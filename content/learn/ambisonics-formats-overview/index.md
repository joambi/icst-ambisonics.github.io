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

<div class="fmt-section" id="scene">

## Scene-based vs channel-based

Ambisonics is **scene-based**: the channels are not speaker feeds but components of a spatial sound-field representation. In **channel-based** audio, channel 1 means left speaker, channel 2 right speaker, and so on.

In Ambisonics the decoder decides how the scene becomes loudspeaker signals or binaural output. That is why the same B-Format master can be rendered for a dome, an octagon, a studio array, headphones, or stereo.

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
