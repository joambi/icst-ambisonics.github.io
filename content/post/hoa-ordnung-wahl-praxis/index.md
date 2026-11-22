---
title: Which Ambisonics Order Do I Need? – Choosing HOA in Practice
description: "FOA, HOA3 or HOA7? This article explains when which order makes sense: channel count, spatial resolution, loudspeaker requirements, CPU load and binaural – as a clear decision aid for everyday production."
date: 2026-03-21T18:00:00+01:00
year: 2026
month: 2026-03
weight: 38
tags: ["hoa", "foa", "order", "channel-count", "workflow", "concept", "reaper"]
key_points:
  - "The formula (N+1)² sets the channel count: 1st = 4, 3rd = 16, 7th = 64 channels"
  - "The loudspeaker system is the limiting factor – not the DAW"
  - "Work in the highest order your CPU allows (ideally HOA7): you can reduce the order later, but never add it back"
difficulty: "beginner"
post_kind: "background"
---

Level: Beginner–Intermediate | **Audience:** Composers, producers, anyone setting up a new Ambisonics session.

---

Choosing the Ambisonics order is one of the first decisions in any production, and it determines channel count, CPU load, plugin requirements and the sound quality on a loudspeaker system. This article explains the relationships without maths and gives clear recommendations for typical situations.

---

## The basic formula

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 205" role="img" aria-label="Channel count grows with the square of the order" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><circle cx="149.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="158.5" cy="64.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="149.5" cy="73.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="158.5" cy="73.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><text x="154.0" y="100" text-anchor="middle" font-weight="600" font-size="12">N = 1</text><text x="154.0" y="118" text-anchor="middle" fill="#4a8fe0" font-size="12">4 ch</text><circle cx="225.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="234.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="243.5" cy="64.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="225.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="234.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="243.5" cy="73.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="225.5" cy="82.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="234.5" cy="82.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="243.5" cy="82.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><text x="234.5" y="109" text-anchor="middle" font-weight="600" font-size="12">N = 2</text><text x="234.5" y="127" text-anchor="middle" fill="#4a8fe0" font-size="12">9 ch</text><circle cx="310.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="319.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="328.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="337.5" cy="64.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="310.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="319.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="328.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="337.5" cy="73.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="310.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="319.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="328.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="337.5" cy="82.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="310.5" cy="91.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="319.5" cy="91.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="328.5" cy="91.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="337.5" cy="91.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><text x="324.0" y="118" text-anchor="middle" font-weight="600" font-size="12">N = 3</text><text x="324.0" y="136" text-anchor="middle" fill="#3fa968" font-size="12">16 ch</text><circle cx="404.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="413.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="422.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="431.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="440.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="449.5" cy="64.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="404.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="413.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="422.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="431.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="440.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="449.5" cy="73.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="404.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="413.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="422.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="431.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="440.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="449.5" cy="82.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="404.5" cy="91.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="413.5" cy="91.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="422.5" cy="91.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="431.5" cy="91.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="440.5" cy="91.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="449.5" cy="91.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="404.5" cy="100.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="413.5" cy="100.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="422.5" cy="100.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="431.5" cy="100.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="440.5" cy="100.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="449.5" cy="100.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="404.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="413.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="422.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="431.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="440.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="449.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><text x="427.0" y="136" text-anchor="middle" font-weight="600" font-size="12">N = 5</text><text x="427.0" y="154" text-anchor="middle" fill="#d9a441" font-size="12">36 ch</text><circle cx="516.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="64.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="72.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="80.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="88.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="96.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="104.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="112.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="524.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="532.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="540.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="548.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="556.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="564.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="572.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="544.0" y="146" text-anchor="middle" font-weight="600" font-size="12">N = 7</text><text x="544.0" y="164" text-anchor="middle" fill="#d9534f" font-size="12">64 ch</text><text x="360" y="26" text-anchor="middle" font-weight="600" font-size="15">(N + 1)²</text><text x="360" y="44" text-anchor="middle" font-size="11">each step adds an L-shaped layer of new channels</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Dots are channels. The coloured L is what a higher order adds: 4, 9, 16, 36, 64 channels for orders 1, 2, 3, 5 and 7.</figcaption>
</figure>














