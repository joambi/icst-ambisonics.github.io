---
title: "ICST Studio Case: Why Our 31-Speaker Setup Is Routed This Way"
description: "A practical case study of routing decisions in the ICST 31-speaker Ambisonics environment."
date: 2026-03-16T09:00:00+01:00
weight: -1
draft: true
group: "Studio"
tags: ["studio", "routing", "loudspeaker", "decoder", "case-study"]
---

# ICST Studio Case: Why Our 31-Speaker Setup Is Routed This Way

**For whom:** Level: Intermediate | Audience: Composer, Technician, Researcher.

## Context
This case explains the routing logic used in the ICST composition studio to keep sessions robust and repeatable.

## Core decisions
1. Dedicated `Bformat-Master` as single source of truth.
2. Decoder layer separated from source layer.
3. Monitoring variants (speaker/binaural) in parallel paths.
4. Predictable naming and channel conventions.

## What this solves
- Faster onboarding for guest artists
- Lower setup error rate
- Easier troubleshooting during production

## Typical failure points
- Mixed channel formats on master path
- Monitoring fed from wrong bus
- Decoder preset mismatch

## Related tutorial
- [From Stereo to HOA7: A Step-by-Step Session](/post/stereo-to-hoa7-session/)
- [ICST AmbiDecoder - Multi-Decoder Mode](/post/multi-decoder-mode/)

## Download
- Add routing diagram and checklist links.

## Next step
- [ICST Composition Studio](/blog/icst-composer-studio-blog/)

