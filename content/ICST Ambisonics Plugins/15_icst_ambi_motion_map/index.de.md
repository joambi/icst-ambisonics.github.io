---
title: ICST Ambi Motion Map
date: 2026-06-27T00:00:00
weight: 87
draft: false
toc: true
description: "Algorithmischer Bewegungsgenerator für ICST AmbiEncoder_64 in REAPER — Bewegungsformen pro Source zuweisen und XYZ-Automation über eine Zeitauswahl schreiben."
---

Level: Intermediate | Zielgruppe: Komponist:in, Sounddesigner:in, Spatial-Audio-Techniker:in.

Diese Seite beschreibt, wie du für mehrere AmbiEncoder-Sources gleichzeitig räumliche Bewegungen automatisch generierst — Kreise, Spiralen, Lissajous-Figuren, Bögen — direkt als REAPER-Automation geschrieben.

> **Download:** [ICST Ambi Motion Map Bundle](/downloads/ICST_Ambi_Motion_Map_Bundle.zip) (GUI-Script + Automation-Writer)

## Was es macht

`AmbiEncoder64 Motion Map GUI` ermöglicht es, pro Source-Index eine Bewegungsform zuzuweisen und mit einem Klick XYZ-Automation über die aktuelle REAPER-Zeitauswahl zu schreiben. Statt Positionen einzeln zu definieren, wählst du ein Bewegungsmuster — Linie, Bogen, Kreis, Spirale, Lissajous — und das Script generiert die vollständige Automationskurve.

Es arbeitet mit `AmbiEncoder_64` (bis zu 64 Sources) und schreibt direkt in FX-Parameter-Envelopes, inklusive automatisch erstellter Render-Region.

Einsetzen wenn du brauchst:

- generative oder texturale Raumbewegung (alle Sources kreisen mit versetzten Phasen)
- schnelles Prototyping komplexer Mehrquellen-Szenen
- automatisierte Variation statt manuell definierter Cue-Positionen

![AmbiEncoder64 Motion Map GUI](/motion-markers/motion-map-gui-overview.png)

> **Siehe auch:** Für musikalisch getimte, Cue-basierte Bewegung zwischen definierten Positionen: [ICST Ambi Motion Markers](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/)

## Voraussetzungen

- **REAPER** (v6 oder neuer)
- **ICST AmbiEncoder_64** auf der Zielspur — siehe [Installation](/de/icst-ambisonics-plugins/02_installation/)
- Eine Zeitauswahl (Loop Range) muss vor dem Schreiben gesetzt sein

## Installation

### Scripts in REAPER einbinden

In REAPER: *Actions-Menü → Load ReaScript…* — dann beide Dateien aus dem Bundle laden:

- `scripts/JS_AmbiEncoder64_Motion_Map_GUI.lua` — die GUI
- `scripts/JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua` — der Automation-Writer (muss im selben Ordner liegen)

Das GUI-Script ruft den Writer automatisch auf — beide Dateien müssen im selben Verzeichnis bleiben.

## Workflow

1. Genau einen Track mit `AmbiEncoder_64` selektieren
2. Zeitauswahl (Loop Range) auf den gewünschten Bereich setzen
3. GUI öffnen: `JS_AmbiEncoder64_Motion_Map_GUI` über das Actions-Menü starten
4. Sources mit dem **✓**-Checkbox aktivieren und jeweils eine Bewegungsform zuweisen
5. Settings anpassen (Center, Spread, Steps/sec)
6. **Write Automation + Region** klicken

Das Script schreibt Envelope-Punkte, setzt den Track auf Latch-Mode und erstellt eine benannte Render-Region über der Zeitauswahl.

## Bewegungsformen

Jeder Source kann eine von zehn Bewegungsformen zugewiesen werden:

| Form | Label | Charakter |
|------|-------|-----------|
| `line` | Line | Diagonal über die Zeitspanne, von einer Ecke zur anderen |
| `arc_up` | Arc+ | Aufwärtsbogen — Smoothstep-Easing auf Azimut |
| `arc_down` | Arc− | Abwärtsbogen |
| `s_curve` | S | S-förmige Kurve — eine vollständige Sinusschwingung in Elevation |
| `step` | Step | Quantisierte Stufen in Azimut mit Elevation-Dreieckswellen |
| `zigzag` | Zig | Schnelles Azimut/Elevation-Zickzackmuster |
| `circle` | Circ | Vollständiger Kreis in der Horizontalebene |
| `spiral` | Spir | Spirale nach aussen vom Zentrum |
| `fourier_xyz` | Four | Komplexe 3D-Trajektorie aus summierten Fourier-Komponenten |
| `lissajous` | Lis | Lissajous-Figur — Azimut und Elevation bei verschiedenen Frequenzen |