The number of channels in the B-format master follows from the chosen order:

**(N + 1)² = channel count**

| Order | Channels | New channels |
|---|---|---|
| 1st order (FOA) | **4** | 4 |
| 2nd order | **9** | 5 |
| 3rd order | **16** | 7 |
| 4th order | **25** | 9 |
| 5th order | **36** | 11 |
| 7th order | **64** | 15 |

A higher order means more channels, more spherical information, finer spatial resolution – and more computing effort.

---

## What changes with the order

<figure class="explainer-video" style="margin:1.8rem 0">
<video controls muted loop playsinline preload="metadata" style="width:100%;max-width:720px;height:auto;display:block;border-radius:8px" src="/videos/hoa-order-en.mp4"></video>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Short video: the same source at HOA1, HOA3 and HOA7. A higher order sharpens the direction (schematic pattern).</figcaption>
</figure>

### Spatial resolution

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 315" role="img" aria-label="Point source pattern at different orders" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><circle cx="300" cy="160" r="57.5" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="2 4"/><circle cx="300" cy="160" r="115" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="2 4"/><line x1="300" y1="37" x2="300" y2="283" stroke="currentColor" stroke-width="1" opacity="0.3"/><line x1="177" y1="160" x2="423" y2="160" stroke="currentColor" stroke-width="1" opacity="0.3"/><polyline points="300.0,45.0 304.0,45.1 308.0,45.5 312.0,46.0 315.9,46.8 319.8,47.8 323.6,49.1 327.3,50.5 330.9,52.2 334.4,54.0 337.8,56.1 341.1,58.3 344.2,60.7 347.2,63.3 350.0,66.0 352.6,68.9 355.1,71.9 357.3,75.0 359.4,78.2 361.3,81.5 363.0,84.9 364.4,88.4 365.7,92.0 366.7,95.6 367.6,99.2 368.2,102.8 368.6,106.4 368.8,110.0 368.7,113.6 368.5,117.2 368.1,120.7 367.4,124.1 366.6,127.5 365.6,130.8 364.4,134.0 363.1,137.0 361.5,140.0 359.9,142.8 358.1,145.5 356.1,148.1 354.0,150.5 351.8,152.7 349.6,154.8 347.2,156.7 344.7,158.4 342.2,160.0 339.7,161.4 337.1,162.6 334.4,163.6 331.8,164.5 329.1,165.1 326.5,165.6 323.9,166.0 321.3,166.1 318.8,166.1 316.3,165.9 313.9,165.6 311.5,165.1 309.3,164.5 307.1,163.8 305.1,162.9 303.1,161.9 301.3,160.9 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 298.7,160.9 296.9,161.9 294.9,162.9 292.9,163.8 290.7,164.5 288.5,165.1 286.1,165.6 283.7,165.9 281.2,166.1 278.7,166.1 276.1,166.0 273.5,165.6 270.9,165.1 268.2,164.5 265.6,163.6 262.9,162.6 260.3,161.4 257.8,160.0 255.3,158.4 252.8,156.7 250.4,154.8 248.2,152.7 246.0,150.5 243.9,148.1 241.9,145.5 240.1,142.8 238.5,140.0 236.9,137.0 235.6,134.0 234.4,130.8 233.4,127.5 232.6,124.1 231.9,120.7 231.5,117.2 231.3,113.6 231.2,110.0 231.4,106.4 231.8,102.8 232.4,99.2 233.3,95.6 234.3,92.0 235.6,88.4 237.0,84.9 238.7,81.5 240.6,78.2 242.7,75.0 244.9,71.9 247.4,68.9 250.0,66.0 252.8,63.3 255.8,60.7 258.9,58.3 262.2,56.1 265.6,54.0 269.1,52.2 272.7,50.5 276.4,49.1 280.2,47.8 284.1,46.8 288.0,46.0 292.0,45.5 296.0,45.1 300.0,45.0" fill="none" stroke="#d9534f" stroke-width="2.2"/><polyline points="300.0,45.0 304.0,45.3 308.0,46.1 311.8,47.4 315.6,49.2 319.1,51.5 322.5,54.3 325.6,57.5 328.4,61.0 330.9,65.0 333.0,69.3 334.8,73.8 336.3,78.5 337.3,83.5 338.0,88.5 338.3,93.7 338.2,98.9 337.8,104.0 337.0,109.1 335.9,114.1 334.5,118.9 332.8,123.6 330.8,128.1 328.7,132.3 326.4,136.2 324.0,139.9 321.5,143.2 318.9,146.3 316.2,149.0 313.7,151.5 311.1,153.6 308.6,155.4 306.3,156.9 304.1,158.2 302.0,159.2 300.1,159.9 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.8,160.3 301.4,160.6 302.0,161.0 302.5,161.3 302.9,161.7 303.2,162.0 303.4,162.3 303.5,162.6 303.5,162.8 303.5,162.9 303.3,163.0 303.1,163.0 302.8,162.9 302.4,162.7 302.0,162.4 301.6,162.0 301.2,161.6 300.7,161.1 300.3,160.5 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 299.7,160.5 299.3,161.1 298.8,161.6 298.4,162.0 298.0,162.4 297.6,162.7 297.2,162.9 296.9,163.0 296.7,163.0 296.5,162.9 296.5,162.8 296.5,162.6 296.6,162.3 296.8,162.0 297.1,161.7 297.5,161.3 298.0,161.0 298.6,160.6 299.2,160.3 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 299.9,159.9 298.0,159.2 295.9,158.2 293.7,156.9 291.4,155.4 288.9,153.6 286.3,151.5 283.8,149.0 281.1,146.3 278.5,143.2 276.0,139.9 273.6,136.2 271.3,132.3 269.2,128.1 267.2,123.6 265.5,118.9 264.1,114.1 263.0,109.1 262.2,104.0 261.8,98.9 261.7,93.7 262.0,88.5 262.7,83.5 263.7,78.5 265.2,73.8 267.0,69.3 269.1,65.0 271.6,61.0 274.4,57.5 277.5,54.3 280.9,51.5 284.4,49.2 288.2,47.4 292.0,46.1 296.0,45.3 300.0,45.0" fill="none" stroke="#d9a441" stroke-width="2.2"/><polyline points="300.0,45.0 304.0,45.8 307.8,48.3 311.3,52.3 314.4,57.7 316.9,64.3 318.7,71.9 319.9,80.3 320.3,89.2 320.0,98.4 319.1,107.5 317.6,116.4 315.6,124.9 313.3,132.6 310.8,139.7 308.2,145.8 305.7,151.0 303.3,155.2 301.1,158.5 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.6,159.6 301.2,159.3 301.7,159.2 302.0,159.1 302.0,159.2 301.9,159.3 301.7,159.5 301.3,159.6 300.8,159.8 300.3,159.9 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.2,160.0 300.5,160.1 300.7,160.2 300.9,160.3 300.9,160.3 300.9,160.4 300.8,160.4 300.6,160.3 300.4,160.2 300.2,160.1 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.1,160.1 300.2,160.4 300.3,160.6 300.4,160.7 300.5,160.9 300.4,160.9 300.4,160.9 300.3,160.8 300.2,160.6 300.1,160.3 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 299.9,160.3 299.8,160.6 299.7,160.8 299.6,160.9 299.6,160.9 299.5,160.9 299.6,160.7 299.7,160.6 299.8,160.4 299.9,160.1 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 299.8,160.1 299.6,160.2 299.4,160.3 299.2,160.4 299.1,160.4 299.1,160.3 299.1,160.3 299.3,160.2 299.5,160.1 299.8,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 299.7,159.9 299.2,159.8 298.7,159.6 298.3,159.5 298.1,159.3 298.0,159.2 298.0,159.1 298.3,159.2 298.8,159.3 299.4,159.6 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 298.9,158.5 296.7,155.2 294.3,151.0 291.8,145.8 289.2,139.7 286.7,132.6 284.4,124.9 282.4,116.4 280.9,107.5 280.0,98.4 279.7,89.2 280.1,80.3 281.3,71.9 283.1,64.3 285.6,57.7 288.7,52.3 292.2,48.3 296.0,45.8 300.0,45.0" fill="none" stroke="#3fa968" stroke-width="2.2"/><text x="300" y="31" text-anchor="middle" font-size="11">source direction</text><line x1="520" y1="120" x2="550" y2="120" stroke="#d9534f" stroke-width="3" opacity="1"/><text x="560" y="124" text-anchor="start" font-size="12">FOA (N=1)</text><line x1="520" y1="148" x2="550" y2="148" stroke="#d9a441" stroke-width="3" opacity="1"/><text x="560" y="152" text-anchor="start" font-size="12">HOA3</text><line x1="520" y1="176" x2="550" y2="176" stroke="#3fa968" stroke-width="3" opacity="1"/><text x="560" y="180" text-anchor="start" font-size="12">HOA7</text><text x="520" y="100" text-anchor="start" font-weight="600" font-size="11">same source, three orders</text><text x="360" y="308" text-anchor="middle" font-size="11">Maximum-rE weighting, polar view; schematic, not a measurement.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Higher order concentrates the source in a narrower lobe. FOA is broad and soft, HOA7 is sharp.</figcaption>
</figure>














