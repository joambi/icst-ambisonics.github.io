---
title: ICST Ambi Motion Markers
date: 2024-12-31 16:00:00 -0800
weight: 140
draft: false
description: REAPER-Timeline-Marker verwenden, um AmbiEncoder-Quellbewegungen zu definieren, sie per OSC vorhören und als Automation aufzeichnen.
---

Level: Intermediate | Zielgruppe: Komponist:in, Sound-Designer:in, Spatial-Audio-Techniker:in, Studierende.

Nutze diese Seite, wenn du AmbiEncoder-Bewegungen mit REAPER-Markern definieren, per OSC vorhören und als Automation aufzeichnen möchtest.

## Was es macht

`ICST Ambi Motion Markers` ist ein REAPER-Workflow, der auf Timeline-Markern aufbaut.

Es ermöglicht:

- Quellpositionen als Marker-Cues definieren
- ein Paar oder eine ganze Serie per OSC vorhören
- den gleichen Bewegungspfad als AmbiEncoder-Automation aufzeichnen
- Cue-Sets aus einer CSV importieren statt Marker-Text manuell einzutippen

Kerndateien:

- `JS_Ambi_Motion_Marker_GUI.lua`
- `JS_Import_Ambi_Markers_From_CSV.lua`
- `reaper_marker_ambi_motion.py`

## Installation

### 1. Scripts in REAPER einbinden

Diese ReaScripts importieren:

- `Scripts/JS_Ambi_Motion_Marker_GUI.lua`
- `Scripts/JS_Import_Ambi_Markers_From_CSV.lua`

### 2. Python-Abhängigkeit installieren

Das GUI startet `reaper_marker_ambi_motion.py` als Hintergrundprozess für OSC-Befehle.

Die Datei kann an einem beliebigen Ort abgelegt werden – eine naheliegende Wahl ist neben den Lua-Scripts:

`Scripts/reaper_marker_ambi_motion.py`

Benötigtes Paket installieren:

```
pip install python-osc
```

Den Python-Pfad im GUI (Feld Python) eintragen:

```
/Users/yourname/.pyenv/versions/3.11.8/bin/python3
```

Mit `which python3` im Terminal den korrekten Pfad auf dem eigenen System herausfinden. Das GUI übergibt `reaper_marker_ambi_motion.py` und die OSC-Parameter zur Laufzeit an diese ausführbare Datei — kein manueller Start erforderlich.

### 3. ICST-Plugin konfigurieren

`AmbiEncoder_64` auf dem Ziel-Track einbinden und OSC-Input aktivieren.

Den OSC-Port des Plugins mit der GUI-Einstellung abgleichen.

Typischer Standardwert:

```
50001
```

## Marker-Workflow

Marker können manuell in dieser Form eingegeben werden:

```
ambi 1 a=-45 e=0 d=0.8
ambi 2 a=20 e=0 d=0.7
```

Mehrere Quellen zum gleichen Cue-Zeitpunkt können in einem Marker kombiniert werden:

```
ambi 1 a=-45 e=0 d=0.8 | ambi 2 a=20 e=0 d=0.7
```

In der Marker-Liste:

- linke Seite einer Zeile klicken, um S zu setzen
- rechte Seite einer Zeile klicken, um E zu setzen
- **Set Selection** klicken, um den REAPER-Zeitbereich zu erstellen

## CSV-zuerst-Workflow

Für grössere Projekte ist der CSV-Import die empfohlene Methode.

**Unterstütztes Format: Azimut/Elevation/Distanz**

```
time,index,source,azimuth,elevation,distance
1.2,1,1,-45,0,0.8
1.2,1,2,20,0,0.7
9.2,2,1,45,20,0.5
9.2,2,2,90,0,0.2
```

**Unterstütztes Format: x/y/z**

```
time,index,source,x,y,z
1.2,1,1,-0.566,0.566,0.000
1.2,1,2,0.239,0.658,0.000
```

**Import im GUI**

**Load CSV** im Marker-Panel verwenden:

