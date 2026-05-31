-- @description A/B Solo Toggle for selected track
-- @version 1.0
-- @author GPT
-- @about
--   Toggles solo on the selected track, and unsolos all others (for A/B listening)
-- @provides
--   [main] .

function main()
  reaper.Undo_BeginBlock()

  local selectedTrack = reaper.GetSelectedTrack(0, 0)
  if not selectedTrack then
    reaper.ShowMessageBox("Kein Track ausgewählt.", "Fehler", 0)
    return
  end

  local isSolo = reaper.GetMediaTrackInfo_Value(selectedTrack, "I_SOLO") > 0

  -- Erstmal alle Solos ausschalten
  local trackCount = reaper.CountTracks(0)
  for i = 0, trackCount - 1 do
    local track = reaper.GetTrack(0, i)
    reaper.SetMediaTrackInfo_Value(track, "I_SOLO", 0)
  end

  -- Nur solo schalten, wenn vorher nicht solo
  if not isSolo then
    reaper.SetMediaTrackInfo_Value(selectedTrack, "I_SOLO", 1)
  end

  reaper.TrackList_AdjustWindows(false)
  reaper.Undo_EndBlock("A/B Solo Toggle selected track", -1)
end

main()


