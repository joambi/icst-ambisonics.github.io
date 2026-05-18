-- =============================================================================
-- icst_osc_raumkurven_xyz.lua
-- ICST Ambisonics Workshop 2026
--
-- Schreibt die Raumkurve "02_LinksRechts" direkt als X/Y-Automation
-- in die FX-Parameter des ICST AmbiEncoder_64 auf dem ausgewählten Track.
--
-- Kein LuaSocket / kein OSC-Server nötig – nutzt REAPER's FX-Envelope API.
-- Basiert auf demselben Ansatz wie ICST_Pan_to_AmbiXYZ.lua.
--
-- Verwendung:
--   1. Track auswählen, auf dem der ICST AmbiEncoder_64 als FX läuft
--   2. Script ausführen (Actions → Load ReaScript)
--   3. X/Y-Automationskurven erscheinen direkt im AmbiEncoder
-- =============================================================================


-- ── KONFIGURATION ─────────────────────────────────────────────────────────────

local CONFIG = {
  time_offset   = 0.0,    -- Zeitversatz in Sekunden (alle Punkte verschieben)
  distance      = 0.5,    -- Y-Achse fix (0.0 = hinten, 0.5 = Mitte, 1.0 = vorne)
  shape         = 4,      -- Kurvenform: 0=Linear  2=Smooth  4=Bezier
  tension       = 0.0,    -- Bezier-Tension
  clear_range   = true,   -- Bestehende Punkte im Zeitbereich löschen
  source_idx    = 1,      -- Quellen-Index im AmbiEncoder_64 (1–64)
}

-- AmbiEncoder_64 Parameterstruktur (aus ICST AmbiEncoder_64 Spiral Walk.lua):
--   Erste Quelle beginnt bei 0-basiertem Index 10, jede Quelle belegt 5 Params:
--   base + 0 = X, base + 1 = Y, base + 2 = Z, base + 3 = ..., base + 4 = ...
--   → Quelle 1: X=10, Y=11, Z=12  (0-basiert) = REAPER zeigt 11, 12, 13
local AMBI_FIRST_PARAM = 10   -- 0-basierter Index des ersten X-Parameters
local AMBI_BLOCK_SIZE  =  5   -- Parameterblock pro Quelle


-- ── RAUMKURVEN-DATENPUNKTE ────────────────────────────────────────────────────
--
-- Exemplarische Links-Rechts-Traversierung (60 Sekunden):
--   Start Mitte → ganz Rechts → Mitte → ganz Links
--
-- x = sin(azimuth):  -1.0 = ganz links, 0.0 = Mitte, +1.0 = ganz rechts
-- Im AmbiEncoder wird x umgerechnet: (x + 1) / 2  →  0.0 … 1.0
-- ─────────────────────────────────────────────────────────────────────────────
local pan_data = {
  { t =  0.0, x =  0.000 },   --   0°  MITTE (Start)          ──
  { t = 10.0, x =  0.643 },   -- +40°  rechts                 ►
  { t = 20.0, x =  1.000 },   -- +90°  GANZ RECHTS            ►►
  { t = 30.0, x =  0.000 },   --   0°  MITTE (Durchgang)      ──
  { t = 40.0, x = -0.643 },   -- −40°  links                  ◄
  { t = 52.5, x = -0.940 },   -- −70°  fast GANZ LINKS        ◄◄
  { t = 60.0, x = -1.000 },   -- −90°  GANZ LINKS (Ende)      ◄◄
}


-- =============================================================================
-- Hilfsfunktionen (analog ICST_Pan_to_AmbiXYZ.lua)
-- =============================================================================

-- AmbiEncoder_64 FX-Index auf dem Track finden (sucht nach Name "AmbiEncoder")
local function findAmbiEncoderFX(track)
  local nfx = reaper.TrackFX_GetCount(track)
  for fi = 0, nfx - 1 do
    local _, fname = reaper.TrackFX_GetFXName(track, fi, "")
    if fname:lower():find("ambiencoder", 1, true) or
       fname:lower():find("ambi encoder", 1, true) then
      return fi, fname
    end
  end
  return nil
end

-- FX-Parameter-Envelope anhand von 0-basiertem Parameterindex holen
local function getFXParamEnv(track, fxIdx, paramIdx)
  local _, pname = reaper.TrackFX_GetParamName(track, fxIdx, paramIdx, "")
  local env = reaper.GetFXEnvelope(track, fxIdx, paramIdx, true)
  return env, pname
end

