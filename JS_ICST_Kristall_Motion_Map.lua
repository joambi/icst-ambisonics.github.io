-- @description ICST Kristall Motion Map
-- @author JS / Codex
-- @version 2.2.1
-- @about
--   Modular 3D crystal-lattice motion system for up to 64 AmbiEncoder sources.
--   Inspired by ICST Ambi Motion Map. Real-time gfx GUI, isometric 3D preview,
--   Python3 OSC preview, REAPER ExtState presets, automation-writer compatible.

-- ============================================================
-- SECTION 1: CONSTANTS AND ENUMS
-- ============================================================

local SCRIPT_NAME    = "ICST Kristall Motion Map"
local SCRIPT_VERSION = "v2.4.0"
local MAX_INSTANCES  = 64
local PRESET_EXT     = "ICST_KristallMotionMap_v1"

local ROT_ORDER       = { "XYZ","XZY","YXZ","YZX","ZXY","ZYX" }
local ROT_ORDER_IDX   = { XYZ=1,XZY=2,YXZ=3,YZX=4,ZXY=5,ZYX=6 }
local REP             = { INFINITE=1,FINITE=2,PINGPONG=3 }
local REP_LABELS      = { "Infinite","Finite","Pingpong" }
local BOUND           = { NONE=1,CLAMP=2,WRAP=3,MIRROR=4 }
local BOUND_LABELS    = { "None","Clamp","Wrap","Mirror" }
local ROUND           = { NEAREST=1,FLOOR=2,CEIL=3 }
local ROUND_LABELS    = { "Nearest","Floor","Ceil" }
local FALLOFF         = { LINEAR=1,INV_SQ=2,GAUSSIAN=3 }
local FALLOFF_LABELS  = { "Linear","InvSq","Gaussian" }

local PALETTE = {
  {0.36,0.83,0.62},{0.29,0.62,1.00},{0.96,0.65,0.14},{0.91,0.36,0.59},
  {0.65,0.55,0.98},{0.20,0.83,0.78},{0.98,0.57,0.19},{0.64,0.90,0.21},
  {0.96,0.44,0.71},{0.38,0.65,0.98},{0.98,0.80,0.08},{0.53,0.93,0.54},
}

-- ============================================================
-- SECTION 2: DEFAULT SETTINGS
-- ============================================================

local DEFAULTS = {
  enabled=true, name="Crystal", colorIdx=1,
  startX="0", startY="0", startZ="0",
  offsetX="1", offsetY="0", offsetZ="0",
  rate="2", repetitionMode=REP.INFINITE, stepCount="128",
  rotationX="0", rotationY="0", rotationZ="0", rotationOrder=ROT_ORDER_IDX.XYZ,
  scaleX="1", scaleY="1", scaleZ="1",
  boundsEnabled=false,
  boundMinX="-1",boundMaxX="1",boundMinY="-1",boundMaxY="1",boundMinZ="-1",boundMaxZ="1",
  boundMode=BOUND.CLAMP,
  spaceQuantizeEnabled=false, timeQuantizeEnabled=false,
  gridX="0.25",gridY="0.25",gridZ="0.25", roundMode=ROUND.NEAREST,
  smoothingEnabled=true, glideTime="0.08",
  interactionEnabled=false, sendAmount="1.0", receiveAmount="1.0",
  interactionRadius="1.0", falloffMode=FALLOFF.LINEAR,
  affectOffset=false, affectRate=false,
  affectScale=false, affectRotation=false,  -- reserved, not yet implemented
}

-- ============================================================
-- SECTION 3: HOST ADAPTER STUBS
-- ============================================================
-- All REAPER-specific calls isolated here.
-- Replace these functions to port to a different Lua host.

local function getTransportState()
  local playing = reaper.GetPlayState() == 1
  local _, bpm  = reaper.GetProjectTimeSignature2(0)
  return { playing=playing, bpm=bpm or 120, time=reaper.GetPlayPosition2() or 0 }
end
local function getWallTime()   return reaper.time_precise() end
local function storageSave(k,v) reaper.SetExtState(PRESET_EXT,k,tostring(v),true) end
local function storageLoad(k)  return reaper.GetExtState(PRESET_EXT,k) end
local function storageDelete(k) reaper.DeleteExtState(PRESET_EXT,k,true) end

-- gfx helpers (thin wrappers — real REAPER gfx.* calls)
local function setColor(r,g,b,a) gfx.r=r;gfx.g=g;gfx.b=b;gfx.a=a or 1 end
local function fillRect(x,y,w,h) gfx.rect(math.floor(x),math.floor(y),math.floor(w),math.floor(h),1) end
local function drawRect(x,y,w,h) gfx.rect(math.floor(x),math.floor(y),math.floor(w),math.floor(h),0) end
local function drawStr(s,x,y)    gfx.x=math.floor(x);gfx.y=math.floor(y);gfx.drawstr(tostring(s)) end
local function measureStr(s)     return gfx.measurestr(tostring(s)) end

-- ============================================================
-- SECTION 4: VECTOR / MATH HELPERS
-- ============================================================

local pi=math.pi; local sin=math.sin; local cos=math.cos
local sqrt=math.sqrt; local exp=math.exp; local floor=math.floor
local ceil=math.ceil; local abs=math.abs; local max=math.max; local min=math.min

local function vec3(x,y,z) return {x=x or 0,y=y or 0,z=z or 0} end
local function vecAdd(a,b) return vec3(a.x+b.x,a.y+b.y,a.z+b.z) end
local function vecSub(a,b) return vec3(a.x-b.x,a.y-b.y,a.z-b.z) end
local function vecMul(a,b) return vec3(a.x*b.x,a.y*b.y,a.z*b.z) end
local function vecScale(a,s) return vec3(a.x*s,a.y*s,a.z*s) end
local function vecLength(a) return sqrt(a.x*a.x+a.y*a.y+a.z*a.z) end
local function vecDistance(a,b) return vecLength(vecSub(a,b)) end
local function vecLerp(a,b,t) return vec3(a.x+(b.x-a.x)*t,a.y+(b.y-a.y)*t,a.z+(b.z-a.z)*t) end
local function vecCopy(v) return vec3(v.x,v.y,v.z) end

local function clamp(v,lo,hi) return max(lo,min(hi,v)) end
local function wrap(v,lo,hi) local r=hi-lo; return r<=0 and lo or lo+(v-lo)%r end
local function mirrorVal(v,lo,hi)
  local r=hi-lo; if r<=0 then return lo end
  local t=(v-lo)%(2*r); return lo+(t>r and 2*r-t or t)
end
local function roundNearest(v,g) return g<=0 and v or floor(v/g+0.5)*g end
local function roundFloor(v,g)   return g<=0 and v or floor(v/g)*g end
local function roundCeil(v,g)    return g<=0 and v or ceil(v/g)*g end
local function quantizeValue(v,g,mode)
  if mode==ROUND.FLOOR then return roundFloor(v,g)
  elseif mode==ROUND.CEIL then return roundCeil(v,g)
  else return roundNearest(v,g) end
end

local function mat3Mul(A,B)
  local C={}
  for i=0,2 do for j=0,2 do
    local s=0; for k=0,2 do s=s+A[i*3+k+1]*B[k*3+j+1] end; C[i*3+j+1]=s
  end end; return C
end
local function mat3MulVec(M,v)
  return vec3(M[1]*v.x+M[2]*v.y+M[3]*v.z,
              M[4]*v.x+M[5]*v.y+M[6]*v.z,
              M[7]*v.x+M[8]*v.y+M[9]*v.z)
end
local function rotX(a) local c,s=cos(a),sin(a); return {1,0,0,0,c,-s,0,s,c} end
local function rotY(a) local c,s=cos(a),sin(a); return {c,0,s,0,1,0,-s,0,c} end
local function rotZ(a) local c,s=cos(a),sin(a); return {c,-s,0,s,c,0,0,0,1} end

local function buildRotMat(rx,ry,rz,order)
  local d=pi/180
  local X,Y,Z=rotX(rx*d),rotY(ry*d),rotZ(rz*d)
  if order==1 then return mat3Mul(mat3Mul(X,Y),Z)   -- XYZ
  elseif order==2 then return mat3Mul(mat3Mul(X,Z),Y) -- XZY
  elseif order==3 then return mat3Mul(mat3Mul(Y,X),Z) -- YXZ
  elseif order==4 then return mat3Mul(mat3Mul(Y,Z),X) -- YZX
  elseif order==5 then return mat3Mul(mat3Mul(Z,X),Y) -- ZXY
  elseif order==6 then return mat3Mul(mat3Mul(Z,Y),X) -- ZYX
  else return mat3Mul(mat3Mul(X,Y),Z) end
end

-- Isometric projection: world → screen
local function isoProject(x,y,z, cx,cy,scale)
  -- Match the ICST encoder layout: +X = right, +Y = front (up), +Z = elevation
  -- (drawn up-left so it stays distinct from the X and Y axes).
  local sx = cx + x*scale*0.95 - z*scale*0.30
  local sy = cy - y*scale*0.95 - z*scale*0.55
  return sx, sy
end

-- ============================================================
-- SECTION 5: INSTANCE FACTORY
-- ============================================================

local function n(s) return tonumber(s) or 0 end

local function createInstance(ov)
  local inst={}; for k,v in pairs(DEFAULTS) do inst[k]=v end
  if ov then for k,v in pairs(ov) do inst[k]=v end end
  local sx,sy,sz=n(inst.startX),n(inst.startY),n(inst.startZ)
  inst.currentStep=0; inst.phaseAccumulator=0; inst.direction=1
  inst.currentPos     = vec3(sx,sy,sz)
  inst.targetPos      = vec3(sx,sy,sz)
  inst.effectivePos   = vec3(sx,sy,sz)
  inst.effectiveOffset= vec3(n(inst.offsetX),n(inst.offsetY),n(inst.offsetZ))
  inst.effectiveRate  = n(inst.rate)
  inst.influenceSum   = 0
  return inst
end

local function resetInstance(inst)
  local sx,sy,sz=n(inst.startX),n(inst.startY),n(inst.startZ)
  inst.currentStep=0; inst.phaseAccumulator=0; inst.direction=1
  inst.currentPos     = vec3(sx,sy,sz)
  inst.targetPos      = vec3(sx,sy,sz)
  inst.effectivePos   = vec3(sx,sy,sz)
  inst.effectiveOffset= vec3(n(inst.offsetX),n(inst.offsetY),n(inst.offsetZ))
  inst.effectiveRate  = n(inst.rate)
  inst.influenceSum   = 0
end

-- Restore all parameter values to factory defaults, keeping name and color.
local function defaultInstance(inst)
  local keep_name  = inst.name
  local keep_color = inst.colorIdx
  for k,v in pairs(DEFAULTS) do inst[k]=v end
  inst.name     = keep_name
  inst.colorIdx = keep_color
  resetInstance(inst)
end

local function duplicateInstance(src)
  local copy=createInstance(); for k,v in pairs(src) do copy[k]=v end
  resetInstance(copy); return copy
end

local function removeInstance(list,idx) table.remove(list,idx) end

-- ============================================================
-- SECTION 6: INSTANCE MANAGEMENT
-- ============================================================

local instances   = {}
local selectedIdx = 1
local selectedSet = {[1]=true}  -- all currently selected indices (shift-click multi-select)

local function addInstance(ov)
  if #instances>=MAX_INSTANCES then return nil end
  local inst=createInstance(ov); table.insert(instances,inst); return inst
end
local function clearAll() instances={}; selectedIdx=1; selectedSet={[1]=true} end
local function activeCount()
  local c=0; for _,i in ipairs(instances) do if i.enabled then c=c+1 end end; return c
end

-- ============================================================
-- SECTION 7: UI PARAMETER DECLARATIONS
-- ============================================================
-- Layout constants and mutable UI state used by draw and input routines.

local PAD=8; local ROW_H=22

local ui = {
  LIST_SCROLL    = 0,
  right_scroll   = 0,
  focus_field    = nil,
  focus_text     = "",
  focus_selectAll = false,  -- true = field just focused, first keystroke replaces value
  focus_key      = nil,
  last_mouse     = 0,
  last_rmb       = 0,    -- right-button edge tracking (right-click = reset field)
  prevFrac       = 0.45, -- fraction of right column used by the lattice preview (draggable divider)
  dividerDrag    = false,-- true while dragging the preview/param divider
  param_fields   = {},   -- hit-test table rebuilt each frame
  preset_open    = false,
  preset_scroll  = 0,
  sliderDrag     = {active=false,id=nil,startMx=0,startVal=0,lo=0,hi=1,scale=0.01},
  cmdDrag        = {active=false,key=nil,inst=nil,startMy=0,startVal=0,step=0.01},
  sb_right_geo   = nil,  -- {x,y,w,h,track_y,track_h,max_scroll} set each frame by drawParamPanel
  sb_right_drag  = false,
  sb_right_start = 0,    -- mouse_y at drag start
  sb_right_base  = 0,    -- right_scroll value at drag start
}

local osc = {
  host="127.0.0.1", port="9001",
  ok=false, status="Not connected", pipe=nil, last_t=0,
  state_file=nil, in_port=0,
}

local statusMsg  = "Ready"
local presetName = "MyPreset"
local presetIndex = {}   -- list of all saved preset names

-- ============================================================
-- SECTION 8: UI SYNC
-- ============================================================

local function onSelectionChanged()
  ui.focus_field=nil; ui.focus_text=""; ui.right_scroll=0
end


-- ============================================================
-- SECTION 9: TRANSFORM ENGINE
-- ============================================================

-- Global transform variables (declared here so transform functions can close over them)
local globalTransX = 0.0   -- translation: shifts all final positions uniformly
local globalTransY = 0.0
local globalTransZ = 0.0
local globalMoveX  = 0.0   -- per-step movement added to all instance offsets
local globalMoveY  = 0.0
local globalMoveZ  = 0.0
local globalPitch  = 0.0   -- global rotation X (degrees): tilts figure forward/back
local globalYaw    = 0.0   -- global rotation Y (degrees): spins figure left/right
local globalRoll   = 0.0   -- global rotation Z (degrees): rolls figure clockwise/ccw
local globalZoom     = 1.0   -- global zoom: scales whole figure around origin (0=collapse, 1=neutral, 2=2×)
local globalRotPitch = 0.0   -- spin: degrees per second added to globalPitch (feature: global rotation per step)
local globalRotYaw   = 0.0   -- spin: degrees per second added to globalYaw
local globalRotRoll  = 0.0   -- spin: degrees per second added to globalRoll

local function computeStepPosition(inst)
  local step=inst.currentStep
  local ex=inst.effectiveOffset.x+globalMoveX
  local ey=inst.effectiveOffset.y+globalMoveY
  local ez=inst.effectiveOffset.z+globalMoveZ
  return vec3(n(inst.startX)+step*ex,
              n(inst.startY)+step*ey,
              n(inst.startZ)+step*ez)
end

local function applyRotation(pos,inst)
  local M=buildRotMat(n(inst.rotationX),n(inst.rotationY),n(inst.rotationZ),inst.rotationOrder)
  local org=vec3(n(inst.startX),n(inst.startY),n(inst.startZ))
  return vecAdd(mat3MulVec(M,vecSub(pos,org)),org)
end

local function applyScale(pos,inst)
  local ox,oy,oz=n(inst.startX),n(inst.startY),n(inst.startZ)
  return vec3(ox+(pos.x-ox)*n(inst.scaleX),
              oy+(pos.y-oy)*n(inst.scaleY),
              oz+(pos.z-oz)*n(inst.scaleZ))
end

local function applyBoundAxis(v,lo,hi,mode)
  if mode==BOUND.CLAMP then return clamp(v,lo,hi)
  elseif mode==BOUND.WRAP then return wrap(v,lo,hi)
  elseif mode==BOUND.MIRROR then return mirrorVal(v,lo,hi)
  else return v end
end

local function applyBounds(pos,inst)
  if not inst.boundsEnabled then return pos end
  local m=inst.boundMode
  return vec3(applyBoundAxis(pos.x,n(inst.boundMinX),n(inst.boundMaxX),m),
              applyBoundAxis(pos.y,n(inst.boundMinY),n(inst.boundMaxY),m),
              applyBoundAxis(pos.z,n(inst.boundMinZ),n(inst.boundMaxZ),m))
end

-- ============================================================
-- SECTION 10: QUANTIZATION ENGINE
-- ============================================================

local function quantizePoint(pos,inst)
  if not inst.spaceQuantizeEnabled then return pos end
  local m=inst.roundMode
  return vec3(quantizeValue(pos.x,n(inst.gridX),m),
              quantizeValue(pos.y,n(inst.gridY),m),
              quantizeValue(pos.z,n(inst.gridZ),m))
end

-- Global speed control (multiplies all per-instance rates)
-- 0 = steps/sec absolute, 1 = steps/beat (BPM sync)
local rateMode   = 0
local globalRateMult = 1.0   -- speed multiplier shown in status bar
local globalDir    = 1          -- global direction: 1=forward, -1=reverse
local globalPaused = true       -- pause: freeze steps, keep current positions; starts paused (Stop) on launch
local globalPingPong    = false -- global ping-pong: whole figure reverses as one
local globalPingPongDir = 1     -- shared direction used by globalPingPong mode
local _ppWantsFlip      = false -- set by any instance that hits a boundary; consumed by updateAllInstances
local _prevPlaying      = false -- DAW transport play-state last frame (for BPM auto-sync on start)


