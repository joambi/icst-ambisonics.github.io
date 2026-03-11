---
title: Ambisonics 101
description: Kompakter Einstieg in Ambisonics, B-Format, typische Setups und praxisnahe Hörsituationen.
slug: ambisonics-101
languageCode: de
---

<style>
.toc-card {
  border: 1px solid #c8c8c8;
  border-radius: 6px;
  padding: 1rem 1.1rem;
  margin: 0.8rem 0 1.4rem 0;
}
.toc-card__title {
  font-size: 1.25rem;
  font-weight: 700;
  margin-bottom: 0.6rem;
}
.toc-card ol {
  margin: 0;
  padding-left: 1.4rem;
}
.toc-card li {
  margin: 0.25rem 0;
  line-height: 1.4;
}
.toc-card a {
  text-decoration: none;
}
.toc-card a:hover {
  text-decoration: underline;
}
.post__content h1 a,
.post__content h2 a,
.post__content h3 a {
  color: #6086b4 !important;
}
</style>

<div class="toc-card">
  <div class="toc-card__title">Inhaltsverzeichnis</div>
  <ol>
    <li><a href="#was-ist-ambisonics">Was ist Ambisonics?</a></li>
    <li><a href="#was-ist-b-format">Was ist B-Format?</a></li>
    <li><a href="#signalfluss">Signalfluss auf einen Blick</a></li>
    <li><a href="#typische-setups">Typische Setups</a></li>
    <li><a href="#kopfhoerer-vs-lautsprecher">Kopfhörer vs. Lautsprecher</a></li>
    <li><a href="#immersive-vs-atmos">Wie unterscheidet sich Ambisonics von Immersive Audio, Dolby Atmos und Spatial Audio?</a></li>
    <li><a href="#einstieg-am-icst">Einstieg am ICST</a></li>
    <li><a href="#begriffssammlung-ambisonics">Begriffssammlung Ambisonics (Kurzreferenz)</a></li>
  </ol>
</div>

<a id="was-ist-ambisonics"></a>
## 1. [Was ist Ambisonics?](https://de.wikipedia.org/wiki/Ambisonics)
Ambisonics ist eine formatagnostische Methode, um ein räumliches 3D-Klangfeld zu beschreiben. Statt direkt für ein festes Lautsprecher-Layout zu mischen, arbeitet man mit einer räumlichen Repräsentation, die später für unterschiedliche Wiedergabesysteme gerendert werden kann.

<a id="was-ist-b-format"></a>
## 2. [Was ist B-Format?](https://ambisonic.info/ambisonics/channels.html)

Das B-Format ist das zentrale Signalformat von Ambisonics und enthält die räumlichen Informationen. Klangquellen werden ins B-Format encodiert und anschließend für ein Ziel-Setup dekodiert, etwa für Kopfhörer, Stereo oder verschiedene Lautsprecher-Arrays.

Es beschreibt einen Raumzustand um einen Hörpunkt herum, der aus Druck- und Richtungsanteilen besteht. In der ersten Ordnung bedeutet das:
- `W` ist die omnidirektionale Komponente, also der Druck bzw. die Präsenz im Raum.
- `X`, `Y` und `Z` sind gerichtete Anteile in drei Achsen (vorne-hinten, links-rechts, oben-unten), die angeben, aus welcher Richtung das Signal kommt.

Im engeren, klassischen Sinn bezeichnet "B-Format" dieses vierkanalige Ambisonics-Format erster Ordnung (`W`, `X`, `Y`, `Z`). Im erweiterten Sinn kann man B-Format auch für höhere Ordnungen verwenden. Dann umfasst es alle Ambisonics-Koeffizienten bis zu einer bestimmten Ordnung, jeweils als eigener Audiokanal.

