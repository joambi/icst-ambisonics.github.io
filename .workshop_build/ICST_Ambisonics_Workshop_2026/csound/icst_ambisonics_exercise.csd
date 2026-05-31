<CsoundSynthesizer>

<CsOptions>
; ─────────────────────────────────────────────────────────────────────────────
; ICST Ambisonics Workshop 2026 – Räumliche Bewegungsübung
; Binaural-Monitoring (Stereo, L/R):
;   csound icst_ambisonics_exercise.csd
;
; Nur B-Format speichern (kein DAC, 16ch float-WAV):
;   Setze giBinaural = 0 und starte mit:
;   csound -d -o icst_bformat_3ord.wav icst_ambisonics_exercise.csd
; ─────────────────────────────────────────────────────────────────────────────
-d -odac
</CsOptions>

<CsInstruments>

sr      = 48000
ksmps   = 32
nchnls  = 2       ; Stereo: Binaural-Ausgabe (Kopfhörer)
0dbfs   = 1

;; ════════════════════════════════════════════════════════════════════════════
;; ICST Ambisonics Workshop 2026 – Räumliche Bewegungsübung
;;
;; 3rd-Order B-Format Ambisonics: (N+1)² = 16 Kanäle für N=3
;;   W  X  Y  Z                   (1st order, 4 Kanäle)
;;   R  S  T  U  V                (2nd order, 5 Kanäle)
;;   K  L  M  N  O  P  Q         (3rd order, 7 Kanäle)
;;
;; Quellen und Raumkurven (analog Raumkurven-Diagramm):
;;
;;   Instr 1 – PERKUSSION
;;     → Kreisbewegung in der Horizontalebene (Azimut rotiert 0 → 2π)
;;     → 1 Umdrehung alle 8 Sekunden, rhythmische Impulse
;;
;;   Instr 2 – DRONE
;;     → Startet vorne-mitte, bewegt sich nach hinten (π rad) + nach oben
;;     → Elevation: 0° → 70°, Distanz: 1 → 5 (Klang entfernt sich)
;;
;;   Instr 3 – MELODIE (zwei Stimmen mit Überkreuzung)
;;     → Stimme A: Azimut links (−90°) → rechts (+90°)
;;     → Stimme B: Azimut rechts (+90°) → links (−90°)
;;     → Kreuzungspunkt: Mitte (vorne)
;;
;; Ausgabe:
;;   giBinaural  = 1  → hrtfmove2 Binaural-Dekodierung (L/R Ausgang)
;;   giWriteBFmt = 1  → fout: B-Format 16ch als 32-bit-float WAV auf Disk
;;
;; HRTF-Dateien (Csound-Distribution, 48kHz):
;;   hrtf-48000-left.dat   und   hrtf-48000-right.dat
;;   → müssen im selben Ordner liegen oder SSDIR gesetzt sein
;; ════════════════════════════════════════════════════════════════════════════

; ── Betriebsparameter ────────────────────────────────────────────────────────
giBinaural   =  1     ; 1 = Binaural-Monitoring auf DAC (Kopfhörer)
giWriteBFmt  =  1     ; 1 = B-Format 16ch-Datei auf Disk schreiben

; HRTF-Dateinamen (relativ zum CSD-Pfad, oder absoluter Pfad)
gSHrtfL      =  "hrtf-48000-left.dat"
gSHrtfR      =  "hrtf-48000-right.dat"

; Ausgabedatei für B-Format (32-bit float WAV, 16 Kanäle)
gSBFmtFile   =  "icst_ambisonics_bformat_3ord.wav"

; ── Globale B-Format Busse (3rd Order, 16 Kanäle) ────────────────────────────
; Jedes Instrument addiert seinen Beitrag; Instr 99 liest und setzt zurück.
gaW  init 0   ;  Kanal  1  / W  (Omnidirektional)
gaX  init 0   ;  Kanal  2  / X  (links-rechts)
gaY  init 0   ;  Kanal  3  / Y  (vorne-hinten)
gaZ  init 0   ;  Kanal  4  / Z  (oben-unten)
gaR  init 0   ;  Kanal  5  / R  (2nd order)
gaS  init 0   ;  Kanal  6  / S
gaT  init 0   ;  Kanal  7  / T
gaU  init 0   ;  Kanal  8  / U
gaV  init 0   ;  Kanal  9  / V
gaK  init 0   ;  Kanal 10  / K  (3rd order)
gaL  init 0   ;  Kanal 11  / L
gaM  init 0   ;  Kanal 12  / M
gaN  init 0   ;  Kanal 13  / N
gaO  init 0   ;  Kanal 14  / O
gaP  init 0   ;  Kanal 15  / P
gaQ  init 0   ;  Kanal 16  / Q

