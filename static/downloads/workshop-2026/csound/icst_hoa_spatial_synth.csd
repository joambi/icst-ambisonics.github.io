; ═══════════════════════════════════════════════════════════════════
; ICST HOA Spatial Synth — Csound + Cabbage VST
; ═══════════════════════════════════════════════════════════════════
; HOA 3rd Order (16 Kanäle) — in REAPER als VST3 über Cabbage laden
;
; Setup in REAPER:
;   1. Cabbage installieren: https://cabbageaudio.com
;   2. Diese .csd-Datei in Cabbage öffnen → "Export as Plugin"
;   3. VST-Pfad in REAPER eintragen und rescannen
;   4. Plugin auf einen 16-Kanal-HOA-Track laden (HOA 3rd Order)
;   5. Den Track auf deinen B-Format Master routen
;
; Signalfluss:
;   Oscillator + Noise → *Gain → bformenc1 (az, el) → 16ch HOA Out
; ═══════════════════════════════════════════════════════════════════

<Cabbage>

form caption("ICST HOA Spatial Synth") size(560, 360), colour(20, 32, 45), pluginId("IHSS"), guiRefresh(60)

; ── Titelzeile ─────────────────────────────────────────────────────
label   bounds(10, 8, 540, 22), text("ICST HOA Spatial Synth  ·  3rd Order (16ch)  ·  ambisonics.ch"), \
        fontColour(160, 200, 230), align("left"), fontSize(13)

; ── Source 1: Sine ─────────────────────────────────────────────────
groupbox bounds(10, 38, 170, 150), text("Source 1 · Sine"), colour(30, 50, 70), fontColour(160, 200, 230)

rslider  bounds(15,  60, 75, 80), channel("freq1"), range(50, 2000, 220, 1, 1), \
         text("Hz"), colour(74, 158, 218), fontColour(220, 235, 250), trackerColour(74, 158, 218)
rslider  bounds(98,  60, 75, 80), channel("gain1"), range(0, 1, 0.35, 1, 0.001), \
         text("Gain"), colour(74, 158, 218), fontColour(220, 235, 250), trackerColour(74, 158, 218)

; ── Source 2: Noise ────────────────────────────────────────────────
groupbox bounds(190, 38, 170, 150), text("Source 2 · Noise"), colour(30, 50, 70), fontColour(160, 200, 230)

rslider  bounds(195,  60, 75, 80), channel("cutoff"), range(100, 8000, 600, 1, 1), \
         text("Cutoff"), colour(74, 158, 218), fontColour(220, 235, 250), trackerColour(74, 158, 218)
rslider  bounds(278,  60, 75, 80), channel("gain2"), range(0, 1, 0.12, 1, 0.001), \
         text("Gain"), colour(74, 158, 218), fontColour(220, 235, 250), trackerColour(74, 158, 218)

; ── Spatial Controls ───────────────────────────────────────────────
groupbox bounds(370, 38, 180, 150), text("Spatial · Manual"), colour(30, 50, 70), fontColour(160, 200, 230)

rslider  bounds(375,  60, 75, 80), channel("az_s1"), range(-180, 180, -45, 1, 1), \
         text("Az S1"), colour(74, 158, 218), fontColour(220, 235, 250)
rslider  bounds(458,  60, 75, 80), channel("az_s2"), range(-180, 180,  45, 1, 1), \
         text("Az S2"), colour(74, 158, 218), fontColour(220, 235, 250)

; ── Generative Movement ────────────────────────────────────────────
groupbox bounds(10, 198, 540, 110), text("Generative Movement"), colour(30, 50, 70), fontColour(160, 200, 230)

checkbox bounds(18, 220, 120, 22), channel("autoS1"), text("Auto S1"), colour(74, 158, 218), fontColour(220, 235, 250), value(1)
rslider  bounds(15, 242, 75, 58), channel("speed1"), range(0.01, 3, 0.25, 1, 0.01), \
         text("Speed"), colour(240, 180, 50), fontColour(220, 235, 250)
rslider  bounds(95, 242, 75, 58), channel("depth1"), range(0, 180, 90, 1, 1), \
         text("Depth"), colour(240, 180, 50), fontColour(220, 235, 250)

checkbox bounds(200, 220, 120, 22), channel("autoS2"), text("Auto S2"), colour(74, 158, 218), fontColour(220, 235, 250), value(1)
rslider  bounds(197, 242, 75, 58), channel("speed2"), range(0.01, 3, 0.4, 1, 0.01), \
         text("Speed"), colour(240, 180, 50), fontColour(220, 235, 250)
rslider  bounds(277, 242, 75, 58), channel("depth2"), range(0, 180, 120, 1, 1), \
         text("Depth"), colour(240, 180, 50), fontColour(220, 235, 250)

