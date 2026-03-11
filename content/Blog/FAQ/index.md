---
title: "FAQ"
description: "Frequently asked questions about the ICST Ambisonics Plugins, setup, OSC, and common issues."
date: 2026-01-01T00:00:00
weight: 16
draft: false
---

Answers to the most common questions about the ICST Ambisonics Plugins for REAPER and the ICST Ambisonics Tools for Max/MSP.

---

## Installation & Compatibility

**Which REAPER version do the plugins require?**
REAPER 6.0 or higher is recommended. The plugins run on macOS (Intel and Apple Silicon) and Windows 10/11 (64-bit). Linux is not officially supported.

**Do the plugins work on Apple Silicon (M1/M2/M3)?**
Yes — the plugins ship as universal binaries and run natively on Apple Silicon without Rosetta. Make sure you are using REAPER 6.78 or later for full compatibility.

**Where do I install the plugins?**
Copy the `.vst3` (or `.component` for AU on macOS) files to your system VST3 folder, then rescan in REAPER under Options → Preferences → VST. See the [Installation guide](/icst-ambisonics-plugins/02_installation/) for exact paths.

**Why does REAPER not show the plugins after installation?**
Trigger a manual VST rescan: Options → Preferences → Plug-ins → VST → Re-scan. If the plugins still don't appear, verify the plugin files are in the correct folder and are not quarantined by macOS Gatekeeper.

**On macOS, I get a message "Apple cannot verify this developer" — what do I do?**
Open System Settings → Privacy & Security → scroll down and click "Open Anyway" next to the blocked plugin. You may need to do this once per plugin file.

---

## Signal Flow & Setup

**What is the difference between AmbiEncoder and MultiEncoder?**
The AmbiEncoder handles a single mono audio source and positions it in 3D space. The MultiEncoder handles multiple sources simultaneously (up to 36 in v3.2) and is the recommended choice for production sessions.

**I have audio in REAPER but hear nothing through the decoder — what's wrong?**
Check three things in order: (1) the channel count on your B-Format bus must match the order you are working in (e.g. 16 channels for 3rd order HOA), (2) the decoder preset must match your speaker layout, (3) your REAPER output routing must address the correct hardware outputs. The [Step-by-Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/) guide walks through each step.

**How many output channels does third-order HOA need?**
Third-order Ambisonics uses (3+1)² = 16 B-Format channels. Seventh-order uses 64 channels. The encoder and decoder must be set to the same order.

**Can I use the ICST Decoder and REAPER's built-in FX chain together?**
Yes. Place any processing before the decoder on the B-Format bus. Gain, filtering, and reverb all work as expected. Avoid processing that changes channel count downstream of the encoder.

---

## OSC Control

**The OSC encoder does not respond to my messages — what should I check?**
First confirm the correct UDP port is open in REAPER (Extensions → ReaScript or OSC/web). The default ICST listener port is **8000**. Then check that the message path matches the expected syntax — see [OSC Syntax Reference](/post/osc-syntax-for-the-icst-ambiencoder-plugin/).

**What is the minimum OSC message to move a source?**
`/ambi/source/[id]/aed [azimuth] [elevation] [distance]` — where azimuth and elevation are in degrees, distance is a normalised 0–1 value. Source IDs start at 1.

**Can I automate OSC from Ableton Live?**
Yes — use Max for Live MIDI or OSC clips to send control messages, synchronised via LTC. The [Ableton + REAPER bridging tutorial](/post/ableton_reaper/) documents a complete 7th-order workflow.

---

## Binaural & Monitoring

**Can I monitor in binaural without a speaker array?**
Yes. The AmbiDecoder includes a binaural decoding mode using HRTFs. Enable it in the decoder's output section and route to a stereo output. For higher-quality HRTF rendering, the [DearVR integration tutorial](/post/getting-started-icst-plugins-reaper/) covers using a third-party binaural renderer on the decoder output.

**The binaural output sounds mono or collapsed — why?**
Usually caused by a channel count mismatch: the decoder is receiving fewer HOA channels than it expects. Check that the B-Format bus send is set to full multichannel (not summed to stereo).

---

## ICST Ambisonics Tools (Max/MSP)

**Which version of Max is required?**
Max 8.0 or later. The package is available through the Max Package Manager.

**What is the difference between the Plugins and the Tools?**
The Plugins run inside REAPER as VST/AU effects and are designed for session-based, multitrack work. The Tools are Max/MSP externals for live spatialisation, algorithmic composition, and custom patching outside a DAW.

---

## Updates & Versions

**How do I update from v3.1 to v3.2?**
Replace the old plugin files with the new ones from the [GitHub Releases page](https://github.com/schweizerweb/icst-ambisonics-plugins/releases) and rescan in REAPER. Existing sessions will open correctly — no settings migration is required. Check [What's New in v3.2](/icst-ambisonics-plugins/00_new/) for new features.

**Where can I report bugs or request features?**
Open an issue on the [GitHub repository](https://github.com/schweizerweb/icst-ambisonics-plugins/issues). Include your OS version, REAPER version, plugin version, and a minimal reproducible project if possible.
