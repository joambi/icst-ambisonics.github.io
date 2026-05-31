-- Check if an item is selected
local item = reaper.GetSelectedMediaItem(0, 0)
if not item then
  reaper.ShowMessageBox("Please select an audio item", "Error", 0)
  return
end

-- Get the number of channels of the item
local track = reaper.GetMediaItem_Track(item)
local take = reaper.GetMediaItemTake(item, 0)
local num_channels = reaper.GetMediaSourceNumChannels(reaper.GetMediaItemTake_Source(take))

-- Ensure we have multiple channels to split
if num_channels < 2 then
  reaper.ShowMessageBox("The selected item doesn't have multiple channels", "Error", 0)
  return
end

-- Iterate through the channels and create a new track for each
for i = 0, num_channels - 1 do
  -- Create a new track for each channel
  reaper.InsertTrackAtIndex(reaper.CountTracks(0), true)
  local newTrack = reaper.GetTrack(0, reaper.CountTracks(0) - 1)
  
  -- Set the new track as the one where the channel will be placed
  reaper.SetTrackSelected(newTrack, true)
  
  -- Split the item into its channels and create separate items
  reaper.SetMediaItemSelected(item, true)
  reaper.SplitMediaItem(item, reaper.GetMediaItemLength(item))
  
  -- Get the new items after the split (the two channels)
  local newItem = reaper.GetSelectedMediaItem(0, 0)
  
  -- Move the item to the newly created track
  reaper.MoveMediaItemToTrack(newItem, newTrack)
  
  -- Optionally, adjust the name of each track based on the channel
  local trackName = "Channel " .. (i + 1)
  reaper.GetSetMediaTrackInfo_String(newTrack, "P_NAME", trackName, true)
end

reaper.TrackList_AdjustWindows(true) -- Update the window
reaper.UpdateArrange() -- Refresh the arrange view



