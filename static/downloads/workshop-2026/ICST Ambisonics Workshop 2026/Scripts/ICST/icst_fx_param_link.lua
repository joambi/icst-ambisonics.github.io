-- ReaScript Name: FX Parameter Link GUI (with Track/FX/Param selection for Source and Destination)
-- Author: Reaper DAW Ultimate Assistant
-- Requires: ReaImGui extension

local ctx = reaper.ImGui_CreateContext('FX Param Linker')
local font = reaper.ImGui_CreateFont('sans-serif', 14)
reaper.ImGui_Attach(ctx, font)

-- Helper to get track names
local function get_track_names()
  local names = {}
  for i = 0, reaper.CountTracks(0)-1 do
    local tr = reaper.GetTrack(0,i)
    local _, name = reaper.GetSetMediaTrackInfo_String(tr, 'P_NAME', '', false)
    names[i] = (name ~= '' and name or ('Track '..(i+1)))
  end
  return names
end

-- Data for source and destination
local track_names = get_track_names()

-- Source selection
local src_track = 0
local src_fx = 0
local src_param = 0
local src_fx_names = {}
local src_param_names = {}
local src_fx_count, src_param_count = 0,0

-- Destination selection
local dst_track = 0
local dst_fx = 0
local dst_param = 0
local dst_fx_names = {}
local dst_param_names = {}
local dst_fx_count, dst_param_count = 0,0

local function update_fx_list_for(track_idx)
  local tr = reaper.GetTrack(0,track_idx)
  local fxnames = {}
  local fxcount = reaper.TrackFX_GetCount(tr)
  for i=0,fxcount-1 do
    local _, fxname = reaper.TrackFX_GetFXName(tr,i,'')
    fxnames[i] = fxname
  end
  return fxnames, fxcount
end

local function update_param_list_for(track_idx, fx_idx)
  local tr = reaper.GetTrack(0,track_idx)
  local pnames = {}
  local pcount = reaper.TrackFX_GetNumParams(tr, fx_idx)
  for i=0,pcount-1 do
    local _, pname = reaper.TrackFX_GetParamName(tr,fx_idx,i,'')
    pnames[i] = pname
  end
  return pnames, pcount
end

local function refresh_all()
  src_fx_names, src_fx_count = update_fx_list_for(src_track)
  src_param_names, src_param_count = update_param_list_for(src_track, src_fx)
  dst_fx_names, dst_fx_count = update_fx_list_for(dst_track)
  dst_param_names, dst_param_count = update_param_list_for(dst_track, dst_fx)
end

refresh_all()

local function link_params()
  local track = reaper.GetTrack(0, dst_track)
  reaper.TrackFX_SetNamedConfigParm(track, dst_fx, "param."..dst_param..".plink.active", "1")
  reaper.TrackFX_SetNamedConfigParm(track, dst_fx, "param."..dst_param..".plink.src_tr", tostring(src_track))
  reaper.TrackFX_SetNamedConfigParm(track, dst_fx, "param."..dst_param..".plink.src_fx", tostring(src_fx))
  reaper.TrackFX_SetNamedConfigParm(track, dst_fx, "param."..dst_param..".plink.src_param", tostring(src_param))
  reaper.TrackFX_SetNamedConfigParm(track, dst_fx, "param."..dst_param..".plink.scale", "1")
  reaper.TrackFX_SetNamedConfigParm(track, dst_fx, "param."..dst_param..".plink.min", "0")
  reaper.TrackFX_SetNamedConfigParm(track, dst_fx, "param."..dst_param..".plink.max", "1")
  reaper.ShowMessageBox("Linked!", "Done", 0)
end

function loop()
  reaper.ImGui_PushFont(ctx, font)
  local visible, open = reaper.ImGui_Begin(ctx, 'FX Param Linker', true)
  if visible then
    reaper.ImGui_Text(ctx, 'Source (driving)')
    if reaper.ImGui_BeginCombo(ctx, 'Source Track', track_names[src_track]) then
      for i,name in pairs(track_names) do
        if reaper.ImGui_Selectable(ctx,name,i==src_track) then
          src_track=i; refresh_all()
        end
      end
      reaper.ImGui_EndCombo(ctx)
    end
    if src_fx_count>0 then
      if reaper.ImGui_BeginCombo(ctx,'Source FX',src_fx_names[src_fx] or '?') then
        for i,name in pairs(src_fx_names) do
          if reaper.ImGui_Selectable(ctx,name,i==src_fx) then
            src_fx=i; src_param_names,src_param_count = update_param_list_for(src_track,src_fx)
          end
        end
        reaper.ImGui_EndCombo(ctx)
      end
    end
    if src_param_count>0 then
      if reaper.ImGui_BeginCombo(ctx,'Source Param',src_param_names[src_param] or '?') then
        for i,name in pairs(src_param_names) do
          if reaper.ImGui_Selectable(ctx,name,i==src_param) then src_param=i end
        end
        reaper.ImGui_EndCombo(ctx)
      end
    end

    reaper.ImGui_Separator(ctx)
    reaper.ImGui_Text(ctx,'Destination (to be linked)')
    if reaper.ImGui_BeginCombo(ctx, 'Dest Track', track_names[dst_track]) then
      for i,name in pairs(track_names) do
        if reaper.ImGui_Selectable(ctx,name,i==dst_track) then
          dst_track=i; refresh_all()
        end
      end
      reaper.ImGui_EndCombo(ctx)
    end
    if dst_fx_count>0 then
      if reaper.ImGui_BeginCombo(ctx,'Dest FX',dst_fx_names[dst_fx] or '?') then
        for i,name in pairs(dst_fx_names) do
          if reaper.ImGui_Selectable(ctx,name,i==dst_fx) then
            dst_fx=i; dst_param_names,dst_param_count = update_param_list_for(dst_track,dst_fx)
          end
        end
        reaper.ImGui_EndCombo(ctx)
      end
    end
    if dst_param_count>0 then
      if reaper.ImGui_BeginCombo(ctx,'Dest Param',dst_param_names[dst_param] or '?') then
        for i,name in pairs(dst_param_names) do
          if reaper.ImGui_Selectable(ctx,name,i==dst_param) then dst_param=i end
        end
        reaper.ImGui_EndCombo(ctx)
      end
    end

    reaper.ImGui_Separator(ctx)
    if reaper.ImGui_Button(ctx,'Link Now') then
      link_params()
    end

    reaper.ImGui_End(ctx)
  end
  reaper.ImGui_PopFont(ctx)
  if open then reaper.defer(loop) end
end

reaper.defer(loop)


