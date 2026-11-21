---
title: "Ambisonics Formats Explained: A-Format, B-Format, FuMa, ambiX, FOA and HOA"
description: "A practical reference for Ambisonics formats: A-Format, B-Format, FuMa, ambiX, ACN, SN3D, N3D, FOA, HOA, channel counts, and the ICST recommendation — in tables at a glance."
date: 2026-05-01T00:00:00
draft: false
url: /learn/ambisonics-formats/
aliases:
  - /ambisonics-101/formats/
tags:
  - ambisonics
  - b-format
  - ambix
  - hoa
  - formats
---

<style>
.fmt-intro {
  font-size: 1.55rem;
  margin-bottom: 2.2rem;
  line-height: 1.7;
}
.fmt-section {
  margin: 2.2rem 0;
}
.fmt-section h2 {
  font-size: 2.1rem;
  font-weight: 700;
  margin-bottom: 1.2rem;
  padding-bottom: 0.5rem;
  border-bottom: 2px solid #e0e0e0;
}
.fmt-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 1.45rem;
  margin: 1rem 0 1.8rem 0;
}
.fmt-table th {
  background: #f5f5f5;
  text-align: left;
  padding: 0.9rem 1.2rem;
  font-weight: 700;
  border-bottom: 2px solid #ccc;
}
.fmt-table td {
  padding: 0.9rem 1.2rem;
  border-bottom: 1px solid #e8e8e8;
  vertical-align: top;
  line-height: 1.55;
}
.fmt-table tr:last-child td { border-bottom: none; }
.fmt-table tr:hover td { background: #fafafa; }
.fmt-badge {
  display: inline-block;
  font-size: 1.15rem;
  font-weight: 700;
  padding: 0.2rem 0.7rem;
  border-radius: 3px;
  margin-left: 0.4rem;
}
.fmt-badge--icst { background: #d4edda; color: #155724; }
.fmt-badge--legacy { background: #fff3cd; color: #856404; }
.fmt-badge--raw { background: #cce5ff; color: #004085; }
.fmt-rule {
  background: #f0f7ff;
  border-left: 4px solid #6086b4;
  padding: 1.2rem 1.6rem;
  margin: 1.4rem 0;
  border-radius: 0 4px 4px 0;
  font-size: 1.5rem;
  line-height: 1.6;
}
.fmt-links {
  display: flex;
  gap: 1.2rem;
  flex-wrap: wrap;
  margin: 1.6rem 0 0.4rem 0;
}
.fmt-links a {
  font-size: 1.4rem;
  padding: 0.6rem 1.4rem;
  border: 1px solid #6086b4;
  border-radius: 4px;
  color: #6086b4;
  text-decoration: none;
}
.fmt-links a:hover { background: #6086b4; color: #fff; }

/* ── Dark mode ── */
html.theme--dark .fmt-section h2 {
  border-bottom-color: #3a3a3a;
}
html.theme--dark .fmt-table th {
  background: #1e1e1e;
  border-bottom-color: #3a3a3a;
}
html.theme--dark .fmt-table td {
  border-bottom-color: #2e2e2e;
}
html.theme--dark .fmt-table tr:hover td {
  background: #1a1a1a;
}
html.theme--dark .fmt-rule {
  background: rgba(96, 134, 180, 0.12);
  border-left-color: #6086b4;
  color: inherit;
}
html.theme--dark .fmt-badge--icst {
  background: #0d2b18;
  color: #6fcf97;
}
html.theme--dark .fmt-badge--legacy {
  background: #2e2200;
  color: #f0c040;
}
html.theme--dark .fmt-badge--raw {
  background: #001f3d;
  color: #7ec8e3;
}
html.theme--dark .fmt-links a {
  border-color: #6086b4;
  color: #8aadd4;
}
html.theme--dark .fmt-links a:hover {
  background: #6086b4;
  color: #fff;
}
.fmt-fig{margin:1.8rem 0}
.fmt-fig svg{width:100%;height:auto;max-width:720px;display:block}
.fmt-fig figcaption{font-size:1.3rem;opacity:.8;margin-top:.6rem}
</style>

<p class="fmt-intro">
Ambisonics uses the word <em>format</em> for several different things at once: the raw microphone signal, the spatial encoding convention, the channel ordering, and the normalisation. This page puts all of them side by side.
</p>

<div class="fmt-links">
  <a href="#overview">All formats</a>
  <a href="#a-vs-b">A vs B-Format</a>
  <a href="#fuma-vs-ambix">FuMa vs ambiX</a>
  <a href="#orders">Orders & channels</a>
  <a href="#normalisation">Normalisation</a>
  <a href="#recommendation">ICST recommendation</a>
</div>

---

<div class="fmt-section" id="why">

<div class="learn-box" style="border:1px solid var(--border-color,#8886);border-left:4px solid #4a8fe0;border-radius:8px;padding:.4rem 1.4rem;margin:1.6rem 0">

**What you will learn**

- Tell A-format and B-format apart
- Know the difference between FuMa and ambiX (ACN/SN3D)
- Read channel counts per order
- Choose the right format for your project

</div>

## Why "format" is confusing

Ambisonics uses the word **format** for several different things:

- the raw output of a microphone
- the internal spatial signal in a DAW
- the channel order inside a file
- the normalization convention of the spherical harmonics
- the Ambisonics order, which determines the channel count

That is why "Is this B-Format?" is often not specific enough. A better question is:

> Is this an ambiX B-Format file, with ACN channel ordering and SN3D normalization, and which order does it use?

</div>

---

<div class="fmt-section" id="overview">

## All Formats at a Glance

<table class="fmt-table">
  <thead>
    <tr>
      <th>Format</th>
      <th>What it is</th>
      <th>Channels</th>
      <th>When you encounter it</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>A-Format</strong> <span class="fmt-badge fmt-badge--raw">raw</span></td>
      <td>Raw capsule signals from a tetrahedral microphone — before spatial encoding</td>
      <td>4</td>
      <td>Directly from a mic (Zoom H3-VR, Ambeo, Rode NT-SF1, …). Must be converted before use in a DAW.</td>
    </tr>
    <tr>
      <td><strong>B-Format FOA</strong></td>
      <td>First-Order Ambisonics scene — 4 spherical harmonic channels</td>
      <td>4</td>
      <td>Entry-level recordings, simple setups, older archives</td>
    </tr>
    <tr>
      <td><strong>B-Format HOA-3</strong></td>
      <td>Third-Order Ambisonics — finer spatial resolution</td>
      <td>16</td>
      <td>Zylia ZM-1 microphone output, intermediate productions</td>
    </tr>
    <tr>
      <td><strong>B-Format HOA-7</strong></td>
      <td>Seventh-Order Ambisonics — maximum spatial resolution</td>
      <td>64</td>
      <td>ICST studio standard, large speaker arrays, high-quality archiving</td>
    </tr>
    <tr>
      <td><strong>FuMa</strong> <span class="fmt-badge fmt-badge--legacy">legacy</span></td>
      <td>Older channel ordering and normalisation convention (W, X, Y, Z / MaxN)</td>
      <td>4–36</td>
      <td>Older plugins, historical archives, some first-order workflows</td>
    </tr>
    <tr>
      <td><strong>ambiX</strong> <span class="fmt-badge fmt-badge--icst">ICST standard</span></td>
      <td>Modern convention: ACN channel ordering + SN3D normalisation</td>
      <td>4–64</td>
      <td>All current ICST, IEM, SPARTA, and most modern HOA tools</td>
    </tr>
  </tbody>
</table>

</div>

---

<div class="fmt-section" id="a-vs-b">

## A-Format vs B-Format

<figure class="fmt-fig">
<svg viewBox="0 0 720 210" role="img" aria-label="A-Format: four capsule signals are converted into the B-Format channels W, X, Y, Z" xmlns="http://www.w3.org/2000/svg"><defs><marker id="ah1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="90" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">A-Format (4 capsules)</text><circle cx="50" cy="62" r="26" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="50" y="67" text-anchor="middle" font-size="14" fill="currentColor">LF</text><circle cx="130" cy="62" r="26" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="130" y="67" text-anchor="middle" font-size="14" fill="currentColor">RF</text><circle cx="50" cy="132" r="26" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="50" y="137" text-anchor="middle" font-size="14" fill="currentColor">LB</text><circle cx="130" cy="132" r="26" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="130" y="137" text-anchor="middle" font-size="14" fill="currentColor">RB</text><line x1="150" y1="110" x2="250" y2="110" stroke="currentColor" stroke-width="1.5" marker-end="url(#ah1)"/><rect x="255" y="70" width="170" height="80" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="340.0" y="111.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">A→B conversion</text><text x="340.0" y="126.0" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".75">matrix + filters</text><line x1="430" y1="110" x2="520" y2="110" stroke="currentColor" stroke-width="1.5" marker-end="url(#ah1)"/><text x="615" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">B-Format (FOA)</text><rect x="530" y="36" width="170" height="34" rx="8" stroke="#8a8a8a" fill="#8a8a8a" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="58.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">W</text><rect x="530" y="76" width="170" height="34" rx="8" stroke="#d9534f" fill="#d9534f" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="98.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">X</text><rect x="530" y="116" width="170" height="34" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="138.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Y</text><rect x="530" y="156" width="170" height="34" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="178.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Z</text></svg>
<figcaption>From microphone capsules to the B-Format scene: the A→B step is specific to each microphone.</figcaption>
</figure>

<table class="fmt-table">
  <thead>
    <tr>
      <th></th>
      <th>A-Format</th>
      <th>B-Format</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>What it contains</strong></td>
      <td>Raw capsule signals (microphone-specific)</td>
      <td>Spatial sound-field representation (spherical harmonics)</td>
    </tr>
    <tr>
      <td><strong>Channels (1st order)</strong></td>
      <td>4</td>
      <td>4 (FOA) up to 64 (HOA-7)</td>
    </tr>
    <tr>
      <td><strong>Transferable between tools?</strong></td>
      <td>No — tied to the microphone model</td>
      <td>Yes — standard exchange format</td>
    </tr>
    <tr>
      <td><strong>Can be decoded directly?</strong></td>
      <td>No — must be encoded to B-Format first</td>
      <td>Yes — feeds decoder or binaural renderer directly</td>
    </tr>
    <tr>
      <td><strong>Typical source</strong></td>
      <td>Ambisonic microphone output</td>
      <td>DAW B-Format bus, archive file, encoder output</td>
    </tr>
  </tbody>
</table>

<div class="fmt-rule">
  <strong>Practical rule:</strong> A-Format comes from the microphone and must be converted first. B-Format is the spatial scene you route, decode, archive, and render.
</div>

</div>

---

<div class="fmt-section" id="fuma-vs-ambix">

## FuMa vs ambiX

<figure class="fmt-fig">
<svg viewBox="0 0 720 230" role="img" aria-label="Channel order of first-order Ambisonics: FuMa W X Y Z versus ambiX ACN W Y Z X, same components connected by lines" xmlns="http://www.w3.org/2000/svg"><text x="10" y="55" font-size="14" font-weight="600" fill="currentColor">FuMa</text><text x="10" y="73" font-size="11" fill="currentColor" fill-opacity=".75">W X Y Z</text><text x="10" y="175" font-size="14" font-weight="600" fill="currentColor">ambiX</text><text x="10" y="193" font-size="11" fill="currentColor" fill-opacity=".75">ACN / SN3D</text><text x="10" y="22" font-size="12" fill="currentColor" fill-opacity=".8">Channel position (0 – 3)</text><text x="240" y="22" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".8">0</text><rect x="190" y="34" width="100" height="44" rx="8" stroke="#8a8a8a" fill="#8a8a8a" fill-opacity=".18" stroke-width="1.5"/><text x="240.0" y="57.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">W</text><rect x="190" y="152" width="100" height="44" rx="8" stroke="#8a8a8a" fill="#8a8a8a" fill-opacity=".18" stroke-width="1.5"/><text x="240.0" y="179.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">W</text><text x="365" y="22" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".8">1</text><rect x="315" y="34" width="100" height="44" rx="8" stroke="#d9534f" fill="#d9534f" fill-opacity=".18" stroke-width="1.5"/><text x="365.0" y="61.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">X</text><rect x="315" y="152" width="100" height="44" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".18" stroke-width="1.5"/><text x="365.0" y="179.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Y</text><text x="490" y="22" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".8">2</text><rect x="440" y="34" width="100" height="44" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".18" stroke-width="1.5"/><text x="490.0" y="61.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Y</text><rect x="440" y="152" width="100" height="44" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".18" stroke-width="1.5"/><text x="490.0" y="179.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Z</text><text x="615" y="22" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".8">3</text><rect x="565" y="34" width="100" height="44" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="61.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">Z</text><rect x="565" y="152" width="100" height="44" rx="8" stroke="#d9534f" fill="#d9534f" fill-opacity=".18" stroke-width="1.5"/><text x="615.0" y="179.0" text-anchor="middle" font-size="16" font-weight="600" fill="currentColor">X</text><line x1="240" y1="80" x2="240" y2="150" stroke="#8a8a8a" stroke-width="2" stroke-dasharray="0"/><text x="250" y="120" font-size="11" fill="currentColor" fill-opacity=".8">W is 3 dB lower</text><line x1="365" y1="80" x2="615" y2="150" stroke="#d9534f" stroke-width="2" stroke-dasharray="5 3"/><line x1="490" y1="80" x2="365" y2="150" stroke="#3fa968" stroke-width="2" stroke-dasharray="5 3"/><line x1="615" y1="80" x2="490" y2="150" stroke="#4a8fe0" stroke-width="2" stroke-dasharray="5 3"/><text x="360" y="222" text-anchor="middle" font-size="12" fill="currentColor" fill-opacity=".8">Same components, different order. In ambiX the W channel is not attenuated by 3 dB.</text></svg>
<figcaption>Channel order of first-order material: the same four components, in a different order.</figcaption>
</figure>

<table class="fmt-table">
  <thead>
    <tr>
      <th></th>
      <th>FuMa <span class="fmt-badge fmt-badge--legacy">legacy</span></th>
      <th>ambiX <span class="fmt-badge fmt-badge--icst">ICST standard</span></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Channel ordering</strong></td>
      <td>FuMa (W, X, Y, Z, …)</td>
      <td>ACN (0, 1, 2, 3, …)</td>
    </tr>
    <tr>
      <td><strong>Normalisation</strong></td>
      <td>MaxN</td>
      <td>SN3D</td>
    </tr>
    <tr>
      <td><strong>Supported orders</strong></td>
      <td>Mainly 1st order (some tools up to 3rd)</td>
      <td>All orders up to HOA-7 and beyond</td>
    </tr>
    <tr>
      <td><strong>Where you see it</strong></td>
      <td>Older plug-ins (e.g. classic Ambisonic Toolkit versions, legacy archives)</td>
      <td>ICST, IEM, SPARTA, REAPER, modern export pipelines</td>
    </tr>
    <tr>
      <td><strong>File format</strong></td>
      <td>WAV (standard multichannel)</td>
      <td>WAV or RF64 (for files > 4 GB)</td>
    </tr>
    <tr>
      <td><strong>ICST recommendation</strong></td>
      <td>Only when a tool specifically requires it</td>
      <td>✓ Use by default</td>
    </tr>
  </tbody>
</table>

<div class="fmt-rule">
  <strong>If in doubt:</strong> choose <code>ACN / SN3D</code> — that is ambiX, and it is what every current ICST tool expects.
</div>

</div>

---

<div class="fmt-section" id="orders">

## Orders & Channel Counts

<figure data-gen="g20" style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Channel counts for orders 1, 2... up to 7 with their ACN index ranges" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arx1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="360" y="24" text-anchor="middle" font-weight="600">Each order contains all lower orders</text><text x="100" y="61" text-anchor="end" font-weight="600" fill="#4a8fe0" font-size="13">N = 1</text><rect x="120" y="44" width="35.0" height="26" rx="4" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><text x="163.0" y="62" text-anchor="start" font-size="11.5">4 ch · ACN 0–3</text><text x="100" y="97" text-anchor="end" font-weight="600" fill="#4a8fe0" font-size="13">N = 2</text><rect x="120" y="80" width="78.8" height="26" rx="4" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><text x="206.75" y="98" text-anchor="start" font-size="11.5">9 ch · ACN 0–8</text><text x="100" y="133" text-anchor="end" font-weight="600" fill="#3fa968" font-size="13">N = 3</text><rect x="120" y="116" width="140.0" height="26" rx="4" fill="#3fa968" fill-opacity=".3" stroke="#3fa968"/><text x="268.0" y="134" text-anchor="start" font-size="11.5">16 ch · ACN 0–15</text><text x="100" y="169" text-anchor="end" font-weight="600" fill="#d9a441" font-size="13">N = 5</text><rect x="120" y="152" width="315.0" height="26" rx="4" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="443.0" y="170" text-anchor="start" font-size="11.5">36 ch · ACN 0–35</text><text x="100" y="205" text-anchor="end" font-weight="600" fill="#d9534f" font-size="13">N = 7</text><rect x="120" y="188" width="560.0" height="26" rx="4" fill="#d9534f" fill-opacity=".3" stroke="#d9534f"/><text x="688.0" y="206" text-anchor="start" font-size="11.5">64 ch · ACN 0–63</text><text x="360" y="236" text-anchor="middle" font-size="11">Lower orders are the first channels of higher orders.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">With ACN numbering a lower order is simply the first channels of a higher one. Reducing the order means dropping channels.</figcaption>
</figure>



The number of channels in a B-Format signal is determined by the Ambisonics order:

**channels = (order + 1)²**

<table class="fmt-table">
  <thead>
    <tr>
      <th>Order</th>
      <th>Name</th>
      <th>Channels</th>
      <th>Spatial resolution</th>
      <th>Typical use</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>1</strong></td>
      <td>FOA</td>
      <td>4</td>
      <td>Basic</td>
      <td>Entry-level recording, simple setups, most Ambisonic microphones</td>
    </tr>
    <tr>
      <td><strong>2</strong></td>
      <td>HOA-2</td>
      <td>9</td>
      <td>Moderate</td>
      <td>Intermediate compositions, some older HOA tools</td>
    </tr>
    <tr>
      <td><strong>3</strong></td>
      <td>HOA-3</td>
      <td>16</td>
      <td>Good</td>
      <td>Zylia ZM-1 output, standard HOA productions</td>
    </tr>
    <tr>
      <td><strong>4</strong></td>
      <td>HOA-4</td>
      <td>25</td>
      <td>High</td>
      <td>Research, large arrays</td>
    </tr>
    <tr>
      <td><strong>5</strong></td>
      <td>HOA-5</td>
      <td>36</td>
      <td>Very high</td>
      <td>Eigenmike em32, large dome setups</td>
    </tr>
    <tr>
      <td><strong>6</strong></td>
      <td>HOA-6</td>
      <td>49</td>
      <td>Very high</td>
      <td>Specialised research applications</td>
    </tr>
    <tr>
      <td><strong>7</strong></td>
      <td>HOA-7</td>
      <td>64</td>
      <td>Maximum</td>
      <td><strong>ICST studio standard</strong> — 64-channel B-Format bus in REAPER</td>
    </tr>
  </tbody>
</table>

<div class="fmt-rule">
  In REAPER, the ICST workflow uses a <strong>64-channel B-Format bus</strong>. This ensures that no HOA channels are silently lost, regardless of which order you are working in.
</div>

</div>

---

<div class="fmt-section" id="normalisation">

## Normalisation Conventions

<figure data-gen="g20" style="margin:1.8rem 0">
<svg viewBox="0 0 720 260" role="img" aria-label="Gain factor between SN3D and N3D normalisation by order" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arx2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="360" y="24" text-anchor="middle" font-weight="600">Same signal, different scaling per order n</text><line x1="100" y1="210" x2="680" y2="210" stroke="currentColor" stroke-width="1.2" opacity="1"/><rect x="150" y="162.0" width="40" height="48.0" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><rect x="196" y="162.0" width="40" height="48.0" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="170" y="156" text-anchor="middle" fill="#4a8fe0" font-size="11">1</text><text x="216" y="156.0" text-anchor="middle" fill="#d9a441" font-size="11">1.00</text><text x="193" y="228" text-anchor="middle" font-weight="600" font-size="12">n = 0</text><rect x="280" y="162.0" width="40" height="48.0" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><rect x="326" y="126.9" width="40" height="83.1" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="300" y="156" text-anchor="middle" fill="#4a8fe0" font-size="11">1</text><text x="346" y="120.86156123669389" text-anchor="middle" fill="#d9a441" font-size="11">1.73</text><text x="323" y="228" text-anchor="middle" font-weight="600" font-size="12">n = 1</text><rect x="410" y="162.0" width="40" height="48.0" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><rect x="456" y="102.7" width="40" height="107.3" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="430" y="156" text-anchor="middle" fill="#4a8fe0" font-size="11">1</text><text x="476" y="96.66873708001009" text-anchor="middle" fill="#d9a441" font-size="11">2.24</text><text x="453" y="228" text-anchor="middle" font-weight="600" font-size="12">n = 2</text><rect x="540" y="162.0" width="40" height="48.0" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><rect x="586" y="83.0" width="40" height="127.0" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="560" y="156" text-anchor="middle" fill="#4a8fe0" font-size="11">1</text><text x="606" y="77.00393706889965" text-anchor="middle" fill="#d9a441" font-size="11">2.65</text><text x="583" y="228" text-anchor="middle" font-weight="600" font-size="12">n = 3</text><rect x="490" y="34" width="170" height="40" rx="6" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1" opacity="0.4"/><rect x="502" y="45" width="14" height="14" fill="#4a8fe0" fill-opacity=".3" stroke="#4a8fe0"/><text x="522" y="57" text-anchor="start" font-size="12">SN3D</text><rect x="572" y="45" width="14" height="14" fill="#d9a441" fill-opacity=".3" stroke="#d9a441"/><text x="592" y="57" text-anchor="start" font-size="12">N3D</text><text x="360" y="248" text-anchor="middle" font-weight="600" font-size="12">N3D = SN3D × √(2n+1)</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">SN3D keeps all orders at the same reference gain. N3D scales order n up by √(2n+1). Mixing the two without conversion changes the balance between orders.</figcaption>
</figure>



Normalisation defines how the amplitude of each spherical harmonic component is scaled. Using the wrong convention between encoder and decoder produces incorrect spatial rendering — even if the channel order is right.

<table class="fmt-table">
  <thead>
    <tr>
      <th>Convention</th>
      <th>Full name</th>
      <th>Used in</th>
      <th>Notes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>SN3D</strong> <span class="fmt-badge fmt-badge--icst">ICST standard</span></td>
      <td>Schmidt Semi-Normalised 3D</td>
      <td>ambiX, ICST, IEM, SPARTA, most modern HOA tools</td>
      <td>De-facto standard for production and exchange. Use this.</td>
    </tr>
    <tr>
      <td><strong>N3D</strong></td>
      <td>Full 3D Normalised</td>
      <td>Some research tools, mathematical contexts</td>
      <td>Differs from SN3D by a constant factor per order. Common in academic literature.</td>
    </tr>
    <tr>
      <td><strong>MaxN</strong> <span class="fmt-badge fmt-badge--legacy">legacy</span></td>
      <td>Maximum Normalised</td>
      <td>FuMa convention</td>
      <td>Normalises each component to its peak value. Used in older systems and archives.</td>
    </tr>
  </tbody>
</table>

</div>

---

<div class="fmt-section" id="scene">

## Scene-based vs channel-based

<figure data-gen="g20" style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Channel-based versus scene-based audio" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arx3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="180" y="22" text-anchor="middle" font-weight="600" font-size="14">Channel-based</text><text x="540" y="22" text-anchor="middle" font-weight="600" font-size="14">Scene-based (Ambisonics)</text><line x1="360" y1="36" x2="360" y2="285" stroke="currentColor" stroke-width="1" opacity="0.25" stroke-dasharray="4 4"/><rect x="20" y="50" width="60" height="30" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="50" y="70" text-anchor="middle" font-size="11.5">Ch 1</text><rect x="20" y="90" width="60" height="30" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="50" y="110" text-anchor="middle" font-size="11.5">Ch 2</text><rect x="20" y="130" width="60" height="30" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="50" y="150" text-anchor="middle" font-size="11.5">Ch 3</text><rect x="120" y="70" width="70" height="70" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="0.5"/><text x="155" y="100" text-anchor="middle" font-size="11.5">Mix</text><text x="155" y="116" text-anchor="middle" font-size="10">for one layout</text><line x1="80" y1="65" x2="120" y2="85" stroke="currentColor" stroke-width="1.1" opacity="0.7"/><line x1="80" y1="105" x2="120" y2="95" stroke="currentColor" stroke-width="1.1" opacity="0.7"/><line x1="80" y1="145" x2="120" y2="105" stroke="currentColor" stroke-width="1.1" opacity="0.7"/><line x1="190" y1="105" x2="230" y2="150" stroke="currentColor" stroke-width="1.5" opacity="1" marker-end="url(#arx3)"/><circle cx="250" cy="170" r="7" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="290" cy="150" r="7" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="330" cy="170" r="7" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="260" cy="215" r="7" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="320" cy="215" r="7" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><text x="290" y="250" text-anchor="middle" font-size="11.5">5 fixed loudspeakers</text><text x="290" y="268" text-anchor="middle" font-size="10.5">Ch 1 means: this speaker.</text><rect x="385" y="40" width="80" height="26" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="425" y="58" text-anchor="middle" font-size="11">Source 1</text><line x1="465" y1="53" x2="495" y2="97" stroke="currentColor" stroke-width="1" opacity="0.7"/><rect x="385" y="74" width="80" height="26" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="425" y="92" text-anchor="middle" font-size="11">Source 2</text><line x1="465" y1="87" x2="495" y2="97" stroke="currentColor" stroke-width="1" opacity="0.7"/><rect x="385" y="108" width="80" height="26" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="425" y="126" text-anchor="middle" font-size="11">Source 3</text><line x1="465" y1="121" x2="495" y2="97" stroke="currentColor" stroke-width="1" opacity="0.7"/><rect x="495" y="75" width="80" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="535" y="93" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="12">B-format</text><text x="535" y="109" text-anchor="middle" font-size="10">scene</text><line x1="535" y1="119" x2="535" y2="142" stroke="currentColor" stroke-width="1.2" opacity="0.5"/><line x1="535" y1="128" x2="605" y2="164" stroke="currentColor" stroke-width="1.2" opacity="0.8" marker-end="url(#arx3)"/><rect x="605" y="150" width="100" height="28" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="655" y="168" text-anchor="middle" font-size="11">Dome</text><line x1="535" y1="128" x2="605" y2="202" stroke="currentColor" stroke-width="1.2" opacity="0.8" marker-end="url(#arx3)"/><rect x="605" y="188" width="100" height="28" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="655" y="206" text-anchor="middle" font-size="11">Studio array</text><line x1="535" y1="128" x2="605" y2="240" stroke="currentColor" stroke-width="1.2" opacity="0.8" marker-end="url(#arx3)"/><rect x="605" y="226" width="100" height="28" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="655" y="244" text-anchor="middle" font-size="11">Headphones</text><text x="535" y="278" text-anchor="middle" font-size="10.5">One scene, decoded for each system.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">A channel is a speaker feed in channel-based audio. In Ambisonics it is a component of the sound field, and the decoder decides how the scene reaches each system.</figcaption>
</figure>



Ambisonics is **scene-based**: the channels are not speaker feeds but components of a spatial sound-field representation. In **channel-based** audio, channel 1 means left speaker, channel 2 right speaker, and so on.

In Ambisonics the decoder decides how the scene becomes loudspeaker signals or binaural output. That is why the same B-Format master can be rendered for a dome, an octagon, a studio array, headphones, or stereo.

</div>

---

<div class="fmt-section" id="recommendation">

## ICST Recommendation

<figure data-gen="g20" style="margin:1.8rem 0">
<svg viewBox="0 0 720 290" role="img" aria-label="ICST recommendation: one B-format bus, decode only at monitoring or final render" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="arx4" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="100" width="220" height="60" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="125" y="125" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="13">64-channel B-format bus</text><text x="125" y="145" text-anchor="middle" font-size="11">ambiX · ACN · SN3D</text><line x1="235" y1="130" x2="300" y2="46" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#arx4)"/><rect x="305" y="24" width="170" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="390" y="51" text-anchor="middle" font-weight="600" font-size="12">Loudspeaker decode</text><line x1="235" y1="130" x2="300" y2="104" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#arx4)"/><rect x="305" y="82" width="170" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="390" y="109" text-anchor="middle" font-weight="600" font-size="12">Binaural monitor</text><line x1="235" y1="130" x2="300" y2="162" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#arx4)"/><rect x="305" y="140" width="170" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="390" y="167" text-anchor="middle" font-weight="600" font-size="12">Archive export</text><line x1="235" y1="130" x2="300" y2="220" stroke="currentColor" stroke-width="1.4" opacity="0.8" marker-end="url(#arx4)"/><rect x="305" y="198" width="170" height="44" rx="8" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="390" y="225" text-anchor="middle" font-weight="600" font-size="12">Render for other systems</text><text x="560" y="40" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="13">decoding</text><line x1="520" y1="48" x2="490" y2="48" stroke="#3fa968" stroke-width="1.4" opacity="1" marker-end="url(#arx4)"/><text x="560" y="56" text-anchor="middle" font-size="11">happens here</text><text x="360" y="282" text-anchor="middle" font-size="11">Keep the session open: the same B-format master feeds every output.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Stay in ambiX with the B-format bus and decode only at the end. The master stays open for every future system.</figcaption>
</figure>



<div class="fmt-rule">
  <strong>For all new Ambisonics work:</strong><br>
  Use <strong>ambiX — ACN channel ordering + SN3D normalisation</strong>.<br><br>
  In REAPER: route through a <strong>64-channel B-Format bus</strong>.<br>
  Decode only at the monitoring or final rendering stage.
</div>

This keeps your session open: the same B-Format master can feed loudspeaker decoding, binaural monitoring, archive export, and later rendering for any playback system.

</div>

---

<div class="fmt-section" id="checklist">

## Checklist: Which format should I use?

**ambiX B-Format, ACN/SN3D** when you start a new production, work with ICST, IEM, SPARTA or other modern HOA tools, export an archive master, or need reliable exchange between DAWs and plugins.

**A-Format** only for raw microphone recordings that still need the manufacturer-specific A-to-B conversion.

**FuMa** only when an older tool or archive requires it, or when you convert historical first-order material.

Always document: order, channel count, channel ordering, normalization, sample rate and bit depth, and the decoder or renderer used for monitoring.

</div>

---

## Related pages

- [Ambisonics 101](/ambisonics-101/)
- [ICST B-Format Archive](/blog/b-format-archive/)
- [ICST Encoders](/icst-ambisonics-plugins/10_icst_encoders/)
- [ICST Decoder](/icst-ambisonics-plugins/08_icst_decoder/)
- [Render B-Format in REAPER](/icst-ambisonics-plugins/12_render_bformat/)
- [Which Ambisonics order do I need?](/post/hoa-ordnung-wahl-praxis/)
- [First session in REAPER](/post/getting-started-icst-plugins-reaper/)
- [Glossary](/ambisonics-101/glossary/)
