-- AmbiEncoder_64 Rotation + Y-Achsen-Bewegung Script mit Mode- und Speed-Auswahl
-- benötigt ReaImGui (ReaPack)

local ctx = reaper.ImGui_CreateContext('AmbiEncoder Rotation/Y-Move')
local point_count = 64
local track_index = 0
local fx_index = 0

local rotation_dir = 0 -- 0 = Uhrzeigersinn, 1 = Gegenuhrzeigersinn
local y_move_dir = 0   -- 0 = 1.0 → -1.0, 1 = -1.0 → 1.0
local mode = 0         -- 0 = nur Rotation, 1 = nur Y-Fahrt, 2 = Rotation+Y
local speed = 1.0      -- Rotationen pro Region

local x_params = {10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85}
local y_params = {11,16,21,26,31,36,41,46,51,56,61,66,71,76,81,86}

function create_motion()
  local start_time, end_time = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
  if start_time == end_time then
    reaper.ShowMessageBox("Keine Region Selection aktiv!", "Fehler", 0)
    return
  end

  local track = reaper.GetTrack(0, track_index)
  if not track then
    reaper.ShowMessageBox("Track nicht gefunden!", "Fehler", 0)
    return
  end

  local points = {}
  for i = 1, #x_params do
    local x = (reaper.TrackFX_GetParam(track, fx_index, x_params[i]) * 2) - 1
    local y = (reaper.TrackFX_GetParam(track, fx_index, y_params[i]) * 2) - 1
    table.insert(points, { x = x, y = y })
  end

  local step_time = (end_time - start_time) / (point_count - 1)
  local dirRot = (rotation_dir == 0) and 1 or -1

  local y_start = (y_move_dir == 0) and 1.0 or -1.0
  local y_end   = (y_move_dir == 0) and -1.0 or 1.0

  for idx = 1, #points do
    local envX = reaper.GetFXEnvelope(track, fx_index, x_params[idx], true)
    local envY = reaper.GetFXEnvelope(track, fx_index, y_params[idx], true)
    if envX and envY then
      reaper.DeleteEnvelopePointRange(envX, start_time, end_time)
      reaper.DeleteEnvelopePointRange(envY, start_time, end_time)

      local dx = points[idx].x
      local dy = points[idx].y
      local baseAngle = math.atan(dy, dx)
      local radius = math.sqrt(dx*dx + dy*dy)

      local t = start_time
      for i = 0, point_count - 1 do
        local progress = i / (point_count - 1)

        -- Rotationswinkel mit Speed-Faktor
        local angle = baseAngle + (progress * math.pi * 2 * dirRot * speed)

        local rotX = math.cos(angle) * radius
        local rotY = math.sin(angle) * radius
        local linY = y_start + (y_end - y_start) * progress

        local outX, outY
        if mode == 0 then
          outX = rotX
          outY = rotY
        elseif mode == 1 then
          outX = points[idx].x
          outY = linY
        elseif mode == 2 then
          outX = rotX
          outY = rotY + linY
        end

        reaper.InsertEnvelopePoint(envX, t, (outX + 1) / 2, 0, 0, false, true)
        reaper.InsertEnvelopePoint(envY, t, (outY + 1) / 2, 0, 0, false, true)
        t = t + step_time
      end

      reaper.Envelope_SortPoints(envX)
      reaper.Envelope_SortPoints(envY)
    end
  end

  reaper.UpdateArrange()
  local modeName = (mode==0 and "Rotation") or (mode==1 and "Y-Fahrt") or "Rotation+Y"
  reaper.ShowMessageBox("Bewegung erstellt: "..modeName.."\nSpeed: "..tostring(speed).." Umdrehungen", "Fertig", 0)
end

function loop()
  local visible, open = reaper.ImGui_Begin(ctx, 'AmbiEncoder Rotation/Y-Move', true,
    reaper.ImGui_WindowFlags_AlwaysAutoResize())
  if visible then
    local changed1, new_points = reaper.ImGui_InputInt(ctx, 'Punktanzahl', point_count)
    if changed1 then point_count = math.max(2, new_points) end

    local changed2
    changed2, rotation_dir = reaper.ImGui_Combo(ctx, 'Drehrichtung', rotation_dir,
      'Uhrzeigersinn\0Gegenuhrzeigersinn\0')

    local changed3
    changed3, y_move_dir = reaper.ImGui_Combo(ctx, 'Y-Bewegung', y_move_dir,
      '1.0 → -1.0\0-1.0 → 1.0\0')

    local changed4
    changed4, mode = reaper.ImGui_Combo(ctx, 'Modus', mode,
      'Nur Rotation\0Nur Y-Fahrt\0Rotation + Y-Fahrt\0')

    local changed5
    changed5, speed = reaper.ImGui_InputDouble(ctx, 'Speed (Rotationen)', speed)

    if reaper.ImGui_Button(ctx, 'Bewegung erstellen') then
      create_motion()
    end

    reaper.ImGui_End(ctx)
  end

  if open then
    reaper.defer(loop)
  else
    reaper.ImGui_DestroyContext(ctx)
  end
end

reaper.defer(loop)


