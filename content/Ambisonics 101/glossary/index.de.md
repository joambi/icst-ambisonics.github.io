---
title: "Ambisonics-Begriffssammlung"
description: "Kurzreferenz zu Ambisonics und HOA: Format, Ordnung, Normalisierung, Mikrofone, Decoder, Binaural, Verarbeitung und parametrische Verfahren."
date: 2026-11-22T00:00:00
draft: false
url: /de/ambisonics-101/glossary/
languageCode: de
tags:
  - ambisonics
  - glossary
---

Kurzreferenz zu den Begriffen aus [Ambisonics 101](/de/ambisonics-101/).

## Grundbegriffe

- <a id="gl-a-format"></a>**A-Format** — Rohsignal eines tetraedrischen Ambisonics-Mikrofons: vier Kapselsignale in tetraedrischer Anordnung. Muss vor der Verwendung in B-Format enkodiert werden.
  → [Wikipedia: Ambisonics](https://de.wikipedia.org/wiki/Ambisonics)

- <a id="gl-b-format"></a>**B-Format** — Das Ambisonics-Trägersignal: kodiert das räumliche Klangfeld als Kugelflächenfunktionen. Erste Ordnung = 4 Kanäle (W, X, Y, Z); siebte Ordnung = 64 Kanäle.
  → [Wikipedia: Ambisonics](https://de.wikipedia.org/wiki/Ambisonics) | [ICST Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)

- <a id="gl-ambix"></a>**ambiX** — Standardisiertes Ambisonics-Dateiformat (ACN-Kanalreihenfolge, SN3D-Normierung); De-facto-Standard für HOA-Austausch und -Archivierung.
  → [ambiX Spezifikation (IEM)](https://ambisonics.iem.at/proceedings-of-the-ambisonics-symposium-2011/ambix-a-suggested-ambisonics-format)

- <a id="gl-order"></a>**Ambisonics-Ordnung** — Räumliche Auflösungsstufe: 1st order = 4 Kanäle, 3rd = 16, 7th = 64. Höhere Ordnung bedeutet präzisere Lokalisation und mehr Kanäle.
  → [Wikipedia: Higher-order Ambisonics](https://en.wikipedia.org/wiki/Ambisonics#Higher-order_Ambisonics) | [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)

- <a id="gl-encoder"></a>**Encoder** — Wandelt eine Mono-/Stereo-Quelle mit Positionsdaten (Azimut, Elevation, Distanz) in B-Format um.
  → [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)

- <a id="gl-decoder"></a>**Decoder** — Rendert B-Format auf ein Zielsystem: Lautsprecher-Array oder Binaural.
  → [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)

- <a id="gl-channel-count"></a>**Channel Count** — Anzahl der Kanäle im Ambisonics-Signalpfad; muss im gesamten Routing konsistent bleiben.
  → [ICST Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)

- <a id="gl-speaker-layout"></a>**Speaker Layout** — Physische Lautsprechergeometrie, auf die der Decoder das B-Format rendert.
  → [Wikipedia: Ambisonic reproduction systems](https://en.wikipedia.org/wiki/Ambisonic_reproduction_systems)

- <a id="gl-binaural"></a>**Binaural / HRTF** — Kopfhörer-Rendering via Head-Related Transfer Functions (HRTFs): simuliert räumliche Richtungswahrnehmung ohne Lautsprecher. Ermöglicht Ambisonics-Abhören auf jedem Kopfhörer.
  → [Wikipedia: Binaurale Tonaufnahme](https://de.wikipedia.org/wiki/Binaurale_Tonaufnahme) | [Wikipedia: HRTF](https://de.wikipedia.org/wiki/Head-Related_Transfer_Function)

- <a id="gl-dolby-atmos"></a>**Dolby Atmos** — Objektbasiertes 3D-Audioformat: Klangquellen werden als Audio-Objekte mit Positions-Metadaten gespeichert; ein lizenzierter Renderer platziert sie im Zielsystem (Kino, Heimkino, Streaming-Dienste).
  → [dolby.com](https://www.dolby.com/technologies/dolby-atmos/) | [Wikipedia: Dolby Atmos](https://de.wikipedia.org/wiki/Dolby_Atmos)

- <a id="gl-osc"></a>**OSC (Open Sound Control)** — Netzwerkprotokoll (UDP/IP) zur Echtzeitsteuerung räumlicher Parameter.
  → [opensoundcontrol.stanford.edu](https://opensoundcontrol.stanford.edu/) | [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)

- <a id="gl-yaw"></a>**Yaw / Pitch / Roll** — Rotationsachsen im 3D-Raum: Yaw = horizontal (links/rechts), Pitch = vertikal (oben/unten), Roll = Neigung.
  → [Wikipedia: Eulersche Winkel](https://de.wikipedia.org/wiki/Eulersche_Winkel)

- <a id="gl-azimuth"></a>**Azimut / Elevation** — Polarkoordinaten zur Beschreibung von Quellrichtungen: Azimut = horizontaler Winkel (0°–360°, in den ICST-Tools im Uhrzeigersinn: 0° vorne, 90° rechts, 180° hinten, 270° links), Elevation = vertikaler Winkel (−90° bis +90°).
  → [Wikipedia: Kartesisches Koordinatensystem](https://de.wikipedia.org/wiki/Kartesisches_Koordinatensystem)

- <a id="gl-foa"></a>**First-Order Ambisonics (FOA)** — Ambisonics 1. Ordnung: 4 Kanäle (W, X, Y, Z). Liefern alle gängigen Ambisonics-Mikrofone. Kompakt und robust, mit begrenzter räumlicher Auflösung.
  → [Welche Ordnung brauche ich?](/de/post/hoa-ordnung-wahl-praxis/)

- <a id="gl-hoa"></a>**Higher-Order Ambisonics (HOA)** — Ambisonics ab der 2. Ordnung. Die N-te Ordnung braucht (N+1)² Kanäle (3rd = 16, 7th = 64) und ergibt feinere Ortung und einen grösseren Sweetspot.
  → [Welche Ordnung brauche ich?](/de/post/hoa-ordnung-wahl-praxis/)

- <a id="gl-sweet-spot"></a>**Sweetspot** — Bereich, in dem das Schallfeld korrekt wiedergegeben wird. Er wächst mit der Ambisonics-Ordnung und wird mit steigender Frequenz kleiner.
  → [Welche Ordnung brauche ich?](/de/post/hoa-ordnung-wahl-praxis/)

- <a id="gl-acn"></a>**ACN (Ambisonic Channel Number)** — Kanalordnung von ambiX. In erster Ordnung laufen die Kanäle W, Y, Z, X.
  → [Formate erklärt](/de/learn/ambisonics-formats/)

- <a id="gl-sn3d"></a>**SN3D** — Normalisierung, die ambiX zusammen mit der ACN-Ordnung verwendet.
  → [Formate erklärt](/de/learn/ambisonics-formats/)

- <a id="gl-fuma"></a>**FuMa (Furse-Malham)** — Ältere Konvention: Kanalordnung W, X, Y, Z mit maxN-Normalisierung. Bis zur 3. Ordnung definiert; in aktuellen Tools durch ambiX ersetzt.
  → [Formate erklärt](/de/learn/ambisonics-formats/)

- <a id="gl-aed-xyz"></a>**AED und XYZ** — Zwei Arten, eine Quellposition anzugeben: Azimut, Elevation, Distanz (polar) oder X, Y, Z (kartesisch: X rechts, Y vorne, Z oben).
  → [XYZ und AED im Vergleich](/de/post/xyz-vs-aed-koordinatensysteme/)

- <a id="gl-weighting"></a>**Decoder-Gewichtung (Basic, In-Phase, Max-rE)** — Ordnungsabhängige Gewichte im Decoder. Basic rekonstruiert das Feld streng, hat aber Nebenkeulen; In-Phase hat keine und ist am breitesten; Max-rE ist ein auf den Energievektor abgestimmter Kompromiss, üblich für grosse Räume.
  → [Decoder-Geschichte](/de/blog/decoder-geschichte-und-anwendungen/)

- <a id="gl-rv-re"></a>**Geschwindigkeitsvektor (rV) und Energievektor (rE)** — Gerzons psychoakustische Kriterien: rV beschreibt die Ortung bei tiefen, rE bei hohen Frequenzen.
  → [Decoder-Geschichte](/de/blog/decoder-geschichte-und-anwendungen/)

- <a id="gl-allrad"></a>**AllRAD** — All-Round Ambisonic Decoding: Decoder-Methode für unregelmässige Lautsprecher-Layouts, verfügbar als IEM AllRADecoder.
  → [IEM Plugin Suite](https://plugins.iem.at/)

- <a id="gl-hrtf"></a>**HRTF** — Head-Related Transfer Function: die Filterung durch Kopf und Ohren für jede Richtung. Binaural-Decoder nutzen HRTFs, um Quellen über Kopfhörer zu platzieren.
  → [Binaural Monitoring](/de/post/binaural-monitoring-icst-workflow/)

- <a id="gl-sofa"></a>**SOFA** — Dateiformat für HRTF-Daten (AES69), das Binaural-Renderer mit eigenen HRTFs laden.
  → [Binaural Monitoring](/de/post/binaural-monitoring-icst-workflow/)

- <a id="gl-head-tracking"></a>**Head-Tracking** — Ein Sensor folgt der Kopfdrehung und die Szene wird gegenläufig gedreht, damit Quellen über Kopfhörer im Raum fest bleiben.
  → [Binaural Monitoring](/de/post/binaural-monitoring-icst-workflow/)

- <a id="gl-w-channel"></a>**W-Kanal** — Omnidirektionale Druckkomponente, der erste B-Format-Kanal. Nach der A→B-Konvertierung sollte er der lauteste Kanal sein.
  → [Mikrofon-Guide](/de/post/ambisonics-mikrofon-a-format-b-format/)

- <a id="gl-non-coincidence"></a>**Nicht-Koinzidenz** — Die vier Kapseln eines Ambisonics-Mikrofons sitzen etwa 1 cm auseinander. Bei hohen Frequenzen entstehen dadurch Richtungsfehler, die das A→B-Plugin korrigiert.
  → [Mikrofon-Guide](/de/post/ambisonics-mikrofon-a-format-b-format/)

- <a id="gl-multidecoder"></a>**MultiDecoder** — ICST-Plugin, das bis zu vier Decoder-Einheiten parallel betreibt, jede mit eigener Lautsprecher-Teilmenge, Ordnung, Gewichtung und eigenem Filter.
  → [ICST MultiDecoder](/de/icst-ambisonics-plugins/09_icst_multidecoder/)

- <a id="gl-bformat-master"></a>**B-Format-Master** — Der gemeinsame B-Format-Bus einer Session, in den alle Encoder summieren. Von hier wird dekodiert und gerendert.
  → [Workflow](/de/learn/ambisonics-workflow/)

- <a id="gl-delay-compensation"></a>**Laufzeitkompensation** — Der Decoder verzögert die näheren Lautsprecher, damit alle Signale gleichzeitig an der Hörposition ankommen.
  → [Skalierung und Laufzeitkompensation](/de/post/decoder-skalierung-laufzeitkompensation/)

- <a id="gl-uhj"></a>**UHJ** — Stereo-kompatible Kodierung von Ambisonics (2 bis 4 Kanäle, meist 2) aus den 1970ern, genutzt für Veröffentlichungen, die auf normalen Stereoanlagen laufen mussten.
  → [Zeitleiste](/de/blog/geschichte-von-ambisonics-foa-und-hoa/)

- <a id="gl-scene-based"></a>**Szenenbasiertes und kanalbasiertes Audio** — Ambisonics speichert das Schallfeld (die Szene) unabhängig vom Lautsprecher-Layout und dekodiert es für jedes System. Kanalbasierte Formate speichern ein Signal pro Lautsprecher.
  → [Ambisonics 101](/de/ambisonics-101/)

## Mathematische Grundlagen

- <a id="gl-spherical-harmonics"></a>**Kugelflächenfunktionen (Spherical Harmonics)** — Mathematische Funktionen auf der Kugeloberfläche, in die Ambisonics das Schallfeld zerlegt. Jede Funktion hat einen Grad n (die Ambisonics-Ordnung) und einen Index m von −n bis n. Bis zur Ordnung N gibt es (N+1)² Funktionen, also Kanäle.
  → [Wikipedia: Spherical harmonics](https://en.wikipedia.org/wiki/Spherical_harmonics) | [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-plane-spherical-wave"></a>**Ebene Welle und Kugelwelle** — Ambisonics beschreibt Quellen zunächst als ebene Wellen: unendlich weit entfernt, nur eine Richtung. Quellen in endlicher Distanz sind Kugelwellen; ihr Nahfeldverhalten erfasst die Nahfeld-Kodierung.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-periphony"></a>**Periphonie und Pantophonie** — Begriffe von Gerzon: Periphonie ist Wiedergabe mit Höhe (volle Sphäre), Pantophonie nur in der Horizontalebene.
  → [Gerzon 1973](https://ringbuffer.org/papers/gerzon1973periphony.html)

- <a id="gl-2d-ambisonics"></a>**Horizontales (2D-)Ambisonics** — Ambisonics nur in der Horizontalebene. Ordnung N braucht dort 2N+1 Kanäle statt (N+1)².
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-mixed-order"></a>**Mixed-Order-Ambisonics** — Horizontale und vertikale Ordnung sind verschieden, etwa horizontal hoch und vertikal niedrig. Das spart Kanäle gegenüber der vollen Ordnung.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-order-reduction"></a>**Ordnungsreduktion** — Die Kanäle höherer Ordnung werden weggelassen: Aus einem HOA7-Master wird so HOA3 oder FOA. Umgekehrt entsteht beim Hochmischen keine neue räumliche Auflösung.
  → [HOA-Wahl in der Praxis](/de/post/hoa-ordnung-wahl-praxis/)

- <a id="gl-spatial-aliasing"></a>**Räumliches Aliasing** — Oberhalb einer Grenzfrequenz wird das Schallfeld nur noch unvollständig erfasst oder rekonstruiert. Sie hängt vom Kapselabstand (Mikrofon) bzw. von der Lautsprecherzahl ab. Folgen sind Richtungsfehler und Klangfärbung.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7) | [Ward & Abhayapala 2001](https://doi.org/10.1109/89.943347)

## Formate und Austausch

- <a id="gl-n3d-maxn"></a>**N3D und maxN** — Weitere Normalisierungen neben SN3D. N3D ist voll orthonormal; es entspricht SN3D mal √(2n+1) für Grad n. maxN skaliert so, dass kein Kanal über 1 geht, und gehört zu FuMa.
  → [Wikipedia: Ambisonic data exchange formats](https://en.wikipedia.org/wiki/Ambisonic_data_exchange_formats)

- <a id="gl-ogg-opus"></a>**Ambisonics in Opus (RFC 8486)** — Legt fest, wie Ambisonics-Signale in Ogg-Opus-Dateien gespeichert werden. Das ermöglicht Ambisonics in gängigen Streaming-Containern.
  → [RFC 8486](https://www.rfc-editor.org/info/rfc8486)

- <a id="gl-mpegh"></a>**MPEG-H 3D Audio** — Audio-Codec-Standard, der HOA-Szenen neben Kanälen und Objekten kodieren kann.
  → [Wikipedia: MPEG-H 3D Audio](https://en.wikipedia.org/wiki/MPEG-H_3D_Audio)

## Mikrofone und Aufnahme

- <a id="gl-soundfield-mic"></a>**Soundfield-Mikrofon** — Das erste kommerzielle Ambisonics-Mikrofon (Calrec, 1978): vier Kapseln im Tetraeder, die das A-Format liefern.
  → [Zeitleiste](/de/blog/geschichte-von-ambisonics-foa-und-hoa/)

- <a id="gl-spherical-array"></a>**Sphärisches Mikrofonarray** — Viele Kapseln auf einer Kugel, zum Beispiel Eigenmike (32 Kapseln) oder Zylia ZM-1 (19 Kapseln). Es erfasst höhere Ordnungen. Für Ordnung N braucht es mindestens (N+1)² Kapseln.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7) | [Mikrofon: A- und B-Format](/de/post/ambisonics-mikrofon-a-format-b-format/)

- <a id="gl-radial-filter"></a>**Radialfilter (Kapselentzerrung)** — Frequenzabhängige Filter, die aus den Kapselsignalen ein korrektes B-Format machen. Je höher die Ordnung, desto stärker verstärken sie tiefe Frequenzen und damit auch Rauschen. Das begrenzt die nutzbare Ordnung im Bass.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-beamforming"></a>**Beamforming (virtuelle Mikrofone)** — Aus dem B-Format lassen sich Richtmikrofone beliebiger Richtung und Charakteristik berechnen.
  → [Wikipedia: Beamforming](https://en.wikipedia.org/wiki/Beamforming)

- <a id="gl-srir"></a>**Räumliche Raumimpulsantwort (SRIR)** — Impulsantwort eines Raums, mit einem Ambisonics-Mikrofon gemessen. Gefaltet mit einem Signal ergibt sie Raumhall als B-Format.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

## Decoder und Wiedergabe

- <a id="gl-sad"></a>**Sampling-Decoder (SAD)** — Wertet die Kugelflächenfunktionen an den Lautsprecherrichtungen aus. Einfach und gut bei regelmässigen Layouts, bei unregelmässigen ungleichmässig.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-mmd"></a>**Mode-Matching-Decoder (MMD)** — Invertiert (Pseudoinverse) die Matrix der Kugelflächenfunktionen an den Lautsprecherpositionen. Genau bei genügend gut verteilten Lautsprechern, instabil bei Lücken im Layout.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-epad"></a>**EPAD (Energy-Preserving Ambisonic Decoder)** — Decoder, der für gleichmässige Energie über alle Richtungen sorgt.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-nfc"></a>**Nahfeld-Kompensation (NFC)** — Berücksichtigt die endliche Entfernung von Lautsprechern bzw. Quellen (Kugelwellen statt ebener Wellen). Wichtig bei höherer Ordnung und bei Quellen nahe am Kopf.
  → [Decoder-Geschichte](/de/blog/decoder-geschichte-und-anwendungen/)

- <a id="gl-t-design"></a>**t-Design und regelmässige Layouts** — Gleichmässig auf der Kugel verteilte Punktmengen (zum Beispiel Lebedev-Gitter), für die die Kugelflächenfunktionen bis zu einem bestimmten Grad sauber abgetastet werden. Ideal für Lautsprecherlayouts.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-vbap-wfs"></a>**VBAP und Wellenfeldsynthese** — Zwei andere Wiedergabeverfahren. VBAP verteilt eine Quelle auf die zwei oder drei nächsten Lautsprecher und hängt vom Layout ab. Wellenfeldsynthese rekonstruiert Wellenfronten mit vielen Lautsprechern auf einer grossen Fläche.
  → [VBAP (Aalto University)](http://legacy.spa.aalto.fi/research/cat/vbap/) | [Wikipedia: Wave field synthesis](https://en.wikipedia.org/wiki/Wave_field_synthesis)

## Binaural

- <a id="gl-virtual-speakers"></a>**Virtuelle Lautsprecher** — Binaurales Rendering in zwei Schritten: Das B-Format wird zuerst auf virtuelle Lautsprecher dekodiert, dann wird jeder mit der HRTF seiner Richtung gefaltet. Alternativ wird die HRTF direkt im Kugelflächenbereich angewendet.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-magls"></a>**MagLS (Magnitude Least Squares)** — Optimiert beim binauralen Rendering niedriger Ordnung das Betragsspektrum der HRTF-Darstellung. Das verbessert die Klangfarbe gegenüber einer reinen Kugelflächen-Näherung.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

## Verarbeitung im Ambisonics-Bereich

- <a id="gl-rotation"></a>**Rotation** — Drehung des ganzen Schallfeldes um Yaw, Pitch und Roll. Im Kugelflächenbereich geschieht das mit Matrizen und ohne Verlust. Grundlage für Head-Tracking.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-dominance"></a>**Dominanz (Zoom)** — Verschiebt die Energie des Schallfeldes in eine Richtung: Quellen vor dem Hörer werden betont, die dahinter zurückgenommen.
  → [Zotter & Frank 2019](https://link.springer.com/book/10.1007/978-3-030-17207-7)

- <a id="gl-source-width"></a>**Quellenbreite (Spread)** — Eine Quelle wirkt breiter. In Ambisonics geht das zum Beispiel über eine niedrigere Ordnung für diese Quelle, denn niedrige Ordnung bündelt weniger scharf.
  → [HOA-Wahl in der Praxis](/de/post/hoa-ordnung-wahl-praxis/)

## Parametrische Verfahren

- <a id="gl-dirac"></a>**DirAC (Directional Audio Coding)** — Analysiert pro Frequenzband Richtung und Diffusität des Schallfeldes und rendert sie auf beliebige Lautsprecherlayouts. Ein parametrisches Verfahren statt einer reinen Kugelflächen-Zerlegung.
  → [Pulkki et al. 2017](https://doi.org/10.1002/9781119252634)
