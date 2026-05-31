-- Copied from workshop bundle for convenient installation with the toolbar.
-- Original source:
-- /Volumes/T7_Audio/2026_ICST_Ambisonics_Workshop/REAPER_Scripts/ICST_Pan_to_AmbiXYZ.lua

local PI = math.pi
local PAN_ANGLE_RANGE = PI / 2
local RESOLUTION_SEC = 0.05

local PARAM_SEARCH = {
  x = { "param_x", " x ", "^x$", "pos_x", "posx" },
  y = { "param_y", " y ", "^y$", "pos_y", "posy" },
  z = { "param_z", " z ", "^z$", "pos_z", "posz" },
}

local function findFXEnv(track, searchList)
  local nfx = reaper.TrackFX_GetCount(track)
  for fi = 0, nfx - 1 do
    local np = reaper.TrackFX_GetNumParams(track, fi)
    for pi = 0, np - 1 do
      local _, pname = reaper.TrackFX_GetParamName(track, fi, pi, "")
      local pnl = pname:lower()
      for _, pat in ipairs(searchList) do
        if pnl == pat:lower() or pnl:find(pat:lower(), 1, true) then
          return reaper.GetFXEnvelope(track, fi, pi, true)
        end
      end
    end
  end
  return nil
end

local function getEnvTimeRange(env)
  local tMin, tMax = math.huge, -math.huge
  local np = reaper.CountEnvelopePoints(env)
  for i = 0, np - 1 do
    local ok, t = reaper.GetEnvelopePoint(env, i)
    if ok then
      tMin = math.min(tMin, t)
      tMax = math.max(tMax, t)
    end
  end
  local nai = reaper.CountAutomationItems(env)
  for i = 0, nai - 1 do
    local pos = reaper.GetSetAutomationItemInfo(env, i, "D_POSITION", 0, false)
    local len = reaper.GetSetAutomationItemInfo(env, i, "D_LENGTH", 0, false)
    tMin = math.min(tMin, pos)
    tMax = math.max(tMax, pos + len)
  end
  if tMin == math.huge then
    return nil, nil
  end
  return tMin, tMax
end

local function writeEnvelope(env, tArr, vArr)
  if #tArr == 0 then
    return
  end
  local t0 = tArr[1] - 0.001
  local t1 = tArr[#tArr] + 0.001
  reaper.DeleteEnvelopePointRange(env, t0, t1)
  for i = 1, #tArr do
    reaper.InsertEnvelopePoint(env, tArr[i], vArr[i], 0, 0, false, true)
  end
  reaper.Envelope_SortPoints(env)
end

local function clamp(v, lo, hi)
  return math.max(lo, math.min(hi, v))
end

local track = reaper.GetSelectedTrack(0, 0)
if not track then
  reaper.ShowMessageBox("Kein Track selektiert.", "ICST Pan -> AmbiXYZ", 0)
  return
end

local panEnv = reaper.GetTrackEnvelopeByName(track, "Pan")
if not panEnv then
  reaper.ShowMessageBox("Kein Pan-Envelope gefunden.", "ICST Pan -> AmbiXYZ", 0)
  return
end

local tStart, tEnd = getEnvTimeRange(panEnv)
if not tStart then
  reaper.ShowMessageBox("Pan-Envelope enthaelt keine Punkte.", "ICST Pan -> AmbiXYZ", 0)
  return
end

local envX = findFXEnv(track, PARAM_SEARCH.x)
local envY = findFXEnv(track, PARAM_SEARCH.y)
local envZ = findFXEnv(track, PARAM_SEARCH.z)

if not envX or not envY then
  reaper.ShowMessageBox("X/Y-Parameter im AmbiEncoder nicht gefunden.", "ICST Pan -> AmbiXYZ", 0)
  return
end

local tArr, xArr, yArr, zArr = {}, {}, {}, {}
local t = tStart
local idx = 1
while t <= tEnd + RESOLUTION_SEC * 0.5 do
  local _, panVal = reaper.Envelope_Evaluate(panEnv, t, 44100, 1)
  panVal = clamp(panVal, -1.0, 1.0)
  local azimuth = panVal * PAN_ANGLE_RANGE
  tArr[idx] = t
  xArr[idx] = math.sin(azimuth)
  yArr[idx] = math.cos(azimuth)
  zArr[idx] = 0.0
  idx = idx + 1
  t = t + RESOLUTION_SEC
end

reaper.Undo_BeginBlock()
writeEnvelope(envX, tArr, xArr)
writeEnvelope(envY, tArr, yArr)
if envZ then
  writeEnvelope(envZ, tArr, zArr)
end
reaper.Undo_EndBlock("ICST: Pan -> AmbiEncoder XYZ", -1)

reaper.ShowMessageBox("Pan-Automation wurde auf X/Y/Z uebertragen.", "ICST Pan -> AmbiXYZ", 0)
