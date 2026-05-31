-- ================================================================
-- ICST AmbiEncoder_64 — Zug-Vergleich: Langsam + Schnell
-- Schreibt BEIDE Zugbewegungen hintereinander ab Cursor-Position:
--   [Pause] → [Langsamer Zug 30s] → [Pause] → [Schnellzug 4s]
--
-- Nützlich für direkten Hörvergleich ohne Script-Wechsel.
-- Parameter 11 (Azimut), 12 (Elevation), 13 (Distanz)
--
-- Institut für Computermusik und Klangtechnologie (ICST)
-- Zürcher Hochschule der Künste (ZHdK)
-- ================================================================

local CFG = {
  PARAM_AZIMUT    = 11,
  PARAM_ELEVATION = 12,
  PARAM_DISTANZ   = 13,
  AZ_MIN = -180,  AZ_MAX = 180,
  EL_MIN =  -90,  EL_MAX =  90,
  FX_INDEX = 0,

  PAUSE_ANFANG     = 3.0,   -- Sekunden Stille vor dem langsamen Zug
  PAUSE_ZWISCHEN   = 5.0,   -- Sekunden Stille zwischen den Zügen
  PAUSE_ENDE       = 2.0,   -- Sekunden Stille nach dem Schnellzug

  -- Langsamer Zug
  LANGSAM = {
    DAUER_SEK      = 28.0,
    N_PUNKTE       = 120,
    SPUR_ABSTAND   = 0.30,
    SPUR_BREITE    = 1.40,
    DISTANZ_NAH    = 0.22,
    DISTANZ_FERN   = 0.88,
    ELEVATION_OFF  = 0.0,
    DISTANZ_EXP    = 1.0,   -- linear (sanfte Kurve)
    R_NACH_L       = true,
  },

  -- Schnellzug
  SCHNELL = {
    DAUER_SEK      = 4.0,
    N_PUNKTE       = 200,
    SPUR_ABSTAND   = 0.18,
    SPUR_BREITE    = 1.60,
    DISTANZ_NAH    = 0.08,
    DISTANZ_FERN   = 0.85,
    ELEVATION_OFF  = 0.0,
    ELEVATION_KURVE = 2.0,
    DISTANZ_EXP    = 1.8,   -- exponentiell (steile Kurve)
    R_NACH_L       = true,
  },
}

-- ---- Hilfsfunktionen ----------------------------------------

local function normalize(v, mn, mx)  return (v - mn) / (mx - mn) end
local function clamp(v, lo, hi)
  if v < lo then return lo end
  if v > hi then return hi end
  return v
end

local function zugPosition(t, c)
  local halb = c.SPUR_BREITE * 0.5
  local x = c.R_NACH_L and (-halb + c.SPUR_BREITE * t)
                        or  ( halb - c.SPUR_BREITE * t)
  local y = c.SPUR_ABSTAND

  local azimut = math.deg(math.atan(x, y))

  local d_roh     = math.sqrt(x*x + y*y)
  local d_max_roh = math.sqrt(halb*halb + y*y)
  local d_min_roh = y
  local d_n_roh   = clamp((d_roh - d_min_roh) / (d_max_roh - d_min_roh), 0, 1)
  local d_kurve   = math.pow(d_n_roh, 1.0 / c.DISTANZ_EXP)
  local distanz   = c.DISTANZ_NAH + (c.DISTANZ_FERN - c.DISTANZ_NAH) * d_kurve

  local elevation = (c.ELEVATION_OFF or 0)
  if c.ELEVATION_KURVE then
    elevation = elevation + c.ELEVATION_KURVE * math.exp(-20 * (t - 0.5)^2)
  end

  return azimut, elevation, clamp(distanz, 0, 1)
end

