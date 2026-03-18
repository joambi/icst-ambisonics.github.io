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
    <li><a href="#was-ist-3d-audio">Was ist 3D-Audio?</a></li>
    <li><a href="#was-ist-ambisonics">Was ist Ambisonics?</a></li>
    <li><a href="#ambisonics-vs-stereo">Ambisonics vs. Stereo</a></li>
    <li><a href="#was-ist-b-format">Was ist B-Format?</a></li>
    <li><a href="#signalfluss">Signalfluss auf einen Blick</a></li>
    <li><a href="#typische-setups">Typische Setups</a></li>
    <li><a href="#kopfhoerer-vs-lautsprecher">Kopfhörer vs. Lautsprecher</a></li>
    <li><a href="#immersive-vs-atmos">Wie unterscheidet sich Ambisonics von Immersive Audio, Dolby Atmos und Spatial Audio?</a></li>
    <li><a href="#einstieg-am-icst">Einstieg am ICST</a></li>
    <li><a href="#ambisonics-mikrofone">Ambisonische Mikrofone — Einstieg</a></li>
    <li><a href="#begriffssammlung-ambisonics">Begriffssammlung Ambisonics (Kurzreferenz)</a></li>
  </ol>
</div>

<a id="was-ist-3d-audio"></a>
## 1. Was ist 3D-Audio?
3D-Audio ist der Oberbegriff für Klang, der nicht nur links und rechts, sondern auch vorne, hinten, oben, unten und in der Tiefe wahrgenommen wird. Statt eines flachen Stereobilds entsteht der Eindruck eines umgebenden akustischen Raums.

Ambisonics ist eine spezielle Methode, um 3D-Audio zu erzeugen und zu speichern. Andere Ansätze sind binaurales Audio für Kopfhörer oder objektbasierte Formate wie Dolby Atmos. 3D-Audio ist also die übergeordnete Kategorie, Ambisonics eine konkrete Methode innerhalb davon.

Zwei kurze Hörbeispiele:

{{< youtube AVnlw7iIPnE >}}

{{< youtube LKTdCq6AhDI >}}

<a id="was-ist-ambisonics"></a>
## 2. [Was ist Ambisonics?](https://de.wikipedia.org/wiki/Ambisonics)
Ambisonics ist eine formatagnostische Methode, um ein räumliches 3D-Klangfeld zu beschreiben. Statt direkt für ein festes Lautsprecher-Layout zu mischen, arbeitet man mit einer räumlichen Repräsentation, die später für unterschiedliche Wiedergabesysteme gerendert werden kann.

<a id="ambisonics-vs-stereo"></a>
## 3. Ambisonics vs. Stereo

Stereo ist vertraut: zwei Kanäle, links und rechts. Es erzeugt die Illusion von Klängen, die entlang einer horizontalen Linie zwischen zwei Lautsprechern positioniert sind. Fügt man einen Centerkanal und Surroundlautsprecher hinzu, entsteht 5.1 oder 7.1 — doch jedes Mal, wenn sich das Lautsprecher-Layout ändert, muss von Grund auf neu gemischt werden.

