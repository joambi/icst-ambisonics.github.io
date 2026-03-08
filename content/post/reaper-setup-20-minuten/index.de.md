---
title: Reaper Ambisonics Setup in 20 Minuten (ICST Workflow)
description: "Schritt-fuer-Schritt Einstieg in ein stabiles Reaper-Ambisonics-Setup mit ICST Plugins, Routing und erstem Monitoring-Test."
date: 2026-03-08T11:40:00+01:00
year: 2026
month: 2026-03
weight: 21
tags: ["reaper", "ambiencoder", "tutorial", "workflow"]
key_points:
  - "Fuehre ein schnelles 20-Minuten-Setup mit direkten Docs-Links aus."
  - "Pruefe Routing, Bewegung und Monitoring in einem kompakten Durchlauf."
---
Institute for Computer Music and Sound Technology (ICST) Zurich University of the Arts

---

# Reaper Ambisonics Setup in 20 Minuten (ICST Workflow)

**Für wen:** Level: Beginner | Zielgruppe: Komponist:in, Studierende, DAW-Einsteiger:in.


Diese Seite ist die **Ausfuehrungs-Checkliste** (klickorientiert).
Fuer Onboarding-Logik und systematische Fehlersuche siehe:
- [Getting Started mit ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)

## Was du am Ende erreicht hast
Du hast eine lauffaehige Reaper-Session mit ICST AmbiEncoder, sauberem Routing und einem schnellen Monitoring-Check.

## Voraussetzungen
- Reaper installiert.
- ICST Ambisonics Plugins installiert.
- Audio-Interface mit passender I/O-Konfiguration.
- Docs dazu: [Installation](/icst-ambisonics-plugins/02_installation/)

## Schritt 1 - Session vorbereiten
Lege eine neue Session an, setze Sample Rate und definiere ein klares Track-Layout fuer Quellen, B-Format-Bus und Monitoring.
- Docs dazu:
  - [Schnellstart](/icst-ambisonics-plugins/04_quick_start/)
  - [Schritt-fuer-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)

## Schritt 2 - ICST AmbiEncoder korrekt routen
Lade den AmbiEncoder auf den Quelltracks und route die Ausgaenge in den zentralen B-Format-Bus. Pruefe danach die Kanalzuordnung im Routing-Fenster.
- Docs dazu:
  - [Spurvorlagen](/icst-ambisonics-plugins/05_open_track_templates/)
  - [Wie es funktioniert](/icst-ambisonics-plugins/03_how_it_works/)
  - [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/)

## Schritt 3 - Erste Quelle raeumlich bewegen
Bewege eine einzelne Quelle in X/Y/Z, speichere ein Preset und pruefe die Bewegung in der Radar-Ansicht.
- Docs dazu:
  - [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)
  - [Schritt-fuer-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)

## Schritt 4 - Monitoring und Schnelltest
Fuehre einen kurzen Pegel- und Hoertest durch und verifiziere, dass alle Kanaele erwartungsgemaess reagieren.
- Docs dazu:
  - [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/)
  - [Schritt-fuer-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)

## Haeufige Fehler
Die ausfuehrliche Debug-Liste liegt im Onboarding-Guide:
- [Getting Started mit ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)

## Downloads und weiterfuehrende Artikel
- [ICST Ambisonics Tools](/icst%20ambisonics%20tools/)
- [OSC im ICST AmbiEncoder: Die 10 wichtigsten Messages](/post/osc-10-key-messages/)
- [Ableton Live und ICST Ambisonics Integration](/post/ableton_reaper/)

## Naechster Schritt
Wenn das Grundsetup stabil laeuft, erweitere die Session mit OSC-Automation fuer reproduzierbare Bewegungen.
