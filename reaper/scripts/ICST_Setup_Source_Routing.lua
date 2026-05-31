-- ═══════════════════════════════════════════════════════════════
-- ICST Ambisonics: Source → Encoder Mono Routing Setup
-- Version: 3.0 | 2026
--
-- Richtet das Mono-Routing der Kind-Tracks im Encoder-Folder ein.
-- Jeder Source-Track sendet Mono Ch 1 auf einen eigenen
-- Encoder-Eingangskanal.
--
-- Technische Umsetzung:
--   Folder-Sends (Child → Parent) werden via I_SRCCHAN / I_DSTCHAN
--   konfiguriert. I_SRCCHAN + 1024 = Mono-Flag in REAPER.
-- ═══════════════════════════════════════════════════════════════

local function ci(str, sub)
  if not str or not sub then return false end
  return str:lower():find(sub:lower(), 1, true) ~= nil
end

local function getTrackName(track)
  local _, name = reaper.GetTrackName(track, "")
  return name or ""
end

local function trackIndex(track)
  return math.floor(reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")) - 1
end

-- ── 1. Encoder-Folder finden ─────────────────────────────────────

local encoderTrack = nil
for i = 0, reaper.CountTracks(0) - 1 do
  local t    = reaper.GetTrack(0, i)
  local name = getTrackName(t)
  if ci(name, "multiencoder") or ci(name, "multi-ambi") or
     ci(name, "multi ambi")   or ci(name, "encoder") then
    encoderTrack = t
    break
  end
end

if not encoderTrack then
  reaper.ShowMessageBox(
    'Kein Encoder-Track gefunden.\n\nName muss "Encoder" oder "MultiEncoder" enthalten.',
    "ICST Routing", 0)
  return
end

-- ── 2. Kind-Tracks sammeln ───────────────────────────────────────

local sources = {}
for i = 0, reaper.CountTracks(0) - 1 do
  local t = reaper.GetTrack(0, i)
  if reaper.GetParentTrack(t) == encoderTrack then
    table.insert(sources, { track = t, name = getTrackName(t), idx = i })
  end
end

table.sort(sources, function(a, b) return a.idx < b.idx end)

if #sources == 0 then
  reaper.ShowMessageBox(
    string.format('Keine Kind-Tracks in "%s" gefunden.', getTrackName(encoderTrack)),
    "ICST Routing", 0)
  return
end

-- ── 3. Vorschau ──────────────────────────────────────────────────

local preview = string.format(
  'Encoder: "%s"\n%d Source-Tracks:\n\n', getTrackName(encoderTrack), #sources)
for i, s in ipairs(sources) do
  preview = preview .. string.format("  Ch %2d  ←  %s\n", i, s.name)
end
preview = preview .. "\nMono Ch 1 → Enc Eingang N\nFortfahren?"

if reaper.ShowMessageBox(preview, "ICST Routing Setup", 4) ~= 6 then
  return
end

-- ── 4. Routing setzen ────────────────────────────────────────────

reaper.Undo_BeginBlock()

local done   = {}
local errors = {}

for encInput, src in ipairs(sources) do
  local t       = src.track
  local dstChan = encInput - 1   -- 0-basiert

  -- Track-Kanalzahl auf 1 (Mono)
  reaper.SetMediaTrackInfo_Value(t, "I_NCHAN", 1)

  -- Master-Send aus (Source geht nur in Encoder-Folder)
  reaper.SetMediaTrackInfo_Value(t, "B_MAINSEND", 0)

  -- ── Folder-Send anpassen ────────────────────────────────────
  -- In REAPER sind Folder-Sends als Receives am Parent gespeichert.
  -- Wir lesen alle Receives des Encoder-Tracks durch und finden
  -- den Receive der von diesem Kind-Track kommt.

  local encoderRecvCount = reaper.GetTrackNumSends(encoderTrack, -1)  -- -1 = Receives
  local folderSendFound  = false

  for r = 0, encoderRecvCount - 1 do
    -- P_SRCTRACK des Receives holen
    local srcTrackNum = reaper.GetTrackSendInfo_Value(encoderTrack, -1, r, "I_SRCTRACKNUMBER")
    -- I_SRCTRACKNUMBER ist 1-basiert
    local srcIdx = math.floor(srcTrackNum) - 1

    if srcIdx == src.idx then
      -- Gefunden: Mono-Flag (1024) auf Quell-Kanal 1 (0)
      -- SRCCHAN im Receive = der Kanal des Child-Tracks
      reaper.SetTrackSendInfo_Value(encoderTrack, -1, r, "I_SRCCHAN", 1024 + 0)
      -- DSTCHAN im Receive = der Eingangskanal des Encoders
      reaper.SetTrackSendInfo_Value(encoderTrack, -1, r, "I_DSTCHAN", dstChan)

      folderSendFound = true
      table.insert(done, string.format(
        "✅  Enc Ch %2d  ←  \"%s\"", encInput, src.name))
      break
    end
  end

  if not folderSendFound then
    -- Kein Folder-Receive gefunden → normalen Send erstellen
    local sendIdx = reaper.CreateTrackSend(t, encoderTrack)
    if sendIdx >= 0 then
      reaper.SetTrackSendInfo_Value(t, 0, sendIdx, "I_SRCCHAN", 1024 + 0)
      reaper.SetTrackSendInfo_Value(t, 0, sendIdx, "I_DSTCHAN",  dstChan)
      reaper.SetTrackSendInfo_Value(t, 0, sendIdx, "D_VOL",      1.0)
      reaper.SetTrackSendInfo_Value(t, 0, sendIdx, "I_SENDMODE", 0)
      table.insert(done, string.format(
        "✅  Enc Ch %2d  ←  \"%s\"  (neuer Send)", encInput, src.name))
    else
      table.insert(errors, string.format("❌  \"%s\"  — Send fehlgeschlagen", src.name))
    end
  end
end

reaper.Undo_EndBlock("ICST Mono Routing Setup", -1)
reaper.UpdateArrange()
reaper.TrackList_AdjustWindows(false)

-- ── 5. Bericht ───────────────────────────────────────────────────

local sep    = string.rep("─", 44)
local report = sep .. "\n  ICST Routing Setup — Fertig\n" .. sep .. "\n\n"
report = report .. string.format("%d/%d Tracks geroutet:\n\n", #done, #sources)
for _, l in ipairs(done)   do report = report .. l .. "\n" end
if #errors > 0 then
  report = report .. "\n"
  for _, l in ipairs(errors) do report = report .. l .. "\n" end
end
report = report .. "\n" .. sep .. "\nPreflight-Check ausführen zur Bestätigung."

reaper.ShowMessageBox(report, "ICST Routing Setup", 0)
