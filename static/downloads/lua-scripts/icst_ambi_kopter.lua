-- ================================================================
-- ICST Ambisonics — Helikopter Überflug
-- Erstellt physik-basierte 3D-Automation auf dem ausgewählten Track.
--
-- Trajektorie:
--   Der Helikopter fliegt in gerader Linie von vorne nach hinten
--   in fester Höhe über den Hörpunkt. Azimut, Elevation und
--   Distanz werden aus der 3D-Position berechnet (kein Fake-Panning).
--
--   Phase 1 (Annäherung): Elevation steigt, Azimut ~0° (vorne)
--   Phase 2 (Overhead):   Elevation max, Azimut dreht 0°→180°
--   Phase 3 (Abflug):     Elevation sinkt, Azimut ~180° (hinten)
--
-- Reaper-Parameter (ICST AmbiEncoder_64):
--   Param 11 (Index 10) = Azimut   [0..1] → [−180°..+180°]
--   Param 12 (Index 11) = Elevation [0..1] → [−90°..+90°]
--   Param 13 (Index 12) = Distanz  [0..1] → [nah..fern]
--
-- Verwendung:
--   1. Track mit ICST AmbiEncoder_64 als erstem FX auswählen
--   2. Script via Actions → Load ReaScript ausführen
--
-- Institut für Computermusik und Klangtechnologie (ICST)
-- Zürcher Hochschule der Künste (ZHdK)
-- ================================================================

-- ============================================================
-- KONFIGURATION
-- ============================================================
local CFG = {
  -- Trajektorie (alle Werte in Metern, Koordinatensystem: Listener = 0/0/0)
  START_Y       =  30.0,   -- Startposition vorne  (positiv = vorne)
  END_Y         = -30.0,   -- Endposition hinten   (negativ = hinten)
  LATERAL       =   2.0,   -- Seitlicher Versatz (0 = genau über Listener)
  HOEHE         =   8.0,   -- Flughöhe über Listener (m) — typisch 8–15 m

  -- Distanz-Normierung (Extremwerte → 0.0 / 1.0 im Plugin)
  DISTANZ_NAH   =   8.0,   -- Nächste Distanz (m) = 0.0
  DISTANZ_FERN  =  35.0,   -- Weiteste Distanz (m) = 1.0

  -- Zeitliche Parameter
  DAUER_SEK     =  18.0,   -- Gesamtdauer des Überflugs in Sekunden
  START_TIME    =   1.0,   -- Startzeit im Projekt (Sekunden)
  PUNKTE        = 360,     -- Automation-Auflösung (mehr = glattere Kurve)
}

-- ============================================================
-- HILFSFUNKTIONEN
-- ============================================================

-- Normiert val auf [0,1] bezogen auf [min_val, max_val], mit Clamp
local function normalize(val, min_val, max_val)
  local clamped = math.max(min_val, math.min(max_val, val))
  return (clamped - min_val) / (max_val - min_val)
end

-- Sucht AmbiEncoder auf dem Track (partieller Name-Match)
local function find_ambi_encoder(track)
  for i = 0, reaper.TrackFX_GetCount(track) - 1 do
    local _, name = reaper.TrackFX_GetFXName(track, i, "")
    if name:lower():find("ambiencoder") or name:lower():find("ambi encoder") then
      return i
    end
  end
  return -1
end

-- ============================================================
-- HAUPTPROGRAMM
-- ============================================================

-- (1) Track prüfen
local track = reaper.GetSelectedTrack(0, 0)
if not track then
  reaper.ShowMessageBox(
    "Bitte zuerst den Track mit dem ICST AmbiEncoder auswählen.",
    "Kein Track ausgewählt", 0)
  return
end

local _, track_name = reaper.GetTrackName(track, "")

-- (2) AmbiEncoder finden
local fx_idx = find_ambi_encoder(track)
if fx_idx < 0 then
  reaper.ShowMessageBox(
    "Kein ICST AmbiEncoder auf Track «" .. track_name .. "» gefunden.\n\n" ..
    "Bitte AmbiEncoder_64 als erstes FX auf den Track laden.",
    "Plugin nicht gefunden", 0)
  return
end

-- (3) Parameter-Envelopes holen (true = anlegen falls nicht vorhanden)
--     Param 11 → Index 10 (Azimut)
--     Param 12 → Index 11 (Elevation)
--     Param 13 → Index 12 (Distanz)
local env_az   = reaper.GetFXEnvelope(track, fx_idx, 10, true)
local env_el   = reaper.GetFXEnvelope(track, fx_idx, 11, true)
local env_dist = reaper.GetFXEnvelope(track, fx_idx, 12, true)