As the order rises, sound sources become sharper to localise. At 1st order a point source sounds slightly diffuse – a loudspeaker in a cluster is hard to tell from its neighbours. At 3rd order localisation is convincing for most listening situations. At 7th order the resolution approaches what the human ear can resolve under ideal conditions.

A simple picture: order behaves much like the resolution of a photo. FOA is 480p – recognisable but soft. HOA3 is 1080p – good for almost every purpose. HOA7 is 4K – you need a very good playback system to hear the difference.

### Sweet spot size

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Accurate listening area at 1 kHz" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><circle cx="250" cy="150" r="114.66000000000003" fill="none" stroke="#3fa968" stroke-width="2"/><text x="335.07608600000003" y="72.92391399999998" text-anchor="start" fill="#3fa968" font-size="11">N=7</text><circle cx="250" cy="150" r="81.9" fill="none" stroke="#d9a441" stroke-width="2"/><text x="311.91149" y="96.08851" text-anchor="start" fill="#d9a441" font-size="11">N=5</text><circle cx="250" cy="150" r="49.14" fill="none" stroke="#4a8fe0" stroke-width="2"/><text x="288.746894" y="119.253106" text-anchor="start" fill="#4a8fe0" font-size="11">N=3</text><circle cx="250" cy="150" r="16.38" fill="none" stroke="#d9534f" stroke-width="2"/><text x="236" y="182.38" text-anchor="middle" fill="#d9534f" font-size="11">N=1</text><circle cx="250" cy="150" r="26.099999999999998" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="2 3"/><text x="250" y="154" text-anchor="middle" font-size="10">head</text><text x="560" y="92" text-anchor="middle" font-weight="600">Accurate area at 1 kHz</text><circle cx="480" cy="128" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="496" y="133" text-anchor="start" font-size="13">N=1: r ≈ 5 cm</text><circle cx="480" cy="158" r="6" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><text x="496" y="163" text-anchor="start" font-size="13">N=3: r ≈ 16 cm</text><circle cx="480" cy="188" r="6" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><text x="496" y="193" text-anchor="start" font-size="13">N=5: r ≈ 27 cm</text><circle cx="480" cy="218" r="6" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><text x="496" y="223" text-anchor="start" font-size="13">N=7: r ≈ 38 cm</text><text x="480" y="262" text-anchor="start" font-size="11">Rule of thumb r ≈ N·c / (2π·f)</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">The area in which the sound field is reproduced correctly grows with the order. At FOA it is smaller than a head, at HOA3 it suffices for one listener, at HOA7 for a small group.</figcaption>
</figure>