Ambisonics verfolgt einen anderen Ansatz. Statt direkt für ein Lautsprecher-Layout zu mischen, kodiert man zuerst das räumliche Klangfeld als [B-Format](#gl-b-format) (siehe Abschnitt 3). Diese Repräsentation erfasst, woher Klang aus der gesamten 3D-Sphäre kommt — links, rechts, vorne, hinten, oben, unten. Die Dekodierung auf konkrete Lautsprecher erfolgt erst später, und dieselbe Datei kann für völlig unterschiedliche Setups dekodiert werden, ohne den Mix anzufassen.

| | Stereo | Ambisonics |
|---|---|---|
| **Kanäle** | 2 (L / R) | 4 – 64+ (B-Format) |
| **Räumliche Reichweite** | Links–rechts-Linie | Volle Sphäre (360° × 180°) |
| **Lautsprecherabhängigkeit** | Fest zum Layout beim Mischen | Später auf jedes Layout dekodierbar |
| **Wiederverwendung** | Neuer Mix pro Setup | Eine B-Format-Datei → viele Setups |
| **Typischer Einsatz** | Musik, Rundfunk, Alltagshören | Kunst, Forschung, Installation, Live, Film |

**Wann ist Stereo die bessere Wahl?** Für die meisten Musikveröffentlichungen, Podcasts und Rundfunkanwendungen bleibt Stereo der Standard — es ist mit jedem Wiedergabesystem kompatibel und erfordert keine speziellen Werkzeuge. Ambisonics lohnt sich, wenn die räumliche Dimension des Klangs künstlerisch oder technisch entscheidend ist, oder wenn man eine einzige Master-Datei benötigt, die verschiedene Wiedergabekontexte bedienen soll.

<a id="was-ist-b-format"></a>
## 4. [Was ist B-Format?](https://ambisonic.info/ambisonics/channels.html)

Das B-Format ist das zentrale Signalformat von Ambisonics und enthält die räumlichen Informationen. Klangquellen werden ins B-Format encodiert und anschließend für ein Ziel-Setup dekodiert, etwa für Kopfhörer, Stereo oder verschiedene Lautsprecher-Arrays.

Es beschreibt einen Raumzustand um einen Hörpunkt herum, der aus Druck- und Richtungsanteilen besteht. In der ersten Ordnung bedeutet das:
- `W` ist die omnidirektionale Komponente, also der Druck bzw. die Präsenz im Raum.
- `X`, `Y` und `Z` sind gerichtete Anteile in drei Achsen (vorne-hinten, links-rechts, oben-unten), die angeben, aus welcher Richtung das Signal kommt.

Im engeren, klassischen Sinn bezeichnet "B-Format" dieses vierkanalige Ambisonics-Format erster Ordnung (`W`, `X`, `Y`, `Z`). Im erweiterten Sinn kann man B-Format auch für [höhere Ordnungen](https://en.wikipedia.org/wiki/Ambisonics#Higher-order_Ambisonics) verwenden. Dann umfasst es alle Ambisonics-Koeffizienten bis zu einer bestimmten Ordnung, jeweils als eigener Audiokanal.

Dieses Format kann anschließend auf verschiedene Ziel-Setups dekodiert werden, etwa auf Kopfhörer, Stereo oder Lautsprecher-Arrays. [1](https://en.wikipedia.org/wiki/Ambisonics) [2](https://ambisonic.info/ambisonics/channels.html)

<a id="signalfluss"></a>
## 5. Signalfluss auf einen Blick

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
## 6. [Typische Setups](https://en.wikipedia.org/wiki/Ambisonic_reproduction_systems)
Typische Setups reichen von kleinen Studio-Ringen über Höhenebenen bis hin zu individuellen Arrays im Kompositionsstudio. Dasselbe Ambisonics-Material kann durch Dekodierung an diese verschiedenen Setups angepasst werden.

<a id="kopfhoerer-vs-lautsprecher"></a>
## 7. Kopfhörer vs. Lautsprecher
Kopfhörer arbeiten mit [binauralem Rendering](#gl-binaural) und sind praktisch für Editing, Translation-Checks und die Zusammenarbeit auf Distanz. Lautsprecher erzeugen ein physisches Klangfeld im Raum und bleiben zentral für Komposition, Tiefenwahrnehmung und künstlerische Bewertung.

<a id="immersive-vs-atmos"></a>
## 8. Wie unterscheidet sich Ambisonics von Immersive Audio, Dolby Atmos und Spatial Audio?

Immersive Audio ist ein Oberbegriff für alle 3D-Audioverfahren, die Klang um — und über — die hörende Person herum platzieren, statt nur links und rechts. Ambisonics, [Dolby Atmos](#gl-dolby-atmos) und [Apple Spatial Audio](https://en.wikipedia.org/wiki/Spatial_audio) verfolgen dieses Ziel, aber auf grundlegend unterschiedlichen Wegen.

**Ambisonics ist feldbasiert.** Das Klangfeld wird als mathematische Repräsentation (B-Format) gespeichert, die unabhängig von einem konkreten Lautsprecher-Layout ist. Dieselbe B-Format-Datei lässt sich später für einen Studio-Ring, eine Konzertkuppel, Kopfhörer oder Stereo dekodieren. Das Wiedergabesystem muss zum Produktionszeitpunkt noch nicht feststehen.

**Dolby Atmos und Apple Spatial Audio sind objektbasiert.** Einzelne Klangquellen werden als Audio-Objekte mit Positions-Metadaten gespeichert. Ein lizenzierter Renderer (Dolby Atmos Renderer, Apple-Music-Infrastruktur) platziert sie bei der Abgabe in das Zielwiedergabesystem — Kino, Heimkino oder Kopfhörer.

| | Ambisonics | Dolby Atmos |
|---|---|---|
| **Räumlicher Ansatz** | Feldbasiert (B-Format) | Objektbasiert (Audio + Metadaten) |
| **Lautsprecher-Unabhängigkeit** | Ja — eine Datei, viele Setups | Nein — Render je Zielsystem |
| **Hardware-Abhängigkeit** | Frei, offen, beliebiges Lautsprecher-Array | Lizenzierter Dolby-Renderer erforderlich |
| **Kopfhörerwiedergabe** | Binaural-Decoder (freie Tools) | Dolby Binaural Renderer |
| **Typische Tools** | ICST Plugins, IEM, ATK | Pro Tools + Dolby Renderer, Logic, Nuendo |
| **Kosten** | Kostenlos, Open Source | Kommerzielle Lizenz für Distribution |
| **Typischer Einsatz** | Kunst, Forschung, Installation, Archivierung, Live | Film, Streaming-Musik, Gaming, Consumer-Media |
| **Archivierbarkeit** | Hoch — B-Format ist formatagnostisch | Mittel — an das Dolby-Ökosystem gebunden |

**Wann welches Verfahren:**
Ambisonics ist die bessere Wahl, wenn Lautsprecher-Unabhängigkeit, offene Archivierung oder künstlerisch-wissenschaftlicher Einsatz im Vordergrund stehen. Dolby Atmos ist der Standard für kommerzielle Streaming-Abgabe (Tidal, Apple Music, Amazon Music) und Film — wer diese Kanäle bedienen muss, kommt an Atmos nicht vorbei.

Beide schliessen sich nicht aus: Manche Workflows produzieren Ambisonics für die Archivierung und den künstlerischen Einsatz und liefern daneben ein separates Dolby-Atmos-Render für das Streaming.

<a id="einstieg-am-icst"></a>
## 9. Einstieg am ICST

- Für Einsteiger:innen: [Quick Start](/icst-ambisonics-plugins/04_quick_start/)
- Starte mit den [ICST Ambisonics Plugins](/icst-ambisonics-plugins/) für DAW-Workflows.
- Nutze die [ICST Ambisonics Tools](/icst-ambisonics-tools/) für Max/MSP-Workflows.
- Höre in [Ascolta](/blog/ascolta/) und nutze die Hörbeispiele als Referenz.
- Gehe weiter mit den [Anleitungen & Tutorials](/post/).

**Ambisonics 101: Ten Essential Questions Answered**

{{< youtube 95Hr3T5whsU >}}

---
<a id="ambisonics-mikrofone"></a>
## 10. Ambisonische Mikrofone — Einstieg

Ein Ambisonics-Mikrofon nimmt das vollständige Klangfeld in einer einzigen Aufnahme auf. Anders als Standard-Stereo- oder Surroundmikrofone verwendet es eine tetraedrische Anordnung von vier (oder mehr) Kapseln und gibt ein Rohformat namens [**A-Format**](#gl-a-format) aus, das vor der Verwendung in der DAW in B-Format konvertiert werden muss.

### A-Format und der Enkodierungsschritt

Die meisten tetraedrischen Mikrofone geben A-Format aus: vier rohe Kapselsignale in einer tetraedrischen Geometrie. Diese müssen in B-Format (W, X, Y, Z für erste Ordnung) enkodiert werden, bevor sie in Ambisonics verwendet werden können. Die Enkodierung übernimmt in der Regel die Hersteller-Software — zum Beispiel das SoundField-by-Rode-Plugin, Zylia Studio oder das Sennheiser A-B-Ambisonics-Plugin — oder Tools von Drittanbietern wie [Harpex](https://harpex.net/) oder der IEM AllRADecoder.

Einige Mikrofone (z. B. der Zoom H3-VR) übernehmen dies intern und geben B-Format direkt aus.

### Gängige Mikrofone

| Mikrofon | Ordnung | Kapseln | Ausgabe | Hinweise |
|---|---|---|---|---|
| [Zoom H3-VR](https://zoomcorp.com/en/us/handheld-recorders/handheld-recorders/h3-vr/) | 1. | 4 | A- oder B-Format | Einsteigergerät, integrierter Encoder, gut für Feldaufnahmen |
| [Sennheiser Ambeo VR Mic](https://www.sennheiser.com/en-us/catalog/products/microphones/ambeo-vr-mic/ambeo-vr-mic-506071) | 1. | 4 | A-Format | Weit verbreitet, Enkodierung via Sennheiser A-B-Ambisonics-Plugin |
| [Rode NT-SF1](https://rode.com/en/microphones/studio-condenser/nt-sf1) | 1. | 4 | A-Format | SoundField-by-Rode-Software inklusive |
| [Core Sound TetraMic](https://www.core-sound.com/TetraMic/1.php) | 1. | 4 | A-Format | Bewährtes Gerät, weit verbreitet in Feldaufnahme und Forschung |
| [Zylia ZM-1](https://www.zylia.co/zylia-zm-1-microphone.html) | 3. | 19 | A-Format | Higher-Order, inkl. Zylia Studio Software, gute Ortsauflösung |
| [mh acoustics Eigenmike em32](https://mhacoustics.com/products) | 4. | 32 | A-Format | Professionell / Forschung, sehr hohe Ortsauflösung |

### Im ICST-Workflow

Jede B-Format-Aufnahme — ob von einem Mikrofon erster Ordnung oder [HOA](https://en.wikipedia.org/wiki/Ambisonics#Higher-order_Ambisonics) — kann direkt in eine REAPER-Session geladen und mit dem ICST AmbiDecoder dekodiert werden. Bei HOA-Aufnahmen muss die Ambisonics-Ordnung im Decoder mit der Aufnahmeordnung übereinstimmen.

---
<a id="begriffssammlung-ambisonics"></a>
## 11. Begriffssammlung Ambisonics (Kurzreferenz)

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

---

Passende nächste Artikel:
- [Getting Started mit ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)
- [OSC-Syntax für den ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
