; ============================================================================
; ICST Cabbage -> ICST MultiEncoder Session
; ============================================================================
; Purpose:
;   Cabbage/Csound generates two independent mono sources and sends OSC position
;   data to the ICST AmbiEncoder / MultiEncoder in REAPER.
;
; Recommended REAPER signal flow:
;   Track 1  Cabbage Source Generator, 8 channels
;            ch1 = Source 1, ch2 = Source 2, ch3-8 = silent reserve
;      ->    Track 2  ICST_AmbiEncoder_Multi_8src or matching MultiEncoder
;      ->    Track 3  Bformat Master
;      ->    Track 4  ICST Decoder / binaural monitoring
;
; OSC:
;   Enable OSC input in the ICST MultiEncoder and set the input port to 50001.
;   This patch sends index-based AED messages:
;     /icst/ambi/sourceindex/aed 1 az el dist
;     /icst/ambi/sourceindex/aed 2 az el dist
;
; Workshop focus:
;   Cabbage is the generative source/controller. ICST plugins remain responsible
;   for Ambisonics encoding, decoder practice, B-format export, and monitoring.
;
; MIDI Learn:
;   All knobs have midilearn(1) enabled.
;   Rechtsklick auf einen Knob -> "MIDI Learn" -> Regler am Controller drehen.
; ============================================================================
<Cabbage>
form caption("ICST Cabbage -> MultiEncoder") size(760, 420), colour(20, 32, 45), pluginId("ICBG"), guiRefresh(40)
label bounds(16, 10, 730, 24), text("ICST Cabbage -> ICST MultiEncoder  ·  audio ch1/ch2 + OSC AED positions"), \
      align("left"), fontColour(170, 210, 235), fontSize(14)
label bounds(16, 34, 730, 18), text("REAPER: route this 8ch track to ICST_AmbiEncoder_Multi_8src, OSC input port 50001"), \
      align("left"), fontColour(120, 160, 190), fontSize(11)

; --- Source 1 ---
groupbox bounds(14, 66, 230, 150), text("Source 1 · tone"), colour(30, 50, 70), fontColour(170, 210, 235)
rslider bounds(26, 92, 78, 84), channel("freq1"), range(80, 1200, 220, 1, 1), text("Hz"), \
        colour(74, 158, 218), trackerColour(74, 158, 218), fontColour(230, 240, 250), midilearn(1)
rslider bounds(108, 92, 78, 84), channel("gain1"), range(0, 0.8, 0.25, 1, 0.001), text("Gain"), \
        colour(74, 158, 218), trackerColour(74, 158, 218), fontColour(230, 240, 250), midilearn(1)
checkbox bounds(30, 182, 170, 24), channel("mute1"), text("Mute S1"), value(0), \
         colour(74, 158, 218), fontColour(230, 240, 250)

; --- Source 2 ---
groupbox bounds(264, 66, 230, 150), text("Source 2 · filtered noise"), colour(30, 50, 70), fontColour(170, 210, 235)
rslider bounds(276, 92, 78, 84), channel("cut2"), range(120, 8000, 900, 1, 1), text("Cutoff"), \
        colour(74, 158, 218), trackerColour(74, 158, 218), fontColour(230, 240, 250), midilearn(1)
rslider bounds(358, 92, 78, 84), channel("gain2"), range(0, 0.8, 0.16, 1, 0.001), text("Gain"), \
        colour(74, 158, 218), trackerColour(74, 158, 218), fontColour(230, 240, 250), midilearn(1)
checkbox bounds(280, 182, 170, 24), channel("mute2"), text("Mute S2"), value(0), \
         colour(74, 158, 218), fontColour(230, 240, 250)

; --- OSC ---
groupbox bounds(514, 66, 230, 150), text("OSC to ICST MultiEncoder"), colour(30, 50, 70), fontColour(170, 210, 235)
checkbox bounds(528, 94, 180, 24), channel("oscOn"), text("Send OSC"), value(1), \
         colour(74, 158, 218), fontColour(230, 240, 250)
rslider bounds(528, 124, 78, 84), channel("oscRate"), range(2, 60, 25, 1, 1), text("Hz"), \
        colour(240, 180, 50), trackerColour(240, 180, 50), fontColour(230, 240, 250), midilearn(1)
label bounds(612, 132, 116, 54), text("Target:\n127.0.0.1:50001\nsourceindex/aed"), \
      align("left"), fontColour(170, 190, 205), fontSize(11)

; --- Movement S1 ---
groupbox bounds(14, 232, 355, 145), text("Movement S1"), colour(30, 50, 70), fontColour(170, 210, 235)
rslider bounds(26, 258, 78, 84), channel("az1"), range(-180, 180, -40, 1, 1), text("Az"), \
        colour(100, 180, 100), trackerColour(100, 180, 100), fontColour(230, 240, 250), midilearn(1)
