---
title: Ambisonics 101
description: Kompakter Einstieg in Ambisonics, B-Format, typische Setups und praxisnahe Hörsituationen.
slug: ambisonics-101
languageCode: de
layout: single
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
.fig101{margin:1.8rem 0}
.fig101 svg{width:100%;height:auto;max-width:720px;display:block}
.fig101 figcaption{font-size:1.3rem;opacity:.8;margin-top:.6rem}
.post__content table{width:100%;font-size:1.45rem}
.post__content table th,.post__content table td{padding:.9rem 1.2rem;vertical-align:top}
.post__content div[style*="56.25%"]{max-width:560px;width:100%;margin-left:0;margin-right:auto;aspect-ratio:16/9;height:auto !important;padding-bottom:0 !important}
</style>

<div class="toc-card">
  <div class="toc-card__title">Inhaltsverzeichnis</div>
  <ol>
    <li><a href="#was-ist-3d-audio">Was ist 3D-Audio?</a></li>
    <li><a href="#was-ist-ambisonics">Was ist Ambisonics?</a></li>
    <li><a href="#ambisonics-vs-stereo">Ambisonics vs. Stereo</a></li>
    <li><a href="#was-ist-b-format">Was ist B-Format?</a></li>
    <li><a href="/de/learn/ambisonics-formats/">Ambisonics-Formate</a></li>
    <li><a href="#signalfluss">Signalfluss auf einen Blick</a></li>
    <li><a href="#typische-setups">Typische Setups</a></li>
    <li><a href="#kopfhoerer-vs-lautsprecher">Kopfhörer vs. Lautsprecher</a></li>
    <li><a href="#immersive-vs-atmos">Wie unterscheidet sich Ambisonics von Immersive Audio, Dolby Atmos und Spatial Audio?</a></li>
    <li><a href="#einstieg-am-icst">Einstieg am ICST</a></li>
    <li><a href="#ambisonics-mikrofone">Ambisonische Mikrofone — Einstieg</a></li>
    <li><a href="/de/ambisonics-101/glossary/">Begriffssammlung Ambisonics (eigene Seite)</a></li>
  </ol>
</div>

<div class="learn-box" style="border:1px solid var(--border-color,#8886);border-left:4px solid #4a8fe0;border-radius:8px;padding:.4rem 1.4rem;margin:1.6rem 0">

**Das lernst du**

- Was Ambisonics ist und wie es sich von Stereo und kanalbasiertem Audio unterscheidet
- Wie das Signal vom Encoder über den B-Format-Bus zum Decoder fliesst
- Was B-Format ist und welche Setups typisch sind
- Wo du mit den ICST-Tools beginnst

</div>

<a id="was-ist-3d-audio"></a>
## 1. Was ist 3D-Audio?
3D-Audio ist der Oberbegriff für Klang, der nicht nur links und rechts, sondern auch vorne, hinten, oben, unten und in der Tiefe wahrgenommen wird. Statt eines flachen Stereobilds entsteht der Eindruck eines umgebenden akustischen Raums.

Ambisonics ist eine spezielle Methode, um 3D-Audio zu erzeugen und zu speichern. Andere Ansätze sind binaurales Audio für Kopfhörer oder objektbasierte Formate wie Dolby Atmos. 3D-Audio ist also die übergeordnete Kategorie, Ambisonics eine konkrete Methode innerhalb davon.

Zwei kurze Hörbeispiele:

{{< youtube AVnlw7iIPnE >}}

{{< youtube LKTdCq6AhDI >}}

<a id="was-ist-ambisonics"></a>
## 2. Was ist Ambisonics?

