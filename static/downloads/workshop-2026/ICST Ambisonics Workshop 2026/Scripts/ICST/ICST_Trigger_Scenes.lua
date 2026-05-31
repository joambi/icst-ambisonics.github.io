-- REAPER ReaScript: send marker timing as OSC to Max whenever playback crosses a marker.
-- Max side:
--   [udpreceive 50010]
--   /act/scene/interval marker1 marker1_pos marker2 marker2_pos diff_ms
--   -> Scene Mover Duration (ms) + play
--   /act/scene/target Scene_2
--   /act/scene/start is still sent for compatibility/debugging.

local HOST = "127.0.0.1"
local PORT = 50010
local START_ADDRESS = "/act/scene/start"
local INTERVAL_ADDRESS = "/act/scene/interval"
local TARGET_ADDRESS = "/act/scene/target"
local SEND_COOLDOWN_SEC = 0.25
local CLICK_TOLERANCE_SEC = 0.02
local EXTSTATE_SECTION = "ACT_MARKER_TO_MAX"
local EXTSTATE_KEY = "instance_id"
local HELPER_FILENAME = "ICST_Trigger_Scenes_helper.py"
local PYTHON_CANDIDATES = {
  "/opt/homebrew/bin/python3",
  "/usr/local/bin/python3",
  "/usr/bin/python3",
  "python3"
}

local udp
local helper_warned = false
local socket_ok, socket = pcall(require, "socket")
if socket_ok and socket and socket.udp then
  udp = assert(socket.udp())
  udp:settimeout(0)
  assert(udp:setpeername(HOST, PORT))
end

local last_play_pos = nil
local last_marker_id = nil
local prev_marker_id = nil
local prev_marker_pos = nil
local last_send_time = -1
local last_cursor_pos = nil
local last_clicked_marker_id = nil
local instance_id = string.format("%.6f", reaper.time_precise())

reaper.SetExtState(EXTSTATE_SECTION, EXTSTATE_KEY, instance_id, false)
reaper.atexit(function()
  if reaper.GetExtState(EXTSTATE_SECTION, EXTSTATE_KEY) == instance_id then
    reaper.DeleteExtState(EXTSTATE_SECTION, EXTSTATE_KEY, false)
  end
end)

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

local function dirname(path)
  if type(path) ~= "string" or path == "" then
    return nil
  end
  return path:match("^(.*[/\\])[^/\\]+$") or nil
end

local function shell_quote(s)
  return "'" .. tostring(s):gsub("'", "'\"'\"'") .. "'"
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

