---
title: Blauert's Bands
description: "Dokumentiert Blauerts Bänder sowie OSC-Routing und IEM MultiEQ-Frequenzbänder mit Workflow-Hinweisen zu Front/Back und Höhen."
date: 2025-05-16
slug: blauerts-bands
aliases:
  - /post/blauerts-bands/
  - /post/blauertsche_bänder/
  - /post/blauertsche_bänder/
year: 2025
month: 2025-05
weight: 10
tags: ["perception", "psychoacoustics", "binaural", "theory"]
key_points:
  - "Understand how Blauert's Bands affect perceived elevation and front/back localisation"
  - "Apply IEM MultiEQ filter settings for elevation and direction correction"
difficulty: "intermediate"
---

<style>
/* ── Blauert's Bands — Anatole theme aligned ── */

.info-box {
  border-left: 3px solid #6086b4;  /* info */
  border-radius: 0 2px 2px 0;
  padding: 0.9rem 1.2rem;
  margin: 1.2rem 0;
  font-size: 1.4rem;
}
.theme--light .info-box { background: #eeeeee; color: #464646; }
.theme--dark  .info-box { background: #2a3a44; color: #eeeeee; }
.info-box strong { display: block; margin-bottom: 0.3rem; color: #6086b4; }

/* Code/OSC block — stays dark in both modes (terminal style) */
.osc-block {
  background: #1e1e1e;
  color: #d4d4d4;
  border-radius: 2px;
  padding: 0.8rem 1.1rem;
  font-family: monospace;
  font-size: 1.3rem;
  margin: 0.6rem 0 1rem 0;
}
.osc-block .label {
  color: #9f9f9f;
  font-size: 1rem;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  margin-bottom: 4px;
}
.osc-block .arrow { color: #569cd6; }
.osc-block .path   { color: #9cdcfe; }
.osc-block .param  { color: #ce9178; }

.step-grid { display: flex; flex-direction: column; gap: 0.6rem; margin: 1rem 0; }
.step { display: flex; gap: 0.8rem; align-items: flex-start; }
.step__num {
  background: #6086b4;            /* info */
  color: #fff;
  border-radius: 50%;
  width: 26px; height: 26px;
  display: flex; align-items: center; justify-content: center;
  font-size: 1.1rem; font-weight: bold; flex-shrink: 0; margin-top: 2px;
}
.step__text { font-size: 1.4rem; padding-top: 2px; }
</style>

Level: Advanced | **Audience:** Psychoacoustics-focused composer/researcher.

<div class="info-box">
<strong>What this tutorial covers</strong>
How to use Blauert's Bands (frequency-dependent directional perception) to enhance front/back and height perception in Ambisonics — by coupling the ICST Encoder's Y and Z axes to the IEM MultiEQ via OSC.
</div>

For the voice and its directivity perception I conducted experiments with the [Blauert's Bands](https://de.wikipedia.org/wiki/Blauertsche_B%C3%A4nder).

![Ritungsbänder](Richtungsbänder.png)

Thus I coupled Y Front ↔ Back and Z Top ↔ Bottom with the IEM-Multifilter.

![RichtungsWahrnehmung](Richtungswahrnehmung.png)

---

## OSC Routing

### Height (Z-Axis → IEM MultiEQ)

<div class="osc-block">
  <div class="label">OSC OUT · Port 8008</div>
  <span class="arrow">ICST Encoder OSC-Out Height</span> <span class="arrow">→</span> <span class="path">/MultiEQ/filterGain4</span> <span class="param">{sz, -5.3, 0.0, 5.3}</span>
</div>

<div class="osc-block">
  <div class="label">OSC IN · Port 8008</div>
  Z <span class="arrow">→</span> IEM MultiEQ: <span class="path">/MultiEQ/filterGain4</span> <span class="param">(Float)</span>
</div>

### Front/Back (Y-Axis → IEM MultiEQ)

<div class="osc-block">
  <div class="label">OSC OUT · Port 8008</div>
  <span class="arrow">ICST Encoder OSC-Out Front</span> <span class="arrow">→</span> <span class="path">/MultiEQ/filterGain4</span> <span class="param">{sz, -5.3, 0.0, 5.3}</span>
</div>

![OSC Connection](osc-anbindung.png)

---

## IEM MultiEQ — Frequency Bands

**Height (8 kHz boost)**
![Height8000](8000hz.png)

**Front**
![Front](Front.png)

**Back**
![Back](Back.png)

---

## Workflow Steps

<div class="step-grid">
  <div class="step"><div class="step__num">1</div><div class="step__text">How can I make the presence of the front/back and the feeling of highs and lows more audible?</div></div>
  <div class="step"><div class="step__num">2</div><div class="step__text">Create OSC communication between Encoder (Y, Z axes) and IEM MultiEQ (Blauert's Bands).</div></div>
  <div class="step"><div class="step__num">3</div><div class="step__text">Set up a Mono-Encoder FX-Chain "Blauert's Bands-Ambi".</div></div>
</div>

---

### Links
- [Blauert's Bands (Wikipedia)](https://de.wikipedia.org/wiki/Blauertsche_B%C3%A4nder)
- [sengpielaudio.com – Die Bedeutung der Blauert'schen Bänder (PDF)](https://sengpielaudio.com/DieBedeutungDerBlauertschenBaender.pdf)