-- Envelope-Punkte in Zeitbereich löschen und neue schreiben
local function writeEnvelope(env, tArr, vArr, shape, tension)
  if #tArr == 0 then return end
  if CONFIG.clear_range then
    local t0 = tArr[1]  - 0.05
    local t1 = tArr[#tArr] + 0.05
    reaper.DeleteEnvelopePointRange(env, t0, t1)
  end
  for i = 1, #tArr do
    reaper.InsertEnvelopePoint(env, tArr[i], vArr[i], shape, tension, false, true)
  end
  reaper.Envelope_SortPoints(env)
end

-- Pan-Wert → AmbiEncoder XY
--   AmbiEncoder X-Achse (L-R): Parameterbereich 0.0–1.0 (0=links, 0.5=Mitte, 1=rechts)
--   AmbiEncoder Y-Achse (F-B): konstant = distance (Quelle bleibt vorne)
local function pan_to_xy(panVal, dist)
  local ambiX = (panVal + 1.0) * 0.5     -- [-1..+1] → [0..1]: 0=links, 0.5=Mitte, 1=rechts
  local ambiY = dist                      -- F-B: konstant vorne, kein Tiefenwechsel
  return ambiX, ambiY
end


-- =============================================================================
-- Hauptprogramm
-- =============================================================================

local track = reaper.GetSelectedTrack(0, 0)
if not track then
  reaper.ShowMessageBox(
    "Bitte zuerst den Track auswählen,\nauf dem der ICST AmbiEncoder_64 läuft.",
    "Kein Track ausgewählt", 0)
  return
end

local _, track_name = reaper.GetTrackName(track)

-- AmbiEncoder_64 FX auf dem Track finden
local fxIdx, fxName = findAmbiEncoderFX(track)
if not fxIdx then
  reaper.ShowMessageBox(
    "ICST AmbiEncoder_64 nicht gefunden auf Track:\n" .. track_name ..
    "\n\nBitte sicherstellen:\n" ..
    "  • AmbiEncoder_64 ist als FX auf diesem Track geladen\n" ..
    "  • Der Track ist ausgewählt",
    "AmbiEncoder nicht gefunden", 0)
  return
end

-- Parameter-Indizes für die gewählte Quelle berechnen (0-basiert)
local src   = CONFIG.source_idx
local base  = AMBI_FIRST_PARAM + (src - 1) * AMBI_BLOCK_SIZE
local piX   = base      -- X  (REAPER zeigt: base+1)
local piY   = base + 1  -- Y
local envX, nameX = getFXParamEnv(track, fxIdx, piX)
local envY, nameY = getFXParamEnv(track, fxIdx, piY)

if not envX or not envY then
  reaper.ShowMessageBox(
    string.format("Parameter %d/%d nicht gefunden.\n(%s)", piX+1, piY+1, fxName),
    "Parameter fehlt", 0)
  return
end

-- Datenpunkte → XY-Arrays aufbauen
-- ambiX_arr = L-R Pan-Werte [-1..+1] → umgerechnet auf [0..1] für AmbiEncoder X
-- ambiY_arr = konstant vorne          → AmbiEncoder Y-Achse (Vorne-Hinten)
local tArr, ambiX_arr, ambiY_arr = {}, {}, {}
for i, p in ipairs(pan_data) do
  local t = p.t + CONFIG.time_offset
  local ambiX, ambiY = pan_to_xy(p.x, CONFIG.distance)
  tArr[i]      = t
  ambiX_arr[i] = ambiX   -- L-R → X
  ambiY_arr[i] = ambiY   -- F-B → Y (konstant)
end

-- In FX-Envelopes schreiben
reaper.Undo_BeginBlock()

writeEnvelope(envX, tArr, ambiX_arr, CONFIG.shape, CONFIG.tension)  -- L-R → X-Param
writeEnvelope(envY, tArr, ambiY_arr, CONFIG.shape, CONFIG.tension)  -- F-B → Y-Param

reaper.UpdateArrange()
reaper.Undo_EndBlock("ICST Raumkurven → AmbiEncoder XY", -1)

-- Bestätigung
local t_start = tArr[1]
local t_end   = tArr[#tArr]
reaper.ShowMessageBox(
  string.format(
    "✓  %d XY-Punkte geschrieben\n\n" ..
    "Track:       %s\n" ..
    "Plugin:      %s\n" ..
    "Quelle:      %d  (Params %d / %d)\n" ..
    "Parameter:   %s\n             %s\n" ..
    "Zeitbereich: %.1f s – %.1f s",
    #tArr,
    track_name,
    fxName,
    src, piX+1, piY+1,
    (nameX or "x"), (nameY or "y"),
    t_start, t_end
  ),
  "ICST Raumkurven → AmbiEncoder XY", 0)
