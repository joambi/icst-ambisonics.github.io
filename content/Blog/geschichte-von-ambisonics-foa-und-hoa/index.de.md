---
title: "Die Geschichte von Ambisonics: FOA und HOA als grafische Timeline"
description: "Eine visuelle Zeitleiste zur Entwicklung von First-Order Ambisonics und Higher-Order Ambisonics von den 1970ern bis heute."
date: 2026-03-15T10:30:00+01:00
draft: false
tags: ["ambisonics", "foa", "hoa", "geschichte", "timeline"]
aliases:
  - /de/blog/ambisonics-timeline/
---

<div class="ambisonics-history">

<p class="ambisonics-history__lead">
Diese Timeline trennt die Entwicklung von <strong>FOA</strong> und <strong>HOA</strong>, zeigt aber auch die gemeinsamen Meilensteine. So wird sichtbar: FOA ist die historische Basis von Ambisonics, HOA entsteht spaeter als systematische Erweiterung fuer hoehere raeumliche Aufloesung.
</p>

<div class="ambisonics-history__legend">
  <span class="ambisonics-history__legend-item"><span class="ambisonics-history__dot ambisonics-history__dot--foa"></span>FOA-Linie</span>
  <span class="ambisonics-history__legend-item"><span class="ambisonics-history__dot ambisonics-history__dot--hoa"></span>HOA-Linie</span>
  <span class="ambisonics-history__legend-item"><span class="ambisonics-history__dot ambisonics-history__dot--shared"></span>Gemeinsame Standards und Medienpraxis</span>
</div>

<div class="ambisonics-history__card">

```mermaid
flowchart TB
    classDef foa fill:#d9f3f4,stroke:#00838f,color:#0d2a2d,stroke-width:1.6px;
    classDef hoa fill:#ffe7d1,stroke:#ef6c00,color:#432100,stroke-width:1.6px;
    classDef shared fill:#eceff1,stroke:#455a64,color:#1f2a30,stroke-width:1.4px;

    A["1970er<br/>Gerzon und Fellgett entwickeln die Grundlagen von Ambisonics"]:::shared

    subgraph FOA["FOA: First-Order Ambisonics"]
      direction TB
      F1["1973<br/>Periphony: With-Height Sound Reproduction"]:::foa
      F2["1975<br/>Der Begriff Ambisonics etabliert sich"]:::foa
      F3["spaete 1970er<br/>UHJ macht Ambisonics stereo-kompatibel"]:::foa
      F4["1980er<br/>FOA wird in Aufnahme, Rundfunk und UHJ-Releases praktisch genutzt"]:::foa
      F5["1990er<br/>FOA bleibt die dominante Praxisform und Lehrbasis"]:::foa
      F6["2010er-heute<br/>FOA bleibt der einfache Einstieg fuer 360-Audio und Produktion"]:::foa
    end

    subgraph HOA["HOA: Higher-Order Ambisonics"]
      direction TB
      H1["2000/2001<br/>Jerome Daniel formuliert die moderne HOA-Grundlage"]:::hoa
      H2["2003<br/>Near-Field- und Distance-Coding erweitern HOA"]:::hoa
      H3["2005<br/>Poletti etabliert HOA ueber sphaerische Harmonische"]:::hoa
      H4["2006-2009<br/>Mikrofonarrays, Symposien und Forschung machen HOA praktikabel"]:::hoa
      H5["2011<br/>ambiX vereinheitlicht Ordering und Normalisierung"]:::hoa
      H6["2010er-heute<br/>HOA wird Schluesseltechnologie fuer VR, XR und scene-based audio"]:::hoa
    end

    S1["2011<br/>Datei- und Austauschformate werden fuer HOA-Workflows entscheidend"]:::shared
    S2["2018<br/>RFC 8486 standardisiert Ambisonics in Ogg Opus"]:::shared
    S3["heute<br/>FOA und HOA koexistieren als praktische und skalierbare Formate"]:::shared

    A --> F1 --> F2 --> F3 --> F4 --> F5 --> F6
    A --> H1 --> H2 --> H3 --> H4 --> H5 --> H6
    F5 --> S1 --> S2 --> S3
    H4 --> S1
```

</div>

<div class="ambisonics-history__notes">
  <section class="ambisonics-history__note">
    <h3>FOA</h3>
    <p>FOA ist der historische Kern von Ambisonics. Es ist kompakt, robust und bis heute dort stark, wo einfache Produktion, Distribution und Kompatibilitaet wichtiger sind als maximale Richtungsaufloesung.</p>
  </section>
  <section class="ambisonics-history__note">
    <h3>HOA</h3>
    <p>HOA baut auf denselben Grundlagen auf, erweitert sie aber systematisch. Mit hoeherer Ordnung wachsen Richtungsauflosung, Flexibilitaet im Rendering und Relevanz fuer immersive Medien und Forschung.</p>
  </section>
</div>

</div>

## Lesart der Grafik

- **FOA** bezeichnet die erste Ordnung von Ambisonics und war die Form, in der das Verfahren historisch zuerst praktisch verbreitet wurde.
- **HOA** wird ab etwa 2000 als eigenes modernes Forschungs- und Produktionsfeld sichtbar.
- Die **gemeinsame Achse** zeigt, dass Formate, Standards und heutige Medienpraxis FOA und HOA nicht gegeneinander ausspielen, sondern beide in denselben Oekosystemen vorkommen.

## Warum diese Unterscheidung wichtig ist

Wer die Geschichte von Ambisonics nur als eine einzige Linie darstellt, uebersieht leicht, dass zwischen den fruehen FOA-Arbeiten der 1970er Jahre und der systematischen HOA-Entwicklung rund um 2000 ein deutlicher methodischer Sprung liegt. FOA ist nicht "veraltet", sondern oft die pragmatische Wahl. HOA ist nicht einfach "mehr Kanaele", sondern eine andere Groessenordnung an szenischer Praezision und Render-Flexibilitaet.

## Quellen und Referenzen

- Michael Gerzon, *Periphony: With-Height Sound Reproduction* (JAES, 1973)
- Michael Gerzon, *Practical Periphony* (1980)
- Jerome Daniel, Dissertation zu HOA-Grundlagen (2000/2001)
- Mark Poletti, Arbeiten zu 3D-Surround-Systemen auf Basis sphaerischer Harmonischer (2005)
- Ambisonics Symposium 2011, *ambiX - A Suggested Ambisonics Format*
- [RFC 8486: Ambisonics in an Ogg Opus Container](https://www.rfc-editor.org/info/rfc8486)
