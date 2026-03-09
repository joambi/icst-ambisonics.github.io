---
title: Ambisonics 101
description: A compact introduction to Ambisonics, B-format, typical setups, and practical listening workflows.
slug: ambisonics-101
---

Institute for Computer Music and Sound Technology (ICST) Zurich University of the Arts

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

---
<a id="ambisonics-glossary"></a>
## 7. Ambisonics Glossary (Quick Reference)
- **B-Format**: The Ambisonics signal representation that stores spatial information for later decoding.  
  Deep dive (Wiki): [ICST Ambisonics Plugins Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)
- **Ambisonics Order**: Spatial resolution level (e.g. 1st, 3rd, 7th order). Higher order usually means finer localization.  
  Deep dive (Wiki): [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)
- **Encoder**: Converts a mono/stereo source into Ambisonics (B-format) with spatial position data.  
  Deep dive (Wiki): [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)
- **Decoder**: Renders B-format to a target playback system (speaker array, binaural headphone output, etc.).  
  Deep dive (Wiki): [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)
- **Channel Count**: Number of channels used in your Ambisonics path; must be consistent across routing.  
  Deep dive (Wiki): [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)
- **Speaker Layout**: Physical loudspeaker geometry used for decoding and playback.  
  Deep dive (Wiki): [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)
- **Binaural**: Headphone rendering method that simulates spatial direction cues.  
  Deep dive (Wiki): [ICST Ambisonics Plugins Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)
- **OSC (Open Sound Control)**: Message protocol used to control spatial parameters in real time.  
  Deep dive (Wiki): [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)
- **Yaw / Pitch / Roll**: Rotation axes used for orientation and motion control in 3D space.  
  Deep dive (Wiki): [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)
- **Azimuth / Elevation**: Angle coordinates used to describe horizontal and vertical source direction.  
  Deep dive (Wiki): [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)

---

Related next reads:
- [Getting Started with ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)
- [OSC Syntax for the ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
