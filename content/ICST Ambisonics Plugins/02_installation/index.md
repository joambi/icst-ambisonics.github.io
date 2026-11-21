---
date: 2025-02-02T04:14:54-08:00
draft: false
title: Installation
description: "Install guide for the ICST Ambisonics Plugins on macOS and Windows, including REAPER dependencies, file locations, and first troubleshooting checks."
params:
  author: Johannes Schuett
weight: 30
tags:
docs_nav_group: "Getting started"
---

Level: Beginner | Audience: Composer, technician, student, studio user.

Use this page when you want a clean plugin installation before opening templates or building a REAPER session from scratch.

> **Shortcut:** If you would rather not set up REAPER yourself, the [ICST Ambi REAPER Bundle](/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/) is a portable, preconfigured REAPER folder with toolbar, scripts and plugins already in place.

## Before you start

For a reliable installation, make sure you have:

- a current version of **REAPER**
- the **SWS / S&M extension**
- **ReaPack**
- access to the current ICST plugin release package

Recommended next step after installation:

- [Quick Start](/icst-ambisonics-plugins/04_quick_start/) for the fastest first session
- [Step by Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/) if you want to build the routing manually

## Install on macOS

1. Download **REAPER** for Apple Silicon or Intel from [reaper.fm](https://www.reaper.fm/).
2. Install and open REAPER once.
3. Close REAPER again.
4. Install the **SWS / S&M extension** from <https://www.sws-extension.org/>.
5. Install **ReaPack** from <https://reapack.com/>.
6. Follow the ReaPack installation guide: <https://reapack.com/user-guide#installation>
7. Download the current ICST Ambisonics Plugins release from <https://github.com/schweizerweb/icst-ambisonics-plugins/releases>.
8. Run the macOS installer.

![installer](installer.gif)

## Install on Windows

1. Download **REAPER** for Windows from [reaper.fm](https://www.reaper.fm/).
2. Install and open REAPER once.
3. Close REAPER again.
4. Install the **SWS / S&M extension** from <https://www.sws-extension.org/>.
5. Install **ReaPack** from <https://reapack.com/>.
6. Follow the ReaPack installation guide: <https://reapack.com/user-guide#installation>
7. Download the current ICST Ambisonics Plugins release from <https://github.com/schweizerweb/icst-ambisonics-plugins/releases>.
8. Download and run `ICST_AmbiPlugins_Windows_4.0.0.exe` (or the newest installer). The “Full installation” sets up the VST3 and LV2 plugins plus the REAPER project and track templates. Follow the steps below.

> **Note:** The screenshots show the Windows installer version 4.0.0 (the installer itself is in English). Newer versions may differ slightly in wording.

<style>
.win-shots { display:flex; flex-wrap:wrap; gap:1.2rem; align-items:flex-start; margin:1.2rem 0 }
.win-shots p { margin:0; width:320px; max-width:100% }
.win-shots em { display:block; font-size:1.3rem; opacity:.85; margin-top:.4rem }
.win-shots img { width:320px; max-width:100%; height:auto; border-radius:6px }
</style>

<div class="win-shots">

![SmartScreen: Windows protected your PC](01_win.jpg)
*1. SmartScreen warns about an unknown publisher: click “Run anyway”. If only “More info” is shown, click that first.*

![User Account Control prompt](02_win.jpg)
*2. Confirm the User Account Control prompt with “Yes”.*

![Installer readme page](03_win.jpg)
*3. Read the notes and click “Next”.*

![Destination folder: Common Files](04_win.jpg)
*4. Keep the destination folder (Common Files) and click “Next”.*

![Select components](05_win.jpg)
*5. Choose “Full installation” (LV2, VST3, REAPER project and track templates) and click “Next”.*

![Ready to install](06_win.jpg)
*6. Check the summary and click “Install”.*

![Installation in progress](07_win.jpg)
*7. Wait until the installation has finished.*

</div>

## Installed files and folders

Typical installation targets:

- `/Library/Audio/Plugins/VST3`
- `/Library/Audio/Plugins/Components`
- `/Library/Audio/Plugins/LV2` (experimental)
- `Users/Shared/AmbiPluginsTemp/ProjectTemplates`
- `Users/Shared/AmbiPluginsTemplatesTemp/TrackTemplates`

Templates usually include:

- `ICST_AmbiPlugins_MonoEncoder.RPP`
- `ICST_AmbiPlugins_MultiEncoder.RPP`
- `ICST_AmbiPlugins`
- `ICST_AmbiPlugins_3rdParty`

## If the plugins do not appear

Check these points first:

- REAPER has been restarted after installation.
- The **SWS** extension is installed correctly.
- **ReaPack** is installed correctly.
- The plugin files were placed in the expected VST3 / AU / LV2 directories.
- The ICST plugins appear in the REAPER **FX Browser** after a plugin rescan.

If the templates are missing, also check the shared template folders listed above.

## Related references

- Project wiki: <https://github.com/schweizerweb/icst-ambisonics-plugins/wiki>
**Installation video: ICST Ambisonics Plugins – 01 – How to Install**

{{< youtube 2GXb5tbqW1Y >}}

## Next step

- [Quick Start](/icst-ambisonics-plugins/04_quick_start/)
- [Step by Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/)