rslider bounds(108, 258, 78, 84), channel("el1"), range(-80, 80, 0, 1, 1), text("El"), \
        colour(100, 180, 100), trackerColour(100, 180, 100), fontColour(230, 240, 250), midilearn(1)
rslider bounds(190, 258, 78, 84), channel("dist1"), range(0.1, 1.5, 0.8, 1, 0.01), text("Dist"), \
        colour(100, 180, 100), trackerColour(100, 180, 100), fontColour(230, 240, 250), midilearn(1)
rslider bounds(272, 258, 78, 84), channel("spin1"), range(0, 2, 0.18, 1, 0.01), text("Spin"), \
        colour(240, 180, 50), trackerColour(240, 180, 50), fontColour(230, 240, 250), midilearn(1)
checkbox bounds(30, 346, 160, 24), channel("auto1"), text("Auto move S1"), value(1), \
         colour(74, 158, 218), fontColour(230, 240, 250)

; --- Movement S2 ---
groupbox bounds(389, 232, 355, 145), text("Movement S2"), colour(30, 50, 70), fontColour(170, 210, 235)
rslider bounds(401, 258, 78, 84), channel("az2"), range(-180, 180, 50, 1, 1), text("Az"), \
        colour(100, 180, 100), trackerColour(100, 180, 100), fontColour(230, 240, 250), midilearn(1)
rslider bounds(483, 258, 78, 84), channel("el2"), range(-80, 80, 20, 1, 1), text("El"), \
        colour(100, 180, 100), trackerColour(100, 180, 100), fontColour(230, 240, 250), midilearn(1)
rslider bounds(565, 258, 78, 84), channel("dist2"), range(0.1, 1.5, 1.0, 1, 0.01), text("Dist"), \
        colour(100, 180, 100), trackerColour(100, 180, 100), fontColour(230, 240, 250), midilearn(1)
rslider bounds(647, 258, 78, 84), channel("spin2"), range(0, 2, 0.31, 1, 0.01), text("Spin"), \
        colour(240, 180, 50), trackerColour(240, 180, 50), fontColour(230, 240, 250), midilearn(1)
checkbox bounds(405, 346, 160, 24), channel("auto2"), text("Auto move S2"), value(1), \
         colour(74, 158, 218), fontColour(230, 240, 250)

label bounds(16, 392, 730, 18), text("Audio output: channel 1 = S1, channel 2 = S2. OSC controls ICST source indices 1 and 2."), \
      align("left"), fontColour(120, 160, 190), fontSize(11)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d
</CsOptions>
<CsInstruments>
sr      = 48000
ksmps   = 64
nchnls  = 8
0dbfs   = 1

