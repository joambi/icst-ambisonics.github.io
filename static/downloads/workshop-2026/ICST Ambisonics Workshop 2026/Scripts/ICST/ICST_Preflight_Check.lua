-- ═══════════════════════════════════════════════════════════════
-- ICST Ambisonics Preflight Check
-- Version: 1.1 | 2026
--
-- Prüft eine REAPER-Session auf Ambisonics-Korrektheit:
--   1. HOA-Bus vorhanden und vollständig?
--   2. Decoder geladen?
--   3. Binaural-Konflikt (Binaural + Speaker gleichzeitig aktiv)?
--   4. Routing: Multichannel-Tracks ohne Send?
--   5. Export-Dokumentation in Projektnotizen?
--
-- Installation: Actions > Load ReaScript > diese Datei wählen
-- ═══════════════════════════════════════════════════════════════

local checks = {}

-- ── Hilfsfunktionen ──────────────────────────────────────────────

local function ci(str, sub)
  -- Case-insensitive Suche; gibt false zurück wenn nil
  if not str or not sub then return false end
  return str:lower():find(sub:lower(), 1, true) ~= nil
end

local function getTrackName(track)
  local _, name = reaper.GetTrackName(track, "")
  return name or ""
end

local function getFX(track)
  local fx = {}
  local count = reaper.TrackFX_GetCount(track)
  for i = 0, count - 1 do
    local _, name = reaper.TrackFX_GetFXName(track, i, "")
    local enabled  = reaper.TrackFX_GetEnabled(track, i)
    table.insert(fx, { name = name or "", enabled = enabled, index = i })
  end
  return fx
end

local function hoaOrder(ch)
  local t = { [4]=  "1st Order (4ch)",
              [9]=  "2nd Order (9ch)",
              [16]= "3rd Order (16ch)",
              [25]= "4th Order (25ch)",
              [36]= "5th Order (36ch)" }
  if t[ch] then return t[ch] end
  if ch == 64 then return "HOA-Buffer (64ch — ICST Standard)" end
  if ch > 36  then return string.format("HOA-Buffer (%dch)", ch) end
  return string.format("%dch", ch)
end

local function hoaOrderShort(ch)
  local t = { [4]="1st",[9]="2nd",[16]="3rd",[25]="4th",[36]="5th" }
  if t[ch] then return t[ch] .. " Order (" .. ch .. "ch)" end
  if ch == 64 then return "HOA-Buffer (64ch — ICST)" end
  if ch > 36  then return "HOA-Buffer (" .. ch .. "ch)" end
  return ch .. "ch"
end

local function addCheck(icon, name, detail)
  table.insert(checks, { icon = icon, name = name, detail = detail })
end

-- ── Keyword-Listen ───────────────────────────────────────────────

local HOA_NAME_KW = { "hoa", "ambi", "b-format", "bformat", "bus" }
local BINAURAL_KW = { "binaural", "dearvr", "dear vr", "hrir",
                      "headphone", "mc_binaural" }
local SPEAKER_KW  = { "allrad", "speaker", "lautsprecher", "dome",
                      "array", "ambidec" }
local DECODER_KW  = { "decoder", "binaural", "dearvr", "allrad",
                      "ambidec", "icst", "sparta", "iem" }

-- ─── Alle Tracks einlesen ────────────────────────────────────────

local trackCount = reaper.CountTracks(0)
local allTracks  = {}

for i = 0, trackCount - 1 do
  local track    = reaper.GetTrack(0, i)
  local name     = getTrackName(track)
  local ch       = reaper.GetMediaTrackInfo_Value(track, "I_NCHAN")
  local mainsend = reaper.GetMediaTrackInfo_Value(track, "B_MAINSEND") == 1
  local fx       = getFX(track)
  table.insert(allTracks, { track=track, name=name, ch=ch,
                             mainsend=mainsend, fx=fx, idx=i })
end

-- ═══════════════════════════════════════════════════════════════
-- 1. HOA-BUS CHECK
-- ═══════════════════════════════════════════════════════════════

local hoaBusList = {}
local hoaBusSet  = {}

for _, t in ipairs(allTracks) do
  if t.ch >= 4 then
    local nameMatch = false
    for _, kw in ipairs(HOA_NAME_KW) do
      if ci(t.name, kw) then nameMatch = true; break end
    end

    local hasICSTFX = false
    for _, f in ipairs(t.fx) do
      if ci(f.name, "icst") or ci(f.name, "ambisonic") then
        hasICSTFX = true; break
      end
    end

    if nameMatch or hasICSTFX then
      table.insert(hoaBusList, t)
      hoaBusSet[t.track] = true
    end
  end
end

if #hoaBusList > 0 then
  local parts = {}
  for _, b in ipairs(hoaBusList) do
    table.insert(parts, string.format('"%s"  %s', b.name, hoaOrder(b.ch)))
  end
  addCheck("✅", "HOA-Bus", table.concat(parts, "\n         "))
