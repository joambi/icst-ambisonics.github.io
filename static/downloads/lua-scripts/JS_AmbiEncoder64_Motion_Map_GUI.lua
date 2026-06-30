-- @description AmbiEncoder64 Motion Map GUI
-- @author JS / Codex
-- @version 2.0
-- @about
--   Improved GUI for assigning motion shapes per ICST AmbiEncoder_64 source index,
--   with live AZ/EL trajectory preview, anti-aliased icons, and color-coded source trails.
--   Writes XYZ automation and a render region via JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua.

local SCRIPT_NAME = "AmbiEncoder64 Motion Map GUI"

-- ── Motion shapes ────────────────────────────────────────────────────────────
local MOTIONS = {
  { id = "line",        label = "Line"  },
  { id = "arc_up",      label = "Arc+"  },
  { id = "arc_down",    label = "Arc-"  },
  { id = "s_curve",     label = "S"     },
  { id = "step",        label = "Step"  },
  { id = "zigzag",      label = "Zig"   },
  { id = "circle",      label = "Circ"  },
  { id = "spiral",      label = "Spir"  },
  { id = "fourier_xyz", label = "Four"  },
  { id = "heart_curve", label = "Hrt"   },
  { id = "cardioid",    label = "Card"  },
  { id = "rose8",       label = "R8"    },
  { id = "bernoulli",   label = "Bern"  },
  { id = "astroid",     label = "Ast"   },
  { id = "epicycloid",  label = "Epi"   },
  { id = "lattice",     label = "Lat"   },
  { id = "lissajous",   label = "Lis"   },
}

-- ── Source color palette (12 colors, RGB 0-1) ────────────────────────────────
local COLORS = {
  { 0.36, 0.83, 0.62 }, -- green
  { 0.29, 0.62, 1.00 }, -- blue
  { 0.96, 0.65, 0.14 }, -- orange
  { 0.91, 0.36, 0.59 }, -- pink
  { 0.65, 0.55, 0.98 }, -- purple
  { 0.20, 0.83, 0.78 }, -- teal
  { 0.98, 0.57, 0.19 }, -- amber
  { 0.64, 0.90, 0.21 }, -- lime
  { 0.96, 0.44, 0.71 }, -- rose
  { 0.38, 0.65, 0.98 }, -- sky
  { 0.98, 0.80, 0.08 }, -- yellow
  { 0.53, 0.93, 0.54 }, -- mint
}

-- ── State ────────────────────────────────────────────────────────────────────
local state = {
  w = 1440,
  h = 1010,
  source_scroll   = 1,
  selected_source = 1,
  motion_by_source = {},
  source_enabled   = {},
  focus = nil,
  steps_per_second = "12",
  scale     = "1",    -- display scale factor (1=unit sphere, 10=10m, 50=50m, 100=100m)
  x_center  = "0.00", -- X center in scale units (−scale..+scale)
  x_spread  = "2.00", -- X total spread in scale units (0..2×scale) — 2.0 = full -1..+1
  y_center  = "0.00", -- Y center in scale units (−scale..+scale; 0=horizon)
  y_spread  = "0.56", -- Y total spread in scale units (0..2×scale)
  z_center  = "0.75", -- Z center in scale units (0..scale)
  z_spread  = "0.35", -- Z total spread in scale units (0..scale)
  motion_amount  = "1.0",
  lattice_rate   = "8.0",
  lattice_smooth = "1.0",
  lattice_bound_x = "0.00",
  lattice_bound_y = "0.00",
  lattice_bound_z = "0.00",
  time_quant_steps = "0.0",
  space_quant_x = "0.00",
  space_quant_y = "0.00",
  space_quant_z = "0.00",
  source_phase   = "0.00", -- temporal offset between sources (0=same pos, 1=evenly spread)
  region_name   = "BFormat_TS",
  clear_existing   = true,
  set_latch        = true,
  overwrite_region = true,
  use_z_motion     = true,
  palindrome          = false,
  time_curve_mode     = "linear",   -- "linear" | "exp" | "log"
  time_curve_amount   = "2.0",      -- exponent n (1 = neutral)
  -- OSC Preview
  osc_host    = "127.0.0.1",
  osc_port    = "9001",
  osc_preview = false,
  preset_name        = "My Preset",
  preset_list_scroll = 0,
  status = "Ready",
}

local ui = {
  mx = 0, my = 0,
  mouse_down = false, last_mouse_down = false,
  char = 0,
}

-- ── Math helpers ─────────────────────────────────────────────────────────────
local function clamp(v, a, b)  return math.max(a, math.min(b, v)) end
-- Palindrome: maps t ∈ [0,1] → 0→1→0 (forward then reverse)
local function palindrome_t(t)
  if not state.palindrome then return t end
  return t < 0.5 and (t * 2.0) or (2.0 - t * 2.0)
end
-- Time curve: warps t after palindrome.
--   linear → identity
--   exp    → t^n  (slow start, fast end;  n>1)
--   log    → t^(1/n) = n-th root  (fast start, slow end; n>1)
local function time_curve_t(t)
  local mode = state.time_curve_mode or "linear"
  if mode == "linear" then return t end
  local n = math.max(1.001, tonumber(state.time_curve_amount) or 2.0)
  if mode == "exp" then return t ^ n end
  return t ^ (1.0 / n)  -- log / n-th root
end
-- Combined transform applied to every raw animation t ∈ [0,1]
local function transform_t(raw_t)
  return time_curve_t(palindrome_t(raw_t))
end
local function smoothstep(t)   return t * t * (3 - 2 * t) end
local function tri(p)
  local w = p - math.floor(p)
  return w < 0.5 and w * 4 - 1 or 3 - w * 4
end
local function wrapDeg(v)
  while v < -180 do v = v + 360 end
  while v >  180 do v = v - 360 end
  return v
end

-- Wrap elevation to [-90, +90], flipping az by 180° when crossing zenith or nadir.
-- Enables full vertical orbits when el_spread > 180°.
local function wrap_el_az(el, az)
  while el > 180  do el = el - 360 end
  while el < -180 do el = el + 360 end
  if el > 90 then
    el = 180 - el   -- reflect over zenith
    az = az + 180
  elseif el < -90 then
    el = -180 - el  -- reflect over nadir
    az = az + 180
  end
  return el, wrapDeg(az)
end
local function fourierSum(t, phase, terms)
  local sum, wsum = 0, 0
  for _, term in ipairs(terms) do
    local w, f, ph = term[1], term[2], (term[3] or 0)
    sum  = sum  + w * math.sin(math.pi * 2 * (f * t + phase + ph))
    wsum = wsum + math.abs(w)
  end
  return wsum < 1e-6 and 0 or clamp(sum / wsum, -1, 1)
end

local function centered_wrap(value, bound)
  if bound <= 0.000001 then return value end
  local span = bound * 2
  local shifted = (value + bound) % span
  if shifted < 0 then shifted = shifted + span end
  return shifted - bound
end

local function lattice_step_progress(t, rate, smooth)
  if rate <= 0.000001 then return 0 end
  local raw = t * rate
  local step_index = math.floor(raw)
  local frac = raw - step_index
  local blend = clamp(smooth or 0, 0, 1)
  if blend <= 0.000001 then
    return step_index
  end
  return step_index + smoothstep(frac) * blend
end

local function quantize_progress(t, steps)
  if steps <= 0.000001 then return t end
  local scaled = t * steps
  return math.floor(scaled) / steps
end

local function quantize_value(value, quantum)
  if quantum <= 0.000001 then return value end
  return math.floor((value / quantum) + 0.5) * quantum
end

local function parametric_shape_xy(shape, t)
  local angle = math.pi * 2 * t
  if shape == "heart_curve" then
    local s = math.sin(angle)
    local c = math.cos(angle)
    return (16 * s * s * s) / 18, (13 * c - 5 * math.cos(2 * angle) - 2 * math.cos(3 * angle) - math.cos(4 * angle)) / 18
  elseif shape == "cardioid" then
    local r = 0.5 * (1 - math.sin(angle))
    return r * math.cos(angle), r * math.sin(angle)
  elseif shape == "rose8" then
    local r = math.cos(4 * angle)
    return r * math.cos(angle), r * math.sin(angle)
  elseif shape == "bernoulli" then
    local s = math.sin(angle)
    local c = math.cos(angle)
    local denom = 1 + s * s
    return c / denom, (s * c) / denom
  elseif shape == "astroid" then
    return math.cos(angle) ^ 3, math.sin(angle) ^ 3
  elseif shape == "epicycloid" then
    return (5 * math.cos(angle) - math.cos(5 * angle)) / 6, (5 * math.sin(angle) - math.sin(5 * angle)) / 6
  end
  return nil, nil
end

local function parametric_shape_z(shape, t, phase)
  local shifted = t + phase
  local two_pi = math.pi * 2
  if shape == "heart_curve" then
    return math.sin(two_pi * shifted)
  elseif shape == "cardioid" then
    return math.cos(two_pi * shifted)
  elseif shape == "rose8" then
    return math.sin(two_pi * 4 * shifted) * 0.85
  elseif shape == "bernoulli" then
    return math.cos(two_pi * 2 * shifted) * 0.75
  elseif shape == "astroid" then
    return math.sin(two_pi * 3 * shifted) * 0.65
  elseif shape == "epicycloid" then
    return math.sin(two_pi * 5 * shifted) * 0.85
  end
  return nil
end

