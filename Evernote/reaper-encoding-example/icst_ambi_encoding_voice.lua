-- ============================================================
-- ICST Ambisonics Encoding Example
-- Exercise: Quelle in Ambisonics-Raum setzen
-- Stimme auf Azimut -45°, Elevation 20°
--
-- Voraussetzung: ICST Ambisonics Plugins installiert
-- Institut für Computermusik und Klangtechnologie (ICST)
-- Zürcher Hochschule der Künste (ZHdK)
-- ============================================================

-- ---- Hilfsfunktion ----------------------------------------
-- Normiert einen physikalischen Wert auf den [0, 1]-Bereich
-- den Reaper intern für FX-Parameter verwendet
local function normalize(value, min_val, max_val)
  return (value - min_val) / (max_val - min_val)
end

-- ---- Quellposition definieren ----------------------------
-- Koordinaten-Konvention ICST AmbiEncoder:
--   Azimut:    0° = vorne, +90° = links, -90° = rechts
--   Elevation: 0° = Horizontalebene, +90° = Zenit
--   Distanz:   0.0 = Zentrum, 1.0 = Lautsprecher-Radius

local SOURCE_NAME  = "Voice"
local AZIMUT       = -45.0   -- rechts-vorne
local ELEVATION    =  20.0   -- leicht über der Horizontalebene
local DISTANZ      =   1.0   -- auf dem Lautsprecher-Radius

-- ---- Script beginnt --------------------------------------
reaper.Undo_BeginBlock()

-- (1) Track anlegen
reaper.InsertTrackAtIndex(0, true)
local track = reaper.GetTrack(0, 0)

-- Track benennen
reaper.GetSetMediaTrackInfo_String(track, "P_NAME", SOURCE_NAME, true)

-- Track auf Mono (1 Kanal) — Stimme ist eine Punktquelle
reaper.SetMediaTrackInfo_Value(track, "I_NCHAN", 1)

-- (2) ICST AmbiEncoder einfügen
--     Falls der Name nicht passt: FX-Browser öffnen und genauen Namen prüfen
local PLUGIN_NAME = "ICST Ambisonics Encoder"

local fx_idx = reaper.TrackFX_AddByName(track, PLUGIN_NAME, false, -1)

if fx_idx < 0 then
  reaper.ShowMessageBox(
    "Plugin nicht gefunden: \"" .. PLUGIN_NAME .. "\"\n\n" ..
    "Bitte sicherstellen dass die ICST Ambisonics Plugins\n" ..
    "installiert sind, und den genauen Namen im FX-Browser prüfen.",
    "Fehler", 0
  )
  reaper.Undo_EndBlock("ICST Encoding – Fehler", -1)
  return
end

-- (3) Parameter normieren
--     Reaper erwartet alle FX-Parameter als normierte Float-Werte [0.0, 1.0]
--
--     ICST AmbiEncoder Parameter (Source 1):
--       Index 0 → Azimut    (physikalisch: -180° bis +180°)
--       Index 1 → Elevation (physikalisch:  -90° bis  +90°)
--       Index 2 → Distanz   (physikalisch:   0.0 bis   1.0)

local az_norm = normalize(AZIMUT,     -180.0,  180.0)  -- -45° → 0.375
local el_norm = normalize(ELEVATION,   -90.0,   90.0)  -- +20° → 0.611
local di_norm = normalize(DISTANZ,       0.0,    1.0)  --  1.0 → 1.0

-- (4) Parameter setzen
reaper.TrackFX_SetParam(track, fx_idx, 0, az_norm)   -- Azimut
reaper.TrackFX_SetParam(track, fx_idx, 1, el_norm)   -- Elevation
reaper.TrackFX_SetParam(track, fx_idx, 2, di_norm)   -- Distanz

-- (5) Plugin-Fenster öffnen (zur visuellen Kontrolle)
reaper.TrackFX_Show(track, fx_idx, 3)  -- 3 = Floating Window

-- (6) Äquivalenter OSC-Befehl (zur Information)
local osc_cmd = string.format(
  "/icst/ambi/source/aed '%s' %.1f %.1f %.1f",
  SOURCE_NAME, AZIMUT, ELEVATION, DISTANZ
)

reaper.ShowMessageBox(
  "✓  Track \"" .. SOURCE_NAME .. "\" erstellt\n\n" ..
  string.format("   Azimut:    %6.1f°  →  norm %.3f\n", AZIMUT,     az_norm) ..
  string.format("   Elevation: %6.1f°  →  norm %.3f\n", ELEVATION,  el_norm) ..
  string.format("   Distanz:   %6.1f   →  norm %.3f\n\n", DISTANZ,  di_norm) ..
  "Äquivalenter OSC-Befehl (Port 50001):\n" ..
  osc_cmd,
  "ICST AmbiEncoder – Encoding gesetzt", 0
)

reaper.Undo_EndBlock("ICST Ambi Encoding: Voice Azimut -45° Elev 20°", -1)
reaper.UpdateArrange()
reaper.TrackList_AdjustWindows(false)
