---
title: "Spatial Counterpoint"
description: "Spatial voice-leading, case studies, and practical work with ICST and REAPER."
date: 2026-01-01T00:00:00
weight: 50
draft: false
---

Spatial Counterpoint is the attempt to make **extension, position, and movement** compositional parameters on the same level as pitch, time, dynamics, and timbre. Space is not merely a stage or a playback arrangement; it becomes part of form itself.

Two sound objects may be tonally consonant but spatially dissonant. A fifth remains harmonically stable, yet if the sources are too close in space, they may blur into a single perceptual object. Conversely, spatial distance can intensify or release tension.

### Basic Principles

Spatial counterpoint depends on the **independence of voices**. In Ambisonics, this is organised mainly through:

- angular separation
- elevation and vertical layering
- distance coding
- movement speed and direction
- timbral differentiation

### Movement Types

| Type | Description | Spatial Effect |
| --- | --- | --- |
| Contrary motion | Source A moves left, source B right | opening, tension |
| Parallel motion | Both move together | fusion, mass |
| Oblique motion | One moves, one remains | figure/background |
| Convergence | Sources approach each other | sharpening, density |
| Divergence | Sources separate | release, widening |

### ICST / REAPER Workflow

Within an ICST workflow, spatial counterpoint is usually shaped through four parameter groups:

- **position**: azimuth, elevation, distance
- **movement**: trajectory, speed, rotation
- **grouping**: source grouping and relative offsets
- **rendering context**: decoder order, loudspeaker layout, monitoring, routing

<figure class="big">
  <img src="/icst-ambisonics-plugins/06_step_by_step_setup/GP_edit_scaled.png" alt="ICST MultiEncoder radar GUI" loading="lazy" />
  <figcaption><strong>Radar GUI and group logic.</strong> The ICST MultiEncoder makes spatial relations directly visible and editable as compositional parameters.</figcaption>
</figure>

### Case Study 1 — Dialogue Between Two Objects

Imagine two prepared piano sounds in a 24-channel ring. One begins on the left, the other on the right. Their relation is shaped not only by timing and timbre, but by whether the dialogue remains clearly two-voiced or collapses into a shared spatial centre.

<figure class="big">
  <img src="/icst-ambisonics-plugins/06_step_by_step_setup/Distance.gif" alt="Distance automation in ICST workflow" loading="lazy" />
  <figcaption><strong>Distance as dramaturgy.</strong> Distance coding can shape nearness, density, and disappearance in space.</figcaption>
</figure>

### Case Study 2 — Three-Voice Spatial Canon

A second model is a spatial canon: the same material appears multiple times with time offsets, but each voice follows a different trajectory or height layer.

<figure class="big">
  <img src="/icst-ambisonics-plugins/06_step_by_step_setup/MultiEnc_01.gif" alt="MultiEncoder with multiple sources" loading="lazy" />
  <figcaption><strong>Spatial canon in the MultiEncoder.</strong> Multiple sources can be organised as a contrapuntal group and moved together or relatively against each other.</figcaption>
</figure>

### Toolchains and Transferability

These principles can be realised not only with ICST, but also with IEM, SPARTA, and other Ambisonics toolchains. What matters most is clarity about format, routing, and the availability of parameters for position, movement, grouping, and distance.
