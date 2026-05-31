-- @description AmbiEncoder_64 Group Move (XY or Z) with Shape
-- @version 1.0
-- @author Dein Assistent
-- @noindex

local ctx = reaper.ImGui_CreateContext('AmbiEncoder Group Move')
local track_index = 0
local fx_index = 0
local point_count = 64  -- wie viele Punkte du automatisieren willst
local step_points = 64  -- wie viele Keyframes pro Achse schreiben

-- Formwahl
local move_mode = 0     -- 0 = XY, 1 = Z
local form_mode = 0     -- 0 = Gerade, 1 = Sinus, 2 = Dreieck
local speed = 1.0
local rotation_dir = 0 -- 0 = normal, 1 = invertiert

-- Parameter-Index-Tabellen (angepasst aus deiner Liste)
local x_params = {10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,
                  90,95,100,105,110,115,120,125,130,135,140,145,150,155,
                  160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,
                  240,245,250,255,260,265,270,275,280,285,290,295,300,305,310,315,320,325}

local y_params = {11,16,21,26,31,36,41,46,51,56,61,66,71,76,81,86,
                  91,96,101,106,111,116,121,126,131,136,141,146,151,156,
                  161,166,171,176,181,186,191,196,201,206,211,216,221,226,231,236,
                  241,246,251,256,261,266,271,276,281,286,291,296,301,306,311,316,321,326}

local z_params = {12,17,22,27,32,37,42,47,52,57,62,67,72,77,82,87,
                  92,97,102,107,112,117,122,127,132,137,142,147,152,157,
                  162,167,172,177,182,187,192,197,202,207,212,217,222,227,232,237,
                  242,247,252,257,262,267,272,277,282,287,292,297,302,307,312,317,322,327}

local function shape_value(progress)
  -- progress von 0..1
  local v = 0
  if form_mode == 0 then
    v = -1 + progress * 2
  elseif form_mode == 1 then
    v = math.sin(progress * math.pi * 2 * speed)
  elseif form_mode == 2 then
    local phase = (progress * 2 * speed) % 2
    if phase < 1 then v = -1 + phase * 2 else v = 1 - (phase - 1) * 2 end
  end
  if rotation_dir == 1 then v = -v end
  return v
end

local function create_motion()
  local start_time, end_time = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
  if start_time == end_time then
    reaper.ShowMessageBox("Bitte vorher eine Region/Time-Selection setzen!", "Fehler", 0)
    return
  end
  local track = reaper.GetTrack(0, track_index)
  if not track then
    reaper.ShowMessageBox("Track nicht gefunden!", "Fehler", 0)
    return
  end

  -- Ursprungswerte sichern
  local basesX, basesY, basesZ = {}, {}, {}
  for i=1,point_count do
    basesX[i] = (reaper.TrackFX_GetParam(track, fx_index, x_params[i]) * 2) - 1
    basesY[i] = (reaper.TrackFX_GetParam(track, fx_index, y_params[i]) * 2) - 1
    basesZ[i] = (reaper.TrackFX_GetParam(track, fx_index, z_params[i]) * 2) - 1
  end

  local step_time = (end_time - start_time) / (step_points-1)

  for i=1,point_count do
    local envX = reaper.GetFXEnvelope(track, fx_index, x_params[i], true)
    local envY = reaper.GetFXEnvelope(track, fx_index, y_params[i], true)
    local envZ = reaper.GetFXEnvelope(track, fx_index, z_params[i], true)

    if move_mode == 0 then
      if envX then reaper.DeleteEnvelopePointRange(envX, start_time, end_time) end
      if envY then reaper.DeleteEnvelopePointRange(envY, start_time, end_time) end
    else
      if envZ then reaper.DeleteEnvelopePointRange(envZ, start_time, end_time) end
    end

    local t = start_time
    for s=0, step_points-1 do
      local progress = s / (step_points-1)
      local offset = shape_value(progress)

      if move_mode == 0 then
        -- XY gemeinsam verschieben
        if envX then reaper.InsertEnvelopePoint(envX, t, (basesX[i]+offset+1)/2, 0,0,false,true) end
        if envY then reaper.InsertEnvelopePoint(envY, t, (basesY[i]+offset+1)/2, 0,0,false,true) end
      else
        -- nur Z
        if envZ then reaper.InsertEnvelopePoint(envZ, t, (basesZ[i]+offset+1)/2, 0,0,false,true) end
      end
      t = t + step_time
    end

    if move_mode == 0 then
      if envX then reaper.Envelope_SortPoints(envX) end
      if envY then reaper.Envelope_SortPoints(envY) end
    else
      if envZ then reaper.Envelope_SortPoints(envZ) end
    end
  end

  reaper.UpdateArrange()
  local mname = (move_mode==0) and "XY" or "Z"
  local fname = (form_mode==0) and "Gerade" or (form_mode==1 and "Sinus" or "Dreieck")
  reaper.ShowMessageBox("Bewegung erstellt\nModus: "..mname.."\nForm: "..fname, "Fertig", 0)
end

local function loop()
  local visible, open = reaper.ImGui_Begin(ctx, 'AmbiEncoder Group Move', true,
    reaper.ImGui_WindowFlags_AlwaysAutoResize())
  if visible then
    local _, newCount = reaper.ImGui_InputInt(ctx, 'Keyframes pro Achse', step_points)
    if newCount and newCount > 2 then step_points = newCount end

    _, move_mode = reaper.ImGui_Combo(ctx, 'Bewegung', move_mode, 'XY Ebene\0Z Achse\0')
    _, form_mode = reaper.ImGui_Combo(ctx, 'Form', form_mode, 'Gerade\0Sinus\0Dreieck\0')
    _, speed = reaper.ImGui_InputDouble(ctx, 'Speed (Zyklen)', speed)
    _, rotation_dir = reaper.ImGui_Combo(ctx, 'Richtung', rotation_dir, 'Normal\0Invertiert\0')

    if reaper.ImGui_Button(ctx, 'Bewegung erstellen') then
      create_motion()
    end

    reaper.ImGui_End(ctx)
  end
  if open then reaper.defer(loop) end
end

reaper.defer(loop)


