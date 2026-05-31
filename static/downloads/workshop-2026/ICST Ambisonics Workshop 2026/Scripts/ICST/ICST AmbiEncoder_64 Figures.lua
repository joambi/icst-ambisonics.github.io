-- AmbiEncoder_64 Figurenfahrt Automation mit ReaImGui GUI
-- Offset: je näher an der Mitte (0.0), desto größer; bei -1.0 und 1.0 kleiner
-- Muster: Dreieck, Zickzack, Kreis, Ellipse, Rechteck, Herz, Lissajous, Acht, Spirale
-- Speed-Slider, Punkt-Offset
-- Figur bleibt am Ende stehen (kein Zurückspringen)
-- Punkte werden so berechnet, dass der Abstand gleich bleibt (nach Weglänge, nicht nur p-Schritte)

local ctx = reaper.ImGui_CreateContext('AmbiEncoder Figurenfahrt')
local point_count = 128
local height = 0.0
local use_z = true
local pattern_mode = 0
local zick_segments = 8
local speed_factor = 1.0
local point_offset = 0.0

local track_indices = {0}
local fx_index = 0

local x_params = {10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85}
local y_params = {11,16,21,26,31,36,41,46,51,56,61,66,71,76,81,86}
local z_params = {12,17,22,27,32,37,42,47,52,57,62,67,72,77,82,87}

local function clamp(v,min,max)
  if v<min then return min elseif v>max then return max else return v end
end

