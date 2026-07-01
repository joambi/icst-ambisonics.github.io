-- @description ICST Kristall Motion Map
-- @author JS / Codex
-- @version 0.1.0
-- @about
--   Modular 3D crystal-lattice motion system for up to 64 AmbiEncoder sources.
--   Inspired by ICST Ambi Motion Map. Real-time gfx GUI, isometric 3D preview,
--   Python3 OSC preview, REAPER ExtState presets, automation-writer compatible.

-- ============================================================
-- SECTION 1: CONSTANTS AND ENUMS
-- ============================================================

local SCRIPT_NAME    = "ICST Kristall Motion Map"
local SCRIPT_VERSION = "v0.1.0"
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
  affectOffset=false, affectRate=false, affectScale=false, affectRotation=false,
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
  local sx = cx + (x-y)*cos(pi/6)*scale
  local sy = cy - (x+y)*sin(pi/6)*scale + z*scale
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

local function addInstance(ov)
  if #instances>=MAX_INSTANCES then return nil end
  local inst=createInstance(ov); table.insert(instances,inst); return inst
end
local function clearAll() instances={}; selectedIdx=1 end
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
  focus_key      = nil,
  last_mouse     = 0,
  param_fields   = {},   -- hit-test table rebuilt each frame
  preset_open    = false,
  preset_scroll  = 0,
  sliderDrag     = {active=false,id=nil,startMx=0,startVal=0,lo=0,hi=1,scale=0.01},
}