Weiterlesen: [de.wikipedia.org](https://de.wikipedia.org/wiki/Ambisonics)

Ambisonics ist eine formatagnostische Methode, um ein räumliches 3D-Klangfeld zu beschreiben. Statt direkt für ein festes Lautsprecher-Layout zu mischen, arbeitet man mit einer räumlichen Repräsentation, die später für unterschiedliche Wiedergabesysteme gerendert werden kann.

<a id="ambisonics-vs-stereo"></a>
## 3. Ambisonics vs. Stereo

<figure class="fig101">
<svg viewBox="0 0 720 235" role="img" aria-label="Stereo platziert Klänge auf einer Linie zwischen zwei Lautsprechern; Ambisonics beschreibt die volle Kugel um die Hörposition." xmlns="http://www.w3.org/2000/svg"><defs><marker id="a1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker><marker id="a1W" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#8a8a8a"/></marker><marker id="a1X" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#d9534f"/></marker><marker id="a1Y" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#3fa968"/></marker><marker id="a1Z" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#4a8fe0"/></marker></defs><text x="180" y="22" text-anchor="middle" font-size="15" font-weight="600" fill="currentColor" fill-opacity="1">Stereo</text><rect x="74" y="89" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="274" y="89" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><line x1="86" y1="95" x2="274" y2="95" stroke="#4a8fe0" stroke-width="3"/><circle cx="180" cy="170" r="11" fill="none" stroke="currentColor" stroke-width="1.8"/><circle cx="180" cy="157" r="2.5" fill="currentColor"/><text x="180" y="215" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">2 Kanäle: eine Linie zwischen zwei Lautsprechern</text><line x1="180" y1="48" x2="180" y2="48" /><text x="540" y="22" text-anchor="middle" font-size="15" font-weight="600" fill="currentColor" fill-opacity="1">Ambisonics</text><ellipse cx="540" cy="120" rx="80" ry="40" fill="none" stroke="currentColor" stroke-opacity=".35" stroke-dasharray="4 3"/><ellipse cx="540" cy="120" rx="80" ry="80" fill="none" stroke="#4a8fe0" stroke-width="2.5" stroke-opacity=".7"/><rect x="607.910362600903" y="144.6146745892072" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="564.6146745892072" y="187.91036260090294" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="503.3853254107928" y="187.91036260090294" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="460.08963739909706" y="144.6146745892072" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="460.08963739909706" y="83.38532541079283" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="503.3853254107928" y="40.089637399097086" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="564.6146745892072" y="40.08963739909707" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="607.9103626009029" y="83.38532541079277" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><circle cx="540" cy="120" r="11" fill="none" stroke="currentColor" stroke-width="1.8"/><circle cx="540" cy="107" r="2.5" fill="currentColor"/><text x="540" y="215" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">Volle Kugel um die Hörposition</text><line x1="360" y1="40" x2="360" y2="200" stroke="currentColor" stroke-opacity=".25"/></svg>
<figcaption>Stereo arbeitet auf einer Linie, Ambisonics auf einer Kugel.</figcaption>
</figure>

Stereo ist vertraut: zwei Kanäle, links und rechts. Es erzeugt die Illusion von Klängen, die entlang einer horizontalen Linie zwischen zwei Lautsprechern positioniert sind. Fügt man einen Centerkanal und Surroundlautsprecher hinzu, entsteht 5.1 oder 7.1 — doch jedes Mal, wenn sich das Lautsprecher-Layout ändert, muss von Grund auf neu gemischt werden.

Ambisonics verfolgt einen anderen Ansatz. Statt direkt für ein Lautsprecher-Layout zu mischen, kodiert man zuerst das räumliche Klangfeld als [B-Format](/de/ambisonics-101/glossary/#gl-b-format) (Abschnitt 4). Diese Repräsentation erfasst, woher Klang aus der gesamten 3D-Sphäre kommt — links, rechts, vorne, hinten, oben, unten. Die Dekodierung auf konkrete Lautsprecher erfolgt erst später, und dieselbe Datei kann für völlig unterschiedliche Setups dekodiert werden, ohne den Mix anzufassen.

| | Stereo | Ambisonics |
|---|---|---|
| **Kanäle** | 2 (L / R) | 4 – 64+ (B-Format) |
| **Räumliche Reichweite** | Links–rechts-Linie | Volle Sphäre (360° × 180°) |
| **Lautsprecherabhängigkeit** | Fest zum Layout beim Mischen | Später auf jedes Layout dekodierbar |
| **Wiederverwendung** | Neuer Mix pro Setup | Eine B-Format-Datei → viele Setups |
| **Typischer Einsatz** | Musik, Rundfunk, Alltagshören | Kunst, Forschung, Installation, Live, Film |

**Wann ist Stereo die bessere Wahl?** Für die meisten Musikveröffentlichungen, Podcasts und Rundfunkanwendungen bleibt Stereo der Standard — es ist mit jedem Wiedergabesystem kompatibel und erfordert keine speziellen Werkzeuge. Ambisonics lohnt sich, wenn die räumliche Dimension des Klangs künstlerisch oder technisch entscheidend ist, oder wenn man eine einzige Master-Datei benötigt, die verschiedene Wiedergabekontexte bedienen soll.

<a id="was-ist-b-format"></a>
## 4. Was ist B-Format?

<figure class="fig101">
<svg viewBox="0 0 720 240" role="img" aria-label="B-Format erster Ordnung: W ist die omnidirektionale Komponente, X, Y und Z sind die drei Richtungsachsen." xmlns="http://www.w3.org/2000/svg"><defs><marker id="a2" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker><marker id="a2W" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#8a8a8a"/></marker><marker id="a2X" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#d9534f"/></marker><marker id="a2Y" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#3fa968"/></marker><marker id="a2Z" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#4a8fe0"/></marker></defs><circle cx="200" cy="125" r="38" fill="#8a8a8a" fill-opacity=".18" stroke="#8a8a8a" stroke-width="1.5" stroke-dasharray="4 3"/><text x="198" y="130" text-anchor="middle" font-size="16" font-weight="700" fill="currentColor" fill-opacity="1">W</text><line x1="200" y1="125" x2="305" y2="63" stroke="#d9534f" stroke-width="2.4" marker-end="url(#a2X)"/><text x="318" y="57" text-anchor="middle" font-size="16" font-weight="700" fill="currentColor" fill-opacity="1">X</text><line x1="200" y1="125" x2="80" y2="105" stroke="#3fa968" stroke-width="2.4" marker-end="url(#a2Y)"/><text x="68" y="107" text-anchor="middle" font-size="16" font-weight="700" fill="currentColor" fill-opacity="1">Y</text><line x1="200" y1="125" x2="200" y2="15" stroke="#4a8fe0" stroke-width="2.4" marker-end="url(#a2Z)"/><text x="212" y="17" text-anchor="middle" font-size="16" font-weight="700" fill="currentColor" fill-opacity="1">Z</text><rect x="400" y="50" width="34" height="30" rx="6" fill="#8a8a8a" fill-opacity=".2" stroke="#8a8a8a" stroke-width="1.5"/><text x="417" y="71" text-anchor="middle" font-size="15" font-weight="700" fill="currentColor" fill-opacity="1">W</text><text x="448" y="71" text-anchor="start" font-size="14" font-weight="400" fill="currentColor" fill-opacity="1">W: omnidirektional (Druck)</text><rect x="400" y="94" width="34" height="30" rx="6" fill="#d9534f" fill-opacity=".2" stroke="#d9534f" stroke-width="1.5"/><text x="417" y="115" text-anchor="middle" font-size="15" font-weight="700" fill="currentColor" fill-opacity="1">X</text><text x="448" y="115" text-anchor="start" font-size="14" font-weight="400" fill="currentColor" fill-opacity="1">X: vorne – hinten</text><rect x="400" y="138" width="34" height="30" rx="6" fill="#3fa968" fill-opacity=".2" stroke="#3fa968" stroke-width="1.5"/><text x="417" y="159" text-anchor="middle" font-size="15" font-weight="700" fill="currentColor" fill-opacity="1">Y</text><text x="448" y="159" text-anchor="start" font-size="14" font-weight="400" fill="currentColor" fill-opacity="1">Y: links – rechts</text><rect x="400" y="182" width="34" height="30" rx="6" fill="#4a8fe0" fill-opacity=".2" stroke="#4a8fe0" stroke-width="1.5"/><text x="417" y="203" text-anchor="middle" font-size="15" font-weight="700" fill="currentColor" fill-opacity="1">Z</text><text x="448" y="203" text-anchor="start" font-size="14" font-weight="400" fill="currentColor" fill-opacity="1">Z: oben – unten</text><text x="200" y="225" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">Hörposition in der Mitte</text></svg>
<figcaption>B-Format erster Ordnung: eine omnidirektionale und drei gerichtete Komponenten.</figcaption>
</figure>

Weiterlesen: [ambisonic.info](https://ambisonic.info/ambisonics/channels.html)

Das B-Format ist das zentrale Signalformat von Ambisonics und enthält die räumlichen Informationen. Klangquellen werden ins B-Format encodiert und anschliessend für ein Ziel-Setup dekodiert, etwa für Kopfhörer, Stereo oder verschiedene Lautsprecher-Arrays.

Es beschreibt einen Raumzustand um einen Hörpunkt herum, der aus Druck- und Richtungsanteilen besteht. In der ersten Ordnung bedeutet das:
- `W` ist die omnidirektionale Komponente, also der Druck bzw. die Präsenz im Raum.
- `X`, `Y` und `Z` sind gerichtete Anteile in drei Achsen (vorne-hinten, links-rechts, oben-unten), die angeben, aus welcher Richtung das Signal kommt.

Im engeren, klassischen Sinn bezeichnet "B-Format" dieses vierkanalige Ambisonics-Format erster Ordnung (`W`, `X`, `Y`, `Z`). Im erweiterten Sinn kann man B-Format auch für [höhere Ordnungen](https://en.wikipedia.org/wiki/Ambisonics#Higher-order_Ambisonics) verwenden. Dann umfasst es alle Ambisonics-Koeffizienten bis zu einer bestimmten Ordnung, jeweils als eigener Audiokanal.

Dieses Format kann anschliessend auf verschiedene Ziel-Setups dekodiert werden, etwa auf Kopfhörer, Stereo oder Lautsprecher-Arrays. [1](https://en.wikipedia.org/wiki/Ambisonics) [2](https://ambisonic.info/ambisonics/channels.html)

Für die praktischen Unterschiede zwischen A-Format, B-Format, FuMa, ambiX, ACN/SN3D, FOA und HOA lies weiter bei [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/).

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
## 6. Typische Setups

<figure class="fig101">
<svg viewBox="0 0 720 235" role="img" aria-label="Drei typische Lautsprecher-Setups von oben: Studio-Ring, Kuppel, individuelles Array. Dasselbe Ambisonics-Material wird für jedes Setup dekodiert." xmlns="http://www.w3.org/2000/svg"><circle cx="120" cy="100" r="62" fill="none" stroke="currentColor" stroke-opacity=".25"/><rect x="171.28053101569978" y="117.72637280663557" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="137.72637280663557" y="151.28053101569978" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="90.27362719336443" y="151.28053101569978" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="56.71946898430022" y="117.72637280663557" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="56.719468984300214" y="70.27362719336443" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="90.2736271933644" y="36.719468984300235" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="137.7263728066356" y="36.71946898430023" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="171.28053101569975" y="70.27362719336439" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><circle cx="120" cy="100" r="9" fill="none" stroke="currentColor" stroke-width="1.8"/><circle cx="120" cy="89" r="2.5" fill="currentColor"/><circle cx="360" cy="100" r="62" fill="none" stroke="currentColor" stroke-opacity=".25"/><rect x="411.2805310156998" y="117.72637280663557" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="377.7263728066356" y="151.28053101569978" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="330.27362719336446" y="151.28053101569978" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="296.7194689843002" y="117.72637280663557" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="296.7194689843002" y="70.27362719336443" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="330.2736271933644" y="36.719468984300235" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="377.7263728066356" y="36.71946898430023" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="411.28053101569975" y="70.27362719336439" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><circle cx="360" cy="100" r="36" fill="none" stroke="currentColor" stroke-opacity=".25" stroke-dasharray="3 3"/><rect x="379.4558441227157" y="119.45584412271572" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="328.5441558772843" y="119.45584412271572" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="328.5441558772843" y="68.54415587728428" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="379.4558441227157" y="68.54415587728428" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="354" y="94" width="12" height="12" rx="2" fill="#4a8fe0" fill-opacity=".85"/><rect x="539" y="49" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="594" y="34" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="654" y="56" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="666" y="109" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="634" y="154" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="574" y="144" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="524" y="119" width="12" height="12" rx="2" fill="currentColor" fill-opacity=".85"/><rect x="554" y="89" width="12" height="12" rx="2" fill="#4a8fe0" fill-opacity=".85"/><circle cx="600" cy="104" r="7" fill="none" stroke="currentColor" stroke-width="1.6"/><text x="120" y="205" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Studio-Ring</text><text x="120" y="222" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">8 Lautsprecher, horizontal</text><text x="360" y="205" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Kuppel mit Höhe</text><text x="360" y="222" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Ring plus oberer Ring und Zenit</text><text x="600" y="205" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Individuelles Array</text><text x="600" y="222" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Unregelmässig, auf den Raum abgestimmt</text></svg>
<figcaption>Dasselbe B-Format-Material speist jedes dieser Setups.</figcaption>
</figure>

Weiterlesen: [en.wikipedia.org](https://en.wikipedia.org/wiki/Ambisonic_reproduction_systems)

Typische Setups reichen von kleinen Studio-Ringen über Höhenebenen bis hin zu individuellen Arrays im Kompositionsstudio. Dasselbe Ambisonics-Material kann durch Dekodierung an diese verschiedenen Setups angepasst werden.

<a id="kopfhoerer-vs-lautsprecher"></a>
## 7. Kopfhörer vs. Lautsprecher
Kopfhörer arbeiten mit [binauralem Rendering](/de/ambisonics-101/glossary/#gl-binaural) und sind praktisch für Editing, Translation-Checks und die Zusammenarbeit auf Distanz. Lautsprecher erzeugen ein physisches Klangfeld im Raum und bleiben zentral für Komposition, Tiefenwahrnehmung und künstlerische Bewertung.

<a id="immersive-vs-atmos"></a>
## 8. Wie unterscheidet sich Ambisonics von Immersive Audio, Dolby Atmos und Spatial Audio?

<figure class="fig101">
<svg viewBox="0 0 720 240" role="img" aria-label="Ambisonics speichert ein Klangfeld und dekodiert es später für jedes Layout; Dolby Atmos speichert Objekte mit Metadaten und rendert sie für das Zielsystem." xmlns="http://www.w3.org/2000/svg"><defs><marker id="a4" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker><marker id="a4W" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#8a8a8a"/></marker><marker id="a4X" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#d9534f"/></marker><marker id="a4Y" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#3fa968"/></marker><marker id="a4Z" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="#4a8fe0"/></marker></defs><text x="10" y="22" text-anchor="start" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Ambisonics: feldbasiert</text><rect x="10" y="34" width="150" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="85.0" y="67.0" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Quellen</text><line x1="162" y1="62" x2="198" y2="62" stroke="currentColor" stroke-width="1.6" marker-end="url(#a4)"/><rect x="200" y="34" width="170" height="56" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="285.0" y="60.0" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">B-Format</text><text x="285.0" y="77.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Klangfeld ohne Lautsprecher</text><line x1="372" y1="62" x2="408" y2="62" stroke="currentColor" stroke-width="1.6" marker-end="url(#a4)"/><rect x="410" y="34" width="110" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="465" y="67" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Decoder</text><line x1="522" y1="62" x2="558" y2="62" stroke="currentColor" stroke-width="1.6" marker-end="url(#a4)"/><rect x="560" y="34" width="150" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="635" y="67" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Layout / Kopfhörer</text><text x="10" y="128" text-anchor="start" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Dolby Atmos: objektbasiert</text><rect x="10" y="140" width="150" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="85.0" y="166.0" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Audio-Objekte</text><text x="85.0" y="183.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Audio + Metadaten</text><line x1="162" y1="168" x2="198" y2="168" stroke="currentColor" stroke-width="1.6" marker-end="url(#a4)"/><rect x="200" y="140" width="170" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="285.0" y="166.0" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Lizenzierter Renderer</text><text x="285.0" y="183.0" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">bei der Abgabe</text><line x1="372" y1="168" x2="408" y2="168" stroke="currentColor" stroke-width="1.6" marker-end="url(#a4)"/><rect x="410" y="140" width="300" height="56" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="560.0" y="173.0" text-anchor="middle" font-size="14" font-weight="600" fill="currentColor" fill-opacity="1">Zielsystem (Kino, Heimkino, Streaming)</text><text x="360" y="222" text-anchor="middle" font-size="12" font-weight="400" fill="currentColor" fill-opacity="0.8">Ambisonics hält die Szene offen; Atmos rendert sie für das Zielsystem.</text></svg>
<figcaption>Feldbasiert oder objektbasiert: Wo die räumliche Entscheidung fällt.</figcaption>
</figure>

Immersive Audio ist ein Oberbegriff für alle 3D-Audioverfahren, die Klang um — und über — die hörende Person herum platzieren, statt nur links und rechts. Ambisonics, [Dolby Atmos](/de/ambisonics-101/glossary/#gl-dolby-atmos) und [Apple Spatial Audio](https://en.wikipedia.org/wiki/Spatial_audio) verfolgen dieses Ziel, aber auf grundlegend unterschiedlichen Wegen.

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

- Deine erste funktionierende Session: [Erste Session in REAPER](/de/post/getting-started-icst-plugins-reaper/)
- Für Einsteiger:innen: [Quick Start](/de/icst-ambisonics-plugins/04_quick_start/)
- Ordnung wählen: [Welche Ambisonics-Ordnung brauche ich?](/de/post/hoa-ordnung-wahl-praxis/)
- Positionen verstehen: [Koordinatensysteme XYZ und AED](/de/post/xyz-vs-aed-koordinatensysteme/)
- Begriffe nachschlagen im [Glossar](/de/ambisonics-101/glossary/)
- Vor dem Setup Formate klären: [Ambisonics-Formate erklärt](/de/learn/ambisonics-formats/)
- Starte mit den [ICST Ambisonics Plugins](/icst-ambisonics-plugins/) für DAW-Workflows.
- Nutze die [ICST Ambisonics Tools](/icst-ambisonics-tools/) für Max/MSP-Workflows.
- Höre in [Ascolta](/blog/ascolta/) und nutze die Hörbeispiele als Referenz.
- Gehe weiter mit den [Anleitungen & Tutorials](/post/).

**Ambisonics 101: Ten Essential Questions Answered**

{{< youtube 95Hr3T5whsU >}}

---
<a id="ambisonics-mikrofone"></a>
## 10. Ambisonische Mikrofone — Einstieg

Ein Ambisonics-Mikrofon nimmt das vollständige Klangfeld in einer einzigen Aufnahme auf. Anders als Standard-Stereo- oder Surroundmikrofone verwendet es eine tetraedrische Anordnung von vier (oder mehr) Kapseln und gibt ein Rohformat namens [**A-Format**](/de/ambisonics-101/glossary/#gl-a-format) aus, das vor der Verwendung in der DAW in B-Format konvertiert werden muss.

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

Passende nächste Artikel:
- [Getting Started mit ICST Ambisonics Plugins in Reaper](/post/getting-started-icst-plugins-reaper/)
- [Ambisonics-Begriffssammlung](/de/ambisonics-101/glossary/)
- [OSC-Syntax für den ICST AmbiEncoder](/post/osc-syntax-for-the-icst-ambiencoder-plugin/)
- [Audio Brewers, Beginner: Ambisonics Made Simple](https://www.audiobrewers.com/faq/Blog%20Post%20Title%20One-3zaa9-9fsz6-j2ed5-dj7rh) (extern): dieselben Grundlagen aus Produzentensicht
- [Audio Brewers, Intermediate: Understanding Ambisonics](https://www.audiobrewers.com/faq/intermediate-understanding-ambisonics) (extern): Kugelflächenfunktionen, Ordnung, ambiX vs. FuMa
