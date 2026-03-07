---
title: Blauertsche Bänder
description: "Zeigt, wie Blauerts Bänder per OSC zum IEM MultiEQ geleitet werden und welche Schritte nötig sind, um Front/Back- und Höhenbänder zu formen."
date: 2025-05-16
year: 2025
month: 2025-05
weight: 10
tags: ["perception", "psychoacoustics", "binaural", "theory"]
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

----
# Blauertsche Bänder:

Für die Stimme und ihre Richtungswahrnehmung habe ich Experimente mit den [Blauertsche Bänder](https://de.wikipedia.org/wiki/Blauertsche_B%C3%A4nder) durchgeführt.
![Richtungsbänder | 400](Richtungsbänder.png)

So habe ich Y Front <-> Back und Z Top <-> Bottom mit dem IEM-Multifilter gekoppelt.
![RichtungsWahrnehmung | 400](Richtungswahrnehmung.png)
OSC-OUT: 8008
- ICST Encoder OSC-Out Height: --> /MultiEQ/filterGain4 {sz, -5.3, 0.0, 5.3}
OSC-IN: 8008
- Z--> IEM MultiEQ: /MultiEQ/filterGain4 (Float)

OSC-OUT: 8008
- ICST Encoder OSC-Out Front: --> /MultiEQ/filterGain4 {sz, -5.3, 0.0, 5.3}
- Y--> IEM MultiEQ: ![OSC](osc-anbindung.png)

---
IEM-MultiEQ
Height:
![Height8000](8000hz.png)

Front:![Front](Front.png)

Back:![Back](Back.png)

----

### Gedanken und Beschreibungen der Workflow-Schritte
1. Wie kann ich die Präsenz von vorne und hinten, sowie das Gefühl von Höhen und Tiefen hörbarer machen?
2. Erstellte OSC-Kommunikation zwischen Encoder (Y,Z) & IEM MultiEQ (Blauertsche Bänder)
3. Mono-Encoder FX-Chain "Blauertsche Bänder-Ambi" eingerichtet.


### Links:
- [Blauertsche Bänder](https://de.wikipedia.org/wiki/Blauertsche_B%C3%A4nder)
- [sengpielaudio.com/DieBedeutungDerBlauertschenBaender.pdf](https://sengpielaudio.com/DieBedeutungDerBlauertschenBaender.pdf)

---