Dieses Format kann anschließend auf verschiedene Ziel-Setups dekodiert werden, etwa auf Kopfhörer, Stereo oder Lautsprecher-Arrays. [1](https://en.wikipedia.org/wiki/Ambisonics) [2](https://ambisonic.info/ambisonics/channels.html)

<a id="signalfluss"></a>
## Signalfluss auf einen Blick

Von der Quelle zum Lautsprecher — so funktioniert Ambisonics in REAPER mit den ICST Plugins:

<div class="ambi-sigflow">
<div class="ambi-sigflow__track">
<div class="ambi-sigflow__node ambi-sigflow__node--source">
<i class="fas fa-music ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">Audio-Quelle</div>
<div class="ambi-sigflow__detail">Mono-Spur<br>in REAPER</div>
</div>
<div class="ambi-sigflow__connector">
<div class="ambi-sigflow__clabel">Plugin-Insert</div>
<div class="ambi-sigflow__arrow">
<div class="ambi-sigflow__arrow-line"></div>
<span class="ambi-sigflow__arrow-head">▶</span>
</div>
</div>
<div class="ambi-sigflow__node ambi-sigflow__node--plugin">
<i class="fas fa-dot-circle ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">ICST<br>AmbiEncoder</div>
<div class="ambi-sigflow__detail">Az · El<br>Distanz</div>
</div>
<div class="ambi-sigflow__connector">
<div class="ambi-sigflow__clabel">B-Format (ambiX)</div>
<div class="ambi-sigflow__arrow">
<div class="ambi-sigflow__arrow-line"></div>
<span class="ambi-sigflow__arrow-head">▶</span>
</div>
</div>
<div class="ambi-sigflow__node ambi-sigflow__node--bus">
<i class="fas fa-code-branch ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">B-Format<br>Bus</div>
<div class="ambi-sigflow__detail">64 Kanäle<br>7. Ordnung</div>
</div>
<div class="ambi-sigflow__connector">
<div class="ambi-sigflow__clabel">Bus-Receive</div>
<div class="ambi-sigflow__arrow">
<div class="ambi-sigflow__arrow-line"></div>
<span class="ambi-sigflow__arrow-head">▶</span>
</div>
</div>
<div class="ambi-sigflow__node ambi-sigflow__node--plugin">
<i class="fas fa-broadcast-tower ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">ICST<br>AmbiDecoder</div>
<div class="ambi-sigflow__detail">Lsp.-Layout<br>Ordnung · Filter</div>
</div>
<div class="ambi-sigflow__connector">
<div class="ambi-sigflow__clabel">Ausgabe</div>
<div class="ambi-sigflow__arrow">
<div class="ambi-sigflow__arrow-line"></div>
<span class="ambi-sigflow__arrow-head">▶</span>
</div>
</div>
<div class="ambi-sigflow__outputs">
<div class="ambi-sigflow__node ambi-sigflow__node--output">
<i class="fas fa-volume-up ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">Lautsprecher</div>
</div>
<div class="ambi-sigflow__or">oder</div>
<div class="ambi-sigflow__node ambi-sigflow__node--output">
<i class="fas fa-headphones ambi-sigflow__icon"></i>
<div class="ambi-sigflow__name">Binaural</div>
</div>
</div>
</div>
<div class="ambi-sigflow__caption">Mehrere Quellen haben je einen eigenen AmbiEncoder — alle speisen in denselben B-Format-Bus. Das Decoding auf Lautsprecher oder Kopfhörer findet einmalig am Bus-Ausgang statt.</div>
</div>

<a id="typische-setups"></a>
## 3. [Typische Setups](https://en.wikipedia.org/wiki/Ambisonic_reproduction_systems)
Typische Setups reichen von kleinen Studio-Ringen über Höhenebenen bis hin zu individuellen Arrays im Kompositionsstudio. Dasselbe Ambisonics-Material kann durch Dekodierung an diese verschiedenen Setups angepasst werden.

<a id="kopfhoerer-vs-lautsprecher"></a>
## 4. Kopfhörer vs. Lautsprecher
Kopfhörer arbeiten mit binauralem Rendering und sind praktisch für Editing, Translation-Checks und die Zusammenarbeit auf Distanz. Lautsprecher erzeugen ein physisches Klangfeld im Raum und bleiben zentral für Komposition, Tiefenwahrnehmung und künstlerische Bewertung.

<a id="immersive-vs-atmos"></a>
## 5. Wie unterscheidet sich Ambisonics von Immersive Audio, Dolby Atmos und Spatial Audio?

Ambisonics ist eine Form von Immersive Audio. Immersive Audio ist ein Oberbegriff für 3D-Audioverfahren, die ein vollständiges Klangfeld um die hörende Person erzeugen statt nur links/rechts.

Dolby Atmos und Apple Spatial Audio verfolgen ein ähnliches Ziel wie Ambisonics, basieren jedoch meist auf objektbasierten Workflows. Ambisonics ist dagegen ein kanalbasiertes, feldorientiertes Verfahren. Die räumliche Information steckt im B-Format und wird erst beim Dekodieren an ein konkretes Wiedergabesystem angepasst.

<a id="einstieg-am-icst"></a>
## 6. Einstieg am ICST

- Für Einsteiger:innen: [Quick Start](/icst-ambisonics-plugins/04_quick_start/)
- Starte mit den [ICST Ambisonics Plugins](/icst-ambisonics-plugins/) für DAW-Workflows.
- Nutze die [ICST Ambisonics Tools](/icst-ambisonics-tools/) für Max/MSP-Workflows.
- Höre in [Ascolta](/blog/ascolta/) und nutze die Hörbeispiele als Referenz.
- Gehe weiter mit den [Anleitungen & Tutorials](/post/).

Ambisonics 101: Ten Essential Questions Answered  
[Auf YouTube ansehen](https://www.youtube.com/watch?v=95Hr3T5whsU&t=6s)

---
<a id="begriffssammlung-ambisonics"></a>
## 7. Begriffssammlung Ambisonics (Kurzreferenz)
- **B-Format**: Das Ambisonics-Signalformat, das räumliche Informationen für die spätere Dekodierung speichert.  
  Vertiefung (Wiki): [ICST Ambisonics Plugins Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)
- **Ambisonics-Order**: Räumliche Auflösungsstufe (z. B. 1st, 3rd, 7th order). Höhere Order bedeutet meist präzisere Lokalisation.  
  Vertiefung (Wiki): [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)
- **Encoder**: Codiert eine Mono-/Stereo-Quelle mit Positionsdaten in Ambisonics (B-Format).  
  Vertiefung (Wiki): [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)
- **Decoder**: Dekodiert B-Format für ein Zielsystem (Lautsprecher-Array, binaurale Kopfhörerausgabe usw.).  
  Vertiefung (Wiki): [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)
- **Channel Count**: Anzahl der Kanäle im Ambisonics-Signalpfad; sollte im Routing durchgehend konsistent sein.  
  Vertiefung (Wiki): [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)
- **Speaker Layout**: Physische Lautsprechergeometrie, auf die dekodiert und abgespielt wird.  
  Vertiefung (Wiki): [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)
- **Binaural**: Kopfhörer-Rendering, das räumliche Richtungshinweise simuliert.  
  Vertiefung (Wiki): [ICST Ambisonics Plugins Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)
- **OSC (Open Sound Control)**: Nachrichtenprotokoll zur Echtzeitsteuerung räumlicher Parameter.  
  Vertiefung (Wiki): [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)
- **Yaw / Pitch / Roll**: Rotationsachsen für Orientierung und Bewegung im 3D-Raum.  
  Vertiefung (Wiki): [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)
- **Azimut / Elevation**: Winkelkoordinaten zur Beschreibung horizontaler und vertikaler Quellrichtung.  
  Vertiefung (Wiki): [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)

---

Passende nächste Artikel:
- [Getting Started mit ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)
- [OSC-Syntax für den ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