local trianglePoints = {{-1,-1},{1,-1},{0,1},{-1,-1}}
local function sample_path(points)
  local lengths = {}
  local total = 0
  for i=1,#points-1 do
    local dx = points[i+1][1]-points[i][1]
    local dy = points[i+1][2]-points[i][2]
    local segLen = math.sqrt(dx*dx+dy*dy)
    lengths[i] = segLen
    total = total + segLen
  end
  local samples = {}
  for s=0,point_count-1 do
    local dist = (s/(point_count-1))*total
    local acc = 0
    for i=1,#lengths do
      if dist <= acc + lengths[i] then
        local t = (dist-acc)/lengths[i]
        local x = points[i][1] + (points[i+1][1]-points[i][1])*t
        local y = points[i][2] + (points[i+1][2]-points[i][2])*t
        samples[#samples+1] = {x,y}
        break
      end
      acc = acc + lengths[i]
    end
  end
  return samples
end

local function get_triangle_samples()
  return sample_path(trianglePoints)
end

local function get_zickzack_samples()
  local pts = {}
  local step = 2/(zick_segments)
  for i=0,zick_segments do
    local x = -1 + step*i
    local y = (i%2==0) and -1 or 1
    pts[#pts+1] = {x,y}
  end
  return sample_path(pts)
end

local function get_circle_samples()
  local pts = {}
  local steps = 360
  for i=0,steps do
    local a = (i/steps)*2*math.pi
    pts[#pts+1] = {math.cos(a), math.sin(a)}
  end
  return sample_path(pts)
end

local function get_ellipse_samples()
  local pts = {}
  local steps = 360
  for i=0,steps do
    local a = (i/steps)*2*math.pi
    pts[#pts+1] = {0.8*math.cos(a), 0.4*math.sin(a)}
  end
  return sample_path(pts)
end

local function get_rectangle_samples()
  local pts={{-1,-1},{1,-1},{1,1},{-1,1},{-1,-1}}
  return sample_path(pts)
end

local function get_heart_samples()
  local pts={}
  local steps=360
  for i=0,steps do
    local t=(i/steps)*2*math.pi
    local x=16*math.sin(t)^3/20
    local y=(13*math.cos(t)-5*math.cos(2*t)-2*math.cos(3*t)-math.cos(4*t))/20
    pts[#pts+1]={clamp(x,-1,1),clamp(y,-1,1)}
  end
  return sample_path(pts)
end

local function get_lissajous_samples()
  local pts={}
  local steps=360
  for i=0,steps do
    local t=(i/steps)*2*math.pi
    pts[#pts+1]={math.sin(3*t),math.sin(2*t)}
  end
  return sample_path(pts)
end

local function get_eight_samples()
  local pts={}
  local steps=360
  for i=0,steps do
    local t=(i/steps)*2*math.pi
    pts[#pts+1]={math.sin(t),math.sin(t)*math.cos(t)}
  end
  return sample_path(pts)
end

local function get_spiral_samples()
  local pts={}
  local steps=360
  for i=0,steps do
    local t=(i/steps)*4*math.pi
    local r=i/steps
    pts[#pts+1]={clamp(r*math.cos(t),-1,1),clamp(r*math.sin(t),-1,1)}
  end
  return sample_path(pts)
end

local pattern_functions={get_triangle_samples,get_zickzack_samples,get_circle_samples,get_ellipse_samples,get_rectangle_samples,get_heart_samples,get_lissajous_samples,get_eight_samples,get_spiral_samples}

function create_motion()
  local start_time,end_time=reaper.GetSet_LoopTimeRange(false,false,0,0,false)
  if start_time==end_time then reaper.ShowMessageBox("Keine Region Selection aktiv!","Fehler",0)return end
  local dur=end_time-start_time
  local scaled_dur=dur/speed_factor
  local samples = pattern_functions[pattern_mode+1]()
  for idxParam=1,#x_params do
    for _,trk_idx in ipairs(track_indices) do
      local track=reaper.GetTrack(0,trk_idx)
      if track then
        local envX=reaper.GetFXEnvelope(track,fx_index,x_params[idxParam],true)
        local envY=reaper.GetFXEnvelope(track,fx_index,y_params[idxParam],true)
        local envZ=use_z and reaper.GetFXEnvelope(track,fx_index,z_params[idxParam],true) or nil
        if envX and envY then
          reaper.DeleteEnvelopePointRange(envX,start_time,end_time)
          reaper.DeleteEnvelopePointRange(envY,start_time,end_time)
          if envZ then reaper.DeleteEnvelopePointRange(envZ,start_time,end_time) end
          local posNorm=(idxParam-1)/(#x_params-1)
          local distCenter=math.abs((posNorm*2)-1)
          local proximity=1.0-distCenter
          local scaled_offset_angle=math.rad(point_offset*proximity)
          for i,s in ipairs(samples) do
            local px,py=s[1],s[2]
            local ox=px*math.cos(scaled_offset_angle)-py*math.sin(scaled_offset_angle)
            local oy=px*math.sin(scaled_offset_angle)+py*math.cos(scaled_offset_angle)
            local t=start_time+((i-1)/(#samples-1))*scaled_dur
            reaper.InsertEnvelopePoint(envX,t,(ox+1)/2,0,0,false,true)
            reaper.InsertEnvelopePoint(envY,t,(oy+1)/2,0,0,false,true)
            if envZ then reaper.InsertEnvelopePoint(envZ,t,(clamp(height,-1,1)+1)/2,0,0,false,true) end
          end
          local last=samples[#samples]
          local lx,ly=last[1],last[2]
          local ox=lx*math.cos(scaled_offset_angle)-ly*math.sin(scaled_offset_angle)
          local oy=lx*math.sin(scaled_offset_angle)+ly*math.cos(scaled_offset_angle)
          reaper.InsertEnvelopePoint(envX,end_time,(ox+1)/2,0,0,false,true)
          reaper.InsertEnvelopePoint(envY,end_time,(oy+1)/2,0,0,false,true)
          if envZ then reaper.InsertEnvelopePoint(envZ,end_time,(clamp(height,-1,1)+1)/2,0,0,false,true) end
          reaper.Envelope_SortPoints(envX)
          reaper.Envelope_SortPoints(envY)
          if envZ then reaper.Envelope_SortPoints(envZ) end
        end
      end
    end
  end
  local names={"Dreieck","Zickzack","Kreis","Ellipse","Rechteck","Herz","Lissajous","Acht","Spirale"}
  reaper.ShowMessageBox(names[pattern_mode+1].."-Fahrt erstellt (gleichmäßiger Abstand)!","Fertig",0)
end

function loop()
  local visible,open=reaper.ImGui_Begin(ctx,'AmbiEncoder Figurenfahrt',true,reaper.ImGui_WindowFlags_AlwaysAutoResize())
  if visible then
    local ch1,np=reaper.ImGui_InputInt(ctx,'Punktanzahl',point_count);if ch1 then point_count=math.max(2,np) end
    local ch3,h=reaper.ImGui_SliderDouble(ctx,'Z-Höhe',height,-1,1);if ch3 then height=h end
    local chs,sf=reaper.ImGui_SliderDouble(ctx,'Speed Faktor',speed_factor,0.1,5.0);if chs then speed_factor=sf end
    local cho,po=reaper.ImGui_SliderDouble(ctx,'Punkt-Offset (Grad)',point_offset,-180,180);if cho then point_offset=po end
    local chz,uZ=reaper.ImGui_Checkbox(ctx,'Z verwenden',use_z);if chz then use_z=uZ end
    local items="Dreieck\0Zickzack\0Kreis\0Ellipse\0Rechteck\0Herz\0Lissajous\0Acht\0Spirale\0"
    local rv,pm=reaper.ImGui_Combo(ctx,'Muster',pattern_mode,items);if rv then pattern_mode=pm end
    if reaper.ImGui_Button(ctx,'Figurenfahrt erstellen') then create_motion() end
    reaper.ImGui_End(ctx)
  end
  if open then reaper.defer(loop) end
end

reaper.defer(loop)

