-- ICST AmbiEncoder_64: Punkte in Kreis anordnen
-- Autor: Dein Reaper Assistent

local track = reaper.GetSelectedTrack(0,0)
if not track then
  reaper.ShowMessageBox("Bitte einen Track mit AmbiEncoder_64 auswählen!", "Fehler", 0)
  return
end

local fx = reaper.TrackFX_AddByName(track, "AmbiEncoder_64", false, 0)
if fx < 0 then
  reaper.ShowMessageBox("Kein AmbiEncoder_64 im Track gefunden!", "Fehler", 0)
  return
end

-- === Einstellungen ===
local pointCount = 64      -- Anzahl Punkte
local radius = 0.5         -- Radius des Kreises (-1..1 Bereich)
local startAngle = 0       -- Startwinkel in Radiant
local clockwise = true     -- Drehrichtung

-- === Funktionen ===
local function setParam(idx, value)
  local norm = math.max(0, math.min(1, (value + 1) / 2))
  reaper.TrackFX_SetParam(track, fx, idx, norm)
end

-- === Kreis berechnen ===
for i = 1, pointCount do
  local angle = startAngle + (i-1) * (2 * math.pi / pointCount)
  if clockwise then angle = -angle end
  local x = math.cos(angle) * radius
  local y = math.sin(angle) * radius
  local z = 0.0
  local base = (i-1)*5
  setParam(10+base, x)
  setParam(11+base, y)
  setParam(12+base, z)
end

reaper.ShowMessageBox("Kreis-Offsets für "..pointCount.." Punkte mit Radius "..radius.." gesetzt!","Fertig",0)


