---
title: "From Stereo to HOA7: A Step-by-Step Session"
description: "Structured walkthrough from a stereo production mindset to a practical HOA7 Ambisonics session, including routing, movement design, and export checks."
date: 2026-03-08T14:20:00+01:00
year: 2026
month: 2026-03
weight: 24
tags: ["tutorial", "hoa7", "reaper", "ambisonics", "workflow"]
key_points:
  - "Translate a stereo production mindset into a 7th-order Ambisonics workflow"
  - "Design controlled source movement and validate the HOA7 export"
difficulty: "intermediate"
post_kind: "tutorial"
tool: ["REAPER"]
---


Level: Intermediate | **Audience:** Composer, Producer.

## Why this guide exists
Many users know stereo production well but need a concrete bridge to higher-order Ambisonics in a real session.

## Learning goal
Translate a stereo-style arrangement into HOA7 workflow thinking: object placement, motion, and controlled rendering.

## Prerequisites
- Basic stereo mixing workflow.
- Basic Reaper project setup skills.
- ICST plugin installation complete.

## Step 1 - Map stereo roles to spatial roles

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Stereo roles mapped into space: lead stays in front, support goes wider, atmosphere becomes a diffuse height layer." xmlns="http://www.w3.org/2000/svg"><defs><marker id="m1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="150" y="22" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Stereo</text><line x1="40" y1="110" x2="260" y2="110" stroke="currentColor" stroke-width="2" stroke-opacity=".5"/><circle cx="150" cy="110" r="9" fill="#d9534f" fill-opacity=".85"/><text x="150" y="90" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Lead</text><circle cx="80" cy="110" r="9" fill="#3fa968" fill-opacity=".85"/><text x="80" y="90" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Support</text><circle cx="220" cy="110" r="9" fill="#3fa968" fill-opacity=".85"/><text x="220" y="90" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Support</text><rect x="60" y="140" width="180" height="30" rx="15" fill="#4a8fe0" fill-opacity=".2" stroke="#4a8fe0"/><text x="150" y="160" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="1">Atmosphere</text><line x1="285" y1="110" x2="380" y2="110" stroke="currentColor" stroke-width="1.6" marker-end="url(#m1)"/><text x="540" y="22" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Space</text><circle cx="540" cy="115" r="85" fill="none" stroke="currentColor" stroke-opacity=".3"/><circle cx="540" cy="115" r="52" fill="none" stroke="#4a8fe0" stroke-width="2" stroke-dasharray="5 4"/><circle cx="540" cy="115" r="9" fill="none" stroke="currentColor" stroke-width="1.8"/><circle cx="540" cy="102" r="2.5" fill="currentColor"/><circle cx="540" cy="45" r="9" fill="#d9534f" fill-opacity=".85"/><text x="556" y="49" text-anchor="start" font-size="11" font-weight="400" fill="currentColor" fill-opacity="1">Lead</text><circle cx="460" cy="123" r="9" fill="#3fa968" fill-opacity=".85"/><circle cx="620" cy="123" r="9" fill="#3fa968" fill-opacity=".85"/><text x="460" y="149" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="1">Support</text><text x="620" y="149" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="1">Support</text><text x="540" y="227" text-anchor="middle" font-size="11" font-weight="400" fill="#4a8fe0" fill-opacity="1">Atmosphere: diffuse, above</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Step 1: from stereo roles to spatial roles.</figcaption>
</figure>

Assign your stereo elements to spatial objects:
- Lead elements -> stable front or animated object.
- Support elements -> wider spatial beds.
- Atmospheres -> diffuse or layered height support.

