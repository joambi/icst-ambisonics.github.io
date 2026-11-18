---
title: ICST Ambi REAPER Bundle
date: 2026-11-18T00:00:00
weight: 35
draft: false
toc: true
translationKey: ambi-reaper-bundle
description: "The ICST Ambi REAPER Bundle (ICST_Ambi_Reaper): a portable, preconfigured REAPER folder with toolbar, Lua scripts, VST3 plugins and documentation for working with the ICST Ambisonics Plugins and the Animator Choreographer."
---

Level: Beginner | Audience: Composer, sound designer, student, technician.

The **ICST Ambi REAPER Bundle** (`ICST_Ambi_Reaper`) is a portable REAPER folder that is already set up for the ICST Ambisonics Plugins. With one click on the toolbar you create Ambisonics tracks (orders 1 to 7), route them, move sources and decode. It is the preconfigured entry point into REAPER within the [ICST Ambisonics EcoSystem](/ecosystem/).

{{< notice warning >}}
Evaluation beta, as of v1.1.3. The macOS version is complete. The Windows version is beta and has not been tested yet. REAPER itself is not included for licence reasons. The ICST's own content is licensed under GPL-3.0-or-later; third-party components keep their own licences (see below).
{{< /notice >}}

## What it contains

- A REAPER resource folder with the toolbar *ICST_Ambi_Automation* and icons for the ICST tools
- Lua scripts for spatial workflows: Quick Start, track creation, auto-routing, motion, markers, Animator
- ICST and IEM plugins as VST3 (AmbiEncoder, AmbiEncoder_64, AmbiDecoder, IEM BinauralDecoder, IEM effects for HOA FX and HOA_Reverb)
- SWS, js_ReaScriptAPI and ReaPack (macOS, Apple Silicon)
- An offline manual (`Docs/index.html`)
- The [Animator Choreographer](/post/icst-animator-choreographer/) app (`Animator/`)

## Requirements

| Item | macOS | Windows |
|---|---|---|
| Status | Complete | Beta, untested |
| System | macOS 12 or newer, Apple Silicon recommended (on Intel Macs the extensions in `UserPlugins` are missing) | Windows 10/11 (64 bit) |
| REAPER | Version 7 (tested with 7.85), not included | Version 7 (64 bit), portable install |
| Plugins | In the folder (`Effects/VST3`) | Installers needed |
| Python 3 | Optional, for Motion Map, [Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) and Kristall Motion Map | Same, from python.org |
| Plugin format | VST3 (not AU) | VST3 |

## Download

