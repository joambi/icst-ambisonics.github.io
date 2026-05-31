--[[
ICST MultiEncoder Item Motion Animator (GUI)
ReaImGui v0.10.0.2
REAPER 7.59+

Applies formula-based Azimuth & Elevation automation
to selected items using ICST Ambisonics MultiEncoder
]]

--------------------------------------------------
-- ReaImGui setup
--------------------------------------------------
local ctx = reaper.ImGui_CreateContext("ICST Item Motion Animator")
local size_w, size_h = 420, 300
reaper.ImGui_SetNextWindowSize(ctx, size_w, size_h, reaper.ImGui_Cond_FirstUseEver())

--------------------------------------------------
-- Math / defaults
--------------------------------------------------
local twopi = math.pi * 2

local duration = 30.0
local steps = 300
local radius = 0.6
local noise_amt = 0.15
local speed = 1.0

--------------------------------------------------
-- Pseudo noise
--------------------------------------------------
local function pseudo_noise(x)
  return math.sin(x * 12.9898 + 78.233) * 43758.5453 % 1
end

--------------------------------------------------
-- Core processing
--------------------------------------------------
local function apply_motion()
  local itemCount = reaper.CountSelectedMediaItems(0)
  if itemCount == 0 then
    reaper.ShowMessageBox("No items selected!", "ICST Animator", 0)
    return
  end

  reaper.Undo_BeginBlock()
  reaper.PreventUIRefresh(1)

  for i = 0, itemCount - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    local take = reaper.GetActiveTake(item)
    if not take or reaper.TakeIsMIDI(take) then goto continue end

    local item_pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    local objectIndex = i

    -- Find ICST FX
    local fxIndex = reaper.TakeFX_GetByName(
      take,
      "ICST Ambisonics MultiEncoder",
      false
    )
    if fxIndex == -1 then
      reaper.ShowMessageBox(
        "ICST MultiEncoder not found in Take FX (Item " .. (i + 1) .. ")",
        "ICST Animator",
        0
      )
      goto continue
    end

    -- Parameter indices (verify if needed)
    local param_azimuth = 0
    local param_elevation = 1

    -- Get / create envelopes
    local env_az = reaper.TakeFX_GetEnvelope(take, fxIndex, param_azimuth, true)
    local env_el = reaper.TakeFX_GetEnvelope(take, fxIndex, param_elevation, true)

    -- Clear existing points
    reaper.DeleteEnvelopePointRange(env_az, item_pos, item_pos + duration + 0.01)
    reaper.DeleteEnvelopePointRange(env_el, item_pos, item_pos + duration + 0.01)

    for s = 0, steps do
      local t = (s / steps) * duration
      local time = item_pos + t
      local tt = t * speed

      local x =
        radius * math.cos(twopi * tt / 30 + objectIndex * 0.393) +
        noise_amt * (pseudo_noise(tt * 0.4 + objectIndex * 2.1) - 0.5) +
        0.1 * math.cos(twopi * tt / 8 + objectIndex * 1.7)

      local y =
        radius * math.sin(twopi * tt / 30 + objectIndex * 0.393) +
        noise_amt * (pseudo_noise(tt * 0.4 + objectIndex * 3.3) - 0.5) +
        0.1 * math.sin(twopi * tt / 8 + objectIndex * 1.7)

      local elevation =
        0.5 +
        0.2 * math.sin(twopi * tt / 30 + objectIndex * 0.785) +
        0.08 * (pseudo_noise(tt * 0.6 + objectIndex * 4.7) - 0.5)

      local azimuth = math.deg(math.atan2(y, x)) -- -180..180
      local az_norm = (azimuth + 180) / 360
      local el_norm = math.max(0, math.min(1, elevation))

      reaper.InsertEnvelopePoint(env_az, time, az_norm, 0, 0, false, true)
      reaper.InsertEnvelopePoint(env_el, time, el_norm, 0, 0, false, true)
    end

    reaper.Envelope_SortPoints(env_az)
    reaper.Envelope_SortPoints(env_el)

    ::continue::
  end

  reaper.PreventUIRefresh(-1)
  reaper.Undo_EndBlock("ICST Item Motion Automation", -1)
  reaper.UpdateArrange()
end

--------------------------------------------------
-- GUI loop
--------------------------------------------------
local function loop()
  reaper.ImGui_SetNextWindowSize(ctx, size_w, size_h, reaper.ImGui_Cond_Once())

  local visible, open = reaper.ImGui_Begin(
    ctx,
    "ICST Item Motion Animator",
    true,
    reaper.ImGui_WindowFlags_NoCollapse()
  )

  if visible then
    reaper.ImGui_Text(ctx, "Formula-based ICST MultiEncoder animation")
    reaper.ImGui_Separator(ctx)

    retval, duration = reaper.ImGui_SliderDouble(
      ctx, "Duration (s)", duration, 1.0, 120.0, "%.1f"
    )

    retval, steps = reaper.ImGui_SliderInt(
      ctx, "Steps", steps, 50, 2000
    )

    retval, radius = reaper.ImGui_SliderDouble(
      ctx, "Radius", radius, 0.1, 1.5, "%.2f"
    )

    retval, noise_amt = reaper.ImGui_SliderDouble(
      ctx, "Noise Amount", noise_amt, 0.0, 0.5, "%.2f"
    )

    retval, speed = reaper.ImGui_SliderDouble(
      ctx, "Speed", speed, 0.1, 3.0, "%.2f"
    )

    reaper.ImGui_Separator(ctx)

    if reaper.ImGui_Button(ctx, "Apply to Selected Items", -1, 30) then
      apply_motion()
    end

    reaper.ImGui_End(ctx)
  end

  if open then
    reaper.defer(loop)
  end
end

--------------------------------------------------
-- Start
--------------------------------------------------
reaper.defer(loop)


