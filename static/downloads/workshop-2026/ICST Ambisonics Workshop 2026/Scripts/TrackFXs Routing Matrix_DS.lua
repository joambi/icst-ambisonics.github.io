--[[--
    eugen2777: http://forum.cockos.com/showthread.php?t=173867
    DarkStar:  mods, for connector pin colours, 
               pin numbers (Alt_click) and wire (Alt_right_click)
    version: c01
--]]--
---------------------------------------------------------------------------------------------------
function pointIN(x,y,w,h)
  return mouse_ox >= x and mouse_ox <= x + w and mouse_oy >= y and mouse_oy <= y + h and
         gfx.mouse_x >= x and gfx.mouse_x <= x + w and gfx.mouse_y  >= y and gfx.mouse_y <= y + h
end
-----
function mouseClick()
  return gfx.mouse_cap&1==0 and last_mouse_cap&1==1
end
function mouseRightClick()
  return gfx.mouse_cap&2==0 and last_mouse_cap&2==2
end
----------------------------------------------------------------------------------------------------

------------------------------------------------
function draw_pin_number(x,y,i)
------------------------------------------------
    if i < 10 then gfx.x =x+4 else gfx.x =x end
    gfx.y =y-1
    gfx.set(0.1,0.1,0.2)--set id color
    gfx.printf("%d",i)
end

------------------------------------------------
function set_colour(i)
------------------------------------------------
-- red / cyan
    if i %2 == 0 then gfx.set(0.60, 0.20, 0.00)
                 else gfx.set(0.00, 0.70, 0.60)
    end
--[[
-- red / yellow
    if i %2 == 0 then gfx.set(0.60, 0.20, 0.00)
                 else gfx.set(0.60, 0.60, 0.00)
    end
]]--
-- red / green
--[[
    if i %2 == 0 then gfx.set(0.60, 0.00, 0.00)
                 else gfx.set(0.00, 0.70, 0.00)
    end
]]--    
end

------------------------------------------------
function set_greys(i)
------------------------------------------------
    if i%2==0 then gfx.set(0.6,0.6,0.6, 1) 
              else gfx.set(0.4,0.4,0.4, 1)
    end

end

------------------------------------------------
function draw_pin(track,fx,isOut,pin,chans, x,y,w,h)
------------------------------------------------

 local Low32,Hi32 = reaper.TrackFX_GetPinMappings(track, fx, isOut, pin)--Get current pin
 local bit,val,y0
 local Click = mouseClick()

    set_colour(pin+1)
    y0 =y-30
    --------------------------------------
    --draw(and change val if Clicked)-------
    for i = 1, chans do
        bit = 2^(i-1)       --cuurent bit
        val = (Low32&bit)>0 --current bit(aka channel value as booleen)
            if Click and pointIN(x,y,w,h-1) then
                if val then Low32 = Low32 - bit else Low32 = Low32 + bit end 
                reaper.TrackFX_SetPinMappings(track, fx, isOut , pin, Low32, Hi32)--Set pin 
            end
        if val and reaper.TrackFX_GetEnabled(track,fx) then gfx.a = 1 else gfx.a = 0.3 end --set gfx.a
        gfx.rect(x,y,w-2,h-2, val) --bool = val      

-- DarkStar (pin numbers and wires)
        if val and reaper.TrackFX_GetEnabled(track,fx) then
            if show_pins > 0 then draw_pin_number(x,y,pin+1) end
            set_colour(i) 
            if show_wires > 0 then
                if grey_wires > 0 then set_greys(i) end
                if isOut == 0  then 
                   gfx.line(last_in[i-1]+w-2,y+h/2,x-1,y+h/2)
                end
                gfx.line(x+w/2,y0,x+w/2,y-1)
            end

            last_in[i-1] = x
        end
------------
        y = y + h --next y
    end 
    --------------------------------------
end


