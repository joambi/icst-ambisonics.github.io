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

- <a id="gl-azimuth"></a>**Azimuth / Elevation** — Polar coordinates for source direction: Azimuth = horizontal angle (0°–360°, in ICST tools clockwise: 0° front, 90° right, 180° back, 270° left), Elevation = vertical angle (−90° to +90°).
  → [Wikipedia: Horizontal coordinate system](https://en.wikipedia.org/wiki/Horizontal_coordinate_system)  

- <a id="gl-foa"></a>**First-Order Ambisonics (FOA)** — Ambisonics of 1st order: 4 channels (W, X, Y, Z). Delivered by all common Ambisonics microphones. Compact and robust, with limited spatial resolution.
  → [Which order do I need?](/post/hoa-ordnung-wahl-praxis/)

- <a id="gl-hoa"></a>**Higher-Order Ambisonics (HOA)** — Ambisonics of 2nd order and above. N-th order needs (N+1)² channels (3rd = 16, 7th = 64) and gives finer localisation and a larger sweet spot.
  → [Which order do I need?](/post/hoa-ordnung-wahl-praxis/)

- <a id="gl-sweet-spot"></a>**Sweet spot** — Area in which the sound field is reproduced correctly. It grows with the Ambisonics order and shrinks with frequency.
  → [Which order do I need?](/post/hoa-ordnung-wahl-praxis/)

- <a id="gl-acn"></a>**ACN (Ambisonic Channel Number)** — Channel ordering used by ambiX. In first order the channels run W, Y, Z, X.
  → [Formats explained](/learn/ambisonics-formats/)

- <a id="gl-sn3d"></a>**SN3D** — Normalisation used by ambiX together with ACN ordering.
  → [Formats explained](/learn/ambisonics-formats/)

- <a id="gl-fuma"></a>**FuMa (Furse-Malham)** — Older convention: channel order W, X, Y, Z with maxN normalisation. Defined up to 3rd order; replaced by ambiX in current tools.
  → [Formats explained](/learn/ambisonics-formats/)

- <a id="gl-aed-xyz"></a>**AED and XYZ** — Two ways to give a source position: azimuth, elevation, distance (polar) or X, Y, Z (Cartesian: X right, Y front, Z up).
  → [XYZ and AED compared](/post/xyz-vs-aed-koordinatensysteme/)

- <a id="gl-weighting"></a>**Decoder weighting (Basic, In-Phase, Max-rE)** — Per-order gains in the decoder. Basic reconstructs the field strictly but has side lobes, In-Phase has none and is widest, Max-rE is a compromise tuned for energy-vector localisation, common for large rooms.
  → [Decoder history](/blog/decoder-geschichte-und-anwendungen/)

- <a id="gl-rv-re"></a>**Velocity vector (rV) and energy vector (rE)** — Gerzon's psychoacoustic criteria: rV describes localisation at low frequencies, rE at high frequencies.
  → [Decoder history](/blog/decoder-geschichte-und-anwendungen/)

- <a id="gl-allrad"></a>**AllRAD** — All-Round Ambisonic Decoding: decoder method for irregular loudspeaker layouts, available as the IEM AllRADecoder.
  → [IEM Plugin Suite](https://plugins.iem.at/)

- <a id="gl-hrtf"></a>**HRTF** — Head-related transfer function: the filtering of head and ears for each direction. Binaural decoders use HRTFs to place sources over headphones.
  → [Binaural monitoring](/post/binaural-monitoring-icst-workflow/)

- <a id="gl-sofa"></a>**SOFA** — File format for HRTF data (AES69), loaded by binaural renderers that support custom HRTFs.
  → [Binaural monitoring](/post/binaural-monitoring-icst-workflow/)

- <a id="gl-head-tracking"></a>**Head tracking** — A sensor follows head rotation and the scene is rotated the opposite way, so sources stay fixed in space over headphones.
  → [Binaural monitoring](/post/binaural-monitoring-icst-workflow/)

- <a id="gl-w-channel"></a>**W channel** — Omnidirectional pressure component, the first B-format channel. It should be the loudest channel after A→B conversion.
  → [Microphone guide](/post/ambisonics-mikrofon-a-format-b-format/)

- <a id="gl-non-coincidence"></a>**Non-coincidence** — The four capsules of an Ambisonics microphone sit about 1 cm apart. At high frequencies this causes direction errors that the A→B plugin corrects.
  → [Microphone guide](/post/ambisonics-mikrofon-a-format-b-format/)

- <a id="gl-multidecoder"></a>**MultiDecoder** — ICST plugin that runs up to four decoder units in parallel, each with its own loudspeaker subset, order, weighting and filter.
  → [ICST MultiDecoder](/icst-ambisonics-plugins/09_icst_multidecoder/)

- <a id="gl-bformat-master"></a>**B-format master** — The shared B-format bus of a session that all encoders sum into. Decode and render from it.
  → [Workflow](/learn/ambisonics-workflow/)

- <a id="gl-delay-compensation"></a>**Delay compensation** — The decoder delays the nearer loudspeakers so that all signals arrive at the listening position at the same time.
  → [Scaling and delay compensation](/post/decoder-skalierung-laufzeitkompensation/)

- <a id="gl-uhj"></a>**UHJ** — Stereo-compatible encoding of Ambisonics (2 to 4 channels, usually 2) from the 1970s, used for releases that had to play on ordinary stereo systems.
  → [History timeline](/blog/geschichte-von-ambisonics-foa-und-hoa/)

- <a id="gl-scene-based"></a>**Scene-based and channel-based audio** — Ambisonics stores the sound field (the scene) independent of the loudspeaker layout and decodes it for each system. Channel-based formats store one signal per loudspeaker.
  → [Ambisonics 101](/ambisonics-101/)
