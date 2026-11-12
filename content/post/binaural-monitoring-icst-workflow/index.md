---
title: Binaural Monitoring in the ICST Workflow – Headphones as a Control Tool
description: "How to work on headphones in the ICST workflow: signal chain, plugin choice (IEM, SPARTA, dearVR), monitoring setup in REAPER and the most common mistakes in binaural listening."
date: 2026-03-21T16:00:00+01:00
year: 2026
month: 2026-03
weight: 35
tags: ["binaural", "monitoring", "hrtf", "iem", "sparta", "reaper", "workflow", "headphones"]
key_points:
  - "Binaural monitoring is a production tool – not just a deliverable"
  - "The BinauralDecoder replaces the loudspeaker decoder in the monitoring chain – it sits on the same bus"
  - "Encoder order and decoder order must match – otherwise you get blur instead of localisation"
difficulty: "intermediate"
kind: "tutorial"
tool: ["Binaural"]
---

Level: Intermediate | **Audience:** Composers, producers, technicians.

---

Binaural is not just an output format. Anyone developing an Ambisonics production without loudspeakers – on the train, in a home office, on a laptop without a decoder system – needs reliable headphone monitoring that reproduces the spatial field as faithfully as possible. This article shows how to integrate binaural into the ICST session, which plugins work and what to watch for during setup.

---

## Why binaural monitoring is not a makeshift solution

Binaural from HOA is in principle less lossy than binaural from FOA. A 3rd-order signal carries 16 channels of spherical information; a well-implemented BinauralDecoder can use this spatial resolution fully for headphone playback. The result is clearly superior to first order: sharper localisation, more convincing elevation rendering, a wider sweet spot.

At the same time: binaural on headphones and a loudspeaker decode on a 3D system do not sound identical. Binaural monitoring is a **control tool**, not a substitute for the real loudspeaker check before a performance.

---

## The signal chain

The BinauralDecoder sits **on the B-format master bus** – exactly where you would use the ICST AmbiDecoder in a loudspeaker session. It receives the complete multichannel B-format signal and outputs stereo:

```
[Sources] → [ICST AmbiEncoder] → [B-format master bus] → [BinauralDecoder] → [Stereo out / headphones]
```

For everyday production a **parallel monitoring chain** is recommended: the B-format bus sends its signal to two FX chains – one for the loudspeaker decode (ICST AmbiDecoder), one for binaural. You activate one at a time; the other stays disabled or sits on a separate send bus.

In REAPER this is easy with the **FX bypass button** in the FX list: disable the loudspeaker decoder, enable the BinauralDecoder – and vice versa. No routing change is needed.

---

## Plugin overview: which BinauralDecoder for which context

### IEM BinauralDecoder

The plugin from the IEM Plug-in Suite is the first choice in the ICST workflow because it uses the same SN3D/ACN convention as the rest of the suite.

- **HRTF**: Neumann KU 100 dummy-head measurements, processed with MagLS (Magnitude Least Squares) – minimises timbral artefacts from HRTF order reduction
- **Headphone EQ**: optionally loadable headphone equalisation (after Bernschütz et al.)
- **Order detection**: automatic – the plugin adapts to the channel count of the bus
- **Recommendation**: always run it at the same order at which the encoders work. The channel count on the B-format bus must be right (1st = 4 ch, 3rd = 16 ch, 7th = 64 ch)

### SPARTA AmbiBIN

Part of the SPARTA Spatial Audio Suite. More flexible than IEM for experimental workflows because it can load SOFA files – your own HRTF measurements or specialised datasets can be used directly.

- **Order**: up to 10th order
- **SOFA support**: your own HRTFs can be loaded (.sofa files)
- **Head tracking**: via OSC (e.g. from GyrOSC on an iPhone)
- **Decoding methods**: LS, SPR, TA, MagLS – MagLS recommended for the best sound quality
- **Recommendation**: good for composers who want to integrate head tracking into the monitoring workflow

### dearVR AMBI MICRO

Available for free (VST/AU/AAX). A good start without licence costs.

