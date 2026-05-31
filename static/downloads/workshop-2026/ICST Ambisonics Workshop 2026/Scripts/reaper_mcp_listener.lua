-- reaper_listener.lua — REAPER MCP Listener
-- https://github.com/username/reaper-mcp
--
-- Runs inside REAPER as a deferred script (Actions > Run ReaScript).
-- Polls for command files from the MCP server and executes them via ReaScript API.
-- All mutating commands are wrapped in undo blocks so everything is Ctrl+Z-able.
--
-- IPC directory can be overridden with the REAPER_MCP_IPC_DIR environment variable.
-- Default: ~/.reaper-mcp/ (macOS/Linux) or %USERPROFILE%/.reaper-mcp/ (Windows)

-- ============================================================================
-- Configuration
-- ============================================================================

local function get_ipc_dir()
  local dir = os.getenv("REAPER_MCP_IPC_DIR")
  if dir then
    -- Normalize trailing separator
    if dir:sub(-1) ~= "/" and dir:sub(-1) ~= "\\" then
      dir = dir .. "/"
    end
    return dir
  end
  -- Cross-platform default
  local home = os.getenv("HOME") or os.getenv("USERPROFILE")
  if not home then
    reaper.ShowConsoleMsg("REAPER MCP: ERROR — Cannot determine home directory.\n")
    return nil
  end
  return home .. "/.reaper-mcp/"
end

local IPC_DIR = get_ipc_dir()
if not IPC_DIR then return end

local CMD_FILE = IPC_DIR .. "command.json"
local RSP_FILE = IPC_DIR .. "response.json"
local POLL_INTERVAL = 0.033 -- ~30Hz polling
local MAX_CMD_SIZE = 1024 * 1024 -- 1MB max command size (safety limit)

-- ============================================================================
-- Minimal JSON encoder/decoder
-- REAPER's Lua environment does not include a JSON library.
-- This is a self-contained recursive descent parser and encoder.
-- ============================================================================

local json = {}

