---
title: "Ambisonics Studio Practice at ICST"
description: "Workflow perspectives from the ICST Composer Studio."
date: 2026-01-01T00:00:00
weight: 80
draft: false
translationKey: "composing-studio-practice"
---

Once spatial parameters have been defined as compositional categories, the practical question arises of how they are organized in the studio. Composing in Ambisonics does not consist only in selecting individual spatial gestures; it also requires a workflow in which sketching, spatial control, monitoring, archiving, and delivery formats are coordinated with one another. Studio practice at ICST should therefore be understood less as a rigid production scheme than as a workflow-based method for developing spatial composition consistently over longer periods of work.

## From Parameter to Session

The decisive step in the studio is to translate spatial parameters into a sustainable project dramaturgy. A piece is no longer conceived solely as a sequence of sounds, but as a configuration of sources, groups, trajectories, and perspectives. In practice, this means that from the outset it is necessary to decide which role individual tracks will play within the spatial structure: which sources remain stably localized, which form moving lines, and which function as fields, envelopes, or distant horizons.

In the ICST context, work therefore often begins with a relatively clear distinction between functions:

- **source tracks** for individual sound objects or clearly distinguishable voices
- **groups** for related movements or stratifications
- **a shared Ambisonics bus** as the central spatial working field
- **decoder and monitoring tracks** for different listening situations

This separation is not only technical, but compositional. It allows a distinction between micro- and macro-levels: individual sources can be shaped in detail, while larger movement logics or spatial contrasts can be organized at the group or bus level.

## HOA Order as a Compositional Choice

Before a session is set up, one decision shapes everything that follows: **at which HOA order will the work be done?** This choice is not only technical but directly compositional: it determines the spatial resolution with which positions, trajectories, and layering can be realized in the piece.

The HOA order N determines how finely directional information is encoded in the Ambisonics sound field. As the order increases, the precision of localisation improves; at the same time, the channel count grows according to the formula (N+1)² for 3D Ambisonics.

| Order | Channels (3D) | Spatial resolution | Typical application |
| --- | --- | --- | --- |
| 1st order (FOA) | 4 | ~45° | Archive format, legacy, robust compatibility |
| 3rd order | 16 | ~20° | Standard for production and small dome arrays |
| 5th order | 36 | ~12° | Medium to large dome setups (16–30 speakers) |
| 7th order | 64 | ~8° | High-resolution arrays and precise binaural |

**What order means compositionally:** At 1st order, sound objects are spatially "soft" — positions are recognisable, but fine trajectories and close approaches between voices are lost. From 3rd order upwards, movements become clearly legible, sources are separable, and spatial counterpoint voices are distinguishable. For compositional strategies based on precise localisation, voice separation, or close movement relationships, 3rd order is a sensible minimum.

**Binaural:** For binaural output, 3rd to 5th order is generally sufficient. Higher orders slightly improve externalisation, but the larger influence lies in HRTF quality. For pieces intended primarily for binaural listening, working at 3rd order is adequate.

**Speaker arrays:** The optimal order for a given array is roughly guided by the speaker count L: N ≈ √L. An 8-channel ring renders well at 3rd order; a 24-channel dome benefits from 5th order; larger installations with 50+ speakers make use of 7th order.

**ICST recommendation:** In the studio context, **3rd order** is the standard starting point, as it combines compositional precision, manageable channel counts, and compatibility with most performance venues. For productions explicitly designed for large-scale dome setups or maximum binaural quality, increasing to 5th or 7th order is appropriate — but this should be decided consciously and early, since a retrospective increase in order is lossless in principle but affects rendering and file-size planning.

The order choice is therefore an early compositional act: it defines which spatial gestures are achievable in the piece, and simultaneously determines the technical infrastructure of the entire production.

## Session Architecture and Signal Flow

A typical ICST session is designed so that all sonic events are first encoded into a shared B-format. This B-format constitutes the actual compositional space of the project. From there it can be decoded into different monitoring and output paths: for the studio loudspeaker array, for binaural monitoring, or for alternative target systems.

Such a session architecture offers several advantages. First, the spatial organization is gathered at a single central point. Second, the composition itself remains largely independent of a single loudspeaker configuration. Third, different monitoring and export paths can be considered in parallel without requiring the piece to be fundamentally restructured each time.

In practical terms this means:

- **encoder tracks** define source position, movement, size, and grouping
- **the Ambisonics bus** gathers the resulting sound field
- **decoder tracks** translate this field into concrete listening situations
- **additional analysis, recording, or reference tracks** support control and documentation

This separation is especially important in the ICST studio because many works are not intended for only one setup, but must mediate between dome playback, loudspeaker arrays, binaural monitoring, and archival formats. A quick reference for the correct setup is provided in the [HOA Routing Checklist](/icst-ambisonics-plugins/06_step_by_step_setup/).

