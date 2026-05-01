---
title: "Ambisonics in VR and Installation"
description: "Spatial sound in sound installations and VR contexts: head tracking, interactive listening, installation without sweet spot, and compositional specifics."
date: 2026-01-01T00:00:00
weight: 91
translationKey: "composing-vr-installation"
---

Ambisonics was originally conceived as a concert format — an audience, a spatially reproduced acoustic perspective, a performance event. Two further contexts substantially alter this basic constellation: **sound installations** and **virtual reality**. In both cases, there is no fixed audience in a fixed relation to the sound field; instead, people move through the space or through a virtual scenario, and the listening experience is individual, temporally variable, and often non-linear.

For composers, this means: compositional control shifts from the score toward a **system** that responds to use, position, and movement. Ambisonics remains the central format — but its application changes fundamentally.

## Sound Installations: Space Without Conducting

A sound installation is a place, not a performance. People enter, stay, move on — at unpredictable moments, for unpredictable durations. The acoustic field exists independently of visitors, or it responds to their presence.

### The Absent Sweet Spot

In the concert context, a central listening point — the sweet spot — is optimised. In an installation, this is impossible. The sound field must be experienceable by people at different positions in the space: front, back, lateral, close to loudspeakers, far from the centre.

**Compositional consequence:** Ambisonics installations should rely on strategies that are perceivable regardless of position:
- **Envelopment (LEV)** rather than precise localisation: diffuse energy and reflection structures are experienceable from any standpoint; exact angular position is not.
- **Sound fields and textures** rather than individual events that presuppose a specific listening point.
- **Spatial hierarchy** through intensity and spectral properties, not only through azimuth position.

This does not mean that localisation is excluded. But it becomes less reliable than in concert, and a composition relying exclusively on precise point localisation loses a substantial part of its effect outside the sweet spot.

### Temporally Non-Linear Listening

A visitor enters the installation after 4 minutes, stays for 7 minutes, leaves. Another hears from the beginning, leaves after 2 minutes. Linear narrative composing — a piece with a clear beginning, middle, and end — functions in this context only if the total duration is short enough that it is almost always heard in full.

Alternatives:
- **Cyclic structures:** The piece regularly returns to departure points. Every entry time is a valid entry point.
- **Generative systems:** Sound events are algorithmically generated or varied. Repetition with variation rather than repetition without difference.
- **Atmospheric time structure:** No narrative arc, but a temporal state — a sound field that changes slowly but marks no individual dramaturgical points.

### Interaction and Response

Installations can respond to presence. Sensors (motion detectors, cameras, microphones) supply data that modify spatial parameters: a person enters → a sound event is triggered; several people move → the sound field changes its density; silence in the room → the field opens up.

In this context, Ambisonics becomes part of a larger interactive system. The encoding of spatial events can be controlled via Max/MSP, SuperCollider, Pure Data, or similar systems communicating with REAPER and the ICST plugins via OSC.

## Virtual Reality: Head Movement as Compositional Parameter

VR combines the immersive perspective of Ambisonics with a new degree of freedom: **head tracking**. The acoustic field follows the wearer's head movement — when the head turns, the listening perspective turns accordingly. What is experienced in the concert as a fixed spatial arrangement becomes in VR a space the body can explore.

### Binaural + Head Tracking

VR Ambisonics is rendered almost exclusively binaurally. The Ambisonics field is converted in real time into a binaural signal, incorporating the current head orientation (yaw, pitch, roll from the VR hardware). The result: if a source sounds "right", it remains right even when the head turns. This is the decisive difference from static binaural rendering without head tracking.

**Compositional implication:** Head tracking changes the relationship between composer and listener fundamentally. The composer establishes a spatial constellation — sources, fields, movements. The listener actively explores this constellation through head and body movement. The experience is partially personalised: someone looking left hears the left side of the field frontally; someone looking straight ahead hears it laterally.

### Static vs. Dynamic Sources in VR

In VR there are two fundamental source types:

**World-locked:** The source remains at a fixed position in virtual space. When the head turns, the relative direction of the source changes. This creates the strong immersion effect of VR audio: the source "is" at a location.

**Head-locked:** The source follows the head movement and remains at the same relative position (e.g. always directly in front of the listener). Useful for narration, interface sounds, or elements that should remain stable regardless of head movement.

**Ambisonics** is the ideal format for world-locked audio, since it encodes the complete sound field and the decoding can incorporate head-tracking data in real time.

### Psychoacoustic Specifics in VR

VR introduces specific psychoacoustic challenges that are compositionally relevant:

**Externalisation and in-head localisation:** Binaural audio without a perfectly matched HRTF often sounds "inside the head" rather than "out in the space". Ambisonics-based VR audio with head tracking substantially improves externalisation, but not completely. Higher HOA orders (5th or 7th) improve binaural quality.

**Vertigo and orientation stability:** Inconsistency between the visual and acoustic worlds in VR can cause disorientation or discomfort. Audio latencies of more than 20–30 ms between head movement and sound field update can become perceptible. For musical composition, this means: non-synchronous spatial cues should be used deliberately and sparingly.

**Presence:** The sensation of "actually being there" depends strongly on spatial audio quality in VR. Realistic room acoustics, consistent occlusion (sound change behind objects), and coherent perspective substantially increase presence. Compositionally, this dimension can be exploited — or deliberately broken.

### Ambisonics Formats for VR

The standard for 360° video and VR platforms is **First-Order Ambisonics (FOA) in ambiX/ACN-SN3D**. Platforms such as YouTube 360, Facebook/Meta 360, and most VR engines (Unreal, Unity) support this format directly. For higher orders there are toolchain-dependent solutions (IEM, Resonance Audio, Steam Audio), but no universal platform standards.

**For composers at the ICST:** The ICST plugins operate in ACN/SN3D and are therefore directly compatible with VR workflows. An Ambisonics composition produced in REAPER can be exported as an ambiX file and imported into VR engines or 360° video editing software.

## Compositional Consequence

VR and installation are not marginal special cases of Ambisonics — they are independent compositional contexts with their own audience behaviour, their own perceptual conditions, and their own strengths. Their common denominator is the **activity of listening**: rather than a passive reception role as in the concert, in both contexts listening itself becomes an act of spatial traversal.

Compositional thinking must adapt: no longer "what do I hear when", but "what is experienceable wherever one is and in whatever direction one moves". This does not exclude narrative linearity — but it requires a different form of compositional control: the shaping of spaces and states rather than temporal progressions.

The technical tools are the same — ICST plugins, REAPER, ambiX format. But the compositional architecture in which they are deployed differs substantially from concert and fixed media. Those composing for VR or installation must hold as a foundational question for every compositional decision: "How will different people experience this piece simultaneously and independently of one another?"
