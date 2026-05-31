-- Show only selected tracks and hide all others
-- Written for Reaper in Lua

function Main()
    -- Get the total number of tracks in the project
    local trackCount = reaper.CountTracks(0)
    
    -- Loop through all tracks
    for i = 0, trackCount - 1 do
        local track = reaper.GetTrack(0, i)
        
        -- Check if the track is selected
        local isSelected = reaper.IsTrackSelected(track)
        
        -- Set track visibility
        if isSelected then
            -- Show selected track in both TCP and MCP
            reaper.SetMediaTrackInfo_Value(track, "B_SHOWINTCP", 1)
            reaper.SetMediaTrackInfo_Value(track, "B_SHOWINMIXER", 1)
        else
            -- Hide unselected tracks in both TCP and MCP
            reaper.SetMediaTrackInfo_Value(track, "B_SHOWINTCP", 0)
            reaper.SetMediaTrackInfo_Value(track, "B_SHOWINMIXER", 0)
        end
    end
    
    -- Refresh UI to reflect changes
    reaper.TrackList_AdjustWindows(false)
    reaper.UpdateArrange()
end

-- Run the script
reaper.Undo_BeginBlock()
Main()
reaper.Undo_EndBlock("Show only selected tracks and hide all others", -1)


