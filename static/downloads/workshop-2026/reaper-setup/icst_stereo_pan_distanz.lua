-- =============================================================================
-- icst_stereo_pan_distanz.lua
-- ICST Ambisonics Workshop 2026
--
-- Fügt Stereo-Pan- UND Volumen-Automation ein (Distanzsimulation).
-- Je weiter die Quelle nach Links/Rechts wandert, desto leiser wird sie —
-- analog zur Pegeldifferenz bei seitlichen Positionen im Ambisonics-Feld.
--
-- Pan-Skala:    -1.0 = 100% links,  0.0 = Mitte,  +1.0 = 100% rechts
-- Volumen:       1.0 = 0 dB (Mitte = lauteste Position), nimmt mit |pan| ab
--
-- Bewegung: Mitte → Rechts → Mitte → Links  (kongruent zum AmbiEncoder-Beispiel)
--
-- Verwendung:
--   1. Track auswählen
--   2. Script via Actions-Liste ausführen
--      (Actions → Load ReaScript → diese Datei)
-- =============================================================================


-- ── KONFIGURATION ─────────────────────────────────────────────────────────────

local CONFIG = {
  time_offset   = 0.0,   -- Zeitversatz in Sekunden (alle Punkte verschieben)
  clear_range   = true,  -- Existierende Punkte im Zeitbereich löschen
  shape         = 4,     -- Kurvenform: 0=Linear  2=Smooth  4=Bezier
  tension       = 0.0,   -- Bezier-Tension (-1 bis +1, 0 = neutral)
  show_confirm  = true,  -- Bestätigungsdialog nach dem Einfügen zeigen

  -- Distanzsimulation mit Normierung auf 0 dB Peak:
  --   Mitte  →  0 dB  (lautester Punkt, unity gain)
  --   Seiten → negative dB-Werte (leiser, weiter entfernt)
  -- Werte: center_db = lautester Punkt, side_db = Pegel an den Seiten
  center_db  =  0.0,   -- dB in der Mitte (Peak = exakt 0 dB)
  side_db    = -11.0,  -- dB an den Seiten
}


-- ── PAN-DATENPUNKTE ───────────────────────────────────────────────────────────
--
-- Exemplarische Traversierung (60 Sekunden):
--   Start Mitte → ganz Rechts → Mitte → ganz Links
--   (kongruent zum AmbiEncoder XYZ-Beispiel)
--
--   x = sin(azimuth):  -1 = ganz links, 0 = Mitte, +1 = ganz rechts
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
-- Hilfsfunktionen
-- =============================================================================

-- REAPER Volume-Envelope: lineare Amplitude (0.0 = -∞/INF → NICHT verwenden!)
--   1.0   =  0 dB  (unity, lautester Punkt)
--   0.282 = -11 dB (leiser an den Seiten)
--
-- Formel: interpoliert zwischen side_db (Seiten) und center_db (Mitte)
--   pan = 0.0  → center_db (  0 dB) → linear 1.0
--   pan = ±1.0 → side_db   (-11 dB) → linear 0.282
local function pan_to_vol(panVal)
  local db = CONFIG.side_db + (CONFIG.center_db - CONFIG.side_db) * (1.0 - math.abs(panVal))
  return 10.0 ^ (db / 20.0)
end

local function to_volume_envelope_raw(env, amplitude)
  local mode = reaper.GetEnvelopeScalingMode(env)
  return reaper.ScaleToEnvelopeMode(mode, amplitude)
end

local function insert_envelope_point(env, time, value)
  reaper.InsertEnvelopePoint(env, time, value, CONFIG.shape, CONFIG.tension, false, true)
end

-- Volume-Envelope suchen (Name kann je nach REAPER-Lokalisierung abweichen)
local function findVolumeEnvelope(track)
  local n = reaper.CountTrackEnvelopes(track)
  for i = 0, n - 1 do
    local env = reaper.GetTrackEnvelope(track, i)
    local _, name = reaper.GetEnvelopeName(env, "")
    local nl = name:lower()
    if nl == "volume" or nl == "lautstärke" or nl:find("vol") then
      return env, name
    end
  end
  return nil, nil
