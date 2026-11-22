---
title: Ambisonics 101
description: "What is Ambisonics? A practical introduction to B-format, Higher Order Ambisonics (HOA), loudspeaker decoding, and 3D spatial audio workflows for composers and producers."
slug: ambisonics-101
layout: single
---

<style>
.toc-card {
  border: 1px solid #c8c8c8;
  border-radius: 6px;
  padding: 1rem 1.1rem;
  margin: 0.8rem 0 1.4rem 0;
}
.toc-card__title {
  font-size: 1.25rem;
  font-weight: 700;
  margin-bottom: 0.6rem;
}
.toc-card ol {
  margin: 0;
  padding-left: 1.4rem;
}
.toc-card li {
  margin: 0.25rem 0;
  line-height: 1.4;
}
.toc-card a {
  text-decoration: none;
}
.toc-card a:hover {
  text-decoration: underline;
}
.post__content h1 a,
.post__content h2 a,
.post__content h3 a {
  color: #6086b4 !important;
}
.fig101{margin:1.8rem 0}
.fig101 svg{width:100%;height:auto;max-width:720px;display:block}
.fig101 figcaption{font-size:1.3rem;opacity:.8;margin-top:.6rem}
.post__content table{width:100%;font-size:1.45rem}
.post__content table th,.post__content table td{padding:.9rem 1.2rem;vertical-align:top}
.post__content div[style*="56.25%"]{max-width:560px;width:100%;margin-left:0;margin-right:auto;aspect-ratio:16/9;height:auto !important;padding-bottom:0 !important}
</style>

<div class="toc-card">
  <div class="toc-card__title">Table of Contents</div>
  <ol>
    <li><a href="#what-is-3d-audio">What Is 3D Audio?</a></li>
    <li><a href="#what-is-ambisonics">What Is Ambisonics?</a></li>
    <li><a href="#ambisonics-vs-stereo">Ambisonics vs. Stereo</a></li>
    <li><a href="#what-is-b-format">What Is B-Format?</a></li>
    <li><a href="/learn/ambisonics-formats/">Ambisonics Formats</a></li>
    <li><a href="#signal-flow">Signal Flow at a Glance</a></li>
    <li><a href="#typical-setups">Typical Setups</a></li>
    <li><a href="#headphones-vs-loudspeakers">Headphones vs. Loudspeakers</a></li>
    <li><a href="#immersive-vs-atmos">How is Ambisonics Different from Immersive Audio, Dolby Atmos, and Spatial Audio?</a></li>
    <li><a href="#where-to-start-at-icst">Where To Start at ICST</a></li>
    <li><a href="#ambisonic-microphones">Ambisonic Microphones — A Practical Introduction</a></li>
    <li><a href="/ambisonics-101/glossary/">Ambisonics Glossary (separate page)</a></li>
  </ol>
</div>

<div class="learn-box" style="border:1px solid var(--border-color,#8886);border-left:4px solid #4a8fe0;border-radius:8px;padding:.4rem 1.4rem;margin:1.6rem 0">

**What you will learn**

- What Ambisonics is and how it differs from stereo and channel-based audio
- How the signal flows from encoder through the B-format bus to decoder
- What B-format is and which setups are typical
- Where to start with the ICST tools

</div>

<a id="what-is-3d-audio"></a>
## 1. What Is 3D Audio?
3D audio is the general term for sound that is perceived not only left and right, but also in front, behind, above, below, and in depth. Instead of a flat stereo image, it creates the impression of a surrounding acoustic space.

Ambisonics is one specific way to produce and store 3D audio. Other approaches include binaural audio for headphones and object-based formats such as Dolby Atmos. In that sense, 3D audio is the broader category, and Ambisonics is one method within it.

Two short listening examples:

{{< youtube AVnlw7iIPnE >}}

{{< youtube LKTdCq6AhDI >}}

<a id="what-is-ambisonics"></a>
## 2. What Is Ambisonics?

