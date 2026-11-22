---
title: "How to Work with Ambisonics: Workflow from Recording to Delivery"
description: "Practical workflow guide for Ambisonics productions: recording, production, mixing, delivery, and live systems using REAPER, ICST Plugins, and Max/MSP."
date: 2026-05-15T00:00:00
draft: false
slug: ambisonics-workflow
languageCode: en
tags:
  - ambisonics
  - workflow
  - recording
  - mixing
  - delivery
  - live
  - reaper
---

<div class="learn-box" style="border:1px solid var(--border-color,#8886);border-left:4px solid #4a8fe0;border-radius:8px;padding:.4rem 1.4rem;margin:1.6rem 0">

**What you will learn**

- The stages of an Ambisonics production from recording to delivery
- Where to decide on order and format, and why you always render from the B-format master
- Where decoding happens for loudspeakers, headphones and live systems
- Which page to open next for each stage

</div>


<style>
/* ══════════════════════════════════════════════════════════
   WORKFLOW PAGE STYLES — Light + Dark Mode
   ══════════════════════════════════════════════════════════ */

.post__content > h1 {
  font-size: clamp(2.8rem, 4.2vw, 4.3rem);
  line-height: 1.08;
  letter-spacing: 0.01em;
  margin-bottom: 1.5rem;
}
.post__content h2 { font-size: clamp(2rem, 2.6vw, 2.7rem); line-height: 1.18; }
.post__content h3 { font-size: clamp(1.45rem, 1.6vw, 1.8rem); line-height: 1.25; }
.post__content p,
.post__content li,
.post__content td,
.post__content th { font-size: 1.55rem; line-height: 1.62; }

