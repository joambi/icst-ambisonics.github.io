---
date: 2025-05-16
title: Blauert's Bands
weight: 10
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

----
# Blauert's Bands:

For the voice and its directivity perception I conducted experiments with the [Blauert's Bands](https://de.wikipedia.org/wiki/Blauertsche_B%C3%A4nder).
![Ritungsbänder | 400](Richtungsbänder.png)

Thus I coupled Y Front <-> Back and Z Top <-> Bottom with the IEM-Multifilter.
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

### Thoughts & Descriptions of the Workflow Steps
1. How can I make the presence of the front and the back of me, as well as the feeling of highs and lows more audible?
2. Created OSC Communication between Encoder (Y,Z) & IEM MultiEQ (Blauert's Bands)
3. Mono-Encoder FX-Chain "Blauert's Bands-Ambi" set up.


### Links:
- [Blauert's Bands](https://de.wikipedia.org/wiki/Blauertsche_B%C3%A4nder)
- [sengpielaudio.com/DieBedeutungDerBlauertschenBaender.pdf](https://sengpielaudio.com/DieBedeutungDerBlauertschenBaender.pdf)

---

