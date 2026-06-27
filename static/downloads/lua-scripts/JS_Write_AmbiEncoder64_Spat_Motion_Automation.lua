-- @description Write AmbiEncoder64 Spat Motion Automation
-- @author JS / Codex
-- @version 1.0
-- @about
--   Writes generated spat movements for up to 64 ICST AmbiEncoder_64 sources
--   into FX parameter envelopes over the current REAPER time selection.
--
--   Workflow:
--   - Select exactly one track containing ICST AmbiEncoder_64
--   - Create a loop/time selection
--   - Run this script
--   - Confirm source count, density and motion range

local SCRIPT_NAME = "Write AmbiEncoder64 Spat Motion Automation"

local AMBI_FX_NAME_MATCH = "ambiencoder"
local DEFAULT_SOURCE_RANGE = "1-64"
local DEFAULT_STEPS_PER_SECOND = 12
local DEFAULT_AZIMUTH_CENTER = 0
local DEFAULT_AZIMUTH_SPREAD = 320
local DEFAULT_ELEVATION_CENTER = 0
local DEFAULT_ELEVATION_SPREAD = 50
local DEFAULT_DISTANCE_CENTER = 0.75
local DEFAULT_DISTANCE_SPREAD = 0.35
local DEFAULT_MOTION_AMOUNT = 1.0
local DEFAULT_USE_Z_MOTION = true
local DEFAULT_CLEAR_EXISTING = true
local DEFAULT_SET_LATCH = true
local DEFAULT_HIDE_NON_TARGET_ENVELOPES = true
local BOUNDARY_TRIGGER_SEC = 0.005
local DEFAULT_MOTION_MAP = "auto"
local DEFAULT_REGION_NAME = "BFormat_TS"
local DEFAULT_OVERWRITE_REGION = true
local ICST_XYZ_FIRST_UI_PARAM = 11
local ICST_XYZ_SOURCE_STRIDE = 5
local AUTO_MOTION_SHAPES = {
  "line",
  "arc_up",
  "arc_down",
  "s_curve",
  "step",
  "zigzag",
  "circle",
  "spiral",
  "fourier_xyz",
}

local function clamp(value, min_value, max_value)
  if value < min_value then return min_value end
  if value > max_value then return max_value end
  return value
end

local function round(value)
  return math.floor(value + 0.5)
end

local function trim(value)
  return tostring(value or ""):match("^%s*(.-)%s*$")
end

local function bool_from_text(value, default_value)
  local normalized = trim(value):lower()
  if normalized == "" then return default_value end
  return normalized == "1" or normalized == "yes" or normalized == "y" or normalized == "true" or normalized == "ja" or normalized == "j"
end

local function parse_number(value, default_value)
  local normalized = trim(value):gsub(",", ".")
  local parsed = tonumber(normalized)
  if parsed == nil then return default_value end
  return parsed
end

