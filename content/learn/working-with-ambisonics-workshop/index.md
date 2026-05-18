---
title: "ICST Ambisonics Workshop: Working with Ambisonics"
description: "Online workshop: HOA recording with Zylia ZM-1, encoding with ICST AmbiEncoder, FuMa–AmbiX conversion, Reaper workflow and hands-on exercise."
date: 2026-05-03T00:00:00
draft: false
slug: working-with-ambisonics-workshop
tags:
  - ambisonics
  - hoa
  - workshop
  - reaper
  - zylia
  - fuma
  - ambix
---

<style>
/* ══════════════════════════════════════════════════════════════
   WORKSHOP PAGE STYLES — Light + Dark Mode
   ══════════════════════════════════════════════════════════════ */

.post__content > h1 {
  font-size: clamp(2.8rem, 4.2vw, 4.3rem);
  line-height: 1.08; letter-spacing: 0.01em; margin-bottom: 1.5rem;
}
.post__content h2 { font-size: clamp(2rem, 2.6vw, 2.7rem); line-height: 1.18; }
.post__content h3 { font-size: clamp(1.45rem, 1.6vw, 1.8rem); line-height: 1.25; }
.post__content p, .post__content li, .post__content td, .post__content th {
  font-size: 1.55rem; line-height: 1.62;
}
.post__content code { font-size: 0.95em; }

