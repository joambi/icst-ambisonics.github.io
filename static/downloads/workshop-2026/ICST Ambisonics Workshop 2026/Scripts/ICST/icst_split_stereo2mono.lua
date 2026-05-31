-- @description Split selected stereo item into two mono tracks
-- @version 1.0
-- @author Your Name
-- @changelog Initial release

function split_stereo_item_to_mono()
  -- Get the selected item
  local item = reaper.GetSelectedMediaItem(0, 0)
  if not item then
    reaper.ShowMessageBox("Please select a stereo item to split.", "Error", 0)
    return
  end

  -- Get the take and its source
  local take = reaper.GetActiveTake(item)
  if not take then
    reaper.ShowMessageBox("The selected item has no active take.", "Error", 0)
    return
  end

  local source = reaper.GetMediaItemTake_Source(take)
  local num_channels = reaper.GetMediaSourceNumChannels(source)

  if num_channels < 2 then
    reaper.ShowMessageBox("The selected item is not a stereo item.", "Error", 0)
    return
  end

  -- Get item properties
  local item_start = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
  local item_length = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
  local item_track = reaper.GetMediaItem_Track(item)

  -- Create two new tracks for mono channels
  reaper.Undo_BeginBlock()

  local left_track_index = reaper.GetMediaTrackInfo_Value(item_track, "IP_TRACKNUMBER")
  reaper.InsertTrackAtIndex(left_track_index, true)
  reaper.InsertTrackAtIndex(left_track_index + 1, true)
  local left_track = reaper.GetTrack(0, left_track_index)
  local right_track = reaper.GetTrack(0, left_track_index + 1)

  -- Rename tracks
  reaper.GetSetMediaTrackInfo_String(left_track, "P_NAME", "Left Channel", true)
  reaper.GetSetMediaTrackInfo_String(right_track, "P_NAME", "Right Channel", true)

  -- Duplicate the item to the new tracks
  local left_item = reaper.AddMediaItemToTrack(left_track)
  local right_item = reaper.AddMediaItemToTrack(right_track)

  -- Set item properties
  reaper.SetMediaItemInfo_Value(left_item, "D_POSITION", item_start)
  reaper.SetMediaItemInfo_Value(left_item, "D_LENGTH", item_length)
  reaper.SetMediaItemInfo_Value(right_item, "D_POSITION", item_start)
  reaper.SetMediaItemInfo_Value(right_item, "D_LENGTH", item_length)

  -- Add takes to the new items
  local left_take = reaper.AddTakeToMediaItem(left_item)
  local right_take = reaper.AddTakeToMediaItem(right_item)

  -- Set the media source
  reaper.SetMediaItemTake_Source(left_take, source)
  reaper.SetMediaItemTake_Source(right_take, source)

  -- Pan each take
  reaper.SetMediaItemTakeInfo_Value(left_take, "D_PAN", -1) -- Left channel
  reaper.SetMediaItemTakeInfo_Value(right_take, "D_PAN", 1) -- Right channel

  -- Mute the original item
  reaper.SetMediaItemInfo_Value(item, "B_MUTE", 1)

  reaper.UpdateArrange()
  reaper.Undo_EndBlock("Split stereo item into mono tracks", -1)
end

-- Run the script
split_stereo_item_to_mono()


