---
title: ICST Ambi Motion Markers
date: 2026-06-21T00:00:00
weight: 85
draft: false
description: "Marker-basierter Workflow für OSC-Preview und Automation-Aufnahme mit dem ICST AmbiEncoder in REAPER, inklusive CSV-Import und Good Practices."
---

Level: Intermediate | Zielgruppe: Komponist:in, Sounddesigner:in, Spatial-Audio-Techniker:in, Studierende.

Nutze diese Seite, wenn du Bewegungen für den AmbiEncoder mit REAPER-Markern definieren, per OSC vorhören und als Automation aufzeichnen willst.

## Was es macht

`ICST Ambi Motion Markers` ist ein REAPER-Workflow auf Basis von Timeline-Markern.

Damit kannst du:

- Quellenpositionen als Marker-Cues definieren
- einzelne Paare oder ganze Serien per OSC vorhören
- denselben Bewegungsverlauf als AmbiEncoder-Automation aufnehmen
- Cue-Sets per CSV importieren statt Markertexte von Hand zu schreiben

Zentrale Dateien:

- `JS_Ambi_Motion_Marker_GUI.lua`
- `JS_Import_Ambi_Markers_From_CSV.lua`
- `reaper_marker_ambi_motion.py`

## Installation

### 1. Scripts in REAPER einbinden

Importiere diese ReaScripts:

- `Scripts/JS_Ambi_Motion_Marker_GUI.lua`
- `Scripts/JS_Import_Ambi_Markers_From_CSV.lua`

### 2. Python-Abhängigkeit installieren

Die GUI startet einen Python-Worker für OSC-Bewegungen.

Installieren:

```bash
pip install python-osc
```

Danach den Python-Pfad in der GUI setzen.

Beispiel:

```text
/Users/yourname/.pyenv/versions/3.11.8/bin/python3
```

### 3. ICST-Plugin konfigurieren

Setze `AmbiEncoder_64` auf die Zielspur und aktiviere OSC Input.

Der OSC-Port im Plugin muss mit dem GUI-Port übereinstimmen.

Typischer Default:

```text
50001
```

## Marker-Workflow

Marker können weiterhin direkt so eingegeben werden:

```text
ambi 1 a=-45 e=0 d=0.8
ambi 2 a=20 e=0 d=0.7
```

Mehrere Quellen an einem Cue-Zeitpunkt können in einem Marker stehen:

```text
ambi 1 a=-45 e=0 d=0.8 | ambi 2 a=20 e=0 d=0.7
```

In der Marker-Liste:

- links klicken = `S`
- rechts klicken = `E`
- `Set Selection` erzeugt die REAPER-Time-Selection

## CSV-first Workflow

Für größere Projekte ist CSV der empfohlene Weg.

### Unterstütztes Format: azimuth/elevation/distance

```csv
time,index,source,azimuth,elevation,distance
1.2,1,1,-45,0,0.8
1.2,1,2,20,0,0.7
9.2,2,1,45,20,0.5
9.2,2,2,90,0,0.2
```

### Unterstütztes Format: x/y/z

```csv
time,index,source,x,y,z
1.2,1,1,-0.566,0.566,0.000
1.2,1,2,0.239,0.658,0.000
```

### Import in der GUI

Nutze `Load CSV` im Marker-Panel:

1. `Load CSV` klicken
2. CSV auswählen
3. passende Marker im Projekt werden automatisch ersetzt

Beispieldateien:

- `ambi_markers_aed_example.csv`
- `ambi_markers_xyz_example.csv`

## Hauptfunktionen

### Send pair

Sendet nur das aktuell gewählte `S -> E`-Paar per OSC.

### Send series

Sendet die komplette Serie vom aktuellen `S`-Marker bis zum letzten Marker der Liste.

### Record pair

Nimmt das gewählte Paar als AmbiEncoder-Automation auf.

### Record series

Verwendet dieselbe Bereichslogik wie `Send series`, schreibt dabei aber Automation.

## Schritt-für-Schritt-Test

### Test 1: einzelnes Pair vorhören

1. GUI öffnen
2. `S` und `E` setzen
3. `Set Selection`
4. `Send pair`
5. Bewegung im Plugin prüfen

### Test 2: Serie vorhören

1. `S` auf den gewünschten Startmarker setzen
2. `Send series`
3. prüfen, ob alle Segmente bis zum letzten Marker abgespielt werden

### Test 3: einzelnes Pair aufnehmen

1. AmbiEncoder-Spur selektieren
2. `S` und `E` wählen
3. `Record pair`
4. Automation prüfen

### Test 4: Serie aufnehmen

1. AmbiEncoder-Spur selektieren
2. `S` setzen
3. `Record series`
4. prüfen, ob dieselbe Serie wie bei `Send series` aufgezeichnet wird

## Good Practices

- CSV als Source of Truth verwenden
- vor dem Aufzeichnen zuerst `Send pair` testen
- Marker-Indizes stabil halten
- eine Quelle pro CSV-Zeile verwenden
- musikalisch klare Cue-Punkte setzen
- Console nur beim Debuggen aktivieren

## Troubleshooting

### Keine Bewegung im Plugin

Prüfen:

- OSC Input im Plugin aktiv
- korrekter OSC-Port
- Start- und Endwerte sind unterschiedlich

### `Send series` wirkt wie `Send pair`

Dann gibt es meist nur noch ein Segment zwischen aktuellem `S` und letztem Marker.

### CSV-Import schlägt fehl

Prüfen:

- Headernamen
- Dezimalpunkte
- eine Quelle pro Zeile
- gültige Zeiten und Indizes

## Downloads

Nutze das vorbereitete Bundle:

- [ICST Ambi Motion Markers Bundle herunterladen](https://github.com/joambi/icst_ambisonics/raw/main/Scripts/bundles/ICST_Ambi_Motion_Markers_Bundle.zip)
- [Bundle-Inhalt auf GitHub ansehen](https://github.com/joambi/icst_ambisonics/tree/main/Scripts/bundles/ICST_Ambi_Motion_Markers_Bundle)

Empfohlener Inhalt:

- GUI-Script
- CSV-Import-Script
- Python-OSC-Worker
- Beispiel-CSVs
- Handbuch
