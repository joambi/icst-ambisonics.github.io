-- AmbiEncoder_64: Kreis-Offsets setzen + RandomWalk+Rotation starten
-- Autor: Dein Reaper Assistent

-------------------------------------
-- GUI Parameter für Kreis setzen
local circle_radius = 0.5
local circle_points = 64
local circle_startAngle = 0.0
local circle_clockwise = true

-------------------------------------
-- Bewegungseinstellungen
local rot_speed = 0.1
local random_speed = 0.01
local random_range = 1.0
local include_z = false

-------------------------------------
-- Preset-Verwaltung für Bewegungswerte
local presetDir = reaper.GetResourcePath().."/AmbiCirclePresets/"
reaper.RecursiveCreateDirectory(presetDir, 0)
local presetName = "MyPreset"
local presetFiles = {}
local selectedPreset = 1

local function refreshPresets()
  presetFiles = {}
  local i = 0
  repeat
    local file = reaper.EnumerateFiles(presetDir,i)
    if file then if file:match("%.txt$") then table.insert(presetFiles,file) end end
    i=i+1
  until not file
  if #presetFiles==0 then table.insert(presetFiles,"<keine Presets>") end
  selectedPreset=1
end

local function savePreset(name)
  local f=io.open(presetDir..name..".txt","w")
  if not f then return end
  f:write(string.format("%f;%f;%f;%d\n",rot_speed,random_speed,random_range,include_z and 1 or 0))
  f:close()
  refreshPresets()
end

local function loadPreset(path)
  local f=io.open(path,"r")
  if not f then return end
  local line=f:read("*l"); f:close()
  if line then
    local rs,rws,rr,iz = line:match("([^;]+);([^;]+);([^;]+);([^;]+)")
    rot_speed = tonumber(rs) or rot_speed
    random_speed = tonumber(rws) or random_speed
    random_range = tonumber(rr) or random_range
    include_z = (tonumber(iz)==1)
  end
end

refreshPresets()

-------------------------------------
-- Track & FX holen
local track = reaper.GetSelectedTrack(0,0)
if not track then reaper.ShowMessageBox("Bitte einen Track mit AmbiEncoder_64 auswählen!","Fehler",0) return end
local fx_index = reaper.TrackFX_AddByName(track, "AmbiEncoder_64", false, 0)
if fx_index < 0 then reaper.ShowMessageBox("Kein AmbiEncoder_64 gefunden!","Fehler",0) return end

-- Hilfsfunktionen
local function setParam(idx,v) reaper.TrackFX_SetParam(track,fx_index,idx, math.max(0,math.min(1,(v+1)/2))) end
local function getParam(idx) local v=reaper.TrackFX_GetParam(track,fx_index,idx) return (v*2)-1 end

-- Punkte vorbereiten
local points={}
for i=1,64 do
  points[i]={x_idx=10+(i-1)*5,y_idx=11+(i-1)*5,z_idx=12+(i-1)*5,pos={x=0,y=0,z=0},offset={x=0,y=0,z=0}}
end
local gp={x=0,y=0,z=0}
local gxIndex,gyIndex,gzIndex=330,331,332

-------------------------------------
-- Kreis setzen
local function applyCircle()
  for i=1,circle_points do
    local angle = circle_startAngle + (i-1)*(2*math.pi/circle_points)
    if circle_clockwise then angle=-angle end
    local x = math.cos(angle)*circle_radius
    local y = math.sin(angle)*circle_radius
    local z = 0.0
    local base = (i-1)*5
    setParam(10+base,x)
    setParam(11+base,y)
    setParam(12+base,z)
  end
  reaper.ShowMessageBox("Kreis gesetzt mit "..circle_points.." Punkten, Radius "..circle_radius,"Fertig",0)
end

-------------------------------------
-- Ausgangswerte lesen
local function readBasePositions()
  local cx,cy,cz,count=0,0,0,0
  for _,p in ipairs(points) do
    local x,y,z=getParam(p.x_idx),getParam(p.y_idx),getParam(p.z_idx)
    p.pos.x,p.pos.y,p.pos.z=x,y,z
    cx,cy,cz=cx+x,cy+y,cz+z
    count=count+1
  end
  gp.x,gp.y,gp.z=cx/count,cy/count,cz/count
  for _,p in ipairs(points) do
    p.offset.x=p.pos.x-gp.x
    p.offset.y=p.pos.y-gp.y
    p.offset.z=p.pos.z-gp.z
  end
end

-------------------------------------
-- Bewegung
local function randomWalkGP()
  gp.x=math.max(-random_range,math.min(random_range,gp.x+(math.random()*2-1)*random_speed))
  gp.y=math.max(-random_range,math.min(random_range,gp.y+(math.random()*2-1)*random_speed))
  if include_z then gp.z=math.max(-random_range,math.min(random_range,gp.z+(math.random()*2-1)*random_speed)) end
  setParam(gxIndex,gp.x); setParam(gyIndex,gp.y); setParam(gzIndex,gp.z)
end