--------------------------------------------------------
function draw_FX_head(track,fx,in_Pins,out_Pins, x,y,w,h)
------------------------------------------------
  local _, ps_name = reaper.TrackFX_GetPreset(track, fx, "")
  local _, fx_name = reaper.TrackFX_GetFXName(track, fx, ""); fx_name = fx_name:match(" %P+")

    --draw head and name----------
    y,w,h = y-w ,w*(in_Pins+out_Pins+1.2)-2,h-1 --correct values for head position
    gfx.set(0.5,0.7,0)--set head color
    if reaper.TrackFX_GetEnabled(track,fx) then gfx.a = 1 else gfx.a = 0.3 end --if FX enabled/disabled
       -----------------------
       gfx.x, gfx.y = x, y+(h-gfx.texth)/2
       gfx.rect(x,y,w,h,false) 
       gfx.printf("%.16s",fx_name) -- was %.12s

    --Open-Close FX on click-- 
    if mouseClick() and pointIN(x,y,w,h) then
       reaper.TrackFX_SetOpen(track, fx, not reaper.TrackFX_GetOpen(track, fx) )--not bool for change state
    end
end


--------------------------------------------------------
function draw_FX(track,fx,chans, x,y,w,h)
------------------------------------------------
 local _, in_Pins,out_Pins = reaper.TrackFX_GetIOSize(track,fx) 
 --for some JS-plug-ins---------------------------------
  if out_Pins==-1 and in_Pins~=-1 then out_Pins=in_Pins end --in some JS outs ret "-1" 

  ---------------------------------
  draw_FX_head(track,fx,in_Pins,out_Pins, x,y,w,h)

  --------------------------------
  --Draw FX pins,chans etc-- 
    --input pins---
    local isOut=0
    for i=1,in_Pins do
        draw_pin(track,fx,isOut, i-1,chans, x,y+ZZ,w,h)--(track,fx,isOut, pin,chans, x,y,  w,h)
        x = x + w --next x
    end
    ---------------
    x = x + 1.2*w --Gap between FX in-out pins
    ---------------
    --output pins--
    local isOut=1 
    for i=1,out_Pins do
        draw_pin(track,fx,isOut, i-1,chans, x,y+ZZ,w,h)--(track,fx,isOut, pin,chans, x,y,  w,h)
        x = x + w --next x
    end   
 return x --return x value for next FX position
end


------------------------------------------------
function draw_track_chan_add_sub(track,chans, x,y,w,h)
------------------------------------------------
       -- "-" --
     gfx.set(0.9,0.8,0, 0.5)
     x = x+1.5*w ; y = y + h*(chans-1.5)
y =y + h*2
     w, h = w-2, h-2
     local s_w, s_h = gfx.measurestr("-")
     gfx.x, gfx.y = x + (w-s_w)/2 , y + (h-s_h)/2
     gfx.rect(x,y,w,h, 0);  gfx.printf("-")
     gfx.printf("   Remove last 2 channels")

     if mouseClick() and pointIN(x,y,w,h) then 
         reaper.SetMediaTrackInfo_Value(track, "I_NCHAN", math.max(chans-2,2))  end 
       -- "+" --
     y = y+h+8; 
     s_w, s_h = gfx.measurestr("+")
     gfx.x, gfx.y = x + (w-s_w)/2 , y + (h-s_h)/2 
     gfx.set(0.9,0.8,0, 0.5)
     gfx.rect(x,y,w,h, 0); gfx.printf("+")
     gfx.printf("   Add 2 more channels")

     if mouseClick() and pointIN(x,y,w,h) then
         reaper.SetMediaTrackInfo_Value(track, "I_NCHAN", math.min(chans+2,32)) end 
end


------------------------------------------------
function draw_track_in_out(type,track,chans, x,y,w,h)
------------------------------------------------

    if type == "IN" then for i=0,chans do last_in[i] =x end end

    gfx.x, gfx.y = x, y-2*w
    gfx.set(0.9,0.8,0, 1)
    gfx.printf(type)
    for i=1,chans do 
        set_greys(i)
        gfx.rect(x,y,w-2,h-2, 1)

        if show_pins > 0 then draw_pin_number(x,y,i) end
        y = y + h
     end
end