## Step 2 - Build the HOA7 session scaffold

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 262" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="The 64 channels of HOA7 grouped by order 0 to 7; lower orders are contained in higher ones." xmlns="http://www.w3.org/2000/svg"><rect x="20" y="22" width="21" height="21" rx="3" fill="#8a8a8a" fill-opacity=".85"/><rect x="44" y="22" width="21" height="21" rx="3" fill="#4a8fe0" fill-opacity=".85"/><rect x="68" y="22" width="21" height="21" rx="3" fill="#4a8fe0" fill-opacity=".85"/><rect x="92" y="22" width="21" height="21" rx="3" fill="#4a8fe0" fill-opacity=".85"/><rect x="116" y="22" width="21" height="21" rx="3" fill="#3fa5c4" fill-opacity=".85"/><rect x="140" y="22" width="21" height="21" rx="3" fill="#3fa5c4" fill-opacity=".85"/><rect x="164" y="22" width="21" height="21" rx="3" fill="#3fa5c4" fill-opacity=".85"/><rect x="188" y="22" width="21" height="21" rx="3" fill="#3fa5c4" fill-opacity=".85"/><rect x="20" y="46" width="21" height="21" rx="3" fill="#3fa5c4" fill-opacity=".85"/><rect x="44" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="68" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="92" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="116" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="140" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="164" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="188" y="46" width="21" height="21" rx="3" fill="#3fa98f" fill-opacity=".85"/><rect x="20" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="44" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="68" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="92" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="116" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="140" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="164" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="188" y="70" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="20" y="94" width="21" height="21" rx="3" fill="#3fa968" fill-opacity=".85"/><rect x="44" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="68" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="92" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="116" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="140" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="164" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="188" y="94" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="20" y="118" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="44" y="118" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="68" y="118" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="92" y="118" width="21" height="21" rx="3" fill="#8fb83f" fill-opacity=".85"/><rect x="116" y="118" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="140" y="118" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="164" y="118" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="188" y="118" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="20" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="44" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="68" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="92" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="116" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="140" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="164" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="188" y="142" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="20" y="166" width="21" height="21" rx="3" fill="#d9b43f" fill-opacity=".85"/><rect x="44" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="68" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="92" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="116" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="140" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="164" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="188" y="166" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="20" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="44" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="68" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="92" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="116" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="140" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="164" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><rect x="188" y="190" width="21" height="21" rx="3" fill="#d9843f" fill-opacity=".85"/><text x="116" y="236" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">64 channels, coloured by order</text><text x="250" y="30" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Orders inside HOA7 (channels, cumulative)</text><rect x="250" y="44" width="18" height="18" rx="3" fill="#8a8a8a" fill-opacity=".85"/><text x="280" y="58" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Order 0</text><text x="420" y="58" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">1</text><rect x="250" y="74" width="18" height="18" rx="3" fill="#4a8fe0" fill-opacity=".85"/><text x="280" y="88" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Order 1</text><text x="420" y="88" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">4</text><rect x="250" y="104" width="18" height="18" rx="3" fill="#3fa5c4" fill-opacity=".85"/><text x="280" y="118" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Order 2</text><text x="420" y="118" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">9</text><rect x="250" y="134" width="18" height="18" rx="3" fill="#3fa98f" fill-opacity=".85"/><text x="280" y="148" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Order 3</text><text x="420" y="148" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">16</text><rect x="250" y="164" width="18" height="18" rx="3" fill="#8fb83f" fill-opacity=".85"/><text x="280" y="178" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Order 5</text><text x="420" y="178" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">36</text><rect x="250" y="194" width="18" height="18" rx="3" fill="#d9843f" fill-opacity=".85"/><text x="280" y="208" text-anchor="start" font-size="13" font-weight="400" fill="currentColor" fill-opacity="1">Order 7</text><text x="420" y="208" text-anchor="start" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">64</text><text x="250" y="250" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">(order + 1)² = channels</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">HOA7 contains all lower orders; 64 channels carry everything from FOA upwards.</figcaption>
</figure>

Create one mono source track per stereo element, insert an AmbiEncoder on each, and send every encoder output to one `Bformat-Master` track.

- Set **all** Ambisonics tracks to **64 channels**. HOA7 needs exactly 64 channels (ACN 0-63); a track with fewer channels silently drops the higher orders.
- Keep one clear chain: `Source -> Encoder -> Bformat-Master -> Decoder`. No source goes straight to the master.
- Name tracks consistently (`LEAD`, `PAD_L`, `ATMO`, `Bformat-Master`) so routing errors stand out later.
- Start from the [track templates](/icst-ambisonics-plugins/05_open_track_templates/) instead of building the routing by hand, and add the decoder for your speaker preset on the monitoring path.

## Step 3 - Start with static placement
Give every source a fixed position and listen before any automation exists.