-- Compute raw AED (azimuth°, elevation°, distance 0-1) for a motion shape.
-- These values mirror the writer's intent in "linear-AED" space:
--   az maps linearly to X_norm via: X_norm = 0.5 + az/360  (writer formula)
--   el maps linearly to Y_norm via: Y_norm = 0.5 + el/180  (writer formula)
--   d  is written directly as Z_norm.
-- NOTE: Do NOT send az/el directly via OSC. The AmbiEncoder receives AED via
-- OSC and converts to Cartesian using sin/cos, producing a spherical arc — not
-- the straight path the writer creates with its linear X/Y mapping. Use
-- toOscAED() to convert az/el/d to the correct OSC values before sending.
local function computeAED(shape, t, src_idx, n_active, p)
  local pi2   = math.pi * 2
  local phase = src_idx / math.max(1, n_active)
  -- Temporal offset: spread sources along the trajectory (0=same pos, 1=evenly distributed)
  local src_spread = p.src_spread or 0
  local t_src = (t + phase * src_spread) % 1.0
  t_src = quantize_progress(t_src, p.time_quant_steps or 0)

  local az_a  = p.az_spr * 0.5
  local el_a  = p.el_spr * 0.5
  local z_a   = p.use_z and p.z_spr * 0.5 or 0
  local az, el, d = p.az_cen, p.el_cen, p.z_cen
  local px, py = parametric_shape_xy(shape, t_src)

  if px ~= nil and py ~= nil then
    az = p.az_cen + az_a * px
    el = p.el_cen + el_a * py
    local pz = parametric_shape_z(shape, t_src, phase)
    if pz then d = p.z_cen + z_a * pz end
  elseif shape == "lattice" then
    local step_progress = lattice_step_progress(t_src, p.lattice_rate or 8.0, p.lattice_smooth or 1.0)
    local dx = centered_wrap(p.az_spr * step_progress, p.lattice_bound_x or 0)
    local dy = centered_wrap(p.el_spr * step_progress, p.lattice_bound_y or 0)
    local dz = centered_wrap(p.z_spr * step_progress, p.lattice_bound_z or 0)
    az = p.az_cen + dx
    el = p.el_cen + dy
    d  = p.z_cen + dz
  elseif shape == "line" then
    az = p.az_cen - az_a + p.az_spr * t_src
    el = p.el_cen - el_a + p.el_spr * t_src
  elseif shape == "arc_up" then
    local e = smoothstep(t_src)
    az = p.az_cen - az_a + p.az_spr * e
    el = p.el_cen + el_a * math.sin(math.pi * t_src)
    d  = p.z_cen  + z_a  * math.sin(math.pi * t_src)
  elseif shape == "arc_down" then
    local e = smoothstep(t_src)
    az = p.az_cen - az_a + p.az_spr * e
    el = p.el_cen - el_a * math.sin(math.pi * t_src)
    d  = p.z_cen  - z_a  * math.sin(math.pi * t_src)
  elseif shape == "s_curve" then
    local e = smoothstep(t_src)
    az = p.az_cen - az_a + p.az_spr * e
    el = p.el_cen + el_a * math.sin(pi2 * (t_src - 0.25))
    d  = p.z_cen  + z_a  * math.sin(pi2 * e)
  elseif shape == "step" then
    local steps   = 4
    local stepped = t_src >= 1 and 1 or math.floor(t_src * steps) / steps
    az = p.az_cen - az_a + p.az_spr * stepped
    el = p.el_cen + el_a * tri(stepped + phase)
    d  = p.z_cen  + z_a  * tri(stepped * 2 + phase)
  elseif shape == "zigzag" then
    az = p.az_cen + az_a * tri(t_src * 4 + phase)
    el = p.el_cen + el_a * tri(t_src * 2 + phase + 0.25)
  elseif shape == "circle" then
    local p_norm = math.min(az_a / 180, el_a / 90)
    az = p.az_cen + p_norm * 180 * math.cos(pi2 * (t_src + phase))
    el = p.el_cen + p_norm *  90 * math.sin(pi2 * (t_src + phase))
    d  = p.z_cen  + z_a  * math.sin(pi2 * (t_src * 0.5 + phase))
  elseif shape == "spiral" then
    local sw     = smoothstep(t_src)
    local p_norm = math.min(az_a / 180, el_a / 90)
    local r_t    = p_norm * (0.15 + 0.85 * t_src)
    az = p.az_cen + r_t * 180 * math.cos(pi2 * (sw + phase))
    el = p.el_cen + r_t *  90 * math.sin(pi2 * (sw + phase))
    d  = p.z_cen  - z_a  + p.z_spr * t_src
  elseif shape == "fourier_xyz" then
    az = p.az_cen + az_a * fourierSum(t_src, phase, {{1,1,0},{0.55,2,0.18},{0.30,3,0.41},{0.18,5,0.07}})
    el = p.el_cen + el_a * fourierSum(t_src, phase, {{1,1,0.25},{0.50,3,0.02},{0.28,4,0.33},{0.15,6,0.11}})
    d  = p.z_cen  + z_a  * fourierSum(t_src, phase, {{1,1,0.125},{0.42,2,0.36},{0.24,5,0.19}})
  elseif shape == "lissajous" then
    az = p.az_cen + az_a * math.sin(pi2 * (t_src + phase))
    el = p.el_cen + el_a * math.sin(pi2 * (t_src * 2 + phase))
    d  = p.z_cen  + z_a  * math.cos(pi2 * (t_src + phase))
  end

  az = quantize_value(az, p.space_quant_x or 0)
  el = quantize_value(el, p.space_quant_y or 0)
  d  = quantize_value(d, p.space_quant_z or 0)

  local el_w, az_w = wrap_el_az(el, az)
  return az_w, el_w, clamp(d, 0, 1)
end

-- Convert computeAED output → true AED for OSC so the AmbiEncoder displays
-- the same Cartesian path as the written automation.
--
-- The writer stores the source position as three Cartesian coordinates:
--   X_cart = az / 180       (linear, not sin!)
--   Y_cart = el / 90        (linear, not sin!)
--   Z_cart = 2 * d - 1      (maps Z_norm∈[0,1] to Cartesian Z∈[-1,+1])
--
-- The AmbiEncoder converts incoming OSC AED to Cartesian as:
--   X = sin(az_osc) * cos(el_osc) * dist_osc
--   Y = cos(az_osc) * cos(el_osc) * dist_osc
--   Z = sin(el_osc) * dist_osc
--
-- Solving for az_osc / el_osc / dist_osc that reproduce the writer's Cartesian:
--   dist_osc = sqrt(X_cart² + Y_cart² + Z_cart²)
--   az_osc   = atan2(X_cart, Y_cart)    (angle from front toward right)
--   el_osc   = asin(Z_cart / dist_osc)
local function toOscAED(az, el, d)
  local x = az / 180          -- writer's linear X_cart
  local y = el / 90           -- writer's linear Y_cart
  local z = 2.0 * d - 1.0    -- writer's Z_cart (from Z_norm = d)
  local r = math.sqrt(x*x + y*y + z*z)
  if r < 1e-9 then return 0, 0, 0 end
  local az_osc   = math.deg(math.atan(x, y))      -- atan2(x,y): angle from Y toward X
  local el_osc   = math.deg(math.asin(z / r))
  local dist_osc = r
  return wrapDeg(az_osc), clamp(el_osc, -90, 90), dist_osc
end

-- ── File helpers ─────────────────────────────────────────────────────────────
local function script_dir()
  local _, path = reaper.get_action_context()
  return path:match("^(.*)[/\\][^/\\]+$") or "."
end
local function join_path(left, right)
  local sep = package.config:sub(1, 1)
  if left:sub(-1) == "/" or left:sub(-1) == "\\" then return left .. right end
  return left .. sep .. right
end
local function writer_path()
  return join_path(script_dir(), "JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua")
end
local function file_exists(path)
  local f = io.open(path, "r")
  if f then f:close() return true end
  return false
end

-- ── Preset system ─────────────────────────────────────────────────────────────
local PRESET_EXT = "AmbiMotionMap_v2"

