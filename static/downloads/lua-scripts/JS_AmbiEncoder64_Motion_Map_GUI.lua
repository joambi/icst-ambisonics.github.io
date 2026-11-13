-- @description AmbiEncoder64 Motion Map GUI
-- @author JS / Codex
-- @version 2.4.5
-- @about
--   Improved GUI for assigning motion shapes per ICST AmbiEncoder_64 source index,
--   with live AZ/EL trajectory preview, anti-aliased icons, and color-coded source trails.
--   Writes XYZ automation and a render region via JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua.
-- @changelog
--   v2.4.5: Written tracks are always set to Latch (the Track Latch option is gone; old presets
--         are ignored for this). New Sync button in the preview transport: the preview follows
--         REAPER play/stop, and the GUI Play / Stop buttons start / stop the REAPER transport.
--   v2.4.4: Preview transport under OSC PREVIEW (like Kristall Motion Map): Speed x (free-run
--         and tempo-synced preview), Fwd/Rev direction, Play / Stop (Stop freezes the animation
--         in the trajectory preview and in the live OSC preview). Not stored in presets.
--   v2.4.3: Quantize controls (any figure): Time / T = number of time slices per figure cycle
--         (0 = off), Q X / Q Y / Q Z = spatial rounding step in scale units (0 = off).
--         Used by preview, live OSC, score export and the written automation; stored in presets.
--   v2.3: Figure Editor — every motion shape has editable parameters (e.g. spiral: turns,
--         inner/outer radius, easing; circle: turns, start angle, ellipse; lissajous: ratios),
--         plus generic transforms (rotation, X/Y scale, offset, time offset, reverse).
--         Scope per shape (all sources) or per source. Stored in presets; passed to the writer.
--   v2.4.2: Hook function handed over via its own global (the writer clears its settings global
--         before computing) — verified in REAPER.
--   v2.4.1: Writer hook now targets the real writer function (xyz_motion_values) — figure
--         parameters and tempo sync are written; previously the hook never matched.
--   v2.4: Tempo sync (like Kristall Motion Map): BPM button switches the time base from
--         seconds to beats — the figure cycle is N beats (default 16 = 4 bars) and repeats over
--         the time selection; steps are given per beat; phase can be locked to bar lines;
--         preview/OSC animation follows the project tempo and the DAW transport.
--         Score image (time mode) shows bar lines in sync mode. Writer gets a synced hook.
--   v2.3.2: Figure Editor is a tab of the right column (SETTINGS | FIGURE EDITOR) under the
--         trajectory preview — the window stays 1440 px wide, nothing moves off-screen.
--         Clicking the already-assigned figure of a source opens the editor for it.
--   v2.2: Score export — renders the trajectory preview (XY or X/Y/Z-over-time) to a PNG
--         and inserts it as a video item on a "Motion Score" track, stretched over the
--         target region (time selection → region at edit cursor → named region).

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
  h = 940,
  source_scroll   = 1,
  selected_source = 1,
  motion_by_source = {},
  source_enabled   = {},
  focus = nil,
  steps_per_second = "12",
  bpm_sync         = false,  -- tempo sync (Kristall-style): time base in beats
  cycle_beats      = "16",   -- figure cycle length in beats (quarter notes) when synced
  steps_per_beat   = "4",    -- automation steps per beat when synced
  quant_start      = true,   -- lock the cycle phase to bar lines (else to the selection start)
  anim_speed       = "1.00", -- preview transport: speed factor (preview / live OSC only)
  anim_rev         = false,  -- preview transport: reverse direction
  anim_run         = true,   -- preview transport: false = animation frozen (Stop)
  sync_transport   = false,  -- preview follows REAPER play/stop; Play/Stop buttons drive REAPER
  scale     = "1",    -- display scale factor (1=unit sphere, 10=10m, 50=50m, 100=100m)
  x_center  = "0.00", -- X center in scale units (−scale..+scale)
  x_spread  = "2.00", -- X total spread in scale units (0..2×scale) — 2.0 = full -1..+1
  y_center  = "0.00", -- Y center in scale units (−scale..+scale; 0=horizon)
  y_spread  = "0.56", -- Y total spread in scale units (0..2×scale)
  z_center  = "0.75", -- Z center in scale units (0..scale)
  z_spread  = "0.35", -- Z total spread in scale units (0..scale)
  motion_amount  = "1.0",
  source_phase   = "0.00", -- temporal offset between sources (0=same pos, 1=evenly spread)
  time_quant_steps = "0",    -- Quantize: time slices per figure cycle (0 = off)
  space_quant_x  = "0.00",   -- Quantize: rounding step X in scale units (0 = off)
  space_quant_y  = "0.00",
  space_quant_z  = "0.00",
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
  osc_port    = "50001",
  osc_preview = false,
  preset_name        = "My Preset",
  score_mode         = "xy",    -- "xy" | "time"  (score image export)
  shape_params       = {},      -- figure editor: shape id -> { key = value } (applies to all sources)
  source_params      = {},      -- figure editor: source (1-64) -> { key = value } (per-source override)
  fig_scope          = "shape", -- "shape" | "source"
  right_tab          = "settings", -- "settings" | "figure"  (right column below the preview)
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

-- ── Tempo sync helpers (v2.4) ────────────────────────────────────────────────
-- Beat positions come from the project tempo map (TimeMap2), so tempo changes
-- inside the selection are respected. "fullbeats" = absolute quarter notes.
local function sync_cycle_beats()
  return math.max(0.25, tonumber(state.cycle_beats) or 16)
end
local function sync_bpm_at(time)
  local bpm = reaper.TimeMap_GetDividedBpmAtTime(time or 0)
  if not bpm or bpm <= 0 then bpm = 120 end
  return bpm
end
local function time_to_beats(time)
  local _, _, _, fullbeats = reaper.TimeMap2_timeToBeats(0, time)
  return fullbeats or 0
end
-- Phase anchor (in beats) for a selection starting at ts0: bar line before ts0,
-- or ts0 itself when "Taktstart" is off.
local function sync_anchor_beats(ts0)
  if state.quant_start then
    local _, measures = reaper.TimeMap2_timeToBeats(0, ts0)
    local bar_t = reaper.TimeMap2_beatsToTime(0, 0, measures or 0)
    return time_to_beats(bar_t)
  end
  return time_to_beats(ts0)
end
-- Cycle phase (0..1, raw) for an absolute project time
local function sync_cycle_phase(time, anchor_beats)
  return ((time_to_beats(time) - anchor_beats) / sync_cycle_beats()) % 1.0
end
-- Returns a computeAED-compatible function that maps a linear 0..1 over
-- [ts0, ts1] onto repeating tempo-synced cycles (palindrome/curve per cycle).
-- Defined after computeAED exists (set in make_synced_compute below).
local make_synced_compute
-- Number of cycles in a time range and bar count (for the info line)
local function sync_info(ts0, ts1)
  local cb   = sync_cycle_beats()
  local nb   = time_to_beats(ts1) - time_to_beats(ts0)
  local _, bpi = reaper.GetProjectTimeSignature2(0)
  bpi = (bpi and bpi > 0) and bpi or 4
  return nb / cb, cb / bpi, sync_bpm_at(ts0)
end
-- Animation phase for preview/OSC: synced → follows transport (play position)
-- or free-runs at project tempo; otherwise the old 0.28 Hz free-run.
local _anim = { phase = 0, last = nil }
local function anim_phase(now)
  local dt = _anim.last and (now - _anim.last) or 0
  _anim.last = now
  if dt < 0 or dt > 0.25 then dt = 0 end
  local speed = math.max(0, math.min(16, tonumber(state.anim_speed) or 1))
  local dir   = state.anim_rev and -1 or 1
  if state.bpm_sync and state.anim_run and (reaper.GetPlayState() & 1) == 1 then
    local pos = reaper.GetPlayPosition()
    local ts0, ts1 = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
    local anchor = sync_anchor_beats(ts1 > ts0 and ts0 or pos)
    _anim.phase = sync_cycle_phase(pos, anchor)       -- follows the DAW transport
    return _anim.phase
  end
  if state.anim_run then
    local rate = 0.28                                  -- free-run: 0.28 cycles/s
    if state.bpm_sync then
      rate = sync_bpm_at(reaper.GetCursorPosition()) / 60 / sync_cycle_beats()
    end
    _anim.phase = (_anim.phase + dt * rate * speed * dir) % 1.0
  end
  return _anim.phase
end
local function smoothstep(t)   return t * t * (3 - 2 * t) end
local function quantize_progress(t, steps)
  if not steps or steps <= 0.000001 then return t end
  return math.floor(t * steps) / steps
end
local function quantize_value(v, quantum)
  if not quantum or quantum <= 0.000001 then return v end
  return math.floor(v / quantum + 0.5) * quantum
end
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

