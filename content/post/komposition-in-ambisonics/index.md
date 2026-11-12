---
title: "Composing in Ambisonics: Space, Movement and Performance"
description: "Not just 'more space': Ambisonics as a compositional system with perspective, movement, density and translation to different playback situations."
date: 2026-05-11T00:00:00+02:00
year: 2026
month: 2026-05
tags: ["composition", "performance", "workflow", "ambisonics", "space", "live"]
categories:
  - ICST Ambisonics Workshop
  - Composition
difficulty: "intermediate"
post_kind: "background"
---

The best way to prepare for Ambisonics is to treat it like an instrument of its own: not just "more space", but a compositional system with perspective, movement, density and translation to different playback situations.

This means: space is not an effect that you lay over a finished composition at the end. It is a parameter that has to be thought of from the start – just like timbre, dynamics or form. Anyone who only "applies" Ambisonics in the mix uses the system by half.

---

## 1. Think of space as a score

Before you record a single track or open an encoder, it is worth sketching the composition spatially – not as a technical plan, but as a dramaturgical idea.

Consider early on:

- Which sounds are **points** in space?
- Which are **surfaces / atmospheres**?
- Which really move?
- Which should only "breathe spatially"?
- Is there a clear front, centre, top, bottom?
- Is the audience inside the sound, or does it look at a virtual scene?

The distinction between point and surface is decisive: a single high tone moving from left to right is a point – it has direction and sharpness. A deep, diffuse room sound that envelops the listener is a surface – it has density but no clear source. Both have their compositional function, but they react very differently to movement, loudness and distance.

The question of the audience's perspective is one of the most fundamental in spatial composition. Is the audience in the middle of the sound – surrounded, enclosed, immersed? Or does it look at a scene in which sounds act like figures on a stage? Both approaches are legitimate, but they demand completely different compositional decisions, especially with regard to distance and spatial depth.

> **Note**
> What happens musically when you close your eyes? If the spatial idea remains comprehensible even then, it is usually strong. This is a useful test because it separates space from visual expectation – Ambisonics works not through seeing but through hearing.

---

## 2. Clarify the technical setup beforehand

Technical uncertainties before a performance can ruin everything – even a carefully prepared composition. Ambisonics setups vary greatly: between studios with height layers and simple loudspeaker rings, between HOA7 and FOA, between REAPER and Max/MSP. What sounds good at home may sound completely different at the venue if the decoder setup is not known.

Before a performance you should know:

- Which Ambisonics order? 1st, 3rd, 5th order?
- ACN/SN3D or another format?
- Binaural, loudspeaker array or both?
- How many loudspeakers and where do they stand?
- Are there height loudspeakers?
- Which DAW or environment: REAPER, Max/MSP, Ableton with plugins, SuperCollider?
- Which plugins: IEM, SPARTA, ATK, Blue Ripple, etc.?
- How is it decoded in the end?

The question of order is not only technical but also aesthetic: first-order Ambisonics (FOA) has a softer, more diffuse spatiality. Higher orders (HOA3, HOA7) allow sharper localisation and more precise movements – but only if the loudspeaker system can reproduce them. An 8-channel ring does not decode HOA7 better than FOA; the limiting factor is always the physical system.

Important: always test the complete signal flow – not only the decoder, not only the encoder, but everything together:

`Source → encoder → B-format bus → FX / rotation → decoder → output`

A common problem is that encoder and decoder expect different channel counts or normalisations. This leads to silent output or wrongly localised sources – and is hard to diagnose under time pressure.

---

## 3. Work in scenes, not just tracks

Thinking in tracks – track A is sound X, track B is sound Y – is familiar from stereo production but often not enough for Ambisonics. Because space is dynamic, an Ambisonics composition needs a temporal dramaturgy of space itself: what happens spatially in minute 1, in minute 3, at the climax?

For Ambisonics it helps to plan musical situations:

- **Scene 1:** static sound architecture – the space introduces itself
- **Scene 2:** individual movements – first directed energy
- **Scene 3:** rotation of the whole space – the sound field itself moves
- **Scene 4:** condensation / proximity – spatial density rises, distances shrink
- **Scene 5:** dissolution / distance – sources move outwards or upwards

This is not a binding scheme but an example of how spatial movement works as dramaturgy. You can also reverse scenes, interleave them or play them simultaneously. What matters is that spatial changes do not happen by chance but are compositionally justified – just as a crescendo does not start by chance.

This prevents the most common aesthetic problem when first using Ambisonics: simply letting "sounds travel in circles" because it is technically possible. Circling movements without a function quickly become monotonous – space becomes a trick, not an argument.

---

## 4. Compose movements sparingly

Movement is the strongest means of expression in Ambisonics – and therefore the most dangerous when overused. The ear is conditioned to movement; it draws attention. When many sources move at the same time, they compete for this attention – and none wins. The result is not intensity but disorientation.