local function schreibeZugEnvelopes(env_az, env_el, env_dist, start_t, c)
  local end_t = start_t + c.DAUER_SEK
  reaper.DeleteEnvelopePointRange(env_az,   start_t - 0.01, end_t + 0.01)
  reaper.DeleteEnvelopePointRange(env_el,   start_t - 0.01, end_t + 0.01)
  reaper.DeleteEnvelopePointRange(env_dist, start_t - 0.01, end_t + 0.01)

  for i = 0, c.N_PUNKTE do
    local t       = i / c.N_PUNKTE
    local zeit    = start_t + t * c.DAUER_SEK
    local no_sort = (i < c.N_PUNKTE)
    local az, el, dist = zugPosition(t, c)

    local az_n   = clamp(normalize(az,   CFG.AZ_MIN, CFG.AZ_MAX), 0, 1)
    local el_n   = clamp(normalize(el,   CFG.EL_MIN, CFG.EL_MAX), 0, 1)
    local dist_n = clamp(dist, 0, 1)

    reaper.InsertEnvelopePoint(env_az,   zeit, az_n,   0, 0, false, no_sort)
    reaper.InsertEnvelopePoint(env_el,   zeit, el_n,   0, 0, false, no_sort)
    reaper.InsertEnvelopePoint(env_dist, zeit, dist_n, 0, 0, false, no_sort)
  end
end

-- ---- Hauptprogramm ------------------------------------------

local track = reaper.GetSelectedTrack(0, 0)
if not track then
  reaper.ShowMessageBox("Bitte Track auswählen!", "Kein Track", 0)
  return
end

local fx_count = reaper.TrackFX_GetCount(track)
if CFG.FX_INDEX >= fx_count then
  reaper.ShowMessageBox(
    string.format("Kein FX auf Index %d (0–%d verfügbar).", CFG.FX_INDEX, fx_count-1),
    "FX nicht gefunden", 0
  )
  return
end

local env_az   = reaper.GetFXEnvelope(track, CFG.FX_INDEX, CFG.PARAM_AZIMUT,    true)
local env_el   = reaper.GetFXEnvelope(track, CFG.FX_INDEX, CFG.PARAM_ELEVATION, true)
local env_dist = reaper.GetFXEnvelope(track, CFG.FX_INDEX, CFG.PARAM_DISTANZ,   true)

if not env_az or not env_el or not env_dist then
  reaper.ShowMessageBox("Envelopes konnten nicht erstellt werden.", "Fehler", 0)
  return
end

reaper.Undo_BeginBlock()

local cursor    = reaper.GetCursorPosition()
local t_langsam = cursor + CFG.PAUSE_ANFANG
local t_schnell = t_langsam + CFG.LANGSAM.DAUER_SEK + CFG.PAUSE_ZWISCHEN

-- Langsamen Zug schreiben
schreibeZugEnvelopes(env_az, env_el, env_dist, t_langsam, CFG.LANGSAM)

-- Schnellzug schreiben
schreibeZugEnvelopes(env_az, env_el, env_dist, t_schnell, CFG.SCHNELL)

-- Sortieren
reaper.Envelope_SortPoints(env_az)
reaper.Envelope_SortPoints(env_el)
reaper.Envelope_SortPoints(env_dist)

reaper.Undo_EndBlock("ICST Ambi: Zug-Vergleich (Langsam + Schnell)", -1)
reaper.UpdateArrange()

local total = CFG.PAUSE_ANFANG + CFG.LANGSAM.DAUER_SEK
           + CFG.PAUSE_ZWISCHEN + CFG.SCHNELL.DAUER_SEK + CFG.PAUSE_ENDE

reaper.ShowMessageBox(
  string.format(
    "✓ Zug-Vergleich erstellt\n\n" ..
    "  Zeitplan:\n" ..
    "  %.1f s   Pause (Ruhe)\n" ..
    "  %.1f s   Langsamer Zug (%.0f s)\n" ..
    "  %.1f s   Pause (Ruhe)\n" ..
    "  %.1f s   Schnellzug    (%.1f s)\n" ..
    "  %.1f s   Ende\n\n" ..
    "  Gesamtdauer: %.1f s",
    cursor,
    t_langsam, CFG.LANGSAM.DAUER_SEK,
    t_langsam + CFG.LANGSAM.DAUER_SEK,
    t_schnell, CFG.SCHNELL.DAUER_SEK,
    t_schnell + CFG.SCHNELL.DAUER_SEK,
    total
  ),
  "Zug-Vergleich — Fertig", 0
)
