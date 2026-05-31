--[[
ICST AmbiEncoder_64 - Perlenkette Effekt mit Random Walk & Preset Management
✅ 64 Punkte
✅ Preset speichern über Textfeld-Namen (kein GetUserFileNameForWrite nötig)
✅ Preset-Ordner mit Dropdown
✅ Z-Offset-Slider
Benötigt: ReaImGui (ReaPack)
]]

local ctx = reaper.ImGui_CreateContext('AmbiEncoder Perlenkette Random Presets')
local track = reaper.GetTrack(0, 0)
local fx = 0

-- Parameter-Indizes für 64 Punkte (anpassen falls nötig!)
local x_params, y_params, z_params = {}, {}, {}
for i = 0,63 do
  x_params[i+1] = 10 + i*5
  y_params[i+1] = 11 + i*5
  z_params[i+1] = 12 + i*5
end
local pointCount = 64

-- Positionen
local px, py, pz = {}, {}, {}
for i=1,pointCount do px[i],py[i],pz[i] = 0,0,0 end

-- Random Walk
local targetX,targetY,targetZ = 0,0,0
local frameCounter = 0
local updateInterval = 60

-- GUI-Parameter
local gain = 0.10
local stepSize = 0.2
local smoothFactor = 0.01
local enableZ = false
local zOffset = 0.0
local running = false

-- Preset Verwaltung
local presetDir = reaper.GetResourcePath().."/AmbiPearlPresets/"
reaper.RecursiveCreateDirectory(presetDir,0)
local presetFiles = {}
local selectedPreset = 1
local presetName = "MyPreset"

-- Funktionen
local function clamp01(v) return math.max(0,math.min(1,v)) end
local function setPoint(i,x,y,z)
  reaper.TrackFX_SetParam(track,fx,x_params[i],clamp01((x+1)/2))
  reaper.TrackFX_SetParam(track,fx,y_params[i],clamp01((y+1)/2))
  reaper.TrackFX_SetParam(track,fx,z_params[i],clamp01((z+zOffset+1)/2))
end

local function newTarget()
  targetX = (math.random()*2-1)*stepSize
  targetY = (math.random()*2-1)*stepSize
  targetZ = enableZ and (math.random()*2-1)*stepSize or 0.0
end

local function savePreset(path)
  local f = io.open(path,"w")
  if not f then return end
  f:write(string.format("%f;%f;%f;%d;%f;%d\n",
    gain,stepSize,smoothFactor,updateInterval,zOffset,enableZ and 1 or 0))
  f:close()
end

local function loadPreset(path)
  local f = io.open(path,"r")
  if not f then return end
  local line = f:read("*l"); f:close()
  if line then
    local g,sf,sm,ui,zo,ez = line:match("([^;]+);([^;]+);([^;]+);([^;]+);([^;]+);([^;]+)")
    gain = tonumber(g) or gain
    stepSize = tonumber(sf) or stepSize
    smoothFactor = tonumber(sm) or smoothFactor
    updateInterval = tonumber(ui) or updateInterval
    zOffset = tonumber(zo) or zOffset
    enableZ = (tonumber(ez)==1)
  end
end

local function refreshPresets()
  presetFiles = {}
  local i = 0
  repeat
    local file = reaper.EnumerateFiles(presetDir,i)
    if file then
      if file:match("%.txt$") then
        table.insert(presetFiles,file)
      end
    end
    i = i + 1
  until not file
  if #presetFiles == 0 then table.insert(presetFiles,"<keine Presets>") end
  selectedPreset = 1
end

refreshPresets()

-- Loop
local function loop()
  local visible, open = reaper.ImGui_Begin(ctx, 'AmbiEncoder Perlenkette Random (64)', true)
  if visible then
    if reaper.ImGui_Button(ctx, running and 'Stop' or 'Start') then
      running = not running
    end
    reaper.ImGui_SameLine(ctx)
    -- Textfeld für Preset Name
    _, presetName = reaper.ImGui_InputText(ctx, 'Preset Name', presetName)
    reaper.ImGui_SameLine(ctx)
    if reaper.ImGui_Button(ctx,'Save Preset') then
      local path = presetDir .. presetName .. ".txt"
      savePreset(path)
      refreshPresets()
    end
    reaper.ImGui_SameLine(ctx)
    if reaper.ImGui_Button(ctx,'Load Preset (Dialog)') then
      local retval, path = reaper.GetUserFileNameForRead("Choose Preset","txt")
      if retval then loadPreset(path) end
    end

    -- Dropdown Presets
    if reaper.ImGui_BeginCombo(ctx,"Preset auswählen", presetFiles[selectedPreset] or "") then
      for i, name in ipairs(presetFiles) do
        local sel = (i==selectedPreset)
        if reaper.ImGui_Selectable(ctx,name,sel) then
          selectedPreset = i
        end
      end
      reaper.ImGui_EndCombo(ctx)
    end
    reaper.ImGui_SameLine(ctx)
    if reaper.ImGui_Button(ctx,'Load Selected') and presetFiles[selectedPreset] and presetFiles[selectedPreset]~="<keine Presets>" then
      loadPreset(presetDir..presetFiles[selectedPreset])
    end

    -- Slider
    _, gain           = reaper.ImGui_SliderDouble(ctx,'Follow Gain',gain,0.01,1.0,'%.2f')
    _, stepSize       = reaper.ImGui_SliderDouble(ctx,'Random Area',stepSize,0.05,1.0,'%.2f')
    _, smoothFactor   = reaper.ImGui_SliderDouble(ctx,'Smooth Factor',smoothFactor,0.001,0.05,'%.3f')
    _, updateInterval = reaper.ImGui_SliderInt(ctx,'Update Interval (Frames)',updateInterval,1,600)
    _, zOffset        = reaper.ImGui_SliderDouble(ctx,'Z Offset',zOffset,-1.0,1.0,'%.2f')
    _, enableZ        = reaper.ImGui_Checkbox(ctx,'Z bewegen',enableZ)

    reaper.ImGui_Separator(ctx)
    reaper.ImGui_Text(ctx, 'P1: Random Walk (smooth), andere folgen')

    if running then
      frameCounter = frameCounter + 1
      if frameCounter > updateInterval then
        frameCounter = 0
        newTarget()
      end

      -- Masterpunkt
      px[1] = px[1] + (targetX - px[1]) * smoothFactor
      py[1] = py[1] + (targetY - py[1]) * smoothFactor
      pz[1] = pz[1] + (targetZ - pz[1]) * smoothFactor

      -- Perlenkette
      for i=2,pointCount do
        px[i] = px[i] + (px[i-1]-px[i]) * gain
        py[i] = py[i] + (py[i-1]-py[i]) * gain
        pz[i] = pz[i] + (pz[i-1]-pz[i]) * gain
      end

      -- In Plugin schreiben
      for i=1,pointCount do
        setPoint(i,px[i],py[i],pz[i])
      end
    end

    reaper.ImGui_End(ctx)
  end

  if open then
    reaper.defer(loop)
  else
    reaper.ImGui_DestroyContext(ctx)
  end
end

math.randomseed(os.time())
reaper.defer(loop)


