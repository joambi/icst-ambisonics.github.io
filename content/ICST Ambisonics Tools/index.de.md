---
title: "ICST Ambisonics Tools"
description: "MaxMSP-Externals für Ambisonics-Encoding, -Decoding und 3D-Quellenkontrolle. Kostenlos, Open Source, kompatibel mit Max 8 und Max 9, verfügbar über den Max Package Manager."
date: 2026-11-21T00:00:00
tags: ["ambisonics", "max", "externals", "icst"]
languageCode: de
---

<div class="hero__links" style="margin: 0 0 1.6rem;">
  <a class="hero__link hero__link--primary" href="https://www.zhdk.ch/forschung/icst/software-downloads-5379/downloads-icst-tools-for-maxmsp-5385" target="_blank" rel="noopener noreferrer">
    <i class="fas fa-download"></i>&nbsp;Download via Max Package Manager
  </a>
  <a class="hero__link" href="https://www.zhdk.ch/forschung/icst/software-downloads-5379" target="_blank" rel="noopener noreferrer">
    <i class="fas fa-external-link-alt"></i>&nbsp;Alle ICST Software-Downloads
  </a>
</div>

<img src="/icst-ambisonics-tools/large-1.jpg" alt="ICST Ambisonics Tools in Max: patch with ambimonitor and icst.spline" style="display:block;width:100%;max-width:640px;height:auto;margin:1.2rem auto;border-radius:8px">

Eine Sammlung von **MaxMSP-Externals** für **Ambisonics**-Surround-Verarbeitung und 3D-Quellenkontrolle. Aus Forschung und Praxis seit 2000 entstanden und 2003 erstmals veröffentlicht, sind die Tools in Konzerten, Kompositionen und Installationen im Einsatz. Sie laufen in Musikstudios, Hörräumen und Akustiklabors weltweit und als Erweiterung von Max auch in Ableton Live. Die aktuelle Version überarbeitet und erweitert nahezu alle Teile des Pakets.

## Auf einen Blick

| | |
|---|---|
| Typ | Max/MSP-Externals (Max-Package) |
| Version | 3.0.1 (Mai 2021) |
| Kompatibel mit | Max 8.1 und neuer, **auch mit dem aktuellen Max 9** |
| Plattform | macOS, Windows 10 |
| Lizenz | Revised BSD (im Paket enthalten) |
| Installation | Max Package Manager |

## Enthaltene Externals

| External | Funktion | Bereich |
|---|---|---|
| `ambiencode~` | Mehrere Audioquellen in Ambisonics-B-Format kodieren. | Encoding |
| `mc.ambiencode~` | Wie oben, Multichannel-Version. | Encoding |
| `ambidecode~` | B-Format auf mehrere Audioausgänge dekodieren. | Decoding |
| `mc.ambidecode~` | Wie oben, Multichannel-Version. | Decoding |
| `ambipanning~` | Panning auf Ambisonics-Basis. | Panning |
| `mc.ambipanning~` | Wie oben, Multichannel-Version. | Panning |
| `ambimonitor` | GUI-Objekt für Ambisonics-Spatialisierung. | Steuerung |
| `ambicontrol` | Trajektorien-Controller für ambimonitor. | Steuerung |
| `ambipoint` | Schweizer Taschenmesser für Ambi-Punkte. | Steuerung |
| `icst.map` | Wert über Kurve, Tabelle, Buffer oder Liste umrechnen. | Algorithmisch |
| `icst.random` | Zufallswerte aus Verteilungskurven. | Algorithmisch |
| `icst.spline` | Splines definieren und auswerten. | Algorithmisch |
| `icst.button` | Button oder Toggle-Schalter. | Benutzeroberfläche |
| `icst.floatui` | GUI für Fliesskommawerte. | Benutzeroberfläche |
| `icst.intui` | GUI für ganze Zahlen. | Benutzeroberfläche |
| `icst.listui` | GUI für Listen. | Benutzeroberfläche |

## Installation

**ICST Ambisonics Tools** in **Max 8 oder Max 9** über den **Package Manager** installieren:

<video autoplay muted loop playsinline preload="metadata" aria-label="Installation im Max Package Manager" style="width:100%;height:auto;border-radius:6px" src="/icst-ambisonics-tools/Amb_Max.mp4"></video>

Weitere Informationen und Download bei der [ZHdK](https://www.zhdk.ch/en/research/icst/software-downloads-5379/downloads-icst-tools-for-maxmsp-5385).

## Wann die Max-Tools?

| | Max-Tools | REAPER-Plugins |
|---|---|---|
| Stärke | Modular, individuelles Patching je Anwendung | Fertig nutzbar, zeitbasiert (Automation, Motion Map, Animator) |
| Voraussetzung | Max-Programmierkenntnisse | REAPER und die Plugin-Suite |
| Zeitbasiert | Nein (ausser Envelop in Ableton) | Ja |
| Empfohlen für | Live-Elektronik, besondere Aufführungen | Studioproduktion, Komponieren auf der Timeline |

Wie die Komponenten zusammenpassen, zeigt die [EcoSystem-Übersicht](/de/ecosystem/), die Grundlagen stehen in [Ambisonics 101](/de/ambisonics-101/).