Further reading: [en.wikipedia.org](https://en.wikipedia.org/wiki/Ambisonics)

Ambisonics is a format-agnostic method for describing a spatial 3D sound field. Instead of mixing directly for a fixed loudspeaker layout, you work with a spatial representation that can later be rendered for different playback systems.

<a id="ambisonics-vs-stereo"></a>
## 3. Ambisonics vs. Stereo

<figure class="fig101">
<svg viewBox="0 0 720 235" role="img" aria-label="Stereo places sounds on a line between two speakers; Ambisonics describes the full sphere around the listener." xmlns="http://www.w3.org/2000/svg"><defs><marker id="a1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker><marker id="a1W" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#8a8a8a"/></marker><marker id="a1X" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#d9534f"/></marker><marker id="a1Y" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#3fa968"/></marker><marker id="a1Z" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#4a8fe0"/></marker></defs><text x="180" y="22" text-anchor="middle" font-size="15" font-weight="600" fill="currentColor" fill-opacity="1">Stereo</text><rect x="74" y="89" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="274" y="89" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><line x1="86" y1="95" x2="274" y2="95" stroke="#4a8fe0" stroke-width="3"/><circle cx="180" cy="170" r="11" fill="none" stroke="currentColor" stroke-width="1.8"/><circle cx="180" cy="157" r="2.5" fill="currentColor"/><text x="180" y="215" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">2 channels: a line between two speakers</text><line x1="180" y1="48" x2="180" y2="48" /><text x="540" y="22" text-anchor="middle" font-size="15" font-weight="600" fill="currentColor" fill-opacity="1">Ambisonics</text><ellipse cx="540" cy="120" rx="80" ry="40" fill="none" stroke="currentColor" stroke-opacity=".35" stroke-dasharray="4 3"/><ellipse cx="540" cy="120" rx="80" ry="80" fill="none" stroke="#4a8fe0" stroke-width="2.5" stroke-opacity=".7"/><rect x="607.910362600903" y="144.6146745892072" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="564.6146745892072" y="187.91036260090294" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="503.3853254107928" y="187.91036260090294" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="460.08963739909706" y="144.6146745892072" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="460.08963739909706" y="83.38532541079283" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="503.3853254107928" y="40.089637399097086" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="564.6146745892072" y="40.08963739909707" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="607.9103626009029" y="83.38532541079277" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><circle cx="540" cy="120" r="11" fill="none" stroke="currentColor" stroke-width="1.8"/><circle cx="540" cy="107" r="2.5" fill="currentColor"/><text x="540" y="215" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">Full sphere around the listener</text><line x1="360" y1="40" x2="360" y2="200" stroke="currentColor" stroke-opacity=".25"/></svg>
<figcaption>Stereo works on a line, Ambisonics on a sphere.</figcaption>
</figure>

Stereo is familiar: two channels, left and right. It creates the illusion of sounds positioned along a horizontal line between two speakers. Add a centre channel and surrounds, and you get 5.1 or 7.1 — but each time you change the loudspeaker layout, you have to re-mix from scratch.

Ambisonics takes a different approach. Instead of mixing directly for a speaker layout, you first encode the spatial sound field as [B-format](/ambisonics-101/glossary/#gl-b-format) (section 4 below). That representation captures where sound comes from across the full 3D sphere — left, right, front, back, above, below. The decoding to actual speakers happens later, and the same file can be decoded for completely different setups without touching the mix.

| | Stereo | Ambisonics |
|---|---|---|
| **Channels** | 2 (L / R) | 4 – 64+ (B-format) |
| **Spatial range** | Left–right line | Full sphere (360° × 180°) |
| **Speaker dependency** | Fixed to layout at mix time | Decoded to any layout later |
| **Re-use** | New mix per setup | One B-format file → many setups |
| **Typical use** | Music, broadcast, everyday listening | Art, research, installation, live, film |

**When does stereo make more sense?** For most music distribution, podcasts, and broadcast, stereo remains the standard — it is compatible with every playback system and requires no special tools. Ambisonics pays off when the spatial dimension of sound matters artistically or technically, or when you need a single master file that can serve multiple playback contexts.

**Listen:** stereo and binaural versions of the same material are available in the <a href="https://www.audiobrewers.com/shop/p/ambisonics-test-library#product-listen" target="_blank" rel="noopener noreferrer">AmbiTest library by AudioBrewers</a> (external). More on <a href="/blog/audio-examples/">Audio Examples</a>.

<a id="what-is-b-format"></a>
## 4. What Is B-Format?

<figure class="fig101">
<svg viewBox="0 0 720 240" role="img" aria-label="First-order B-format: W is the omnidirectional component, X, Y and Z are the three directional axes." xmlns="http://www.w3.org/2000/svg"><defs><marker id="a2" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker><marker id="a2W" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#8a8a8a"/></marker><marker id="a2X" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#d9534f"/></marker><marker id="a2Y" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#3fa968"/></marker><marker id="a2Z" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#4a8fe0"/></marker></defs><circle cx="200" cy="125" r="38" fill="#8a8a8a" fill-opacity=".18" stroke="#8a8a8a" stroke-width="1.5" stroke-dasharray="4 3"/><text x="198" y="130" text-anchor="middle" font-size="16" font-weight="700" fill="currentColor" fill-opacity="1">W</text><line x1="200" y1="125" x2="305" y2="63" stroke="#d9534f" stroke-width="2.4" marker-end="url(#a2X)"/><text x="318" y="57" text-anchor="middle" font-size="16" font-weight="700" fill="currentColor" fill-opacity="1">X</text><line x1="200" y1="125" x2="80" y2="105" stroke="#3fa968" stroke-width="2.4" marker-end="url(#a2Y)"/><text x="68" y="107" text-anchor="middle" font-size="16" font-weight="700" fill="currentColor" fill-opacity="1">Y</text><line x1="200" y1="125" x2="200" y2="15" stroke="#4a8fe0" stroke-width="2.4" marker-end="url(#a2Z)"/><text x="212" y="17" text-anchor="middle" font-size="16" font-weight="700" fill="currentColor" fill-opacity="1">Z</text><rect x="400" y="50" width="34" height="30" rx="6" fill="#8a8a8a" fill-opacity=".2" stroke="#8a8a8a" stroke-width="1.5"/><text x="417" y="71" text-anchor="middle" font-size="15" font-weight="700" fill="currentColor" fill-opacity="1">W</text><text x="448" y="71" text-anchor="start" font-size="14" font-weight="400" fill="currentColor" fill-opacity="1">W: omnidirectional (pressure)</text><rect x="400" y="94" width="34" height="30" rx="6" fill="#d9534f" fill-opacity=".2" stroke="#d9534f" stroke-width="1.5"/><text x="417" y="115" text-anchor="middle" font-size="15" font-weight="700" fill="currentColor" fill-opacity="1">X</text><text x="448" y="115" text-anchor="start" font-size="14" font-weight="400" fill="currentColor" fill-opacity="1">X: front – back</text><rect x="400" y="138" width="34" height="30" rx="6" fill="#3fa968" fill-opacity=".2" stroke="#3fa968" stroke-width="1.5"/><text x="417" y="159" text-anchor="middle" font-size="15" font-weight="700" fill="currentColor" fill-opacity="1">Y</text><text x="448" y="159" text-anchor="start" font-size="14" font-weight="400" fill="currentColor" fill-opacity="1">Y: left – right</text><rect x="400" y="182" width="34" height="30" rx="6" fill="#4a8fe0" fill-opacity=".2" stroke="#4a8fe0" stroke-width="1.5"/><text x="417" y="203" text-anchor="middle" font-size="15" font-weight="700" fill="currentColor" fill-opacity="1">Z</text><text x="448" y="203" text-anchor="start" font-size="14" font-weight="400" fill="currentColor" fill-opacity="1">Z: up – down</text><text x="200" y="225" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">Listener at the centre</text></svg>
<figcaption>First-order B-format: one omnidirectional and three directional components.</figcaption>
</figure>

Further reading: [ambisonic.info](https://ambisonic.info/ambisonics/channels.html)

B-format is the core signal format in Ambisonics and carries spatial information. Sources are encoded into B-format and then decoded for a target setup, such as headphones, stereo, or different loudspeaker arrays.

It describes a sound-field state around a listening point using pressure and directional components. In first order, this means:
- `W` is the omnidirectional component, i.e. the pressure/presence in the room.
- `X`, `Y`, and `Z` are directional components along three axes (front-back, left-right, up-down), indicating where the signal comes from.

In the strict classical sense, "B-format" refers to this four-channel first-order format (`W`, `X`, `Y`, `Z`). In an extended sense, the term is also used for [higher-order Ambisonics](https://en.wikipedia.org/wiki/Ambisonics#Higher-order_Ambisonics), where all Ambisonics coefficients up to a given order are represented as separate audio channels.

This format can then be decoded to different target systems such as headphones, stereo, or loudspeaker arrays. [1](https://en.wikipedia.org/wiki/Ambisonics) [2](https://ambisonic.info/ambisonics/channels.html)

For the practical differences between A-Format, B-Format, FuMa, ambiX, ACN/SN3D, FOA, and HOA, continue with [Ambisonics Formats](/learn/ambisonics-formats/).

<a id="signal-flow"></a>
## 5. Signal Flow at a Glance

<figure class="explainer-video" style="margin:1.8rem 0">
<video controls muted loop playsinline preload="metadata" style="width:100%;max-width:720px;height:auto;display:block;border-radius:8px" src="/videos/signal-flow-en.mp4"></video>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Short video: from a mono signal through the encoder and the B-format bus to the decoder.</figcaption>
</figure>

From source to speaker — this is how Ambisonics works in REAPER with the ICST plugins:

<div class="ambi-sigflow">
<div class="ambi-sigflow__track">
<div class="ambi-sigflow__node ambi-sigflow__node--source">
<i class="fas fa-music ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">Audio source</div>
<div class="ambi-sigflow__detail">Mono track<br>in REAPER</div>
</div>
<div class="ambi-sigflow__connector">
<div class="ambi-sigflow__clabel">Plugin insert</div>
<div class="ambi-sigflow__arrow">
<div class="ambi-sigflow__arrow-line"></div>
<span class="ambi-sigflow__arrow-head">▶</span>
</div>
</div>
<div class="ambi-sigflow__node ambi-sigflow__node--plugin">
<i class="fas fa-dot-circle ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">ICST<br>AmbiEncoder</div>
<div class="ambi-sigflow__detail">Az · El<br>Distance</div>
</div>
<div class="ambi-sigflow__connector">
<div class="ambi-sigflow__clabel">B-Format (ambiX)</div>
<div class="ambi-sigflow__arrow">
<div class="ambi-sigflow__arrow-line"></div>
<span class="ambi-sigflow__arrow-head">▶</span>
</div>
</div>
<div class="ambi-sigflow__node ambi-sigflow__node--bus">
<i class="fas fa-code-branch ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">B-Format<br>Bus</div>
<div class="ambi-sigflow__detail">64 channels<br>7th order</div>
</div>
<div class="ambi-sigflow__connector">
<div class="ambi-sigflow__clabel">Bus receive</div>
<div class="ambi-sigflow__arrow">
<div class="ambi-sigflow__arrow-line"></div>
<span class="ambi-sigflow__arrow-head">▶</span>
</div>
</div>
<div class="ambi-sigflow__node ambi-sigflow__node--plugin">
<i class="fas fa-broadcast-tower ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">ICST<br>AmbiDecoder</div>
<div class="ambi-sigflow__detail">Speaker layout<br>Order · Filter</div>
</div>
<div class="ambi-sigflow__connector">
<div class="ambi-sigflow__clabel">Output</div>
<div class="ambi-sigflow__arrow">
<div class="ambi-sigflow__arrow-line"></div>
<span class="ambi-sigflow__arrow-head">▶</span>
</div>
</div>
<div class="ambi-sigflow__outputs">
<div class="ambi-sigflow__node ambi-sigflow__node--output">
<i class="fas fa-volume-up ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">Loudspeakers</div>
</div>
<div class="ambi-sigflow__or">or</div>
<div class="ambi-sigflow__node ambi-sigflow__node--output">
<i class="fas fa-headphones ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">Binaural</div>
</div>
</div>
</div>
<div class="ambi-sigflow__caption">Each source has its own AmbiEncoder — all of them feed the same B-Format bus. Decoding to loudspeakers or headphones happens once, at the bus output.</div>
</div>

<a id="typical-setups"></a>
## 6. Typical Setups

<figure class="fig101">
<svg viewBox="0 0 720 235" role="img" aria-label="Three typical loudspeaker setups seen from above: studio ring, dome, custom array. The same Ambisonics material is decoded for each." xmlns="http://www.w3.org/2000/svg"><circle cx="120" cy="100" r="62" fill="none" stroke="currentColor" stroke-opacity=".25"/><rect x="171.28053101569978" y="117.72637280663557" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="137.72637280663557" y="151.28053101569978" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="90.27362719336443" y="151.28053101569978" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="56.71946898430022" y="117.72637280663557" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="56.719468984300214" y="70.27362719336443" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="90.2736271933644" y="36.719468984300235" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="137.7263728066356" y="36.71946898430023" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="171.28053101569975" y="70.27362719336439" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><circle cx="120" cy="100" r="9" fill="none" stroke="currentColor" stroke-width="1.8"/><circle cx="120" cy="89" r="2.5" fill="currentColor"/><circle cx="360" cy="100" r="62" fill="none" stroke="currentColor" stroke-opacity=".25"/><rect x="411.2805310156998" y="117.72637280663557" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="377.7263728066356" y="151.28053101569978" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="330.27362719336446" y="151.28053101569978" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="296.7194689843002" y="117.72637280663557" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="296.7194689843002" y="70.27362719336443" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="330.2736271933644" y="36.719468984300235" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="377.7263728066356" y="36.71946898430023" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="411.28053101569975" y="70.27362719336439" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><circle cx="360" cy="100" r="36" fill="none" stroke="currentColor" stroke-opacity=".25" stroke-dasharray="3 3"/><rect x="379.4558441227157" y="119.45584412271572" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="328.5441558772843" y="119.45584412271572" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="328.5441558772843" y="68.54415587728428" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="379.4558441227157" y="68.54415587728428" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="354" y="94" width="12" height="12" rx="2" fill="#4a8fe0" fill-opacity=".85"/><rect x="539" y="49" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="594" y="34" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="654" y="56" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="666" y="109" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="634" y="154" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="574" y="144" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="524" y="119" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="554" y="89" width="12" height="12" rx="2" fill="#4a8fe0" fill-opacity=".85"/><circle cx="600" cy="104" r="7" fill="none" stroke="currentColor" stroke-width="1.6"/><text x="120" y="205" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Studio ring</text><text x="120" y="222" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">8 speakers, horizontal</text><text x="360" y="205" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Dome with height</text><text x="360" y="222" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Ring plus upper ring and zenith</text><text x="600" y="205" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Custom array</text><text x="600" y="222" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Irregular, fitted to the room</text></svg>
<figcaption>The same B-format material feeds each of these setups.</figcaption>
</figure>

Further reading: [en.wikipedia.org](https://en.wikipedia.org/wiki/Ambisonic_reproduction_systems)

Common setups range from small studio rings and dome-like height configurations to custom arrays in composition studios. The same Ambisonics material can be adapted to each of these setups through decoding.

<a id="headphones-vs-loudspeakers"></a>
## 7. Headphones vs. Loudspeakers
Headphones use [binaural rendering](/ambisonics-101/glossary/#gl-binaural) and are practical for editing, checking translation, and remote collaboration. Loudspeakers provide a physical spatial field in the room and remain essential for composition, depth perception, and artistic evaluation.

**Listen instead of just reading:** binaural examples are on [Audio Examples](/blog/audio-examples/); B-format files to decode yourself are in the [B-format archive](/blog/b-format-archive/). Spatial music by artists worldwide is available on [AudioSpace](https://audiospace.soundingfuture.com/tracks), rendered for headphones and speakers (guests can play a few tracks for free, after that a free sign-up is required).

<a id="immersive-vs-atmos"></a>
## 8. How is Ambisonics Different from Immersive Audio, Dolby Atmos, and Spatial Audio?

<figure class="fig101">
<svg viewBox="0 0 720 240" role="img" aria-label="Ambisonics stores a sound field and decodes it later for any layout; Dolby Atmos stores objects with metadata and renders them for the target system." xmlns="http://www.w3.org/2000/svg"><defs><marker id="a4" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker><marker id="a4W" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#8a8a8a"/></marker><marker id="a4X" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#d9534f"/></marker><marker id="a4Y" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#3fa968"/></marker><marker id="a4Z" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#4a8fe0"/></marker></defs><text x="10" y="22" text-anchor="start" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Ambisonics: field-based</text><rect x="10" y="34" width="150" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="85.0" y="67.0" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Sources</text><line x1="162" y1="62" x2="198" y2="62" stroke="currentColor" stroke-width="1.6" marker-end="url(#a4)"/><rect x="200" y="34" width="170" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="285.0" y="60.0" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">B-format</text><text x="285.0" y="77.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">field, no speakers yet</text><line x1="372" y1="62" x2="408" y2="62" stroke="currentColor" stroke-width="1.6" marker-end="url(#a4)"/><rect x="410" y="34" width="110" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="465" y="67" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Decoder</text><line x1="522" y1="62" x2="558" y2="62" stroke="currentColor" stroke-width="1.6" marker-end="url(#a4)"/><rect x="560" y="34" width="150" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="635" y="67" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Layout / headphones</text><text x="10" y="128" text-anchor="start" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Dolby Atmos: object-based</text><rect x="10" y="140" width="150" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="85.0" y="166.0" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Audio objects</text><text x="85.0" y="183.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">audio + metadata</text><line x1="162" y1="168" x2="198" y2="168" stroke="currentColor" stroke-width="1.6" marker-end="url(#a4)"/><rect x="200" y="140" width="170" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="285.0" y="166.0" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Licensed renderer</text><text x="285.0" y="183.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">at delivery</text><line x1="372" y1="168" x2="408" y2="168" stroke="currentColor" stroke-width="1.6" marker-end="url(#a4)"/><rect x="410" y="140" width="300" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="560.0" y="173.0" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Target system (cinema, home, streaming)</text><text x="360" y="222" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">Ambisonics keeps the scene open; Atmos renders it for the target system.</text></svg>
<figcaption>Field-based or object-based: where the spatial decision is made.</figcaption>
</figure>

Immersive audio is a broad term for any 3D audio approach that places sound around — and above — the listener rather than just left and right. Ambisonics, [Dolby Atmos](/ambisonics-101/glossary/#gl-dolby-atmos), and [Apple Spatial Audio](https://en.wikipedia.org/wiki/Spatial_audio) all pursue this goal, but they do so in fundamentally different ways.

**Ambisonics is field-based.** The sound field is encoded as a mathematical representation (B-format) that is independent of any specific speaker layout. The same B-format file can be decoded later for a studio ring, a concert dome, headphones, or stereo. The playback system does not need to be decided at production time.

**Dolby Atmos and Apple Spatial Audio are object-based.** Individual sound sources are stored as audio objects with position metadata. A licensed renderer (Dolby Atmos Renderer, Apple Music infrastructure) places them into a target playback system — whether a cinema, a home theater, or headphones — at delivery time.

| | Ambisonics | Dolby Atmos |
|---|---|---|
| **Spatial approach** | Field-based (B-format) | Object-based (audio + metadata) |
| **Speaker independence** | Yes — one file, many layouts | No — render per target system |
| **Hardware dependency** | Free, open, any speaker array | Requires licensed Dolby renderer |
| **Headphone playback** | Binaural decoder (free tools) | Dolby binaural renderer |
| **Typical tools** | ICST Plugins, IEM, ATK | Pro Tools + Dolby Renderer, Logic, Nuendo |
| **Cost** | Free, open source | Commercial licensing for distribution |
| **Typical use** | Art, research, installation, archiving, live | Film, streaming music, gaming, consumer media |
| **Archivability** | High — B-format is format-agnostic | Medium — tied to Dolby ecosystem |

**When to use which:**
Ambisonics is the better choice when speaker-layout independence, open archiving, or research and artistic use matter. Dolby Atmos is the standard for commercial streaming delivery (Tidal, Apple Music, Amazon Music) and film — if you need to reach those channels, Atmos is the practical requirement.

The two are not mutually exclusive: some workflows produce Ambisonics for archiving and artistic use, and separately deliver a Dolby Atmos render for streaming.

<a id="where-to-start-at-icst"></a>
## 9. Where To Start at ICST

- Your first working session: [First session in REAPER](/post/getting-started-icst-plugins-reaper/)
- For Beginners: [Quick Start](/icst-ambisonics-plugins/04_quick_start/)
- Decide on an order: [Which Ambisonics order do I need?](/post/hoa-ordnung-wahl-praxis/)
- Understand positions: [XYZ and AED coordinate systems](/post/xyz-vs-aed-koordinatensysteme/)
- Look up terms in the [Glossary](/ambisonics-101/glossary/)
- Clarify formats before setup: [Ambisonics Formats](/learn/ambisonics-formats/)
- Start with the [ICST Ambisonics Plugins](/icst-ambisonics-plugins/) for DAW workflows.
- Use the [ICST Ambisonics Tools](/icst-ambisonics-tools/) for Max/MSP workflows.
- Explore [Ascolta](/blog/ascolta/) for listening practice and references.
- Continue with tutorials and articles in the [Blog & Tutorials](/post/).

**Ambisonics 101: Ten Essential Questions Answered**

{{< youtube 95Hr3T5whsU >}}

---
<a id="ambisonic-microphones"></a>
## 10. Ambisonic Microphones — A Practical Introduction

An Ambisonic microphone captures the full-sphere sound field in a single recording. Unlike standard stereo or surround microphones, it uses a tetrahedral arrangement of four (or more) capsules and outputs a raw format called [**A-format**](/ambisonics-101/glossary/#gl-a-format), which must be converted to B-format before use in your DAW.

### A-format and the encoding step

Most tetrahedral microphones output A-format: four raw capsule signals in a tetrahedral geometry. This must be encoded into B-format (W, X, Y, Z for first order) before working with the recording in Ambisonics. Encoding is usually handled by dedicated software from the manufacturer — for example the SoundField by Rode plugin, Zylia Studio, or the Sennheiser A-B Ambisonics plugin — or by third-party tools such as [Harpex](https://harpex.net/) or the IEM AllRADecoder.

Some microphones (e.g. the Zoom H3-VR) handle this internally and output B-format directly.

### Common microphones

| Microphone | Order | Capsules | Output | Notes |
|---|---|---|---|---|
| [Zoom H3-VR](https://zoomcorp.com/en/us/handheld-recorders/handheld-recorders/h3-vr/) | 1st | 4 | A- or B-format | Entry-level, integrated encoder, good for field recording |
| [Sennheiser Ambeo VR Mic](https://www.sennheiser.com/en-us/catalog/products/microphones/ambeo-vr-mic/ambeo-vr-mic-506071) | 1st | 4 | A-format | Widely used, requires Sennheiser A-B Ambisonics plugin for encoding |
| [Rode NT-SF1](https://rode.com/en/microphones/studio-condenser/nt-sf1) | 1st | 4 | A-format | SoundField by Rode software included |
| [Core Sound TetraMic](https://www.core-sound.com/TetraMic/1.php) | 1st | 4 | A-format | Long-established, widely used in field recording and research |
| [Zylia ZM-1](https://www.zylia.co/zylia-zm-1-microphone.html) | 3rd | 19 | A-format | Higher-order, includes Zylia Studio software, good spatial resolution |
| [mh acoustics Eigenmike em32](https://mhacoustics.com/products) | 4th | 32 | A-format | Professional/research grade, very high spatial resolution |

### In the ICST workflow

Any B-format recording — whether from a first-order or [HOA](https://en.wikipedia.org/wiki/Ambisonics#Higher-order_Ambisonics) microphone — can be loaded directly into a REAPER session and decoded with the ICST AmbiDecoder. For HOA recordings, make sure the Ambisonics order in the decoder matches the recording order.

---

Related next reads:
- [Getting Started with ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)
- [Ambisonics Glossary](/ambisonics-101/glossary/)
- [OSC Syntax for the ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
- [Audio Brewers, Beginner: Ambisonics Made Simple](https://www.audiobrewers.com/faq/Blog%20Post%20Title%20One-3zaa9-9fsz6-j2ed5-dj7rh) (external): the same basics from a producer's perspective
- [Audio Brewers, Intermediate: Understanding Ambisonics](https://www.audiobrewers.com/faq/intermediate-understanding-ambisonics) (external): spherical harmonics, order, ambiX vs. FuMa
