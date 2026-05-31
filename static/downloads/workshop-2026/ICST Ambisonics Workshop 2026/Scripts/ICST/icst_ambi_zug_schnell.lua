-- ================================================================
-- ICST AmbiEncoder_64 — Schnellzug (ICE / Hochgeschwindigkeit)
-- Animiert Parameter 11 (Azimut), 12 (Elevation), 13 (Distanz)
-- als Automation-Envelopes ab der aktuellen Cursor-Position.
--
-- Physikalisches Modell:
--   Ein Schnellzug passiert in wenigen Sekunden. Die Bewegung
--   ist dieselbe Physik wie beim langsamen Zug, aber:
--   · stark komprimierte Zeitachse (3–6 Sekunden)
--   · näher am Hörer (dramatischerer Effekt)
--   · steilere Distanzkurve (schroffer Anstieg/Abfall)
--   · extremerer Azimut-Sweep (fast ±90°)
--
-- Für Doppler-Effekt: Pitch-Automation auf dem Source-Track
--   hinzufügen (fällt beim Vorbeifahren, proportional zu d_norm).
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

  -- Paramater-Ranges des Plugins
  AZ_MIN = -180,  AZ_MAX = 180,
  EL_MIN =  -90,  EL_MAX =  90,
  DI_MIN =   0,   DI_MAX =  1,

  -- Zugbewegung
  DAUER_SEK   = 4.0,   -- Dauer der Passage (Sekunden) — Schnellzug: 3–8 s
  N_PUNKTE    = 200,   -- Viele Punkte für präzise schnelle Kurve

  -- Richtung: true = rechts→links, false = links→rechts
  RECHTS_NACH_LINKS = true,

  -- Geometrie (normiert, 1.0 = Lautsprecher-Radius)
  SPUR_ABSTAND  = 0.18,  -- Schnellzug fährt NÄHER am Hörer vorbei
  SPUR_BREITE   = 1.60,  -- breiter Sweep (extremerer Azimut-Effekt)

  -- Distanz-Mapping: extremere Werte als beim langsamen Zug
  DISTANZ_NAH  = 0.08,  -- sehr nah am nächsten Punkt (dramatisch)
  DISTANZ_FERN = 0.85,  -- fern an den Rändern

  -- Elevation: minimal — Schnellzug auf Bodenhöhe
  ELEVATION_OFFSET = 0.0,   -- exakt auf Horizontalebene
  ELEVATION_KURVE  = 2.0,   -- leichte Elevation-Spitze beim nächsten Punkt
                             -- (simuliert den Luftdruck/Wirbeleffekt)

  -- Exponent für die Distanzkurve (>1 = spitzer, schroffer Effekt)
  -- 1.0 = lineare Interpolation, 2.0 = quadratisch (schroffer Abfall)
  DISTANZ_EXPONENT = 1.8,

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

-- Exponentielle Gewichtung der Distanzkurve:
-- d_norm_roh = 0 (vorne) … 1 (Rand)
-- exponent > 1 macht den Übergang nah/fern steiler
local function distanzKurve(d_norm_roh, exponent)
  return math.pow(d_norm_roh, 1.0 / exponent)
end

-- Berechnet Position für den Schnellzug.
-- t: normierter Zeitwert [0, 1]
local function zugPosition(t)
  local halb = CFG.SPUR_BREITE * 0.5
  local x
  if CFG.RECHTS_NACH_LINKS then
    x = -halb + CFG.SPUR_BREITE * t
  else
    x =  halb - CFG.SPUR_BREITE * t
  end
  local y = CFG.SPUR_ABSTAND

  -- Azimut (ICST: 0° vorne, +90° links, -90° rechts)
  local azimut = math.deg(math.atan(x, y))

  -- Distanz: physikalisch berechnet, mit Exponent-Kurve
  local d_roh     = math.sqrt(x * x + y * y)
  local d_max_roh = math.sqrt(halb * halb + y * y)
  local d_min_roh = y
  local d_norm_roh = (d_roh - d_min_roh) / (d_max_roh - d_min_roh)
  -- Exponent-Kurve: macht den Übergang am nächsten Punkt steiler
  local d_kurve = distanzKurve(clamp(d_norm_roh, 0, 1), CFG.DISTANZ_EXPONENT)
  local distanz = CFG.DISTANZ_NAH + (CFG.DISTANZ_FERN - CFG.DISTANZ_NAH) * d_kurve

  -- Elevation: leichte Spitze genau beim Vorbeifahren (t ≈ 0.5)
  -- Gauss-ähnliche Kurve: Maximum bei t=0.5
  local el_kurve = math.exp(-20 * (t - 0.5)^2)  -- schmal, nur kurz erhöht
  local elevation = CFG.ELEVATION_OFFSET + CFG.ELEVATION_KURVE * el_kurve

  return azimut, elevation, clamp(distanz, 0, 1)
end

-- ---- Hauptprogramm ------------------------------------------

local track = reaper.GetSelectedTrack(0, 0)
if not track then
  reaper.ShowMessageBox(
    "Bitte zuerst den Track mit dem ICST AmbiEncoder_64 auswählen!",
    "Kein Track ausgewählt", 0
  )
  return
end

