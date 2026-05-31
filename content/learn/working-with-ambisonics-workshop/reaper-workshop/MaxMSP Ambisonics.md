---
categories:
  - ICST Ambisonics Workshop
---
---
**Die wichtigsten Ambisonics-Optionen in Max**

- **ICST Ambisonics**  
    Sehr praxisnahes Paket für Max, mit 3D-Source-Control, GUI, Trajektorien und Ambisonics-Processing. Das ist heute eine der klar sichtbar gepflegten Max-Paketlösungen im Package Manager.  
    Quelle: [![](https://cycling74.com/favicon.ico)ICST Ambisonics](https://cycling74.com/packages/icst-ambisonics)


- **Spat5 von IRCAM**  
    Sehr mächtig und professionell, besonders wenn Ambisonics Teil eines größeren Spatial-Audio-Workflows ist. Dazu gehören HOA-Encoder/Decoder, Binauralisierung und weitere Panning-/Raumsimulationsverfahren.  
    Quelle: [IRCAM HOA-Workflow](https://discussion.forum.ircam.fr/t/vbap-vbip-dualbandvbp/36449)
    

**Warum Max dafür gut ist**

- visuelle Patchen für komplexe Signalflüsse
- einfache Anbindung von MIDI, OSC, Tracking, Sensoren
- gut für interaktive Raumkomposition
- gut für Prototyping von Bewegungen und Installationen
- Mehrkanalrouting lässt sich flexibel bauen

**Worauf man achten muss**

- Höhere Ordnung bedeutet schnell sehr viele Kanäle
- Kanalreihenfolge und Normierung sind wichtig
- verschiedene Libraries nutzen teils unterschiedliche Konventionen
- Decoding hängt stark vom Lautsprecher-Setup ab
- binaural ist praktisch, aber nicht automatisch identisch zu einer Lautsprecherwiedergabe

**Ein guter Denkrahmen für Max**  
Ambisonics in Max ist meistens:

1. Klangquelle erzeugen oder einlesen
2. Positiondaten erzeugen
3. in HOA encodieren
4. Feld transformieren/bewegen
5. auf Speaker oder binaural decodieren