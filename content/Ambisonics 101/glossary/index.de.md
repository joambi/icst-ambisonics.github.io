---
title: "Ambisonics-Begriffssammlung"
description: "Kurzreferenz zu den wichtigsten Begriffen in Ambisonics: A-Format, B-Format, ambiX, Ordnung, Encoder, Decoder, Binaural, OSC, Yaw/Pitch/Roll, Azimut/Elevation."
date: 2026-11-20T00:00:00
draft: false
url: /de/ambisonics-101/glossary/
languageCode: de
tags:
  - ambisonics
  - glossary
---

Kurzreferenz zu den Begriffen aus [Ambisonics 101](/de/ambisonics-101/).

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
  → [Wikipedia: Binauraltechnik](https://de.wikipedia.org/wiki/Binauraltechnik) | [Wikipedia: HRTF](https://de.wikipedia.org/wiki/Head-Related_Transfer_Function)

- <a id="gl-dolby-atmos"></a>**Dolby Atmos** — Objektbasiertes 3D-Audioformat: Klangquellen werden als Audio-Objekte mit Positions-Metadaten gespeichert; ein lizenzierter Renderer platziert sie im Zielsystem (Kino, Heimkino, Streaming-Dienste).
  → [dolby.com](https://www.dolby.com/technologies/dolby-atmos/) | [Wikipedia: Dolby Atmos](https://de.wikipedia.org/wiki/Dolby_Atmos)

- <a id="gl-osc"></a>**OSC (Open Sound Control)** — Netzwerkprotokoll (UDP/IP) zur Echtzeitsteuerung räumlicher Parameter.
  → [opensoundcontrol.stanford.edu](https://opensoundcontrol.stanford.edu/) | [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)

- <a id="gl-yaw"></a>**Yaw / Pitch / Roll** — Rotationsachsen im 3D-Raum: Yaw = horizontal (links/rechts), Pitch = vertikal (oben/unten), Roll = Neigung.
  → [Wikipedia: Eulersche Winkel](https://de.wikipedia.org/wiki/Eulersche_Winkel)

- <a id="gl-azimuth"></a>**Azimut / Elevation** — Polarkoordinaten zur Beschreibung von Quellrichtungen: Azimut = horizontaler Winkel (0°–360°, in den ICST-Tools im Uhrzeigersinn: 0° vorne, 90° rechts, 180° hinten, 270° links), Elevation = vertikaler Winkel (−90° bis +90°).
  → [Wikipedia: Horizontalkoordinatensystem](https://de.wikipedia.org/wiki/Horizontalkoordinatensystem)

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