local function parse_source_range(text)
  local sources = {}
  local seen = {}

  for token in tostring(text or ""):gmatch("[^;%s]+") do
    local left, right = token:match("^(%d+)%s*[-:]%s*(%d+)$")
    if left and right then
      local first = clamp(tonumber(left), 1, 64)
      local last = clamp(tonumber(right), 1, 64)
      local step = first <= last and 1 or -1
      for source = first, last, step do
        if not seen[source] then
          sources[#sources + 1] = source
          seen[source] = true
        end
      end
    else
      local source = tonumber(token)
      if source then
        source = clamp(math.floor(source), 1, 64)
        if not seen[source] then
          sources[#sources + 1] = source
          seen[source] = true
        end
      end
    end
  end

  table.sort(sources)
  return sources
end

local function normalize_motion_shape(shape)
  local normalized = trim(shape):lower():gsub("-", "_")
  local aliases = {
    auto = "auto",
    line = "line",
    linie = "line",
    diagonal = "line",
    ramp = "line",
    arc = "arc_up",
    arc_up = "arc_up",
    arcup = "arc_up",
    bow = "arc_up",
    bogen = "arc_up",
    arc_down = "arc_down",
    arcdown = "arc_down",
    bow_down = "arc_down",
    s = "s_curve",
    s_curve = "s_curve",
    scurve = "s_curve",
    sigmoid = "s_curve",
    step = "step",
    steps = "step",
    treppe = "step",
    square = "step",
    zigzag = "zigzag",
    zig_zag = "zigzag",
    zickzack = "zigzag",
    circle = "circle",
    kreis = "circle",
    loop = "circle",
    spiral = "spiral",
    fourier = "fourier_xyz",
    fourier_xyz = "fourier_xyz",
    fourierxyz = "fourier_xyz",
    fourier3d = "fourier_xyz",
    lissajous = "lissajous",
    eight = "lissajous",
    acht = "lissajous",
  }
  return aliases[normalized]
end

local function add_motion_map_entry(motion_map, source_text, shape)
  local sources = parse_source_range(source_text)
  if #sources == 0 then return end
  for _, source in ipairs(sources) do
    motion_map[source] = shape
  end
end

local function parse_motion_map(text)
  local motion_map = {}
  local default_shape = nil
  local input = trim(text)
  if input == "" or input:lower() == "auto" then
    return motion_map
  end

  local single_shape = normalize_motion_shape(input)
  if single_shape and single_shape ~= "auto" then
    motion_map.default = single_shape
    return motion_map
  end

  for token in input:gmatch("[^;%s]+") do
    local source_text, shape_text = token:match("^([^=]+)=([^=]+)$")
    if not source_text then
      source_text, shape_text = token:match("^([^:]+):([^:]+)$")
    end
    if source_text and shape_text then
      local shape = normalize_motion_shape(shape_text)
      if shape and shape ~= "auto" then
        add_motion_map_entry(motion_map, source_text, shape)
      elseif shape == "auto" then
        add_motion_map_entry(motion_map, source_text, nil)
      end
    else
      local shape = normalize_motion_shape(token)
      if shape and shape ~= "auto" then
        default_shape = shape
      end
    end
  end

  motion_map.default = default_shape
  return motion_map
end

local function get_time_selection()
  local start_pos, end_pos = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
  if end_pos <= start_pos then
    return nil, nil
  end
  return start_pos, end_pos
end

local function get_selected_track()
  if reaper.CountSelectedTracks(0) ~= 1 then
    return nil
  end
  return reaper.GetSelectedTrack(0, 0)
end

local function get_track_name(track)
  local _, name = reaper.GetTrackName(track)
  return name or "Selected Track"
end

local function find_ambi_fx(track)
  for fx_index = 0, reaper.TrackFX_GetCount(track) - 1 do
    local _, fx_name = reaper.TrackFX_GetFXName(track, fx_index, "")
    local normalized = (fx_name or ""):lower()
    if normalized:find(AMBI_FX_NAME_MATCH, 1, true) then
      return fx_index, fx_name
    end
  end
  return nil, nil
end

local function param_kind(name)
  local normalized = (name or ""):lower()
  if normalized:match("^%s*x%s*%d*%s*$") or normalized:match(":%s*x%s*$") then
    return "x"
  end
  if normalized:match("^%s*y%s*%d*%s*$") or normalized:match(":%s*y%s*$") then
    return "y"
  end
  if normalized:match("^%s*z%s*%d*%s*$") or normalized:match(":%s*z%s*$") then
    return "z"
  end
  if normalized:find("azim", 1, true) or normalized:find("azimuth", 1, true) then
    return "azimuth"
  end
  if normalized:find("elev", 1, true) or normalized:find("elevation", 1, true) then
    return "elevation"
  end
  if normalized:find("dist", 1, true) or normalized:find("distance", 1, true) or normalized:find("radius", 1, true) then
    return "distance"
  end
  return nil
end

local function source_number_from_param_name(name)
  local normalized = (name or ""):lower()
  local patterns = {
    "source%s*#?%s*(%d+)",
    "src%s*#?%s*(%d+)",
    "input%s*#?%s*(%d+)",
    "ch%s*#?%s*(%d+)",
    "#%s*(%d+)",
  }

  for _, pattern in ipairs(patterns) do
    local source = tonumber(normalized:match(pattern))
    if source and source >= 1 and source <= 64 then return source end
  end

  for number in normalized:gmatch("(%d+)") do
    local source = tonumber(number)
    if source and source >= 1 and source <= 64 then return source end
  end

  return nil
end

local function discover_ambi_params(track, fx_index)
  local params_by_source = {}
  local ordered_by_kind = {
    x = {},
    y = {},
    z = {},
    azimuth = {},
    elevation = {},
    distance = {},
  }

  local param_count = reaper.TrackFX_GetNumParams(track, fx_index)
  for param_index = 0, param_count - 1 do
    local _, name = reaper.TrackFX_GetParamName(track, fx_index, param_index, "")
    local kind = param_kind(name)
    if kind then
      local entry = {
        index = param_index,
        name = name or ("Param " .. tostring(param_index + 1)),
        kind = kind,
      }
      ordered_by_kind[kind][#ordered_by_kind[kind] + 1] = entry

      local source = source_number_from_param_name(name)
      if source then
        params_by_source[source] = params_by_source[source] or {}
        params_by_source[source][kind] = entry
      end
    end
  end

  for source = 1, 64 do
    params_by_source[source] = params_by_source[source] or {}
    for kind, entries in pairs(ordered_by_kind) do
      if not params_by_source[source][kind] and entries[source] then
        params_by_source[source][kind] = entries[source]
      end
    end

    local first_api_param = (ICST_XYZ_FIRST_UI_PARAM - 1) + ((source - 1) * ICST_XYZ_SOURCE_STRIDE)
    if first_api_param + 2 < param_count then
      params_by_source[source].x = params_by_source[source].x or {
        index = first_api_param,
        name = "ICST Source " .. tostring(source) .. " X",
        kind = "x",
      }
      params_by_source[source].y = params_by_source[source].y or {
        index = first_api_param + 1,
        name = "ICST Source " .. tostring(source) .. " Y",
        kind = "y",
      }
      params_by_source[source].z = params_by_source[source].z or {
        index = first_api_param + 2,
        name = "ICST Source " .. tostring(source) .. " Z",
        kind = "z",
      }
    end
  end

  return params_by_source, ordered_by_kind
end

local function first_number(text)
  local normalized = tostring(text or ""):gsub(",", ".")
  return tonumber(normalized:match("[-+]?%d+%.?%d*"))
end

local function formatted_param_number(track, fx_index, param_index, normalized_value)
  reaper.TrackFX_SetParamNormalized(track, fx_index, param_index, normalized_value)
  local _, formatted = reaper.TrackFX_FormatParamValueNormalized(track, fx_index, param_index, normalized_value, "")
  return first_number(formatted)
end

local function calibrate_param(track, fx_index, param_index, kind)
  local original = reaper.TrackFX_GetParamNormalized(track, fx_index, param_index)
  local sample_low = formatted_param_number(track, fx_index, param_index, 0)
  local sample_mid = formatted_param_number(track, fx_index, param_index, 0.5)
  local sample_high = formatted_param_number(track, fx_index, param_index, 1)
  reaper.TrackFX_SetParamNormalized(track, fx_index, param_index, original)

  if sample_low and sample_high and math.abs(sample_high - sample_low) > 0.000001 then
    return {
      low = sample_low,
      high = sample_high,
      mid = sample_mid,
    }
  end

  if kind == "azimuth" then
    return { low = -180, high = 180, mid = 0 }
  end
  if kind == "elevation" then
    return { low = -90, high = 90, mid = 0 }
  end
  return { low = 0, high = 1, mid = 0.5 }
end

local function value_to_normalized(value, calibration, kind)
  if kind == "azimuth" then
    while value < calibration.low do value = value + 360 end
    while value > calibration.high do value = value - 360 end
  end
  return clamp((value - calibration.low) / (calibration.high - calibration.low), 0, 1)
end

local function set_envelope_ready(env)
  if reaper.SetEnvelopeInfo_Value then
    reaper.SetEnvelopeInfo_Value(env, "B_ACTIVE", 1)
    reaper.SetEnvelopeInfo_Value(env, "B_VISIBLE", 1)
    reaper.SetEnvelopeInfo_Value(env, "B_ARM", 1)
  end
end

local function hide_track_envelope(env)
  if reaper.SetEnvelopeInfo_Value then
    reaper.SetEnvelopeInfo_Value(env, "B_VISIBLE", 0)
    reaper.SetEnvelopeInfo_Value(env, "B_ARM", 0)
  end
end

local function triangle(phase)
  local wrapped = phase - math.floor(phase)
  if wrapped < 0.5 then
    return wrapped * 4 - 1
  end
  return 3 - wrapped * 4
end

local function smoothstep(value)
  return value * value * (3 - 2 * value)
end

local function wrap_degrees(value)
  while value < -180 do value = value + 360 end
  while value > 180 do value = value - 360 end
  return value
end

local function fourier_component(t, phase, terms)
  local sum = 0
  local weight_sum = 0
  local two_pi = math.pi * 2
  for _, term in ipairs(terms) do
    local weight = term[1]
    local frequency = term[2]
    local phase_offset = term[3] or 0
    sum = sum + weight * math.sin(two_pi * (frequency * t + phase + phase_offset))
    weight_sum = weight_sum + math.abs(weight)
  end
  if weight_sum <= 0.000001 then return 0 end
  return clamp(sum / weight_sum, -1, 1)
end

local function normalized_xyz_to_aed(x, y, z)
  local signed_x = (x - 0.5) * 2
  local signed_y = (y - 0.5) * 2
  local signed_z = (z - 0.5) * 2
  local planar = math.sqrt(signed_x * signed_x + signed_y * signed_y)
  local radius = math.sqrt(planar * planar + signed_z * signed_z)
  local azimuth = planar <= 0.000001 and 0 or math.deg(math.atan(signed_y, signed_x))
  local elevation = radius <= 0.000001 and 0 or math.deg(math.atan(signed_z, planar))
  return {
    azimuth = wrap_degrees(azimuth),
    elevation = clamp(elevation, -90, 90),
    distance = clamp(radius / math.sqrt(3), 0, 1),
  }
end

local function source_motion_shape(source, settings)
  if settings.motion_map and settings.motion_map[source] then
    return settings.motion_map[source]
  end
  if settings.motion_map and settings.motion_map.default then
    return settings.motion_map.default
  end
  return AUTO_MOTION_SHAPES[((source - 1) % #AUTO_MOTION_SHAPES) + 1]
end

local function safe_motion_amount(requested_amount, x_center, y_center, z_center, x_amp, y_amp, z_amp)
  local amount = clamp(requested_amount or DEFAULT_MOTION_AMOUNT, 0, 8)
  local function limit_for(center, amp)
    if amp <= 0.000001 then return amount end
    return math.min(center / amp, (1 - center) / amp)
  end

  return clamp(math.min(
    amount,
    limit_for(x_center, x_amp),
    limit_for(y_center, y_amp),
    limit_for(z_center, z_amp)
  ), 0, 8)
end

local function xyz_motion_values(source, source_count, progress, settings)
  local phase = (source - 1) / math.max(1, source_count)
  local shape = source_motion_shape(source, settings)
  local t = progress
  local two_pi = math.pi * 2
  local x_center = clamp(0.5 + (settings.azimuth_center / 360), 0, 1)
  local y_center = clamp(0.5 + (settings.elevation_center / 180), 0, 1)
  local z_center = settings.distance_center
  local x_amp = clamp(settings.azimuth_spread / 360, 0, 1) * 0.5
  local y_amp = clamp(settings.elevation_spread / 180, 0, 1) * 0.5
  local use_z_motion = settings.use_z_motion ~= false
  local z_amp = use_z_motion and (settings.distance_spread * 0.5) or 0
  local planar_amp = math.min(x_amp, y_amp)
  local amount = safe_motion_amount(settings.motion_amount, x_center, y_center, z_center, x_amp, y_amp, z_amp)
  local x = x_center
  local y = y_center
  local z = z_center

  if shape == "line" then
    x = x_center - x_amp + (x_amp * 2) * t
    y = y_center - y_amp + (y_amp * 2) * t
  elseif shape == "arc_up" then
    local eased = smoothstep(t)
    x = x_center - x_amp + (x_amp * 2) * eased
    y = y_center + y_amp * math.sin(math.pi * t)
    z = z_center + z_amp * math.sin(math.pi * t)
  elseif shape == "arc_down" then
    local eased = smoothstep(t)
    x = x_center - x_amp + (x_amp * 2) * eased
    y = y_center - y_amp * math.sin(math.pi * t)
    z = z_center - z_amp * math.sin(math.pi * t)
  elseif shape == "s_curve" then
    x = x_center - x_amp + (x_amp * 2) * t
    y = y_center + y_amp * math.sin(two_pi * t)
    z = z_center + z_amp * math.sin(two_pi * t)
  elseif shape == "step" then
    local steps = 4
    local stepped = math.floor(t * steps) / steps
    if t >= 1 then stepped = 1 end
    x = x_center - x_amp + (x_amp * 2) * stepped
    y = y_center + y_amp * triangle(stepped + phase)
    z = z_center + z_amp * triangle(stepped * 2 + phase)
  elseif shape == "zigzag" then
    x = x_center + x_amp * triangle(t * 4 + phase)
    y = y_center + y_amp * triangle(t * 2 + phase + 0.25)
  elseif shape == "circle" then
    x = x_center + planar_amp * math.cos(two_pi * (t + phase))
    y = y_center + planar_amp * math.sin(two_pi * (t + phase))
    z = z_center + z_amp * math.sin(two_pi * (t * 0.5 + phase))
  elseif shape == "spiral" then
    local eased = smoothstep(t)
    local radius = planar_amp * (0.15 + 0.85 * t)
    x = x_center + radius * math.cos(two_pi * (eased + phase))
    y = y_center + radius * math.sin(two_pi * (eased + phase))
    z = z_center - z_amp + (z_amp * 2) * t
  elseif shape == "fourier_xyz" then
    local x_wave = fourier_component(t, phase, {
      { 1.00, 1.0, 0.00 },
      { 0.55, 2.0, 0.18 },
      { 0.30, 3.0, 0.41 },
      { 0.18, 5.0, 0.07 },
    })
    local y_wave = fourier_component(t, phase, {
      { 1.00, 1.0, 0.25 },
      { 0.50, 3.0, 0.02 },
      { 0.28, 4.0, 0.33 },
      { 0.15, 6.0, 0.11 },
    })
    local z_wave = fourier_component(t, phase, {
      { 1.00, 1.0, 0.125 },
      { 0.42, 2.0, 0.36 },
      { 0.24, 5.0, 0.19 },
    })
    x = x_center + x_amp * x_wave
    y = y_center + y_amp * y_wave
    z = z_center + z_amp * z_wave
  elseif shape == "lissajous" then
    x = x_center + x_amp * math.sin(two_pi * (t + phase))
    y = y_center + y_amp * math.sin(two_pi * (t * 2 + phase))
    z = z_center + z_amp * math.cos(two_pi * (t + phase))
  end

  x = x_center + (x - x_center) * amount
  y = y_center + (y - y_center) * amount
  z = z_center + (z - z_center) * amount

  return {
    x = clamp(x, 0, 1),
    y = clamp(y, 0, 1),
    z = clamp(z, 0, 1),
  }
end

local function motion_values(source, source_count, progress, settings)
  local phase = (source - 1) / math.max(1, source_count)
  local shape = source_motion_shape(source, settings)
  local t = progress
  local two_pi = math.pi * 2
  local azimuth = settings.azimuth_center
  local elevation = settings.elevation_center
  local distance = settings.distance_center
  local az_amp = settings.azimuth_spread * 0.5
  local el_amp = settings.elevation_spread * 0.5
  local dist_amp = settings.distance_spread * 0.5

  if shape == "line" then
    azimuth = settings.azimuth_center - az_amp + settings.azimuth_spread * t + phase * 18
    elevation = settings.elevation_center - el_amp + settings.elevation_spread * t
    distance = settings.distance_center
  elseif shape == "arc_up" then
    local eased = smoothstep(t)
    azimuth = settings.azimuth_center - az_amp + settings.azimuth_spread * eased + phase * 24
    elevation = settings.elevation_center + el_amp * math.sin(math.pi * t + phase * two_pi)
    distance = settings.distance_center + dist_amp * math.sin(math.pi * t)
  elseif shape == "arc_down" then
    local eased = smoothstep(t)
    azimuth = settings.azimuth_center - az_amp + settings.azimuth_spread * eased + phase * 24
    elevation = settings.elevation_center - el_amp * math.sin(math.pi * t + phase * two_pi)
    distance = settings.distance_center - dist_amp * math.sin(math.pi * t)
  elseif shape == "s_curve" then
    local eased = smoothstep(t)
    azimuth = settings.azimuth_center - az_amp + settings.azimuth_spread * eased
    elevation = settings.elevation_center + el_amp * math.sin(two_pi * (t - 0.25 + phase * 0.5))
    distance = settings.distance_center + dist_amp * math.sin(two_pi * (eased + phase))
  elseif shape == "step" then
    local steps = 4
    local stepped = math.floor(t * steps) / steps
    if t >= 1 then stepped = 1 end
    azimuth = settings.azimuth_center - az_amp + settings.azimuth_spread * stepped
    elevation = settings.elevation_center + el_amp * triangle(stepped + phase)
    distance = settings.distance_center + dist_amp * triangle(stepped * 2 + phase)
  elseif shape == "zigzag" then
    azimuth = settings.azimuth_center + az_amp * triangle(t * 4 + phase)
    elevation = settings.elevation_center + el_amp * triangle(t * 2 + phase + 0.25)
    distance = settings.distance_center
  elseif shape == "circle" then
    azimuth = settings.azimuth_center + settings.azimuth_spread * (t + phase - 0.5)
    elevation = settings.elevation_center + el_amp * math.sin(two_pi * (t + phase))
    distance = settings.distance_center + dist_amp * math.sin(two_pi * (t * 0.5 + phase))
  elseif shape == "spiral" then
    local sweep = smoothstep(t)
    azimuth = settings.azimuth_center + az_amp * math.sin(two_pi * (sweep + phase))
    elevation = settings.elevation_center - el_amp + settings.elevation_spread * sweep
    distance = settings.distance_center - dist_amp + settings.distance_spread * t
  elseif shape == "fourier_xyz" then
    local xyz = xyz_motion_values(source, source_count, progress, settings)
    local aed = normalized_xyz_to_aed(xyz.x, xyz.y, xyz.z)
    azimuth = aed.azimuth
    elevation = aed.elevation
    distance = aed.distance
  elseif shape == "lissajous" then
    azimuth = settings.azimuth_center + az_amp * math.sin(two_pi * (t + phase))
    elevation = settings.elevation_center + el_amp * math.sin(two_pi * (t * 2 + phase))
    distance = settings.distance_center + dist_amp * math.cos(two_pi * (t + phase))
  else
    local hold = t < 0.25 and 0 or (t > 0.75 and 1 or (t - 0.25) / 0.5)
    azimuth = settings.azimuth_center + az_amp * math.sin(two_pi * (hold + phase))
    elevation = settings.elevation_center + el_amp * math.sin(math.pi * hold)
    distance = settings.distance_center + dist_amp * triangle(t * 3 + phase)
  end

  local xyz = xyz_motion_values(source, source_count, progress, settings)
  return {
    azimuth = wrap_degrees(azimuth),
    elevation = clamp(elevation, -90, 90),
    distance = clamp(distance, 0, 1),
    x = xyz.x,
    y = xyz.y,
    z = xyz.z,
  }
end

local function normalize_external_settings(settings)
  if type(settings) ~= "table" then return nil end
  local sources = settings.sources or parse_source_range(settings.source_range or DEFAULT_SOURCE_RANGE)
  if #sources == 0 then sources = parse_source_range(DEFAULT_SOURCE_RANGE) end
  return {
    sources = sources,
    steps_per_second = clamp(parse_number(settings.steps_per_second, DEFAULT_STEPS_PER_SECOND), 1, 120),
    azimuth_center = parse_number(settings.azimuth_center, DEFAULT_AZIMUTH_CENTER),
    azimuth_spread = clamp(parse_number(settings.azimuth_spread, DEFAULT_AZIMUTH_SPREAD), 0, 720),
    elevation_center = parse_number(settings.elevation_center, DEFAULT_ELEVATION_CENTER),
    elevation_spread = clamp(parse_number(settings.elevation_spread, DEFAULT_ELEVATION_SPREAD), 0, 180),
    distance_center = clamp(parse_number(settings.distance_center, DEFAULT_DISTANCE_CENTER), 0, 1),
    distance_spread = clamp(parse_number(settings.distance_spread, DEFAULT_DISTANCE_SPREAD), 0, 1),
    motion_amount = clamp(parse_number(settings.motion_amount, DEFAULT_MOTION_AMOUNT), 0, 8),
    use_z_motion = settings.use_z_motion ~= false,
    clear_existing = settings.clear_existing ~= false,
    set_latch = settings.set_latch ~= false,
    motion_map = settings.motion_map or parse_motion_map(settings.motion_map_text or DEFAULT_MOTION_MAP),
    region_name = trim(settings.region_name or DEFAULT_REGION_NAME),
    overwrite_region = settings.overwrite_region ~= false,
  }
end

local function collect_inputs()
  if _G.JS_AMBIENCODER64_SETTINGS then
    local settings = normalize_external_settings(_G.JS_AMBIENCODER64_SETTINGS)
    _G.JS_AMBIENCODER64_SETTINGS = nil
    return settings
  end

  local defaults = table.concat({
    DEFAULT_SOURCE_RANGE,
    tostring(DEFAULT_STEPS_PER_SECOND),
    tostring(DEFAULT_AZIMUTH_CENTER),
    tostring(DEFAULT_AZIMUTH_SPREAD),
    tostring(DEFAULT_ELEVATION_CENTER),
    tostring(DEFAULT_ELEVATION_SPREAD),
    tostring(DEFAULT_DISTANCE_CENTER),
    tostring(DEFAULT_DISTANCE_SPREAD),
    DEFAULT_CLEAR_EXISTING and "yes" or "no",
    DEFAULT_SET_LATCH and "yes" or "no",
    DEFAULT_MOTION_MAP,
    DEFAULT_REGION_NAME,
    DEFAULT_OVERWRITE_REGION and "yes" or "no",
    tostring(DEFAULT_MOTION_AMOUNT),
    DEFAULT_USE_Z_MOTION and "yes" or "no",
  }, ",")

  local ok, values = reaper.GetUserInputs(
    SCRIPT_NAME,
    15,
    "Sources range/space,Steps/sec,X/Az center,X/Az spread,Y/El center,Y/El spread,Z/Dist center,Z/Dist spread,Clear existing,Latch mode,Motion map,Region name,Overwrite region,Motion amount,Use Z motion",
    defaults
  )
  if not ok then return nil end

  local fields = {}
  for field in (values .. ","):gmatch("([^,]*),") do
    fields[#fields + 1] = trim(field)
  end

  local sources = parse_source_range(fields[1])
  if #sources == 0 then sources = parse_source_range(DEFAULT_SOURCE_RANGE) end

  return {
    sources = sources,
    steps_per_second = clamp(parse_number(fields[2], DEFAULT_STEPS_PER_SECOND), 1, 120),
    azimuth_center = parse_number(fields[3], DEFAULT_AZIMUTH_CENTER),
    azimuth_spread = clamp(parse_number(fields[4], DEFAULT_AZIMUTH_SPREAD), 0, 720),
    elevation_center = parse_number(fields[5], DEFAULT_ELEVATION_CENTER),
    elevation_spread = clamp(parse_number(fields[6], DEFAULT_ELEVATION_SPREAD), 0, 180),
    distance_center = clamp(parse_number(fields[7], DEFAULT_DISTANCE_CENTER), 0, 1),
    distance_spread = clamp(parse_number(fields[8], DEFAULT_DISTANCE_SPREAD), 0, 1),
    clear_existing = bool_from_text(fields[9], DEFAULT_CLEAR_EXISTING),
    set_latch = bool_from_text(fields[10], DEFAULT_SET_LATCH),
    motion_map = parse_motion_map(fields[11]),
    region_name = trim(fields[12]),
    overwrite_region = bool_from_text(fields[13], DEFAULT_OVERWRITE_REGION),
    motion_amount = clamp(parse_number(fields[14], DEFAULT_MOTION_AMOUNT), 0, 8),
    use_z_motion = bool_from_text(fields[15], DEFAULT_USE_Z_MOTION),
  }
end

local function count_available_sources(params_by_source, sources)
  local count = 0
  for _, source in ipairs(sources) do
    local params = params_by_source[source]
    if params and (params.x or params.y or params.z or params.azimuth or params.elevation or params.distance) then
      count = count + 1
    end
  end
  return count
end

local function automation_kinds_for_source(params)
  if params.x or params.y or params.z then
    return { "x", "y", "z" }
  end
  return { "azimuth", "elevation", "distance" }
end

local function count_automation_envelopes(params_by_source, sources)
  local count = 0
  for _, source in ipairs(sources) do
    local params = params_by_source[source]
    if params then
      for _, kind in ipairs(automation_kinds_for_source(params)) do
        if params[kind] then
          count = count + 1
        end
      end
    end
  end
  return count
end

local function set_track_latch_mode(track)
  if reaper.SetGlobalAutomationOverride then
    reaper.SetGlobalAutomationOverride(-1)
  end
  reaper.SetMediaTrackInfo_Value(track, "I_AUTOMODE", 4)
  reaper.TrackList_AdjustWindows(false)
  reaper.UpdateArrange()
end

local function hide_existing_track_envelopes(track)
  for envelope_index = 0, reaper.CountTrackEnvelopes(track) - 1 do
    local env = reaper.GetTrackEnvelope(track, envelope_index)
    if env then
      hide_track_envelope(env)
    end
  end
end

local function find_region_at_time_selection(start_pos, end_pos)
  local _, marker_count, region_count = reaper.CountProjectMarkers(0)
  local total_count = marker_count + region_count
  local tolerance = 0.000001

  for marker_index = 0, total_count - 1 do
    local ok, is_region, position, region_end, name, index, color = reaper.EnumProjectMarkers3(0, marker_index)
    if ok and is_region and math.abs(position - start_pos) <= tolerance and math.abs(region_end - end_pos) <= tolerance then
      return index, name, color
    end
  end

  return nil, nil, nil
end

local function collect_regions_by_name(region_name)
  local matches = {}
  local _, marker_count, region_count = reaper.CountProjectMarkers(0)
  local total_count = marker_count + region_count

  for marker_index = 0, total_count - 1 do
    local ok, is_region, position, region_end, name, index, color = reaper.EnumProjectMarkers3(0, marker_index)
    if ok and is_region and trim(name) == region_name then
      matches[#matches + 1] = {
        index = index,
        position = position,
        region_end = region_end,
        color = color or 0,
      }
    end
  end

  return matches
end

local function overwrite_region_by_name(start_pos, end_pos, region_name)
  local matches = collect_regions_by_name(region_name)
  if #matches == 0 then
    return nil
  end

  local keep = matches[1]
  reaper.SetProjectMarker3(0, keep.index, true, start_pos, end_pos, region_name, keep.color or 0)

  for index = #matches, 2, -1 do
    reaper.DeleteProjectMarker(0, matches[index].index, true)
  end

  return keep.index
end

local function write_time_selection_region(start_pos, end_pos, name, overwrite_region)
  local region_name = trim(name)
  if region_name == "" then
    return nil, false
  end

  if overwrite_region then
    local overwritten_index = overwrite_region_by_name(start_pos, end_pos, region_name)
    if overwritten_index then
      return overwritten_index, true
    end
  end

  local existing_index, _, existing_color = find_region_at_time_selection(start_pos, end_pos)
  if existing_index then
    reaper.SetProjectMarker3(0, existing_index, true, start_pos, end_pos, region_name, existing_color or 0)
    return existing_index, true
  end

  local new_index = reaper.AddProjectMarker2(0, true, start_pos, end_pos, region_name, -1, 0)
  return new_index, false
end

local function insert_motion_points(track, fx_index, params_by_source, settings, start_pos, end_pos)
  local duration = end_pos - start_pos
  local step_count = math.max(1, round(duration * settings.steps_per_second))
  local guard_end = end_pos + BOUNDARY_TRIGGER_SEC
  local calibrations = {}
  local sorted_envs = {}
  local written_points = 0
  local written_envs = 0

  for _, source in ipairs(settings.sources) do
    local params = params_by_source[source]
    if params then
      for _, kind in ipairs(automation_kinds_for_source(params)) do
        local param = params[kind]
        if param then
          local key = tostring(param.index)
          if not calibrations[key] then
            calibrations[key] = calibrate_param(track, fx_index, param.index, kind)
          end

          local env = reaper.GetFXEnvelope(track, fx_index, param.index, true)
          if env then
            set_envelope_ready(env)
            if settings.clear_existing then
              reaper.DeleteEnvelopePointRange(env, start_pos, guard_end)
            end

            local last_values = motion_values(source, #settings.sources, 1, settings)
            local last_normalized = value_to_normalized(last_values[kind], calibrations[key], kind)

            for step = 0, step_count do
              local progress = step / step_count
              local time = start_pos + duration * progress
              local values = motion_values(source, #settings.sources, progress, settings)
              local normalized = value_to_normalized(values[kind], calibrations[key], kind)
              reaper.InsertEnvelopePoint(env, time, normalized, 0, 0, false, true)
              written_points = written_points + 1
            end

            reaper.InsertEnvelopePoint(env, guard_end, last_normalized, 0, 0, false, true)
            written_points = written_points + 1

            if not sorted_envs[env] then
              sorted_envs[env] = true
              written_envs = written_envs + 1
            end
          end
        end
      end
    end
  end

  for env in pairs(sorted_envs) do
    reaper.Envelope_SortPoints(env)
  end

  return written_envs, written_points, step_count + 2
end

local function main()
  local track = get_selected_track()
  if not track then
    reaper.MB("Bitte genau einen Track mit ICST AmbiEncoder_64 selektieren.", SCRIPT_NAME, 0)
    return
  end

  local start_pos, end_pos = get_time_selection()
  if not start_pos then
    reaper.MB("Bitte zuerst eine Loop/Time Selection setzen.", SCRIPT_NAME, 0)
    return
  end

  local settings = collect_inputs()
  if not settings then return end

  local fx_index, fx_name = find_ambi_fx(track)
  if not fx_index then
    reaper.MB(
      "Auf dem selektierten Track wurde kein AmbiEncoder_64-FX gefunden.\n\n" ..
      "Bitte den Track mit `VST3: AmbiEncoder_64 (ICST)` selektieren, nicht den ReaLearn-Track.",
      SCRIPT_NAME,
      0
    )
    return
  end

  local params_by_source = discover_ambi_params(track, fx_index)
  local available_sources = count_available_sources(params_by_source, settings.sources)
  if available_sources == 0 then
    reaper.MB(
      "Keine passenden X/Y/Z- oder Azimuth/Elevation/Distance-Parameter gefunden.\n\n" ..
      "Das Script sucht Parameternamen wie 'Point 1: X', 'X 1', 'azim', 'elev', 'dist' und Source-Nummern 1-64.",
      SCRIPT_NAME,
      0
    )
    return
  end

  local point_columns = math.max(1, round((end_pos - start_pos) * settings.steps_per_second) + 1)
  point_columns = point_columns + 1
  local estimated_envelopes = count_automation_envelopes(params_by_source, settings.sources)
  local estimated_points = estimated_envelopes * point_columns
  if estimated_points > 100000 then
    local answer = reaper.MB(
      string.format("Das schreibt ca. %d Envelope-Punkte.\n\nFortfahren?", estimated_points),
      SCRIPT_NAME,
      4
    )
    if answer ~= 6 then return end
  end

  reaper.Undo_BeginBlock()

  if settings.set_latch then
    set_track_latch_mode(track)
  end

  if DEFAULT_HIDE_NON_TARGET_ENVELOPES then
    hide_existing_track_envelopes(track)
  end

  reaper.PreventUIRefresh(1)
  local written_envs, written_points, points_per_env = insert_motion_points(track, fx_index, params_by_source, settings, start_pos, end_pos)
  local region_index, region_updated = write_time_selection_region(start_pos, end_pos, settings.region_name, settings.overwrite_region)

  reaper.PreventUIRefresh(-1)
  reaper.UpdateArrange()
  reaper.TrackList_AdjustWindows(false)
  reaper.Undo_EndBlock(SCRIPT_NAME, -1)

  reaper.MB(
    string.format(
      "Fertig.\n\nTrack: %s\nFX: %s\nSources mit Parametern: %d\nEnvelopes: %d\nPunkte pro Envelope: %d\nGeschriebene Punkte: %d\nAutomation Mode: %s\nRegion: %s",
      get_track_name(track),
      fx_name or ("FX " .. tostring(fx_index + 1)),
      available_sources,
      written_envs,
      points_per_env,
      written_points,
      settings.set_latch and "Latch" or "unveraendert",
      region_index and (tostring(settings.region_name) .. (region_updated and " aktualisiert" or " erstellt")) or "keine"
    ),
    SCRIPT_NAME,
    0
  )
end

main()
