---
title: "ICST Ambisonics EcoSystem"
description: "Overview of all ICST Ambisonics components: plugins, Max externals, REAPER bundle, motion tools, studio material and documentation – with status, licence and maintenance."
date: 2026-11-11T00:00:00
draft: false
slug: ecosystem
translationKey: icst-ambisonics-ecosystem
languageCode: en
tags:
  - ambisonics
  - icst
  - ecosystem
  - reaper
  - max
---

<figure>
  <object type="image/svg+xml" data="/images/ecosystem-collage-en.svg" aria-label="Collage of the ICST Ambisonics EcoSystem: Ambisonics sphere with speaker ring and trajectories, surrounded by ICST Ambisonics Tools (Max), Plugins (AU, VST3, LV2), Animator, Ambi Reaper, GitHub and Wiki, and the blog ambisonics.ch" style="width:100%;aspect-ratio:1600/1000;display:block">
    <img src="/images/ecosystem-collage-en.svg" alt="Collage of the ICST Ambisonics EcoSystem: Ambisonics sphere with speaker ring and trajectories, surrounded by ICST Ambisonics Tools (Max), Plugins (AU, VST3, LV2), Animator, Ambi Reaper, GitHub and Wiki, and the blog ambisonics.ch" loading="lazy" style="width:100%;max-width:100%;max-height:none;margin:0" />
  </object>
</figure>

The **ICST Ambisonics EcoSystem** is the umbrella term for all tools, packages and materials developed and maintained at ICST (ZHdK) for Higher-Order Ambisonics. Each component has its own versions and its own licence. The **ICST Ambisonics Bundle** is one of them: the preconfigured entry point into REAPER.

{{< notice warning >}}
As of 2026-11-11. Components marked **Beta** are released for evaluation, not approved for production or teaching. Licence and status information applies to the linked version.
{{< /notice >}}

## Bundle and EcoSystem

| | ICST Ambisonics Bundle | ICST Ambisonics EcoSystem |
|---|---|---|
| Type | One downloadable package (`ICST_Ambi_Reaper`) | Umbrella over all components |
| Contents | REAPER folder with toolbar, scripts, VST3 plugins, impulse responses and docs | Plugins, Max externals, bundle, motion tools, templates, layouts, archive, docs |
| Version | Own release number | None; components are versioned |
| Platform | macOS complete, Windows beta | Per component |
| Licence | Mixed, package licence still open | Each component keeps its licence |

## Components

| Component | Contents | Platform / format | Status | Licence | Maintained in |
|---|---|---|---|---|---|
| [ICST Ambisonics Plugins](/icst-ambisonics-plugins/) (Core) | AmbiEncoder, AmbiEncoder_64, AmbiDecoder, MultiDecoder, Monitor, Animator | VST3, AU; LV2 experimental; macOS, Windows | Stable | GPL3 | [schweizerweb/icst-ambisonics-plugins](https://github.com/schweizerweb/icst-ambisonics-plugins/releases) |
| ICST AmbiPlugins (Extended) | AmbiIRVerb, AmbiIRLayers, AmbiGran 16 | VST3; macOS, Windows | Beta, unsigned | Open; IRidesce material with its own rights notice | [joambi/ICST-AmbiPlugins](https://github.com/joambi/ICST-AmbiPlugins/releases) |
| [ICST Ambisonics Tools for Max](/icst-ambisonics-tools/) | `ambiencode~`, `mc.ambiencode~`, `ambidecode~`, `ambipanning~`, `ambimonitor`, `ambicontrol` and more | Max 8, Max Package Manager | Stable | Free | ICST / ZHdK |
| [ICST Ambisonics Bundle (`ICST_Ambi_Reaper`)](/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/) | Portable REAPER folder: toolbar, Lua scripts, ICST and IEM VST3, SWS, js_ReaScriptAPI, ReaPack, docs | REAPER 7; macOS (Apple Silicon recommended), Windows | macOS complete, Windows beta untested | Mixed, package licence open | [joambi/ICST-AmbiPlugins](https://github.com/joambi/ICST-AmbiPlugins/releases) |
| [ICST Animator](/icst-ambisonics-plugins/11_animator/) | Timeline animation of source groups in the Multi-AmbiEncoder_64, scenes as XML | macOS, Windows | Docs released with Plugins 4.0 | Open | ICST |
| [ICST Animator Choreographer](/post/icst-animator-choreographer/) | Desktop app that builds Animator scene XML in five steps; region import from REAPER via CSV; optional draft from a description with a local model (Ollama) | macOS; app unsigned | In development | GPL3 | ICST |
| [Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/), [Kristall Motion Map](/icst-ambisonics-plugins/18_kristall_motion_map/), [Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) | Motion shapes with a figure editor, crystal lattices and marker-based motion for AmbiEncoder_64 | REAPER Lua, Python 3 for OSC preview | Stable | Free | [joambi/icst-ambisonics.github.io](https://github.com/joambi/icst-ambisonics.github.io) |
| [HOA REAPER Template Pack](/blog/download-pack-1-hoa-reaper-template/) | Session templates and HOA routing checklist | REAPER | Stable | Free | ICST |
| [Speaker layouts and decoder settings](/blog/downloads/) | ICST Composition Studio, ICST DOM, ZHdK IA Space, Notam Studio 3 | XML, ZIP | Stable | Free | ICST |
| [ICST B-Format Archive](/blog/b-format-archive/) | Reference recordings in ambiX (ACN/SN3D) | WAV | Stable | Per work | ICST |
| Documentation | Plugin docs, tutorials, Ambisonics 101, workflow guide, resident guide | Web, PDF | Ongoing | Site licence | [ambisonics.ch](/) |

## Third-party dependencies

| Component | Used in | Licence | Note |
|---|---|---|---|
| [IEM Plug-in Suite](https://plugins.iem.at/) | Bundle (BinauralDecoder, HOA FX) | GPL3 | The binaural script uses the IEM BinauralDecoder; breaking changes from v1.16.0, check templates before updating |
| [SWS](https://www.sws-extension.org), [js_ReaScriptAPI](https://forum.cockos.com/showthread.php?t=212174), [ReaPack](https://reapack.com) | Bundle scripts | Free | Install manually on Windows |
| Python 3 | Motion Map, Kristall Motion Map | PSF | Only for the OSC preview |