rslider  bounds(380, 220, 75, 80), channel("elev1"), range(-90, 90, -20, 1, 1), \
         text("El S1"), colour(100, 180, 100), fontColour(220, 235, 250)
rslider  bounds(465, 220, 75, 80), channel("elev2"), range(-90, 90,  30, 1, 1), \
         text("El S2"), colour(100, 180, 100), fontColour(220, 235, 250)

; ── HOA Order ──────────────────────────────────────────────────────
label    bounds(10, 316, 540, 18), \
         text("Output: 16 channels ambiX HOA 3rd Order (ACN / SN3D) → route to B-Format Master in REAPER"), \
         fontColour(120, 160, 190), align("left"), fontSize(11)

</Cabbage>

<CsoundSynthesizer>
<CsOptions>
; Plugin mode: no real-time output (REAPER handles it)
-n -d
</CsOptions>

<CsInstruments>

sr      = 48000
ksmps   = 64
; ── Ausgabe-Modus ────────────────────────────────────────────────
; STANDALONE / Cabbage-Test:  nchnls = 2  (Stereo-Monitoring-Decode)
; VST in REAPER (HOA-Output): nchnls = 16 + outch 1-16 verwenden
nchnls  = 2
0dbfs   = 1

; Csound 7: $M_PI ggf. nicht als Built-in verfügbar → explizit definieren
#ifndef M_PI
  #define M_PI # 3.14159265358979 #
#endif

; ─────────────────────────────────────────────────────────────────────────────
; Instrument 1  — Generative HOA Spatial Synth
; ─────────────────────────────────────────────────────────────────────────────
;
; Source 1: Sine oscillator  (leicht detuned für Fülle)
; Source 2: Tiefpassgefiltertes Rauschen
; Beide werden unabhängig im HOA-Raum positioniert.
;
; bformenc1 Syntax (3rd Order):
;   aw,ax,ay,az, ar,as,at,au,av, ak,al,am,an,ao,ap,aq  bformenc1  asig, kazimuth_rad, kelevation_rad, iorder
;
; Ausgabe Kanalzuordnung (ambiX / ACN):
;   ch 1=W(ACN0)  ch 2=Y(ACN1)  ch 3=Z(ACN2)  ch 4=X(ACN3) ...
;   Hinweis: bformenc1 verwendet FuMa-Konvention intern.
;   Für ambiX-Output: Nachbearbeitung via B-Format-Transformer in REAPER empfohlen.
; ─────────────────────────────────────────────────────────────────────────────

