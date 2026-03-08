---
title: Reaper Ambisonics Setup in 20 Minuten (ICST Workflow)
description: "Schritt-fuer-Schritt Einstieg in ein stabiles Reaper-Ambisonics-Setup mit ICST Plugins, Routing und erstem Monitoring-Test."
date: 2026-03-08T11:40:00+01:00
year: 2026
month: 2026-03
weight: 21
tags: ["reaper", "ambiencoder", "tutorial", "workflow"]
---
Institute for Computer Music and Sound Technology (ICST) Zurich University of the Arts

---

# Reaper Ambisonics Setup in 20 Minuten (ICST Workflow)

## Was du am Ende erreicht hast
Du hast eine lauffaehige Reaper-Session mit ICST AmbiEncoder, sauberem Routing und einem schnellen Monitoring-Check.

## Voraussetzungen
- Reaper installiert.
- ICST Ambisonics Plugins installiert.
- Audio-Interface mit passender I/O-Konfiguration.

## Schritt 1 - Session vorbereiten
Lege eine neue Session an, setze Sample Rate und definiere ein klares Track-Layout fuer Quellen, B-Format-Bus und Monitoring.

## Schritt 2 - ICST AmbiEncoder korrekt routen
Lade den AmbiEncoder auf den Quelltracks und route die Ausgaenge in den zentralen B-Format-Bus. Pruefe danach die Kanalzuordnung im Routing-Fenster.

## Schritt 3 - Erste Quelle raeumlich bewegen
Bewege eine einzelne Quelle in X/Y/Z, speichere ein Preset und pruefe die Bewegung in der Radar-Ansicht.

## Schritt 4 - Monitoring und Schnelltest
Fuehre einen kurzen Pegel- und Hoertest durch und verifiziere, dass alle Kanaele erwartungsgemaess reagieren.

## Haeufige Fehler und schnelle Fixes
- Kein Signal: Input-/Track-Arming pruefen.
- Falsches Routing: Bus-Zuordnung im Track Routing korrigieren.
- Keine Bewegung sichtbar: Falscher Plugin-Track oder Preset nicht geladen.

## Downloads und weiterfuehrende Artikel
- [ICST Ambisonics Tools](/icst%20ambisonics%20tools/)
- [OSC im ICST AmbiEncoder: Die 10 wichtigsten Messages](/post/osc-10-key-messages/)
- [Ableton Live und ICST Ambisonics Integration](/post/ableton_reaper/)

## Naechster Schritt
Wenn das Grundsetup stabil laeuft, erweitere die Session mit OSC-Automation fuer reproduzierbare Bewegungen.