- **4 binaural modes**: different degrees of spaciousness
- **AMBEO A-to-B converter**: integrated – useful when microphone recordings are part of the session
- **Head tracking**: VR-capable
- **Limitation**: less HRTF control than IEM or SPARTA; no SOFA import in the free version

| Plugin | Free | SOFA | Head track | Max order | Recommended for |
|---|---|---|---|---|---|
| IEM BinauralDecoder | ✓ | ✗ | ✗ | 7th | standard ICST workflow |
| SPARTA AmbiBIN | ✓ | ✓ | ✓ (OSC) | 10th | own HRTFs, head tracking |
| dearVR AMBI MICRO | ✓ | ✗ | ✓ | 1st–3rd | quick start |

---

## Setup in REAPER: step by step

**1. Set the B-format master bus to the correct channel count**

The channel count of the bus must match the encoder order: 4 channels for 1st order, 16 for 3rd, 36 for 5th, 64 for 7th. A wrongly configured bus silently cuts off higher-order components – without an error message.

**2. Set up the BinauralDecoder as FX on the B-format bus**

Put the IEM BinauralDecoder as an FX plugin on the B-format master bus. Set normalisation in the plugin to **SN3D**, if it can be chosen manually. The plugin outputs 2 channels (stereo).

**3. Route the stereo output**

Route the stereo output of the BinauralDecoder to the headphone output of your audio interface. In REAPER you can do this via a separate stereo sum bus or directly via the hardware output of the track.

**4. Parallel chain for loudspeaker monitoring**

If you want to switch between loudspeakers and headphones: put the ICST AmbiDecoder and the IEM BinauralDecoder both as FX on the bus. Always activate exactly one. Alternatively: a separate send bus for binaural monitoring with its own hardware output – then you can listen to both at the same time (useful for comparisons).

---

## Common mistakes

**Order mismatch:** The encoder works at HOA3 (16 channels), but the B-format bus is set to only 4 channels. The BinauralDecoder then receives a truncated signal – localisation is blurred and the sound is like FOA although HOA material is present. Solution: check the channel count on the bus.

**Normalisation mismatch:** If one plugin runs with N3D and another with SN3D, level differences arise between orders. It does not sound wrong, but it distorts depth perception. Use SN3D / ACN consistently throughout the ICST signal path.

**Using binaural as the primary monitor:** Binaural monitoring does not show what sounds on a real loudspeaker system. Elevation rendering, envelopment and room-acoustic effects behave differently on headphones. Binaural is a check, not a reference.

**Forgetting the headphone EQ:** The IEM BinauralDecoder offers optional headphone equalisation. Without it the sweet spot sounds narrower and externalisation weaker. Load a suitable EQ curve for your headphones, if available.

**Not calibrating head tracking:** Anyone using SPARTA AmbiBIN with GyrOSC or another head tracker must calibrate the tracking offset before making musical decisions – otherwise the reference axis is rotated.

---

## Binaural as a deliverable vs. binaural as monitoring

This page describes binaural monitoring **during production**. Anyone who wants to deliver a finished Ambisonics scene as a binaural file (for streaming, YouTube 360°, headphone distribution) follows a different workflow:

- binaural render as a separate rendering session
- no loudspeaker decoders active in parallel
- headphone EQ permanently baked in, if needed
- output as a 2-channel WAV with stereo metadata

More on this in the article [From the Ambisonics scene to an Atmos bed](/post/ambisonics-to-atmos-bed/) in the section "Binaural as a better route for headphones".

---

## Further reading

- [ICST AmbiDecoder – setup and operation](/icst-ambisonics-plugins/08_icst_decoder/)
- [From the Ambisonics scene to an Atmos bed](/post/ambisonics-to-atmos-bed/)
- [ICST AmbiEncoder – OSC syntax](/post/osc-syntax-for-the-icst-ambiencoder-plugin/) *(for head-tracking integration via OSC)*
- [GyrOSC & ICST AmbiPlugins](/post/gyrosc/)
