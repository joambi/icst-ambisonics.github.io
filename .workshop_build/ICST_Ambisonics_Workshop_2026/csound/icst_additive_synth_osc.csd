; Written by Iain McCurdy, 2006
; Modified for QuteCsound by René, September 2010
; Cabbage / 16-channel version — ICST Ambisonics Workshop
; OSC Random XYZ added 2026 — sends /icst/ambi/source/xyz to AmbiEncoder_64 Port 50001
;
; 30 partials → 16 ch:  P1–P16 → Ch1–16,  P17–P30 → Ch1–14 (summed)
; Reverb: mono-summed, broadcast to all 16 ch equally.
<Cabbage>
form caption("Additive Synth 30P | 16 Ch") size(1200, 520), guiMode("queue"), pluginId("AS30"), colour(28,28,35)
; ── XY pad + Wertanzeige ─────────────────────────────────────────────────────
xypad  bounds(5,5,188,90) text("X=Partial  Y=Amplitude") channel("X_Part","Y_Amp") rangeX(1,31,5,1,1) rangeY(0,1,0.5,1,0.001) colour(50,80,120) fontColour(180,210,255)
; Wertanzeige Zeile 1: Partial-Nr und Amplitude
label  bounds(5,96,22,12)   text("X:")    align("right")  fontColour(120,170,220) fontSize(10)
label  bounds(28,96,30,12)  text("5")     channel("XY_X_Display")  align("left")  fontColour(160,210,255) fontSize(10)
label  bounds(62,96,22,12)  text("Y:")    align("right")  fontColour(120,170,220) fontSize(10)
label  bounds(85,96,50,12)  text("0.50")  channel("XY_Y_Display")  align("left")  fontColour(160,210,255) fontSize(10)
; Wertanzeige Zeile 2: Fund Hz (MIDI oder Slider)
label  bounds(5,109,42,12)  text("Fund Hz:") align("right") fontColour(90,160,110) fontSize(10)
label  bounds(48,109,145,12) text("---")  channel("Fund_Freq_Value") align("left") fontColour(120,220,150) fontSize(10)
; MIDI-Indikator (rechts neben X/Y Display, freier Platz ab x=136)
label  bounds(136,96,57,12) text("MIDI:--")  channel("MidiNoteDisp") align("left") fontColour(140,160,255) fontSize(10)
; ── Global controls ───────────────────────────────────────────────────────────
groupbox bounds(198,5,380,108) text("GLOBAL") colour(42,42,52) fontColour(190,190,190)
rslider  bounds(205,22,82,82)  text("Fund Hz")    channel("Fund_Freq")     range(0,1,0.167,1,0.001)    textBox(1) colour(80,180,120) fontColour(210,210,210)
rslider  bounds(293,22,82,82)  text("Amplitude")  channel("Amplitude")     range(0,1,0.5,1,0.001)      textBox(1) colour(80,180,120) fontColour(210,210,210)
rslider  bounds(381,22,82,82)  text("Amp Port")   channel("Amp_Fund_Port") range(0,5,0.1,1,0.001)      textBox(1) colour(80,180,120) fontColour(210,210,210)
rslider  bounds(469,22,82,82)  text("Ratio Port") channel("Ratio_Port")    range(0,5,0.1,1,0.001)      textBox(1) colour(80,180,120) fontColour(210,210,210)
; ── Envelope ──────────────────────────────────────────────────────────────────
groupbox bounds(583,5,185,108) text("ENVELOPE") colour(42,42,52) fontColour(190,190,190)
rslider  bounds(590,22,87,82)  text("Attack s")   channel("Attack_Time")   range(0.001,5,0.05,1,0.001) textBox(1) colour(100,160,240) fontColour(210,210,210)
rslider  bounds(679,22,87,82)  text("Release s")  channel("Release_Time")  range(0.001,10,0.5,1,0.001) textBox(1) colour(100,160,240) fontColour(210,210,210)
; ── Reverb ────────────────────────────────────────────────────────────────────
groupbox bounds(773,5,260,108) text("REVERB  (all 16 ch)") colour(42,42,52) fontColour(190,190,190)
rslider  bounds(780,22,80,82)  text("Mix")         channel("Reverb_Mix")    range(0,1,0.25,1,0.001)     textBox(1) colour(200,120,80) fontColour(210,210,210)
rslider  bounds(866,22,80,82)  text("Time")        channel("Reverb_Time")   range(0,0.99,0.7,1,0.001)   textBox(1) colour(200,120,80) fontColour(210,210,210)
rslider  bounds(950,22,80,82)  text("LPF")         channel("Reverb_LPF")    range(0,1,0.9,1,0.001)      textBox(1) colour(200,120,80) fontColour(210,210,210)
; ── Presets + Play ────────────────────────────────────────────────────────────
groupbox bounds(1038,5,157,108) text("PRESETS") colour(42,42,52) fontColour(190,190,190)
button   bounds(1044,22,146,24) text("Harmonic Ratios","Harmonic Ratios")    channel("HarmonicBtn")  value(0) colour:0(50,85,50)   colour:1(75,140,75)  fontColour(220,220,220)
button   bounds(1044,50,146,24) text("Randomize Ratios","Randomize Ratios")  channel("RandomizeBtn") value(0) colour:0(85,65,35)   colour:1(155,115,55) fontColour(220,220,220)
button   bounds(1044,78,146,24) text("Zero Amplitudes","Zero Amplitudes")    channel("ZeroBtn")      value(0) colour:0(75,38,38)   colour:1(155,58,58)  fontColour(220,220,220)
button   bounds(1044,106,146,20) text("Play (GUI)","Stop")                   channel("PlayBtn")      value(1) colour:0(50,135,65)  colour:1(135,50,50)  fontColour(255,255,255)
; ── PARTIAL AMPLITUDES — 30 vsliders ─────────────────────────────────────────
groupbox bounds(5,122,1190,118) text("PARTIAL AMPLITUDES  (textBox = Wert doppelklicken zum Eingeben)") colour(42,42,52) fontColour(175,175,175)
vslider  bounds(12,138,37,92)   text("1")  channel("PartAmp1")  range(0,1,0.8,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(51,138,37,92)   text("2")  channel("PartAmp2")  range(0,1,0.5,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(90,138,37,92)   text("3")  channel("PartAmp3")  range(0,1,0.35,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(129,138,37,92)  text("4")  channel("PartAmp4")  range(0,1,0.25,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(168,138,37,92)  text("5")  channel("PartAmp5")  range(0,1,0.18,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(207,138,37,92)  text("6")  channel("PartAmp6")  range(0,1,0.13,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(246,138,37,92)  text("7")  channel("PartAmp7")  range(0,1,0.09,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(285,138,37,92)  text("8")  channel("PartAmp8")  range(0,1,0.06,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(324,138,37,92)  text("9")  channel("PartAmp9")  range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(363,138,37,92)  text("10") channel("PartAmp10") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(402,138,37,92)  text("11") channel("PartAmp11") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(441,138,37,92)  text("12") channel("PartAmp12") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(480,138,37,92)  text("13") channel("PartAmp13") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(519,138,37,92)  text("14") channel("PartAmp14") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(558,138,37,92)  text("15") channel("PartAmp15") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(597,138,37,92)  text("16") channel("PartAmp16") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(636,138,37,92)  text("17") channel("PartAmp17") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(675,138,37,92)  text("18") channel("PartAmp18") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(714,138,37,92)  text("19") channel("PartAmp19") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(753,138,37,92)  text("20") channel("PartAmp20") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(792,138,37,92)  text("21") channel("PartAmp21") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(831,138,37,92)  text("22") channel("PartAmp22") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(870,138,37,92)  text("23") channel("PartAmp23") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(909,138,37,92)  text("24") channel("PartAmp24") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(948,138,37,92)  text("25") channel("PartAmp25") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(987,138,37,92)  text("26") channel("PartAmp26") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(1026,138,37,92) text("27") channel("PartAmp27") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(1065,138,37,92) text("28") channel("PartAmp28") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(1104,138,37,92) text("29") channel("PartAmp29") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
vslider  bounds(1143,138,37,92) text("30") channel("PartAmp30") range(0,1,0,1,0.001) textBox(1) colour(70,145,210) fontColour(200,200,200)
; ── PARTIAL RATIOS — 30 hsliders ─────────────────────────────────────────────
groupbox bounds(5,244,1190,100) text("PARTIAL RATIOS  (× fundamental)") colour(42,42,52) fontColour(175,175,175)
hslider  bounds(12,260,37,28)   channel("Ratio1")  range(0.25,32,1,1,0.01)  textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(51,260,37,28)   channel("Ratio2")  range(0.25,32,2,1,0.01)  textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(90,260,37,28)   channel("Ratio3")  range(0.25,32,3,1,0.01)  textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(129,260,37,28)  channel("Ratio4")  range(0.25,32,4,1,0.01)  textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(168,260,37,28)  channel("Ratio5")  range(0.25,32,5,1,0.01)  textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(207,260,37,28)  channel("Ratio6")  range(0.25,32,6,1,0.01)  textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(246,260,37,28)  channel("Ratio7")  range(0.25,32,7,1,0.01)  textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(285,260,37,28)  channel("Ratio8")  range(0.25,32,8,1,0.01)  textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(324,260,37,28)  channel("Ratio9")  range(0.25,32,9,1,0.01)  textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(363,260,37,28)  channel("Ratio10") range(0.25,32,10,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(402,260,37,28)  channel("Ratio11") range(0.25,32,11,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(441,260,37,28)  channel("Ratio12") range(0.25,32,12,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(480,260,37,28)  channel("Ratio13") range(0.25,32,13,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(519,260,37,28)  channel("Ratio14") range(0.25,32,14,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(558,260,37,28)  channel("Ratio15") range(0.25,32,15,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(597,260,37,28)  channel("Ratio16") range(0.25,32,16,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(636,260,37,28)  channel("Ratio17") range(0.25,32,17,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(675,260,37,28)  channel("Ratio18") range(0.25,32,18,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(714,260,37,28)  channel("Ratio19") range(0.25,32,19,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(753,260,37,28)  channel("Ratio20") range(0.25,32,20,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(792,260,37,28)  channel("Ratio21") range(0.25,32,21,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(831,260,37,28)  channel("Ratio22") range(0.25,32,22,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(870,260,37,28)  channel("Ratio23") range(0.25,32,23,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(909,260,37,28)  channel("Ratio24") range(0.25,32,24,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(948,260,37,28)  channel("Ratio25") range(0.25,32,25,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(987,260,37,28)  channel("Ratio26") range(0.25,32,26,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(1026,260,37,28) channel("Ratio27") range(0.25,32,27,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(1065,260,37,28) channel("Ratio28") range(0.25,32,28,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(1104,260,37,28) channel("Ratio29") range(0.25,32,29,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
hslider  bounds(1143,260,37,28) channel("Ratio30") range(0.25,32,30,1,0.01) textBox(1) colour(145,80,195) fontColour(210,210,210)
; Partial-Nummern unter den Ratio-Slidern
label bounds(12,290,37,11)   text("1")  align("centre") fontColour(95,70,130) fontSize(10)
label bounds(51,290,37,11)   text("2")  align("centre") fontColour(95,70,130) fontSize(10)
label bounds(90,290,37,11)   text("3")  align("centre") fontColour(95,70,130) fontSize(10)
label bounds(129,290,37,11)  text("4")  align("centre") fontColour(95,70,130) fontSize(10)
label bounds(168,290,37,11)  text("5")  align("centre") fontColour(95,70,130) fontSize(10)
label bounds(207,290,37,11)  text("6")  align("centre") fontColour(95,70,130) fontSize(10)
label bounds(246,290,37,11)  text("7")  align("centre") fontColour(95,70,130) fontSize(10)
label bounds(285,290,37,11)  text("8")  align("centre") fontColour(95,70,130) fontSize(10)
label bounds(324,290,37,11)  text("9")  align("centre") fontColour(95,70,130) fontSize(10)
label bounds(363,290,37,11)  text("10") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(402,290,37,11)  text("11") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(441,290,37,11)  text("12") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(480,290,37,11)  text("13") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(519,290,37,11)  text("14") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(558,290,37,11)  text("15") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(597,290,37,11)  text("16") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(636,290,37,11)  text("17") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(675,290,37,11)  text("18") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(714,290,37,11)  text("19") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(753,290,37,11)  text("20") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(792,290,37,11)  text("21") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(831,290,37,11)  text("22") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(870,290,37,11)  text("23") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(909,290,37,11)  text("24") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(948,290,37,11)  text("25") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(987,290,37,11)  text("26") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(1026,290,37,11) text("27") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(1065,290,37,11) text("28") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(1104,290,37,11) text("29") align("centre") fontColour(95,70,130) fontSize(10)
label bounds(1143,290,37,11) text("30") align("centre") fontColour(95,70,130) fontSize(10)
; ── OSC RANDOM XYZ → ICST AmbiEncoder_64 ────────────────────────────────────
groupbox bounds(5,348,1190,66) text("OSC RANDOM XYZ  16 Sources S1–S16  →  ICST AmbiEncoder_64   /icst/ambi/source/xyz   Port 50001") colour(30,42,36) fontColour(130,200,145)
; On/Off
button   bounds(12,366,88,28) text("OSC AUS","OSC AN") channel("OscOn") value(0) colour:0(70,35,35) colour:1(40,125,60) fontColour(220,220,220)
; Parameter
rslider  bounds(108,355,56,52) text("Speed Hz")  channel("OscSpeed")   range(0.05,8,0.8,1,0.01)   textBox(1) colour(60,170,90) fontColour(210,210,210)
rslider  bounds(166,355,56,52) text("Smooth s")  channel("OscSmooth")  range(0,4,0.4,1,0.01)       textBox(1) colour(60,170,90) fontColour(210,210,210)
rslider  bounds(224,355,56,52) text("Range XY")  channel("OscRangeXY") range(0,1,0.85,1,0.001)     textBox(1) colour(60,170,90) fontColour(210,210,210)
rslider  bounds(282,355,56,52) text("Range Z")   channel("OscRangeZ")  range(0,1,0.35,1,0.001)     textBox(1) colour(60,170,90) fontColour(210,210,210)
; Source label
label    bounds(346,360,75,13) text("Monitor: S1") align("left")  fontColour(100,185,120) fontSize(10)
label    bounds(346,375,200,12) text("(S1–S16 in AmbiEncoder anlegen)") align("left") fontColour(65,100,72) fontSize(9)
; XYZ Live-Anzeige
label    bounds(430,360,18,13) text("X:") align("right") fontColour(100,170,210) fontSize(10)
label    bounds(449,360,55,13) text("0.000") channel("OscX_Display") align("left") fontColour(140,210,255) fontSize(10)
label    bounds(506,360,18,13) text("Y:") align("right") fontColour(100,170,210) fontSize(10)
label    bounds(525,360,55,13) text("0.000") channel("OscY_Display") align("left") fontColour(140,210,255) fontSize(10)
label    bounds(582,360,18,13) text("Z:") align("right") fontColour(100,170,210) fontSize(10)
label    bounds(601,360,55,13) text("0.000") channel("OscZ_Display") align("left") fontColour(140,210,255) fontSize(10)
; Hinweis
label    bounds(665,360,525,13) text("rspline curved random walk  ·  XY in [−Range, +Range]  ·  Z in [−Range, +Range]") align("left") fontColour(60,100,68) fontSize(9)
label    bounds(665,375,525,12) text("OSC stoppt automatisch wenn kein AmbiEncoder läuft  ·  16×30=480 Pakete/s  ·  instr 30") align("left") fontColour(55,85,60) fontSize(9)
; ── Info ──────────────────────────────────────────────────────────────────────
label bounds(5,417,1190,12) text("P1–16→Ch1–16  •  P17–30→Ch1–14 (sum)  •  Reverb→alle 16 ch  •  MIDI-Keyboard steuert Fund Hz  (Taste halten = MIDI-Freq aktiv, loslassen = GUI-Slider)") align("centre") fontColour(70,105,145) fontSize(10)
; ── MIDI Keyboard ─────────────────────────────────────────────────────────────
keyboard bounds(5,432,1190,84)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-d -+rtmidi=null -M0
</CsOptions>
<CsInstruments>
sr     = 48000
ksmps  = 32
nchnls = 16
0dbfs  = 1
; MIDI: kein Default-Routing (Kanal N → Instr N), nur midiin in instr 1
massign 0, 0
gasend       init 0
gkMidiFreq   init 440
gkMidiActive init 0
gkMidiNote   init 0
gisine     ftgen 0, 0, 4096, 10, 1
giwaveform ftgen 0, 0, 32, -2, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
giExp8000  ftgen 0, 0, 129, -25, 0, 4,  128, 8000
giExp20000 ftgen 0, 0, 129, -25, 0, 20, 128, 20000
; ── OSC global state ─────────────────────────────────────────────────────────
gkOscOn     init 0
gkOscSpeed  init 0.8
gkOscSmooth init 0.4
gkOscRngXY  init 0.85
gkOscRngZ   init 0.35
; ── OSCILLATOR macro ─────────────────────────────────────────────────────────
#define OSCILLATOR(COUNT'CHAN)
#
kPartAmp$COUNT table $COUNT-1, giwaveform
kPartAmp$COUNT portk 0.000001 + kPartAmp$COUNT, kAmpPort
kRatio$COUNT   portk gkRatio$COUNT, kRatiosPort
apart$COUNT    oscil kamp * kPartAmp$COUNT, kfund * kRatio$COUNT, gisine
outch $CHAN, apart$COUNT * aenv * (1 - gkRvbMix)
gasend = gasend + (apart$COUNT * aenv * gkRvbMix)
#
; ── instr 10: GUI polling + MIDI keyboard tracking ───────────────────────────
instr 10
  ktrig metro 10
  if (ktrig == 1) then
    #define PART(COUNT)
    #
    gkPartAmp$COUNT chnget "PartAmp$COUNT"
    gkRatio$COUNT   chnget "Ratio$COUNT"
    #
    $PART(1)
    $PART(2)
    $PART(3)
    $PART(4)
    $PART(5)
    $PART(6)
    $PART(7)
    $PART(8)
    $PART(9)
    $PART(10)
    $PART(11)
    $PART(12)
    $PART(13)
    $PART(14)
    $PART(15)
    $PART(16)
    $PART(17)
    $PART(18)
    $PART(19)
    $PART(20)
    $PART(21)
    $PART(22)
    $PART(23)
    $PART(24)
    $PART(25)
    $PART(26)
    $PART(27)
    $PART(28)
    $PART(29)
    $PART(30)
    gkamp        chnget "Amplitude"
    gkFundFrq    chnget "Fund_Freq"
    gkFundFrq    tablei gkFundFrq, giExp8000, 1
    kDisplayHz   = (gkMidiActive == 1 ? gkMidiFreq : gkFundFrq)
    chnset       kDisplayHz, "Fund_Freq_Value"
    chnset       gkMidiNote, "MidiNoteDisp"
    gkAmpPort    chnget "Amp_Fund_Port"
    gkRatiosPort chnget "Ratio_Port"
    gkAttTim     chnget "Attack_Time"
    gkRelTim     chnget "Release_Time"
    gkRvbMix     chnget "Reverb_Mix"
    gkRvbFbl     chnget "Reverb_Time"
    gkRvbLPF     chnget "Reverb_LPF"
    gkRvbLPF     tablei gkRvbLPF, giExp20000, 1
    kHarm  chnget "HarmonicBtn"
    kRnd   chnget "RandomizeBtn"
    kZero  chnget "ZeroBtn"
    kPlay  chnget "PlayBtn"
    kHTrig changed kHarm
    kRTrig changed kRnd
    kZTrig changed kZero
    kPTrig changed kPlay
    if kHTrig == 1 && kHarm  == 1 then
      event "i", 5, 0, 0
    endif
    if kRTrig == 1 && kRnd   == 1 then
      event "i", 6, 0, 0
    endif
    if kZTrig == 1 && kZero  == 1 then
      event "i", 7, 0, 0
    endif
    if kPTrig == 1 then
      if kPlay == 1 then
        event "i", 1, 0, -1, 0, 0
      else
        turnoff2 1, 0, 1
      endif
    endif
  endif
endin
; ── instr 1: Sound engine ────────────────────────────────────────────────────
instr 1
  ; ── MIDI-Keyboard: midiin liest DIREKT im Sound-Engine-Instrument ─────────────
  ; midiin läuft jeden k-Zyklus (unabhängig von GUI-Polling-Rate).
  ; Status-Bytes: 144–159 = Note-On Ch1–16,  128–143 = Note-Off Ch1–16.
  kstatus, kchan, kdata1, kdata2  midiin
  if (kstatus >= 144 && kstatus <= 159 && kdata2 > 0) then  ; Note-On
    gkMidiNote   = kdata1
    gkMidiFreq   = cpsmidinn(kdata1)
    gkMidiActive = 1
  elseif ((kstatus >= 128 && kstatus <= 143) || \
          (kstatus >= 144 && kstatus <= 159 && kdata2 == 0)) then  ; Note-Off
    gkMidiActive = 0
  endif
  ; ── Sound engine ──────────────────────────────────────────────────────────────
  kamp        = gkamp * 0.5
  kFundFrq    = (gkMidiActive == 1 ? gkMidiFreq : gkFundFrq)
  kporttime   linseg 0, 0.001, 1, 1, 1
  kAmpPort    = kporttime * gkAmpPort
  kRatiosPort = kporttime * gkRatiosPort
  kfund       portk kFundFrq, kAmpPort
  aenv        linsegr 0, i(gkAttTim), 1, i(gkRelTim), 0
  $OSCILLATOR(1'1)   $OSCILLATOR(2'2)   $OSCILLATOR(3'3)   $OSCILLATOR(4'4)
  $OSCILLATOR(5'5)   $OSCILLATOR(6'6)   $OSCILLATOR(7'7)   $OSCILLATOR(8'8)
  $OSCILLATOR(9'9)   $OSCILLATOR(10'10) $OSCILLATOR(11'11) $OSCILLATOR(12'12)
  $OSCILLATOR(13'13) $OSCILLATOR(14'14) $OSCILLATOR(15'15) $OSCILLATOR(16'16)
  $OSCILLATOR(17'1)  $OSCILLATOR(18'2)  $OSCILLATOR(19'3)  $OSCILLATOR(20'4)
  $OSCILLATOR(21'5)  $OSCILLATOR(22'6)  $OSCILLATOR(23'7)  $OSCILLATOR(24'8)
  $OSCILLATOR(25'9)  $OSCILLATOR(26'10) $OSCILLATOR(27'11) $OSCILLATOR(28'12)
  $OSCILLATOR(29'13) $OSCILLATOR(30'14)
endin
; ── instr 2: XY pad → table ──────────────────────────────────────────────────
instr 2
  kx chnget "X_Part"
  ky chnget "Y_Amp"
  kx = int(kx)
  chnset kx, "XY_X_Display"
  chnset ky, "XY_Y_Display"
  ktrig_XY changed kx, ky
  schedkwhen ktrig_XY, 0, 0, 4, 0, 0, kx, ky
  #define UPDATE_SLIDER(COUNT)
  #
  kPartAmp$COUNT table $COUNT-1, giwaveform
  chnset kPartAmp$COUNT, "PartAmp$COUNT"
  #
  if (ktrig_XY == 1) then
    $UPDATE_SLIDER(1)
    $UPDATE_SLIDER(2)
    $UPDATE_SLIDER(3)
    $UPDATE_SLIDER(4)
    $UPDATE_SLIDER(5)
    $UPDATE_SLIDER(6)
    $UPDATE_SLIDER(7)
    $UPDATE_SLIDER(8)
    $UPDATE_SLIDER(9)
    $UPDATE_SLIDER(10)
    $UPDATE_SLIDER(11)
    $UPDATE_SLIDER(12)
    $UPDATE_SLIDER(13)
    $UPDATE_SLIDER(14)
    $UPDATE_SLIDER(15)
    $UPDATE_SLIDER(16)
    $UPDATE_SLIDER(17)
    $UPDATE_SLIDER(18)
    $UPDATE_SLIDER(19)
    $UPDATE_SLIDER(20)
    $UPDATE_SLIDER(21)
    $UPDATE_SLIDER(22)
    $UPDATE_SLIDER(23)
    $UPDATE_SLIDER(24)
    $UPDATE_SLIDER(25)
    $UPDATE_SLIDER(26)
    $UPDATE_SLIDER(27)
    $UPDATE_SLIDER(28)
    $UPDATE_SLIDER(29)
    $UPDATE_SLIDER(30)
  endif
endin
instr 4
  tabw_i p5, p4, giwaveform
endin
; ── instr 5–7: Presets ───────────────────────────────────────────────────────
instr 5
  chnset 1, "Ratio1"
  chnset 2, "Ratio2"
  chnset 3, "Ratio3"
  chnset 4, "Ratio4"
  chnset 5, "Ratio5"
  chnset 6, "Ratio6"
  chnset 7, "Ratio7"
  chnset 8, "Ratio8"
  chnset 9, "Ratio9"
  chnset 10, "Ratio10"
  chnset 11, "Ratio11"
  chnset 12, "Ratio12"
  chnset 13, "Ratio13"
  chnset 14, "Ratio14"
  chnset 15, "Ratio15"
  chnset 16, "Ratio16"
  chnset 17, "Ratio17"
  chnset 18, "Ratio18"
  chnset 19, "Ratio19"
  chnset 20, "Ratio20"
  chnset 21, "Ratio21"
  chnset 22, "Ratio22"
  chnset 23, "Ratio23"
  chnset 24, "Ratio24"
  chnset 25, "Ratio25"
  chnset 26, "Ratio26"
  chnset 27, "Ratio27"
  chnset 28, "Ratio28"
  chnset 29, "Ratio29"
  chnset 30, "Ratio30"
endin
instr 6
  #define RANDOMIZE_RATIO(COUNT)
  #
  iratio$COUNT random 1, 30
  chnset iratio$COUNT, "Ratio$COUNT"
  #
  $RANDOMIZE_RATIO(1)
  $RANDOMIZE_RATIO(2)
  $RANDOMIZE_RATIO(3)
  $RANDOMIZE_RATIO(4)
  $RANDOMIZE_RATIO(5)
  $RANDOMIZE_RATIO(6)
  $RANDOMIZE_RATIO(7)
  $RANDOMIZE_RATIO(8)
  $RANDOMIZE_RATIO(9)
  $RANDOMIZE_RATIO(10)
  $RANDOMIZE_RATIO(11)
  $RANDOMIZE_RATIO(12)
  $RANDOMIZE_RATIO(13)
  $RANDOMIZE_RATIO(14)
  $RANDOMIZE_RATIO(15)
  $RANDOMIZE_RATIO(16)
  $RANDOMIZE_RATIO(17)
  $RANDOMIZE_RATIO(18)
  $RANDOMIZE_RATIO(19)
  $RANDOMIZE_RATIO(20)
  $RANDOMIZE_RATIO(21)
  $RANDOMIZE_RATIO(22)
  $RANDOMIZE_RATIO(23)
  $RANDOMIZE_RATIO(24)
  $RANDOMIZE_RATIO(25)
  $RANDOMIZE_RATIO(26)
  $RANDOMIZE_RATIO(27)
  $RANDOMIZE_RATIO(28)
  $RANDOMIZE_RATIO(29)
  $RANDOMIZE_RATIO(30)
endin
instr 7
  #define ZERO_AMPLITUDE(COUNT)
  #
  chnset 0, "PartAmp$COUNT"
  tabw_i 0, $COUNT - 1, giwaveform
  #
  $ZERO_AMPLITUDE(1)
  $ZERO_AMPLITUDE(2)
  $ZERO_AMPLITUDE(3)
  $ZERO_AMPLITUDE(4)
  $ZERO_AMPLITUDE(5)
  $ZERO_AMPLITUDE(6)
  $ZERO_AMPLITUDE(7)
  $ZERO_AMPLITUDE(8)
  $ZERO_AMPLITUDE(9)
  $ZERO_AMPLITUDE(10)
  $ZERO_AMPLITUDE(11)
  $ZERO_AMPLITUDE(12)
  $ZERO_AMPLITUDE(13)
  $ZERO_AMPLITUDE(14)
  $ZERO_AMPLITUDE(15)
  $ZERO_AMPLITUDE(16)
  $ZERO_AMPLITUDE(17)
  $ZERO_AMPLITUDE(18)
  $ZERO_AMPLITUDE(19)
  $ZERO_AMPLITUDE(20)
  $ZERO_AMPLITUDE(21)
  $ZERO_AMPLITUDE(22)
  $ZERO_AMPLITUDE(23)
  $ZERO_AMPLITUDE(24)
  $ZERO_AMPLITUDE(25)
  $ZERO_AMPLITUDE(26)
  $ZERO_AMPLITUDE(27)
  $ZERO_AMPLITUDE(28)
  $ZERO_AMPLITUDE(29)
  $ZERO_AMPLITUDE(30)
endin
; ── instr 8: Reverb → all 16 ch ──────────────────────────────────────────────
instr 8
  denorm gasend
  arvbL, arvbR reverbsc gasend, gasend, gkRvbFbl, gkRvbLPF
  arvb = (arvbL + arvbR) * 0.5
  outch  1,arvb,  2,arvb,  3,arvb,  4,arvb
  outch  5,arvb,  6,arvb,  7,arvb,  8,arvb
  outch  9,arvb, 10,arvb, 11,arvb, 12,arvb
  outch 13,arvb, 14,arvb, 15,arvb, 16,arvb
  clear gasend
endin
; ── instr 30: OSC Random XYZ → ICST AmbiEncoder_64 Port 50001 — 16 Sources ──
;
; 16 unabhängige rspline-Kurven (S1–S16), jede mit leicht versetzten Frequenzen.
; Algorithmus: rspline erzeugt kontinuierliche Bézierkurven zwischen zufälligen
;   Zielpunkten. Jede Quelle hat eigene Frequenz-Multiplikatoren (via N) →
;   keine Synchronisation, organisch unabhängige Raumkurven.
;
; OSC-Message: /icst/ambi/source/xyz  "Sn"  kx  ky  kz   (n = 1 … 16)
;   Source-Namen "S1"–"S16" müssen im ICST AmbiEncoder angelegt sein.
;
; Rate: 30 Pakete/s × 16 Quellen = 480 OSC-Pakete/s total.
; instr läuft permanent (Score: i 30 0 86400), sendet nur wenn OscOn == 1.
;
instr 30
  ; GUI-Parameter mit 20 Hz pollen
  ktrig_poll  metro 20
  if (ktrig_poll == 1) then
    gkOscOn     chnget "OscOn"
    gkOscSpeed  chnget "OscSpeed"
    gkOscSmooth chnget "OscSmooth"
    gkOscRngXY  chnget "OscRangeXY"
    gkOscRngZ   chnget "OscRangeZ"
  endif

  kspd       = gkOscSpeed
  ktrig_osc  metro 30
  ktrig_send = ktrig_osc * gkOscOn

  ; Macro: 3 rspline-Kurven (X/Y/Z) + portk + limit + OSCsend pro Source.
  ; Frequenz-Multiplikatoren werden mit N skaliert → jede Quelle bewegt sich
  ; in einem eigenen Tempo, keine zwei Quellen laufen synchron.
  ; Macro-Aufruf je eine Zeile (Csound-Preprocessor-Anforderung).
  #define OSC_SRC(N)
  #
  kxr$N  rspline -1, 1, kspd * (0.29 + $N * 0.013), kspd * (1.61 + $N * 0.041)
  kyr$N  rspline -1, 1, kspd * (0.23 + $N * 0.017), kspd * (1.43 + $N * 0.037)
  kzr$N  rspline -1, 1, kspd * (0.17 + $N * 0.011), kspd * (1.19 + $N * 0.029)
  kx$N   portk kxr$N * gkOscRngXY, gkOscSmooth
  ky$N   portk kyr$N * gkOscRngXY, gkOscSmooth
  kz$N   portk kzr$N * gkOscRngZ,  gkOscSmooth
  kx$N   limit kx$N, -1, 1
  ky$N   limit ky$N, -1, 1
  kz$N   limit kz$N, -1, 1
  Ss$N   =     "S$N"
  OSCsend ktrig_send, "127.0.0.1", 50001, "/icst/ambi/source/xyz", "sfff", Ss$N, kx$N, ky$N, kz$N
  #
  $OSC_SRC(1)
  $OSC_SRC(2)
  $OSC_SRC(3)
  $OSC_SRC(4)
  $OSC_SRC(5)
  $OSC_SRC(6)
  $OSC_SRC(7)
  $OSC_SRC(8)
  $OSC_SRC(9)
  $OSC_SRC(10)
  $OSC_SRC(11)
  $OSC_SRC(12)
  $OSC_SRC(13)
  $OSC_SRC(14)
  $OSC_SRC(15)
  $OSC_SRC(16)

  ; Monitor: S1-Werte im GUI anzeigen (stellvertretend für alle 16 Quellen)
  if (ktrig_osc == 1 && gkOscOn == 1) then
    chnset kx1, "OscX_Display"
    chnset ky1, "OscY_Display"
    chnset kz1, "OscZ_Display"
  endif
endin
</CsInstruments>
<CsScore>
i 1  0 86400   ; Sound engine — startet sofort (Amplitudes 1–8 voreingestellt)
i 2  0 86400
i 8  0 86400
i 10 0 86400
i 30 0 86400   ; OSC Random XYZ — läuft permanent, sendet nur wenn "OSC AN" gedrückt
</CsScore>
</CsoundSynthesizer>