local osc = {
  host="127.0.0.1", port="9001",
  ok=false, status="Not connected", pipe=nil, last_t=0,
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

-- Commit a text field: write ui.focus_text back into inst[key].
local function commitFocus(inst)
  if not ui.focus_field or not inst then return end
  -- Find matching key in param_fields
  for _,f in ipairs(ui.param_fields) do
    if f.id==ui.focus_field and f.key then inst[f.key]=ui.focus_text; break end
  end
  ui.focus_field=nil
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

local function computeTransformedPosition(inst)
  local pos=computeStepPosition(inst)
  pos=applyRotation(pos,inst); pos=applyScale(pos,inst); pos=applyBounds(pos,inst)
  -- global translation: shift all instances uniformly
  return vec3(pos.x+globalTransX, pos.y+globalTransY, pos.z+globalTransZ)
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
local globalPaused = false      -- pause: freeze steps, keep current positions


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
    local d=inst.direction*globalDir
    if inst.repetitionMode==REP.INFINITE then
      inst.currentStep=inst.currentStep+d
    elseif inst.repetitionMode==REP.FINITE then
      inst.currentStep=clamp(inst.currentStep+d, 0, sc-1)
    elseif inst.repetitionMode==REP.PINGPONG then
      inst.currentStep=inst.currentStep+d
      if inst.currentStep>=sc-1 then inst.currentStep=sc-1;inst.direction=inst.direction*-1
      elseif inst.currentStep<=0 then inst.currentStep=0;inst.direction=inst.direction*-1 end
    end
  end
  local pos=computeStepPosition(inst)                                 -- 3
  pos=applyRotation(pos,inst)                                         -- 4
  pos=applyScale(pos,inst)                                            -- 5
  pos=applyBounds(pos,inst)                                           -- 6
  pos=quantizePoint(pos,inst)                                         -- 7
  inst.targetPos=pos; updateSmoothing(inst,dt)                        -- 8
  inst.effectivePos=vecCopy(inst.currentPos)                          -- 9
end

local function updateAllInstances(dt)
  if globalPaused then return end
  local transport=getTransportState()
  local influences=accumulateInfluences()
  for i,inst in ipairs(instances) do
    updateInstance(inst,influences[i] or {offsetSum=vec3(),rateSum=0,weightSum=0},dt,transport)
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
  local c=cos(pi/6)*scale; local s=sin(pi/6)*scale
  local A=(sx-cx)/c          -- x - y
  local B=(cy-sy+z*scale)/s  -- x + y
  return (A+B)*0.5, (B-A)*0.5
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
      local sel=(i==selectedIdx)
      if sel then setColor(0.18,0.32,0.58); fillRect(lx,ry,lw,ROW_H) end
      -- color swatch
      local c=PALETTE[((inst.colorIdx-1)%#PALETTE)+1]
      setColor(c[1],c[2],c[3]); fillRect(lx+3,ry+5,8,12)
      -- enabled dot
      if inst.enabled then setColor(0.25,0.90,0.35) else setColor(0.50,0.18,0.18) end
      gfx.circle(lx+18,ry+11,4,1)
      -- name
      setColor(sel and 1.0 or 0.85, sel and 1.0 or 0.85, sel and 1.0 or 0.88)
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

  -- Add / Remove / Dup buttons
  local by=ly+lh-24; local bw=floor(lw/3)
  local btns={"+ Add","- Rem","Dup"}
  for k,label in ipairs(btns) do
    local bx=lx+(k-1)*bw
    setColor(0.14,0.18,0.28); fillRect(bx+1,by,bw-2,20)
    setColor(0.36,0.83,0.62); drawStr(label, bx+4, by+4)
  end
end

-- ── Right parameter panel ─────────────────────────────────────────────────────

local RIGHT_W=300

-- Draw a labeled text-input field; register in ui.param_fields for hit-testing.
local function pField(id,label,inst,key,rx,ry,rw)
  local val=tostring(inst[key] or "")
  local focused=(ui.focus_field==id)
  local display=focused and ui.focus_text or val
  setColor(0.42,0.42,0.50); drawStr(label, rx, ry)
  local bx=rx+88; local bw=rw-92
  setColor(focused and 0.14 or 0.10, focused and 0.22 or 0.11, focused and 0.38 or 0.16)
  fillRect(bx,ry-2,bw,ROW_H-3)
  setColor(focused and 0.36 or 0.22, focused and 0.83 or 0.22, focused and 0.62 or 0.28)
  drawRect(bx,ry-2,bw,ROW_H-3)
  setColor(1,1,1); drawStr(display, bx+4, ry)
  ui.param_fields[#ui.param_fields+1]={id=id,key=key,x=bx,y=ry-2,w=bw,h=ROW_H-2}
end

-- Cycle-button for enum fields
local function pCycle(label,inst,key,opts,rx,ry,rw)
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

  local vpy=ry+24; local vph=rh-24
  local max_content=1200  -- approx total content height
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
  pCheck("→ Scale",         inst,"affectScale",    px,row(24)+2)
  pCheck("→ Rotation",      inst,"affectRotation", px,row(24)+2)

  -- scroll bar
  if max_scroll>0 then
    local sbh=max(16,vph*vph/max_content)
    local sby=vpy+(ui.right_scroll/max_scroll)*(vph-sbh)
    setColor(0.25,0.25,0.38); fillRect(rx+rw-5,sby,4,sbh)
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
  setColor(1,1,1); drawStr(pfoc and ui.focus_text or osc.port, bx+262, by+8)

  -- Connect / Disconnect button
  setColor(osc.ok and 0.45 or 0.10, osc.ok and 0.12 or 0.28, osc.ok and 0.12 or 0.18)
  fillRect(bx+320,by+3,100,20)
  setColor(1,1,1); drawStr(osc.ok and "Disconnect" or "  Connect", bx+324, by+7)

  -- ── Preset section ───────────────────────────────────────────
  -- Layout: "Preset:" | [editable name 148px] | [▼ 24px] | [Save] | [Reset]
  local pnx=bx+434; local pnlw=148  -- name text field
  local ddtx=pnx+pnlw+2; local ddtw=24  -- dropdown arrow button
  local savex=ddtx+ddtw+4
  local resetx=savex+66

  setColor(0.38,0.38,0.48); drawStr("Preset:", bx+370, by+8)

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
  local r2y=by+28   -- second row y-offset
  setColor(0.12,0.12,0.17); fillRect(bx,r2y,bw,1)  -- subtle divider

  -- Speed multiplier label
  setColor(0.50,0.50,0.60); drawStr("Speed:", bx+8, r2y+6)
  local spdx=bx+54; local spdw=58
  local sfoc=(ui.focus_field=="globalRate")
  setColor(sfoc and 0.14 or 0.11, sfoc and 0.20 or 0.12, sfoc and 0.34 or 0.18)
  fillRect(spdx,r2y+2,spdw,18)
  setColor(sfoc and 0.40 or 0.28, sfoc and 0.85 or 0.36, sfoc and 0.65 or 0.42)
  drawRect(spdx,r2y+2,spdw,18)
  setColor(1,1,1)
  local spdLabel = sfoc and ("×"..ui.focus_text)
                         or string.format("×%.2f", globalRateMult)
  drawStr(spdLabel, spdx+4, r2y+5)

  -- BPM sync toggle button
  local bpmx=spdx+spdw+6; local bpmw=48
  local bpmOn=(rateMode==1)
  setColor(bpmOn and 0.08 or 0.11, bpmOn and 0.28 or 0.13, bpmOn and 0.48 or 0.19)
  fillRect(bpmx,r2y+2,bpmw,18)
  setColor(bpmOn and 0.40 or 0.30, bpmOn and 0.85 or 0.50, bpmOn and 1.0 or 0.60)
  drawRect(bpmx,r2y+2,bpmw,18)
  setColor(bpmOn and 0.55 or 0.45, bpmOn and 1.0 or 0.65, bpmOn and 1.0 or 0.65)
  drawStr(bpmOn and "BPM ✓" or "BPM", bpmx+6, r2y+5)

  -- Global direction toggle button
  local dirx=bpmx+bpmw+6; local dirw=42
  local dirRev=(globalDir<0)
  setColor(dirRev and 0.22 or 0.10, dirRev and 0.10 or 0.12, dirRev and 0.10 or 0.20)
  fillRect(dirx,r2y+2,dirw,18)
  setColor(dirRev and 0.90 or 0.28, dirRev and 0.35 or 0.55, dirRev and 0.30 or 0.90)
  drawRect(dirx,r2y+2,dirw,18)
  setColor(1,1,1); drawStr(dirRev and "< Rev" or "> Fwd", dirx+4, r2y+5)

  -- Pause button
  local psx=dirx+dirw+6; local psw=44
  setColor(globalPaused and 0.30 or 0.11, globalPaused and 0.24 or 0.13, globalPaused and 0.08 or 0.10)
  fillRect(psx,r2y+2,psw,18)
  setColor(globalPaused and 1.0 or 0.55, globalPaused and 0.80 or 0.55, globalPaused and 0.10 or 0.20)
  drawRect(psx,r2y+2,psw,18)
  setColor(globalPaused and 1 or 0.80, globalPaused and 0.85 or 0.80, globalPaused and 0.10 or 0.30)
  drawStr(globalPaused and "▶ Play" or "‖ Pause", psx+4, r2y+5)

  -- Stop button
  local stx=psx+psw+4; local stw=36
  setColor(0.22,0.10,0.10); fillRect(stx,r2y+2,stw,18)
  setColor(0.80,0.28,0.28); drawRect(stx,r2y+2,stw,18)
  setColor(0.95,0.40,0.40); drawStr("■ Stop", stx+4, r2y+5)

  -- Status message (rest of row 2)
  setColor(0.35,0.35,0.45); drawStr(statusMsg, stx+stw+10, r2y+6)

  -- ── Row 3: Global Pos (translation) + Global Move (direction) ──
  local r3y=by+54
  setColor(0.12,0.12,0.17); fillRect(bx,r3y,bw,1)  -- divider

  -- Slider helper: draws a scrubber bar with fill from centre
  local function sb3slider(id, val, lbl, lx, ly, fw, lo, hi)
    local hot=(ui.sliderDrag.active and ui.sliderDrag.id==id)
    -- label
    setColor(hot and 0.70 or 0.45, hot and 0.70 or 0.45, hot and 0.80 or 0.58)
    drawStr(lbl, lx, ly+5)
    local sx=lx+measureStr(lbl)+4
    -- track
    setColor(0.09,0.10,0.16); fillRect(sx,ly+2,fw,18)
    -- fill from centre
    local clamped=clamp(val,lo,hi)
    local t=(clamped-lo)/(hi-lo)
    local midx=sx+fw*0.5; local ex=sx+fw*t
    if val>=0 then
      setColor(hot and 0.30 or 0.18, hot and 0.80 or 0.52, hot and 0.65 or 0.48)
      if ex>midx then fillRect(midx,ly+5,ex-midx,12) end
    else
      setColor(hot and 0.80 or 0.52, hot and 0.35 or 0.25, hot and 0.30 or 0.20)
      if midx>ex then fillRect(ex,ly+5,midx-ex,12) end
    end
    -- centre tick
    setColor(0.28,0.28,0.38); fillRect(midx-1,ly+3,2,16)
    -- border
    setColor(hot and 0.45 or 0.22, hot and 0.90 or 0.38, hot and 0.80 or 0.52)
    drawRect(sx,ly+2,fw,18)
    -- value text
    setColor(hot and 1 or 0.88, hot and 1 or 0.88, 1)
    drawStr(string.format("%.3f",val), sx+4, ly+5)
  end

  local fw3=72  -- slider width
  local lx=bx+8
  setColor(0.50,0.50,0.62); drawStr("Pos", lx, r3y+5); lx=lx+28
  sb3slider("gTX",globalTransX,"X",lx,r3y,fw3,-2,2); lx=lx+measureStr("X")+4+fw3+5
  sb3slider("gTY",globalTransY,"Y",lx,r3y,fw3,-2,2); lx=lx+measureStr("Y")+4+fw3+5
  sb3slider("gTZ",globalTransZ,"Z",lx,r3y,fw3,-2,2); lx=lx+measureStr("Z")+4+fw3+16

  setColor(0.50,0.50,0.62); drawStr("Move", lx, r3y+5); lx=lx+40
  sb3slider("gMX",globalMoveX,"X",lx,r3y,fw3,-2,2); lx=lx+measureStr("X")+4+fw3+5
  sb3slider("gMY",globalMoveY,"Y",lx,r3y,fw3,-2,2); lx=lx+measureStr("Y")+4+fw3+5
  sb3slider("gMZ",globalMoveZ,"Z",lx,r3y,fw3,-2,2)

  -- version (bottom-right of row 1)
  local vs=SCRIPT_VERSION
  setColor(0.26,0.26,0.34); drawStr(vs, bx+bw-measureStr(vs)-8, by+8)
end

-- Preset dropdown overlay (drawn on top of everything when open)
local function drawPresetDropdown(bx,by,bw)
  if not ui.preset_open then return end
  local pnx_=bx+434; local pnlw_=148; local ddtw_=24
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
  for ix=0,n-1 do for iy=0,n-1 do for iz=0,n-1 do
    local ov={
      name=string.format("C%d%d%d",ix,iy,iz),
      startX=tostring((ix-(n-1)/2)*spacing),
      startY=tostring((iy-(n-1)/2)*spacing),
      startZ=tostring((iz-(n-1)/2)*spacing),
      offsetX="0.02", offsetY="0.01", offsetZ="0.015",
      rate="2", stepCount="64",
      repetitionMode=REP.INFINITE,
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

local function savePreset(name)
  if name=="" then name="MyPreset" end
  storageSave(name.."__count", #instances)
  for i,inst in ipairs(instances) do
    storageSave(name.."__inst"..i, serializeInstance(inst))
  end
  storageSave(name.."__osc_host", osc.host)
  storageSave(name.."__osc_port", osc.port)
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
  statusMsg="Preset loaded: "..name
end

-- ── Preset index (master list of saved preset names) ─────────────────────────

function savePresetIndex()
  storageSave("__preset_index__", table.concat(presetIndex,"\t"))
end

function loadPresetIndex()
  local s=storageLoad("__preset_index__")
  presetIndex={}
  if s and s~="" then
    for name in s:gmatch("[^\t]+") do
      presetIndex[#presetIndex+1]=name
    end
  end
end

function addToPresetIndex(name)
  if name=="" then return end
  for _,n in ipairs(presetIndex) do if n==name then return end end
  presetIndex[#presetIndex+1]=name
  savePresetIndex()
end

function removeFromPresetIndex(name)
  for i,n in ipairs(presetIndex) do
    if n==name then table.remove(presetIndex,i); savePresetIndex(); return end
  end
end

-- ============================================================
-- OSC SYSTEM
-- ============================================================

local OSC_PYTHON = [[
import socket, struct, sys, time
def osc_str(s):
    b=s.encode()+b'\x00';n=4-len(b)%4;return b+b'\x00'*n
def osc_float(f):
    return struct.pack('>f',f)
def osc_int(i):
    return struct.pack('>i',i)
def build(addr,*args):
    msg=osc_str(addr)+osc_str(','+(''.join('i' if isinstance(a,int) else 'f' for a in args)))
    for a in args: msg+=osc_int(a) if isinstance(a,int) else osc_float(a)
    return msg
sock=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
host=sys.argv[1]; port=int(sys.argv[2])
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

local function oscConnect()
  if osc.pipe then pcall(function() osc.pipe:close() end); osc.pipe=nil end
  osc.ok=false; osc.status="Connecting…"
  -- write helper script to temp file
  local tmp=os.tmpname()..".py"
  local f=io.open(tmp,"w"); if not f then osc.status="Tmp write fail"; return end
  f:write(OSC_PYTHON); f:close()
  local cmd=string.format("python3 %s %s %s 2>/dev/null || python %s %s %s 2>/dev/null",
    tmp, osc.host, osc.port, tmp, osc.host, osc.port)
  osc.pipe=io.popen(cmd,"w")
  if osc.pipe then osc.ok=true; osc.status="Connected"; osc.tmp=tmp
  else osc.status="Failed — check Python install" end
end

local function oscDisconnect()
  if osc.pipe then pcall(function() osc.pipe:close() end); osc.pipe=nil end
  osc.ok=false; osc.status="Disconnected"
  if osc.tmp then os.remove(osc.tmp); osc.tmp=nil end
end

-- ============================================================
-- JSFX CONTROLLER  (track named "Kristall Controller")
-- Sliders: 0=Preset Trigger, 1=Smoothing, 2=Glide Time, 3=Rate
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

  -- slider1=Preset, slider2=Rate, slider3=RateMode, slider4=Smoothing, slider5=Glide
  local preset   = math.floor(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 0) + 0.5)
  local rate     = reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 1)
  local rmode    = math.floor(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 2) + 0.5)
  local smooth   = math.floor(reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 3) + 0.5)
  local glide    = reaper.TrackFX_GetParam(ctrl.track, ctrl.fxIdx, 4)

  -- Preset trigger: fire on change away from 0
  if preset ~= ctrl.lastPreset then
    ctrl.lastPreset = preset
    if     preset == 1 then presetCubic(3, 0.4)
    elseif preset == 2 then presetTetragonal(3, 0.3, 0.6)
    elseif preset == 3 then presetHexagonal(2, 0.4)
    elseif preset == 4 then presetRandomSwarm(12, 0.8)
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
end

-- Send all enabled instances as OSC /icst/ambi/sourceindex/aed messages
local function oscSendPreview()
  if not osc.ok or not osc.pipe then return end
  local t=reaper.time_precise()
  if t - osc.last_t < 0.016 then return end   -- ~60 Hz cap
  osc.last_t = t
  for i,inst in ipairs(instances) do
    if inst.enabled then
      -- convert XYZ → AED for OSC (encoder's spherical mapping)
      local x=inst.effectivePos.x; local y=inst.effectivePos.y; local z=inst.effectivePos.z
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
  else
    local inst=instances[selectedIdx]
    local key=ui.focus_key
    if inst and key then
      if type(inst[key])~="boolean" then
        inst[key]=ui.focus_text
      end
    end
  end
  ui.focus_field=nil; ui.focus_key=nil; ui.focus_text=""
end

local WIN_W, WIN_H       -- updated each frame from gfx
local STAT_H = 80  -- row1=28px + row2=26px + row3=26px
local PREV_H_FRAC = 0.45  -- fraction of right column for lattice preview

local function handleInput()
  local mx=gfx.mouse_x; local my=gfx.mouse_y
  local mb=gfx.mouse_cap
  local lmb=(mb&1)==1
  local clicked=(lmb and ui.last_mouse==0)
  ui.last_mouse=lmb and 1 or 0

  WIN_W=gfx.w; WIN_H=gfx.h
  local content_h = WIN_H - STAT_H

  -- ── List panel ─────────────────────────────────────────────
  local list_x=0; local list_y=0; local list_h=content_h

  if hit(mx,my,list_x,list_y,LIST_W,list_h) then
    -- scroll wheel on list
    if gfx.mouse_wheel~=0 then
      ui.LIST_SCROLL=ui.LIST_SCROLL - gfx.mouse_wheel*ROW_H*0.5
      gfx.mouse_wheel=0
    end
    if clicked then
      -- row click
      local visible_start=26; local ry=my-(list_y+visible_start)+ui.LIST_SCROLL
      local row=floor(ry/ROW_H)+1
      if row>=1 and row<=#instances then
        commitFocus()
        selectedIdx=row
        onSelectionChanged()
      end
      -- Add / Rem / Dup buttons
      local by_=list_y+list_h-24; local bw_=floor(LIST_W/3)
      if hit(mx,my,list_x,by_,bw_,20) then
        if #instances<MAX_INSTANCES then addInstance({}); selectedIdx=#instances end
      elseif hit(mx,my,list_x+bw_,by_,bw_,20) then
        if #instances>0 then removeInstance(instances,selectedIdx)
          selectedIdx=clamp(selectedIdx,1,max(1,#instances)) end
      elseif hit(mx,my,list_x+bw_*2,by_,bw_,20) then
        if instances[selectedIdx] and #instances<MAX_INSTANCES then
          local dup=duplicateInstance(instances[selectedIdx])
          table.insert(instances,selectedIdx+1,dup); selectedIdx=selectedIdx+1 end
      end
    end
  end

  -- ── Right column ────────────────────────────────────────────
  local right_x=LIST_W; local right_w=WIN_W-LIST_W
  local prev_h=floor(content_h*PREV_H_FRAC)
  local param_y=prev_h; local param_h=content_h-prev_h

  -- ── Lattice preview drag ─────────────────────────────────────
  local prev_cx=right_x+right_w*0.5; local prev_cy=prev_h*0.55
  local iso_scale=min(right_w,prev_h)*0.17
  local shift_held=(gfx.mouse_cap&8)==8

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
      elseif sd.id=="gMZ" then globalMoveZ=newVal end
    else
      ui.sliderDrag.active=false
    end
  end

  if drag.active then
    if lmb then
      -- update position while dragging
      local inst=instances[drag.instIdx]
      if inst then
        if shift_held then
          -- Z axis: vertical screen movement maps to Z
          local dz=(drag.startMy-my)/iso_scale
          local newZ=clamp(drag.origZ+dz,-2,2)
          inst.startZ=string.format("%.4f",newZ)
          -- also shift currentPos so preview updates
          inst.currentPos.z=newZ; inst.effectivePos.z=newZ
        else
          -- XY plane via inverse iso projection
          local wx,wy=isoUnproject(mx,my,drag.origZ, prev_cx,prev_cy,iso_scale)
          local ox,oy=isoUnproject(drag.startMx,drag.startMy,drag.origZ, prev_cx,prev_cy,iso_scale)
          local newX=clamp(drag.origX+(wx-ox),-2,2)
          local newY=clamp(drag.origY+(wy-oy),-2,2)
          inst.startX=string.format("%.4f",newX)
          inst.startY=string.format("%.4f",newY)
          inst.currentPos.x=newX; inst.effectivePos.x=newX
          inst.currentPos.y=newY; inst.effectivePos.y=newY
        end
      end
    else
      -- mouse released — drag done
      drag.active=false; drag.instIdx=nil
    end
  elseif clicked and hit(mx,my,right_x,0,right_w,prev_h) then
    -- check if click landed on any dot
    for i,inst in ipairs(instances) do
      if inst.enabled then
        local sx,sy=isoProject(inst.effectivePos.x,inst.effectivePos.y,inst.effectivePos.z,
                               prev_cx,prev_cy,iso_scale)
        if (mx-sx)*(mx-sx)+(my-sy)*(my-sy)<=(10*10) then
          commitFocus()
          selectedIdx=i; onSelectionChanged()
          drag.active=true; drag.instIdx=i
          drag.startMx=mx; drag.startMy=my
          drag.origX=tonumber(inst.startX) or 0
          drag.origY=tonumber(inst.startY) or 0
          drag.origZ=tonumber(inst.startZ) or 0
          break
        end
      end
    end
  end

  -- dropdown scroll
  if ui.preset_open and gfx.mouse_wheel~=0 then
    ui.preset_scroll=ui.preset_scroll - gfx.mouse_wheel*ROW_H*0.5
    gfx.mouse_wheel=0
  end

  -- scroll in param panel
  if hit(mx,my,right_x,param_y,right_w,param_h) then
    if gfx.mouse_wheel~=0 then
      ui.right_scroll=ui.right_scroll - gfx.mouse_wheel*ROW_H*0.5
      gfx.mouse_wheel=0
    end
  end

  if clicked then
    local inst=instances[selectedIdx]

    -- ── Parameter fields ───────────────────────────────────────
    for _,f in ipairs(ui.param_fields) do
      if hit(mx,my,f.x,f.y,f.w,f.h) then
        if f.checkbox and f.inst then
          f.inst[f.key]=not f.inst[f.key]
        elseif f.cycle and f.inst and f.options then
          local cur=f.inst[f.key] or 1
          f.inst[f.key]=(cur % #f.options)+1
        else
          commitFocus()
          ui.focus_field=f.id; ui.focus_key=f.key
          ui.focus_text=inst and tostring(inst[f.key] or "") or ""
        end
        break
      end
    end

    -- ── Status bar buttons ─────────────────────────────────────
    local sb_y=content_h
    -- Preset layout constants (must match drawStatusBar)
    local pnx=434; local pnlw=148
    local ddtx=pnx+pnlw+2; local ddtw=24
    local savex=ddtx+ddtw+4
    local resetx=savex+66

    -- Host field
    if hit(mx,my,93,sb_y+4,120,18) then
      commitFocus(); ui.focus_field="osc_host"; ui.focus_text=osc.host
    end
    -- Port field
    if hit(mx,my,258,sb_y+4,52,18) then
      commitFocus(); ui.focus_field="osc_port"; ui.focus_text=osc.port
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
    -- Reset button
    if hit(mx,my,resetx,sb_y+3,62,20) then
      commitFocus(); clearAll(); addInstance({}); selectedIdx=1
      statusMsg="Reset to single instance"
    end

    -- Speed controls — row 2 (matches drawStatusBar row2 coords)
    local r2y=sb_y+28
    local spdx=54; local spdw=58
    local bpmx=spdx+spdw+6; local bpmw=48
    if hit(mx,my,spdx,r2y+2,spdw,18) then
      commitFocus()
      ui.focus_field="globalRate"
      ui.focus_text=""  -- clear so user types a fresh value
    end
    if hit(mx,my,bpmx,r2y+2,bpmw,18) then
      commitFocus()
      rateMode = (rateMode==0) and 1 or 0
      statusMsg = rateMode==1 and "BPM sync ON — 1 step = 1 beat"
                               or "BPM sync OFF — steps/sec"
    end
    -- Global direction toggle
    local dirx_=bpmx+bpmw+6; local dirw_=42
    if hit(mx,my,dirx_,r2y+2,dirw_,18) then
      commitFocus()
      globalDir = globalDir * -1
      statusMsg = globalDir==1 and "Direction: Forward" or "Direction: Reverse"
    end
    -- Pause toggle
    local psx_=dirx_+dirw_+6; local psw_=44
    if hit(mx,my,psx_,r2y+2,psw_,18) then
      commitFocus()
      globalPaused = not globalPaused
      statusMsg = globalPaused and "Paused" or "Playing"
    end
    -- Stop (reset all to step 0)
    local stx_=psx_+psw_+4; local stw_=36
    if hit(mx,my,stx_,r2y+2,stw_,18) then
      commitFocus()
      for _,inst in ipairs(instances) do resetInstance(inst) end
      globalPaused=false
      statusMsg="Stopped — all instances reset"
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
    local lx3=8+28  -- after "Pos" label (bx=0)
    r3sliderHit("gTX","X",lx3,-2,2,0.01); lx3=lx3+measureStr("X")+4+fw3+5
    r3sliderHit("gTY","Y",lx3,-2,2,0.01); lx3=lx3+measureStr("Y")+4+fw3+5
    r3sliderHit("gTZ","Z",lx3,-2,2,0.01); lx3=lx3+measureStr("Z")+4+fw3+16+40
    r3sliderHit("gMX","X",lx3,-2,2,0.01); lx3=lx3+measureStr("X")+4+fw3+5
    r3sliderHit("gMY","Y",lx3,-2,2,0.01); lx3=lx3+measureStr("Y")+4+fw3+5
    r3sliderHit("gMZ","Z",lx3,-2,2,0.01)

    -- Preset quick-select buttons (presets 1-4)
    local presets={"Cubic","Tetragonal","Hexagonal","RandomSwarm"}
    for pi,pname in ipairs(presets) do
      local bx2=right_x+(pi-1)*floor(right_w/4); local by2=sb_y+STAT_H-22
      if hit(mx,my,bx2,by2,floor(right_w/4)-2,18) then
        commitFocus()
        if pname=="Cubic"      then presetCubic(2,1.0)
        elseif pname=="Tetragonal" then presetTetragonal(3,0.8,1.4)
        elseif pname=="Hexagonal"  then presetHexagonal(2,1.2)
        elseif pname=="RandomSwarm"then presetRandomSwarm(20,1.5) end
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
          ui.focus_field=nil; ui.focus_key=nil; ui.focus_text=""
        elseif char==8 or char==127 then  -- Backspace/Del
          ui.focus_text=ui.focus_text:sub(1,-2)
        elseif char>=32 and char<127 then
          ui.focus_text=ui.focus_text..string.char(char)
        end
      else
        -- Global shortcuts
        if char==string.byte('a') or char==string.byte('A') then
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

local function drawPresetBar(bx,by,bw,bh)
  setColor(0.09,0.09,0.13); fillRect(bx,by,bw,bh)
  local names={"1 Cubic","2 Tetra","3 Hex","4 Swarm"}
  local pw=floor(bw/#names)
  for i,n in ipairs(names) do
    local px=bx+(i-1)*pw
    local hot=(ui.hover_preset==i)
    setColor(hot and 0.18 or 0.12, hot and 0.26 or 0.16, hot and 0.42 or 0.24)
    fillRect(px+1,by+1,pw-2,bh-2)
    setColor(0.36,0.83,0.62); drawStr(n, px+6, by+4)
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
  local prev_h=floor(content_h*PREV_H_FRAC)

  -- lattice preview (top of right column)
  drawLatticePreview(right_x, 0, right_w, prev_h)

  -- param panel (bottom of right column)
  drawParamPanel(right_x, prev_h, right_w, content_h-prev_h)

  -- status bar (very bottom)
  drawStatusBar(0, content_h, w, STAT_H)

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

  -- JSFX controller (reads preset trigger + smoothing/glide/rate)
  ctrlPoll(dt)

  -- process all instances
  updateAllInstances(dt)

  -- OSC preview
  if osc.ok then oscSendPreview() end

  -- draw
  drawFrame()

  -- input (returns false on window close)
  local cont=handleInput()

  if cont and gfx.getchar()~=-1 then
    reaper.defer(mainLoop)
  else
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

-- math shims not assigned above
local atan = math.atan2 or math.atan   -- Lua 5.1 uses atan2; 5.3 uses atan(y,x)
local asin = math.asin

-- computeAllInfluences is the exported name used in mainLoop;
-- accumulateInfluences (Section 12) is the implementation.
local computeAllInfluences = accumulateInfluences

-- Re-expose label tables as globals so pCycle (Section 14) can reach them
-- when called before Section 15's explicit assignments. (Section 15 sets the
-- same globals; these are no-op overrides if sec15 ran first.)
REP_LABELS    = REP_LABELS    or {"Infinite","Finite","Pingpong"}
BOUND_LABELS  = BOUND_LABELS  or {"None","Clamp","Wrap","Mirror"}
ROUND_LABELS  = ROUND_LABELS  or {"Nearest","Floor","Ceil"}
FALLOFF_LABELS= FALLOFF_LABELS or {"Linear","InvSq","Gaussian"}

-- Global accessibility patch — mainLoop and oscSendPreview were defined
-- before the local aliases above, so they look these up as globals.
computeAllInfluences = accumulateInfluences
atan = math.atan2 or math.atan
asin = math.asin