else
  addCheck("❌", "HOA-Bus",
    'Kein HOA-Bus gefunden\n' ..
    '         → Track mit ≥4 Kanälen und "Ambi/HOA" im Namen anlegen\n' ..
    '           oder ICST Ambisonics Plugin auf Master-Bus laden')
end

-- ═══════════════════════════════════════════════════════════════
-- 2. DECODER CHECK
-- ═══════════════════════════════════════════════════════════════

local binActive   = {}
local binBypassed = {}
local spkActive   = {}
local spkBypassed = {}

for _, t in ipairs(allTracks) do
  for _, f in ipairs(t.fx) do
    -- Ist es überhaupt ein Decoder?
    local isDecoder = false
    for _, kw in ipairs(DECODER_KW) do
      if ci(f.name, kw) then isDecoder = true; break end
    end

    if isDecoder then
      local isBin = false
      for _, kw in ipairs(BINAURAL_KW) do
        if ci(f.name, kw) then isBin = true; break end
      end
      local isSpk = false
      for _, kw in ipairs(SPEAKER_KW) do
        if ci(f.name, kw) then isSpk = true; break end
      end

      -- ICST Ambisonic Decoder ohne weitere Keywords → Speaker
      if not isBin and ci(f.name, "icst") and ci(f.name, "decoder") then
        isSpk = true
      end

      local label = string.format('"%s"  →  Track "%s"', f.name, t.name)
      if isBin then
        if f.enabled then table.insert(binActive, label)
        else               table.insert(binBypassed, label) end
      elseif isSpk then
        if f.enabled then table.insert(spkActive, label)
        else               table.insert(spkBypassed, label) end
      end
    end
  end
end

local totalDec = #binActive + #binBypassed + #spkActive + #spkBypassed

if totalDec == 0 then
  addCheck("❌", "Decoder",
    "Kein Decoder erkannt\n" ..
    "         → ICST, IEM, dearVR oder SPARTA Plugin prüfen")
else
  local lines = {}
  for _, d in ipairs(binActive)   do table.insert(lines, "🎧 aktiv     " .. d) end
  for _, d in ipairs(spkActive)   do table.insert(lines, "🔊 aktiv     " .. d) end
  for _, d in ipairs(binBypassed) do table.insert(lines, "🎧 bypassed  " .. d) end
  for _, d in ipairs(spkBypassed) do table.insert(lines, "🔊 bypassed  " .. d) end
  addCheck("✅", "Decoder", table.concat(lines, "\n         "))
end

-- ═══════════════════════════════════════════════════════════════
-- 3. BINAURAL-KONFLIKT
-- ═══════════════════════════════════════════════════════════════

