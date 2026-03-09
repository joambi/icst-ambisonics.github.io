---
tags:
title: Wie es funktioniert
weight: 50
date: 2025-02-01T19:26:00
---
Institute for Computer Music and Sound Technology (ICST) Zurich University of the Arts

---

-

### Intuitiver Ambisonics-Workflow mit ICST Plugins

Die **ICST Ambisonics Plugins** sind für einen nahtlosen und intuitiven Workflow konzipiert.
In diesem Tutorial zeigen wir dir drei wesentliche **"Wie es funktioniert"** Workflows.

### Einrichten eines Ambisonics-Workflows in deiner DAW

Zum Erstellen von **Ambisonics-Inhalten** sollte deine Einrichtung folgende Komponenten umfassen:

- **Monoquellen** – Einzelne Soundquellen
- **Encoder** – Positioniert oder bewegt Monoquellen im Ambisonics-Feld
- **B-Format Master-Track** – Erfasst das kodierte Audio zum Durchmischen oder Aufnehmen
- **Decoder** – Konvertiert B-Format-Audio für Lautsprecherausgabe oder binaurales Kopfhörer-Monitoring

#### Signalfluss-Übersicht

Nachstehend findest du eine schematische Darstellung eines **typischen Ambisonics-Workflows**:
  ![01_easyworkflow](01_easy_workflow.png)

Das nächste Bild bietet einen **Überblick über den ICST Ambisonics Plugin-Signalfluss**:
  ![0_workflow_](02_workflow.png)

In **Reaper** sieht der Signalfluss wie folgt aus:

  ![03_reaper_workflow](03_reaper_workflow.png)

- **Master Output**
- **Decoder**
- **B-Format Master**
- **B-Format (ambiX) Player**
- **MultiEncoder** mit 16-Kanal Monoquellen als Child-Tracks

![Ambi_Signalflow](Ambi_Signalflow.jpg)

Natürlich kannst du deinen Workflow auch anpassen, um deinen Anforderungen zu entsprechen!

----
<span style="font-size:9px;color:#9f9f9f;">©2025 ICST</span>