---
title: "ICST Ambisonics EcoSystem"
description: "Übersicht aller ICST-Ambisonics-Komponenten: Plugins, Max-Externals, REAPER-Bundle, Bewegungswerkzeuge, Studiomaterial und Dokumentation – mit Status, Version, Lizenz und Pflege."
date: 2026-11-19T00:00:00
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

<figure>
  <object type="image/svg+xml" data="/images/ecosystem-collage-de.svg" aria-label="Collage des ICST Ambisonics EcoSystems: Ambisonics-Kugel mit Lautsprecherring und Trajektorien, umgeben von ICST Ambisonics Tools (Max), Plugins (AU, VST3, LV2), Animator, Ambi Reaper, GitHub und Wiki sowie dem Blog ambisonics.ch" style="width:100%;aspect-ratio:1600/1000;display:block">
    <img src="/images/ecosystem-collage-de.svg" alt="Collage des ICST Ambisonics EcoSystems: Ambisonics-Kugel mit Lautsprecherring und Trajektorien, umgeben von ICST Ambisonics Tools (Max), Plugins (AU, VST3, LV2), Animator, Ambi Reaper, GitHub und Wiki sowie dem Blog ambisonics.ch" loading="lazy" style="width:100%;max-width:100%;max-height:none;margin:0" />
  </object>
</figure>

Das **ICST Ambisonics EcoSystem** ist der Oberbegriff für alle Werkzeuge, Pakete und Materialien, die am ICST (ZHdK) für Higher-Order Ambisonics entwickelt und gepflegt werden. Jede Komponente hat ihre eigene Version und ihre eigene Lizenz. Das **ICST Ambisonics Bundle** ist eine davon: der vorkonfigurierte Einstieg in REAPER.

Die Idee dahinter: Raum wird als kompositorisches Material behandelt, nicht als Effekt, der am Ende dazukommt. Die Plugins (VST3/AU/LV2) übernehmen Encoding, Decoding und binaurales Monitoring. Die REAPER- und Max-Tools schreiben, steuern und importieren räumliche Bewegung. Dasselbe Werkzeug begleitet ein Stück von der ersten Skizze im Studio bis zur Aufführung über eine Lautsprecherkuppel. Dieser Blog, ambisonics.ch, führt Dokumentation, Tutorials und Downloads zusammen, damit Komponierende, Studierende und Forschende die ganze Kette offen nutzen und nachvollziehen können.

{{< notice warning >}}
Stand: 2026-11-19. Als **Beta** markierte Komponenten sind zur Evaluation freigegeben, nicht für Produktion oder Unterricht. Lizenz- und Statusangaben gelten für die verlinkte Version.
{{< /notice >}}

## Wo anfangen?

