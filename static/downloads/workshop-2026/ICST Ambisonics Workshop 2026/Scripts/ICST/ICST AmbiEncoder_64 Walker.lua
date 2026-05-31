-- AmbiEncoder_64 Random Walk Script mit ReaImGui GUI und Figuren-Linien-Visualisierung für alle 64 Quellen (nur XYZ, ohne Gain/Mute)
-- Autor: Dein Reaper Assistent

-- ========================
-- Anfangswerte
local speed = 0.01      -- Schrittgröße pro Tick
local range = 1.0       -- maximale Range (normalisiert -1.0 bis +1.0)
local include_z = false -- Z ebenfalls bewegen? true/false
-- ========================

-- ReaImGui Setup
local ctx = reaper.ImGui_CreateContext('AmbiEncoder Random Walk')
local sizeX, sizeY = 600, 600
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
    pos.x = clamp(pos.x + (math.random()*2-1)*speed, -range, range)
    reaper.TrackFX_SetParam(track, fx_index, get_param_index_xyz(0, s), (pos.x*0.5)+0.5)
    pos.y = clamp(pos.y + (math.random()*2-1)*speed, -range, range)
    reaper.TrackFX_SetParam(track, fx_index, get_param_index_xyz(1, s), (pos.y*0.5)+0.5)
    if include_z then
      pos.z = clamp(pos.z + (math.random()*2-1)*speed, -range, range)
      reaper.TrackFX_SetParam(track, fx_index, get_param_index_xyz(2, s), (pos.z*0.5)+0.5)
    end
  end
end

function drawFigure()
  -- Canvas zeichnen
  local draw_list = reaper.ImGui_GetWindowDrawList(ctx)
  local cx, cy = reaper.ImGui_GetWindowPos(ctx)
  local w, h = reaper.ImGui_GetWindowSize(ctx)
  local centerX, centerY = cx + w/2, cy + h/2 + 50
  local scale = (math.min(w,h)/2) * 0.8

  -- Linien zwischen den Punkten zeichnen (z.B. alle 64 verbinden)
  local prevX, prevY
  for i,s in ipairs(sources) do
    local pos = positions[s]
    local px = centerX + (pos.x * scale)
    local py = centerY - (pos.y * scale)
    if prevX then
      reaper.ImGui_DrawList_AddLine(draw_list, prevX, prevY, px, py, 0xFF00FF00, 1.5)
    end
    prevX, prevY = px, py
    -- Punkte zeichnen
    reaper.ImGui_DrawList_AddCircleFilled(draw_list, px, py, 3, 0xFFFFFFFF)
  end
  -- Schließe die Figur zurück zum ersten Punkt
  if #sources > 1 then
    local firstPos = positions[sources[1]]
    local fx = centerX + (firstPos.x * scale)
    local fy = centerY - (firstPos.y * scale)
    local lastPos = positions[sources[#sources]]
    local lx = centerX + (lastPos.x * scale)
    local ly = centerY - (lastPos.y * scale)
    reaper.ImGui_DrawList_AddLine(draw_list, lx, ly, fx, fy, 0xFF00FF00, 1.5)
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
    drawFigure()
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

