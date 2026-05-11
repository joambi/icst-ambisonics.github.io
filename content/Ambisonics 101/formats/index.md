---
title: "Ambisonics Formats at a Glance"
description: "A visual reference for Ambisonics formats: A-Format vs B-Format, FuMa vs ambiX, FOA vs HOA, channel counts, and normalization conventions — all in one place."
date: 2026-05-01T00:00:00
draft: false
url: /ambisonics-101/formats/
tags:
  - ambisonics
  - b-format
  - ambix
  - hoa
  - formats
---

<style>
.fmt-intro {
  font-size: 1.05rem;
  margin-bottom: 1.8rem;
  line-height: 1.7;
}
.fmt-section {
  margin: 2.2rem 0;
}
.fmt-section h2 {
  font-size: 1.2rem;
  font-weight: 700;
  margin-bottom: 0.8rem;
  padding-bottom: 0.3rem;
  border-bottom: 2px solid #e0e0e0;
}
.fmt-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.93rem;
  margin: 0.6rem 0 1.2rem 0;
}
.fmt-table th {
  background: #f5f5f5;
  text-align: left;
  padding: 0.55rem 0.8rem;
  font-weight: 700;
  border-bottom: 2px solid #ccc;
}
.fmt-table td {
  padding: 0.5rem 0.8rem;
  border-bottom: 1px solid #e8e8e8;
  vertical-align: top;
  line-height: 1.5;
}
.fmt-table tr:last-child td { border-bottom: none; }
.fmt-table tr:hover td { background: #fafafa; }
.fmt-badge {
  display: inline-block;
  font-size: 0.78rem;
  font-weight: 700;
  padding: 0.15rem 0.5rem;
  border-radius: 3px;
  margin-left: 0.4rem;
}
.fmt-badge--icst { background: #d4edda; color: #155724; }
.fmt-badge--legacy { background: #fff3cd; color: #856404; }
.fmt-badge--raw { background: #cce5ff; color: #004085; }
.fmt-rule {
  background: #f0f7ff;
  border-left: 4px solid #6086b4;
  padding: 0.8rem 1rem;
  margin: 1rem 0;
  border-radius: 0 4px 4px 0;
  font-size: 0.95rem;
}
.fmt-links {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
  margin: 1.6rem 0 0.4rem 0;
}
.fmt-links a {
  font-size: 0.9rem;
  padding: 0.35rem 0.9rem;
  border: 1px solid #6086b4;
  border-radius: 4px;
  color: #6086b4;
  text-decoration: none;
}
.fmt-links a:hover { background: #6086b4; color: #fff; }
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

<div class="fmt-section" id="recommendation">

## ICST Recommendation

<div class="fmt-rule">
  <strong>For all new Ambisonics work:</strong><br>
  Use <strong>ambiX — ACN channel ordering + SN3D normalisation</strong>.<br><br>
  In REAPER: route through a <strong>64-channel B-Format bus</strong>.<br>
  Decode only at the monitoring or final rendering stage.
</div>

This keeps your session open: the same B-Format master can feed loudspeaker decoding, binaural monitoring, archive export, and later rendering for any playback system.

</div>

---

**Go deeper:** [Ambisonics Formats Explained](/learn/ambisonics-formats/) — the full technical reference with all conventions, ACN numbering, and archiving guidelines.

**Back to:** [Ambisonics 101](/ambisonics-101/)
