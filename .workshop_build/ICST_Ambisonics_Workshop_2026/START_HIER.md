# ICST Ambisonics Workshop 2026
## So startest du

Entpacke dieses ZIP in einen Ordner deiner Wahl.
Alle relativen Pfade (Audio ↔ REAPER-Projekt, HRTF ↔ Csound) funktionieren
dann automatisch — solange du die Ordnerstruktur nicht veränderst.

---

## Ordnerinhalt

| Ordner | Inhalt | Programm |
|---|---|---|
| `html/` | Workshop-Handouts, Raumkurven-Diagramm | Browser |
| `csound/` | Cabbage/Csound-Instrumente + HRTF-Files | Cabbage oder csound CLI |
| `reaper/` | REAPER-Projekt + Mono-Audio-Quellen | REAPER |
| `maxmsp/` | Max/MSP OSC-Patcher | Max/MSP |
| `plugins-macos/` | Additive-Synth VST3 (nur macOS) | manuell installieren |

---

## Schnellstart nach Umgebung

### Browser (kein Download nötig)
Die HTML-Handouts können auch direkt online aufgerufen werden:
→ https://ambisonics.ch/downloads/workshop-2026/html/ICST_Workshop_Ablauf.html

### REAPER
1. ICST Ambisonics Plugins installieren (→ ambisonics.ch/start)
2. `reaper/spatial_counterpoint_workshop.RPP` in REAPER öffnen
3. Plugin-Pfade beim ersten Öffnen bestätigen

### Csound / Cabbage
1. Cabbage installieren (→ cabbageaudio.com)
2. Eine `.csd`-Datei aus `csound/` in Cabbage öffnen
3. Die HRTF-Files (`hrtf-48000-left.dat` / `hrtf-48000-right.dat`) liegen
   bereits im selben Ordner — kein SSDIR-Setup nötig

### Ambisonics Exercise (Csound)
`csound/icst_ambisonics_exercise.csd`
→ Binaural-Monitoring + B-Format 16ch-Datei-Ausgabe
→ Öffne in Cabbage oder starte mit:
   `csound csound/icst_ambisonics_exercise.csd`
→ Die B-Format-Datei wird im `csound/`-Ordner abgelegt.

---

## Voraussetzungen

- **REAPER** 7.x → https://reaper.fm
- **ICST Ambisonics Plugins** (AmbiEncoder, AmbiDecoder, etc.)
  → https://ambisonics.ch/start
- **Cabbage** (für Csound-Instrumente) → https://cabbageaudio.com
- **Max/MSP** (für Patcher) → https://cycling74.com

---

ICST / Zurich University of the Arts — https://ambisonics.ch
