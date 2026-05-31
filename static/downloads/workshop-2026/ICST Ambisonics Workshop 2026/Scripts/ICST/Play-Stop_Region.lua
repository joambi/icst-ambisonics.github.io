local loopStop_state = reaper.GetToggleCommandStateEx(0, 41834)
if loopStop_state == 0 then reaper.Main_OnCommand(41834, 0) end

-- Ensure repeat is off and manage loop points
function ensureRepeatIsOffAndSetLoopPointsToCurrentRegion()
    -- Ensure repeat is off
    local repeatState = reaper.GetToggleCommandState(1068) -- Command ID for Repeat
    if repeatState == 1 then
        reaper.Main_OnCommand(1068, 0) -- Toggle repeat off if it's on
    end

    -- Find the current region and set loop points 
    local playPosition = reaper.GetCursorPosition()
    local _, regionIndex = reaper.GetLastMarkerAndCurRegion(0, playPosition)
    if regionIndex ~= -1 then
        local _, _, regionStartPos, regionEndPos = reaper.EnumProjectMarkers(regionIndex)
        reaper.GetSet_LoopTimeRange(true, true, regionStartPos, regionEndPos, false)
        return true, regionEndPos -- Successfully set loop points, return end position
    else
        reaper.ShowMessageBox("Not currently in a region.", "Error", 0)
        return false -- Failed to set loop points
    end
end

-- Monitor playback and ensure stop at the end of the loop, then move the cursor
function monitorPlaybackAndEnsureStop(regionEndPos)
    local playState = reaper.GetPlayState()
    -- If playback has passed the end loop point, or stopped manually
    if playState ~= 0 then
        reaper.defer(function() monitorPlaybackAndEnsureStop(regionEndPos) end) -- Continue monitoring
    else
      if reaper.GetToggleCommandState(41834) ~= loopStop_state then reaper.Main_OnCommand(41834, 0) end
      reaper.SetEditCurPos(regionEndPos, true, false)
    end
end

function main()
    local success, regionEndPos = ensureRepeatIsOffAndSetLoopPointsToCurrentRegion()
    if success then
        monitorPlaybackAndEnsureStop(regionEndPos)
    end
end

main()

