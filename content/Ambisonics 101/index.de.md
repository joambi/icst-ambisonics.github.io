---
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
    <li><a href="#what-is-3d-audio">Was ist 3D-Audio?</a></li>
    <li><a href="#what-is-ambisonics">Was ist Ambisonics?</a></li>
    <li><a href="#ambisonics-vs-stereo">Ambisonics vs. Stereo</a></li>
    <li><a href="#what-is-b-format">Was ist B-Format?</a></li>
    <li><a href="/de/ambisonics-101/formats/">Ambisonics-Formate auf einen Blick</a></li>
    <li><a href="#signal-flow">Signalfluss auf einen Blick</a></li>
    <li><a href="#typical-setups">Typische Setups</a></li>
    <li><a href="#headphones-vs-loudspeakers">Kopfhörer vs. Lautsprecher</a></li>
    <li><a href="#immersive-vs-atmos">Wie unterscheidet sich Ambisonics von Immersive Audio, Dolby Atmos und Spatial Audio?</a></li>
    <li><a href="#where-to-start-at-icst">Wo du am ICST anfängst</a></li>
    <li><a href="#ambisonic-microphones">Ambisonics-Mikrofone — eine praktische Einführung</a></li>
    <li><a href="#ambisonics-glossary">Ambisonics-Glossar (Kurzreferenz)</a></li>
  </ol>
</div>

<a id="what-is-3d-audio"></a>
## 1. Was ist 3D-Audio?
3D-Audio ist der Oberbegriff für Klang, der nicht nur links und rechts wahrgenommen wird, sondern auch vorne, hinten, oben, unten und in der Tiefe. Statt eines flachen Stereobilds entsteht der Eindruck eines umgebenden akustischen Raums.

Ambisonics ist eine bestimmte Art, 3D-Audio zu erzeugen und zu speichern. Andere Ansätze sind binaurales Audio für Kopfhörer und objektbasierte Formate wie Dolby Atmos. In diesem Sinne ist 3D-Audio die breitere Kategorie, und Ambisonics ist eine Methode darin.

Zwei kurze Hörbeispiele:

{{< youtube AVnlw7iIPnE >}}

{{< youtube LKTdCq6AhDI >}}

<a id="what-is-ambisonics"></a>
## 2. [Was ist Ambisonics?](https://en.wikipedia.org/wiki/Ambisonics)
Ambisonics ist eine formatunabhängige Methode, um ein räumliches 3D-Schallfeld zu beschreiben. Statt direkt für ein festes Lautsprecher-Layout zu mischen, arbeitest du mit einer räumlichen Repräsentation, die sich später für verschiedene Wiedergabesysteme rendern lässt.

<a id="ambisonics-vs-stereo"></a>
## 3. Ambisonics vs. Stereo

Stereo ist vertraut: zwei Kanäle, links und rechts. Es erzeugt die Illusion von Klängen, die entlang einer horizontalen Linie zwischen zwei Lautsprechern positioniert sind. Ergänze einen Center-Kanal und Surrounds, und du erhältst 5.1 oder 7.1 — aber jedes Mal, wenn du das Lautsprecher-Layout änderst, musst du von Grund auf neu mischen.