-- ── Figure parameters (v2.3) ─────────────────────────────────────────────────
-- Each shape has editable parameters; defaults reproduce the v2.2 figures exactly.
-- Definition: { key, label, min, max, default, is_int }
-- GENERIC_PARAMS apply to every shape after the figure is computed (normalised space).
local SHAPE_PARAMS = {
  line        = {},
  arc_up      = { {"height","Höhe",0,2,1}, {"cycles","Bögen",0.5,4,1}, {"ease","Easing",0,1,1} },
  arc_down    = { {"height","Höhe",0,2,1}, {"cycles","Bögen",0.5,4,1}, {"ease","Easing",0,1,1} },
  s_curve     = { {"height","Höhe",0,2,1}, {"cycles","Wellen",0.5,4,1}, {"ease","Easing",0,1,1} },
  step        = { {"steps","Stufen",2,16,4,true}, {"height","Höhe",0,2,1} },
  zigzag      = { {"zx","Zacken X",1,16,4,true}, {"zy","Zacken Y",1,16,2,true} },
  circle      = { {"turns","Umläufe",0.25,8,1}, {"start","Startwinkel °",-180,180,0}, {"ellipse","Ellipse Y",0.05,1,1} },
  spiral      = { {"turns","Umläufe",0.25,12,1}, {"r0","Radius innen",0,1,0.15}, {"r1","Radius aussen",0,1,1}, {"ease","Easing",0,1,1}, {"start","Startwinkel °",-180,180,0} },
  fourier_xyz = { {"terms","Teiltöne",1,4,4,true}, {"harm","Obertöne",0,2,1} },
  heart_curve = { {"turns","Umläufe",0.25,4,1}, {"start","Startwinkel °",-180,180,0} },
  cardioid    = { {"turns","Umläufe",0.25,4,1}, {"start","Startwinkel °",-180,180,0} },
  rose8       = { {"petals","Blätter k",1,12,4,true}, {"turns","Umläufe",0.25,4,1}, {"start","Startwinkel °",-180,180,0} },
  bernoulli   = { {"turns","Umläufe",0.25,4,1}, {"start","Startwinkel °",-180,180,0} },
  astroid     = { {"turns","Umläufe",0.25,4,1}, {"start","Startwinkel °",-180,180,0}, {"power","Spitze",1,6,3} },
  epicycloid  = { {"turns","Umläufe",0.25,4,1}, {"start","Startwinkel °",-180,180,0}, {"lobes","Zacken",2,12,5,true} },
  lissajous   = { {"fx","Freq X",1,8,1,true}, {"fy","Freq Y",1,8,2,true}, {"phase","Phase °",-180,180,0} },
}
local GENERIC_PARAMS = {
  {"rot","Drehung °",-180,180,0},
  {"sx","Skalierung X",0,2,1},
  {"sy","Skalierung Y",0,2,1},
  {"ox","Versatz X",-1,1,0},
  {"oy","Versatz Y",-1,1,0},
  {"toff","Zeitversatz",0,1,0},
  {"rev","Rückwärts",0,1,0,true},
}

-- Merged parameter table for a (shape, source): defaults <- shape_params <- source_params
local function figure_params(shape, src)
  local fp = {}
  for _, d in ipairs(SHAPE_PARAMS[shape] or {}) do fp[d[1]] = d[5] end
  for _, d in ipairs(GENERIC_PARAMS) do fp[d[1]] = d[5] end
  local sp = state.shape_params[shape]
  if sp then for k, v in pairs(sp) do fp[k] = v end end
  local op = src and state.source_params[src]
  if op then for k, v in pairs(op) do fp[k] = v end end
  return fp
end

-- Generic post-transform in normalised figure space (x,y ∈ ≈[-1,1])
local function figure_transform(x, y, fp)
  local rot = math.rad(fp.rot or 0)
  if rot ~= 0 then
    local c, s = math.cos(rot), math.sin(rot)
    x, y = x * c - y * s, x * s + y * c
  end
  return x * (fp.sx or 1) + (fp.ox or 0), y * (fp.sy or 1) + (fp.oy or 0)
end

local function sgnpow(v, p)
  if v < 0 then return -((-v) ^ p) end
  return v ^ p
end

-- Closed parametric figures in normalised space (x,y ∈ [-1,1]); fp = figure params
local function parametric_shape_xy(shape, t, fp)
  local turns = fp.turns or 1
  local angle = math.pi * 2 * t * turns + math.rad(fp.start or 0)
  if shape == "heart_curve" then
    local s = math.sin(angle)
    local c = math.cos(angle)
    return (16 * s * s * s) / 18, (13 * c - 5 * math.cos(2 * angle) - 2 * math.cos(3 * angle) - math.cos(4 * angle)) / 18
  elseif shape == "cardioid" then
    local r = 0.5 * (1 - math.sin(angle))
    return r * math.cos(angle), r * math.sin(angle)
  elseif shape == "rose8" then
    local k = math.max(1, math.floor((fp.petals or 4) + 0.5))
    local r = math.cos(k * angle)
    return r * math.cos(angle), r * math.sin(angle)
  elseif shape == "bernoulli" then
    local s = math.sin(angle)
    local c = math.cos(angle)
    local denom = 1 + s * s
    return c / denom, (s * c) / denom
  elseif shape == "astroid" then
    local pw = fp.power or 3
    return sgnpow(math.cos(angle), pw), sgnpow(math.sin(angle), pw)
  elseif shape == "epicycloid" then
    local n = math.max(2, math.floor((fp.lobes or 5) + 0.5))
    return (n * math.cos(angle) - math.cos(n * angle)) / (n + 1), (n * math.sin(angle) - math.sin(n * angle)) / (n + 1)
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

