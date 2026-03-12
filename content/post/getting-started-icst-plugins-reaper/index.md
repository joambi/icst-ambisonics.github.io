---
title: Getting Started with ICST Ambisonics Plugins in Reaper
description: "A practical starter guide for composers, students, and technicians to set up ICST Ambisonics Plugins in Reaper and complete a first working session."
date: 2026-03-08T14:10:00+01:00
year: 2026
month: 2026-03
weight: 23
tags: ["tutorial", "reaper", "ambiencoder", "getting-started", "workflow"]
key_points:
  - "Complete a first working spatial audio session in REAPER step by step"
  - "Structured checklist from plugin install to binaural monitoring"
difficulty: "beginner"
---


Level: Beginner | **Audience:** Composer, Student, Studio Assistant.

This page is the compact onboarding version of the full docs workflow:
[Step by Step Setup](/icst-ambisonics-plugins/06_step_by_step_setup/).
Use this guide to get running fast, then use the docs page as technical reference.

## Who this is for
- Composers who want a reliable first Ambisonics session.
- Students who need a clear practical entry point.
- Technicians who need a repeatable setup baseline.

## What you will achieve
By the end, you will have a working Reaper project with source routing, AmbiEncoder control, and a basic monitoring check.

## Prerequisites
- Reaper installed and running.
- ICST Ambisonics Plugins installed.
- Recommended Reaper extensions installed (SWS and ReaPack).
- Basic understanding of tracks, buses, and plugin inserts.

## Session baseline (from the docs setup)
Use 64 channels as default on all Ambisonics-related tracks and check routing at each step.

## Workflow phases (onboarding view)
Use this page to understand the structure before hands-on execution:
1. Monitoring backbone: `Decoder` + `Bformat-Master` + speaker preset.
2. Parallel listening: add binaural path for headphone validation.
3. Source layer: start with one MonoEncoder source and verify routing.
4. Motion layer: record first movement and validate automation readback.
5. Output layer: render from `Bformat-Master` in multichannel format.

## Hands-on checklist (execution)
For the exact click-by-click sequence, use:
- [Reaper Ambisonics Setup in 20 Minutes](/post/reaper-setup-20-minuten/)
- [Step by Step Setup (Docs)](/icst-ambisonics-plugins/06_step_by_step_setup/)

## Typical first errors (and where to debug)
- Wrong bus assignment (`Source -> Bformat-Master -> Decoder` chain broken).
- Binaural track fed from wrong source.
- Non-64-channel track in the signal path.
- OSC port mismatch when external control is enabled.

## Next steps
- [OSC Syntax for the ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
- [Reaper Ambisonics Setup in 20 Minutes](/post/reaper-setup-20-minuten/)
- [Stereo to HOA7: A Step-by-Step Session](/post/stereo-to-hoa7-session/)
