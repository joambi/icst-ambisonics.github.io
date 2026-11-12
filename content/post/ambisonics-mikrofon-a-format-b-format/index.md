---
title: Recording with an Ambisonics Microphone – A-Format, B-Format and ICST Integration
description: "How to work with Ambisonics microphones (Sennheiser Ambeo, Rode NT-SF1, Zylia ZM-1): understanding A-format, A→B conversion, integration into the ICST workflow and what FOA recordings can do and where their limits lie."
date: 2026-03-21T17:00:00+01:00
year: 2026
month: 2026-03
weight: 37
tags: ["microphone", "a-format", "b-format", "recording", "ambeo", "nt-sf1", "zylia", "foa", "reaper", "workflow"]
key_points:
  - "A-format is the raw capsule signal – it does not sound like Ambisonics until it is matrixed into B-format"
  - "A→B conversion needs a microphone-specific plugin – not a generic matrix"
  - "FOA microphones deliver 1st-order B-format: spatially limited, but ideal for room acoustics, ambience and textures"
difficulty: "intermediate"
post_kind: "tutorial"
tool: ["Recording"]
---

Level: Intermediate | **Audience:** Composers, sound designers, recording engineers.

---

Ambisonics microphones record the space – not as stereo, not as surround, but as a complete spherical sound field. That sounds like more than it is at first: almost all commercially available Ambisonics microphones are first-order (FOA) devices. They deliver four channels that describe the field at a resolution that is excellent for room atmospheres, textures and sound objects but insufficient for the sharp localisation of an HOA3 or HOA7 system. This article explains the recording process, the conversion and how the result is integrated into the ICST workflow.

---

## A-format: what comes out of the microphone

An Ambisonics microphone consists of four capsules in a tetrahedral arrangement – typically one capsule up front left, one down front right, one down back left, one up back right. Each capsule records its own signal. These four raw capsule signals are called **A-format**.

A-format does not sound like Ambisonics. It is the raw material: four slightly different perspectives of the same room, with capsule-spacing artefacts and no direct relation to W, X, Y, Z. You cannot feed A-format directly into the ICST workflow.

What you need is the **A→B conversion**: a matrixing that calculates the four B-format components W (pressure), X (front-back), Y (left-right) and Z (up-down) from the four capsule signals.

---

## Why a microphone-specific plugin is necessary

The conversion matrix is not universal. It depends on the exact capsule geometry, the capsule polarity and the frequency-response characteristics of the particular microphone. On top of that comes the **non-coincidence problem**: the four capsules are physically separated from each other, usually by about 1 cm. At high frequencies this distance leads to directional deviations that a simple fixed matrix cannot compensate. Modern conversion plugins therefore work frequency-dependently – they correct the non-coincidence artefacts in the frequency domain.

Every microphone manufacturer supplies its own conversion plugin, calibrated to the measurement data of that microphone. Third-party plugins can apply generic matrices – that works, but is less precise.

---

## Microphone overview

### Sennheiser Ambeo VR Mic

- **Capsules**: 4 × KE 14 cardioid, tetrahedral
- **A-format designation**: FLU (Front Left Up), FRD (Front Right Down), BLD (Back Left Down), BRU (Back Right Up)
- **Conversion plugin**: **Sennheiser AMBEO A-B Converter** (free, VST/AU/AAX) – calibrated to this microphone, with EQ compensation
- **Output**: 4-channel XLR, 48 V phantom power required

### Rode NT-SF1

- **Capsules**: 4 × 1/2" TF45C cardioid, tetrahedral
- **Connection**: 10-pin XLR → 4 × XLR adapter (supplied)
- **Conversion plugin**: **SoundField by RØDE** (free, VST/AU/AAX) – frequency-dependent conversion, particularly good at high frequencies
- **Output formats**: AmbiX (ACN/SN3D), FuMa, stereo, 5.1, 7.1 and Atmos-compatible formats directly from the plugin
- **Special feature**: the SoundField plugin offers direction manipulation (rotation, tilt, tumble) directly in the conversion step

### Zylia ZM-1

- **Capsules**: 19 MEMS microphones (Infineon XENSIV)
- **Ambisonics order**: natively **3rd order** (scalable down to 2nd or 1st)
- **Connection**: USB directly to the computer or to the Zylia ZR-1 recorder
- **Special feature**: the only microphone named here with HOA output out of the box. No A→B conversion plugin needed – the Zylia driver delivers AmbiX/SN3D directly
- **Limitation**: higher self-noise than condenser microphones because of the MEMS capsules; SNR 69 dB

