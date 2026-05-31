---
title: "Zylia ZM-1 Recording — Reaper Session Beispiel"
tags:
  - post
  - reaper
  - zylia
  - recording
  - hoa
  - ambisonics
---

Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

---

## Zylia ZM-1 — HOA Recording in Reaper

**Aufgabe:** Eine Feld-Aufnahme mit dem Zylia ZM-1 Mikrofon in Reaper aufnehmen, abhören und als 3rd Order Ambisonics (16-Kanal AmbiX) rendern.

---

## Das Zylia ZM-1 Mikrofon

Das **Zylia ZM-1** ist ein sphärisches Mikrofonarr mit 19 Kapseln, das **3rd Order Ambisonics (HOA)** aufnimmt.

| Eigenschaft      | Wert                              |
|------------------|-----------------------------------|
| Kapseln          | 19 (sphärisch angeordnet)         |
| Ambisonics-Order | 3rd Order HOA                     |
| Ausgangskanäle   | 16 (AmbiX, ACN-Reihenfolge)       |
| Normierung       | SN3D                              |
| Interface        | USB (Zylia ASIO-Treiber)          |
| Samplerate       | 48 000 Hz                         |

---

## Signal-Routing in Reaper

```
ZYLIA ZM-1 (Hardware)
    │  19 Kapseln (Roh-Signal, intern konvertiert)
    ▼
01  ZYLIA ZM-1 Input-Track     [16ch · AmbiX · 3rd Order]
    │  AUXSEND → alle 16 Kanäle
    ▼
02  HOA Bus                    [16ch · sammelt alle HOA-Signale]
    │           │
    ▼           ▼
03  ICST        04  Binaural Monitor
    AmbiDecoder     (SPARTA ambiDEC / IEM BinauralDecoder)
    [16ch→18ch]     [16ch → Stereo]
    │               │
    ▼               ▼
Lautsprecher    Kopfhörer (→ Stereo Master)

05  HOA Render Bus  [16ch · gemuted · zum Rendern aktivieren]
```

---

## Reaper Session herunterladen

→ **[zylia_recording_example.RPP](../../downloads/zylia-recording-example/zylia_recording_example.RPP)**

---

## Track-Übersicht

| # | Track-Name | Kanäle | Funktion |
|---|-----------|--------|----------|
| 00 | Session Notes | 2ch (muted) | Routing-Dokumentation |
| 01 | ZYLIA ZM-1 Input | **16ch** | Aufnahme vom Zylia Interface (Inputs 1–16) |
| 02 | HOA Bus | **16ch** | Sammelt alle HOA-Signale — bleibt leer |
| 03 | ICST AmbiDecoder | **16→18ch** | Lautsprecher-Monitoring im Studio |
| 04 | Binaural Monitor | **16→2ch** | Kopfhörer-Monitoring (→ Stereo Master) |
| 05 | HOA Render Bus | **16ch** | Export-Bus (muted; zum Rendern aktivieren) |

---

## Schritt-für-Schritt Setup

### 1. Zylia Interface vorbereiten

1. Zylia ZM-1 via USB anschließen
2. Im Betriebssystem: **ZYLIA ASIO-Treiber** auswählen
3. In Reaper: **Options → Preferences → Audio → Device** → ZYLIA ASIO

### 2. Track 01 — Eingangskanäle zuweisen

1. Rechtsklick auf Track 01 → **Track properties**
2. **Record input**: `Input 1 / Multichannel` → alle 16 Kanäle (1–16)
3. Track hat bereits **NCHAN 16** in der Session-Datei gesetzt
4. Track ist bereits **armed** (roter REC-Button)

### 3. Track 03 — ICST AmbiDecoder einrichten

1. FX-Chain auf Track 03 öffnen (FX-Button)
2. Plugin hinzufügen: **ICST Ambisonics Decoder** (VST3)
3. Plugin konfigurieren:
   - **Ambisonics Order**: 3
   - **Channel Format**: AmbiX (ACN / SN3D)
   - **Speaker Setup**: Lautsprecher-Preset für das Studio laden
