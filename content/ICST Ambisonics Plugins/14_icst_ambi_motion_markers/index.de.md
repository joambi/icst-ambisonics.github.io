---
title: ICST Ambi Motion Markers
date: 2026-06-21T00:00:00
weight: 85
draft: false
toc: true
description: "Marker-basierter Workflow für OSC-Preview und Automation-Aufnahme mit dem ICST AmbiEncoder in REAPER, inklusive CSV-Import und Good Practices."
---

Level: Intermediate | Zielgruppe: Komponist:in, Sounddesigner:in, Spatial-Audio-Techniker:in, Studierende.

Diese Seite beschreibt, wie du AmbiEncoder-Bewegungen mit REAPER-Markern definierst, per OSC vorhörst und als Automation aufzeichnest.

> **Zuerst herunterladen:** Alles Nötige ist im Bundle — [ICST Ambi Motion Markers Bundle herunterladen](/downloads/ICST_Ambi_Motion_Markers_Bundle.zip) (Lua-Scripts, Python-Worker, Beispiel-CSVs, Handbuch).

## Was es macht

`ICST Ambi Motion Markers` ist ein REAPER-Workflow auf Basis von Timeline-Markern. Statt Automationskurven von Hand zu zeichnen, definierst du Positionen als benannte Marker auf der Timeline — und hörst die entstehende Bewegung per OSC vor oder nimmst sie als Automation auf.

Marker sind beständig und editierbar wie jeder REAPER-Marker — du kannst sie in einer CSV versionieren, umbenennen, auf der Timeline verschieben und erneut importieren, ohne das Plugin anzufassen. Automationskurven bieten das nicht.

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

<div class="hero__links" style="margin-top:0; margin-bottom:1.5rem;">
  <a class="hero__link hero__link--primary" href="/downloads/ICST_Ambi_Motion_Markers_Bundle.zip">
    <i class="fas fa-download"></i> Bundle herunterladen
  </a>
  <a class="hero__link" href="/de/icst-ambisonics-plugins/02_installation/">ICST Plugin Installation</a>
  <a class="hero__link" href="/de/icst-ambisonics-plugins/13_osc/">OSC Setup</a>
</div>

### 1. Scripts in REAPER einbinden

In REAPER: *Actions-Menü → Load ReaScript…* — dann aus dem Bundle auswählen:

- `scripts/JS_Ambi_Motion_Marker_GUI.lua`
- `scripts/JS_Import_Ambi_Markers_From_CSV.lua`

![REAPER Actions-Menü — Load ReaScript Dialog](/motion-markers/install-load-reascript.png)

### 2. Python-Worker ablegen

Die GUI startet `reaper_marker_ambi_motion.py` als persistenten Hintergrundprozess für OSC-Befehle. Die Datei kann beliebig abgelegt werden — naheliegend ist neben den Lua-Scripts. Im Bundle liegt sie unter:

