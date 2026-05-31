-- ReaScript Name: Split stereo items on selected tracks into mono and copy to new tracks
-- Author: ChatGPT (fixed)
-- Description:
--   Für alle selektierten Tracks:
--     - zwei neue Mono-Tracks (L/R) direkt darunter anlegen
--     - alle Stereo-Items duplizieren:
--         Kopie auf (L) mit Channel Mode = Left only
--         Kopie auf (R) mit Channel Mode = Right only

local function msg(s) reaper.ShowMessageBox(s, "Split Stereo to Mono", 0) end

reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)

local num_sel_tracks = reaper.CountSelectedTracks(0)
if num_sel_tracks == 0 then
    reaper.PreventUIRefresh(-1)
    reaper.Undo_EndBlock("Split stereo items to mono tracks", -1)
    msg("Keine Tracks ausgewählt.")
    return
end

for t = 0, num_sel_tracks-1 do
    local track = reaper.GetSelectedTrack(0, t)
    if track then
        -- aktuellen Track-Index ermitteln (0-basiert)
        local tracknum = math.floor(reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER"))
        local idx = tracknum - 1

        -- ursprünglichen Namen holen
        local _, track_name = reaper.GetTrackName(track, "")

        -- 2 neue Tracks direkt darunter einfügen
        -- Left-Track
        reaper.InsertTrackAtIndex(idx + 1, true)
        local left_track = reaper.GetTrack(0, idx + 1)
        reaper.GetSetMediaTrackInfo_String(left_track, "P_NAME", track_name .. " (L)", true)

        -- Right-Track
        reaper.InsertTrackAtIndex(idx + 2, true)
        local right_track = reaper.GetTrack(0, idx + 2)
        reaper.GetSetMediaTrackInfo_String(right_track, "P_NAME", track_name .. " (R)", true)

        -- Items im Original-Track zählen
        local item_count = reaper.CountTrackMediaItems(track)

        -- Für jedes Item prüfen, ob Stereo und dann duplizieren
        for i = 0, item_count - 1 do
            local item = reaper.GetTrackMediaItem(track, i)
            local take = item and reaper.GetActiveTake(item)
            if take and not reaper.TakeIsMIDI(take) then
                local src = reaper.GetMediaItemTake_Source(take)
                local ch = reaper.GetMediaSourceNumChannels(src)

                if ch == 2 then
                    -- ganzen Item-State (inkl. Position, Fades etc.) holen
                    local retval, chunk = reaper.GetItemStateChunk(item, "", false)
                    if retval and chunk ~= "" then
                        -- Kopie für L
                        local new_item_L = reaper.AddMediaItemToTrack(left_track)
                        reaper.SetItemStateChunk(new_item_L, chunk, false)
                        local new_take_L = reaper.GetActiveTake(new_item_L)
                        if new_take_L then
                            -- 2 = Mono (Left)  / I_CHANMODE ist korrektes Feld
                            reaper.SetMediaItemTakeInfo_Value(new_take_L, "I_CHANMODE", 2)
                        end

                        -- Kopie für R
                        local new_item_R = reaper.AddMediaItemToTrack(right_track)
                        reaper.SetItemStateChunk(new_item_R, chunk, false)
                        local new_take_R = reaper.GetActiveTake(new_item_R)
                        if new_take_R then
                            -- 3 = Mono (Right)
                            reaper.SetMediaItemTakeInfo_Value(new_take_R, "I_CHANMODE", 3)
                        end
                    end
                end
            end
        end
    end
end

reaper.PreventUIRefresh(-1)
reaper.Undo_EndBlock("Split stereo items to mono tracks (L/R)", -1)


