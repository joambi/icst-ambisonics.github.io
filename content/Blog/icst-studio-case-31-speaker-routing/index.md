---
title: "ICST Studio Case: Why Our 31-Speaker Setup Is Routed This Way"
description: "A practical case study of routing decisions in the ICST 31-speaker Ambisonics environment — what we chose, why, and what it prevents."
date: 2026-03-16T09:00:00+01:00
weight: -1
draft: false
group: "Studio"
tags: ["studio", "routing", "loudspeaker", "decoder", "case-study"]
---

**Level:** Intermediate — **For:** Composers, Technicians, Researchers working with or visiting the ICST Kompositionsstudio.

---

## Context

Every multi-speaker Ambisonics room accumulates small routing decisions over time — a bus added here, a monitoring path rerouted there. In the ICST Kompositionsstudio, those decisions have been made deliberately and documented so that each new resident starts from a stable, understood baseline rather than a mystery template.

This article explains the four core decisions behind the studio's 31-speaker REAPER session template, the problems each decision solves, and the failure modes it prevents.

---

## Decision 1 — A dedicated `Bformat-Master` track as the single source of truth

All source material — regardless of how many encoders or source tracks are active — feeds into one dedicated B-Format master bus before decoding. No source track sends audio directly to a decoder or to the speaker outputs.

**Why:** When multiple composers work in the same session over several days, it is easy for a source track to be accidentally routed to a monitoring bus or a decoder input that was meant for another signal. A single, named B-Format master makes the signal path visible and auditable at a glance. It also means that recording a "dry B-Format capture" of the full mix — useful for archiving or offline binaural rendering — requires exactly one send, from one track.

---

## Decision 2 — Decoder layer fully separated from the source layer

The decoder (AmbiDecoder) receives only from the `Bformat-Master`. It does not sit in a chain with source tracks, and its output goes directly to the speaker output bus — nowhere else.

**Why:** Mixing the decode stage with source processing is the most common source of hard-to-diagnose level and phase anomalies in Ambisonics sessions. If a source track's gain is wrong, that is audible immediately and locally. If the decoder is misconfigured — wrong order, wrong normalisation convention, wrong speaker preset — it affects every source simultaneously and the artefacts can appear to be a room problem rather than a routing problem. Keeping the decoder isolated means any misconfiguration is unambiguously in one place.

---

## Decision 3 — Speaker output and binaural monitoring as parallel paths

The session template includes two monitoring paths that are mutually exclusive by convention: the 31-speaker hardware output and a stereo binaural render. Both decode from the same `Bformat-Master`. Switching between them is a matter of muting one output bus and unmuting the other — no routing changes, no re-patching.

**Why:** Composers working in the studio frequently want to check their mix on headphones before committing to a speaker session booking, or want to send a rough binaural export to a collaborator. If binaural monitoring requires re-routing the session, it becomes a disruption and often gets skipped. With parallel paths in the template, it is a one-click toggle that does not touch the spatial signal chain.

---

## Decision 4 — Consistent naming and channel conventions

All tracks in the template follow a naming convention: `[number]_[function]_[format]`, e.g. `01_source_mono`, `10_bformat-master_HOA3`, `20_decoder_out`. Channel counts are fixed per track type and documented in the template.

**Why:** In a 31-channel environment, a single misassigned channel can produce an output that is indistinguishable from a speaker hardware failure. Consistent naming means that a guest artist or technician can audit the signal path in under a minute without needing to open every plugin. It also makes REAPER's track list readable as documentation — a new resident can understand the session architecture before pressing play.

---

## Common failure points this setup prevents

- **Mixed HOA orders on the B-Format master:** Adding a third-order source to a first-order session silently degrades to first-order when both feed the same master. The template documents the target order prominently in the master track name.
- **Monitoring fed from the wrong bus:** A direct send from a source track to the speaker output bypasses the decoder and produces a mono or stereo signal through a 31-speaker array — audible immediately, but confusing to diagnose. The separated layers make this structurally impossible in the template.
- **Decoder preset mismatch after a system update:** Speaker coordinate files are referenced by absolute path in the template and version-tagged in the filename. Loading the wrong preset is the most common cause of incorrectly localised sources after a software update.

---

## Related resources

- [From Stereo to HOA7: A Step-by-Step Session](/post/stereo-to-hoa7-session/)
- [ICST AmbiDecoder — Multi-Decoder Mode](/post/multi-decoder-mode/)
- [ICST Kompositionsstudio — Guide for Residents](/for-residents/)
- [ICST Kompositionsstudio Overview](/blog/icst-composer-studio-overview/)