if not env_az or not env_el or not env_dist then
  reaper.ShowMessageBox(
    "Envelopes konnten nicht angelegt werden.\n" ..
    "Bitte sicherstellen, dass der AmbiEncoder korrekt geladen ist.",
    "Envelope-Fehler", 0)
  return
end

-- (4) Alten Zeitbereich leeren
local t_end_total = CFG.START_TIME + CFG.DAUER_SEK + 2
reaper.DeleteEnvelopePointRange(env_az,   0, t_end_total)
reaper.DeleteEnvelopePointRange(env_el,   0, t_end_total)
reaper.DeleteEnvelopePointRange(env_dist, 0, t_end_total)

-- (5) Automation-Punkte berechnen und einfügen
reaper.Undo_BeginBlock()

for i = 0, CFG.PUNKTE do
  local t_norm = i / CFG.PUNKTE
  local t_sek  = CFG.START_TIME + t_norm * CFG.DAUER_SEK

  -- 3D-Position des Helikopters
  local y = CFG.START_Y + t_norm * (CFG.END_Y - CFG.START_Y)  -- vorne → hinten
  local x = CFG.LATERAL                                          -- seitlicher Versatz
  local z = CFG.HOEHE                                           -- Höhe (konstant)

  -- Azimut: horizontaler Winkel im Uhrzeigersinn (atan2 von x/y)
  local az_rad = math.atan(x, y)
  local az_deg = math.deg(az_rad)
  local az_norm = normalize(az_deg, -180, 180)

  -- Elevation: Winkel nach oben (atan2 von z / horizontale Distanz)
  local horiz_dist = math.sqrt(x * x + y * y)
  local el_rad  = math.atan(z, horiz_dist)
  local el_deg  = math.deg(el_rad)
  local el_norm = normalize(el_deg, -90, 90)

  -- 3D-Distanz (Pythagoras)
  local dist_3d   = math.sqrt(x * x + y * y + z * z)
  local dist_norm = normalize(dist_3d, CFG.DISTANZ_NAH, CFG.DISTANZ_FERN)

  -- Punkte einfügen (shape 0 = linear)
  reaper.InsertEnvelopePoint(env_az,   t_sek, az_norm,   0, 0, false, false)
  reaper.InsertEnvelopePoint(env_el,   t_sek, el_norm,   0, 0, false, false)
  reaper.InsertEnvelopePoint(env_dist, t_sek, dist_norm, 0, 0, false, false)
end

-- (6) Envelopes sortieren und UI aktualisieren
reaper.Envelope_SortPoints(env_az)
reaper.Envelope_SortPoints(env_el)
reaper.Envelope_SortPoints(env_dist)

reaper.Undo_EndBlock(
  "ICST: Helikopter-Überflug auf «" .. track_name .. "»", -1)
reaper.UpdateArrange()

-- (7) Ergebnis-Meldung
reaper.ShowMessageBox(
  string.format(
    "✓  Helikopter-Überflug Automation gesetzt\n\n" ..
    "  Track:       %s\n" ..
    "  FX-Index:    %d\n" ..
    "  Dauer:       %.1f s  (%.0f Punkte)\n\n" ..
    "  Trajektorie:\n" ..
    "  ┌──────────────────────────────────────┐\n" ..
    "  │  Start:    Y = +%.0f m (vorne)       │\n" ..
    "  │  Ende:     Y = −%.0f m (hinten)      │\n" ..
    "  │  Höhe:     Z = +%.0f m               │\n" ..
    "  │  Lateral:  X = %.1f m               │\n" ..
    "  └──────────────────────────────────────┘\n\n" ..
    "  Elevation:   max. %.0f° (direkt overhead)\n" ..
    "  Distanz:     %.0f – %.0f m",
    track_name, fx_idx,
    CFG.DAUER_SEK, CFG.PUNKTE,
    CFG.START_Y, math.abs(CFG.END_Y),
    CFG.HOEHE, CFG.LATERAL,
    math.deg(math.atan(CFG.HOEHE, math.abs(CFG.LATERAL))),
    math.sqrt(CFG.LATERAL^2 + CFG.HOEHE^2),
    math.sqrt(CFG.LATERAL^2 + CFG.HOEHE^2 + CFG.START_Y^2)
  ),
  "Helikopter — Fertig", 0
)
