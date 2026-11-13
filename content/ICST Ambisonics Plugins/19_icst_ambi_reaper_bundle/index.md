---
title: ICST Ambi REAPER Bundle
date: 2026-11-12T00:00:00
weight: 35
draft: false
toc: true
translationKey: ambi-reaper-bundle
description: "The ICST Ambi REAPER Bundle (ICST_Ambi_Reaper): a portable, preconfigured REAPER folder with toolbar, Lua scripts, VST3 plugins and documentation for working with the ICST Ambisonics Plugins and the Animator Choreographer."
---

Level: Beginner | Audience: Composer, sound designer, student, technician.

The **ICST Ambi REAPER Bundle** (`ICST_Ambi_Reaper`) is a portable REAPER folder that is already set up for the ICST Ambisonics Plugins. With one click on the toolbar you create Ambisonics tracks (orders 1 to 7), route them, move sources and decode. It is the preconfigured entry point into REAPER within the [ICST Ambisonics EcoSystem](/ecosystem/).

{{< notice warning >}}
Draft. The macOS version is complete. The Windows version is beta and has not been tested yet. REAPER itself is not included for licence reasons. The ICST's own content is licensed under GPL-3.0-or-later; third-party components keep their own licences (see below).
{{< /notice >}}

## What it contains

- A REAPER resource folder with the toolbar *ICST_Ambi_Automation* and icons for the ICST tools
- Lua scripts for spatial workflows: track creation, auto-routing, motion, markers, Animator
- ICST and IEM plugins as VST3 (AmbiEncoder, AmbiEncoder_64, AmbiDecoder, IEM BinauralDecoder)
- SWS, js_ReaScriptAPI and ReaPack (macOS, Apple Silicon)
- An offline manual (`Docs/index.html`)
- The [Animator Choreographer](/post/icst-animator-choreographer/) app (`Animator/`)

## Requirements

| Item | macOS | Windows |
|---|---|---|
| Status | Complete | Beta, untested |
| System | macOS 12 or newer, Apple Silicon recommended | Windows 10/11 (64 bit) |
| REAPER | Version 7 (tested with 7.85), not included | Version 7 (64 bit), portable install |
| Plugins | In the folder (`Effects/VST3`) | Installers needed |
| Python 3 | Optional, for Motion Map, [Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) and Kristall Motion Map | Same, from python.org |
| Plugin format | VST3 (not AU) | VST3 |

## Download

The downloads will appear as a GitHub release in the repository `joambi/ICST_Ambi_Reaper` once the release is published. These files are planned:

- `ICST_Ambi_Reaper_<Version>_macOS.pkg`: installer to `/Applications/ICST_Ambi_Reaper`
- `ICST_Ambi_Reaper_<Version>_macOS.zip`: portable, for example for an external SSD
- `ICST_Ambi_Reaper_<Version>_scripts-only.zip`: only the platform-neutral parts (for Windows)

<!-- TODO release: insert the current version number once the release is published. -->

## Installation on macOS

1. **Copy the folder** to a fixed place (external SSD or `~/Music`). Spaces in the path are fine.
2. **Add REAPER.app.** If `REAPER.app` is not in the folder, download it from [reaper.fm](https://www.reaper.fm) (same major version) and put it **into the folder** next to `reaper.ini`.
3. **Run the setup script:** right-click `run-me-before-install.command` → *Open*. It removes the macOS quarantine flag and sets the plugin path. Run it again after every move of the folder.
4. **Start REAPER from the folder.** If macOS warns: right-click the app → *Open*. Check: *Options → Show REAPER resource path* must point to `ICST_Ambi_Reaper`.
5. **Scan plugins:** *Options → Preferences → Plug-ins → VST*, path ends in `Effects/VST3`, click *Re-scan*.
6. **Show the toolbar:** *View → Toolbars → Floating toolbar 1*.

With the `.pkg` installer, steps 1 to 3 are done for you. An unsigned PKG opens with right-click → *Open*.

{{< notice info >}}
Do not install twice: if the same plugins also sit in `/Library/Audio/Plug-Ins/VST3`, REAPER may load the old copy. Use either the folder or the system installers.
{{< /notice >}}

## Installation on Windows (beta)

The folder is a macOS bundle, so only the platform-neutral parts are used on Windows:

1. Install REAPER as a **portable install** (for example `C:\ICST_Ambi_Reaper`), start it once and close it.
2. Install SWS and ReaPack, then **js_ReaScriptAPI** through ReaPack.
3. Copy `Scripts\ICST`, `Data\toolbar_icons`, `Docs`, `OSC`, `ICST_Player_Presets`, `reaper-menu.ini` and `reaper-kb.ini` from the *scripts-only* zip into that folder.
4. Install the plugins with their installers (ICST packages, AmbiEncoder/AmbiDecoder from [ambisonics.ch](/icst-ambisonics-plugins/02_installation/), [IEM Plug-in Suite](https://plugins.iem.at)).
5. Start REAPER, *Re-scan* the VST plugins, show *Floating toolbar 1*.

## First run (10 minutes)

1. New track, insert a mono audio file. Click **Encoder 64** on the track.
2. Click **Decoder** for loudspeakers or **Binaural** for headphones.
3. Optional: **HOA Reverb**.
4. Click **Auto-Route**: the 16-channel sends source → reverb → decoder/binaural are created.
5. Play and move the source in the encoder. For recorded movements use [Motion Map](/icst-ambisonics-plugins/15_icst_ambi_motion_map/), [Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) or Spat Motion Automation.

## Toolbar and scripts

Scripts ask for the Ambisonics order (1, 3, 5 or 7, that is 4, 16, 36 or 64 channels) and colour the tracks per effect.

| Button | Function |
|---|---|
| B-Format Player, Encoder 64, Encoder | Create player and encoder tracks |
| HOA FX | Effect track with IEM effects |
| Decoder, Binaural | Loudspeaker decoder, IEM BinauralDecoder (up to 7th order); the Binaural script uses dearVR AMBI MICRO only if dearVR is installed |
| Auto-Route | Detects tracks and creates all sends |
| Motion Map GUI, Kristall Motion Map, Spat Motion Automation | Movement shapes and automation |
| [Motion Markers GUI](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/), CSV import | Movement between markers via OSC, recorded as automation |
| Animator buttons | Open the [Choreographer](/post/icst-animator-choreographer/), region navigation, encoder tracks, CSV export |
| Documentation | Opens the offline manual |

<!-- TODO release: add a screenshot of the toolbar. -->

## Troubleshooting

| Problem | Solution |
|---|---|
| Plugins do not appear (macOS) | Run `run-me-before-install.command` again, start REAPER from the folder, *Re-scan* |
| Toolbar is empty | Check *Floating toolbar 1*; `reaper-menu.ini` and `reaper-kb.ini` must be in the resource folder |
| Script reports a missing `JS_…` function | Install js_ReaScriptAPI (Windows) or check `UserPlugins` (macOS) |
| Motion tools: "python3 not found" | Install Python 3 and `python3 -m pip install python-osc` |
| Auto-Route misses a track | The track needs a recognisable plugin or "Player" in its name |

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

## See also

- [Quick Start: ICST Ambisonics Plugins in REAPER](/icst-ambisonics-plugins/04_quick_start/)
- [Installation](/icst-ambisonics-plugins/02_installation/)
- [Downloads](/icst-ambisonics-plugins/08_downloads/)
- [ICST Ambisonics EcoSystem](/ecosystem/)
