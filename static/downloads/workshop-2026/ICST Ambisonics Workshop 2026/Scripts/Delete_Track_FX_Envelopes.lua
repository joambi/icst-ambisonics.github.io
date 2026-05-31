-- @description Löscht alle FX-Automationsdaten eines ausgewählten Tracks und blendet sie aus
-- @version 1.3
-- @author ChatGPT
-- @about Löscht alle FX-Automationspunkte und versteckt die Envelopes über den State Chunk

function hideEnvelope(env)
  local retval, chunk = reaper.GetEnvelopeStateChunk(env, "", false)
  if retval then
    -- Ersetze die VIS-Zeile (Sichtbarkeit) mit "VIS 0 0 0"
    chunk = chunk:gsub("VIS%s+%d+%s+%d+%s+%d+", "VIS 0 0 0")
    reaper.SetEnvelopeStateChunk(env, chunk, false)
  end
end

function clearFXAutomationEnvelopes(track)
  if not track then return end

  local envCount = reaper.CountTrackEnvelopes(track)
  for i = 0, envCount - 1 do
    local env = reaper.GetTrackEnvelope(track, i)
    local retval, envName = reaper.GetEnvelopeName(env, "")

    -- Nur FX-Parameter-Automationen
    if envName:match("^FX %d+:") then
      reaper.DeleteEnvelopePointRange(env, -math.huge, math.huge)
      hideEnvelope(env)
    end
  end
end

reaper.Undo_BeginBlock()

local track = reaper.GetSelectedTrack(0, 0)
if track then
  clearFXAutomationEnvelopes(track)
else
  reaper.ShowMessageBox("Bitte einen Track auswählen.", "Fehler", 0)
end

reaper.Undo_EndBlock("FX-Automationen löschen und verstecken", -1)
reaper.UpdateArrange()

  
