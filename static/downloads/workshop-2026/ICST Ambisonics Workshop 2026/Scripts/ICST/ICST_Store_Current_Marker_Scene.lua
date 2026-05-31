-- REAPER ReaScript: explicitly store the current marker scene in Max.
-- Sends:
--   /act/scene/target Scene_2
--   /act/scene/setduration 4181
--   /act/scene/store Scene_2

local HOST = "127.0.0.1"
local PORT = 50010
local TARGET_ADDRESS = "/act/scene/target"
local SETDURATION_ADDRESS = "/act/scene/setduration"
local STORE_ADDRESS = "/act/scene/store"
local HELPER_FILENAME = "ICST_Trigger_Scenes_helper.py"
local PYTHON_CANDIDATES = {
  "/opt/homebrew/bin/python3",
  "/usr/local/bin/python3",
  "/usr/bin/python3",
  "python3"
}

local udp
local socket_ok, socket = pcall(require, "socket")
if socket_ok and socket and socket.udp then
  udp = assert(socket.udp())
  udp:settimeout(0)
  assert(udp:setpeername(HOST, PORT))
end

local function dirname(path)
  if type(path) ~= "string" or path == "" then
    return nil
  end
  return path:match("^(.*[/\\])[^/\\]+$") or nil
end

local function get_script_path()
  local ok, a, b, c, d, e, f, g = pcall(reaper.get_action_context)
  if not ok then
    return nil
  end
  local values = {a, b, c, d, e, f, g}
  for _, value in ipairs(values) do
    if type(value) == "string" and value ~= "" and (value:match("%.lua$") or value:match("/")) then
      return value
    end
  end
  return nil
end

local function helper_path()
  local script_dir = dirname(get_script_path())
  if not script_dir then
    return nil
  end
  return script_dir .. HELPER_FILENAME
end

local function file_exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

local function python_command()
  for _, candidate in ipairs(PYTHON_CANDIDATES) do
    if candidate == "python3" or file_exists(candidate) then
      return candidate
    end
  end
  return "python3"
end

local function shell_quote(s)
  return "'" .. tostring(s):gsub("'", "'\"'\"'") .. "'"
end

local function osc_pad(s)
  local pad = 4 - (#s % 4)
  if pad == 4 then pad = 0 end
  return s .. string.rep("\0", pad)
end

local function osc_string(s)
  return osc_pad(s .. "\0")
end

local function osc_packet_symbol(address, scene_name)
  return osc_string(address)
    .. osc_string(",s")
    .. osc_string(scene_name)
end

local function osc_packet_int(address, value)
  local pack = string.pack and string.pack(">i4", value) or string.char(0, 0, 0, 0)
  return osc_string(address)
    .. osc_string(",i")
    .. pack
end

local function send_via_python(mode, address, payload)
  local helper = helper_path()
  if not helper then
    reaper.ShowConsoleMsg("ACT explicit store: could not resolve helper path.\n")
    return false
  end

  local command = table.concat({
    shell_quote(python_command()),
    shell_quote(helper),
    shell_quote(HOST),
    shell_quote(tostring(PORT)),
    shell_quote(address),
    shell_quote(mode),
    shell_quote(tostring(payload))
  }, " ")

  local ok, why, code = os.execute(command)
  if ok == true or ok == 0 then
    return true
  end

  reaper.ShowConsoleMsg(
    "ACT explicit store failed: mode="
      .. tostring(mode)
      .. " why="
      .. tostring(why)
      .. " code="
      .. tostring(code)
      .. "\n"
  )
  return false
end

local function send_symbol(address, mode, scene_name)
  if udp then
    udp:send(osc_packet_symbol(address, scene_name))
    return true
  end
  return send_via_python(mode, address, scene_name)
end

local function send_int(address, mode, value)
  if udp then
    udp:send(osc_packet_int(address, value))
    return true
  end
  return send_via_python(mode, address, value)
end

local function normalize_scene_name(marker_name)
  if type(marker_name) ~= "string" then
    return nil
  end
  local scene_name = marker_name:match("^%s*(.-)%s*$")
  if scene_name == "" then
    return nil
  end
  local digits = scene_name:match("^(%d+)$")
  if digits then
    return "Scene_" .. digits
  end
  return scene_name:gsub("%s+", "_")
end

local function current_reference_pos()
  local play_state = reaper.GetPlayState()
  if (play_state & 1) == 1 then
    return reaper.GetPlayPosition()
  end
  return reaper.GetCursorPosition()
end

local function marker_at_or_before(pos)
  local _, num_markers, num_regions = reaper.CountProjectMarkers(0)
  local total = num_markers + num_regions
  local bestId, bestPos, bestName = nil, -math.huge, nil
  for i = 0, total - 1 do
    local ok, is_region, mpos, _, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
    if ok and not is_region and mpos <= pos and mpos >= bestPos then
      bestId, bestPos, bestName = markrgnindexnumber, mpos, name
    end
  end
  return bestId, bestPos, bestName
end

local function next_marker_after(pos)
  local _, num_markers, num_regions = reaper.CountProjectMarkers(0)
  local total = num_markers + num_regions
  local bestId, bestPos, bestName = nil, math.huge, nil
  for i = 0, total - 1 do
    local ok, is_region, mpos, _, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
    if ok and not is_region and mpos > pos and mpos <= bestPos then
      bestId, bestPos, bestName = markrgnindexnumber, mpos, name
    end
  end
  return bestId, bestPos, bestName
end

local marker_id, marker_pos, marker_name = marker_at_or_before(current_reference_pos())
local scene_name = normalize_scene_name(marker_name)

if not marker_id or not scene_name then
  reaper.ShowConsoleMsg("ACT explicit store: no marker at or before cursor/playhead.\n")
  return
end

local next_marker_id, next_marker_pos = next_marker_after(marker_pos)
local duration_ms = nil
if next_marker_id and next_marker_pos and next_marker_pos > marker_pos then
  duration_ms = math.floor(((next_marker_pos - marker_pos) * 1000) + 0.5)
end

local okTarget = send_symbol(TARGET_ADDRESS, "target", scene_name)
local okDuration = true
if duration_ms then
  okDuration = send_int(SETDURATION_ADDRESS, "setduration", duration_ms)
end
local okStore = send_symbol(STORE_ADDRESS, "store", scene_name)

if okTarget and okDuration and okStore then
  reaper.ShowConsoleMsg(
    string.format(
      "ACT explicit store -> Max: marker %d at %.3fs as %s duration=%s\n",
      marker_id,
      marker_pos,
      scene_name,
      duration_ms and tostring(duration_ms) .. "ms" or "<unchanged>"
    )
  )
end
