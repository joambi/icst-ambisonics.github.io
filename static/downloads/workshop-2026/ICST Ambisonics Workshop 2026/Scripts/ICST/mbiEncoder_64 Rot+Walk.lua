-- AmbiEncoder_64 Random Walk + Rotation Script mit ReaImGui GUI und Linien-Visualisierung
-- Autor: Dein Reaper Assistent

-- ========================
-- Anfangswerte
local rot_speed = 0.1        -- Umdrehungen pro Sekunde
local random_speed = 0.01    -- Schrittgröße des Random Walks
local random_range = 1.0     -- maximale Auslenkung (wird geclamped)
local include_z = false      -- Z-Achse mit einbeziehen?
-- ========================

-- ImGui Setup
local ctx = reaper.ImGui_CreateContext('AmbiEncoder64 Rot+Walk')
local sizeX, sizeY = 600, 600
reaper.ImGui_SetNextWindowSize(ctx, sizeX, sizeY, reaper.ImGui_Cond_FirstUseEver())

-- Track & FX
local track = reaper.GetSelectedTrack(0,0)
if not track then reaper.ShowMessageBox("Bitte einen Track mit AmbiEncoder_64 auswählen!","Fehler",0) return end
local fx_index = reaper.TrackFX_AddByName(track, "AmbiEncoder_64", false, 0)
if fx_index < 0 then reaper.ShowMessageBox("Kein AmbiEncoder_64 im Track gefunden!","Fehler",0) return end

-- Punkte vorbereiten
local points = {}
for i=1,64 do
  points[i] = {
    x_idx = 10 + (i-1)*5,
    y_idx = 11 + (i-1)*5,
    z_idx = 12 + (i-1)*5,
    pos = {x=0,y=0,z=0}
  }
end

local function getParam(idx)
  local v = reaper.TrackFX_GetParam(track, fx_index, idx)
  return (v*2)-1
end
local function setParam(idx,val)
  local norm = math.max(0, math.min(1,(val+1)/2))
  reaper.TrackFX_SetParam(track, fx_index, idx, norm)
end

local function readBasePositions()
  for i,p in ipairs(points) do
    p.pos.x = getParam(p.x_idx)
    p.pos.y = getParam(p.y_idx)
    p.pos.z = getParam(p.z_idx)
  end
end

-- Random Walk für ALLE Punkte mit Range-Clamp
local function randomWalkAll()
  for i,p in ipairs(points) do
    p.pos.x = math.max(-random_range, math.min(random_range, p.pos.x + (math.random()*2-1)*random_speed))
    p.pos.y = math.max(-random_range, math.min(random_range, p.pos.y + (math.random()*2-1)*random_speed))
    if include_z then
      p.pos.z = math.max(-random_range, math.min(random_range, p.pos.z + (math.random()*2-1)*random_speed))
    end
    setParam(p.x_idx,p.pos.x)
    setParam(p.y_idx,p.pos.y)
    setParam(p.z_idx,p.pos.z)
  end
end

local function drawFigure()
  local draw = reaper.ImGui_GetWindowDrawList(ctx)
  local cx,cy = reaper.ImGui_GetWindowPos(ctx)
  local w,h = reaper.ImGui_GetWindowSize(ctx)
  local centerX,centerY = cx+w/2, cy+h/2
  local scale = (math.min(w,h)/2)*0.8
  local prevX,prevY
  for i,p in ipairs(points) do
    local px = centerX + (p.pos.x*scale)
    local py = centerY - (p.pos.y*scale)
    if prevX then
      reaper.ImGui_DrawList_AddLine(draw, prevX, prevY, px, py, 0xFF00FF00,1.5)
    end
    reaper.ImGui_DrawList_AddCircleFilled(draw, px, py, 3, 0xFFFFFFFF)
    prevX,prevY = px,py
  end
  if #points>1 then
    local first = points[1]
    local fx = centerX + (first.pos.x*scale)
    local fy = centerY - (first.pos.y*scale)
    local last = points[#points]
    local lx = centerX + (last.pos.x*scale)
    local ly = centerY - (last.pos.y*scale)
    reaper.ImGui_DrawList_AddLine(draw, lx, ly, fx, fy, 0xFF00FF00,1.5)
  end
end

local running = false
local function loop()
  local visible,open = reaper.ImGui_Begin(ctx,'AmbiEncoder64 Random Walk All',true)
  if visible then
    _, random_speed = reaper.ImGui_SliderDouble(ctx,'RandomWalk Speed',random_speed,0.0,0.1,'%.4f')
    _, random_range = reaper.ImGui_SliderDouble(ctx,'RandomWalk Range',random_range,0.0,1.0,'%.3f')
    _, include_z = reaper.ImGui_Checkbox(ctx,'Z-Achse',include_z)
    if reaper.ImGui_Button(ctx,running and 'Stop' or 'Start') then
      running = not running
      if running then readBasePositions() end
    end
    drawFigure()
    reaper.ImGui_End(ctx)
  end
  if running then
    randomWalkAll()
  end
  if open then reaper.defer(loop) else reaper.ImGui_DestroyContext(ctx) end
end

readBasePositions()
reaper.defer(loop)