- **Load CSV** klicken
- CSV-Datei auswählen
- passende Marker im Projekt werden automatisch ersetzt

Beispiel-CSV-Dateien:

- `ambi_markers_aed_example.csv`
- `ambi_markers_xyz_example.csv`

## Hauptbedienelemente

**Send pair**

Sendet das aktuell gewählte S-E-Paar per OSC. Damit lässt sich ein einzelnes Bewegungssegment testen.

**Send series**

Sendet eine ganze Marker-Serie vom aktuellen S-Marker bis zum letzten Marker in der Liste. Für die Vorschau einer vollständigen Phrase oder Szene.

**Record pair**

Zeichnet das gewählte Paar als AmbiEncoder-Automation auf.

**Record series**

Verwendet dieselbe Bereichslogik wie Send series, schreibt aber Automation während die Bewegung abgespielt wird.

## Schritt-für-Schritt-Test-Workflow

### Test 1: Einzelpaar-Vorschau

1. GUI laden
2. S und E setzen
3. **Set Selection** klicken
4. **Send pair** klicken
5. prüfen, ob sich die Quelle im ICST-Plugin bewegt

Erwartetes Ergebnis: Vorschau-Cursor bewegt sich, OSC-Bewegung ist sichtbar, keine Automation wird geschrieben.

### Test 2: Serien-Vorschau

1. S auf den gewünschten ersten Marker setzen
2. **Send series** klicken
3. prüfen, ob die Wiedergabe Segment für Segment bis zum letzten Marker weiterläuft

Erwartetes Ergebnis: Alle Segmente nach S werden abgespielt, das Ende der Serie ist der letzte Marker.

### Test 3: Paar-Aufnahme

1. AmbiEncoder-Track auswählen
2. S und E wählen
3. **Record pair** klicken
4. prüfen, ob Automation geschrieben wird

Erwartetes Ergebnis: Transport läuft, Plugin bewegt sich, Automations-Lanes erhalten Daten.

### Test 4: Serien-Aufnahme

1. AmbiEncoder-Track auswählen
2. gewünschtes S setzen
3. **Record series** klicken
4. prüfen, ob der gleiche Serienpfad wie bei Send series aufgezeichnet wird

Erwartetes Ergebnis: Transport läuft die komplette Serie durch, Bewegung stimmt mit Send series überein, Automation wird für jedes Segment geschrieben.

## Empfehlungen

- CSV als zentrale Datenquelle für grössere Cue-Sets verwenden
- vor der Aufnahme mit Send pair vorhören
- Marker-Indizes über Revisionen hinweg stabil halten
- eine Quelle pro CSV-Zeile verwenden
- Start- und End-Cues musikalisch sinnvoll setzen
- Konsolenausgabe beim Debuggen aktivieren, bei Live-Einsatz deaktivieren

## Fehlerbehebung

**"No markers or regions with 'ambi...' found"**

Die Marker-Liste ist leer. Marker manuell hinzufügen oder Load CSV ausführen. Jeder Marker-Name muss mit `ambi` beginnen (Gross-/Kleinschreibung beachten).

**Keine Bewegung im Plugin**

Prüfen:

- OSC-Input im Plugin aktiviert
- korrekter OSC-Port
- Marker-Positionen von Start und Ende unterscheiden sich

**Send series verhält sich wie Send pair**

Normalerweise bedeutet das, dass zwischen dem aktuellen S-Marker und dem letzten Marker nur noch ein Segment übrig ist.

**CSV-Import schlägt fehl**

Prüfen:

- Spaltennamen
- Dezimalpunkte
- eine Quelle pro Zeile
- gültige Zeitwerte und Indizes

## Downloads

Das vorbereitete Bundle für den Workflow verwenden:

[ICST Ambi Motion Markers Bundle herunterladen](https://ambisonics.ch/icst-ambisonics-plugins/downloads/)

Empfohlene Bundle-Inhalte:

- GUI-Script
- CSV-Import-Script
- Python-OSC-Worker
- Beispiel-CSV-Dateien
- Handbuch
