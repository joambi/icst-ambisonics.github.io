---
title: Getting Started mit ICST Ambisonics Plugins in Reaper
description: "Praktischer Einstiegsleitfaden für Komponist:innen, Studierende und Techniker:innen, um mit ICST Ambisonics Plugins in Reaper eine erste funktionierende Session aufzubauen."
date: 2026-03-08T14:10:00+01:00
year: 2026
month: 2026-03
weight: 23
tags: ["tutorial", "reaper", "ambiencoder", "getting-started", "workflow"]
key_points:
  - "Erste funktionierende Spatial-Audio-Session in REAPER Schritt für Schritt aufbauen"
  - "Strukturierte Checkliste vom Plugin-Install bis zum Binaural-Monitoring"
difficulty: "beginner"
---


**Für wen:** Level: Beginner | Zielgruppe: Komponist:in, Studierende, Studio-Assistenz.

Diese Seite ist die kompakte Onboarding-Version des vollständigen Docs-Workflows:
[Step by Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/).
Nutze diesen Guide für den schnellen Einstieg und die Docs-Seite als technische Referenz.

## Für wen ist das gedacht
- Komponist:innen, die eine stabile erste Ambisonics-Session brauchen.
- Studierende, die einen klaren Praxiseinstieg suchen.
- Techniker:innen, die ein reproduzierbares Setup als Grundlage wollen.

## Was du am Ende hast
Am Ende hast du ein funktionierendes Reaper-Projekt mit Quellrouting, AmbiEncoder-Steuerung und einem grundlegenden Monitoring-Check.

## Voraussetzungen
- Reaper ist installiert und laeuft.
- ICST Ambisonics Plugins sind installiert.
- Empfohlene Reaper-Erweiterungen sind installiert (SWS und ReaPack).
- Grundkenntnisse zu Tracks, Bussen und Plugin-Insert-Slots.

## Session-Baseline (aus dem Docs-Setup)
Setze bei allen Ambisonics-relevanten Tracks standardmaessig 64 Kanäle und prüfe das Routing nach jedem Schritt.

## Workflow-Phasen (Onboarding-Sicht)
Nutze diese Seite, um die Struktur zu verstehen, bevor du ins Klick-für-Klick-Setup gehst:
1. Monitoring-Backbone: `Decoder` + `Bformat-Master` + Lautsprecher-Preset.
2. Paralleles Hören: binauralen Pfad für Kopfhoerer-Validierung aufsetzen.
3. Quellen-Ebene: mit einer MonoEncoder-Quelle starten und Routing verifizieren.
4. Bewegungs-Ebene: erste Bewegung aufnehmen und Automation prüfen.
5. Output-Ebene: aus `Bformat-Master` als Multichannel rendern.

## Hands-on-Checkliste (Ausführung)
Für die exakte Schrittfolge nutze:
- [Reaper Ambisonics Setup in 20 Minuten](/post/reaper-setup-20-minuten/)
- [Step by Step Setup (Docs)](/icst-ambisonics-plugins/06_step_by_step_setup/)

## Typische Startfehler (und wo du suchst)
- Falsche Bus-Zuordnung (Kette `Source -> Bformat-Master -> Decoder` unterbrochen).
- Binaural-Track von falscher Quelle gespeist.
- Nicht-64-Kanal-Track im Signalpfad.
- OSC-Port-Mismatch bei externer Steuerung.

## Nächste Schritte
- [OSC Syntax für den ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
- [Reaper Ambisonics Setup in 20 Minuten](/post/reaper-setup-20-minuten/)
- [Von Stereo zu HOA7: Schritt-für-Schritt-Session](/post/stereo-to-hoa7-session/)
