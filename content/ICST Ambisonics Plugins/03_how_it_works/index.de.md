---
tags:
title: Wie es funktioniert
weight: 70
date: 2025-02-01T19:26:00
---

Referenzübersicht des Standard-Signalflusses für Ambisonics in REAPER: Quelle, Encoder, B-Format-Bus und Decoder.

## Grundmodell des Workflows

Zum Erstellen von **Ambisonics-Inhalten** sollte deine Einrichtung folgende Komponenten umfassen:

- **Monoquellen** – Einzelne Soundquellen
- **Encoder** – Positioniert oder bewegt Monoquellen im Ambisonics-Feld
- **B-Format Master-Track** – Erfasst das kodierte Audio zum Durchmischen oder Aufnehmen
- **Decoder** – Konvertiert B-Format-Audio für Lautsprecherausgabe oder binaurales Kopfhörer-Monitoring

### Signalflussübersicht

Die folgende Darstellung zeigt einen typischen Ambisonics-Workflow:
  ![01_easyworkflow](01_easy_workflow.png)

Das nächste Bild zeigt den Signalfluss der ICST Plugins:
  ![0_workflow_](02_workflow.png)

In **REAPER** sieht der Signalfluss wie folgt aus:

  ![03_reaper_workflow](03_reaper_workflow.png)

- **Master Output**
- **Decoder**
- **B-Format Master**
- **B-Format (ambiX) Player**
- **MultiEncoder** mit 16-Kanal Monoquellen als Child-Tracks

![Ambi_Signalflow](Ambi_Signalflow.jpg)

Natürlich kannst du deinen Workflow auch anpassen, um deinen Anforderungen zu entsprechen!

----