instr 1
  ; ---- MIDI Fighter Twister (ch 1, CC 0-11) -------------------------
  ; ctrl7 liest CC-Wert; chnset aktualisiert GUI-Knob nur wenn bewegt.
  ; Encoder-Zuordnung:
  ;   CC 0  Hz S1    CC 1  Gain S1   CC 2  Cutoff S2  CC 3  Gain S2
  ;   CC 4  Az S1    CC 5  El S1     CC 6  Dist S1    CC 7  Spin S1
  ;   CC 8  Az S2    CC 9  El S2     CC 10 Dist S2    CC 11 Spin S2
  kcc0  ctrl7 1,  0,   80, 1200
  kcc1  ctrl7 1,  1,    0,  0.8
  kcc2  ctrl7 1,  2,  120, 8000
  kcc3  ctrl7 1,  3,    0,  0.8
  kcc4  ctrl7 1,  4, -180,  180
  kcc5  ctrl7 1,  5,  -80,   80
  kcc6  ctrl7 1,  6,  0.1,  1.5
  kcc7  ctrl7 1,  7,    0,    2
  kcc8  ctrl7 1,  8, -180,  180
  kcc9  ctrl7 1,  9,  -80,   80
  kcc10 ctrl7 1, 10,  0.1,  1.5
  kcc11 ctrl7 1, 11,    0,    2

  ktrig0  changed kcc0
  ktrig1  changed kcc1
  ktrig2  changed kcc2
  ktrig3  changed kcc3
  ktrig4  changed kcc4
  ktrig5  changed kcc5
  ktrig6  changed kcc6
  ktrig7  changed kcc7
  ktrig8  changed kcc8
  ktrig9  changed kcc9
  ktrig10 changed kcc10
  ktrig11 changed kcc11

  if ktrig0 == 1 then
    chnset kcc0, "freq1"
  endif
  if ktrig1 == 1 then
    chnset kcc1, "gain1"
  endif
  if ktrig2 == 1 then
    chnset kcc2, "cut2"
  endif
  if ktrig3 == 1 then
    chnset kcc3, "gain2"
  endif
  if ktrig4 == 1 then
    chnset kcc4, "az1"
  endif
  if ktrig5 == 1 then
    chnset kcc5, "el1"
  endif
  if ktrig6 == 1 then
    chnset kcc6, "dist1"
  endif
  if ktrig7 == 1 then
    chnset kcc7, "spin1"
  endif
  if ktrig8 == 1 then
    chnset kcc8, "az2"
  endif
  if ktrig9 == 1 then
    chnset kcc9, "el2"
  endif
  if ktrig10 == 1 then
    chnset kcc10, "dist2"
  endif
  if ktrig11 == 1 then
    chnset kcc11, "spin2"
  endif

  ; ---- MIDI Debug print (erscheint im Csound output console) --------
  printf "CC0  freq1  = %.1f\n",  ktrig0,  kcc0
  printf "CC1  gain1  = %.3f\n",  ktrig1,  kcc1
  printf "CC2  cut2   = %.1f\n",  ktrig2,  kcc2
  printf "CC3  gain2  = %.3f\n",  ktrig3,  kcc3
  printf "CC4  az1    = %.1f\n",  ktrig4,  kcc4
  printf "CC5  el1    = %.1f\n",  ktrig5,  kcc5
  printf "CC6  dist1  = %.2f\n",  ktrig6,  kcc6
  printf "CC7  spin1  = %.2f\n",  ktrig7,  kcc7
  printf "CC8  az2    = %.1f\n",  ktrig8,  kcc8
  printf "CC9  el2    = %.1f\n",  ktrig9,  kcc9
  printf "CC10 dist2  = %.2f\n",  ktrig10, kcc10
  printf "CC11 spin2  = %.2f\n",  ktrig11, kcc11

  ; ---- GUI-Werte lesen (ggf. gerade von MIDI aktualisiert) ----------
  kfreq1   chnget "freq1"
  kgain1   chnget "gain1"
  kgain2   chnget "gain2"
  kcut2    chnget "cut2"
  kmute1   chnget "mute1"
  kmute2   chnget "mute2"

  ; Movement controls
  kazBase1 chnget "az1"
  kel1     chnget "el1"
  kdist1   chnget "dist1"
  kspin1   chnget "spin1"
  kauto1   chnget "auto1"
  kazBase2 chnget "az2"
  kel2     chnget "el2"
  kdist2   chnget "dist2"
  kspin2   chnget "spin2"
  kauto2   chnget "auto2"
  koscOn   chnget "oscOn"
  koscRate chnget "oscRate"

  ; Source 1: simple beating tone
  a1a      oscili kgain1 * (1 - kmute1) * 0.65, kfreq1
  a1b      oscili kgain1 * (1 - kmute1) * 0.35, kfreq1 * 1.006
  asrc1    = a1a + a1b

  ; Source 2: filtered noise cloud
  anoise   noise kgain2 * (1 - kmute2), 0
  asrc2    butterlp anoise, kcut2

  ; Automatic source movement in AED coordinates, degrees.
  kautoAz1 lfo 80,  kspin1, 0
  kautoEl1 lfo 18,  kspin1 * 0.37, 0
  kaz1     = (kauto1 == 1 ? kazBase1 + kautoAz1 : kazBase1)
  kelOut1  = (kauto1 == 1 ? kel1 + kautoEl1 : kel1)

  kautoAz2 lfo 115, kspin2, 0
  kautoAz2 = kautoAz2 * (-1)            ; counter-rotation via inversion
  kautoEl2 lfo 22,  kspin2 * 0.29, 0
  kaz2     = (kauto2 == 1 ? kazBase2 + kautoAz2 : kazBase2)
  kelOut2  = (kauto2 == 1 ? kel2 + kautoEl2 : kel2)

  ; Send OSC to ICST MultiEncoder. Set ICST OSC input port to 50001.
  ktrig    metro koscRate
  ksend    = ktrig * koscOn
  OSCsend ksend, "127.0.0.1", 50001, "/icst/ambi/sourceindex/aed", "ifff", 1, kaz1, kelOut1, kdist1
  OSCsend ksend, "127.0.0.1", 50001, "/icst/ambi/sourceindex/aed", "ifff", 2, kaz2, kelOut2, kdist2

  ; Multichannel source output for the ICST MultiEncoder input track.
  outch 1, asrc1
  outch 2, asrc2

endin
</CsInstruments>
<CsScore>
i 1 0 3600
</CsScore>
</CsoundSynthesizer>