4. Hardware-Outputs (Lautsprecher-Kanäle 1–18) sind in der Session vorbereitet

### 4. Track 04 — Binaural Decoder einrichten

1. FX-Chain auf Track 04 öffnen
2. Empfohlene Plugins (einer reicht):
   - **SPARTA ambiDEC** (kostenlos, [sparta.aalto.fi](https://sparta.aalto.fi))
   - **IEM BinauralDecoder** (kostenlos, [plugins.iem.at](https://plugins.iem.at))
   - **dearVR AMBI MICRO** (kommerziell)
3. Plugin-Eingang: 16-Kanal HOA (vom HOA Bus)
4. Plugin-Ausgang: Stereo → geht direkt zum Stereo-Master

### 5. Aufnahme starten

1. Alle Pegel prüfen (Meter auf Track 01 zeigen Eingang vom Zylia)
2. **Record** (Ctrl+R) → Track 01 nimmt auf
3. Dateipfad: `audio/recordings/` (relativ zur Session-Datei)

### 6. Rendern (HOA Export)

Für eine vollwertige AmbiX-Datei zum Rendern:

1. Track 05 **unmuten** (HOA Render Bus)
2. **File → Render** öffnen
3. Einstellungen:
   - **Source**: Track 05 (oder Region)
   - **Channels**: 16
   - **Format**: WAV, 24-bit oder 32-bit float
   - **Sample rate**: 48 000 Hz
4. Ergebnis: `renders/zylia_hoa_[regionname].wav` (16-Kanal AmbiX)

---

## AmbiX Kanalreihenfolge (ACN / SN3D)

| ACN | Order | Degree | Bezeichnung |
|-----|-------|--------|-------------|
| 0  | 0 | 0 | W (Omni) |
| 1  | 1 | -1 | Y |
| 2  | 1 | 0 | Z |
| 3  | 1 | +1 | X |
| 4  | 2 | -2 | V |
| 5  | 2 | -1 | T |
| 6  | 2 | 0 | R |
| 7  | 2 | +1 | S |
| 8  | 2 | +2 | U |
| 9  | 3 | -3 | Q |
| 10 | 3 | -2 | O |
| 11 | 3 | -1 | M |
| 12 | 3 | 0 | K |
| 13 | 3 | +1 | L |
| 14 | 3 | +2 | N |
| 15 | 3 | +3 | P |

---

## Optionaler Workflow mit ZYLIA Beamformer

Statt des ICST AmbiDecoders kann auf Track 02 der **ZYLIA Beamformer** eingesetzt werden:

- Erstellt virtuelle Richtmikrofone aus dem HOA-Feld
- Echtzeit-Energiekarte zeigt die Quellenlokalisation
- Unterstützt Polar-Patterns: Kardioid, Niere, Acht, Kugel
- Output: Mono- oder Stereo-Kanäle für einzelne Quellen

```
02 HOA Bus (16ch)
    │
    ▼ [ZYLIA Beamformer Plugin]
    ├→ Virtuelle Mikrofone (N×Mono/Stereo)
    └→ Weiter zur Ambisonics-Wiedergabe
```

→ Mehr Infos: [ZYLIA Beamformer](https://www.zylia.co/zylia-beamformer.html)

---

## Weiterführende Links

- [ZYLIA ZM-1 Produktseite](https://www.zylia.co/zylia-zm-1.html)
- [ZYLIA Studio PRO Software](https://www.zylia.co/zylia-studio.html)
- [ICST Ambisonics Plugins](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)
- [SPARTA Plugins (ambiDEC)](https://sparta.aalto.fi)
- [IEM Plugin Suite](https://plugins.iem.at)
- [AmbiX Format Spezifikation](https://en.wikipedia.org/wiki/Ambisonic_data_exchange_formats)

---

©2025 ICST
