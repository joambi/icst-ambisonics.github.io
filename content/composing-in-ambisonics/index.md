---
title: "Composing in Ambisonics"
description: "Spatial thinking for composers — how to work with movement, depth, and immersion as compositional parameters in REAPER and beyond."
date: 2026-01-01T00:00:00
draft: false
---

Ambisonics gives composers access to a three-dimensional sound field as primary compositional material — not as an effect added after the fact, but as a structural dimension on the same level as pitch, rhythm, and timbre. Movement, depth, envelopment, elevation, point-source vs. diffuse: all of these can be composed, scored, and rendered with the ICST toolset.

This section collects frameworks and references for thinking and working spatially as a composer — from analytical listening to studio practice.

---

## Chapter 1 — Listening Analytically

Before composing spatial trajectories, it helps to hear them clearly in other people's work. This chapter introduces a practical listening framework used in the ICST [ascolta](/blog/ascolta/) sessions: Smalley's three spatial categories, five analytical questions, and three exercises for active spatial listening.

→ [Ascolta Listening Guide — Analytical Spatial Listening](/blog/ascolta-listening-guide/)

---

## Chapter 2 — 10 Questions When Composing in 3D Space with Ambisonics

### 1. Ontology of the Piece — What Is There?

**Key question:** What kind of "world" does the piece construct in space?

Sub-questions: Am I working with recognisable places/scenes (city, landscape, interior) or with abstract spatial formations? Are there identifiable "agents" (sound objects) and "environments" (fields, textures)?

Decision options:
- realistic / ecological
- abstracted from real spaces
- purely abstract / "imaginary space"
- focus on individual objects
- focus on textures/fields

---

### 2. Role of Space — Space vs. Spectrum/Time

**Key question:** What primarily carries the form — spatial gestures or spectral‑temporal development?

Sub-questions: Could the piece still work in stereo, or would the form collapse? Are there sections defined almost entirely through spatial change (space‑form)?

Decision options:
- form primarily spectral/temporal, space secondary
- form equally space + spectrum/time
- form primarily spatial (spatial architecture, sounds fill it)
- mark per section: "S > Sp/T", "S = Sp/T" or "S < Sp/T"

---

### 3. Spatial Layers

**Key question:** How many distinguishable spatial layers are there?

Sub-questions: Which zones matter (front, back, above, below, near, far)? Is there a constant "backdrop" against which foreground gestures play out?

Decision options:
- foreground objects (clearly localisable)
- midfield texture
- background ambience / far field
- overhead layer / "ceiling"
- floor / below ear level

For each layer, briefly note: sound type, density, typical movements.

---

### 4. Object Count and Density

**Key question:** How full is the space at any given moment?

Sub-questions: How many active objects can be consciously tracked simultaneously? Are there deliberate density tipping points (gesture → texture, clarity → cloud)?

Decision options:
- max. number of "trackable" objects: ___
- typical density per section (e.g. 1–3 / 4–8 / >8 objects)
- mark moments where you intentionally move into "excess" or "emptiness"

---

### 5. Trajectories and Gesture Types

**Key question:** What kinds of movement appear?

Sub-questions: Do I use geometric movements (circles, rings, spirals) or gestural ones (approach, flight, circling)? Are there "signature gestures" that recur?

Decision options:
- circle / orbital movement
- line / travel in one direction
- vertical movement (bottom–top / top–bottom)
- explosion / implosion
- swarm / flock (many similar trajectories)

For each gesture, briefly note its purpose (e.g. "opens new section", "climax marker").

---

### 6. Localisation vs. Diffuseness

**Key question:** When should sounds be pinpoint, when spread?

Sub-questions: Are there dramaturgically important moments of maximum sharpness or maximum envelopment? Do I use focus/defocus transitions deliberately as a formal element?

Decision options — scale 1–5 per section:
- 1 = very diffuse / cloud
- 3 = mixed
- 5 = very precise localisation

Mark moments: focus gesture (diffuse → point source) / defocus gesture (point source → diffuse).

---

### 7. Target Listening Scenario

**Key question:** For which real playback setting am I composing?

Sub-questions: Which loudspeaker configuration do I have in mind (dome, 5.1/7.1, headphones)? Must the piece work across multiple formats?

Decision options — primary target:
- 3D dome / specific array
- multichannel (5.1 / 7.1 / 22.2)
- binaural (headphones)

Secondary: stereo compatibility important / unimportant. Note constraints per target (e.g. "overhead structures attenuated binaurally").

