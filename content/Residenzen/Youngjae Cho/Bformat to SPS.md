---
date: 2025-07-08T11:37:00
---

Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

---
SPS (Spatial PCM Sampling) oder P-Format.

_SPS kann als alternativer Ansatz zu High Order Ambisonics_
_betrachtet werden. Es beruht auf dem gleichen Konzept der_
_Kodierung der räumlichen Information in einer kleinen Anzahl_
_von Kanälen, von denen jeder einen "räumlich abhängigen"_
_Filter darstellt. Die kodierten Signale können verarbeitet und_
_später über ein Lautsprechersystem mit beliebiger Geometrie_
_und Anzahl von Lautsprechern wiedergegeben werden._

Das SPS (PCM) Audio ermöglicht, ein genaueres bearbeiten einer Feldaufnahme im B-Format.
Dazu werde ich das Bformat (3rd-Order ambix) mit den [sparta-decoder/encoder](https://leomccormack.github.io/sparta-site/docs/plugins/overview/) zu einem T-design Format umwandeln (T-Design/ T-Format entspricht dem SPS-Format)
Der Workflow sieht wie folgt aus:
![[Bildschirmfoto 2025-07-08 um 12.59.29.png | 600]]
1. Convert the Bformat (HOA) to a 3rd-order ambix bformat
2. Decoding the 3rd-order (B-format to T-format conversion using AmbiDEC) from Sparta.
   ![[Bildschirmfoto 2025-07-08 um 11.51.46.png]]
3. De-Noise or work with traditional methodic on your PCM Audio
    Example: Toonbooster EQ-Pro
4. Back-Conversion from T-Format to a B-Format (3rd-order ambix)
   ![[Bildschirmfoto 2025-07-08 um 12.24.39.png]]
5. UpScaling to 7th-order ambix
6. 
Literatur:
- A.Farina [upv.es/contenidos/ISVA2011/info/U0568405.pdf](https://www.upv.es/contenidos/ISVA2011/info/U0568405.pdf)
- [SPS and Mach1 spatial audio formats](https://www.angelofarina.it/SPS-conversion.htm)

