-- @description AmbiEncoder64 Motion Map GUI
-- @author JS / Codex
-- @version 1.0
-- @about
--   GUI for assigning motion shapes per ICST AmbiEncoder_64 source index,
--   then writing XYZ automation and a render region via
--   JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua.

local SCRIPT_NAME = "AmbiEncoder64 Motion Map GUI"

local MOTIONS = {
  { id = "line", label = "Line" },
  { id = "arc_up", label = "Arc+" },
  { id = "arc_down", label = "Arc-" },
  { id = "s_curve", label = "S" },
  { id = "step", label = "Step" },
  { id = "zigzag", label = "Zig" },
  { id = "circle", label = "Circ" },
  { id = "spiral", label = "Spir" },
  { id = "fourier_xyz", label = "Four" },
  { id = "lissajous", label = "Lis" },
}

local state = {
  w = 980,
  h = 720,
  source_scroll = 1,
  selected_source = 1,
  motion_by_source = {},
  source_enabled = {},
  focus = nil,
  steps_per_second = "12",
  x_center = "0",
  x_spread = "320",
  y_center = "0",
  y_spread = "50",
  z_center = "0.75",
  z_spread = "0.35",
  motion_amount = "2.0",
  region_name = "BFormat_TS",
  clear_existing = true,
  set_latch = true,
  overwrite_region = true,
  use_z_motion = true,
  status = "Ready",
}

local ui = {
  mx = 0,
  my = 0,
  mouse_down = false,
  last_mouse_down = false,
  char = 0,
}

local function clamp(value, min_value, max_value)
  if value < min_value then return min_value end
  if value > max_value then return max_value end
  return value
end

local function trim(value)
  return tostring(value or ""):match("^%s*(.-)%s*$")
end

local function script_dir()
  local _, path = reaper.get_action_context()
  return path:match("^(.*)[/\\][^/\\]+$") or "."
end

local function join_path(left, right)
  local separator = package.config:sub(1, 1)
  if left:sub(-1) == "/" or left:sub(-1) == "\\" then
    return left .. right
  end
  return left .. separator .. right
end

local function writer_path()
  return join_path(script_dir(), "JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua")
end

local function file_exists(path)
  local file = io.open(path, "r")
  if file then
    file:close()
    return true
  end
  return false
end

local function draw_rect(x, y, w, h, r, g, b, a, filled)
  gfx.set(r, g, b, a or 1)
  gfx.rect(x, y, w, h, filled and 1 or 0)
end

local function draw_text(text, x, y, r, g, b)
  gfx.set(r or 0.88, g or 0.90, b or 0.92, 1)
  gfx.x = x
  gfx.y = y
  gfx.drawstr(text or "")
end

local function rect_hit(x, y, w, h)
  return ui.mx >= x and ui.mx <= x + w and ui.my >= y and ui.my <= y + h
end

local function mouse_clicked(x, y, w, h)
  return ui.mouse_down and not ui.last_mouse_down and rect_hit(x, y, w, h)
end

local function draw_button(label, x, y, w, h, active, disabled)
  local hover = rect_hit(x, y, w, h) and not disabled
  local r, g, b = 0.16, 0.18, 0.20
  if active then r, g, b = 0.22, 0.42, 0.36 end
  if disabled then r, g, b = 0.10, 0.11, 0.12 end
  if hover then r, g, b = r + 0.05, g + 0.05, b + 0.05 end
  draw_rect(x, y, w, h, r, g, b, 1, true)
  draw_rect(x, y, w, h, active and 0.52 or 0.34, active and 0.84 or 0.38, active and 0.66 or 0.42, disabled and 0.35 or 1, false)
  local tw, th = gfx.measurestr(label)
  draw_text(label, x + (w - tw) / 2, y + (h - th) / 2 + 1, disabled and 0.45 or 0.90, disabled and 0.46 or 0.92, disabled and 0.48 or 0.94)
  return not disabled and mouse_clicked(x, y, w, h)
end