The sweet spot is the area in which the sound field is reproduced correctly. It grows with the order. With FOA it is hardly larger than a head at mid and high frequencies. With HOA3 it suffices for a small group of listeners. For large rooms and many people, HOA5 or HOA7 become relevant.

In practice: if you work for studio production and headphones, you hardly notice the sweet-spot difference. If you produce for a large concert system, the difference between HOA3 and HOA7 becomes audible depending on repertoire and hall.

### Minimum number of loudspeakers

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Loudspeaker count versus usable order" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar4" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><line x1="40" y1="120" x2="680" y2="120" stroke="currentColor" stroke-width="2" opacity="1"/><line x1="80.0" y1="112" x2="80.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="80.0" y="146" text-anchor="middle" font-size="11">4</text><text x="80.0" y="162" text-anchor="middle" font-size="10.5">N=1</text><line x1="130.0" y1="112" x2="130.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="130.0" y="146" text-anchor="middle" font-size="11">9</text><text x="130.0" y="162" text-anchor="middle" font-size="10.5">N=2</text><line x1="200.0" y1="112" x2="200.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="200.0" y="146" text-anchor="middle" font-size="11">16</text><text x="200.0" y="162" text-anchor="middle" font-size="10.5">N=3</text><line x1="290.0" y1="112" x2="290.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="290.0" y="146" text-anchor="middle" font-size="11">25</text><text x="290.0" y="162" text-anchor="middle" font-size="10.5">N=4</text><line x1="400.0" y1="112" x2="400.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="400.0" y="146" text-anchor="middle" font-size="11">36</text><text x="400.0" y="162" text-anchor="middle" font-size="10.5">N=5</text><line x1="530.0" y1="112" x2="530.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="530.0" y="146" text-anchor="middle" font-size="11">49</text><text x="530.0" y="162" text-anchor="middle" font-size="10.5">N=6</text><line x1="680.0" y1="112" x2="680.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="680.0" y="146" text-anchor="middle" font-size="11">64</text><text x="680.0" y="162" text-anchor="middle" font-size="10.5">N=7</text><line x1="120.0" y1="100" x2="120.0" y2="62" stroke="#d9534f" stroke-width="2.5" opacity="1"/><circle cx="120.0" cy="60" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="120.0" y="44" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="11">Octagon (8)</text><line x1="200.0" y1="100" x2="200.0" y2="42" stroke="#4a8fe0" stroke-width="2.5" opacity="1"/><circle cx="200.0" cy="40" r="6" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><text x="200.0" y="24" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="11">16 speakers</text><line x1="220.0" y1="100" x2="220.0" y2="62" stroke="#3fa968" stroke-width="2.5" opacity="1"/><circle cx="220.0" cy="60" r="6" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><text x="220.0" y="44" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="11">ICST Studio (18)</text><line x1="680.0" y1="100" x2="680.0" y2="42" stroke="#d9a441" stroke-width="2.5" opacity="1"/><circle cx="680.0" cy="40" r="6" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><text x="674.0" y="24" text-anchor="end" font-weight="600" fill="#d9a441" font-size="11">Dome (64)</text><text x="360" y="200" text-anchor="middle" font-size="12">Loudspeakers → usable order is the highest N with (N+1)² ≤ loudspeakers</text><text x="360" y="225" text-anchor="middle" font-size="11">Orders above that are calculated but not reproduced in full.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Marks show the minimum loudspeaker count for each order. An 8-loudspeaker ring tops out at FOA, the 18-speaker studio at 3rd order.</figcaption>
</figure>














