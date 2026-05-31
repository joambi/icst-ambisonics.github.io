-- AmbiEncoder_64 Random Walk Script mit ReaImGui GUI für alle 64 Quellen (nur XYZ, ohne Gain/Mute)
-- Autor: Dein Reaper Assistent

-- ========================
-- Anfangswerte
local speed = 0.01      -- Schrittgröße pro Tick
local range = 1.0       -- maximale Range (normalisiert -1.0 bis +1.0)
local include_z = false -- Z ebenfalls bewegen? true/false
-- ========================

-- ReaImGui Setup
local ctx = reaper.ImGui_CreateContext('AmbiEncoder Random Walk')
local sizeX, sizeY = 300, 180
reaper.ImGui_SetNextWindowSize(ctx, sizeX, sizeY, reaper.ImGui_Cond_FirstUseEver())

-- Alle 64 Quellen vorbereiten
local sources = {}
for i = 1, 64 do table.insert(sources, i) end

local positions = {}
for _,s in ipairs(sources) do
  positions[s] = {x=0.0,y=0.0,z=0.0}
end

local function clamp(v,min,max)
  if v<min then return min elseif v>max then return max else return v end
end

-- XYZ Parameter starten mit Index 10, jede Quelle hat 5 Parameter: X,Y,Z,Gain,Mute
local function get_param_index_xyz(axis_offset, source)
  -- axis_offset: 0 für X, 1 für Y, 2 für Z
  -- Index 10 = X1, 11 = Y1, 12 = Z1, dann +5 für jede nächste Quelle
  return 10 + axis_offset + (source-1)*5
end

local track = reaper.GetSelectedTrack(0,0)
if not track then
  reaper.ShowMessageBox("Bitte einen Track mit AmbiEncoder_64 auswählen!","Fehler",0)
  return
end
local fx_index = reaper.TrackFX_AddByName(track, "AmbiEncoder_64", false, 0)
if fx_index < 0 then
  reaper.ShowMessageBox("Kein AmbiEncoder_64 im Track gefunden!","Fehler",0)
  return
end

local running = true

function doRandomWalk()
  for _,s in ipairs(sources) do
    local pos = positions[s]
    -- X
    pos.x = clamp(pos.x + (math.random()*2-1)*speed, -range, range)
    reaper.TrackFX_SetParam(track, fx_index, get_param_index_xyz(0, s), (pos.x*0.5)+0.5)
    -- Y
    pos.y = clamp(pos.y + (math.random()*2-1)*speed, -range, range)
    reaper.TrackFX_SetParam(track, fx_index, get_param_index_xyz(1, s), (pos.y*0.5)+0.5)
    -- Z optional
    if include_z then
      pos.z = clamp(pos.z + (math.random()*2-1)*speed, -range, range)
      reaper.TrackFX_SetParam(track, fx_index, get_param_index_xyz(2, s), (pos.z*0.5)+0.5)
    end
  end
end

function loop()
  local visible, open = reaper.ImGui_Begin(ctx, 'AmbiEncoder Random Walk', true)
  if visible then
    local changed
    changed, speed = reaper.ImGui_SliderDouble(ctx, 'Speed', speed, 0.001, 0.1, '%.4f')
    changed, range = reaper.ImGui_SliderDouble(ctx, 'Range', range, 0.1, 1.0, '%.2f')
    local checked
    checked, include_z = reaper.ImGui_Checkbox(ctx, 'Include Z Axis', include_z)
    if reaper.ImGui_Button(ctx, running and 'Stop' or 'Start') then
      running = not running
    end
    reaper.ImGui_End(ctx)
  end

  if running then
    doRandomWalk()
  end

  if open then
    reaper.defer(loop)
  else
    reaper.ImGui_DestroyContext(ctx)
  end
end

reaper.defer(loop)


