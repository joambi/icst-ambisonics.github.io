---
title: "Binaural Rendering and Headphone Delivery"
description: "How to convert an Ambisonics mix to binaural, choose and evaluate HRTFs, monitor during composition, and deliver a headphone-compatible master."
date: 2026-01-01T00:00:00
weight: 82
draft: false
translationKey: "composing-binaural-delivery"
---

A growing share of audiences will experience Ambisonics compositions through headphones — via streaming platforms, video documentations, or personal listening. Binaural rendering converts a B-format mix to a stereo signal that preserves spatial information for headphone playback, using **Head-Related Transfer Functions (HRTFs)**. Understanding how this works, and how to evaluate and deliver a binaural master, is now a practical necessity for any Ambisonics composer.

## What Is Binaural Rendering?

The human auditory system determines the direction of a sound source by comparing tiny differences in the signal reaching the left and right ear: differences in arrival time (ITD — interaural time difference), differences in level (ILD — interaural level difference), and spectral coloration introduced by the shape of the outer ear and head (the pinna effect). Together, these cues allow us to localise sounds in full three-dimensional space.

A **Head-Related Transfer Function (HRTF)** captures this filtering mathematically for every direction in space. By convolving a mono signal with the appropriate pair of HRTFs (one for each ear), a binaural renderer simulates where that sound appears to come from when listened to through headphones.

Ambisonics to binaural rendering works by decoding the B-format signal into a virtual loudspeaker array and then applying HRTFs for each virtual speaker position. Modern decoders do this in a single step, often using higher-order Ambisonics to improve spatial resolution.

## Generic vs. Personalised HRTFs

HRTFs are highly individual: your ears, head, and shoulders produce a unique filtering pattern. Using a **generic HRTF** (measured on an artificial head or averaged from a population) works reasonably well for many listeners, but may produce localisation errors, especially in elevation, and the well-known **in-head localisation** effect where sounds appear to originate inside the head rather than around it.

**Personalised HRTFs** — measured from the listener's own ears, or approximated from photographs or ear scans — significantly improve externalisation and elevation accuracy. Several commercial and research services now offer personalised HRTFs (e.g., Mimi Hearing Technologies, Earable, or research databases such as CIPIC and SADIE II).

For composition and mastering purposes, the practical approach is:

- **Monitor with a commonly used generic HRTF** (e.g., the KU100 binaural head from Neumann, or the SADIE II dataset) to approximate what most listeners will hear
- **Test additionally with two or three different generic HRTFs** to check that spatial impressions survive HRTF variation — a spatial texture that only works with one specific HRTF is fragile
- Note that **elevation cues are less reliable** than horizontal localisation across all generic HRTFs; compositional gestures that depend on precise vertical positioning may not translate

## Binaural Monitoring During Composition

Rather than leaving binaural rendering to the mastering stage, integrate it into the composition workflow:

1. **Insert a binaural decoder** on the master output (e.g., IEM BinauralDecoder, dearVR Monitor, Envelopment, or the SPARTA Binaural Panner) and switch between loudspeaker decoding and binaural as you work
2. **Cross-check regularly**: what reads clearly over loudspeakers may collapse binaurally, and vice versa. A sound spinning overhead may be vivid on speakers but flat on headphones if elevation cues are not well supported
3. **Avoid over-correcting**: if you adjust the mix purely for binaural, it may suffer on loudspeakers. Keep both playback paths as co-equal references

Many composers adopt a simple A/B switching setup: a speaker decoder and a binaural decoder on parallel busses, toggled by a mute. This makes the comparison immediate and keeps the decision-making grounded in both listening contexts simultaneously.

## HRTFs and Ambisonics Order

Binaural rendering quality scales with the Ambisonics order of the B-format signal. A first-order (FOA) mix decoded binaurally will have noticeably lower spatial resolution than a third-order (HOA) mix — blurrier localisation, less stable imaging. If the piece is being produced in FOA for technical reasons, the binaural result will reflect those limitations.