instr 1

  ; ── Cabbage-Kanäle lesen mit Fallback-Defaults ───────────────────
  ; Defaults greifen wenn kein Cabbage-UI aktiv ist (z.B. CsoundQt-Test).
  ; In Cabbage überschreiben die Regler alle Werte.
  kfreq1   chnget "freq1"
  kfreq1   = (kfreq1  <= 0) ? 220   : kfreq1
  kgain1   chnget "gain1"
  kgain1   = (kgain1  <= 0) ? 0.35  : kgain1
  kgain2   chnget "gain2"
  kgain2   = (kgain2  <= 0) ? 0.12  : kgain2
  kcutoff  chnget "cutoff"
  kcutoff  = (kcutoff <= 0) ? 600   : kcutoff

  kaz_s1   chnget "az_s1"       ; Basis-Azimut S1 (Grad)
  kaz_s2   chnget "az_s2"       ; Basis-Azimut S2 (Grad)
  kaz_s2   = (kaz_s2  == 0) ? 45    : kaz_s2
  kel1     chnget "elev1"       ; Elevation S1 (Grad)
  kel1     = (kel1    == 0) ? -20   : kel1
  kel2     chnget "elev2"       ; Elevation S2 (Grad)
  kel2     = (kel2    == 0) ? 30    : kel2

  kauto1   chnget "autoS1"
  kauto1   = (kauto1  == 0) ? 1     : kauto1   ; Auto-Move default: an
  kspeed1  chnget "speed1"
  kspeed1  = (kspeed1 <= 0) ? 0.25  : kspeed1
  kdepth1  chnget "depth1"
  kdepth1  = (kdepth1 <= 0) ? 90    : kdepth1

  kauto2   chnget "autoS2"
  kauto2   = (kauto2  == 0) ? 1     : kauto2
  kspeed2  chnget "speed2"
  kspeed2  = (kspeed2 <= 0) ? 0.4   : kspeed2
  kdepth2  chnget "depth2"
  kdepth2  = (kdepth2 <= 0) ? 120   : kdepth2

  ; ── Source 1: Sine (leicht detuned) ─────────────────────────────
  asine1   oscili kgain1 * 0.6, kfreq1
  asine2   oscili kgain1 * 0.4, kfreq1 * 1.0025   ; leichtes Detune
  asrc1    = asine1 + asine2

  ; ── Source 2: Gefiltertes Rauschen ──────────────────────────────
  anoise   noise kgain2, 0
  asrc2    butterlp anoise, kcutoff                ; Tiefpass

  ; ── Generative Azimut-Bewegung ───────────────────────────────────
  ; lfo: kein Funktions-Table nötig (Csound 6 + 7 kompatibel)
  ; S1: Sinusförmige Kreisbewegung (itype=0 = Sinus)
  klfo1     lfo kdepth1, kspeed1, 0
  kaz1_auto = kaz_s1 + klfo1
  kaz1      = (kauto1 == 1) ? kaz1_auto : kaz_s1

  ; S2: Gegenläufige Bewegung (LFO invertiert → Gegenbewegung)
  klfo2     lfo kdepth2, kspeed2, 0
  klfo2     = klfo2 * (-1)
  kaz2_auto = kaz_s2 + klfo2
  kaz2      = (kauto2 == 1) ? kaz2_auto : kaz_s2

  ; ── Grad → Bogenmaß ─────────────────────────────────────────────
  kaz1_rad  = kaz1 * $M_PI / 180
  kel1_rad  = kel1 * $M_PI / 180
  kaz2_rad  = kaz2 * $M_PI / 180
  kel2_rad  = kel2 * $M_PI / 180

  ; ── HOA Encoding: 3rd Order (16 Kanäle) ─────────────────────────
  ; Csound 7: kein iorder-Argument — die HOA-Ordnung ergibt sich aus der
  ; Anzahl der Output-Variablen: 16 Outputs = 3rd Order (4+1)² = 16 ch
  ;
  ; Source 1
  aw1,ax1,ay1,az1, ar1,as1,at1,au1,av1, ak1,al1,am1,an1,ao1,ap1,aq1 \
      bformenc1 asrc1, kaz1_rad, kel1_rad

  ; Source 2
  aw2,ax2,ay2,az2, ar2,as2,at2,au2,av2, ak2,al2,am2,an2,ao2,ap2,aq2 \
      bformenc1 asrc2, kaz2_rad, kel2_rad

  ; ── Binaural Output via HRTF (hrtfmove2) ────────────────────────
  ; hrtfmove2: echtes Binaural-Rendering mit gemessenen HRTFs
  ;
  ; Azimut-Konvention für hrtfmove2: 0=vorne, 0-360° gegen Uhrzeigersinn
  ; → von -180/+180 auf 0-360 umrechnen:
  kaz1_h  = (kaz1 < 0) ? kaz1 + 360 : kaz1
  kaz2_h  = (kaz2 < 0) ? kaz2 + 360 : kaz2

  ; Elevation auf HRTF-Datenbereich begrenzen (-40° bis +90°)
  kel1_h  = (kel1 < -40) ? -40 : ((kel1 > 90) ? 90 : kel1)
  kel2_h  = (kel2 < -40) ? -40 : ((kel2 > 90) ? 90 : kel2)

  ; HRTF-Dateien: mit Csound mitgeliefert (hrtf-48000-left/right.dat)
  ; Falls nicht gefunden: in den Ordner der .csd-Datei kopieren.
  ; Pfad:  /Library/Frameworks/CsoundLib64.framework/Versions/6.0/Resources/
  ;        oder im Cabbage-App-Bundle unter Resources/
  aL1, aR1  hrtfmove2  asrc1, kaz1_h, kel1_h, \
                        "hrtf-48000-left.dat", "hrtf-48000-right.dat"
  aL2, aR2  hrtfmove2  asrc2, kaz2_h, kel2_h, \
                        "hrtf-48000-left.dat", "hrtf-48000-right.dat"

  outs  (aL1 + aL2) * 0.5,  (aR1 + aR2) * 0.5

  ; ── HOA-Vollausgang für VST in REAPER ────────────────────────────
  ; nchnls = 16 setzen, outs-Zeile entfernen, outch einkommentieren:
  ;
  ; outch  1,aw1+aw2  ;  outch  2,ax1+ax2  ;  outch  3,ay1+ay2  ;  outch  4,az1+az2
  ; outch  5,ar1+ar2  ;  outch  6,as1+as2  ;  outch  7,at1+at2  ;  outch  8,au1+au2
  ; outch  9,av1+av2  ;  outch 10,ak1+ak2  ;  outch 11,al1+al2  ;  outch 12,am1+am2
  ; outch 13,an1+an2  ;  outch 14,ao1+ao2  ;  outch 15,ap1+ap2  ;  outch 16,aq1+aq2

endin

</CsInstruments>

<CsScore>
; Instrument läuft kontinuierlich (1 Stunde)
i 1  0  3600
</CsScore>

</CsoundSynthesizer>