- Check the chain with one mono test source at a known position (straight ahead) before placing the rest.
- Place Lead near the front, Support left and right, atmosphere higher and wider. Use distance to separate depth layers.
- Listen over loudspeakers and binaural. If a source is not locatable when static, movement will not fix it.
- Save one plugin preset per role and a project snapshot (for example `_static`) as your fallback.

## Step 4 - Add controlled movement
Add movement one element at a time, starting with the Lead.

- Begin with small moves; widen them only if they are not audible in the monitoring.
- Let one foreground element move while Support and atmosphere stay still.
- Choose the tool by the job: [Motion Markers](/post/motion-markers-reaper/) for movement tied to the timeline, the [Animator](/icst-ambisonics-plugins/11_animator/) for choreographies, [group animation](/post/gp-manipulation/) for several sources at once.
- Re-check every movement in the binaural path as well as over loudspeakers.

## Step 5 - Validate translation

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 240" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="The HOA7 bus is checked on mono, stereo, binaural and the loudspeaker array." xmlns="http://www.w3.org/2000/svg"><defs><marker id="m3" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="70" width="170" height="60" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="95.0" y="98.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">HOA7 bus</text><text x="95.0" y="114.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">64 channels</text><line x1="182" y1="100" x2="438" y2="38" stroke="currentColor" stroke-width="1.6" marker-end="url(#m3)"/><rect x="440" y="14" width="260" height="44" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="570.0" y="34.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Mono</text><text x="570.0" y="50.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">sum check</text><line x1="182" y1="100" x2="438" y2="88" stroke="currentColor" stroke-width="1.6" marker-end="url(#m3)"/><rect x="440" y="64" width="260" height="44" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="570.0" y="84.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Stereo</text><text x="570.0" y="100.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">fold-down check</text><line x1="182" y1="100" x2="438" y2="138" stroke="currentColor" stroke-width="1.6" marker-end="url(#m3)"/><rect x="440" y="114" width="260" height="44" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="570.0" y="134.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Binaural</text><text x="570.0" y="150.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">headphones</text><line x1="182" y1="100" x2="438" y2="188" stroke="currentColor" stroke-width="1.6" marker-end="url(#m3)"/><rect x="440" y="164" width="260" height="44" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="570.0" y="184.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Speaker array</text><text x="570.0" y="200.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">decoder preset</text><text x="360" y="230" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.85">Check the same bus on every target before export.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Step 5: one bus, four checks.</figcaption>
</figure>

Verify that the session still works when the spatial format is not available.

- Fold the B-format down to mono and stereo: the key sources must stay audible and balanced (watch for phase cancellations).
- Compare loudspeaker and binaural monitoring; they should tell the same story.
- Run a 30-second signal check after loading a preset or reopening the project, and confirm the decoder preset matches the real speaker setup.

## Step 6 - Export and archive
Render the **Bformat-Master**, not the decoder output.

1. Solo `Bformat-Master`, open **File -> Render**, choose 48 kHz and multichannel WAV with **64 channels**.
2. Render a short test file first, re-import it and play it through the decoder or the binaural path.
3. Write a note in **Project Settings -> Notes**: ambiX (ACN/SN3D), 48000 Hz, 64 channels, 7th order, decoder preset used.

Details: [Render B-format](/icst-ambisonics-plugins/12_render_bformat/) and [Exporting the B-format master](/post/b-format-export-reaper/).

## Common pitfalls
- Over-animating too early.
- Ignoring gain staging on higher-order buses.
- Missing documentation of routing and OSC assignments.
- A track with fewer than 64 channels in the signal path.
- Decoder preset that does not match the real loudspeaker setup.

## Continue with
- [Which Ambisonics Order Do I Need?](/post/hoa-ordnung-wahl-praxis/): check whether HOA7 is really what your project needs
- [ICST AmbiEncoder_64: Group Animation](/post/gp-manipulation/): move several sources together
- [ICST Animator](/icst-ambisonics-plugins/11_animator/): design movements on a timeline instead of by hand
- [ICST AmbiDecoder: Multi-Decoder Mode](/post/multi-decoder-mode/): for larger or mixed loudspeaker setups
- [Ambisonics Workflow](/learn/ambisonics-workflow/): the whole path from recording to delivery
- Later: [OSC and Control](/reference/osc-and-control/)
