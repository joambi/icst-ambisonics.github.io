-- ================================================================
-- FuMa B-Format → AmbiX FOA Konverter
-- Erstellt automatisch ein JSFX-Plugin und lädt es auf den
-- ausgewählten Track. Kein externes Plugin nötig.
--
-- Was dieses Script tut:
--   1. Schreibt ein JSFX-Plugin in den Reaper-Effects-Ordner
--   2. Setzt den Track auf 4 Kanäle (FOA)
--   3. Lädt das JSFX auf den Track
--
-- Konversion:
--   Kanalreihenfolge: FuMa WXYZ → AmbiX WYZX (ACN-Reihenfolge)
--   Normierung:       W × √2 (+3.01 dB), X/Y/Z × 1/√3 (−4.77 dB)
--
-- Institut für Computermusik und Klangtechnologie (ICST)
-- Zürcher Hochschule der Künste (ZHdK)
-- ================================================================

-- ============================================================
-- KONFIGURATION
-- ============================================================
local CFG = {
  -- Unterordner im Reaper-Effects-Verzeichnis
  JSFX_SUBDIR  = "ICST",
  -- Dateiname des JSFX-Plugins
  JSFX_NAME    = "FuMa_to_AmbiX_FOA",
  -- FX-Fenster nach dem Laden öffnen?
  SHOW_FX      = true,
}

-- ============================================================
-- JSFX-PLUGIN INHALT
-- (wird vom Script automatisch in den Effects-Ordner geschrieben)
-- ============================================================
local JSFX_CONTENT = [[
desc:FuMa to AmbiX - FOA Converter (ICST)
tags: ambisonics fuma ambix convert foa b-format

// FuMa (B-Format) -> AmbiX (ACN / SN3D), First Order Ambisonics
//
// Input  (FuMa):  Ch1=W  Ch2=X  Ch3=Y  Ch4=Z
// Output (AmbiX): Ch1=W  Ch2=Y  Ch3=Z  Ch4=X  (ACN 0-3)
//
// Gain: W x sqrt(2) = +3.01 dB | X,Y,Z x 1/sqrt(3) = -4.77 dB

in_pin:W (FuMa Ch1)
in_pin:X (FuMa Ch2)
in_pin:Y (FuMa Ch3)
in_pin:Z (FuMa Ch4)
out_pin:W (AmbiX ACN0)
out_pin:Y (AmbiX ACN1)
out_pin:Z (AmbiX ACN2)
out_pin:X (AmbiX ACN3)

options:no-meter

@init
gain_W   = sqrt(2);
gain_XYZ = 1.0 / sqrt(3);

@sample
tmp_W = spl0;
tmp_X = spl1;
tmp_Y = spl2;
tmp_Z = spl3;
spl0 = tmp_W * gain_W;
spl1 = tmp_Y * gain_XYZ;
spl2 = tmp_Z * gain_XYZ;
spl3 = tmp_X * gain_XYZ;
]]

-- ============================================================
-- HILFSFUNKTIONEN
-- ============================================================

-- Plattform-unabhängiger Pfadtrenner
local SEP = package.config:sub(1, 1)  -- "/" auf macOS/Linux, "\" auf Windows

-- Verzeichnis erstellen (macOS/Linux und Windows)
local function mkdir(path)
  if SEP == "/" then
    os.execute('mkdir -p "' .. path .. '"')
  else
    os.execute('mkdir "' .. path .. '" 2>nul')
  end
end

-- Datei schreiben
local function writeFile(path, content)
  local f = io.open(path, "w")
  if not f then return false end
  f:write(content)
  f:close()
  return true
end

-- Prüfen ob Datei existiert
local function fileExists(path)
  local f = io.open(path, "r")
  if f then f:close(); return true end
  return false
end

-- ============================================================
-- HAUPTPROGRAMM
-- ============================================================

-- (1) Track-Prüfung
local track = reaper.GetSelectedTrack(0, 0)
if not track then
  reaper.ShowMessageBox(
    "Bitte zuerst den Track mit dem FuMa-Signal auswählen!",
    "Kein Track ausgewählt", 0
  )
  return
end

local _, track_name = reaper.GetTrackName(track, "")

