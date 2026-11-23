---
title: What's New
description: "New in the ICST Ambisonics tools: REAPER bundle 1.1.3, Motion Map GUI 2.4.5, Animator Choreographer 0.1.0 and the plugin release 4.0."
date: 2026-11-14T08:00:00
weight: 15
docs_nav_group: "Getting started"
---

## ICST Ambisonics Plugins Release 4.0

Version 4.0.0 is out (released 9 November 2026). It is a major step forward for composing in Ambisonics with source groups: create choreographies directly in the REAPER timeline and save them as XML scores, so you can reuse and reshape them in other projects. The ICST Group Animator is a work in progress and will continue to grow.

In the ICST AmbiEncoder_64 plugin the Blauert filters have been optimised, and for a spherical presentation without a frontal orientation, the Z axis alone can be selected.

[Download: GitHub Release 4.0.0](https://github.com/schweizerweb/icst-ambisonics-plugins/releases/tag/4.0.0) · [Documentation: ICST Animator](/icst-ambisonics-plugins/11_animator/)

---

## November 2026: REAPER bundle, Motion Map 2.4.5, Animator Choreographer

New tools and documentation for composing with the ICST Ambisonics plugins in REAPER. All three are evaluation betas.

## ICST Ambi REAPER Bundle 1.1.3

A portable REAPER folder that is already set up for the ICST plugins: one click on the toolbar creates Ambisonics tracks (orders 1 to 7), routes them, moves sources and decodes. macOS is complete, Windows is beta and untested; the files are not signed.

[Release 1.1.3 on GitHub](https://github.com/joambi/ICST_Ambi_Reaper/releases/tag/v1.1.3) · [ICST Ambi REAPER Bundle](/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/)

## Motion Map GUI 2.4.5

Position and animate up to 64 sources and write the movement as REAPER automation. New since 2.2:
- **Figure Editor** (2.3): reshape each motion figure, per source or for all sources that use it.
- **Tempo sync** (2.4): the cycle runs in beats and can lock to the bar lines.
- **Quantize** (2.4.3): turn any figure into stepped motion in time and space.
- **Preview transport with Sync** (2.4.4, 2.4.5): the preview follows REAPER play and stop, and Play/Stop in the GUI start and stop the REAPER transport.
- **Latch** (2.4.5): written tracks are always set to Latch.

[Motion Mapping](/icst-ambisonics-plugins/15_icst_ambi_motion_map/) (with a screen recording)

## Animator Choreographer 0.1.0

A desktop app that plans how groups of sources move through space and exports the scene XML for the ICST Animator, with REAPER regions as sections. Available for macOS, Windows and Linux; not code-signed yet.

[Releases on GitHub](https://github.com/joambi/animator-choreographer/releases) · [Animator Choreographer](/icst-ambisonics-plugins/20_animator_choreographer/)

