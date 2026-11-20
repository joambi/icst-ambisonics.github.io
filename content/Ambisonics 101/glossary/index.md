---
title: "Ambisonics Glossary"
description: "Quick reference for the most important Ambisonics terms: A-format, B-format, ambiX, order, encoder, decoder, binaural, OSC, yaw/pitch/roll, azimuth/elevation."
date: 2026-11-20T00:00:00
draft: false
url: /ambisonics-101/glossary/
tags:
  - ambisonics
  - glossary
---

Quick reference for the terms used in [Ambisonics 101](/ambisonics-101/).

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
