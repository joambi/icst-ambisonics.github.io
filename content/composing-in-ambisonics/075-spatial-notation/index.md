---
title: Spatial Notation and the Spatial Score
description: How do you write down spatial sound? An overview of notation
  approaches, from graphic sound-time diagrams to a practical spatial score in
  the ICST/REAPER context.
date: 2026-01-01T00:00:00
weight: 77
draft: false
translationKey: composing-spatial-notation
---

Traditional notation operates on two axes: time (horizontal) and pitch (vertical). Space appears, if at all, as a marginal note — "ff from the wings", "distant orchestra", "left sideband" — rather than as a structurally anchored dimension. For Ambisonics compositions, in which azimuth, elevation, distance, movement, and diffusion can be parameters of equal standing, this gap is substantial.

The question of the spatial score is therefore not only practical and archival. It is also conceptual: in what format can spatial form be made visible at all — for yourself, for other studios, for later reconstruction, and for performance practice?

## Existing Approaches

There is no universal notation system for spatial sound. In practice, several formats have emerged, each with different strengths and weaknesses depending on context.

### Graphic Score

The graphic score of the New Music tradition — Feldman, Cardew, Haubenstock-Ramati — makes form and energy visible without fixing pitch. For spatial sound, this approach can be extended: sound objects appear on a time axis, their spatial position encoded as geometric location within the image. Many electroacoustic composers — among them Denis Smalley, Hildegard Westerkamp, Barry Truax — use such graphic representations in analyses and commentary.

**Strength:** Expressive, communicative, readable as an overview.  
**Weakness:** Rarely precise enough for technical reconstruction.

### Top-View Diagram (Radar Plan)

Most widespread in spatial audio practice is the **top-view diagram**: a circular disc in which azimuth positions are entered as angles and distance as radial offset. This format also appears in the ICST MultiEncoder as the interactive radar GUI.

It suits static snapshots well — positions at a given moment or within a phase — as well as trajectories drawn as arrows or curves.

**Strength:** Intuitive, directly linked to the ICST workflow, well suited for horizontal movement patterns.  
**Weakness:** Elevation and temporal development are difficult to represent.

### Parameter Timeline

The format closest to DAW work is the **parameter timeline**: a time axis on which spatial parameters such as azimuth, elevation, distance, and spread are shown as overlapping curves. This corresponds essentially to a readable export version of REAPER automation lanes.

**Strength:** Precise, directly reconstructable, complete temporal coverage.  
**Weakness:** Difficult to read intuitively; communicates spatial gestures poorly as an overall picture.

### Equirectangular Projection

For fully three-dimensional trajectories, the **equirectangular projection** offers the most complete representation: a rectangular map in which azimuth is plotted horizontally and elevation vertically. Trajectories appear as curves across this surface. The format is known from 360° video and VR notation, and underlies some research standards such as SpatDIF (Spatial Sound Description Interchange Format).

**Strength:** Complete 3D representation; well suited for pieces with a strong vertical dimension.  
**Weakness:** Less intuitively readable; distortion at the poles.

### SSMN — Spatialization Symbolic Music Notation

