---
title: "ICST Ambisonics Tools"
description: "MaxMSP externals for Ambisonics encoding, decoding and 3D source control. Free, open source, compatible with Max 8 and Max 9, available via the Max Package Manager."
date: 2026-11-21T00:00:00
tags: ["ambisonics", "max", "externals", "icst"]
---

<div class="hero__links" style="margin: 0 0 1.6rem;">
  <a class="hero__link hero__link--primary" href="https://www.zhdk.ch/forschung/icst/software-downloads-5379/downloads-icst-tools-for-maxmsp-5385" target="_blank" rel="noopener noreferrer">
    <i class="fas fa-download"></i>&nbsp;Download via Max Package Manager
  </a>
  <a class="hero__link" href="https://www.zhdk.ch/forschung/icst/software-downloads-5379" target="_blank" rel="noopener noreferrer">
    <i class="fas fa-external-link-alt"></i>&nbsp;All ICST Software Downloads
  </a>
</div>

<img src="/icst-ambisonics-tools/large-1.jpg" alt="ICST Ambisonics Tools in Max: patch with ambimonitor and icst.spline" style="display:block;width:100%;max-width:640px;height:auto;margin:1.2rem auto;border-radius:8px">

A collection of **MaxMSP externals** for **Ambisonics** surround sound processing and 3D source control. Developed through research and practice since 2000 and first released in 2003, the tools have been used in concerts, compositions and installations. They run in music studios, listening spaces and acoustics labs worldwide, and, as an extension of Max, in Ableton Live. The current release reworks and extends almost every part of the package.

## At a glance

| | |
|---|---|
| Type | Max/MSP externals (Max package) |
| Version | 3.0.1 (May 2021) |
| Compatible with | Max 8.1 and later, **including the current Max 9** |
| Platform | macOS, Windows 10 |
| Licence | Revised BSD (included in the package) |
| Install | Max Package Manager |

## Included externals

| External | Function | Area |
|---|---|---|
| `ambiencode~` | Encode multiple audio sources to Ambisonics B-format. | Encoding |
| `mc.ambiencode~` | As above, multichannel version. | Encoding |
| `ambidecode~` | Decode B-format to multiple audio outputs. | Decoding |
| `mc.ambidecode~` | As above, multichannel version. | Decoding |
| `ambipanning~` | Ambisonics-equivalent panning. | Panning |
| `mc.ambipanning~` | As above, multichannel version. | Panning |
| `ambimonitor` | GUI object for Ambisonic sound spatialisation. | Control |
| `ambicontrol` | Trajectory controller for ambimonitor. | Control |
| `ambipoint` | Swiss army knife for ambi-formatted points. | Control |
| `icst.map` | Remap a value from a curve, table, buffer or list. | Algorithmic |
| `icst.random` | Random values from distribution curves. | Algorithmic |
| `icst.spline` | Define and evaluate splines. | Algorithmic |
| `icst.button` | Button or toggle switch. | User interface |
| `icst.floatui` | GUI for floating-point values. | User interface |
| `icst.intui` | GUI for integer values. | User interface |
| `icst.listui` | GUI for lists. | User interface |

## Installation

Install **ICST Ambisonics Tools** in **Max 8 or Max 9** via the **Package Manager**:

<video autoplay muted loop playsinline preload="metadata" aria-label="Installing the package in the Max Package Manager" style="width:100%;height:auto;border-radius:6px" src="/icst-ambisonics-tools/Amb_Max.mp4"></video>

More information and the download at [ZHdK](https://www.zhdk.ch/en/research/icst/software-downloads-5379/downloads-icst-tools-for-maxmsp-5385).

## When to use the Max tools

| | Max tools | REAPER plugins |
|---|---|---|
| Strength | Modular, individual patching for each application | Ready-made, timeline-based (automation, Motion Map, Animator) |
| Requires | Max programming knowledge | REAPER and the plugin suite |
| Time-based | No (except Envelop in Ableton) | Yes |
| Recommended for | Live electronics, special performances | Studio production, composing on a timeline |

See the [EcoSystem overview](/ecosystem/) for how the components fit together and the [Ambisonics 101](/ambisonics-101/) for the basics.
