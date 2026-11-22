---
title: Blauertsche Bänder
description: "Zeigt, wie Blauerts Bänder per OSC zum IEM MultiEQ geleitet werden und welche Schritte nötig sind, um Front/Back- und Höhenbänder zu formen."
date: 2025-05-16
slug: blauerts-bands
aliases:
  - /de/post/blauertsche_bänder/
year: 2025
month: 2025-05
weight: 10
tags: ["perception", "psychoacoustics", "binaural", "theory"]
key_points:
  - "Verstehen, wie Blauertsche Bänder Höhen- und Richtungswahrnehmung beeinflussen"
  - "IEM-MultiEQ-Filtersetzung für Elevations- und Front/Back-Korrektur anwenden"
difficulty: "intermediate"
post_kind: "background"
---

<style>
/* ── Blauert's Bands — Anatole theme aligned ── */

.info-box {
  border-left: 3px solid #6086b4;  /* info */
  border-radius: 0 2px 2px 0;
  padding: 0.9rem 1.2rem;
  margin: 1.2rem 0;
  font-size: 1.4rem;
}
.theme--light .info-box { background: #eeeeee; color: #464646; }
.theme--dark  .info-box { background: #2a3a44; color: #eeeeee; }
.info-box strong { display: block; margin-bottom: 0.3rem; color: #6086b4; }

/* Code/OSC block — stays dark in both modes (terminal style) */
.osc-block {
  background: #1e1e1e;
  color: #d4d4d4;
  border-radius: 2px;
  padding: 0.8rem 1.1rem;
  font-family: monospace;
  font-size: 1.3rem;
  margin: 0.6rem 0 1rem 0;
}
.osc-block .label {
  color: #9f9f9f;
  font-size: 1rem;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  margin-bottom: 4px;
}
.osc-block .arrow { color: #569cd6; }
.osc-block .path   { color: #9cdcfe; }
.osc-block .param  { color: #ce9178; }

.step-grid { display: flex; flex-direction: column; gap: 0.6rem; margin: 1rem 0; }
.step { display: flex; gap: 0.8rem; align-items: flex-start; }
.step__num {
  background: #6086b4;            /* info */
  color: #fff;
  border-radius: 50%;
  width: 26px; height: 26px;
  display: flex; align-items: center; justify-content: center;
  font-size: 1.1rem; font-weight: bold; flex-shrink: 0; margin-top: 2px;
}
.step__text { font-size: 1.4rem; padding-top: 2px; }
</style>

**Level:** Fortgeschritten | **Zielgruppe:** psychoakustisch orientierte Komponist:innen/Researcher.

<div class="info-box">
<strong>Worum es in diesem Tutorial geht</strong>
Wie Blauertsche Bänder (frequenzabhängige Richtungswahrnehmung) die Wahrnehmung von vorne/hinten und Höhe in Ambisonics verstärken – indem die Y- und Z-Achse des ICST Encoders per OSC mit dem IEM MultiEQ gekoppelt werden.
</div>

Für die Stimme und ihre Richtungswahrnehmung habe ich Experimente mit den [Blauertschen Bändern](https://de.wikipedia.org/wiki/Blauertsche_B%C3%A4nder).

![Richtungsbänder](Richtungsbänder.png)

So habe ich Y vorne ↔ hinten und Z oben ↔ unten mit dem IEM-Multifilter gekoppelt.

![RichtungsWahrnehmung](Richtungswahrnehmung.png)

---

## OSC-Routing

### Höhe (Z-Achse → IEM MultiEQ)

<div class="osc-block">
  <div class="label">OSC OUT · Port 8008</div>
  <span class="arrow">ICST Encoder OSC-Out Höhe</span> <span class="arrow">→</span> <span class="path">/MultiEQ/filterGain4</span> <span class="param">{sz, -5.3, 0.0, 5.3}</span>
</div>

<div class="osc-block">
  <div class="label">OSC IN · Port 8008</div>
  Z <span class="arrow">→</span> IEM MultiEQ: <span class="path">/MultiEQ/filterGain4</span> <span class="param">(Float)</span>
</div>

### Vorne/Hinten (Y-Achse → IEM MultiEQ)

<div class="osc-block">
  <div class="label">OSC OUT · Port 8008</div>
  <span class="arrow">ICST Encoder OSC-Out Vorne</span> <span class="arrow">→</span> <span class="path">/MultiEQ/filterGain4</span> <span class="param">{sz, -5.3, 0.0, 5.3}</span>
</div>

![OSC Connection](osc-anbindung.png)

---

## IEM MultiEQ — Frequenzbänder

**Höhe (Anhebung bei 8 kHz)**
![Height8000](8000hz.png)

**Vorne**
![Front](Front.png)

**Hinten**
![Back](Back.png)

---

## Workflow-Schritte

<div class="step-grid">
  <div class="step"><div class="step__num">1</div><div class="step__text">Wie kann ich die Präsenz von vorne und hinten sowie das Gefühl von Höhen und Tiefen hörbarer machen?</div></div>
  <div class="step"><div class="step__num">2</div><div class="step__text">OSC-Kommunikation zwischen Encoder (Y-, Z-Achse) und IEM MultiEQ (Blauertsche Bänder) erstellen.</div></div>
  <div class="step"><div class="step__num">3</div><div class="step__text">AmbiEncoder-FX-Chain „Blauertsche Bänder-Ambi“ einrichten.</div></div>
</div>

---

### Links
- [Blauertsche Bänder (Wikipedia)](https://de.wikipedia.org/wiki/Blauertsche_B%C3%A4nder)
- [sengpielaudio.com – Die Bedeutung der Blauert'schen Bänder (PDF)](https://sengpielaudio.com/DieBedeutungDerBlauertschenBaender.pdf)