**SSMN** is a taxonomy and notation system developed at the [ICST (ZHdK)](https://blog.zhdk.ch/ssmn/) in collaboration with the HEM Geneva and EPFL, funded by the Swiss National Science Foundation. The project created a symbolic library integrated into a custom MuseScore editor: once a symbol is placed in the score, an inspector window displays user-defined parameters (start/end points, radius, direction, acceleration, azimuth/elevation/distance), and instant audio rendering provides feedback within a surround system.

The value of SSMN lies less in proposing one universal score format than in separating *what kind of spatial event is taking place* from *how it is graphically represented*. In other words, SSMN helps distinguish the **taxonomy** of spatial phenomena from the **notation** used to communicate them. See the [ICMC 2014 paper (PDF)](https://blog.zhdk.ch/ssmn/files/2014/10/Spatialization-Symbolic-Music-Notation-at-ICST.pdf) for the full taxonomy and implementation.

For Ambisonics work, this is especially helpful because many spatial decisions combine several layers at once: position, movement type, diffusion, distance behaviour, and relations between multiple sources. SSMN is therefore relevant as a **conceptual reference** even if one ultimately documents the piece in REAPER screenshots, radar plans, or prose.

In practice, the ICST workflow can benefit from this distinction:

- **SSMN Taxonomy** helps name the spatial event: static placement, trajectory, divergence, convergence, diffusion, layer change, field transformation.
- **SSMN Notation** raises the question of how this event should best be communicated: as a radar snapshot, an automation curve, a graphic score, an equirectangular map, or a verbal instruction.

### Locus Notation

A lighter-weight alternative for live and mixed-media contexts is **Locus**, developed by Luís Zanforlin. Rather than a dedicated editor, Locus uses a downloadable font with 26 glyphs that can be embedded in any standard notation software. The symbols encode horizontal direction (8 positions × 3 distance levels) and elevation (8 vertical levels), making spatial positions readable inline with conventional notation. The font is mapped to keyboard shortcuts: `w/a/s/d` for close positions, numpad for median distance. See [makuxr.com/blog/locus-spatial-music-notation](https://www.makuxr.com/blog/locus-spatial-music-notation) for the full symbol set and font download.

**Strength:** No special software; integrates into Sibelius, Finale, Dorico, or MuseScore.
**Weakness:** 3D resolution is coarse (45° horizontal, 5 elevation levels); not designed for precise Ambisonics trajectories.

## The Ambisonics Spatial Score in Practice

For the ICST context, a **pragmatic hybrid** is recommended: not a single universal notation format, but a documentation package that assembles different perspectives on the spatial structure.

A minimal spatial score document contains:

**1. Technical parameters**  
Order and format convention (e.g. 3rd order, ACN/SN3D), decoder configuration used, plugins and version numbers, primary target system.

**2. Schematic source overview**  
List of tracks or sources with their compositional function (main voice, supporting layer, spatial field element), typical spatial zone, and movement character.

**3. Radar plan for structurally important moments**  
Top-view diagrams as snapshots for key moments: opening, climax, resolution. Trajectories drawn as arrows or curves.

**4. Automation screenshot**  
Export or screenshot of REAPER automation lanes for the essential spatial parameters (azimuth, elevation, distance, spread). This is technically precise and directly linkable to the session.

**5. Verbal description of the spatial dramaturgy**  
A short text noting where the nodes of spatial change lie, which gestures are structurally constitutive, and where precision is essential — as opposed to areas where flexibility is permitted.

## Space-Time Axes as a Compositional Planning Tool

The spatial score is useful not only for documenting completed pieces. It can also be used as a **compositional planning tool** — before the session is set up.

A rough space-time axis records which spatial zones are active or dominant at which points in time: front/back, high/low, near/far, diffuse/focused. This approach is similar to sketching a timbral dramaturgy or a harmonic arc: you describe not every sound in detail, but the spatial form trajectory of the piece.

| Time | Front | Back | Above | Distance | Diffusion |
|------|-------|------|-------|----------|-----------|
| 0:00–1:00 | main source | empty | empty | near | low |
| 1:00–2:30 | main source | resonance layer | — | middle | increasing |
| 2:30–3:30 | — | — | envelopment | far | high |
| 3:30–4:00 | return | — | — | near | low |

Even in this rough form, a table like this immediately shows whether the piece is spatially varied — or whether all energy remains in a single zone. Gaps in the table become compositional questions: what happens at the back while the main voice runs at the front? Is that a deliberate decision?

## Notation as a Communication Task

Beyond your own work, the question arises of what information other studios, performers, or performance situations need in order to realise the piece. In this sense, the spatial score is a **communication task**.

For performance contexts, the following are especially relevant:

- loudspeaker plan and decoder configuration
- HOA order and format convention
- critical dependencies on particular spatial zones — especially vertical movements that are lost without overhead loudspeakers
- monitoring requirements and flexibility margin (what can the piece absorb, what cannot?)

A simple notation document covering these points substantially increases the chance that a piece will function not only in its production context but also in unfamiliar performance environments.

## Compositional Consequence

The spatial score is not bureaucratic overhead. It is a direct response to a fundamental property of spatial composition: **spatial decisions are difficult to communicate through sound alone.** A chord can be named; a spatial gesture — the coordinated movement of three sources across a spherical region over fifteen seconds — can barely be described completely without a diagram or automation screenshot.

Creating a spatial score requires formalising your own spatial composition: what is constitutive, what is flexible, what is situation-dependent. This act of formalisation sharpens the compositional eye — just as writing out a harmonic analysis can change one's understanding of a passage.

In the ICST studio, the spatial score is therefore part of the standard repertoire of compositional documentation — not as an obligation, but as a thinking tool. The [10 Questions](/composing-in-ambisonics/04-10-questions/) provide a practical entry point: Question 10 (work identity and documentation) translates directly into the documentation layers described here.

## Further Reading

- [SSMN Project — blog.zhdk.ch/ssmn](https://blog.zhdk.ch/ssmn/) — project blog with taxonomy overview, MuseScore implementation, and audio examples
- [Spatialization Symbolic Music Notation at ICST (PDF)](https://blog.zhdk.ch/ssmn/files/2014/10/Spatialization-Symbolic-Music-Notation-at-ICST.pdf) — Ellberger, Toro Pérez et al., ICMC 2014
- [Taxonomy and Notation of Spatialization (PDF)](http://tenor2016.tenor-conference.org/papers/29_Ellberger_tenor2016.pdf) — Ellberger & Toro Pérez, TENOR 2016
- [Space Notation in Electroacoustic Music (PDF)](https://hal.science/hal-01971595/document) — Bertrand Merlier, overview of historical and contemporary notation approaches
- [Locus Spatial Music Notation](https://www.makuxr.com/blog/locus-spatial-music-notation) — font-based notation for standard score software
- [The Composition and Performance of Spatial Music (PDF)](http://www.endabates.net/Enda%20Bates%20-%20The%20Composition%20and%20Performance%20of%20Spatial%20Music.pdf) — Enda Bates, comprehensive monograph including notation practice