Better:

- few, clear movements – the ear can follow them
- slow movements are often more effective than fast ones – they visibly cross the space
- motivate movements rhythmically or formally – movement as a structural event, not as decoration
- set static anchors – at least one resting source gives the space stability
- use height only deliberately – vertical movements are unfamiliar and have a strong effect, but quickly lose it when overused

A slow, single source moving from front to back in 30 seconds can be dramatic – if the rest of the sound field stays calm. The same movement is lost when five other sources are moving at the same time.

Space is like dynamics: if everything is constantly at maximum spatiality, you no longer hear the difference. The strength of Ambisonics lies in contrast – between movement and stillness, between near and far, between point and surface.

---

## 5. Monitoring in several modes

An Ambisonics composition that has only been checked binaurally on headphones is not finished. Binaural and loudspeakers sound fundamentally different – not because one is wrong, but because they physically do different things. Headphones simulate localisation via HRTF filters; loudspeakers create a physical sound field in the room. Three aspects in particular regularly differ:

- **Depth staging:** binaural often exaggerates near and far; on loudspeakers distances often seem flatter.
- **Height information:** elevation is strongly HRTF-dependent and individual in binaural; on loudspeakers with a real height layer it can be physically experienced.
- **Movement precision:** fast, precise movements sound sharper in binaural; on arrays they sometimes get lost in the room.

Test your composition at least in:

- binaural on headphones – for quick checks, detail work, remote work
- stereo downmix – important for translatability and possible streaming use
- a real loudspeaker decoder, if possible – for the actual spatial experience
- low and high volume – localisation and sense of space change with level

Anyone who cannot listen regularly on a real array should at least take the stereo downmix seriously. A composition that collapses sonically in the downmix has a structural problem.

---

## 6. A technical checklist for the rehearsal

Technical preparation for an Ambisonics performance differs from a normal stereo performance above all in one respect: there are more places where something can go wrong, and the errors are harder to diagnose. A wrongly routed interface, a wrong decoder matrix or a forgotten plugin version can make the space simply sound "flat" – and you will not find the cause in the ten minutes before the concert.

Bring or prepare:

- project file with cleanly named tracks
- export as B-format, if necessary
- stereo backup
- binaural backup render
- list of plugin versions
- interface routing (documented, not just in your head)
- loudspeaker mapping (which channel → which loudspeaker)
- test signal per channel (e.g. short pink noise or sine tone)
- short demo scene for setting up – a 30-second excerpt that shows all spatial dimensions
- emergency plan in case only stereo is possible

For performances: better a robust system than a maximally complex one that becomes fragile under stress. Two hours of soundcheck with a stable system achieve more than four hours of troubleshooting with an optimised but unstable one.

---

## 7. Performance strategy

Live control over an Ambisonics space means: choosing from a potentially very large parameter space exactly what makes musical sense – and fixing or automating everything else.

Decide beforehand what is controlled live:

- position of individual sources
- rotation of the entire sound field
- distance / spread
- reverb / diffusion
- decoder switching
- scene changes
- density / mutes / sends

The most important decision is what is *not* controlled live. Too many open parameters lead to uncertainty – you reach too much, correct too much, and the performance loses clarity.

Good macro controls solve this problem: one fader for "proximity" simultaneously controls the distance of all sources, room portions and perhaps spread. One fader for "rotation" turns the entire sound field. This allows expressive control with few gestures – much as a conductor does not instruct every finger individually but communicates a lot with a few movements.

If possible, performance control should be anchored in rehearsals, not just planned conceptually. Spatial transitions that seem sensible on paper sometimes feel too fast, too slow or too vague under stage conditions.

---

## 8. Musical preparation

Ambisonics as an instrument – that also means: practising. Not practising the technical system, but the musical decisions that are made in space.

Practise specifically:

- spatial transitions – how does the space change from scene to scene?
- start and end states of each scene – where does the space begin, where does it land?
- critical movements – the moments that carry a lot musically
- moments with a lot of energy – how does the system behave under load?
- quiet or fragile passages – often the most difficult, because every error is audible
- recovery if a cue is missed – what is the fastest way back into the flow?

A simple performance score helps enormously: not the full composition score but an action list – time, scene, action, risk, backup. It must be readable at a glance during the performance.

This sounds like over-planning but is the opposite: whoever knows and has prepared the critical moments can act more freely in the concert – because they know where the safety nets are.

---

## In short

Prepare on three levels:

1. **Compositional:** what does space mean musically in this piece – as structure, as drama, as perspective?
2. **Technical:** is the Ambisonics signal flow stable, documented and tested several times?
3. **Performative:** which spatial decisions do you control live, and with which gestures?

The strongest approach is usually: few clear spatial ideas, technically cleanly implemented, deployed with dramaturgical awareness. Space itself is not the goal – what it makes possible musically is.
