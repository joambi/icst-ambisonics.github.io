---
title: Getting Started with ICST Ambisonics Plugins in REAPER
description: "A practical starter guide for composers, students, and technicians to set up ICST Ambisonics Plugins in Reaper and complete a first working session."
date: 2026-03-08T14:10:00+01:00
year: 2026
month: 2026-03
weight: 23
tags: ["tutorial", "reaper", "ambiencoder", "getting-started", "workflow"]
key_points:
  - "Build a first working spatial audio session in REAPER in about 30 minutes"
  - "Structured checklist from plugin install to binaural monitoring"
difficulty: "beginner"
post_kind: "tutorial"
tool: ["REAPER", "AmbiEncoder"]
aliases:
  - /post/reaper-setup-20-minuten/
  - /post/ambisonics-in-30-minutes/
---

**Level:** Beginner | **Audience:** Composer, Student, Studio Assistant.

In about 30 minutes you build a working Reaper session: source routing, AmbiEncoder control, B-format bus, decoder and a monitoring check.
This is the short path. The full technical reference is [Step by Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/).

## Prerequisites
- Reaper and the ICST Ambisonics Plugins are installed ([Installation](/icst-ambisonics-plugins/02_installation/)).
- Recommended: SWS and ReaPack.
- Audio interface with a suitable I/O configuration.
- Basic knowledge of tracks, buses and plugin inserts.
- Rule for the whole session: use **64 channels** on all Ambisonics tracks and check the routing after each step.

## Step 1 - Monitoring backbone
Create a new session, set the sample rate and create the track `Bformat-Master` (64 channels). Insert the decoder on the monitoring path and choose the speaker preset.
- Docs: [Quick Start](/icst-ambisonics-plugins/04_quick_start/), [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/), [Track Templates](/icst-ambisonics-plugins/05_open_track_templates/)

## Step 2 - Add a source
Add one source track with the AmbiEncoder and route its output to `Bformat-Master`. Check the channel assignment in the routing window.
- Docs: [How it Works](/icst-ambisonics-plugins/03_how_it_works/), [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)

## Step 3 - Move the source in space
Move the source in X/Y/Z, watch it in the radar view and save a preset. Then record a short motion pass and check that the automation plays back.

## Step 4 - Binaural check
Add a binaural path in parallel for headphone monitoring and run a short level and listening test.

## Step 5 - Render
Render from `Bformat-Master` as multichannel and verify the output channels.

## Common first errors
- Source not routed to `Bformat-Master`; the chain `Source -> Bformat-Master -> Decoder` is broken.
- A non-64-channel track in the signal path.
- Wrong decoder preset for the speaker setup.
- Binaural track fed from the wrong source.
- OSC port mismatch when external control is enabled.

## Next steps
- [OSC Syntax for the ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
- [OSC in ICST AmbiEncoder: The 10 Most Important Messages](/post/osc-10-key-messages/)
- [Stereo to HOA7: A Step-by-Step Session](/post/stereo-to-hoa7-session/)
- [Ableton Live and ICST Ambisonics Integration](/post/ableton_reaper/)