local function shouldAdvanceStep(inst,dt,transport)
  local bpm=transport.bpm or 120
  if inst.timeQuantizeEnabled then
    local stepDur=(60/bpm)/max(0.001,inst.effectiveRate)
    inst.phaseAccumulator=inst.phaseAccumulator+dt
    if inst.phaseAccumulator>=stepDur then
      inst.phaseAccumulator=inst.phaseAccumulator-stepDur; return true
    end
    return false
  elseif rateMode==1 then
    -- steps/beat: effectiveRate=1 → 1 step per quarter note at any BPM
    inst.phaseAccumulator=inst.phaseAccumulator+dt*(bpm/60)*inst.effectiveRate*globalRateMult
    if inst.phaseAccumulator>=1 then inst.phaseAccumulator=inst.phaseAccumulator-1; return true end
    return false
  else
    -- steps/sec absolute: globalRateMult scales all instances uniformly
    inst.phaseAccumulator=inst.phaseAccumulator+dt*inst.effectiveRate*globalRateMult
    if inst.phaseAccumulator>=1 then inst.phaseAccumulator=inst.phaseAccumulator-1; return true end
    return false
  end
end

-- ============================================================
-- SECTION 11: SMOOTHING ENGINE
-- ============================================================

local function updateSmoothing(inst,dt)
  if not inst.smoothingEnabled or n(inst.glideTime)<=0 then
    inst.currentPos=vecCopy(inst.targetPos); return
  end
  local alpha=1-exp(-dt/max(0.001,n(inst.glideTime)))
  inst.currentPos=vecLerp(inst.currentPos,inst.targetPos,alpha)
end

-- ============================================================
-- SECTION 12: INTERACTION ENGINE
-- ============================================================

local function falloffWeight(dist,radius,mode)
  if radius<=0 or dist>=radius then return 0 end
  local t=1-dist/radius
  if mode==FALLOFF.LINEAR then return t
  elseif mode==FALLOFF.INV_SQ then return t*t
  elseif mode==FALLOFF.GAUSSIAN then
    local s=radius/3; return exp(-(dist*dist)/(2*s*s))
  end; return t
end

local function computeInstanceInfluence(source,target)
  local zero={offsetDelta=vec3(),rateDelta=0,weight=0}
  if not source.enabled or not source.interactionEnabled then return zero end
  local dist=vecDistance(source.currentPos,target.currentPos)
  local w=falloffWeight(dist,n(source.interactionRadius),source.falloffMode)
  if w<=0 then return zero end
  w=w*n(source.sendAmount)
  local od=source.affectOffset and vecScale(source.effectiveOffset,w) or vec3()
  local rd=source.affectRate   and source.effectiveRate*w            or 0
  return {offsetDelta=od,rateDelta=rd,weight=w}
end

local function accumulateInfluences()
  local result={}
  for i=1,#instances do result[i]={offsetSum=vec3(),rateSum=0,weightSum=0} end
  for i,target in ipairs(instances) do
    if target.enabled and target.interactionEnabled then
      for j,source in ipairs(instances) do
        if i~=j then
          local inf=computeInstanceInfluence(source,target)
          local w=inf.weight*n(target.receiveAmount)
          if w>0 then
            result[i].offsetSum =vecAdd(result[i].offsetSum,vecScale(inf.offsetDelta,w))
            result[i].rateSum   =result[i].rateSum+inf.rateDelta*w
            result[i].weightSum =result[i].weightSum+w
          end
        end
      end
    end
  end
  return result
end

local function applyInfluenceToInstance(inst,inf)
  local base=vec3(n(inst.offsetX),n(inst.offsetY),n(inst.offsetZ))
  if inf.weightSum<=0 then
    inst.effectiveOffset=base; inst.effectiveRate=n(inst.rate); inst.influenceSum=0; return
  end
  inst.effectiveOffset=inst.affectOffset and vecAdd(base,inf.offsetSum) or base
  inst.effectiveRate  =inst.affectRate   and max(0.001,n(inst.rate)+inf.rateSum) or n(inst.rate)
  inst.influenceSum   =inf.weightSum
end

-- ============================================================
-- SECTION 13: UPDATE LOOP
-- ============================================================

local function updateInstance(inst,inf,dt,transport)
  if not inst.enabled then return end
  applyInfluenceToInstance(inst,inf)                                  -- 1
  if shouldAdvanceStep(inst,dt,transport) then                        -- 2
    local sc=tonumber(inst.stepCount) or 128
    if globalPingPong then
      -- All instances share one direction; boundary of any instance triggers global flip
      local d=globalPingPongDir*globalDir
      inst.currentStep=inst.currentStep+d
      if inst.currentStep>=sc-1 then inst.currentStep=sc-1; _ppWantsFlip=true
      elseif inst.currentStep<=0 then inst.currentStep=0;   _ppWantsFlip=true end
    else
      local d=inst.direction*globalDir
      if inst.repetitionMode==REP.INFINITE then
        local sc_safe=max(1,sc)
        inst.currentStep=(inst.currentStep+d) % sc_safe
      elseif inst.repetitionMode==REP.FINITE then
        inst.currentStep=clamp(inst.currentStep+d, 0, sc-1)
      elseif inst.repetitionMode==REP.PINGPONG then
        inst.currentStep=inst.currentStep+d
        if inst.currentStep>=sc-1 then inst.currentStep=sc-1;inst.direction=inst.direction*-1
        elseif inst.currentStep<=0 then inst.currentStep=0;inst.direction=inst.direction*-1 end
      end
    end
  end
  local pos=computeStepPosition(inst)                                 -- 3
  pos=applyRotation(pos,inst)                                         -- 4
  pos=applyScale(pos,inst)                                            -- 5
  pos=applyBounds(pos,inst)                                           -- 6
  pos=quantizePoint(pos,inst)                                         -- 7
  inst.targetPos=pos; updateSmoothing(inst,dt)                        -- 8
  inst.effectivePos=vecCopy(inst.currentPos)                          -- 9: smoothed local pos
end

local function updateAllInstances(dt)
  local transport=getTransportState()
  -- BPM mode: when the DAW transport starts, auto-trigger Sync so every instance
  -- restarts from step 0 locked to the moment playback begins → deterministic,
  -- repeatable timesteps synced to the DAW timeline.
  local justStarted = transport.playing and not _prevPlaying
  local justStopped = (not transport.playing) and _prevPlaying
  _prevPlaying = transport.playing
  if rateMode==1 and justStarted then
    globalPaused=false   -- DAW transport start un-pauses (drives) Kristall
    for _,inst in ipairs(instances) do resetInstance(inst) end
    statusMsg="Transport started — synced & running"
  elseif rateMode==1 and justStopped then
    globalPaused=true    -- DAW transport stop also pauses Kristall
    statusMsg="Transport stopped — Kristall paused"
  end
  if globalPaused then return end
  local influences=accumulateInfluences()
  _ppWantsFlip=false  -- reset before this pass
  for i,inst in ipairs(instances) do
    updateInstance(inst,influences[i] or {offsetSum=vec3(),rateSum=0,weightSum=0},dt,transport)
  end
  if globalPingPong and _ppWantsFlip then
    globalPingPongDir=globalPingPongDir*-1  -- flip once after all instances processed
  end
end

-- Apply global Pt/Yw/Rl rotation + Offset translation to effectivePos every frame.
-- Runs after updateAllInstances (and even when paused), so dragging sliders
-- while paused still updates the preview and OSC output immediately.
local rotMatCache = nil
local rotCacheKey = ""
local function applyGlobalTransforms(dt)
  -- Feature: global rotation per step (spin) — accumulate into Pitch/Yaw/Roll
  if not globalPaused and dt and (globalRotPitch~=0 or globalRotYaw~=0 or globalRotRoll~=0) then
    local t_=getTransportState(); local bpm_=t_.bpm or 120
    local rate_=rateMode==1 and (bpm_/60*globalRateMult) or globalRateMult
    globalPitch=((globalPitch+globalRotPitch*dt*rate_)+180)%360-180
    globalYaw  =((globalYaw  +globalRotYaw  *dt*rate_)+180)%360-180
    globalRoll =((globalRoll +globalRotRoll *dt*rate_)+180)%360-180
    rotCacheKey=""  -- invalidate rotation matrix cache
  end
  local needRot = (globalPitch~=0 or globalYaw~=0 or globalRoll~=0)
  if needRot then
    local key=globalPitch..","..globalYaw..","..globalRoll
    if key~=rotCacheKey then
      rotMatCache=buildRotMat(globalPitch,globalYaw,globalRoll,1)
      rotCacheKey=key
    end
  end
  for _,inst in ipairs(instances) do
    local p=vecCopy(inst.currentPos)
    if needRot then p=mat3MulVec(rotMatCache,p) end
    if globalZoom~=1.0 then p=vec3(p.x*globalZoom,p.y*globalZoom,p.z*globalZoom) end
    inst.effectivePos=vec3(p.x+globalTransX, p.y+globalTransY, p.z+globalTransZ)
  end
end

local function getOutputPositions()
  local out={}
  for i,inst in ipairs(instances) do
    if inst.enabled then out[i]={x=inst.effectivePos.x,y=inst.effectivePos.y,z=inst.effectivePos.z} end
  end
  return out
end

-- ============================================================
-- SECTION 14: VISUALIZATION / OUTPUT HELPERS
-- ============================================================

local EDGE_DIST = 2.0   -- world-units: max distance to draw a lattice edge

-- Inverse isometric projection: screen (sx,sy) → world (x,y), z fixed
-- sx = cx + (x-y)*cos(π/6)*scale
-- sy = cy - (x+y)*sin(π/6)*scale + z*scale
local function isoUnproject(sx,sy,z, cx,cy,scale)
  -- Inverse of isoProject for a known z (used by XY dragging).
  local x = (sx - cx + z*scale*0.30)/(scale*0.95)
  local y = (cy - sy - z*scale*0.55)/(scale*0.95)
  return x, y
end

-- Drag state (lives next to ui table, set at UI declaration time via patch below)
local drag = { active=false, instIdx=nil, startMx=0, startMy=0,
               origX=0, origY=0, origZ=0 }

