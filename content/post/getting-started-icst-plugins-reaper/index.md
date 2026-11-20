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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 175" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Signal chain in REAPER: sources with AmbiEncoder feed the 64-channel Bformat-Master, which goes to the decoder for speakers and to a binaural track for headphones." xmlns="http://www.w3.org/2000/svg"><defs><marker id="ah1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="30" width="150" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="85.0" y="54.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Source 1</text><text x="85.0" y="70.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">+ AmbiEncoder</text><rect x="10" y="100" width="150" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="85.0" y="124.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Source 2</text><text x="85.0" y="140.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">+ AmbiEncoder</text><line x1="162" y1="56" x2="238" y2="86" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><line x1="162" y1="126" x2="238" y2="100" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><rect x="240" y="63" width="150" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="315.0" y="89.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Bformat-Master</text><text x="315.0" y="105.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">64 channels</text><line x1="392" y1="80" x2="478" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><line x1="392" y1="102" x2="478" y2="126" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><rect x="480" y="30" width="130" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="545" y="54.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Decoder</text><text x="545" y="70.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">speaker preset</text><line x1="612" y1="56" x2="636" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><text x="642" y="60" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Speakers</text><rect x="480" y="100" width="130" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="545" y="124.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Binaural track</text><text x="545" y="140.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Decoder (binaural)</text><line x1="612" y1="126" x2="636" y2="126" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah1)"/><text x="642" y="130" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Headphones</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">The session structure from steps 1 to 4: every source gets its own AmbiEncoder, all feed one B-format bus, decoding happens once at the output.</figcaption>
</figure>

## Shortcut: start from a project template
If you want to skip the setup, open `ICST_AmbiPlugins_MonoEncoder.RPP` (installed with the plugins). It already contains one encoder track, the 64-channel `Bformat-Master` and the decoder, so steps 1 and 2 are done. Start at step 3 and use the checks of steps 1 and 2 as a quick sanity test. See [Track Templates](/icst-ambisonics-plugins/05_open_track_templates/) for all templates.

## Prerequisites
- Reaper and the ICST Ambisonics Plugins are installed ([Installation](/icst-ambisonics-plugins/02_installation/)).
- Recommended: SWS and ReaPack (extensions for scripts and updates inside REAPER).
- Audio interface with a suitable I/O configuration. For the first session, headphones are enough; a loudspeaker array is not required.
- Basic knowledge of tracks, buses and plugin inserts.
- Rule for the whole session: use **64 channels** on all Ambisonics tracks and check the routing after each step. 64 channels hold up to 7th order; lower orders simply use fewer of them (see [Which Ambisonics Order Do I Need?](/post/hoa-ordnung-wahl-praxis/)).

## Step 1 - Monitoring backbone
Create a new session, set the sample rate and create the track `Bformat-Master` (64 channels). Insert the decoder on the monitoring path and choose the speaker preset.

**Check (about 5 minutes):** in the decoder use *test all speakers*. Each loudspeaker should sound in turn, in the position and order you expect. If not, fix the preset before going on.

- Docs: [Quick Start](/icst-ambisonics-plugins/04_quick_start/), [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/), [Track Templates](/icst-ambisonics-plugins/05_open_track_templates/)

## Step 2 - Add a source
Add one source track with the AmbiEncoder and route its output to `Bformat-Master`. Check the channel assignment in the routing window.

**Check (about 5 minutes):** play a mono test sound. With the encoder at the front you should hear it in front, and the meter of `Bformat-Master` should move. No signal there means the routing is broken.

- Docs: [How it Works](/icst-ambisonics-plugins/03_how_it_works/), [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)

## Step 3 - Move the source in space
Move the source in X/Y/Z, watch it in the radar view and save a preset. Then record a short motion pass: set the encoder position parameters to *Write* or *Touch* automation, move the source while the project plays, then stop.

**Check (about 5 minutes):** play the section again without touching anything. The source should repeat your movement. For markers and scripted motion see [ICST Ambi Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/).

## Step 4 - Binaural check
Add a binaural path in parallel for headphone monitoring and run a short level and listening test.

Use a binaural decoder such as the free IEM BinauralDecoder or the SPARTA binaural decoder. It sits on a separate track that is fed from `Bformat-Master`, parallel to the speaker decoder. Never let both paths play audibly at the same time. Details: [Binaural Monitoring in the ICST Workflow](/post/binaural-monitoring-icst-workflow/).

