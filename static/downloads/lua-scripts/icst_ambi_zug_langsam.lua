-- ================================================================
-- ICST AmbiEncoder_64 — Langsam vorbeifahrender Zug
-- Animiert Parameter 11 (Azimut), 12 (Elevation), 13 (Distanz)
-- als Automation-Envelopes ab der aktuellen Cursor-Position.
--
-- Physikalisches Modell:
--   Der Zug fährt auf einer geraden Strecke an einem festen
--   Punkt vorbei. Azimut und Distanz werden aus der x/y-Position
--   des Zuges berechnet (Physik-basiert, nicht linear).
--
-- Institut für Computermusik und Klangtechnologie (ICST)
-- Zürcher Hochschule der Künste (ZHdK)
-- ================================================================

-- ============================================================
-- KONFIGURATION — hier anpassen
-- ============================================================
local CFG = {
  -- Parameter-Indizes im ICST AmbiEncoder_64 (0-basiert)
  PARAM_AZIMUT    = 11,  -- Azimut    (-180° bis +180°)
  PARAM_ELEVATION = 12,  -- Elevation ( -90° bis  +90°)
  PARAM_DISTANZ   = 13,  -- Distanz   (  0.0 bis   1.0)

  -- Paramater-Ranges des Plugins (für Normierung)
  AZ_MIN = -180,  AZ_MAX = 180,
  EL_MIN =  -90,  EL_MAX =  90,
  DI_MIN =   0,   DI_MAX =  1,

  -- Zugbewegung
  DAUER_SEK   = 30.0,  -- Dauer der Passage in Sekunden
  N_PUNKTE    = 120,   -- Anzahl Automation-Punkte (mehr = glatter)

  -- Richtung: true = rechts→links, false = links→rechts
  RECHTS_NACH_LINKS = true,

  -- Geometrie (normiert, 1.0 = Lautsprecher-Radius)
  SPUR_ABSTAND  = 0.30,  -- Abstand der Zugstrecke vom Hörer (y-Achse)
  SPUR_BREITE   = 1.40,  -- Gesamtbreite der Passage (x-Achse, ±Hälfte)

  -- Distanz-Mapping: wie nah kommt der Zug maximal/minimal?
  DISTANZ_NAH  = 0.20,  -- Distanzwert wenn direkt vorne (Normiert)
  DISTANZ_FERN = 0.90,  -- Distanzwert an den Rändern der Passage (Normiert)

  -- Elevation: leichte Neigung beim Vorbeifahren (Grad)
  ELEVATION_OFFSET = 0.0,   -- Grundelevation
  ELEVATION_KURVE  = 0.0,   -- maximale Abweichung durch Schrägheit der Strecke
                             -- (0 = exakt horizontal)
  -- FX-Index des AmbiEncoders auf dem Track (0-basiert)
  FX_INDEX = 0,
}
-- ============================================================

-- ---- Hilfsfunktionen ----------------------------------------

local function normalize(value, min_val, max_val)
  return (value - min_val) / (max_val - min_val)
end

local function clamp(v, lo, hi)
  if v < lo then return lo end
  if v > hi then return hi end
  return v
end

-- Berechnet Azimut (Grad), Elevation (Grad) und normierte Distanz
-- für einen Zug auf einer geraden horizontalen Strecke.
-- t: normierter Zeitwert [0, 1]
local function zugPosition(t)
  -- Horizontale Position entlang der Zugstrecke
  -- x = -halb_breite … +halb_breite (linear)
  local halb = CFG.SPUR_BREITE * 0.5
  local x    -- Linkswärts-Komponente (+ = links, - = rechts in ICST)
  if CFG.RECHTS_NACH_LINKS then
    x = -halb + CFG.SPUR_BREITE * t   -- von rechts (-) nach links (+)
  else
    x =  halb - CFG.SPUR_BREITE * t   -- von links (+) nach rechts (-)
  end
  local y = CFG.SPUR_ABSTAND  -- konstanter Abstand nach vorne

  -- Azimut: atan2(x_links, y_vorne) — ICST Konvention
  --   0° = vorne, +90° = links, -90° = rechts
  local azimut = math.deg(math.atan(x, y))

  -- Distanz: Euklidischer Abstand, auf [NAH, FERN] skaliert
  local d_roh     = math.sqrt(x * x + y * y)
  local d_max_roh = math.sqrt(halb * halb + y * y)
  local d_min_roh = y  -- nächster Punkt = direkt vorne
  local d_norm    = (d_roh - d_min_roh) / (d_max_roh - d_min_roh)
  -- d_norm ist jetzt 0.0 (nächster Punkt) … 1.0 (Randpunkt)
  local distanz = CFG.DISTANZ_NAH + (CFG.DISTANZ_FERN - CFG.DISTANZ_NAH) * d_norm

  -- Elevation: horizontal mit optionaler leichter Kurve
  -- (simuliert leichte Schräglage der Strecke oder Kopfhöhe)
  local elevation = CFG.ELEVATION_OFFSET
    + CFG.ELEVATION_KURVE * math.sin(math.pi * t)

  return azimut, elevation, clamp(distanz, 0, 1)
end

-- ---- Hauptprogramm ------------------------------------------

