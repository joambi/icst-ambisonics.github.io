---
title: "10 Questions in 3D Space"
description: "A practical compositional checklist for Ambisonics pieces."
date: 2026-01-01T00:00:00
weight: 40
draft: false
translationKey: "composing-10-questions"
---

The following questions are intended as a **compositional worksheet**. They are useful not only for analysing existing works, but also for planning your own pieces, during studio sessions, and for documentation.

## Ten Short REAPER Studies

The following miniatures are intended as **1–2 minute sketches**. Each study answers one of the ten key questions in a practical way and can be realized quickly in **REAPER** with the **ICST Ambisonics Plugins** or similar HOA toolchains. They are deliberately kept small: more **compositional études** than finished pieces.

For all examples, a basic setup is sufficient:

- 1 master track with `AmbiDecoder` or `MultiDecoder`
- 2 to 6 sound tracks with `MonoEncoder` or `MultiEncoder_64`
- ambiX / ACN-SN3D
- a target setup such as `binaural`, `IEM BinauralDecoder`, or an available dome preset

### Quick Overview

| Question | Duration | Tracks | Main Automation | Goal |
| --- | --- | --- | --- | --- |
| 1. Ontology | 1:30 | 3 | Position, Distance, Height | make the same material audible in three spatial worlds |
| 2. Space vs. Spectrum/Time | 2:00 | 2 | Azimuth, Elevation, Distance vs. Audio FX | compare whether form arises more through space or through sound transformation |
| 3. Spatial Layers | 1:30 | 3 groups | Distance, Spread, slow circular motion | stably stratify foreground, midfield, and far field |
| 4. Object Count / Density | 2:00 | 6–8 | number of sources, position, grouping | find the tipping point between clarity and cloud |
| 5. Trajectories | 1:30 | 3 | circle, line, ascent, implosion | test movement vocabulary as formal markers |
| 6. Localisation vs. Diffuseness | 1:30 | 1–2 | Spread, Distance, Decorrelator mix | compose focus and defocus gestures |
| 7. Listening Scenario | 1:00–2:00 | 3 | overhead vs. lateral movement | make differences between dome and binaural mix audible |
| 8. Audience | 1:30 | 3–4 | small vs. large spatial contrasts | test legibility for different listening habits |
| 9. Real Space / Archetypes | 2:00 | 3 | room character, EQ, reverb, axis movement | build tunnel, square, and open sky as archetypes |
| 10. Work Identity | 1:00 | 2–3 | one clear main trajectory | miniature plus clean documentation for transferability |

### Mini-Study 1 — Ontology: What Kind of World Is This?

**Duration:** approx. 90 seconds

**Idea:** Build three short versions of the same material in REAPER: a **real scene**, an **abstracted scene**, and a **purely imagined spatial world**.

**Material:**
- Track 1: footsteps or breath
- Track 2: field recording or noise
- Track 3: synthetic sine/granular sound

**Structure:**
- `0:00–0:30`: realistic. Footsteps front left, ambient recording as a wide backdrop, few impossible movements.
- `0:30–1:00`: abstracted. The same material is stretched, shifted in height, and sonically defamiliarized.
- `1:00–1:30`: imagined space. Only spectral traces, diffuse surfaces, and unclear depth stratification remain.

**REAPER focus:** Place the same sources within three different spatial logics. This immediately reveals how strongly the **ontology** of the piece shapes compositional decisions.

### Mini-Study 2 — Space vs. Spectrum/Time: What Carries the Form?

**Duration:** approx. 2 minutes

**Idea:** Compose two contrasting sections: in one, form emerges almost entirely through **spatial movement**; in the other, almost entirely through **spectral-temporal transformation**.

**Material:**
- a stable drone sound
- a short percussive sound

**Structure:**
- `0:00–1:00`: the spectrum stays almost the same, but the drone travels from floor to ceiling, from ring to center, from sharp to diffuse.
- `1:00–2:00`: space stays almost static, while filter, granulation, and rhythm take over the form.

**REAPER focus:** In the first section, draw mainly `Azimuth`, `Elevation`, `Distance`, and `Spread` automation. In the second section, these values remain nearly unchanged while audio effects take over the form.

### Mini-Study 3 — Spatial Layers: Foreground, Midfield, Far Field

**Duration:** approx. 90 seconds

**Idea:** Set up three clearly distinguishable **layers** and check whether they remain stably perceivable as separate planes, even with eyes closed.

**Material:**
- foreground: short clicks or individual tones
- midfield: floating texture
- far field: diffuse reverb or wind cloud

**Structure:**
- `0:00–0:30`: layers clearly separated
- `0:30–1:00`: midfield begins a slow circular motion
- `1:00–1:30`: foreground sinks into the texture; far field briefly becomes brighter and closer

**REAPER focus:** Work with three track groups and different distance/spread values. The goal is not just movement, but **readable stratification**.

### Mini-Study 4 — Object Count and Density: When Does Clarity Tip Into Cloud?

**Duration:** approx. 2 minutes

**Idea:** Begin with one object and gradually densify the scene until it overflows, then clear it again.