| Du bist … | Beginne mit |
| --- | --- |
| Neu bei Ambisonics | [Ambisonics 101](/de/ambisonics-101/), dann [Bundle](/de/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/) und [HOA REAPER Template Pack](https://ambisonics.ch/blog/download-pack-1-hoa-reaper-template/) |
| Komponist:in in REAPER | [ICST Ambisonics Plugins](/de/icst-ambisonics-plugins/), [Motion Map](/de/icst-ambisonics-plugins/15_icst_ambi_motion_map/), [Animator](/de/icst-ambisonics-plugins/11_animator/) |
| Komponist:in in Max | [ICST Ambisonics Tools für Max](/de/icst-ambisonics-tools/) |
| Artist in Residence | [Resident Guide](/de/for-residents/), [Lautsprecher-Layouts und Decoder-Einstellungen](https://ambisonics.ch/blog/downloads/) |
| Forschende | [ICST B-Format-Archiv](https://ambisonics.ch/blog/b-format-archive/), [Best Practices](/de/icst-ambisonics-plugins/17_best_practices/) |


## Wie die Komponenten zusammenhängen

- Die **ICST Ambisonics Plugins** sind der Kern: Encoding, Decoding, Monitoring.
- Das **Bundle** verpackt sie für REAPER zusammen mit Skripten, IEM-Plugins und Dokumentation.
- **Motion Map, Kristall Motion Map und Motion Markers** schreiben räumliche Bewegung für den AmbiEncoder_64 (REAPER Lua).
- Der **Animator** animiert Quellgruppen im AmbiEncoder_64 auf einer Timeline. Der **Animator Choreographer** erzeugt die Animator-Szenen-XML und importiert Regionen aus REAPER per CSV.
- Die **Max-Tools** decken dieselbe Kette aus Encoding, Decoding und Steuerung innerhalb von Max ab.
- **Layouts, Templates und das B-Format-Archiv** sind das Material rund um die Werkzeuge.

## Bundle und EcoSystem

|  | ICST Ambisonics Bundle | ICST Ambisonics EcoSystem |
| --- | --- | --- |
| Art | Ein herunterladbares Paket (`ICST_Ambi_Reaper`) | Dach über alle Komponenten |
| Inhalt | REAPER-Ordner mit Toolbar, Skripten, VST3-Plugins und Doku | Plugins, Max-Externals, Bundle, Motion-Tools, Templates, Layouts, Archiv, Doku |
| Version | Eigene Release-Nummer | Keine; die Komponenten sind versioniert |
| Plattform | macOS vollständig, Windows Beta | Je Komponente |
| Lizenz | ICST-Teile GPL-3.0-or-later, Komponenten behalten ihre eigene | Jede Komponente behält ihre Lizenz |

## Statusstufen

| Status | Bedeutung |
| --- | --- |
| **Stable** | Freigegeben, für Produktion und Unterricht zugelassen |
| **Beta** | Zur Evaluation freigegeben, nicht für Produktion oder Unterricht |
| **Experimental** | Funktioniert teilweise, kein Support, Schnittstelle kann sich ändern |
| **Docs only** | Dokumentation ist veröffentlicht, die Komponente selbst ist kein eigenes Release |

## Komponenten

| Komponente | Inhalt | Plattform / Format | Status | Version | Lizenz | Quelle |
| --- | --- | --- | --- | --- | --- | --- |
| [ICST Ambisonics Plugins](/de/icst-ambisonics-plugins/) (Core) | AmbiEncoder, AmbiEncoder_64, AmbiDecoder, MultiDecoder, Monitor | VST3, AU; LV2 experimentell; macOS, Windows | Stable | 4.0 | GPL-3.0-or-later | [schweizerweb/icst-ambisonics-plugins](https://github.com/schweizerweb/icst-ambisonics-plugins/releases) |
| [ICST Animator](/de/icst-ambisonics-plugins/11_animator/) | Timeline-Animation von Quellgruppen im AmbiEncoder_64, Szenen als XML | macOS, Windows | Docs only (veröffentlicht mit Plugins 4.0) | Teil der Plugins | GPL-3.0-or-later | [schweizerweb/icst-ambisonics-plugins](https://github.com/schweizerweb/icst-ambisonics-plugins/releases) |
| [ICST Animator Choreographer](/de/post/icst-animator-choreographer/) | Desktop-App, die Animator-Szenen-XML in fünf Schritten aufbaut; Regionen-Import aus REAPER per CSV; optionaler Entwurf aus einer Beschreibung mit lokalem Modell (Ollama) | macOS, Windows, Linux; unsigniert | Beta | [0.1.0](https://github.com/joambi/animator-choreographer/releases/tag/v0.1.0) | GPL-3.0-or-later | [joambi/animator-choreographer](https://github.com/joambi/animator-choreographer) |
| [ICST Ambisonics Bundle (`ICST_Ambi_Reaper`)](/de/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/) | Portabler REAPER-Ordner: Toolbar, Lua-Skripte, ICST- und IEM-VST3, SWS, js_ReaScriptAPI, ReaPack, Doku | REAPER 7; macOS (Apple Silicon empfohlen), Windows | Beta (macOS vollständig, Windows ungetestet) | [1.1.3](https://github.com/joambi/ICST_Ambi_Reaper/releases/tag/v1.1.3) | ICST-Teile GPL-3.0-or-later, sonst je Komponente | [joambi/ICST_Ambi_Reaper](https://github.com/joambi/ICST_Ambi_Reaper) |
| [ICST Ambisonics Tools für Max](/de/icst-ambisonics-tools/) | `ambiencode~`, `mc.ambiencode~`, `ambidecode~`, `ambipanning~`, `ambimonitor`, `ambicontrol` und weitere | Max 8, Max Package Manager | Stable | — | GPL-3.0-or-later | — |
| [Motion Map](/de/icst-ambisonics-plugins/15_icst_ambi_motion_map/), [Kristall Motion Map](/de/icst-ambisonics-plugins/18_kristall_motion_map/), [Motion Markers](/de/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) | Bewegungsfiguren mit Figureneditor, Kristallgitter und markerbasierte Bewegung für AmbiEncoder_64 | REAPER Lua; Python 3 für OSC-Vorschau | Stable | — | GPL-3.0-or-later | [joambi/icst-ambisonics.github.io](https://github.com/joambi/icst-ambisonics.github.io) |
| [HOA REAPER Template Pack](https://ambisonics.ch/blog/download-pack-1-hoa-reaper-template/) | Session-Templates und HOA-Routing-Checkliste | REAPER | Stable | — | CC BY 4.0 | ICST |
| [Lautsprecher-Layouts und Decoder-Einstellungen](https://ambisonics.ch/blog/downloads/) | ICST Composition Studio, ICST DOM, ZHdK IA Space, Notam Studio 3 | XML, ZIP | Stable | — | CC BY 4.0 | ICST |
| [ICST B-Format-Archiv](https://ambisonics.ch/blog/b-format-archive/) | Referenzaufnahmen in ambiX (ACN/SN3D) | WAV | Stable | — | Je Werk | ICST |
| Dokumentation | Plugin-Doku, Tutorials, Ambisonics 101, Workflow-Guide, Resident Guide | Web, PDF | Laufend | — | CC BY 4.0 | [ambisonics.ch](/) |

## Plattformübersicht

| Komponente | macOS | Windows | Linux |
| --- | --- | --- | --- |
| Plugins (VST3, AU) | ja | ja | LV2 experimentell |
| Bundle | vollständig | Beta, ungetestet | — |
| Animator Choreographer | ja | ja | ja |

## Drittanbieter-Abhängigkeiten

| Komponente | Verwendet in | Lizenz | Hinweis |
| --- | --- | --- | --- |
| [IEM Plug-in Suite](https://plugins.iem.at/) | Bundle (BinauralDecoder, HOA FX) | GPL-3.0 | Das Binaural-Skript nutzt den IEM BinauralDecoder; Breaking Changes ab v1.16.0, Templates vor dem Update prüfen |
| [SWS](https://www.sws-extension.org) | Bundle-Skripte | MIT | Unter Windows manuell installieren |
| [js_ReaScriptAPI](https://github.com/juliansader/ReaExtensions) | Bundle-Skripte | MIT | Unter Windows manuell installieren |
| [ReaPack](https://reapack.com) | Bundle-Skripte | LGPL-3.0 | Unter Windows manuell installieren |
| [Python 3](https://www.python.org/) | Motion Map, Kristall Motion Map | PSF | Nur für die OSC-Vorschau |
| [Ollama](https://ollama.com) | Animator Choreographer | MIT | Optional; nur für den Entwurf aus einer Beschreibung |