end

local function findPanEnvelope(track)
  local n = reaper.CountTrackEnvelopes(track)
  for i = 0, n - 1 do
    local env = reaper.GetTrackEnvelope(track, i)
    local _, name = reaper.GetEnvelopeName(env, "")
    local nl = name:lower()
    if nl == "pan" or nl == "balance" or nl == "panorama" or nl:find("pan") then
      return env, name
    end
  end
  return nil, nil
end


-- =============================================================================
-- Hauptprogramm
-- =============================================================================

local function main()

  local track = reaper.GetSelectedTrack(0, 0)
  if not track then
    reaper.ShowMessageBox(
      "Bitte zuerst einen Track auswählen\nund dann das Script erneut ausführen.",
      "Kein Track ausgewählt", 0)
    return
  end

  local _, track_name = reaper.GetTrackName(track)

  -- Pan-Envelope
  reaper.SetMediaTrackInfo_Value(track, "B_PANENVATT", 1)
  local env_pan, pan_name = findPanEnvelope(track)
  if not env_pan then
    reaper.ShowMessageBox(
      "Pan-Envelope auf Track '" .. track_name .. "' nicht gefunden.",
      "Fehler", 0)
    return
  end

  -- Volume-Envelope (robust: erst per Name, dann per Iteration)
  reaper.SetMediaTrackInfo_Value(track, "B_VOLENVATT", 1)
  local env_vol, vol_name = findVolumeEnvelope(track)
  if not env_vol then
    reaper.ShowMessageBox(
      "Volumen-Envelope auf Track '" .. track_name .. "' nicht gefunden.\n\n" ..
      "Verfügbare Envelopes:\n" .. (function()
        local s = ""
        for i = 0, reaper.CountTrackEnvelopes(track) - 1 do
          local e = reaper.GetTrackEnvelope(track, i)
          local _, nm = reaper.GetEnvelopeName(e, "")
          s = s .. "  • " .. nm .. "\n"
        end
        return s
      end)(),
      "Fehler", 0)
    return
  end

  -- Zeitbereich
  local t_first = pan_data[1].t         + CONFIG.time_offset
  local t_last  = pan_data[#pan_data].t + CONFIG.time_offset

  reaper.Undo_BeginBlock()

  -- Bestehende Punkte löschen
  if CONFIG.clear_range then
    reaper.DeleteEnvelopePointRange(env_pan, t_first - 0.05, t_last + 0.05)
    reaper.DeleteEnvelopePointRange(env_vol, t_first - 0.05, t_last + 0.05)
  end

  for _, p in ipairs(pan_data) do
    local t = p.t + CONFIG.time_offset
    local vol_amp = pan_to_vol(p.x)
    local vol_raw = to_volume_envelope_raw(env_vol, vol_amp)

    insert_envelope_point(env_pan, t, p.x)
    insert_envelope_point(env_vol, t, vol_raw)
  end

  reaper.Envelope_SortPoints(env_pan)
  reaper.Envelope_SortPoints(env_vol)
  reaper.UpdateArrange()
  reaper.UpdateTimeline()

  reaper.Undo_EndBlock("ICST Stereo Pan + Distanz Automation", -1)

  -- Bestätigung
  if CONFIG.show_confirm then
    local lines = {
      string.format("✓  %d Pan- + Volumen-Punkte geschrieben", #pan_data),
      "",
      string.format("Track:         %s", track_name),
      string.format("Pan-Envelope:  %s", pan_name),
      string.format("Vol-Envelope:  %s", vol_name),
      string.format("Zeitbereich:   %.1f s – %.1f s", t_first, t_last),
      "",
      "Distanzsimulation (Volume Trim):",
      string.format("  Mitte  (pan= 0):  %.1f dB → linear %.3f  (lautester Peak)", CONFIG.center_db, 10^(CONFIG.center_db/20)),
      string.format("  Seite  (pan=±1):  %.1f dB → linear %.3f", CONFIG.side_db,   10^(CONFIG.side_db/20)),
    }
    reaper.ShowMessageBox(table.concat(lines, "\n"), "ICST Pan + Distanz", 0)
  end

end

main()
