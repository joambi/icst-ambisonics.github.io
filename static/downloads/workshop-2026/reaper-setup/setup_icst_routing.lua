-- ICST Ambisonics Workshop routing helper for REAPER.
-- Run this after opening spatial_counterpoint_workshop.RPP.

local function msg(text)
  reaper.ShowConsoleMsg(tostring(text) .. "\n")
end

local function find_track(partial_name)
  local needle = partial_name:lower()
  for i = 0, reaper.CountTracks(0) - 1 do
    local track = reaper.GetTrack(0, i)
    local _, name = reaper.GetTrackName(track, "")
    if name:lower():find(needle, 1, true) then
      return track, i
    end
  end
  return nil, -1
end

local function set_track_channels(track, channels)
  reaper.SetMediaTrackInfo_Value(track, "I_NCHAN", channels)
end

local function disable_master_send(track)
  reaper.SetMediaTrackInfo_Value(track, "B_MAINSEND", 0)
end

local function enable_master_send(track)
  reaper.SetMediaTrackInfo_Value(track, "B_MAINSEND", 1)
end

local function clear_sends(track)
  for i = reaper.GetTrackNumSends(track, 0) - 1, 0, -1 do
    reaper.RemoveTrackSend(track, 0, i)
  end
end

local function make_send(source, destination, destination_channel, label)
  local send_index = reaper.CreateTrackSend(source, destination)
  reaper.SetTrackSendInfo_Value(source, 0, send_index, "D_VOL", 1.0)
  reaper.SetTrackSendInfo_Value(source, 0, send_index, "D_PAN", 0.0)
  reaper.SetTrackSendInfo_Value(source, 0, send_index, "I_SENDMODE", 0)
  reaper.SetTrackSendInfo_Value(source, 0, send_index, "I_SRCCHAN", 0)
  reaper.SetTrackSendInfo_Value(source, 0, send_index, "I_DSTCHAN", destination_channel)
  msg("send: " .. label)
end

local sources = {
  { key = "01 Percussion", dst = 0, label = "Percussion -> ICST MultiEncoder input 1/2" },
  { key = "02 Depth Drone", dst = 2, label = "Drone -> ICST MultiEncoder input 3/4" },
  { key = "03 Melody", dst = 4, label = "Melody -> ICST MultiEncoder input 5/6" },
}

reaper.Undo_BeginBlock()
reaper.ClearConsole()

local encoder = find_track("10 ICST MultiEncoder")
local bformat = find_track("11 B-Format Master")
local decoder = find_track("12 Binaural Monitor")

if not encoder or not bformat or not decoder then
  reaper.ShowMessageBox(
    "Could not find all routing tracks. Expected tracks named 10 ICST MultiEncoder, 11 B-Format Master, and 12 Binaural Monitor.",
    "ICST routing setup",
    0
  )
  reaper.Undo_EndBlock("ICST workshop routing failed", -1)
  return
end

set_track_channels(encoder, 64)
set_track_channels(bformat, 64)
set_track_channels(decoder, 64)

disable_master_send(encoder)
disable_master_send(bformat)
enable_master_send(decoder)

clear_sends(encoder)
clear_sends(bformat)

for _, source_def in ipairs(sources) do
  local source = find_track(source_def.key)
  if source then
    set_track_channels(source, 2)
    disable_master_send(source)
    clear_sends(source)
    make_send(source, encoder, source_def.dst, source_def.label)
  else
    msg("missing source track: " .. source_def.key)
  end
end

make_send(encoder, bformat, 0, "ICST MultiEncoder -> B-Format Master")
make_send(bformat, decoder, 0, "B-Format Master -> Binaural Monitor / Decoder")

reaper.TrackList_AdjustWindows(false)
reaper.UpdateArrange()

msg("")
msg("Routing created.")
msg("Next steps:")
msg("1. Insert ICST MultiEncoder on track 10.")
msg("2. Insert AmbiDecoder or binaural decoder on track 12.")
msg("3. Render/export from track 11 B-Format Master for B-format deliverables.")

reaper.Undo_EndBlock("Set up ICST workshop routing", -1)
