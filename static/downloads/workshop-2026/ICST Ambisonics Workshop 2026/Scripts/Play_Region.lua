--[[
ReaScript Name: Play current region and stop at end (auto)
Author: ReaperGPT
Version: 1.1

Beschreibung:
  - Findet die Region unter dem Start-Punkt (standard: Edit-Cursor).
  - Springt an deren Anfang, startet Playback und stoppt exakt am Ende.
  - Stoppt ebenfalls, wenn der Playhead die Region vorzeitig verlässt (optional).
]]

local r = reaper

---------------- Einstellungen ----------------
local START_FROM_PLAYHEAD = false  -- false = nimm Edit-Cursor, true = nimm aktuellen Playhead
local MOVE_VIEW           = true   -- Ansicht scrollen beim Springen
local SEEK_PLAY           = true   -- Play-Seek verwenden
local STOP_IF_LEAVE       = true   -- stoppen, wenn Playhead die Region verlässt
local EPS                 = 1e-4   -- Toleranz

---------------- Helpers ----------------
local function get_region_at_time(time)
  local total = ({r.CountProjectMarkers(0)})[1]
  for i = 0, total-1 do
    local ok, isrgn, pos, fin, name, id = r.EnumProjectMarkers3(0, i)
    if ok and isrgn and time >= pos - EPS and time < fin - EPS then
      return {id=id, name=name or "", s=pos, e=fin}
    end
  end
end

local function goto_time(t, start_play)
  r.SetEditCurPos2(0, t, MOVE_VIEW and 1 or 0, (start_play and SEEK_PLAY) and 1 or 0)
  if start_play then r.OnPlayButton() end
end

local function hard_stop_at(t)
  r.OnStopButton()
  r.SetEditCurPos(t, MOVE_VIEW, false)
end

---------------- Main ----------------
local function main()
  local start_time
  if START_FROM_PLAYHEAD and (r.GetPlayState() & 1) == 1 then
    start_time = r.GetPlayPosition()
  else
    start_time = r.GetCursorPosition()
  end

  local region = get_region_at_time(start_time)
  if not region then
    r.MB("Keine Region unter Start-Position gefunden.\nSetze den Edit-Cursor in eine Region und starte das Script erneut.",
         "Play Region", 0)
    return
  end

  -- an den Anfang der Region springen und abspielen
  goto_time(region.s, true)

  -- Watcher: stoppt am Ende (oder wenn wir die Region verlassen)
  local function watcher()
    local playstate = r.GetPlayState() -- 1=play, 2=pause, 4=rec
    if playstate & 1 == 0 then return end -- nicht mehr am Abspielen

    local pos = r.GetPlayPosition()
    if (STOP_IF_LEAVE and (pos < region.s - EPS or pos >= region.e - EPS))
       or (not STOP_IF_LEAVE and pos >= region.e - EPS) then
      hard_stop_at(region.e)
      return
    end

    r.defer(watcher)
  end

  watcher()
end

main()


