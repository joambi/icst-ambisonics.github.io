-- ICST AmbiEncoder_64 Circle Movement Script (verbesserte Kreisberechnung)
-- Übernimmt die aktuelle Position der gewählten Punkte und bewegt sie im Kreis.
-- Mit Offset pro Punkt, wählbarer Kreisrichtung und Speed.

local ctx = reaper.ImGui_CreateContext('ICST Ambi Circle Improved')
local visible = true

local numPointsToProcess = 5
local pointOffset = 0.1
local reverseDir = false
local speed = 1.0 -- Runden pro Sekunde
local radius = 0.5

local function clamp(v,min,max)
  if v<min then return min end
  if v>max then return max end
  return v
end

local function buildParamMap()
  local map = {}
  local firstSourceIndex = 10
  local blockSize = 5
  for p=1,64 do
    local base = firstSourceIndex+(p-1)*blockSize
    map[p] = {x=base,y=base+1,z=base+2}
  end
  return map
end
local paramMap = buildParamMap()

local function safeGet(track,fx,idx)
  local v = reaper.TrackFX_GetParamNormalized(track,fx,idx)
  return ((v or 0)*2)-1
end

-- verbesserte Kreisberechnung: Ausgangsposition als Zentrum verwenden
local function generateCircle(cx,cy,steps)
  local xs,ys = {},{}
  local dir = reverseDir and -1 or 1
  for i=1,steps do
    local angle = (i-1)/steps * (2*math.pi*speed) * dir
    local x = clamp(cx + radius * math.cos(angle),-1,1)
    local y = clamp(cy + radius * math.sin(angle),-1,1)
    xs[i] = x
    ys[i] = y
  end
  return xs,ys
end

local function writeEnv(track,fx,paramIdx,vals,ts,te)
  local env = reaper.GetFXEnvelope(track,fx,paramIdx,true)
  if not env then return end
  reaper.DeleteEnvelopePointRange(env,ts,te)
  local dur = te-ts
  for i,v in ipairs(vals) do
    local t = ts + ((i-1)/(#vals-1))*dur
    local norm = (v+1)/2
    reaper.InsertEnvelopePoint(env,t,norm,0,0,false,true)
  end
  local last = vals[#vals]
  if last then reaper.InsertEnvelopePoint(env,te+0.0001,(last+1)/2,0,0,false,true) end
  reaper.Envelope_SortPoints(env)
end

local function apply()
  local ts,te = reaper.GetSet_LoopTimeRange(false,false,0,0,false)
  if te<=ts then reaper.ShowMessageBox("Bitte Time Selection wählen","Fehler",0) return end
  local regionLen = te-ts
  local steps = math.max(4,math.floor(regionLen*200)) -- mindestens 4 Schritte für runden Kreis
  local sel = reaper.CountSelectedTracks(0)
  if sel==0 then reaper.ShowMessageBox("Bitte mindestens einen Track auswählen","Fehler",0) return end
  reaper.Undo_BeginBlock()
  for t=0,sel-1 do
    local tr = reaper.GetSelectedTrack(0,t)
    for fx=0,reaper.TrackFX_GetCount(tr)-1 do
      local _,fxname = reaper.TrackFX_GetFXName(tr,fx,"")
      if fxname:match("AmbiEncoder_64") then
        for p=1,numPointsToProcess do
          local map = paramMap[p]
          if map then
            local cx = safeGet(tr,fx,map.x) + (p-1)*pointOffset
            local cy = safeGet(tr,fx,map.y) + (p-1)*pointOffset
            cx = clamp(cx,-1,1)
            cy = clamp(cy,-1,1)
            local xs,ys = generateCircle(cx,cy,steps)
            writeEnv(tr,fx,map.x,xs,ts,te)
            writeEnv(tr,fx,map.y,ys,ts,te)
          end
        end
      end
    end
  end
  reaper.UpdateArrange()
  reaper.Undo_EndBlock("ICST Ambi Circle Improved",-1)
end

function loop()
  if not visible then return end
  reaper.ImGui_SetNextWindowSize(ctx,420,320,reaper.ImGui_Cond_FirstUseEver())
  local draw,open = reaper.ImGui_Begin(ctx,"ICST Ambi Circle Improved",true)
  if draw then
    _,numPointsToProcess = reaper.ImGui_InputInt(ctx,"Points to Process",numPointsToProcess)
    _,pointOffset = reaper.ImGui_InputDouble(ctx,"Offset pro Punkt",pointOffset)
    _,radius = reaper.ImGui_SliderDouble(ctx,"Radius",radius,0.0,1.0)
    _,speed = reaper.ImGui_SliderDouble(ctx,"Speed (Runden pro Sekunde)",speed,0.1,5.0)
    _,reverseDir = reaper.ImGui_Checkbox(ctx,"Richtung umkehren",reverseDir)
    if reaper.ImGui_Button(ctx,"Start") then apply() end
    reaper.ImGui_End(ctx)
  end
  if open then reaper.defer(loop) else visible=false end
end

reaper.defer(loop)