| Microphone | Order | Conversion plugin | Connection | Strengths |
|---|---|---|---|---|
| Sennheiser Ambeo VR | FOA | AMBEO A-B Converter | 4× XLR | sound quality, calibration |
| Rode NT-SF1 | FOA | SoundField by RØDE | 10-pin XLR | format flexibility, direction correction |
| Zylia ZM-1 | HOA3 | not needed (direct AmbiX) | USB | the only affordable HOA option |

---

## Workflow in REAPER: step by step

### 1. Record four channels

The A-format microphone needs 4 input channels on the audio interface – each with 48 V phantom power. In REAPER create a 4-channel track and route the four capsule signals as a multichannel recording. When monitoring during the recording it does not yet sound like Ambisonics – that is normal.

### 2. Put the A→B conversion plugin on the recording track

After the recording (or directly in the monitoring path): put the conversion plugin on the 4-channel track. The output of the plugin is 4 channels of B-format (W, X, Y, Z in ACN order, SN3D-normalised).

- Sennheiser Ambeo: AMBEO A-B Converter → set output to AmbiX/SN3D
- Rode NT-SF1: SoundField by RØDE → set format to AmbiX, order = 1st
- Zylia ZM-1: no plugin needed, route directly as an HOA3 track

### 3. Route the output to the B-format master bus

Send the 4-channel output of the conversion plugin to the B-format master bus. Channel offset = 0, send all 4 channels. From here the microphone signal behaves like any other Ambisonics source in the session – it is summed together with encoder sources in the B-format bus.

### 4. Monitoring and orientation check

On first listening, check that the main direction is right. An Ambisonics microphone has a reference axis – typically the front edge of the microphone, which should point towards the main sound source. If the scene sounds mirrored or rotated: correct the orientation in the SoundField plugin (Rode) or via a separate SPARTA Rotator plugin.

---

## What FOA recordings can do – and where the limit lies

First-order Ambisonics from a 4-capsule microphone describes the sound field with limited spatial resolution. This has practical consequences:

**Well suited to:**
- room atmospheres (ambience, outdoor recordings)
- diffuse sound textures
- room-acoustic impulses (convolution reverb)
- natural sound environments as compositional background

**Of limited suitability for:**
- sharp point-source localisation (a single loudspeaker in a cluster sounds blurred)
- elevation rendering with high precision
- mixing with HOA3 or HOA7 encoder sources when the same localisation is expected

FOA material and HOA encoder sources **can be summed in the same B-format bus** – that is not a technical problem. The spatial coherence then depends on how well the FOA texture behaves against the sharper HOA sources. In many compositional contexts exactly this difference is interesting: a diffuse FOA field as a ground, sharp HOA objects above it.

---

## Upscaling FOA to HOA?

In principle there are neural-network approaches that extrapolate FOA to HOA3 – experimental tools that exist in research (e.g. Conv-TasNet-based models). For everyday production: these methods improve the spatial representation but cannot recover information that the microphone physics never captured. FOA recordings remain FOA – upscaling is enhancement, not replacement.

Anyone who needs native HOA microphone recordings should reach for the Zylia ZM-1 (HOA3) or for multi-microphone array recordings.

---

## Gain staging and headroom

FOA microphones, especially those with MEMS capsules (Zylia), have higher self-noise than studio condenser microphones. Recommendations:

- set the recording level so that the W channel (omnidirectional) peaks at about –12 dBFS in loud moments
- do no gain normalisation after the recording before the A→B conversion is complete – the level balance between the capsules is decisive for the matrixing
- after conversion: the W channel should have the highest level; if X, Y or Z dominate, the matrixing or the gain is wrong

---

## Further reading

- [Exporting the B-format master](/post/b-format-export-reaper/)
- [Binaural monitoring in the ICST workflow](/post/binaural-monitoring-icst-workflow/)
- [XYZ and AED – two coordinate systems, one loudspeaker](/post/xyz-vs-aed-koordinatensysteme/)
- [ICST AmbiDecoder – scaling and delay compensation](/post/decoder-skalierung-laufzeitkompensation/)
