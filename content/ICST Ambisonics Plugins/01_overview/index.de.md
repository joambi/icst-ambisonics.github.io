---
date: 2025-06-02T04:14:54
draft: false
params:
  author: Johannes Schuett
weight: 10
tags:
title: Übersicht
description: "Orientierungsseite für die ICST Ambisonics Plugins in REAPER: was die Suite umfasst, wie die zentrale Signalkette funktioniert und wo der beste Einstieg liegt."
---

Level: Beginner | Zielgruppe: Komponist:in, Techniker:in, Studierende, Studio-User.

Nutze diese Seite, wenn du vor Setup, Routing oder Plugin-Details zuerst eine schnelle Orientierung willst.

Die ICST Ambisonics Plugins bilden eine REAPER-basierte Produktionsumgebung für Higher-Order Ambisonics: Quellen positionieren, B-Format encodieren, Lautsprecher-Arrays decodieren, Sessions mit Vorlagen aufbauen und externe Kontrolle über OSC anbinden.

![Overview_v3.1](Overview_v3.1.png)

## Hier starten

Wähle den schnellsten Einstieg für dein Ziel:

- **Erste funktionierende Session:** [Schnellstart](/icst-ambisonics-plugins/04_quick_start/)
- **Saubere Installation:** [Installation](/icst-ambisonics-plugins/02_installation/)
- **Routing von Grund auf aufbauen:** [Schritt-für-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- **B-Format korrekt rendern:** [B-Format in REAPER rendern](/icst-ambisonics-plugins/12_render_bformat/)

## Zentrale Plugin-Kette

Die Standardkette für die Produktion ist:

`Quelle -> Encoder -> Bformat Master -> Decoder -> Lautsprecher`

Optionaler Monitoring-Zweig:

`Bformat Master -> Binaural-Decoder -> Kopfhörer`

Die Kernlogik ist einfach:

- **Encoder** positionieren oder bewegen Quellen im Ambisonics-Feld.
- Der **Bformat Master** sammelt das encodierte HOA-Signal.
- Der **Decoder** übersetzt das B-Format in Lautsprecherwiedergabe.
- Für Kopfhörer-Monitoring wird ein separater **Binaural-Decoder** verwendet.
- Finale Exporte sollten vom **Bformat Master** gerendert werden, nicht vom Decoder-Ausgang.

## Was die Suite umfasst

Die ICST Ambisonics Plugins sind in diesen Formaten verfügbar:

- `VST3`
- `AU (Component)`
- `LV2`  
  LV2 ist derzeit experimentell und sollte nicht als primärer Produktionspfad betrachtet werden.

Die wichtigsten Module sind:

- **ICST Encoders** für Quellenpositionierung und Bewegung
- **ICST Decoder** für Lautsprecherwiedergabe
- **ICST MultiDecoder** für geschichtete oder segmentierte Lautsprecher-Arrays
- **Spurvorlagen** und **Projektvorlagen** für schnellere Setups
- **OSC-Unterstützung** für externe Steuerungs-Workflows

## Wähle deinen Weg

Wenn dein Ziel vor allem praktisch ist, folge einem dieser Wege:

- **Ich will schnell Ton hören:** Schnellstart -> Schritt-für-Schritt-Setup -> B-Format rendern
- **Ich will den Signalfluss verstehen:** Wie es funktioniert -> Decoder -> Best Practices
- **Ich will Bewegung und externe Steuerung:** Encoders -> OSC -> Best Practices

## Downloads und Referenzen

- Plugin-Releases: <https://github.com/schweizerweb/icst-ambisonics-plugins/releases>
- Projekt-Wiki: <https://github.com/schweizerweb/icst-ambisonics-plugins/wiki>
- Tutorials und Site-Hub: <https://ambisonics.ch/>
- YouTube-Kanal: <https://www.youtube.com/@ICSTAmbisonics>

## Entwicklung

Entwicklerteam:

- Christian Schweizer
- Johannes Schuett
- Martin Neukom

Zusätzliche Produktionsunterstützung:

- Video Editing: Axel Kolb
