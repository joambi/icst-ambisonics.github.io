---
title: Getting Started mit ICST Ambisonics Plugins in REAPER
description: "Praktischer Einstiegsleitfaden für Komponist:innen, Studierende und Techniker:innen, um mit ICST Ambisonics Plugins in Reaper eine erste funktionierende Session aufzubauen."
date: 2026-03-08T14:10:00+01:00
year: 2026
month: 2026-03
weight: 23
tags: ["tutorial", "reaper", "ambiencoder", "getting-started", "workflow"]
key_points:
  - "Erste funktionierende Spatial-Audio-Session in REAPER in rund 30 Minuten aufbauen"
  - "Strukturierte Checkliste vom Plugin-Install bis zum Binaural-Monitoring"
difficulty: "beginner"
post_kind: "tutorial"
tool: ["REAPER", "AmbiEncoder"]
aliases:
  - /de/post/reaper-setup-20-minuten/
  - /de/post/ambisonics-in-30-minutes/
---

**Level:** Beginner | **Zielgruppe:** Komponist:in, Studierende, Studio-Assistenz.

In rund 30 Minuten baust du eine funktionierende Reaper-Session auf: Quellrouting, AmbiEncoder-Steuerung, B-Format-Bus, Decoder und ein Monitoring-Check.
Das ist der kurze Weg. Die vollständige technische Referenz ist [Schritt-für-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/).

## Voraussetzungen
- Reaper und die ICST Ambisonics Plugins sind installiert ([Installation](/icst-ambisonics-plugins/02_installation/)).
- Empfohlen: SWS und ReaPack.
- Audio-Interface mit passender I/O-Konfiguration.
- Grundkenntnisse zu Tracks, Bussen und Plugin-Insert-Slots.
- Regel für die ganze Session: **64 Kanäle** auf allen Ambisonics-Tracks und das Routing nach jedem Schritt prüfen.

## Schritt 1 - Monitoring-Backbone
Lege eine neue Session an, setze die Sample Rate und erstelle den Track `Bformat-Master` (64 Kanäle). Setze den Decoder in den Monitoring-Pfad und wähle das Lautsprecher-Preset.
- Docs: [Schnellstart](/icst-ambisonics-plugins/04_quick_start/), [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/), [Spurvorlagen](/icst-ambisonics-plugins/05_open_track_templates/)

## Schritt 2 - Quelle hinzufügen
Lege einen Quelltrack mit dem AmbiEncoder an und route den Ausgang auf `Bformat-Master`. Prüfe die Kanalzuordnung im Routing-Fenster.
- Docs: [Wie es funktioniert](/icst-ambisonics-plugins/03_how_it_works/), [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)

## Schritt 3 - Quelle im Raum bewegen
Bewege die Quelle in X/Y/Z, beobachte sie in der Radar-Ansicht und speichere ein Preset. Nimm dann eine kurze Bewegung auf und prüfe, ob die Automation abgespielt wird.

## Schritt 4 - Binaural-Kontrolle
Setze parallel einen binauralen Pfad fürs Kopfhörer-Monitoring auf und mache einen kurzen Pegel- und Hörtest.

## Schritt 5 - Rendern
Rendere aus `Bformat-Master` als Multichannel und prüfe die Ausgangskanäle.

## Häufige Startfehler
- Quelle nicht auf `Bformat-Master` geroutet; die Kette `Source -> Bformat-Master -> Decoder` ist unterbrochen.
- Nicht-64-Kanal-Track im Signalpfad.
- Falsches Decoder-Preset für das Lautsprecher-Setup.
- Binaural-Track von falscher Quelle gespeist.
- OSC-Port-Mismatch bei externer Steuerung.

## Nächste Schritte
- [OSC Syntax für den ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
- [OSC im ICST AmbiEncoder: Die 10 wichtigsten Nachrichten](/post/osc-10-key-messages/)
- [Von Stereo zu HOA7: Schritt-für-Schritt-Session](/post/stereo-to-hoa7-session/)
- [Ableton Live und ICST Ambisonics Integration](/post/ableton_reaper/)