Ambisonics geht einen anderen Weg. Statt direkt für ein Lautsprecher-Layout zu mischen, kodierst du das räumliche Schallfeld zunächst als [B-Format](#gl-b-format) (siehe Abschnitt 4 unten). Diese Repräsentation erfasst, woher der Klang über die gesamte 3D-Sphäre kommt — links, rechts, vorne, hinten, oben, unten. Die Dekodierung auf reale Lautsprecher erfolgt später, und dieselbe Datei kann für völlig unterschiedliche Setups dekodiert werden, ohne den Mix anzufassen.

| | Stereo | Ambisonics |
|---|---|---|
| **Kanäle** | 2 (L / R) | 4 – 64+ (B-Format) |
| **Räumlicher Bereich** | Links–rechts-Linie | Volle Sphäre (360° × 180°) |
| **Lautsprecher-Abhängigkeit** | Beim Mix aufs Layout festgelegt | Später auf beliebiges Layout dekodiert |
| **Wiederverwendung** | Neuer Mix pro Setup | Eine B-Format-Datei → viele Setups |
| **Typischer Einsatz** | Musik, Broadcast, Alltagshören | Kunst, Forschung, Installation, Live, Film |

**Wann ist Stereo sinnvoller?** Für den Großteil der Musikdistribution, Podcasts und Broadcast bleibt Stereo der Standard — es ist mit jedem Wiedergabesystem kompatibel und benötigt keine speziellen Tools. Ambisonics zahlt sich aus, wenn die räumliche Dimension des Klangs künstlerisch oder technisch wichtig ist, oder wenn du eine einzige Master-Datei brauchst, die mehrere Wiedergabekontexte bedienen kann.

<a id="what-is-b-format"></a>
## 4. [Was ist B-Format?](https://ambisonic.info/ambisonics/channels.html)

B-Format ist das zentrale Signalformat in Ambisonics und trägt die räumliche Information. Quellen werden ins B-Format kodiert und dann für ein Zielsetup dekodiert — etwa Kopfhörer, Stereo oder unterschiedliche Lautsprecher-Arrays.

Es beschreibt einen Schallfeld-Zustand um einen Hörpunkt herum mithilfe von Druck- und Richtungskomponenten. In erster Ordnung bedeutet das:
- `W` ist die omnidirektionale Komponente, also der Druck/die Präsenz im Raum.
- `X`, `Y` und `Z` sind Richtungskomponenten entlang dreier Achsen (vorne-hinten, links-rechts, oben-unten) und geben an, woher das Signal kommt.

Im strengen klassischen Sinn bezeichnet „B-Format" dieses vierkanalige Format erster Ordnung (`W`, `X`, `Y`, `Z`). Im erweiterten Sinn wird der Begriff auch für [Higher-Order Ambisonics](https://en.wikipedia.org/wiki/Ambisonics#Higher-order_Ambisonics) verwendet, bei dem alle Ambisonics-Koeffizienten bis zu einer bestimmten Ordnung als separate Audiokanäle repräsentiert werden.

Dieses Format kann anschließend für verschiedene Zielsysteme dekodiert werden, etwa Kopfhörer, Stereo oder Lautsprecher-Arrays. [1](https://en.wikipedia.org/wiki/Ambisonics) [2](https://ambisonic.info/ambisonics/channels.html)

Zu den praktischen Unterschieden zwischen A-Format, B-Format, FuMa, ambiX, ACN/SN3D, FOA und HOA geht es weiter mit [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/).

<a id="signal-flow"></a>
## 5. Signalfluss auf einen Blick

Von der Quelle zum Lautsprecher — so funktioniert Ambisonics in REAPER mit den ICST-Plugins:

![Ambisonics-Signalfluss — einzelne Quelle](/images/signalflow-simple.svg)

*Einzelne Quelle: Mono-Spur → AmbiEncoder (Az/El/Dist) → B-Format-Bus → AmbiDecoder → Lautsprecher oder Binaural.*

![Ambisonics-Signalfluss — Multi-Source (ICST MultiEncoder)](/images/signalflow-multi.svg)

*Mehrere Quellen: bis zu 64 Quellen speisen gleichzeitig in den ICST MultiEncoder → gemeinsamer B-Format-Bus → einmalig dekodiert.*

<a id="typical-setups"></a>
## 6. [Typische Setups](https://en.wikipedia.org/wiki/Ambisonic_reproduction_systems)
Übliche Setups reichen von kleinen Studio-Ringen und kuppelartigen Höhenkonfigurationen bis zu individuellen Arrays in Kompositionsstudios. Dasselbe Ambisonics-Material lässt sich durch Dekodierung an jedes dieser Setups anpassen.

<a id="headphones-vs-loudspeakers"></a>
## 7. Kopfhörer vs. Lautsprecher
Kopfhörer nutzen [binaurales Rendering](#gl-binaural) und sind praktisch zum Editieren, zum Prüfen der Übersetzung und für Remote-Zusammenarbeit. Lautsprecher liefern ein physisches räumliches Feld im Raum und bleiben unverzichtbar für Komposition, Tiefenwahrnehmung und künstlerische Beurteilung.

<a id="immersive-vs-atmos"></a>
## 8. Wie unterscheidet sich Ambisonics von Immersive Audio, Dolby Atmos und Spatial Audio?

Immersive Audio ist ein Oberbegriff für jeden 3D-Audio-Ansatz, der Klang rund um — und über — den Hörer platziert statt nur links und rechts. Ambisonics, [Dolby Atmos](#gl-dolby-atmos) und [Apple Spatial Audio](https://en.wikipedia.org/wiki/Spatial_audio) verfolgen alle dieses Ziel, tun das aber auf grundlegend unterschiedliche Weise.

**Ambisonics ist feldbasiert.** Das Schallfeld wird als mathematische Repräsentation (B-Format) kodiert, die von jedem konkreten Lautsprecher-Layout unabhängig ist. Dieselbe B-Format-Datei kann später für einen Studio-Ring, eine Konzertkuppel, Kopfhörer oder Stereo dekodiert werden. Das Wiedergabesystem muss zum Produktionszeitpunkt nicht feststehen.

**Dolby Atmos und Apple Spatial Audio sind objektbasiert.** Einzelne Klangquellen werden als Audio-Objekte mit Positions-Metadaten gespeichert. Ein lizenzierter Renderer (Dolby Atmos Renderer, Apple-Music-Infrastruktur) platziert sie zum Auslieferungszeitpunkt in ein Zielsystem — sei es ein Kino, ein Heimkino oder Kopfhörer.

| | Ambisonics | Dolby Atmos |
|---|---|---|
| **Räumlicher Ansatz** | Feldbasiert (B-Format) | Objektbasiert (Audio + Metadaten) |
| **Lautsprecher-Unabhängigkeit** | Ja — eine Datei, viele Layouts | Nein — Rendering pro Zielsystem |
| **Hardware-Abhängigkeit** | Frei, offen, beliebiges Lautsprecher-Array | Benötigt lizenzierten Dolby-Renderer |
| **Kopfhörer-Wiedergabe** | Binauraler Decoder (freie Tools) | Dolby-Binaural-Renderer |
| **Typische Tools** | ICST Plugins, IEM, ATK | Pro Tools + Dolby Renderer, Logic, Nuendo |
| **Kosten** | Kostenlos, Open Source | Kommerzielle Lizenzierung für Distribution |
| **Typischer Einsatz** | Kunst, Forschung, Installation, Archivierung, Live | Film, Streaming-Musik, Gaming, Consumer-Medien |
| **Archivierbarkeit** | Hoch — B-Format ist formatunabhängig | Mittel — an Dolby-Ökosystem gebunden |

**Wann was verwenden:**
Ambisonics ist die bessere Wahl, wenn Lautsprecher-Layout-Unabhängigkeit, offene Archivierung oder Forschungs- und künstlerische Nutzung im Vordergrund stehen. Dolby Atmos ist der Standard für kommerzielle Streaming-Auslieferung (Tidal, Apple Music, Amazon Music) und Film — wenn du diese Kanäle erreichen musst, ist Atmos die praktische Voraussetzung.

Die beiden schließen sich nicht aus: Manche Workflows produzieren Ambisonics für Archivierung und künstlerische Nutzung und liefern separat einen Dolby-Atmos-Render fürs Streaming.

<a id="where-to-start-at-icst"></a>
## 9. Wo du am ICST anfängst

- Für Einsteiger:innen: [Quick Start](/icst-ambisonics-plugins/04_quick_start/)
- Formate vor dem Setup klären: [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/)
- Beginne mit den [ICST Ambisonics Plugins](/icst-ambisonics-plugins/) für DAW-Workflows.
- Nutze die [ICST Ambisonics Tools](/icst-ambisonics-tools/) für Max/MSP-Workflows.
- Entdecke [Ascolta](/blog/ascolta/) für Hörpraxis und Referenzen.
- Weiter geht es mit Tutorials und Artikeln in [Blog & Tutorials](/post/).

**Ambisonics 101: Zehn wesentliche Fragen beantwortet**

{{< youtube 95Hr3T5whsU >}}

---
<a id="ambisonic-microphones"></a>
## 10. Ambisonics-Mikrofone — eine praktische Einführung

Ein Ambisonics-Mikrofon erfasst das Schallfeld der gesamten Sphäre in einer einzigen Aufnahme. Anders als übliche Stereo- oder Surround-Mikrofone nutzt es eine tetraedrische Anordnung von vier (oder mehr) Kapseln und gibt ein Rohformat namens [**A-Format**](#gl-a-format) aus, das vor der Verwendung in deiner DAW ins B-Format konvertiert werden muss.

### A-Format und der Encoding-Schritt

Die meisten tetraedrischen Mikrofone geben A-Format aus: vier rohe Kapselsignale in tetraedrischer Geometrie. Dieses muss ins B-Format kodiert werden (W, X, Y, Z für erste Ordnung), bevor du mit der Aufnahme in Ambisonics arbeitest. Das Encoding übernimmt meist eine dedizierte Software des Herstellers — zum Beispiel das SoundField-by-Rode-Plugin, Zylia Studio oder das Sennheiser-A-B-Ambisonics-Plugin — oder Drittanbieter-Tools wie [Harpex](https://harpex.net/) oder der IEM AllRADecoder.

Einige Mikrofone (z. B. das Zoom H3-VR) erledigen das intern und geben direkt B-Format aus.

### Übliche Mikrofone

| Mikrofon | Ordnung | Kapseln | Ausgabe | Anmerkungen |
|---|---|---|---|---|
| [Zoom H3-VR](https://zoomcorp.com/en/us/handheld-recorders/handheld-recorders/h3-vr/) | 1. | 4 | A- oder B-Format | Einsteiger-Klasse, integrierter Encoder, gut für Field Recording |
| [Sennheiser Ambeo VR Mic](https://www.sennheiser.com/en-us/catalog/products/microphones/ambeo-vr-mic/ambeo-vr-mic-506071) | 1. | 4 | A-Format | Weit verbreitet, benötigt Sennheiser-A-B-Ambisonics-Plugin zum Encoding |
| [Rode NT-SF1](https://rode.com/en/microphones/studio-condenser/nt-sf1) | 1. | 4 | A-Format | SoundField-by-Rode-Software enthalten |
| [Core Sound TetraMic](https://www.core-sound.com/TetraMic/1.php) | 1. | 4 | A-Format | Lange etabliert, weit verbreitet in Field Recording und Forschung |
| [Zylia ZM-1](https://www.zylia.co/zylia-zm-1-microphone.html) | 3. | 19 | A-Format | Höhere Ordnung, inkl. Zylia-Studio-Software, gute räumliche Auflösung |
| [mh acoustics Eigenmike em32](https://mhacoustics.com/products) | 4. | 32 | A-Format | Professionell/Forschungsklasse, sehr hohe räumliche Auflösung |

### Im ICST-Workflow

Jede B-Format-Aufnahme — ob von einem Mikrofon erster Ordnung oder [HOA](https://en.wikipedia.org/wiki/Ambisonics#Higher-order_Ambisonics) — kann direkt in eine REAPER-Session geladen und mit dem ICST AmbiDecoder dekodiert werden. Achte bei HOA-Aufnahmen darauf, dass die Ambisonics-Ordnung im Decoder mit der Aufnahmeordnung übereinstimmt.

---
<a id="ambisonics-glossary"></a>
## 11. Ambisonics-Glossar (Kurzreferenz)

- <a id="gl-a-format"></a>**A-Format** — Rohsignal eines tetraedrischen Ambisonics-Mikrofons: vier Kapselsignale in tetraedrischer Geometrie. Muss vor der Verwendung in einer DAW ins B-Format kodiert werden.
  → [Wikipedia: Ambisonics](https://en.wikipedia.org/wiki/Ambisonics#A-format)

- <a id="gl-b-format"></a>**B-Format** — Das Ambisonics-Trägersignal: kodiert das räumliche Schallfeld als Kugelflächenfunktionen. Erste Ordnung = 4 Kanäle (W, X, Y, Z); siebte Ordnung = 64 Kanäle.
  → [Wikipedia: Ambisonics](https://en.wikipedia.org/wiki/Ambisonics) | [ICST Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)

- <a id="gl-ambix"></a>**ambiX** — Standardisiertes Ambisonics-Dateiformat (ACN-Kanalreihenfolge, SN3D-Normalisierung); der De-facto-Standard für HOA-Austausch und Archivierung.
  → [ambiX-Spezifikation (IEM)](https://ambisonics.iem.at/proceedings-of-the-ambisonics-symposium-2011/ambix-a-suggested-ambisonics-format)

- <a id="gl-order"></a>**Ambisonics-Ordnung** — Grad der räumlichen Auflösung: 1. Ordnung = 4 Kanäle, 3. = 16, 7. = 64. Höhere Ordnung bedeutet feinere Lokalisation und mehr Kanäle.
  → [Wikipedia: Higher-order Ambisonics](https://en.wikipedia.org/wiki/Ambisonics#Higher-order_Ambisonics) | [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)

- <a id="gl-encoder"></a>**Encoder** — Wandelt eine Mono-/Stereo-Quelle mit Positionsdaten (Azimut, Elevation, Distanz) ins B-Format.
  → [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)

- <a id="gl-decoder"></a>**Decoder** — Rendert B-Format auf ein Ziel-Wiedergabesystem: Lautsprecher-Array oder Binaural.
  → [ICST AmbiDecoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)

- <a id="gl-channel-count"></a>**Kanalanzahl** — Anzahl der Kanäle im Ambisonics-Signalweg; muss über das gesamte Routing hinweg konsistent bleiben.
  → [ICST Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)

- <a id="gl-speaker-layout"></a>**Lautsprecher-Layout** — Physische Lautsprecher-Geometrie, auf die der Decoder das B-Format rendert.
  → [Wikipedia: Ambisonic reproduction systems](https://en.wikipedia.org/wiki/Ambisonic_reproduction_systems)

- <a id="gl-binaural"></a>**Binaural / HRTF** — Kopfhörer-Rendering über Head-Related Transfer Functions (HRTFs): simuliert räumliche Richtungshinweise ohne Lautsprecher. Ermöglicht Ambisonics-Monitoring auf jedem Kopfhörer.
  → [Wikipedia: Binaural recording](https://en.wikipedia.org/wiki/Binaural_recording) | [Wikipedia: HRTF](https://en.wikipedia.org/wiki/Head-related_transfer_function)

- <a id="gl-dolby-atmos"></a>**Dolby Atmos** — Objektbasiertes 3D-Audioformat: Klangquellen werden als Audio-Objekte mit Positions-Metadaten gespeichert; ein lizenzierter Renderer platziert sie im Zielsystem (Kino, Heimkino, Streaming-Dienste).
  → [dolby.com](https://www.dolby.com/technologies/dolby-atmos/) | [Wikipedia: Dolby Atmos](https://en.wikipedia.org/wiki/Dolby_Atmos)

- <a id="gl-osc"></a>**OSC (Open Sound Control)** — Netzwerkprotokoll (UDP/IP) zur Echtzeitsteuerung räumlicher Parameter.
  → [opensoundcontrol.stanford.edu](https://opensoundcontrol.stanford.edu/) | [ICST AmbiEncoder](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder)

- <a id="gl-yaw"></a>**Yaw / Pitch / Roll** — Rotationsachsen im 3D-Raum: Yaw = horizontal (links/rechts), Pitch = vertikal (oben/unten), Roll = Neigung.
  → [Wikipedia: Euler angles](https://en.wikipedia.org/wiki/Euler_angles)

- <a id="gl-azimuth"></a>**Azimut / Elevation** — Polarkoordinaten für die Quellrichtung: Azimut = horizontaler Winkel (0°–360°), Elevation = vertikaler Winkel (−90° bis +90°).
  → [Wikipedia: Horizontal coordinate system](https://en.wikipedia.org/wiki/Horizontal_coordinate_system)  

---

Verwandte weiterführende Lektüre:
- [Erste Schritte mit den ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)
- [OSC-Syntax für den ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
