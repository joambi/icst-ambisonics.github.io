-- @description List all FX parameters with indices for selected track
-- @version 1.0
-- @author Dein Assistent
-- @noindex

local track = reaper.GetSelectedTrack(0,0)
if not track then
  reaper.ShowMessageBox("Kein Track ausgewählt!", "Fehler", 0)
  return
end

-- Standard: erstes FX (Index 0)
local fx_idx = 0
local fx_name_ret, fx_name = reaper.TrackFX_GetFXName(track, fx_idx, "")
if not fx_name then
  reaper.ShowMessageBox("Kein FX im Slot 0 gefunden!", "Fehler", 0)
  return
end

reaper.ShowConsoleMsg("== Parameter Liste für FX: "..fx_name.." ==\n")

local param_count = reaper.TrackFX_GetNumParams(track, fx_idx)
for i=0, param_count-1 do
  local _, name = reaper.TrackFX_GetParamName(track, fx_idx, i, "")
  reaper.ShowConsoleMsg(string.format("Index %03d : %s\n", i, name))
end

reaper.ShowConsoleMsg("== Ende der Liste ==\n")