**Material:**
- 6 to 8 short sound objects, for example metallic samples, speech fragments, or sine tones

**Structure:**
- `0:00–0:30`: 1–2 clearly localised objects
- `0:30–1:00`: 3–4 objects with individual paths
- `1:00–1:30`: 6–8 objects, partly overlapping
- `1:30–2:00`: reduction to 2 objects and a wide residual cloud

**REAPER focus:** Use `MultiEncoder_64` to layer several sources quickly. Listen carefully for the point at which the scene no longer sounds contrapuntal but merely textural.

### Mini-Study 5 — Trajectories and Gesture Types

**Duration:** approx. 90 seconds

**Idea:** Build a small movement vocabulary from four gestures: **circle**, **line**, **ascent**, **implosion**.

**Material:**
- a bright tone
- a rough noise
- an impulse or bell sound

**Structure:**
- `0:00–0:20`: circular motion around the head
- `0:20–0:40`: straight trajectory from back to front
- `0:40–1:00`: vertical ascent
- `1:00–1:30`: multiple points drawn toward center

**REAPER focus:** Draw only one dominant automation for each gesture. This makes it audible how differently movement types function as **formal markers**.

### Mini-Study 6 — Localisation vs. Diffuseness

**Duration:** approx. 90 seconds

**Idea:** A single sound material travels several times along the path from **precisely localised** to **nebulously diffuse** and back.

**Material:**
- a short percussive sound or speech fragment
- optionally a decorrelator / reverb / granular effect

**Structure:**
- `0:00–0:20`: dry, sharply localisable
- `0:20–0:45`: increasing spread and decorrelation
- `0:45–1:05`: maximum cloud
- `1:05–1:30`: refocusing onto a single point

**REAPER focus:** Automate `Spread`, `Distance`, and the proportion of diffuse effects. This study works well for testing **focus and defocus gestures** as formal elements.

### Mini-Study 7 — Target Listening Scenario

**Duration:** approx. 1–2 minutes

**Idea:** Design a sketch once optimised for **dome** and once for **binaural**, and compare the priorities.

**Material:**
- 3 sound sources with clear directional profiles

**Structure:**
- Version A: strong use of overhead and vertical shifts
- Version B: the same form, but with greater weight on lateral movements and clear front/back axes

**REAPER focus:** Save two decoder or mix variants of the same project. This immediately shows how the intended **playback scenario** shapes the composition.

### Mini-Study 8 — Audience and Listening Experience

**Duration:** approx. 90 seconds

**Idea:** Compose the same sequence at two levels of legibility: once for an **experienced spatial audio audience**, once for a more **general audience**.

**Material:**
- 3 to 4 sound objects

**Structure:**
- `0:00–0:45`: subtle differences, small angle changes, fine height stratification
- `0:45–1:30`: the same idea in broader, clearer form with stronger contrasts

**REAPER focus:** Duplicate a passage with different automation curves. The question here is not only what is possible, but **what remains quickly legible**.

### Mini-Study 9 — Real-Space Reference and Archetypes

**Duration:** approx. 2 minutes

**Idea:** Compose a short passage through three spatial archetypes: **tunnel**, **open square**, **rooftop / open sky**.

**Material:**
- footsteps or impulses
- ambience or wind
- reverb / filter for room characterisation

**Structure:**
- `0:00–0:40`: tunnel. Narrow axis, front-back emphasis, little width.
- `0:40–1:20`: square. More openness, lateral breadth, clearer reflection-free zone.
- `1:20–2:00`: rooftop. Height, air, far field, overhead presence.

**REAPER focus:** Use not only position but also reverb type, EQ, and dynamics. Space is thus not claimed as metaphor but **compositionally constructed**.

### Mini-Study 10 — Work Identity and Documentation

**Duration:** approx. 1 minute, plus documentation

**Idea:** Create a short study, then document it as if another studio needed to reconstruct it.

**Material:**
- 2 to 3 sound objects
- one clear spatial form, for example a left/right dialogue with a rise toward the ceiling

**Structure:**
- `0:00–1:00`: a complete miniature with opening, densification, and closing gesture

**REAPER focus:** After completing the study, export not only audio but also note:
- HOA order and format
- decoder assumption used
- key trajectories
- critical spatial zones
- screenshot of the automation or radar view

---

These ten studies can be worked through individually or assembled into larger project sketches. It is particularly productive to test **the same sound source** across several questions. This makes it audible that the key questions relate not only to content, but directly to **form, routing, automation, and dramaturgy**.

The ten questions make clear that spatial composition does not consist solely of positions and movements, but depends on the perceptibility and stability of sonic units. Before spatial relations between multiple sound objects can be shaped precisely, it is therefore necessary to ask what allows a sound to emerge in space as a recognisable gestalt in the first place. The following chapter turns to **The Acoustic Gestalt of a Sound**.

---

## The Ten Questions

### 1. Ontology of the Piece — What Is There?

**Key question:** What kind of world does the piece build in space?

