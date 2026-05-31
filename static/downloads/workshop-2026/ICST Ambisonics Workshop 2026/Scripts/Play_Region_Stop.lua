--[[
ReaScript Name: Regions automatisch durchspielen (kein Pause, Auto-Weiter)
Author: ReaperGPT
Version: 1.0

Funktion:
  - Erkennt, in welcher Region sich Playhead/ Cursor befindet.
  - Läuft eine Region bis zum Ende und springt nahtlos zur nächsten Region (spielt weiter).
  - Wenn du gestoppt bist und zur (nächsten) Region springst, startet das Playback automatisch.
  - Optional: nach der letzten Region wieder mit der ersten weitermachen (LOOP_ALL).

Hinweis:
  - Arbeitet mit echten Regionen (nicht Marker).
  - Keine Extensions nötig.
]]

local r = reaper

---------------- Einstellungen ----------------
local MOVE_VIEW    = true     -- Ansicht beim Springen scrollen
local SEEK_PLAY    = true     -- Play-Seek verwenden beim Start
local LOOP_ALL     = false    -- nach letzter Region zurück zur ersten
local START_AT_RGN = true     -- beim (neu) Betreten einer Region im Stop an Regionsanfang springen
local EPS          = 1e-3     -- Toleranz für Floatvergleiche

---------------- Interna ----------------
local regions = {}            -- { {id=, name=, s=, e=} ... } zeitlich sortiert
local cur_idx = nil           -- Index in 'regions' (1..#regions) der aktuellen Region
local last_statecount = -1

local function refresh_regions(force)
  local scc = r.GetProjectStateChangeCount(0)
  if (not force) and scc == last_statecount then return end
  last_statecount = scc

  regions = {}
  local total = ({r.CountProjectMarkers(0)})[1]
  for i = 0, total-1 do
    local ok, isrgn, pos, fin, name, id = r.EnumProjectMarkers3(0, i)
    if ok and isrgn then
      regions[#regions+1] = { id=id, name=name or "", s=pos, e=fin }
    end
  end
  table.sort(regions, function(a,b) return a.s < b.s end)
end

local function find_region_at_time(t)
  for i, g in ipairs(regions) do
    if t >= g.s - EPS and t < g.e - EPS then return i end
  end
end

local function goto_pos(p, start_play, seek)
  -- start_play: true -> starten (falls gestoppt)
  -- seek: true -> Play-Seek (springt auch wenn schon playing)
  r.SetEditCurPos2(0, p, MOVE_VIEW and 1 or 0, (start_play or seek) and 1 or 0)
  if start_play then r.OnPlayButton() end
end

local function next_region_index(i)
  if not i then return nil end
  if i < #regions then return i+1 end
  if LOOP_ALL and #regions > 0 then return 1 end
end

local function loop()
  refresh_regions()

  local playing = (r.GetPlayState() & 1) == 1
  local t = playing and r.GetPlayPosition() or r.GetCursorPosition()

  -- aktuelle Region bestimmen
  local i_now = (#regions > 0) and find_region_at_time(t) or nil

  -- Fall A: Regionswechsel (z.B. durch deine "Next region" Action im Stop)
  if i_now ~= cur_idx then
    cur_idx = i_now
    if cur_idx and not playing then
      -- Wir haben gestoppt und sind in einer (neuen) Region gelandet -> automatisch starten
      local start_t = START_AT_RGN and regions[cur_idx].s or t
      goto_pos(start_t, true, true)
      -- playing-Flag ändert sich erst im nächsten Durchlauf, daher kein return hier
    end
  end

  -- Fall B: Wir spielen und sind am Ende der Region -> nahtlos zur nächsten
  if playing and cur_idx then
    local g = regions[cur_idx]
    if t >= g.e - EPS then
      local ni = next_region_index(cur_idx)
      if ni then
        cur_idx = ni
        goto_pos(regions[ni].s, false, true)  -- Seek, Playback bleibt an
      else
        -- keine nächste Region -> stoppen am Ende der letzten
        r.OnStopButton()
        r.SetEditCurPos(g.e, MOVE_VIEW, false)
      end
    end
  end

  r.defer(loop)
end

-- Start
refresh_regions(true)
loop()