The loudspeaker system sets the practical ceiling of the usable order. The rule of thumb:

> **At least (N+1)² loudspeakers for order N**

| Order | Minimum loudspeakers |
|---|---|
| 1st | 4 |
| 2nd | 9 |
| 3rd | 16 |
| 5th | 36 |
| 7th | 64 |

On a system with 8 loudspeakers HOA3 makes little sense – the system cannot fully reproduce the 16-channel information. The decoder still calculates, but the spatial resolution is capped by the loudspeakers. The **ICST Composition Studio at ZHdK** has 18 loudspeakers – HOA3 is well used there; higher orders are no longer fully reproduced.

> **Important:** In REAPER and the ICST plugins you can use any order, however many loudspeakers you have. The system calculates correctly. But the sound quality is set by the weakest link – the monitoring system.

---

## A practical decision aid

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 215" role="img" aria-label="Which order for which use" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar5" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="20" width="210" height="175" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="120" y="50" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="15">FOA (1st)</text><text x="29" y="86" text-anchor="start" font-size="12">• Binaural-only / streaming</text><text x="29" y="116" text-anchor="start" font-size="12">• Sketches and concepts</text><text x="29" y="146" text-anchor="start" font-size="12">• Small system (4–8 spk)</text><text x="29" y="176" text-anchor="start" font-size="12">• Microphone recordings (FOA)</text><text x="29" y="206" text-anchor="start" font-size="12">• Weak laptop, live</text><rect x="255" y="20" width="210" height="175" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="360" y="50" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="15">HOA3</text><text x="269" y="86" text-anchor="start" font-size="12">• Standard for most work</text><text x="269" y="116" text-anchor="start" font-size="12">• 16+ loudspeakers</text><text x="269" y="146" text-anchor="start" font-size="12">• High-quality binaural</text><text x="269" y="176" text-anchor="start" font-size="12">• Zylia ZM-1 recordings</text><text x="269" y="206" text-anchor="start" font-size="12">• Platform export (VR/360°)</text><rect x="495" y="20" width="210" height="175" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="600" y="50" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="15">HOA5 / HOA7</text><text x="509" y="86" text-anchor="start" font-size="12">• 40+ loudspeakers, domes</text><text x="509" y="116" text-anchor="start" font-size="12">• Archive / master files</text><text x="509" y="146" text-anchor="start" font-size="12">• Dense 3D height rendering</text><text x="509" y="176" text-anchor="start" font-size="12">• Research, high precision</text><text x="509" y="206" text-anchor="start" font-size="12">• Freeze with many sources</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Three typical situations. Working rule: as high as the CPU allows (HOA7); HOA3 is the fallback.</figcaption>
</figure>














