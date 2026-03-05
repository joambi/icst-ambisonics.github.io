---
tags:
title: Wie es funktioniert
weight: 50
date: 2025-02-01T19:26:00
---
Institut für Computermusik und Soundtechnologie / (ICST) Zurich University of the Arts

----

### Intuitiver Ambisonics-Workflow mit ICST Plugins

Die **ICST Ambisonics Plugins** sind für einen nahtlosen und intuitiven Workflow konzipiert.
In diesem Tutorial zeigen wir Ihnen drei wesentliche **"Wie es funktioniert"** Workflows.

### Einrichten eines Ambisonics-Workflows in Ihrer DAW

Zum Erstellen von **Ambisonics-Inhalten** sollte Ihre Einrichtung folgende Komponenten umfassen:

- **Monoquellen** – Einzelne Soundquellen
- **Encoder** – Positioniert oder bewegt Monoquellen im Ambisonics-Feld
- **B-Format Master-Track** – Erfasst das kodierte Audio zum Durchmischen oder Aufnehmen
- **Decoder** – Konvertiert B-Format-Audio für Lautsprecherausgabe oder binaurales Kopfhörer-Monitoring

#### Signalfluss-Übersicht

Nachstehend finden Sie eine schematische Darstellung eines **typischen Ambisonics-Workflows**:
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

Natürlich können Sie Ihren Workflow auch anpassen, um Ihren Anforderungen zu entsprechen!

----
<span style="font-size:9px;color:#9f9f9f;">©2025 ICST</span>