local function draw_toggle(label, value, x, y)
  local size = 18
  local clicked = mouse_clicked(x, y, size, size) or mouse_clicked(x + 26, y - 2, 170, 22)
  if clicked then value = not value end
  draw_rect(x, y, size, size, 0.11, 0.12, 0.14, 1, true)
  draw_rect(x, y, size, size, 0.40, 0.44, 0.48, 1, false)
  if value then draw_rect(x + 4, y + 4, size - 8, size - 8, 0.42, 0.82, 0.62, 1, true) end
  draw_text(label, x + 26, y + 2, 0.78, 0.82, 0.84)
  return value
end

local function draw_input(id, label, x, y, w)
  draw_text(label, x, y, 0.62, 0.66, 0.70)
  local box_y = y + 18
  local active = state.focus == id
  if mouse_clicked(x, box_y, w, 26) then
    state.focus = id
    active = true
  end
  draw_rect(x, box_y, w, 26, active and 0.12 or 0.09, active and 0.16 or 0.11, active and 0.18 or 0.13, 1, true)
  draw_rect(x, box_y, w, 26, active and 0.40 or 0.30, active and 0.70 or 0.34, active and 0.58 or 0.38, 1, false)
  local text = tostring(state[id] or "")
  if active and math.floor(reaper.time_precise() * 2) % 2 == 0 then text = text .. "|" end
  draw_text(text, x + 7, box_y + 6)
end

local function set_motion_for_range(first_source, last_source, motion)
  for source = first_source, last_source do
    state.motion_by_source[source] = motion
  end
end

local function set_source_enabled(first_source, last_source, enabled)
  for source = first_source, last_source do
    state.source_enabled[source] = enabled
  end
end

