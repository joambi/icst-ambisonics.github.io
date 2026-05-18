-- =============================================================================
-- icst_stereo_pan_raumkurven.lua
-- ICST Ambisonics Workshop 2026
--
-- Fügt Stereo-Pan-Automation auf dem ausgewählten REAPER-Track ein.
-- Datenbasis: Azimut-Werte aus ICST Raumkurven → x = sin(azimuth)
-- Pan-Skala: -1.0 = 100% links, 0.0 = Mitte, +1.0 = 100% rechts
--
-- Verwendung:
--   1. Track auswählen
--   2. Script via Actions-Liste ausführen
--      (Actions → Load ReaScript → diese Datei)
-- =============================================================================


-- ── KONFIGURATION ─────────────────────────────────────────────────────────────

local CONFIG = {
  time_offset  = 0.0,   -- Zeitversatz in Sekunden (alle Punkte verschieben)
  clear_range  = true,  -- Existierende Pan-Punkte im Zeitbereich löschen
  shape        = 4,     -- Kurvenform: 0=Linear  2=Smooth(S-Kurve)  4=Bezier
  tension      = 0.0,   -- Bezier-Tension (-1 bis +1, 0 = neutral)
  show_confirm = true,  -- Bestätigungsdialog nach dem Einfügen zeigen
}


-- ── PAN-DATENPUNKTE ───────────────────────────────────────────────────────────
--
-- Format:  { t = Zeit(s), x = Pan-Wert }
--   x = sin(azimuth):  -1 = ganz links, 0 = Mitte, +1 = ganz rechts
--
-- Exemplarische Links-Rechts-Traversierung (60 Sekunden):
--   Start Mitte → ganz Links → Mitte → ganz Rechts
-- ─────────────────────────────────────────────────────────────────────────────
local pan_data = {
  { t =  0.0, x =  0.000 },   --   0°  MITTE (Start)          ──
  { t = 10.0, x = -0.643 },   -- −40°  links                  ◄
  { t = 20.0, x = -1.000 },   -- −90°  GANZ LINKS             ◄◄
  { t = 30.0, x =  0.000 },   --   0°  MITTE (Durchgang)      ──
  { t = 40.0, x =  0.643 },   -- +40°  rechts                 ►
  { t = 52.5, x =  0.940 },   -- +70°  fast GANZ RECHTS       ►►
  { t = 60.0, x =  1.000 },   -- +90°  GANZ RECHTS (Ende)     ►►
}

-- ┌──────────────────────────────────────────────────────────────────────────┐
-- │ ALTERNATIV: Parametrische Sine-Kurve generieren (auskommentiert)        │
-- │                                                                          │
-- │ Statt obiger Datenpunkte: exakte Sinuswelle mit konfigurierbaren        │
-- │ Parametern. Einkommentieren und pan_data oben ersetzen.                 │
-- │                                                                          │
-- │ local pan_data = {}                                                      │
-- │ local amplitude  = 1.0     -- maximale Auslenkung (0–1)                 │
-- │ local period     = 20.0    -- Sekunden pro Periode                      │
-- │ local t_start    = 32.0    -- Startzeit in Sekunden                     │
-- │ local t_end      = 54.0    -- Endzeit in Sekunden                       │
-- │ local steps      = 24      -- Anzahl Datenpunkte                        │
-- │ local phase_rad  = math.rad(-50)  -- Startphase (passend zur Quelle)   │
-- │                                                                          │
-- │ local step_size = (t_end - t_start) / (steps - 1)                      │
-- │ for i = 0, steps - 1 do                                                 │
-- │   local t   = t_start + i * step_size                                   │
-- │   local phi = phase_rad + (2 * math.pi / period) * (t - t_start)       │
-- │   table.insert(pan_data, { t = t, x = amplitude * math.sin(phi) })     │
-- │ end                                                                      │
-- └──────────────────────────────────────────────────────────────────────────┘


-- =============================================================================
-- Hauptprogramm (nicht verändern)
-- =============================================================================

local function main()

  -- Track prüfen
  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox(
      "Bitte zuerst einen Track auswählen\nund dann das Script erneut ausführen.",
      "Kein Track ausgewählt", 0)
    return
  end

  local _, track_name = reaper.GetTrackName(track)

  -- Pan-Envelope sichtbar machen und holen
  reaper.SetMediaTrackInfo_Value(track, "B_PANENVATT", 1)
  local env = reaper.GetTrackEnvelopeByName(track, "Pan")
  if not env then
    reaper.ShowMessageBox(
      "Pan-Envelope auf Track '" .. track_name .. "' nicht gefunden.\n" ..
      "Bitte REAPER 6 oder neuer verwenden.",
      "Fehler", 0)
    return
  end

  -- Zeitbereich der Datenpunkte (mit Versatz)
  local t_first = pan_data[1].t          + CONFIG.time_offset
  local t_last  = pan_data[#pan_data].t  + CONFIG.time_offset

  -- Existierende Punkte im Zeitbereich löschen
  if CONFIG.clear_range then
    reaper.DeleteEnvelopePointRange(env, t_first - 0.05, t_last + 0.05)
  end

  -- Automationspunkte einfügen
  reaper.Undo_BeginBlock()

  for _, p in ipairs(pan_data) do
    reaper.InsertEnvelopePoint(
      env,
      p.t + CONFIG.time_offset,  -- Zeit (s)
      p.x,                        -- Pan: -1=links  0=Mitte  +1=rechts
      CONFIG.shape,               -- Kurvenform
      CONFIG.tension,             -- Tension
      false,                      -- selektiert: nein
      true                        -- noSort: ja (am Ende sortieren)
    )
  end

  reaper.Envelope_SortPoints(env)
  reaper.UpdateArrange()
  reaper.UpdateTimeline()

  reaper.Undo_EndBlock("ICST Stereo Pan Automation", -1)

  -- Bestätigung
  if CONFIG.show_confirm then
    local lines = {
      string.format("✓  %d Pan-Punkte eingefügt", #pan_data),
      "",
      string.format("Track:       %s", track_name),
      string.format("Zeitbereich: %.1f s – %.1f s", t_first, t_last),
      string.format("Kurvenform:  %s",
        ({[0]="Linear",[1]="Stepped",[2]="Smooth",[3]="Fast S/E",
          [4]="Bezier",[5]="Fast Start",[6]="Fast End"})[CONFIG.shape]
        or tostring(CONFIG.shape)),
    }
    reaper.ShowMessageBox(table.concat(lines, "\n"), "ICST Pan Automation", 0)
  end

end

main()