local startTime=reaper.time_precise()
local function updatePoints()
  local t=reaper.time_precise()-startTime
  local angle=t*rot_speed*2*math.pi
  local ca,sa=math.cos(angle),math.sin(angle)
  for _,p in ipairs(points) do
    local ox,oy,oz=p.offset.x,p.offset.y,p.offset.z
    local rx=ox*ca-oy*sa
    local ry=ox*sa+oy*ca
    setParam(p.x_idx,gp.x+rx)
    setParam(p.y_idx,gp.y+ry)
    setParam(p.z_idx,gp.z+oz)
    p.pos.x,p.pos.y,p.pos.z=gp.x+rx,gp.y+ry,gp.z+oz
  end
end

local function drawFigure(ctx)
  local draw=reaper.ImGui_GetWindowDrawList(ctx)
  local cx,cy=reaper.ImGui_GetWindowPos(ctx)
  local w,h=reaper.ImGui_GetWindowSize(ctx)
  local centerX,centerY=cx+w/2,cy+h/2
  local scale=(math.min(w,h)/2)*0.8
  reaper.ImGui_DrawList_AddCircle(draw,centerX,centerY,scale*random_range,0x44FFFFFF,64,1.0)
  local prevX,prevY
  for _,p in ipairs(points) do
    local px=centerX+(p.pos.x*scale)
    local py=centerY-(p.pos.y*scale)
    if prevX then reaper.ImGui_DrawList_AddLine(draw,prevX,prevY,px,py,0xFF00FF00,1.5) end
    reaper.ImGui_DrawList_AddCircleFilled(draw,px,py,3,0xFFFFFFFF)
    prevX,prevY=px,py
  end
end

-------------------------------------
-- GUI Loop
local ctx=reaper.ImGui_CreateContext('AmbiEncoder64 Kreis+Walk')
local running=false
reaper.ImGui_SetNextWindowSize(ctx,600,600,reaper.ImGui_Cond_FirstUseEver())

local function loop()
  local visible,open=reaper.ImGui_Begin(ctx,'AmbiEncoder64 Kreis+Walk',true)
  if visible then
    reaper.ImGui_Text(ctx,"🔄 Kreis-Offsets setzen")
    _,circle_radius=reaper.ImGui_SliderDouble(ctx,'Kreis-Radius',circle_radius,0.1,1.0,'%.2f')
    _,circle_points=reaper.ImGui_SliderInt(ctx,'Punkte-Anzahl',circle_points,1,64)
    _,circle_startAngle=reaper.ImGui_SliderDouble(ctx,'Startwinkel',circle_startAngle,0.0,math.pi*2,'%.2f')
    _,circle_clockwise=reaper.ImGui_Checkbox(ctx,'Uhrzeigersinn',circle_clockwise)
    if reaper.ImGui_Button(ctx,"Apply Kreis") then applyCircle() end

    reaper.ImGui_Separator(ctx)
    reaper.ImGui_Text(ctx,"⚙️ Bewegungs-Parameter")
    _,rot_speed=reaper.ImGui_SliderDouble(ctx,'Rotationsgeschw.',rot_speed,0.0,2.0,'%.3f')
    _,random_speed=reaper.ImGui_SliderDouble(ctx,'RandomWalk Speed',random_speed,0.0,0.1,'%.4f')
    _,random_range=reaper.ImGui_SliderDouble(ctx,'Random Range',random_range,0.1,1.0,'%.2f')
    _,include_z=reaper.ImGui_Checkbox(ctx,'Z-Achse',include_z)

    if reaper.ImGui_Button(ctx,running and 'Stop Bewegung' or 'Start Bewegung') then
      running=not running
      if running then startTime=reaper.time_precise(); readBasePositions() end
    end

    -- Preset Verwaltung
    _,presetName=reaper.ImGui_InputText(ctx,'Preset Name',presetName)
    if reaper.ImGui_Button(ctx,'Save Preset') then savePreset(presetName) end
    reaper.ImGui_SameLine(ctx)
    if reaper.ImGui_Button(ctx,'Load Dialog') then
      -- Korrigierter Aufruf mit Dummy-Dateiname
      local startfile = reaper.GetResourcePath() .. "/preset.txt"
      local ok, path = reaper.GetUserFileNameForRead(startfile, "txt")
      if ok then loadPreset(path) end
    end
    if reaper.ImGui_BeginCombo(ctx,'Preset wählen',presetFiles[selectedPreset] or "") then
      for i,n in ipairs(presetFiles) do
        if reaper.ImGui_Selectable(ctx,n,(i==selectedPreset)) then selectedPreset=i end
      end
      reaper.ImGui_EndCombo(ctx)
    end
    reaper.ImGui_SameLine(ctx)
    if reaper.ImGui_Button(ctx,'Load Selected') and presetFiles[selectedPreset] and presetFiles[selectedPreset]~="<keine Presets>" then
      loadPreset(presetDir..presetFiles[selectedPreset])
    end

    drawFigure(ctx)
    reaper.ImGui_End(ctx)
  end

  if running then
    randomWalkGP()
    updatePoints()
  end

  if open then reaper.defer(loop) else reaper.ImGui_DestroyContext(ctx) end
end

reaper.defer(loop)


