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
    <li><a href="#ambisonics-vs-stereo">Ambisonics vs. Stereo</a></li>
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

<a id="ambisonics-vs-stereo"></a>
## 2. Ambisonics vs. Stereo

Stereo is familiar: two channels, left and right. It creates the illusion of sounds positioned along a horizontal line between two speakers. Add a centre channel and surrounds, and you get 5.1 or 7.1 — but each time you change the loudspeaker layout, you have to re-mix from scratch.

Ambisonics takes a different approach. Instead of mixing directly for a speaker layout, you first encode the spatial sound field as B-format (see section 3 below). That representation captures where sound comes from across the full 3D sphere — left, right, front, back, above, below. The decoding to actual speakers happens later, and the same file can be decoded for completely different setups without touching the mix.

| | Stereo | Ambisonics |
|---|---|---|
| **Channels** | 2 (L / R) | 4 – 64+ (B-format) |
| **Spatial range** | Left–right line | Full sphere (360° × 180°) |
| **Speaker dependency** | Fixed to layout at mix time | Decoded to any layout later |
| **Re-use** | New mix per setup | One B-format file → many setups |
| **Typical use** | Music, broadcast, everyday listening | Art, research, installation, live, film |

**When does stereo make more sense?** For most music distribution, podcasts, and broadcast, stereo remains the standard — it is compatible with every playback system and requires no special tools. Ambisonics pays off when the spatial dimension of sound matters artistically or technically, or when you need a single master file that can serve multiple playback contexts.

<a id="what-is-b-format"></a>
## 3. [What Is B-Format?](https://ambisonic.info/ambisonics/channels.html)

B-format is the core signal format in Ambisonics and carries spatial information. Sources are encoded into B-format and then decoded for a target setup, such as headphones, stereo, or different loudspeaker arrays.

It describes a sound-field state around a listening point using pressure and directional components. In first order, this means:
- `W` is the omnidirectional component, i.e. the pressure/presence in the room.
- `X`, `Y`, and `Z` are directional components along three axes (front-back, left-right, up-down), indicating where the signal comes from.

In the strict classical sense, “B-format” refers to this four-channel first-order format (`W`, `X`, `Y`, `Z`). In an extended sense, the term is also used for higher-order Ambisonics, where all Ambisonics coefficients up to a given order are represented as separate audio channels.

This format can then be decoded to different target systems such as headphones, stereo, or loudspeaker arrays. [1](https://en.wikipedia.org/wiki/Ambisonics) [2](https://ambisonic.info/ambisonics/channels.html)

<a id="signal-flow"></a>
## Signal Flow at a Glance

From source to speaker — this is how Ambisonics works in REAPER with the ICST plugins:

![Ambisonics Signal Flow — Single Source](/images/signalflow-simple.svg)

*Single source: mono track → AmbiEncoder (az/el/dist) → B-Format Bus → AmbiDecoder → Speakers or Binaural.*

![Ambisonics Signal Flow — Multi-Source (ICST MultiEncoder)](/images/signalflow-multi.svg)

*Multi-source: up to 64 sources feed simultaneously into the ICST MultiEncoder → shared B-Format Bus → decoded once.*

<a id="typical-setups"></a>
## 5. [Typical Setups](https://en.wikipedia.org/wiki/Ambisonic_reproduction_systems)
Common setups range from small studio rings and dome-like height configurations to custom arrays in composition studios. The same Ambisonics material can be adapted to each of these setups through decoding.

<a id="headphones-vs-loudspeakers"></a>
## 6. Headphones vs. Loudspeakers
Headphones use binaural rendering and are practical for editing, checking translation, and remote collaboration. Loudspeakers provide a physical spatial field in the room and remain essential for composition, depth perception, and artistic evaluation.

<a id="immersive-vs-atmos"></a>
## 7. How is Ambisonics Different from Immersive Audio, Dolby Atmos, and Spatial Audio?

Immersive audio is a broad term for any 3D audio approach that places sound around — and above — the listener rather than just left and right. Ambisonics, Dolby Atmos, and Apple Spatial Audio all pursue this goal, but they do so in fundamentally different ways.

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
## 8. Where To Start at ICST

- For Beginners: [Quick Start](/icst-ambisonics-plugins/04_quick_start/)
- Start with the [ICST Ambisonics Plugins](/icst-ambisonics-plugins/) for DAW workflows.
- Use the [ICST Ambisonics Tools](/icst-ambisonics-tools/) for Max/MSP workflows.
- Explore [Ascolta](/blog/ascolta/) for listening practice and references.
- Continue with tutorials and articles in the [Blog & Tutorials](/post/).

**Ambisonics 101: Ten Essential Questions Answered**

{{< youtube 95Hr3T5whsU >}}

---
<a id="ambisonics-glossary"></a>
## 9. Ambisonics Glossary (Quick Reference)
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
