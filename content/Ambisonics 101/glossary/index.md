---
title: "Ambisonics Glossary"
description: "Quick reference for Ambisonics and HOA: format, order, normalisation, microphones, decoders, binaural, processing and parametric methods."
date: 2026-11-22T00:00:00
draft: false
url: /ambisonics-101/glossary/
tags:
  - ambisonics
  - glossary
---

Quick reference for the terms used in [Ambisonics 101](/ambisonics-101/).

## Core terms

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

## Mathematical foundations

- <a id="gl-spherical-harmonics"></a>**Spherical harmonics** — Mathematical functions on the surface of a sphere into which Ambisonics decomposes the sound field. Each function has a degree n (the Ambisonics order) and an index m from −n to n. Up to order N there are (N+1)² functions, i.e. channels.
  → [Wikipedia: Spherical harmonics](https://en.wikipedia.org/wiki/Spherical_harmonics) | [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-plane-spherical-wave"></a>**Plane wave and spherical wave** — Ambisonics first describes sources as plane waves: infinitely far away, with a direction only. Sources at a finite distance are spherical waves; near-field coding captures their near-field behaviour.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-periphony"></a>**Periphony and pantophony** — Terms from Gerzon: periphony is reproduction with height (full sphere), pantophony is horizontal-only reproduction.
  → [Gerzon 1973](https://ringbuffer.org/papers/gerzon1973periphony.html)

- <a id="gl-2d-ambisonics"></a>**Horizontal (2D) Ambisonics** — Ambisonics in the horizontal plane only. Order N needs 2N+1 channels there instead of (N+1)².
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-mixed-order"></a>**Mixed-order Ambisonics** — Horizontal and vertical order differ, for example high horizontally and low vertically. This saves channels compared with full order.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-order-reduction"></a>**Order reduction** — The channels of higher orders are dropped: an HOA7 master becomes HOA3 or FOA. Mixing up again does not create new spatial resolution.
  → [HOA-Wahl in der Praxis](/post/hoa-ordnung-wahl-praxis/)

- <a id="gl-spatial-aliasing"></a>**Spatial aliasing** — Above a cut-off frequency the sound field is captured or reconstructed incompletely. It depends on the capsule spacing (microphone) or the number of loudspeakers. The results are directional errors and colouration.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7) | [Ward & Abhayapala 2001](https://doi.org/10.1109/89.943347)

## Formats and exchange

- <a id="gl-n3d-maxn"></a>**N3D and maxN** — Further normalisations besides SN3D. N3D is fully orthonormal; it equals SN3D times √(2n+1) for degree n. maxN scales so that no channel exceeds 1 and belongs to FuMa.
  → [Wikipedia: Ambisonic data exchange formats](https://en.wikipedia.org/wiki/Ambisonic_data_exchange_formats)

- <a id="gl-ogg-opus"></a>**Ambisonics in Opus (RFC 8486)** — Defines how Ambisonics signals are stored in Ogg Opus files. This allows Ambisonics in common streaming containers.
  → [RFC 8486](https://www.rfc-editor.org/info/rfc8486)

- <a id="gl-mpegh"></a>**MPEG-H 3D Audio** — Audio codec standard that can encode HOA scenes alongside channels and objects.
  → [Wikipedia: MPEG-H 3D Audio](https://en.wikipedia.org/wiki/MPEG-H_3D_Audio)

## Microphones and recording

- <a id="gl-soundfield-mic"></a>**Soundfield microphone** — The first commercial Ambisonics microphone (Calrec, 1978): four capsules in a tetrahedron that deliver A-format.
  → [Zeitleiste](/blog/geschichte-von-ambisonics-foa-und-hoa/)

- <a id="gl-spherical-array"></a>**Spherical microphone array** — Many capsules on a sphere, for example Eigenmike (32 capsules) or Zylia ZM-1 (19 capsules). It captures higher orders. Order N needs at least (N+1)² capsules.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7) | [Mikrofon: A- und B-Format](/post/ambisonics-mikrofon-a-format-b-format/)

- <a id="gl-radial-filter"></a>**Radial filters (capsule equalisation)** — Frequency-dependent filters that turn the capsule signals into correct B-format. The higher the order, the more they boost low frequencies and with them noise. This limits the usable order in the bass.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-beamforming"></a>**Beamforming (virtual microphones)** — From B-format, microphones of any direction and polar pattern can be computed.
  → [Wikipedia: Beamforming](https://en.wikipedia.org/wiki/Beamforming)

- <a id="gl-srir"></a>**Spatial room impulse response (SRIR)** — Impulse response of a room measured with an Ambisonics microphone. Convolved with a signal it gives room reverberation as B-format.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

## Decoders and reproduction

- <a id="gl-sad"></a>**Sampling decoder (SAD)** — Evaluates the spherical harmonics at the loudspeaker directions. Simple and good for regular layouts, uneven for irregular ones.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-mmd"></a>**Mode-matching decoder (MMD)** — Inverts (pseudo-inverse) the matrix of spherical harmonics at the loudspeaker positions. Exact with enough well-distributed loudspeakers, unstable with gaps in the layout.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-epad"></a>**EPAD (energy-preserving ambisonic decoder)** — Decoder that provides even energy across all directions.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-nfc"></a>**Near-field compensation (NFC)** — Accounts for the finite distance of loudspeakers or sources (spherical instead of plane waves). Important at higher order and for sources close to the head.
  → [Decoder-Geschichte](/blog/decoder-geschichte-und-anwendungen/)

- <a id="gl-t-design"></a>**t-design and regular layouts** — Point sets evenly distributed on the sphere (for example Lebedev grids) for which the spherical harmonics are sampled cleanly up to a given degree. Ideal for loudspeaker layouts.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-vbap-wfs"></a>**VBAP and wave field synthesis** — Two other reproduction methods. VBAP distributes a source over the nearest two or three loudspeakers and depends on the layout. Wave field synthesis reconstructs wave fronts with many loudspeakers over a large area.
  → [VBAP (Aalto University)](http://legacy.spa.aalto.fi/research/cat/vbap/) | [Wikipedia: Wave field synthesis](https://en.wikipedia.org/wiki/Wave_field_synthesis)

## Binaural

- <a id="gl-virtual-speakers"></a>**Virtual loudspeakers** — Binaural rendering in two steps: B-format is first decoded to virtual loudspeakers, then each one is convolved with the HRTF of its direction. Alternatively the HRTF is applied directly in the spherical-harmonic domain.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-magls"></a>**MagLS (magnitude least squares)** — Optimises the magnitude spectrum of the HRTF representation in low-order binaural rendering. This improves timbre compared with a plain spherical-harmonic approximation.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

## Processing in the Ambisonics domain

- <a id="gl-rotation"></a>**Rotation** — Rotation of the entire sound field about yaw, pitch and roll. In the spherical-harmonic domain this is done with matrices and without loss. Basis for head tracking.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-dominance"></a>**Dominance (zoom)** — Shifts the energy of the sound field towards one direction: sources in front of the listener are emphasised, those behind are reduced.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-source-width"></a>**Source width (spread)** — A source appears wider. In Ambisonics this can be done, for example, with a lower order for that source, because low order focuses less sharply.
  → [HOA-Wahl in der Praxis](/post/hoa-ordnung-wahl-praxis/)

## Parametric methods

- <a id="gl-dirac"></a>**DirAC (directional audio coding)** — Analyses direction and diffuseness of the sound field per frequency band and renders them to any loudspeaker layout. A parametric method instead of a pure spherical-harmonic decomposition.
  → [Pulkki et al. 2017](https://doi.org/10.1002/9781119252634)
