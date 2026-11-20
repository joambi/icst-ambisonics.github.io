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

- <a id="gl-azimuth"></a>**Azimut / Elevation** — Polarkoordinaten zur Beschreibung von Quellrichtungen: Azimut = horizontaler Winkel (0°–360°), Elevation = vertikaler Winkel (−90° bis +90°).
  → [Wikipedia: Horizontalkoordinatensystem](https://de.wikipedia.org/wiki/Horizontalkoordinatensystem)