; Binaural-Summenbusse (addiert von allen Instrumenten)
gaBinL  init 0
gaBinR  init 0

; ── Wavetables ───────────────────────────────────────────────────────────────
gisine   ftgen 1, 0, 4096, 10, 1                                    ; Sinus
gisaw    ftgen 2, 0, 4096, 10, 1, 0.5, 0.333, 0.25, 0.2, 0.167, 0.143, 0.125
gipad    ftgen 3, 0, 4096, 10, 1, 0.7,  0.4,  0.2,  0.1, 0.05        ; Pad


; ════════════════════════════════════════════════════════════════════════════
; Instr 1 – PERKUSSION
; Kreisförmige Azimut-Bewegung in der Horizontalebene.
; Das Instrument läuft durch; ein metro-Trigger erzeugt rhythmische Impulse.
; Per reinit/rireturn wird die Hüllkurve bei jedem Schlag neu gestartet.
;
; p4 = Amplitude
; p5 = Schläge pro Sekunde (BPS)
; p6 = Sekunden pro Umdrehung (Kreisperiode)
; ════════════════════════════════════════════════════════════════════════════
instr 1
  iamp   =  p4
  ibps   =  p5
  icirc  =  p6

  ; Trigger bei jedem Schlag
  ktrig  metro ibps

  ; Hüllkurve: bei Trigger via reinit/rireturn neu gestartet
  if (ktrig > 0) then
    reinit perk_env_reset
  endif
  perk_env_reset:
  aenv  expseg 1, 0.004, 0.6, 0.08, 0.05, 0.15, 0.001
  rireturn

  ; Perkussiver Klang: gefiltertes Rauschen (Klick-Charakter)
  anoise  noise 1, 0
  aclick  butlp anoise, 2800
  aclick  =  aclick * aenv * iamp

  ; ── Räumliche Position: Kreisazimut ─────────────────────────────────────
  ; phasor 0→1 über die Kreisperiode → in Radiant umrechnen
  kazim  phasor  1 / icirc             ; 0 → 1
  kazim  =  kazim * 2 * $M_PI          ; 0 → 2π
  kazim  =  kazim - $M_PI              ; −π → +π  (Csound: 0=vorne)
  kelev  =  0                          ; Horizontalebene
  krad   =  1.5                        ; nahe Distanz

  ; ── Binaural (hrtfmove2, Grad) ──────────────────────────────────────────
  if (giBinaural == 1) then
    kazDeg  =  kazim * (180 / $M_PI)
    kElDeg  =  kelev * (180 / $M_PI)
    aL, aR  hrtfmove2  aclick, kazDeg, kElDeg, gSHrtfL, gSHrtfR, 1, 64, 48000
    gaBinL  +=  aL
    gaBinR  +=  aR
  endif

  ; ── B-Format Enkodierung (3rd Order, 16 Kanäle) ─────────────────────────
  aw,ax,ay,az,ar,as,at,au,av,ak,al,am,an,ao,ap,aq  \
    bformenc1  aclick, kazim, kelev, krad, 3
  gaW += aw  ;  gaX += ax  ;  gaY += ay  ;  gaZ += az
  gaR += ar  ;  gaS += as  ;  gaT += at  ;  gaU += au  ;  gaV += av
  gaK += ak  ;  gaL += al  ;  gaM += am  ;  gaN += an
  gaO += ao  ;  gaP += ap  ;  gaQ += aq
endin


