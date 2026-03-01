---
date: 2025-07-08T11:37:00
---

Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

---
SPS (Spatial PCM Sampling) or P-Format.

_SPS can be considered as an alternative approach to High Order Ambisonics._
_It is based on the same concept of_
_encoding spatial information in a small number_
_of channels, each representing a "spatially dependent"_
_filter. The encoded signals can be processed and_
_later reproduced via a loudspeaker system with arbitrary geometry_
_and number of loudspeakers._

SPS (PCM) audio allows for more precise processing of a field recording in B-format.
For this, I will convert the B-format (3rd-order ambix) with the [sparta-decoder/encoder](https://leomccormack.github.io/sparta-site/docs/plugins/overview/) to a T-design format (T-Design / T-Format corresponds to the SPS-Format)
The workflow is as follows:
![Bildschirmfoto 2025-07-08 um 12.59.29.png](Bildschirmfoto%202025-07-08%20um%2012.59.29.png)
1. Convert the B-format (HOA) to a 3rd-order ambix B-format
2. Decoding the 3rd-order (B-format to T-format conversion using AmbiDEC) from Sparta.
   ![Bildschirmfoto 2025-07-08 um 11.51.46.png](Bildschirmfoto%202025-07-08%20um%2011.51.46.png)
3. De-Noise or work with traditional methods on your PCM Audio
    Example: Toonbooster EQ-Pro
4. Back-Conversion from T-Format to a B-Format (3rd-order ambix)
   ![Bildschirmfoto 2025-07-08 um 12.24.39.png](Bildschirmfoto%202025-07-08%20um%2012.24.39.png)
5. UpScaling to 7th-order ambix
6.
Literature:
- A.Farina [upv.es/contenidos/ISVA2011/info/U0568405.pdf](https://www.upv.es/contenidos/ISVA2011/info/U0568405.pdf)
- [SPS and Mach1 spatial audio formats](https://www.angelofarina.it/SPS-conversion.htm)