-- Draw the isometric 3D lattice preview canvas
local function drawLatticePreview(px,py,pw,ph)
  setColor(0.07,0.07,0.10); fillRect(px,py,pw,ph)
  setColor(0.18,0.18,0.24); drawRect(px,py,pw,ph)

  local cx=px+pw*0.5; local cy=py+ph*0.55
  local scale=min(pw,ph)*0.17

  -- unit-cube guide lines
  setColor(0.16,0.16,0.22)
  local cube_edges={
    {{-1,-1,-1},{1,-1,-1}},{{-1,1,-1},{1,1,-1}},{{-1,-1,1},{1,-1,1}},{{-1,1,1},{1,1,1}},
    {{-1,-1,-1},{-1,1,-1}},{{1,-1,-1},{1,1,-1}},{{-1,-1,1},{-1,1,1}},{{1,-1,1},{1,1,1}},
    {{-1,-1,-1},{-1,-1,1}},{{1,-1,-1},{1,-1,1}},{{-1,1,-1},{-1,1,1}},{{1,1,-1},{1,1,1}},
  }
  for _,e in ipairs(cube_edges) do
    local x1,y1=isoProject(e[1][1],e[1][2],e[1][3],cx,cy,scale)
    local x2,y2=isoProject(e[2][1],e[2][2],e[2][3],cx,cy,scale)
    gfx.line(floor(x1),floor(y1),floor(x2),floor(y2))
  end

  -- lattice edges between nearby instances
  for i=1,#instances do
    local a=instances[i]
    if a.enabled then
      for j=i+1,#instances do
        local b=instances[j]
        if b.enabled and vecDistance(a.effectivePos,b.effectivePos)<=EDGE_DIST then
          local c=PALETTE[((a.colorIdx-1)%#PALETTE)+1]
          setColor(c[1]*0.3,c[2]*0.3,c[3]*0.3,0.8)
          local x1,y1=isoProject(a.effectivePos.x,a.effectivePos.y,a.effectivePos.z,cx,cy,scale)
          local x2,y2=isoProject(b.effectivePos.x,b.effectivePos.y,b.effectivePos.z,cx,cy,scale)
          gfx.line(floor(x1),floor(y1),floor(x2),floor(y2))
        end
      end
    end
  end

  -- instance dots
  local mx=gfx.mouse_x; local my=gfx.mouse_y
  for i,inst in ipairs(instances) do
    if inst.enabled then
      local c=PALETTE[((inst.colorIdx-1)%#PALETTE)+1]
      local sx,sy=isoProject(inst.effectivePos.x,inst.effectivePos.y,inst.effectivePos.z,cx,cy,scale)
      local isSel=(i==selectedIdx)
      local isDrag=(drag.active and drag.instIdx==i)
      local isHover=(not drag.active and (mx-sx)*(mx-sx)+(my-sy)*(my-sy)<=(9*9))
      local rad=isDrag and 9 or (isSel and 7 or (isHover and 6 or 4))
      -- fill
      if isDrag then setColor(1,0.9,0.2)
      elseif isHover then setColor(min(1,c[1]+0.3),min(1,c[2]+0.3),min(1,c[3]+0.3))
      else setColor(c[1],c[2],c[3]) end
      gfx.circle(floor(sx),floor(sy),rad,1)
      -- ring for selected / hovered
      if isDrag then setColor(1,1,0.3,0.8); gfx.circle(floor(sx),floor(sy),rad+3,0)
      elseif isSel then setColor(1,1,1,0.6); gfx.circle(floor(sx),floor(sy),rad+2,0)
      elseif isHover then setColor(1,1,1,0.35); gfx.circle(floor(sx),floor(sy),rad+2,0) end
      -- label
      if isSel or isDrag then
        setColor(1,1,1,0.85)
        local lbl=isDrag and string.format("#%d [%.2f, %.2f, %.2f]",i,
          inst.effectivePos.x,inst.effectivePos.y,inst.effectivePos.z)
          or string.format("#%d %s",i,inst.name)
        drawStr(lbl, floor(sx)+10, floor(sy)-7)
      elseif isHover then
        setColor(0.85,0.85,0.90,0.8)
        drawStr(inst.name, floor(sx)+8, floor(sy)-6)
      end
    end
  end

  -- caption
  setColor(0.35,0.35,0.42)
  drawStr("Lattice Preview — drag XY  |  Shift+drag Z", px+PAD, py+PAD)
  drawStr(string.format("%d active / %d",activeCount(),#instances), px+PAD, py+ph-16)
end

-- ── Instance list panel ───────────────────────────────────────────────────────

local LIST_W=230; local LEFT_PAD=4

local function drawInstanceList(lx,ly,lw,lh)
  setColor(0.11,0.11,0.15); fillRect(lx,ly,lw,lh)
  -- header
  setColor(0.14,0.18,0.26); fillRect(lx,ly,lw,22)
  setColor(0.85,0.85,0.90); drawStr(string.format("Instances  [%d / %d]",#instances,MAX_INSTANCES),lx+6,ly+5)

  local visible_h=lh-26-26
  local max_scroll=max(0,#instances*ROW_H-visible_h)
  ui.LIST_SCROLL=clamp(ui.LIST_SCROLL,0,max_scroll)

  for i,inst in ipairs(instances) do
    local ry=ly+26+(i-1)*ROW_H-ui.LIST_SCROLL
    if ry>ly+26-ROW_H and ry<ly+26+visible_h then
      local isPrimary=(i==selectedIdx)
      local isInSet=selectedSet[i]
      if isPrimary then setColor(0.22,0.42,0.68); fillRect(lx,ry,lw,ROW_H)
      elseif isInSet then setColor(0.14,0.25,0.48); fillRect(lx,ry,lw,ROW_H) end
      -- color swatch
      local c=PALETTE[((inst.colorIdx-1)%#PALETTE)+1]
      setColor(c[1],c[2],c[3]); fillRect(lx+3,ry+5,8,12)
      -- enabled dot
      if inst.enabled then setColor(0.25,0.90,0.35) else setColor(0.50,0.18,0.18) end
      gfx.circle(lx+18,ry+11,4,1)
      -- name
      setColor(isPrimary and 1.0 or (isInSet and 0.93 or 0.85),
               isPrimary and 1.0 or (isInSet and 0.93 or 0.85),
               isPrimary and 1.0 or (isInSet and 0.95 or 0.88))
      drawStr(string.format("%2d  %s",i,inst.name), lx+28, ry+5)
      -- step
      setColor(0.40,0.40,0.48)
      drawStr(tostring(inst.currentStep), lx+lw-36, ry+5)
    end
  end

  -- scroll bar
  if max_scroll>0 then
    local sbh=max(16,visible_h*visible_h/(#instances*ROW_H))
    local sby=ly+26+(ui.LIST_SCROLL/max_scroll)*(visible_h-sbh)
    setColor(0.28,0.28,0.40); fillRect(lx+lw-5,sby,4,sbh)
  end

  -- Add / Remove / Dup / Import / COD buttons
  local by=ly+lh-24; local bw=floor(lw/5)
  local btns={"+ Add","- Rem","Dup","CIF","COD"}
  for k,label in ipairs(btns) do
    local bx=lx+(k-1)*bw
    setColor(0.14,0.18,0.28); fillRect(bx+1,by,bw-2,20)
    setColor(0.36,0.83,0.62); drawStr(label, bx+4, by+4)
  end
end

-- ── Right parameter panel ─────────────────────────────────────────────────────

local RIGHT_W=300

-- Viewport clip bounds — set by drawParamPanel so that pField/pCheck/pCycle
-- skip drawing (and skip hit-test registration) for items outside the visible
-- scrollable area.  Without this, items scrolled below the panel bottom are
-- painted on top of the status bar, and clicks there trigger both the param
-- handler AND status-bar handlers, causing the status-bar to steal focus.
local param_clip_y1    = 0    -- top of scrollable viewport (vpy)
local param_clip_y2    = 9999 -- bottom of scrollable viewport (vpy + vph)
local param_content_h  = 1200 -- measured each frame; used for scroll math next frame

-- Draw a labeled text-input field; register in ui.param_fields for hit-testing.
local function pField(id,label,inst,key,rx,ry,rw)
  if ry < param_clip_y1 - ROW_H or ry >= param_clip_y2 then return end
  local val=tostring(inst[key] or "")
  local focused=(ui.focus_field==id)
  local display=focused and ui.focus_text or val
  setColor(0.42,0.42,0.50); drawStr(label, rx, ry)
  local bx=rx+88; local bw=rw-92
  setColor(focused and 0.14 or 0.10, focused and 0.22 or 0.11, focused and 0.38 or 0.16)
  fillRect(bx,ry-2,bw,ROW_H-3)
  if focused and ui.focus_selectAll then  -- selection highlight behind text
    setColor(0.20,0.40,0.70); fillRect(bx+2,ry-1,measureStr(display)+4,ROW_H-5)
  end
  setColor(focused and 0.36 or 0.22, focused and 0.83 or 0.22, focused and 0.62 or 0.28)
  drawRect(bx,ry-2,bw,ROW_H-3)
  setColor(1,1,1); drawStr(display, bx+4, ry)
  ui.param_fields[#ui.param_fields+1]={id=id,key=key,x=bx,y=ry-2,w=bw,h=ROW_H-2,inst=inst}
end

-- Cycle-button for enum fields
local function pCycle(label,inst,key,opts,rx,ry,rw)
  if ry < param_clip_y1 - ROW_H or ry >= param_clip_y2 then return end
  local cur=inst[key] or 1; local lbl=opts[cur] or "?"
  setColor(0.42,0.42,0.50); drawStr(label, rx, ry)
  local bx=rx+88; local bw=rw-92
  setColor(0.14,0.14,0.22); fillRect(bx,ry-2,bw,ROW_H-2)
  setColor(0.30,0.30,0.48); drawRect(bx,ry-2,bw,ROW_H-2)
  setColor(0.36,0.83,0.62); drawStr("< "..lbl.." >", bx+6, ry)
  ui.param_fields[#ui.param_fields+1]={id="cyc_"..label,key=key,x=bx,y=ry-2,
    w=bw,h=ROW_H-2,cycle=true,options=opts,inst=inst}
end

-- Checkbox
local function pCheck(label,inst,key,rx,ry)
  if ry < param_clip_y1 - ROW_H or ry >= param_clip_y2 then return end
  local v=inst[key]
  setColor(v and 0.25 or 0.22, v and 0.80 or 0.22, v and 0.40 or 0.22)
  fillRect(rx,ry,14,14)
  setColor(0.35,0.35,0.45); drawRect(rx,ry,14,14)
  if v then setColor(0.05,0.05,0.05); drawStr("v",rx+2,ry) end
  setColor(0.78,0.78,0.82); drawStr(label, rx+18, ry)
  ui.param_fields[#ui.param_fields+1]={id="cb_"..label,key=key,x=rx,y=ry,
    w=14,h=14,checkbox=true,inst=inst}
end


local function pHeader(title,rx,ry,rw)
  if ry < param_clip_y1 - ROW_H or ry >= param_clip_y2 then return end
  setColor(0.13,0.17,0.26); fillRect(rx,ry,rw,17)
  setColor(0.36,0.83,0.62); drawStr(title, rx+4, ry+2)
end

local function drawParamPanel(rx,ry,rw,rh)
  ui.param_fields={}
  setColor(0.10,0.10,0.14); fillRect(rx,ry,rw,rh)
  local inst=instances[selectedIdx]
  if not inst then
    setColor(0.40,0.40,0.48); drawStr("No instance selected",rx+PAD,ry+PAD); return
  end
  -- panel header
  setColor(0.12,0.15,0.22); fillRect(rx,ry,rw,22)
  setColor(0.90,0.90,0.95)
  drawStr(string.format("Instance %d — %s",selectedIdx,inst.name), rx+6, ry+5)
  -- ↺ Defaults button (right-anchored in header, not scrolled)
  local defbx=rx+rw-54; local defby=ry+3; local defbw=50; local defbh=16
  setColor(0.14,0.14,0.24); fillRect(defbx,defby,defbw,defbh)
  setColor(0.38,0.38,0.60); drawRect(defbx,defby,defbw,defbh)
  setColor(0.62,0.62,0.85); drawStr("↺ Def", defbx+7, defby+2)

  local vpy=ry+24; local vph=rh-24
  param_clip_y1 = vpy        -- expose to pField/pCheck/pCycle for clipping
  param_clip_y2 = vpy + vph
  local max_content=param_content_h  -- measured from previous frame
  local max_scroll=max(0,max_content-vph)
  ui.right_scroll=clamp(ui.right_scroll,0,max_scroll)

  local iy=vpy-ui.right_scroll
  local function row(dy) iy=iy+dy; return iy end
  local pw=rw-PAD*2; local px=rx+PAD

  -- ── IDENTITY
  pHeader("▸ Identity", px, row(2), pw)
  pField("name","Name",     inst,"name",     px,row(20),pw)
  pCheck("Enabled",         inst,"enabled",  px,row(24)+2)

  -- ── POSITION
  pHeader("▸ Position", px, row(28), pw)
  pField("sx","Start X",    inst,"startX",   px,row(20),pw)
  pField("sy","Start Y",    inst,"startY",   px,row(22),pw)
  pField("sz","Start Z",    inst,"startZ",   px,row(22),pw)
  pField("ox","Offset X",   inst,"offsetX",  px,row(22),pw)
  pField("oy","Offset Y",   inst,"offsetY",  px,row(22),pw)
  pField("oz","Offset Z",   inst,"offsetZ",  px,row(22),pw)

  -- ── TIMING
  pHeader("▸ Timing", px, row(28), pw)
  pField("rate","Rate",     inst,"rate",      px,row(20),pw)
  pField("sc","Steps",      inst,"stepCount", px,row(22),pw)
  pCycle("Mode",            inst,"repetitionMode",REP_LABELS,px,row(22),pw)

  -- ── ROTATION
  pHeader("▸ Rotation", px, row(28), pw)
  pField("rx","Rot X°",    inst,"rotationX",  px,row(20),pw)
  pField("ry","Rot Y°",    inst,"rotationY",  px,row(22),pw)
  pField("rz","Rot Z°",    inst,"rotationZ",  px,row(22),pw)
  pCycle("Order",           inst,"rotationOrder",ROT_ORDER,px,row(22),pw)

  -- ── SCALE
  pHeader("▸ Scale", px, row(28), pw)
  pField("scx","Scale X",  inst,"scaleX",     px,row(20),pw)
  pField("scy","Scale Y",  inst,"scaleY",     px,row(22),pw)
  pField("scz","Scale Z",  inst,"scaleZ",     px,row(22),pw)

  -- ── BOUNDS
  pHeader("▸ Bounds", px, row(28), pw)
  pCheck("Bounds On",       inst,"boundsEnabled",  px,row(20)+2)
  pCycle("Mode",            inst,"boundMode",BOUND_LABELS,px,row(26),pw)
  pField("bnx","Min X",    inst,"boundMinX",  px,row(22),pw)
  pField("bxx","Max X",    inst,"boundMaxX",  px,row(22),pw)
  pField("bny","Min Y",    inst,"boundMinY",  px,row(22),pw)
  pField("bxy","Max Y",    inst,"boundMaxY",  px,row(22),pw)
  pField("bnz","Min Z",    inst,"boundMinZ",  px,row(22),pw)
  pField("bxz","Max Z",    inst,"boundMaxZ",  px,row(22),pw)

  -- ── QUANTIZE
  pHeader("▸ Quantize", px, row(28), pw)
  pCheck("Space Q.",        inst,"spaceQuantizeEnabled",px,row(20)+2)
  pCheck("Time  Q.",        inst,"timeQuantizeEnabled", px,row(24)+2)
  pField("gx","Grid X",    inst,"gridX",      px,row(24),pw)
  pField("gy","Grid Y",    inst,"gridY",      px,row(22),pw)
  pField("gz","Grid Z",    inst,"gridZ",      px,row(22),pw)
  pCycle("Round",           inst,"roundMode",ROUND_LABELS,px,row(22),pw)

  -- ── SMOOTHING
  pHeader("▸ Smoothing", px, row(28), pw)
  pCheck("Smooth",          inst,"smoothingEnabled",   px,row(20)+2)
  pField("gl","Glide s",   inst,"glideTime",  px,row(24),pw)

  -- ── INTERACTION
  pHeader("▸ Interaction", px, row(28), pw)
  pCheck("Interact.",       inst,"interactionEnabled", px,row(20)+2)
  pField("sa","Send",      inst,"sendAmount",         px,row(24),pw)
  pField("ra","Receive",   inst,"receiveAmount",      px,row(22),pw)
  pField("ir","Radius",    inst,"interactionRadius",  px,row(22),pw)
  pCycle("Falloff",         inst,"falloffMode",FALLOFF_LABELS,px,row(22),pw)
  pCheck("→ Offset",        inst,"affectOffset",   px,row(24)+2)
  pCheck("→ Rate",          inst,"affectRate",     px,row(24)+2)

  -- update content height for next frame's scroll math
  param_content_h = max(iy - vpy + ui.right_scroll + ROW_H * 2, vph + ROW_H)

  -- scroll bar (interactive — geometry stored in ui.sb_right_geo for drag handling)
  if max_scroll>0 then
    local sbh=max(16,vph*vph/max_content)
    local sby=vpy+(ui.right_scroll/max_scroll)*(vph-sbh)
    ui.sb_right_geo={x=rx+rw-8,y=sby,w=7,h=sbh,track_y=vpy,track_h=vph,max_scroll=max_scroll}
    if ui.sb_right_drag then setColor(0.45,0.50,0.72) else setColor(0.25,0.25,0.38) end
    fillRect(rx+rw-7,sby,6,sbh)
  else
    ui.sb_right_geo=nil
  end
end

-- ── Status bar ────────────────────────────────────────────────────────────────

local function drawStatusBar(bx,by,bw,bh)
  setColor(0.08,0.08,0.11); fillRect(bx,by,bw,bh)
  setColor(0.18,0.18,0.24); fillRect(bx,by,bw,1)

  -- OSC dot
  setColor(osc.ok and 0.2 or 0.7, osc.ok and 0.9 or 0.2, osc.ok and 0.3 or 0.2)
  gfx.circle(bx+14,by+14,6,1)
  setColor(0.80,0.80,0.85); drawStr("OSC", bx+26, by+8)

  -- Host field (editable)
  local hfoc=(ui.focus_field=="osc_host")
  setColor(0.40,0.40,0.48); drawStr("Host:", bx+58, by+8)
  setColor(hfoc and 0.12 or 0.10, hfoc and 0.18 or 0.11, hfoc and 0.32 or 0.16)
  fillRect(bx+93,by+4,120,18)
  setColor(hfoc and 0.36 or 0.20, hfoc and 0.83 or 0.22, hfoc and 0.62 or 0.26)
  drawRect(bx+93,by+4,120,18)
  setColor(1,1,1); drawStr(hfoc and ui.focus_text or osc.host, bx+97, by+8)

  -- Port field (editable)
  local pfoc=(ui.focus_field=="osc_port")
  setColor(0.40,0.40,0.48); drawStr("Port:", bx+222, by+8)
  setColor(pfoc and 0.12 or 0.10, pfoc and 0.18 or 0.11, pfoc and 0.32 or 0.16)
  fillRect(bx+258,by+4,52,18)
  setColor(pfoc and 0.36 or 0.20, pfoc and 0.83 or 0.22, pfoc and 0.62 or 0.26)
  drawRect(bx+258,by+4,52,18)
  if pfoc and ui.focus_selectAll then  -- selection highlight behind text
    setColor(0.20,0.40,0.70); fillRect(bx+260,by+5,measureStr(ui.focus_text)+4,16)
  end
  setColor(1,1,1); drawStr(pfoc and ui.focus_text or osc.port, bx+262, by+8)

  -- Connect / Disconnect button
  setColor(osc.ok and 0.45 or 0.10, osc.ok and 0.12 or 0.28, osc.ok and 0.12 or 0.18)
  fillRect(bx+320,by+3,100,20)
  setColor(1,1,1); drawStr(osc.ok and "Disconnect" or "  Connect", bx+324, by+7)

  -- OSC input port indicator (shown when connected)
  if osc.ok and osc.in_port > 0 then
    setColor(0.40,0.40,0.48); drawStr("in:"..osc.in_port, bx+426, by+8)
  end

  -- ── Preset section ───────────────────────────────────────────
  -- Right-anchored so it never collides with the OSC section regardless of window width.
  -- Total preset widget width: name(130) + gap(2) + ▼(24) + gap(4) + Save(62) + gap(4) + Reset(62) = 288px + margins
  -- Minimum pnx = bx+490 (keeps 70px clear of Connect button right edge at 420).
  local pnlw=130; local ddtw=24
  local pnx  = max(bx+490, bx+bw-296)  -- right-anchored, never left of 490
  local ddtx = pnx+pnlw+2
  local savex= ddtx+ddtw+4
  local resetx=savex+66

  -- Name text field (editable)
  local pfoc=(ui.focus_field=="preset_name")
  setColor(pfoc and 0.12 or 0.09, pfoc and 0.18 or 0.10, pfoc and 0.32 or 0.16)
  fillRect(pnx,by+3,pnlw,20)
  setColor(pfoc and 0.36 or 0.22, pfoc and 0.83 or 0.28, pfoc and 0.62 or 0.34)
  drawRect(pnx,by+3,pnlw,20)
  setColor(1,1,1)
  local pnlabel=pfoc and ui.focus_text or (presetName~="" and presetName or "(name)")
  drawStr(pnlabel, pnx+5, by+7)

  -- ▼ arrow button (opens/closes dropdown)
  setColor(ui.preset_open and 0.18 or 0.12, ui.preset_open and 0.26 or 0.14,
           ui.preset_open and 0.42 or 0.22)
  fillRect(ddtx,by+3,ddtw,20)
  setColor(ui.preset_open and 0.55 or 0.35, 0.83, ui.preset_open and 0.90 or 0.62)
  drawStr(ui.preset_open and "▲" or "▼", ddtx+5, by+7)

  -- Save / Reset buttons
  setColor(0.13,0.18,0.28); fillRect(savex,by+3,62,20)
  setColor(0.36,0.83,0.62); drawStr(" Save", savex+4, by+7)
  setColor(0.13,0.18,0.28); fillRect(resetx,by+3,62,20)
  setColor(0.36,0.83,0.62); drawStr(" Reset", resetx+4, by+7)

  -- ── Row 2: Speed controls + status message ──────────────────
  -- Buttons enlarged ~40 % (width ×1.4, taller) — kept within the row slot.
  local r2y=by+28   -- second row y-offset
  local r2h=23      -- enlarged control height (was 18)
  local r2ty=r2y+7  -- vertical text position, centred in the taller controls
  setColor(0.12,0.12,0.17); fillRect(bx,r2y,bw,1)  -- subtle divider

  -- Speed multiplier label
  setColor(0.50,0.50,0.60); drawStr("Speed:", bx+8, r2y+8)
  local spdx=bx+54; local spdw=81
  local sfoc=(ui.focus_field=="globalRate")
  setColor(sfoc and 0.14 or 0.11, sfoc and 0.20 or 0.12, sfoc and 0.34 or 0.18)
  fillRect(spdx,r2y+2,spdw,r2h)
  setColor(sfoc and 0.40 or 0.28, sfoc and 0.85 or 0.36, sfoc and 0.65 or 0.42)
  drawRect(spdx,r2y+2,spdw,r2h)
  setColor(1,1,1)
  local spdLabel = sfoc and ("×"..ui.focus_text)
                         or string.format("×%.2f", globalRateMult)
  drawStr(spdLabel, spdx+6, r2ty)

  -- BPM sync toggle button
  local bpmx=spdx+spdw+6; local bpmw=67
  local bpmOn=(rateMode==1)
  setColor(bpmOn and 0.08 or 0.11, bpmOn and 0.28 or 0.13, bpmOn and 0.48 or 0.19)
  fillRect(bpmx,r2y+2,bpmw,r2h)
  setColor(bpmOn and 0.40 or 0.30, bpmOn and 0.85 or 0.50, bpmOn and 1.0 or 0.60)
  drawRect(bpmx,r2y+2,bpmw,r2h)
  setColor(bpmOn and 0.55 or 0.45, bpmOn and 1.0 or 0.65, bpmOn and 1.0 or 0.65)
  drawStr(bpmOn and "BPM ✓" or "BPM", bpmx+8, r2ty)

  -- Global direction toggle button
  local dirx=bpmx+bpmw+6; local dirw=59
  local dirRev=(globalDir<0)
  setColor(dirRev and 0.22 or 0.10, dirRev and 0.10 or 0.12, dirRev and 0.10 or 0.20)
  fillRect(dirx,r2y+2,dirw,r2h)
  setColor(dirRev and 0.90 or 0.28, dirRev and 0.35 or 0.55, dirRev and 0.30 or 0.90)
  drawRect(dirx,r2y+2,dirw,r2h)
  setColor(1,1,1); drawStr(dirRev and "< Rev" or "> Fwd", dirx+6, r2ty)

  -- Pause button
  local psx=dirx+dirw+6; local psw=62
  setColor(globalPaused and 0.30 or 0.11, globalPaused and 0.24 or 0.13, globalPaused and 0.08 or 0.10)
  fillRect(psx,r2y+2,psw,r2h)
  setColor(globalPaused and 1.0 or 0.55, globalPaused and 0.80 or 0.55, globalPaused and 0.10 or 0.20)
  drawRect(psx,r2y+2,psw,r2h)
  setColor(globalPaused and 1 or 0.80, globalPaused and 0.85 or 0.80, globalPaused and 0.10 or 0.30)
  drawStr(globalPaused and "▶ Play" or "‖ Pause", psx+6, r2ty)

  -- Stop button
  local stx=psx+psw+4; local stw=50
  setColor(0.22,0.10,0.10); fillRect(stx,r2y+2,stw,r2h)
  setColor(0.80,0.28,0.28); drawRect(stx,r2y+2,stw,r2h)
  setColor(0.95,0.40,0.40); drawStr("■ Stop", stx+6, r2ty)

  -- Global Ping-Pong toggle
  local ppx=stx+stw+6; local ppw=48
  setColor(globalPingPong and 0.10 or 0.09, globalPingPong and 0.22 or 0.10, globalPingPong and 0.28 or 0.15)
  fillRect(ppx,r2y+2,ppw,r2h)
  setColor(globalPingPong and 0.20 or 0.22, globalPingPong and 0.75 or 0.35, globalPingPong and 0.95 or 0.50)
  drawRect(ppx,r2y+2,ppw,r2h)
  setColor(globalPingPong and 0.30 or 0.55, globalPingPong and 0.90 or 0.65, globalPingPong and 1.0 or 0.70)
  drawStr("⇄ PP", ppx+6, r2ty)

  -- Sync timing button (after PingPong)
  local syncx=ppx+ppw+6; local syncw=64
  setColor(0.09,0.18,0.16); fillRect(syncx,r2y+2,syncw,r2h)
  setColor(0.22,0.60,0.52); drawRect(syncx,r2y+2,syncw,r2h)
  setColor(0.36,0.88,0.76); drawStr("⊙ Sync", syncx+6, r2ty)
  -- Status message (rest of row 2)
  setColor(0.35,0.35,0.45); drawStr(statusMsg, syncx+syncw+10, r2y+8)

  -- ── Row 3: Global Pos (translation) + Global Move (direction) ──
  local r3y=by+54
  setColor(0.12,0.12,0.17); fillRect(bx,r3y,bw,1)  -- divider

  -- Slider helper: draws a scrubber bar with fill from centre
  local function sb3slider(id, val, lbl, lx, ly, fw, lo, hi, ctr)
    local focused=(ui.focus_field==id)
    local hot=(ui.sliderDrag.active and ui.sliderDrag.id==id) or focused
    -- label
    setColor(hot and 0.70 or 0.45, hot and 0.70 or 0.45, hot and 0.80 or 0.58)
    drawStr(lbl, lx, ly+5)
    local sx=lx+measureStr(lbl)+4
    -- track bg (dimmed when focused to make text stand out)
    setColor(focused and 0.06 or 0.09, focused and 0.08 or 0.10, focused and 0.12 or 0.16)
    fillRect(sx,ly+2,fw,18)
    if not focused then
      -- fill from neutral point (ctr defaults to 0 for symmetric ranges)
      local nc = ctr or 0
      local tc = clamp((nc-lo)/(hi-lo), 0, 1)
      local clamped=clamp(val,lo,hi)
      local t=(clamped-lo)/(hi-lo)
      local midx=sx+fw*tc; local ex=sx+fw*t
      if val>=nc then
        setColor(hot and 0.30 or 0.18, hot and 0.80 or 0.52, hot and 0.65 or 0.48)
        if ex>midx then fillRect(midx,ly+5,ex-midx,12) end
      else
        setColor(hot and 0.80 or 0.52, hot and 0.35 or 0.25, hot and 0.30 or 0.20)
        if midx>ex then fillRect(ex,ly+5,midx-ex,12) end
      end
      -- neutral tick
      setColor(0.28,0.28,0.38); fillRect(midx-1,ly+3,2,16)
    end
    -- border — bright teal when focused, normal otherwise
    if focused then
      setColor(0.36,0.83,0.62)
    else
      setColor(hot and 0.45 or 0.22, hot and 0.90 or 0.38, hot and 0.80 or 0.52)
    end
    drawRect(sx,ly+2,fw,18)
    -- value text (or typed text with cursor when focused)
    if focused then
      if ui.focus_selectAll then  -- selection highlight behind text
        setColor(0.20,0.40,0.70); fillRect(sx+2,ly+3,measureStr(ui.focus_text)+4,14)
      end
      setColor(1,1,1)
      drawStr(ui.focus_text.."|", sx+4, ly+5)
    else
      setColor(hot and 1 or 0.88, hot and 1 or 0.88, 1)
      drawStr(string.format("%.3f",val), sx+4, ly+5)
    end
  end

  local fw3=72  -- slider width
  local lx=bx+8
  setColor(0.50,0.50,0.62); drawStr("Offset", lx, r3y+5); lx=lx+50
  sb3slider("gTX",globalTransX,"X",lx,r3y,fw3,-2,2); lx=lx+measureStr("X")+4+fw3+5
  sb3slider("gTY",globalTransY,"Y",lx,r3y,fw3,-2,2); lx=lx+measureStr("Y")+4+fw3+5
  sb3slider("gTZ",globalTransZ,"Z",lx,r3y,fw3,-2,2); lx=lx+measureStr("Z")+4+fw3+16

  setColor(0.50,0.50,0.62); drawStr("Move", lx, r3y+5); lx=lx+40
  sb3slider("gMX",globalMoveX,"X",lx,r3y,fw3,-2,2); lx=lx+measureStr("X")+4+fw3+5
  sb3slider("gMY",globalMoveY,"Y",lx,r3y,fw3,-2,2); lx=lx+measureStr("Y")+4+fw3+5
  sb3slider("gMZ",globalMoveZ,"Z",lx,r3y,fw3,-2,2)

  -- ── Row 4: Global Rotation — Pitch / Yaw / Roll ──
  local r4y=by+80
  setColor(0.12,0.12,0.17); fillRect(bx,r4y,bw,1)
  local lx4=bx+8
  setColor(0.50,0.50,0.62); drawStr("Rotate", lx4, r4y+5); lx4=lx4+54
  sb3slider("gPitch",globalPitch,"Pt",lx4,r4y,fw3,-180,180); lx4=lx4+measureStr("Pt")+4+fw3+5
  sb3slider("gYaw",  globalYaw,  "Yw",lx4,r4y,fw3,-180,180); lx4=lx4+measureStr("Yw")+4+fw3+5
  sb3slider("gRoll", globalRoll, "Rl",lx4,r4y,fw3,-180,180); lx4=lx4+measureStr("Rl")+4+fw3+16
  setColor(0.50,0.50,0.62); drawStr("Zoom",lx4,r4y+5); lx4=lx4+measureStr("Zoom")+4
  sb3slider("gZoom",globalZoom,"×",lx4,r4y,fw3,0,2,1.0)

  -- ── Row 5: Spin (global rotation per step) + Arrange shapes ──
  local r5y=by+106
  setColor(0.12,0.12,0.17); fillRect(bx,r5y,bw,1)  -- divider
  local lx5=bx+8
  setColor(0.50,0.50,0.62); drawStr("Spin", lx5, r5y+5); lx5=lx5+48
  sb3slider("gRPitch",globalRotPitch,"Pt",lx5,r5y,fw3,-360,360); lx5=lx5+measureStr("Pt")+4+fw3+5
  sb3slider("gRYaw",  globalRotYaw,  "Yw",lx5,r5y,fw3,-360,360); lx5=lx5+measureStr("Yw")+4+fw3+5
  sb3slider("gRRoll", globalRotRoll, "Rl",lx5,r5y,fw3,-360,360); lx5=lx5+measureStr("Rl")+4+fw3+16
  -- Arrange buttons (right of Spin)
  local arrLbl="Arrange:"
  setColor(0.50,0.50,0.62); drawStr(arrLbl, lx5, r5y+5)
  lx5=lx5+measureStr(arrLbl)+6
  local arrNames={"Circle","Helix","Sphere","Line","Grid","Rnd"}
  local arrW=46
  for ai,sname in ipairs(arrNames) do
    local ax=lx5+(ai-1)*(arrW+3)
    setColor(0.12,0.16,0.24); fillRect(ax,r5y+2,arrW-2,18)
    setColor(0.22,0.38,0.58); drawRect(ax,r5y+2,arrW-2,18)
    setColor(0.65,0.82,1.0); drawStr(sname, ax+4, r5y+5)
  end

  -- version string — right edge of row 2 (avoids row-1 preset section)
  local vs=SCRIPT_VERSION
  setColor(0.26,0.26,0.34); drawStr(vs, bx+bw-measureStr(vs)-6, r2y+6)
end

-- Preset dropdown overlay (drawn on top of everything when open)
local function drawPresetDropdown(bx,by,bw)
  if not ui.preset_open then return end
  local pnlw_=130; local ddtw_=24
  local pnx_=max(bx+490, bx+bw-296)   -- must match drawStatusBar
  local ddx=pnx_; local ddw=pnlw_+ddtw_+2   -- align with name field + arrow
  local item_h=ROW_H; local max_vis=10
  local total=#presetIndex
  local vis=min(total,max_vis)
  local dh=max(vis*item_h+6, item_h+6)  -- minimum height so "No saved presets" fits
  local dy=by-dh  -- opens upward

  -- background
  setColor(0.10,0.12,0.20); fillRect(ddx,dy,ddw,dh)
  setColor(0.25,0.35,0.55); drawRect(ddx,dy,ddw,dh)

  -- scroll
  local max_sc=max(0,(total-max_vis)*item_h)
  ui.preset_scroll=clamp(ui.preset_scroll,0,max_sc)

  if total==0 then
    setColor(0.45,0.45,0.52); drawStr("No saved presets", ddx+8, dy+8)
    return
  end

  for i,name in ipairs(presetIndex) do
    local iy=dy+3+(i-1)*item_h-ui.preset_scroll
    if iy>=dy and iy<dy+dh-item_h+4 then
      local isSel=(name==presetName)
      if isSel then setColor(0.16,0.28,0.50); fillRect(ddx+1,iy,ddw-2,item_h-1) end
      setColor(isSel and 0.90 or 0.75, isSel and 0.95 or 0.78, 1)
      drawStr(name, ddx+8, iy+4)
      -- delete X
      setColor(0.45,0.20,0.20); drawStr("×", ddx+ddw-16, iy+4)
    end
  end

  -- scrollbar
  if max_sc>0 then
    local sbh=max(14,dh*dh/((total)*item_h))
    local sby=dy+(ui.preset_scroll/max_sc)*(dh-sbh)
    setColor(0.30,0.35,0.55); fillRect(ddx+ddw-4,sby,3,sbh)
  end
end

-- ============================================================
-- SECTION 15: PRESETS
-- ============================================================

-- Label arrays referenced by pCycle (needed for drawParamPanel)
REP_LABELS   = {"Infinite","Finite","Ping-Pong"}
BOUND_LABELS = {"None","Clamp","Wrap","Mirror"}
ROUND_LABELS = {"Nearest","Floor","Ceil"}
FALLOFF_LABELS={"Linear","Inv-Sq","Gaussian"}
ROT_ORDER_IDX= {XYZ=1,XZY=2,YXZ=3,YZX=4,ZXY=5,ZYX=6}

-- ── Preset generators ─────────────────────────────────────────────────────────

local function presetCubic(n, spacing)
  n = n or 2; spacing = spacing or 1.0
  clearAll()
  local ci=1
  local sc=64
  for ix=0,n-1 do for iy=0,n-1 do for iz=0,n-1 do
    -- Each corner oscillates toward the centre (0,0,0) and back.
    -- At step 0 the instance sits at its lattice corner; at step sc-1
    -- it reaches (0,0,0); PingPong reverses back — a breathing cube.
    local sx=(ix-(n-1)/2)*spacing
    local sy=(iy-(n-1)/2)*spacing
    local sz=(iz-(n-1)/2)*spacing
    local ox= (sc>1) and (-sx/(sc-1)) or 0
    local oy= (sc>1) and (-sy/(sc-1)) or 0
    local oz= (sc>1) and (-sz/(sc-1)) or 0
    local ov={
      name=string.format("C%d%d%d",ix,iy,iz),
      startX=string.format("%.4f",sx),
      startY=string.format("%.4f",sy),
      startZ=string.format("%.4f",sz),
      offsetX=string.format("%.4f",ox),
      offsetY=string.format("%.4f",oy),
      offsetZ=string.format("%.4f",oz),
      rate="2", stepCount=tostring(sc),
      repetitionMode=REP.PINGPONG,
      colorIdx=((ci-1)%#PALETTE)+1,
    }
    addInstance(ov); ci=ci+1
    if #instances>=MAX_INSTANCES then goto done_cubic end
  end end end
  ::done_cubic::
  statusMsg=string.format("Preset 'Cubic' — %d instances",#instances)
end

local function presetTetragonal(n, a, c)
  n = n or 3; a = a or 0.8; c = c or 1.4
  clearAll()
  local ci=1
  for ix=0,n-1 do for iy=0,n-1 do for iz=0,1 do
    local ov={
      name=string.format("T%d%d%d",ix,iy,iz),
      startX=tostring((ix-(n-1)/2)*a),
      startY=tostring((iy-(n-1)/2)*a),
      startZ=tostring((iz-0.5)*c),
      offsetX="0.015", offsetY="0.015", offsetZ="0.03",
      rate="2", stepCount="96",
      repetitionMode=REP.PINGPONG,
      colorIdx=((ci-1)%#PALETTE)+1,
    }
    addInstance(ov); ci=ci+1
    if #instances>=MAX_INSTANCES then goto done_tetra end
  end end end
  ::done_tetra::
  statusMsg=string.format("Preset 'Tetragonal' — %d instances",#instances)
end

local function presetHexagonal(rings, c)
  rings = rings or 2; c = c or 1.2
  clearAll()
  local ci=1
  for layer=0,1 do
    for ring=0,rings do
      if ring==0 then
        local ov={
          name=string.format("H0_%d",layer),
          startX="0",startY="0",
          startZ=tostring((layer-0.5)*c),
          offsetX="0.01",offsetY="0.01",offsetZ="0.02",
          rate="2", stepCount="72",
          repetitionMode=REP.INFINITE,
          colorIdx=((ci-1)%#PALETTE)+1,
        }
        addInstance(ov); ci=ci+1
      else
        local sides=6*ring
        for k=0,sides-1 do
          local angle=k*(2*pi/sides)
          local rx_=ring*cos(angle)
          local ry_=ring*sin(angle)
          local ov={
            name=string.format("H%d_%d_%d",ring,k,layer),
            startX=tostring(rx_),startY=tostring(ry_),
            startZ=tostring((layer-0.5)*c),
            offsetX=tostring(0.008*cos(angle+pi/2)),
            offsetY=tostring(0.008*sin(angle+pi/2)),
            offsetZ="0.01",
            rate=tostring(0.15+ring*0.03),
            stepCount="80",
            repetitionMode=REP.PINGPONG,
            colorIdx=((ci-1)%#PALETTE)+1,
          }
          addInstance(ov); ci=ci+1
          if #instances>=MAX_INSTANCES then goto done_hex end
        end
      end
    end
  end
  ::done_hex::
  statusMsg=string.format("Preset 'Hexagonal' — %d instances",#instances)
end

-- ── Generic unit-cell helper ──────────────────────────────────
-- Returns Cartesian lattice vectors (a, b, c) for a parallelepiped
-- defined by lengths a_len/b_len/c_len and inter-vector angles alpha/beta/gamma (degrees).
-- Conventions: a along X, b in XY plane, c general.
local function latticeVecs(a_len, b_len, c_len, alpha_deg, beta_deg, gamma_deg)
  local d2r = math.pi/180
  local ca, cb, cg = cos(alpha_deg*d2r), cos(beta_deg*d2r), cos(gamma_deg*d2r)
  local sg = math.max(sin(gamma_deg*d2r), 1e-6)
  local Vf = sqrt(math.max(0, 1-ca*ca-cb*cb-cg*cg+2*ca*cb*cg))
  return
    a_len, 0,   0,                                 -- a⃗
    b_len*cg, b_len*sg, 0,                         -- b⃗
    c_len*cb, c_len*(ca-cb*cg)/sg, c_len*Vf/sg     -- c⃗
end

-- Place 8 corner instances of a unit cell, centered at origin.
-- Returns instance count added.
local function unitCellPreset(pfx, a_len, b_len, c_len, al, be, ga, ox, oy, oz, rate_, mode_)
  local ax,ay,az, bx_,by_,bz_, cx_,cy_,cz_ = latticeVecs(a_len,b_len,c_len,al,be,ga)
  local cx0=(ax+bx_+cx_)*0.5; local cy0=(ay+by_+cy_)*0.5; local cz0=(az+bz_+cz_)*0.5
  clearAll()
  local ci=1
  for n1=0,1 do for n2=0,1 do for n3=0,1 do
    local x=n1*ax+n2*bx_+n3*cx_-cx0
    local y=n1*ay+n2*by_+n3*cy_-cy0
    local z=n1*az+n2*bz_+n3*cz_-cz0
    addInstance({
      name=string.format("%s%d%d%d",pfx,n1,n2,n3),
      startX=tostring(x), startY=tostring(y), startZ=tostring(z),
      offsetX=tostring(ox), offsetY=tostring(oy), offsetZ=tostring(oz),
      rate=tostring(rate_), stepCount="64",
      repetitionMode=mode_,
      colorIdx=((ci-1)%#PALETTE)+1,
    })
    ci=ci+1
  end end end
  return ci-1
end

-- ── Primitive-lattice unit-cell presets ───────────────────────
-- Each places 8 instances at the corners of the crystallographic unit cell.
-- α=angle(b⃗,c⃗)  β=angle(a⃗,c⃗)  γ=angle(a⃗,b⃗)

local function presetOrthorhombic(a, b, c)
  -- a≠b≠c, α=β=γ=90°  →  rectangular parallelepiped, different side lengths
  a=a or 0.55; b=b or 0.85; c=c or 1.25
  local n=unitCellPreset("O",a,b,c, 90,90,90, 0.012,0.018,0.025, 2, REP.PINGPONG)
  statusMsg=string.format("Preset 'Orthorhombic' — %d instances",n)
end

local function presetRhombohedral(a, alpha_deg)
  -- a=b=c, α=β=γ≠90°  →  equal sides, all oblique angles
  a=a or 0.80; alpha_deg=alpha_deg or 68
  local n=unitCellPreset("R",a,a,a, alpha_deg,alpha_deg,alpha_deg, 0.015,0.015,0.015, 1.5, REP.PINGPONG)
  statusMsg=string.format("Preset 'Rhombohedral' — %d instances",n)
end

local function presetMonoclinic(a, b, c, beta_deg)
  -- a≠b≠c, α=γ=90°, β≠90°  →  one pair of tilted faces
  a=a or 0.65; b=b or 0.95; c=c or 1.20; beta_deg=beta_deg or 108
  local n=unitCellPreset("M",a,b,c, 90,beta_deg,90, 0.010,0.015,0.020, 2, REP.PINGPONG)
  statusMsg=string.format("Preset 'Monoclinic' — %d instances",n)
end

local function presetTriclinic(a, b, c)
  -- a≠b≠c, α≠β≠γ≠90°  →  fully asymmetric parallelepiped
  a=a or 0.65; b=b or 0.85; c=c or 1.05
  local n=unitCellPreset("Tc",a,b,c, 78,85,68, 0.008,0.012,0.018, 1.5, REP.PINGPONG)
  statusMsg=string.format("Preset 'Triclinic' — %d instances",n)
end

local function presetRandomSwarm(count, radius)
  count = count or 24; radius = radius or 1.5
  clearAll()
  math.randomseed(42)
  for i=1,count do
    local ov={
      name=string.format("S%02d",i),
      startX=tostring((math.random()*2-1)*radius),
      startY=tostring((math.random()*2-1)*radius),
      startZ=tostring((math.random()*2-1)*radius),
      offsetX=tostring((math.random()*0.04-0.02)),
      offsetY=tostring((math.random()*0.04-0.02)),
      offsetZ=tostring((math.random()*0.04-0.02)),
      rate=tostring(1.0+math.random()*2.0),
      stepCount=tostring(math.random(48,128)),
      repetitionMode=(i%3==0) and REP.PINGPONG or REP.INFINITE,
      smoothingEnabled=true, glideTime=tostring(0.05+math.random()*0.15),
      interactionEnabled=(i<=8),
      interactionRadius="1.2", falloffMode=FALLOFF.GAUSSIAN,
      colorIdx=((i-1)%#PALETTE)+1,
    }
    addInstance(ov)
    if #instances>=MAX_INSTANCES then break end
  end
  statusMsg=string.format("Preset 'RandomSwarm' — %d instances",#instances)
end

-- ── Preset serialize / deserialize / save / load ──────────────────────────────

local function serializeInstance(inst)
  local parts={}
  for k,v in pairs(inst) do
    if type(v)~="table" then
      parts[#parts+1]=tostring(k).."="..tostring(v)
    end
  end
  return table.concat(parts,"|")
end

local function deserializeInstance(s)
  local ov={}
  for pair in s:gmatch("[^|]+") do
    local k,v=pair:match("^(.-)=(.*)$")
    if k and v then
      local n_=tonumber(v)
      if v=="true"  then ov[k]=true
      elseif v=="false" then ov[k]=false
      elseif n_ then ov[k]=n_
      else ov[k]=v end
    end
  end
  return ov
end

-- Forward declarations (defined after savePreset, called within it)
local addToPresetIndex
local removeFromPresetIndex

local function savePreset(name)
  if name=="" then name="MyPreset" end
  storageSave(name.."__count", #instances)
  for i,inst in ipairs(instances) do
    storageSave(name.."__inst"..i, serializeInstance(inst))
  end
  storageSave(name.."__osc_host",   osc.host)
  storageSave(name.."__osc_port",   osc.port)
  storageSave(name.."__rateMode",   rateMode)
  storageSave(name.."__rateMult",   globalRateMult)
  addToPresetIndex(name)
  presetName=name
  statusMsg="Preset saved: "..name
end

local function loadPreset(name)
  if name=="" then name="MyPreset" end
  local cnt=tonumber(storageLoad(name.."__count")) or 0
  if cnt==0 then statusMsg="No preset: "..name; return end
  clearAll()
  for i=1,cnt do
    local s=storageLoad(name.."__inst"..i)
    if s and s~="" then
      local ov=deserializeInstance(s)
      -- restore numeric fields that should be strings
      for _,k in ipairs({"startX","startY","startZ","offsetX","offsetY","offsetZ",
        "rate","stepCount","rotationX","rotationY","rotationZ",
        "scaleX","scaleY","scaleZ","boundMinX","boundMaxX","boundMinY","boundMaxY",
        "boundMinZ","boundMaxZ","gridX","gridY","gridZ","glideTime",
        "sendAmount","receiveAmount","interactionRadius","name"}) do
        if ov[k]~=nil and type(ov[k])~="string" then ov[k]=tostring(ov[k]) end
      end
      addInstance(ov)
    end
  end
  local h=storageLoad(name.."__osc_host"); if h and h~="" then osc.host=h end
  local p=storageLoad(name.."__osc_port"); if p and p~="" then osc.port=p end
  local rm=tonumber(storageLoad(name.."__rateMode")); if rm then rateMode=rm end
  local rml=tonumber(storageLoad(name.."__rateMult")); if rml then globalRateMult=clamp(rml,0.01,16) end
  statusMsg="Preset loaded: "..name
end

-- ── Preset index (master list of saved preset names) ─────────────────────────

local function savePresetIndex()
  storageSave("__preset_index__", table.concat(presetIndex,"\t"))
end

local function loadPresetIndex()
  local s=storageLoad("__preset_index__")
  presetIndex={}
  if s and s~="" then
    for name in s:gmatch("[^\t]+") do
      presetIndex[#presetIndex+1]=name
    end
  end
end

addToPresetIndex = function(name)
  if name=="" then return end
  for _,n in ipairs(presetIndex) do if n==name then return end end
  presetIndex[#presetIndex+1]=name
  savePresetIndex()
end

removeFromPresetIndex = function(name)
  for i,n in ipairs(presetIndex) do
    if n==name then table.remove(presetIndex,i); savePresetIndex(); return end
  end
end

-- ============================================================
-- OSC SYSTEM
-- ============================================================

local OSC_PYTHON = [[
import socket,struct,sys,time,threading,os,tempfile

def osc_str(s):
    b=s.encode()+b'\x00';pad=(4-len(b)%4)%4;return b+b'\x00'*pad
def osc_float(f): return struct.pack('>f',f)
def osc_int(i):   return struct.pack('>i',i)
def build(addr,*args):
    msg=osc_str(addr)+osc_str(','+(''.join('i' if isinstance(a,int) else 'f' for a in args)))
    for a in args: msg+=osc_int(a) if isinstance(a,int) else osc_float(a)
    return msg

def parse_osc(data):
    def read_str(buf,pos):
        end=buf.index(b'\x00',pos); s=buf[pos:end].decode('utf-8','ignore')
        return s,(end+1+3)&~3
    try:
        addr,pos=read_str(data,0); tags,pos=read_str(data,pos); args=[]
        for t in tags[1:]:
            if t=='f': args.append(struct.unpack('>f',data[pos:pos+4])[0]); pos+=4
            elif t=='i': args.append(float(struct.unpack('>i',data[pos:pos+4])[0])); pos+=4
        return addr,args
    except: return None,[]

host=sys.argv[1]; port=int(sys.argv[2])
state_file=sys.argv[3] if len(sys.argv)>3 else os.path.join(tempfile.gettempdir(),'kristall_osc_in.txt')
in_port=port+1
sock=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

def receiver():
    rsock=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
    try: rsock.bind(('',in_port)); rsock.settimeout(1.0)
    except Exception as e:
        with open(state_file,'w') as f: f.write('error='+str(e)+'\n')
        return
    state={}
    while True:
        try:
            data,_=rsock.recvfrom(1024)
            addr,args=parse_osc(data)
            if not addr or not args: continue
            v=float(args[0])
            if   addr=='/kristall/pitch': state['pitch']=v
            elif addr=='/kristall/yaw':   state['yaw']=v
            elif addr=='/kristall/roll':  state['roll']=v
            elif addr=='/kristall/rotate' and len(args)>=3:
                state['pitch']=float(args[0]); state['yaw']=float(args[1]); state['roll']=float(args[2])
            # atomic replace on Unix; direct write fallback on Windows (file locking)
            try:
                tmp_=state_file+'.tmp'
                with open(tmp_,'w') as fw: [fw.write(f'{k}={val}\n') for k,val in state.items()]
                os.replace(tmp_,state_file)
            except OSError:
                try:
                    with open(state_file,'w') as fw: [fw.write(f'{k}={val}\n') for k,val in state.items()]
                except: pass
        except socket.timeout: continue
        except: break

threading.Thread(target=receiver,daemon=True).start()

for line in sys.stdin:
    line=line.strip()
    if not line: continue
    p=line.split(',')
    if len(p)<5: continue
    try:
        idx=int(p[0]); az=float(p[1]); el=float(p[2]); dist=float(p[3]); ch=int(p[4])
        msg=build('/icst/ambi/sourceindex/aed',idx,az,el,dist)
        sock.sendto(msg,(host,port))
    except: pass
]]

-- Detect OS once (Windows path separator is backslash)
local IS_WINDOWS = package.config:sub(1,1) == "\\"

-- Cross-platform temp path: on Windows os.tmpname() returns a root-relative
-- path like \lua_XXXXX which is often unwritable; use %TEMP% instead.
local function osc_tmppath(suffix)
  if IS_WINDOWS then
    local d = os.getenv("TEMP") or os.getenv("TMP") or os.getenv("USERPROFILE") or "C:\\Temp"
    local id = tostring(math.floor((reaper.time_precise()*1e6) % 1e7))
    return d .. "\\kristall_osc_" .. id .. suffix
  end
  return os.tmpname() .. suffix
end

local function oscConnect()
  if osc.pipe then pcall(function() osc.pipe:close() end); osc.pipe=nil end
  osc.ok=false; osc.status="Connecting…"
  -- write helper script to temp file
  local tmp=osc_tmppath(".py")
  local f=io.open(tmp,"w"); if not f then osc.status="Tmp write fail"; return end
  f:write(OSC_PYTHON); f:close()
  -- state file for OSC input (pitch/yaw/roll from receiver thread)
  local sf=osc_tmppath("_in.txt")
  osc.state_file=sf
  osc.in_port=(tonumber(osc.port) or 9001)+1
  -- On Windows: paths must be quoted (spaces), stderr → nul (not /dev/null)
  local null_dev = IS_WINDOWS and "2>nul" or "2>/dev/null"
  local q = IS_WINDOWS and '"' or ''
  local function py_cmd(exe)
    return string.format("%s %s%s%s %s %s %s%s%s %s",
      exe, q, tmp, q, osc.host, osc.port, q, sf, q, null_dev)
  end
  -- On Windows: use pythonw (windowless — no cmd.exe popup) then python fallback.
  -- Skip python3: on Windows it either doesn't exist or triggers the MS Store stub
  -- (exit code 9009), which leaves the stdin pipe detached for the || fallback.
  local cmd = IS_WINDOWS
    and (py_cmd("pythonw") .. " || " .. py_cmd("python"))
    or  (py_cmd("python3") .. " || " .. py_cmd("python"))
  osc.pipe=io.popen(cmd,"w")
  if osc.pipe then osc.ok=true; osc.status="Connected"; osc.tmp=tmp
  else osc.status="Failed — check Python install" end
end

local function oscDisconnect()
  if osc.pipe then pcall(function() osc.pipe:close() end); osc.pipe=nil end
  osc.ok=false; osc.status="Disconnected"
  if osc.tmp then pcall(os.remove, osc.tmp); osc.tmp=nil end
  if osc.state_file then pcall(os.remove, osc.state_file); osc.state_file=nil end
  osc.in_port=0
end

-- ============================================================
-- JSFX CONTROLLER  (JS_ICST_Kristall_Controller.jsfx on any track)
-- param 0=Preset, 1=Rate, 2=RateMode, 3=Smoothing, 4=Glide
-- param 5=Pitch(-180..180°), 6=Yaw(-180..180°), 7=Roll(-180..180°)
-- ============================================================
local ctrl = {
  track      = nil,
  fxIdx      = -1,
  lastPreset = 0,      -- previous slider0 value (detect change)
  scanTimer  = 0,      -- rescan every few seconds if not found
  SCAN_INTERVAL = 3.0,
}

local function ctrlFind()
  ctrl.track=nil; ctrl.fxIdx=-1
  -- Search ANY track for the JSFX — track name doesn't matter
  for i=0, reaper.CountTracks(0)-1 do
    local tr = reaper.GetTrack(0,i)
    for fi=0, reaper.TrackFX_GetCount(tr)-1 do
      local _, fname = reaper.TrackFX_GetFXName(tr, fi, "")
      if fname:find("Kristall Controller", 1, true) then
        ctrl.track=tr; ctrl.fxIdx=fi
        local _, tname = reaper.GetTrackName(tr, "")
        statusMsg="JSFX Controller found on track: "..tname
        return
      end
    end
  end
end

-- Read OSC input state file written by the Python receiver thread.
-- Updates globalPitch/globalYaw/globalRoll when the sender sends
--   /kristall/pitch  <float degrees>
--   /kristall/yaw    <float degrees>
--   /kristall/roll   <float degrees>
--   /kristall/rotate <float pitch> <float yaw> <float roll>
local oscInReadTimer = 0
local function readOscInput(dt)
  if not osc.ok or not osc.state_file then return end
  oscInReadTimer = oscInReadTimer + dt
  if oscInReadTimer < 0.05 then return end  -- poll at ~20 Hz
  oscInReadTimer = 0
  local f=io.open(osc.state_file,"r"); if not f then return end
  local content=f:read("*a"); f:close()
  for key,val in content:gmatch("(%a+)=(%-?%d+%.?%d*)") do
    local v=tonumber(val)
    if v then
      if     key=="pitch" then globalPitch=clamp(v,-180,180)
      elseif key=="yaw"   then globalYaw  =clamp(v,-180,180)
      elseif key=="roll"  then globalRoll =clamp(v,-180,180)
      end
    end
  end
end

local function ctrlPoll(dt)
  -- Periodically rescan if not connected
  if not ctrl.track or ctrl.fxIdx < 0 then
    ctrl.scanTimer = ctrl.scanTimer + dt
    if ctrl.scanTimer >= ctrl.SCAN_INTERVAL then
      ctrl.scanTimer = 0; ctrlFind()
    end
    return
  end
  -- Validate track still exists
  if not reaper.ValidatePtr(ctrl.track, "MediaTrack*") then
    ctrl.track=nil; ctrl.fxIdx=-1; return
  end

  -- param index = slider number − 1
  local preset = math.floor(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 0) + 0.5)
  local rate   = reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 1)
  local rmode  = math.floor(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 2) + 0.5)
  local smooth = math.floor(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 3) + 0.5)
  local glide  = reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 4)
  -- params 5/6/7 (slider6/7/8): Pitch/Yaw/Roll in degrees — only present in JSFX v0.2+
  local numP   = reaper.TrackFX_GetNumParams(ctrl.track, ctrl.fxIdx)

  -- Preset trigger: fire on change away from 0
  if preset ~= ctrl.lastPreset then
    ctrl.lastPreset = preset
    if     preset == 1 then presetCubic(3, 0.4)
    elseif preset == 2 then presetTetragonal(3, 0.3, 0.6)
    elseif preset == 3 then presetHexagonal(2, 0.4)
    elseif preset == 4 then presetRandomSwarm(12, 0.8)
    elseif preset == 5 then presetOrthorhombic()
    elseif preset == 6 then presetRhombohedral()
    elseif preset == 7 then presetMonoclinic()
    elseif preset == 8 then presetTriclinic()
    end
  end

  -- Global rate multiplier + mode (no per-instance override — preserves individual rates)
  globalRateMult = clamp(rate, 0.01, 16)
  rateMode       = rmode

  -- Smoothing / glide apply globally
  local smoothBool = (smooth == 1)
  local glideStr   = string.format("%.4f", clamp(glide, 0, 2))
  for _, inst in ipairs(instances) do
    inst.smoothingEnabled = smoothBool
    inst.glideTime        = glideStr
  end

  -- MIDI/JSFX Pitch/Yaw/Roll via params 5-7 (degrees, -180..180)
  -- Only read when the JSFX has slider6/7/8 (numP >= 8).
  if numP >= 8 then
    globalPitch = clamp(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 5), -180, 180)
    globalYaw   = clamp(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 6), -180, 180)
    globalRoll  = clamp(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 7), -180, 180)
  end

  -- Offset X/Y/Z, Move X/Y/Z, Zoom via params 8-14 (slider9-15)
  -- Only read when the JSFX has the extended sliders (numP >= 15).
  if numP >= 15 then
    globalTransX = clamp(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx,  8), -2, 2)
    globalTransY = clamp(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx,  9), -2, 2)
    globalTransZ = clamp(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 10), -2, 2)
    globalMoveX  = clamp(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 11), -2, 2)
    globalMoveY  = clamp(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 12), -2, 2)
    globalMoveZ  = clamp(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 13), -2, 2)
    globalZoom   = clamp(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 14),  0, 2)
  end
end

-- ============================================================
-- SECTION 13b: CIF IMPORT (Crystallography Open Database)
-- ============================================================
-- Parse a classical CIF (fractional coords + unit-cell params), convert to
-- centred/normalised cartesian points, and load them as instances. Reuses
-- latticeVecs() — the same cell matrix as the crystal-system presets.

local function cifTrim(s) return (s:gsub("^%s+",""):gsub("%s+$","")) end
-- strip standard-uncertainty parens, e.g. "0.1234(5)" -> "0.1234"
local function cifNum(s) if not s then return nil end return tonumber((s:gsub("%b()",""))) end

-- Element -> palette colour index (approx. CPK; hash fallback for the rest)
local CIF_ELEM_COLOR = {
  H=6, C=5, N=2, O=9, F=8, Cl=12, Br=3, I=5, P=7, S=11, B=8,
  Al=4, Si=6, Na=10, K=10, Mg=1, Ca=1, Zn=3, Fe=7, Cu=3, Ni=6,
  Co=4, Mn=9, Ti=6, Se=11, As=5,
}
local function cifElementColor(sym)
  sym=(sym or ""):gsub("[^%a]","")
  sym=sym:sub(1,1):upper()..sym:sub(2):lower()
  local c=CIF_ELEM_COLOR[sym]
  if c then return c end
  local h=0; for i=1,#sym do h=h+sym:byte(i) end
  return (h % #PALETTE)+1
end

local function cifFracToCart(fx,fy,fz, cell)
  local ax,ay,az, bx,by,bz, cx,cy,cz = latticeVecs(cell.a,cell.b,cell.c,cell.al,cell.be,cell.ga)
  return fx*ax+fy*bx+fz*cx, fx*ay+fy*by+fz*cy, fx*az+fy*bz+fz*cz
end

local function cifParse(text)
  local lines={}; for l in (text.."\n"):gmatch("(.-)\n") do lines[#lines+1]=l end
  local cell={}
  local function findval(tag)
    for _,ln in ipairs(lines) do
      local k,v=ln:match("^%s*(_%S+)%s+(.+)$"); if k==tag then return cifTrim(v) end
    end
  end
  cell.a =cifNum(findval("_cell_length_a"));  cell.b =cifNum(findval("_cell_length_b"));  cell.c =cifNum(findval("_cell_length_c"))
  cell.al=cifNum(findval("_cell_angle_alpha")); cell.be=cifNum(findval("_cell_angle_beta")); cell.ga=cifNum(findval("_cell_angle_gamma"))
  local atoms={}
  local i,nn=1,#lines
  local function brk(t) return t=="" or t:match("^loop_") or t:match("^_") or t:match("^#") or t:match("^data_") end
  while i<=nn do
    if cifTrim(lines[i])=="loop_" then
      i=i+1; local cols,idx={},{}
      while i<=nn do local t=cifTrim(lines[i]); if t:match("^_") then cols[#cols+1]=t; idx[t]=#cols; i=i+1 else break end end
      if idx["_atom_site_fract_x"] then
        local fxc,fyc,fzc=idx["_atom_site_fract_x"],idx["_atom_site_fract_y"],idx["_atom_site_fract_z"]
        local lc,sc=idx["_atom_site_label"],idx["_atom_site_type_symbol"]
        while i<=nn and not brk(cifTrim(lines[i])) do
          local tk={}; for w in lines[i]:gmatch("%S+") do tk[#tk+1]=w end
          if #tk>=#cols then
            local fx,fy,fz=cifNum(tk[fxc]),cifNum(tk[fyc]),cifNum(tk[fzc])
            if fx and fy and fz then
              local sym=(sc and tk[sc]) or (lc and tk[lc]:match("^%a+")) or "?"
              atoms[#atoms+1]={label=(lc and tk[lc]) or "", symbol=sym, fx=fx, fy=fy, fz=fz}
            end
          end
          i=i+1
        end
      else
        while i<=nn and not brk(cifTrim(lines[i])) do i=i+1 end
      end
    else i=i+1 end
  end
  return cell, atoms
end

local function cifImport()
  local ok, path = reaper.GetUserFileNameForRead("", "Import CIF (Crystallography Open Database)", "cif")
  if not ok or not path or path=="" then return end
  local f=io.open(path,"r"); if not f then statusMsg="CIF: cannot open file"; return end
  local text=f:read("*a"); f:close()
  local cell, atoms = cifParse(text)
  if not (cell.a and cell.b and cell.c and cell.al and cell.be and cell.ga) then
    statusMsg="CIF: incomplete unit cell (_cell_* tags missing)"; return
  end
  if #atoms==0 then statusMsg="CIF: no _atom_site_fract atoms found"; return end
  -- fractional -> cartesian, centre on centroid, normalise to unit radius
  local pts={}
  for _,a in ipairs(atoms) do
    local x,y,z=cifFracToCart(a.fx,a.fy,a.fz,cell)
    pts[#pts+1]={x=x,y=y,z=z,label=a.label,symbol=a.symbol}
  end
  local total=#pts; local mx0,my0,mz0=0,0,0
  for _,p in ipairs(pts) do mx0=mx0+p.x; my0=my0+p.y; mz0=mz0+p.z end
  mx0,my0,mz0=mx0/total,my0/total,mz0/total
  local maxr=1e-6
  for _,p in ipairs(pts) do p.x=p.x-mx0; p.y=p.y-my0; p.z=p.z-mz0
    local r=sqrt(p.x*p.x+p.y*p.y+p.z*p.z); if r>maxr then maxr=r end end
  local s=1.0/maxr
  local capped=false
  clearAll()
  for _,p in ipairs(pts) do
    if #instances>=MAX_INSTANCES then capped=true; break end
    addInstance({
      startX=string.format("%.4f",p.x*s), startY=string.format("%.4f",p.y*s), startZ=string.format("%.4f",p.z*s),
      offsetX="0", offsetY="0", offsetZ="0",   -- imported atoms are static by default
      name=(p.label~="" and p.label) or p.symbol,
      colorIdx=cifElementColor(p.symbol),
    })
  end
  selectedIdx=1; selectedSet={[1]=true}
  statusMsg=string.format("CIF import: %d atoms loaded%s", #instances,
                          capped and (" (capped from "..total..")") or "")
end

-- Open the Crystallography Open Database in the default browser — quick access
-- to search & download .cif files that the CIF button then imports.
-- Pre-filtered to Acta Crystallographica Section E — small single-crystal
-- structures whose asymmetric unit usually fits the 64-instance limit.
local COD_URL = "https://www.crystallography.net/cod/result.php?journal=Acta%20Crystallographica%20Section%20E"
local function cifOpenDatabase()
  if reaper.CF_ShellExecute then          -- SWS extension (cleanest, if present)
    reaper.CF_ShellExecute(COD_URL)
  else
    local os_ = reaper.GetOS() or ""
    local cmd
    if     os_:match("^Win")               then cmd='start "" "'..COD_URL..'"'
    elseif os_:match("OSX") or os_:match("macOS") then cmd='open "'..COD_URL..'"'
    else                                        cmd='xdg-open "'..COD_URL..'" &' end
    os.execute(cmd)
  end
  statusMsg="Opened crystallography.net (COD) in your browser"
end

-- Send all enabled instances as OSC /icst/ambi/sourceindex/aed messages
local function oscSendPreview()
  if not osc.ok or not osc.pipe then return end
  local t=reaper.time_precise()
  if t - osc.last_t < 0.016 then return end   -- ~60 Hz cap
  osc.last_t = t
  for i,inst in ipairs(instances) do
    if inst.enabled then
      -- effectivePos already includes rotation, zoom and translation (via applyGlobalTransforms)
      local x=inst.effectivePos.x; local y=inst.effectivePos.y; local z=inst.effectivePos.z
      -- ICST AmbiEncoder OSC-AED input convention: azimuth 0° = Front (+Y), +90° = Right (+X);
      -- distance = raw Euclidean radius (encoder rings extend past 1). Verified against the
      -- encoder display, this matches; the writer's normalized_xyz_to_aed uses a different space.
      local dist=sqrt(x*x+y*y+z*z); if dist<0.001 then dist=0.001 end
      local az=(math.atan2 and math.atan2(x,y) or math.atan(x,y))*180/math.pi
      local el=math.asin(clamp(z/dist,-1,1))*180/math.pi
      local line=string.format("%d,%.4f,%.4f,%.4f,%d\n",i,az,el,dist,i)
      pcall(function() osc.pipe:write(line); osc.pipe:flush() end)
    end
  end
end

-- ============================================================
-- INPUT HANDLER
-- ============================================================

-- Hit-test a point against a rectangle
local function hit(mx,my,rx,ry,rw,rh) return mx>=rx and mx<=rx+rw and my>=ry and my<=ry+rh end

-- Commit focus field value to the selected instance or special fields
local function commitFocus()
  if not ui.focus_field then return end
  if ui.focus_field=="osc_host" then
    osc.host=ui.focus_text
  elseif ui.focus_field=="osc_port" then
    osc.port=ui.focus_text
  elseif ui.focus_field=="preset_name" then
    presetName=ui.focus_text
  elseif ui.focus_field=="globalRate" then
    local v=tonumber(ui.focus_text)
    if v then globalRateMult=clamp(v, 0.01, 16) end
  elseif ui.focus_field=="gTX" then local v=tonumber(ui.focus_text); if v then globalTransX=v end
  elseif ui.focus_field=="gTY" then local v=tonumber(ui.focus_text); if v then globalTransY=v end
  elseif ui.focus_field=="gTZ" then local v=tonumber(ui.focus_text); if v then globalTransZ=v end
  elseif ui.focus_field=="gMX" then local v=tonumber(ui.focus_text); if v then globalMoveX=v end
  elseif ui.focus_field=="gMY" then local v=tonumber(ui.focus_text); if v then globalMoveY=v end
  elseif ui.focus_field=="gMZ" then local v=tonumber(ui.focus_text); if v then globalMoveZ=v end
  elseif ui.focus_field=="gPitch" then local v=tonumber(ui.focus_text); if v then globalPitch=v end
  elseif ui.focus_field=="gYaw"   then local v=tonumber(ui.focus_text); if v then globalYaw=v end
  elseif ui.focus_field=="gRoll"  then local v=tonumber(ui.focus_text); if v then globalRoll=v end
  elseif ui.focus_field=="gZoom"   then local v=tonumber(ui.focus_text); if v then globalZoom  =clamp(v,0,2) end
  elseif ui.focus_field=="gRPitch" then local v=tonumber(ui.focus_text); if v then globalRotPitch=clamp(v,-360,360) end
  elseif ui.focus_field=="gRYaw"   then local v=tonumber(ui.focus_text); if v then globalRotYaw  =clamp(v,-360,360) end
  elseif ui.focus_field=="gRRoll"  then local v=tonumber(ui.focus_text); if v then globalRotRoll =clamp(v,-360,360) end
  else
    local inst=instances[selectedIdx]
    local key=ui.focus_key
    if inst and key then
      if type(inst[key])~="boolean" then
        inst[key]=ui.focus_text
        -- batch apply same value to all other selected instances
        for idx,_ in pairs(selectedSet) do
          if instances[idx] and idx~=selectedIdx then
            instances[idx][key]=ui.focus_text
          end
        end
      end
    end
  end
  ui.focus_field=nil; ui.focus_key=nil; ui.focus_text=""; ui.focus_selectAll=false
end

local WIN_W, WIN_H       -- updated each frame from gfx
local STAT_H = 154  -- row1=28px + row2=26px + row3=26px + row4=26px + row5=26px + presetBar=22px
local PREV_H_FRAC = 0.45  -- default fraction of right column for lattice preview
local PREV_FRAC_MIN, PREV_FRAC_MAX = 0.18, 0.90  -- drag limits for the divider

local function handleInput()
  local mx=gfx.mouse_x; local my=gfx.mouse_y
  local mb=gfx.mouse_cap
  local lmb=(mb&1)==1
  local clicked=(lmb and ui.last_mouse==0)
  ui.last_mouse=lmb and 1 or 0
  local rmb=(mb&2)==2
  local rclicked=(rmb and ui.last_rmb==0)   -- right-click edge
  ui.last_rmb=rmb and 1 or 0

  WIN_W=gfx.w; WIN_H=gfx.h
  local content_h = WIN_H - STAT_H
  local shift_held=(gfx.mouse_cap&8)==8
  local cmd_held  =(gfx.mouse_cap&4)==4

  -- ── Focused-field scroll: nudge value without typing ────────────
  -- Click any value box to focus it, then scroll to adjust.
  -- Shift+scroll = ×10 coarser step.
  if gfx.mouse_wheel~=0 and ui.focus_field then
    local cur=tonumber(ui.focus_text)
    if cur then
      local notch=gfx.mouse_wheel>0 and 1 or -1
      local key=ui.focus_key or ui.focus_field
      local step
      if     key=="stepCount"                      then step=1
      elseif key:match("^rot")                     then step=1.0
      elseif key:match("^offset")                  then step=0.005
      elseif key=="rate"                           then step=0.05
      elseif key:match("^start")                   then step=0.01
      elseif key=="smoothing"                      then step=0.01
      elseif key=="globalRate"                     then step=0.1
      elseif key:match("^gT") or key:match("^gM") then step=0.01
      elseif key=="gPitch" or key=="gYaw"
          or key=="gRoll"                          then step=1.0
      elseif key=="gZoom"                          then step=0.01
      elseif key:match("^gR")                      then step=1.0
      else                                              step=0.01
      end
      if shift_held then step=step*10 end
      local newVal=cur+notch*step
      if key=="stepCount" then
        newVal=math.floor(clamp(newVal,1,512))
        ui.focus_text=tostring(newVal)
      else
        ui.focus_text=string.format("%.4f",newVal)
      end
      gfx.mouse_wheel=0
    end
  end

  -- ── List panel ─────────────────────────────────────────────
  local list_x=0; local list_y=0; local list_h=content_h

  if hit(mx,my,list_x,list_y,LIST_W,list_h) then
    -- scroll wheel on list (~1 row per notch)
    if gfx.mouse_wheel~=0 then
      ui.LIST_SCROLL=ui.LIST_SCROLL - (gfx.mouse_wheel/120)*ROW_H
      gfx.mouse_wheel=0
    end
    if clicked then
      -- row click
      local visible_start=26; local ry=my-(list_y+visible_start)+ui.LIST_SCROLL
      local row=floor(ry/ROW_H)+1
      if row>=1 and row<=#instances then
        commitFocus()
        if shift_held then
          if selectedSet[row] and row~=selectedIdx then
            selectedSet[row]=nil  -- deselect non-primary
          else
            selectedSet[row]=true
            selectedIdx=row
          end
        else
          selectedSet={[row]=true}
          selectedIdx=row
          onSelectionChanged()
        end
      end
      -- Add / Rem / Dup / Import / COD buttons
      local by_=list_y+list_h-24; local bw_=floor(LIST_W/5)
      if hit(mx,my,list_x,by_,bw_,20) then
        if #instances<MAX_INSTANCES then addInstance({}); selectedIdx=#instances end
      elseif hit(mx,my,list_x+bw_,by_,bw_,20) then
        if #instances>0 then removeInstance(instances,selectedIdx)
          selectedIdx=clamp(selectedIdx,1,max(1,#instances)) end
      elseif hit(mx,my,list_x+bw_*2,by_,bw_,20) then
        if instances[selectedIdx] and #instances<MAX_INSTANCES then
          local dup=duplicateInstance(instances[selectedIdx])
          table.insert(instances,selectedIdx+1,dup); selectedIdx=selectedIdx+1 end
      elseif hit(mx,my,list_x+bw_*3,by_,bw_,20) then
        cifImport()
      elseif hit(mx,my,list_x+bw_*4,by_,bw_,20) then
        cifOpenDatabase()
      end
    end
  end

  -- ── Right column ────────────────────────────────────────────
  local right_x=LIST_W; local right_w=WIN_W-LIST_W
  local prev_h=floor(content_h*ui.prevFrac)
  local param_y=prev_h; local param_h=content_h-prev_h

  -- ── Draggable divider between preview and param panel ───────────
  -- Grab the boundary and drag up/down to resize the lattice preview.
  -- Drag all the way down for a near-fullscreen preview.
  local DIV_GRAB=5
  if ui.dividerDrag then
    if lmb then
      ui.prevFrac=clamp(my/content_h, PREV_FRAC_MIN, PREV_FRAC_MAX)
    else
      ui.dividerDrag=false
    end
  elseif clicked and mx>=right_x and mx<right_x+right_w
         and my>=prev_h-DIV_GRAB and my<=prev_h+DIV_GRAB then
    commitFocus()
    ui.dividerDrag=true
  end

  -- ── Lattice preview drag ─────────────────────────────────────
  -- Must match drawLatticePreview(right_x, 0, right_w, prev_h) exactly:
  --   cx = px+pw*0.5, cy = py+ph*0.55 = 0+prev_h*0.55, scale = min(pw,ph)*0.17
  local prev_cx   = right_x + right_w*0.5
  local prev_cy   = prev_h * 0.55
  local iso_scale = min(right_w, prev_h) * 0.17

  -- ── Slider drag update ─────────────────────────────────────────
  if ui.sliderDrag.active then
    if lmb then
      local sd=ui.sliderDrag
      local delta=(mx-sd.startMx)*sd.scale
      local newVal=clamp(sd.startVal+delta, sd.lo, sd.hi)
      if     sd.id=="gTX" then globalTransX=newVal
      elseif sd.id=="gTY" then globalTransY=newVal
      elseif sd.id=="gTZ" then globalTransZ=newVal
      elseif sd.id=="gMX" then globalMoveX=newVal
      elseif sd.id=="gMY" then globalMoveY=newVal
      elseif sd.id=="gMZ" then globalMoveZ=newVal
      elseif sd.id=="gPitch" then globalPitch=newVal
      elseif sd.id=="gYaw"   then globalYaw=newVal
      elseif sd.id=="gRoll"  then globalRoll=newVal
      elseif sd.id=="gZoom"   then globalZoom=newVal
      elseif sd.id=="gRPitch" then globalRotPitch=newVal
      elseif sd.id=="gRYaw"   then globalRotYaw=newVal
      elseif sd.id=="gRRoll"  then globalRotRoll=newVal end
    else
      -- Mouse released: if barely moved, treat as click → open text edit
      local sd=ui.sliderDrag
      if math.abs(mx - sd.startMx) < 4 then
        local cur
        if     sd.id=="gTX"    then cur=globalTransX
        elseif sd.id=="gTY"    then cur=globalTransY
        elseif sd.id=="gTZ"    then cur=globalTransZ
        elseif sd.id=="gMX"    then cur=globalMoveX
        elseif sd.id=="gMY"    then cur=globalMoveY
        elseif sd.id=="gMZ"    then cur=globalMoveZ
        elseif sd.id=="gPitch" then cur=globalPitch
        elseif sd.id=="gYaw"   then cur=globalYaw
        elseif sd.id=="gRoll"  then cur=globalRoll
        elseif sd.id=="gZoom"   then cur=globalZoom
        elseif sd.id=="gRPitch" then cur=globalRotPitch
        elseif sd.id=="gRYaw"   then cur=globalRotYaw
        elseif sd.id=="gRRoll"  then cur=globalRotRoll
        end
        ui.focus_field = sd.id
        ui.focus_text  = string.format("%.3f", cur or 0)
        ui.focus_selectAll = true   -- first keystroke replaces the value
      end
      ui.sliderDrag.active=false
    end
  end

  -- ── Cmd+drag: vertical mouse scrub on instance value fields ─────
  -- Cmd+LMB on a value box then drag up/down to change value.
  -- Shift during drag = ×10 finer step.
  if ui.cmdDrag.active then
    if lmb then
      local dy = ui.cmdDrag.startMy - my   -- positive = moved up = value increases
      local key = ui.cmdDrag.key
      local eff_step = shift_held and ui.cmdDrag.step*0.1 or ui.cmdDrag.step
      local newVal = ui.cmdDrag.startVal + dy * eff_step
      if key=="stepCount" then newVal=math.floor(clamp(newVal,1,512)) end
      local inst=ui.cmdDrag.inst
      if inst then
        local prevVal=tonumber(inst[key]) or 0
        local delta=newVal-prevVal
        inst[key]=tostring(newVal)
        -- batch: apply same delta to other selected instances
        for idx,_ in pairs(selectedSet) do
          if instances[idx] and instances[idx]~=inst then
            local bc=tonumber(instances[idx][key]) or 0
            local bv=bc+delta
            if key=="stepCount" then bv=math.floor(clamp(bv,1,512)) end
            instances[idx][key]=tostring(bv)
          end
        end
      end
    else
      -- Released without a vertical drag → treat as a plain Cmd+click = reset to default
      if math.abs(my - ui.cmdDrag.startMy) < 3 then
        local key=ui.cmdDrag.key; local inst=ui.cmdDrag.inst
        if inst and key~="name" and DEFAULTS[key]~=nil then
          inst[key]=DEFAULTS[key]
          for idx,_ in pairs(selectedSet) do
            if instances[idx] and instances[idx]~=inst then instances[idx][key]=DEFAULTS[key] end
          end
          statusMsg=string.format("%s reset to default (%s)", key, tostring(DEFAULTS[key]))
        end
      end
      ui.cmdDrag.active=false
    end
  end

  if drag.active then
    if lmb then
      -- update position while dragging — applies delta to ALL selected instances
      local inst=instances[drag.instIdx]
      if inst then
        local origs=drag.origPositions or {[drag.instIdx]={x=drag.origX,y=drag.origY,z=drag.origZ}}
        if shift_held then
          -- Z axis: apply same dZ to all selected
          local dz=(drag.startMy-my)/iso_scale
          for idx,orig in pairs(origs) do
            if instances[idx] then
              local newZ=clamp(orig.z+dz,-2,2)
              instances[idx].startZ=string.format("%.4f",newZ)
              instances[idx].currentPos.z=newZ; instances[idx].effectivePos.z=newZ
            end
          end
        else
          -- XY plane: compute delta from primary drag, apply to all selected
          local wx,wy=isoUnproject(mx,my,drag.origZ, prev_cx,prev_cy,iso_scale)
          local ox,oy=isoUnproject(drag.startMx,drag.startMy,drag.origZ, prev_cx,prev_cy,iso_scale)
          local dx=wx-ox; local dy=wy-oy
          for idx,orig in pairs(origs) do
            if instances[idx] then
              local newX=clamp(orig.x+dx,-2,2)
              local newY=clamp(orig.y+dy,-2,2)
              instances[idx].startX=string.format("%.4f",newX)
              instances[idx].startY=string.format("%.4f",newY)
              instances[idx].currentPos.x=newX; instances[idx].effectivePos.x=newX
              instances[idx].currentPos.y=newY; instances[idx].effectivePos.y=newY
            end
          end
        end
      end
    else
      -- mouse released — drag done
      drag.active=false; drag.instIdx=nil; drag.origPositions=nil
    end
  elseif clicked and not ui.dividerDrag and hit(mx,my,right_x,0,right_w,prev_h) then
    -- check if click landed on any dot
    for i,inst in ipairs(instances) do
      if inst.enabled then
        local sx,sy=isoProject(inst.effectivePos.x,inst.effectivePos.y,inst.effectivePos.z,
                               prev_cx,prev_cy,iso_scale)
        if (mx-sx)*(mx-sx)+(my-sy)*(my-sy)<=(10*10) then
          commitFocus()
          if shift_held then
            -- Shift+click in preview: add dot to selectedSet (multi-select)
            selectedSet[i]=true; selectedIdx=i
          else
            selectedSet={[i]=true}; selectedIdx=i; onSelectionChanged()
          end
          drag.active=true; drag.instIdx=i
          drag.startMx=mx; drag.startMy=my
          drag.origX=tonumber(inst.startX) or 0
          drag.origY=tonumber(inst.startY) or 0
          drag.origZ=tonumber(inst.startZ) or 0
          -- Snapshot start positions of ALL selected instances for multi-drag
          drag.origPositions={}
          for idx,_ in pairs(selectedSet) do
            if instances[idx] then
              drag.origPositions[idx]={
                x=tonumber(instances[idx].startX) or 0,
                y=tonumber(instances[idx].startY) or 0,
                z=tonumber(instances[idx].startZ) or 0,
              }
            end
          end
          break
        end
      end
    end
  end

  -- dropdown scroll (~1 row per notch)
  if ui.preset_open and gfx.mouse_wheel~=0 then
    ui.preset_scroll=ui.preset_scroll - (gfx.mouse_wheel/120)*ROW_H
    gfx.mouse_wheel=0
  end

  -- Param panel: mouse-wheel over a field changes its value; elsewhere scrolls the panel.
  if hit(mx,my,right_x,param_y,right_w,param_h) and gfx.mouse_wheel~=0 then
    local consumed=false
    for _,f in ipairs(ui.param_fields) do
      if hit(mx,my,f.x,f.y,f.w,f.h) then
        local notch=gfx.mouse_wheel>0 and 1 or -1
        if f.cycle and f.inst and f.options then
          -- Cycle field (Mode, Order…): wheel steps through options
          local cur=f.inst[f.key] or 1
          local newVal=((cur-1+notch) % #f.options)+1
          f.inst[f.key]=newVal
          for idx,_ in pairs(selectedSet) do
            if instances[idx] and idx~=selectedIdx then instances[idx][f.key]=newVal end
          end
        elseif not f.checkbox and f.inst and f.key then
          -- Numeric text field: wheel nudges value; shift = ×10 coarser step
          local key=f.key
          local step
          if     key=="stepCount"        then step=1
          elseif key:match("^rot")       then step=1.0
          elseif key:match("^offset")    then step=0.005
          elseif key=="rate"             then step=0.05
          elseif key:match("^start")     then step=0.01
          elseif key=="smoothing"        then step=0.01
          else                                step=0.01
          end
          if shift_held then step=step*10 end
          local delta=notch*step
          local cur=tonumber(f.inst[key]) or 0
          local newVal=cur+delta
          if key=="stepCount" then newVal=math.floor(clamp(newVal,1,512)) end
          f.inst[key]=tostring(newVal)
          -- batch apply same delta to all other selected instances
          for idx,_ in pairs(selectedSet) do
            if instances[idx] and idx~=selectedIdx then
              local bc=tonumber(instances[idx][key]) or 0
              local bv=bc+delta
              if key=="stepCount" then bv=math.floor(clamp(bv,1,512)) end
              instances[idx][key]=tostring(bv)
            end
          end
        end
        gfx.mouse_wheel=0; consumed=true; break
      end
    end
    if not consumed then
      ui.right_scroll=ui.right_scroll - gfx.mouse_wheel*0.15
      gfx.mouse_wheel=0
    end
  end

  -- right scrollbar drag
  local sg=ui.sb_right_geo
  if sg and not ui.sb_right_drag and clicked and hit(mx,my,sg.x,sg.y,sg.w,sg.h) then
    ui.sb_right_drag=true
    ui.sb_right_start=my
    ui.sb_right_base=ui.right_scroll
    clicked=false  -- consume click so param fields below don't fire
  end
  if ui.sb_right_drag then
    if lmb then
      local g=ui.sb_right_geo
      if g then
        local travel=max(1, g.track_h - g.h)
        ui.right_scroll=clamp(ui.sb_right_base+(my-ui.sb_right_start)*(g.max_scroll/travel), 0, g.max_scroll)
      end
    else
      ui.sb_right_drag=false
    end
  end

  -- ── Right-click a value field → reset it to its default ─────────
  if rclicked then
    for _,f in ipairs(ui.param_fields) do
      if hit(mx,my,f.x,f.y,f.w,f.h) and f.inst and f.key
         and not f.checkbox and not f.cycle
         and f.key~="name" and DEFAULTS[f.key]~=nil then
        commitFocus()
        local dv=DEFAULTS[f.key]
        f.inst[f.key]=dv
        for idx,_ in pairs(selectedSet) do
          if instances[idx] and instances[idx]~=f.inst then instances[idx][f.key]=dv end
        end
        statusMsg=string.format("%s reset to default (%s)", f.key, tostring(dv))
        break
      end
    end
  end

  if clicked and not ui.dividerDrag then
    local inst=instances[selectedIdx]

    -- ── ↺ Defaults button in param panel header ────────────────────
    do
      local defbx=right_x+right_w-54; local defby=param_y+3
      local defbw=50; local defbh=16
      if hit(mx,my,defbx,defby,defbw,defbh) and inst then
        commitFocus()
        local ns=0
        for idx,_ in pairs(selectedSet) do
          if instances[idx] then defaultInstance(instances[idx]); ns=ns+1 end
        end
        statusMsg=string.format("↺ Defaults applied (%d instance%s)", ns, ns==1 and "" or "s")
        clicked=false  -- consume so param fields below don't fire
      end
    end

    -- ── Cmd+click on value field → start vertical scrub drag ──────
    -- Intercepts before normal text-edit so Cmd+drag doesn't open a text box.
    local cmdClickHandled=false
    if cmd_held then
      for _,f in ipairs(ui.param_fields) do
        if hit(mx,my,f.x,f.y,f.w,f.h) and not f.checkbox and not f.cycle and f.inst and f.key then
          commitFocus()
          local key=f.key
          local step
          if     key=="stepCount"        then step=1
          elseif key:match("^rot")       then step=1.0
          elseif key:match("^offset")    then step=0.005
          elseif key=="rate"             then step=0.05
          elseif key:match("^start")     then step=0.01
          elseif key=="smoothing"        then step=0.01
          else                                step=0.01
          end
          ui.cmdDrag={active=true,key=key,inst=f.inst,startMy=my,
                      startVal=tonumber(f.inst[key]) or 0,step=step}
          cmdClickHandled=true
          break
        end
      end
    end

    -- ── Parameter fields ───────────────────────────────────────
    for _,f in ipairs(ui.param_fields) do
      if cmdClickHandled then break end
      if hit(mx,my,f.x,f.y,f.w,f.h) then
        if f.checkbox and f.inst then
          local newVal=not f.inst[f.key]
          f.inst[f.key]=newVal
          for idx,_ in pairs(selectedSet) do
            if instances[idx] and idx~=selectedIdx then instances[idx][f.key]=newVal end
          end
        elseif f.cycle and f.inst and f.options then
          local cur=f.inst[f.key] or 1
          local newVal=(cur % #f.options)+1
          f.inst[f.key]=newVal
          for idx,_ in pairs(selectedSet) do
            if instances[idx] and idx~=selectedIdx then instances[idx][f.key]=newVal end
          end
        else
          commitFocus()
          ui.focus_field=f.id; ui.focus_key=f.key
          ui.focus_text=inst and tostring(inst[f.key] or "") or ""
          ui.focus_selectAll=true   -- first keystroke replaces the value
        end
        break
      end
    end

    -- ── Status bar buttons ─────────────────────────────────────
    local sb_y=content_h
    -- Preset layout constants (must match drawStatusBar — right-anchored)
    local pnlw=130; local ddtw=24
    local pnx  = max(490, WIN_W-296)
    local ddtx = pnx+pnlw+2
    local savex= ddtx+ddtw+4
    local resetx=savex+66

    -- Host field
    if hit(mx,my,93,sb_y+4,120,18) then
      commitFocus(); ui.focus_field="osc_host"; ui.focus_text=osc.host
    end
    -- Port field
    if hit(mx,my,258,sb_y+4,52,18) then
      commitFocus(); ui.focus_field="osc_port"; ui.focus_text=osc.port; ui.focus_selectAll=true
    end
    -- Connect / Disconnect
    if hit(mx,my,320,sb_y+3,100,20) then
      commitFocus()
      if osc.ok then oscDisconnect() else oscConnect() end
    end

    -- Preset name text field
    if hit(mx,my,pnx,sb_y+3,pnlw,20) then
      commitFocus(); ui.focus_field="preset_name"; ui.focus_text=presetName
    end
    -- Dropdown ▼ toggle OR item click (mutually exclusive to avoid same-frame close)
    if hit(mx,my,ddtx,sb_y+3,ddtw,20) then
      -- clicking the ▼ button toggles the dropdown
      commitFocus(); ui.preset_open=not ui.preset_open
    elseif ui.preset_open then
      -- dropdown is open: check item clicks or outside-click-to-close
      local item_h=ROW_H; local max_vis=10
      local total=#presetIndex
      local vis=min(total,max_vis)
      local dh=max(vis*item_h+6, item_h+6)  -- minimum height so empty list is visible
      local dy=sb_y-dh
      local ddx2=pnx; local ddw2=pnlw+ddtw+2
      if hit(mx,my,ddx2,dy,ddw2,dh) then
        for i,name in ipairs(presetIndex) do
          local iy=dy+3+(i-1)*item_h-ui.preset_scroll
          if my>=iy and my<iy+item_h then
            if mx>=ddx2+ddw2-20 then
              removeFromPresetIndex(name)
              if presetName==name then presetName="" end
            else
              presetName=name
              loadPreset(name)
              ui.preset_open=false
            end
            break
          end
        end
      else
        ui.preset_open=false
      end
    end
    -- Save button
    if hit(mx,my,savex,sb_y+3,62,20) then
      commitFocus()
      if presetName~="" then savePreset(presetName) end
    end
    -- Reset button → Cubic 2×2×2 default state
    if hit(mx,my,resetx,sb_y+3,62,20) then
      commitFocus(); presetCubic(2,1.0)
    end

    -- Speed controls — row 2 (matches drawStatusBar row2 coords; enlarged ~40 %)
    local r2y=sb_y+28; local r2h=23
    local spdx=54; local spdw=81
    local bpmx=spdx+spdw+6; local bpmw=67
    if hit(mx,my,spdx,r2y+2,spdw,r2h) then
      commitFocus()
      ui.sliderDrag.active=false  -- cancel any active slider drag
      ui.focus_field="globalRate"
      ui.focus_text=""
    end
    if hit(mx,my,bpmx,r2y+2,bpmw,r2h) then
      commitFocus()
      rateMode = (rateMode==0) and 1 or 0
      statusMsg = rateMode==1 and "BPM sync ON — 1 step = 1 beat"
                               or "BPM sync OFF — steps/sec"
    end
    -- Global direction toggle
    local dirx_=bpmx+bpmw+6; local dirw_=59
    if hit(mx,my,dirx_,r2y+2,dirw_,r2h) then
      commitFocus()
      globalDir = globalDir * -1
      statusMsg = globalDir==1 and "Direction: Forward" or "Direction: Reverse"
    end
    -- Pause toggle
    local psx_=dirx_+dirw_+6; local psw_=62
    if hit(mx,my,psx_,r2y+2,psw_,r2h) then
      commitFocus()
      globalPaused = not globalPaused
      statusMsg = globalPaused and "Paused" or "Playing"
    end
    -- Stop (reset all to step 0)
    local stx_=psx_+psw_+4; local stw_=50
    if hit(mx,my,stx_,r2y+2,stw_,r2h) then
      commitFocus()
      for _,inst in ipairs(instances) do resetInstance(inst) end
      globalPaused=true
      statusMsg="Stopped — all instances reset"
    end
    -- Global Ping-Pong toggle
    local ppx_=stx_+stw_+6; local ppw_=48
    if hit(mx,my,ppx_,r2y+2,ppw_,r2h) then
      commitFocus()
      globalPingPong = not globalPingPong
      if globalPingPong then
        globalPingPongDir = 1  -- reset direction when enabling
        statusMsg = "Global Ping-Pong ON — whole figure reverses together"
      else
        statusMsg = "Global Ping-Pong OFF"
      end
    end
    -- Sync timing: reset phaseAccumulator + currentStep for all selected instances
    local syncx_=ppx_+ppw_+6; local syncw_=64
    if hit(mx,my,syncx_,r2y+2,syncw_,r2h) then
      commitFocus()
      for idx,_ in pairs(selectedSet) do
        if instances[idx] then resetInstance(instances[idx]) end
      end
      local cnt=0; for _ in pairs(selectedSet) do cnt=cnt+1 end
      statusMsg=string.format("Timing synced — %d instance%s reset to step 0", cnt, cnt==1 and "" or "s")
    end

    -- Row 3: Global Pos + Move sliders
    local r3y=sb_y+54; local fw3=72
    local function r3sliderHit(id, lbl, lx, lo, hi, scale)
      local sx=lx+measureStr(lbl)+4
      if hit(mx,my,sx,r3y+2,fw3,18) then
        commitFocus()
        local cur
        if     id=="gTX" then cur=globalTransX
        elseif id=="gTY" then cur=globalTransY
        elseif id=="gTZ" then cur=globalTransZ
        elseif id=="gMX" then cur=globalMoveX
        elseif id=="gMY" then cur=globalMoveY
        elseif id=="gMZ" then cur=globalMoveZ end
        ui.sliderDrag={active=true,id=id,startMx=mx,startVal=cur or 0,lo=lo,hi=hi,scale=scale}
        return true
      end
      return false
    end
    local lx3=8+50  -- after "Offset" label (bx=0)
    r3sliderHit("gTX","X",lx3,-2,2,0.01); lx3=lx3+measureStr("X")+4+fw3+5
    r3sliderHit("gTY","Y",lx3,-2,2,0.01); lx3=lx3+measureStr("Y")+4+fw3+5
    r3sliderHit("gTZ","Z",lx3,-2,2,0.01); lx3=lx3+measureStr("Z")+4+fw3+16+40
    r3sliderHit("gMX","X",lx3,-2,2,0.01); lx3=lx3+measureStr("X")+4+fw3+5
    r3sliderHit("gMY","Y",lx3,-2,2,0.01); lx3=lx3+measureStr("Y")+4+fw3+5
    r3sliderHit("gMZ","Z",lx3,-2,2,0.01)

    -- Row 4: Rotate sliders (Pitch / Yaw / Roll)
    local r4y=sb_y+80
    local function r4sliderHit(id, lbl, lx, lo, hi, scale)
      local sx=lx+measureStr(lbl)+4
      if hit(mx,my,sx,r4y+2,fw3,18) then
        commitFocus()
        local cur
        if     id=="gPitch" then cur=globalPitch
        elseif id=="gYaw"   then cur=globalYaw
        elseif id=="gRoll"  then cur=globalRoll
        elseif id=="gZoom"  then cur=globalZoom end
        ui.sliderDrag={active=true,id=id,startMx=mx,startVal=cur or 0,lo=lo,hi=hi,scale=scale}
        return true
      end
      return false
    end
    local lx4=8+54  -- after "Rotate" label
    r4sliderHit("gPitch","Pt",lx4,-180,180,0.5); lx4=lx4+measureStr("Pt")+4+fw3+5
    r4sliderHit("gYaw",  "Yw",lx4,-180,180,0.5); lx4=lx4+measureStr("Yw")+4+fw3+5
    r4sliderHit("gRoll", "Rl",lx4,-180,180,0.5); lx4=lx4+measureStr("Rl")+4+fw3+16+measureStr("Zoom")+4
    r4sliderHit("gZoom", "×", lx4,0,2,0.005)

    -- Row 5: Spin sliders (global rotation per step) + Arrange buttons
    local r5y_=sb_y+106; local fw3_=72
    local function r5sliderHit(id, lbl, lx, lo, hi, scale)
      local sx=lx+measureStr(lbl)+4
      if hit(mx,my,sx,r5y_+2,fw3_,18) then
        commitFocus()
        local cur
        if     id=="gRPitch" then cur=globalRotPitch
        elseif id=="gRYaw"   then cur=globalRotYaw
        elseif id=="gRRoll"  then cur=globalRotRoll end
        ui.sliderDrag={active=true,id=id,startMx=mx,startVal=cur or 0,lo=lo,hi=hi,scale=scale}
        return true
      end
      return false
    end
    local lx5_=8+48  -- after "Spin" label
    r5sliderHit("gRPitch","Pt",lx5_,-360,360,1.0); lx5_=lx5_+measureStr("Pt")+4+fw3_+5
    r5sliderHit("gRYaw",  "Yw",lx5_,-360,360,1.0); lx5_=lx5_+measureStr("Yw")+4+fw3_+5
    r5sliderHit("gRRoll", "Rl",lx5_,-360,360,1.0); lx5_=lx5_+measureStr("Rl")+4+fw3_+16
    -- Arrange buttons (after Spin sliders)
    local arrLbl="Arrange:"
    local arrx_=lx5_+measureStr(arrLbl)+6
    local arrNames={"Circle","Helix","Sphere","Line","Grid","Rnd"}
    local arrW_=46
    for ai,sname in ipairs(arrNames) do
      local ax=arrx_+(ai-1)*(arrW_+3)
      if hit(mx,my,ax,r5y_+2,arrW_-2,18) then
        commitFocus()
        local sel={}
        for idx,_ in pairs(selectedSet) do if instances[idx] then sel[#sel+1]=idx end end
        table.sort(sel)
        local nn=#sel; if nn==0 then break end
        local rr=0.7
        for pos,idx in ipairs(sel) do
          local tt=(nn>1) and (pos-1)/(nn-1) or 0
          local ff=(pos-1)/nn
          local xx,yy,zz=0,0,0
          if ai==1 then      -- Circle (XZ plane)
            local a=ff*2*pi; xx=sin(a)*rr; yy=0; zz=cos(a)*rr
          elseif ai==2 then  -- Helix
            local a=tt*4*pi; xx=sin(a)*rr; yy=(tt-0.5)*1.4; zz=cos(a)*rr
          elseif ai==3 then  -- Sphere (Fibonacci)
            local golden=(1+sqrt(5))/2
            local theta=2*pi*pos/golden
            local phi=math.acos(clamp(1-2*pos/nn,-1,1))
            xx=sin(phi)*cos(theta)*rr; yy=cos(phi)*rr; zz=sin(phi)*sin(theta)*rr
          elseif ai==4 then  -- Line (X axis)
            xx=(tt-0.5)*1.8; yy=0; zz=0
          elseif ai==5 then  -- Grid (XZ)
            local side=max(1,ceil(sqrt(nn)))
            local gx=((pos-1)%side)-(side-1)*0.5
            local gz=floor((pos-1)/side)-(ceil(nn/side)-1)*0.5
            local sp=side>1 and 1.4/(side-1) or 0
            xx=gx*sp; yy=0; zz=gz*sp
          elseif ai==6 then  -- Random
            xx=(math.random()*2-1)*rr
            yy=(math.random()*2-1)*rr
            zz=(math.random()*2-1)*rr
          end
          instances[idx].startX=string.format("%.4f",xx)
          instances[idx].startY=string.format("%.4f",yy)
          instances[idx].startZ=string.format("%.4f",zz)
        end
        statusMsg=string.format("Arranged %d instances: %s",nn,sname)
        break
      end
    end

    -- Preset quick-select bar (row 6 — 8 buttons across full width)
    local pbar_y=sb_y+132; local pbar_h=22
    local n8=#PRESET_NAMES; local pw8=floor(WIN_W/n8)
    ui.hover_preset=nil
    for pi=1,n8 do
      local bx2=(pi-1)*pw8; local bw2=pw8-2
      if hit(mx,my,bx2,pbar_y,bw2,pbar_h) then
        ui.hover_preset=pi
        if clicked then
          commitFocus()
          if     pi==1 then presetCubic(2,1.0)
          elseif pi==2 then presetTetragonal(3,0.8,1.4)
          elseif pi==3 then presetHexagonal(2,1.2)
          elseif pi==4 then presetRandomSwarm(20,1.5)
          elseif pi==5 then presetOrthorhombic()
          elseif pi==6 then presetRhombohedral()
          elseif pi==7 then presetMonoclinic()
          elseif pi==8 then presetTriclinic()
          end
        end
      end
    end
  end

  -- ── Keyboard input (drain all pending chars per frame) ──────
  local char=0
  repeat
    char=gfx.getchar()
    if char>0 then
      if ui.focus_field then
        if char==13 then   -- Enter
          if ui.focus_field=="preset_name" then presetName=ui.focus_text end
          commitFocus()
        elseif char==27 then  -- Esc
          ui.focus_field=nil; ui.focus_key=nil; ui.focus_text=""; ui.focus_selectAll=false
        elseif char==1 then  -- Cmd/Ctrl+A: re-select the whole field
          ui.focus_selectAll=true
        elseif char==8 or char==127 then  -- Backspace/Del
          if ui.focus_selectAll then ui.focus_text=""; ui.focus_selectAll=false
          else ui.focus_text=ui.focus_text:sub(1,-2) end
        elseif char>=32 and char<127 then
          if ui.focus_selectAll then ui.focus_text=""; ui.focus_selectAll=false end
          ui.focus_text=ui.focus_text..string.char(char)
        end
      else
        -- Global shortcuts
        if char==1 then  -- Cmd+A: select all instances
          selectedSet={}; for i=1,#instances do selectedSet[i]=true end
          if #instances>0 then selectedIdx=1 end
          statusMsg=string.format("All %d instances selected",#instances)
        elseif char==string.byte('a') or char==string.byte('A') then
          if #instances<MAX_INSTANCES then addInstance({}); selectedIdx=#instances end
        elseif char==string.byte('d') or char==string.byte('D') then
          if instances[selectedIdx] and #instances<MAX_INSTANCES then
            local dup=duplicateInstance(instances[selectedIdx])
            table.insert(instances,selectedIdx+1,dup); selectedIdx=selectedIdx+1 end
        elseif char==string.byte('r') or char==string.byte('R') then
          if instances[selectedIdx] then resetInstance(instances[selectedIdx]) end
        elseif char==26 then  -- Ctrl+Z placeholder (REAPER undo)
          statusMsg="Use REAPER Undo for DAW actions"
        end
      end
    end
  until char<=0

  -- close on window close char
  if char==-1 then oscDisconnect(); return false end
  return true
end

-- ============================================================
-- DRAW FRAME
-- ============================================================

-- All 8 built-in crystal presets.
-- PRESET_NAMES[i] is the display label; PRESET_COUNT is used for JSFX dispatch.
PRESET_NAMES = {
  "Cubic","Tetragonal","Hexagonal","Rnd.Swarm",
  "Orthorhombic","Rhombohedral","Monoclinic","Triclinic"
}

local function drawPresetBar(bx,by,bw,bh)
  setColor(0.07,0.07,0.10); fillRect(bx,by,bw,bh)
  setColor(0.14,0.14,0.20); fillRect(bx,by,bw,1)  -- top divider
  local n=#PRESET_NAMES; local pw=floor(bw/n)
  for i,label in ipairs(PRESET_NAMES) do
    local px=bx+(i-1)*pw
    local hot=(ui.hover_preset==i)
    -- slightly different hue for the 4 crystallographic presets (5-8)
    local r = i<=4 and (hot and 0.18 or 0.12) or (hot and 0.20 or 0.13)
    local g = i<=4 and (hot and 0.26 or 0.16) or (hot and 0.22 or 0.13)
    local b_ = i<=4 and (hot and 0.42 or 0.24) or (hot and 0.36 or 0.20)
    setColor(r,g,b_); fillRect(px+1,by+2,pw-2,bh-3)
    -- label colour: teal for existing, amber for new crystallographic
    if i<=4 then setColor(0.36,0.83,0.62)
    else         setColor(0.95,0.80,0.30) end
    drawStr(i.." "..label, px+5, by+5)
    -- separator
    if i<n then setColor(0.18,0.18,0.25); fillRect(px+pw,by+2,1,bh-4) end
  end
end

local function drawFrame()
  gfx.clear=0x111118
  local w=gfx.w; local h=gfx.h
  local content_h=h-STAT_H

  -- left list
  drawInstanceList(0, 0, LIST_W, content_h)

  -- right column
  local right_x=LIST_W; local right_w=w-LIST_W
  local prev_h=floor(content_h*ui.prevFrac)

  -- lattice preview (top of right column)
  drawLatticePreview(right_x, 0, right_w, prev_h)

  -- param panel (bottom of right column)
  drawParamPanel(right_x, prev_h, right_w, content_h-prev_h)

  -- draggable divider handle between preview and param panel
  local mxg,myg=gfx.mouse_x,gfx.mouse_y
  local divHover=(mxg>=right_x and myg>=prev_h-5 and myg<=prev_h+5)
  local divOn=ui.dividerDrag or divHover
  if divOn then setColor(0.36,0.83,0.62) else setColor(0.20,0.22,0.30) end
  fillRect(right_x, prev_h-1, right_w, 2)
  -- centre grip dots for discoverability
  if divOn then setColor(0.55,0.95,0.80) else setColor(0.34,0.36,0.46) end
  local gcx=right_x+right_w*0.5
  for i=-2,2 do fillRect(floor(gcx+i*8)-1, prev_h-2, 3, 4) end

  -- status bar (rows 1-4)
  drawStatusBar(0, content_h, w, STAT_H)

  -- preset quick-select bar (row 5 — last 22 px of STAT_H)
  drawPresetBar(0, content_h+132, w, 22)

  -- preset dropdown overlay (on top of everything)
  drawPresetDropdown(0, content_h, w)

  gfx.update()
end

-- ============================================================
-- MAIN LOOP
-- ============================================================

local last_time = reaper.time_precise()

local function mainLoop()
  local now=reaper.time_precise()
  local dt=clamp(now-last_time, 0, 0.1)
  last_time=now

  -- JSFX controller (reads preset trigger + smoothing/glide/rate + MIDI Pt/Yw/Rl)
  ctrlPoll(dt)

  -- OSC input: update Pt/Yw/Rl from incoming /kristall/pitch|yaw|roll messages
  readOscInput(dt)

  -- process all instances, then apply global Pt/Yw/Rl + Offset (runs even when paused)
  updateAllInstances(dt)
  applyGlobalTransforms(dt)

  -- OSC preview
  if osc.ok then oscSendPreview() end

  -- draw
  drawFrame()

  -- input (returns false on window close)
  local cont=handleInput()

  if cont and gfx.getchar()~=-1 then
    reaper.defer(mainLoop)
  else
    savePreset("__last__")   -- auto-save session on close
    oscDisconnect()
    gfx.quit()
  end
end

-- ============================================================
-- STARTUP
-- ============================================================

-- Vertical window: list on left, preview + params on right
gfx.init(SCRIPT_NAME, 980, 720, 0, 100, 80)
gfx.setfont(1, "Arial", 13)
gfx.setfont(2, "Arial", 11)
gfx.setfont(3, "Arial Bold", 12)

-- Load preset index (list of saved names)
loadPresetIndex()
ctrlFind()   -- initial scan for JSFX controller track

-- Load last preset or fall back to Cubic
local saved_count=tonumber(storageLoad("__last__count")) or 0
if saved_count>0 then
  loadPreset("__last__")
  statusMsg="Session restored — "..#instances.." instances"
else
  presetCubic(2, 1.0)
end

last_time=reaper.time_precise()
reaper.defer(mainLoop)

-- ============================================================
-- ALIASES / COMPATIBILITY SHIMS
-- (appended after all sections to resolve forward references)
-- ============================================================

-- Label table safety guards — Section 15 sets these globals before any draw
-- call, but these or-guards document the expected values as a fallback.
REP_LABELS    = REP_LABELS    or {"Infinite","Finite","Pingpong"}
BOUND_LABELS  = BOUND_LABELS  or {"None","Clamp","Wrap","Mirror"}
ROUND_LABELS  = ROUND_LABELS  or {"Nearest","Floor","Ceil"}
FALLOFF_LABELS= FALLOFF_LABELS or {"Linear","InvSq","Gaussian"}
