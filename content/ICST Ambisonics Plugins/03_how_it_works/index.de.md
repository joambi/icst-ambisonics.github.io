---
tags:
title: Wie es funktioniert
weight: 70
date: 2025-02-01T19:26:00
description: "Grundübersicht zum Signalfluss der ICST Ambisonics Plugins in REAPER: was jede Stufe tut, was Pflicht ist und was optional bleibt."
---

Level: Beginner | Zielgruppe: Komponist:in, Techniker:in, Studierende, Studio-User.

Nutze diese Seite, wenn du die Grundlogik des ICST-Ambisonics-Workflows verstehen willst, bevor du eine Session aufbaust oder veränderst.

## Die Signalkette in einer Minute

Die Standardkette für die Produktion ist:

`Quelle -> Encoder -> Bformat Master -> Decoder -> Lautsprecher`

Optionaler Monitoring-Zweig:

`Bformat Master -> Binaural-Decoder -> Kopfhörer`

Die wichtigste Regel ist:

- der **Encoder** erzeugt das HOA- bzw. B-Format-Feld
- der **Bformat Master** ist der zentrale Sammel- und Render-Punkt
- der **Decoder** ist für Lautsprecher-Monitoring da
- für Kopfhörer-Monitoring sollte ein **separater Binaural-Decoder** verwendet werden
- der finale Export sollte vom **Bformat Master** kommen, nicht vom Decoder-Ausgang

## Was jede Stufe macht

- **Quelle**  
  Eine Mono- oder Mehrkanalquelle, die im Raum positioniert werden soll.
- **Encoder**  
  Positioniert oder bewegt die Quelle im Ambisonics-Feld.
- **Bformat Master**  
  Nimmt das encodierte HOA-Signal auf und dient als zentraler Aufnahme- und Render-Punkt.
- **Decoder**  
  Übersetzt das B-Format in Lautsprechersignale für den realen Raum.
- **Binaural-Decoder**  
  Wandelt dasselbe HOA-Signal in Kopfhörer-Monitoring um, ohne das Lautsprecher-Setup zu verändern.

## Pflicht und optional

Pflicht für ein grundlegendes Lautsprecher-Setup:

- Quellspur
- Encoder
- Bformat Master
- Decoder

Optional, aber oft sinnvoll:

- binauraler Monitoring-Pfad
- B-Format-Player-Spur
- Spurvorlagen oder Projektvorlagen
- OSC-Steuerung
- MultiDecoder für geschichtete oder segmentierte Arrays

## Typische REAPER-Struktur

Die folgende Darstellung zeigt einen typischen Ambisonics-Workflow:

![01_easyworkflow](01_easy_workflow.png)

Das nächste Bild zeigt den Signalfluss der ICST Plugins:

![0_workflow_](02_workflow.png)

In **REAPER** sieht die Struktur oft so aus:

![03_reaper_workflow](03_reaper_workflow.png)

Typische Spurrollen:

- **Decoder**
- **Bformat Master**
- **B-Format (ambiX) Player**
- **MultiEncoder** mit Mono-Child-Tracks

![Ambi_Signalflow](Ambi_Signalflow.jpg)

## Welchen Encoder solltest du verwenden?

Nutze **MonoEncoder**, wenn:

- du eine einzelne Quelle positionieren oder automatisieren willst
- du den Workflow gerade lernst
- du pro Quelle das klarste Routing willst

Nutze **MultiEncoder**, wenn:

- du mehrere Quellen in einer Oberfläche verwalten willst
- du Gruppenbewegungen oder räumliche Choreografien brauchst
- du mit einem Template arbeiten willst, das bereits mehrere Quellspuren vorbereitet

## Häufige Missverständnisse

- **Der Decoder ist nicht das Render-Ziel.**  
  Er ist in erster Linie die Lautsprecher-Monitoring-Stufe.
- **Der Bformat Master ist nicht einfach nur ein weiterer Bus.**  
  Er ist das zentrale HOA-Signal und sollte stabil und klar benannt bleiben.
- **Binaurales Monitoring ist nicht dasselbe wie der Lautsprecher-Decoder.**  
  Behandle es als separaten Hörzweig.
- **Höhere Ordnung ist nicht automatisch besser.**  
  Die HOA-Ordnung sollte zur realen Lautsprecherdichte und zum Produktionsziel passen.

## Nächste Schritte

- [Schritt-für-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)
- [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/)
- [Best Practices](/icst-ambisonics-plugins/15_best_practices/)
