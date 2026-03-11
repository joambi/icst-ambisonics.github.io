---
title: Ambisonics 101
description: A compact introduction to Ambisonics, B-format, typical setups, and practical listening workflows.
slug: ambisonics-101
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
</style>

<div class="toc-card">
  <div class="toc-card__title">Table of Contents</div>
  <ol>
    <li><a href="#what-is-ambisonics">What Is Ambisonics?</a></li>
    <li><a href="#what-is-b-format">What Is B-Format?</a></li>
    <li><a href="#signal-flow">Signal Flow at a Glance</a></li>
    <li><a href="#typical-setups">Typical Setups</a></li>
    <li><a href="#headphones-vs-loudspeakers">Headphones vs. Loudspeakers</a></li>
    <li><a href="#immersive-vs-atmos">How is Ambisonics Different from Immersive Audio, Dolby Atmos, and Spatial Audio?</a></li>
    <li><a href="#where-to-start-at-icst">Where To Start at ICST</a></li>
    <li><a href="#ambisonics-glossary">Ambisonics Glossary (Quick Reference)</a></li>
  </ol>
</div>

<a id="what-is-ambisonics"></a>
## 1. [What Is Ambisonics?](https://en.wikipedia.org/wiki/Ambisonics)
Ambisonics is a format-agnostic method for describing a spatial 3D sound field. Instead of mixing directly for a fixed loudspeaker layout, you work with a spatial representation that can later be rendered for different playback systems.

<a id="what-is-b-format"></a>
## 2. [What Is B-Format?](https://ambisonic.info/ambisonics/channels.html)

B-format is the core signal format in Ambisonics and carries spatial information. Sources are encoded into B-format and then decoded for a target setup, such as headphones, stereo, or different loudspeaker arrays.

It describes a sound-field state around a listening point using pressure and directional components. In first order, this means:
- `W` is the omnidirectional component, i.e. the pressure/presence in the room.
- `X`, `Y`, and `Z` are directional components along three axes (front-back, left-right, up-down), indicating where the signal comes from.

In the strict classical sense, “B-format” refers to this four-channel first-order format (`W`, `X`, `Y`, `Z`). In an extended sense, the term is also used for higher-order Ambisonics, where all Ambisonics coefficients up to a given order are represented as separate audio channels.

