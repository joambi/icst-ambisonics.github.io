---
Date-Created: 2025-05-17
tags:
  - ambiencoder
title: blauertschen-baender
---


----
# ~={blue}Blauertschen Bänder=~:

Für die Stimme und derer Directivity Wahrnehmung habe ich Experimente mit den [Blauertschen-Bändern](https://de.wikipedia.org/wiki/Blauertsche_B%C3%A4nder) gemacht. 
![[Bildschirmfoto 2025-05-17 um 11.03.02.png | 250]]

So habe ich Y Vorne <-> Hinten und Z  Oben <-> Unten mit dem IEM-Multifilter gekoppelt. 
![[Bildschirmfoto 2025-05-17 um 12.15.56.png | 300]]
OSC-OUT: 8008
- ICST Encoder OSC-Out Hight: --> /MultiEQ/filterGain4 {sz, -5.3, 0.0, 5.3}
OSC-IN: 8008
- Z--> IEM MultiEQ: /MultiEQ/filterGain4 (Float)

OSC-OUT: 8008
- ICST Encoder OSC-Out Front: --> /MultiEQ/filterGain4 {sz, -5.3, 0.0, 5.3}
- Y--> IEM MultiEQ: ![[Bildschirmfoto 2025-05-18 um 10.28.40.png]]

---
IEM-MultiEQ
Hight:![[Hight 8000.png]]


Front:![[Front.png]]

Back:![[Back.png]]

----

### Gedanken & Beschreibungen zu den Arbeitsschritten
1. Wie kann ich Präsenz der Front und des Hinter mir, sowie das Höhen & Tiefen Gefühl besser hörbar machen?
2. Created OSC Communication bethween Encoder (Y,Z) & IEM MultiEQ (Blauertschebänder)
3. Mono-Encoder FX-Chain "Blauertschebänder-Ambi" eingerichtet.


### Links:
- [Blauertschebänder](https://de.wikipedia.org/wiki/Blauertsche_B%C3%A4nder)
- [sengpielaudio.com/DieBedeutungDerBlauertschenBaender.pdf](https://sengpielaudio.com/DieBedeutungDerBlauertschenBaender.pdf)
- 
