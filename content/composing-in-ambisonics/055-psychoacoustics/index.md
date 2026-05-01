---
title: "Psychoacoustic Foundations of Spatial Perception"
description: "How the auditory system localises spatial sound — and what composers can derive from it."
date: 2026-01-01T00:00:00
weight: 55
translationKey: "composing-psychoacoustics"
---

Spatial composition presupposes that perceptual effects can be achieved reliably. A sound should appear closer, a voice should seem to come from above, a movement should travel from left to right — all of this can only function as compositional material if the ear actually experiences it that way. This chapter provides an overview of the key mechanisms of spatial perception and derives concrete consequences for composing in Ambisonics.

The psychoacoustic foundations of spatial hearing are not a purely technical subject. They describe what the auditory system can accomplish, where it reaches its limits, and under which conditions spatial events are stable, ambiguous, or ineffective. Knowing these mechanisms means composing not against perception, but with it.

## The Binaural System: Horizontal Localisation

The first and most fundamental mechanism of spatial perception is binaural: the brain compares the signals reaching both ears and evaluates the differences to determine horizontal positions.

**ITD (Interaural Time Difference)** refers to the difference in arrival time of a sound event between the left and right ear. A sound from the left reaches the left ear earlier. The brain processes this time difference with great precision; it is the dominant localisation cue especially at low frequencies (below approximately 1.5 kHz).

**ILD (Interaural Level Difference)** describes the level difference between both ears caused by the acoustic shadow of the head: the ear facing away from the sound receives less energy. ILD is particularly effective at high frequencies (above approximately 1.5 kHz).

Both cues complement one another in what is known as the **duplex model**: low-frequency components are primarily localised via ITD, high-frequency components via ILD. Sound objects with a broad frequency spectrum are therefore the easiest and most reliably localised.

*Compositional consequence:* Narrow-band low tones (bass, sine tones below 500 Hz) are difficult to localise laterally. When compositional clarity is needed — for instance a clearly led counterpoint between two voices — it helps to use material with sufficient energy in the mid and high frequency range. Low-frequency material is better suited to diffuse fields or envelopment effects.

## HRTF: Elevation and Front-Back

The horizontal plane alone is not enough to create a three-dimensional sound image. For elevation (up/down) and for resolving front-back ambiguity, a further mechanism is responsible: the **Head-Related Transfer Function (HRTF)**.

HRTFs describe how the outer ear (pinna), head, and shoulders colour incoming sound spectrally depending on its direction. A sound from above is filtered differently than one from below or from behind — these characteristic spectral signatures are evaluated by the brain as directional cues.

HRTFs are **individual**: every person has slightly different pinnae, a different head shape, different shoulders. Generic HRTFs (as used in binaural decoders) work well enough for many listeners, but can for some individuals lead to incorrect elevation perception, in-head localisation, or front-back confusion.

*Compositional consequence:* Elevation gestures are effective but fragile. They are especially vulnerable to strong spectral processing (EQ, effects) that masks the HRTF cues. For compositional impact, it helps to combine elevation differences with other cues — such as distance or movement changes — to stabilise the percept.

## Distance Perception: Multiple Cues, No Single Reliable Source

Distance is not determined by a single mechanism, but by the interplay of several cues:

- **D/R ratio (Direct-to-Reverberant Ratio):** The ratio of direct sound to diffuse reverb is the most powerful distance cue. More direct sound → near; more reverb → far. In Ambisonics this is controllable via the distance parameter in the encoder.
- **Loudness:** Greater level tends to be perceived as closer — but this is strongly context-dependent and overlaid by musical expectations.
- **Air absorption:** Over large distances, air preferentially attenuates high frequencies. This can be simulated compositionally (high-frequency roll-off = more distance).
- **Spectral brightness:** Nearness is often associated with greater treble energy; distance with a duller, filtered sound image.

*Compositional consequence:* The strongest sense of distance arises from the **combined control** of D/R ratio, level, and spectral brightness. Changing only the level produces loudness, not distance. Only shifting several cues simultaneously makes nearness and farness convincingly perceptible.

## Envelopment and Source Width: LEV and ASW

Two psychoacoustic quantities describe how a sound field is experienced as immersive or object-oriented:

**LEV (Listener Envelopment)** is the sensation of being surrounded by sound. It is produced primarily by **late lateral reflections** — diffuse energy arriving from the sides and rear. High LEV can be created through diffusion, rear spread, and reverberant texture layers.

**ASW (Apparent Source Width)** describes how wide a source appears. It is determined primarily by **early lateral reflections**. A source with high spread or broad multichannel encoding sounds larger and more space-filling.

The compositionally decisive difference: ASW concerns the **perceived size of an object**, LEV concerns the **spatial surround**. Both can be shaped independently in Ambisonics via spread, diffusion, and reverb proportion.

*Compositional consequence:* For a convincing immersive sound experience, distributing sources in a circle is not enough. Envelopment arises only from **diffuse energy** — from textures, reverberation, and layers arriving from all directions simultaneously. Precisely localised point sources alone produce no envelopment, regardless of how many there are.

## The System as a Whole: Cue Consistency

The most powerful spatial moments arise not because one cue is particularly strong, but because **several cues work together consistently**. A convincingly near sound event has high direct sound, little reverberation, bright spectral balance, and a clear lateral ILD position. When these cues are contradictory — for instance a very loud sound with heavy reverberation — spatial ambiguity or instability arises.

This consistency is also a compositional resource: contradictory cues can be used deliberately as a means of irritation or defamiliarisation. Spatial instability is not a malfunction but a compositionally controllable effect.

## Perceptual Limits: What Is Reliable, What Is Fragile

Some parameters of spatial perception are robust; others are context- and setup-dependent.

**Reliable:** Lateral localisation (left/right) via ITD and ILD works well for broadband sounds on both loudspeakers and binaural. Coarse distance differences (near vs. far) are readily perceived when several cues work together. Envelopment from diffuse energy is robust.

**Fragile:** Elevation is HRTF-dependent and setup-sensitive. On loudspeaker systems with physical height channels it performs better than binaural. Front-back resolution can fail on loudspeakers if the decoding grid is too coarse or the listening position falls outside the sweet spot. Precise distance coding requires consistent reverb conditions — it breaks down when the acoustic character of the playback room overlays the encoded spatial components.

*Compositional consequence:* The more a spatial idea depends on fragile cues, the more important it is to combine them with more robust ones. A sound defined only by elevation may be lost in many performance situations. Those who wish to use elevation compositionally should link it to distance, movement, or spectral changes that remain perceptible even when HRTF resolution degrades.

---

Knowledge of these mechanisms is not a constraint on composing — it is the foundation on which spatial form can be reliably built. The chapters that follow build on this groundwork: **Spatial Parameters** describes how the individual parameters are applied compositionally; **Spatial Counterpoint** shows how multiple sources can be set in spatial voice-leading relations to one another.
