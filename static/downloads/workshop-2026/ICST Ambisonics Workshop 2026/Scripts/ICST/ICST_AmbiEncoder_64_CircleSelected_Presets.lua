-- AmbiEncoder_64: Auswählbare Punkte + Kreis-Presets mit Namen + Export/Import + Visualisierung

-- === Parameter ===
local circle_radius = 0.5
local circle_points = 64
local circle_startAngle = 0.0
local circle_clockwise = true
local angle_step = 1.0
local offset_per_point = 0.0
local rot_speed = 0.1
local random_speed = 0.01
local random_range = 1.0
local include_z = false

-- === Track holen ===
local track = reaper.GetSelectedTrack(0,0)
if not track then reaper.ShowMessageBox("Bitte einen Track mit AmbiEncoder_64 auswählen!","Fehler",0) return end
local fx_index = reaper.TrackFX_AddByName(track, "AmbiEncoder_64", false, 0)
if fx_index < 0 then reaper.ShowMessageBox("Kein AmbiEncoder_64 gefunden!","Fehler",0) return end

-- === Daten vorbereiten ===
local points = {}
for i=1,64 do
  points[i] = {
    x_idx = 10+(i-1)*5,
    y_idx = 11+(i-1)*5,
    z_idx = 12+(i-1)*5,
    pos = {x=0,y=0,z=0},
    offset = {x=0,y=0,z=0}
  }
end
local gp = {x=0,y=0,z=0}
local gxIndex,gyIndex,gzIndex = 330,331,332
local selectedPoints = {}
for i=1,64 do selectedPoints[i] = false end

-- === Helper ===
local function setParam(idx,v)
  reaper.TrackFX_SetParam(track,fx_index,idx, math.max(0,math.min(1,(v+1)/2)))
end
local function getParam(idx)
  local v = reaper.TrackFX_GetParam(track,fx_index,idx)
  return (v*2)-1
end

-- === Kreis setzen ===
local function applyCircle()
  for i=1,circle_points do
    if selectedPoints[i] then
      local angle = circle_startAngle + (i-1)*(2*math.pi/circle_points)*angle_step
      if circle_clockwise then angle = -angle end
      local radius = circle_radius + (i-1)*offset_per_point
      setParam(points[i].x_idx, math.cos(angle)*radius)
      setParam(points[i].y_idx, math.sin(angle)*radius)
      setParam(points[i].z_idx, 0.0)
    end
  end
  reaper.ShowMessageBox("Kreis gesetzt!","Fertig",0)
end

-- === Positionen einlesen ===
local function readBasePositions()
  local cx,cy,cz,count = 0,0,0,0
  for i,p in ipairs(points) do
    if selectedPoints[i] then
      p.pos.x, p.pos.y, p.pos.z = getParam(p.x_idx), getParam(p.y_idx), getParam(p.z_idx)
      cx,cy,cz = cx+p.pos.x, cy+p.pos.y, cz+p.pos.z
      count = count+1
    end
  end
  if count>0 then
    gp.x,gp.y,gp.z = cx/count,cy/count,cz/count
    for i,p in ipairs(points) do
      if selectedPoints[i] then
        p.offset.x = p.pos.x-gp.x
        p.offset.y = p.pos.y-gp.y
        p.offset.z = p.pos.z-gp.z
      end
    end
  end
end

-- === Bewegung ===
local function randomWalkGP()
  gp.x = math.max(-random_range, math.min(random_range, gp.x+(math.random()*2-1)*random_speed))
  gp.y = math.max(-random_range, math.min(random_range, gp.y+(math.random()*2-1)*random_speed))
  if include_z then
    gp.z = math.max(-random_range, math.min(random_range, gp.z+(math.random()*2-1)*random_speed))
  end
  setParam(gxIndex,gp.x); setParam(gyIndex,gp.y); setParam(gzIndex,gp.z)
end

local startTime = reaper.time_precise()
local function updatePoints()
  local t = reaper.time_precise()-startTime
  local ca,sa = math.cos(t*rot_speed*2*math.pi), math.sin(t*rot_speed*2*math.pi)
  for i,p in ipairs(points) do
    if selectedPoints[i] then
      local rx = p.offset.x*ca - p.offset.y*sa
      local ry = p.offset.x*sa + p.offset.y*ca
      setParam(p.x_idx,gp.x+rx)
      setParam(p.y_idx,gp.y+ry)
      setParam(p.z_idx,gp.z+p.offset.z)
      p.pos.x,p.pos.y,p.pos.z = gp.x+rx,gp.y+ry,gp.z+p.offset.z
    end
  end
