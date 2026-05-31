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
    pos = {x=0,y=0,z=0},
    offset = {x=0,y=0,z=0}
  }
end

-- GP (Group Point) Parameter Indices
local gxIndex, gyIndex, gzIndex = 330, 331, 332
local gp = {x=0,y=0,z=0}

local function getParam(idx)
  local v = reaper.TrackFX_GetParam(track, fx_index, idx)
  return (v*2)-1
end
local function setParam(idx,val)
  local norm = math.max(0, math.min(1,(val+1)/2))
  reaper.TrackFX_SetParam(track, fx_index, idx, norm)
end

local function readBasePositions()
  local cx, cy, cz, count = 0,0,0,0
  for i,p in ipairs(points) do
    local x = getParam(p.x_idx)
    local y = getParam(p.y_idx)
    local z = getParam(p.z_idx)
    p.pos.x, p.pos.y, p.pos.z = x,y,z
    cx,cy,cz = cx+x,cy+y,cz+z
    count = count+1
  end
  gp.x, gp.y, gp.z = cx/count, cy/count, cz/count
  for i,p in ipairs(points) do
    p.offset.x = p.pos.x-gp.x
    p.offset.y = p.pos.y-gp.y
    p.offset.z = p.pos.z-gp.z
  end
end

-- Random Walk für GroupPoint mit Range-Clamp
local function randomWalkGP()
  gp.x = math.max(-random_range, math.min(random_range, gp.x + (math.random()*2-1)*random_speed))
  gp.y = math.max(-random_range, math.min(random_range, gp.y + (math.random()*2-1)*random_speed))
  if include_z then
    gp.z = math.max(-random_range, math.min(random_range, gp.z + (math.random()*2-1)*random_speed))
  end
  setParam(gxIndex,gp.x)
  setParam(gyIndex,gp.y)
  setParam(gzIndex,gp.z)
end

local startTime = reaper.time_precise()
local function updatePoints()
  local t = reaper.time_precise() - startTime
  local angle = t * rot_speed * 2*math.pi
  local ca,sa = math.cos(angle),math.sin(angle)
  for i,p in ipairs(points) do
    local ox,oy,oz = p.offset.x,p.offset.y,p.offset.z
    local rx = ox*ca - oy*sa
    local ry = ox*sa + oy*ca
    setParam(p.x_idx, gp.x+rx)
    setParam(p.y_idx, gp.y+ry)
    setParam(p.z_idx, gp.z+oz)
    p.pos.x,p.pos.y,p.pos.z = gp.x+rx,gp.y+ry,gp.z+oz
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
  local visible,open = reaper.ImGui_Begin(ctx,'AmbiEncoder64 Rot+Walk',true)
  if visible then
    _, rot_speed = reaper.ImGui_SliderDouble(ctx,'Rotationsgeschw.',rot_speed,0.0,2.0,'%.3f')
    _, random_speed = reaper.ImGui_SliderDouble(ctx,'RandomWalk Speed',random_speed,0.0,0.1,'%.4f')
    _, random_range = reaper.ImGui_SliderDouble(ctx,'RandomWalk Range',random_range,0.0,1.0,'%.3f')
    _, include_z = reaper.ImGui_Checkbox(ctx,'Z-Achse',include_z)
    if reaper.ImGui_Button(ctx,running and 'Stop' or 'Start') then
      running = not running
      if running then startTime = reaper.time_precise(); readBasePositions() end
    end
    drawFigure()
    reaper.ImGui_End(ctx)
  end
  if running then
    randomWalkGP()
    updatePoints()
  end
  if open then reaper.defer(loop) else reaper.ImGui_DestroyContext(ctx) end
end

readBasePositions()
reaper.defer(loop)


