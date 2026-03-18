---
title: "Capturing Space and Synthetically Creating Space"
description: "A practical guide for Ambisonics composers on acoustic familiarisation, room analysis, and the decision between dry production, artificial reverb, and convolution."
date: 2026-01-01T00:00:00
weight: 78
draft: false
translationKey: "composing-room-capture"
---

At the start of any musical work process, musicians familiarise themselves with the acoustic properties of the space they are working in — whether a concert hall, a church, or a studio. As a composer of 3D Ambisonics fixed-media, you face the same fundamental questions, and a number of additional ones specific to spatial audio.

## Acoustic Familiarisation

Before starting work, every experienced performer listens to and assesses the space. A violinist tests how much the bow pressure and vibrato interact with a long reverberation time. A singer adjusts articulation and dynamic range so that text and expression do not disappear in the hall's reverb tail (Kalkandjiev & Weinzierl, 2023). A drummer might tape down the hi-hat to reduce unwanted high-frequency scatter.

As an Ambisonics composer, the equivalent step is a **listening walk**: move through the space before a session, clap your hands, and observe what you hear. Ask yourself: Where does the sound pool? How long does the tail last? Does it smear transients? What happens at the edges of the room?

This first impression will shape every compositional decision that follows.

## Analysing the Room

After the initial listening, a more systematic analysis is useful. Tools for measuring room impulse responses (IRs) such as Room EQ Wizard, Maat thEQred, or even a simple starter pistol recording can give you:

- **RT60** — how long it takes the sound to decay by 60 dB across different frequency bands
- **Early reflections** — the first discrete bounces that shape clarity and spatial width
- **Frequency response** — resonant modes that colour certain pitches
- **Diffuse-field behaviour** — how uniformly energy decays across the room

A room with RT60 > 2 seconds will smear fast rhythmic figures. One with a very short decay time (< 0.3 s, typical of a small studio) will make dry spatial positioning very precise but potentially fatiguing over time. Knowing these values lets you make **informed compositional choices** rather than discovering problems only during the concert.

## Adjustments and Practical Adaptations

Once the room's character is known, the question becomes: what can you actually change?

- **Reverberation level**: reduce artificial reverb in the Ambisonics mix if the hall already provides enough room sound
- **Distance simulation**: pull sources slightly inward to prevent them from sounding excessively remote in a highly reverberant space
- **Filtering**: roll off low frequencies slightly if the room has significant bass accumulation
- **Tempo and gesture density**: fast gestures and dense spatial movement tend to collapse in long reverb; simpler, slower spatial writing often survives better
- **Dry vs. wet sources**: a dry, close-sounding source will cut through more easily, while a diffuse bed fills and connects

The same adjustment logic that a string section applies to its articulation in a cathedral applies to the Ambisonics mix: **the room is part of the instrument**.

## Ambisonics-Specific Challenges

### Movement in Different Room Configurations

A spatial trajectory — a sound moving from front to back, spiralling overhead — will sound noticeably different depending on the playback system. What is crisp and well-defined over a dense 24-speaker ring in the ICST studio may become a broader smear in a less symmetric concert hall array. This is not a failure of the composition; it is a property of Ambisonics: the decoded image always interacts with the playback geometry and the listening room.

Practically, this means:

- Slower movements survive transposition to different venues better than very fast ones
- Wide diffuse fields are more layout-robust than narrow point-source trajectories
- If precise localization is artistically essential, test the piece on multiple systems before the premiere

### Downmix to Stereo and Headphones

A second key question is: **does the piece work in a stereo downmix and on headphones?** Many listeners will encounter the work through exactly these formats — in documentation, on streaming platforms, or at home.

A binaural decode of a well-structured Ambisonics mix usually conveys the spatial character well. A naive stereo downmix (collapsing all channels to two) may lose most of the spatial information. Decisions worth making early:

- Does every source have meaningful content in the W (omnidirectional) channel, so a mono downmix is still coherent?
- Is the piece intelligible without spatial information, or does the spatial layer carry structural weight that will be lost?
- Should a separate binaural master be delivered?

### Studio Versus Large Hall

What works in an 8 × 8 m studio sounds different in a 30 × 70 m concert hall. The hall adds its own long reverb on top of the encoded one. Spatial motion that reads as nimble and articulate in the studio may feel sluggish and blurred at a larger scale. Conversely, a slowly diffusing texture that sounds static in the studio may come to life in a large, reverberant space.

If you have the opportunity, **test the piece in the target venue before the premiere**. If not, the following heuristics are useful: plan for more spatial simplicity than you think you need, leave room for the hall to breathe, and avoid encoding heavy artificial reverb that will multiply unpredictably with the venue's own decay.

## Methodological Approaches

### Dry Production vs. Wet Production

One of the fundamental decisions in fixed-media Ambisonics composition is whether to produce **dry** — encoding sources with little or no reverb — or **wet** — baking reverb into the B-format from the beginning.

**Arguments for dry production:**
- Reflections in the venue will not compound with encoded reverb to create uncontrolled mud
- The piece remains legible in drier monitoring contexts (headphones, studio)
- Spatial positions stay distinct and precise

**Arguments for wet production:**
- The artistic vision of an enveloping, reverberant space can be fully realised in the studio
- The piece works more reliably on headphones, where no room sound is added by the playback environment
- Convolution reverb with a specific room IR can be encoded spatially, creating a precisely shaped acoustic environment