→ *Listen:* [#13 Listening Twice — stereo vs. immersive](/blog/ascolta/13-ascolta/) · [#14 5.1 surround vs. Ambisonics UHJ](/blog/ascolta/14-ascolta/) · [#15 UHJ recordings from the 1970s](/blog/ascolta/15-ascolta/)

---

### 8. Audience and Listening Experience

**Key question:** How spatially "trained" is the assumed audience?

Sub-questions: Is the piece more likely performed at festivals with experienced audiences or in general audience contexts? Must contrasts be clear and legible, or may they remain subtle?

Decision options:
- spatially experienced audience
- mixed
- limited experience

Consequence: strong, clear spatial contrasts / fine, microscopic differences / combination (e.g. clear macro arc + subtle details).

→ *Listen:* [All ASCOLTA sessions](/blog/ascolta/) — a range of audiences from specialists to first-time listeners

---

### 9. Real-Space Reference and Archetypes

**Key question:** How do I relate to real spaces / spatial metaphors?

Sub-questions: Do I use familiar archetypes (tunnel, plaza, interior, exterior, height, abyss)? Do I want to reproduce real spaces, defamiliarise them, or construct something physically impossible?

Decision options:
- mimesis (reproduction of real spaces)
- defamiliarisation / exaggeration
- "impossible" spaces

List the archetypes used and their musical function (e.g. "tunnel = transition", "plaza = culmination point").

→ *Listen:* [#10 Natasha Barrett — spatial argument about containment and release](/blog/ascolta/10-ascolta/)

---

### 10. Work Identity and Documentation

**Key question:** What actually constitutes the "work" — and how do I document it?

Sub-questions: Is the HOA master file the actual core of the work, or a specific decoder configuration? Does it need a score, patch, text instructions, layout plans to remain reconstructible?

Decision options — reference:
- HOA master (e.g. 7th order)
- specific loudspeaker version (e.g. 24.1 layout X)
- binaural release

Documentation:
- loudspeaker plan(s)
- written description of spatial form(s)
- screenshots/exports of trajectories / automation
- custom "spatial score" (diagrams/timeline)

---

## Chapter 3 — Spatial Counterpoint in Ambisonics

### 1. Introduction: From Stereo to Ambisonics

- Problem: limited spatial differentiation in stereo/5.1 and its consequences for polyphony.
- Ambisonics as a "space-agnostic" format that conceives voices as sound fields (B‑format/HOA).
- Goal: Spatial Counterpoint as the organisation of multiple Ambisonics voices in spherical space.

### 2. Ambisonics Fundamentals for Spatial Counterpoint

- Brief overview: order, spherical harmonics, decoding, sweet-spot problem.
- Ambisonics "voice": source, stream, or field (e.g. dedicated HOA buses, object groups).
- Differences from loudspeaker layouts (e.g. Brant-style): flexibility vs. absent visual anchoring.

### 3. Perception in the Ambisonics Listening Space

- Localisation, precision, and front-bias in a typical Ambisonics setup.
- Influence of order, loudspeaker density, and room acoustics on the audibility of spatial polyphony.
- Binaural headphone vs. loudspeaker Ambisonics: differences for spatial counterpoint.

### 4. Models of Spatial Polyphony in Ambisonics

- Trajectory voices: individual sources/objects as moving voices in the Ambisonics field.
- Layer voices: different HOA buses or zones (e.g. near-field/far-field, above/below).
- Field voices: diffuse vs. directed fields, clusters/clouds, noise layers as polyphonic units.

### 5. Historical and Current Ambisonics Practice

- Early multichannel/spatial music as precursors, transition to HOA practice.
- Examples: studio productions and concert settings using Ambisonics for polyphonic spatial design.
- Role of Ambisonics institutes/studios in developing spatial counterpoint models.

### 6. Parameters of Spatial Counterpoint in the Ambisonics Context

- Spherical parameters: azimuth, elevation, distance (synthetic), spread, order.
- Coupling with spectrum, dynamics, and density in Ambisonics buses.
- Technical parameters: order limitation, energy vs. velocity decoding, subwoofer management.

### 7. Types of Spatial Counterpoint Formation in Ambisonics

- Canon in spherical space: temporal and spatial displacement of motifs (e.g. rotating around the listening position).
- Layer counterpoint: different orders/buses (e.g. N=1 vs. N=3) or differing diffuseness as contrapuntal strata.
- "False HOA polyphony": apparent polyphony through rapid movement or dynamic order/diffuseness of a single source.

### 8. Notation and Representation for Ambisonics Composition

- Spherical notation forms (polar-coordinate diagrams, 2D projections, layer graphics).
- Software-based score: DAW automation, Ambisonics panner curves, OSC scenarios as structural notation.
- Analysis diagrams: snapshots of energy density on the sphere, time–space sketches.

### 9. Compositional Strategies and Guidelines in Ambisonics

- Heuristics for HOA polyphony: maximum voice count, minimum angular and temporal distances, order per voice.
- Handling masking: spectral and spatial separation of voices, use of height and diffuseness as voice parameters.
- Practical don'ts: overfull N=3 fields, unmotivated rotations that destroy polyphonic clarity.

### 10. Analysis Examples of Ambisonics Works

- Selection of 2–3 HOA works (or own pieces) as case studies.
- Mapping specific passages to the models in section 4 and the types in section 7.
- Discussion: which constellations work in the Ambisonics listening space, which break down?

### 11. Outlook: Spatial Counterpoint in Ambisonics Ecosystems

- Integration into Ambisonics pedagogy: from B‑format basics to complex spatial counterpoint exercises.
- Transferability to Atmos, WFS, XR (Ambisonics as compositional "neutral layer").
- Perspectives: tools for automated analysis of spatial counterpoint in Ambisonics productions.

---

## Chapter 4 — Spatial Parameters as Compositional Material

*Coming soon.* How to work with azimuth, elevation, distance, and diffusion as scoreable parameters — notation approaches, REAPER automation, and OSC control from live performance setups.

---

## Chapter 5 — Studio Practice at the ICST

*Coming soon.* Compositional workflows developed from residencies at the ICST Kompositionsstudio — session templates, B-Format archiving, and multi-format delivery (speaker, binaural, UHJ).

---

## References

### Books

- [Ambisonics: A Practical 3D Audio Theory — Zotter & Frank (2019, Open Access)](https://link.springer.com/book/10.1007/978-3-030-17207-7)
- [Parametric Time-Frequency Domain Spatial Audio — Pulkki, Delikaris-Manias & Politis (2017)](https://doi.org/10.1002/9781119252634)
- [Immersive Sound: The Art and Science of Binaural and Multi-Channel Audio — Rumsey (2012)](https://www.routledge.com/Immersive-Sound-The-Art-and-Science-of-Binaural-and-Multi-Channel-Audio/Rumsey/p/book/9780240815091)
- [Kompositionen für hörbaren Raum / Compositions for Audible Space — transcript Verlag](https://www.transcript-verlag.de/978-3-8376-3076-3/kompositionen-fuer-hoerbaren-raum/compositions-for-audible-space/)

### Key Papers

- [Periphony: With-Height Sound Reproduction — Gerzon (JAES, 1973)](https://ringbuffer.org/papers/gerzon1973periphony.html)
- [Sector-Based Parametric Sound Field Reproduction in the Spherical Harmonic Domain — Politis, Vilkamo & Pulkki (2015)](https://doi.org/10.1109/JSTSP.2015.2415762)
- [Introduction to Ambisonics (ResearchGate)](https://www.researchgate.net/publication/280010078_Introduction_to_Ambisonics)
- [Producing 3D Audio in Ambisonics (ResearchGate)](https://www.researchgate.net/publication/281559396_Producing_3D_Audio_in_Ambisonics)
- [ambiX — A Suggested Ambisonics Format (IEM, 2011)](https://ambisonics.iem.at/proceedings-of-the-ambisonics-symposium-2011/ambix-a-suggested-ambisonics-format)
- [Spectromorphology: explaining sound-shapes — Smalley (Organised Sound, 1997)](https://www.cambridge.org/core/journals/organised-sound/article/abs/spectromorphology-explaining-soundshapes/A18EBE591592836FC22C20FB327D3232)
- [Space-form and the acousmatic image — Smalley (Organised Sound, 2007)](https://www.cambridge.org/core/journals/organised-sound/article/abs/spaceform-and-the-acousmatic-image/8B80E6A25A065A3D37DA7F9568A23432) · [PDF](/downloads/papers/DENIS%20SMALLEY%20Space%20form%20and%20the%20acousmatic%20image.pdf)
- [From Sound-Shapes to Space-Form — Smalley (PDF)](/downloads/papers/SMALLEYFromSoundShapestoSpaceForm.pdf)
- [Spatial music composition — Barrett (Oxford Handbook of Computer Music, 2019)](https://global.oup.com/academic/product/the-oxford-handbook-of-computer-music-9780199792030)
- [Barrett — EMS 2010 (PDF)](/downloads/papers/EMS_Barrett2010.pdf)
- [Perceptual evaluation of high-order ambisonics reproduction — Gaveau, Parizet & Koehl (Acta Acustica, 2022)](https://acta-acustica.edpsciences.org/)
- [Organised Sound — Spatial Music thematic issue (Cambridge University Press, 2025)](https://www.cambridge.org/core/journals/organised-sound/announcements/call-for-papers/call-perspectives-and-trajectories-in-spatial-music-and-sonic-art)

### Michael Gerzon

- [Gerzon Archive](https://audiosignal.co.uk/Gerzon%20archive.html)
- [The Michael Gerzon Story — Into The Soundfield](https://intothesoundfield.music.ox.ac.uk/michael-gerzon-story)
- Video: ['Into The Soundfield' — Michael Gerzon & Ambisonics at Oxford (2018)](https://www.youtube.com/watch?v=X23hZNoSkUs)

### Video

- [Denis Smalley — Spatiality in acousmatic music (CIRMMT)](https://www.youtube.com/watch?v=_G68Q4gkOMc)

---

## Related resources

- [Ambisonics 101](/ambisonics-101/) — signal flow, HOA orders, B-Format basics
- [ascolta — all listening sessions](/blog/ascolta/) — works from ICST residencies and international repertoire
- [ICST B-Format Archive](/blog/b-format-archive/) — encoded works for reference listening
- [Residencies](/residenzen/) — documentation from composers working in the ICST studio
