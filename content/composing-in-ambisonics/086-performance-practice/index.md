---
title: "Concert and Performance Practice"
description: "Technical rider, pre-concert communication, soundcheck logistics, and common pitfalls for Ambisonics fixed-media performances."
date: 2026-01-01T00:00:00
weight: 86
draft: false
translationKey: "composing-performance-practice"
---

A fixed-media Ambisonics piece does not perform itself. Between the studio master and a successful concert performance lies a chain of technical decisions, communication tasks, and practical checks that are as much part of the compositional work as the piece itself. The earlier these are prepared, the less is left to chance — or to the stressed hour before doors open.

## The Technical Rider

The technical rider is the central document exchanged between composer and venue. It should be sent well in advance — ideally weeks before the concert — and contain everything the technical team needs to set up and run the piece correctly.

A minimal rider for an Ambisonics fixed-media piece includes:

**Playback file**
- Format: AmbiX, how many channels, sample rate, bit depth
- Or: pre-decoded multichannel file with channel count and order
- Loudness: integrated LUFS value and whether the file has been normalised

**Loudspeaker layout**
- Required minimum configuration (e.g. ring 8, ring 16, dome 24)
- Whether the piece works in a 2D ring only or requires elevated speakers
- Whether a sub-woofer is required and how it should be fed

**Decoding**
- Who decodes: composer (brings own decoder), or venue (uses their system)?
- If the venue decodes: which decoder and layout file should be used?
- If the composer decodes: which software, and what output format is expected from the venue (MADI, AES67, analogue)?

**Playback software and hardware**
- What plays the file: Reaper, Max/MSP, Qlab, or similar?
- Who brings the playback machine, or does the venue provide one?
- Any latency or synchronisation requirements?

**Monitoring**
- Is a separate monitoring mix needed during performance?
- Does the composer need to sit at a mixing desk or can the piece run autonomously?

**Time requirements**
- Minimum soundcheck duration (realistically: 45–90 minutes for a first performance in a new venue)
- Duration of the piece and any silent gaps or fade-in/fade-out behaviour

---

A rider template can be adapted from the [ICST Ambisonics documentation](/ICST-Ambisonics-Plugins/) or sent as a simple PDF. A clear rider prevents the most common concert failures before they happen.

## Pre-Concert Communication

Send the rider, then follow up. Venues and festivals receive many technical documents and may not read them carefully. A brief phone or video call with the technical director one to two weeks before the concert is often more effective than a long email chain. Key questions to confirm:

- How many speakers are in the array, and what is the exact layout?
- Are all speakers in working order and correctly calibrated?
- Is the system delays-aligned (all speakers timed to a common listening position)?
- Is the room treated, or does it have significant untreated reverb?
- How is the playback routed: digital (MADI, Dante, AES67) or analogue?

If the venue can provide a loudspeaker layout file (azimuth, elevation, distance per channel) in advance, you can pre-decode the piece to the exact array and arrive with a ready-to-play multichannel file rather than relying on the venue's decoder during the soundcheck.

## The Soundcheck

The soundcheck is the most important moment of the performance process. Plan it seriously.

**What to check, in order:**

1. **Signal routing** — play a test signal (pink noise or a known source) and verify that every speaker is working and assigned to the correct channel. A rotating noise source at 0° elevation is useful: it should spin smoothly around the ring.

2. **Level calibration** — all speakers should be at matched SPL. Many venues have already calibrated their arrays; some have not. Bring a reference level (e.g. –18 dBFS pink noise should read approximately 85 dB SPL at the sweet spot).

3. **Decoder check** — if the venue decodes, play a short B-format excerpt and confirm that the spatial image matches what you expect. Front should be front, overhead should be overhead.

4. **Full piece playthrough** — if time permits, play the entire piece at performance level. This reveals resonances, phase issues, or sections that do not translate as expected to the venue.

5. **Seating position** — the sweet spot of an Ambisonics array depends on its geometry. Confirm where the audience will sit and listen from that position yourself. Sounds that seem spatially precise from the engineer's desk may read differently from the audience area.

6. **Loudness check** — at performance level and from the audience position, confirm that the dynamic range is appropriate: quiet passages are not inaudible, peaks are not uncomfortably loud.

**Time budget:** Allow at minimum 45 minutes for a simple setup with a pre-decoded file and a cooperative venue. For a first performance in a new venue with live decoding, 90 minutes is more realistic. Factor in setup time before the soundcheck itself begins.

## Flexibility and Fallback Plans

Even with a perfect rider and a cooperative venue, things go wrong. Common failure modes and how to prepare for them:

| Problem | Prevention | Fallback |
|---------|-----------|---------|
| Wrong channel routing | Bring your own routing patch / channel order reference | Pre-decoded file for multiple common configurations |
| Missing or broken speaker | Know which speakers are critical; check in advance | Identify which speakers can be dropped without destroying the spatial image |
| Venue decoder unavailable | Bring your own laptop + decoder | Pre-decoded file for the expected layout |
| Playback machine failure | Bring a second laptop; keep a backup drive | Have a binaural stereo or stereo mix as last resort |
| Excessive venue reverb | Test in advance; adjust mix if possible | Reduce wet signals in mix; increase direct/dry ratio |
| Level mismatch | Arrive with loudness metadata and a reference recording | Master volume adjustment at the desk |

A binaural stereo backup file on a USB stick has saved more than one concert. It is not the ideal listening experience, but it is better than silence.

## During the Performance

For a fully autonomous fixed-media piece, the performance itself requires little intervention: start playback at the agreed cue, monitor levels, and stop cleanly at the end. A few practical points:

- **Sit in the room during performance**, not at the engineer's desk. Hear what the audience hears.
- **Communicate the start cue clearly** with the technical operator: a count-in, a visual signal, or a written cue sheet.
- **Do not adjust levels during the piece** unless something is seriously wrong. Level changes mid-performance are usually more disruptive than a slightly too-loud or too-quiet moment.
- **Know where the emergency stop is** — if playback software crashes or audio drops out, be able to stop cleanly rather than letting silence extend indefinitely.

## Post-Concert Documentation

After the performance, record what happened:

- Which playback file was used (filename, date, format)
- Which loudspeaker configuration and decoder setting were used
- Any adjustments made during the soundcheck
- Audience response and any spatial elements that did not work as expected
- Technical issues and how they were resolved

This documentation feeds directly back into the [spatial score](/composing-in-ambisonics/075-spatial-notation/) and the [archiving process](/composing-in-ambisonics/084-formats-archiving/): it tells you whether the piece holds up outside the studio, which zones of the spatial image are fragile, and what to change for the next performance or for future productions.
