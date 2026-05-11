---
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
    <li><a href="#what-is-3d-audio">What Is 3D Audio?</a></li>
    <li><a href="#what-is-ambisonics">What Is Ambisonics?</a></li>
    <li><a href="#ambisonics-vs-stereo">Ambisonics vs. Stereo</a></li>
    <li><a href="#what-is-b-format">What Is B-Format?</a></li>
    <li><a href="/ambisonics-101/formats/">Ambisonics Formats at a Glance</a></li>
    <li><a href="#signal-flow">Signal Flow at a Glance</a></li>
    <li><a href="#typical-setups">Typical Setups</a></li>
    <li><a href="#headphones-vs-loudspeakers">Headphones vs. Loudspeakers</a></li>
    <li><a href="#immersive-vs-atmos">How is Ambisonics Different from Immersive Audio, Dolby Atmos, and Spatial Audio?</a></li>
    <li><a href="#where-to-start-at-icst">Where To Start at ICST</a></li>
    <li><a href="#ambisonic-microphones">Ambisonic Microphones — A Practical Introduction</a></li>
    <li><a href="#ambisonics-glossary">Ambisonics Glossary (Quick Reference)</a></li>
  </ol>
</div>

<a id="what-is-3d-audio"></a>
## 1. What Is 3D Audio?
3D audio is the general term for sound that is perceived not only left and right, but also in front, behind, above, below, and in depth. Instead of a flat stereo image, it creates the impression of a surrounding acoustic space.

Ambisonics is one specific way to produce and store 3D audio. Other approaches include binaural audio for headphones and object-based formats such as Dolby Atmos. In that sense, 3D audio is the broader category, and Ambisonics is one method within it.

Two short listening examples:

{{< youtube AVnlw7iIPnE >}}

{{< youtube LKTdCq6AhDI >}}

<a id="what-is-ambisonics"></a>
## 2. [What Is Ambisonics?](https://en.wikipedia.org/wiki/Ambisonics)
Ambisonics is a format-agnostic method for describing a spatial 3D sound field. Instead of mixing directly for a fixed loudspeaker layout, you work with a spatial representation that can later be rendered for different playback systems.

<a id="ambisonics-vs-stereo"></a>
## 3. Ambisonics vs. Stereo

Stereo is familiar: two channels, left and right. It creates the illusion of sounds positioned along a horizontal line between two speakers. Add a centre channel and surrounds, and you get 5.1 or 7.1 — but each time you change the loudspeaker layout, you have to re-mix from scratch.