**Check (about 5 minutes):** with headphones, the source at the front should be heard in front, and moving it to the left should move it to the left.

## Step 5 - Render
Render from `Bformat-Master` as multichannel and verify the output channels. The detailed render settings are on [Render B-Format in REAPER](/icst-ambisonics-plugins/12_render_bformat/).

**Check (about 5 minutes):** the file has the channel count of your order (64 for the setup above). Import it into a new track and play it through the decoder.

## Common first errors

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 200" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="The same signal chain with four typical error points marked: source not routed, track without 64 channels, wrong decoder preset, binaural track fed from the wrong source." xmlns="http://www.w3.org/2000/svg"><defs><marker id="ah2" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="30" width="150" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="85.0" y="54.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Source 1</text><text x="85.0" y="70.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">+ AmbiEncoder</text><rect x="10" y="100" width="150" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="85.0" y="124.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Source 2</text><text x="85.0" y="140.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">+ AmbiEncoder</text><line x1="162" y1="56" x2="238" y2="86" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><line x1="162" y1="126" x2="238" y2="100" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><rect x="240" y="63" width="150" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="315.0" y="89.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Bformat-Master</text><text x="315.0" y="105.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">64 channels</text><line x1="392" y1="80" x2="478" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><line x1="392" y1="102" x2="478" y2="126" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><rect x="480" y="30" width="130" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="545" y="54.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Decoder</text><text x="545" y="70.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">speaker preset</text><line x1="612" y1="56" x2="636" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><text x="642" y="60" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Speakers</text><rect x="480" y="100" width="130" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="545" y="124.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Binaural track</text><text x="545" y="140.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Decoder (binaural)</text><line x1="612" y1="126" x2="636" y2="126" stroke="currentColor" stroke-width="1.6" marker-end="url(#ah2)"/><text x="642" y="130" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Headphones</text><circle cx="200" cy="55" r="11" fill="#d9534f"/><text x="200" y="60" text-anchor="middle" font-size="13" font-weight="700" fill="#fff" fill-opacity="1">1</text><circle cx="395" cy="60" r="11" fill="#d9534f"/><text x="395" y="65" text-anchor="middle" font-size="13" font-weight="700" fill="#fff" fill-opacity="1">2</text><circle cx="616" cy="28" r="11" fill="#d9534f"/><text x="616" y="33" text-anchor="middle" font-size="13" font-weight="700" fill="#fff" fill-opacity="1">3</text><circle cx="616" cy="98" r="11" fill="#d9534f"/><text x="616" y="103" text-anchor="middle" font-size="13" font-weight="700" fill="#fff" fill-opacity="1">4</text><text x="360" y="185" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.85">1 source not routed  ·  2 track is not 64 channels  ·  3 wrong decoder preset  ·  4 binaural fed from wrong source</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Where the first session usually breaks.</figcaption>
</figure>

- Source not routed to `Bformat-Master`; the chain `Source -> Bformat-Master -> Decoder` is broken. *Fix:* check the track routing and the channel assignment (step 2).
- A non-64-channel track in the signal path. *Fix:* set every Ambisonics track to 64 channels.
- Wrong decoder preset for the speaker setup. *Fix:* load the matching preset and run *test all speakers* (step 1).
- Binaural track fed from the wrong source. *Fix:* feed it only from `Bformat-Master` (step 4).
- OSC port mismatch when external control is enabled. *Fix:* compare the ports in REAPER, the controller and the plugin; see [OSC and Control](/reference/osc-and-control/).
- No sound at all. *Fix:* mute/solo state, the decoder output routing to your interface, then the master send of `Bformat-Master`.

## Next steps
- [Stereo to HOA7: A Step-by-Step Session](/post/stereo-to-hoa7-session/): a complete project from start to render
- [Which Ambisonics Order Do I Need?](/post/hoa-ordnung-wahl-praxis/)
- [Best Practices](/icst-ambisonics-plugins/17_best_practices/)
- [Ambisonics Workflow](/learn/ambisonics-workflow/): from idea to B-format master, with checklist
- Later: [OSC and Control](/reference/osc-and-control/) and [Ableton Live Integration](/post/ableton_reaper/)
