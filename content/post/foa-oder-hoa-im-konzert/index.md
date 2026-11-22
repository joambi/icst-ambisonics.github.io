---
title: FOA or HOA for Concerts? Choosing the Order for Loudspeaker Performances
description: "Which Ambisonics order for a concert? Hall size, number of loudspeakers, audience area, playback and rehearsal routine: a decision aid for FOA, HOA3 and HOA7 in performances."
date: 2026-11-22T20:00:00+01:00
year: 2026
month: 2026-11
draft: true
weight: 40
tags: ["hoa", "foa", "order", "concert", "performance", "loudspeakers", "workflow"]
key_points:
  - "The loudspeaker count sets the usable order: at least (N+1)² loudspeakers for order N"
  - "A higher order enlarges the area with correct localisation, which matters for an audience"
  - "Produce in HOA7, deliver for the room: you can always reduce the order, never add it"
difficulty: "intermediate"
post_kind: "background"
---

Level: Intermediate | **Audience:** Composers, performers, technicians preparing a loudspeaker concert.

---

**Short answer:** For a concert, the room decides. Up to about 8 loudspeakers, FOA is all the system can reproduce. With around 16 loudspeakers, HOA3 is the sensible delivery order. From about 36 loudspeakers (large halls, domes), HOA5 or HOA7 pays off. Produce in HOA7 as long as your computer allows it, and decode for the room.

---

## What the room tells you

The number of loudspeakers sets the practical ceiling. For order N you need at least (N+1)² loudspeakers: 4 for FOA, 16 for HOA3, 36 for HOA5, 64 for HOA7. Orders above that are calculated but not reproduced in full. The ICST Composition Studio with its 18 loudspeakers reproduces about HOA3 completely; a dome with 64 loudspeakers can use HOA7.

More background in [Which Ambisonics order do I need?](/post/hoa-ordnung-wahl-praxis/).

---

## Why the audience changes the question

On headphones or at a single sweet spot, FOA and HOA3 are often close. A concert has many listeners at many seats. The area in which the sound field is reproduced correctly grows with the order (about 5 cm at FOA, 16 cm at HOA3, 27 cm at HOA5 and 38 cm at HOA7 at 1 kHz, as an illustration). At FOA it is smaller than a head, at HOA3 it suffices for one listener, at HOA7 for a small group.

> [To add from your experience: how does the spatial image change for listeners away from the centre in the studio or in a concert hall? Which order worked for how many seats?]

---

## Delivery: reduce, never add

Work in the highest order your computer allows and decode for the room. A HOA7 master can be reduced to HOA3 or FOA for a smaller system, a stereo backup or a binaural render. A lower-order session can never be upgraded afterwards. See [Exporting the B-format master](/post/b-format-export-reaper/).

For heavy sessions, freeze encoder tracks into multichannel files. Playing a frozen 64-channel file needed 0.14 % CPU in our REAPER measurement, instead of the encoder load of each source.

---

## Decoder and room

In a real hall the loudspeakers are rarely on a perfect sphere. Distances differ, the walls are asymmetric. Scaling and delay compensation in the decoder make the sound arrive at the listener at the right time. See [ICST AmbiDecoder: scaling and delay compensation](/post/decoder-skalierung-laufzeitkompensation/).

> [To add from your experience: which loudspeaker layouts did you decode for (ring, dome, mixed), and which decoder settings did you use?]

---

## Rehearsal checklist

- Check the loudspeaker mapping with a test signal on every channel.
- Run the piece in the target order on the performance computer, with all effects, and watch the CPU.
- Keep a stereo backup and a binaural render ready.
- Have a lower-order version prepared (for example HOA3) in case the system is limited.
- Note the plugin versions and interface routing in writing.

The longer checklist and the performance strategy are in [Composing in Ambisonics](/post/komposition-in-ambisonics/). For headphone checks during preparation, see [Binaural monitoring](/post/binaural-monitoring-icst-workflow/).

> [To add from your experience: your usual rehearsal routine, how long the soundcheck takes, which problems occur most often.]

---

## Recommendation

| Situation | Order |
|---|---|
| Small system (4 to 8 loudspeakers), sketches, headphones only | FOA |
| Studio or hall with 16 to about 35 loudspeakers | HOA3 |
| Large hall or dome with 36 or more loudspeakers | HOA5 or HOA7 |
| Archive and master files | HOA7 |