In practice, many composers use a **hybrid approach**: encode sources dry with accurate spatial positions, then add a modest shared reverb on the Ambisonics bus — enough to glue the scene, but not so much that the venue doubles it to excess.

### A/B Comparison

A simple and effective test method is an **A/B comparison** between:

- a dry version (sources positioned in Ambisonics with minimal reverb)
- a wet version (with artificial or convolved reverb added)

Playing both through the same system — ideally through both loudspeakers and headphones — reveals how much room sound the composition needs, and where the balance between spatial clarity and immersive depth lies. This kind of iterative testing is as much a compositional act as sketching melodic material.

### Three Approaches to Integrating Room Acoustics

Once the room is understood, three production paths are available — each with different technical requirements and artistic results.

---

**Approach 1 — Record the room as a convolution reverb**

Record the target room's impulse response (IR) with an Ambisonics microphone and use it as a spatial convolution reverb during production. This allows you to "pre-bake" the concert hall acoustics into the piece while still working in the studio.

Workflow:
1. Generate a sine sweep (using Room EQ Wizard, Reaper, or similar) and play it through a full-range loudspeaker in the target room
2. Record the response with an Ambisonics microphone — the **Zylia ZM-1** (3rd-order HOA, 19 capsules) gives excellent spatial resolution; the **Sennheiser Ambeo VR Mic** or **Rode NT-SF1** work well for first-order captures; the **Core Sound TetraMic** or **Eigenmike em32** are also suitable
3. Decode the recorded IR to B-format (AmbiX) using the microphone's own software or IEM / SPARTA tools
4. Apply the B-format IR in the DAW as a convolution reverb on individual sources or the Ambisonics bus — plugins such as **Reaper's ReaVerb**, **Altiverb**, or the **IEM RoomEncoder** support multichannel convolution

The result is a piece that already carries the acoustic signature of the target venue. When played back in that hall, the encoded room and the live room blend — which can be artistically very powerful, or occasionally problematic if the decay doubles too noticeably. If the venue changes, a new IR can be substituted without reworking the composition.

**Strength:** Physically accurate; the spatial character of the specific room is preserved in full 3D.
**Consideration:** Requires access to the venue in advance; IR capture takes 30–60 minutes on site.

---

**Approach 2 — Synthesise a virtual room in Ambisonics**

Rather than capturing a real room, generate a synthetic spatial reverberation algorithmically. This approach is fully studio-based and gives complete creative control over all room parameters.

Key tools:

- **IRCAM Spat5** (Max/MSP, standalone, or VST) — the most powerful spatial reverb environment for Ambisonics work; supports room modelling, source directivity, and full HOA output up to arbitrary order; room size, RT60, early reflections, diffusion, and air absorption are all controllable per source
- **SPARTA AmbiBIN / Hybrid Reverb** — free VST with Ambisonics-native reverb and binaural output
- **IEM FdnReverb** — free feedback delay network reverb with Ambisonics output, suitable for envelopment and large hall simulation
- **Aalto Spatial** / **dearVR Spatial Connect** — commercial options with HRTF-based room simulation
- **Panoramix** (IRCAM, Max/MSP) — used in many acousmatic concert contexts; includes directional reverb and spatialisation in a single environment

With a tool like Spat5, you can build a room that does not exist — a 40-metre stone vault, a spherical chamber, an anechoic space — and compose specifically for its properties. The room becomes a compositional instrument rather than a physical constraint.

**Strength:** Complete creative freedom; no venue access needed; room properties can change across sections of the piece.
**Consideration:** Synthetic reverbs can sound less physically convincing than real IRs for certain material; requires time to calibrate to a realistic or coherent result.

---

**Approach 3 — Combine both: hybrid production**

The most flexible approach combines a real captured IR (for overall spatial character) with a synthetic reverb layer (for compositional control). Typical hybrid setups:

- Apply the **real IR** as a light convolution tail on the Ambisonics bus — giving the piece the "flavour" of the target space — while keeping individual source reverb **synthetic** for precise control of early reflections and source distance
- Use Spat5 or similar to shape the **early reflections** (which have the most decisive effect on perceived source distance and room size), and use a real IR for the **late diffuse tail** only
- In Reaper: route sources through a Spat5 insert for spatial positioning and early reflection shaping, then send the Ambisonics bus through a convolution reverb loaded with the venue IR for the late field

This approach is common in professional fixed-media production at ICST and at IRCAM: the real room gives credibility to the acoustic space; the synthetic layer gives compositional precision that a raw IR capture alone cannot provide.

**Strength:** Physically grounded but compositionally controllable; works even if the venue IR is not yet available (build with a similar reference IR, substitute later).
**Consideration:** More complex routing; careful gain staging is needed to avoid reverb multiplication.

## Summary: Questions to Ask Before Each Production

Before committing to a final mix, work through this checklist:

- Where and how will this piece be played? What is the likely RT60?
- Have I tested spatial movements in a venue comparable to the premiere space?
- Does the piece translate to stereo and headphones?
- Have I chosen between dry, wet, or hybrid production deliberately?
- Have I made an A/B comparison between different reverb levels?
- Do I have the target room's impulse response, and have I considered using it?

The room is always co-composer. The earlier in the process you account for it, the more of the work ends up intentional rather than accidental.

---

**Reference:** Kalkandjiev, Z., & Weinzierl, S. (2023). *The effect of room acoustics on performance practice and musical interpretation.* Acoustics, 5(2), 454–467.