Ambisonics takes a different approach. Instead of mixing directly for a speaker layout, you first encode the spatial sound field as [B-format](#gl-b-format) (see section 3 below). That representation captures where sound comes from across the full 3D sphere — left, right, front, back, above, below. The decoding to actual speakers happens later, and the same file can be decoded for completely different setups without touching the mix.

| | Stereo | Ambisonics |
|---|---|---|
| **Channels** | 2 (L / R) | 4 – 64+ (B-format) |
| **Spatial range** | Left–right line | Full sphere (360° × 180°) |
| **Speaker dependency** | Fixed to layout at mix time | Decoded to any layout later |
| **Re-use** | New mix per setup | One B-format file → many setups |
| **Typical use** | Music, broadcast, everyday listening | Art, research, installation, live, film |

**When does stereo make more sense?** For most music distribution, podcasts, and broadcast, stereo remains the standard — it is compatible with every playback system and requires no special tools. Ambisonics pays off when the spatial dimension of sound matters artistically or technically, or when you need a single master file that can serve multiple playback contexts.

<a id="what-is-b-format"></a>
## 4. [What Is B-Format?](https://ambisonic.info/ambisonics/channels.html)

B-format is the core signal format in Ambisonics and carries spatial information. Sources are encoded into B-format and then decoded for a target setup, such as headphones, stereo, or different loudspeaker arrays.

It describes a sound-field state around a listening point using pressure and directional components. In first order, this means:
- `W` is the omnidirectional component, i.e. the pressure/presence in the room.
- `X`, `Y`, and `Z` are directional components along three axes (front-back, left-right, up-down), indicating where the signal comes from.

In the strict classical sense, “B-format” refers to this four-channel first-order format (`W`, `X`, `Y`, `Z`). In an extended sense, the term is also used for [higher-order Ambisonics](https://en.wikipedia.org/wiki/Ambisonics#Higher-order_Ambisonics), where all Ambisonics coefficients up to a given order are represented as separate audio channels.

This format can then be decoded to different target systems such as headphones, stereo, or loudspeaker arrays. [1](https://en.wikipedia.org/wiki/Ambisonics) [2](https://ambisonic.info/ambisonics/channels.html)

For the practical differences between A-Format, B-Format, FuMa, ambiX, ACN/SN3D, FOA, and HOA, continue with [Ambisonics Formats Explained](/learn/ambisonics-formats/).

<a id="signal-flow"></a>
## 5. Signal Flow at a Glance

From source to speaker — this is how Ambisonics works in REAPER with the ICST plugins:

![Ambisonics Signal Flow — Single Source](/images/signalflow-simple.svg)

*Single source: mono track → AmbiEncoder (az/el/dist) → B-Format Bus → AmbiDecoder → Speakers or Binaural.*

![Ambisonics Signal Flow — Multi-Source (ICST MultiEncoder)](/images/signalflow-multi.svg)

*Multi-source: up to 64 sources feed simultaneously into the ICST MultiEncoder → shared B-Format Bus → decoded once.*

<a id="typical-setups"></a>
## 6. [Typical Setups](https://en.wikipedia.org/wiki/Ambisonic_reproduction_systems)
Common setups range from small studio rings and dome-like height configurations to custom arrays in composition studios. The same Ambisonics material can be adapted to each of these setups through decoding.

<a id="headphones-vs-loudspeakers"></a>
## 7. Headphones vs. Loudspeakers
Headphones use [binaural rendering](#gl-binaural) and are practical for editing, checking translation, and remote collaboration. Loudspeakers provide a physical spatial field in the room and remain essential for composition, depth perception, and artistic evaluation.

<a id="immersive-vs-atmos"></a>
## 8. How is Ambisonics Different from Immersive Audio, Dolby Atmos, and Spatial Audio?

Immersive audio is a broad term for any 3D audio approach that places sound around — and above — the listener rather than just left and right. Ambisonics, [Dolby Atmos](#gl-dolby-atmos), and [Apple Spatial Audio](https://en.wikipedia.org/wiki/Spatial_audio) all pursue this goal, but they do so in fundamentally different ways.

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

- For Beginners: [Quick Start](/icst-ambisonics-plugins/04_quick_start/)
- Clarify formats before setup: [Ambisonics Formats Explained](/learn/ambisonics-formats/)
- Start with the [ICST Ambisonics Plugins](/icst-ambisonics-plugins/) for DAW workflows.
- Use the [ICST Ambisonics Tools](/icst-ambisonics-tools/) for Max/MSP workflows.
- Explore [Ascolta](/blog/ascolta/) for listening practice and references.
- Continue with tutorials and articles in the [Blog & Tutorials](/post/).

**Ambisonics 101: Ten Essential Questions Answered**

{{< youtube 95Hr3T5whsU >}}

---
<a id="ambisonic-microphones"></a>
## 10. Ambisonic Microphones — A Practical Introduction

An Ambisonic microphone captures the full-sphere sound field in a single recording. Unlike standard stereo or surround microphones, it uses a tetrahedral arrangement of four (or more) capsules and outputs a raw format called [**A-format**](#gl-a-format), which must be converted to B-format before use in your DAW.

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
<a id="ambisonics-glossary"></a>
## 11. Ambisonics Glossary (Quick Reference)

- <a id="gl-a-format"></a>**A-format** — Raw signal from a tetrahedral Ambisonics microphone: four capsule signals in tetrahedral geometry. Must be encoded to B-format before use in a DAW.
  → [Wikipedia: Ambisonics](https://en.wikipedia.org/wiki/Ambisonics#A-format)

- <a id="gl-b-format"></a>**B-format** — The Ambisonics carrier signal: encodes the spatial sound field as spherical harmonics. First order = 4 channels (W, X, Y, Z); seventh order = 64 channels.
  → [Wikipedia: Ambisonics](https://en.wikipedia.org/wiki/Ambisonics) | [ICST Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)

- <a id="gl-ambix"></a>**ambiX** — Standardised Ambisonics file format (ACN channel ordering, SN3D normalisation); the de-facto standard for HOA exchange and archiving.
  → [ambiX Specification (IEM)](https://ambisonics.iem.at/proceedings-of-the-ambisonics-symposium-2011/ambix-a-suggested-ambisonics-format)

- <a id="gl-order"></a>**Ambisonics Order** — Spatial resolution level: 1st order = 4 channels, 3rd = 16, 7th = 64. Higher order means finer localisation and more channels.
  → [Wikipedia: Higher-order Ambisonics](https://en.wikipedia.org/wiki/Ambisonics#Higher-order_Ambisonics) | [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)

- <a id="gl-encoder"></a>**Encoder** — Converts a mono/stereo source with position data (azimuth, elevation, distance) into B-format.
  → [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)

- <a id="gl-decoder"></a>**Decoder** — Renders B-format to a target playback system: loudspeaker array or binaural.
  → [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)

- <a id="gl-channel-count"></a>**Channel Count** — Number of channels in the Ambisonics signal path; must remain consistent across the entire routing.
  → [ICST Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)

- <a id="gl-speaker-layout"></a>**Speaker Layout** — Physical loudspeaker geometry to which the decoder renders B-format.
  → [Wikipedia: Ambisonic reproduction systems](https://en.wikipedia.org/wiki/Ambisonic_reproduction_systems)

- <a id="gl-binaural"></a>**Binaural / HRTF** — Headphone rendering via Head-Related Transfer Functions (HRTFs): simulates spatial directional cues without loudspeakers. Enables Ambisonics monitoring on any headphone.
  → [Wikipedia: Binaural recording](https://en.wikipedia.org/wiki/Binaural_recording) | [Wikipedia: HRTF](https://en.wikipedia.org/wiki/Head-related_transfer_function)

- <a id="gl-dolby-atmos"></a>**Dolby Atmos** — Object-based 3D audio format: sound sources are stored as audio objects with position metadata; a licensed renderer places them in the target system (cinema, home theatre, streaming services).
  → [dolby.com](https://www.dolby.com/technologies/dolby-atmos/) | [Wikipedia: Dolby Atmos](https://en.wikipedia.org/wiki/Dolby_Atmos)

- <a id="gl-osc"></a>**OSC (Open Sound Control)** — Network protocol (UDP/IP) for real-time control of spatial parameters.
  → [opensoundcontrol.stanford.edu](https://opensoundcontrol.stanford.edu/) | [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)

- <a id="gl-yaw"></a>**Yaw / Pitch / Roll** — Rotation axes in 3D space: Yaw = horizontal (left/right), Pitch = vertical (up/down), Roll = tilt.
  → [Wikipedia: Euler angles](https://en.wikipedia.org/wiki/Euler_angles)

- <a id="gl-azimuth"></a>**Azimuth / Elevation** — Polar coordinates for source direction: Azimuth = horizontal angle (0°–360°), Elevation = vertical angle (−90° to +90°).
  → [Wikipedia: Horizontal coordinate system](https://en.wikipedia.org/wiki/Horizontal_coordinate_system)  

---

Related next reads:
- [Getting Started with ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)
- [OSC Syntax for the ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