/* Hero */
.ws-hero {
  background: linear-gradient(135deg, #1a2a3a 0%, #2c4a6e 100%);
  border-radius: 10px; padding: 2.1rem 2.25rem 1.95rem;
  color: #fff; margin-bottom: 2rem;
}
.ws-hero__title { font-size: 2.25rem; font-weight: 800; letter-spacing: 0.02em; margin: 0 0 0.3rem 0; }
.ws-hero__subtitle { font-size: 1.45rem; opacity: 0.75; margin: 0 0 1.2rem 0; }
.ws-badges { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 1rem; }
.ws-badge {
  background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.25);
  border-radius: 20px; padding: 0.32rem 0.95rem; font-size: 1.3rem; color: #fff; white-space: nowrap;
  text-decoration: none; display: inline-block;
}
a.ws-badge:hover { background: rgba(255,255,255,0.25); border-color: rgba(255,255,255,0.5); }
.ws-badge--blue   { background: #4a9eda; border-color: #4a9eda; }
.ws-badge--green  { background: #4a9e7a; border-color: #4a9e7a; }
.ws-meta { display: flex; flex-wrap: wrap; gap: 1.5rem; margin-top: 1rem; font-size: 1.38rem; opacity: 0.85; }
.ws-meta span { white-space: nowrap; }
.ws-meta a { color: inherit; text-decoration-color: rgba(255,255,255,0.45); text-underline-offset: 0.18em; }
.ws-meta a:hover { text-decoration-color: rgba(255,255,255,0.9); }

/* Goals */
.ws-goals {
  background: #f0f6ff; border-left: 4px solid #4a9eda;
  border-radius: 0 8px 8px 0; padding: 1.4rem 1.6rem; margin: 1.5rem 0 2rem;
}
.theme--dark .ws-goals { background: #1a2d3d; }
.ws-goals__title { font-weight: 700; font-size: 1.5rem; margin: 0 0 0.8rem; color: #1a2a3a; }
.theme--dark .ws-goals__title { color: #d0e8f7; }
.ws-goals ul { margin: 0; padding-left: 0; list-style: none; }
.ws-goals li { padding: 0.34rem 0 0.34rem 1.9rem; position: relative; font-size: 1.52rem; line-height: 1.5; }
.ws-goals li::before { content: "✓"; position: absolute; left: 0; color: #4a9eda; font-weight: 700; }

/* Block headers */
.ws-block {
  border-top: 3px solid #4a9eda; margin: 2.5rem 0 1.2rem; padding-top: 1rem;
}
.ws-block__head { display: flex; align-items: baseline; flex-wrap: wrap; gap: 0.7rem; margin-bottom: 0.4rem; }
.ws-block__num {
  background: #4a9eda; color: #fff; border-radius: 4px;
  padding: 0.1rem 0.5rem; font-size: 1.12rem; font-weight: 700; letter-spacing: 0.05em; white-space: nowrap;
}
.ws-block__title { font-size: 1.9rem; font-weight: 700; color: #1a2a3a; margin: 0; }
.theme--dark .ws-block__title { color: #d0e8f7; }
.ws-block__meta {
  font-size: 1.35rem; color: #666; margin: 0.2rem 0 1rem;
  display: flex; flex-wrap: wrap; gap: 1rem;
}
.theme--dark .ws-block__meta { color: #7a9ab0; }
.ws-block__meta span::before { content: "· "; }
.ws-block__meta span:first-child::before { content: ""; }

/* Callouts */
.ws-info {
  background: #edf5ff; border: 1px solid #b0d0f0;
  border-left: 4px solid #4a9eda; border-radius: 0 8px 8px 0;
  padding: 0.9rem 1.2rem; margin: 1rem 0 1.4rem;
  font-size: 1.4rem; line-height: 1.6; color: #2c4a6e;
}
.ws-info strong { display: block; font-size: 1.18rem; font-weight: 700; margin-bottom: 0.3rem; color: #1a3a5c; }
.ws-info a { color: #2c72bb; }
.theme--dark .ws-info { background: #0f1f30; border-color: #2a4a6a; border-left-color: #4a9eda; color: #a0c8e8; }
.theme--dark .ws-info strong { color: #7ec8f0; }
.theme--dark .ws-info a { color: #7ec8f0; }

.ws-tip {
  background: #f0faf4; border-left: 4px solid #4a9e7a;
  border-radius: 0 8px 8px 0; padding: 0.9rem 1.2rem; margin: 1rem 0 1.4rem;
  font-size: 1.4rem; line-height: 1.6; color: #1a3a2a;
}
.ws-tip strong { display: block; font-size: 1.18rem; font-weight: 700; margin-bottom: 0.3rem; color: #1a3a2a; }
.theme--dark .ws-tip { background: #0a1f14; border-left-color: #4a9e7a; color: #90d8b0; }
.theme--dark .ws-tip strong { color: #90d8b0; }

/* Figure / image */
.ws-figure {
  margin: 1.6rem 0; border-radius: 8px; overflow: hidden;
  border: 1px solid #d0e4f7;
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}
.ws-figure img { width: 100%; height: auto; display: block; }
.ws-figure figcaption {
  background: #f0f6ff; padding: 0.55rem 1rem;
  font-size: 1.28rem; color: #666; border-top: 1px solid #d0e4f7;
  font-style: italic;
}
.theme--dark .ws-figure { border-color: #2a4560; }
.theme--dark .ws-figure figcaption { background: #0f1f30; color: #7a9ab0; border-top-color: #2a4560; }

/* Navigation / TOC */
.ws-nav {
  display: grid; grid-template-columns: repeat(auto-fit, minmax(170px, 1fr));
  gap: 0.6rem; margin: 1.2rem 0 2rem;
}
.ws-nav-item {
  background: #f5f9ff; border: 1px solid #d0e4f7; border-radius: 7px;
  padding: 0.65rem 0.9rem; text-decoration: none; color: #2c4a6e;
  font-size: 1.32rem; display: flex; gap: 0.55rem; align-items: baseline;
  transition: background 0.15s;
}
.ws-nav-item:hover { background: #e0eefa; text-decoration: none; }
.ws-nav-ltr { font-weight: 700; color: #4a9eda; font-size: 1.25rem; }
.theme--dark .ws-nav-item { background: #1a2d3d; border-color: #2a4560; color: #7ec8f0; }
.theme--dark .ws-nav-item:hover { background: #1e3548; }
.theme--dark .ws-nav-ltr { color: #7ec8f0; }

/* Steps / numbered list */
.ws-steps { counter-reset: ws-step; padding: 0; list-style: none; margin: 1rem 0 1.5rem; }
.ws-steps li {
  counter-increment: ws-step;
  padding: 0.55rem 0 0.55rem 2.8rem; position: relative;
  font-size: 1.52rem; line-height: 1.55; border-bottom: 1px solid #e8eef5;
}
.theme--dark .ws-steps li { border-bottom-color: #2a3d4f; }
.ws-steps li:last-child { border-bottom: none; }
.ws-steps li::before {
  content: counter(ws-step);
  position: absolute; left: 0; top: 0.5rem;
  background: #4a9eda; color: #fff; border-radius: 50%;
  width: 1.8rem; height: 1.8rem; font-size: 1.15rem; font-weight: 700;
  display: flex; align-items: center; justify-content: center;
}

/* Resources */
.ws-resources {
  display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 0.8rem; margin: 1rem 0;
}
.ws-resource-link {
  display: block; background: #f5f9ff; border: 1px solid #d0e4f7;
  border-radius: 7px; padding: 0.7rem 1rem; text-decoration: none;
  font-size: 1.35rem; color: #2c4a6e; transition: background 0.15s;
}
.ws-resource-link:hover { background: #e0eefa; text-decoration: none; }
.ws-resource-link strong { display: block; font-size: 1.18rem; color: #888; font-weight: 400; }
.theme--dark .ws-resource-link { background: #1a2d3d; border-color: #2a4560; color: #7ec8f0; }
.theme--dark .ws-resource-link:hover { background: #1e3548; }
.theme--dark .ws-resource-link strong { color: #7a9ab0; }
.ws-resource-link--featured { background: #e8f4fd; border-color: #4a9eda; border-width: 2px; font-weight: 700; color: #1a5c8a; }
.ws-resource-link--featured:hover { background: #d0eaf8; }
.theme--dark .ws-resource-link--featured { background: #0d2236; border-color: #4a9eda; color: #7ec8f0; }
.theme--dark .ws-resource-link--featured:hover { background: #112a40; }

/* Schedule table */
.ws-schedule {
  width: 100%; border-collapse: collapse; font-size: 1.45rem;
  margin: 1.2rem 0 2rem; border-radius: 8px; overflow: hidden;
  box-shadow: 0 1px 4px rgba(0,0,0,0.1);
}
.ws-schedule th { background: #2c4a6e; color: #fff; padding: 0.72rem 1.05rem; text-align: left; font-weight: 600; }
.ws-schedule td { padding: 0.7rem 1.05rem; border-bottom: 1px solid #e8eef5; vertical-align: middle; }
.theme--dark .ws-schedule td { border-bottom-color: #2a3d4f; }
.ws-schedule tr:last-child td { border-bottom: none; }
.ws-schedule tr.ws-block-row { background: #f5f9ff; }
.ws-schedule tr.ws-block-row td:first-child { font-weight: 600; color: #2c4a6e; }
.theme--dark .ws-schedule tr.ws-block-row { background: #1a2d3d; }
.theme--dark .ws-schedule tr.ws-block-row td:first-child { color: #7ec8f0; }
</style>

<div class="ws-hero">
  <p class="ws-hero__title">Working with Ambisonics</p>
  <p class="ws-hero__subtitle">Online-Workshop · ICST / ZHdK · ambisonics.ch</p>
  <div class="ws-badges">
    <span class="ws-badge ws-badge--blue">Online Course</span>
    <span class="ws-badge ws-badge--green">Self-paced</span>
    <a class="ws-badge" href="https://www.zylia.co" target="_blank" rel="noopener">Zylia ZM-1</a>
    <a class="ws-badge" href="https://ambisonics.ch/start/" target="_blank" rel="noopener">ICST Plugins</a>
    <a class="ws-badge" href="/learn/ambisonics-formats/">HOA 3rd Order</a>
    <a class="ws-badge" href="https://www.reaper.fm" target="_blank" rel="noopener">Reaper pre-installed</a>
  </div>
  <div class="ws-meta">
    <span>🎛️ <a href="https://www.reaper.fm" target="_blank" rel="noopener">REAPER</a> + <a href="https://ambisonics.ch/start/" target="_blank" rel="noopener">ICST AmbiEncoder/Decoder</a></span>
    <span>🎙️ <a href="https://www.zylia.co" target="_blank" rel="noopener">Zylia ZM-1</a> (16-channel HOA)</span>
    <span>🔄 <a href="/learn/ambisonics-formats/">FuMa ↔ AmbiX Conversion</a></span>
  </div>
</div>

---

## Learning Objectives

<div class="ws-goals">
<p class="ws-goals__title">After this workshop you will be able to:</p>
<ul>
<li>explain the Ambisonics signal flow from recording to playback</li>
<li>distinguish A-format (PCM audio) from B-format (mathematical format)</li>
<li>set up and route a Zylia ZM-1 HOA recording in Reaper</li>
<li>position sound sources in three-dimensional space using the ICST AmbiEncoder_64</li>
<li>convert FOA/HOA material between FuMa and AmbiX formats</li>
<li>carry out a guided hands-on exercise (Encoding → Mixing → Decoding) independently</li>
<li>integrate external tools (MaxMSP, Csound/Cabbage) into an Ambisonics workflow</li>
</ul>
</div>

<div class="ws-info">
<strong>📋 Preparation</strong>
Reaper is pre-installed on all workshop computers (v7+, incl. ICST plugins) · Bring headphones (binaural monitoring) · <a href="https://e.pcloud.link/publink/show?code=XZAeJrZH78kTyE16GyaO0aFzw3kdhpvNeYk" target="_blank" rel="noopener">Download the large workshop package</a> (Reaper folder + papers) in advance
</div>

---

## Contents

<div class="ws-nav">
  <a class="ws-nav-item" href="#block-a"><span class="ws-nav-ltr">A</span> Overall Workflow</a>
  <a class="ws-nav-item" href="#block-b"><span class="ws-nav-ltr">B</span> Recording</a>
  <a class="ws-nav-item" href="#block-c"><span class="ws-nav-ltr">C</span> Reaper Workflow</a>
  <a class="ws-nav-item" href="#block-d"><span class="ws-nav-ltr">D</span> External Tools</a>
  <a class="ws-nav-item" href="#block-e"><span class="ws-nav-ltr">E</span> Csound</a>
  <a class="ws-nav-item" href="#block-f"><span class="ws-nav-ltr">F</span> MaxMSP</a>
  <a class="ws-nav-item" href="#block-g"><span class="ws-nav-ltr">G</span> Discussion</a>
</div>

---

<div class="ws-block" id="block-a">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK A</span>
  <h2 class="ws-block__title">Overall Workflow</h2>
</div>
<div class="ws-block__meta">
  <span>Signal Flow</span><span>Formats</span><span>HOA Orders</span>
</div>
</div>

Ambisonics is a channel-format-independent, full-sphere audio system. Every production follows the same chain — regardless of whether the target is headphones, an 8-channel ring, or a 24-channel dome.

### The Ambisonics Signal Flow

<figure class="ws-figure">
  <img src="/images/workshop/diagram-overall-workflow.png" alt="Ambisonics Overall Workflow: Recording → HOA Bus → B-Format Master / Binaural / Array" loading="lazy">
  <figcaption>Ambisonics signal flow: From recording (A-format → B-format ambiX) through the HOA bus and production to the three output formats — B-format master, binaural stereo, and array/live.</figcaption>
</figure>

| Step | What happens | Tool (Workshop) |
|---|---|---|
| **1. Recording** | Microphone array → A-format (raw capsules) or direct HOA | Zylia ZM-1 → Zylia App |
| **2. A-to-B Conversion** | Raw capsule data → B-format (AmbiX / HOA) | Zylia App, JS plugin |
| **3. Encoding** | Position mono/stereo sources in space | ICST AmbiEncoder_64 |
| **4. Processing** | EQ, reverb, panning on the HOA bus | Reaper FX chain |
| **5. Decoding** | B-format → playback format | ICST AmbiDecoder |
| **6. Delivery** | Render master, choose format | Reaper Render |

**The golden rule:** Render the B-format master track — never the decoder output. The decoder is for monitoring only. One and the same B-format master works for headphones, loudspeakers, and streaming.

<div class="ws-info">
<strong>📖 Further reading: Ambisonics Fundamentals</strong>
→ <a href="/post/ambisonics-in-30-minutes/">Ambisonics in 30 Minutes</a> — compact overview of the system<br>
→ <a href="/learn/ambisonics-workflow/">Workflow from Recording to Delivery</a> — in-depth step-by-step guide<br>
→ <a href="/post/getting-started-icst-plugins-reaper/">Getting Started: ICST Plugins in Reaper</a> — introduction to the plugin chain
</div>

### Monitoring Setup

Before recording starts, monitoring must be in place:

- **Binaural (headphones):** Load ICST AmbiDecoder with HRTF preset → direct spatial feedback without loudspeakers
- **Check decoder preset:** Does the layout (channel count, speaker geometry) match the actual setup?
- **Never run binaural and loudspeakers in parallel:** Only one decoder active — otherwise phase errors in the mix
- **Separate monitoring branch:** Binaural monitor track on a dedicated bus, not looped into the B-format master

<div class="ws-info">
<strong>📖 Further reading: Binaural Monitoring</strong>
→ <a href="/post/binaural-monitoring-icst-workflow/">Binaural Monitoring in the ICST Workflow</a> — HRTF setup, decoder presets, monitoring practice
</div>

### Formats & Normalisation

| Format | Channel order | Normalisation | Status |
|---|---|---|---|
| **FuMa** (Furse-Malham) | W, X, Y, Z | MaxN | Older, legacy |
| **AmbiX** (ACN / SN3D) | W, Y, Z, X | SN3D | Current standard |

**Rule of thumb:** Always work and archive in AmbiX (ACN/SN3D). Use FuMa only for compatibility with legacy material.

| HOA Order | Channels | Microphone example | Spatial resolution |
|---|---|---|---|
| 1st Order (FOA) | 4 | Zoom H3-VR, Sennheiser Ambeo | Good as stereo replacement, coarse directionality |
| 2nd Order | 9 | — | Significantly sharper localisation |
| 3rd Order | 16 | Zylia ZM-1 | High resolution, production reference |

<div class="ws-info">
<strong>📖 Further reading: Formats & Orders</strong>
→ <a href="/learn/ambisonics-formats/">Ambisonics Formats Explained</a> — FuMa, AmbiX, ACN, SN3D in detail<br>
→ <a href="/post/hoa-ordnung-wahl-praxis/">Which Ambisonics Order Do I Need?</a> — practical decision guide
</div>

### Delivery Formats

| Target | Format | Note |
|---|---|---|
| **Archive / Master** | Multichannel WAV, AmbiX, 48 kHz / 32-bit float | Unaltered B-format master |
| **Binaural** | 2-channel WAV | Streaming, preview, headphones |
| **Loudspeakers** | N-channel WAV | Performance, installation |
| **YouTube 360** | Binaural + Spatial Metadata | Spatial Media Metadata Tool |

<div class="ws-info">
<strong>📖 Further reading: Exporting B-Format</strong>
→ <a href="/icst-ambisonics-plugins/12_render_bformat/">Render B-Format in REAPER</a> — step-by-step render setup<br>
→ <a href="/post/b-format-export-reaper/">Exporting the B-Format Master</a> — Reaper settings for archive and delivery
</div>

---

<div class="ws-block" id="block-b">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK B</span>
  <h2 class="ws-block__title">How to Record Ambisonics — Zylia ZM-1</h2>
</div>
<div class="ws-block__meta">
  <span>Microphone Setup</span><span>A-to-B Conversion</span><span>Reaper Session</span>
</div>
</div>

### Recording 3D Audio: The Recording Workflow

<figure class="ws-figure">
  <img src="/images/workshop/diagram-recording-3daudio.png" alt="Recording 3D Audio: Microphone → A-format → A-to-B Conversion → B-format" loading="lazy">
  <figcaption>From capsule to B-format: microphone array (A-format, raw capsules) → A-to-B conversion in the Zylia app → 16-channel B-format (AmbiX). All three stages are covered in the workshop workflow.</figcaption>
</figure>

### Workflow (Hands-on with Zylia → Main Reaper)

<ol class="ws-steps">
<li><strong>Short Recording Session</strong> — Set up Zylia ZM-1, check levels (−18 dBFS), record 30–60 seconds → 19-channel A-format PCM</li>
<li><strong>A to B Converting</strong> — Zylia App: import A-format, export as 3rd Order HOA → 16-channel B-format AmbiX WAV<br>
  <em>A-format = PCM audio (regular audio data, raw capsules)</em><br>
  <em>B-format = Mathematical format (spherical harmonics, not directly listenable)</em></li>
<li><strong>Listening B-Format</strong> — Load in Reaper, listen binaurally via HOA bus + AmbiDecoder: does "front" actually sound in front?</li>
<li><strong>Upsampling & FX</strong> — EQ, reverb on HOA bus, distance automation on the encoder</li>
<li><strong>Mastering B-Format</strong> — Render HOA Render Bus: 16 ch, 48 kHz, 32-bit float WAV → B-format master</li>
</ol>

<div class="ws-tip">
<strong>💡 Thunderstorm Example (Zylia Recording)</strong>
A thunderstorm recording shows why HOA far surpasses stereo: thunder comes from all directions (full envelopment), rain falls from above (elevation), wind rotates (rotation of the sound field). In stereo: just a left-right smear. In Ambisonics: a complete sphere.
</div>

### Microphone Specifications

- 19-capsule array (omnidirectional)
- Output: 19 raw channels → encoded to 3rd Order HOA (16 channels, AmbiX) by the Zylia software
- Connection: USB-C, no external power required

### Microphone Placement

The position of the microphone determines the listening perspective — this is not a technical but a compositional decision.

- **Height:** approx. 1.5 m for a natural ear-level perspective; lower for a "ground level" effect, higher for an overview perspective
- **Orientation:** The microphone has a preferred direction (marker). "Front" in B-format corresponds to this direction — document it so that decoding is correct
- **Distance to source:** Closer = more direct sound, more spatial detail; further = more diffuse field, less localisation
- **Reflections:** Hard walls, floors, and ceilings are very prominent in an HOA microphone — listen carefully to the placement location before recording
- **Wind protection:** Always use a windshield outdoors (blimp or fur). Activate LF roll-off below 80 Hz

### Gain Management

- Target level: approx. **−18 dBFS** (check all 19 channels individually)
- Headroom: at least **12 dB** — transients in HOA microphones can peak unexpectedly
- Monitor all raw channels separately: a single clipping channel corrupts the entire B-format
- Set the gain structure in the Zylia app, not in Reaper after the fact

### A-to-B Conversion

The Zylia ZM-1 delivers A-format (19 raw channels). The Zylia software converts these to 3rd Order HOA (16 channels, AmbiX):

- **When to convert?** Immediately after recording, before importing into Reaper
- **Quality control:** Test phase and channel assignment — a mono test source from the front should sound clearly in front in the binaural monitor
- **Archive raw data:** Always keep the A-format (19 channels) — this allows re-conversion later with better software

<div class="ws-info">
<strong>📖 Further reading: A-format & B-format</strong>
→ <a href="/post/ambisonics-mikrofon-a-format-b-format/">Recording with an Ambisonics Microphone – A-format, B-format</a> — conversion workflow and quality control explained
</div>

### Field Recording Checklist

<style>
.ws-checklist { list-style: none; padding: 0; margin: 0.5rem 0 1.2rem; }
.ws-checklist li { display: flex; align-items: flex-start; gap: 0.7rem; padding: 0.38rem 0; font-size: 1.48rem; line-height: 1.5; border-bottom: 1px solid #e8eef5; }
.theme--dark .ws-checklist li { border-bottom-color: #2a3d4f; }
.ws-checklist li:last-child { border-bottom: none; }
.ws-checklist input[type="checkbox"] { flex-shrink: 0; width: 1.2rem; height: 1.2rem; margin-top: 0.22rem; accent-color: #4a9eda; cursor: pointer; }
.ws-checklist li.done { color: #888; text-decoration: line-through; }
.theme--dark .ws-checklist li.done { color: #556; }
</style>

Before recording:

<ul class="ws-checklist" id="checklist-before">
  <li><input type="checkbox" onchange="wsCk(this)"> Acoustic survey: reflections, noise sources, wind direction</li>
  <li><input type="checkbox" onchange="wsCk(this)"> Decide on microphone placement and document it (height, orientation, distance)</li>
  <li><input type="checkbox" onchange="wsCk(this)"> Level check: all 19 channels at approx. −18 dBFS</li>
  <li><input type="checkbox" onchange="wsCk(this)"> Binaural monitoring active and verified</li>
  <li><input type="checkbox" onchange="wsCk(this)"> Metadata template prepared (location, date, take number, weather)</li>
</ul>

After recording:

<ul class="ws-checklist" id="checklist-after">
  <li><input type="checkbox" onchange="wsCk(this)"> A-to-B conversion in Zylia app</li>
  <li><input type="checkbox" onchange="wsCk(this)"> Load HOA file (16 ch AmbiX) in Reaper and verify binaurally</li>
  <li><input type="checkbox" onchange="wsCk(this)"> Archive raw channels (A-format)</li>
</ul>

<script>
function wsCk(cb) { cb.closest('li').classList.toggle('done', cb.checked); }
</script>

### Reaper Session (pre-configured)

| Track | Channels | Function |
|---|---|---|
| Notes | — | Notes track (muted) |
| Zylia ZM-1 | 16 | Armed for recording · VU: multichannel peaks |
| HOA Bus | 16 | AUXRECV from Zylia · no direct out |
| ICST AmbiDecoder | 18 | 16 ch in + 2 aux · decoder plugin |
| Binaural Monitor | 2 | Headphone monitoring |
| HOA Render Bus | 16 | Muted · for offline render |

<div class="ws-info">
<strong>📥 Download: Pre-configured Reaper Session</strong>
All tracks, routing, and decoder preset are pre-configured — just open and start.<br>
→ <a href="/downloads/zylia-recording-example/zylia_recording_example.RPP" download>zylia_recording_example.RPP</a>
</div>

<div class="ws-info">
<strong>📖 Further reading: Room Recording & Acoustics</strong>
→ <a href="/composing-in-ambisonics/073-room-capture/">Capturing Space and Synthetically Creating Space</a> — room acoustics and recording technique for HOA productions
</div>

### Common Recording Errors and Solutions

| Problem | Cause | Solution |
|---|---|---|
| Sound seems "back to front" | Microphone orientation not documented | Test and note front/back on location |
| Comb filtering / unstable direction | Faulty A-to-B conversion | Check for spectral artefacts, repeat conversion |
| Clipping on individual channels | Overloading of individual capsules | Monitor all 19 raw channels separately, reduce gain |
| Wind noise in low frequencies | Missing wind protection | LF roll-off below 80 Hz, use blimp |
| No elevation | FOA loaded instead of HOA | Check channel count: FOA = 4 ch, HOA 3rd = 16 ch |
| B-format import in Reaper incorrect | Wrong ordering (FuMa instead of AmbiX) | Use FuMa → AmbiX converter (JSFX, Block C) |

---

### Composers Workflow — The Three Stages

<figure class="ws-figure">
  <img src="/images/workshop/diagram-three-stages.png" alt="The three stages: Encoder → Transformer → Decoder (Author / Image / Monitor)" loading="lazy">
  <figcaption>The paradigmatic workflow of the Ambisonics Toolkit: Author → Image → Monitor. Every Ambisonics production passes through the same three stages — regardless of tool and output format.</figcaption>
</figure>

Every Ambisonics production — whether field recording, synthesiser, or live performance — passes through three stages:

| Stage | Question | In practice |
|---|---|---|
| **Encoding** | Where is the sound in 3D space? | Azimuth, elevation, distance — via ICST AmbiEncoder_64 or Lua script |
| **Processing** | How does the sound move and how does it interact with the space? | Rotation, movement automation, reverb on HOA bus, distance simulation |
| **Decoding** | How do I play this back on my audio system? | ICST AmbiDecoder: binaural (HRTF), loudspeaker ring, MultiDecoder |

<figure class="ws-figure">
  <img src="/images/workshop/diagram-signalflow.png" alt="Signal flow (communication): External applications, bridges, DAW, external hardware, outputs" loading="lazy">
  <figcaption>Complete signal flow of an Ambisonics production environment: external tools (AbletonLive, Csound, SuperCollider, Max 9) → bridges → DAW (sound design, spatialisation, mix & mastering) → B-format → decoding. OSC/MIDI connects all layers.</figcaption>
</figure>

---

<div class="ws-block" id="block-c">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK C</span>
  <h2 class="ws-block__title">Reaper Workflow: Encoding · Processing · Decoding</h2>
</div>
<div class="ws-block__meta">
  <span>ICST AmbiEncoder_64</span><span>Lua Automation</span><span>Decoding</span>
</div>
</div>

### Encoding with ICST AmbiEncoder_64

Plugin: **ICST AmbiEncoder_64** (VST3) — pre-installed on all workshop computers.

| Parameter | Index | Normalised | Meaning |
|---|---|---|---|
| Azimuth | 11 | 0–1 → −180° to +180° | Horizontal position |
| Elevation | 12 | 0–1 → −90° to +90° (0.5 = horizon) | Vertical position |
| Distance | 13 | 0 = near · 1 = far | Depth |

<div class="ws-info">
<strong>📥 Lua script: Encoding example</strong>
→ <a href="/downloads/lua-scripts/icst_ambi_encoding_voice.lua" download>icst_ambi_encoding_voice.lua</a> — sets track, loads AmbiEncoder, positions source at azimuth −45°, elevation +20°
</div>

<div class="ws-info">
<strong>📖 Further reading: ICST AmbiEncoder</strong>
→ <a href="/icst-ambisonics-plugins/10_icst_encoders/">ICST Encoders</a> — all parameters, modes, and encoder variants at a glance<br>
→ <a href="/post/icst-scripts/">ICST AmbiEncoder – Spiral Walk Script</a> — example of complex Lua automation<br>
→ <a href="/post/osc-syntax-for-the-icst-ambiencoder-plugin/">ICST AmbiEncoder – OSC Syntax</a> — control the encoder via OSC (Touchdesigner, Max, etc.)
</div>

### Automation: Moving Sound Sources

Physik-basierte Trajektorie: `atan2` für Azimut, `√(x²+y²)` für Distanz.

<div class="ws-info">
<strong>📥 Lua scripts: Train pass-by</strong>
→ <a href="/downloads/lua-scripts/icst_ambi_zug_langsam.lua" download>icst_ambi_zug_langsam.lua</a> — slow train, 28 seconds<br>
→ <a href="/downloads/lua-scripts/icst_ambi_zug_schnell.lua" download>icst_ambi_zug_schnell.lua</a> — express train, 4 seconds<br>
→ <a href="/downloads/lua-scripts/icst_ambi_zug_vergleich.lua" download>icst_ambi_zug_vergleich.lua</a> — pause + slow + pause + fast in sequence
</div>

### Processing

#### Distance

In the ICST AmbiEncoder, **Param 13 (Distance)** simulates depth in space. The plugin attenuates level and high-frequency content with increasing distance — similar to air absorption in real space:

- Near sources (distance ~0): present, direct, high HF content
- Distant sources (distance ~1): quieter, duller, more diffuse-field content
- **Combined with reverb:** The greater the distance, the higher the wet amount in the room plugin on the HOA bus

<div class="ws-info">
<strong>📥 Reaper example: Distance automation</strong>
→ <a href="/downloads/workshop-2026/reaper-setup/icst_stereo_pan_distanz.lua" download>icst_stereo_pan_distanz.lua</a>
</div>

#### Room / Reverb

The reverb sits on the **HOA bus track** — not on the source track. Only then does the reverb remain anchored in Ambisonics space and get decoded correctly with the B-format.

- **ReaVerb or FX reverb** on the HOA bus (after all encoders, before the decoder)
- Dry/wet ratio: start sparingly (~10–20% wet), as HOA reverb sounds very prominent
- **Room size and pre-delay** determine the size of the space
- Separate reverb sends per source allow different room distances

<div class="ws-info">
<strong>📥 Reaper example: Room curves</strong>
→ <a href="/downloads/workshop-2026/reaper-setup/icst_stereo_pan_raumkurven.lua" download>icst_stereo_pan_raumkurven.lua</a>
</div>

#### Example: Helicopter Flyover

| Phase | Azimuth | Elevation | Distance |
|---|---|---|---|
| Approach (front) | ~0° | 15° → 70° | 1.0 → 0.3 |
| Overhead | 0° → 180° | 70° → 85° → 70° | 0.3 → **min** → 0.3 |
| Departure (rear) | ~180° | 70° → 15° | 0.3 → 1.0 |

The script calculates position, azimuth, and elevation directly from 3D coordinates (`atan2`, Pythagoras) — no manual angle estimation.

<div class="ws-info">
<strong>📖 Further reading: Spatial Parameters</strong>
→ <a href="/composing-in-ambisonics/06-spatial-parameters/">Spatial Parameters as Compositional Material</a> — creative use of azimuth, elevation, and distance
</div>

<div class="ws-info">
<strong>📥 Lua script: Helicopter flyover</strong>
→ <a href="/downloads/lua-scripts/icst_ambi_kopter.lua" download>icst_ambi_kopter.lua</a> — 18 s flyover, 360 points, configurable height and lateral offset
</div>

### Decoding

- **Binaural:** ICST AmbiDecoder with HRTF file → 2-channel headphones
- **Loudspeakers:** Decoder with `.spk` configuration file
- **Screensets:** `Ctrl+Alt+1` (Recording) · `Ctrl+Alt+2` (Mixing) · `Ctrl+Alt+3` (Decoding)

<div class="ws-info">
<strong>📖 Further reading: Decoding & Delivery</strong>
→ <a href="/post/multi-decoder-mode/">ICST AmbiDecoder – Multi-Decoder Mode</a> — running multiple output formats in parallel<br>
→ <a href="/composing-in-ambisonics/082-binaural-delivery/">Binaural Rendering and Headphone Delivery</a> — binaural render for streaming and headphones
</div>

---

### FuMa → AmbiX Conversion (FOA)

For legacy material in FuMa format (e.g. SoundField, older productions):

| FuMa Input | AmbiX Output (ACN) | Gain correction |
|---|---|---|
| Ch1 = W | ACN 0 = W | × √2 = **+3.01 dB** |
| Ch2 = X | ACN 3 = X | × 1/√3 = **−4.77 dB** |
| Ch3 = Y | ACN 1 = Y | × 1/√3 = **−4.77 dB** |
| Ch4 = Z | ACN 2 = Z | × 1/√3 = **−4.77 dB** |

<div class="ws-info">
<strong>📥 JSFX plugin + Lua installer</strong>
→ <a href="/downloads/lua-scripts/FuMa_to_AmbiX_FOA.jsfx" download>FuMa_to_AmbiX_FOA.jsfx</a> — JSFX plugin<br>
→ <a href="/downloads/lua-scripts/icst_fuma_to_ambix_foa.lua" download>icst_fuma_to_ambix_foa.lua</a> — Lua installer<br>
In Reaper: Actions → Load new Script → <code>icst_fuma_to_ambix_foa.lua</code>
</div>

---

<div class="ws-block" id="block-d">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK D</span>
  <h2 class="ws-block__title">External to Reaper</h2>
</div>
<div class="ws-block__meta">
  <span>MaxMSP</span><span>Csound</span><span>Max for Live</span>
</div>
</div>

Reaper is not the only environment for Ambisonics. These tools are used by composers and researchers — each with a different approach and different strengths.

**Workflow with MaxMSP:** ICST Ambisonics Externals (ambicontrol, ambiencode, ambidecode). Real-time spatialisation, OSC control of the ICST AmbiEncoder in Reaper. Strength: generative and algorithmic spatialisation, live electronics.

**Workflow with Csound (Cabbage.app):** Csound opcodes `bformenc1` / `bformdec2`. Cabbage wraps Csound as a VST3 plugin. Strength: precise mathematical control of the sound field, additive synthesis, granular synthesis.

**Workflow with Max for Live:** MaxMSP integrated in Ableton Live. Combines Ableton's production workflow with Ambisonics spatialisation. Strength: live performance with Ambisonics, studio production.

<div class="ws-tip">
<strong>📌 Note</strong>
Blocks D, E, and F go beyond the 4-hour workshop scope. They are introduced here as an overview and explored in depth in a follow-up workshop.
</div>

---

<div class="ws-block" id="block-e">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK E</span>
  <h2 class="ws-block__title">Csound / Cabbage</h2>
</div>
<div class="ws-block__meta">
  <span>Additive Synthesis</span><span>Spatialisation</span><span>VST3</span>
</div>
</div>

Csound is a programmable audio synthesis language. Cabbage wraps Csound instruments as VST3 plugins and makes them usable in Reaper.

### Cabbage → Reaper (DAW)

<figure class="ws-figure">
  <img src="/images/workshop/diagram-cabbage-reaper.png" alt="Cabbage (Csound) → Reaper: Cabbage.app → BlackHole_64 → Reaper.app, with OSC return channel" loading="lazy">
  <figcaption>Integration of Cabbage/Csound into Reaper: Cabbage.app sends audio to Reaper via BlackHole_64 (virtual audio interface). OSC enables bidirectional communication — Reaper can control spatialisation parameters, Csound can receive encoder positions.</figcaption>
</figure>

**Key Csound opcodes for Ambisonics:**
- `bformenc1` — encodes a mono signal into B-format (1st–3rd order). Input: audio, azimuth, elevation. Output: HOA channels.
- `bformdec2` — decodes B-format to a loudspeaker array.

**Example: Additive Synth & Random Spatialisation (Cabbage)**

A Cabbage example demonstrates: an additive synthesiser generates partials (sine waves) in real time. Each partial is independently spatialised with `bformenc1` and a randomised azimuth/elevation. The position drifts randomly — the result is a moving cloud of sound in 3D space, then decoded binaurally.

---

<div class="ws-block" id="block-f">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK F</span>
  <h2 class="ws-block__title">MaxMSP — ICST Ambisonics Externals</h2>
</div>
<div class="ws-block__meta">
  <span>ACT-Tool</span><span>OSC</span><span>Real-time</span>
</div>
</div>

MaxMSP with the ICST Ambisonics Externals provides a complete real-time Ambisonics environment. Unlike a DAW, Max allows algorithmic and generative control of spatialisation — positions can be driven by data, gestures, sensors, or other audio signals.

### MaxMSP → Reaper (DAW)

<figure class="ws-figure">
  <img src="/images/workshop/diagram-maxmsp-reaper.png" alt="MaxMSP → Reaper: Max9.app ↔ BlackHole_64 ↔ Reaper.app, with OSC and MIDI" loading="lazy">
  <figcaption>MaxMSP and Reaper communicate via BlackHole_64 (audio), OSC (spatialisation parameters), and MIDI. Max9 can control the ICST AmbiEncoder in Reaper in real time — azimuth, elevation, and distance as live automation.</figcaption>
</figure>

**ICST Ambisonics Externals:**
- `ambiencode~` — encodes mono audio into B-format. Message input for azimuth, elevation, distance.
- `ambidecode~` — decodes B-format to loudspeakers or binaural.
- `ambicontrol` — GUI panel for manual spatialisation control.

**ACT-Tool Example:**

The ACT-Tool (Ambisonics Composition Tool) is a MaxMSP patch developed at ICST:
- 3D visual interface for placing and animating sound sources
- Sources can be moved manually (mouse/trackpad) or algorithmically (LFOs, envelopes, data streams)
- OSC output: sends azimuth, elevation, and distance to any Ambisonics encoder — including the ICST AmbiEncoder in Reaper
- The ACT-Tool can be used as a "spatial score": define movement visually, record OSC output as automation in Reaper

---

## Hands-on Exercise

Guided exercise with the prepared sessions:

<ol class="ws-steps">
<li>Open the Zylia session, verify microphone routing and decoder preset</li>
<li>Route a mono test source to the HOA bus, listen binaurally</li>
<li>Run the encoding script: position source at azimuth −45°, elevation +20°</li>
<li>Start the train pass-by automation and follow the trajectory binaurally</li>
<li>Encode your own source and move it in space (automation or manually)</li>
<li>Render and verify the B-format master (16 ch, not 2 ch!)</li>
</ol>

<div class="ws-info">
<strong>📖 Further reading: Compositional Practice</strong>
→ <a href="/composing-in-ambisonics/05-spatial-counterpoint/">Spatial Counterpoint</a> — spatial contrary motion as a compositional technique<br>
→ <a href="/post/reaper-setup-20-minuten/">Reaper Ambisonics Setup in 20 Minutes</a> — quick setup for your own projects after the workshop
</div>

---

<div class="ws-block" id="block-g">
<div class="ws-block__head">
  <span class="ws-block__num">BLOCK G</span>
  <h2 class="ws-block__title">Composer Discussion</h2>
</div>
<div class="ws-block__meta">
  <span>Topics</span><span>Q&A</span><span>Outlook</span>
</div>
</div>

A guided discussion to consolidate the workshop experience. Not a lecture — participants share their own observations and develop ideas together.

**Topics:**

- **Space as compositional material:** Can space itself be the instrument? What happens when the space moves and the source stays still?
- **The composer's perspective:** How does working in Ambisonics change compositional decisions compared to stereo?
- **Elevation and expressivity:** When does height feel natural, when artificial? What does the vertical axis enable that stereo never could?
- **Distance and reverb:** How do distance and reverb interact? When does a source sound "inside the space" rather than "outside"?
- **Outlook — follow-up workshop:** MaxMSP + Csound in depth (Blocks D, E, F).

---

## Preparation & Downloads

- Reaper is pre-installed on all workshop computers (v7+, incl. ICST plugins)
- Bring headphones (binaural monitoring)
- Download the pre-configured Reaper session in advance

<div class="ws-resources">
  <a class="ws-resource-link ws-resource-link--featured" href="https://e.pcloud.link/publink/show?code=XZAeJrZH78kTyE16GyaO0aFzw3kdhpvNeYk" target="_blank" rel="noopener">⬇ ICST Workshop — Large Download (pCloud)<strong>Pre-configured Reaper folder (drag in Reaper.app → ready to go) + Workshop papers</strong></a>
  <a class="ws-resource-link ws-resource-link--featured" href="/downloads/workshop-2026/ICST_Ambisonics_Workshop_2026.zip" download>⬇ ICST_Ambisonics_Workshop_2026.zip<strong>Complete workshop package — Reaper session, Lua scripts, Csound, MaxMSP (6.8 MB)</strong></a>
  <a class="ws-resource-link" href="/downloads/zylia-recording-example/zylia_recording_example.RPP" download>zylia_recording_example.RPP<strong>Pre-configured Reaper session for Zylia ZM-1</strong></a>
  <a class="ws-resource-link" href="/downloads/ICST_Ambisonics_Workshop.docx" download>Workshop Document (.docx)<strong>Complete workshop document</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_ambi_encoding_voice.lua" download>icst_ambi_encoding_voice.lua<strong>Encoding: voice at Az −45°, El +20°</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_ambi_zug_langsam.lua" download>icst_ambi_zug_langsam.lua<strong>Slow train pass-by (28 s)</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_ambi_zug_schnell.lua" download>icst_ambi_zug_schnell.lua<strong>Express train pass-by (4 s)</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_ambi_zug_vergleich.lua" download>icst_ambi_zug_vergleich.lua<strong>Train comparison (slow + fast)</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_ambi_kopter.lua" download>icst_ambi_kopter.lua<strong>Helicopter flyover (3D, 18 s)</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/FuMa_to_AmbiX_FOA.jsfx" download>FuMa_to_AmbiX_FOA.jsfx<strong>FuMa → AmbiX FOA Converter (JSFX)</strong></a>
  <a class="ws-resource-link" href="/downloads/lua-scripts/icst_fuma_to_ambix_foa.lua" download>icst_fuma_to_ambix_foa.lua<strong>FuMa → AmbiX Lua installer</strong></a>
  <a class="ws-resource-link" href="/blog/b-format-archive/">ICST B-Format Archive<strong>Archive with HOA example files to explore</strong></a>
  <a class="ws-resource-link" href="/icst-ambisonics-plugins/15_best_practices/">Best Practices<strong>Recommendations for professional Ambisonics productions</strong></a>
</div>
