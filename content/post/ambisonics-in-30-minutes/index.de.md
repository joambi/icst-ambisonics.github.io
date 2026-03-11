---
title: "Ambisonics in 30 Minuten: Dein erster funktionierender Reaper-Session-Flow"
description: "Schneller Einstiegsleitfaden, um in Reaper mit ICST Plugins eine stabile erste Ambisonics-Session aufzubauen."
date: 2026-03-09T09:00:00+01:00
year: 2026
month: 2026-03
weight: 24
tags: ["tutorial", "reaper", "ambisonics", "einstieg", "workflow"]
key_points:
  - "Encoder → B-Format-Bus → Decoder-Routing von Grund auf in REAPER aufbauen"
  - "Häufige Fehler beim ersten Setup erkennen und beheben"
difficulty: "beginner"
---


**Für wen:** Level: Beginner | Zielgruppe: Komponist:in, Studierende, Studio-Assistenz.

## Problem
Du willst schnell mit ICST Ambisonics Plugins in Reaper starten, ohne lange Routing-Fehlersuche.

## Setup
- Reaper installiert
- ICST Ambisonics Plugins installiert
- Optional: SWS + ReaPack

## Schritt-für-Schritt
1. `Bformat-Master` anlegen (64 Kanäle).
2. Decoder in den Monitoring-Pfad einsetzen.
3. Eine Quelle mit AmbiEncoder anlegen.
4. Quelle auf `Bformat-Master` routen.
5. Binaurales Monitoring parallel aufsetzen.
6. Kurze Bewegungsautomation aufnehmen.
7. Rendern und Ausgangskanaele prüfen.

## Häufige Fehler
- Quelle nicht auf `Bformat-Master` geroutet
- Nicht-64-Kanal-Track im Signalpfad
- Falsches Decoder-Preset für Lautsprecher-Setup

## Related tutorial
- [Getting Started mit ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)
- [Reaper Ambisonics Setup in 20 Minuten](/post/reaper-setup-20-minuten/)

## Download
- Hier Links zu Template und Checkliste eintragen.

## Next step
- [OSC Syntax für den ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