This format can then be decoded to different target systems such as headphones, stereo, or loudspeaker arrays. [1](https://en.wikipedia.org/wiki/Ambisonics) [2](https://ambisonic.info/ambisonics/channels.html)

<a id="signal-flow"></a>
## Signal Flow at a Glance

From source to speaker — this is how Ambisonics works in REAPER with the ICST plugins:

<div class="ambi-sigflow">
<div class="ambi-sigflow__track">
<div class="ambi-sigflow__node ambi-sigflow__node--source">
<i class="fas fa-music ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">Audio Source</div>
<div class="ambi-sigflow__detail">mono track<br>in REAPER</div>
</div>
<div class="ambi-sigflow__connector">
<div class="ambi-sigflow__clabel">plugin insert</div>
<div class="ambi-sigflow__arrow">
<div class="ambi-sigflow__arrow-line"></div>
<span class="ambi-sigflow__arrow-head">▶</span>
</div>
</div>
<div class="ambi-sigflow__node ambi-sigflow__node--plugin">
<i class="fas fa-dot-circle ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">ICST<br>AmbiEncoder</div>
<div class="ambi-sigflow__detail">az · el<br>distance</div>
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
<div class="ambi-sigflow__clabel">bus receive</div>
<div class="ambi-sigflow__arrow">
<div class="ambi-sigflow__arrow-line"></div>
<span class="ambi-sigflow__arrow-head">▶</span>
</div>
</div>
<div class="ambi-sigflow__node ambi-sigflow__node--plugin">
<i class="fas fa-broadcast-tower ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">ICST<br>AmbiDecoder</div>
<div class="ambi-sigflow__detail">speaker layout<br>order · filter</div>
</div>
<div class="ambi-sigflow__connector">
<div class="ambi-sigflow__clabel">renders to</div>
<div class="ambi-sigflow__arrow">
<div class="ambi-sigflow__arrow-line"></div>
<span class="ambi-sigflow__arrow-head">▶</span>
</div>
</div>
<div class="ambi-sigflow__outputs">
<div class="ambi-sigflow__node ambi-sigflow__node--output">
<i class="fas fa-volume-up ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">Speakers</div>
</div>
<div class="ambi-sigflow__or">or</div>
<div class="ambi-sigflow__node ambi-sigflow__node--output">
<i class="fas fa-headphones ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">Binaural</div>
</div>
</div>
</div>
<div class="ambi-sigflow__caption">Multiple sources each have their own AmbiEncoder — all feed into the shared B-Format Bus. Decoding to speakers or headphones happens once at the bus output.</div>
</div>

<a id="typical-setups"></a>
## 3. [Typical Setups](https://en.wikipedia.org/wiki/Ambisonic_reproduction_systems)
Common setups range from small studio rings and dome-like height configurations to custom arrays in composition studios. The same Ambisonics material can be adapted to each of these setups through decoding.

<a id="headphones-vs-loudspeakers"></a>
## 4. Headphones vs. Loudspeakers
Headphones use binaural rendering and are practical for editing, checking translation, and remote collaboration. Loudspeakers provide a physical spatial field in the room and remain essential for composition, depth perception, and artistic evaluation.

<a id="immersive-vs-atmos"></a>
## 5. How is Ambisonics Different from Immersive Audio, Dolby Atmos, and Spatial Audio?

Ambisonics is a form of immersive audio. Immersive audio is a broader term for 3D audio approaches that recreate a full sound field around the listener rather than just left/right playback.

Dolby Atmos and Apple Spatial Audio pursue a similar goal, but are typically object-based workflows. Ambisonics, by contrast, is a channel-based, field-oriented approach. The spatial information is contained in B-format and adapted to a concrete playback system only at decoding stage.

<a id="where-to-start-at-icst"></a>
## 6. Where To Start at ICST

- For Beginners: [Quick Start](/icst-ambisonics-plugins/04_quick_start/)
- Start with the [ICST Ambisonics Plugins](/icst-ambisonics-plugins/) for DAW workflows.
- Use the [ICST Ambisonics Tools](/icst-ambisonics-tools/) for Max/MSP workflows.
- Explore [Ascolta](/blog/ascolta/) for listening practice and references.
- Continue with tutorials and articles in the [Blog & Tutorials](/post/).

Ambisonics 101: Ten Essential Questions Answered  
[Watch on YouTube](https://www.youtube.com/watch?v=95Hr3T5whsU&t=6s)

---
<a id="ambisonics-glossary"></a>
## 7. Ambisonics Glossary (Quick Reference)
- **B-Format**: The Ambisonics signal representation that stores spatial information for later decoding.  
- **Ambisonics Order**: Spatial resolution level (e.g. 1st, 3rd, 7th order). Higher order usually means finer localization.  
- **Encoder**: Converts a mono/stereo source into Ambisonics (B-format) with spatial position data.  
- **Decoder**: Renders B-format to a target playback system (speaker array, binaural headphone output, etc.).  
- **Channel Count**: Number of channels used in your Ambisonics path; must be consistent across routing.  
- **Speaker Layout**: Physical loudspeaker geometry used for decoding and playback.  
- **Binaural**: Headphone rendering method that simulates spatial direction cues.  
- **OSC (Open Sound Control)**: Message protocol used to control spatial parameters in real time.  
- **Yaw / Pitch / Roll**: Rotation axes used for orientation and motion control in 3D space.  
- **Azimuth / Elevation**: Angle coordinates used to describe horizontal and vertical source direction.  

---

Related next reads:
- [Getting Started with ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)
- [OSC Syntax for the ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