end

-- === Export / Import Auswahl ===
local function exportSelection(path)
  local f = io.open(path,"w"); if not f then return end
  for i=1,64 do f:write(selectedPoints[i] and "1" or "0"); if i<64 then f:write(",") end end
  f:close()
end
local function importSelection(path)
  local f = io.open(path,"r"); if not f then return end
  local data = f:read("*a"); f:close()
  local idx=1; for val in string.gmatch(data,"[^,]+") do selectedPoints[idx]=(val=="1"); idx=idx+1 end
end

-- === Presets ===
local presetDir = reaper.GetResourcePath().."/AmbiPresets"
reaper.RecursiveCreateDirectory(presetDir,0)

local function listPresets()
  local list = {}
  local i = 0
  while true do
    local fname = reaper.EnumerateFiles(presetDir, i)
    if not fname then break end
    if fname:sub(-4) == ".txt" then
      list[#list+1] = fname:gsub("%.txt$","")
    end
    i = i + 1
  end
  return list
end

local function saveCirclePreset(name)
  if not name or name=="" then return end
  local f = io.open(presetDir.."/"..name..".txt","w"); if not f then return end
  f:write(string.format("%f;%d;%f;%d;%f;%f\n",circle_radius,circle_points,circle_startAngle,circle_clockwise and 1 or 0,angle_step,offset_per_point))
  f:close(); reaper.ShowMessageBox("Preset '"..name.."' gespeichert.","Preset",0)
end

local function loadCirclePreset(name)
  if not name or name=="" then return end
  local f = io.open(presetDir.."/"..name..".txt","r"); if not f then return end
  local line=f:read("*l"); f:close()
  if line then
    local r,p,a,c,as,off = line:match("([^;]+);([^;]+);([^;]+);([^;]+);([^;]+);([^;]+)")
    circle_radius=tonumber(r)or circle_radius; circle_points=tonumber(p)or circle_points
    circle_startAngle=tonumber(a)or circle_startAngle; circle_clockwise=(tonumber(c)==1)
    angle_step=tonumber(as)or angle_step; offset_per_point=tonumber(off)or offset_per_point
    reaper.ShowMessageBox("Preset '"..name.."' geladen.","Preset",0)
  end
end

-- === Visualisierung ===
local function drawFigure(ctx)
  local draw = reaper.ImGui_GetWindowDrawList(ctx)
  local cx,cy = reaper.ImGui_GetWindowPos(ctx)
  local w,h = reaper.ImGui_GetWindowSize(ctx)
  local centerX,centerY = cx+w/2, cy+h/2
  local scale = (math.min(w,h)/2)*0.8
  reaper.ImGui_DrawList_AddCircle(draw,centerX,centerY,scale*random_range,0x44FFFFFF,64,1.0)
  local px,py,prevX,prevY
  for i,p in ipairs(points) do
    if selectedPoints[i] then
      px,py = centerX+p.pos.x*scale, centerY-p.pos.y*scale
      if prevX then reaper.ImGui_DrawList_AddLine(draw,prevX,prevY,px,py,0xFF00FF00,1.5) end
      reaper.ImGui_DrawList_AddCircleFilled(draw,px,py,3,0xFFFFFFFF)
      prevX,prevY = px,py
    end
  end
end

-- === GUI ===
local ctx = reaper.ImGui_CreateContext('AmbiEncoder64 Kreis+Walk (Presets)')
local running = false
reaper.ImGui_SetNextWindowSize(ctx,700,950,reaper.ImGui_Cond_FirstUseEver())

local presetName = ""
local presets = listPresets()
local selectedPresetIndex = 0

local function loop()
  local visible,open = reaper.ImGui_Begin(ctx,'AmbiEncoder64 Kreis+Walk (Presets)',true)
  if visible then
    reaper.ImGui_Text(ctx,"✅ Punkte auswählen:")
    if reaper.ImGui_Button(ctx,"Alle auswählen") then for i=1,64 do selectedPoints[i]=true end end
    reaper.ImGui_SameLine(ctx)
    if reaper.ImGui_Button(ctx,"Alle abwählen") then for i=1,64 do selectedPoints[i]=false end end
    for i=1,64 do
      local changed
      changed,selectedPoints[i]=reaper.ImGui_Checkbox(ctx,tostring(i),selectedPoints[i])
      if (i%8)~=0 then reaper.ImGui_SameLine(ctx) end
    end

    reaper.ImGui_Separator(ctx)
    reaper.ImGui_Text(ctx,"🔄 Kreis-Offsets setzen")
    _,circle_radius=reaper.ImGui_SliderDouble(ctx,'Kreis-Radius',circle_radius,0.1,1.0,'%.2f')
    _,circle_points=reaper.ImGui_SliderInt(ctx,'Punkte-Anzahl',circle_points,1,64)
    _,circle_startAngle=reaper.ImGui_SliderDouble(ctx,'Startwinkel',circle_startAngle,0.0,math.pi*2,'%.2f')
    _,circle_clockwise=reaper.ImGui_Checkbox(ctx,'Uhrzeigersinn',circle_clockwise)
    _,angle_step=reaper.ImGui_SliderDouble(ctx,'Winkel-Abstand',angle_step,0.1,3.0,'%.2f')
    _,offset_per_point=reaper.ImGui_SliderDouble(ctx,'Abstandszuwachs',offset_per_point,-0.05,0.05,'%.3f')
    if reaper.ImGui_Button(ctx,"Apply Kreis") then applyCircle() end

    reaper.ImGui_Separator(ctx)
    reaper.ImGui_Text(ctx,"💾 Preset-Name:")
    local ch; ch,presetName = reaper.ImGui_InputText(ctx,"##PresetName",presetName)
    if reaper.ImGui_Button(ctx,"Preset speichern") then
      saveCirclePreset(presetName)
      presets = listPresets()
    end

    if #presets>0 then
      local comboItems = table.concat(presets, "\0") .. "\0"
      local changedIdx
      changedIdx, selectedPresetIndex = reaper.ImGui_Combo(ctx, "##PresetList", selectedPresetIndex, comboItems, #presets)
      reaper.ImGui_SameLine(ctx)
      if reaper.ImGui_Button(ctx,"Preset laden") then
        loadCirclePreset(presets[selectedPresetIndex+1])
      end
    end

    reaper.ImGui_Separator(ctx)
    reaper.ImGui_Text(ctx,"📤 Export / 📥 Import Punkte")
    if reaper.ImGui_Button(ctx,"Punkte exportieren") then
      local exportPath = reaper.GetResourcePath().."/points_export.txt"
      exportSelection(exportPath)
      reaper.ShowMessageBox("Exportiert nach:\n"..exportPath,"Export",0)
    end
    reaper.ImGui_SameLine(ctx)
    if reaper.ImGui_Button(ctx,"Punkte importieren") then
      -- ✅ FIX: korrekte 3 Argumente
      local ok, path = reaper.GetUserFileNameForRead(
        reaper.GetResourcePath().."/points_export.txt",
        "Punkte Importieren",
        "txt"
      )
      if ok then importSelection(path) end
    end

    reaper.ImGui_Separator(ctx)
    reaper.ImGui_Text(ctx,"⚙️ Bewegung")
    _,rot_speed=reaper.ImGui_SliderDouble(ctx,'Rotationsgeschw.',rot_speed,0.0,2.0,'%.3f')
    _,random_speed=reaper.ImGui_SliderDouble(ctx,'RandomWalk Speed',random_speed,0.0,0.1,'%.4f')
    _,random_range=reaper.ImGui_SliderDouble(ctx,'Random Range',random_range,0.1,1.0,'%.2f')
    _,include_z=reaper.ImGui_Checkbox(ctx,'Z-Achse',include_z)
    if reaper.ImGui_Button(ctx,running and "Stop Bewegung" or "Start Bewegung") then
      running=not running
      if running then startTime=reaper.time_precise(); readBasePositions() end
    end

    drawFigure(ctx)
    reaper.ImGui_End(ctx)
  end

  if running then randomWalkGP(); updatePoints() end
  if open then reaper.defer(loop) else reaper.ImGui_DestroyContext(ctx) end
end

reaper.defer(loop)


