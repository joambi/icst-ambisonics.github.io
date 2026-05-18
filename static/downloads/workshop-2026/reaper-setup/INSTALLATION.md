# ICST Ambisonics Workshop 2026 — Reaper Setup

## Inhalt dieses Ordners

```
reaper-setup/
├── spatial_counterpoint_workshop.RPP   ← Workshop-Session (hier starten)
├── setup_icst_routing.lua              ← Routing-Script (einmalig ausführen)
├── icst_osc_raumkurven_xyz.lua         ← OSC XYZ-Trajektorien
├── icst_stereo_pan_distanz.lua         ← Distanz-basierter Stereo-Panner
├── icst_stereo_pan_raumkurven.lua      ← Spatial Curve Panner
├── automation_plan.csv                 ← Referenz für Automation-Übung
└── audio/
    ├── 01_percussion_impulses_mono.wav
    ├── 02_depth_drone_mono.wav
    └── 03_counterpoint_melody_mono.wav
```

---

## Schritt 1 — REAPER installieren

Download: https://www.reaper.fm/download.php
Kostenlose 60-Tage Testversion — voll funktionsfähig.

---

## Schritt 2 — ICST Plugins installieren

1. **AmbiEncoder_64.vst3** und **AmbiDecoder.vst3** nach `/Library/Audio/Plug-Ins/VST3/` kopieren
2. REAPER öffnen → Preferences → Plug-ins → VST → Re-scan
3. Im FX-Browser nach "ICST" suchen — alle Plugins sichtbar? ✓

Download & Installationsanleitung: https://ambisonics.ch/learn

---

## Schritt 3 — Session öffnen

1. `spatial_counterpoint_workshop.RPP` in REAPER öffnen
2. Bei fehlenden Audio-Dateien: auf den `audio/`-Ordner zeigen

Die Session enthält 7 Tracks:
- `00` Workshop-Notes (Anleitung direkt in Reaper)
- `01–03` Mono-Quellen (Percussion, Drone, Melody)
- `10` ICST MultiEncoder Platzhalter → **hier AmbiEncoder_64 einfügen**
- `11` B-Format HOA Bus (64ch)
- `12` Binaural Decoder Platzhalter → **hier IEM BinauralDecoder einfügen**

---

## Schritt 4 — Routing einrichten (Lua-Script)

1. Actions → Show action list → Load ReaScript
2. `setup_icst_routing.lua` laden und ausführen
3. Das Script verdrahtet alle Sends automatisch:
   - Quellen 01–03 → AmbiEncoder (Inputs 1/2, 3/4, 5/6)
   - AmbiEncoder → HOA Bus
   - HOA Bus → Decoder

---

## Schritt 5 — Erste Klänge

Play → du solltest binaural encodierten Ambisonics auf Kopfhörern hören.
Azimut / Elevation / Distanz im AmbiEncoder_64 anpassen → Quelle bewegt sich im Raum.

---

## Benötigte Plugins

| Plugin | Format | Download |
|--------|--------|----------|
| ICST AmbiEncoder_64 | VST3 | https://ambisonics.ch/learn |
| ICST AmbiDecoder | VST3 | https://ambisonics.ch/learn |
| IEM BinauralDecoder | VST3/LV2 | https://plugins.iem.at |

---

*ICST Ambisonics Workshop 2026 — ZHdK / ICST*