As a rule of thumb:
- **FOA (1st order)**: functional binaural decode, but limited precision — suitable for immersive background or diffuse textures
- **3rd order**: significantly improved localisation, good for precise spatial events
- **5th order and above**: close to the theoretical limit of binaural resolution — diminishing returns unless very high spatial precision is the artistic goal

## Binaural Mastering

A binaural master is a stereo file (typically WAV, 24-bit, 48 kHz or 96 kHz) intended for headphone playback. Key steps:

**1. Choose the reference HRTF deliberately.** Document which HRTF was used. If you deliver a binaural master to a label or festival, include this information in the technical rider.

**2. Apply headphone compensation.** Most HRTFs are measured on a dummy head with a flat frequency response. Real headphones colour the signal. Headphone compensation filters (available in dearVR, Sonarworks Reference, or Apple AirPods Pro adaptive EQ) correct for this and significantly improve externalisation. If no headphone compensation is applied, the result may sound coloured or unnaturally close.

**3. Check for in-head localisation.** Play back the binaural mix through multiple headphone types (closed-back, open-back, in-ear). Sources that should appear outside the head but remain inside it are a sign of insufficient externalisation — common causes are missing HRTF diffuse-field correction, an unsuitable HRTF dataset, or sources with insufficient spatial separation.

**4. Manage the low frequencies.** Below approximately 500 Hz, HRTFs provide little directional information; spatial cues at low frequencies rely almost entirely on level differences. Heavy low-frequency content in the Ambisonics mix may lack spatial definition in the binaural decode. Consider high-passing spatially encoded reverb tails and leaving sub-bass content as omnidirectional.

**5. Normalise appropriately.** Binaural mixes can have higher peak levels than the equivalent loudspeaker mix due to HRTF convolution. Aim for integrated loudness around –14 LUFS (streaming standard) and ensure no true peaks exceed –1 dBTP.

## Checking on Headphones

A brief quality checklist before finalising a binaural master:

- Does the front/back axis read clearly? A sound in front should not appear behind
- Do sounds above or below the horizon read correctly, or do they collapse to the horizontal plane?
- Are there any sources that remain stubbornly inside the head?
- Does the mix hold up on consumer earphones (not just studio headphones)?
- Is there any harsh high-frequency coloration introduced by the HRTF? (A gentle high-shelf cut at 8–10 kHz sometimes helps without damaging spatial cues)
- Does the piece still make sense if the listener moves their head? (Static binaural mixes will not track head movement; dynamic binaural with head-tracking data will — a relevant consideration for VR and installation contexts)

## Tools

The following plugins and environments support Ambisonics-to-binaural rendering:

| Tool | Type | Notes |
|------|------|-------|
| [IEM BinauralDecoder](https://plugins.iem.at) | Free VST/AU | Multiple HRTF datasets, supports HOA |
| [SPARTA Binaural Panner](https://leomccormack.github.io/sparta-site/) | Free VST/AU | Flexible, supports custom HRTFs |
| [dearVR Monitor](https://www.dear-reality.com) | Commercial | Headphone compensation, multiple HRTFs |
| [Envelopment](https://envelop.us/technology) | Free Max/MSP | Integration with Ambisonics workflows |
| [Apple Spatial Audio](https://developer.apple.com/documentation/avfaudio/audio-engine) | Platform | Personalised HRTF via AirPods Pro |
| [Headphone:X (2BSuccess)](https://www.2bsuccess.com) | Commercial | Focus on externalisation |

The ICST Ambisonics Plugins do not include a dedicated binaural decoder, but integrate cleanly with IEM and SPARTA tools within the same DAW session.

## Delivery Formats

When delivering a composition that includes a binaural version, standard practice is:

- **B-format master** (e.g., AmbiX, 4–16 channels depending on order): the archival format, can be decoded to any playback format
- **Binaural stereo WAV**: a baked stereo render for streaming and documentation; label clearly with HRTF used and whether head-tracking is supported
- **Multichannel loudspeaker stems**: for festival delivery (typically 8, 16, or 24 channels in the agreed channel order)

Delivering all three ensures the work can be experienced in the widest range of contexts over time.
