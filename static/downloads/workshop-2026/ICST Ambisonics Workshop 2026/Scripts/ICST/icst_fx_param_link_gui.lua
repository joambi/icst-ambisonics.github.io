-- ReaScript Name: FX Parameter Link GUI
-- Author: Reaper DAW Ultimate Assistant
-- Description: GUI to select source and destination FX/Parameter indices and link them.
-- Requires: ReaImGui extension (https://forum.cockos.com/showthread.php?t=241604)

local ctx = reaper.ImGui_CreateContext('FX Param Linker')
local visible = true
local src_fx, src_param, dest_fx, dest_param = 0,0,0,0

function link_params(track, sfx, sparam, dfx, dparam)
  reaper.TrackFX_SetNamedConfigParm(track, dfx, "param."..dparam..".plink.active", "1")
  reaper.TrackFX_SetNamedConfigParm(track, dfx, "param."..dparam..".plink.src_tr", tostring(reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")-1))
  reaper.TrackFX_SetNamedConfigParm(track, dfx, "param."..dparam..".plink.src_fx", tostring(sfx))
  reaper.TrackFX_SetNamedConfigParm(track, dfx, "param."..dparam..".plink.src_param", tostring(sparam))
  reaper.TrackFX_SetNamedConfigParm(track, dfx, "param."..dparam..".plink.scale", "1")
  reaper.TrackFX_SetNamedConfigParm(track, dfx, "param."..dparam..".plink.min", "0")
  reaper.TrackFX_SetNamedConfigParm(track, dfx, "param."..dparam..".plink.max", "1")
end

function loop()
  if not visible then return end
  reaper.ImGui_SetNextWindowSize(ctx, 400, 200, reaper.ImGui_Cond_FirstUseEver())
  local rv, open = reaper.ImGui_Begin(ctx, 'FX Param Linker', true)
  if rv then
    reaper.ImGui_Text(ctx, 'Selected track: first selected')

    _, src_fx = reaper.ImGui_InputInt(ctx, 'Source FX Index', src_fx)
    _, src_param = reaper.ImGui_InputInt(ctx, 'Source Param Index', src_param)
    _, dest_fx = reaper.ImGui_InputInt(ctx, 'Dest FX Index', dest_fx)
    _, dest_param = reaper.ImGui_InputInt(ctx, 'Dest Param Index', dest_param)

    if reaper.ImGui_Button(ctx, 'Link Now') then
      local track = reaper.GetSelectedTrack(0,0)
      if track then
        link_params(track, src_fx, src_param, dest_fx, dest_param)
        reaper.ShowMessageBox('Linked!', 'Done', 0)
      else
        reaper.ShowMessageBox('No track selected!', 'Error', 0)
      end
    end

    reaper.ImGui_End(ctx)
  end
  if open then
    reaper.defer(loop)
  else
    visible = false
  end
end

reaper.defer(loop)