local function set_auto_map()
  for source = 1, 64 do
    state.motion_by_source[source] = MOTIONS[((source - 1) % #MOTIONS) + 1].id
  end
end

local function clear_motion_selection()
  for source = 1, 64 do
    state.motion_by_source[source] = nil
    state.source_enabled[source] = false
  end
  state.status = "Motion selection cleared"
end

local function enabled_sources()
  local sources = {}
  for source = 1, 64 do
    if state.source_enabled[source] then
      sources[#sources + 1] = source
    end
  end
  return sources
end

local function set_all(motion)
  set_motion_for_range(1, 64, motion)
end

local function set_random()
  math.randomseed(math.floor(reaper.time_precise() * 100000))
  for source = 1, 64 do
    state.motion_by_source[source] = MOTIONS[math.random(1, #MOTIONS)].id
  end
end

local function motion_label(id)
  for _, motion in ipairs(MOTIONS) do
    if motion.id == id then return motion.label end
  end
  return "None"
end

local function source_label(source)
  return "S" .. tostring(source - 1)
end

local function draw_motion_icon(id, x, y, w, h, r, g, b)
  gfx.set(r, g, b, 1)
  local cx = x + w / 2
  local cy = y + h / 2
  local left = x + 8
  local right = x + w - 8
  local top = y + 6
  local bottom = y + h - 6
  local function draw_polyline(points)
    for i = 2, #points do
      gfx.line(points[i - 1][1], points[i - 1][2], points[i][1], points[i][2])
    end
  end

  if id == "line" then
    gfx.line(left, bottom, right, top)
  elseif id == "arc_up" then
    local points = {}
    for i = 0, 16 do
      local t = i / 16
      points[#points + 1] = {
        left + (right - left) * t,
        cy - ((bottom - top) * 0.42) * math.sin(math.pi * t),
      }
    end
    draw_polyline(points)
  elseif id == "arc_down" then
    local points = {}
    for i = 0, 16 do
      local t = i / 16
      points[#points + 1] = {
        left + (right - left) * t,
        cy + ((bottom - top) * 0.42) * math.sin(math.pi * t),
      }
    end
    draw_polyline(points)
  elseif id == "s_curve" then
    local points = {}
    for i = 0, 24 do
      local t = i / 24
      points[#points + 1] = {
        left + (right - left) * t,
        cy - math.sin(t * math.pi * 2) * ((bottom - top) * 0.34),
      }
    end
    draw_polyline(points)
  elseif id == "step" then
    local step_w = (right - left) / 4
    local step_h = (bottom - top) / 3
    local px = left
    local py = bottom
    for i = 1, 4 do
      local nx = left + step_w * i
      gfx.line(px, py, nx, py)
      if i < 4 then
        gfx.line(nx, py, nx, py - step_h)
        py = py - step_h
      end
      px = nx
    end
  elseif id == "zigzag" then
    local px = left
    local py = bottom
    for i = 1, 5 do
      local nx = left + i * ((right - left) / 5)
      local ny = i % 2 == 1 and top or bottom
      gfx.line(px, py, nx, ny)
      px, py = nx, ny
    end
  elseif id == "circle" then
    gfx.circle(cx, cy, math.min(w, h) * 0.30, 0)
  elseif id == "spiral" then
    local max_r = math.min(right - left, bottom - top) * 0.46
    for i = 1, 32 do
      local p1 = (i - 1) / 32
      local p2 = i / 32
      local a1 = p1 * math.pi * 5.2
      local a2 = p2 * math.pi * 5.2
      local r1 = max_r * p1
      local r2 = max_r * p2
      gfx.line(cx + math.cos(a1) * r1, cy + math.sin(a1) * r1, cx + math.cos(a2) * r2, cy + math.sin(a2) * r2)
    end
  elseif id == "fourier_xyz" then
    local points = {}
    for i = 0, 48 do
      local t = i / 48
      local px =
        math.sin(math.pi * 2 * t) * 0.58 +
        math.sin(math.pi * 4 * t + 0.7) * 0.24 +
        math.sin(math.pi * 6 * t + 1.3) * 0.12
      local py =
        math.sin(math.pi * 2 * t + 1.1) * 0.56 +
        math.sin(math.pi * 8 * t + 0.2) * 0.18 +
        math.sin(math.pi * 12 * t + 0.8) * 0.10
      points[#points + 1] = {
        cx + px * ((right - left) * 0.30),
        cy + py * ((bottom - top) * 0.30),
      }
    end
    draw_polyline(points)
  else
    local points = {}
    for i = 0, 48 do
      local t = (i / 48) * math.pi * 2
      points[#points + 1] = {
        cx + math.sin(t) * ((right - left) * 0.34),
        cy + math.sin(t * 2) * ((bottom - top) * 0.34),
      }
    end
    draw_polyline(points)
  end
end

local function draw_motion_cell(source, motion, x, y, w, h)
  local active = state.motion_by_source[source] == motion.id
  local enabled = state.source_enabled[source]
  if draw_button("", x, y, w, h, active, false) then
    state.motion_by_source[source] = motion.id
    state.source_enabled[source] = true
    state.selected_source = source
  end
  local dim = enabled and 1 or 0.45
  draw_motion_icon(motion.id, x, y, w, h, (active and 0.88 or 0.64) * dim, (active and 0.96 or 0.68) * dim, (active and 0.90 or 0.72) * dim)
end

local function draw_source_grid()
  local x = 18
  local y = 84
  local row_h = 30
  local enable_w = 34
  local source_w = 52
  local cell_w = 58
  local max_rows = 16

  draw_text("On", x + 5, y - 24, 0.62, 0.66, 0.70)
  draw_text("Source", x + enable_w, y - 24, 0.62, 0.66, 0.70)
  for i, motion in ipairs(MOTIONS) do
    draw_text(motion.label, x + enable_w + source_w + (i - 1) * cell_w + 7, y - 24, 0.62, 0.66, 0.70)
  end

  state.source_scroll = clamp(state.source_scroll, 1, 64 - max_rows + 1)
  for row = 0, max_rows - 1 do
    local source = state.source_scroll + row
    local row_y = y + row * row_h
    local selected = source == state.selected_source
    local enabled = state.source_enabled[source]
    if draw_button(enabled and "✓" or "", x, row_y, enable_w - 6, row_h - 4, enabled, false) then
      state.source_enabled[source] = not enabled
      state.selected_source = source
    end
    draw_rect(x + enable_w, row_y, source_w - 6, row_h - 4, selected and 0.22 or 0.12, selected and 0.32 or 0.14, selected and 0.28 or 0.16, enabled and 1 or 0.55, true)
    draw_rect(x + enable_w, row_y, source_w - 6, row_h - 4, 0.30, 0.34, 0.38, enabled and 1 or 0.55, false)
    draw_text(source_label(source), x + enable_w + 7, row_y + 7, enabled and 0.88 or 0.46, enabled and 0.90 or 0.48, enabled and 0.92 or 0.50)
    if mouse_clicked(x + enable_w, row_y, source_w - 6, row_h - 4) then
      state.selected_source = source
    end
    for i, motion in ipairs(MOTIONS) do
      draw_motion_cell(source, motion, x + enable_w + source_w + (i - 1) * cell_w, row_y, cell_w - 4, row_h - 4)
    end
  end

  if draw_button("Up", x + 642, y, 46, 28, false, state.source_scroll == 1) then
    state.source_scroll = math.max(1, state.source_scroll - 8)
  end
  if draw_button("Down", x + 642, y + 34, 46, 28, false, state.source_scroll >= 49) then
    state.source_scroll = math.min(49, state.source_scroll + 8)
  end
  draw_text("Showing " .. source_label(state.source_scroll) .. "-" .. source_label(state.source_scroll + max_rows - 1), x + 642, y + 76, 0.62, 0.66, 0.70)
end

local function draw_presets()
  local x = 18
  local y = 572
  draw_text("Presets", x, y - 20, 0.62, 0.66, 0.70)
  if draw_button("Auto", x, y, 70, 30, false, false) then set_auto_map() end
  if draw_button("Random", x + 78, y, 80, 30, false, false) then set_random() end
  if draw_button("All Line", x + 166, y, 90, 30, false, false) then set_all("line") end
  if draw_button("All Circle", x + 264, y, 94, 30, false, false) then set_all("circle") end
  if draw_button("All Step", x + 366, y, 86, 30, false, false) then set_all("step") end
  if draw_button("S0-7 Arc", x + 460, y, 88, 30, false, false) then set_motion_for_range(1, 8, "arc_up") end
  if draw_button("S8-15 Circle", x + 556, y, 118, 30, false, false) then set_motion_for_range(9, 16, "circle") end
  if draw_button("All Src", x, y + 38, 78, 28, false, false) then set_source_enabled(1, 64, true) end
  if draw_button("None Src", x + 86, y + 38, 86, 28, false, false) then set_source_enabled(1, 64, false) end
  if draw_button("S0-7 Src", x + 180, y + 38, 88, 28, false, false) then set_source_enabled(1, 64, false); set_source_enabled(1, 8, true) end
  if draw_button("S8-15 Src", x + 276, y + 38, 96, 28, false, false) then set_source_enabled(1, 64, false); set_source_enabled(9, 16, true) end
  if draw_button("Clear Sel", x + 368, y + 38, 94, 28, false, false) then clear_motion_selection() end
end

local function motion_map_for_writer()
  local map = {}
  for source = 1, 64 do
    local motion = state.motion_by_source[source]
    if motion and motion ~= "" then
      map[source] = motion
    end
  end
  return map
end

local function write_automation()
  local path = writer_path()
  if not file_exists(path) then
    reaper.MB("Writer-Script nicht gefunden:\n" .. path, SCRIPT_NAME, 0)
    return
  end
  local sources = enabled_sources()
  if #sources == 0 then
    reaper.MB("Bitte mindestens eine Source aktivieren.", SCRIPT_NAME, 0)
    return
  end

  _G.JS_AMBIENCODER64_SETTINGS = {
    sources = sources,
    steps_per_second = state.steps_per_second,
    azimuth_center = state.x_center,
    azimuth_spread = state.x_spread,
    elevation_center = state.y_center,
    elevation_spread = state.y_spread,
    distance_center = state.z_center,
    distance_spread = state.z_spread,
    motion_amount = state.motion_amount,
    use_z_motion = state.use_z_motion,
    clear_existing = state.clear_existing,
    set_latch = state.set_latch,
    overwrite_region = state.overwrite_region,
    region_name = state.region_name,
    motion_map = motion_map_for_writer(),
  }

  dofile(path)
  state.status = "Automation written for " .. tostring(#sources) .. " source(s)"
end

local function draw_settings()
  local x = 720
  local y = 84
  local sources = enabled_sources()
  draw_text("Settings", x, y - 28, 0.94, 0.96, 0.96)
  draw_text("Active sources", x, y, 0.62, 0.66, 0.70)
  draw_text(tostring(#sources) .. " / 64", x, y + 24, 0.88, 0.90, 0.92)
  draw_input("steps_per_second", "Steps/sec", x + 148, y, 100)
  draw_input("x_center", "X center", x, y + 58, 100)
  draw_input("x_spread", "X spread", x + 116, y + 58, 100)
  draw_input("y_center", "Y center", x, y + 116, 100)
  draw_input("y_spread", "Y spread", x + 116, y + 116, 100)
  draw_input("z_center", "Z center", x, y + 174, 100)
  draw_input("z_spread", "Z spread", x + 116, y + 174, 100)
  draw_input("motion_amount", "Motion amount", x, y + 232, 130)
  draw_input("region_name", "Region name", x, y + 290, 220)
  state.clear_existing = draw_toggle("Clear existing", state.clear_existing, x, y + 358)
  state.set_latch = draw_toggle("Track Latch", state.set_latch, x, y + 386)
  state.overwrite_region = draw_toggle("Overwrite region", state.overwrite_region, x, y + 414)
  state.use_z_motion = draw_toggle("Use Z motion", state.use_z_motion, x, y + 442)

  draw_text("Selected " .. source_label(state.selected_source) .. ": " .. motion_label(state.motion_by_source[state.selected_source]), x, y + 486, 0.72, 0.82, 0.78)
  if draw_button("Write Automation + Region", x, y + 522, 230, 42, true, false) then
    write_automation()
  end
end

local function handle_text_input()
  if not state.focus then return end
  local char = ui.char
  if char == 0 then return end
  if char == 27 or char == 13 then
    state.focus = nil
    return
  end

  local text = tostring(state[state.focus] or "")
  if char == 8 then
    state[state.focus] = text:sub(1, -2)
  elseif char >= 32 and char <= 126 then
    state[state.focus] = text .. string.char(char)
  end
end

local function draw()
  draw_rect(0, 0, state.w, state.h, 0.07, 0.08, 0.09, 1, true)
  draw_text("AmbiEncoder64 Motion Map", 18, 18, 0.96, 0.97, 0.97)
  draw_text("Assign one motion shape per source index, then write XYZ automation over the current time selection.", 18, 42, 0.62, 0.66, 0.70)
  draw_source_grid()
  draw_presets()
  draw_settings()
  draw_rect(0, state.h - 34, state.w, 34, 0.09, 0.10, 0.11, 1, true)
  draw_text(state.status, 18, state.h - 23, 0.78, 0.82, 0.84)
end

local function loop()
  ui.mx, ui.my = gfx.mouse_x, gfx.mouse_y
  ui.mouse_down = (gfx.mouse_cap & 1) == 1
  ui.char = gfx.getchar()
  if ui.char < 0 then return end
  handle_text_input()
  draw()
  ui.last_mouse_down = ui.mouse_down
  gfx.update()
  reaper.defer(loop)
end

set_auto_map()
set_source_enabled(1, 64, true)
gfx.init(SCRIPT_NAME, state.w, state.h, 0)
gfx.setfont(1, "Arial", 14)
loop()
