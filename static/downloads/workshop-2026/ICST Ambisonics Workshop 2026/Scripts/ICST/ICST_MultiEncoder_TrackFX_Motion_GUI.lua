--[[
ICST Ambisonics MultiEncoder_64
Track FX ONLY
16 Source Points
REAPER 7.59+
ReaImGui v0.10.0.2
]]


--------------------------------------------------
-- ImGui Context
--------------------------------------------------
local ctx = reaper.ImGui_CreateContext("ICST Track Motion Animator")

--------------------------------------------------
-- Defaults
--------------------------------------------------
local twopi = math.pi * 2

local duration  = 30.0
local steps     = 300
local radius    = 0.6
local noise_amt = 0.15
local speed     = 1.0
local sources   = 16

--------------------------------------------------
-- Pseudo noise
--------------------------------------------------
local function pseudo_noise(x)
  return math.sin(x * 12.9898 + 78.233) * 43758.5453 % 1
end

--------------------------------------------------
-- Collect first selected item per track
--------------------------------------------------
local function collect_tracks()
  local t = {}
  local itemCount = reaper.CountSelectedMediaItems(0)

  for i = 0, itemCount - 1 do
    local item  = reaper.GetSelectedMediaItem(0, i)
    local track = reaper.GetMediaItem_Track(item)
    if not t[track] then
      t[track] = item
    end
  end

  return t
end

--------------------------------------------------
-- Apply motion (TRACK FX ONLY)
--------------------------------------------------
local function apply_motion()
  local tracks = collect_tracks()
  if not next(tracks) then
    reaper.ShowMessageBox("Keine selektierten Items gefunden.", "ICST Animator", 0)
    return
  end

  reaper.Undo_BeginBlock()
  reaper.PreventUIRefresh(1)

  for track, item in pairs(tracks) do
    local item_pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")

    -- FIND TRACK FX (ICST)
    local fxIndex = reaper.TrackFX_AddByName(
      track,
      "AmbiEncoder_64 (ICST)",
      false,  -- normal Track FX chain
      -1      -- search only
    )

    if fxIndex < 0 then
      local _, trackName = reaper.GetTrackName(track)
      reaper.ShowMessageBox(
        "ICST MultiEncoder_64 nicht im TRACK FX:\n" .. trackName,
        "ICST Animator",
        0
      )
      goto continue
    end

    -- Iterate Sources
    for s = 0, sources - 1 do
      local az_param = s * 2
      local el_param = s * 2 + 1


      reaper.DeleteEnvelopePointRange(env_az, item_pos, item_pos + duration + 0.01)
      reaper.DeleteEnvelopePointRange(env_el, item_pos, item_pos + duration + 0.01)

      for i = 0, steps do
        local t  = (i / steps) * duration
        local tt = t * speed
        local time = item_pos + t

        local phase = s * 0.4

        local x =
          radius * math.cos(twopi * tt / 30 + phase) +
          noise_amt * (pseudo_noise(tt * 0.4 + s * 2.1) - 0.5) +
          0.1 * math.cos(twopi * tt / 8 + phase)

        local y =
          radius * math.sin(twopi * tt / 30 + phase) +
          noise_amt * (pseudo_noise(tt * 0.4 + s * 3.3) - 0.5) +
          0.1 * math.sin(twopi * tt / 8 + phase)

        local elevation =
          0.5 +
          0.2 * math.sin(twopi * tt / 30 + phase) +
          0.08 * (pseudo_noise(tt * 0.6 + s * 4.7) - 0.5)

        local az = math.deg(math.atan2(y, x))
        local az_norm = (az + 180) / 360
        local el_norm = math.max(0, math.min(1, elevation))

        reaper.InsertEnvelopePoint(env_az, time, az_norm, 0, 0, false, true)
        reaper.InsertEnvelopePoint(env_el, time, el_norm, 0, 0, false, true)
      end

      reaper.Envelope_SortPoints(env_az)
      reaper.Envelope_SortPoints(env_el)
    end

    ::continue::
  end

  reaper.PreventUIRefresh(-1)
  reaper.Undo_EndBlock("ICST Track FX Motion – 16 Sources", -1)
  reaper.UpdateArrange()
end

--------------------------------------------------
-- GUI Loop (CORRECT Begin / End)
--------------------------------------------------
local function loop()
  local visible, open = reaper.ImGui_Begin(
    ctx,
    "ICST Track Motion Animator",
    true,
    reaper.ImGui_WindowFlags_NoCollapse()
  )

  if visible then
    reaper.ImGui_Text(ctx, "ICST MultiEncoder_64 – TRACK FX (16 Sources)")
    reaper.ImGui_Separator(ctx)

    _, duration  = reaper.ImGui_SliderDouble(ctx, "Duration (s)", duration, 1, 120, "%.1f")
    _, steps     = reaper.ImGui_SliderInt(ctx, "Steps", steps, 50, 3000)
    _, radius    = reaper.ImGui_SliderDouble(ctx, "Radius", radius, 0.1, 1.5, "%.2f")
    _, noise_amt = reaper.ImGui_SliderDouble(ctx, "Noise", noise_amt, 0, 0.5, "%.2f")
    _, speed     = reaper.ImGui_SliderDouble(ctx, "Speed", speed, 0.1, 3, "%.2f")

    reaper.ImGui_Separator(ctx)

    if reaper.ImGui_Button(ctx, "Apply Motion to Selected Tracks", -1, 30) then
      apply_motion()
    end
  end

  reaper.ImGui_End(ctx)

  if open then
    reaper.defer(loop)
  end
end

--------------------------------------------------
-- Start
--------------------------------------------------
reaper.defer(loop)