### When is FOA (1st order) enough?

- Binaural-only production for headphones or streaming
- Compositional sketches or concept work without a final loudspeaker system
- Real-time performance on a small system (4–8 loudspeakers, e.g. an octagon)
- Ambisonics microphone recordings (Ambeo, NT-SF1 – these deliver FOA only)
- Resource-limited live situations (older laptop, unstable machine)

### When is HOA3 the right choice?

HOA3 is the **practical fallback** when the CPU or the plugin chain does not allow HOA7, and the usual target for delivery:

- Professional composition for a multi-loudspeaker system from about 16 loudspeakers
- High-quality binaural rendering (the IEM BinauralDecoder makes full use of HOA3)
- Mixing encoder sources and microphone recordings (the Zylia ZM-1 delivers HOA3)
- Export for platforms such as YouTube 360° or VR (most platforms accept HOA3 at most)
- Studio production on a modern computer without a specific need for HOA7

### When do you need HOA5 or HOA7?

- Large concert halls with 40+ loudspeakers (e.g. dome installations, IMAX-like systems)
- Archives and master files designed for future, higher-order systems
- Special height rendering in dense 3D arrays
- Academic or research contexts with precision requirements

### Binaural: how much order sounds better?

For binaural headphone monitoring, the perceptible jump in quality lies between FOA and HOA3 – clearly. Between HOA3 and HOA7 the difference in binaural rendering is measurable but perceptually less dramatic. From HOA3 up, binaural is high-resolution enough for most purposes.

---

## CPU load in REAPER

| Order | Channels | Relative CPU | In practice |
|---|---|---|---|
| FOA | 4 | very low | no problem even on older systems |
| HOA3 | 16 | moderate | standard on a modern computer, no problem |
| HOA5 | 36 | noticeable | large sessions require a freeze strategy |
| HOA7 | 64 | high | with many sources: freeze or render to file |

In REAPER: if HOA7 tracks need to be frozen, use the *Freeze* function (right-click the track → Freeze). The frozen track is stored internally as a fully calculated multichannel file and no longer causes encoder CPU load – only bus routing remains.

---

