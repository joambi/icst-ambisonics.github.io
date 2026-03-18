---
title: "The History of Ambisonics: FOA and HOA as a Visual Timeline"
description: "A visual timeline tracing the development of First-Order Ambisonics and Higher-Order Ambisonics from the 1970s to the present."
date: 2026-03-15T10:30:00+01:00
draft: false
tags: ["ambisonics", "foa", "hoa", "history", "timeline"]
aliases:
  - /blog/ambisonics-timeline/
---

<div class="ambisonics-history">

<p class="ambisonics-history__lead">
This timeline separates the development of <strong>FOA</strong> and <strong>HOA</strong> while also showing their shared milestones. The picture that emerges: FOA is the historical foundation of Ambisonics; HOA arrives later as a systematic extension for higher spatial resolution.
</p>

<div class="ambisonics-history__legend">
  <span class="ambisonics-history__legend-item"><span class="ambisonics-history__dot ambisonics-history__dot--foa"></span>FOA line</span>
  <span class="ambisonics-history__legend-item"><span class="ambisonics-history__dot ambisonics-history__dot--hoa"></span>HOA line</span>
  <span class="ambisonics-history__legend-item"><span class="ambisonics-history__dot ambisonics-history__dot--shared"></span>Shared standards and media practice</span>
</div>

<div class="ambisonics-history__card">

```mermaid
flowchart TB
    classDef foa fill:#d9f3f4,stroke:#00838f,color:#0d2a2d,stroke-width:1.6px;
    classDef hoa fill:#ffe7d1,stroke:#ef6c00,color:#432100,stroke-width:1.6px;
    classDef shared fill:#eceff1,stroke:#455a64,color:#1f2a30,stroke-width:1.4px;

    A["1970s<br/>Gerzon and Fellgett develop the foundations of Ambisonics"]:::shared

    subgraph FOA["FOA: First-Order Ambisonics"]
      direction TB
      F1["1973<br/>Periphony: With-Height Sound Reproduction"]:::foa
      F2["1975<br/>The term Ambisonics becomes established"]:::foa
      F3["Late 1970s<br/>UHJ makes Ambisonics stereo-compatible"]:::foa
      F4["1980s<br/>FOA enters practical use in recording, broadcasting, and UHJ releases"]:::foa
      F5["1990s<br/>FOA remains the dominant practical form and teaching basis"]:::foa
      F6["2010s–present<br/>FOA remains the accessible entry point for 360 audio and production"]:::foa
    end

    subgraph HOA["HOA: Higher-Order Ambisonics"]
      direction TB
      H1["2000/2001<br/>Jérôme Daniel establishes the modern theoretical basis for HOA"]:::hoa
      H2["2003<br/>Near-field and distance coding extend HOA"]:::hoa
      H3["2005<br/>Poletti grounds HOA in spherical harmonics"]:::hoa
      H4["2006–2009<br/>Microphone arrays, symposia, and research make HOA practical"]:::hoa
      H5["2011<br/>ambiX unifies channel ordering and normalisation"]:::hoa
      H6["2010s–present<br/>HOA becomes a key technology for VR, XR, and scene-based audio"]:::hoa
    end

    S1["2011<br/>File and interchange formats become critical for HOA workflows"]:::shared
    S2["2018<br/>RFC 8486 standardises Ambisonics in Ogg Opus"]:::shared
    S3["Today<br/>FOA and HOA coexist as practical and scalable formats"]:::shared

    A --> F1 --> F2 --> F3 --> F4 --> F5 --> F6
    A --> H1 --> H2 --> H3 --> H4 --> H5 --> H6
    F5 --> S1 --> S2 --> S3
    H4 --> S1
```

</div>

<div class="ambisonics-history__notes">
  <section class="ambisonics-history__note">
    <h3>FOA</h3>
    <p>FOA is the historical core of Ambisonics. It is compact, robust, and still the stronger choice wherever straightforward production, distribution, and compatibility matter more than maximum directional resolution.</p>
  </section>
  <section class="ambisonics-history__note">
    <h3>HOA</h3>
    <p>HOA builds on the same foundations but extends them systematically. Higher order brings greater directional resolution, more flexible rendering, and increasing relevance for immersive media and research.</p>
  </section>
</div>

</div>

## How to read the diagram

- **FOA** refers to the first order of Ambisonics and was the form in which the technique first reached widespread practical use.
- **HOA** becomes visible as a distinct modern field of research and production from around 2000 onwards.
- The **shared axis** shows that formats, standards, and today's media practice do not pit FOA against HOA — both coexist within the same ecosystems.

## Why this distinction matters

Representing the history of Ambisonics as a single unbroken line makes it easy to miss that there is a clear methodological leap between the early FOA work of the 1970s and the systematic development of HOA around the year 2000. FOA is not "outdated" — it is often the pragmatic choice. HOA is not simply "more channels" — it represents a different order of scenic precision and rendering flexibility.

## Sources and references

- Michael Gerzon, *Periphony: With-Height Sound Reproduction* (JAES, 1973)
- Michael Gerzon, *Practical Periphony* (1980)
- Jérôme Daniel, dissertation on the foundations of HOA (2000/2001)
- Mark Poletti, work on 3D surround systems based on spherical harmonics (2005)
- Ambisonics Symposium 2011, *ambiX — A Suggested Ambisonics Format*
- [RFC 8486: Ambisonics in an Ogg Opus Container](https://www.rfc-editor.org/info/rfc8486)