Sub-questions: Am I working with recognisable places/scenes (city, landscape, interior) or with abstract spatial formations? Are there identifiable actors (sound objects) and environments (fields, textures)?

Options:
- realistic / ecological
- abstracted from real spaces
- purely abstract / "imagined space"
- focus on individual objects
- focus on textures/fields

---

### 2. Role of Space — Space vs. Spectrum/Time

**Key question:** What primarily carries the form — spatial gestures or spectral-temporal development?

Sub-questions: Could the piece still work in stereo, or would the form collapse? Are there sections defined almost exclusively through spatial change (space-form)?

Options:
- form primarily spectral/temporal, space secondary
- form equally space + spectrum/time
- form primarily spatial (spatial architecture, sounds fill it)
- mark per section: "R > S/T", "R = S/T", or "R < S/T"

---

### 3. Spatial Layers

**Key question:** How many distinguishable spatial layers are there?

Sub-questions: Which zones matter (front, back, above, below, near, far)? Is there a constant backdrop against which foreground gestures unfold?

Options:
- foreground objects (clearly localisable)
- midfield texture
- background ambience / far field
- overhead layer / "ceiling"
- floor / below ear level

Note for each layer: sound type, density, typical movements.

---

### 4. Object Count and Density

**Key question:** How full is the space at any given moment?

Sub-questions: How many active objects can be consciously tracked at once? Are there deliberate density tips (gesture → texture, clarity → cloud)?

Options:
- maximum number of trackable objects: ___
- typical density per section (e.g. 1–3 / 4–8 / >8 objects)
- mark moments where you deliberately move into overflow or emptiness

---

### 5. Trajectories and Gesture Types

**Key question:** Which types of movement appear?

Sub-questions: Am I using geometric movements (circles, rings, spirals) or gestural movements (approach, flight, circling)? Are there signature gestures that recur?

Options:
- circle / orbital motion
- line / travel in one direction
- vertical motion (bottom-up / top-down)
- explosion / implosion
- swarm / flock (many similar trajectories)

For each gesture: briefly note its purpose (e.g. start of new section, climax marker).

---

### 6. Localisation vs. Diffuseness

**Key question:** When should sounds be pinpoint precise, when diffuse?

Sub-questions: Are there dramaturgically important moments of maximum sharpness or maximum envelopment? Am I using focus/defocus transitions deliberately as a formal element?

Options — scale 1–5 for each section:
- 1 = very diffuse / cloud
- 3 = mixed
- 5 = very precise localisation

Mark moments: focus gesture (diffuse → point) / defocus gesture (point → diffuse).

---

### 7. Target Listening Scenario

**Key question:** For which real playback setting am I composing?

Sub-questions: Which loudspeaker configuration do I have in mind (dome, 5.1/7.1, headphones)? Does the piece need to work in multiple formats?

Options — primary target:
- 3D dome / specific array
- multichannel (5.1 / 7.1 / 22.2)
- binaural (headphones)

Secondary: stereo compatibility important / unimportant. Note any constraints per target (e.g. overhead structures are weakened in binaural).

→ *Listen:* [#13 Listening Twice — Stereo vs. Immersive](/blog/ascolta/13-ascolta/) · [#14 5.1 Surround vs. Ambisonics UHJ](/blog/ascolta/14-ascolta/) · [#15 UHJ Recordings from the 1970s](/blog/ascolta/15-ascolta/)

---

### 8. Audience and Listening Experience

**Key question:** How spatially "trained" is the assumed audience?

Sub-questions: Will the piece be performed mainly at festivals with an experienced audience or in general-audience contexts? Do contrasts need to be clear and legible, or can they remain subtle?

Options:
- spatially experienced audience
- mixed
- little experience

Consequence: strong, clear spatial contrasts / finer, microscopic differences / combination (e.g. clear macro-arc + subtle details).

→ *Listen:* [All ASCOLTA sessions](/blog/ascolta/) — from expert to first-time listeners

---

### 9. Real-Space Reference and Archetypes

**Key question:** How do I relate to real spaces and spatial metaphors?

Sub-questions: Am I using familiar archetypes (tunnel, square, interior, exterior, height, abyss)? Do I want to recreate real spaces, distort them, or build something physically impossible?

Options:
- mimesis (recreation of real spaces)
- distortion / exaggeration
- impossible spaces

List of archetypes used and their musical function (e.g. tunnel = transition, square = culmination point).

→ *Listen:* [#10 Natasha Barrett — spatial argument about enclosure and opening](/blog/ascolta/10-ascolta/)

---

### 10. Work Identity and Documentation

**Key question:** What actually is the "work" — and how do I document it?

Sub-questions: Is the HOA master file the actual core of the work, or is a specific decoder configuration? Does the piece need a score, patch, written instructions, and layout plans to remain reconstructible?

Options — reference version:
- HOA master (e.g. 7th order)
- specific loudspeaker version (e.g. 24.1 layout X)
- binaural release

Documentation:
- loudspeaker plan(s)
- text description of the spatial form(s)
- screenshots/exports of trajectories / automation
- a "spatial score" (diagrams/timeline)