; ════════════════════════════════════════════════════════════════════════════
; Instr 2 – DRONE
; Beginnt vorne, bewegt sich langsam nach hinten (π rad) und nach oben.
; Distanz nimmt zu → Klang entfernt sich räumlich.
;
; p4 = Amplitude
; p5 = Grundfrequenz in Hz
; ════════════════════════════════════════════════════════════════════════════
instr 2
  iamp   =  p4
  ifreq  =  p5

  ; Langsames Ein- und Ausblenden (2s Attack, 2s Release)
  aenv  linseg  0, 2, 1, p3 - 4, 1, 2, 0

  ; Drone-Klang: vier leicht verstimmte Oszillatoren → Schwebung/Wärme
  aosc1  oscil  iamp * 0.45,  ifreq,           gipad
  aosc2  oscil  iamp * 0.30,  ifreq * 1.0015,  gipad   ; +1.5 Cent Schwebung
  aosc3  oscil  iamp * 0.20,  ifreq * 0.5,     gipad   ; Suboktave
  aosc4  oscil  iamp * 0.15,  ifreq * 2.003,   gipad   ; Oberharmonische
  adrone  =  (aosc1 + aosc2 + aosc3 + aosc4) * aenv

  ; ── Räumliche Position: hinten + aufsteigend ────────────────────────────
  ; Azimut: π (hinten) mit langsamer Schwankung (±0.2 rad)
  kazSway  oscil  0.2, 0.04, gisine
  kazim    =  kazSway + $M_PI

  ; Elevation: 0 → 1.22 rad (≈ 70°, in Richtung Zenit)
  kelev  linseg  0, p3, 1.22

  ; Distanz: 1 → 5 (Klang entfernt sich)
  krad   linseg  1.0, p3, 5.0

  ; ── Binaural ────────────────────────────────────────────────────────────
  if (giBinaural == 1) then
    kazDeg  =  kazim * (180 / $M_PI)
    kElDeg  =  kelev * (180 / $M_PI)
    aL, aR  hrtfmove2  adrone, kazDeg, kElDeg, gSHrtfL, gSHrtfR, 1, 64, 48000
    gaBinL  +=  aL * 0.8
    gaBinR  +=  aR * 0.8
  endif

  ; ── B-Format Enkodierung ────────────────────────────────────────────────
  aw,ax,ay,az,ar,as,at,au,av,ak,al,am,an,ao,ap,aq  \
    bformenc1  adrone, kazim, kelev, krad, 3
  gaW += aw  ;  gaX += ax  ;  gaY += ay  ;  gaZ += az
  gaR += ar  ;  gaS += as  ;  gaT += at  ;  gaU += au  ;  gaV += av
  gaK += ak  ;  gaL += al  ;  gaM += am  ;  gaN += an
  gaO += ao  ;  gaP += ap  ;  gaQ += aq
endin


; ════════════════════════════════════════════════════════════════════════════
; Instr 3 – MELODIE
; Einzelne melodische Note, bewegt sich linear von p6 nach p7 (Azimut).
; Wird im Score mehrfach für Überkreuzungs-Muster verwendet:
;   Stimme A: links → rechts  (−π/2 → +π/2)
;   Stimme B: rechts → links  (+π/2 → −π/2)
; → Kreuzungspunkt liegt in der Mitte (vorne, t=Mitte der Noten-Dauer)
;
; p4 = Amplitude
; p5 = Frequenz in Hz
; p6 = Azimut-Start (Radiant)
; p7 = Azimut-Ende  (Radiant)
; p8 = Elevation    (Radiant, konstant für diese Note)
; ════════════════════════════════════════════════════════════════════════════
instr 3
  iamp     =  p4
  ifreq    =  p5
  iazStart =  p6
  iazEnd   =  p7
  ielev    =  p8

  ; Melodischer Klang: Sägezahn gefiltert (wärmerer Ton)
  aenv   linseg   0, 0.025, 1, p3 - 0.075, 0.8, 0.05, 0
  aosc   oscil    iamp, ifreq, gisaw
  afilt  butlp    aosc, 5000 - (ifreq * 3)   ; hF-Dämpfung mit Frequenz
  amelo  =  afilt * aenv

  ; ── Räumliche Position: lineare Traversierung ───────────────────────────
  kazim  linseg  iazStart, p3, iazEnd
  kelev  =  ielev
  krad   =  2.0

  ; ── Binaural ────────────────────────────────────────────────────────────
  if (giBinaural == 1) then
    kazDeg  =  kazim * (180 / $M_PI)
    kElDeg  =  kelev * (180 / $M_PI)
    aL, aR  hrtfmove2  amelo, kazDeg, kElDeg, gSHrtfL, gSHrtfR, 1, 64, 48000
    gaBinL  +=  aL
    gaBinR  +=  aR
  endif

  ; ── B-Format Enkodierung ────────────────────────────────────────────────
  aw,ax,ay,az,ar,as,at,au,av,ak,al,am,an,ao,ap,aq  \
    bformenc1  amelo, kazim, kelev, krad, 3
  gaW += aw  ;  gaX += ax  ;  gaY += ay  ;  gaZ += az
  gaR += ar  ;  gaS += as  ;  gaT += at  ;  gaU += au  ;  gaV += av
  gaK += ak  ;  gaL += al  ;  gaM += am  ;  gaN += an
  gaO += ao  ;  gaP += ap  ;  gaQ += aq
endin


