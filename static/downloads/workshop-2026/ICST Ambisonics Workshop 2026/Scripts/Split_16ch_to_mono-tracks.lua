-- REAPER Lua Script to Split 16-Channel Audio into Mono Tracks

-- Get the active take from the selected item (assumed to be multi-channel audio)
local item = reaper.GetSelectedMediaItem(0, 0)  -- Get the first selected item

if not item then
    reaper.ShowMessageBox("No item selected!", "Error", 0)
    return
end

local take = reaper.GetMediaItemTake(item, 0)

if not take then
    reaper.ShowMessageBox("No take found in the selected item!", "Error", 0)
    return
end

-- Get the number of channels in the take (audio file)
local num_channels = reaper.GetMediaSourceNumChannels(reaper.GetMediaItemTake_Source(take))

if num_channels ~= 16 then
    reaper.ShowMessageBox("The item doesn't contain 16 channels!", "Error", 0)
    return
end

-- Iterate through each channel and create a separate mono track
for i = 1, 16 do
    -- Create a new track
    reaper.InsertTrackAtIndex(reaper.CountTracks(0), true)
    local new_track = reaper.GetTrack(0, reaper.CountTracks(0) - 1)
    
    -- Set the track name (optional, for clarity)
    reaper.GetSetMediaTrackInfo_String(new_track, "P_NAME", "Channel " .. i, true)
    
    -- Create a new item from the original take, specifying the channel
    local start_time = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    local end_time = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
    local new_item = reaper.AddMediaItemToTrack(new_track)
    
    -- Split the multi-channel take into mono for each channel
    reaper.SetMediaItemTake_Source(new_item, reaper.GetMediaItemTake_Source(take))
    reaper.SetMediaItemInfo_Value(new_item, "D_POSITION", start_time)
    reaper.SetMediaItemInfo_Value(new_item, "D_LENGTH", end_time)
    reaper.SetMediaItemTake_Source(new_item, reaper.GetMediaItemTake_Source(take))
    reaper.SetMediaItemTake_Channel(new_item, i - 1)  -- 0-indexed channel
    
    -- Optional: Move the new track down below the original
    reaper.SetTrackSelected(new_track, true)
end

-- Update the arrange view
reaper.TrackList_AdjustWindows(true)
reaper.UpdateArrange()


