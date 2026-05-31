-- ICST AmbiEncoder_64 Spiral Walk GUI mit JSON Load/Save, Speed Kontrolle, Radius-Limit und Z-Achsen-Scaler
-- Startpositionen der Punkte werden übernommen und starten exakt am Beginn der Zeitauswahl

local ctx = reaper.ImGui_CreateContext('ICST AmbiEncoder_64 Spiral Walk')
local visible = true

-- Default Settings
local steps = 200
local spiralSpread = 1.0
local maxRadius = 1.0
local minRadius = 0.1
local accelerando = 1.0
local reverseAccel = false
local includeZ = true
local numPointsToProcess = 8
local randomSeed = os.time()
local spiralOutward = true
local holdEnd = true
local speed = 1.0
local zScale = 1.0

local presets = {}
local script_path = ({reaper.get_action_context()})[2]:match("^(.*[/\\])")
local presetDir = script_path
local presetFileName = "spiralwalk_presets.json"
local presetFilePath = presetDir .. presetFileName
local presetInput = ""
local presetDirInput = presetDir

-- JSON Helper
local json = {}
function json.encode(val)
  local t = type(val)
  if t == "table" then
    local isArray = (#val > 0)
    local out = {}
    if isArray then
      for i,v in ipairs(val) do table.insert(out,json.encode(v)) end
      return "["..table.concat(out,",").."]"
    else
      for k,v in pairs(val) do table.insert(out,string.format("%q:%s",k,json.encode(v))) end
      return "{"..table.concat(out,",").."}"
    end
  elseif t=="string" then
    return string.format("%q",val)
  elseif t=="number" or t=="boolean" then
    return tostring(val)
  else
    return "null"
  end
end
function json.decode(str)
  local f = load("return "..str,"json","t",{})
  if not f then return {} end
  local ok,res = pcall(f)
  if ok and type(res)=="table" then return res else return {} end
end

local function savePresetsToDisk()
  local f = io.open(presetFilePath,"w")
  if f then f:write(json.encode(presets)) f:close() end
end

local function loadPresetsFromDisk()
  local f = io.open(presetFilePath,"r")
  if f then
    local content = f:read("*a")
    f:close()
    local loaded = json.decode(content)
    if type(loaded)=="table" then presets = loaded end
  end
end

local function buildSourceParamMap()
  local map = {}
  local firstSourceIndex = 10
  local blockSize = 5
  for p = 1, 64 do
    local base = firstSourceIndex + (p-1)*blockSize
    map[p] = {x = base, y = base+1, z = base+2}
  end
  return map
end
local sourceParamMap = buildSourceParamMap()

local function safeGetParamNormalized(track, fxIdx, paramIdx)
  local v = reaper.TrackFX_GetParamNormalized(track, fxIdx, paramIdx)
  return v or 0.0
end

local function generateSpiralWalk(startX, startY, steps, outward, spread, accel)
  local xVals, yVals = {}, {}
  local angle = math.random() * math.pi * 2
  local baseRadius = math.sqrt(startX * startX + startY * startY)
  local angleStepBase = (math.pi * 2 / steps)
  for i = 1, steps do
    local t = (i / steps) * spread
    local rRaw = outward and (baseRadius + t) or (baseRadius - t)
    if rRaw < minRadius then rRaw = minRadius end
    local r = math.max(-maxRadius, math.min(maxRadius, rRaw))
    if r < minRadius then r = minRadius end
    local accelFactor = accel
    if reverseAccel then accelFactor = -accel end
    local dynamicAngleStep = angleStepBase * speed * (1 + accelFactor * (i / steps))
    angle = angle + dynamicAngleStep
    xVals[i] = math.max(-1, math.min(1, r * math.cos(angle)))
    yVals[i] = math.max(-1, math.min(1, r * math.sin(angle)))
  end
  return xVals, yVals
end

local function createEnvelopeAndItem(track, fxIdx, paramIdx, values, startTime, endTime)
  local env = reaper.GetFXEnvelope(track, fxIdx, paramIdx, true)
  if not env then return end
  reaper.DeleteEnvelopePointRange(env, startTime, endTime)
  local duration = endTime - startTime
  for i, val in ipairs(values) do
    local t = startTime + ((i - 1) / (#values - 1)) * duration
    local normVal = (val + 1) / 2
    reaper.InsertEnvelopePoint(env, t, normVal, 0, 0, false, true)
    if holdEnd and (i == #values) then
      reaper.InsertEnvelopePoint(env, endTime + 0.0001, normVal, 0, 0, false, true)
    end
  end
  reaper.Envelope_SortPoints(env)
end

function applySpiralWalk()
  local ts, te = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
  if te <= ts then reaper.ShowMessageBox('Bitte Zeitbereich wählen', 'Fehler', 0) return end
  local trackCount = reaper.CountSelectedTracks(0)
  if trackCount == 0 then reaper.ShowMessageBox('Bitte Track auswählen', 'Fehler', 0) return end
  reaper.Undo_BeginBlock()
  for t = 0, trackCount-1 do
    local track = reaper.GetSelectedTrack(0, t)
    for fx = 0, reaper.TrackFX_GetCount(track)-1 do
      local _, name = reaper.TrackFX_GetFXName(track, fx, '')
      if name:match('AmbiEncoder_64') then
        for p = 1, numPointsToProcess do
          local m = sourceParamMap[p]
          -- Startposition wird zum Startzeitpunkt ts übernommen
          local startX = (safeGetParamNormalized(track, fx, m.x) * 2) - 1
          local startY = (safeGetParamNormalized(track, fx, m.y) * 2) - 1
          local startZ = (safeGetParamNormalized(track, fx, m.z) * 2) - 1
          local xs, ys = generateSpiralWalk(startX, startY, steps, spiralOutward, spiralSpread, accelerando)
          createEnvelopeAndItem(track, fx, m.x, xs, ts, te)
          createEnvelopeAndItem(track, fx, m.y, ys, ts, te)
          if includeZ then
            local zVals = {}
            for i = 1, steps do
              zVals[i] = math.max(-1, math.min(1, startZ * zScale))
            end
            createEnvelopeAndItem(track, fx, m.z, zVals, ts, te)
          end
        end
      end
    end
  end
  reaper.UpdateArrange()
  reaper.Undo_EndBlock('Spiral Walk', -1)
end

function loop()
  if not visible then return end
  reaper.ImGui_SetNextWindowSize(ctx, 500, 780, reaper.ImGui_Cond_FirstUseEver())
  local draw, open = reaper.ImGui_Begin(ctx, 'ICST AmbiEncoder_64 Spiral Walk', true)
  if draw then
    _, steps = reaper.ImGui_InputInt(ctx, 'Schritte', steps)
    _, spiralSpread = reaper.ImGui_InputDouble(ctx, 'Spiral Spread', spiralSpread)
    _, maxRadius = reaper.ImGui_InputDouble(ctx, 'Max Radius', maxRadius)
    _, minRadius = reaper.ImGui_InputDouble(ctx, 'Min Radius', minRadius)
    if minRadius < 0.1 then minRadius = 0.1 end
    _, accelerando = reaper.ImGui_InputDouble(ctx, 'Accelerando (Drehgeschw.)', accelerando)
    _, reverseAccel = reaper.ImGui_Checkbox(ctx, 'Accelerando umkehren', reverseAccel)
    _, spiralOutward = reaper.ImGui_Checkbox(ctx, 'Spiral nach außen bewegen', spiralOutward)
    _, includeZ = reaper.ImGui_Checkbox(ctx, 'Z-Achse aktivieren', includeZ)
    _, zScale = reaper.ImGui_InputDouble(ctx, 'Z-Achse Skalierung (-1 bis 1)', zScale)
    if zScale > 1.0 then zScale = 1.0 end
    if zScale < -1.0 then zScale = -1.0 end
    _, speed = reaper.ImGui_InputDouble(ctx, 'Speed Faktor', speed)
    _, numPointsToProcess = reaper.ImGui_InputInt(ctx, 'Anzahl Punkte', numPointsToProcess)

    if reaper.ImGui_Button(ctx, 'Spiral Walk ausführen') then
      applySpiralWalk()
    end

    reaper.ImGui_Separator(ctx)
    reaper.ImGui_Text(ctx, 'Preset Verwaltung:')
    _, presetInput = reaper.ImGui_InputText(ctx, 'Preset-Name', presetInput)
    if reaper.ImGui_Button(ctx, 'Preset speichern') then
      presets[presetInput] = {
        steps=steps, spiralSpread=spiralSpread, maxRadius=maxRadius, accelerando=accelerando,
        reverseAccel=reverseAccel, spiralOutward=spiralOutward, includeZ=includeZ, speed=speed,
        numPointsToProcess=numPointsToProcess, minRadius=minRadius, zScale=zScale
      }
      savePresetsToDisk()
    end

    for name, data in pairs(presets) do
      if reaper.ImGui_Button(ctx, 'Laden: '..name) then
        steps = data.steps
        spiralSpread = data.spiralSpread
        maxRadius = data.maxRadius
        accelerando = data.accelerando
        reverseAccel = data.reverseAccel
        spiralOutward = data.spiralOutward
        includeZ = data.includeZ
        speed = data.speed
        numPointsToProcess = data.numPointsToProcess
        minRadius = data.minRadius or 0.1
        zScale = data.zScale or 1.0
      end
      reaper.ImGui_SameLine(ctx)
      if reaper.ImGui_Button(ctx, 'Löschen##'..name) then
        presets[name] = nil
        savePresetsToDisk()
      end
    end

    reaper.ImGui_Separator(ctx)
    reaper.ImGui_Text(ctx, 'Speicherort für Presets:')
    _, presetDirInput = reaper.ImGui_InputText(ctx, 'Ordnerpfad', presetDirInput)
    if reaper.ImGui_Button(ctx, 'Speicherort übernehmen') then
      if not presetDirInput:match("[/\\]$") then
        presetDirInput = presetDirInput .. "/"
      end
      presetDir = presetDirInput
      presetFilePath = presetDir .. presetFileName
      savePresetsToDisk()
    end

    reaper.ImGui_End(ctx)
  end
  if open then reaper.defer(loop) else visible = false end
end

loadPresetsFromDisk()
reaper.defer(loop)


