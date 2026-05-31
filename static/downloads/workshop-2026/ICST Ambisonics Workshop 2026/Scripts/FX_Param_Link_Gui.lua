-- ReaScript Name: FX Parameter Link GUI (with Track/FX/Param selection)
-- Author: Reaper DAW Ultimate Assistant
-- Requires: ReaImGui extension

local ctx = reaper.ImGui_CreateContext('FX Param Linker')
local font = reaper.ImGui_CreateFont('sans-serif', 14)
reaper.ImGui_Attach(ctx, font)

local track_count = reaper.CountTracks(0)
local track_names = {}
for i = 0, track_count-1 do
  local tr = reaper.GetTrack(0,i)
  local _, name = reaper.GetSetMediaTrackInfo_String(tr, 'P_NAME', '', false)
  track_names[i] = (name ~= '' and name or ('Track '..(i+1)))
end

local selected_track = 0
local fx_count = 0
local fx_names = {}
local selected_fx = 0
local param_count = 0
local param_names = {}
local selected_param = 0

-- Quelle für Mapping (vereinfachte Eingabe):
local src_fx = 0
local src_param = 0

function update_fx_list()
  fx_count = reaper.TrackFX_GetCount(reaper.GetTrack(0,selected_track))
  fx_names = {}
  for i = 0, fx_count-1 do
    local retval, fx_name = reaper.TrackFX_GetFXName(reaper.GetTrack(0,selected_track), i, '')
    fx_names[i] = fx_name
  end
  selected_fx = math.min(selected_fx, fx_count-1)
  update_param_list()
end

function update_param_list()
  param_count = reaper.TrackFX_GetNumParams(reaper.GetTrack(0,selected_track), selected_fx)
  param_names = {}
  for i = 0, param_count-1 do
    local _, pname = reaper.TrackFX_GetParamName(reaper.GetTrack(0,selected_track), selected_fx, i, '')
    param_names[i] = pname
  end
  selected_param = math.min(selected_param, param_count-1)
end

update_fx_list()

function link_params()
  local track = reaper.GetTrack(0, selected_track)
  reaper.TrackFX_SetNamedConfigParm(track, selected_fx, "param."..selected_param..".plink.active", "1")
  reaper.TrackFX_SetNamedConfigParm(track, selected_fx, "param."..selected_param..".plink.src_tr", tostring(reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")-1))
  reaper.TrackFX_SetNamedConfigParm(track, selected_fx, "param."..selected_param..".plink.src_fx", tostring(src_fx))
  reaper.TrackFX_SetNamedConfigParm(track, selected_fx, "param."..selected_param..".plink.src_param", tostring(src_param))
  reaper.TrackFX_SetNamedConfigParm(track, selected_fx, "param."..selected_param..".plink.scale", "1")
  reaper.TrackFX_SetNamedConfigParm(track, selected_fx, "param."..selected_param..".plink.min", "0")
  reaper.TrackFX_SetNamedConfigParm(track, selected_fx, "param."..selected_param..".plink.max", "1")
  reaper.ShowMessageBox("Linked!", "Done", 0)
end

function loop()
  reaper.ImGui_PushFont(ctx, font)
  local visible, open = reaper.ImGui_Begin(ctx, 'FX Param Linker', true)
  if visible then
    if reaper.ImGui_BeginCombo(ctx, 'Select Track', track_names[selected_track]) then
      for i,name in pairs(track_names) do
        if reaper.ImGui_Selectable(ctx, name, i==selected_track) then
          selected_track = i
          update_fx_list()
        end
      end
      reaper.ImGui_EndCombo(ctx)
    end

    if fx_count > 0 then
      if reaper.ImGui_BeginCombo(ctx, 'Select FX', fx_names[selected_fx] or '?') then
        for i,name in pairs(fx_names) do
          if reaper.ImGui_Selectable(ctx, name, i==selected_fx) then
            selected_fx = i
            update_param_list()
          end
        end
        reaper.ImGui_EndCombo(ctx)
      end
    end

    if param_count > 0 then
      if reaper.ImGui_BeginCombo(ctx, 'Select Parameter', param_names[selected_param] or '?') then
        for i,name in pairs(param_names) do
          if reaper.ImGui_Selectable(ctx, name, i==selected_param) then
            selected_param = i
          end
        end
        reaper.ImGui_EndCombo(ctx)
      end
    end

    reaper.ImGui_Separator(ctx)
    reaper.ImGui_Text(ctx, 'Source FX index (on same track):')
    _, src_fx = reaper.ImGui_InputInt(ctx, 'Src FX', src_fx)
    _, src_param = reaper.ImGui_InputInt(ctx, 'Src Param', src_param)

    if reaper.ImGui_Button(ctx, 'Link Now') then
      link_params()
    end

    reaper.ImGui_End(ctx)
  end
  reaper.ImGui_PopFont(ctx)
  if open then reaper.defer(loop) end
end

reaper.defer(loop)


