---
title: ICST Encoders
date: 2025-01-01T00:00:00
weight: 80
draft: false
description: "Leitfaden zu den ICST Encoders für Quellenpositionierung, Bewegung, Gruppierung und OSC-basierte Steuerung in Ambisonics-Sessions."
---

Level: Intermediate | Zielgruppe: Komponist:in, Techniker:in, Studierende, Interactive-Media-User.

Nutze diese Seite, wenn du Quellen im Ambisonics-Feld platzieren, bewegen, gruppieren oder automatisieren willst.

## Welchen Encoder solltest du verwenden?

Nutze **MonoEncoder**, wenn:

- du jeweils nur eine Quelle positionieren willst
- du den Workflow gerade lernst
- du das klarste Routing pro Quelle willst

Nutze **MultiEncoder**, wenn:

- du viele Quellen in einer Oberfläche steuern willst
- du Quellengruppen brauchst
- du größere Bewegungsstrukturen aufnehmen oder editieren willst
- du OSC-basierte Interaktion mit mehreren Quellen planst

## Was die Encoder machen

Die **ICST Encoders** positionieren und bewegen Klangquellen im Ambisonics-B-Format-Feld.

- **MonoEncoder** arbeitet mit einer einzelnen Mono-Quelle.
- **MultiEncoder** verarbeitet bis zu 64 Quellen auf einer Spur und organisiert sie in bis zu 8 Gruppen.

Ein prägendes Merkmal ist die integrierte **Distanzsimulation**, die Tiefpassfilterung und einen Doppler-ähnlichen Effekt kombiniert, um Tiefenwahrnehmung zu formen.

Durch OSC-Ein- und Ausgang sind die Encoder auch für controllerbasierte und algorithmische Workflows geeignet.

## Übersicht

![ICST AmbiEncoder overview](<CleanShot 2026-03-04 at 14.27.47@2x.png>)

| Label | Beschreibung |
|---|---|
| **A** | MonoEncoder für eine einzelne Quelle |
| **B** | MultiEncoder für bis zu 64 Quellen pro Spur |

## Benutzeroberfläche

### Hauptbedienelemente

1. **Einstellungen**
2. **Hilfe**

### Quellen-Fenster

![AmbiEncoder source window](<CleanShot 2026-03-04 at 15.02.00@2x.png>)

In diesem Bereich werden einzelne Quellen über Azimut, Elevation und Distanz angezeigt und gesteuert.

### Encoding-Einstellungen

![AmbiEncoder encoding settings](<CleanShot 2026-03-04 at 15.02.47@2x.png>)

Hier werden zentrale Encoding-Parameter wie Ordnung und Kanalformat gesetzt.

### Radar

Das Radar zeigt das Feld in Draufsicht und macht Quellenpositionen und Gruppen direkt editierbar.

## Gruppierung und Bewegung

MultiEncoder ist besonders dann sinnvoll, wenn räumliche Bewegung nicht nur individuell, sondern strukturell gedacht wird:

- mehrere Quellen können gruppiert werden
- Gruppen lassen sich relativ zu ihrem Gruppenzentrum bewegen
- größere räumliche Choreografien können aufgenommen und verfeinert werden

Nutze Gruppen, wenn die Szene als zusammenhängendes Objekt funktionieren soll und nicht als Sammlung unabhängiger Einzelquellen.

## OSC-Integration

- **OSC-Eingang und JavaScript** empfangen externe Steuernachrichten
- **OSC-Ausgang** sendet den Encoder-Zustand an Controller oder externe Anwendungen

> [!example]
> Video: ICST Ambisonics Plugins – 03 – OSC Teil 1  
> https://youtu.be/7_s-jaUQa14?si=NM8TPRrigY_egDfC

Für Setup und Syntax:

- [OSC](/icst-ambisonics-plugins/13_osc/)

## Weitere Bedienelemente

8. **Distanz-Scaler**  
   Simuliert Tiefe über Tiefpassfilterung und Doppler-ähnliches Verhalten.
9. **Infiniti**  
   Platziert Quellen an der Fernfeld-Grenze.
10. **Gain / Lautstärke**  
   Regelt den Eingangs- oder Ausgangspegel des Encoders.
11. **Import & Export**  
   Speichert oder lädt Quellkonfigurationen.
12. **Gruppen-Editor**  
   Verwaltet Quellengruppen und relative Repositionierung.
13. **Presets speichern & laden**  
   Speichert komplette Encoder-Zustände für reproduzierbare Setups.

## Häufige Fehler

- MultiEncoder wird genutzt, obwohl eine einfache MonoEncoder-Spur klarer wäre
- Distanz-Skalierung wird spät im Projekt verändert und bricht die Bewegungskonsistenz
- vergessen wird, dass das Encoder-Routing trotzdem in einen stabilen Bformat Master führen muss
- OSC wird als Pflicht behandelt, obwohl normale REAPER-Automation ausreichen würde
- Quellen werden gruppiert, ohne klare Benennung, was spätere Bearbeitung erschwert

## Nächster Schritt

- [Schritt-für-Schritt-Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
- [OSC](/icst-ambisonics-plugins/13_osc/)
- [Best Practices](/icst-ambisonics-plugins/15_best_practices/)
