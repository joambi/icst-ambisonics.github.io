---
title: "ICST Ambisonics EcoSystem"
description: "Overview of all ICST Ambisonics components: plugins, Max externals, REAPER bundle, motion tools, studio material and documentation – with status, version, licence and maintenance."
date: 2026-11-19T00:00:00
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

The **ICST Ambisonics EcoSystem** is the umbrella term for all tools, packages and materials developed and maintained at ICST (ZHdK) for Higher-Order Ambisonics. Each component has its own version and its own licence. The **ICST Ambisonics Bundle** is one of them: the preconfigured entry point into REAPER.

The idea behind it: space is treated as compositional material, not as an effect added at the end. The plugins (VST3/AU/LV2) handle encoding, decoding and binaural monitoring. The REAPER and Max tools write, control and import spatial movement. The same toolset carries a piece from the first sketch in the studio to the performance over a loudspeaker dome. This blog, ambisonics.ch, brings documentation, tutorials and downloads together, so composers, students and researchers can use the whole chain openly and follow how it works.

{{< notice warning >}}
As of 2026-11-19. Components marked **Beta** are released for evaluation, not approved for production or teaching. Licence and status information applies to the linked version.
{{< /notice >}}

## Where to start

| You are… | Start with |
| --- | --- |
| New to Ambisonics | [Ambisonics 101](/ambisonics-101/), then the [Bundle](/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/) and the [HOA REAPER Template Pack](/blog/download-pack-1-hoa-reaper-template/) |
| Composer in REAPER | [ICST Ambisonics Plugins](/icst-ambisonics-plugins/), [Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/), [Animator](/icst-ambisonics-plugins/11_animator/) |
| Composer in Max | [ICST Ambisonics Tools for Max](/icst-ambisonics-tools/) |
| Artist in residence | [Resident Guide](/for-residents/), [speaker layouts and decoder settings](/blog/downloads/) |
| Researcher | [ICST B-Format Archive](/blog/b-format-archive/), [Best Practices](/icst-ambisonics-plugins/17_best_practices/) |

## How the components fit together

- The **ICST Ambisonics Plugins** are the core: encoding, decoding, monitoring.
- The **Bundle** packages them for REAPER together with scripts, IEM plugins and documentation.
- **Motion Map, Kristall Motion Map and Motion Markers** write spatial movement for the AmbiEncoder_64 (REAPER Lua).
- The **Animator** animates source groups in the Multi-AmbiEncoder_64 on a timeline. The **Animator Choreographer** builds the Animator scene XML and imports regions from REAPER via CSV.
- The **Max Tools** cover the same chain of encoding, decoding and control inside Max.
- **Layouts, templates and the B-Format Archive** are the material around the tools.

## Bundle and EcoSystem

|  | ICST Ambisonics Bundle | ICST Ambisonics EcoSystem |
| --- | --- | --- |
| Type | One downloadable package (`ICST_Ambi_Reaper`) | Umbrella over all components |
| Contents | REAPER folder with toolbar, scripts, VST3 plugins and docs | Plugins, Max externals, bundle, motion tools, templates, layouts, archive, docs |
| Version | Own release number | None; components are versioned |
| Platform | macOS complete, Windows beta | Per component |
| Licence | ICST parts GPL-3.0-or-later, components keep their own | Each component keeps its licence |

## Status levels

| Status | Meaning |
| --- | --- |
| **Stable** | Released, approved for production and teaching |
| **Beta** | Released for evaluation, not approved for production or teaching |
| **Experimental** | Works in part, no support, interface may change |
| **Docs only** | Documentation is published, the component itself is not a separate release |

## Components

