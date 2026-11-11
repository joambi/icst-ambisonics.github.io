---
title: "ICST Ambisonics EcoSystem"
description: "Übersicht aller ICST-Ambisonics-Komponenten: Plugins, Max-Externals, REAPER-Bundle, Bewegungswerkzeuge, Studiomaterial und Dokumentation – mit Status, Lizenz und Pflege."
date: 2026-11-11T00:00:00
draft: false
slug: ecosystem
translationKey: icst-ambisonics-ecosystem
languageCode: de
tags:
  - ambisonics
  - icst
  - ecosystem
  - reaper
  - max
---

Das **ICST Ambisonics EcoSystem** ist der Dachbegriff für alle Werkzeuge, Pakete und Materialien, die am ICST (ZHdK) für Higher-Order Ambisonics entwickelt und gepflegt werden. Jede Komponente hat eigene Versionen und eine eigene Lizenz. Das **ICST Ambisonics Bundle** ist eine davon: der vorkonfigurierte Einstieg in REAPER.

{{< notice warning >}}
Stand 11.11.2026. Komponenten mit dem Status **Beta** sind zur Evaluation freigegeben, nicht für Produktion oder Unterricht abgenommen. Lizenz- und Statusangaben gelten für die jeweils verlinkte Version.
{{< /notice >}}

## Bundle und EcoSystem

| | ICST Ambisonics Bundle | ICST Ambisonics EcoSystem |
|---|---|---|
| Art | Ein Paket zum Herunterladen (`ICST_Ambi_Reaper`) | Dach über alle Komponenten |
| Inhalt | REAPER-Ordner mit Toolbar, Skripten, VST3-Plugins, Impulsantworten und Doku | Plugins, Max-Externals, Bundle, Bewegungswerkzeuge, Templates, Layouts, Archiv, Doku |
| Version | Eigene Release-Nummer | Keine; versioniert werden die Komponenten |
| Plattform | macOS vollständig, Windows Beta | Je Komponente |
| Lizenz | Gemischt, Gesamtpaket noch offen | Jede Komponente behält ihre Lizenz |

## Komponenten

| Komponente | Inhalt | Plattform / Format | Status | Lizenz | Pflege |
|---|---|---|---|---|---|
| [ICST Ambisonics Plugins](/de/icst-ambisonics-plugins/) (Core) | AmbiEncoder, AmbiEncoder_64, AmbiDecoder, MultiDecoder, Monitor, Animator | VST3, AU; LV2 experimentell; macOS, Windows | Stabil | GPL3 | [schweizerweb/icst-ambisonics-plugins](https://github.com/schweizerweb/icst-ambisonics-plugins/releases) |
| ICST AmbiPlugins (Extended) | AmbiIRVerb, AmbiIRLayers, AmbiGran 16 | VST3; macOS, Windows | Beta, nicht signiert | Offen; IRidesce-Material mit eigener Rechtenotiz | [joambi/ICST-AmbiPlugins](https://github.com/joambi/ICST-AmbiPlugins/releases) |
| [ICST Ambisonics Tools für Max](/de/icst-ambisonics-tools/) | `ambiencode~`, `mc.ambiencode~`, `ambidecode~`, `ambipanning~`, `ambimonitor`, `ambicontrol` u. a. | Max 8, Max Package Manager | Stabil | Frei | ICST / ZHdK |
| ICST Ambisonics Bundle (`ICST_Ambi_Reaper`) | Portabler REAPER-Ordner: Toolbar, Lua-Skripte, ICST- und IEM-VST3, SWS, js_ReaScriptAPI, ReaPack, Doku | REAPER 7; macOS (Apple Silicon empfohlen), Windows | macOS vollständig, Windows Beta ungetestet | Gemischt, Gesamtpaket offen | [joambi/ICST-AmbiPlugins](https://github.com/joambi/ICST-AmbiPlugins/releases) |
| ICST Animator / Animator Choreographer | Zeitleisten-Animation von Quellen, Szenen als XML, Regionen-Import per CSV | macOS, Windows | In Entwicklung; Doku erscheint mit Plugins 4.0 | Offen | ICST |
| [Motion Map](/de/icst-ambisonics-plugins/15_icst_ambi_motion_map/), [Kristall Motion Map](/de/icst-ambisonics-plugins/18_kristall_motion_map/), [Motion Markers](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) | Bewegungsformen, Kristallgitter und markerbasierte Bewegung für AmbiEncoder_64 | REAPER-Lua, Python 3 für OSC-Vorschau | Stabil | Frei | [joambi/icst-ambisonics.github.io](https://github.com/joambi/icst-ambisonics.github.io) |
| [HOA REAPER Template Pack](/de/blog/download-pack-1-hoa-reaper-template/) | Session-Templates und HOA-Routing-Checkliste | REAPER | Stabil | Frei | ICST |
| [Lautsprecher-Layouts und Decoder-Settings](/de/blog/downloads/) | ICST Kompositionsstudio, ICST DOM, ZHdK IA Space, Notam Studio 3 | XML, ZIP | Stabil | Frei | ICST |
| [ICST B-Format Archive](/de/blog/b-format-archive/) | Referenzaufnahmen in ambiX (ACN/SN3D) | WAV | Stabil | Je Werk | ICST |
| Dokumentation | Plugin-Doku, Tutorials, Ambisonics 101, Workflow-Guide, Resident Guide | Web, PDF | Laufend | Website-Lizenz | [ambisonics.ch](/de/) |

## Abhängigkeiten von Dritten

| Komponente | Verwendet in | Lizenz | Hinweis |
|---|---|---|---|
| [IEM Plug-in Suite](https://plugins.iem.at/) | Bundle (BinauralDecoder, HOA-FX) | GPL3 | Ab v1.16.0 Breaking Changes; Templates vor einem Update prüfen |
| [SWS](https://www.sws-extension.org), [js_ReaScriptAPI](https://forum.cockos.com/showthread.php?t=212174), [ReaPack](https://reapack.com) | Bundle-Skripte | Frei | Auf Windows selbst installieren |
| dearVR AMBI MICRO | Ersatzweg des Binaural-Skripts | Proprietär, eingestellt | Wird nicht mehr gepflegt; nicht für neue Projekte |
| Python 3 | Motion Map, Kristall Motion Map | PSF | Nur für die OSC-Vorschau |

## Offene Punkte

- Lizenz für das Gesamtpaket des Bundles und für ICST AmbiPlugins festlegen.
- Windows-Durchlauf des Bundles abnehmen.
- dearVR-Ersatzweg im Binaural-Skript ersetzen oder als Altlast kennzeichnen.
- Institutionelle Pflege und Zuständigkeit je Komponente für die Zeit nach der ICST-Übergabe klären.