```text
python/reaper_marker_ambi_motion.py
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

Die GUI startet den Worker automatisch beim ersten Klick auf einen Button — kein manueller Start nötig. Der Worker läuft weiter, wenn die GUI geschlossen wird, und wird beim nächsten Öffnen wiederverwendet.

### 3. ICST-Plugin konfigurieren

`AmbiEncoder_64` auf der Zielspur einbinden und OSC-Input aktivieren. Der Port im Plugin muss mit dem GUI-Port übereinstimmen (Standard: `50001`).

### Installations-Checkliste

Vor dem ersten Test prüfen:

<ul class="quick-start-steps" style="margin-top:0.5rem;">
  <li><strong>Beide Lua-Scripts geladen</strong> <span>Sichtbar in <em>Actions → Show action list</em> als <code>JS_Ambi_Motion_Marker_GUI</code> und <code>JS_Import_Ambi_Markers_From_CSV</code></span></li>
  <li><strong>Python-Pfad in der GUI gesetzt</strong> <span>Das Feld <code>Python</code> zeigt auf ein gültiges Python-3-Executable — mit <code>which python3</code> im Terminal prüfen</span></li>
  <li><strong>python-osc installiert</strong> <span><code>pip3 install python-osc</code> für dasselbe Python-Executable ausführen</span></li>
  <li><strong>AmbiEncoder OSC-Input aktiv</strong> <span>Plugin → OSC In aktiviert, Port stimmt mit GUI-Einstellung überein (Standard <code>50001</code>)</span></li>
</ul>

## Erste Schritte

Folgendes setzt voraus, dass die Installation abgeschlossen ist und die GUI geöffnet ist (`JS_Ambi_Motion_Marker_GUI.lua` über das Actions-Menü starten).

**S/E-Paare:** In der GUI-Markerliste die **linke Hälfte** einer Zeile klicken → `S` (Start), **rechte Hälfte** → `E` (Ende). Dann `Set Selection` klicken — damit wird der REAPER-Zeitbereich gesetzt, den die GUI für Vorschau und Aufnahme verwendet.

**Markernamen** folgen diesem Muster: `ambi 1 a=-45 e=0 d=0.8` — Quellindex, dann Azimut / Elevation / Distanz. Die GUI erkennt nur Marker, deren Name mit `ambi` beginnt. Marker können manuell in REAPER gesetzt oder aus einer CSV importiert werden.

### 1. Einzelne Bewegung vorhören

1. Zwei Marker in REAPER setzen — z. B. `ambi 1 a=-45 e=0 d=0.8` und `ambi 1 a=45 e=0 d=0.8` — oder CSV importieren
2. In der GUI-Markerliste `S` auf den ersten Marker, `E` auf den zweiten setzen
3. `Set Selection`, dann `Send pair` klicken
4. Die Quelle bewegt sich im AmbiEncoder-Plugin

Was zu sehen sein sollte: Vorschau-Cursor bewegt sich über den Zeitbereich, OSC-Ausgabe erscheint in der Konsole, keine Automation geschrieben.

### 2. Ganze Serie vorhören

1. `S` auf den ersten Marker der Phrase setzen
2. `Send series` klicken
3. Die GUI läuft automatisch durch alle Segmente bis zum letzten Marker

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

## Marker-Workflow

### Koordinatensystem

AmbiEncoder verwendet Kugelkoordinaten — Azimut (`a`), Elevation (`e`) und Distanz (`d`):

| Parameter | Bereich | Beschreibung |
|-----------|---------|--------------|
| `a` Azimut | −180 … +180° | 0° = vorne, −90° = links, +90° = rechts, ±180° = hinten |
| `e` Elevation | −90 … +90° | 0° = Horizontalebene, +90° = direkt oben, −90° = direkt unten |
| `d` Distanz | 0.0 … 1.0 | 1.0 = Oberfläche der Einheitssphäre; Werte über 1 platzieren die Quelle ausserhalb |

Die intern verwendete XYZ-Konversion folgt der ICST-Konvention: X = D·cos(E)·sin(A), Y = D·cos(E)·cos(A), Z = D·sin(E).

### Marker-Syntax

Marker werden mit Positionsdaten in dieser Form benannt:

```text
ambi 1 a=-45 e=0 d=0.8
ambi 2 a=20 e=0 d=0.7
```

`1` / `2` = Quellindex, `a` = Azimut, `e` = Elevation, `d` = Distanz.

Mehrere Quellen am selben Cue-Zeitpunkt können in einem Marker kombiniert werden:

```text
ambi 1 a=-45 e=0 d=0.8 | ambi 2 a=20 e=0 d=0.7
```

### S und E setzen

In der GUI-Markerliste repräsentiert jede Zeile einen Marker. Linke Seite einer Zeile klicken → `S` (Start), rechte Seite → `E` (Ende). Dann `Set Selection` klicken, um den REAPER-Zeitbereich zwischen S und E zu erstellen.

`S` und `E` definieren zusammen ein Bewegungssegment — von der Quellposition bei `S` zur Position bei `E`.

![S/E-Selektion aktiv mit Konsolenausgabe](/motion-markers/se-selection-console.gif)

## Cues per CSV importieren

Manuelle Marker funktionieren gut für wenige Cues. Wechsle zu CSV, sobald du mehr als sechs oder sieben Positionen hast, wenn Koordinaten aus einer Partitur oder einem Raumplanungs-Spreadsheet stammen, oder wenn du das Cue-Set zusammen mit dem Projekt in git versionieren möchtest. CSV bearbeiten, einmal `Load CSV` klicken — alle Marker werden aktualisiert, kein erneutes Eintippen.

### Format: AED

```csv
time,index,source,azimuth,elevation,distance
1.2,1,1,-45,0,0.8
1.2,1,2,20,0,0.7
9.2,2,1,45,20,0.5
9.2,2,2,90,0,0.2
```

### Format: XYZ

```csv
time,index,source,x,y,z
1.2,1,1,-0.566,0.566,0.000
1.2,1,2,0.239,0.658,0.000
```

### Import in der GUI

1. `Load CSV` im Marker-Panel klicken
2. CSV-Datei auswählen
3. Passende Marker im Projekt werden automatisch ersetzt

![Import-Ambi-Markers-From-CSV-Dialog](/motion-markers/csv-import-dialog.png)

Beispiel-CSV-Dateien sind im Bundle enthalten: `ambi_markers_aed_example.csv` und `ambi_markers_xyz_example.csv`.

## Hauptfunktionen

### Send pair

Sendet das aktuell gewählte `S → E`-Paar per OSC — die Quelle bewegt sich im Plugin, aber es wird keine Automation geschrieben. Damit lässt sich ein einzelnes Segment vor der Aufnahme testen und verfeinern.

Während der Wiedergabe bewegt sich der REAPER-Edit-Cursor in Echtzeit über den Zeitbereich, und oben rechts erscheint ein `PREVIEW`-Indikator. `Stop preview` klicken, um Cursor und OSC-Bewegung gemeinsam zu stoppen.

![Send-pair-Workflow mit Konsolenausgabe nach der Bewegung](/motion-markers/opt_workflow-03.gif)

### Send series

Sendet alle Segmente vom aktuellen `S`-Marker bis zum letzten Marker der Liste, eines nach dem anderen. Für die Vorschau einer kompletten Phrase oder Szene.

### Record pair

Nimmt das gewählte `S → E`-Segment als AmbiEncoder-Automation auf. Die AmbiEncoder-Spur muss vor dem Klick selektiert sein.

### Record series

Gleiche Bereichslogik wie `Send series`, schreibt aber Automation für jedes Segment, während der Bewegungsablauf durchläuft. Der Transport läuft einmal vom ersten bis zum letzten Ambi-Cue durch; der Worker-Status zeigt `Segment 1/N`, `2/N` usw.

### Interpolationsmodi

Das `Curve`-Dropdown bestimmt, wie sich die Quelle zwischen `S` und `E` bewegt:

| Modus | Charakter |
|-------|-----------|
| `Linear` | Gerade Linie im XYZ-Raum — konstante Geschwindigkeit |
| `Parabol` | Sanfter Start und sanftes Ende — quadratisches Easing |
| `Expon` | Sehr sanfter Start, schnelle Mitte, sanftes Ende |
| `Polar` | Bogen im AED-Raum — Azimut/Elevation bewegen sich als Winkel, nicht als XYZ-Linie durch die Sphäre |
| `Smoothstep` | Neutrale glatte Kurve — aus Kompatibilitätsgründen beibehalten |

`Polar` ist die richtige Wahl, wenn die Quelle einen Bogen beschreiben soll, statt direkt durch das Innere der Sphäre zu schneiden.

### Markerlisten-Navigation

- **Linke Hälfte** einer Marker-Zeile klicken → als `S` (Start) setzen
- **Rechte Hälfte** klicken → als `E` (Ende) setzen
- `< Pair` / `Pair >` — gewähltes Paar einen Schritt durch die Marker-Sequenz verschieben (z. B. `1→3` wird zu `2→4`)
- `Follow ON` — Markerliste scrollt mit dem Abspiel- oder Edit-Cursor mit
- Der kleine **Timeline-Balken** unten zeigt Marker-Positionen und aktuellen Cursor-Ort

### Next pair after stop

Wenn aktiviert, rückt die GUI nach dem Ende einer Vorschau oder Aufnahme automatisch zum nächsten Paar weiter — `1→3` wird zu `2→4`, bereit für den nächsten Trigger. Die nächste Bewegung startet nicht automatisch.

### Polyphonic mode

`Polyphonic all indexes` sendet alle passenden `ambi <index>`-Paare gleichzeitig, nicht nur das erste gefundene. Wenn Quelle 1 und Quelle 2 jeweils einen Cue bei `S` und bei `E` haben, bewegen sich beide gleichzeitig. Quellen, die nur an einem Ende vorkommen, werden übersprungen.

### XYZ Score

Der Button `XYZ score` erstellt oder aktualisiert eine Spur namens `Ambi XYZ Score`. Für jedes benachbarte Cue-Paar wird ein stummgeschaltetes, leeres Item auf dieser Spur platziert. Die Item-Notizen enthalten die XYZ-Koordinaten jeder Quelle an Start und Ende:

```text
XYZ 01  0.50s -> 16.50s
1: (-0.566, 0.566, 0.000) -> (0.332, 0.332, 0.171)
2: (0.239, 0.658, 0.000) -> (0.200, 0.000, 0.000)
```

Das ergibt eine lesbare Partitur-Ansicht aller räumlichen Bewegungen, ohne die GUI öffnen zu müssen. Erneutes Klicken auf `XYZ score` ersetzt nur die GUI-generierten Items; alles andere auf der Spur bleibt unberührt.

## Good Practices

- CSV als Source of Truth für grössere Cue-Sets verwenden — leichter zu bearbeiten und versionieren als manuelle Marker
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

## Siehe auch

[ICST Ambi Motion Map](/de/icst-ambisonics-plugins/15_icst_ambi_motion_map/) — algorithmischer Bewegungsgenerator für AmbiEncoder_64. Bewegungsformen (Kreis, Spirale, Lissajous…) pro Source zuweisen und XYZ-Automation mit einem Klick schreiben. Motion Map für generative Raumtexturen; Motion Markers für musikalisch getimte, Cue-basierte Bewegung.