; ════════════════════════════════════════════════════════════════════════════
; Instr 99 – OUTPUT ENGINE
; Liest globale B-Format-Busse, schreibt auf Disk und/oder gibt Binaural aus.
; Muss immer als letztes Instrument in der Score aktiviert sein.
; ════════════════════════════════════════════════════════════════════════════
instr 99

  ; B-Format 16ch auf Disk schreiben (32-bit float WAV)
  ; Format-Code 0 = 32-bit float (höchste Qualität, universal kompatibel)
  if (giWriteBFmt == 1) then
    fout gSBFmtFile, 0, \
      gaW, gaX, gaY, gaZ, \
      gaR, gaS, gaT, gaU, gaV, \
      gaK, gaL, gaM, gaN, gaO, gaP, gaQ
  endif

  ; Binaural-Mix auf Ausgang (Kanal 1 = Links, 2 = Rechts)
  if (giBinaural == 1) then
    out  gaBinL * 0.7, gaBinR * 0.7
  endif

  ; ── Globale Busse zurücksetzen (Ende jedes k-Zyklus) ────────────────────
  gaW  = 0  ;  gaX  = 0  ;  gaY  = 0  ;  gaZ  = 0
  gaR  = 0  ;  gaS  = 0  ;  gaT  = 0  ;  gaU  = 0  ;  gaV  = 0
  gaK  = 0  ;  gaL  = 0  ;  gaM  = 0  ;  gaN  = 0
  gaO  = 0  ;  gaP  = 0  ;  gaQ  = 0
  gaBinL  = 0
  gaBinR  = 0
endin


</CsInstruments>

<CsScore>

;; ════════════════════════════════════════════════════════════════════════════
;; ICST Ambisonics Workshop 2026 – Kompositions-Score
;; Gesamtdauer: 62 Sekunden
;;
;; Raumkurven-Übersicht (analog zum Diagramm):
;;
;;   Perkussion │ ───── Kreisbewegung (horizontal) ─────────────────────────
;;   Drone      │         ╰── nach hinten + aufwärts ──────────────────────╮
;;   Melodie    │                    ╰──(A: links→rechts)───────── ────────╯
;;              │                       (B: rechts→links)
;;              0s     10s     20s     30s     40s     50s     60s
;;
;; Azimut-Konvention (bformenc1, Radiant):
;;     0      = vorne
;;   +π/2  ≈ +1.571  = links
;;   −π/2  ≈ −1.571  = rechts
;;    ±π   ≈ ±3.14   = hinten
;;
;; Elevation-Konvention (Radiant):
;;     0    = Horizont
;;   +π/2   = Zenit (oben)
;; ════════════════════════════════════════════════════════════════════════════

; Output-Engine: muss zuerst und über die gesamte Dauer aktiv sein
; (höchste Instr-Nr. → letzter im k-Zyklus dank Standard-Reihenfolge)
i99   0   63


; ── PERKUSSION (Instr 1) ─────────────────────────────────────────────────────
; Kreisbewegung, kontinuierlich über die gesamte Komposition
;        Start  Dur   Amp    BPS   Sec/Umdrehung
;  p4=Amp, p5=BPS, p6=Sec/Kreis
i1        0      62    0.45   2.0   8


; ── DRONE (Instr 2) ──────────────────────────────────────────────────────────
; Eintritt t=4s, Austritt t=60s (56s Dauer)
; Bewegt sich von vorne-Mitte nach hinten-oben
;        Start  Dur   Amp    Freq(Hz)
;  p4=Amp, p5=Freq
i2        4      56    0.4    82.41     ; E2 (≈ 82 Hz)


; ── MELODIE (Instr 3) ────────────────────────────────────────────────────────
; Zwei Stimmen überkreuzen sich zweimal (t=15–35s, t=40–60s)
;
; p4=Amp  p5=Freq(Hz)  p6=azStart(rad)  p7=azEnd(rad)  p8=Elev(rad)
;
; ─ Überkreuzung 1: t=15 bis t=35 (20 Sekunden) ─
; Stimme A: links (−π/2) → rechts (+π/2), Kreuzung bei t=25s (Mitte vorne)
i3  15    20    0.35   261.63   -1.571    1.571   0.0     ; C4

; Stimme B: rechts (+π/2) → links (−π/2)
i3  15    20    0.30   329.63    1.571   -1.571   0.0     ; E4

; ─ Übergang: kurze Motive (t=35–40s) ─
; Stimme A verweilt kurz rechts, Stimme B links
i3  35     5    0.30   261.63    1.2     0.6     0.1      ; C4, rechts→Mitte
i3  35     5    0.28   329.63   -1.2    -0.6     0.1      ; E4, links→Mitte

; ─ Überkreuzung 2: t=40 bis t=60 (20 Sekunden) ─
; Umgekehrte Richtungen, leicht erhöhte Elevation (Kreuzung schwebt höher)
; Stimme A: rechts (+π/2) → links (−π/2)
i3  40    20    0.32   392.00    1.571   -1.571   0.2     ; G4

; Stimme B: links (−π/2) → rechts (+π/2)
i3  40    20    0.28   493.88   -1.571    1.571   0.2     ; B4

; ─ Abschluss: beide Stimmen laufen in die Mitte (t=60–62s) ─
i3  60     2    0.25   392.00    0.8      0.0     0.0     ; G4, Mitte annähern
i3  60     2    0.22   493.88   -0.8      0.0     0.0     ; B4, Mitte annähern

e

</CsScore>

</CsoundSynthesizer>