## B-Format as Working and Archival Format

In studio practice, the B-format has a double function. It is not only the technical intermediate format of production, but also the central **working and archival format**. Whereas decodings may vary according to loudspeaker layout, performance situation, or publication form, the B-format remains the version in which the spatial relations of the piece are fixed most consistently.

For studio work this means that decisions should be tested as early as possible with regard to whether they are coherent in the B-format itself and not only persuasive in one particular decoding. A passage that works convincingly only on one loudspeaker setup, but lacks a clear spatial logic in the Ambisonics master, remains fragile in the long term. The B-format therefore functions as a reference layer against which the transferability of the spatial dramaturgy can be measured.

At the same time, this way of working is also relevant archivally. For later reconstruction, re-decoding, or transfer into other contexts, the B-format master is often the most reliable basis of the work. The ICST B-Format Archive stores Ambisonics productions in **ambiX (ACN/SN3D)** and makes them accessible as a listening repertoire and reference collection. In the ICST context, this means that a production is understood not only as a present studio version, but also as a future object of work and documentation. Further information on archiving can be found in the [B-Format Archive](/blog/b-format-archive/).

## Monitoring as Compositional Control

In Ambisonics, monitoring is not merely a final check, but part of the compositional process itself. Since spatial decisions may become legible in different ways depending on the playback situation, listening must shift between several perspectives: loudspeaker playback, binaural control, and where relevant alternative decoders or simplified setups. These shifts serve not only technical verification, but compositional calibration.

The recurring question in the studio is therefore which aspects of a passage should remain invariant, and which may legitimately change with the setup. Some pieces depend strongly on vertical stratification or diffuse envelopment and gain precision in the loudspeaker array; others benefit from the immediacy and perspectival sharpness of binaural control. In this sense, monitoring means consciously hearing the difference between the idea of the work and its specific playback condition.

In practice, a cyclical procedure is often helpful:

1. sketch a passage in B-format or through the primary decoding
2. check its legibility, focus, and movement logic through binaural monitoring
3. control its stratification, envelopment, and spatial energy on the loudspeaker setup
4. correct problematic passages not only at the decoder stage, but as far as possible within the spatial structure itself

Monitoring thus becomes not a belated error check, but a method for gradually sharpening spatial form.

## Multi-Format Delivery and Versioning

A work produced in the ICST context often does not end in a single final output. Alongside the Ambisonics master, loudspeaker renders, binaural versions, or documentary derivatives may also be required. It follows that versioning and format decisions should be built into the workflow at an early stage.

From a compositional point of view, different delivery versions should not be treated merely as technical derivatives. Each version establishes a specific listening situation and may foreground different parameters of the work. A binaural version may require more precise control of front-back axes and HRTF-relevant spectral features; a loudspeaker version may benefit more strongly from spatial spread and energy distribution. Multi-format delivery therefore does not mean simple export, but the renewed testing of the identity of the work under changed conditions.

It is useful to distinguish at least the following layers:

- **project versions** for ongoing compositional work
- **the B-format master** as the central work and archive version
- **monitoring or performance versions** for specific setups (dome, array, binaural)
- **documentation versions** for transmission, archive, or teaching

This separation prevents later adjustments from feeding back uncontrollably into the actual center of the work.

## Documentation as Part of Composition

The more strongly a work depends on spatial relations, the more important its documentation becomes. In the ICST studio this concerns not only file formats and technical metadata, but also the compositional description of decisive spatial processes. Documentation is therefore not an external administrative step, but part of the stabilization of the work.

It is helpful to record at least the following:

- the order and format convention used, for example ACN/SN3D
- relevant decoder assumptions and monitoring situations
- central trajectories, group formations, or critical spatial zones
- particular dependencies on reverberation, diffusion, or vertical stratification
- screenshots or graphic notes of radar and automation views

This documentation supports not only later reconstruction, but already during the work itself sharpens attention to which spatial decisions are actually constitutive of the piece. The tenth of the [10 Questions](/composing-in-ambisonics/04-10-questions/) takes up this aspect explicitly and offers a practical framework for documentation within the production process.

## Compositional Consequence

Studio practice at ICST therefore does not simply mean operating Ambisonics plugins correctly. Rather, it refers to a way of working in which compositional idea, spatial control, monitoring, archiving, and transferability are thought together. The studio thus becomes the place where spatial form can not only be technically realized, but also methodically tested, stabilized, and refined.

This is precisely where the difference lies between a merely production-oriented and a compositional approach to Ambisonics: the decisive criterion is not any single decoding, but the coherence of spatial relations within the work itself. Studio practice therefore serves not merely the realization of a piece, but its conceptual and perceptual clarification.