local fx_count = reaper.TrackFX_GetCount(track)
if CFG.FX_INDEX >= fx_count then
  reaper.ShowMessageBox(
    string.format("Kein Plugin auf FX-Index %d.\nVerfügbar: 0–%d",
                  CFG.FX_INDEX, fx_count - 1),
    "FX nicht gefunden", 0
  )
  return
end

local start_time = reaper.GetCursorPosition()
local end_time   = start_time + CFG.DAUER_SEK

-- Envelopes holen / erstellen
local env_az   = reaper.GetFXEnvelope(track, CFG.FX_INDEX, CFG.PARAM_AZIMUT,    true)
local env_el   = reaper.GetFXEnvelope(track, CFG.FX_INDEX, CFG.PARAM_ELEVATION, true)
local env_dist = reaper.GetFXEnvelope(track, CFG.FX_INDEX, CFG.PARAM_DISTANZ,   true)

if not env_az or not env_el or not env_dist then
  reaper.ShowMessageBox(
    "Konnte keine Automation-Envelopes erstellen.\n" ..
    string.format("Parameter-Indizes: %d, %d, %d",
                  CFG.PARAM_AZIMUT, CFG.PARAM_ELEVATION, CFG.PARAM_DISTANZ),
    "Envelope-Fehler", 0
  )
  return
end

reaper.DeleteEnvelopePointRange(env_az,   start_time - 0.01, end_time + 0.01)
reaper.DeleteEnvelopePointRange(env_el,   start_time - 0.01, end_time + 0.01)
reaper.DeleteEnvelopePointRange(env_dist, start_time - 0.01, end_time + 0.01)

reaper.Undo_BeginBlock()

-- Automation-Punkte einfügen
for i = 0, CFG.N_PUNKTE do
  local t       = i / CFG.N_PUNKTE
  local zeit    = start_time + t * CFG.DAUER_SEK
  local no_sort = (i < CFG.N_PUNKTE)

  local az, el, dist = zugPosition(t)

  local az_n   = clamp(normalize(az,   CFG.AZ_MIN, CFG.AZ_MAX), 0, 1)
  local el_n   = clamp(normalize(el,   CFG.EL_MIN, CFG.EL_MAX), 0, 1)
  local dist_n = clamp(normalize(dist, CFG.DI_MIN, CFG.DI_MAX), 0, 1)

  reaper.InsertEnvelopePoint(env_az,   zeit, az_n,   0, 0, false, no_sort)
  reaper.InsertEnvelopePoint(env_el,   zeit, el_n,   0, 0, false, no_sort)
  reaper.InsertEnvelopePoint(env_dist, zeit, dist_n, 0, 0, false, no_sort)
end

reaper.Envelope_SortPoints(env_az)
reaper.Envelope_SortPoints(env_el)
reaper.Envelope_SortPoints(env_dist)

reaper.Undo_EndBlock(
  string.format("ICST Ambi: Schnellzug %.1fs (Param %d/%d/%d)",
    CFG.DAUER_SEK, CFG.PARAM_AZIMUT, CFG.PARAM_ELEVATION, CFG.PARAM_DISTANZ), -1
)

reaper.UpdateArrange()

-- ---- Doppler-Hinweis ----------------------------------------
-- Berechne maximale Azimut-Rate für Info
local az_mitte_t0, _, _ = zugPosition(0.49)
local az_mitte_t1, _, _ = zugPosition(0.51)
local sweep_rate = math.abs(az_mitte_t1 - az_mitte_t0) / (0.02 * CFG.DAUER_SEK)

reaper.ShowMessageBox(
  string.format(
    "✓ Schnellzug — Automation erstellt\n\n" ..
    "  Dauer:          %.1f Sekunden\n" ..
    "  Startzeit:      %.2f s\n" ..
    "  Punkte:         %d\n" ..
    "  Max. Sweep:     ~%.0f°/s (in der Mitte)\n\n" ..
    "  Positionen (Azimut / Distanz):\n" ..
    "    Start:   %5.1f°  /  %.2f\n" ..
    "    Mitte:   %5.1f°  /  %.2f\n" ..
    "    Ende:    %5.1f°  /  %.2f\n\n" ..
    "  Distanz-Exponent: %.1f (steile Kurve)\n" ..
    "  Params: %d (Az), %d (El), %d (Dist)\n\n" ..
    "  Tipp: Doppler-Effekt → Pitch-Automation\n" ..
    "  auf dem Source-Track: leichter Absturz\n" ..
    "  zwischen Start und Ende der Passage.",
    CFG.DAUER_SEK, start_time, CFG.N_PUNKTE + 1, sweep_rate,
    (function() local a,_,_ = zugPosition(0.0)  return a end)(),
    (function() local _,_,d = zugPosition(0.0)  return d end)(),
    (function() local a,_,_ = zugPosition(0.5)  return a end)(),
    (function() local _,_,d = zugPosition(0.5)  return d end)(),
    (function() local a,_,_ = zugPosition(1.0)  return a end)(),
    (function() local _,_,d = zugPosition(1.0)  return d end)(),
    CFG.DISTANZ_EXPONENT,
    CFG.PARAM_AZIMUT, CFG.PARAM_ELEVATION, CFG.PARAM_DISTANZ
  ),
  "Schnellzug — Fertig", 0
)