.wf-hero {
  background: linear-gradient(135deg, #1a2a1a 0%, #2c4a2e 100%);
  border-radius: 10px;
  padding: 2.1rem 2.25rem 1.95rem;
  color: #fff;
  margin-bottom: 2rem;
}
.wf-hero__title { font-size: 2.25rem; font-weight: 800; letter-spacing: 0.02em; margin: 0 0 0.3rem 0; }
.wf-hero__subtitle { font-size: 1.45rem; opacity: 0.75; margin: 0 0 1.2rem 0; }
.wf-badges { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 1rem; }
.wf-badge { background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.25); border-radius: 20px; padding: 0.32rem 0.95rem; font-size: 1.3rem; color: #fff; white-space: nowrap; }
.wf-badge--green { background: #3a8a45; border-color: #3a8a45; }
.wf-meta { display: flex; flex-wrap: wrap; gap: 1.5rem; margin-top: 1rem; font-size: 1.38rem; opacity: 0.85; }
.wf-meta span { white-space: nowrap; }
.wf-meta a { color: inherit; text-decoration-color: rgba(255,255,255,0.45); text-underline-offset: 0.18em; }

.wf-chain { display: flex; flex-wrap: wrap; gap: 0; margin: 1.5rem 0 2rem; border-radius: 8px; overflow: hidden; box-shadow: 0 1px 4px rgba(0,0,0,0.1); }
.wf-chain__step { flex: 1 1 120px; background: #f0f6f0; border-right: 1px solid #d0e8d0; padding: 1rem 1.1rem 0.9rem; text-align: center; }
.wf-chain__step:last-child { border-right: none; }
.wf-chain__step--active { background: #2c4a2e; color: #fff; }
.theme--dark .wf-chain__step { background: #1a2d1a; border-right-color: #2a4030; }
.theme--dark .wf-chain__step--active { background: #2c5a30; }
.wf-chain__icon { font-size: 1.8rem; display: block; margin-bottom: 0.3rem; }
.wf-chain__label { font-size: 1.25rem; font-weight: 700; display: block; }
.wf-chain__sub { font-size: 1.1rem; opacity: 0.7; display: block; }

.wf-section { border-top: 3px solid #3a8a45; margin: 2.5rem 0 1.2rem; padding-top: 1rem; }
.wf-section__head { display: flex; align-items: baseline; flex-wrap: wrap; gap: 0.7rem; margin-bottom: 0.4rem; }
.wf-section__num { background: #3a8a45; color: #fff; border-radius: 4px; padding: 0.1rem 0.55rem; font-size: 1.12rem; font-weight: 700; letter-spacing: 0.05em; }
.wf-section__title { font-size: 1.9rem; font-weight: 700; color: #1a2a1a; margin: 0; }
.theme--dark .wf-section__title { color: #c0e8c0; }
.wf-section__meta { font-size: 1.35rem; color: #666; margin: 0.2rem 0 1rem; display: flex; flex-wrap: wrap; gap: 1rem; }
.theme--dark .wf-section__meta { color: #7a9a7a; }
.wf-section__meta span::before { content: "· "; }
.wf-section__meta span:first-child::before { content: ""; }

.wf-key { background: #f0f6f0; border-left: 4px solid #3a8a45; border-radius: 0 8px 8px 0; padding: 1.1rem 1.5rem; margin: 1.2rem 0; }
.theme--dark .wf-key { background: #1a2d1a; }
.wf-key__title { font-weight: 700; font-size: 1.4rem; color: #1a5a25; margin: 0 0 0.6rem; }
.theme--dark .wf-key__title { color: #7dd3a8; }
.wf-key p, .wf-key li { font-size: 1.5rem; margin-bottom: 0.35rem; line-height: 1.5; }

.wf-warn { background: #fff8e6; border: 1px solid #f0c040; border-left: 4px solid #f0c040; border-radius: 0 8px 8px 0; padding: 0.9rem 1.2rem; margin: 1.2rem 0; }
.theme--dark .wf-warn { background: #231f0e; border-color: #a07c10; border-left-color: #f0c040; }
.wf-warn__title { font-weight: 700; font-size: 1.4rem; color: #7a5800; margin: 0 0 0.5rem; }
.theme--dark .wf-warn__title { color: #f0c040; }
.wf-warn p, .wf-warn li { font-size: 1.45rem; margin-bottom: 0.35rem; line-height: 1.5; }

.wf-steps { counter-reset: wf-step; list-style: none; padding: 0; margin: 1rem 0; }
.wf-steps li { counter-increment: wf-step; display: flex; gap: 1rem; align-items: flex-start; padding: 0.65rem 0; border-bottom: 1px solid #e8f0e8; font-size: 1.52rem; line-height: 1.55; }
.theme--dark .wf-steps li { border-bottom-color: #2a3d2a; }
.wf-steps li:last-child { border-bottom: none; }
.wf-steps li::before { content: counter(wf-step); background: #3a8a45; color: #fff; border-radius: 50%; width: 2rem; height: 2rem; min-width: 2rem; display: flex; align-items: center; justify-content: center; font-size: 1.1rem; font-weight: 700; margin-top: 0.1rem; }

.wf-table { width: 100%; border-collapse: collapse; font-size: 1.45rem; margin: 1.2rem 0 1.8rem; border-radius: 8px; overflow: hidden; box-shadow: 0 1px 4px rgba(0,0,0,0.08); }
.wf-table th { background: #2c4a2e; color: #fff; padding: 0.7rem 1rem; text-align: left; font-weight: 600; }
.wf-table td { padding: 0.65rem 1rem; border-bottom: 1px solid #e0ede0; vertical-align: top; }
.theme--dark .wf-table td { border-bottom-color: #2a3d2a; }
.wf-table tr:last-child td { border-bottom: none; }
.wf-table tr:nth-child(even) td { background: #f7fbf7; }
.theme--dark .wf-table tr:nth-child(even) td { background: #1a2d1a; }

.wf-checklist { columns: 2; column-gap: 2rem; list-style: none; padding: 0; margin: 1rem 0; }
@media (max-width: 640px) { .wf-checklist { columns: 1; } }
.wf-checklist li { font-size: 1.45rem; padding: 0.32rem 0 0.32rem 2rem; position: relative; break-inside: avoid; }
.wf-checklist li::before { content: "☐"; position: absolute; left: 0; color: #3a8a45; font-size: 1.3rem; }

.wf-resources { display: grid; grid-template-columns: repeat(auto-fit, minmax(210px, 1fr)); gap: 0.8rem; margin: 1rem 0; }
.wf-resource-link { display: block; background: #f0f6f0; border: 1px solid #c0ddc0; border-radius: 7px; padding: 0.7rem 1rem; text-decoration: none; font-size: 1.35rem; color: #1a4a25; transition: background 0.15s; }
.wf-resource-link:hover { background: #ddf0dd; text-decoration: none; }
.wf-resource-link strong { display: block; font-size: 1.15rem; color: #6a8a6a; font-weight: 400; }
.theme--dark .wf-resource-link { background: #1a2d1a; border-color: #2a4a2a; color: #7ec8a0; }
.theme--dark .wf-resource-link:hover { background: #1e3d1e; }
.theme--dark .wf-resource-link strong { color: #5a8a6a; }

/* Readability pass: stronger contrast in both themes */
.post__content .wf-meta a { color: #e8f5e8 !important; text-decoration: underline; text-decoration-color: rgba(255,255,255,0.6); }
.wf-hero__subtitle { opacity: 0.92; }
.wf-meta { opacity: 1; }
.wf-chain__label { font-size: 1.35rem; }
.wf-chain__sub { font-size: 1.2rem; opacity: 0.88; }
.wf-section__meta { color: #4a4a4a; font-size: 1.4rem; }
.theme--dark .wf-section__meta { color: #b4d2b4; }
.wf-resource-link strong { color: #4a6a50; font-size: 1.2rem; }
.theme--dark .wf-resource-link strong { color: #a3cdb3; }
.theme--dark .wf-resource-link { color: #a8e0c0; }
.theme--dark .wf-key { background: #20402a; border-left-color: #5fcf7a; }
.theme--dark .wf-key__title { color: #9be8bb; }
.theme--dark .wf-warn { background: #3a3110; }
.theme--dark .wf-checklist li::before { color: #7fdc94; }
.theme--dark .wf-table th { background: #356b3c; }
.theme--dark .wf-table tr:nth-child(even) td { background: #1e3322; }
.wf-table td strong, .wf-table td:first-child { font-weight: 600; }
.wf-badge { background: rgba(255,255,255,0.22); border-color: rgba(255,255,255,0.4); }
</style>

<div class="wf-hero">
  <p class="wf-hero__title">How to Work with Ambisonics</p>
  <p class="wf-hero__subtitle">Workflow Guide · Recording · Production · Delivery · Live · ICST / ZHdK</p>
  <div class="wf-badges">
    <span class="wf-badge wf-badge--green">Advanced</span>
    <span class="wf-badge">REAPER + ICST Plugins</span>
    <span class="wf-badge">Max/MSP optional</span>
    <span class="wf-badge">Csound optional</span>
  </div>
  <div class="wf-meta">
    <span>🎛️ <a href="/icst-ambisonics-plugins/17_best_practices/">Prerequisite: Best Practices</a></span>
    <span>📐 <a href="/learn/ambisonics-formats/">Ambisonics Formats</a></span>
    <span>🔧 <a href="/icst-ambisonics-plugins/">ICST Plugin Documentation</a></span>
  </div>
</div>

This page describes the **complete Ambisonics workflow** — from microphone placement to finished delivery or live system. It is not a beginner tutorial, but a **reference for practitioners**: compact, decision-oriented, and aligned directly with the ICST ecosystem.

<div class="wf-chain">
  <div class="wf-chain__step">
    <span class="wf-chain__icon">🎙</span>
    <span class="wf-chain__label">Recording</span>
    <span class="wf-chain__sub">A-Format → B-Format</span>
  </div>
  <div class="wf-chain__step">
    <span class="wf-chain__icon">🎛</span>
    <span class="wf-chain__label">Production</span>
    <span class="wf-chain__sub">REAPER · Encoding · Mixing</span>
  </div>
  <div class="wf-chain__step">
    <span class="wf-chain__icon">📦</span>
    <span class="wf-chain__label">Delivery</span>
    <span class="wf-chain__sub">Export · Formats · Render</span>
  </div>
  <div class="wf-chain__step">
    <span class="wf-chain__icon">🔊</span>
    <span class="wf-chain__label">Live</span>
    <span class="wf-chain__sub">System Design · Real-time</span>
  </div>
</div>

---

<div class="wf-section">
<div class="wf-section__head">
  <span class="wf-section__num">01</span>
  <h2 class="wf-section__title">Recording</h2>
</div>
<div class="wf-section__meta">
  <span>Microphone Selection</span><span>A-to-B Conversion</span><span>Field Recording</span><span>Quality Control</span>
</div>
</div>

## Microphone Selection

Ambisonics microphones record in **A-Format** — the raw capsule signals, not yet a sound-field format. Conversion to **B-Format (ambiX)** happens afterwards, either internally in the microphone or via software.

<table class="wf-table">
<thead><tr><th>Microphone</th><th>Order</th><th>Strengths</th><th>Typical Use</th></tr></thead>
<tbody>
<tr><td>Zoom H3-VR</td><td>1st / 4 ch</td><td>Compact, affordable, internal B-Format output</td><td>Field recording, education</td></tr>
<tr><td>Sennheiser Ambeo VR</td><td>1st / 4 ch</td><td>Robust, widely used, good sound</td><td>Field recording, studio</td></tr>
<tr><td>Rode NT-SF1</td><td>1st / 4 ch</td><td>Affordable entry, solid quality</td><td>Field recording, production</td></tr>
<tr><td>DPA d:mension</td><td>1st / 4 ch</td><td>Very linear response, low coloration</td><td>Music recording, studio</td></tr>
<tr><td>Zylia ZM-1</td><td>3rd / 19 ch</td><td>Higher resolution, good directionality</td><td>Research, HOA production</td></tr>
<tr><td>EigenMike em32</td><td>4th / 32 ch</td><td>Reference HOA, maximum resolution</td><td>Studio, scientific recording</td></tr>
</tbody>
</table>

**Rule of thumb:** 1st-order microphones are sufficient for FOA productions and teaching. For HOA productions from 3rd order up, a Zylia ZM-1 or EigenMike is appropriate.

### A-to-B Conversion

<div class="wf-warn">
<p class="wf-warn__title">⚠ A-Format is not Ambisonics</p>
<p>A-Format files sound spatially incoherent when loaded directly as B-Format. Conversion must occur before any further processing.</p>
</div>

The conversion matrix compensates for capsule spacing, frequency response, and phase errors of the specific microphone. Manufacturer-specific matrices matter — not all A-to-B tools work with all microphones.

<ul class="wf-steps">
<li>Import A-Format raw file into REAPER (4 / 19 / 32 channels depending on microphone)</li>
<li>Load manufacturer-specific A-to-B plugin: Sennheiser Ambeo Orbiter, SoundField Ambisonic Toolkit, or ICST JS Plugin</li>
<li>Verify channel assignment: W (pressure) on channel 1, then X, Y, Z following ACN ordering</li>
<li>Audition a short test segment binaurally — confirm stable directionality and coherent depth</li>
<li>Export result as ambiX WAV and document metadata (microphone, location, take number)</li>
</ul>

### Field Recording Workflow

<table class="wf-table">
<thead><tr><th>Phase</th><th>Action</th></tr></thead>
<tbody>
<tr><td>Before recording</td><td>Acoustic survey: reflections, noise sources, walkable listening zones. Level check with test tones.</td></tr>
<tr><td>Placement</td><td>Microphone height approx. 1.5 m for natural listening perspective. Avoid nearby reflective surfaces unless intentional.</td></tr>
<tr><td>Levels</td><td>Target level approx. −18 dBFS, 12 dB headroom. Monitor all raw channels separately.</td></tr>
<tr><td>Monitoring</td><td>Binaural over headphones during recording. Check for spatial coherence and wind noise.</td></tr>
<tr><td>Documentation</td><td>Immediately after each take: location, mic position, weather conditions, time of day, notable details.</td></tr>
</tbody>
</table>

### Common Problems and Solutions

<table class="wf-table">
<thead><tr><th>Problem</th><th>Cause</th><th>Solution</th></tr></thead>
<tbody>
<tr><td>Channel swap, unstable directionality</td><td>Incorrect ACN ordering</td><td>Test W/X/Y/Z assignment on site with an impulse</td></tr>
<tr><td>Comb filtering, spatial artifacts</td><td>Wrong or missing A-to-B conversion</td><td>Check spectrum, use manufacturer-specific matrix</td></tr>
<tr><td>Clipping on individual capsule</td><td>Single channel overloaded</td><td>Meter all raw channels separately</td></tr>
<tr><td>Wind noise, LF rumble</td><td>Insufficient wind protection</td><td>Double windshield, LF roll-off below 80 Hz</td></tr>
</tbody>
</table>

---

<div class="wf-section">
<div class="wf-section__head">
  <span class="wf-section__num">02</span>
  <h2 class="wf-section__title">Production & Mixing</h2>
</div>
<div class="wf-section__meta">
  <span>Session Setup</span><span>Routing</span><span>Encoding</span><span>Spatial Mixing</span><span>Monitoring</span>
</div>
</div>

### Session Architecture in REAPER

A clean Ambisonics session has a clear hierarchy:

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 200" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Session architecture: source tracks go through the AmbiEncoder into the HOA bus, which feeds a decoder track for speakers and the B-format master for export." xmlns="http://www.w3.org/2000/svg"><defs><marker id="m1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="70" width="190" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="105.0" y="96.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Source tracks</text><text x="105.0" y="112.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">mono / stereo / A-format</text><line x1="202" y1="98" x2="228" y2="98" stroke="currentColor" stroke-width="1.6" marker-end="url(#m1)"/><rect x="230" y="70" width="170" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="315.0" y="96.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">ICST AmbiEncoder</text><text x="315.0" y="112.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">encoding + panning</text><line x1="402" y1="98" x2="428" y2="98" stroke="currentColor" stroke-width="1.6" marker-end="url(#m1)"/><rect x="430" y="70" width="110" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="485.0" y="96.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">HOA bus</text><text x="485.0" y="112.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">B-Format</text><line x1="542" y1="88" x2="568" y2="52" stroke="currentColor" stroke-width="1.6" marker-end="url(#m1)"/><line x1="542" y1="108" x2="568" y2="144" stroke="currentColor" stroke-width="1.6" marker-end="url(#m1)"/><rect x="570" y="26" width="140" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="640.0" y="50.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Decoder track</text><text x="640.0" y="66.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">→ speaker output</text><rect x="570" y="122" width="140" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="640.0" y="146.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">B-format master</text><text x="640.0" y="162.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">→ export</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Session architecture in REAPER.</figcaption>
</figure>

<div class="wf-key">
<p class="wf-key__title">Core rule: never bypass the HOA bus</p>
<p>No direct source-to-master path. Every source goes through the AmbiEncoder — otherwise the binaural render will sound different from the speaker setup.</p>
</div>

### Routing Step by Step

<ul class="wf-steps">
<li>Create HOA Bus: channel count matching desired order (4 / 9 / 16 / 25 / 36 channels)</li>
<li>Insert ICST AmbiEncoder on every source track: set azimuth, elevation, spread</li>
<li>Route encoder output to HOA Bus — never directly to master</li>
<li>Insert ICST AmbiDecoder at the end of the chain: load speaker layout preset</li>
<li>Build a separate binaural branch: AmbiHeadphone on its own monitoring track</li>
<li>Prepare B-Format Master as a separate render track (without decoder)</li>
</ul>

### Spatial Mixing — Parameters

| Parameter | Tool | Purpose |
|---|---|---|
| **Azimuth / Elevation** | AmbiEncoder GUI or automation | Base position and movement |
| **Spread / Width** | AmbiEncoder → Width | Point source vs. diffuse cloud |
| **Depth / Distance** | Level + pre-fader reverb in HOA domain | Near/far illusion |
| **Rotation** | AmbiTransformer or OSC | Scene rotation, compass alignment |
| **FX in HOA domain** | FX plugins after encoder, before decoder | Room sound that colours the entire scene |

### Reverb and FX

<figure data-gen="g22" style="margin:1.8rem 0">
<svg viewBox="0 0 720 200" role="img" aria-label="Signal chain: source, encoder, HOA effects, HOA bus, decoder" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arw1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="10" y="60" width="120" height="60" rx="8" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="70" y="95" text-anchor="middle" font-weight="600" font-size="12">Source track</text><line x1="131" y1="90" x2="153" y2="90" stroke="currentColor" stroke-width="1.5" opacity="1" marker-end="url(#arw1)"/><rect x="154" y="60" width="120" height="60" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="214" y="95" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="12">AmbiEncoder</text><line x1="275" y1="90" x2="297" y2="90" stroke="currentColor" stroke-width="1.5" opacity="1" marker-end="url(#arw1)"/><rect x="298" y="60" width="120" height="60" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="358" y="95" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="12">HOA FX</text><line x1="419" y1="90" x2="441" y2="90" stroke="currentColor" stroke-width="1.5" opacity="1" marker-end="url(#arw1)"/><rect x="442" y="60" width="120" height="60" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="502" y="95" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="12">HOA bus</text><line x1="563" y1="90" x2="585" y2="90" stroke="currentColor" stroke-width="1.5" opacity="1" marker-end="url(#arw1)"/><rect x="586" y="60" width="120" height="60" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="646" y="95" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="12">Decoder</text><text x="360" y="152" text-anchor="middle" font-size="12">Reverb sits after the encoder and before the decoder, not on single sources.</text><text x="360" y="172" text-anchor="middle" font-size="11">Room sound stays format-independent and is exported with the B-format master.</text><rect x="280" y="40" width="160" height="0.01" rx="8" fill="none" fill-opacity="0" stroke="#d9a441" stroke-width="1.5" opacity="0"/></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Place room effects in the HOA domain, between encoder and decoder.</figcaption>
</figure>




Place reverb and room effects **after the encoder and before the decoder** — not on individual source tracks. This keeps room sound format-independent and ensures it is correctly exported with the B-Format master.

Typical chain for an HOA reverb:

```
Source Track → AmbiEncoder → [HOA FX: SN3D-compliant Reverb] → HOA Bus → Decoder
```

### Monitoring

<div class="wf-warn">
<p class="wf-warn__title">⚠ Never run binaural and speaker decoder simultaneously</p>
<p>Running a binaural decoder and a speaker decoder in parallel causes phase cancellation. Build monitoring branches as exclusive sends.</p>
</div>

- **Binaural:** AmbiHeadphone on a dedicated monitor track, solo routing.
- **Speakers:** ICST AmbiDecoder with the preset for the current room.
- **Preset switching:** Only swap the decoder — the HOA bus remains unchanged.

### Choosing HOA Order

<figure data-gen="g22" style="margin:1.8rem 0">
<svg viewBox="0 0 720 290" role="img" aria-label="Working in the highest order and reducing downwards, never upgrading" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arw2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="30" y="20" width="330" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="195.0" y="47" text-anchor="middle" font-weight="600" font-size="13">HOA7 · 64 ch</text><text x="374" y="47" text-anchor="start" font-size="12">working order (CPU permitting)</text><line x1="195.0" y1="64" x2="160.0" y2="78" stroke="currentColor" stroke-width="1.5" opacity="1" marker-end="url(#arw2)"/><rect x="30" y="78" width="260" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="160.0" y="105" text-anchor="middle" font-weight="600" font-size="13">HOA5 · 36 ch</text><line x1="160.0" y1="122" x2="125.0" y2="136" stroke="currentColor" stroke-width="1.5" opacity="1" marker-end="url(#arw2)"/><rect x="30" y="136" width="190" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="125.0" y="163" text-anchor="middle" font-weight="600" font-size="13">HOA3 · 16 ch</text><text x="234" y="163" text-anchor="start" font-size="12">fallback / delivery</text><line x1="125.0" y1="180" x2="90.0" y2="194" stroke="currentColor" stroke-width="1.5" opacity="1" marker-end="url(#arw2)"/><rect x="30" y="194" width="120" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="90.0" y="221" text-anchor="middle" font-weight="600" font-size="13">HOA1 · 4 ch</text><text x="164" y="221" text-anchor="start" font-size="12">FOA</text><text x="715" y="92" text-anchor="end" fill="#3fa968" font-size="12">reduce</text><text x="715" y="110" text-anchor="end" font-size="11">for a system or platform</text><text x="715" y="196" text-anchor="end" fill="#d9534f" font-size="12">✗ never upgrade</text><text x="715" y="214" text-anchor="end" font-size="11">a lower order cannot be raised</text><text x="360" y="282" text-anchor="middle" font-size="11">Produce in the highest order the CPU allows (ideally HOA7).</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">A higher-order master can always be reduced, a lower-order session never upgraded.</figcaption>
</figure>




| Order | Channels | Formula | Recommendation |
|---:|---:|---|---|
| 1st (FOA) | 4 | `(1+1)²` | Binaural production, education, FOA recordings |
| 2nd | 9 | `(2+1)²` | — |
| 3rd | 16 | `(3+1)²` | Fallback and typical delivery order; sufficient for mid-sized arrays |
| 5th | 36 | `(5+1)²` | Large arrays, high directional resolution |
| 7th | 64 | `(7+1)²` | Recommended working order if the CPU allows; scientific reference |

**Working rule:** produce in the highest order your computer's CPU copes with (ideally 7th). A higher-order master can always be reduced to 3rd or 1st order for a specific system or platform; a lower-order session can never be upgraded. See [Which Ambisonics order do I need?](/post/hoa-ordnung-wahl-praxis/).

---

<div class="wf-section">
<div class="wf-section__head">
  <span class="wf-section__num">03</span>
  <h2 class="wf-section__title">Delivery & Export</h2>
</div>
<div class="wf-section__meta">
  <span>B-Format Master</span><span>Formats</span><span>Binaural Render</span><span>Platforms</span>
</div>
</div>

### Golden Rule: Always Render from the B-Format Master

<div class="wf-key">
<p class="wf-key__title">Never render from the decoder output</p>
<p>The decoder output is speaker-specific — it only works for one particular array. The B-Format master is format- and room-independent and remains usable with any future decoder.</p>
</div>

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 175" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Render from the B-format master, not from the decoder output, which only fits one loudspeaker array." xmlns="http://www.w3.org/2000/svg"><defs><marker id="m2" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="24" width="130" height="50" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="54.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">HOA bus</text><line x1="142" y1="49" x2="198" y2="49" stroke="currentColor" stroke-width="1.6" marker-end="url(#m2)"/><rect x="200" y="24" width="170" height="50" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".16" stroke-width="1.5"/><text x="285.0" y="54.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">B-format master</text><line x1="372" y1="49" x2="428" y2="49" stroke="currentColor" stroke-width="1.6" marker-end="url(#m2)"/><rect x="430" y="24" width="90" height="50" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="475.0" y="54.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Render</text><text x="535" y="54" text-anchor="start" font-size="22" font-weight="700" fill="#3fa968" fill-opacity="1">✓</text><text x="570" y="54" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.85">room-independent</text><rect x="10" y="104" width="130" height="50" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="134.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">HOA bus</text><line x1="142" y1="129" x2="198" y2="129" stroke="currentColor" stroke-width="1.6" marker-end="url(#m2)"/><rect x="200" y="104" width="170" height="50" rx="8" stroke="#d9534f" fill="#d9534f" fill-opacity=".16" stroke-width="1.5"/><text x="285.0" y="134.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Decoder output</text><line x1="372" y1="129" x2="428" y2="129" stroke="currentColor" stroke-width="1.6" marker-end="url(#m2)"/><rect x="430" y="104" width="90" height="50" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="475.0" y="134.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Render</text><text x="535" y="134" text-anchor="start" font-size="22" font-weight="700" fill="#d9534f" fill-opacity="1">✗</text><text x="570" y="134" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.85">specific to one array</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Render from the B-format master, never from the decoder output.</figcaption>
</figure>

### Export Workflow

<ul class="wf-steps">
<li>Solo the B-Format master track and disable all other outputs</li>
<li>Render a short test file (approx. 10 s) and re-import it</li>
<li>Audition the test file through the binaural path — confirm spatial coherence</li>
<li>Start the full render: WAV / RF64 for large multichannel files</li>
<li>Document metadata in the project notes</li>
</ul>

**Recommended meta-text for REAPER Project Notes:**

```text
Render: B-Format Master | Format: ambiX (ACN/SN3D) | SR: 48000 Hz | Bit: 32-bit float | Channels: 16 | HOA: 3rd | Monitoring: Binaural ✓ / Array ✓
```

### Format Decisions

<table class="wf-table">
<thead><tr><th>Situation</th><th>Format</th><th>Rationale</th></tr></thead>
<tbody>
<tr><td>New archive master</td><td>ambiX (ACN/SN3D), multichannel WAV/RF64</td><td>Standard convention, maximum compatibility with all HOA tools</td></tr>
<tr><td>Binaural delivery (streaming, preview)</td><td>2-channel WAV, 48 kHz / 24-bit</td><td>Universally playable; document HRTF choice</td></tr>
<tr><td>Speaker stems for performance</td><td>N-channel WAV, channel count = array size</td><td>Deliver decoder preset and speaker layout alongside</td></tr>
<tr><td>Legacy system requiring FuMa</td><td>FuMa (W/X/Y/Z, MaxN normalisation)</td><td>Only when a tool explicitly requires FuMa</td></tr>
<tr><td>YouTube 360 / VR platform</td><td>Binaural stereo + spatial metadata</td><td>Check Spatial Media Metadata Tool (Google) per platform requirements</td></tr>
</tbody>
</table>

### Export Checklist

<ul class="wf-checklist">
<li>Channel count matches HOA order</li>
<li>Sample rate: 48 kHz</li>
<li>Bit depth: 32-bit float (master) or 24-bit (delivery)</li>
<li>Format: ambiX (ACN/SN3D) documented</li>
<li>Filename includes order and format</li>
<li>B-Format archive copy backed up</li>
</ul>

---

<div class="wf-section">
<div class="wf-section__head">
  <span class="wf-section__num">04</span>
  <h2 class="wf-section__title">Live Performance & Installation</h2>
</div>
<div class="wf-section__meta">
  <span>System Design</span><span>Real-time Decoding</span><span>Max/MSP</span><span>OSC</span><span>Robustness</span>
</div>
</div>

### Core Question: Where Does Decoding Happen?

The most important decision in live HOA systems is **decoder placement**:

<table class="wf-table">
<thead><tr><th>Setup</th><th>Advantages</th><th>Risks</th></tr></thead>
<tbody>
<tr><td>Laptop on stage (performer decodes)</td><td>Direct control, flexible spatial responses</td><td>Single point of failure, limited latency budget</td></tr>
<tr><td>FOH system decodes</td><td>Separation of performance and control room, proven infrastructure</td><td>Communication critical, B-Format streaming required</td></tr>
<tr><td>Dedicated render machine</td><td>Most stable solution, performer independent</td><td>Synchronisation, network setup required</td></tr>
</tbody>
</table>

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 245" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Three live setups: the performer laptop decodes, the FOH system decodes, or a dedicated render machine decodes. The decoder is highlighted in each." xmlns="http://www.w3.org/2000/svg"><defs><marker id="m" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="18" width="300" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".2" stroke-width="1.5"/><text x="160.0" y="42.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Laptop on stage</text><text x="160.0" y="58.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">source + decoder</text><line x1="312" y1="44" x2="528" y2="44" stroke="currentColor" stroke-width="1.6" marker-end="url(#m)"/><rect x="530" y="18" width="180" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="620.0" y="49.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Speakers</text><rect x="10" y="88" width="170" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="95.0" y="112.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Laptop on stage</text><text x="95.0" y="128.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">source</text><line x1="182" y1="114" x2="258" y2="114" stroke="currentColor" stroke-width="1.6" marker-end="url(#m)"/><text x="220" y="106" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.8">B-format</text><rect x="260" y="88" width="170" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".2" stroke-width="1.5"/><text x="345.0" y="112.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">FOH system</text><text x="345.0" y="128.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">decoder</text><line x1="432" y1="114" x2="528" y2="114" stroke="currentColor" stroke-width="1.6" marker-end="url(#m)"/><rect x="530" y="88" width="180" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="620.0" y="119.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Speakers</text><rect x="10" y="158" width="170" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="95.0" y="182.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Laptop on stage</text><text x="95.0" y="198.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">control</text><line x1="182" y1="184" x2="258" y2="184" stroke="currentColor" stroke-width="1.6" marker-end="url(#m)"/><text x="220" y="176" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.8">network</text><rect x="260" y="158" width="170" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".2" stroke-width="1.5"/><text x="345.0" y="182.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Render machine</text><text x="345.0" y="198.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">decoder</text><line x1="432" y1="184" x2="528" y2="184" stroke="currentColor" stroke-width="1.6" marker-end="url(#m)"/><rect x="530" y="158" width="180" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="620.0" y="189.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Speakers</text><text x="360" y="232" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.85">Blue marks where decoding happens.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Where decoding happens: on stage, at FOH, or on a dedicated render machine.</figcaption>
</figure>

### System Design by Context

<table class="wf-table">
<thead><tr><th>Context</th><th>Priorities</th><th>Recommended Tools</th></tr></thead>
<tbody>
<tr><td>Concert / Stage</td><td>Latency · robustness · FOH compatibility</td><td>REAPER + ICST Decoder · backup binaural mix</td></tr>
<tr><td>Club / Electronic</td><td>Real-time panning · beat sync · interaction</td><td>Max/MSP + OSC + Ableton Link</td></tr>
<tr><td>Gallery / Installation</td><td>Continuous operation · sensors · multiple zones</td><td>Max/MSP + binaural listening stations</td></tr>
<tr><td>Hybrid Studio/Live</td><td>Combine production and performance</td><td>REAPER as recorder · Max as spatialiser</td></tr>
</tbody>
</table>

### Max/MSP for Live HOA

<ul class="wf-steps">
<li>Load externals: <code>ambiencode~</code>, <code>ambidecode~</code>, <code>ambipanning~</code> from the ICST Max tools</li>
<li>Generative panning: <code>drunk</code>, <code>noise~</code>, or <code>cycle~</code> feeding azimuth and elevation inputs</li>
<li>OSC routing: control spatial parameters over the network (tablet, sensor, external software)</li>
<li>Load speaker preset into <code>ambidecode~</code> and send a test tone through all positions</li>
<li>Stress-test for continuous operation: patch must run stably for hours without memory leaks or crashes</li>
<li>Prepare a backup patch: switch to binaural stereo if the array fails</li>
</ul>

### OSC Control

<figure data-gen="g22" style="margin:1.8rem 0">
<svg viewBox="0 0 720 230" role="img" aria-label="External controllers send OSC to the ICST AmbiEncoder, with REAPER automation as fallback" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arw3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="20" width="170" height="46" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="100" y="48" text-anchor="middle" font-size="12">Tablet</text><line x1="187" y1="43" x2="283" y2="86" stroke="currentColor" stroke-width="1.4" opacity="1" marker-end="url(#arw3)"/><rect x="15" y="82" width="170" height="46" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="100" y="110" text-anchor="middle" font-size="12">Sensor</text><line x1="187" y1="105" x2="283" y2="100" stroke="currentColor" stroke-width="1.4" opacity="1" marker-end="url(#arw3)"/><rect x="15" y="144" width="170" height="46" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="100" y="172" text-anchor="middle" font-size="12">Other software</text><line x1="187" y1="167" x2="283" y2="114" stroke="currentColor" stroke-width="1.4" opacity="1" marker-end="url(#arw3)"/><rect x="288" y="70" width="190" height="60" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="383" y="96" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="13">OSC / UDP</text><text x="383" y="114" text-anchor="middle" font-size="11">document port + namespace</text><line x1="480" y1="100" x2="515" y2="100" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#arw3)"/><rect x="520" y="70" width="185" height="60" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="612" y="96" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="13">ICST AmbiEncoder</text><text x="612" y="114" text-anchor="middle" font-size="11">real-time positioning</text><rect x="520" y="160" width="185" height="50" rx="8" fill="none" fill-opacity="0" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="612" y="182" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="12">REAPER automation</text><text x="612" y="198" text-anchor="middle" font-size="11">backup if OSC fails</text><line x1="612" y1="160" x2="612" y2="132" stroke="currentColor" stroke-width="1.4" opacity="1" marker-end="url(#arw3)" stroke-dasharray="5 4"/><text x="383" y="152" text-anchor="middle" font-size="11">OSC over UDP: delivery is unconfirmed.</text><text x="383" y="168" text-anchor="middle" font-size="11">Test latency before the performance.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">OSC enables real-time positioning from outside; keep automation lanes as a backup.</figcaption>
</figure>




OSC messages to the ICST AmbiEncoder enable real-time positioning from external sources — tablet, sensor, another piece of software, or a second device.

Key preparation:
- Document OSC port and message namespace in the REAPER template.
- Test latency: OSC over UDP is unconfirmed delivery; for critical messages, consider confirmed transmission.
- Fallback: REAPER automation lanes as backup if OSC fails.

→ Full OSC syntax reference: [OSC Syntax for the ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)

### Irregular Arrays and AllRADecoder

For irregular speaker layouts (non-spherical, asymmetric), the **AllRADecoder** from the [IEM Plugin Suite](https://plugins.iem.at/) offers more flexibility than the ICST decoder. Workflow:

- Enter speaker positions into AllRADecoder and compute the decoder matrix.
- Export the matrix as a preset and load it into the live patch.
- Always measure with the real setup — do not rely on simulation alone.

---

## Quick Reference: Decision Guide

<table class="wf-table">
<thead><tr><th>Situation</th><th>Decision</th></tr></thead>
<tbody>
<tr><td>New production — which format?</td><td>ambiX (ACN/SN3D) · order determined by target format and microphone</td></tr>
<tr><td>Opening an unknown file?</td><td>Check channel count → formula (N+1)² → read ordering tag in file header</td></tr>
<tr><td>Preparing an export?</td><td>Solo B-Format master track · test render · re-import · binaural check</td></tr>
<tr><td>Reusing a FuMa file?</td><td>Convert to ambiX first, then integrate into session</td></tr>
<tr><td>Live setup — array fails?</td><td>Switch to binaural stereo backup — set it up beforehand</td></tr>
<tr><td>Monitoring sounds wrong?</td><td>Check: binaural and speaker decoder running in parallel?</td></tr>
</tbody>
</table>

---

## Further Resources

<div class="wf-resources">
  <a class="wf-resource-link" href="/post/getting-started-icst-plugins-reaper/">First session<strong>Your first working ICST session in REAPER</strong></a>
  <a class="wf-resource-link" href="/post/hoa-ordnung-wahl-praxis/">Which order?<strong>FOA, HOA3 or HOA7: channels, CPU, loudspeakers</strong></a>
  <a class="wf-resource-link" href="/post/xyz-vs-aed-koordinatensysteme/">XYZ and AED<strong>Coordinate systems and the ICST azimuth convention</strong></a>
  <a class="wf-resource-link" href="/icst-ambisonics-plugins/17_best_practices/">Best Practices<strong>Setup rules, routing, monitoring, export</strong></a>
  <a class="wf-resource-link" href="/learn/ambisonics-formats/">Ambisonics Formats<strong>A-Format · B-Format · ambiX · FuMa · ACN/SN3D</strong></a>
  <a class="wf-resource-link" href="/icst-ambisonics-plugins/12_render_bformat/">Render B-Format<strong>Export guide for REAPER</strong></a>
  <a class="wf-resource-link" href="/icst-ambisonics-plugins/">ICST Plugins Docs<strong>Plugin documentation for REAPER and Max/MSP</strong></a>
  <a class="wf-resource-link" href="https://plugins.iem.at/">IEM Plugin Suite<strong>AllRADecoder · BinauralDecoder · further HOA tools</strong></a>
  <a class="wf-resource-link" href="https://cabbageaudio.com/">Cabbage Audio<strong>Csound as VST3/AU for algorithmic HOA composition</strong></a>
  <a class="wf-resource-link" href="https://zenodo.org/records/2261633">ARTE Database<strong>Ambisonic recordings of typical environments (Zenodo)</strong></a>
  <a class="wf-resource-link" href="https://www.audiobrewers.com/">Audio Brewers<strong>ab Decoder, ab Recorder and the Ambisonics Test Library</strong></a>
</div>

<p class="ai-credit" style="font-size:.85em;opacity:.7"><em>Diagrams and explainer videos created with the help of Claude (Anthropic). <a href="/about/#about-this-site">→</a></em></p>
