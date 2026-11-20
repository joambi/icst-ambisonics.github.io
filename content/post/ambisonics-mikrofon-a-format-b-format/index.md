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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 240" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Four tetrahedral capsule signals are converted by a microphone-specific plugin into the four B-format components W, X, Y and Z." xmlns="http://www.w3.org/2000/svg"><defs><marker id="ma" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="10" y="20" text-anchor="start" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">A-format (raw capsules)</text><text x="710" y="20" text-anchor="end" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">B-format (ACN / SN3D)</text><rect x="272" y="85" width="186" height="80" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="365.0" y="122.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">A→B conversion</text><text x="365.0" y="139.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">microphone-specific plugin</text><rect x="10" y="40" width="130" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="57.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">FLU</text><text x="75.0" y="74.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">front left up</text><line x1="142" y1="60" x2="270" y2="125" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><line x1="460" y1="125" x2="588" y2="60" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><rect x="590" y="40" width="120" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="650.0" y="57.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">W</text><text x="650.0" y="74.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">pressure (omni)</text><rect x="10" y="90" width="130" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="107.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">FRD</text><text x="75.0" y="124.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">front right down</text><line x1="142" y1="110" x2="270" y2="125" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><line x1="460" y1="125" x2="588" y2="110" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><rect x="590" y="90" width="120" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="650.0" y="107.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">X</text><text x="650.0" y="124.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">front–back</text><rect x="10" y="140" width="130" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="157.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">BLD</text><text x="75.0" y="174.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">back left down</text><line x1="142" y1="160" x2="270" y2="125" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><line x1="460" y1="125" x2="588" y2="160" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><rect x="590" y="140" width="120" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="650.0" y="157.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Y</text><text x="650.0" y="174.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">left–right</text><rect x="10" y="190" width="130" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="207.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">BRU</text><text x="75.0" y="224.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">back right up</text><line x1="142" y1="210" x2="270" y2="125" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><line x1="460" y1="125" x2="588" y2="210" stroke="currentColor" stroke-width="1.6" marker-end="url(#ma)"/><rect x="590" y="190" width="120" height="40" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="650.0" y="207.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Z</text><text x="650.0" y="224.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">up–down</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">A-format is raw capsule signal; the A→B conversion turns it into W, X, Y, Z.</figcaption>
</figure>


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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 210" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Two recording paths into the B-format bus: A-format microphones go through an A→B plugin, the Zylia ZM-1 delivers AmbiX directly." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mw" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="10" y="18" text-anchor="start" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">Ambeo / Rode NT-SF1 (A-format)</text><rect x="10" y="28" width="130" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="53.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Microphone</text><text x="75.0" y="70.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">4 × XLR, 48 V</text><line x1="142" y1="56" x2="168" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#mw)"/><rect x="170" y="28" width="150" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="245.0" y="53.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">4-ch track</text><text x="245.0" y="70.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">A-format recording</text><line x1="322" y1="56" x2="348" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#mw)"/><rect x="350" y="28" width="150" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="425.0" y="53.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">A→B plugin</text><text x="425.0" y="70.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">AmbiX, 1st order</text><line x1="502" y1="56" x2="548" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#mw)"/><rect x="550" y="28" width="160" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="630.0" y="53.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">B-format bus</text><text x="630.0" y="70.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">64 ch</text><text x="10" y="122" text-anchor="start" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">Zylia ZM-1 (HOA3, AmbiX direct)</text><rect x="10" y="132" width="130" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="75.0" y="157.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Zylia ZM-1</text><text x="75.0" y="174.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">USB</text><line x1="142" y1="160" x2="168" y2="160" stroke="currentColor" stroke-width="1.6" marker-end="url(#mw)"/><rect x="170" y="132" width="150" height="56" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".16" stroke-width="1.5"/><text x="245.0" y="157.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">HOA3 track</text><text x="245.0" y="174.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">16 ch, AmbiX</text><line x1="322" y1="160" x2="548" y2="160" stroke="currentColor" stroke-width="1.6" marker-end="url(#mw)"/><text x="435" y="150" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">no A→B plugin needed</text><rect x="550" y="132" width="160" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="630.0" y="157.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">B-format bus</text><text x="630.0" y="174.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">64 ch</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Both paths end in the same B-format bus.</figcaption>
</figure>


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