local function osc_pad(s)
  local pad = 4 - (#s % 4)
  if pad == 4 then pad = 0 end
  return s .. string.rep("\0", pad)
end

local function osc_string(s)
  return osc_pad(s .. "\0")
end

local function osc_int32(n)
  if string.pack then
    return string.pack(">i4", n)
  end
  local b4 = n % 256
  n = math.floor(n / 256)
  local b3 = n % 256
  n = math.floor(n / 256)
  local b2 = n % 256
  n = math.floor(n / 256)
  local b1 = n % 256
  return string.char(b1, b2, b3, b4)
end

local function osc_float32(f)
  if string.pack then
    return string.pack(">f", f)
  end
  return osc_int32(0)
end

local function osc_packet_target(scene_name)
  return osc_string(TARGET_ADDRESS)
    .. osc_string(",s")
    .. osc_string(scene_name)
end

local function osc_packet_start(marker_index, marker_pos, marker_name)
  return osc_string(START_ADDRESS)
    .. osc_string(",ifs")
    .. osc_int32(marker_index)
    .. osc_float32(marker_pos)
    .. osc_string(marker_name or "")
end

local function osc_packet_interval(marker1_index, marker1_pos, marker2_index, marker2_pos, diff_ms)
  return osc_string(INTERVAL_ADDRESS)
    .. osc_string(",ififi")
    .. osc_int32(marker1_index)
    .. osc_float32(marker1_pos)
    .. osc_int32(marker2_index)
    .. osc_float32(marker2_pos)
    .. osc_int32(diff_ms)
end

local function send_via_python(mode, args)
  local helper = helper_path()
  if not helper then
    reaper.ShowConsoleMsg("ACT marker trigger: could not resolve helper path for Python OSC sender.\n")
    return false
  end

  local python = python_command()

  local command = table.concat({
    shell_quote(python),
    shell_quote(helper),
    shell_quote(HOST),
    shell_quote(tostring(PORT)),
    shell_quote(mode == "interval" and INTERVAL_ADDRESS or (mode == "target" and TARGET_ADDRESS or START_ADDRESS)),
    shell_quote(mode),
    table.unpack(args)
  }, " ")

  local ok, why, code = os.execute(command)
  if ok == true or ok == 0 then
    return true
  end

  reaper.ShowConsoleMsg("ACT marker trigger: Python OSC helper failed for " .. helper .. "\n")
  reaper.ShowConsoleMsg(
    "ACT marker trigger: python="
      .. tostring(python)
      .. " status="
      .. tostring(ok)
      .. " why="
      .. tostring(why)
      .. " code="
      .. tostring(code)
      .. "\n"
  )
  return false
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

  scene_name = scene_name:gsub("%s+", "_")
  return scene_name
end

local function send_target(scene_name)
  if not scene_name then
    return false
  end

  local sent = false

  if udp then
    udp:send(osc_packet_target(scene_name))
    sent = true
  else
    if not helper_warned then
      reaper.ShowConsoleMsg("LuaSocket not available: using Python OSC helper fallback.\n")
      reaper.ShowConsoleMsg("ACT marker trigger helper: " .. tostring(helper_path()) .. "\n")
      helper_warned = true
    end
    sent = send_via_python("target", {
      shell_quote(scene_name)
    })
  end

  return sent
end

local function send_start(marker_index, marker_pos, marker_name)
  local sent = false

  if udp then
    udp:send(osc_packet_start(marker_index, marker_pos, marker_name))
    sent = true
  else
    if not helper_warned then
      reaper.ShowConsoleMsg("LuaSocket not available: using Python OSC helper fallback.\n")
      reaper.ShowConsoleMsg("ACT marker trigger helper: " .. tostring(helper_path()) .. "\n")
      helper_warned = true
    end
    sent = send_via_python("start", {
      shell_quote(tostring(marker_index)),
      shell_quote(string.format("%.9f", marker_pos)),
      shell_quote(marker_name or "")
    })
  end

  return sent
end

local function send_interval(marker1_index, marker1_pos, marker2_index, marker2_pos, diff_ms)
  local sent = false

  if udp then
    udp:send(osc_packet_interval(marker1_index, marker1_pos, marker2_index, marker2_pos, diff_ms))
    sent = true
  else
    if not helper_warned then
      reaper.ShowConsoleMsg("LuaSocket not available: using Python OSC helper fallback.\n")
      reaper.ShowConsoleMsg("ACT marker trigger helper: " .. tostring(helper_path()) .. "\n")
      helper_warned = true
    end
    sent = send_via_python("interval", {
      shell_quote(tostring(marker1_index)),
      shell_quote(string.format("%.9f", marker1_pos)),
      shell_quote(tostring(marker2_index)),
      shell_quote(string.format("%.9f", marker2_pos)),
      shell_quote(tostring(diff_ms))
    })
  end

  return sent
end

local function send_trigger(marker_index, marker_pos, marker_name)
  local sent = false
  local diff_ms = nil
  local scene_name = normalize_scene_name(marker_name)

  sent = send_target(scene_name) or sent

  if prev_marker_id and prev_marker_pos and marker_pos > prev_marker_pos then
    diff_ms = math.floor(((marker_pos - prev_marker_pos) * 1000) + 0.5)
    sent = send_interval(prev_marker_id, prev_marker_pos, marker_index, marker_pos, diff_ms) or sent
  else
    sent = send_start(marker_index, marker_pos, marker_name) or sent
  end

  if sent then
    if diff_ms then
      reaper.ShowConsoleMsg(
        string.format(
          "ACT marker interval -> Max: scene %s | M%d %.3fs -> M%d %.3fs = %d ms\n",
          scene_name or "<current>",
          prev_marker_id,
          prev_marker_pos,
          marker_index,
          marker_pos,
          diff_ms
        )
      )
    else
      reaper.ShowConsoleMsg(
        string.format(
          "ACT marker trigger -> Max: scene %s | marker %d at %.3fs %s\n",
          scene_name or "<current>",
          marker_index,
          marker_pos,
          marker_name or ""
        )
      )
    end
  end

  prev_marker_id = marker_index
  prev_marker_pos = marker_pos
end

local function marker_between(a, b)
  local lo = math.min(a, b)
  local hi = math.max(a, b)
  local _, num_markers, num_regions = reaper.CountProjectMarkers(0)
  local total = num_markers + num_regions
  for i = 0, total - 1 do
    local ok, is_region, pos, _, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
    if ok and not is_region and pos > lo and pos <= hi then
      return markrgnindexnumber, pos, name
    end
  end
  return nil
end

local function marker_at_position(pos, tolerance)
  local _, num_markers, num_regions = reaper.CountProjectMarkers(0)
  local total = num_markers + num_regions
  local bestId, bestPos, bestName = nil, nil, nil
  local bestDistance = math.huge
  for i = 0, total - 1 do
    local ok, is_region, mpos, _, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
    if ok and not is_region then
      local dist = math.abs(mpos - pos)
      if dist <= tolerance and dist < bestDistance then
        bestId, bestPos, bestName = markrgnindexnumber, mpos, name
        bestDistance = dist
      end
    end
  end
  return bestId, bestPos, bestName
end

local function fire_clicked_marker(marker_id, marker_pos, marker_name)
  local scene_name = normalize_scene_name(marker_name)
  local sent = false

  sent = send_target(scene_name) or sent
  sent = send_start(marker_id, marker_pos, marker_name) or sent

  if sent then
    reaper.ShowConsoleMsg(
      string.format(
        "ACT marker click -> Max: scene %s | marker %d at %.3fs %s\n",
        scene_name or "<current>",
        marker_id,
        marker_pos,
        marker_name or ""
      )
    )
  end
end

local function loop()
  if reaper.GetExtState(EXTSTATE_SECTION, EXTSTATE_KEY) ~= instance_id then
    return
  end

  local play_state = reaper.GetPlayState()
  local is_playing = (play_state & 1) == 1
  local now = reaper.time_precise()

  if is_playing then
    local pos = reaper.GetPlayPosition()
    if last_play_pos then
      local marker_id, marker_pos, marker_name = marker_between(last_play_pos, pos)
      if marker_id and (marker_id ~= last_marker_id or now - last_send_time > SEND_COOLDOWN_SEC) then
        send_trigger(marker_id, marker_pos, marker_name)
        last_marker_id = marker_id
        last_send_time = now
      end
    end
    last_play_pos = pos
    last_cursor_pos = nil
    last_clicked_marker_id = nil
  else
    last_play_pos = nil
    last_marker_id = nil
    prev_marker_id = nil
    prev_marker_pos = nil

    local cursor_pos = reaper.GetCursorPosition()
    local moved = (last_cursor_pos == nil) or (math.abs(cursor_pos - last_cursor_pos) > 0.0005)
    if moved then
      local marker_id, marker_pos, marker_name = marker_at_position(cursor_pos, CLICK_TOLERANCE_SEC)
      if marker_id then
        if marker_id ~= last_clicked_marker_id then
          fire_clicked_marker(marker_id, marker_pos, marker_name)
          last_clicked_marker_id = marker_id
        end
      else
        last_clicked_marker_id = nil
      end
    end
    last_cursor_pos = cursor_pos
  end

  reaper.defer(loop)
end

reaper.ShowConsoleMsg(
  "ACT marker-to-Max OSC trigger running ["
    .. instance_id
    .. "]: "
    .. INTERVAL_ADDRESS
    .. " + "
    .. TARGET_ADDRESS
    .. " + "
    .. START_ADDRESS
    .. " -> "
    .. HOST
    .. ":"
    .. tostring(PORT)
    .. "\n"
)
loop()
