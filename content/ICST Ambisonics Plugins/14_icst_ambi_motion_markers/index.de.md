---
title: ICST Ambi Motion Markers
date: 2026-06-21T00:00:00
weight: 85
draft: false
description: "Marker-basierter Workflow für OSC-Preview und Automation-Aufnahme mit dem ICST AmbiEncoder in REAPER, inklusive CSV-Import und Good Practices."
---

Level: Intermediate | Zielgruppe: Komponist:in, Sounddesigner:in, Spatial-Audio-Techniker:in, Studierende.

Diese Seite beschreibt, wie du AmbiEncoder-Bewegungen mit REAPER-Markern definierst, per OSC vorhörst und als Automation aufzeichnest.

> **Zuerst herunterladen:** Alles Nötige ist im Bundle — [ICST Ambi Motion Markers Bundle herunterladen](https://github.com/joambi/icst_ambisonics/raw/main/Scripts/bundles/ICST_Ambi_Motion_Markers_Bundle.zip) (Lua-Scripts, Python-Worker, Beispiel-CSVs, Handbuch). [Inhalt auf GitHub ansehen](https://github.com/joambi/icst_ambisonics/tree/main/Scripts/bundles/ICST_Ambi_Motion_Markers_Bundle).

## Was es macht

`ICST Ambi Motion Markers` ist ein REAPER-Workflow auf Basis von Timeline-Markern. Statt Automationskurven von Hand zu zeichnen, definierst du Positionen als benannte Marker auf der Timeline — und hörst die entstehende Bewegung per OSC vor oder nimmst sie als Automation auf.

Damit kannst du:

- Quellenpositionen als Marker-Cues definieren
- einzelne Paare oder ganze Serien per OSC vorhören
- denselben Bewegungsverlauf als AmbiEncoder-Automation aufnehmen
- Cue-Sets per CSV importieren statt Markertexte von Hand zu schreiben

Das zentrale Konzept ist das **S/E-Paar**: `S` markiert den Beginn eines Bewegungssegments, `E` das Ende. Jede Vorschau und jede Aufnahme arbeitet entweder auf einem ausgewählten Paar oder auf einer Serie von Paaren ab `S` bis zum letzten Marker.

![ICST Ambi Motion Marker GUI mit vier geladenen Markern](/motion-markers/gui-overview.gif)

## Voraussetzungen

Vor der Installation sicherstellen, dass vorhanden ist:

- **REAPER** (v6 oder neuer empfohlen)
- **ICST AmbiEncoder** installiert und funktionsfähig — siehe [Installation](/de/icst-ambisonics-plugins/02_installation/)
- **Python 3.9 oder neuer** — [python.org/downloads](https://www.python.org/downloads/)
- OSC-Input im AmbiEncoder-Plugin aktiviert — siehe [OSC](/de/icst-ambisonics-plugins/13_osc/)

## Installation

### 1. Scripts in REAPER einbinden

Aus dem heruntergeladenen Bundle diese ReaScripts über *Actions → Load ReaScript* importieren:

- `Scripts/JS_Ambi_Motion_Marker_GUI.lua`
- `Scripts/JS_Import_Ambi_Markers_From_CSV.lua`

### 2. Python-Worker ablegen

Die GUI startet `reaper_marker_ambi_motion.py` als Hintergrundprozess für OSC-Befehle. Die Datei kann beliebig abgelegt werden — naheliegend ist neben den Lua-Scripts:

```text
Scripts/reaper_marker_ambi_motion.py
```

Benötigtes Python-Paket installieren:

```bash
pip3 install python-osc
```

Danach den Python-Pfad im GUI-Feld `Python` eintragen. Der korrekte Pfad lässt sich im Terminal mit `which python3` herausfinden:

```text
# macOS / Linux
/usr/local/bin/python3
/Users/yourname/.pyenv/versions/3.11.8/bin/python3

# Windows (Beispiel)
C:\Python311\python.exe
```

Das GUI übergibt `reaper_marker_ambi_motion.py` und die OSC-Parameter zur Laufzeit — kein manueller Start erforderlich.

### 3. ICST-Plugin konfigurieren

`AmbiEncoder_64` auf der Zielspur einbinden und OSC-Input aktivieren. Der Port im Plugin muss mit dem GUI-Port übereinstimmen (Standard: `50001`).

## Marker-Workflow

### Marker-Syntax

Marker werden mit Positionsdaten in dieser Form benannt:

```text
ambi 1 a=-45 e=0 d=0.8
ambi 2 a=20 e=0 d=0.7
```

`1` / `2` = Quellindex, `a` = Azimut, `e` = Elevation, `d` = Distanz.

Mehrere Quellen am selben Cue-Zeitpunkt können in einem Marker stehen:

```text
ambi 1 a=-45 e=0 d=0.8 | ambi 2 a=20 e=0 d=0.7
```

### S und E setzen

In der GUI-Markerliste repräsentiert jede Zeile einen Marker. Linke Seite einer Zeile klicken → `S` (Start), rechte Seite → `E` (Ende). Danach `Set Selection` klicken, um den REAPER-Zeitbereich zwischen S und E zu erstellen.

`S` und `E` zusammen definieren ein Bewegungssegment — von der Quellposition bei `S` zur Position bei `E`.

![S/E-Selektion aktiv mit Konsolenausgabe](/motion-markers/se-selection-console.gif)

## Cues per CSV importieren

Für größere Projekte ist der CSV-Import der empfohlene Weg — alle Cues im Tabellenformat definieren, einmal importieren.

### Format: Azimut/Elevation/Distanz

```csv
time,index,source,azimuth,elevation,distance
1.2,1,1,-45,0,0.8
1.2,1,2,20,0,0.7
9.2,2,1,45,20,0.5
9.2,2,2,90,0,0.2
```

### Format: x/y/z

```csv
time,index,source,x,y,z
1.2,1,1,-0.566,0.566,0.000
1.2,1,2,0.239,0.658,0.000
```

### Import in der GUI

1. `Load CSV` im Marker-Panel klicken
2. CSV-Datei auswählen
3. passende Marker im Projekt werden automatisch ersetzt

![Import-Ambi-Markers-From-CSV-Dialog](/motion-markers/csv-import-dialog.png)

Beispiel-CSV-Dateien sind im Bundle enthalten: `ambi_markers_aed_example.csv` und `ambi_markers_xyz_example.csv`.

## Hauptfunktionen

### Send pair

Sendet das aktuell gewählte `S → E`-Paar per OSC — die Quelle bewegt sich im Plugin, aber es wird keine Automation geschrieben. Damit lässt sich ein einzelnes Segment vor der Aufnahme testen und verfeinern.

![Send-pair-Workflow mit Konsolenausgabe nach der Bewegung](/motion-markers/opt_workflow-03.gif)

### Send series

Sendet alle Segmente vom aktuellen `S`-Marker bis zum letzten Marker der Liste, eines nach dem anderen. Für die Vorschau einer kompletten Phrase oder Szene.

### Record pair

Nimmt das gewählte `S → E`-Segment als AmbiEncoder-Automation auf. Die AmbiEncoder-Spur muss vor dem Klick selektiert sein.

### Record series

Gleiche Bereichslogik wie `Send series`, schreibt aber Automation für jedes Segment während der Bewegungsablauf durchläuft.

## Erste Schritte

### 1. Einzelne Bewegung vorhören

1. GUI öffnen (`JS_Ambi_Motion_Marker_GUI.lua` über das Actions-Menü starten)
2. zwei Marker mit `ambi`-Namen in REAPER setzen, oder CSV importieren
3. `S` auf den ersten Marker, `E` auf den zweiten setzen
4. `Set Selection`, dann `Send pair` klicken
5. die Quelle sollte sich im AmbiEncoder-Plugin bewegen

Was zu sehen sein sollte: Vorschau-Cursor bewegt sich, OSC-Ausgabe in der Konsole, keine Automation geschrieben.

### 2. Ganze Serie vorhören

1. `S` auf den ersten Marker der Phrase setzen
2. `Send series` klicken
3. die GUI läuft automatisch durch alle Segmente bis zum letzten Marker

### 3. Ein Paar als Automation aufnehmen

1. AmbiEncoder-Spur in REAPER selektieren
2. `S` und `E` setzen
3. `Record pair` klicken

Was zu sehen sein sollte: Transport läuft, Plugin bewegt sich, Automation-Lanes erhalten Positionsdaten.

### 4. Ganze Serie aufnehmen

1. AmbiEncoder-Spur selektieren
2. `S` auf den ersten Marker setzen
3. `Record series` klicken

Der Transport läuft die komplette Serie durch und schreibt Automation für jedes Segment.

## Good Practices

- CSV als Source of Truth verwenden — leichter zu bearbeiten und versionieren als manuelle Marker
- immer zuerst mit `Send pair` vorhören, bevor aufgenommen wird
- Marker-Indizes stabil halten — Umnummerieren bricht CSV-Re-Imports
- eine Quelle pro CSV-Zeile
- musikalisch klare Cue-Punkte setzen (an Phrasen-Grenzen, nicht mitten in einer Geste)
- Konsolenausgabe beim Debuggen aktivieren, beim Aufführen deaktivieren

## Troubleshooting

### „No markers or regions with 'ambi...' found"

Die Markerliste ist leer. Marker manuell hinzufügen oder `Load CSV` ausführen. Jeder Markername muss mit `ambi` beginnen (Gross-/Kleinschreibung beachten).

### Keine Bewegung im Plugin

Prüfen:

- OSC-Input im AmbiEncoder-Plugin aktiviert
- Port im Plugin stimmt mit GUI-Port überein (Standard: 50001)
- `S`- und `E`-Positionen sind tatsächlich verschieden — identische Positionen erzeugen keine sichtbare Bewegung

### `Send series` verhält sich wie `Send pair`

Es gibt nur noch ein Segment zwischen dem aktuellen `S`-Marker und dem letzten Marker. `S` auf einen früheren Marker setzen.

### Python nicht gefunden / Worker startet nicht

- bestätigen, dass der Pfad im `Python`-Feld auf ein gültiges Python-3-Executable zeigt (`which python3` auf macOS/Linux)
- bestätigen, dass `python-osc` für genau dieses Python installiert ist: `dein/python/pfad -m pip install python-osc`
- Konsolenausgabe in der GUI auf den genauen Fehler prüfen

### CSV-Import schlägt fehl

Prüfen:

- Spaltenbezeichnungen stimmen exakt (`time`, `index`, `source`, dann Positionsspalten)
- Dezimalpunkte (keine Kommas) bei Zahlen
- eine Quelle pro Zeile
- gültige Zeitwerte und Indizes