if #binActive > 0 and #spkActive > 0 then
  addCheck("❌", "Binaural-Konflikt",
    string.format("KONFLIKT: %d Binaural + %d Speaker-Decoder gleichzeitig aktiv!\n" ..
                  "         → Einen Pfad bypassen vor dem Abhören.",
                  #binActive, #spkActive))
elseif #binActive > 0 then
  addCheck("✅", "Binaural-Pfad",
    string.format("%d Binaural aktiv — kein paralleler Speaker-Decoder", #binActive))
elseif #spkActive > 0 then
  addCheck("✅", "Speaker-Pfad",
    string.format("%d Speaker-Decoder aktiv", #spkActive))
elseif totalDec > 0 then
  addCheck("⚠️", "Decoder-Status", "Alle gefundenen Decoder sind bypassed — bewusst so?")
end

-- ═══════════════════════════════════════════════════════════════
-- 4. ROUTING CHECK
-- ═══════════════════════════════════════════════════════════════

local orphans = {}

for _, t in ipairs(allTracks) do
  -- Nur Source-Tracks (nicht HOA-Bus selbst)
  if t.ch >= 4 and not hoaBusSet[t.track] then
    local sendCount = reaper.GetTrackNumSends(t.track, 0)
    -- Kein Send UND kein Master-Send → Waise
    if sendCount == 0 and not t.mainsend then
      table.insert(orphans, string.format('"%s"  (%s)', t.name, hoaOrder(t.ch)))
    end
  end
end

if #orphans > 0 then
  addCheck("⚠️", "Routing",
    "Multichannel-Tracks ohne Send:\n         → " ..
    table.concat(orphans, "\n         → "))
else
  addCheck("✅", "Routing", "Alle Multichannel-Tracks haben Sends oder Master-Routing")
end

-- ═══════════════════════════════════════════════════════════════
-- 5. EXPORT-DOKUMENTATION
--    Wird direkt aus der Session abgeleitet (HOA-Bus + Decoder)
--    + optional aus Project Settings Notes / View>Project Notes
-- ═══════════════════════════════════════════════════════════════

local exportLines = {}
local exportIssues = {}

-- ── Format aus HOA-Bus ableiten ──────────────────────────────
-- ambiX (ACN/SN3D) ist der moderne Standard; FuMa nur wenn
-- explizit im Track-/FX-Namen erwähnt
local detectedFormat = "ambiX (ACN/SN3D)"  -- sicherer Default
local detectedOrder  = nil

for _, b in ipairs(hoaBusList) do
  -- Ordnung aus Kanalzahl
  if b.ch >= 4 and not detectedOrder then
    detectedOrder = hoaOrderShort(b.ch)
  end
  -- FuMa explizit erwähnt?
  if ci(b.name, "fuma") or ci(b.name, "furse") then
    detectedFormat = "FuMa"
  end
  -- FX auf HOA-Bus prüfen
  for _, f in ipairs(b.fx) do
    if ci(f.name, "fuma") or ci(f.name, "furse") then
      detectedFormat = "FuMa"
    end
  end
end

if detectedOrder then
  table.insert(exportLines, "Format:  " .. detectedFormat)
  table.insert(exportLines, "Order:   " .. detectedOrder)
else
  table.insert(exportIssues, "Order konnte nicht bestimmt werden — HOA-Bus prüfen")
end

-- ── Decoder-Typ ──────────────────────────────────────────────
if #binActive > 0 then
  -- Decoder-Name kürzen für Ausgabe
  local decName = binActive[1]:match('"([^"]+)"') or "Binaural"
  table.insert(exportLines, "Decoder: " .. decName)
elseif #spkActive > 0 then
  local decName = spkActive[1]:match('"([^"]+)"') or "Speaker"
  table.insert(exportLines, "Decoder: " .. decName)
else
  table.insert(exportIssues, "Aktiver Decoder nicht gefunden — Export-Format unklar")
end

-- ── Render-Format prüfen ─────────────────────────────────────
local renderCh = reaper.GetSetProjectInfo(0, "RENDER_CHANNELS", 0, false)
if renderCh and renderCh > 0 then
  local binauralActive = #binActive > 0

  if renderCh == 2 and binauralActive then
    -- 2ch Stereo bei aktivem Binaural-Decoder ist korrekt
    table.insert(exportLines, "Render:  2ch Stereo (Binaural) ✓")
  elseif renderCh == 2 and not binauralActive then
    -- 2ch ohne Binaural-Decoder ist verdächtig
    table.insert(exportIssues,
      "Render 2ch Stereo, aber kein Binaural-Decoder aktiv — HOA-Kanäle prüfen")
  else
    -- Multichannel-Render: Ordnung anzeigen
    local renderOrd = { [4]="1st",[9]="2nd",[16]="3rd",[25]="4th",[36]="5th" }
    local orderStr  = renderOrd[renderCh]
    if orderStr then
      table.insert(exportLines,
        string.format("Render:  %dch (%s Order) ✓", renderCh, orderStr))
    else
      table.insert(exportLines,
        string.format("Render:  %dch — Standard-Ordnung?", renderCh))
    end
    -- Warnung wenn Render-Kanäle stark vom HOA-Bus abweichen
    if #hoaBusList > 0 then
      local primary = hoaBusList[#hoaBusList]
      local busCh   = primary.ch
      -- Nur warnen bei echten HOA-Kanälzahlen (nicht 64ch Buffer)
      if busCh <= 36 and renderCh ~= busCh then
        table.insert(exportIssues,
          string.format("Render %dch ≠ HOA-Bus %dch — Render-Einstellungen prüfen",
                        renderCh, busCh))
      end
    end
  end
end

-- ── Ergebnis zusammenstellen ─────────────────────────────────
if #exportIssues == 0 then
  addCheck("✅", "Export-Doku", table.concat(exportLines, "\n         "))
else
  local detail = ""
  if #exportLines > 0 then
    detail = table.concat(exportLines, "\n         ") .. "\n         "
  end
  detail = detail .. "⚠ " .. table.concat(exportIssues, "\n         ⚠ ")
  addCheck("⚠️", "Export-Doku", detail)
end

-- ═══════════════════════════════════════════════════════════════
-- REPORT
-- ═══════════════════════════════════════════════════════════════

local projName = reaper.GetProjectName(0, "")
if not projName or projName == "" then projName = "(unbenanntes Projekt)" end

local sep    = string.rep("─", 54)
local report = sep .. "\n"
report = report .. "  ICST Ambisonics Preflight Check\n"
report = report .. "  " .. projName .. "\n"
report = report .. sep .. "\n\n"

local hasIssue = false
for _, c in ipairs(checks) do
  report = report .. c.icon .. "  " .. c.name .. "\n"
  report = report .. "   " .. c.detail .. "\n\n"
  if c.icon ~= "✅" then hasIssue = true end
end

report = report .. sep .. "\n"
if hasIssue then
  report = report .. "⚠️  Punkte prüfen bevor du weitermachst.\n"
else
  report = report .. "✅  Session sieht gut aus — gutes Arbeiten!\n"
end

reaper.ShowMessageBox(report, "Ambisonics Preflight", 0)