Current version: **1.1.3** with Motion Map GUI v2.4.5 ([release notes and all files on GitHub](https://github.com/joambi/ICST_Ambi_Reaper/releases/tag/v1.1.3)):

- [`ICST_Ambi_Reaper_1.1.3_macOS.zip`](https://github.com/joambi/ICST_Ambi_Reaper/releases/download/v1.1.3/ICST_Ambi_Reaper_1.1.3_macOS.zip): portable, for example for an external SSD
- [`ICST_Ambi_Reaper_1.1.3_scripts-only.zip`](https://github.com/joambi/ICST_Ambi_Reaper/releases/download/v1.1.3/ICST_Ambi_Reaper_1.1.3_scripts-only.zip): scripts, toolbar, configuration and docs only (for setting up on Windows)

**New in 1.1.3:** Motion Map GUI v2.4.5 (before: v2.4.3). Version 2.4.4 adds a preview transport with speed, direction and Play/Stop; presets do not store these settings. Version 2.4.5 always writes tracks with Latch (the *Track Latch* option is gone, older presets are ignored for it) and adds a *Sync* button: the preview follows REAPER's play/stop, and Play/Stop in the GUI start and stop the REAPER transport. Stop freezes the animation in the trajectory preview and in the live OSC preview, and the speed factor works free-running and tempo-synced (details in the [Motion Map guide](/icst-ambisonics-plugins/15_icst_ambi_motion_map/#preview-transport-from-v244-sync-from-v245)). Toolbar button, action ID and icon are unchanged. All other scripts, configuration files and the documentation are unchanged from 1.1.2.

**Tested:** as 1.1.2 with REAPER 7.85 on macOS (Apple Silicon): Auto-Route, Quick Start and routing with 64 channels. The Motion Map GUI v2.4.5 was used on its own in REAPER before it was added to the bundle; starting it from this bundle's toolbar was not tested separately.

This version is an evaluation beta (pre-release on GitHub). Please report problems as an [issue on GitHub](https://github.com/joambi/ICST_Ambi_Reaper/issues).

The SHA-256 checksums are in the [release notes](https://github.com/joambi/ICST_Ambi_Reaper/releases/tag/v1.1.3).

## Installation on macOS

<figure class="reaper-bundle-video" style="margin:0 0 1.5rem 0;">
  <video controls playsinline preload="metadata" poster="/reaper-bundle/install-tutorial-en-poster.jpg" aria-label="Video: installation and first run of the ICST Ambi REAPER Bundle on macOS" style="max-width:100%;height:auto">
    <source src="/reaper-bundle/install-tutorial-en.mp4" type="video/mp4">
  </video>
  <figcaption>Video: installing the bundle on macOS and your first run with Quick Start (about 80 seconds). The written steps follow below.</figcaption>
</figure>


The ZIP is not signed with a Developer ID. If macOS blocks the file, close the message, then go to **System Settings › Privacy & Security › Open Anyway** and confirm with your password (macOS 15 and later; up to macOS 14, Ctrl-click › *Open* is enough).

### Portable folder (ZIP)

![Anatomy of the ICST_Ambi_Reaper folder](/images/reaper-bundle-anatomy-en.svg)

*What the folder contains, and which files you add or run yourself.*


1. **Unzip** and put the folder `ICST_Ambi_Reaper` in a fixed place (external SSD or `~/Music`). Spaces in the path are fine.
2. **Add REAPER.app:** download it from [reaper.fm](https://www.reaper.fm/download.php) (same major version) and put it **into the folder** next to `reaper.ini`.
3. **Setup script:** double-click `run-me-before-install.command`, the first time via *Open Anyway*. The script removes the quarantine flag and sets the plugin path.
4. **Start REAPER:** from now on always with `ICST_Ambi_Reaper starten.command`. It sets the plugin path to the current location on every start, including external drives with a different name.
5. **Check the plugin path:** if REAPER asks *New portable install detected … scan system VST/CLAP/LV2 paths?*, answer **No**. If REAPER still adds the system VST3 folders and starts scanning: cancel the scan, quit REAPER and reopen it with `ICST_Ambi_Reaper starten.command`. Check: *Options › Preferences › Plug-ins › VST*, the path ends in `Effects/VST3`. If plugins are missing: *Re-scan* there.
6. **Toolbar:** *ICST_Ambi_Automation* appears docked at the top of the main window on first start. If it was closed: *View › Toolbars › Floating toolbar 1*.

![Set up once, then always start with the start script](/images/reaper-bundle-setup-flow-en.svg)

*The setup happens once; after that you always start with the same script.*

{{< notice info >}}
Do not install twice: if the same plugins also sit in `/Library/Audio/Plug-Ins/VST3`, REAPER may load the old copy. Use either the plugins in the folder or the system-wide ones from the ICST plugin installers, not both. If REAPER loads an old copy, remove the plugins from `/Library/Audio/Plug-Ins/VST3`.
{{< /notice >}}

## Updating an existing installation

A new ZIP brings its own `reaper.ini` (audio device, window positions etc.), `reaper-kb.ini`, `reaper-menu.ini`, `reaper-mouse.ini` and `reapack.ini`. To keep your own settings, key bindings or menus, copy these files from your old `ICST_Ambi_Reaper` folder before replacing it and put them back afterwards.

Which files to copy depends on where you start from:

| From | To | What to do |
|---|---|---|
| Any version | 1.1.3, complete | Replace the whole folder with the new ZIP (copy your settings first, see above) |
| 1.1.0 or 1.1.1 | 1.1.2, only the fix | Copy `Scripts/ICST/Ambi/Ambi_Auto_Route.lua`, `Scripts/ICST/Ambi/Ambi_Quick_Start.lua` and `Scripts/ICST/Ambi/lib/ambi_common.lua` from `…_scripts-only.zip` into your existing folder |
| 1.1.2 | 1.1.3 | Copy `Scripts/ICST/JS_AmbiEncoder64_Motion_Map_GUI.lua` (Motion Map GUI v2.4.5) from `…_scripts-only.zip` into your existing folder |

## Installation on Windows (beta)

The folder is a macOS bundle, so only the platform-neutral parts are used on Windows:

1. Install REAPER as a **portable install** (for example `C:\ICST_Ambi_Reaper`), start it once and close it.
2. Install SWS and ReaPack, then **js_ReaScriptAPI** through ReaPack.
3. Copy `Scripts\ICST`, `Data\toolbar_icons`, `Docs`, `OSC`, `ICST_Player_Presets`, `reaper-menu.ini` and `reaper-kb.ini` from the *scripts-only* zip into that folder. In an existing installation the two ini files overwrite your own toolbars and key bindings.
4. Install the plugins with their installers (ICST packages, AmbiEncoder/AmbiDecoder from [ambisonics.ch](/icst-ambisonics-plugins/02_installation/), [IEM Plug-in Suite](https://plugins.iem.at)).
5. Start REAPER, *Re-scan* the VST plugins, show *Floating toolbar 1*.

## First run (10 minutes)

### Option A: Quick Start

1. New, empty project (*File › New project*).
2. Click **Quick Start** (lightning bolt, button 1) at the far left of the toolbar.
3. The dialog asks for five values. Default: `4, n, n, j, j` = 4 mono sources, no HOA_FX track, no HOA_Reverb, decoder yes, binaural yes. Confirm with **OK**. The dialog remembers the last values.
4. This creates `Src_01` to `Src_04`, `Ambi_Encoder_64`, `HOA_MASTER`, a decoder and a binaural track, fully routed with 64 channels. With `y` for *HOA_FX* you also get an effect track (IEM SceneRotator, MultiEQ); with `y` for *HOA_Reverb* a track with IEM FdnReverb, in parallel between the encoder (or HOA_FX) and `HOA_MASTER`.
5. Insert a mono audio file on `Src_01`, play and move the source in the AmbiEncoder_64. Headphones via the binaural track, loudspeakers via the decoder.

![Signal flow after Quick Start](/images/reaper-bundle-routing-en.svg)

*What Quick Start creates: sources into the encoder, optionally via HOA_FX and HOA_Reverb into HOA_MASTER, then to decoder and binaural.*

In all yes/no fields, `j`, `ja`, `y`, `yes` and `1` count as yes (from 1.1.2; before, only `j` counted).

### Option B: Step by step

1. New track, insert a mono audio file. Click **Encoder 64** on the track.
2. Click **Decoder** for loudspeakers or **Binaural** for headphones.
3. Optional: **HOA FX**.
4. Click **Auto-Route**. The dialog asks whether to sort the tracks and whether HOA_FX is inserted serially (`s`) or in parallel (`p`). The sends take the channel count of the tracks (64 for the AmbiEncoder_64). With sorting, the tracks end up in the order player, sources, encoder, HOA_FX, HOA_Reverb, `HOA_MASTER`, decoder, binaural; other tracks follow at the end.
5. Play and move the source in the encoder.

For recorded movements use [Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/), [Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) or Spat Motion Automation. **Animator** (button 16) starts the Animator Choreographer.

## Toolbar and scripts

Scripts ask for the Ambisonics order (1, 3, 5 or 7, that is 4, 16, 36 or 64 channels) and colour the tracks per effect.

| Button | Function |
|---|---|
| Quick Start (1) | Creates a whole session (sources, encoder, optional HOA FX and HOA_Reverb, decoder, binaural) and routes it |
| B-Format Player, Encoder 64, Encoder (2–4) | Create player and encoder tracks |
| HOA Master, Mono Sources (6–7) | Bus track `HOA_MASTER`; mono source tracks routed into the AmbiEncoder_64 |
| HOA FX (5) | Effect track with IEM effects (SceneRotator, MultiEQ, FdnReverb, DualDelay and others), chosen from a menu |
| Decoder, Binaural (8–9) | Loudspeaker decoder, IEM BinauralDecoder (up to 7th order); the Binaural script uses dearVR AMBI MICRO only if dearVR is installed |
| Auto-Route (10) | Detects tracks, creates all sends and sorts the tracks on request |
| Motion Map GUI, Kristall Motion Map, Spat Motion Automation (11, 12, 15) | Movement shapes and automation |
| [Motion Markers GUI](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/), CSV import (13–14) | Movement between markers via OSC, recorded as automation |
| Animator buttons (16–20) | Open the [Choreographer](/post/icst-animator-choreographer/), region navigation, encoder tracks, CSV export |
| Documentation (21) | Opens the offline manual |

![The ICST Ambi REAPER toolbar with its 21 buttons in functional groups](/images/reaper-bundle-toolbar-en.svg)

*The toolbar with its 21 buttons, numbered from left to right. The numbers match the offline manual.*

## Troubleshooting

| Problem | Solution |
|---|---|
| Plugins do not appear (macOS) | Quit REAPER and restart it with `ICST_Ambi_Reaper starten.command`; otherwise *Re-scan* or *Clear cache and re-scan*. For the ZIP, run `run-me-before-install.command` again first |
| Toolbar is empty | Check *Floating toolbar 1*; `reaper-menu.ini` and `reaper-kb.ini` must be in the resource folder |
| Script reports a missing `JS_…` function | Install js_ReaScriptAPI (Windows) or check `UserPlugins` (macOS) |
| Motion tools: "python3 not found" | Install Python 3 and `python3 -m pip install python-osc` |
| Auto-Route misses a track | The track needs a recognisable plugin or "Player" in its name |
| Auto-Route does not sort, Quick Start does not create HOA_FX or HOA_Reverb | Up to 1.1.1 only `j` counted as yes; `y` was taken as no. Update to 1.1.2 (see Updating) |

## Licence

The bundle's **own ICST content** (ReaScripts, JSFX, toolbar icons, configuration and documentation) is licensed under the **GNU General Public License, version 3 or later (GPL-3.0-or-later)**. The licence text is included as the file `LICENSE` in the folder.

The bundled binaries (plugins, extensions, Animator Choreographer) are not covered by it: each component keeps its own licence, and the bundle only combines them into a single download. An overview is in the file `THIRD_PARTY_LICENSES.md` in the folder and in the table below.

## Third-party components

| Component | Licence | Note |
|---|---|---|
| [IEM Plug-in Suite](https://plugins.iem.at/) (BinauralDecoder, HOA FX) | GPL3 | The Binaural button uses the IEM BinauralDecoder; breaking changes from v1.16.0, check templates before updating |
| [SWS/S&M Extension](https://www.sws-extension.org) | MIT | Install manually on Windows; the licence text is in the `licenses/` folder |
| [ReaPack](https://reapack.com) | LGPL-3.0 | Install manually on Windows |
| [js_ReaScriptAPI](https://github.com/juliansader/ReaExtensions) | MIT | Install manually on Windows |
| Animator Choreographer | GPL-3.0 | In the folder `Animator/`; toolbar button 16 starts it |

## See also

- [Quick Start: ICST Ambisonics Plugins in REAPER](/icst-ambisonics-plugins/04_quick_start/)
- [Installation](/icst-ambisonics-plugins/02_installation/)
- [Downloads](/icst-ambisonics-plugins/08_downloads/)
- [ICST Ambi Reaper online manual](/icst-ambisonics-plugins/19_icst_ambi_reaper/docs/)
- [ICST Ambisonics EcoSystem](/ecosystem/)
