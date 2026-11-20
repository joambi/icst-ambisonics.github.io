---
title: "Composing in Ambisonics: Space, Movement and Performance"
description: "Not just 'more space': Ambisonics as a compositional system with perspective, movement, density and translation to different playback situations."
date: 2026-05-11T00:00:00+02:00
year: 2026
month: 2026-05
tags: ["composition", "performance", "workflow", "ambisonics", "space", "live"]
difficulty: "intermediate"
post_kind: "background"
---

The best way to prepare for Ambisonics is to treat it like an instrument of its own: not just "more space", but a compositional system with perspective, movement, density and translation to different playback situations.

This means: space is not an effect that you lay over a finished composition at the end. It is a parameter that has to be thought of from the start – just like timbre, dynamics or form. Anyone who only "applies" Ambisonics in the mix uses the system by half.

---

## 1. Think of space as a score

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Point, surface and audience perspective" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="120" y="24" text-anchor="middle" font-weight="600">Point</text><circle cx="120" cy="125" r="52" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><circle cx="120" cy="125" r="6" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="360" y="24" text-anchor="middle" font-weight="600">Surface / atmosphere</text><circle cx="360" cy="125" r="52" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><circle cx="360" cy="125" r="6" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="600" y="24" text-anchor="middle" font-weight="600">Perspective</text><circle cx="600" cy="125" r="52" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><circle cx="600" cy="125" r="6" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="157" cy="88" r="8" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><line x1="126" y1="119" x2="150" y2="95" stroke="#d9534f" stroke-width="2" opacity="1" marker-end="url(#ar1)"/><circle cx="360" cy="125" r="52" fill="none" stroke="#4a8fe0" stroke-width="14" opacity=".35"/><circle cx="412.0" cy="125.0" r="3" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="396.8" cy="161.8" r="3" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="360.0" cy="177.0" r="3" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="323.2" cy="161.8" r="3" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="308.0" cy="125.0" r="3" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="323.2" cy="88.2" r="3" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="360.0" cy="73.0" r="3" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="396.8" cy="88.2" r="3" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><rect x="560" y="80" width="80" height="12" rx="3" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="600" y="72" text-anchor="middle" font-size="11">scene</text><line x1="600" y1="125" x2="600" y2="98" stroke="#3fa968" stroke-width="1.5" opacity="1" marker-end="url(#ar1)" stroke-dasharray="4 3"/><circle cx="600" cy="125" r="52" fill="none" stroke="#3fa968" stroke-width="1.5" stroke-dasharray="2 3"/><text x="120" y="206" text-anchor="middle">has direction and sharpness</text><text x="360" y="206" text-anchor="middle">envelops, no single direction</text><text x="600" y="206" text-anchor="middle">inside vs. looking at a scene</text><text x="120" y="228" text-anchor="middle" fill="#d9534f" font-size="12">e.g. a high tone</text><text x="360" y="228" text-anchor="middle" fill="#4a8fe0" font-size="12">e.g. diffuse room sound</text><text x="600" y="228" text-anchor="middle" fill="#3fa968" font-size="12">decide this early</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Point, surface, perspective: three questions to answer before any encoder is opened. The dot in the middle is the listener.</figcaption>
</figure>


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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Five scenes with spatial density curve" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="20" y="20" width="126" height="54" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="83" y="41" text-anchor="middle" font-weight="600">Scene 1</text><text x="83" y="60" text-anchor="middle" font-size="11">static</text><rect x="160" y="20" width="126" height="54" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="223" y="41" text-anchor="middle" font-weight="600">Scene 2</text><text x="223" y="60" text-anchor="middle" font-size="11">movements</text><rect x="300" y="20" width="126" height="54" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="363" y="41" text-anchor="middle" font-weight="600">Scene 3</text><text x="363" y="60" text-anchor="middle" font-size="11">rotation</text><rect x="440" y="20" width="126" height="54" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="503" y="41" text-anchor="middle" font-weight="600">Scene 4</text><text x="503" y="60" text-anchor="middle" font-size="11">proximity</text><rect x="580" y="20" width="126" height="54" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="643" y="41" text-anchor="middle" font-weight="600">Scene 5</text><text x="643" y="60" text-anchor="middle" font-size="11">dissolution</text><text x="20" y="100" text-anchor="start" font-size="11">spatial density</text><path d="M83,185.0 L223,162.5 L363,147.5 L503,95.0 L643,125.0" fill="none" stroke="#d9534f" stroke-width="2.5"/><circle cx="83" cy="185.0" r="4" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="223" cy="162.5" r="4" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="363" cy="147.5" r="4" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="503" cy="95.0" r="4" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="643" cy="125.0" r="4" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><line x1="20" y1="225" x2="700" y2="225" stroke="currentColor" stroke-width="1" opacity="0.5"/><text x="700" y="243" text-anchor="end" font-size="11">time →</text><line x1="83" y1="76" x2="83" y2="225" stroke="currentColor" stroke-width="1" opacity="0.3" stroke-dasharray="2 4"/><line x1="223" y1="76" x2="223" y2="225" stroke="currentColor" stroke-width="1" opacity="0.3" stroke-dasharray="2 4"/><line x1="363" y1="76" x2="363" y2="225" stroke="currentColor" stroke-width="1" opacity="0.3" stroke-dasharray="2 4"/><line x1="503" y1="76" x2="503" y2="225" stroke="currentColor" stroke-width="1" opacity="0.3" stroke-dasharray="2 4"/><line x1="643" y1="76" x2="643" y2="225" stroke="currentColor" stroke-width="1" opacity="0.3" stroke-dasharray="2 4"/></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">A possible scene dramaturgy: spatial density rises and falls with intention. The order is an example, not a rule.</figcaption>
</figure>


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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Many moving sources versus few clear movements" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="180" y="24" text-anchor="middle" font-weight="600" fill="#d9534f">Everything moves</text><circle cx="180" cy="125" r="70" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><circle cx="180" cy="125" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="540" y="24" text-anchor="middle" font-weight="600" fill="#3fa968">Few, slow, with anchors</text><circle cx="540" cy="125" r="70" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><circle cx="540" cy="125" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="245.8" cy="148.9" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><line x1="245.8" y1="148.9" x2="237.6" y2="171.5" stroke="#d9534f" stroke-width="2" opacity="1" marker-end="url(#ar3)"/><circle cx="198.1" cy="192.6" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><line x1="198.1" y1="192.6" x2="174.9" y2="198.8" stroke="#d9534f" stroke-width="2" opacity="1" marker-end="url(#ar3)"/><circle cx="126.4" cy="170.0" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><line x1="126.4" y1="170.0" x2="110.9" y2="151.6" stroke="#d9534f" stroke-width="2" opacity="1" marker-end="url(#ar3)"/><circle cx="114.2" cy="101.1" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><line x1="114.2" y1="101.1" x2="122.4" y2="78.5" stroke="#d9534f" stroke-width="2" opacity="1" marker-end="url(#ar3)"/><circle cx="161.9" cy="57.4" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><line x1="161.9" y1="57.4" x2="185.1" y2="51.2" stroke="#d9534f" stroke-width="2" opacity="1" marker-end="url(#ar3)"/><circle cx="225.0" cy="71.4" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><line x1="225.0" y1="71.4" x2="243.4" y2="86.8" stroke="#d9534f" stroke-width="2" opacity="1" marker-end="url(#ar3)"/><circle cx="474.2" cy="101.1" r="6" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="600.6" cy="90.0" r="6" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="593.6231110183285" cy="169.99513267805776" r="6" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><path d="M593.6,170.0 A70,70 0 0 1 495.0,178.6" fill="none" stroke="#3fa968" stroke-width="2.5" marker-end="url(#ar3)"/><text x="180" y="222" text-anchor="middle" font-size="12">no reference – attention scatters</text><text x="540" y="222" text-anchor="middle" font-size="12">one slow movement against calm anchors</text><text x="540" y="240" text-anchor="middle" font-size="11">neutral = static anchor · green = moving source</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Movement is strongest in contrast: a single slow movement against a calm sound field is heard; six simultaneous ones are not.</figcaption>
</figure>


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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Three monitoring modes" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar4" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="20" y="20" width="200" height="200" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="120" y="48" text-anchor="middle" font-weight="600" fill="#4a8fe0">Binaural</text><text x="120" y="80" text-anchor="middle" font-size="12">quick checks</text><text x="120" y="106" text-anchor="middle" font-size="12">detail work</text><text x="120" y="132" text-anchor="middle" font-size="12">exaggerated depth</text><text x="120" y="158" text-anchor="middle" font-size="12">HRTF-dependent height</text><rect x="260" y="20" width="200" height="200" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="360" y="48" text-anchor="middle" font-weight="600" fill="#d9a441">Stereo downmix</text><text x="360" y="80" text-anchor="middle" font-size="12">translatability</text><text x="360" y="106" text-anchor="middle" font-size="12">streaming use</text><text x="360" y="132" text-anchor="middle" font-size="12">collapse = structural</text><text x="360" y="158" text-anchor="middle" font-size="12">problem</text><rect x="500" y="20" width="200" height="200" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="600" y="48" text-anchor="middle" font-weight="600" fill="#3fa968">Loudspeaker decoder</text><text x="600" y="80" text-anchor="middle" font-size="12">real spatial experience</text><text x="600" y="106" text-anchor="middle" font-size="12">physical height</text><text x="600" y="132" text-anchor="middle" font-size="12">check at low and</text><text x="600" y="158" text-anchor="middle" font-size="12">high volume</text><text x="360" y="242" text-anchor="middle" font-size="11">Check all three, at least at two playback levels.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Each monitoring mode answers a different question; none replaces the others.</figcaption>
</figure>


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

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 262" role="img" aria-label="Macro controls steering many parameters" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar5" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="110" y="24" text-anchor="middle" font-weight="600">Macro controls</text><text x="540" y="24" text-anchor="middle" font-weight="600">Controlled parameters</text><text x="20" y="64" text-anchor="start" font-weight="600">Proximity</text><line x1="20" y1="90" x2="200" y2="90" stroke="#4a8fe0" stroke-width="5" opacity="0.4"/><circle cx="146.0" cy="90" r="9" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><text x="20" y="159" text-anchor="start" font-weight="600">Rotation</text><line x1="20" y1="185" x2="200" y2="185" stroke="#d9534f" stroke-width="5" opacity="0.4"/><circle cx="83.0" cy="185" r="9" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><rect x="400" y="50" width="280" height="28" rx="6" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="540" y="69" text-anchor="middle" font-size="12">distance of all sources</text><line x1="206" y1="95" x2="398" y2="64" stroke="#4a8fe0" stroke-width="1.4" opacity="0.8" marker-end="url(#ar5)"/><rect x="400" y="88" width="280" height="28" rx="6" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="540" y="107" text-anchor="middle" font-size="12">reverb share</text><line x1="206" y1="95" x2="398" y2="102" stroke="#4a8fe0" stroke-width="1.4" opacity="0.8" marker-end="url(#ar5)"/><rect x="400" y="126" width="280" height="28" rx="6" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="540" y="145" text-anchor="middle" font-size="12">spread</text><line x1="206" y1="95" x2="398" y2="140" stroke="#4a8fe0" stroke-width="1.4" opacity="0.8" marker-end="url(#ar5)"/><rect x="400" y="164" width="280" height="28" rx="6" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="540" y="183" text-anchor="middle" font-size="12">rotation of the B-format bus</text><line x1="206" y1="185" x2="398" y2="178" stroke="#d9534f" stroke-width="1.4" opacity="0.8" marker-end="url(#ar5)"/><rect x="400" y="202" width="280" height="28" rx="6" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="540" y="221" text-anchor="middle" font-size="12">(optional) decoder rotation</text><line x1="206" y1="185" x2="398" y2="216" stroke="#d9534f" stroke-width="1.4" opacity="0.8" marker-end="url(#ar5)"/><text x="360" y="256" text-anchor="middle" font-size="11">Everything not mapped to a macro is fixed or automated.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Two macro faders can replace dozens of open parameters: fewer decisions on stage, more clarity.</figcaption>
</figure>


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
