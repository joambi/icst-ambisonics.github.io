---
title: ICST Decoder
date: 2025-01-01T00:00:00
weight: 90
draft: false
description: "Leitfaden zum ICST Decoder für Lautsprecherwiedergabe in Ambisonics-Sessions: wann man ihn einsetzt, wie der Grundaufbau aussieht und welche Fehler vermieden werden sollten."
---

Level: Intermediate | Zielgruppe: Techniker:in, Komponist:in, Studierende, Studio-User.

Nutze diese Seite, wenn du verlässliche Lautsprecherwiedergabe aus dem Bformat Master brauchst und einen Decoder auf ein reales Lautsprecher-Array abstimmen willst.

Zur praktischen Bedeutung von **B-Format**, **FOA/HOA**, **ambiX**, **ACN/SN3D** und Kanalzahlen siehe [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/).

## Wann du den ICST Decoder verwenden solltest

Nutze den **ICST Decoder**, wenn:

- du Wiedergabe auf einem definierten Lautsprecher-Array brauchst
- du Lautsprecher-Presets für einen Raum laden oder erstellen willst
- du Kontrolle über Ambisonics-Ordnung, Gewichtung, Laufzeiten und Filterung brauchst
- du reproduzierbares Lautsprecher-Monitoring in REAPER willst

Für reines Kopfhörer-Monitoring sollte ein separater **Binaural-Decoder** verwendet werden.

## Was der Decoder macht

Decodierung ist die Stufe zwischen dem Ambisonics-B-Format-Feld und der physischen Lautsprecherwiedergabe. Geometrie, Laufzeit, Gewichtung, Filterung und Ordnung beeinflussen das resultierende räumliche Bild.

Der **ICST Decoder** wurde für flexible Lautsprecher-Setups in Studio- und Live-Kontexten entwickelt. Neben Standard-Arrays wie Quadro, Oktagon oder 7.1.4 kann er auch asymmetrische oder individuell eingemessene Lautsprecher-Anordnungen verarbeiten.

## Plugin-Formate

Der **ICST Decoder** ist verfügbar als:

- `VST3`
- `AU (Component)`
- `LV2`  
  LV2 ist experimentell und sollte nicht als Hauptpfad für die Produktion betrachtet werden.

Alle Beispiele auf dieser Seite gehen von **REAPER** aus, das bis zu 128 Audiokanäle pro Spur unterstützt.

## Übersicht

![ICST Ambisonics Decoder Übersicht](decoder-overview.png)

### Hauptbereiche der Oberfläche

1. **Radar** für die horizontale Lautsprecheransicht
2. **Vertikale Radar-Ansicht**
3. **Lautsprecherparameter**
   - Kanalindex
   - Lautsprechername
   - kartesische und polare Koordinaten

> [!tip]
> Doppelklick auf Parameterfelder erlaubt direkte Eingabe.

### Einstellungen und Hilfe

4. Zahnrad-Icon -> Lautsprecher-Einstellungen  
5. Fragezeichen -> Hilfe-Fenster

**Lautsprecher-Parameter-Editor:**

![Lautsprecher-Parameter-Editor](CleanShot%202026-02-11%20at%2010.59.50@2x.png)

### Tastenkürzel

| Aktion | Kürzel |
|---|---|
| Ausgewählte Quelle oder Lautsprecher muten | `Ctrl + Shift + M` |
| Ausgewählte Quelle oder Lautsprecher solo | `Ctrl + Shift + S` |

## Empfohlene REAPER-Struktur

![Workflow-Schema](CleanShot%202026-02-10%20at%2017.28.25@2x.png)

Lege drei 64-Kanal-Spuren an:

1. **B-Format-Quellspur**
2. **Ambisonics-Bus / Bformat Master**
3. **Decoder-Spur**

![Spuraufbau](CleanShot%202026-02-10%20at%2017.36.04@2x.png)

Diese Trennung hält die Session übersichtlich und vereinfacht spätere Fehlersuche deutlich.

## Decoder-Logik in drei Schritten

Du kannst die Arbeit mit dem Decoder als drei Schritte denken:

1. **Geometrie**  
   Lautsprecherkoordinaten bestimmen, **wo** das System Lautsprecher im Raum verortet.