-- (2) Pfade bestimmen
local res_path  = reaper.GetResourcePath()
local fx_dir    = res_path .. SEP .. "Effects" .. SEP .. CFG.JSFX_SUBDIR
local fx_file   = fx_dir .. SEP .. CFG.JSFX_NAME .. ".jsfx"
-- Name wie Reaper ihn im FX-Browser sieht:
local fx_reaper = CFG.JSFX_SUBDIR .. "/" .. CFG.JSFX_NAME

-- (3) JSFX-Datei schreiben (überschreibt wenn schon vorhanden)
mkdir(fx_dir)
local ok = writeFile(fx_file, JSFX_CONTENT)
if not ok then
  reaper.ShowMessageBox(
    "Konnte JSFX-Plugin nicht schreiben:\n" .. fx_file ..
    "\n\nBitte prüfen ob der Effects-Ordner beschreibbar ist.",
    "Fehler: Datei nicht schreibbar", 0
  )
  return
end

-- (4) Track auf 4 Kanäle setzen (FOA = 4ch)
reaper.SetMediaTrackInfo_Value(track, "I_NCHAN", 4)

-- (5) JSFX auf Track laden
reaper.Undo_BeginBlock()

-- Zuerst prüfen ob FX bereits vorhanden (kein Duplikat erzeugen)
local existing_idx = reaper.TrackFX_AddByName(track, fx_reaper, false, 0)
-- 0 = nur suchen, nicht hinzufügen; gibt -1 zurück wenn nicht gefunden

local fx_idx
if existing_idx >= 0 then
  -- Bereits vorhanden → verwenden
  fx_idx = existing_idx
  reaper.ShowConsoleMsg("[ICST] FuMa→AmbiX JSFX bereits auf Track, wird aktualisiert.\n")
else
  -- Neu hinzufügen
  fx_idx = reaper.TrackFX_AddByName(track, fx_reaper, false, -1)
end

-- Fallback: mit vollständigem Pfad versuchen
if fx_idx < 0 then
  fx_idx = reaper.TrackFX_AddByName(track, fx_file, false, -1)
end

if fx_idx < 0 then
  reaper.ShowMessageBox(
    "JSFX wurde geschrieben, konnte aber nicht automatisch geladen werden.\n\n" ..
    "Bitte manuell im FX-Browser hinzufügen:\n" ..
    "  JS: " .. fx_reaper .. "\n\n" ..
    "Datei liegt in:\n" .. fx_file,
    "Manuelles Laden nötig", 0
  )
  reaper.Undo_EndBlock("FuMa→AmbiX: JSFX geschrieben", -1)
  return
end

-- (6) FX-Fenster öffnen (optional)
if CFG.SHOW_FX then
  reaper.TrackFX_Show(track, fx_idx, 3)  -- 3 = Floating Window
end

reaper.Undo_EndBlock(
  "ICST: FuMa → AmbiX FOA Konverter installiert auf \"" .. track_name .. "\"", -1
)
reaper.UpdateArrange()

-- (7) Ergebnis-Meldung
reaper.ShowMessageBox(
  string.format(
    "✓  FuMa → AmbiX Konverter installiert\n\n" ..
    "  Track:      %s\n" ..
    "  Kanäle:     4 (FOA)\n" ..
    "  FX-Index:   %d\n" ..
    "  JSFX-Datei: %s/%s.jsfx\n\n" ..
    "  Kanalkonversion:\n" ..
    "  ┌──────────┬────────────────┬─────────────┐\n" ..
    "  │ FuMa In  │  AmbiX Out     │    Gain     │\n" ..
    "  ├──────────┼────────────────┼─────────────┤\n" ..
    "  │ Ch1 = W  │  Ch1 = W (ACN0)│  +3.01 dB   │\n" ..
    "  │ Ch3 = Y  │  Ch2 = Y (ACN1)│  −4.77 dB   │\n" ..
    "  │ Ch4 = Z  │  Ch3 = Z (ACN2)│  −4.77 dB   │\n" ..
    "  │ Ch2 = X  │  Ch4 = X (ACN3)│  −4.77 dB   │\n" ..
    "  └──────────┴────────────────┴─────────────┘",
    track_name, fx_idx,
    CFG.JSFX_SUBDIR, CFG.JSFX_NAME
  ),
  "FuMa → AmbiX — Fertig", 0
)