| Component | Contents | Platform / format | Status | Version | Licence | Source |
| --- | --- | --- | --- | --- | --- | --- |
| [ICST Ambisonics Plugins](/icst-ambisonics-plugins/) (Core) | AmbiEncoder, AmbiEncoder_64, AmbiDecoder, MultiDecoder, Monitor | VST3, AU; LV2 experimental; macOS, Windows | Stable | 4.0 | GPL-3.0-or-later | [schweizerweb/icst-ambisonics-plugins](https://github.com/schweizerweb/icst-ambisonics-plugins/releases) |
| [ICST Animator](/icst-ambisonics-plugins/11_animator/) | Timeline animation of source groups in the Multi-AmbiEncoder_64, scenes as XML | macOS, Windows | Docs only (released with Plugins 4.0) | Part of Plugins | GPL-3.0-or-later | [schweizerweb/icst-ambisonics-plugins](https://github.com/schweizerweb/icst-ambisonics-plugins/releases) |
| [ICST Animator Choreographer](/post/icst-animator-choreographer/) | Desktop app that builds Animator scene XML in five steps; region import from REAPER via CSV; optional draft from a description with a local model (Ollama) | macOS, Windows, Linux; unsigned | Beta | [0.1.0](https://github.com/joambi/animator-choreographer/releases/tag/v0.1.0) | GPL-3.0-or-later | [joambi/animator-choreographer](https://github.com/joambi/animator-choreographer) |
| [ICST Ambisonics Bundle (`ICST_Ambi_Reaper`)](/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/) | Portable REAPER folder: toolbar, Lua scripts, ICST and IEM VST3, SWS, js_ReaScriptAPI, ReaPack, docs | REAPER 7; macOS (Apple Silicon recommended), Windows | Beta (macOS complete, Windows untested) | [1.1.3](https://github.com/joambi/ICST_Ambi_Reaper/releases/tag/v1.1.3) | ICST parts GPL-3.0-or-later, otherwise per component | [joambi/ICST_Ambi_Reaper](https://github.com/joambi/ICST_Ambi_Reaper) |
| [ICST Ambisonics Tools for Max](/icst-ambisonics-tools/) | `ambiencode~`, `mc.ambiencode~`, `ambidecode~`, `ambipanning~`, `ambimonitor`, `ambicontrol` and more | Max 8, Max Package Manager | Stable | — | GPL-3.0-or-later | — |
| [Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/), [Kristall Motion Map](/icst-ambisonics-plugins/18_kristall_motion_map/), [Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) | Motion shapes with a figure editor, crystal lattices and marker-based motion for AmbiEncoder_64 | REAPER Lua; Python 3 for OSC preview | Stable | — | GPL-3.0-or-later | [joambi/icst-ambisonics.github.io](https://github.com/joambi/icst-ambisonics.github.io) |
| [HOA REAPER Template Pack](/blog/download-pack-1-hoa-reaper-template/) | Session templates and HOA routing checklist | REAPER | Stable | — | CC BY 4.0 | ICST |
| [Speaker layouts and decoder settings](/blog/downloads/) | ICST Composition Studio, ICST DOM, ZHdK IA Space, Notam Studio 3 | XML, ZIP | Stable | — | CC BY 4.0 | ICST |
| [ICST B-Format Archive](/blog/b-format-archive/) | Reference recordings in ambiX (ACN/SN3D) | WAV | Stable | — | Per work | ICST |
| Documentation | Plugin docs, tutorials, Ambisonics 101, workflow guide, resident guide | Web, PDF | Ongoing | — | CC BY 4.0 | [ambisonics.ch](/) |

## Platform overview

| Component | macOS | Windows | Linux |
| --- | --- | --- | --- |
| Plugins (VST3, AU) | yes | yes | LV2 experimental |
| Bundle | complete | beta, untested | — |
| Animator Choreographer | yes | yes | yes |

## Third-party dependencies

| Component | Used in | Licence | Note |
| --- | --- | --- | --- |
| [IEM Plug-in Suite](https://plugins.iem.at/) | Bundle (BinauralDecoder, HOA FX) | GPL-3.0 | The binaural script uses the IEM BinauralDecoder; breaking changes from v1.16.0, check templates before updating |
| [SWS](https://www.sws-extension.org) | Bundle scripts | MIT | Install manually on Windows |
| [js_ReaScriptAPI](https://github.com/juliansader/ReaExtensions) | Bundle scripts | MIT | Install manually on Windows |
| [ReaPack](https://reapack.com) | Bundle scripts | LGPL-3.0 | Install manually on Windows |
| [Python 3](https://www.python.org/) | Motion Map, Kristall Motion Map | PSF | Only for the OSC preview |
| [Ollama](https://ollama.com) | Animator Choreographer | MIT | Optional; only for the draft from a description |