2. **Laufzeit**  
   Laufzeitkompensation bestimmt, **wann** Signale am Hörplatz ankommen.
3. **Abstimmung**  
   Gewichtung, Filterung und verwandte Einstellungen formen, **wie deutlich** oder **wie gefärbt** das Ergebnis wahrgenommen wird.

Diese Reihenfolge ist wichtig: zuerst die Geometrie verlässlich machen, dann die Zeitverhältnisse stabilisieren, danach den Klang fein abstimmen.

> [!tip]
> **Decoder-Serie:**
> - **Geometrie:** [XYZ und AED – Zwei Koordinatensysteme, ein Lautsprecher](/post/xyz-vs-aed-koordinatensysteme/)
> - **Laufzeit:** [Skalierung und Laufzeitkompensation](/post/decoder-skalierung-laufzeitkompensation/)
> - **Abstimmung:** [Der Filter-Tab – Praxisbeispiele und Anwendungsfälle](/post/decoder-filter-praxisbeispiele/)

## Grundaufbau

1. Den **ICST AmbiDecoder** auf der Decoder-Spur einsetzen.
2. Die Lautsprecher-Einstellungen öffnen.
3. Ein Preset laden oder das eigene Lautsprecher-Layout definieren.
4. Ambisonics-**Ordnung** und **Kanalgewichtung** setzen.
5. Bei Bedarf Raumdimensionen skalieren.
6. Vor Probe, Aufnahme oder Export einen Lautsprechertest durchführen.

![Plugin hinzufügen](CleanShot%202026-02-10%20at%2017.54.52@2x.png)
![Lautsprecher bearbeiten](Speaker_Editing.gif)
![Ambisonics-Ordnung](CleanShot%202026-02-11%20at%2009.30.18@2x.png)

## Kontrolle pro Lautsprecher

Lautsprecherspezifische Parameter können direkt bearbeitet und als Presets gespeichert werden.

![Lautsprecher-Einstellungen Detail](CleanShot%202026-02-10%20at%2018.57.37@2x.png)

Optional steht eine Filterung pro Lautsprecher zur Verfügung:

![Filtertypen](CleanShot%202026-02-11%20at%2011.11.32@2x.png)

## Audio-Testfunktion

![Audio-Test](Decoder%20Audio%20test.gif)

Der integrierte Testbereich enthält:

- Pink-Noise-Generator
- Einzeltests pro Lautsprecher
- sequenziellen Lautsprechertest
- Mute- und Solo-Kürzel

Das ist der schnellste Weg, um zu prüfen, ob physisches System, Preset und Ausgangszuordnung zusammenpassen.

## Schnellcheck vor der Session

Vor Probe oder Aufnahme kurz prüfen:

1. Pegel am Decoder-Eingang sichtbar
2. Lautsprecher-Reihenfolge passt zum Raum
3. das richtige Preset ist geladen
4. Decoder-Ordnung passt zur B-Format-Quelle
5. Lautsprecher- und binaurales Monitoring laufen nicht unbeabsichtigt parallel

> [!tip]
> Presets mit einem stabilen Schema speichern, zum Beispiel `Room_Array_Order_Date`.

## Häufige Fehler

- die falsche Spur wird in den Decoder geschickt
- ein Lautsprecher-Preset passt nicht zur realen Hardware-Ausgangszuordnung
- Ordnung und Gewichtung werden nicht gegen das Quellmaterial geprüft
- der Decoder wird fälschlich als Render-Ziel behandelt statt der Bformat Master
- Lautsprecher- und binaurales Monitoring laufen unbeabsichtigt gleichzeitig

## Presets

![Voreinstellungen speichern](save%20decoder%20presets.gif)

Lautsprecher-Presets können jederzeit gespeichert und erneut geladen werden. Das ist zentral für reproduzierbare Raum-Setups.

## Nächster Schritt

Wenn dein Array mehrere Höhenebenen oder unterschiedliche Lautsprecher-Subsets verwendet, gehe weiter zu:

- [ICST MultiDecoder](/icst-ambisonics-plugins/09_icst_multidecoder/)

Verwandte Seiten:

- [Schritt-für-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [B-Format in REAPER rendern](/icst-ambisonics-plugins/12_render_bformat/)
- [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/)
- [Best Practices](/icst-ambisonics-plugins/15_best_practices/)