-- Fourier term tables (first `terms` entries used; `harm` scales the overtones)
local FOURIER_X = {{1,1,0},{0.55,2,0.18},{0.30,3,0.41},{0.18,5,0.07}}
local FOURIER_Y = {{1,1,0.25},{0.50,3,0.02},{0.28,4,0.33},{0.15,6,0.11}}
local FOURIER_Z = {{1,1,0.125},{0.42,2,0.36},{0.24,5,0.19}}
local function fourier_terms(tbl, fp)
  local n    = math.max(1, math.min(#tbl, math.floor((fp.terms or 4) + 0.5)))
  local harm = fp.harm or 1
  local out  = {}
  for i = 1, n do
    local w = tbl[i][1] * (i == 1 and 1 or harm)
    out[i] = { w, tbl[i][2], tbl[i][3] }
  end
  return out
end

-- Compute raw AED (azimuth°, elevation°, distance 0-1) for a motion shape.
-- These values mirror the writer's intent in "linear-AED" space:
--   az maps linearly to X_norm via: X_norm = 0.5 + az/360  (writer formula)
--   el maps linearly to Y_norm via: Y_norm = 0.5 + el/180  (writer formula)
--   d  is written directly as Z_norm.
-- v2.3: the figure is first computed in normalised space (x,y,z ∈ [-1,1]) using
-- the editable figure parameters, then the generic transform (rotation, scale,
-- offset) is applied, then it is mapped onto center/spread.
-- NOTE: Do NOT send az/el directly via OSC — use toOscAED().
local function computeAED(shape, t, src_idx, n_active, p)
  local pi2   = math.pi * 2
  local phase = src_idx / math.max(1, n_active)
  local fp    = figure_params(shape, src_idx + 1)
  -- Temporal offset: spread sources along the trajectory (0=same pos, 1=evenly distributed)
  local src_spread = p.src_spread or 0
  local t_src = (t + phase * src_spread + (fp.toff or 0)) % 1.0
  if (fp.rev or 0) >= 0.5 then t_src = 1.0 - t_src end
  t_src = quantize_progress(t_src, p.time_quant_steps)

  local az_a  = p.az_spr * 0.5
  local el_a  = p.el_spr * 0.5
  local z_a   = p.use_z and p.z_spr * 0.5 or 0
  -- Circle/spiral: keep a true circle on the display (same normalisation as v2.2)
  local p_norm = math.min(az_a / 180, el_a / 90)
  local kx = az_a > 1e-9 and (p_norm * 180 / az_a) or 0
  local ky = el_a > 1e-9 and (p_norm *  90 / el_a) or 0

  local x, y, z = 0, 0, nil
  local ease = fp.ease or 1
  local function eased(v) return v + (smoothstep(v) - v) * ease end

  local px, py = parametric_shape_xy(shape, t_src, fp)
  if px ~= nil then
    x, y = px, py
    z = parametric_shape_z(shape, t_src, phase)
  elseif shape == "line" then
    x = 2 * t_src - 1
    y = 2 * t_src - 1
  elseif shape == "arc_up" or shape == "arc_down" then
    local sgn = (shape == "arc_up") and 1 or -1
    local cyc = fp.cycles or 1
    x = 2 * eased(t_src) - 1
    y = sgn * (fp.height or 1) * math.sin(math.pi * cyc * t_src + phase * pi2)
    z = sgn * math.sin(math.pi * cyc * t_src)
  elseif shape == "s_curve" then
    local e   = eased(t_src)
    local cyc = fp.cycles or 1
    x = 2 * e - 1
    y = (fp.height or 1) * math.sin(pi2 * (cyc * t_src - 0.25 + phase * 0.5))
    z = math.sin(pi2 * (e + phase))
  elseif shape == "step" then
    local steps   = math.max(2, math.floor((fp.steps or 4) + 0.5))
    local stepped = t_src >= 1 and 1 or math.floor(t_src * steps) / steps
    x = 2 * stepped - 1
    y = (fp.height or 1) * tri(stepped + phase)
    z = tri(stepped * 2 + phase)
  elseif shape == "zigzag" then
    x = tri(t_src * (fp.zx or 4) + phase)
    y = tri(t_src * (fp.zy or 2) + phase + 0.25)
  elseif shape == "circle" then
    local a = pi2 * ((fp.turns or 1) * t_src + phase) + math.rad(fp.start or 0)
    x = kx * math.cos(a)
    y = ky * (fp.ellipse or 1) * math.sin(a)
    z = math.sin(pi2 * (t_src * 0.5 + phase))
  elseif shape == "spiral" then
    local sw  = eased(t_src)
    local r0  = fp.r0 or 0.15
    local r1  = fp.r1 or 1
    local r_t = r0 + (r1 - r0) * t_src
    local a   = pi2 * ((fp.turns or 1) * sw + phase) + math.rad(fp.start or 0)
    x = kx * r_t * math.cos(a)
    y = ky * r_t * math.sin(a)
    z = 2 * t_src - 1
  elseif shape == "fourier_xyz" then
    x = fourierSum(t_src, phase, fourier_terms(FOURIER_X, fp))
    y = fourierSum(t_src, phase, fourier_terms(FOURIER_Y, fp))
    z = fourierSum(t_src, phase, fourier_terms(FOURIER_Z, fp))
  elseif shape == "lissajous" then
    x = math.sin(pi2 * ((fp.fx or 1) * t_src + phase))
    y = math.sin(pi2 * ((fp.fy or 2) * t_src + phase) + math.rad(fp.phase or 0))
    z = math.cos(pi2 * (t_src + phase))
  end

  x, y = figure_transform(x, y, fp)
  local az = p.az_cen + az_a * x
  local el = p.el_cen + el_a * y
  local d  = p.z_cen + (z and z_a * z or 0)

  az = quantize_value(az, p.space_quant_x)
  el = quantize_value(el, p.space_quant_y)
  d  = quantize_value(d,  p.space_quant_z)

  local el_w, az_w = wrap_el_az(el, az)
  return az_w, el_w, clamp(d, 0, 1)
end

make_synced_compute = function(ts0, ts1)
  local anchor = sync_anchor_beats(ts0)
  local len    = math.max(1e-9, ts1 - ts0)
  return function(shape, t, src_idx, n_active, p)
    local time = ts0 + t * len
    return computeAED(shape, transform_t(sync_cycle_phase(time, anchor)), src_idx, n_active, p)
  end
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

-- Figure params: "<id>:k=v,k=v;<id>:k=v"  (id = shape name or source number)
function fig_serialize(tbl)
  local out = {}
  local keys = {}
  for k in pairs(tbl) do keys[#keys + 1] = k end
  table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
  for _, id in ipairs(keys) do
    local kv = {}
    for k, v in pairs(tbl[id]) do kv[#kv + 1] = k .. "=" .. string.format("%.4g", v) end
    if #kv > 0 then out[#out + 1] = tostring(id) .. ":" .. table.concat(kv, ",") end
  end
  return table.concat(out, ";")
end
function fig_deserialize(str, numeric_ids)
  local tbl = {}
  for entry in (str or ""):gmatch("[^;]+") do
    local id, kvs = entry:match("^([^:]+):(.*)$")
    if id then
      if numeric_ids then id = tonumber(id) end
      if id then
        local t = {}
        for k, v in kvs:gmatch("([%w_]+)=([^,]+)") do t[k] = tonumber(v) end
        tbl[id] = t
      end
    end
  end
  return tbl
end

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
    "bpm_sync=" .. b(state.bpm_sync),
    "cyc_beats=" .. tostring(state.cycle_beats),
    "steps_beat=" .. tostring(state.steps_per_beat),
    "quant_start=" .. b(state.quant_start),
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
    "fig="     .. fig_serialize(state.shape_params),
    "figsrc="  .. fig_serialize(state.source_params),
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
  -- Older presets carry no figure params → defaults
  state.shape_params, state.source_params = {}, {}
  -- Second pass: load values (migrating from older formats to fmt=4 XYZ@Scale=1)
  for pair in str:gmatch("[^&]+") do
    local k, v = pair:match("^([^=]+)=(.*)$")
    if k == "steps"     then state.steps_per_second  = v
    elseif k == "bpm_sync"   then state.bpm_sync       = bv(v)
    elseif k == "cyc_beats"  then state.cycle_beats    = v
    elseif k == "steps_beat" then state.steps_per_beat = v
    elseif k == "quant_start" then state.quant_start   = bv(v)
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
    elseif k == "q_t"     then state.time_quant_steps  = v
    elseif k == "q_x"     then state.space_quant_x     = v
    elseif k == "q_y"     then state.space_quant_y     = v
    elseif k == "q_z"     then state.space_quant_z     = v
    elseif k == "tc_mode" then state.time_curve_mode  = v
    elseif k == "tc_n"    then state.time_curve_amount = v
    elseif k == "palin"   then state.palindrome       = bv(v)
    elseif k == "use_z"   then state.use_z_motion     = bv(v)
    elseif k == "clear"   then state.clear_existing   = bv(v)
    elseif k == "latch"   then state.set_latch        = true   -- always Latch (v2.4.5)
    elseif k == "overwrite" then state.overwrite_region = bv(v)
    elseif k == "region"  then state.region_name      = v
    elseif k == "fig"     then state.shape_params     = fig_deserialize(v, false)
    elseif k == "figsrc"  then state.source_params    = fig_deserialize(v, true)
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
  local port = tonumber(state.osc_port) or 50001
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
  local anim_t = transform_t(anim_phase(now))
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
    time_quant_steps = tonumber(state.time_quant_steps) or 0,
    space_quant_x = (tonumber(state.space_quant_x) or 0) * 180 / _s,
    space_quant_y = (tonumber(state.space_quant_y) or 0) *  90 / _s,
    space_quant_z = (tonumber(state.space_quant_z) or 0) /  _s,
    use_z      = state.use_z_motion,
    src_spread = tonumber(state.source_phase) or 0,
  }
  local enabled = {}
  for s = 1, 64 do
    if state.source_enabled[s] then enabled[#enabled + 1] = s end
  end
  local n    = #enabled
  local host = state.osc_host or "127.0.0.1"
  local port = tonumber(state.osc_port) or 50001
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

  elseif shape == "heart_curve" then
    local x, y = parametric_shape_xy(shape, t, {})
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
    -- edited figures (figure editor) get an amber header + dot
    local edited = false
    local sp = state.shape_params[m.id]
    if sp then for _ in pairs(sp) do edited = true break end end
    if edited then
      draw_text(m.label, hx, GRID_Y - 22, 0.92, 0.72, 0.30)
      gfx.set(0.92, 0.72, 0.30, 1)
      gfx.circle(hx + CELL_W - 12, GRID_Y - 16, 2, true, true)
    else
      draw_text(m.label, hx, GRID_Y - 22, 0.54, 0.60, 0.66)
    end
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
    local ov = state.source_params[src]
    if ov and next(ov) ~= nil then
      gfx.set(0.92, 0.72, 0.30, en and 1 or 0.5)
      gfx.circle(GRID_X + ENABLE_W + SOURCE_W - 12, row_y + 8, 2, true, true)
    end
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
        if active and state.selected_source == src then
          state.right_tab = "figure"      -- second click on the assigned figure → edit it
        end
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
    time_quant_steps = tonumber(state.time_quant_steps) or 0,
    space_quant_x = (tonumber(state.space_quant_x) or 0) * 180 / s,
    space_quant_y = (tonumber(state.space_quant_y) or 0) *  90 / s,
    space_quant_z = (tonumber(state.space_quant_z) or 0) /   s,
    use_z      = state.use_z_motion,
    src_spread = tonumber(state.source_phase) or 0,
  }
end

-- ── Score export (v2.2) ───────────────────────────────────────────────────────
-- Renders the trajectory preview to a PNG (pure-Lua rasterizer + PNG encoder,
-- no external dependencies) and inserts it as a video item on a "Motion Score"
-- track, stretched exactly over the target region so it reads like a score.
--   score_mode "xy"   → XY plot (same view as the preview panel)
--   score_mode "time" → X / Y / Z lanes over time (image width = region length)
-- Target region: time selection → region at edit cursor → region named
-- state.region_name.

local SCORE_TRACK_NAME = "Motion Score"

-- Minimal 5×7 bitmap font (digits, upper-case letters, punctuation)
local FONT5x7 = {
  ["0"]={"01110","10001","10011","10101","11001","10001","01110"},
  ["1"]={"00100","01100","00100","00100","00100","00100","01110"},
  ["2"]={"01110","10001","00001","00010","00100","01000","11111"},
  ["3"]={"11111","00010","00100","00010","00001","10001","01110"},
  ["4"]={"00010","00110","01010","10010","11111","00010","00010"},
  ["5"]={"11111","10000","11110","00001","00001","10001","01110"},
  ["6"]={"00110","01000","10000","11110","10001","10001","01110"},
  ["7"]={"11111","00001","00010","00100","01000","01000","01000"},
  ["8"]={"01110","10001","10001","01110","10001","10001","01110"},
  ["9"]={"01110","10001","10001","01111","00001","00010","01100"},
  A={"01110","10001","10001","11111","10001","10001","10001"},
  B={"11110","10001","10001","11110","10001","10001","11110"},
  C={"01110","10001","10000","10000","10000","10001","01110"},
  D={"11100","10010","10001","10001","10001","10010","11100"},
  E={"11111","10000","10000","11110","10000","10000","11111"},
  F={"11111","10000","10000","11110","10000","10000","10000"},
  G={"01110","10001","10000","10111","10001","10001","01111"},
  H={"10001","10001","10001","11111","10001","10001","10001"},
  I={"01110","00100","00100","00100","00100","00100","01110"},
  J={"00111","00010","00010","00010","00010","10010","01100"},
  K={"10001","10010","10100","11000","10100","10010","10001"},
  L={"10000","10000","10000","10000","10000","10000","11111"},
  M={"10001","11011","10101","10101","10001","10001","10001"},
  N={"10001","10001","11001","10101","10011","10001","10001"},
  O={"01110","10001","10001","10001","10001","10001","01110"},
  P={"11110","10001","10001","11110","10000","10000","10000"},
  Q={"01110","10001","10001","10001","10101","10010","01101"},
  R={"11110","10001","10001","11110","10100","10010","10001"},
  S={"01111","10000","10000","01110","00001","00001","11110"},
  T={"11111","00100","00100","00100","00100","00100","00100"},
  U={"10001","10001","10001","10001","10001","10001","01110"},
  V={"10001","10001","10001","10001","10001","01010","00100"},
  W={"10001","10001","10001","10101","10101","10101","01010"},
  X={"10001","10001","01010","00100","01010","10001","10001"},
  Y={"10001","10001","01010","00100","00100","00100","00100"},
  Z={"11111","00001","00010","00100","01000","10000","11111"},
  [" "]={"00000","00000","00000","00000","00000","00000","00000"},
  ["."]={"00000","00000","00000","00000","00000","01100","01100"},
  [":"]={"00000","01100","01100","00000","01100","01100","00000"},
  ["-"]={"00000","00000","00000","11111","00000","00000","00000"},
  ["+"]={"00000","00100","00100","11111","00100","00100","00000"},
  ["/"]={"00001","00010","00010","00100","01000","01000","10000"},
  ["("]={"00010","00100","01000","01000","01000","00100","00010"},
  [")"]={"01000","00100","00010","00010","00010","00100","01000"},
  [","]={"00000","00000","00000","00000","01100","00100","01000"},
  ["_"]={"00000","00000","00000","00000","00000","00000","11111"},
  ["'"]={"00100","00100","00000","00000","00000","00000","00000"},
}

-- Canvas: packed 0xRRGGBB integers, one per pixel, row-major
local Canvas = {}
Canvas.__index = Canvas

local function canvas_new(w, h, r, g, b)
  local px  = {}
  local bg  = (math.floor(r * 255 + 0.5) << 16) | (math.floor(g * 255 + 0.5) << 8) | math.floor(b * 255 + 0.5)
  for i = 1, w * h do px[i] = bg end
  return setmetatable({ w = w, h = h, px = px }, Canvas)
end

-- Blend colour (0..1 floats) into pixel with coverage a (0..1)
function Canvas:blend(x, y, r, g, b, a)
  if x < 0 or y < 0 or x >= self.w or y >= self.h or a <= 0 then return end
  local i = y * self.w + x + 1
  local p = self.px[i]
  if a >= 1 then
    self.px[i] = (math.floor(r * 255 + 0.5) << 16) | (math.floor(g * 255 + 0.5) << 8) | math.floor(b * 255 + 0.5)
    return
  end
  local pr, pg, pb = (p >> 16) & 255, (p >> 8) & 255, p & 255
  local nr = math.floor(pr + (r * 255 - pr) * a + 0.5)
  local ng = math.floor(pg + (g * 255 - pg) * a + 0.5)
  local nb = math.floor(pb + (b * 255 - pb) * a + 0.5)
  self.px[i] = (nr << 16) | (ng << 8) | nb
end

function Canvas:fill_rect(x, y, w, h, r, g, b, a)
  local x0, y0 = math.floor(x), math.floor(y)
  local x1, y1 = math.floor(x + w) - 1, math.floor(y + h) - 1
  for yy = math.max(0, y0), math.min(self.h - 1, y1) do
    for xx = math.max(0, x0), math.min(self.w - 1, x1) do
      self:blend(xx, yy, r, g, b, a or 1)
    end
  end
end

-- Anti-aliased line segment with round end cap (start cap optional)
function Canvas:line(x0, y0, x1, y1, r, g, b, a, thick, start_cap)
  local rad = (thick or 2) * 0.5
  local dx, dy = x1 - x0, y1 - y0
  local len2 = dx * dx + dy * dy
  local bx0 = math.floor(math.min(x0, x1) - rad - 1)
  local bx1 = math.ceil (math.max(x0, x1) + rad + 1)
  local by0 = math.floor(math.min(y0, y1) - rad - 1)
  local by1 = math.ceil (math.max(y0, y1) + rad + 1)
  for yy = math.max(0, by0), math.min(self.h - 1, by1) do
    for xx = math.max(0, bx0), math.min(self.w - 1, bx1) do
      local cx, cy = xx + 0.5, yy + 0.5
      local t = 0
      if len2 > 0 then t = ((cx - x0) * dx + (cy - y0) * dy) / len2 end
      if t < 0 and not start_cap and len2 > 0 then
        -- skip start cap (previous segment already covered it)
      else
        if t < 0 then t = 0 elseif t > 1 then t = 1 end
        local ex, ey = cx - (x0 + dx * t), cy - (y0 + dy * t)
        local d = math.sqrt(ex * ex + ey * ey)
        local cov = rad + 0.5 - d
        if cov > 0 then
          if cov > 1 then cov = 1 end
          self:blend(xx, yy, r, g, b, cov * (a or 1))
        end
      end
    end
  end
end

function Canvas:circle(x, y, rad, r, g, b, a)
  for yy = math.max(0, math.floor(y - rad - 1)), math.min(self.h - 1, math.ceil(y + rad + 1)) do
    for xx = math.max(0, math.floor(x - rad - 1)), math.min(self.w - 1, math.ceil(x + rad + 1)) do
      local ex, ey = xx + 0.5 - x, yy + 0.5 - y
      local cov = rad + 0.5 - math.sqrt(ex * ex + ey * ey)
      if cov > 0 then
        if cov > 1 then cov = 1 end
        self:blend(xx, yy, r, g, b, cov * (a or 1))
      end
    end
  end
end

-- Bitmap text; scale = pixel size of one font cell. Lower-case is upper-cased.
function Canvas:text(str, x, y, scale, r, g, b, a)
  str = tostring(str or ""):upper()
  local cx = math.floor(x)
  for i = 1, #str do
    local glyph = FONT5x7[str:sub(i, i)]
    if glyph then
      for row = 1, 7 do
        local bits = glyph[row]
        for col = 1, 5 do
          if bits:sub(col, col) == "1" then
            self:fill_rect(cx + (col - 1) * scale, math.floor(y) + (row - 1) * scale, scale, scale, r, g, b, a or 1)
          end
        end
      end
    end
    cx = cx + 6 * scale
  end
end

function Canvas:text_width(str, scale)
  return #tostring(str or "") * 6 * scale - scale
end

-- ── PNG encoder (stored/uncompressed deflate blocks, zlib wrapper) ───────────
local CRC_TABLE
local function crc32_init()
  CRC_TABLE = {}
  for i = 0, 255 do
    local c = i
    for _ = 1, 8 do
      if c & 1 == 1 then c = 0xEDB88320 ~ (c >> 1) else c = c >> 1 end
    end
    CRC_TABLE[i] = c
  end
end
local function crc32(s)
  if not CRC_TABLE then crc32_init() end
  local c = 0xFFFFFFFF
  for i = 1, #s do
    c = CRC_TABLE[(c ~ s:byte(i)) & 0xFF] ~ (c >> 8)
  end
  return (c ~ 0xFFFFFFFF) & 0xFFFFFFFF
end
local function adler32(s)
  local a, b = 1, 0
  local n = #s
  local i = 1
  while i <= n do
    local stop = math.min(n, i + 3999)  -- modulo every ≤4000 bytes stays in range
    for j = i, stop do
      a = a + s:byte(j)
      b = b + a
    end
    a = a % 65521; b = b % 65521
    i = stop + 1
  end
  return ((b << 16) | a) & 0xFFFFFFFF
end
local function u32be(n)
  return string.char((n >> 24) & 255, (n >> 16) & 255, (n >> 8) & 255, n & 255)
end
local function png_chunk(tag, data)
  return u32be(#data) .. tag .. data .. u32be(crc32(tag .. data))
end
local function zlib_stored(raw)
  local out = { "\120\1" }  -- CMF/FLG (no compression hint, FCHECK ok)
  local n, pos = #raw, 1
  repeat
    local len   = math.min(65535, n - pos + 1)
    local final = (pos + len > n) and 1 or 0
    out[#out + 1] = string.char(final, len & 255, len >> 8, (~len) & 255, ((~len) >> 8) & 255)
    out[#out + 1] = raw:sub(pos, pos + len - 1)
    pos = pos + len
  until pos > n
  out[#out + 1] = u32be(adler32(raw))
  return table.concat(out)
end

function Canvas:to_png()
  local rows = {}
  local w, px = self.w, self.px
  local char = string.char
  for y = 0, self.h - 1 do
    local row = { "\0" }  -- filter type 0
    local base = y * w
    for x = 1, w do
      local p = px[base + x]
      row[x + 1] = char((p >> 16) & 255, (p >> 8) & 255, p & 255)
    end
    rows[y + 1] = table.concat(row)
  end
  local raw  = table.concat(rows)
  local ihdr = u32be(self.w) .. u32be(self.h) .. string.char(8, 2, 0, 0, 0)  -- 8-bit RGB
  return "\137PNG\r\n\26\n"
      .. png_chunk("IHDR", ihdr)
      .. png_chunk("IDAT", zlib_stored(raw))
      .. png_chunk("IEND", "")
end

-- ── Score rendering ──────────────────────────────────────────────────────────
local function score_mix(col, a)
  -- pre-mix a colour with the plot background so trails can be drawn opaque
  local br, bg, bb = 0.055, 0.065, 0.085
  return br + (col[1] - br) * a, bg + (col[2] - bg) * a, bb + (col[3] - bb) * a
end

local function score_enabled_sources()
  local enabled = {}
  for s = 1, 64 do
    if state.source_enabled[s] then enabled[#enabled + 1] = s end
  end
  return enabled
end

local function score_fmt(v)
  local s = string.format("%.2f", v):gsub("0+$", ""):gsub("%.$", "")
  return (s == "-0") and "0" or s
end

-- XY plot — mirrors draw_trajectory_preview() (X = az/180, Y = el/90)
local function score_render_xy(W, H, region_name, region_len)
  local cv = canvas_new(W, H, 0.055, 0.065, 0.085)
  local sc = tonumber(state.scale) or 1.0
  local FS = 2
  local pad_l, pad_r, pad_t, pad_b = 92, 24, 44, 44
  local px, py = pad_l, pad_t
  local pw, ph = W - pad_l - pad_r, H - pad_t - pad_b
  local cx, cy = px + pw / 2, py + ph / 2
  local sx, sy = pw / 2, ph / 2

  -- Plot frame
  cv:fill_rect(px, py, pw, ph, 0.04, 0.05, 0.07, 1)
  -- Grid
  for az = -180, 180, 30 do
    local gx    = cx + (az / 180) * sx
    local major = (az % 90 == 0)
    local g     = major and 0.19 or 0.11
    cv:line(gx, py, gx, py + ph, g, g + 0.04, g + 0.08, 1, major and 2 or 1, true)
    if major then
      local lbl = score_fmt(az * sc / 180)
      cv:text(lbl, gx - cv:text_width(lbl, FS) / 2, py + ph + 8, FS, 0.36, 0.44, 0.54, 1)
    end
  end
  for el = -90, 90, 30 do
    local gy    = cy - (el / 90) * sy
    local major = (el == 0)
    local g     = major and 0.19 or 0.11
    cv:line(px, gy, px + pw, gy, g, g + 0.04, g + 0.08, 1, major and 2 or 1, true)
    local lbl = score_fmt(el * sc / 90)
    cv:text(lbl, px - 8 - cv:text_width(lbl, FS), gy - 7, FS, 0.36, 0.44, 0.54, 1)
  end
  cv:text(sc > 1 and "X (M)" or "X", cx - 8, H - 18, FS, 0.36, 0.44, 0.54, 1)
  cv:text(sc > 1 and "Y (M)" or "Y", 12, py - 4, FS, 0.36, 0.44, 0.54, 1)

  -- Trails
  local enabled = score_enabled_sources()
  local n       = #enabled
  local params  = preview_params()
  local TSTEPS  = 96
  local starts  = {}
  for ci, src in ipairs(enabled) do
    local shape = state.motion_by_source[src] or "line"
    local col   = COLORS[((ci - 1) % #COLORS) + 1]
    local r, g, b = score_mix(col, 0.85)
    local prev_gx, prev_gy
    for i = 0, TSTEPS do
      local t  = transform_t(i / TSTEPS)
      local az, el = computeAED(shape, t, src - 1, n, params)
      local gx = cx + (az / 180) * sx
      local gy = cy - (el / 90) * sy
      if prev_gx then
        -- skip wrap-around jumps (az flips at ±180 / el reflection)
        if math.abs(gx - prev_gx) < pw * 0.5 and math.abs(gy - prev_gy) < ph * 0.5 then
          cv:line(prev_gx, prev_gy, gx, gy, r, g, b, 1, 3, i == 1)
        end
      else
        starts[#starts + 1] = { gx, gy, col, src }
      end
      prev_gx, prev_gy = gx, gy
    end
  end
  -- Start markers + source labels (drawn last, on top)
  for _, s in ipairs(starts) do
    local gx, gy, col, src = s[1], s[2], s[3], s[4]
    cv:circle(gx, gy, 6, col[1], col[2], col[3], 1)
    cv:circle(gx, gy, 2.5, 0.92, 0.98, 0.95, 1)
    local lbl = "S" .. (src - 1)
    local lx  = gx + 9
    if lx + cv:text_width(lbl, FS) > px + pw then lx = gx - 9 - cv:text_width(lbl, FS) end
    local ly  = gy - 7
    if ly < py then ly = gy + 9 end
    cv:text(lbl, lx, ly, FS, col[1], col[2], col[3], 1)
  end

  -- Header / footer
  local title = string.format("%s   %s S   %d SRC", region_name, score_fmt(region_len), n)
  cv:text(title, px, 12, 3, 0.86, 0.90, 0.92, 1)
  local foot = "AMBIENCODER64 MOTION MAP V2.4  -  XY"
  cv:text(foot, W - pad_r - cv:text_width(foot, FS), 16, FS, 0.30, 0.36, 0.42, 1)
  return cv
end

-- Time plot — lanes X, Y, Z over time; image width == region length
local function score_render_time(W, H, region_name, region_len, r0, r1)
  local cv = canvas_new(W, H, 0.055, 0.065, 0.085)
  local sc = tonumber(state.scale) or 1.0
  local FS = 2
  local pad_l, pad_r, pad_t, pad_b = 0, 0, 34, 22
  local lanes = state.use_z_motion and { "X", "Y", "Z" } or { "X", "Y" }
  local n_lanes = #lanes
  local gap     = 6
  local lane_h  = (H - pad_t - pad_b - gap * (n_lanes - 1)) / n_lanes
  local pw      = W - pad_l - pad_r

  -- Time grid: ticks every 1 / 5 / 10 / 30 / 60 s depending on length
  local tick = 1
  for _, cand in ipairs({ 1, 2, 5, 10, 30, 60, 120, 300 }) do
    tick = cand
    if region_len / cand <= 24 then break end
  end

  local enabled = score_enabled_sources()
  local n       = #enabled
  local params  = preview_params()
  local TSTEPS  = math.max(96, math.min(768, math.floor(W / 3)))
  -- synced: repeating cycles over the region; free: one cycle over the region
  local synced  = state.bpm_sync and r0 and r1
  local score_eval
  if synced then
    local f = make_synced_compute(r0, r1)
    score_eval = function(shape, raw_t, si, nn, pp) return f(shape, raw_t, si, nn, pp) end
    TSTEPS = math.max(TSTEPS, math.min(3000, math.floor(W / 2)))
  else
    score_eval = function(shape, raw_t, si, nn, pp) return computeAED(shape, transform_t(raw_t), si, nn, pp) end
  end
  -- bar lines (fractions of the region) for the synced grid
  local bars = {}
  if synced then
    local _, m0 = reaper.TimeMap2_timeToBeats(0, r0)
    local m = (m0 or 0)
    while true do
      local bt = reaper.TimeMap2_beatsToTime(0, 0, m)
      if bt > r1 + 1e-6 then break end
      if bt >= r0 - 1e-6 then bars[#bars + 1] = { (bt - r0) / region_len, m + 1 } end
      m = m + 1
      if #bars > 2000 then break end
    end
  end

  for li, lane in ipairs(lanes) do
    local ly = pad_t + (li - 1) * (lane_h + gap)
    cv:fill_rect(pad_l, ly, pw, lane_h, 0.04, 0.05, 0.07, 1)
    -- center + quarter lines
    for _, f in ipairs({ 0.25, 0.5, 0.75 }) do
      local g = f == 0.5 and 0.19 or 0.11
      cv:line(pad_l, ly + lane_h * f, pad_l + pw, ly + lane_h * f, g, g + 0.04, g + 0.08, 1, f == 0.5 and 2 or 1, true)
    end
    -- time ticks (seconds) or bar lines (synced)
    if synced then
      for _, bl in ipairs(bars) do
        local gx = pad_l + bl[1] * pw
        cv:line(gx, ly, gx, ly + lane_h, 0.22, 0.26, 0.32, 1, 2, true)
      end
    else
      local tt = 0
      while tt <= region_len + 1e-9 do
        local gx = pad_l + (tt / region_len) * pw
        local g  = 0.13
        cv:line(gx, ly, gx, ly + lane_h, g, g + 0.04, g + 0.08, 1, 1, true)
        tt = tt + tick
      end
    end
    -- lane label + range
    local lo, hi
    if lane == "Z" then lo, hi = "0", score_fmt(sc) else lo, hi = score_fmt(-sc), score_fmt(sc) end
    cv:text(lane, pad_l + 8, ly + 6, 3, 0.55, 0.62, 0.70, 1)
    cv:text(hi, pad_l + 34, ly + 6, FS, 0.36, 0.44, 0.54, 1)
    cv:text(lo, pad_l + 34, ly + lane_h - 16, FS, 0.36, 0.44, 0.54, 1)

    -- trails
    for ci, src in ipairs(enabled) do
      local shape = state.motion_by_source[src] or "line"
      local col   = COLORS[((ci - 1) % #COLORS) + 1]
      local r, g, b = score_mix(col, 0.85)
      local prev_gx, prev_gy
      for i = 0, TSTEPS do
        local raw_t = i / TSTEPS
        local az, el, d = score_eval(shape, raw_t, src - 1, n, params)
        local v
        if lane == "X" then v = az / 180 elseif lane == "Y" then v = el / 90 else v = d * 2 - 1 end
        local gx = pad_l + raw_t * pw
        local gy = ly + lane_h / 2 - clamp(v, -1, 1) * (lane_h / 2 - 3)
        if prev_gx then
          if math.abs(gy - prev_gy) < lane_h * 0.6 then
            cv:line(prev_gx, prev_gy, gx, gy, r, g, b, 1, 2.5, i == 1)
          end
        end
        prev_gx, prev_gy = gx, gy
      end
    end
  end

  -- Time labels along the bottom (bar numbers when synced)
  local tt, last_lx = 0, -1e9
  if synced then
    for _, bl in ipairs(bars) do
      local gx  = pad_l + bl[1] * pw
      local lbl = "T" .. bl[2]
      if gx + 3 - last_lx > 36 then
        cv:text(lbl, gx + 3, H - pad_b + 6, FS, 0.40, 0.50, 0.60, 1)
        last_lx = gx + 3
      end
    end
    tt = region_len + 1   -- skip the seconds loop
  end
  while tt <= region_len + 1e-9 do
    local gx  = pad_l + (tt / region_len) * pw
    local lbl = score_fmt(tt) .. "S"
    local lx  = gx + 3
    if lx + cv:text_width(lbl, FS) > W then lx = gx - 3 - cv:text_width(lbl, FS) end
    if lx - last_lx > 48 then
      cv:text(lbl, lx, H - pad_b + 6, FS, 0.36, 0.44, 0.54, 1)
      last_lx = lx
    end
    tt = tt + tick
  end

  -- Header
  local title = string.format("%s   %s S   %d SRC", region_name, score_fmt(region_len), n)
  cv:text(title, 8, 8, 3, 0.86, 0.90, 0.92, 1)
  local foot = synced and string.format("AMBIENCODER64 MOTION MAP V2.4  -  TIME  -  %s BEATS/CYCLE", score_fmt(sync_cycle_beats()))
                       or "AMBIENCODER64 MOTION MAP V2.4  -  TIME"
  cv:text(foot, W - 8 - cv:text_width(foot, FS), 10, FS, 0.30, 0.36, 0.42, 1)
  return cv
end

-- ── Target region + REAPER item insertion ────────────────────────────────────
local function score_target_region()
  -- 1) time selection
  local ts0, ts1 = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
  if ts1 > ts0 then
    return ts0, ts1, state.region_name or "Region"
  end
  -- 2) region at edit cursor
  local pos = reaper.GetCursorPosition()
  local _, ridx = reaper.GetLastMarkerAndCurRegion(0, pos)
  if ridx and ridx >= 0 then
    local _, isrgn, r0, r1, name = reaper.EnumProjectMarkers(ridx)
    if isrgn and r1 > r0 then return r0, r1, (name ~= "" and name or "Region") end
  end
  -- 3) region with the configured name
  local want = state.region_name or ""
  local i = 0
  while true do
    local ret, isrgn, r0, r1, name = reaper.EnumProjectMarkers(i)
    if ret == 0 then break end
    if isrgn and name == want and r1 > r0 then return r0, r1, name end
    i = i + 1
  end
  return nil
end

local function score_find_track()
  for i = 0, reaper.CountTracks(0) - 1 do
    local tr = reaper.GetTrack(0, i)
    local _, name = reaper.GetTrackName(tr)
    if name == SCORE_TRACK_NAME then return tr end
  end
  return nil
end

local function score_file_path(region_name)
  local dir = reaper.GetProjectPath("")
  if not dir or dir == "" then dir = script_dir() end
  dir = join_path(dir, "MotionScores")
  reaper.RecursiveCreateDirectory(dir, 0)
  local safe = tostring(region_name):gsub("[^%w%-_]+", "_")
  return join_path(dir, string.format("Score_%s_%s.png", safe, os.date("%Y%m%d-%H%M%S")))
end

local function score_insert_item(path, r0, r1, region_name)
  reaper.Undo_BeginBlock()
  reaper.PreventUIRefresh(1)

  local tr = score_find_track()
  if not tr then
    reaper.InsertTrackAtIndex(0, true)
    tr = reaper.GetTrack(0, 0)
    reaper.GetSetMediaTrackInfo_String(tr, "P_NAME", SCORE_TRACK_NAME, true)
    reaper.SetMediaTrackInfo_Value(tr, "I_HEIGHTOVERRIDE", 120)
  end
  -- Remove earlier score items overlapping the region
  for i = reaper.CountTrackMediaItems(tr) - 1, 0, -1 do
    local it  = reaper.GetTrackMediaItem(tr, i)
    local pos = reaper.GetMediaItemInfo_Value(it, "D_POSITION")
    local len = reaper.GetMediaItemInfo_Value(it, "D_LENGTH")
    if pos < r1 - 1e-6 and pos + len > r0 + 1e-6 then
      reaper.DeleteTrackMediaItem(tr, it)
    end
  end

  local cur = reaper.GetCursorPosition()
  reaper.SelectAllMediaItems(0, false)
  reaper.SetOnlyTrackSelected(tr)
  reaper.SetEditCurPos(r0, false, false)
  reaper.InsertMedia(path, 0)  -- 0 = add to current (selected) track at edit cursor

  local it = reaper.GetSelectedMediaItem(0, 0)
  if it then
    if reaper.GetMediaItem_Track(it) ~= tr then reaper.MoveMediaItemToTrack(it, tr) end
    reaper.SetMediaItemInfo_Value(it, "D_POSITION", r0)
    reaper.SetMediaItemInfo_Value(it, "D_LENGTH",   r1 - r0)
    reaper.SetMediaItemInfo_Value(it, "B_LOOPSRC",  0)
    local tk = reaper.GetActiveTake(it)
    if tk then reaper.GetSetMediaItemTakeInfo_String(tk, "P_NAME", "Score: " .. region_name, true) end
    reaper.GetSetMediaItemInfo_String(it, "P_NOTES",
      "AmbiEncoder64 Motion Map score (" .. (state.score_mode or "xy") .. ")\n" .. path, true)
  end
  reaper.SetEditCurPos(cur, false, false)

  reaper.PreventUIRefresh(-1)
  reaper.UpdateArrange()
  reaper.Undo_EndBlock("Insert Motion Map score image", -1)
  return it ~= nil
end

function score_export()
  local r0, r1, rname = score_target_region()
  if not r0 then
    reaper.MB("Keine Ziel-Region gefunden.\nTime Selection setzen, Edit-Cursor in eine Region stellen\noder zuerst die Automation + Region schreiben.", SCRIPT_NAME, 0)
    return
  end
  if #score_enabled_sources() == 0 then
    reaper.MB("Bitte mindestens eine Source aktivieren.", SCRIPT_NAME, 0)
    return
  end
  local len  = r1 - r0
  local mode = state.score_mode or "xy"
  local cv
  if mode == "time" then
    cv = score_render_time(1920, 540, rname, len, r0, r1)
  else
    cv = score_render_xy(1280, 640, rname, len)
  end
  local path = score_file_path(rname)
  local f = io.open(path, "wb")
  if not f then
    reaper.MB("Score-Bild konnte nicht geschrieben werden:\n" .. path, SCRIPT_NAME, 0)
    return
  end
  f:write(cv:to_png())
  f:close()
  if score_insert_item(path, r0, r1, rname) then
    state.status = string.format("✓ Score (%s) inserted on '%s' over %s  [%.1f s]", mode, SCORE_TRACK_NAME, rname, len)
  else
    state.status = "Score PNG written, but item insertion failed: " .. path
  end
end

local function draw_trajectory_preview()
  -- Panel background
  draw_rect(PREV_X, PREV_Y, PREV_W, PREV_H, 0.055, 0.065, 0.085, 1, true)
  draw_rect(PREV_X, PREV_Y, PREV_W, PREV_H, 0.15, 0.19, 0.25, 1, false)

  -- Title
  gfx.setfont(2, "Arial", 12)
  draw_text("TRAJECTORY PREVIEW", PREV_X + 8, PREV_Y + 7, 0.40, 0.50, 0.58)
  if state.bpm_sync then
    -- tempo-sync info: BPM · bars per cycle · cycles over the time selection
    gfx.setfont(2, "Arial", 11)
    local ts0, ts1 = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
    if ts1 > ts0 then
      local cyc, bars, bpm = sync_info(ts0, ts1)
      draw_text(string.format("♩ %.0f BPM · %s Takte/Zyklus · %.2f Zyklen", bpm, score_fmt(bars), cyc), PREV_X + 150, PREV_Y + 8, 0.40, 0.85, 0.70)
    else
      draw_text(string.format("♩ %.0f BPM · keine Time Selection", sync_bpm_at(reaper.GetCursorPosition())), PREV_X + 150, PREV_Y + 8, 0.70, 0.55, 0.30)
    end
  end
  gfx.setfont(1, "Arial", 16)

  -- Score export controls (top-right of the panel)
  local bx = PREV_X + PREV_W - 8
  if draw_button("⤓ Score → Region", bx - 130, PREV_Y + 4, 130, 20, true, false) then
    score_export()
  end
  bx = bx - 130 - 8
  if draw_button("Time", bx - 44, PREV_Y + 4, 44, 20, state.score_mode == "time", false) then
    state.score_mode = "time"
  end
  bx = bx - 44 - 4
  if draw_button("XY", bx - 36, PREV_Y + 4, 36, 20, state.score_mode ~= "time", false) then
    state.score_mode = "xy"
  end

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
  local anim_t = transform_t(anim_phase(reaper.time_precise()))
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

  -- Preview transport (v2.4.4): speed / direction / play / stop (preview + live OSC only)
  y = y + 40
  draw_input("anim_speed", "Speed \195\151", x, y, 80)
  if draw_button(state.anim_rev and "< Rev" or "> Fwd", x + 92, y + 16, 80, 22, state.anim_rev, false) then
    state.anim_rev = not state.anim_rev; state.focus = nil
  end
  if draw_button("\226\150\182 Play", x + 180, y + 16, 80, 22, state.anim_run, false) then
    state.anim_run = true; state.focus = nil
    if state.sync_transport and (reaper.GetPlayState() & 1) == 0 then reaper.Main_OnCommand(1007, 0) end
  end
  if draw_button("\226\150\160 Stop", x + 268, y + 16, 80, 22, not state.anim_run, false) then
    state.anim_run = false; state.focus = nil
    if state.sync_transport and (reaper.GetPlayState() & 1) == 1 then reaper.Main_OnCommand(1016, 0) end
  end
  if draw_button(state.sync_transport and "Sync \226\156\147" or "Sync", x + 356, y + 16, 80, 22, state.sync_transport, false) then
    state.sync_transport = not state.sync_transport; state.focus = nil
    state.status = state.sync_transport and "Sync ON \226\128\148 preview follows REAPER play/stop; Play/Stop here start/stop REAPER"
                                         or "Sync OFF \226\128\148 preview runs on its own"
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
  state.anim_speed, state.anim_rev, state.anim_run = "1.00", false, true
  state.time_quant_steps  = "0"
  state.space_quant_x, state.space_quant_y, state.space_quant_z = "0.00", "0.00", "0.00"
  state.steps_per_second  = "12"
  state.bpm_sync = false; state.cycle_beats = "16"; state.steps_per_beat = "4"; state.quant_start = true
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

-- Write button + Reset at a fixed position (shown under both tabs)
local WRITE_Y = SET_Y + 434
function draw_write_bar()
  local x, y = SET_X, WRITE_Y - 10
  draw_rect(x, y, PREV_W, 1, 0.14, 0.18, 0.22, 1, true)
  y = y + 10
  if draw_button("▶  Write Automation + Region", x, y, PREV_W - 92, 40, true, false) then
    write_automation()
  end
  if draw_button("⟲ Reset", x + PREV_W - 86, y + 8, 80, 24, false, false) then
    reset_params()
  end
end

local function draw_settings()
  local x     = SET_X
  local y     = SET_Y
  local col_w = 126

  local cnt = 0
  for s = 1, 64 do if state.source_enabled[s] then cnt = cnt + 1 end end

  -- Tabs: SETTINGS | FIGURE EDITOR
  gfx.setfont(2, "Arial", 12)
  if draw_button("SETTINGS", x, y - 4, 96, 20, state.right_tab ~= "figure", false) then
    state.right_tab = "settings"; state.focus = nil
  end
  local fig_lbl = "FIGURE EDITOR  ·  S" .. (state.selected_source - 1)
  if draw_button(fig_lbl, x + 102, y - 4, 150, 20, state.right_tab == "figure", false) then
    state.right_tab = "figure"; state.focus = nil
  end
  draw_text(tostring(cnt) .. " / 64 active", x + PREV_W - 88, y, 0.65, 0.74, 0.72)
  gfx.setfont(1, "Arial", 16)

  if state.right_tab == "figure" then
    draw_figure_editor(x, y + 26, PREV_W)
    draw_write_bar()
    return
  end

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
  if state.bpm_sync then
    draw_input("steps_per_beat",   "Steps/beat  (BPM ✓)", x, y, col_w)
  else
    draw_input("steps_per_second", "Steps/sec",          x, y, col_w)
  end
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

  -- ── Output options ────────────────────────────────────────────────────
  y = y + 38
  draw_input("region_name", "Region name", x, y, col_w * 2 + 6)
  -- Tempo sync (Kristall-style): BPM toggle · cycle length in beats · bar-line lock
  local sx = x + col_w * 2 + 18
  if draw_button(state.bpm_sync and "BPM ✓" or "BPM", sx, y + 16, 62, 22, state.bpm_sync, false) then
    state.bpm_sync = not state.bpm_sync; state.focus = nil
    state.status = state.bpm_sync and "Tempo sync ON — cycle in beats, steps per beat, phase locked to bars"
                                   or "Tempo sync OFF — one cycle over the time selection, steps/sec"
  end
  draw_input("cycle_beats", "Zyklus (Beats)", sx + 70, y, 66)
  state.quant_start = draw_toggle("Taktstart", state.quant_start, sx + 146, y + 19)

  -- Toggles — 2 per row
  y = y + 50
  -- Quantize (any figure): time slices per cycle + spatial rounding step per axis (0 = off)
  do
    local qx, qw = x + 330, 56
    draw_input("time_quant_steps", "Quant T", qx,               y - 4, qw)
    draw_input("space_quant_x",   "Q X",     qx + (qw + 4),     y - 4, qw)
    draw_input("space_quant_y",   "Q Y",     qx + (qw + 4) * 2, y - 4, qw)
    draw_input("space_quant_z",   "Q Z",     qx + (qw + 4) * 3, y - 4, qw)
  end
  state.clear_existing   = draw_toggle("Clear existing",  state.clear_existing,   x,        y)
  state.set_latch        = true   -- tracks are always written in Latch mode
  gfx.setfont(2, "Arial", 12)
  draw_text("Automation: Latch", x + 164 + 28, y + 5, 0.40, 0.50, 0.58)
  gfx.setfont(1, "Arial", 16)
  y = y + 28
  state.overwrite_region = draw_toggle("Overwrite region", state.overwrite_region, x,        y)
  state.use_z_motion     = draw_toggle("Use Z motion",     state.use_z_motion,     x + 164,  y)

  y = y + 28
  local sel_info = "Selected  S" .. tostring(state.selected_source - 1)
                   .. "  →  " .. motion_label(state.motion_by_source[state.selected_source])
  draw_text(sel_info, x, y, 0.36, 0.74, 0.58)
  if draw_button("Figur bearbeiten ▸", x + PREV_W - 150, y - 4, 150, 22, false, false) then
    state.right_tab = "figure"; state.focus = nil
  end

  draw_write_bar()
end


-- ── Figure editor (v2.3) ──────────────────────────────────────────────────────
-- Drawn as a tab of the right column (under the trajectory preview), so the
-- window keeps its size; the main preview shows the edited figure live.
local function fig_target_table()
  local sel   = state.selected_source
  local shape = state.motion_by_source[sel] or "line"
  if state.fig_scope == "source" then
    state.source_params[sel] = state.source_params[sel] or {}
    return state.source_params[sel]
  end
  state.shape_params[shape] = state.shape_params[shape] or {}
  return state.shape_params[shape]
end

local function fig_fmt(v, is_int)
  if is_int then return tostring(math.floor(v + 0.5)) end
  return string.format("%.2f", v)
end

-- draw_figure_editor(x, y, w): x,y top-left under the tab row; w = column width
function draw_figure_editor(x, y, w)
  local sel   = state.selected_source
  local shape = state.motion_by_source[sel] or "line"
  local col3  = math.floor((w - 12) / 3)

  -- Header: source · figure, scope buttons
  draw_text(string.format("S%d  ·  %s", sel - 1, motion_label(shape)), x, y, 0.36, 0.74, 0.58)
  if draw_button("Figur: alle Quellen", x + w - 266, y - 3, 150, 22, state.fig_scope ~= "source", false) then
    state.fig_scope = "shape"; state.focus = nil
  end
  if draw_button("Nur S" .. (sel - 1), x + w - 110, y - 3, 110, 22, state.fig_scope == "source", false) then
    state.fig_scope = "source"; state.focus = nil
  end
  y = y + 24
  gfx.setfont(2, "Arial", 11)
  if state.fig_scope == "source" then
    draw_text("Werte gelten nur für diese Quelle (überschreiben die Figur).", x, y, 0.40, 0.46, 0.52)
  else
    local ov = state.source_params[sel]
    local has = ov and next(ov) ~= nil
    draw_text(has and ("Gilt für alle Quellen mit dieser Figur — S" .. (sel - 1) .. " hat zusätzlich eigene Werte.")
                  or "Gilt für alle Quellen mit dieser Figur. Zum Ändern einer Figur: Spalte anklicken oder Icon der Quelle erneut klicken.",
              x, y, has and 0.86 or 0.40, has and 0.70 or 0.46, has and 0.30 or 0.52)
  end
  gfx.setfont(1, "Arial", 16)
  y = y + 20

  -- Parameter sliders, 3 per row (bound to state["fp_<key>"], synced with the param tables)
  local merged = (state.fig_scope == "source") and figure_params(shape, sel) or figure_params(shape, nil)
  local target = nil
  local function slider_cell(def, cx, cy, cw)
    local key, label, mn, mx, is_int = def[1], def[2], def[3], def[4], def[6]
    local id = "fp_" .. key
    local cur = merged[key]
    if cur == nil then cur = def[5] end
    if state.focus ~= id and _sld.id ~= id then state[id] = fig_fmt(cur, is_int) end
    draw_slider(id, label, cx, cy, cw, mn, mx, is_int)
    local nv = tonumber(state[id])
    if nv and math.abs(nv - cur) > 1e-9 then
      nv = clamp(nv, mn, mx)
      if is_int then nv = math.floor(nv + 0.5) end
      target = target or fig_target_table()
      target[key] = nv
    end
  end
  local function slider_rows(defs, cy)
    local i = 1
    while i <= #defs do
      for c = 0, 2 do
        local d = defs[i + c]
        if d then slider_cell(d, x + c * (col3 + 6), cy, col3) end
      end
      cy = cy + 44
      i = i + 3
    end
    return cy
  end

  gfx.setfont(2, "Arial", 12)
  draw_text("FIGUR", x, y, 0.40, 0.50, 0.58)
  gfx.setfont(1, "Arial", 16)
  y = y + 16
  local defs = SHAPE_PARAMS[shape] or {}
  if #defs == 0 then
    gfx.setfont(2, "Arial", 12)
    draw_text("Diese Figur hat keine eigenen Parameter — nur die Transformation unten.", x, y + 2, 0.40, 0.46, 0.52)
    gfx.setfont(1, "Arial", 16)
    y = y + 26
  else
    y = slider_rows(defs, y)
  end

  y = y + 2
  draw_rect(x, y, w, 1, 0.14, 0.18, 0.22, 1, true)
  y = y + 8
  gfx.setfont(2, "Arial", 12)
  draw_text("TRANSFORMATION", x, y, 0.40, 0.50, 0.58)
  gfx.setfont(1, "Arial", 16)
  y = y + 16
  y = slider_rows(GENERIC_PARAMS, y)

  -- Reset buttons (right-aligned, above the write bar)
  y = y + 2
  if draw_button("Figur zurücksetzen", x, y, 150, 24, false, false) then
    if state.fig_scope == "source" then state.source_params[sel] = nil
    else state.shape_params[shape] = nil end
    state.focus = nil
    state.status = "Figure parameters reset (" .. (state.fig_scope == "source" and ("S" .. (sel - 1)) or motion_label(shape)) .. ")"
  end
  if draw_button("Alle Figuren zurücksetzen", x + 156, y, 180, 24, false, false) then
    state.shape_params, state.source_params = {}, {}
    state.focus = nil
    state.status = "All figure parameters reset"
  end
  if draw_button("◂ Settings", x + w - 100, y, 100, 24, false, false) then
    state.right_tab = "settings"; state.focus = nil
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


-- Load the writer source, inject the figure hook, run it.
-- The writer (JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua) computes positions in
-- xyz_motion_values(source, source_count, progress, settings) and returns normalised
-- { x, y, z } in [0,1]. The hook delegates to _S.compute_xyz with the same signature so
-- figure parameters and tempo sync are written exactly as previewed.
-- Returns true if the hook was injected, false if the plain writer was run.
function run_writer_with_figures(path)
  local f = io.open(path, "rb")
  if not f then dofile(path); return false end
  local code = f:read("*a"); f:close()
  -- The writer consumes (nils) _G.JS_AMBIENCODER64_SETTINGS after reading it, so the hook
  -- uses its own global _G.JS_AMBIENCODER64_COMPUTE_XYZ (set in write_automation).
  local hook = "\n  do local _f = _G.JS_AMBIENCODER64_COMPUTE_XYZ; "
            .. "if _f then local _r = _f(source, source_count, progress, settings); "
            .. "if _r then return _r end end end\n"
  local patched, n = code:gsub("(\n%s*local%s+function%s+xyz_motion_values%s*%(%s*source%s*,%s*source_count%s*,%s*progress%s*,%s*settings%s*%))",
                               "%1" .. hook, 1)
  if n == 0 then dofile(path); return false end
  local chunk, err = load(patched, "=" .. path)
  if not chunk then
    reaper.ShowConsoleMsg(SCRIPT_NAME .. ": Writer-Patch fehlgeschlagen, Fallback ohne Figuren.\n" .. tostring(err) .. "\n")
    dofile(path); return false
  end
  local okrun, err2 = pcall(chunk)
  _G.JS_AMBIENCODER64_COMPUTE_XYZ = nil
  if not okrun then error(err2, 0) end
  return true
end

-- Build the compute_xyz function handed to the writer: GUI trajectory (figure params,
-- palindrome / time curve, optional tempo sync) → normalised x/y/z like the writer.
local function make_compute_xyz(ts0, ts1)
  local P = preview_params()
  local amount = clamp(tonumber(state.motion_amount) or 1, 0, 8)
  P.az_spr = P.az_spr * amount
  P.el_spr = P.el_spr * amount
  P.z_spr  = P.z_spr  * amount
  local synced = state.bpm_sync and ts0 and ts1 and ts1 > ts0
  local anchor = synced and sync_anchor_beats(ts0) or 0
  local len    = synced and math.max(1e-9, ts1 - ts0) or 1
  return function(source, source_count, progress, settings)
    local shape = (settings and settings.motion_map and settings.motion_map[source])
               or state.motion_by_source[source] or "line"
    local t
    if synced then
      t = transform_t(sync_cycle_phase(ts0 + progress * len, anchor))
    else
      t = transform_t(progress)
    end
    local az, el, d = computeAED(shape, t, source - 1, source_count, P)
    local x = (0.5 + az / 360) % 1.0
    if x < 0 then x = x + 1.0 end
    return { x = clamp(x, 0, 1), y = clamp(0.5 + el / 180, 0, 1), z = clamp(d, 0, 1) }
  end
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
    steps_per_second = state.steps_per_second,   -- replaced below in sync mode
    azimuth_center   = tostring(w_az_c),
    azimuth_spread   = tostring(w_az_s),
    elevation_center = tostring(w_el_c),
    elevation_spread = tostring(w_el_s),
    distance_center  = tostring(w_z_c),
    distance_spread  = tostring(w_z_s),
    motion_amount         = state.motion_amount,
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
    -- v2.3/2.4: figure parameters + the GUI's own trajectory function (compute_xyz),
    -- used by the writer via run_writer_with_figures() so edits are written 1:1.
    shape_params     = state.shape_params,
    source_params    = state.source_params,
  }
  do
    local S = _G.JS_AMBIENCODER64_SETTINGS
    local ts0, ts1 = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
    S.compute_xyz = make_compute_xyz(ts0, ts1)
    _G.JS_AMBIENCODER64_COMPUTE_XYZ = S.compute_xyz   -- survives the writer nil-ing its settings global
    if state.bpm_sync and ts1 > ts0 then
      -- Tempo sync: steps per beat → steps/sec at the selection start
      S.steps_per_second = tostring((tonumber(state.steps_per_beat) or 4) * sync_bpm_at(ts0) / 60)
      S.tempo_sync       = { cycle_beats = sync_cycle_beats(), steps_per_beat = tonumber(state.steps_per_beat) or 4,
                             quant_start = state.quant_start, anchor_beats = sync_anchor_beats(ts0) }
    end
  end

  -- Run the writer with the GUI's trajectory function injected (figure params, tempo
  -- sync); if the hook point is not found we fall back to the plain writer.
  local fig_ok = run_writer_with_figures(path)
  state.status = "✓ Automation written for " .. #sources .. " source(s)"
             .. (fig_ok and (state.bpm_sync and "   (tempo-synced)" or "")
                 or "   (Writer ohne Hook — Figur-Parameter/Tempo-Sync nicht angewendet)")
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
  draw_text("AmbiEncoder64 Motion Map   v2.4.5", GRID_X, 10, 0.88, 0.92, 0.94)
  gfx.setfont(2, "Arial", 12)
  draw_text("Assign motion shapes to sources, edit the figures in the Figure Editor, preview, then write XYZ automation over the time selection — or export the preview as a score image.",
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
  if state.sync_transport then state.anim_run = (reaper.GetPlayState() & 1) == 1 end
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
