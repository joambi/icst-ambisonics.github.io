---
title: From the Ambisonics Scene to an Atmos Bed – Methods and Tools
description: "Ambisonics and Dolby Atmos beds are architecturally incompatible. This article explains why every conversion is lossy, which three methods exist and when converting makes sense at all."
date: 2026-03-21T14:00:00+01:00
year: 2026
month: 2026-03
weight: 34
tags: ["ambisonics", "dolby-atmos", "atmos-bed", "conversion", "hoa", "workflow", "delivery"]
key_points:
  - "Ambisonics is field-based, an Atmos bed is channel-based – every conversion is lossy"
  - "Three methods of differing quality: simple decode, beamforming, virtual dome"
  - "For headphones and VR: do not convert, render binaural directly from HOA"
difficulty: "intermediate"
kind: "tutorial"
tool: ["Delivery"]
---

Level: Intermediate | **Audience:** Composers, technicians, sound engineers.

---

## The basic problem

Ambisonics and Dolby Atmos beds are not only technically different – they follow different paradigms.

**B-format** describes a sound field via spherical harmonics. It knows no fixed loudspeakers. The same HOA file can be played back on an octagon, a 3D dome, over headphones or on a 7.1.4 system without changing the source file.

An **Atmos bed** is a fixed channel format: typically 7.1.2 (9 channels) or 7.1.4 (12 channels), with fixed loudspeaker positions. Anyone who creates an Atmos bed has committed to a concrete playback layout.

Converting from Ambisonics to an Atmos bed is therefore structurally lossy:

- The **rotation invariance** of B-format is lost – after conversion the sound field can no longer be rotated or transformed.
- The **phase relationships** between the spherical harmonics are partly lost in a simple downmix.
- **Diffuse field information** – the non-directional part of the room – is rendered less well than in the original.
- Later adjustments require a return to the source file.

This does not mean the conversion sounds bad. It means that the choice of method and the moment of conversion are decisive.

---

## When to convert – and when not

| Situation | Recommendation |
|---|---|
| Streaming release (Apple Music, TIDAL, Amazon) | Conversion necessary → Atmos bed/object |
| Cinema or theatre with a fixed Atmos system | Conversion necessary → 7.1.4 bed |
| Headphones / binaural / VR | **Do not convert** → binaural straight from HOA |
| Archiving and format-agnostic production | Keep the original HOA, convert on demand |
| Live performance | Avoid if possible – latency, DSP load |
| Research and A/B comparisons | Keep the HOA source file, several renders in parallel |

The most important rule: keep the HOA original in the production chain for as long as possible. Convert only at the end of the workflow, not during composition or mixing.

---

## Three conversion methods

### Method A – simple speaker bed decode

The most direct route: HOA is decoded with an Ambisonic decoder to the 12 channels of the 7.1.4 layout and handed to the renderer as an Atmos bed.

**Tools:** IEM SimpleDecoder (via AllRADecoder JSON export), SPARTA AmbiDEC, IEM AllRADecoder, Blue Ripple O3A Decoder (direct 7.1.2 output), Audio Brewers ab Decoder HOA Express (Pro Tools).

**Quality:** medium. Simple and quick to implement, but with complex room content there are measurable losses in localisation sharpness and diffuse field information. Research shows that simple bed downmixing of HOA can lead to a "substantial loss of spatial definition".

**Suited to:** uncomplicated content, quick deliveries, scenes without strong demands on spatial precision.

---

### Method B – beamforming and object decomposition

A much more faithful method: the HOA sound field is decomposed via a **Sampling Ambisonic Decoder (SAD)** into up to 60 discrete directional points on a T-design sphere distribution. Each point is placed in the renderer as an independent Atmos object.

**Tools:** SPARTA AmbiDEC (free 60-point SAD preset built in), Dolby Atmos Renderer (as the target for the object list).

**Quality:** high. Preserves considerably more spatial detail than method A. A 2024 study shows that beamforming-based decomposition into 60 objects significantly improves localisation accuracy compared with a simple bed decode.

**Drawback:** complex workflow, high CPU demand, and the number of Atmos objects is practically limited (32 objects for consumer formats, 118 in cinema). With 60 beamformer points you have to cluster or reduce objects.

**Suited to:** scenes with high spatial density, music productions with precision demands, research contexts.

---

### Method C – virtual speaker dome

A middle way between A and B: a dense virtual loudspeaker grid (24 to 32 points on a sphere) is generated. HOA is decoded onto this virtual dome and each loudspeaker is handed over as an Atmos object.

**Tools:** Blue Ripple O3A Decoder (Dome 24 and Dome 32), SPARTA AmbiDEC with custom configurations.