------------------------------------------------
function DRAW()
------------------------------------------------
 local w,h = Z,Z --its only one chan(rectangle) w and h (but it used in all calculation)
 local x,y = 4*w, 4*h  --its first pin of first FX    x and y (but it used in all calculation) 
 local M_Wheel
 local y0 = w
 ----
 local track = reaper.GetSelectedTrack(0, 0)
   if track then 
      local _, track_name = reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "", false)
      local fx_count = reaper.TrackFX_GetCount(track)
      local chans = math.min( reaper.GetMediaTrackInfo_Value(track, "I_NCHAN"), 32 ) -- max value for visible chans

    --------------------------------------------------------
    ---Zoom------
     if Ctrl and not Shift then M_Wheel = gfx.mouse_wheel;gfx.mouse_wheel = 0
        if M_Wheel>0 then Z = math.min(Z+1, 30) elseif M_Wheel<0 then Z = math.max(Z-1, 8) end
        gfx.setfont(1,"Calibri", Z)
        ZZ = Z *2
     end
     ---Rewind---
     if Shift and not Ctrl then M_Wheel = gfx.mouse_wheel;gfx.mouse_wheel = 0
        if M_Wheel>0 then R = math.min(R+1, fx_count) elseif M_Wheel<0 then R = math.max(R-1, 1) end
        gfx.setfont(1,"Calibri", Z)
     end

-- DarkStar
---Display / hide the pin numbers and wires ---
    if Alt and mouseClick() then show_pins = 1 - show_pins end
    if Alt and mouseRightClick() then show_wires = 1 - show_wires end

    --------------------------------------
    --draw track info(name,fx count etc)--
      gfx.set(0.9,0.7,0, 1)
      gfx.x, gfx.y = y, h
      gfx.printf("Track: " .. track_name.."     FXs: "..fx_count )
    --------------------------------------
    --draw track in,chan_add_sub----------
      draw_track_in_out("IN", track,chans, w,y+ZZ,w,h)
      draw_track_chan_add_sub(track,chans, w,y+ZZ,w,h) 
    --draw each FX(pins,chans etc)--------
       for i=R, fx_count do --R = 1-st drawing FX(used for rewind FXs)
           x = draw_FX(track, i-1,chans, x,y,w,h) + w*2 -- offset for next FX
       end 
    --------------------------------------
    --draw track out----------------------
      draw_track_in_out("OUT",track,chans, x,y+ZZ,w,h)

      if show_wires > 0 then
          y=y+ZZ +h/2
          for i= 1, chans do
              if grey_wires > 0 then set_greys(i) else set_colour(i) end
              if last_in[i-1] > y0 then
                  gfx.line(last_in[i-1]+w-2,y,x-1,y)
              end
              y =y+h
          end
        end
    ----------------------------
    else gfx.set(0.9,0.7,0, 1); gfx.x, gfx.y = 4*w, h; gfx.printf("Track:  " .. "None selected!") 
   end

end
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
---INIT---------------------------------------------------------------------------------------------
Z  = 15 --used as cell w,h(and for change zoom level etc)
ZZ = 30
R = 1  --used for rewind FXs
gfx.clear=1315860
gfx.init( "Track / FX Pins", 750,355 )
gfx.setfont(1,"Calibri", Z)
last_mouse_cap=0
mouse_dx, mouse_dy =0,0

show_pins  = 0
show_wires = 0
grey_wires = 0

if CCC == nil then CCC =1 end
if CCC > 0 then CCC = CCC +1 end
last_in = {} -- used to store that previous node used on each channel


---------------------------------------
function mainloop()
---------------------------------------
 if gfx.mouse_cap&1==1 or gfx.mouse_cap&2==2 and last_mouse_cap&1==0 then 
    mouse_ox, mouse_oy = gfx.mouse_x, gfx.mouse_y 
 end
 Ctrl  = gfx.mouse_cap&4==4
 Shift = gfx.mouse_cap&8==8
 Alt   = gfx.mouse_cap&16==16

 ----------------------
 --MAIN DRAW function--
 DRAW()
 ----------------------
 last_mouse_cap = gfx.mouse_cap
 last_x,last_y = gfx.mouse_x,gfx.mouse_y
 if gfx.getchar()~=-1 then reaper.defer(mainloop) end --defer
-- adds code to be called back by REAPER; used to create persistent ReaScripts
-- that continue to run and respond to input, while the user does other tasks.
 gfx.update();
end

---------------------------------------
mainloop()

