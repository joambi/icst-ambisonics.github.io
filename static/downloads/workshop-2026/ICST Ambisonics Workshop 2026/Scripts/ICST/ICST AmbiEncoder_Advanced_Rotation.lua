-- AmbiEncoder_64 Erweiterte Rotation Automation mit ReaImGui GUI
-- Offset für nachfolgende Punkte einstellbar
-- Tempo-Accelerando-Faktor hinzugefügt (Rotation wird zum Schluss schneller oder langsamer)
-- Fix: Verwende ^ statt math.pow, da math.pow evtl. nicht verfügbar ist

local ctx = reaper.ImGui_CreateContext('AmbiEncoder Advanced Rotation')
local point_count = 64
local rotation_dir = 0
local start_angle_deg = 0.0
local end_angle_deg = 360.0
local radius_scale = 1.0
local use_z = false
local curve_mode = 0
local point_offset_deg = 0.0 -- Offset für jeden nächsten Punkt
local accel_factor = 1.0     -- 1.0 = konstant, >1 beschleunigt, <1 bremst, z.B. 2.0 doppelt so schnell am Ende

local track_indices = {0}
local fx_index = 0

local x_params = {10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85}
local y_params = {11,16,21,26,31,36,41,46,51,56,61,66,71,76,81,86}
local z_params = {12,17,22,27,32,37,42,47,52,57,62,67,72,77,82,87}

local function ease(val,mode)
  if mode==1 then return val*val end
  if mode==2 then return 1-(1-val)*(1-val) end
  return val
end

-- zusätzliche Zeitberechnung für Accelerando
local function accel_progress(i,total,factor)
  local lin = i/(total-1)
  if factor == 1.0 then return lin end
  if factor > 1.0 then
    return lin ^ factor
  else
    local inv = 1.0/factor
    return 1 - ((1-lin) ^ inv)
  end
end

function create_rotation()
  local start_time,end_time = reaper.GetSet_LoopTimeRange(false,false,0,0,false)
  if start_time==end_time then
    reaper.ShowMessageBox("Keine Region Selection aktiv!","Fehler",0)
    return
  end
  local total_time = end_time-start_time
  local direction = (rotation_dir==0) and 1 or -1
  local start_rad = math.rad(start_angle_deg)
  local end_rad = math.rad(end_angle_deg)
  local angle_span = (end_rad - start_rad)*direction
  local offset_rad = math.rad(point_offset_deg)

  for _,trk_idx in ipairs(track_indices) do
    local track = reaper.GetTrack(0,trk_idx)
    if track then
      for idx=1,#x_params do
        local x = (reaper.TrackFX_GetParam(track,fx_index,x_params[idx])*2)-1
        local y = (reaper.TrackFX_GetParam(track,fx_index,y_params[idx])*2)-1
        local z = (reaper.TrackFX_GetParam(track,fx_index,z_params[idx])*2)-1
        local envX = reaper.GetFXEnvelope(track,fx_index,x_params[idx],true)
        local envY = reaper.GetFXEnvelope(track,fx_index,y_params[idx],true)
        local envZ = use_z and reaper.GetFXEnvelope(track,fx_index,z_params[idx],true) or nil
        if envX and envY then
          reaper.DeleteEnvelopePointRange(envX,start_time,end_time)
          reaper.DeleteEnvelopePointRange(envY,start_time,end_time)
          if envZ then reaper.DeleteEnvelopePointRange(envZ,start_time,end_time) end
          local baseAngle = math.atan(y,x) + ((idx-1)*offset_rad)
          local radius = math.sqrt(x*x+y*y)*radius_scale
          for i=0,point_count-1 do
            local prog = accel_progress(i,point_count,accel_factor)
            prog = ease(prog,curve_mode)
            local ang = baseAngle + (start_rad + (angle_span*prog))
            local t = start_time + (prog * total_time)
            local newX = math.cos(ang)*radius
            local newY = math.sin(ang)*radius
            reaper.InsertEnvelopePoint(envX,t,(newX+1)/2,0,0,false,true)
            reaper.InsertEnvelopePoint(envY,t,(newY+1)/2,0,0,false,true)
            if envZ then
              reaper.InsertEnvelopePoint(envZ,t,(z+1)/2,0,0,false,true)
            end
          end
          reaper.Envelope_SortPoints(envX)
          reaper.Envelope_SortPoints(envY)
          if envZ then reaper.Envelope_SortPoints(envZ) end
        end
      end
    end
  end
  reaper.UpdateArrange()
  reaper.ShowMessageBox("Rotation mit Offset und Accelerando erstellt!","Fertig",0)
end

function loop()
  local visible,open = reaper.ImGui_Begin(ctx,'AmbiEncoder Advanced Rotation',true,reaper.ImGui_WindowFlags_AlwaysAutoResize())
  if visible then
    local ch1,np = reaper.ImGui_InputInt(ctx,'Punktanzahl',point_count)
    if ch1 then point_count = math.max(2,np) end
    local ch2,sa = reaper.ImGui_InputDouble(ctx,'Startwinkel (Grad)',start_angle_deg)
    if ch2 then start_angle_deg = sa end
    local ch3,ea = reaper.ImGui_InputDouble(ctx,'Endwinkel (Grad)',end_angle_deg)
    if ch3 then end_angle_deg = ea end
    local ch4,rs = reaper.ImGui_SliderDouble(ctx,'Radius-Skalierung',radius_scale,0.1,2.0)
    if ch4 then radius_scale = rs end
    local _, dir_val = reaper.ImGui_Combo(ctx,'Drehrichtung',rotation_dir,'Uhrzeigersinn\0Gegenuhrzeigersinn\0')
    rotation_dir = dir_val
    local _, curve_val = reaper.ImGui_Combo(ctx,'Kurve',curve_mode,'Linear\0EaseIn\0EaseOut\0')
    curve_mode = curve_val
    local ch7, uz = reaper.ImGui_Checkbox(ctx,'Z-Achse beibehalten',use_z)
    if ch7 then use_z = uz end
    local ch8, off = reaper.ImGui_InputDouble(ctx,'Offset pro Punkt (Grad)',point_offset_deg)
    if ch8 then point_offset_deg = off end
    local ch9, af = reaper.ImGui_InputDouble(ctx,'Accelerando-Faktor',accel_factor)
    if ch9 then accel_factor = af end
    if reaper.ImGui_Button(ctx,'Rotation erstellen') then
      create_rotation()
    end
    reaper.ImGui_End(ctx)
  end
  if open then reaper.defer(loop) else 
    -- reaper.ImGui_DestroyContext(ctx)
  end
end

reaper.defer(loop)