Sources mit derselben Form werden automatisch phasenversetzt, sodass sie sich über das Klangfeld verteilen statt synchron zu laufen.

## Einstellungen

### Räumliche Parameter

| Parameter | Standard | Beschreibung |
|-----------|----------|--------------|
| Steps/sec | 12 | Dichte der Automation-Punkte pro Sekunde |
| X center | 0 | Azimut-Zentrum in Grad |
| X spread | 320 | Azimut-Spreizung in Grad (Gesamtbereich) |
| Y center | 0 | Elevations-Zentrum in Grad |
| Y spread | 50 | Elevations-Spreizung in Grad |
| Z center | 0.75 | Distanz-Zentrum (0–1) |
| Z spread | 0.35 | Distanz-Spreizung |
| Motion amount | 2.0 | Skalierungsfaktor für alle Bewegungsamplituden |

### Optionen

**Clear existing** — löscht bestehende Envelope-Punkte in der Zeitauswahl vor dem Schreiben. Deaktivieren, um weitere Bewegung auf bestehende Automation zu schichten.

**Track Latch** — setzt den AmbiEncoder-Track nach dem Schreiben auf Latch-Automationsmodus, sodass Live-Parameterbewegungen beim nächsten Durchlauf aufgenommen werden.

**Overwrite region** — wenn bereits eine Region mit demselben Namen existiert, wird sie auf die aktuelle Zeitauswahl verschoben statt eine Duplikat zu erstellen.

**Use Z motion** — bezieht Distanz (Z) in die Bewegung ein. Deaktivieren, um alle Sources auf fixer Distanz zu halten, während sich Azimut und Elevation trotzdem bewegen.

### Region name

Setzt den Namen der Render-Region, die über der Zeitauswahl erstellt wird. Standard: `BFormat_TS`. Nützlich zum Benennen von Szenen oder Abschnitten direkt im Projekt.

## Presets

Die Preset-Zeile bietet schnelle Ausgangspunkte:

| Preset | Wirkung |
|--------|---------|
| Auto | Weist Bewegungsformen in Round-Robin-Reihenfolge über alle 64 Sources zu |
| Random | Weist zufällige Formen allen Sources zu |
| All Line | Setzt alle aktivierten Sources auf Line |
| All Circle | Setzt alle aktivierten Sources auf Circle |
| All Step | Setzt alle aktivierten Sources auf Step |
| S0-7 Arc | Weist Arc+ den Sources 0–7 zu |
| S8-15 Circle | Weist Circle den Sources 8–15 zu |

Die Source-Auswahlzeile steuert, welche Sources aktiviert sind, ohne ihre zugewiesenen Formen zu ändern: **All Src**, **None Src**, **S0-7 Src**, **S8-15 Src**, **Clear Sel**.

## Good Practices

- Mit dem **Auto**-Preset und 2–4 aktiven Sources starten, um die Standard-Verteilung zu verstehen, bevor mehr hinzugefügt werden
- **Steps/sec 6–8** für weite Schwingungen, **20–30** für detaillierte Artikulation
- **Motion amount** zunächst auf 1.0 lassen — Werte über 2 können Sources an die Sphärengrenze drängen
- **Clear existing** ausschalten, um einen Kreis auf bestehende Linien-Automation zu schichten
- Regionen sinnvoll benennen — sie erscheinen im REAPER-Projekt und in Render-Exporten

## Troubleshooting

### „Bitte genau einen Track mit ICST AmbiEncoder_64 selektieren"

Genau ein Track muss selektiert sein und er muss ein `AmbiEncoder_64`-FX enthalten. Track zuerst selektieren, dann die GUI öffnen.

### „Bitte zuerst eine Loop/Time Selection setzen"

Keine Zeitauswahl aktiv. Loop Range in REAPER setzen, bevor Write Automation + Region geklickt wird.

### Keine Envelope-Punkte geschrieben / keine Bewegung sichtbar

- Bestätigen, dass der Track `AmbiEncoder_64` enthält und keine andere Encoder-Variante
- Prüfen, dass mindestens eine Source aktiviert ist (✓-Checkbox aktiv)
- Steps/sec verringern, wenn die Zeitauswahl sehr kurz ist — eine 0,1s-Auswahl bei 12 Steps/sec ergibt nur 1 Punkt

### Writer-Script nicht gefunden

Beide Lua-Dateien müssen im selben Verzeichnis liegen. Falls `JS_AmbiEncoder64_Motion_Map_GUI.lua` nach dem Laden in REAPER verschoben wurde, vom neuen Speicherort neu laden. Der Writer-Pfad wird zur Laufzeit relativ zum GUI-Script aufgelöst.