function json.decode(str)
  if not str or str == "" then return nil, "empty input" end
  if #str > MAX_CMD_SIZE then return nil, "input exceeds size limit" end

  local pos = 1
  local depth = 0
  local MAX_DEPTH = 20

  local function skip_ws()
    pos = str:find("[^ \t\n\r]", pos) or (#str + 1)
  end

  local function peek() return str:sub(pos, pos) end

  local parse_value -- forward declaration

  local function parse_string()
    pos = pos + 1 -- skip opening quote
    local parts = {}
    while pos <= #str do
      local c = str:sub(pos, pos)
      if c == '"' then
        pos = pos + 1
        return table.concat(parts)
      elseif c == '\\' then
        pos = pos + 1
        local esc = str:sub(pos, pos)
        if esc == '"' then parts[#parts+1] = '"'
        elseif esc == '\\' then parts[#parts+1] = '\\'
        elseif esc == '/' then parts[#parts+1] = '/'
        elseif esc == 'n' then parts[#parts+1] = '\n'
        elseif esc == 'r' then parts[#parts+1] = '\r'
        elseif esc == 't' then parts[#parts+1] = '\t'
        elseif esc == 'b' then parts[#parts+1] = '\b'
        elseif esc == 'f' then parts[#parts+1] = '\f'
        elseif esc == 'u' then
          local hex = str:sub(pos+1, pos+4)
          pos = pos + 4
          local cp = tonumber(hex, 16)
          if cp then parts[#parts+1] = string.char(cp) end
        end
        pos = pos + 1
      else
        parts[#parts+1] = c
        pos = pos + 1
      end
    end
    return table.concat(parts)
  end

  local function parse_number()
    local start = pos
    if str:sub(pos, pos) == '-' then pos = pos + 1 end
    while pos <= #str and str:sub(pos, pos):match("[%d]") do pos = pos + 1 end
    if pos <= #str and str:sub(pos, pos) == '.' then
      pos = pos + 1
      while pos <= #str and str:sub(pos, pos):match("[%d]") do pos = pos + 1 end
    end
    if pos <= #str and str:sub(pos, pos):match("[eE]") then
      pos = pos + 1
      if pos <= #str and str:sub(pos, pos):match("[%+%-]") then pos = pos + 1 end
      while pos <= #str and str:sub(pos, pos):match("[%d]") do pos = pos + 1 end
    end
    return tonumber(str:sub(start, pos - 1))
  end

  local function parse_object()
    depth = depth + 1
    if depth > MAX_DEPTH then return nil end
    pos = pos + 1 -- skip {
    local obj = {}
    skip_ws()
    if peek() == '}' then pos = pos + 1; depth = depth - 1; return obj end
    while true do
      skip_ws()
      if peek() ~= '"' then depth = depth - 1; return obj end
      local key = parse_string()
      skip_ws()
      pos = pos + 1 -- skip :
      skip_ws()
      obj[key] = parse_value()
      skip_ws()
      if peek() == ',' then pos = pos + 1
      elseif peek() == '}' then pos = pos + 1; depth = depth - 1; return obj
      else depth = depth - 1; return obj end
    end
  end

  local function parse_array()
    depth = depth + 1
    if depth > MAX_DEPTH then return nil end
    pos = pos + 1 -- skip [
    local arr = {}
    skip_ws()
    if peek() == ']' then pos = pos + 1; depth = depth - 1; return arr end
    while true do
      skip_ws()
      arr[#arr+1] = parse_value()
      skip_ws()
      if peek() == ',' then pos = pos + 1
      elseif peek() == ']' then pos = pos + 1; depth = depth - 1; return arr
      else depth = depth - 1; return arr end
    end
  end

  parse_value = function()
    skip_ws()
    local c = peek()
    if c == '"' then return parse_string()
    elseif c == '{' then return parse_object()
    elseif c == '[' then return parse_array()
    elseif c == 't' then pos = pos + 4; return true
    elseif c == 'f' then pos = pos + 5; return false
    elseif c == 'n' then pos = pos + 4; return nil
    else return parse_number()
    end
  end

  local result = parse_value()
  return result
end

function json.encode(val)
  if val == nil then return "null" end
  local t = type(val)
  if t == "boolean" then return val and "true" or "false" end
  if t == "number" then
    if val ~= val then return "null" end -- NaN
    if val == math.huge or val == -math.huge then return "null" end
    return string.format("%.14g", val)
  end
  if t == "string" then
    val = val:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\n', '\\n')
             :gsub('\r', '\\r'):gsub('\t', '\\t')
    return '"' .. val .. '"'
  end
  if t == "table" then
    -- Detect array vs object: consecutive integer keys starting at 1
    local is_array = true
    local max_i = 0
    for k, _ in pairs(val) do
      if type(k) ~= "number" or k < 1 or math.floor(k) ~= k then
        is_array = false; break
      end
      if k > max_i then max_i = k end
    end
    if is_array and max_i == #val then
      local parts = {}
      for i = 1, #val do parts[i] = json.encode(val[i]) end
      return "[" .. table.concat(parts, ",") .. "]"
    else
      local parts = {}
      for k, v in pairs(val) do
        parts[#parts+1] = json.encode(tostring(k)) .. ":" .. json.encode(v)
      end
      return "{" .. table.concat(parts, ",") .. "}"
    end
  end
  return "null"
end

-- ============================================================================
-- File I/O helpers
-- ============================================================================

local function read_file(path)
  local f = io.open(path, "r")
  if not f then return nil end
  local content = f:read("*a")
  f:close()
  return content
end

local function write_file(path, content)
  -- Atomic write: write to temp file, then rename.
  -- Prevents the MCP server from reading a partially-written response.
  local tmp = path .. ".tmp"
  local f = io.open(tmp, "w")
  if not f then return false end
  f:write(content)
  f:close()
  os.rename(tmp, path)
  return true
end

local function file_exists(path)
  local f = io.open(path, "r")
  if f then f:close(); return true end
  return false
end

local function delete_file(path)
  os.remove(path)
end

-- ============================================================================
-- Track resolution
-- Case-insensitive, partial match. Exact matches take priority.
-- Returns (track, nil) on success, (nil, error_string) on failure.
-- ============================================================================

local function resolve_track(name)
  if not name or name == "" then return nil, "No track name provided" end
  if name:lower() == "master" then
    return reaper.GetMasterTrack(0), nil
  end
  local name_lower = name:lower()
  local matches = {}
  local num_tracks = reaper.CountTracks(0)

  for i = 0, num_tracks - 1 do
    local track = reaper.GetTrack(0, i)
    local _, track_name = reaper.GetTrackName(track)
    if track_name:lower() == name_lower then
      return track, nil -- exact match, return immediately
    end
    if track_name:lower():find(name_lower, 1, true) then
      matches[#matches+1] = {track = track, name = track_name}
    end
  end

  if #matches == 1 then return matches[1].track, nil end
  if #matches == 0 then
    return nil, "No track found matching '" .. name .. "'"
  end
  local names = {}
  for _, m in ipairs(matches) do names[#names+1] = m.name end
  return nil, "Ambiguous track name '" .. name .. "', matches: " .. table.concat(names, ", ")
end

-- ============================================================================
-- FX resolution
-- Case-insensitive, partial match. Accepts name (string) or index (number).
-- ============================================================================

local function resolve_fx(track, fx_name)
  if type(fx_name) == "number" then
    if fx_name >= 0 and fx_name < reaper.TrackFX_GetCount(track) then
      return fx_name, nil
    end
    return nil, "FX index " .. fx_name .. " out of range"
  end

  local fx_name_lower = fx_name:lower()
  local count = reaper.TrackFX_GetCount(track)
  local matches = {}

  for i = 0, count - 1 do
    local _, name = reaper.TrackFX_GetFXName(track, i)
    if name:lower() == fx_name_lower then return i, nil end
    if name:lower():find(fx_name_lower, 1, true) then
      matches[#matches+1] = {index = i, name = name}
    end
  end

  if #matches == 1 then return matches[1].index, nil end
  if #matches == 0 then return nil, "No FX found matching '" .. fx_name .. "'" end
  local names = {}
  for _, m in ipairs(matches) do names[#names+1] = m.name end
  return nil, "Ambiguous FX name '" .. fx_name .. "', matches: " .. table.concat(names, ", ")
end

-- ============================================================================
-- Unit conversions
-- dB <-> REAPER volume (0-4 scale, 1.0 = 0dB)
-- Pan: user-facing -100..100 <-> REAPER -1..1
-- ============================================================================

local MAX_DB = 12 -- +12dB ceiling — prevents extreme gain that could damage speakers/hearing

local function db_to_vol(db)
  if db <= -150 then return 0 end
  if db > MAX_DB then db = MAX_DB end
  return 10 ^ (db / 20)
end

local function vol_to_db(vol)
  if vol < 0.00001 then return -150 end
  return 20 * math.log(vol, 10)
end

local function pan_to_reaper(pan) return math.max(-1, math.min(1, pan / 100)) end
local function reaper_to_pan(pan) return pan * 100 end

-- ============================================================================
-- Allowed actions (whitelist)
-- Only actions in this set will be executed. Anything else is rejected.
-- ============================================================================

local ALLOWED_ACTIONS = {}

-- ============================================================================
-- Command handlers
-- Each returns (result_table) on success or (nil, error_string) on failure.
-- ============================================================================

local handlers = {}

-- Session state — gives Claude full context about the current project
function handlers.get_session_state(params)
  local state = {}
  state.tempo = reaper.Master_GetTempo()
  local _, ts_num, ts_den = reaper.TimeMap_GetTimeSigAtTime(0, 0)
  state.time_signature = {numerator = ts_num, denominator = ts_den}

  -- Transport
  local play_state = reaper.GetPlayState()
  state.transport = {
    playing = (play_state & 1) ~= 0,
    paused = (play_state & 2) ~= 0,
    recording = (play_state & 4) ~= 0,
    position = reaper.GetPlayPosition(),
    cursor = reaper.GetCursorPosition()
  }

  -- Tracks
  state.tracks = {}
  local num_tracks = reaper.CountTracks(0)
  for i = 0, num_tracks - 1 do
    local track = reaper.GetTrack(0, i)
    local _, name = reaper.GetTrackName(track)
    local vol = reaper.GetMediaTrackInfo_Value(track, "D_VOL")
    local pan = reaper.GetMediaTrackInfo_Value(track, "D_PAN")
    local mute = reaper.GetMediaTrackInfo_Value(track, "B_MUTE")
    local solo = reaper.GetMediaTrackInfo_Value(track, "I_SOLO")
    local armed = reaper.GetMediaTrackInfo_Value(track, "I_RECARM")

    local track_info = {
      index = i,
      name = name,
      volume_db = math.floor(vol_to_db(vol) * 100) / 100,
      pan = math.floor(reaper_to_pan(pan) * 100) / 100,
      muted = mute == 1,
      soloed = solo > 0,
      armed = armed == 1,
      fx = {},
      sends = {},
      items = {}
    }

    -- FX chain (cap params per FX to prevent huge payloads)
    local fx_count = reaper.TrackFX_GetCount(track)
    for j = 0, fx_count - 1 do
      local _, fx_name = reaper.TrackFX_GetFXName(track, j)
      local enabled = reaper.TrackFX_GetEnabled(track, j)
      local fx_info = {index = j, name = fx_name, enabled = enabled, params = {}}
      local param_count = reaper.TrackFX_GetNumParams(track, j)
      for p = 0, math.min(param_count - 1, 49) do
        local _, pname = reaper.TrackFX_GetParamName(track, j, p)
        local val = reaper.TrackFX_GetParam(track, j, p)
        local _, minval, maxval = reaper.TrackFX_GetParam(track, j, p)
        fx_info.params[#fx_info.params+1] = {
          index = p, name = pname, value = val, min = minval, max = maxval
        }
      end
      track_info.fx[#track_info.fx+1] = fx_info
    end

    -- Sends
    local send_count = reaper.GetTrackNumSends(track, 0)
    for j = 0, send_count - 1 do
      local dest = reaper.GetTrackSendInfo_Value(track, 0, j, "P_DESTTRACK")
      local _, dest_name = reaper.GetTrackName(dest)
      local send_vol = reaper.GetTrackSendInfo_Value(track, 0, j, "D_VOL")
      track_info.sends[#track_info.sends+1] = {
        index = j,
        dest_track = dest_name,
        volume_db = math.floor(vol_to_db(send_vol) * 100) / 100
      }
    end

    -- Items
    local item_count = reaper.CountTrackMediaItems(track)
    for j = 0, item_count - 1 do
      local item = reaper.GetTrackMediaItem(track, j)
      local item_pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
      local item_len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
      local item_name = ""
      local take = reaper.GetActiveTake(item)
      if take then
        _, item_name = reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", "", false)
      end
      track_info.items[#track_info.items+1] = {
        index = j, position = item_pos, length = item_len, name = item_name
      }
    end

    state.tracks[#state.tracks+1] = track_info
  end

  -- Markers and regions
  state.markers = {}
  state.regions = {}
  local _, num_markers, num_regions = reaper.CountProjectMarkers(0)
  local total = num_markers + num_regions
  for i = 0, total - 1 do
    local _, is_region, pos, rgnend, name, idx = reaper.EnumProjectMarkers(i)
    if is_region then
      state.regions[#state.regions+1] = {index = idx, start = pos, finish = rgnend, name = name}
    else
      state.markers[#state.markers+1] = {index = idx, position = pos, name = name}
    end
  end

  return state
end

-- Transport
function handlers.play() reaper.Main_OnCommand(1007, 0); return {status = "playing"} end
function handlers.stop() reaper.Main_OnCommand(1016, 0); return {status = "stopped"} end
function handlers.pause() reaper.Main_OnCommand(1008, 0); return {status = "paused"} end
function handlers.record() reaper.Main_OnCommand(1013, 0); return {status = "recording"} end

function handlers.set_tempo(params)
  local bpm = tonumber(params.bpm)
  if not bpm or bpm < 1 or bpm > 960 then return nil, "BPM must be between 1 and 960" end
  reaper.SetCurrentBPM(0, bpm, true)
  return {tempo = bpm}
end

function handlers.get_transport_state()
  local play_state = reaper.GetPlayState()
  return {
    playing = (play_state & 1) ~= 0,
    paused = (play_state & 2) ~= 0,
    recording = (play_state & 4) ~= 0,
    position = reaper.GetPlayPosition(),
    cursor = reaper.GetCursorPosition(),
    tempo = reaper.Master_GetTempo()
  }
end

-- Tracks
function handlers.create_track(params)
  local name = params.name or "New Track"
  local idx = params.index or reaper.CountTracks(0)
  reaper.InsertTrackAtIndex(idx, true)
  local track = reaper.GetTrack(0, idx)
  reaper.GetSetMediaTrackInfo_String(track, "P_NAME", name, true)
  return {name = name, index = idx}
end

function handlers.delete_track(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  reaper.DeleteTrack(track)
  return {deleted = params.track}
end

function handlers.rename_track(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  if not params.new_name or params.new_name == "" then return nil, "New name cannot be empty" end
  reaper.GetSetMediaTrackInfo_String(track, "P_NAME", params.new_name, true)
  return {old_name = params.track, new_name = params.new_name}
end

function handlers.set_track_volume(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local db = tonumber(params.db)
  if not db then return nil, "Invalid dB value" end
  reaper.SetMediaTrackInfo_Value(track, "D_VOL", db_to_vol(db))
  return {track = params.track, volume_db = db}
end

function handlers.set_track_pan(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local pan = tonumber(params.pan)
  if not pan then return nil, "Invalid pan value" end
  reaper.SetMediaTrackInfo_Value(track, "D_PAN", pan_to_reaper(pan))
  return {track = params.track, pan = pan}
end

function handlers.mute_track(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  reaper.SetMediaTrackInfo_Value(track, "B_MUTE", 1)
  return {track = params.track, muted = true}
end

function handlers.unmute_track(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  reaper.SetMediaTrackInfo_Value(track, "B_MUTE", 0)
  return {track = params.track, muted = false}
end

function handlers.solo_track(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  reaper.SetMediaTrackInfo_Value(track, "I_SOLO", 1)
  return {track = params.track, soloed = true}
end

function handlers.unsolo_track(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  reaper.SetMediaTrackInfo_Value(track, "I_SOLO", 0)
  return {track = params.track, soloed = false}
end

function handlers.arm_track(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  reaper.SetMediaTrackInfo_Value(track, "I_RECARM", 1)
  return {track = params.track, armed = true}
end

function handlers.unarm_track(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  reaper.SetMediaTrackInfo_Value(track, "I_RECARM", 0)
  return {track = params.track, armed = false}
end

-- FX / Plugins
function handlers.list_installed_fx(params)
  local filter = params.filter and params.filter:lower() or nil
  local category = params.category and params.category:lower() or nil
  local results = {}
  local idx = 0
  while true do
    local ok, name = reaper.EnumInstalledFX(idx)
    if not ok then break end
    local include = true
    if filter and not name:lower():find(filter, 1, true) then
      include = false
    end
    if category then
      local name_lower = name:lower()
      if category == "eq" then
        include = include and (name_lower:find("eq") or name_lower:find("equaliz"))
      elseif category == "compressor" then
        include = include and (name_lower:find("comp") or name_lower:find("compress"))
      elseif category == "reverb" then
        include = include and (name_lower:find("reverb") or name_lower:find("verb") or name_lower:find("room") or name_lower:find("hall"))
      elseif category == "delay" then
        include = include and (name_lower:find("delay") or name_lower:find("echo"))
      elseif category == "distortion" then
        include = include and (name_lower:find("dist") or name_lower:find("satur") or name_lower:find("overdrive") or name_lower:find("drive"))
      elseif category == "limiter" then
        include = include and (name_lower:find("limit"))
      elseif category == "gate" then
        include = include and (name_lower:find("gate") or name_lower:find("expander"))
      elseif category == "chorus" then
        include = include and (name_lower:find("chorus") or name_lower:find("flang") or name_lower:find("phas"))
      end
    end
    if include then
      results[#results+1] = name
    end
    idx = idx + 1
    if #results >= 200 then break end -- cap results
  end
  return {plugins = results, count = #results, total_scanned = idx}
end

function handlers.add_fx(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local plugin = params.plugin_name
  if not plugin or plugin == "" then return nil, "No plugin name provided" end
  local idx = reaper.TrackFX_AddByName(track, plugin, false, -1)
  if idx == -1 then return nil, "Plugin '" .. plugin .. "' not found" end
  return {track = params.track, plugin = plugin, fx_index = idx}
end

function handlers.remove_fx(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local fx_idx, fx_err = resolve_fx(track, params.fx)
  if not fx_idx then return nil, fx_err end
  reaper.TrackFX_Delete(track, fx_idx)
  return {track = params.track, removed = params.fx}
end

function handlers.get_fx_params(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local fx_idx, fx_err = resolve_fx(track, params.fx)
  if not fx_idx then return nil, fx_err end

  local _, fx_name = reaper.TrackFX_GetFXName(track, fx_idx)
  local result = {track = params.track, fx = fx_name, params = {}}
  local count = reaper.TrackFX_GetNumParams(track, fx_idx)
  for p = 0, count - 1 do
    local _, pname = reaper.TrackFX_GetParamName(track, fx_idx, p)
    local val = reaper.TrackFX_GetParam(track, fx_idx, p)
    local _, minval, maxval = reaper.TrackFX_GetParam(track, fx_idx, p)
    result.params[#result.params+1] = {
      index = p, name = pname, value = val, min = minval, max = maxval
    }
  end
  return result
end

function handlers.set_fx_param(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local fx_idx, fx_err = resolve_fx(track, params.fx)
  if not fx_idx then return nil, fx_err end
  if not params.param or params.param == "" then return nil, "No parameter name provided" end
  if not params.value then return nil, "No value provided" end

  -- Find param by name (case-insensitive, partial match)
  local param_name_lower = params.param:lower()
  local count = reaper.TrackFX_GetNumParams(track, fx_idx)
  local match_idx = nil
  local matches = {}
  for p = 0, count - 1 do
    local _, pname = reaper.TrackFX_GetParamName(track, fx_idx, p)
    if pname:lower() == param_name_lower then
      match_idx = p; break
    end
    if pname:lower():find(param_name_lower, 1, true) then
      matches[#matches+1] = {index = p, name = pname}
    end
  end
  if not match_idx then
    if #matches == 1 then
      match_idx = matches[1].index
    elseif #matches == 0 then
      return nil, "No parameter matching '" .. params.param .. "'"
    else
      local names = {}
      for _, m in ipairs(matches) do names[#names+1] = m.name end
      return nil, "Ambiguous param '" .. params.param .. "', matches: " .. table.concat(names, ", ")
    end
  end

  -- Clamp value to the plugin's declared min/max range
  local val = params.value
  local _, minval, maxval = reaper.TrackFX_GetParam(track, fx_idx, match_idx)
  if minval and maxval and maxval > minval then
    val = math.max(minval, math.min(maxval, val))
  end
  reaper.TrackFX_SetParam(track, fx_idx, match_idx, val)
  return {track = params.track, fx = params.fx, param = params.param, value = val}
end

function handlers.bypass_fx(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local fx_idx, fx_err = resolve_fx(track, params.fx)
  if not fx_idx then return nil, fx_err end
  reaper.TrackFX_SetEnabled(track, fx_idx, false)
  return {track = params.track, fx = params.fx, bypassed = true}
end

function handlers.enable_fx(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local fx_idx, fx_err = resolve_fx(track, params.fx)
  if not fx_idx then return nil, fx_err end
  reaper.TrackFX_SetEnabled(track, fx_idx, true)
  return {track = params.track, fx = params.fx, enabled = true}
end

function handlers.apply_fx_chain(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  if not params.fx_chain or #params.fx_chain == 0 then
    return nil, "No fx_chain provided"
  end

  local results = {}
  local warnings = {}

  for i, fx_entry in ipairs(params.fx_chain) do
    local plugin = fx_entry.plugin
    if not plugin or plugin == "" then
      warnings[#warnings+1] = "Entry " .. i .. ": no plugin name, skipped"
    else
      local fx_idx = reaper.TrackFX_AddByName(track, plugin, false, -1)
      if fx_idx == -1 then
        warnings[#warnings+1] = "Plugin '" .. plugin .. "' not found, skipped"
      else
        local _, fx_name = reaper.TrackFX_GetFXName(track, fx_idx)
        local param_results = {}

        if fx_entry.params then
          local count = reaper.TrackFX_GetNumParams(track, fx_idx)
          for param_name, param_value in pairs(fx_entry.params) do
            -- Fuzzy-match parameter name (same logic as set_fx_param)
            local param_name_lower = tostring(param_name):lower()
            local match_idx = nil
            local matches = {}
            for p = 0, count - 1 do
              local _, pname = reaper.TrackFX_GetParamName(track, fx_idx, p)
              if pname:lower() == param_name_lower then
                match_idx = p; break
              end
              if pname:lower():find(param_name_lower, 1, true) then
                matches[#matches+1] = {index = p, name = pname}
              end
            end
            if not match_idx then
              if #matches == 1 then
                match_idx = matches[1].index
              elseif #matches == 0 then
                warnings[#warnings+1] = plugin .. ": no param matching '" .. param_name .. "'"
              else
                local names = {}
                for _, m in ipairs(matches) do names[#names+1] = m.name end
                warnings[#warnings+1] = plugin .. ": ambiguous param '" .. param_name .. "', matches: " .. table.concat(names, ", ")
              end
            end

            if match_idx then
              local val = tonumber(param_value)
              if val then
                local _, minval, maxval = reaper.TrackFX_GetParam(track, fx_idx, match_idx)
                if minval and maxval and maxval > minval then
                  val = math.max(minval, math.min(maxval, val))
                end
                reaper.TrackFX_SetParam(track, fx_idx, match_idx, val)
                local _, matched_name = reaper.TrackFX_GetParamName(track, fx_idx, match_idx)
                param_results[#param_results+1] = {param = matched_name, value = val}
              else
                warnings[#warnings+1] = plugin .. ": invalid value for '" .. param_name .. "'"
              end
            end
          end
        end

        results[#results+1] = {plugin = fx_name, fx_index = fx_idx, params_set = param_results}
      end
    end
  end

  return {track = params.track, applied = results, warnings = warnings}
end

-- Routing
function handlers.create_send(params)
  local src, err = resolve_track(params.source)
  if not src then return nil, "Source: " .. err end
  local dest, derr = resolve_track(params.dest)
  if not dest then return nil, "Dest: " .. derr end
  if src == dest then return nil, "Cannot create a send from a track to itself" end
  local send_idx = reaper.CreateTrackSend(src, dest)
  if params.volume_db then
    local db = tonumber(params.volume_db)
    if db then
      reaper.SetTrackSendInfo_Value(src, 0, send_idx, "D_VOL", db_to_vol(db))
    end
  end
  return {source = params.source, dest = params.dest, send_index = send_idx}
end

function handlers.remove_send(params)
  local src, err = resolve_track(params.source)
  if not src then return nil, "Source: " .. err end
  local dest, derr = resolve_track(params.dest)
  if not dest then return nil, "Dest: " .. derr end
  local send_count = reaper.GetTrackNumSends(src, 0)
  for i = 0, send_count - 1 do
    local d = reaper.GetTrackSendInfo_Value(src, 0, i, "P_DESTTRACK")
    if d == dest then
      reaper.RemoveTrackSend(src, 0, i)
      return {source = params.source, dest = params.dest, removed = true}
    end
  end
  return nil, "No send found from '" .. params.source .. "' to '" .. params.dest .. "'"
end

function handlers.set_send_volume(params)
  local src, err = resolve_track(params.source)
  if not src then return nil, "Source: " .. err end
  local dest, derr = resolve_track(params.dest)
  if not dest then return nil, "Dest: " .. derr end
  local db = tonumber(params.db)
  if not db then return nil, "Invalid dB value" end
  local send_count = reaper.GetTrackNumSends(src, 0)
  for i = 0, send_count - 1 do
    local d = reaper.GetTrackSendInfo_Value(src, 0, i, "P_DESTTRACK")
    if d == dest then
      reaper.SetTrackSendInfo_Value(src, 0, i, "D_VOL", db_to_vol(db))
      return {source = params.source, dest = params.dest, volume_db = db}
    end
  end
  return nil, "No send found from '" .. params.source .. "' to '" .. params.dest .. "'"
end

-- Items & MIDI
function handlers.create_midi_item(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local start_beat = tonumber(params.start_beat)
  local length_beats = tonumber(params.length_beats)
  if not start_beat or not length_beats then return nil, "Invalid beat values" end
  local start_time = reaper.TimeMap2_beatsToTime(0, start_beat)
  local end_time = reaper.TimeMap2_beatsToTime(0, start_beat + length_beats)
  reaper.CreateNewMIDIItemInProj(track, start_time, end_time)
  return {track = params.track, start_beat = start_beat, length_beats = length_beats}
end

function handlers.insert_midi_notes(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local item_idx = params.item_index or 0
  local item = reaper.GetTrackMediaItem(track, item_idx)
  if not item then return nil, "Item index " .. item_idx .. " not found" end
  local take = reaper.GetActiveTake(item)
  if not take then return nil, "No active take on item" end
  if not reaper.TakeIsMIDI(take) then return nil, "Item is not a MIDI item" end

  local notes = params.notes or {}
  if #notes > 10000 then return nil, "Too many notes (max 10000 per call)" end
  local count = 0
  for _, note in ipairs(notes) do
    local pitch = tonumber(note.pitch)
    local vel = tonumber(note.velocity) or 100
    local sb = tonumber(note.start_beat)
    local lb = tonumber(note.length_beats)
    if not pitch or not sb or not lb then goto continue end
    if lb <= 0 then goto continue end -- skip zero/negative length notes
    pitch = math.max(0, math.min(127, math.floor(pitch)))
    vel = math.max(1, math.min(127, math.floor(vel)))
    local start_ppq = reaper.MIDI_GetPPQPosFromProjQN(take, sb)
    local end_ppq = reaper.MIDI_GetPPQPosFromProjQN(take, sb + lb)
    local chan = math.max(0, math.min(15, (tonumber(note.channel) or 1) - 1))
    reaper.MIDI_InsertNote(take, false, false, start_ppq, end_ppq, chan, pitch, vel, true)
    count = count + 1
    ::continue::
  end
  reaper.MIDI_Sort(take)
  return {track = params.track, notes_inserted = count}
end

function handlers.delete_item(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local item = reaper.GetTrackMediaItem(track, params.item_index or 0)
  if not item then return nil, "Item not found" end
  reaper.DeleteTrackMediaItem(track, item)
  return {track = params.track, deleted_index = params.item_index}
end

function handlers.move_item(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local item = reaper.GetTrackMediaItem(track, params.item_index or 0)
  if not item then return nil, "Item not found" end
  local pos = tonumber(params.position)
  if not pos then return nil, "Invalid position" end
  if pos < 0 then return nil, "Position cannot be negative" end
  reaper.SetMediaItemInfo_Value(item, "D_POSITION", pos)
  reaper.UpdateArrange()
  return {track = params.track, item_index = params.item_index, new_position = pos}
end

function handlers.split_item_at(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local item = reaper.GetTrackMediaItem(track, params.item_index or 0)
  if not item then return nil, "Item not found" end
  local pos = tonumber(params.position)
  if not pos then return nil, "Invalid position" end
  local new_item = reaper.SplitMediaItem(item, pos)
  if not new_item then return nil, "Split failed at position " .. pos end
  return {track = params.track, split_position = pos}
end

-- Markers & Regions
function handlers.add_marker(params)
  local pos = tonumber(params.position) or reaper.GetCursorPosition()
  local idx = reaper.AddProjectMarker(0, false, pos, 0, params.name or "", -1)
  return {index = idx, position = pos, name = params.name}
end

function handlers.add_region(params)
  local s = tonumber(params.start)
  local e = tonumber(params.finish)
  if not s or not e then return nil, "Invalid start/finish values" end
  if s >= e then return nil, "Region start must be before end" end
  local idx = reaper.AddProjectMarker(0, true, s, e, params.name or "", -1)
  return {index = idx, start = s, finish = e, name = params.name}
end

-- Health check
function handlers.ping()
  return {
    status = "ok",
    reaper_version = reaper.GetAppVersion(),
    project = reaper.GetProjectName(0),
    track_count = reaper.CountTracks(0),
  }
end

-- Undo/Redo
function handlers.undo()
  reaper.Main_OnCommand(40029, 0)
  return {action = "undo"}
end

function handlers.redo()
  reaper.Main_OnCommand(40030, 0)
  return {action = "redo"}
end

-- ============================================================================
-- Metering / Analysis
-- ============================================================================

function handlers.get_track_meter(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  -- Peak values per channel (0-indexed)
  local peak_l = reaper.Track_GetPeakInfo(track, 0)
  local peak_r = reaper.Track_GetPeakInfo(track, 1)
  local function to_db(v) if v < 0.00001 then return -150 end; return 20 * math.log(v, 10) end
  return {
    track = params.track,
    peak_l_db = math.floor(to_db(peak_l) * 10) / 10,
    peak_r_db = math.floor(to_db(peak_r) * 10) / 10,
    peak_l_raw = peak_l,
    peak_r_raw = peak_r,
    clipping = peak_l >= 1.0 or peak_r >= 1.0,
  }
end

function handlers.get_master_meter(params)
  local master = reaper.GetMasterTrack(0)
  local peak_l = reaper.Track_GetPeakInfo(master, 0)
  local peak_r = reaper.Track_GetPeakInfo(master, 1)
  local function to_db(v) if v < 0.00001 then return -150 end; return 20 * math.log(v, 10) end
  return {
    peak_l_db = math.floor(to_db(peak_l) * 10) / 10,
    peak_r_db = math.floor(to_db(peak_r) * 10) / 10,
    clipping = peak_l >= 1.0 or peak_r >= 1.0,
  }
end

-- ============================================================================
-- Render / Bounce
-- ============================================================================

function handlers.render_project(params)
  -- Set output directory if provided
  if params.directory then
    reaper.GetSetProjectInfo_String(0, "RENDER_FILE", params.directory, true)
  end
  -- Set filename pattern if provided
  if params.filename then
    reaper.GetSetProjectInfo_String(0, "RENDER_PATTERN", params.filename, true)
  end
  -- Set bounds: 0=entire project, 1=time selection, 2=entire+markers
  if params.bounds then
    local bounds_map = {project = 0, time_selection = 1, custom = 2}
    local b = bounds_map[params.bounds] or 0
    reaper.GetSetProjectInfo(0, "RENDER_BOUNDSFLAG", b, true)
    if params.bounds == "custom" and params.start_time and params.end_time then
      reaper.GetSetProjectInfo(0, "RENDER_STARTPOS", params.start_time, true)
      reaper.GetSetProjectInfo(0, "RENDER_ENDPOS", params.end_time, true)
    end
  end
  -- Set sample rate if provided (validate common rates)
  if params.sample_rate then
    local sr = tonumber(params.sample_rate)
    local valid_rates = {8000,11025,16000,22050,32000,44100,48000,88200,96000,176400,192000}
    local is_valid = false
    for _, r in ipairs(valid_rates) do if sr == r then is_valid = true; break end end
    if not is_valid then return nil, "Invalid sample rate. Use: 44100, 48000, 88200, 96000, or 192000" end
    reaper.GetSetProjectInfo(0, "RENDER_SRATE", sr, true)
  end
  -- Set channels if provided (1=mono, 2=stereo)
  if params.channels then
    reaper.GetSetProjectInfo(0, "RENDER_CHANNELS", params.channels, true)
  end
  -- Trigger render with most recent format settings, auto-close dialog
  reaper.Main_OnCommand(41824, 0)
  -- Read back what was rendered
  local _, render_file = reaper.GetSetProjectInfo_String(0, "RENDER_FILE", "", false)
  local _, render_pattern = reaper.GetSetProjectInfo_String(0, "RENDER_PATTERN", "", false)
  return {
    rendered = true,
    directory = render_file,
    filename_pattern = render_pattern,
  }
end

-- ============================================================================
-- Automation / Envelopes
-- ============================================================================

-- Helper: resolve an envelope on a track by name
-- create: if true, create FX parameter envelopes that don't exist yet
local function resolve_envelope(track, env_name, create)
  if not env_name or env_name == "" then return nil, "No envelope name provided" end
  local env_lower = env_name:lower()

  -- Built-in envelopes
  local builtin = {volume = "Volume", pan = "Pan", mute = "Mute", width = "Width"}
  if builtin[env_lower] then
    local env = reaper.GetTrackEnvelopeByName(track, builtin[env_lower])
    if env then return env, nil, builtin[env_lower] end
    return nil, "Envelope '" .. builtin[env_lower] .. "' not found (may need to show it first)"
  end

  -- FX parameter envelope: "FXName:ParamName"
  local fx_part, param_part = env_name:match("^(.+):(.+)$")
  if fx_part and param_part then
    local fx_idx, fx_err = resolve_fx(track, fx_part)
    if not fx_idx then return nil, fx_err end
    -- Find param
    local param_lower = param_part:lower()
    local count = reaper.TrackFX_GetNumParams(track, fx_idx)
    for p = 0, count - 1 do
      local _, pname = reaper.TrackFX_GetParamName(track, fx_idx, p)
      if pname:lower() == param_lower or pname:lower():find(param_lower, 1, true) then
        local env = reaper.GetFXEnvelope(track, fx_idx, p, create or false)
        if env then return env, nil, fx_part .. ":" .. pname end
        return nil, "Could not create envelope for " .. pname
      end
    end
    return nil, "No parameter matching '" .. param_part .. "' on FX '" .. fx_part .. "'"
  end

  -- Try as-is
  local env = reaper.GetTrackEnvelopeByName(track, env_name)
  if env then return env, nil, env_name end
  return nil, "Envelope '" .. env_name .. "' not found"
end

function handlers.add_envelope_points(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local env, env_err, env_label = resolve_envelope(track, params.envelope, true)
  if not env then return nil, env_err end

  local points = params.points or {}
  if #points > 10000 then return nil, "Too many points (max 10000)" end
  local count = 0
  for _, pt in ipairs(points) do
    local t = tonumber(pt.time)
    local v = tonumber(pt.value)
    if not t or not v then goto continue end
    -- Convert dB to volume scale for volume envelope
    if env_label == "Volume" then
      v = db_to_vol(v)
    elseif env_label == "Pan" then
      v = pan_to_reaper(v)
    end
    local shape = tonumber(pt.shape) or 0 -- 0=linear
    reaper.InsertEnvelopePoint(env, t, v, shape, 0, false, true)
    count = count + 1
    ::continue::
  end
  reaper.Envelope_SortPoints(env)
  return {track = params.track, envelope = env_label, points_added = count}
end

function handlers.get_envelope_points(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local env, env_err, env_label = resolve_envelope(track, params.envelope)
  if not env then return nil, env_err end

  local start_time = tonumber(params.start_time) or 0
  local end_time = tonumber(params.end_time) or math.huge

  local point_count = reaper.CountEnvelopePoints(env)
  local points = {}
  for i = 0, point_count - 1 do
    local _, time, value, shape, tension, selected = reaper.GetEnvelopePoint(env, i)
    if time >= start_time and time <= end_time then
      local display_value = value
      if env_label == "Volume" then display_value = vol_to_db(value) end
      if env_label == "Pan" then display_value = reaper_to_pan(value) end
      points[#points+1] = {
        index = i, time = time, value = display_value,
        raw_value = value, shape = shape
      }
    end
    if #points >= 500 then break end -- cap output
  end
  return {track = params.track, envelope = env_label, points = points, total = point_count}
end

function handlers.clear_envelope(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local env, env_err, env_label = resolve_envelope(track, params.envelope)
  if not env then return nil, env_err end

  local start_time = tonumber(params.start_time)
  local end_time = tonumber(params.end_time)

  if start_time and end_time then
    reaper.DeleteEnvelopePointRange(env, start_time, end_time)
  else
    -- Clear all points
    local count = reaper.CountEnvelopePoints(env)
    for i = count - 1, 0, -1 do
      reaper.DeleteEnvelopePoint(env, i)
    end
  end
  return {track = params.track, envelope = env_label, cleared = true}
end

-- ============================================================================
-- Track Folders / Grouping
-- ============================================================================

function handlers.create_folder(params)
  local name = params.name or "Folder"
  local children = params.children or {}
  if #children == 0 then return nil, "No child tracks specified" end

  -- Resolve all child tracks first, collect their indices
  local child_entries = {}
  for _, child_name in ipairs(children) do
    local ct, cerr = resolve_track(child_name)
    if not ct then return nil, "Child track: " .. cerr end
    local idx = math.floor(reaper.GetMediaTrackInfo_Value(ct, "IP_TRACKNUMBER") - 1)
    child_entries[#child_entries+1] = {track = ct, name = child_name, idx = idx}
  end

  -- Sort children by current index so we can check contiguity
  table.sort(child_entries, function(a, b) return a.idx < b.idx end)

  -- Check that children are contiguous (required for safe folder creation)
  for i = 2, #child_entries do
    if child_entries[i].idx ~= child_entries[i-1].idx + 1 then
      return nil, "Child tracks must be adjacent in the track list for safe folder creation. "
        .. "'" .. child_entries[i-1].name .. "' (index " .. child_entries[i-1].idx .. ") and '"
        .. child_entries[i].name .. "' (index " .. child_entries[i].idx .. ") are not adjacent. "
        .. "Reorder them in REAPER first, or move them next to each other."
    end
  end

  -- Check that none of the children are already folder parents (would corrupt hierarchy)
  for _, c in ipairs(child_entries) do
    local depth = reaper.GetMediaTrackInfo_Value(c.track, "I_FOLDERDEPTH")
    if depth == 1 then
      return nil, "Track '" .. c.name .. "' is already a folder parent. "
        .. "Cannot nest it inside another folder this way — restructure manually in REAPER."
    end
  end

  -- Insert the folder track right before the first child
  local insert_idx = child_entries[1].idx
  reaper.InsertTrackAtIndex(insert_idx, true)
  local folder_track = reaper.GetTrack(0, insert_idx)
  reaper.GetSetMediaTrackInfo_String(folder_track, "P_NAME", name, true)
  reaper.SetMediaTrackInfo_Value(folder_track, "I_FOLDERDEPTH", 1)

  -- Children shifted by 1 due to the insert. Set their depths.
  -- All children are now at indices (insert_idx+1) through (insert_idx+#children).
  for i = 1, #child_entries do
    local ct = reaper.GetTrack(0, insert_idx + i)
    if i < #child_entries then
      reaper.SetMediaTrackInfo_Value(ct, "I_FOLDERDEPTH", 0)
    else
      -- Last child closes the folder
      reaper.SetMediaTrackInfo_Value(ct, "I_FOLDERDEPTH", -1)
    end
  end

  reaper.TrackList_AdjustWindows(false)
  return {folder = name, children_count = #children, index = insert_idx}
end

-- ============================================================================
-- Item Gain & Fades
-- ============================================================================

function handlers.set_item_gain(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local item = reaper.GetTrackMediaItem(track, params.item_index or 0)
  if not item then return nil, "Item not found" end
  local db = tonumber(params.gain_db)
  if not db then return nil, "Invalid gain_db value" end
  reaper.SetMediaItemInfo_Value(item, "D_VOL", db_to_vol(db))
  return {track = params.track, item_index = params.item_index, gain_db = db}
end

function handlers.set_item_fade_in(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local item = reaper.GetTrackMediaItem(track, params.item_index or 0)
  if not item then return nil, "Item not found" end
  local length = tonumber(params.length)
  if not length or length < 0 then return nil, "Invalid fade length" end
  reaper.SetMediaItemInfo_Value(item, "D_FADEINLEN", length)
  if params.shape then
    local shape = math.max(0, math.min(6, math.floor(tonumber(params.shape) or 0)))
    reaper.SetMediaItemInfo_Value(item, "C_FADEINSHAPE", shape)
  end
  reaper.UpdateArrange()
  return {track = params.track, item_index = params.item_index, fade_in = length}
end

function handlers.set_item_fade_out(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local item = reaper.GetTrackMediaItem(track, params.item_index or 0)
  if not item then return nil, "Item not found" end
  local length = tonumber(params.length)
  if not length or length < 0 then return nil, "Invalid fade length" end
  reaper.SetMediaItemInfo_Value(item, "D_FADEOUTLEN", length)
  if params.shape then
    local shape = math.max(0, math.min(6, math.floor(tonumber(params.shape) or 0)))
    reaper.SetMediaItemInfo_Value(item, "C_FADEOUTSHAPE", shape)
  end
  reaper.UpdateArrange()
  return {track = params.track, item_index = params.item_index, fade_out = length}
end

-- ============================================================================
-- Cursor & Time Selection
-- ============================================================================

function handlers.set_cursor_position(params)
  local time = tonumber(params.time)
  if not time then return nil, "Invalid time value" end
  if time < 0 then time = 0 end
  reaper.SetEditCurPos(time, true, false)
  return {cursor_position = time}
end

function handlers.set_time_selection(params)
  local s = tonumber(params.start_time)
  local e = tonumber(params.end_time)
  if not s or not e then return nil, "Invalid start/end time" end
  if s < 0 then s = 0 end
  if e <= s then return nil, "End time must be after start time" end
  reaper.GetSet_LoopTimeRange(true, false, s, e, false)
  return {start_time = s, end_time = e}
end

function handlers.set_loop_points(params)
  local s = tonumber(params.start_time)
  local e = tonumber(params.end_time)
  if not s or not e then return nil, "Invalid start/end time" end
  reaper.GetSet_LoopTimeRange(true, true, s, e, false)
  -- Enable/disable repeat
  if params.enable ~= nil then
    local repeat_state = reaper.GetSetRepeat(-1)
    if params.enable and repeat_state == 0 then
      reaper.GetSetRepeat(1)
    elseif not params.enable and repeat_state == 1 then
      reaper.GetSetRepeat(0)
    end
  end
  return {start_time = s, end_time = e, loop_enabled = reaper.GetSetRepeat(-1) == 1}
end

function handlers.go_to_marker(params)
  -- Accept name (string) or index (number)
  local target = params.marker
  if not target then return nil, "No marker specified" end

  local _, num_markers, num_regions = reaper.CountProjectMarkers(0)
  local total = num_markers + num_regions

  -- Try as number first
  local target_num = tonumber(target)
  if target_num then
    reaper.GoToMarker(0, math.floor(target_num), false)
    return {marker = target_num}
  end

  -- Search by name
  local target_lower = target:lower()
  for i = 0, total - 1 do
    local _, is_region, pos, _, name, idx = reaper.EnumProjectMarkers(i)
    if not is_region and name:lower():find(target_lower, 1, true) then
      reaper.SetEditCurPos(pos, true, false)
      return {marker = name, position = pos}
    end
  end
  -- Also check regions
  for i = 0, total - 1 do
    local _, is_region, pos, _, name, idx = reaper.EnumProjectMarkers(i)
    if is_region and name:lower():find(target_lower, 1, true) then
      reaper.SetEditCurPos(pos, true, false)
      return {region = name, position = pos}
    end
  end
  return nil, "No marker or region matching '" .. target .. "'"
end

-- ============================================================================
-- Phase
-- ============================================================================

function handlers.toggle_phase(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end
  local current = reaper.GetMediaTrackInfo_Value(track, "B_PHASE")
  local new_phase = current == 0 and 1 or 0
  reaper.SetMediaTrackInfo_Value(track, "B_PHASE", new_phase)
  return {track = params.track, phase_inverted = new_phase == 1}
end

-- ============================================================================
-- Spectral Analysis (requires MCP Analyzer JSFX)
-- ============================================================================

local ANALYZER_FX_NAME = "mcp_analyzer"

local function find_or_add_analyzer(track)
  local count = reaper.TrackFX_GetCount(track)
  for i = 0, count - 1 do
    local _, name = reaper.TrackFX_GetFXName(track, i)
    if name:lower():find("mcp analyzer") or name:lower():find("mcp_analyzer") then
      return i, nil
    end
  end
  -- Try to add it
  local idx = reaper.TrackFX_AddByName(track, ANALYZER_FX_NAME, false, -1)
  if idx < 0 then
    return nil, "MCP Analyzer JSFX not installed. Run 'python mcp_server.py install' to set it up."
  end
  return idx, nil
end

function handlers.analyze_track(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end

  local fx_idx, fx_err = find_or_add_analyzer(track)
  if not fx_idx then return nil, fx_err end

  -- Check playback state
  local play_state = reaper.GetPlayState()
  local warning = nil
  if play_state == 0 then
    warning = "Playback is stopped — analysis values may be stale. Start playback for live readings."
  end

  -- Read spectral params (sliders 0-4, but JSFX params are 0-indexed matching slider-1)
  local sub_db    = reaper.TrackFX_GetParam(track, fx_idx, 0)
  local low_db    = reaper.TrackFX_GetParam(track, fx_idx, 1)
  local mid_db    = reaper.TrackFX_GetParam(track, fx_idx, 2)
  local hmid_db   = reaper.TrackFX_GetParam(track, fx_idx, 3)
  local high_db   = reaper.TrackFX_GetParam(track, fx_idx, 4)

  -- Read peak/RMS params (sliders 5-9)
  local peak_l    = reaper.TrackFX_GetParam(track, fx_idx, 5)
  local peak_r    = reaper.TrackFX_GetParam(track, fx_idx, 6)
  local rms_l     = reaper.TrackFX_GetParam(track, fx_idx, 7)
  local rms_r     = reaper.TrackFX_GetParam(track, fx_idx, 8)
  local crest     = reaper.TrackFX_GetParam(track, fx_idx, 9)

  local result = {
    track = params.track,
    spectral = {
      sub_db = math.floor(sub_db * 10 + 0.5) / 10,
      low_db = math.floor(low_db * 10 + 0.5) / 10,
      mid_db = math.floor(mid_db * 10 + 0.5) / 10,
      high_mid_db = math.floor(hmid_db * 10 + 0.5) / 10,
      high_db = math.floor(high_db * 10 + 0.5) / 10,
    },
    peak = {
      left_db = math.floor(peak_l * 10 + 0.5) / 10,
      right_db = math.floor(peak_r * 10 + 0.5) / 10,
    },
    rms = {
      left_db = math.floor(rms_l * 10 + 0.5) / 10,
      right_db = math.floor(rms_r * 10 + 0.5) / 10,
    },
    crest_factor_db = math.floor(crest * 10 + 0.5) / 10,
  }
  if warning then result.warning = warning end
  return result
end

function handlers.get_loudness(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end

  local fx_idx, fx_err = find_or_add_analyzer(track)
  if not fx_idx then return nil, fx_err end

  -- Optional reset
  if params.reset then
    reaper.TrackFX_SetParam(track, fx_idx, 13, 1) -- trigger reset
  end

  -- Read LUFS params (sliders 10-12)
  local short_lufs  = reaper.TrackFX_GetParam(track, fx_idx, 10)
  local int_lufs    = reaper.TrackFX_GetParam(track, fx_idx, 11)
  local kw_rms      = reaper.TrackFX_GetParam(track, fx_idx, 12)

  local play_state = reaper.GetPlayState()
  local warning = nil
  if play_state == 0 then
    warning = "Playback is stopped — LUFS values may be stale."
  end

  local result = {
    track = params.track,
    short_term_lufs = math.floor(short_lufs * 10 + 0.5) / 10,
    integrated_lufs = math.floor(int_lufs * 10 + 0.5) / 10,
    k_weighted_rms_db = math.floor(kw_rms * 10 + 0.5) / 10,
    targets = {
      spotify = -14,
      youtube = -14,
      apple_music = -16,
      broadcast = -24,
      cd = -9,
    },
  }
  if warning then result.warning = warning end
  return result
end

-- ============================================================================
-- Mix Audit / Diagnostic
-- ============================================================================

function handlers.audit_mix(params)
  local issues = {}
  local num_tracks = reaper.CountTracks(0)
  local play_state = reaper.GetPlayState()
  local playback_active = (play_state & 1) ~= 0

  for i = 0, num_tracks - 1 do
    local track = reaper.GetTrack(0, i)
    local _, track_name = reaper.GetTrackName(track)
    local num_items = reaper.CountTrackMediaItems(track)
    local num_fx = reaper.TrackFX_GetCount(track)
    local num_sends = reaper.GetTrackNumSends(track, 0) -- 0 = sends
    local num_receives = reaper.GetTrackNumSends(track, -1) -- -1 = receives
    local is_folder = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH") > 0
    local phase = reaper.GetMediaTrackInfo_Value(track, "B_PHASE")

    -- Peak check (requires playback)
    if playback_active then
      local peak_l = reaper.Track_GetPeakInfo(track, 0)
      local peak_r = reaper.Track_GetPeakInfo(track, 1)
      local peak_max = math.max(peak_l, peak_r)
      if peak_max >= 1.0 then
        issues[#issues+1] = {severity = "error", category = "clipping", track = track_name,
          message = string.format("Track is clipping (peak: %.1f dBFS)", vol_to_db(peak_max))}
      elseif peak_max > db_to_vol(-6) then
        issues[#issues+1] = {severity = "warning", category = "hot_track", track = track_name,
          message = string.format("Track is hot (peak: %.1f dBFS) — risk of clipping downstream", vol_to_db(peak_max))}
      elseif peak_max < db_to_vol(-40) and num_items > 0 then
        issues[#issues+1] = {severity = "info", category = "quiet_track", track = track_name,
          message = string.format("Very quiet track (peak: %.1f dBFS) with items present", vol_to_db(peak_max))}
      end
    end

    -- Missing HPF check: look for ReaEQ with highpass band (type=3)
    local has_hpf = false
    for j = 0, num_fx - 1 do
      local _, fx_name = reaper.TrackFX_GetFXName(track, j)
      local fx_lower = fx_name:lower()
      if fx_lower:find("hpf") or fx_lower:find("highpass") or fx_lower:find("high pass") then
        has_hpf = true
        break
      end
      -- Check ReaEQ for highpass band type
      if fx_lower:find("reaeq") then
        local num_params = reaper.TrackFX_GetNumParams(track, j)
        for p = 0, num_params - 1 do
          local _, pname = reaper.TrackFX_GetParamName(track, j, p)
          if pname:find("Type") then
            local val = reaper.TrackFX_GetParam(track, j, p)
            if math.floor(val + 0.5) == 3 then -- type 3 = highpass
              has_hpf = true
              break
            end
          end
        end
        if has_hpf then break end
      end
    end
    if not has_hpf and num_items > 0 and not is_folder then
      issues[#issues+1] = {severity = "info", category = "missing_hpf", track = track_name,
        message = "No high-pass filter detected — consider adding HPF to remove low-frequency rumble"}
    end

    -- Empty track check
    if num_items == 0 and num_fx == 0 and num_sends == 0 and num_receives == 0 and not is_folder then
      issues[#issues+1] = {severity = "info", category = "empty_track", track = track_name,
        message = "Empty track (no items, FX, sends, or receives)"}
    end

    -- No FX check
    if num_items > 0 and num_fx == 0 then
      issues[#issues+1] = {severity = "info", category = "no_fx", track = track_name,
        message = "Track has audio items but no FX — intentional?"}
    end

    -- Phase inverted check
    if phase == 1 then
      issues[#issues+1] = {severity = "info", category = "phase_inverted", track = track_name,
        message = "Phase is inverted — verify this is intentional (multi-mic setup)"}
    end
  end

  -- Master track checks
  if playback_active then
    local master = reaper.GetMasterTrack(0)
    local master_peak_l = reaper.Track_GetPeakInfo(master, 0)
    local master_peak_r = reaper.Track_GetPeakInfo(master, 1)
    local master_peak = math.max(master_peak_l, master_peak_r)
    if master_peak >= 1.0 then
      issues[#issues+1] = {severity = "error", category = "master_clipping", track = "Master",
        message = string.format("Master bus is clipping (peak: %.1f dBFS)", vol_to_db(master_peak))}
    elseif master_peak > db_to_vol(-3) then
      issues[#issues+1] = {severity = "warning", category = "low_headroom", track = "Master",
        message = string.format("Master bus has low headroom (peak: %.1f dBFS, < 3dB)", vol_to_db(master_peak))}
    end
  end

  -- Count by severity
  local errors, warnings, infos = 0, 0, 0
  for _, issue in ipairs(issues) do
    if issue.severity == "error" then errors = errors + 1
    elseif issue.severity == "warning" then warnings = warnings + 1
    else infos = infos + 1 end
  end

  local result = {
    playback_active = playback_active,
    summary = {errors = errors, warnings = warnings, info = infos, total_tracks = num_tracks},
    issues = issues,
  }
  if not playback_active then
    result.warning = "Playback is stopped — clipping and level checks require playback to be running."
  end
  return result
end

-- ============================================================================
-- Auto Gain Staging
-- ============================================================================

function handlers.auto_gain_stage(params)
  local play_state = reaper.GetPlayState()
  if (play_state & 1) == 0 then
    return nil, "Playback must be running for gain staging. Start playback on a representative loud section (e.g., chorus), then try again."
  end

  local target_db = params.target_db or -18
  local results = {}
  local tracks_to_process = {}

  if params.track then
    local track, err = resolve_track(params.track)
    if not track then return nil, err end
    tracks_to_process[#tracks_to_process+1] = track
  else
    for i = 0, reaper.CountTracks(0) - 1 do
      tracks_to_process[#tracks_to_process+1] = reaper.GetTrack(0, i)
    end
  end

  for _, track in ipairs(tracks_to_process) do
    local _, track_name = reaper.GetTrackName(track)
    local is_folder = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH") > 0

    -- Skip folders
    if not is_folder then
      local peak_l = reaper.Track_GetPeakInfo(track, 0)
      local peak_r = reaper.Track_GetPeakInfo(track, 1)
      local peak_max = math.max(peak_l, peak_r)

      -- Skip silent tracks
      if peak_max > 0.00001 then
        local current_peak_db = vol_to_db(peak_max)
        local current_vol = reaper.GetMediaTrackInfo_Value(track, "D_VOL")
        local current_vol_db = vol_to_db(current_vol)
        local adjustment = target_db - current_peak_db
        local new_vol_db = current_vol_db + adjustment

        -- Clamp to safe range
        new_vol_db = math.max(-80, math.min(MAX_DB, new_vol_db))
        local new_vol = db_to_vol(new_vol_db)

        reaper.SetMediaTrackInfo_Value(track, "D_VOL", new_vol)

        results[#results+1] = {
          track = track_name,
          before_peak_db = math.floor(current_peak_db * 10 + 0.5) / 10,
          before_vol_db = math.floor(current_vol_db * 10 + 0.5) / 10,
          adjustment_db = math.floor(adjustment * 10 + 0.5) / 10,
          new_vol_db = math.floor(new_vol_db * 10 + 0.5) / 10,
        }
      end
    end
  end

  return {
    target_db = target_db,
    tracks_adjusted = #results,
    results = results,
  }
end

-- ============================================================================
-- Frequency Conflict Detection
-- ============================================================================

function handlers.detect_frequency_conflicts(params)
  local num_tracks = reaper.CountTracks(0)
  local track_boosts = {}  -- {track_name, freq, gain, source}
  local track_spectral = {} -- {track_name, bands}

  -- Band center frequencies for labeling
  local band_names = {"sub (20-80Hz)", "low (80-300Hz)", "mid (300Hz-2kHz)", "high-mid (2-8kHz)", "high (8-20kHz)"}
  local band_freqs = {50, 190, 1150, 5000, 14000}

  for i = 0, num_tracks - 1 do
    local track = reaper.GetTrack(0, i)
    local _, track_name = reaper.GetTrackName(track)
    local num_fx = reaper.TrackFX_GetCount(track)

    -- Mode 1: EQ heuristic — scan EQ plugins for boosting bands
    for j = 0, num_fx - 1 do
      local _, fx_name = reaper.TrackFX_GetFXName(track, j)
      if fx_name:lower():find("reaeq") or fx_name:lower():find("eq") then
        local num_params = reaper.TrackFX_GetNumParams(track, j)
        -- Look for bands with gain > 0.5dB
        for band = 1, 8 do
          local freq_val, gain_val = nil, nil
          for p = 0, num_params - 1 do
            local _, pname = reaper.TrackFX_GetParamName(track, j, p)
            if pname == "Band " .. band .. " Freq" or pname:find("Band " .. band .. " Freq") then
              freq_val = reaper.TrackFX_GetParam(track, j, p)
            end
            if pname == "Band " .. band .. " Gain" or pname:find("Band " .. band .. " Gain") then
              gain_val = reaper.TrackFX_GetParam(track, j, p)
            end
          end
          if freq_val and gain_val and gain_val > 0.5 then
            track_boosts[#track_boosts+1] = {
              track_name = track_name, freq = freq_val, gain = gain_val, source = "eq_boost"
            }
          end
        end
      end

      -- Mode 2: Spectral (MCP Analyzer present)
      if fx_name:lower():find("mcp analyzer") or fx_name:lower():find("mcp_analyzer") then
        local bands = {}
        for b = 0, 4 do
          bands[b+1] = reaper.TrackFX_GetParam(track, j, b)
        end
        track_spectral[#track_spectral+1] = {track_name = track_name, bands = bands}
      end
    end
  end

  local conflicts = {}

  -- EQ heuristic conflicts: compare track pairs for boosts within ~1 octave
  for a = 1, #track_boosts do
    for b = a + 1, #track_boosts do
      local ba = track_boosts[a]
      local bb = track_boosts[b]
      if ba.track_name ~= bb.track_name then
        local ratio = ba.freq / bb.freq
        if ratio > 0.5 and ratio < 2.0 then -- within ~1 octave
          local avg_freq = (ba.freq + bb.freq) / 2
          local range = "unknown"
          if avg_freq < 80 then range = "sub (20-80Hz)"
          elseif avg_freq < 300 then range = "low (80-300Hz)"
          elseif avg_freq < 2000 then range = "mid (300Hz-2kHz)"
          elseif avg_freq < 8000 then range = "high-mid (2-8kHz)"
          else range = "high (8-20kHz)" end

          conflicts[#conflicts+1] = {
            track_a = ba.track_name,
            track_b = bb.track_name,
            frequency_range = range,
            approx_freq_hz = math.floor(avg_freq + 0.5),
            detail = string.format("%s boosts %.0fHz (+%.1fdB), %s boosts %.0fHz (+%.1fdB)",
              ba.track_name, ba.freq, ba.gain, bb.track_name, bb.freq, bb.gain),
            suggestion = string.format("Consider cutting %.0fHz on one track and boosting on the other (complementary EQ)", avg_freq),
          }
        end
      end
    end
  end

  -- Spectral conflicts: compare tracks with strong energy in same bands
  for a = 1, #track_spectral do
    for b = a + 1, #track_spectral do
      local sa = track_spectral[a]
      local sb = track_spectral[b]
      for band_idx = 1, 5 do
        if sa.bands[band_idx] > -20 and sb.bands[band_idx] > -20 then
          conflicts[#conflicts+1] = {
            track_a = sa.track_name,
            track_b = sb.track_name,
            frequency_range = band_names[band_idx],
            approx_freq_hz = band_freqs[band_idx],
            detail = string.format("Both tracks have strong energy in %s (%s: %.1fdB, %s: %.1fdB)",
              band_names[band_idx], sa.track_name, sa.bands[band_idx], sb.track_name, sb.bands[band_idx]),
            suggestion = "Use complementary EQ — cut this range on one track to make space for the other",
          }
        end
      end
    end
  end

  return {
    tracks_analyzed = num_tracks,
    conflicts_found = #conflicts,
    conflicts = conflicts,
  }
end

-- ============================================================================
-- Sidechain Routing
-- ============================================================================

function handlers.setup_sidechain(params)
  if not params.trigger then return nil, "Missing 'trigger' track parameter" end
  if not params.target then return nil, "Missing 'target' track parameter" end

  local trigger, err1 = resolve_track(params.trigger)
  if not trigger then return nil, "Trigger: " .. err1 end
  local target, err2 = resolve_track(params.target)
  if not target then return nil, "Target: " .. err2 end

  local effect = params.effect or "compress"
  local intensity = params.intensity or "moderate"

  -- Intensity presets
  local presets = {
    gentle   = {thresh = -20, ratio = 2, attack = 10, release = 100},
    moderate = {thresh = -15, ratio = 4, attack = 5,  release = 80},
    heavy    = {thresh = -10, ratio = 8, attack = 1,  release = 50},
  }
  local preset = presets[intensity]
  if not preset then return nil, "Invalid intensity '" .. intensity .. "'. Use gentle, moderate, or heavy." end

  -- Create send from trigger to target
  local send_idx = reaper.CreateTrackSend(trigger, target)
  if send_idx < 0 then return nil, "Failed to create send from trigger to target" end

  -- Route send to channels 3/4 (sidechain input)
  reaper.SetTrackSendInfo_Value(trigger, 0, send_idx, "I_DSTCHAN", 2) -- 2 = channels 3/4

  -- Find or add the appropriate FX on target
  local fx_plugin = effect == "gate" and "ReaGate" or "ReaComp"
  local fx_idx = nil
  local fx_count = reaper.TrackFX_GetCount(target)
  for i = 0, fx_count - 1 do
    local _, fx_name = reaper.TrackFX_GetFXName(target, i)
    if fx_name:lower():find(fx_plugin:lower()) then
      fx_idx = i
      break
    end
  end
  if not fx_idx then
    fx_idx = reaper.TrackFX_AddByName(target, fx_plugin, false, -1)
    if fx_idx < 0 then return nil, "Failed to add " .. fx_plugin .. " to target track" end
  end

  -- Set FX parameters using fuzzy matching
  local function set_param_fuzzy(track, fx, name_pattern, value)
    local num_params = reaper.TrackFX_GetNumParams(track, fx)
    for p = 0, num_params - 1 do
      local _, pname = reaper.TrackFX_GetParamName(track, fx, p)
      if pname:lower():find(name_pattern:lower()) then
        reaper.TrackFX_SetParam(track, fx, p, value)
        return true
      end
    end
    return false
  end

  -- Apply preset parameters
  if effect == "gate" then
    set_param_fuzzy(target, fx_idx, "thresh", preset.thresh)
    set_param_fuzzy(target, fx_idx, "attack", preset.attack / 1000) -- ms to seconds
    set_param_fuzzy(target, fx_idx, "release", preset.release / 1000)
  else
    -- ReaComp params — thresh is in dB (0 to -60 range mapped to 1.0 to 0.0)
    local num_params = reaper.TrackFX_GetNumParams(target, fx_idx)
    for p = 0, num_params - 1 do
      local _, pname = reaper.TrackFX_GetParamName(target, fx_idx, p)
      local pname_lower = pname:lower()
      if pname_lower:find("thresh") then
        -- ReaComp thresh: normalize from dB range
        local _, minval, maxval = reaper.TrackFX_GetParam(target, fx_idx, p)
        local range = maxval - minval
        local normalized = (preset.thresh - minval) / range
        normalized = math.max(0, math.min(1, normalized))
        reaper.TrackFX_SetParam(target, fx_idx, p, normalized)
      elseif pname_lower:find("ratio") then
        local _, minval, maxval = reaper.TrackFX_GetParam(target, fx_idx, p)
        local range = maxval - minval
        local normalized = (preset.ratio - minval) / range
        normalized = math.max(0, math.min(1, normalized))
        reaper.TrackFX_SetParam(target, fx_idx, p, normalized)
      elseif pname_lower:find("attack") then
        local _, minval, maxval = reaper.TrackFX_GetParam(target, fx_idx, p)
        local range = maxval - minval
        local normalized = (preset.attack / 1000 - minval) / range
        normalized = math.max(0, math.min(1, normalized))
        reaper.TrackFX_SetParam(target, fx_idx, p, normalized)
      elseif pname_lower:find("release") then
        local _, minval, maxval = reaper.TrackFX_GetParam(target, fx_idx, p)
        local range = maxval - minval
        local normalized = (preset.release / 1000 - minval) / range
        normalized = math.max(0, math.min(1, normalized))
        reaper.TrackFX_SetParam(target, fx_idx, p, normalized)
      elseif pname_lower:find("detector") or pname_lower:find("aux") then
        -- Set to auxiliary/sidechain input
        reaper.TrackFX_SetParam(target, fx_idx, p, 1)
      end
    end
  end

  return {
    trigger = params.trigger,
    target = params.target,
    effect = fx_plugin,
    intensity = intensity,
    send_channel = "3/4 (sidechain)",
    preset = preset,
  }
end

-- ============================================================================
-- Session Cleanup / Prep
-- ============================================================================

function handlers.prepare_session(params)
  local options = params.options or {}
  local remove_empty = options.remove_empty ~= false  -- default true
  local create_buses = options.create_buses ~= false   -- default true

  local removed = {}
  local buses_created = {}

  -- Remove empty tracks (iterate backwards to avoid index shifting)
  if remove_empty then
    for i = reaper.CountTracks(0) - 1, 0, -1 do
      local track = reaper.GetTrack(0, i)
      local _, track_name = reaper.GetTrackName(track)
      local num_items = reaper.CountTrackMediaItems(track)
      local num_fx = reaper.TrackFX_GetCount(track)
      local num_sends = reaper.GetTrackNumSends(track, 0)
      local num_receives = reaper.GetTrackNumSends(track, -1)
      local is_folder = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH") > 0

      if num_items == 0 and num_fx == 0 and num_sends == 0 and num_receives == 0 and not is_folder then
        removed[#removed+1] = track_name
        reaper.DeleteTrack(track)
      end
    end
  end

  -- Create standard buses if they don't exist
  if create_buses then
    local bus_names = {"Drum Bus", "Vocal Bus", "Instrument Bus", "FX Bus"}
    for _, bus_name in ipairs(bus_names) do
      -- Check if bus already exists
      local exists = false
      for i = 0, reaper.CountTracks(0) - 1 do
        local track = reaper.GetTrack(0, i)
        local _, tn = reaper.GetTrackName(track)
        if tn:lower() == bus_name:lower() then
          exists = true
          break
        end
      end
      if not exists then
        local idx = reaper.CountTracks(0)
        reaper.InsertTrackAtIndex(idx, true)
        local track = reaper.GetTrack(0, idx)
        reaper.GetSetMediaTrackInfo_String(track, "P_NAME", bus_name, true)
        buses_created[#buses_created+1] = bus_name
      end
    end
  end

  return {
    tracks_removed = removed,
    tracks_removed_count = #removed,
    buses_created = buses_created,
    buses_created_count = #buses_created,
    total_tracks = reaper.CountTracks(0),
  }
end

function handlers.set_track_color(params)
  local track, err = resolve_track(params.track)
  if not track then return nil, err end

  if not params.r or not params.g or not params.b then
    return nil, "Missing color parameters. Provide r, g, b (0-255 each)."
  end

  local r = math.max(0, math.min(255, math.floor(params.r)))
  local g = math.max(0, math.min(255, math.floor(params.g)))
  local b = math.max(0, math.min(255, math.floor(params.b)))

  local color = reaper.ColorToNative(r, g, b) | 0x1000000
  reaper.SetMediaTrackInfo_Value(track, "I_CUSTOMCOLOR", color)

  return {track = params.track, r = r, g = g, b = b}
end

-- Build the allowed actions set from the handlers table
for action_name, _ in pairs(handlers) do
  ALLOWED_ACTIONS[action_name] = true
end

-- ============================================================================
-- Command dispatcher
-- Validates action against allowlist, wraps mutations in undo blocks.
-- ============================================================================

local READONLY_ACTIONS = {
  get_session_state = true,
  get_fx_params = true,
  get_transport_state = true,
  get_track_meter = true,
  get_master_meter = true,
  get_envelope_points = true,
  list_installed_fx = true,
  ping = true,
  undo = true,  -- undo/redo manage their own undo state, don't wrap them
  redo = true,
  analyze_track = true,
  get_loudness = true,
  audit_mix = true,
  detect_frequency_conflicts = true,
}

local function execute_command(cmd)
  local action = cmd.action
  local params = cmd.params or {}

  -- Validate action against allowlist
  if not ALLOWED_ACTIONS[action] then
    return {
      id = cmd.id, success = false, result = nil,
      error = "Unknown or disallowed action: " .. tostring(action)
    }
  end

  local handler = handlers[action]

  -- Wrap mutating commands in undo blocks
  local is_readonly = READONLY_ACTIONS[action]
  if not is_readonly then
    reaper.Undo_BeginBlock()
  end

  local ok, result_or_err, err = pcall(handler, params)

  if not is_readonly then
    reaper.Undo_EndBlock("MCP: " .. action, -1)
  end

  if not ok then
    return {id = cmd.id, success = false, result = nil, error = "Lua error: " .. tostring(result_or_err)}
  end

  -- Handler returned (nil, error_string)
  if result_or_err == nil then
    return {id = cmd.id, success = false, result = nil, error = err or "Command returned no result"}
  end

  return {id = cmd.id, success = true, result = result_or_err, error = nil}
end

-- ============================================================================
-- Main polling loop
-- Uses reaper.defer() for cooperative scheduling inside REAPER.
-- ============================================================================

local last_poll = 0

local function poll()
  local now = reaper.time_precise()
  if now - last_poll < POLL_INTERVAL then
    reaper.defer(poll)
    return
  end
  last_poll = now

  if file_exists(CMD_FILE) then
    local content = read_file(CMD_FILE)
    delete_file(CMD_FILE)

    if content and content ~= "" then
      if #content > MAX_CMD_SIZE then
        write_file(RSP_FILE, json.encode({
          id = "unknown", success = false, result = nil,
          error = "Command exceeds maximum size limit"
        }))
      else
        local cmd, parse_err = json.decode(content)
        if cmd and cmd.action then
          local response = execute_command(cmd)
          write_file(RSP_FILE, json.encode(response))
        elseif parse_err then
          write_file(RSP_FILE, json.encode({
            id = "unknown", success = false, result = nil,
            error = "Failed to parse command: " .. tostring(parse_err)
          }))
        end
      end
    end
  end

  reaper.defer(poll)
end

-- ============================================================================
-- Startup
-- ============================================================================

reaper.ShowConsoleMsg("REAPER MCP Listener v1.0.0\n")
reaper.ShowConsoleMsg("  IPC directory: " .. IPC_DIR .. "\n")
reaper.ShowConsoleMsg("  Watching for commands...\n")
poll()