## Changing the order during production

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 190" role="img" aria-label="Changing the order of a running session" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar6" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="50" width="150" height="64" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="90.0" y="80.0" text-anchor="middle" font-weight="600">1. Bus channels</text><text x="90.0" y="97.0" text-anchor="middle" font-size="10.5">Track Channels</text><line x1="165" y1="82" x2="190" y2="82" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#ar6)"/><rect x="190" y="50" width="150" height="64" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="265.0" y="80.0" text-anchor="middle" font-weight="600">2. Encoders</text><text x="265.0" y="97.0" text-anchor="middle" font-size="10.5">order parameter</text><line x1="340" y1="82" x2="365" y2="82" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#ar6)"/><rect x="365" y="50" width="150" height="64" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="440.0" y="80.0" text-anchor="middle" font-weight="600">3. Decoder</text><text x="440.0" y="97.0" text-anchor="middle" font-size="10.5">new order</text><line x1="515" y1="82" x2="540" y2="82" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#ar6)"/><rect x="540" y="50" width="150" height="64" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="615.0" y="80.0" text-anchor="middle" font-weight="600">4. Binaural</text><text x="615.0" y="97.0" text-anchor="middle" font-size="10.5">adapts itself</text><text x="360" y="24" text-anchor="middle" font-weight="600">Four places that must follow</text><text x="360" y="160" text-anchor="middle" font-size="11">Fixing the order before production and saving a template avoids all four steps.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Changing the order later means touching bus, encoders and decoder. The IEM BinauralDecoder follows the channel count.</figcaption>
</figure>














Start in HOA7 right away if your computer allows it – a later reduction is easy, a later increase is not. If you still need to change the order of a running session, it requires adjustments:

1. **Adjust the channel count of the B-format bus** (right-click → Track Channels)
2. **Set all AmbiEncoders** to the new order (order parameter in the plugin)
3. **Set the ICST AmbiDecoder** to the new order
4. **The BinauralDecoder** adapts automatically (IEM detects the channel count)

The easiest way: fix the order (ideally HOA7) before starting the production and build a REAPER template on that order. The ICST download pack contains prepared templates.

---

## Recommendation for the ICST workflow

**Working rule:** produce in **HOA7** for as long as your computer's CPU copes with it. A higher-order master can always be reduced to HOA3 or FOA for a specific system, platform or headphones; a lower-order session can never be upgraded afterwards. If HOA7 becomes too heavy (many sources, many effects), drop to HOA5 or HOA3, or freeze tracks.

If you produce at the **ICST Composition Studio** (18 loudspeakers): work in **HOA7** and decode for the room. The loudspeakers reproduce about HOA3 in full, the rest is headroom for other systems and for the archive.

If you produce for **headphones and binaural**: also **HOA7** if the CPU allows; **HOA3** is the sensible fallback (the audible jump is mainly FOA → HOA3).

If you build **your first own session**: start with **FOA or HOA3** – the concepts are the same, and getting started is easier. Move to HOA7 once the workflow is familiar.

---

## Sources and context

What on this page is documented and what is experience:

- **Channel count (N+1)² and minimum number of loudspeakers:** a standard result of Ambisonics theory, see Zotter & Frank, *Ambisonics: A Practical 3D Audio Theory for Recording, Studio Production, Sound Reinforcement, and Virtual Reality* (Springer, 2019, open access).
- **The sweet spot grows with order and shrinks with frequency:** Ward & Abhayapala, *Reproduction of a plane-wave sound field using an array of loudspeakers*, IEEE Transactions on Speech and Audio Processing 9(6), 2001, pp. 697–707 ([DOI](https://doi.org/10.1109/89.943347)). The paper derives the relationship between the number of loudspeakers, the size of the reproduction zone, the frequency range and the accuracy. The head, person and group sizes in the graphics are an illustration, not a measurement.
- **Localisation with FOA and HOA:** Bertet, Daniel, Parizet & Warusfel, *Investigation on localisation accuracy for first and higher order ambisonics reproduced sound sources*, Acta Acustica united with Acustica 99(4), 2013, pp. 642–657.
- **Not from controlled studies:** the image-resolution comparison (480p, 1080p, 4K) is an analogy. The statements about HOA3 as a fallback and the recommendations for the ICST Composition Studio are based on studio experience. The CPU-load table is a qualitative estimate, not a measurement on a specific computer.

---

## Further reading

- [Coordinate systems: XYZ and AED compared](/post/xyz-vs-aed-koordinatensysteme/)
- [ICST AmbiDecoder – scaling and delay compensation](/post/decoder-skalierung-laufzeitkompensation/)
- [Binaural monitoring in the ICST workflow](/post/binaural-monitoring-icst-workflow/)
- [Exporting the B-format master](/post/b-format-export-reaper/)
- [Recording with an Ambisonics microphone – A-format, B-format and ICST integration](/post/ambisonics-mikrofon-a-format-b-format/)