local function preset_serialize()
  -- shapes: only sources with an assigned shape
  local shp = {}
  for s = 1, 64 do
    if state.motion_by_source[s] then
      shp[#shp + 1] = s .. ":" .. state.motion_by_source[s]
    end
  end
  -- enabled sources
  local enb = {}
  for s = 1, 64 do
    if state.source_enabled[s] then enb[#enb + 1] = s end
  end
  local function b(v) return v and "1" or "0" end
  return table.concat({
    "fmt=4",   -- coordinate format version: 4 = XYZ ±scale units (direct Cartesian)
    "scale="   .. tostring(state.scale or "1"),
    "steps="   .. tostring(state.steps_per_second),
    "motion="  .. tostring(state.motion_amount),
    "az_cen="  .. tostring(state.x_center),
    "az_spr="  .. tostring(state.x_spread),
    "el_cen="  .. tostring(state.y_center),
    "el_spr="  .. tostring(state.y_spread),
    "z_cen="   .. tostring(state.z_center),
    "z_spr="   .. tostring(state.z_spread),
    "tc_mode=" .. tostring(state.time_curve_mode),
    "tc_n="    .. tostring(state.time_curve_amount),
    "src_ph="  .. tostring(state.source_phase),
    "lat_rate=" .. tostring(state.lattice_rate),
    "lat_smooth=" .. tostring(state.lattice_smooth),
    "lat_bx="  .. tostring(state.lattice_bound_x),
    "lat_by="  .. tostring(state.lattice_bound_y),
    "lat_bz="  .. tostring(state.lattice_bound_z),
    "q_t="     .. tostring(state.time_quant_steps),
    "q_x="     .. tostring(state.space_quant_x),
    "q_y="     .. tostring(state.space_quant_y),
    "q_z="     .. tostring(state.space_quant_z),
    "palin="   .. b(state.palindrome),
    "use_z="   .. b(state.use_z_motion),
    "clear="   .. b(state.clear_existing),
    "latch="   .. b(state.set_latch),
    "overwrite=" .. b(state.overwrite_region),
    "region="  .. tostring(state.region_name),
    "shapes="  .. table.concat(shp, ";"),
    "enabled=" .. table.concat(enb, ";"),
  }, "&")
end

local function preset_deserialize(str)
  local function bv(v) return v == "1" end
  -- First pass: detect format version
  -- fmt=2 = Az −180..+180°, El −90..+90°, Z 0..1 (original)
  -- fmt=3 = Az 0..360°, El 0..360° (90=horizon), Z 0..100m (intermediate)
  -- fmt=4 = XYZ ±scale units, direct Cartesian (current)
  local fmt = 2
  for pair in str:gmatch("[^&]+") do
    local k, v = pair:match("^([^=]+)=(.*)$")
    if k == "fmt" then fmt = tonumber(v) or 2; break end
  end
  -- Reset scale to unit sphere when loading older presets
  if fmt < 4 then state.scale = "1" end
  -- Second pass: load values (migrating from older formats to fmt=4 XYZ@Scale=1)
  for pair in str:gmatch("[^&]+") do
    local k, v = pair:match("^([^=]+)=(.*)$")
    if k == "steps"     then state.steps_per_second  = v
    elseif k == "motion"  then state.motion_amount    = v
    elseif k == "scale"   then state.scale            = v
    elseif k == "az_cen"  then
      local n = tonumber(v) or 0
      if fmt == 3 then
        n = (n > 180 and n - 360 or n) / 180   -- 0-360° Az → X unit sphere
      elseif fmt == 2 then
        n = n / 180                              -- ±180° Az → X unit sphere
      end
      state.x_center = string.format("%.4f", n)
    elseif k == "az_spr"  then
      local n = tonumber(v) or 0
      if fmt < 4 then n = n / 180 end           -- degrees total → X units total span
      state.x_spread = string.format("%.4f", n)
    elseif k == "el_cen"  then
      local n = tonumber(v) or 0
      if fmt == 3 then
        n = (n - 90) / 90                       -- 0-360° El (90=horizon) → Y unit sphere
      elseif fmt == 2 then
        n = n / 90                               -- ±90° El → Y unit sphere
      end
      state.y_center = string.format("%.4f", n)
    elseif k == "el_spr"  then
      local n = tonumber(v) or 0
      if fmt < 4 then n = n / 90 end            -- degrees total → Y units total span
      state.y_spread = string.format("%.4f", n)
    elseif k == "z_cen"   then
      local n = tonumber(v) or 0
      if fmt == 3 then n = n / 100 end          -- 0-100m → 0-1 (unit sphere)
      state.z_center = string.format("%.4f", n)
    elseif k == "z_spr"   then
      local n = tonumber(v) or 0
      if fmt == 3 then n = n / 100 end
      state.z_spread = string.format("%.4f", n)
    elseif k == "src_ph"  then state.source_phase      = v
    elseif k == "lat_rate" then state.lattice_rate     = v
    elseif k == "lat_smooth" then state.lattice_smooth = v
    elseif k == "lat_bx"  then state.lattice_bound_x   = v
    elseif k == "lat_by"  then state.lattice_bound_y   = v
    elseif k == "lat_bz"  then state.lattice_bound_z   = v
    elseif k == "q_t"     then state.time_quant_steps  = v
    elseif k == "q_x"     then state.space_quant_x     = v
    elseif k == "q_y"     then state.space_quant_y     = v
    elseif k == "q_z"     then state.space_quant_z     = v
    elseif k == "tc_mode" then state.time_curve_mode  = v
    elseif k == "tc_n"    then state.time_curve_amount = v
    elseif k == "palin"   then state.palindrome       = bv(v)
    elseif k == "use_z"   then state.use_z_motion     = bv(v)
    elseif k == "clear"   then state.clear_existing   = bv(v)
    elseif k == "latch"   then state.set_latch        = bv(v)
    elseif k == "overwrite" then state.overwrite_region = bv(v)
    elseif k == "region"  then state.region_name      = v
    elseif k == "shapes"  then
      state.motion_by_source = {}
      for entry in v:gmatch("[^;]+") do
        local idx, shape = entry:match("^(%d+):(.+)$")
        if idx then state.motion_by_source[tonumber(idx)] = shape end
      end
    elseif k == "enabled" then
      state.source_enabled = {}
      for idx in v:gmatch("[^;]+") do
        local n = tonumber(idx)
        if n then state.source_enabled[n] = true end
      end
    end
  end
end

local function preset_list_get()
  local raw = reaper.GetExtState(PRESET_EXT, "list")
  if raw == "" then return {} end
  local list = {}
  for name in (raw .. ","):gmatch("([^,]*),") do
    if name ~= "" then list[#list + 1] = name end
  end
  return list
end

local function preset_list_set(list)
  reaper.SetExtState(PRESET_EXT, "list", table.concat(list, ","), true)
end

local function preset_save(name)
  if name == "" then return end
  local list = preset_list_get()
  local found = false
  for _, n in ipairs(list) do if n == name then found = true; break end end
  if not found then list[#list + 1] = name end
  preset_list_set(list)
  reaper.SetExtState(PRESET_EXT, "p_" .. name, preset_serialize(), true)
  state.status = "Preset saved: " .. name
end

local function preset_load(name)
  local data = reaper.GetExtState(PRESET_EXT, "p_" .. name)
  if data == "" then state.status = "Preset not found: " .. name; return end
  preset_deserialize(data)
  state.preset_name = name
  state.status = "Preset loaded: " .. name
end

local function preset_delete(name)
  local list = preset_list_get()
  local new_list = {}
  for _, n in ipairs(list) do if n ~= name then new_list[#new_list + 1] = n end end
  preset_list_set(new_list)
  reaper.DeleteExtState(PRESET_EXT, "p_" .. name, true)
  state.status = "Preset deleted: " .. name
end

-- ── OSC via Python subprocess (no external Lua libs needed) ──────────────────
-- Spawns a tiny persistent Python3 UDP sender; communicates via stdin pipe.
-- OSC packet: /icst/ambi/sourceindex/aed  [int idx]  [float az]  [float el]  [float dist]

local _pipe       = nil   -- io.popen write-pipe to python helper
local _osc_ok     = false
local _osc_err    = "not connected"
local _osc_last_t = 0     -- throttle to ~30 Hz
local _scale_committed = state.scale  -- last confirmed scale; rescale triggers on change

-- Python helper script written to /tmp at connect time
local PYTHON_HELPER = [[
import sys, socket, struct

def build(idx, az, el, dist):
    addr = b'/icst/ambi/sourceindex/aed\x00\x00'   # 28 bytes
    tag  = b',ifff\x00\x00\x00'                    # 8 bytes
    data = struct.pack('!ifff', idx, az, el, dist)  # 16 bytes
    return addr + tag + data

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
# -u flag (unbuffered) handles stdout; force line-buffered stdin explicitly
while True:
    try:
        line = sys.stdin.readline()
    except Exception:
        break
    if not line:
        break
    line = line.strip()
    if line == 'quit':
        break
    if not line:
        continue
    parts = line.split()
    if len(parts) >= 5:
        try:
            s.sendto(build(int(parts[2]), float(parts[3]), float(parts[4]),
                           float(parts[5]) if len(parts) > 5 else 0.75),
                     (parts[0], int(parts[1])))
        except Exception:
            pass
]]

local function _write_helper()
  local tmp  = (os.getenv("TMPDIR") or "/tmp"):gsub("/$","")
  local path = tmp .. "/reaper_ambi_osc.py"
  local f = io.open(path, "w")
  if not f then return nil, "Cannot write " .. path end
  f:write(PYTHON_HELPER)
  f:close()
  return path
end

local function osc_init()
  _pipe   = nil
  _osc_ok = false
  local path, err = _write_helper()
  if not path then _osc_err = err; state.status = "OSC: " .. err; return end
  -- try python3 first, fall back to python
  -- -u = unbuffered: Python processes each line immediately, no 8KB buffer wait
  local cmd = "python3 -u " .. path .. " 2>/dev/null"
  local pipe = io.popen(cmd, "w")
  if not pipe then
    cmd  = "python -u " .. path .. " 2>/dev/null"
    pipe = io.popen(cmd, "w")
  end
  if not pipe then
    _osc_err = "python3 not found"
    state.status = "OSC: " .. _osc_err
    return
  end
  _pipe   = pipe
  _osc_ok = true
  _osc_err = ""
  -- send a test packet to source 1 at center (verifies pipe is alive)
  local host = state.osc_host or "127.0.0.1"
  local port = tonumber(state.osc_port) or 9001
  pcall(function()
    _pipe:write(string.format("%s %d 1 0.0 0.0 0.75\n", host, port))
    _pipe:flush()
  end)
  state.status = string.format("OSC ▶ %s:%s — connected (python3 -u)",
    host, port)
end

local function osc_close()
  if _pipe then
    pcall(function() _pipe:write("quit\n"); _pipe:flush(); _pipe:close() end)
    _pipe = nil
  end
  _osc_ok = false
  _osc_err = "disconnected"
  state.status = "OSC disconnected"
end

-- Send preview positions for all enabled sources at current animation phase
local function osc_send_preview()
  if not _osc_ok or not _pipe then return end
  local now = reaper.time_precise()
  if now - _osc_last_t < 0.033 then return end   -- ~30 Hz
  _osc_last_t = now
  local anim_t = transform_t((now * 0.28) % 1.0)
  -- inline params (preview_params() is defined later as a local)
  -- Convert XYZ scale-unit values → internal (az/el degrees, z 0-1)
  local _s = math.max(0.001, tonumber(state.scale) or 1.0)
  local params = {
    az_cen     = (tonumber(state.x_center) or 0)    * 180 / _s,
    az_spr     = (tonumber(state.x_spread) or 2.0) * 180 / _s,
    el_cen     = (tonumber(state.y_center) or 0)    *  90 / _s,
    el_spr     = (tonumber(state.y_spread) or 0.56) *  90 / _s,
    z_cen      = (tonumber(state.z_center) or 0.75) /  _s,
    z_spr      = (tonumber(state.z_spread) or 0.35) /  _s,
    use_z      = state.use_z_motion,
    src_spread = tonumber(state.source_phase) or 0,
  }
  local enabled = {}
  for s = 1, 64 do
    if state.source_enabled[s] then enabled[#enabled + 1] = s end
  end
  local n    = #enabled
  local host = state.osc_host or "127.0.0.1"
  local port = tonumber(state.osc_port) or 9001
  local ok   = true
  for _, src in ipairs(enabled) do
    local shape             = state.motion_by_source[src] or "line"
    local az0, el0, dist0   = computeAED(shape, anim_t, src - 1, n, params)
    -- Convert from writer's linear Cartesian space to true AED for OSC.
    -- Sending az0 directly would make the encoder use sin(az0) → spherical arc.
    -- toOscAED() produces az/el/dist that reproduces the same Cartesian position
    -- as the written automation (X_norm = 0.5 + az/360, Y_norm = 0.5 + el/180).
    local az, el, dist      = toOscAED(az0, el0, dist0)
    dist = dist * (tonumber(state.scale) or 1.0)   -- Scale to physical meters
    local line = string.format("%s %d %d %.3f %.3f %.4f\n",
                               host, port, src, az, el, dist)
    ok = ok and pcall(function() _pipe:write(line); _pipe:flush() end)
  end
  if not ok then
    _osc_ok  = false
    _osc_err = "pipe error – reconnect"
    state.osc_preview = false
  end
end

-- ── GFX primitives ───────────────────────────────────────────────────────────
local function draw_rect(x, y, w, h, r, g, b, a, filled)
  gfx.set(r, g, b, a or 1)
  gfx.rect(x, y, w, h, filled and 1 or 0)
end

local function draw_text(text, x, y, r, g, b, a)
  gfx.set(r or 0.88, g or 0.90, b or 0.92, a or 1)
  gfx.x = x; gfx.y = y
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
  local r, g, b = 0.11, 0.13, 0.16
  if active   then r, g, b = 0.14, 0.29, 0.22 end
  if disabled then r, g, b = 0.08, 0.09, 0.10 end
  if hover    then r, g, b = r + 0.05, g + 0.06, b + 0.07 end
  draw_rect(x, y, w, h, r, g, b, 1, true)
  local br, bg, bb = active and 0.36 or 0.24, active and 0.74 or 0.30, active and 0.52 or 0.36
  draw_rect(x, y, w, h, br, bg, bb, disabled and 0.30 or 1, false)
  if label and label ~= "" then
    local tw, th = gfx.measurestr(label)
    draw_text(label, x + (w - tw) / 2, y + (h - th) / 2 + 1,
              disabled and 0.40 or 0.88, disabled and 0.42 or 0.90,
              disabled and 0.44 or 0.92)
  end
  return not disabled and mouse_clicked(x, y, w, h)
end

local function draw_toggle(label, value, x, y)
  local size = 16
  local clicked = mouse_clicked(x, y, size, size) or mouse_clicked(x + 22, y - 2, 170, 20)
  if clicked then value = not value end
  draw_rect(x, y, size, size, 0.09, 0.10, 0.12, 1, true)
  draw_rect(x, y, size, size, 0.28, 0.38, 0.30, 1, false)
  if value then
    draw_rect(x + 3, y + 3, size - 6, size - 6, 0.36, 0.83, 0.62, 1, true)
  end
  draw_text(label, x + 22, y + 2, 0.72, 0.78, 0.76)
  return value
end

local function draw_input(id, label, x, y, w)
  draw_text(label, x, y, 0.56, 0.62, 0.66)
  local box_y = y + 16
  local active = state.focus == id
  if mouse_clicked(x, box_y, w, 22) then state.focus = id; active = true end
  draw_rect(x, box_y, w, 22, active and 0.10 or 0.07, active and 0.14 or 0.09,
            active and 0.16 or 0.11, 1, true)
  draw_rect(x, box_y, w, 22, active and 0.34 or 0.22, active and 0.70 or 0.28,
            active and 0.52 or 0.30, 1, false)
  local text = tostring(state[id] or "")
  if active and math.floor(reaper.time_precise() * 2) % 2 == 0 then text = text .. "|" end
  draw_text(text, x + 6, box_y + 5)
end

-- ── Slider widget ─────────────────────────────────────────────────────────────
-- Horizontal slider with value text on the right.
--   id      = state key (e.g. "x_center")
--   label   = label text drawn above the track
--   x,y,w   = position / total width (label + track + value share this width)
--   min_v, max_v = value range
--   is_int  = true → format/snap to integer, false → 2-decimal float
-- Interaction:
--   Drag track → change value (hold Shift for 10× slower fine-tune)
--   Click value text (right side) → enter text edit mode (type exact value)
local _sld = { id = nil, sx = 0, sv = 0 }   -- active drag state

local function draw_slider(id, label, x, y, w, min_v, max_v, is_int)
  local VAL_W   = 46            -- pixels reserved on the right for the value text
  local track_w = w - VAL_W
  local bx, by, bh = x, y + 16, 22
  local active = (state.focus == id)
  local shift  = (gfx.mouse_cap & 8) == 8

  -- clamp + parse current value
  local val = math.max(min_v, math.min(max_v, tonumber(state[id]) or min_v))

  -- ── drag continuation ──────────────────────────────────────────────────────
  if _sld.id == id then
    if ui.mouse_down then
      local speed = shift and 0.1 or 1.0
      local dv    = (ui.mx - _sld.sx) / track_w * (max_v - min_v) * speed
      local nv    = math.max(min_v, math.min(max_v, _sld.sv + dv))
      if is_int then nv = math.floor(nv + 0.5) end
      state[id] = is_int and tostring(math.floor(nv + 0.5))
                          or string.format("%.2f", nv)
      val = tonumber(state[id])
    else
      _sld.id = nil
    end
  end

  -- ── click handling ─────────────────────────────────────────────────────────
  local in_track = rect_hit(bx, by, track_w, bh)
  local in_value = rect_hit(bx + track_w, by, VAL_W, bh)
  if ui.mouse_down and not ui.last_mouse_down then
    if in_track then
      state.focus = nil; active = false   -- leave text mode
      if _sld.id == nil then
        _sld = { id = id, sx = ui.mx, sv = val }
      end
    elseif in_value then
      state.focus = id; active = true
    end
  end

  -- ── draw ───────────────────────────────────────────────────────────────────
  local norm = (max_v > min_v) and ((val - min_v) / (max_v - min_v)) or 0
  local fill = math.max(0, math.min(track_w, math.floor(norm * track_w)))

  draw_text(label, x, y, 0.56, 0.62, 0.66)          -- label above

  draw_rect(bx, by, w, bh, 0.07, 0.09, 0.11, 1, true)   -- bg
  if fill > 0 then                                        -- filled portion
    draw_rect(bx, by, fill, bh,
              active and 0.14 or 0.11,
              active and 0.30 or 0.22,
              active and 0.24 or 0.17, 1, true)
  end
  draw_rect(bx + fill, by, 2, bh, 0.36, 0.83, 0.62, 1, true)  -- handle
  draw_rect(bx + track_w, by, 1, bh, 0.18, 0.22, 0.26, 1, true) -- divider
  draw_rect(bx, by, w, bh,                                      -- border
            active and 0.34 or 0.22, active and 0.70 or 0.28,
            active and 0.52 or 0.30, 1, false)

  -- value / cursor text (right zone, right-aligned)
  local disp
  if active then
    disp = tostring(state[id] or "")
    if math.floor(reaper.time_precise() * 2) % 2 == 0 then disp = disp .. "|" end
  else
    disp = is_int and tostring(math.floor(val + 0.5))
                  or  string.format("%.2f", val)
  end
  local tw = gfx.measurestr(disp)
  draw_text(disp, bx + w - tw - 5, by + 5)
end

-- ── Motion icon shapes ───────────────────────────────────────────────────────
-- Fixed, normalised icon paths independent of user spread settings.
-- Returns (az, el) in roughly [-0.5, +0.5] range; auto-fit handles scaling.
local ICON_STEPS = 64

local function icon_path(shape, t)
  local pi  = math.pi
  local pi2 = math.pi * 2

  if shape == "line" then
    return t - 0.5, t - 0.5

  elseif shape == "arc_up" then
    return t - 0.5, math.sin(pi * t) * 0.5

  elseif shape == "arc_down" then
    return t - 0.5, -math.sin(pi * t) * 0.5

  elseif shape == "s_curve" then
    return t - 0.5, math.sin(pi2 * (t - 0.25)) * 0.45

  elseif shape == "step" then
    local steps  = 4
    local st     = t >= 1 and 1.0 or math.floor(t * steps) / steps
    local idx    = math.min(math.floor(t * steps), steps - 1)
    return st - 0.5, (idx / (steps - 1) - 0.5) * 0.9

  elseif shape == "zigzag" then
    return tri(t * 3 + 0.5) * 0.5, tri(t * 1.5 + 0.25) * 0.48

  elseif shape == "circle" then
    -- True ellipse
    return math.cos(pi2 * t) * 0.5, math.sin(pi2 * t) * 0.45

  elseif shape == "spiral" then
    -- Growing spiral, 2.5 turns
    local r = (0.08 + 0.92 * t) * 0.5
    local a = pi2 * (t * 2.5 + 0.5)
    return r * math.cos(a), r * math.sin(a) * 0.85

  elseif shape == "fourier_xyz" then
    return fourierSum(t, 0, {{1,1,0},{0.55,2,0.18},{0.30,3,0.41},{0.18,5,0.07}}) * 0.5,
           fourierSum(t, 0, {{1,1,0.25},{0.50,3,0.02},{0.28,4,0.33},{0.15,6,0.11}}) * 0.45

  elseif shape == "lattice" then
    local sx = centered_wrap(lattice_step_progress(t, tonumber(state.lattice_rate) or 8.0, tonumber(state.lattice_smooth) or 1.0), tonumber(state.lattice_bound_x) or 0)
    local sy = centered_wrap(lattice_step_progress(t, tonumber(state.lattice_rate) or 8.0, tonumber(state.lattice_smooth) or 1.0) * 0.56, tonumber(state.lattice_bound_y) or 0)
    return sx * 0.18, sy * 0.18

  elseif shape == "heart_curve" then
    local x, y = parametric_shape_xy(shape, t)
    return x * 0.90, y * 0.82 - 0.03

  elseif shape == "cardioid" then
    local a = pi2 * t
    local r = 0.34 * (1 - math.sin(a))
    return r * math.cos(a), r * math.sin(a) * 0.92 - 0.02

  elseif shape == "rose8" then
    local a = pi2 * t
    local r = 0.34 * math.cos(4 * a)
    return r * math.cos(a), r * math.sin(a) * 0.92

  elseif shape == "bernoulli" then
    return math.sin(pi2 * t) * 0.42, math.sin(pi2 * t) * math.cos(pi2 * t) * 0.66

  elseif shape == "astroid" then
    local a = pi2 * t
    return (math.cos(a) ^ 3) * 0.46, (math.sin(a) ^ 3) * 0.46

  elseif shape == "epicycloid" then
    local a = pi2 * t
    return (2 * math.cos(a) - math.cos(2 * a)) * 0.18, (2 * math.sin(a) - math.sin(2 * a)) * 0.18

  elseif shape == "lissajous" then
    -- Figure-8: 1:2 Lissajous
    return math.sin(pi2 * t) * 0.5, math.sin(pi2 * t * 2 + 0.5) * 0.45
  end

  return t - 0.5, 0
end

local function draw_motion_icon(id, x, y, w, h, active, enabled)
  local pad   = 4
  local left  = x + pad
  local right = x + w - pad
  local mid_y = y + h / 2
  local dim   = enabled and 1 or 0.42
  local ir    = (active and 0.36 or 0.28) * dim
  local ig    = (active and 0.83 or 0.42) * dim
  local ib    = (active and 0.62 or 0.50) * dim
  gfx.set(ir, ig, ib, 1)

  -- Collect all points (normalised icon coords) and auto-fit
  local pts = {}
  local min_az, max_az = math.huge, -math.huge
  local min_el, max_el = math.huge, -math.huge
  for i = 0, ICON_STEPS do
    local t = i / ICON_STEPS
    local az, el = icon_path(id, t)
    pts[#pts + 1] = { az = az, el = el }
    if az < min_az then min_az = az end
    if az > max_az then max_az = az end
    if el < min_el then min_el = el end
    if el > max_el then max_el = el end
  end

  local span_az = math.max(0.01, max_az - min_az)
  local span_el = math.max(0.01, max_el - min_el)
  local ctr_az  = (min_az + max_az) * 0.5
  local ctr_el  = (min_el + max_el) * 0.5
  local cell_w  = right - left
  local cell_h  = (h - pad * 2) * 0.9

  local function to_px(az, el)
    local px = left + cell_w * 0.5 + (az - ctr_az) / span_az * cell_w * 0.9
    local py = mid_y             - (el - ctr_el) / span_el * cell_h * 0.5
    return px, py
  end

  -- Draw path
  local prev_px, prev_py
  for _, pt in ipairs(pts) do
    local px, py = to_px(pt.az, pt.el)
    if prev_px then gfx.line(prev_px, prev_py, px, py, 1) end
    prev_px, prev_py = px, py
  end

  -- Start dot (filled)
  local sx, sy = to_px(pts[1].az, pts[1].el)
  gfx.circle(sx, sy, active and 2.8 or 1.8, true, true)

  -- End dot (hollow ring) for active shape
  if active then
    local ex, ey = to_px(pts[#pts].az, pts[#pts].el)
    gfx.set(ir * 1.4, ig * 1.4, ib * 1.2, 0.9)
    gfx.circle(ex, ey, 2.2, false, true)
  end
end

-- ── Source grid ──────────────────────────────────────────────────────────────
local GRID_X   = 18
local GRID_Y   = 104
local ROW_H    = 36
local ENABLE_W = 38
local SOURCE_W = 58
local CELL_W   = 42
local MAX_ROWS = 14

local function draw_source_grid()
  -- Column headers
  gfx.setfont(2, "Arial", 13)
  draw_text("On",     GRID_X + 2,                             GRID_Y - 22, 0.54, 0.60, 0.66)
  draw_text("Src",    GRID_X + ENABLE_W + 4,                  GRID_Y - 22, 0.54, 0.60, 0.66)
  for i, m in ipairs(MOTIONS) do
    local hx = GRID_X + ENABLE_W + SOURCE_W + (i - 1) * CELL_W + 6
    draw_text(m.label, hx, GRID_Y - 22, 0.54, 0.60, 0.66)
  end
  gfx.setfont(1, "Arial", 16)

  state.source_scroll = clamp(state.source_scroll, 1, 64 - MAX_ROWS + 1)

  for row = 0, MAX_ROWS - 1 do
    local src   = state.source_scroll + row
    local row_y = GRID_Y + row * ROW_H
    local sel   = (src == state.selected_source)
    local en    = state.source_enabled[src]

    -- Enable toggle
    if draw_button(en and "✓" or "", GRID_X, row_y, ENABLE_W - 4, ROW_H - 4, en, false) then
      state.source_enabled[src] = not en
      state.selected_source = src
    end

    -- Source label
    local lbl_r = sel and 0.18 or 0.10
    local lbl_g = sel and 0.26 or 0.12
    local lbl_b = sel and 0.22 or 0.14
    draw_rect(GRID_X + ENABLE_W, row_y, SOURCE_W - 4, ROW_H - 4, lbl_r, lbl_g, lbl_b, en and 1 or 0.55, true)
    draw_rect(GRID_X + ENABLE_W, row_y, SOURCE_W - 4, ROW_H - 4,
              sel and 0.36 or 0.24, sel and 0.74 or 0.28, sel and 0.52 or 0.34, en and 1 or 0.55, false)
    gfx.setfont(2, "Arial", 13)
    draw_text("S" .. tostring(src - 1), GRID_X + ENABLE_W + 6, row_y + 10,
              en and 0.82 or 0.40, en and 0.86 or 0.42, en and 0.88 or 0.44)
    gfx.setfont(1, "Arial", 16)
    if mouse_clicked(GRID_X + ENABLE_W, row_y, SOURCE_W - 4, ROW_H - 4) then
      local shift = (gfx.mouse_cap & 8) == 8
      if shift then
        -- Shift+Click: enable all sources from anchor to here
        local a = math.min(state.selected_source, src)
        local b = math.max(state.selected_source, src)
        for s = a, b do state.source_enabled[s] = true end
        state.selected_source = src
      else
        -- Click: toggle enable + select
        state.source_enabled[src] = not state.source_enabled[src]
        state.selected_source = src
      end
    end

    -- Motion cells
    for i, m in ipairs(MOTIONS) do
      local cx = GRID_X + ENABLE_W + SOURCE_W + (i - 1) * CELL_W
      local active = state.motion_by_source[src] == m.id
      if draw_button("", cx, row_y, CELL_W - 4, ROW_H - 4, active, false) then
        state.motion_by_source[src] = m.id
        state.source_enabled[src]   = true
        state.selected_source       = src
      end
      draw_motion_icon(m.id, cx, row_y, CELL_W - 4, ROW_H - 4, active, en)
    end
  end

  -- Scroll buttons
  local sbx = GRID_X + ENABLE_W + SOURCE_W + #MOTIONS * CELL_W + 4
  if draw_button("▲", sbx, GRID_Y,      46, 26, false, state.source_scroll == 1) then
    state.source_scroll = math.max(1, state.source_scroll - 8)
  end
  if draw_button("▼", sbx, GRID_Y + 30, 46, 26, false, state.source_scroll >= 49) then
    state.source_scroll = math.min(49, state.source_scroll + 8)
  end
  gfx.setfont(2, "Arial", 12)
  draw_text("S" .. (state.source_scroll - 1) .. "–" .. (state.source_scroll + MAX_ROWS - 2),
            sbx, GRID_Y + 64, 0.50, 0.56, 0.60)
  gfx.setfont(1, "Arial", 16)
end

-- ── Trajectory Preview ───────────────────────────────────────────────────────
local PREV_X = 856
local PREV_Y = 56
local PREV_W = 568
local PREV_H = 340

local function preview_params()
  -- Convert XYZ scale-unit values → internal (az/el degrees, z 0-1)
  local s = math.max(0.001, tonumber(state.scale) or 1.0)
  return {
    az_cen     = (tonumber(state.x_center) or 0)    * 180 / s,
    az_spr     = (tonumber(state.x_spread) or 2.0) * 180 / s,
    el_cen     = (tonumber(state.y_center) or 0)   *  90 / s,
    el_spr     = (tonumber(state.y_spread) or 0.56) *  90 / s,
    z_cen      = (tonumber(state.z_center) or 0.75) /   s,
    z_spr      = (tonumber(state.z_spread) or 0.35) /   s,
    lattice_rate = tonumber(state.lattice_rate) or 8.0,
    lattice_smooth = clamp(tonumber(state.lattice_smooth) or 1.0, 0, 1),
    lattice_bound_x = (tonumber(state.lattice_bound_x) or 0) * 180 / s,
    lattice_bound_y = (tonumber(state.lattice_bound_y) or 0) * 90 / s,
    lattice_bound_z = (tonumber(state.lattice_bound_z) or 0) / s,
    time_quant_steps = tonumber(state.time_quant_steps) or 0,
    space_quant_x = (tonumber(state.space_quant_x) or 0) * 180 / s,
    space_quant_y = (tonumber(state.space_quant_y) or 0) * 90 / s,
    space_quant_z = (tonumber(state.space_quant_z) or 0) / s,
    use_z      = state.use_z_motion,
    src_spread = tonumber(state.source_phase) or 0,
  }
end

local function draw_trajectory_preview()
  -- Panel background
  draw_rect(PREV_X, PREV_Y, PREV_W, PREV_H, 0.055, 0.065, 0.085, 1, true)
  draw_rect(PREV_X, PREV_Y, PREV_W, PREV_H, 0.15, 0.19, 0.25, 1, false)

  -- Title
  gfx.setfont(2, "Arial", 12)
  draw_text("TRAJECTORY PREVIEW", PREV_X + 8, PREV_Y + 7, 0.40, 0.50, 0.58)
  gfx.setfont(1, "Arial", 16)

  -- Plot area
  local pad = 30
  local px  = PREV_X + pad
  local py  = PREV_Y + 22
  local pw  = PREV_W - pad * 2
  local ph  = PREV_H - 32
  local cx  = px + pw / 2
  local cy  = py + ph / 2
  local sx  = pw / 2
  local sy  = ph / 2

  -- Grid — X lines every 30° of internal az (maps to ±scale in display)
  local _sc = tonumber(state.scale) or 1.0
  for az = -180, 180, 30 do
    local gx    = cx + (az / 180) * sx
    local major = (az % 90 == 0)
    gfx.set(major and 0.12 or 0.08, major and 0.16 or 0.11, major and 0.21 or 0.14, 1)
    gfx.line(gx, py, gx, py + ph, 0)
    if major then
      local disp_x = az * _sc / 180
      gfx.setfont(2, "Arial", 11)
      draw_text(string.format("%.4g", disp_x), gx - 10, py + ph + 3, 0.22, 0.29, 0.38)
      gfx.setfont(1, "Arial", 16)
    end
  end
  -- Grid — Y lines every 30° of internal el (maps to ±scale in display)
  for el = -90, 90, 30 do
    local gy    = cy - (el / 90) * sy
    local major = (el == 0)
    gfx.set(major and 0.12 or 0.08, major and 0.16 or 0.11, major and 0.21 or 0.14, 1)
    gfx.line(px, gy, px + pw, gy, 0)
    local disp_y = el * _sc / 90
    gfx.setfont(2, "Arial", 11)
    draw_text(string.format("%.4g", disp_y), px - 28, gy - 6, 0.22, 0.29, 0.38)
    gfx.setfont(1, "Arial", 16)
  end

  -- Axis labels
  local _ax_x = _sc > 1 and "X (m)" or "X"
  local _ax_y = _sc > 1 and "Y (m)" or "Y"
  gfx.setfont(2, "Arial", 11)
  draw_text(_ax_x, cx - 14, py + ph + 16, 0.22, 0.29, 0.38)
  draw_text(_ax_y, px - 26, py - 1, 0.22, 0.29, 0.38)
  gfx.setfont(1, "Arial", 16)

  -- Collect enabled sources
  local enabled = {}
  for s = 1, 64 do
    if state.source_enabled[s] then enabled[#enabled + 1] = s end
  end
  local n = #enabled
  local params = preview_params()
  local TSTEPS = 64

  -- Draw trails
  for ci, src in ipairs(enabled) do
    local shape  = state.motion_by_source[src] or "line"
    local col    = COLORS[((ci - 1) % #COLORS) + 1]
    local is_sel = (src == state.selected_source)
    gfx.set(col[1], col[2], col[3], is_sel and 0.90 or 0.55)

    local prev_gx, prev_gy
    for i = 0, TSTEPS do
      local t = transform_t(i / TSTEPS)
      local az, el = computeAED(shape, t, src - 1, n, params)
      local gx = cx + (az / 180) * sx
      local gy = cy - (el / 90) * sy
      if prev_gx then gfx.line(prev_gx, prev_gy, gx, gy, 1) end
      prev_gx, prev_gy = gx, gy
    end
  end

  -- Animated dots — all enabled sources
  local anim_t = transform_t((reaper.time_precise() * 0.28) % 1.0)
  local pulse  = 0.5 + 0.5 * math.sin(reaper.time_precise() * 5)
  local sel_az, sel_el, sel_dot_x, sel_dot_y, sel_col

  for ci, src in ipairs(enabled) do
    local shape  = state.motion_by_source[src] or "line"
    local col    = COLORS[((ci - 1) % #COLORS) + 1]
    local is_sel = (src == state.selected_source)
    local az, el = computeAED(shape, anim_t, src - 1, n, params)
    local dot_x  = cx + (az / 180) * sx
    local dot_y  = cy - (el / 90) * sy

    if is_sel then
      -- save for halo + label (drawn after all dots)
      sel_az, sel_el, sel_dot_x, sel_dot_y, sel_col = az, el, dot_x, dot_y, col
    end
    -- Dot body
    gfx.set(col[1], col[2], col[3], is_sel and 1.0 or 0.80)
    gfx.circle(dot_x, dot_y, is_sel and 5 or 4, true, true)
    -- Inner highlight
    gfx.set(0.90, 0.98, 0.95, is_sel and 1.0 or 0.60)
    gfx.circle(dot_x, dot_y, 2, true, true)
  end

  -- Pulse halo + coord label for selected source (on top)
  if sel_dot_x then
    local col = sel_col
    gfx.set(col[1], col[2], col[3], 0.10 + 0.08 * pulse)
    gfx.circle(sel_dot_x, sel_dot_y, 10 + pulse * 5, true, true)
    gfx.set(col[1], col[2], col[3], 1.0)
    gfx.circle(sel_dot_x, sel_dot_y, 5, true, true)
    gfx.set(0.86, 0.98, 0.92, 1)
    gfx.circle(sel_dot_x, sel_dot_y, 2, true, true)

    gfx.setfont(2, "Arial", 13)
    local _sc2 = tonumber(state.scale) or 1.0
    local disp_x = string.format("%.4g", sel_az * _sc2 / 180)
    local disp_y = string.format("%.4g", sel_el * _sc2 / 90)
    local lbl = string.format("S%d  X:%s  Y:%s", state.selected_source - 1, disp_x, disp_y)
    local lx  = math.min(sel_dot_x + 8, PREV_X + PREV_W - 90)
    local ly  = (sel_dot_y < py + 20) and sel_dot_y + 14 or sel_dot_y - 18
    draw_text(lbl, lx, ly, col[1], col[2], col[3])
    gfx.setfont(1, "Arial", 16)
  end
end

-- ── Presets ───────────────────────────────────────────────────────────────────
local function set_motion_for_range(a, b, motion)
  for s = a, b do state.motion_by_source[s] = motion end
end
local function set_source_enabled(a, b, v)
  for s = a, b do state.source_enabled[s] = v end
end
local function set_auto_map()
  for s = 1, 64 do
    state.motion_by_source[s] = MOTIONS[((s - 1) % #MOTIONS) + 1].id
  end
end
local function set_random()
  math.randomseed(math.floor(reaper.time_precise() * 100000))
  for s = 1, 64 do
    state.motion_by_source[s] = MOTIONS[math.random(1, #MOTIONS)].id
  end
end
local function clear_motion_selection()
  for s = 1, 64 do
    state.motion_by_source[s] = nil
    state.source_enabled[s]   = false
  end
  state.status = "Selection cleared"
end

local function draw_presets()
  local x = GRID_X
  local y = GRID_Y + MAX_ROWS * ROW_H + 8
  gfx.setfont(2, "Arial", 12)
  draw_text("PRESETS", x, y - 18, 0.40, 0.50, 0.58)
  gfx.setfont(1, "Arial", 16)

  if draw_button("Auto",        x,       y, 66, 28, false, false) then set_auto_map() end
  if draw_button("Random",      x + 72,  y, 76, 28, false, false) then set_random() end
  if draw_button("All Line",    x + 154, y, 82, 28, false, false) then set_motion_for_range(1,64,"line") end
  if draw_button("All Circle",  x + 242, y, 90, 28, false, false) then set_motion_for_range(1,64,"circle") end
  if draw_button("All Step",    x + 338, y, 82, 28, false, false) then set_motion_for_range(1,64,"step") end
  if draw_button("S0-7 Arc",    x + 426, y, 84, 28, false, false) then set_motion_for_range(1,8,"arc_up") end
  if draw_button("S8-15 Circ",  x + 516, y, 94, 28, false, false) then set_motion_for_range(9,16,"circle") end

  local y2 = y + 34
  if draw_button("All Src",    x,       y2, 74, 26, false, false) then set_source_enabled(1,64,true) end
  if draw_button("None Src",   x + 80,  y2, 82, 26, false, false) then set_source_enabled(1,64,false) end
  if draw_button("S0-7",       x + 168, y2, 62, 26, false, false) then set_source_enabled(1,64,false); set_source_enabled(1,8,true) end
  if draw_button("S8-15",      x + 236, y2, 68, 26, false, false) then set_source_enabled(1,64,false); set_source_enabled(9,16,true) end
  if draw_button("Clear All",  x + 310, y2, 88, 26, false, false) then clear_motion_selection() end
end

-- ── OSC panel (left column, below preset buttons) ────────────────────────────
local function draw_osc_left()
  local x = GRID_X
  -- sits just below the two preset button rows
  local y = GRID_Y + MAX_ROWS * ROW_H + 84   -- 8 (base) + 28 (row1) + 6 + 26 (row2) + 16 gap

  -- thin separator
  draw_rect(x, y, 620, 1, 0.14, 0.18, 0.22, 1, true)
  y = y + 8

  gfx.setfont(2, "Arial", 12)
  draw_text("OSC PREVIEW", x, y, 0.40, 0.50, 0.58)
  gfx.setfont(1, "Arial", 16)

  y = y + 18
  draw_input("osc_host", "Host",  x,        y, 170)
  draw_input("osc_port", "Port",  x + 178,  y,  74)

  local btn_x = x + 260
  if draw_button(_osc_ok and "Disconnect" or "Connect", btn_x, y + 16, 110, 26,
                 _osc_ok, false) then
    if _osc_ok then osc_close() else osc_init() end
  end
  -- status dot
  local si_r = _osc_ok and 0.22 or 0.70
  local si_g = _osc_ok and 0.74 or 0.24
  local si_b = _osc_ok and 0.34 or 0.20
  gfx.set(si_r, si_g, si_b, 1)
  gfx.circle(btn_x + 122, y + 29, 5, true, true)

  y = y + 50
  local prev_was = state.osc_preview
  state.osc_preview = draw_toggle("Live Preview (sends AED to AmbiEncoder)", state.osc_preview, x, y)
  if state.osc_preview and not prev_was and not _osc_ok then osc_init() end

  if _osc_err ~= "" then
    gfx.setfont(2, "Arial", 11)
    draw_text(_osc_err, x + 22, y + 18, 0.70, 0.36, 0.30)
    gfx.setfont(1, "Arial", 16)
  end
end

local function reset_params()
  local s = math.max(0.001, tonumber(state.scale) or 1.0)
  state.x_center          = string.format("%.2f", 0)
  state.x_spread          = string.format("%.2f", 2.0 * s)
  state.y_center          = string.format("%.2f", 0)
  state.y_spread          = string.format("%.2f", 0.56 * s)
  state.z_center          = string.format("%.2f", 0.75 * s)
  state.z_spread          = string.format("%.2f", 0.35 * s)
  state.motion_amount     = "1.0"
  state.source_phase      = "0.00"
  state.lattice_rate      = "8.0"
  state.lattice_smooth    = "1.0"
  state.lattice_bound_x   = "0.00"
  state.lattice_bound_y   = "0.00"
  state.lattice_bound_z   = "0.00"
  state.time_quant_steps  = "0.0"
  state.space_quant_x     = "0.00"
  state.space_quant_y     = "0.00"
  state.space_quant_z     = "0.00"
  state.steps_per_second  = "12"
  state.time_curve_mode   = "linear"
  state.time_curve_amount = "2.0"
  state.palindrome        = false
  state.use_z_motion      = true
  state.status = "Parameters reset to defaults"
end

-- ── Settings panel ────────────────────────────────────────────────────────────
local SET_X = PREV_X
local SET_Y = PREV_Y + PREV_H + 12

local function motion_label(id)
  for _, m in ipairs(MOTIONS) do
    if m.id == id then return m.label end
  end
  return "—"
end

local function draw_settings()
  local x     = SET_X
  local y     = SET_Y
  local col_w = 126

  local cnt = 0
  for s = 1, 64 do if state.source_enabled[s] then cnt = cnt + 1 end end

  gfx.setfont(2, "Arial", 12)
  draw_text("SETTINGS", x, y, 0.40, 0.50, 0.58)
  draw_text(tostring(cnt) .. " / 64 active", x + PREV_W - 88, y, 0.65, 0.74, 0.72)
  gfx.setfont(1, "Arial", 16)

  -- ── Preset bar ──────────────────────────────────────────────────────────────
  y = y + 20
  -- Name input
  draw_input("preset_name", "Preset", x, y, 230)
  -- Save / Load / Delete buttons
  local pbx = x + 238
  if draw_button("Save",   pbx,      y + 16, 60, 22, false, false) then
    preset_save(state.preset_name or "")
  end
  if draw_button("Load",   pbx + 66, y + 16, 60, 22, false, false) then
    preset_load(state.preset_name or "")
  end
  if draw_button("Delete", pbx + 132, y + 16, 60, 22, false, false) then
    preset_delete(state.preset_name or "")
  end

  -- Scrollable preset chip row
  y = y + 40
  local list         = preset_list_get()
  local chips_visible = 6
  local chip_w       = 80
  local chip_gap     = 4
  local max_scroll   = math.max(0, #list - chips_visible)
  state.preset_list_scroll = math.max(0, math.min(max_scroll, state.preset_list_scroll))
  -- ◄ ► scroll buttons
  local arr_x = x + chips_visible * (chip_w + chip_gap)
  if draw_button("◄", arr_x,      y, 22, 20, false, state.preset_list_scroll == 0) then
    state.preset_list_scroll = math.max(0, state.preset_list_scroll - 1)
  end
  if draw_button("►", arr_x + 26, y, 22, 20, false, state.preset_list_scroll >= max_scroll) then
    state.preset_list_scroll = math.min(max_scroll, state.preset_list_scroll + 1)
  end
  -- chips
  for ci = 1, chips_visible do
    local idx  = ci + state.preset_list_scroll
    local name = list[idx]
    if name then
      local cx    = x + (ci - 1) * (chip_w + chip_gap)
      local is_on = (name == state.preset_name)
      if draw_button(name, cx, y, chip_w, 20, is_on, false) then
        preset_load(name)
      end
    end
  end

  -- thin separator before motion params
  y = y + 26
  draw_rect(x, y, PREV_W - 6, 1, 0.14, 0.18, 0.22, 1, true)
  y = y + 8

  -- Scale input (room size in metres; rescales stored XYZ values when committed)
  draw_input("scale", "Scale (m)  ·  1–1000  ·  OSC dist × Scale", x, y, 110)
  -- Rescale stored coords when user finishes editing (focus leaves scale box)
  if state.focus ~= "scale" then
    local new_s = tonumber(state.scale)
    local old_s = tonumber(_scale_committed)
    if new_s and old_s and new_s > 0 and new_s ~= old_s then
      local ratio = new_s / old_s
      state.x_center = string.format("%.2f", (tonumber(state.x_center) or 0) * ratio)
      state.x_spread = string.format("%.2f", (tonumber(state.x_spread) or 0) * ratio)
      state.y_center = string.format("%.2f", (tonumber(state.y_center) or 0) * ratio)
      state.y_spread = string.format("%.2f", (tonumber(state.y_spread) or 0) * ratio)
      state.z_center = string.format("%.2f", (tonumber(state.z_center) or 0) * ratio)
      state.z_spread = string.format("%.2f", (tonumber(state.z_spread) or 0) * ratio)
      _scale_committed = state.scale
    end
  end
  y = y + 46

  -- Row 1: steps/sec (text) + sliders for motion_amount, x_center, x_spread  (4 cols @ col_w)
  local s = math.max(0.001, tonumber(state.scale) or 1.0)
  draw_input ("steps_per_second", "Steps/sec",    x,               y, col_w)
  draw_slider("motion_amount",    "Motion amount", x + col_w + 6,   y, col_w,    0,    2,   false)
  draw_slider("x_center",        "X center",       x + (col_w+6)*2, y, col_w,   -s,   s,   false)
  draw_slider("x_spread",        "X spread",       x + (col_w+6)*3, y, col_w,    0, 2*s,   false)

  y = y + 52
  -- Row 2: Src offset + Y/Z sliders (5 cols → narrower col_w2 to fit PREV_W)
  local col_w2 = math.floor((PREV_W - 4 * 6) / 5)  -- ~107px each, 5 cols with 4 gaps
  draw_slider("source_phase", "Src offset", x,                y, col_w2,   0,    1,  false)
  draw_slider("y_center",     "Y center",   x + (col_w2+6)*1, y, col_w2,  -s,    s,  false)
  draw_slider("y_spread",     "Y spread",   x + (col_w2+6)*2, y, col_w2,   0,  2*s,  false)
  draw_slider("z_center",     "Z center",   x + (col_w2+6)*3, y, col_w2,   0,    s,  false)
  draw_slider("z_spread",     "Z spread",   x + (col_w2+6)*4, y, col_w2,   0,    s,  false)

  -- ── Time Curve ────────────────────────────────────────────────────────
  y = y + 52
  draw_text("Time curve", x, y, 0.56, 0.62, 0.66)
  local btn_w      = 56
  local modes      = { {"linear","Linear"}, {"exp","Exp"}, {"log","Log"} }
  local btn_lbl_x  = x + 80
  for i, m in ipairs(modes) do
    local bx   = btn_lbl_x + (i - 1) * (btn_w + 4)
    local is_on = (state.time_curve_mode == m[1])
    if draw_button(m[2], bx, y, btn_w, 22, is_on, false) then
      state.time_curve_mode = m[1]
    end
  end
  local sld_x = btn_lbl_x + #modes * (btn_w + 4) + 8
  local sld_w = 110
  local pal_x = sld_x + sld_w + 10      -- Palindrome toggle right of n-slider
  if state.time_curve_mode == "linear" then
    draw_text("n/a", sld_x, y + 5, 0.25, 0.28, 0.32)
  else
    draw_slider("time_curve_amount", "n =", sld_x, y - 16, sld_w, 1.0, 6.0, false)
  end
  state.palindrome = draw_toggle("Palindrome", state.palindrome, pal_x, y + 3)

  -- ── Lattice ───────────────────────────────────────────────────────────
  y = y + 42
  draw_text("Lattice", x, y, 0.56, 0.62, 0.66)
  draw_text("For Lat: X/Y/Z spread = repeated step vector", x + 80, y, 0.34, 0.42, 0.48)
  y = y + 18
  local lat_w = math.floor((PREV_W - 4 * 6) / 5)
  draw_slider("lattice_rate",   "Rate / T", x,                 y, lat_w, 0, 32, false)
  draw_slider("lattice_smooth", "Slide",    x + (lat_w+6) * 1, y, lat_w, 0,  1, false)
  draw_slider("lattice_bound_x","Bound X",  x + (lat_w+6) * 2, y, lat_w, 0,  s, false)
  draw_slider("lattice_bound_y","Bound Y",  x + (lat_w+6) * 3, y, lat_w, 0,  s, false)
  draw_slider("lattice_bound_z","Bound Z",  x + (lat_w+6) * 4, y, lat_w, 0,  s, false)

  -- ── Quantize ──────────────────────────────────────────────────────────
  y = y + 54
  draw_text("Quantize", x, y, 0.56, 0.62, 0.66)
  draw_text("Applies to every shape: step time and round XYZ space", x + 80, y, 0.34, 0.42, 0.48)
  y = y + 18
  draw_slider("time_quant_steps","Time / T", x,                 y, lat_w, 0, 32, false)
  draw_slider("space_quant_x",  "Q X",      x + (lat_w+6) * 1, y, lat_w, 0,  s, false)
  draw_slider("space_quant_y",  "Q Y",      x + (lat_w+6) * 2, y, lat_w, 0,  s, false)
  draw_slider("space_quant_z",  "Q Z",      x + (lat_w+6) * 3, y, lat_w, 0,  s, false)

  -- ── Output options ────────────────────────────────────────────────────
  y = y + 54
  draw_input("region_name", "Region name", x, y, col_w * 2 + 6)

  -- Toggles — 2 per row
  y = y + 50
  state.clear_existing   = draw_toggle("Clear existing",  state.clear_existing,   x,        y)
  state.set_latch        = draw_toggle("Track Latch",      state.set_latch,        x + 164,  y)
  y = y + 28
  state.overwrite_region = draw_toggle("Overwrite region", state.overwrite_region, x,        y)
  state.use_z_motion     = draw_toggle("Use Z motion",     state.use_z_motion,     x + 164,  y)

  y = y + 28
  local sel_info = "Selected  S" .. tostring(state.selected_source - 1)
                   .. "  →  " .. motion_label(state.motion_by_source[state.selected_source])
  draw_text(sel_info, x, y, 0.36, 0.74, 0.58)

  -- Write button — thin separator then button (with Reset)
  y = y + 36
  draw_rect(x, y, PREV_W, 1, 0.14, 0.18, 0.22, 1, true)
  y = y + 10
  if draw_button("▶  Write Automation + Region", x, y, PREV_W - 92, 40, true, false) then
    write_automation()
  end
  if draw_button("⟲ Reset", x + PREV_W - 86, y + 8, 80, 24, false, false) then
    reset_params()
  end
end

-- ── Write automation ──────────────────────────────────────────────────────────
local function enabled_sources()
  local t = {}
  for s = 1, 64 do
    if state.source_enabled[s] then t[#t + 1] = s end
  end
  return t
end

local function motion_map_for_writer()
  local map = {}
  for s = 1, 64 do
    local m = state.motion_by_source[s]
    if m and m ~= "" then map[s] = m end
  end
  return map
end

function write_automation()
  local path    = writer_path()
  local sources = enabled_sources()

  if not file_exists(path) then
    reaper.MB("Writer-Script nicht gefunden:\n" .. path, SCRIPT_NAME, 0)
    return
  end
  if #sources == 0 then
    reaper.MB("Bitte mindestens eine Source aktivieren.", SCRIPT_NAME, 0)
    return
  end

  -- Convert XYZ scale-unit values → internal units (az/el degrees, z 0-1) for writer
  local w_s   = math.max(0.001, tonumber(state.scale) or 1.0)
  local w_az_c = (tonumber(state.x_center) or 0)    * 180 / w_s
  local w_az_s = (tonumber(state.x_spread) or 2.0) * 180 / w_s
  local w_el_c = (tonumber(state.y_center) or 0)    *  90 / w_s
  local w_el_s = (tonumber(state.y_spread) or 0.56) *  90 / w_s
  local w_z_c  = (tonumber(state.z_center) or 0.75) /  w_s
  local w_z_s  = (tonumber(state.z_spread) or 0.35) /  w_s

  _G.JS_AMBIENCODER64_SETTINGS = {
    sources          = sources,
    steps_per_second = state.steps_per_second,
    azimuth_center   = tostring(w_az_c),
    azimuth_spread   = tostring(w_az_s),
    elevation_center = tostring(w_el_c),
    elevation_spread = tostring(w_el_s),
    distance_center  = tostring(w_z_c),
    distance_spread  = tostring(w_z_s),
    motion_amount         = state.motion_amount,
    lattice_rate         = state.lattice_rate,
    lattice_smooth       = state.lattice_smooth,
    lattice_bound_x      = tostring((tonumber(state.lattice_bound_x) or 0) * 180 / w_s),
    lattice_bound_y      = tostring((tonumber(state.lattice_bound_y) or 0) * 90 / w_s),
    lattice_bound_z      = tostring((tonumber(state.lattice_bound_z) or 0) / w_s),
    time_quant_steps     = state.time_quant_steps,
    space_quant_x        = tostring((tonumber(state.space_quant_x) or 0) * 180 / w_s),
    space_quant_y        = tostring((tonumber(state.space_quant_y) or 0) * 90 / w_s),
    space_quant_z        = tostring((tonumber(state.space_quant_z) or 0) / w_s),
    source_phase_spread   = state.source_phase,
    use_z_motion          = state.use_z_motion,
    palindrome          = state.palindrome,
    time_curve_mode     = state.time_curve_mode,
    time_curve_amount   = state.time_curve_amount,
    clear_existing      = state.clear_existing,
    set_latch        = state.set_latch,
    overwrite_region = state.overwrite_region,
    region_name      = state.region_name,
    motion_map       = motion_map_for_writer(),
  }

  dofile(path)
  state.status = "✓ Automation written for " .. #sources .. " source(s)"
end

-- ── Text input ────────────────────────────────────────────────────────────────
local function handle_text_input()
  if not state.focus then return end
  local char = ui.char
  if char == 0 then return end
  if char == 27 or char == 13 then state.focus = nil; return end
  local text = tostring(state[state.focus] or "")
  if char == 8 then
    state[state.focus] = text:sub(1, -2)
  elseif char >= 32 and char <= 126 then
    state[state.focus] = text .. string.char(char)
  end
end

-- ── Draw ──────────────────────────────────────────────────────────────────────
local function draw()
  draw_rect(0, 0, state.w, state.h, 0.06, 0.07, 0.09, 1, true)

  -- Title bar
  gfx.setfont(2, "Arial", 22)
  draw_text("AmbiEncoder64 Motion Map   v2.0", GRID_X, 10, 0.88, 0.92, 0.94)
  gfx.setfont(2, "Arial", 12)
  draw_text("Assign motion shapes to sources, preview trajectories, then write XYZ automation over the current time selection.",
            GRID_X, 40, 0.42, 0.50, 0.56)
  gfx.setfont(1, "Arial", 16)

  -- Divider
  draw_rect(PREV_X - 10, 0, 1, state.h, 0.13, 0.17, 0.22, 1, true)
  gfx.setfont(1, "Arial", 16)

  draw_source_grid()
  draw_presets()
  draw_osc_left()
  draw_trajectory_preview()
  draw_settings()

  -- Status bar
  draw_rect(0, state.h - 28, state.w, 28, 0.07, 0.08, 0.10, 1, true)
  draw_rect(0, state.h - 28, state.w, 1,  0.13, 0.17, 0.22, 1, true)
  gfx.setfont(2, "Arial", 13)
  draw_text(state.status, GRID_X, state.h - 20, 0.58, 0.68, 0.64)
  gfx.setfont(1, "Arial", 16)
end

-- ── Main loop ─────────────────────────────────────────────────────────────────
local function loop()
  ui.mx, ui.my  = gfx.mouse_x, gfx.mouse_y
  ui.mouse_down  = (gfx.mouse_cap & 1) == 1
  ui.char        = gfx.getchar()
  if ui.char < 0 then osc_close(); return end
  handle_text_input()
  if state.osc_preview then osc_send_preview() end
  draw()
  ui.last_mouse_down = ui.mouse_down
  gfx.update()
  reaper.defer(loop)
end

-- ── Init ──────────────────────────────────────────────────────────────────────
set_auto_map()
set_source_enabled(1, 64, true)
gfx.init(SCRIPT_NAME, state.w, state.h, 0)
gfx.setfont(1, "Arial", 16)
loop()
