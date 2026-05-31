-- Lade gespeicherte Tracks anhand der GUIDs und selektiere sie
function restore_selected_tracks()
  local saved = reaper.GetExtState("TrackGroup", "GroupA")
  if saved == "" then
    reaper.ShowMessageBox("Keine gespeicherten Tracks in Gruppe A gefunden!", "Fehler", 0)
    return
  end

  -- Alle Tracks deselektieren
  local all_tracks = reaper.CountTracks(0)
  for i = 0, all_tracks - 1 do
    local track = reaper.GetTrack(0, i)
    reaper.SetTrackSelected(track, false)
  end

  -- GUIDs durchgehen und passende Tracks wieder selektieren
  for guid in string.gmatch(saved, "([^,]+)") do
    for i = 0, all_tracks - 1 do
      local track = reaper.GetTrack(0, i)
      if reaper.GetTrackGUID(track) == guid then
        reaper.SetTrackSelected(track, true)
        break
      end
    end
  end

  reaper.UpdateArrange()
end

restore_selected_tracks()