**Quality:** good. Better than method A, more practical than method B. Precise enough for most music applications.

**Suited to:** music productions, installations, scenes of moderate spatial complexity.

---

## Binaural: the better route for headphones

For headphone delivery – Apple Spatial Audio in binaural mode, VR/XR, 360° video – converting to an Atmos bed is not the right approach. Better: render HOA directly with an HRTF-based binaural decoder.

The advantage: the complete sound field is preserved until the very last step. Rotation (e.g. head tracking in VR) is lossless because B-format is rotation-invariant – an advantage that could no longer be used after conversion into a fixed bed.

**Tools:** SPARTA AmbiBIN (up to 10th order, SOFA file support, head tracking via OSC), IEM BinauralDecoder (up to 7th order), Nuendo 12 (integrated binaural converter), dearVR PRO + MONITOR.

Important note: binaural rendering at low orders (FOA, 2OA) can produce sound artefacts – the HRTF functions and the spherical harmonics do not "fit" together perfectly in spectral terms. Spectral compensation filtering (SH-domain tapering) improves the result considerably. SPARTA AmbiBIN implements this method.

---

## Tools at a glance

| Tool | Licence | Method | Order | Note |
|---|---|---|---|---|
| SPARTA AmbiDEC | free | A, B | up to 10th | 60-point SAD preset for method B |
| SPARTA AmbiBIN | free | binaural | up to 10th | SOFA, head tracking via OSC |
| IEM AllRADecoder | free | A | 1–7 | JSON export for SimpleDecoder |
| IEM SimpleDecoder | free | A | 1–7 | loads AllRADecoder configurations |
| IEM BinauralDecoder | free | binaural | 1–7 | |
| Blue Ripple O3A Decoder | commercial | A, C | O3A (3rd eq.) | direct output 7.1.2 and Dome 24/32 |
| ab Decoder HOA Express | commercial | A | 1–3 | Pro Tools native |
| dearVR PRO | commercial | binaural | up to 7th | Nuendo/Cubase integration |
| Nuendo 12 Atmos Suite | commercial | A + binaural | up to 7th | most seamless integrated workflow |

For REAPER: SPARTA and the IEM Suite are free and fully supported. The way to Atmos leads via method A or B into the Dolby Atmos Renderer (separate, commercial).

---

## Methodological recommendation

Anyone who wants to publish an Ambisonics work for different platforms should build the production chain like this:

1. **Source:** HOA file as the canonical master (the highest order the source material provides)
2. **Monitoring:** binaural render straight from HOA (throughout the production)
3. **Streaming delivery:** HOA → method C or B → Atmos Renderer → ADM file
4. **Headphone delivery:** HOA → HRTF binaural → stereo (no Atmos detour)
5. **Cinema delivery:** HOA → method A or B → Atmos Renderer → DCP preparation
6. **Archive:** keep the HOA source file – all other formats are renders

Conversion is always a decision for a specific playback system. B-format is and remains the most flexible format – leave it as late as possible.

---

## Sources and further reading

- [Decoding Ambisonics to Dolby Atmos Using Beamforming and Spherical Array of Objects](https://www.researchgate.net/publication/380905519_Decoding_Ambisonics_to_Dolby_Atmos_using_beamforming_and_spherical_array_of_objects) – foundational study on method B (2024)
- [EBU Technical Review: Scene-Based Audio and HOA](https://tech.ebu.ch/docs/techreview/trev_2019-Q4_SBA_HOA_Technology_Overview.pdf) – EBU overview of HOA and ADM compatibility
- [ITU-R BS.2076-3 Audio Definition Model](https://www.itu.int/dms_pubrec/itu-r/rec/bs/R-REC-BS.2076-3-202502-I!!PDF-E.pdf) – current ADM standard (2025)
- [SPARTA Suite documentation](https://leomccormack.github.io/sparta-site/docs/plugins/sparta-suite/)
- [IEM Plug-in Suite](https://plugins.iem.at/)
- [Matthias Frank, *How to Make Ambisonics Sound Good*](https://iaem.at/Members/frank/files/2014_frank_howtomakeambisonicssoundgood.pdf) – IEM Graz, practical decoding recommendations

---

## Further reading

- [Why the decoder sounds the way it does – methodological context](/post/decoder-methodological-context/)
- [ICST MultiDecoder](/icst-ambisonics-plugins/09_icst_multidecoder/)
- [History and applications of the Ambisonics decoder](/blog/decoder-geschichte-und-anwendungen/)
- [Best practices](/icst-ambisonics-plugins/17_best_practices/)
