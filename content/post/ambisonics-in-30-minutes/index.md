---
title: "Ambisonics in 30 Minutes: Your First Working Reaper Session Flow"
description: "A fast onboarding tutorial to build a stable first Ambisonics session in Reaper with ICST plugins."
date: 2026-03-09T09:00:00+01:00
year: 2026
month: 2026-03
weight: 24
tags: ["tutorial", "reaper", "ambisonics", "getting-started", "workflow"]
key_points:
  - "Build encoder → B-format bus → decoder routing from scratch in REAPER"
  - "Diagnose and fix the most common first-session errors"
difficulty: "beginner"
---


**For whom:** Level: Beginner | Audience: Composer, Student, Studio Assistant.

## Problem
You want to start quickly with ICST Ambisonics plugins in Reaper, without spending hours on trial-and-error routing.

## Setup
- Reaper installed
- ICST Ambisonics plugins installed
- Optional: SWS + ReaPack

## Step-by-step
1. Create `Bformat-Master` (64 channels).
2. Insert decoder on monitoring path.
3. Add one source with AmbiEncoder.
4. Route source to `Bformat-Master`.
5. Add binaural monitoring in parallel.
6. Record a short motion automation pass.
7. Render and verify output channels.

## Common errors
- Source not routed to `Bformat-Master`
- Non-64-channel track in signal path
- Wrong decoder preset for speaker setup

## Related tutorial
- [Getting Started with ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)
- [Reaper Ambisonics Setup in 20 Minutes](/post/reaper-setup-20-minuten/)

## Download
- Add links to template and checklist here.

## Next step
- [OSC Syntax for the ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
