---
title: From the Ambisonics Scene to an Atmos Bed – Methods and Tools
description: "Ambisonics and Dolby Atmos beds are architecturally incompatible. This article explains why every conversion is lossy, which three methods exist and when converting makes sense at all."
date: 2026-03-21T14:00:00+01:00
year: 2026
month: 2026-03
weight: 34
tags: ["ambisonics", "dolby-atmos", "atmos-bed", "conversion", "hoa", "workflow", "delivery"]
key_points:
  - "Ambisonics is field-based, an Atmos bed is channel-based – every conversion is lossy"
  - "Three methods of differing quality: simple decode, beamforming, virtual dome"
  - "For headphones and VR: do not convert, render binaural directly from HOA"
difficulty: "intermediate"
post_kind: "tutorial"
tool: ["Delivery"]
---

Level: Intermediate | **Audience:** Composers, technicians, sound engineers.

---

## The basic problem

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 256" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="A HOA file plays on any layout; an Atmos bed is tied to one layout and conversion loses information." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mp" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="38" width="160" height="70" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="90.0" y="70.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">HOA sound field</text><text x="90.0" y="87.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">spherical harmonics</text><line x1="172" y1="73" x2="222" y2="73" stroke="currentColor" stroke-width="1.6" marker-end="url(#mp)"/><rect x="224" y="32" width="486" height="82" rx="10" fill="none" stroke="currentColor" stroke-opacity=".4" stroke-width="1.2" stroke-dasharray="5 4"/><text x="467" y="27" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">same file, any layout</text><rect x="236" y="52" width="108" height="50" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="290.0" y="82.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Octagon</text><rect x="354" y="52" width="108" height="50" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="408.0" y="82.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">3D dome</text><rect x="472" y="52" width="108" height="50" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="526.0" y="82.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Headphones</text><rect x="590" y="52" width="108" height="50" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="644.0" y="82.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">7.1.4</text><line x1="90" y1="110" x2="90" y2="166" stroke="currentColor" stroke-width="1.6" marker-end="url(#mp)"/><text x="102" y="145" text-anchor="start" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.85">conversion (lossy)</text><rect x="10" y="170" width="160" height="70" rx="8" stroke="#d9534f" fill="#d9534f" fill-opacity=".16" stroke-width="1.5"/><text x="90.0" y="202.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Atmos bed</text><text x="90.0" y="219.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">12 ch, fixed positions</text><line x1="172" y1="205" x2="222" y2="205" stroke="currentColor" stroke-width="1.6" marker-end="url(#mp)"/><rect x="224" y="180" width="170" height="50" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="309.0" y="210.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">7.1.4 speakers</text><text x="430" y="190" text-anchor="start" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">Lost in conversion:</text><circle cx="436.0" cy="206.0" r="3.5" fill="#d9534f" fill-opacity="0.9"/><text x="448" y="210" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.85">rotation invariance</text><circle cx="436.0" cy="226.0" r="3.5" fill="#d9534f" fill-opacity="0.9"/><text x="448" y="230" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.85">phase relations (partly)</text><circle cx="436.0" cy="246.0" r="3.5" fill="#d9534f" fill-opacity="0.9"/><text x="448" y="250" text-anchor="start" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.85">diffuse field detail</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">HOA is layout-free; a bed commits to one layout, and converting costs information.</figcaption>
</figure>


Ambisonics and Dolby Atmos beds are not only technically different – they follow different paradigms.

**B-format** describes a sound field via spherical harmonics. It knows no fixed loudspeakers. The same HOA file can be played back on an octagon, a 3D dome, over headphones or on a 7.1.4 system without changing the source file.

An **Atmos bed** is a fixed channel format: typically 7.1.2 (9 channels) or 7.1.4 (12 channels), with fixed loudspeaker positions. Anyone who creates an Atmos bed has committed to a concrete playback layout.

Converting from Ambisonics to an Atmos bed is therefore structurally lossy:

- The **rotation invariance** of B-format is lost – after conversion the sound field can no longer be rotated or transformed.
- The **phase relationships** between the spherical harmonics are partly lost in a simple downmix.
- **Diffuse field information** – the non-directional part of the room – is rendered less well than in the original.
- Later adjustments require a return to the source file.

This does not mean the conversion sounds bad. It means that the choice of method and the moment of conversion are decisive.

---

## When to convert – and when not

| Situation | Recommendation |
|---|---|
| Streaming release (Apple Music, TIDAL, Amazon) | Conversion necessary → Atmos bed/object |
| Cinema or theatre with a fixed Atmos system | Conversion necessary → 7.1.4 bed |
| Headphones / binaural / VR | **Do not convert** → binaural straight from HOA |
| Archiving and format-agnostic production | Keep the original HOA, convert on demand |
| Live performance | Avoid if possible – latency, DSP load |
| Research and A/B comparisons | Keep the HOA source file, several renders in parallel |

The most important rule: keep the HOA original in the production chain for as long as possible. Convert only at the end of the workflow, not during composition or mixing.

---

## Three conversion methods

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 284" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Three routes from an HOA master to the Dolby Atmos Renderer: bed decode, beamforming into up to 60 objects, virtual dome with 24 to 32 objects." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mm" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="112" width="110" height="60" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="65.0" y="139.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">HOA master</text><text x="65.0" y="156.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">B-format</text><line x1="122" y1="142" x2="168" y2="48" stroke="currentColor" stroke-width="1.6" marker-end="url(#mm)"/><rect x="170" y="20" width="190" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="265.0" y="45.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">A · Bed decode</text><text x="265.0" y="62.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">quick, medium quality</text><line x1="362" y1="48" x2="398" y2="48" stroke="currentColor" stroke-width="1.6" marker-end="url(#mm)"/><rect x="400" y="20" width="180" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="490.0" y="45.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Bed 7.1.4</text><text x="490.0" y="62.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">12 ch, fixed layout</text><line x1="582" y1="48" x2="598" y2="48" stroke="currentColor" stroke-width="1.6" marker-end="url(#mm)"/><line x1="122" y1="142" x2="168" y2="142" stroke="currentColor" stroke-width="1.6" marker-end="url(#mm)"/><rect x="170" y="114" width="190" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="265.0" y="139.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">B · Beamforming (SAD)</text><text x="265.0" y="156.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">high quality, heavy CPU</text><line x1="362" y1="142" x2="398" y2="142" stroke="currentColor" stroke-width="1.6" marker-end="url(#mm)"/><rect x="400" y="114" width="180" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="490.0" y="139.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Up to 60 objects</text><text x="490.0" y="156.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">cluster to fit limit</text><line x1="582" y1="142" x2="598" y2="142" stroke="currentColor" stroke-width="1.6" marker-end="url(#mm)"/><line x1="122" y1="142" x2="168" y2="236" stroke="currentColor" stroke-width="1.6" marker-end="url(#mm)"/><rect x="170" y="208" width="190" height="56" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".16" stroke-width="1.5"/><text x="265.0" y="233.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">C · Virtual dome</text><text x="265.0" y="250.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">good, practical</text><line x1="362" y1="236" x2="398" y2="236" stroke="currentColor" stroke-width="1.6" marker-end="url(#mm)"/><rect x="400" y="208" width="180" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="490.0" y="233.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">24–32 objects</text><text x="490.0" y="250.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">one per virtual speaker</text><line x1="582" y1="236" x2="598" y2="236" stroke="currentColor" stroke-width="1.6" marker-end="url(#mm)"/><rect x="600" y="20" width="110" height="244" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="655" y="138" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Dolby Atmos</text><text x="655" y="156" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Renderer</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Three conversion methods, one target: the Dolby Atmos Renderer.</figcaption>
</figure>

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Target geometry of the three methods in top view: 12 fixed bed speakers, 60 beamformer points, a dome of 24 to 32 virtual speakers." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mg" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="125" y="20" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">A · Bed</text><circle cx="125" cy="125" r="82" fill="none" stroke="currentColor" stroke-opacity=".35" stroke-width="1.5"/><circle cx="125" cy="125" r="3.5" fill="currentColor"/><text x="125" y="236" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">7 + LFE + 4 height = 12 ch</text><text x="360" y="20" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">B · SAD points</text><circle cx="360" cy="125" r="82" fill="none" stroke="currentColor" stroke-opacity=".35" stroke-width="1.5"/><circle cx="360" cy="125" r="3.5" fill="currentColor"/><text x="360" y="236" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">60 directional points</text><text x="595" y="20" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">C · Virtual dome</text><circle cx="595" cy="125" r="82" fill="none" stroke="currentColor" stroke-opacity=".35" stroke-width="1.5"/><circle cx="595" cy="125" r="3.5" fill="currentColor"/><text x="595" y="236" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">24–32 virtual speakers</text><circle cx="125.0" cy="49.0" r="6.5" fill="currentColor" fill-opacity="0.8"/><circle cx="87.0" cy="59.2" r="6.5" fill="currentColor" fill-opacity="0.8"/><circle cx="163.0" cy="59.2" r="6.5" fill="currentColor" fill-opacity="0.8"/><circle cx="49.0" cy="125.0" r="6.5" fill="currentColor" fill-opacity="0.8"/><circle cx="201.0" cy="125.0" r="6.5" fill="currentColor" fill-opacity="0.8"/><circle cx="71.3" cy="178.7" r="6.5" fill="currentColor" fill-opacity="0.8"/><circle cx="178.7" cy="178.7" r="6.5" fill="currentColor" fill-opacity="0.8"/><circle cx="95.3" cy="95.3" r="6.5" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="154.7" cy="95.3" r="6.5" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="95.3" cy="154.7" r="6.5" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="154.7" cy="154.7" r="6.5" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="374.2" cy="125.0" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="342.0" cy="141.5" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="362.7" cy="93.9" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="382.2" cy="154.0" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="319.5" cy="117.8" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="398.0" cy="100.8" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="347.4" cy="171.8" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="336.2" cy="79.2" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="411.1" cy="143.7" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="307.4" cy="146.7" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="385.1" cy="71.3" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="378.4" cy="183.6" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="305.2" cy="93.2" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="423.6" cy="111.0" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="321.6" cy="179.6" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="351.2" cy="57.3" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="413.3" cy="169.9" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="289.2" cy="127.9" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="411.1" cy="74.2" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="356.6" cy="198.0" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="312.6" cy="68.2" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="434.1" cy="135.0" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="298.0" cy="168.1" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="376.7" cy="50.7" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="398.1" cy="191.5" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="286.5" cy="101.6" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="430.3" cy="92.5" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="330.0" cy="196.7" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="333.6" cy="51.7" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="429.0" cy="161.3" r="3.6" fill="#4a8fe0" fill-opacity="0.9"/><circle cx="284.6" cy="144.9" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="402.1" cy="59.5" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="373.2" cy="201.6" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="298.8" cy="77.6" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="436.9" cy="118.6" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="307.9" cy="181.3" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="360.4" cy="48.9" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="410.7" cy="180.9" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="285.5" cy="118.1" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="418.9" cy="80.3" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="346.9" cy="196.9" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="321.6" cy="64.0" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="428.4" cy="143.7" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="298.0" cy="156.8" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="383.7" cy="61.0" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="385.2" cy="186.9" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="301.1" cy="97.1" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="420.5" cy="106.3" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="329.0" cy="178.0" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="347.6" cy="67.0" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="406.4" cy="158.0" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="306.0" cy="131.7" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="393.4" cy="85.7" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="361.8" cy="173.5" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="328.4" cy="92.9" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="401.0" cy="127.1" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="331.8" cy="148.3" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="364.3" cy="94.1" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="373.8" cy="145.1" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="346.2" cy="121.8" r="3.6" fill="#4a8fe0" fill-opacity="0.35"/><circle cx="595.0" cy="47.0" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="650.2" cy="69.8" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="673.0" cy="125.0" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="650.2" cy="180.2" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="595.0" cy="203.0" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="539.8" cy="180.2" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="517.0" cy="125.0" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="539.8" cy="69.8" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="617.9" cy="69.8" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="650.2" cy="102.1" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="650.2" cy="147.9" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="617.9" cy="180.2" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="572.1" cy="180.2" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="539.8" cy="147.9" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="539.8" cy="102.1" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="572.1" cy="69.8" r="5" fill="#3fa968" fill-opacity="0.9"/><circle cx="617.9" cy="69.8" r="5" fill="#3fa968" fill-opacity="0.35"/><circle cx="650.2" cy="102.1" r="5" fill="#3fa968" fill-opacity="0.35"/><circle cx="650.2" cy="147.9" r="5" fill="#3fa968" fill-opacity="0.35"/><circle cx="617.9" cy="180.2" r="5" fill="#3fa968" fill-opacity="0.35"/><circle cx="572.1" cy="180.2" r="5" fill="#3fa968" fill-opacity="0.35"/><circle cx="539.8" cy="147.9" r="5" fill="#3fa968" fill-opacity="0.35"/><circle cx="539.8" cy="102.1" r="5" fill="#3fa968" fill-opacity="0.35"/><circle cx="572.1" cy="69.8" r="5" fill="#3fa968" fill-opacity="0.35"/><circle cx="14.0" cy="246.0" r="0" fill="none" fill-opacity="0.85"/></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Target geometry per method (top view, front = up).</figcaption>
</figure>


### Method A – simple speaker bed decode

The most direct route: HOA is decoded with an Ambisonic decoder to the 12 channels of the 7.1.4 layout and handed to the renderer as an Atmos bed.

**Tools:** IEM SimpleDecoder (via AllRADecoder JSON export), SPARTA AmbiDEC, IEM AllRADecoder, Blue Ripple O3A Decoder (direct 7.1.2 output), Audio Brewers ab Decoder HOA Express (Pro Tools).

**Quality:** medium. Simple and quick to implement, but with complex room content there are measurable losses in localisation sharpness and diffuse field information. Research shows that simple bed downmixing of HOA can lead to a "substantial loss of spatial definition".

**Suited to:** uncomplicated content, quick deliveries, scenes without strong demands on spatial precision.

---

### Method B – beamforming and object decomposition

A much more faithful method: the HOA sound field is decomposed via a **Sampling Ambisonic Decoder (SAD)** into up to 60 discrete directional points on a T-design sphere distribution. Each point is placed in the renderer as an independent Atmos object.

**Tools:** SPARTA AmbiDEC (free 60-point SAD preset built in), Dolby Atmos Renderer (as the target for the object list).

**Quality:** high. Preserves considerably more spatial detail than method A. A 2024 study shows that beamforming-based decomposition into 60 objects significantly improves localisation accuracy compared with a simple bed decode.

**Drawback:** complex workflow, high CPU demand, and the number of Atmos objects is practically limited (32 objects for consumer formats, 118 in cinema). With 60 beamformer points you have to cluster or reduce objects.

**Suited to:** scenes with high spatial density, music productions with precision demands, research contexts.

---

### Method C – virtual speaker dome

A middle way between A and B: a dense virtual loudspeaker grid (24 to 32 points on a sphere) is generated. HOA is decoded onto this virtual dome and each loudspeaker is handed over as an Atmos object.

**Tools:** Blue Ripple O3A Decoder (Dome 24 and Dome 32), SPARTA AmbiDEC with custom configurations.

**Quality:** good. Better than method A, more practical than method B. Precise enough for most music applications.

**Suited to:** music productions, installations, scenes of moderate spatial complexity.

---

## Binaural: the better route for headphones

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 240" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Binaural directly from HOA keeps head-tracking rotation lossless; going through an Atmos bed first loses that." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mh" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="10" y="18" text-anchor="start" font-size="12" font-weight="600" fill="#3fa968" fill-opacity="1">Directly from HOA (recommended)</text><rect x="10" y="28" width="110" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="65.0" y="61.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">HOA</text><line x1="122" y1="56" x2="148" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#mh)"/><rect x="150" y="28" width="190" height="56" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".16" stroke-width="1.5"/><text x="245.0" y="53.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Rotation</text><text x="245.0" y="70.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">head tracking, lossless</text><line x1="342" y1="56" x2="368" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#mh)"/><rect x="370" y="28" width="160" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="450.0" y="61.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">HRTF binaural</text><line x1="532" y1="56" x2="558" y2="56" stroke="currentColor" stroke-width="1.6" marker-end="url(#mh)"/><rect x="560" y="28" width="150" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="635.0" y="61.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Headphones</text><text x="150" y="104" text-anchor="start" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Rotation stays lossless until the last step.</text><text x="10" y="142" text-anchor="start" font-size="12" font-weight="600" fill="#d9534f" fill-opacity="1">Detour via Atmos bed</text><rect x="10" y="152" width="110" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="65.0" y="185.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">HOA</text><line x1="122" y1="180" x2="148" y2="180" stroke="currentColor" stroke-width="1.6" marker-end="url(#mh)"/><rect x="150" y="152" width="190" height="56" rx="8" stroke="#d9534f" fill="#d9534f" fill-opacity=".16" stroke-width="1.5"/><text x="245.0" y="177.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Atmos bed</text><text x="245.0" y="194.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">fixed positions</text><line x1="342" y1="180" x2="368" y2="180" stroke="currentColor" stroke-width="1.6" marker-end="url(#mh)"/><rect x="370" y="152" width="160" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="450.0" y="185.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">HRTF binaural</text><line x1="532" y1="180" x2="558" y2="180" stroke="currentColor" stroke-width="1.6" marker-end="url(#mh)"/><rect x="560" y="152" width="150" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="635.0" y="185.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Headphones</text><text x="150" y="228" text-anchor="start" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">No lossless rotation any more; spatial detail is already reduced.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Binaural for headphones: render straight from HOA, not from a bed.</figcaption>
</figure>


For headphone delivery – Apple Spatial Audio in binaural mode, VR/XR, 360° video – converting to an Atmos bed is not the right approach. Better: render HOA directly with an HRTF-based binaural decoder.

The advantage: the complete sound field is preserved until the very last step. Rotation (e.g. head tracking in VR) is lossless because B-format is rotation-invariant – an advantage that could no longer be used after conversion into a fixed bed.

**Tools:** SPARTA AmbiBIN (up to 10th order, SOFA file support, head tracking via OSC), IEM BinauralDecoder (up to 7th order), Nuendo 12 (integrated binaural converter), dearVR PRO + MONITOR.

Important note: binaural rendering at low orders (FOA, 2OA) can produce sound artefacts – the HRTF functions and the spherical harmonics do not "fit" together perfectly in spectral terms. Spectral compensation filtering (SH-domain tapering) improves the result considerably. SPARTA AmbiBIN implements this method.

---

## Tools at a glance

| Tool | Licence | Method | Order | Note |
|---|---|---|---|---|
| SPARTA AmbiDEC | free | A, B | up to 10th | 60-point SAD preset for method B |
| SPARTA AmbiBIN | free | binaural | up to 10th | SOFA, head tracking via OSC |
| IEM AllRADecoder | free | A | 1–7 | JSON export for SimpleDecoder |
| IEM SimpleDecoder | free | A | 1–7 | loads AllRADecoder configurations |
| IEM BinauralDecoder | free | binaural | 1–7 | |
| Blue Ripple O3A Decoder | commercial | A, C | O3A (3rd eq.) | direct output 7.1.2 and Dome 24/32 |
| ab Decoder HOA Express | commercial | A | 1–3 | Pro Tools native |
| dearVR PRO | commercial | binaural | up to 7th | Nuendo/Cubase integration |
| Nuendo 12 Atmos Suite | commercial | A + binaural | up to 7th | most seamless integrated workflow |

For REAPER: SPARTA and the IEM Suite are free and fully supported. The way to Atmos leads via method A or B into the Dolby Atmos Renderer (separate, commercial).

---

## Methodological recommendation

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 248" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="The HOA master stays in the middle of the chain; streaming, cinema, headphones and archive are separate renders." xmlns="http://www.w3.org/2000/svg"><defs><marker id="md" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="92" width="160" height="66" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="90" y="121" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">HOA master</text><text x="90" y="139" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">canonical master,</text><text x="90" y="153" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">keep it as long as possible</text><line x1="172" y1="125" x2="208" y2="34" stroke="currentColor" stroke-width="1.6" marker-end="url(#md)"/><rect x="210" y="8" width="500" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="224" y="31.0" text-anchor="start" font-size="13" font-weight="600" fill="currentColor">Streaming</text><text x="224" y="48.0" text-anchor="start" font-size="11" fill="currentColor" fill-opacity=".75">Method C or B → Atmos Renderer → ADM</text><line x1="172" y1="125" x2="208" y2="94" stroke="currentColor" stroke-width="1.6" marker-end="url(#md)"/><rect x="210" y="68" width="500" height="52" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="224" y="91.0" text-anchor="start" font-size="13" font-weight="600" fill="currentColor">Cinema</text><text x="224" y="108.0" text-anchor="start" font-size="11" fill="currentColor" fill-opacity=".75">Method A or B → Atmos Renderer → DCP preparation</text><line x1="172" y1="125" x2="208" y2="154" stroke="currentColor" stroke-width="1.6" marker-end="url(#md)"/><rect x="210" y="128" width="500" height="52" rx="8" stroke="#3fa968" fill="#3fa968" fill-opacity=".16" stroke-width="1.5"/><text x="224" y="151.0" text-anchor="start" font-size="13" font-weight="600" fill="currentColor">Headphones</text><text x="224" y="168.0" text-anchor="start" font-size="11" fill="currentColor" fill-opacity=".75">HRTF binaural straight from HOA → stereo (no Atmos detour)</text><line x1="172" y1="125" x2="208" y2="214" stroke="currentColor" stroke-width="1.6" marker-end="url(#md)"/><rect x="210" y="188" width="500" height="52" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="224" y="211.0" text-anchor="start" font-size="13" font-weight="600" fill="currentColor">Archive</text><text x="224" y="228.0" text-anchor="start" font-size="11" fill="currentColor" fill-opacity=".75">keep the HOA file; every other format is a render</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Keep the HOA master; every delivery format is a render from it.</figcaption>
</figure>




Anyone who wants to publish an Ambisonics work for different platforms should build the production chain like this:

1. **Source:** HOA file as the canonical master (the highest order the source material provides)
2. **Monitoring:** binaural render straight from HOA (throughout the production)
3. **Streaming delivery:** HOA → method C or B → Atmos Renderer → ADM file
4. **Headphone delivery:** HOA → HRTF binaural → stereo (no Atmos detour)
5. **Cinema delivery:** HOA → method A or B → Atmos Renderer → DCP preparation
6. **Archive:** keep the HOA source file – all other formats are renders

Conversion is always a decision for a specific playback system. B-format is and remains the most flexible format – leave it as late as possible.

---

## Sources and further reading

- [Decoding Ambisonics to Dolby Atmos Using Beamforming and Spherical Array of Objects](https://www.researchgate.net/publication/380905519_Decoding_Ambisonics_to_Dolby_Atmos_using_beamforming_and_spherical_array_of_objects) – foundational study on method B (2024)
- [EBU Technical Review: Scene-Based Audio and HOA](https://tech.ebu.ch/docs/techreview/trev_2019-Q4_SBA_HOA_Technology_Overview.pdf) – EBU overview of HOA and ADM compatibility
- [ITU-R BS.2076-3 Audio Definition Model](https://www.itu.int/dms_pubrec/itu-r/rec/bs/R-REC-BS.2076-3-202502-I!!PDF-E.pdf) – current ADM standard (2025)
- [SPARTA Suite documentation](https://leomccormack.github.io/sparta-site/docs/plugins/sparta-suite/)
- [IEM Plug-in Suite](https://plugins.iem.at/)
- [Matthias Frank, *How to Make Ambisonics Sound Good*](https://iaem.at/Members/frank/files/2014_frank_howtomakeambisonicssoundgood.pdf) – IEM Graz, practical decoding recommendations

---

## Further reading

- [Why the decoder sounds the way it does – methodological context](/post/decoder-methodological-context/)
- [ICST MultiDecoder](/icst-ambisonics-plugins/09_icst_multidecoder/)
- [History and applications of the Ambisonics decoder](/blog/decoder-geschichte-und-anwendungen/)
- [Best practices](/icst-ambisonics-plugins/17_best_practices/)
