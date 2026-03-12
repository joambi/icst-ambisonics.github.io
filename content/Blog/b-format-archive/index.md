---
title: "ICST B-Format Archive"
description: "Reference B-Format audio files in ambiX (ACN/SN3D) for testing Ambisonics decoders, renderers, and signal chains."
date: 2026-01-01T00:00:00
draft: false
tags:
  - b-format
  - test-files
  - ambisonics
---

A curated collection of Ambisonics B-Format reference files for testing decoders, binaural renderers, and spatial audio pipelines. All files use the **ambiX** convention: ACN channel ordering, SN3D normalisation.

---

## Audio Files

{{< bformat_archive_table >}}

---

## Format Reference

All files in this archive follow the **ambiX** standard:

- **Channel ordering:** ACN (Ambisonic Channel Number) — channels sorted by degree and order index
- **Normalisation:** SN3D (Schmidt Semi-Normalisation)
- **Encoding:** B-Format, not speaker-decoded audio

To use these files: import into REAPER, set the track to the correct channel count, and route through an ICST AmbiDecoder configured for the matching order. See the [Step-by-Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/) for a walkthrough.