-- Aktiven Track holen
local track = reaper.GetSelectedTrack(0, 0)
if not track then
  reaper.ShowMessageBox(
    "Bitte zuerst den Track mit dem ICST AmbiEncoder_64 auswählen!",
    "Kein Track ausgewählt", 0
  )
  return
end

-- Prüfen ob FX-Slot existiert
local fx_count = reaper.TrackFX_GetCount(track)
if CFG.FX_INDEX >= fx_count then
  reaper.ShowMessageBox(
    string.format("Kein Plugin auf FX-Index %d gefunden.\n" ..
                  "Bitte CFG.FX_INDEX anpassen (aktuell: %d, verfügbar: 0–%d).",
                  CFG.FX_INDEX, CFG.FX_INDEX, fx_count - 1),
    "FX nicht gefunden", 0
  )
  return
end

-- Startzeit = Cursor-Position
local start_time = reaper.GetCursorPosition()

-- Envelopes holen (erstellen falls nicht vorhanden)
local env_az   = reaper.GetFXEnvelope(track, CFG.FX_INDEX, CFG.PARAM_AZIMUT,    true)
local env_el   = reaper.GetFXEnvelope(track, CFG.FX_INDEX, CFG.PARAM_ELEVATION, true)
local env_dist = reaper.GetFXEnvelope(track, CFG.FX_INDEX, CFG.PARAM_DISTANZ,   true)

if not env_az or not env_el or not env_dist then
  reaper.ShowMessageBox(
    "Konnte keine Automation-Envelopes erstellen.\n" ..
    "Bitte prüfen ob die Parameter-Indizes korrekt sind\n" ..
    string.format("(Param %d, %d, %d).", CFG.PARAM_AZIMUT, CFG.PARAM_ELEVATION, CFG.PARAM_DISTANZ),
    "Envelope-Fehler", 0
  )
  return
end

-- Bestehende Punkte im Zeitbereich löschen
local end_time = start_time + CFG.DAUER_SEK
reaper.DeleteEnvelopePointRange(env_az,   start_time - 0.01, end_time + 0.01)
reaper.DeleteEnvelopePointRange(env_el,   start_time - 0.01, end_time + 0.01)
reaper.DeleteEnvelopePointRange(env_dist, start_time - 0.01, end_time + 0.01)

reaper.Undo_BeginBlock()

-- Automation-Punkte einfügen
-- shape 0 = linear (viele Punkte → sehr glatt)
for i = 0, CFG.N_PUNKTE do
  local t      = i / CFG.N_PUNKTE
  local zeit   = start_time + t * CFG.DAUER_SEK
  local no_sort = (i < CFG.N_PUNKTE)  -- erst beim letzten Punkt sortieren

  local az, el, dist = zugPosition(t)

  local az_n   = normalize(az,   CFG.AZ_MIN, CFG.AZ_MAX)
  local el_n   = normalize(el,   CFG.EL_MIN, CFG.EL_MAX)
  local dist_n = normalize(dist, CFG.DI_MIN, CFG.DI_MAX)

  reaper.InsertEnvelopePoint(env_az,   zeit, clamp(az_n,   0, 1), 0, 0, false, no_sort)
  reaper.InsertEnvelopePoint(env_el,   zeit, clamp(el_n,   0, 1), 0, 0, false, no_sort)
  reaper.InsertEnvelopePoint(env_dist, zeit, clamp(dist_n, 0, 1), 0, 0, false, no_sort)
end

-- Sortieren und aktualisieren
reaper.Envelope_SortPoints(env_az)
reaper.Envelope_SortPoints(env_el)
reaper.Envelope_SortPoints(env_dist)

reaper.Undo_EndBlock(
  string.format("ICST Ambi: Langsamer Zug %.0fs (Param %d/%d/%d)",
    CFG.DAUER_SEK, CFG.PARAM_AZIMUT, CFG.PARAM_ELEVATION, CFG.PARAM_DISTANZ), -1
)

reaper.UpdateArrange()

-- Ergebnis melden
local az_start, el_start, dist_start = zugPosition(0)
local az_mid,   el_mid,   dist_mid   = zugPosition(0.5)
local az_end,   el_end,   dist_end   = zugPosition(1.0)

reaper.ShowMessageBox(
  string.format(
    "✓ Langsamer Zug — Automation erstellt\n\n" ..
    "  Dauer:      %.0f Sekunden\n" ..
    "  Startzeit:  %.2f s\n" ..
    "  Punkte:     %d\n\n" ..
    "  Positionen (Azimut / Distanz):\n" ..
    "    Start:  %5.1f°  /  %.2f\n" ..
    "    Mitte:  %5.1f°  /  %.2f\n" ..
    "    Ende:   %5.1f°  /  %.2f\n\n" ..
    "  Params: %d (Az), %d (El), %d (Dist)\n" ..
    "  FX-Index: %d",
    CFG.DAUER_SEK, start_time, CFG.N_PUNKTE + 1,
    az_start, dist_start,
    az_mid,   dist_mid,
    az_end,   dist_end,
    CFG.PARAM_AZIMUT, CFG.PARAM_ELEVATION, CFG.PARAM_DISTANZ,
    CFG.FX_INDEX
  ),
  "Langsamer Zug — Fertig", 0
)
