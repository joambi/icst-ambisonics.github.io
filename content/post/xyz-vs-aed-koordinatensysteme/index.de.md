---
title: XYZ und AED – Zwei Koordinatensysteme, ein Lautsprecher
description: "Der ICST AmbiDecoder erlaubt die Eingabe von Lautsprecherpositionen sowohl in kartesischen (XYZ) als auch in Polarkoordinaten (AED). Dieser Artikel erklärt den Unterschied und wann welches System sinnvoll ist."
date: 2026-03-21T10:30:00+01:00
year: 2026
month: 2026-03
weight: 31
tags: ["decoder", "koordinaten", "xyz", "aed", "lautsprecher", "setup", "konfiguration"]
key_points:
  - "XYZ beschreibt Positionen im euklidischen Raum – ideal für eingemessene Installationen"
  - "AED (Azimut, Elevation, Distanz) orientiert sich an Hörwahrnehmung und Kompassrichtungen"
  - "Beide Systeme sind jederzeit parallel im Decoder sichtbar und editierbar"
difficulty: "beginner"
post_kind: "reference"
tool: ["AmbiDecoder"]
---

Level: Beginner | **Audience:** Techniker:in, Komponist:in, Studierende.

Diese Seite erklärt, warum der ICST AmbiDecoder zwei Koordinatensysteme anbietet und wie du entscheidest, welches du verwenden solltest.

> **Gemeinsamer Kernsatz dieser Decoder-Serie:** Der Decoder erzeugt den Raum nicht neu, sondern projiziert ein B-Format-Feld auf ein reales System.
>
> In diesem Artikel geht es um den ersten Schritt dieser Projektion: **Geometrie**. Koordinaten bestimmen, **wo** der Decoder Lautsprecher im Raum verortet.

---

<figure data-gen="g24" style="margin:1.8rem 0">
<video controls muted loop playsinline preload="metadata" poster="/videos/xyz-vs-aed-de-poster.jpg" src="/videos/xyz-vs-aed-de.mp4" style="width:100%;max-width:720px;height:auto;display:block;border-radius:8px"></video>
<figcaption style="font-size:.9em;opacity:.8;margin-top:.4rem">Video: dieselbe Position als Azimut, Elevation, Distanz und als X, Y, Z (ca. 14 Sekunden).</figcaption>
</figure>

## Das Problem: Wie beschreibt man, wo ein Lautsprecher steht?

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 350" role="img" aria-label="Derselbe Punkt in XYZ und in AED" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="170" y="24" text-anchor="middle" font-weight="600">XYZ</text><text x="170" y="42" text-anchor="middle" font-size="11">kartesisch</text><line x1="40" y1="200" x2="305" y2="200" stroke="currentColor" stroke-width="1.3" opacity="0.7" marker-end="url(#ar1)"/><line x1="170" y1="310" x2="170" y2="75" stroke="currentColor" stroke-width="1.3" opacity="0.7" marker-end="url(#ar1)"/><text x="304" y="216" text-anchor="end" font-size="12">+X</text><text x="178" y="78" text-anchor="start" font-size="12">+Y</text><line x1="224.0" y1="106.5" x2="224.0" y2="200" stroke="#4a8fe0" stroke-width="1.2" opacity="1" stroke-dasharray="4 3"/><line x1="224.0" y1="106.5" x2="170" y2="106.5" stroke="#4a8fe0" stroke-width="1.2" opacity="1" stroke-dasharray="4 3"/><circle cx="224.0" cy="106.5" r="7" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="236.0" y="96.5" text-anchor="start" font-weight="600" fill="#d9534f">P</text><text x="224.0" y="218" text-anchor="middle" fill="#4a8fe0" font-size="12">x = 1,5</text><text x="162" y="110.5" text-anchor="end" fill="#4a8fe0" font-size="12">y = 2,6</text><text x="42" y="192" text-anchor="start" font-size="11">links</text><text x="298" y="192" text-anchor="end" font-size="11">rechts</text><text x="540" y="24" text-anchor="middle" font-weight="600">AED</text><text x="540" y="42" text-anchor="middle" font-size="11">polar</text><circle cx="540" cy="200" r="108" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><line x1="418" y1="200" x2="662" y2="200" stroke="currentColor" stroke-width="1" opacity="0.35"/><line x1="540" y1="78" x2="540" y2="322" stroke="currentColor" stroke-width="1" opacity="0.35"/><circle cx="540" cy="200" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="540" y="72" text-anchor="middle" font-size="11">vorne</text><line x1="540" y1="200" x2="594.0" y2="106.5" stroke="#d9534f" stroke-width="1.6" opacity="1"/><circle cx="594.0" cy="106.5" r="7" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="606.0" y="96.5" text-anchor="start" font-weight="600" fill="#d9534f">P</text><path d="M540.0,150.0 A50,50 0 0 1 565.0,156.7" fill="none" stroke="#4a8fe0" stroke-width="2"/><text x="532" y="138" text-anchor="end" fill="#4a8fe0" font-size="12">A = 30°</text><text x="577.0" y="171.25" text-anchor="start" fill="#4a8fe0" font-size="12">D = 3 m</text><text x="418" y="192" text-anchor="end" font-size="11">links</text><text x="662" y="192" text-anchor="start" font-size="11">rechts</text><text x="360" y="342" text-anchor="middle" font-weight="600" font-size="12">Derselbe Punkt, zwei Beschreibungen – der Decoder zeigt immer beide</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Eine Lautsprecherposition, zwei Beschreibungen: als Abstände entlang der Achsen (links) oder als Winkel plus Distanz vom Zentrum (rechts).</figcaption>
</figure>














Ein Lautsprecher im Raum hat eine Position – aber diese Position lässt sich auf verschiedene Arten beschreiben. Der ICST AmbiDecoder bietet zwei Systeme gleichzeitig an:

- **XYZ** – Kartesische Koordinaten (euklidischer Raum)
- **AED** – Polarkoordinaten: Azimut, Elevation, Distanz

Beide Systeme beschreiben denselben Punkt im Raum. Der Decoder rechnet intern mit XYZ, zeigt aber immer beide Werte an. Du kannst jederzeit in beiden Systemen editieren – Doppelklick auf ein Parameterfeld genügt.

---

## XYZ – Kartesische Koordinaten

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 320" role="img" aria-label="XYZ-Achsen und ein Punkt" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><line x1="90" y1="270" x2="362.0" y2="270.0" stroke="currentColor" stroke-width="1.3" opacity="0.7" marker-end="url(#ar2)"/><line x1="134.0" y1="295.5" x2="280.4" y2="191.8" stroke="currentColor" stroke-width="1.3" opacity="0.7" marker-end="url(#ar2)"/><line x1="170.0" y1="282.0" x2="170.0" y2="98.0" stroke="currentColor" stroke-width="1.3" opacity="0.7" marker-end="url(#ar2)"/><text x="370.0" y="274.0" text-anchor="start" font-weight="600" fill="#4a8fe0">+X</text><text x="288.4" y="193.8" text-anchor="start" font-weight="600" fill="#3fa968">+Y</text><text x="178.0" y="102.0" text-anchor="start" font-weight="600" fill="#d9534f">+Z</text><line x1="362" y1="219" x2="362" y2="139" stroke="#d9a441" stroke-width="1.4" opacity="1" stroke-dasharray="4 3"/><line x1="362" y1="219" x2="290" y2="270" stroke="#4a8fe0" stroke-width="1.2" opacity="1" stroke-dasharray="4 3"/><line x1="362" y1="219" x2="242" y2="219" stroke="#3fa968" stroke-width="1.2" opacity="1" stroke-dasharray="4 3"/><circle cx="362" cy="219" r="3" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="362" cy="139" r="7" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="374" y="131" text-anchor="start" font-weight="600" fill="#d9534f">P (x, y, z)</text><circle cx="170" cy="270" r="4" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="162" y="286" text-anchor="end" font-size="11">Zentrum</text><rect x="490" y="130" width="210" height="130" rx="8" fill="currentColor" fill-opacity="0.12" stroke="currentColor" stroke-width="1.5" opacity="1"/><circle cx="508" cy="162" r="6" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><text x="522" y="167" text-anchor="start" font-size="12">X: links (−) / rechts (+)</text><circle cx="508" cy="196" r="6" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><text x="522" y="201" text-anchor="start" font-size="12">Y: hinten (−) / vorne (+)</text><circle cx="508" cy="230" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="522" y="235" text-anchor="start" font-size="12">Z: unten (−) / oben (+)</text><text x="360" y="24" text-anchor="middle" font-weight="600">Kartesisch XYZ: drei Abstände vom Zentrum</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">XYZ: Die Position ist die Summe dreier Schritte entlang X, Y und Z – genau das, was eine Lasermessung oder ein CAD-Export liefert.</figcaption>
</figure>














XYZ beschreibt die Position eines Lautsprechers als Punkt im dreidimensionalen euklidischen Raum:

- **X** – Richtung links/rechts (negativ = links, positiv = rechts)
- **Y** – Richtung vorne/hinten (positiv = vorne, negativ = hinten)
- **Z** – Richtung oben/unten (positiv = oben, negativ = unten)

**Wann XYZ verwenden?** Immer dann, wenn du Messdaten aus einem Laservermessungsgerät, einer CAD-Zeichnung oder einer Architekturdokumentation hast. Solche Daten liegen fast immer in kartesischen Koordinaten vor. Du kannst sie direkt in den Decoder übertragen, ohne umzurechnen.

XYZ-Eingabe ist präzise und reproduzierbar. Sie eignet sich besonders für:

- Konzertinstallationen mit eingemessenen Lautsprechern
- wissenschaftliche Forschungsumgebungen
- Setups, die zwischen Aufführungsorten übertragen werden sollen

---

## AED – Azimut, Elevation, Distanz

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Azimut und Elevation" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="180" y="24" text-anchor="middle" font-weight="600">Draufsicht: Azimut A</text><circle cx="180" cy="160" r="100" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><line x1="66" y1="160" x2="294" y2="160" stroke="currentColor" stroke-width="1" opacity="0.35"/><line x1="180" y1="46" x2="180" y2="274" stroke="currentColor" stroke-width="1" opacity="0.35"/><circle cx="180" cy="160" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="180.0" y="42.0" text-anchor="middle" font-weight="600" font-size="12">0°</text><text x="302.0" y="164.0" text-anchor="middle" font-weight="600" font-size="12">90°</text><text x="180.0" y="286.0" text-anchor="middle" font-weight="600" font-size="12">180°</text><text x="58.0" y="164.0" text-anchor="middle" font-weight="600" font-size="12">270°</text><line x1="180" y1="160" x2="256.6" y2="95.7" stroke="#d9534f" stroke-width="1.6" opacity="1"/><circle cx="256.6" cy="95.7" r="7" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><path d="M180.0,115.0 A45,45 0 0 1 214.5,131.1" fill="none" stroke="#4a8fe0" stroke-width="2"/><text x="192" y="108" text-anchor="start" font-weight="600" fill="#4a8fe0">A</text><text x="180" y="298" text-anchor="middle" font-size="11">0° vorne, 90° rechts, 180° hinten, 270° links</text><text x="540" y="24" text-anchor="middle" font-weight="600">Seitenansicht: Elevation E</text><line x1="430" y1="160" x2="650" y2="160" stroke="currentColor" stroke-width="1.2" opacity="0.5"/><line x1="540" y1="265" x2="540" y2="55" stroke="currentColor" stroke-width="1.2" opacity="0.35"/><circle cx="540" cy="160" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="654" y="164" text-anchor="start" font-size="11">E = 0°</text><text x="540" y="48" text-anchor="middle" font-size="11">+90°</text><text x="540" y="284" text-anchor="middle" font-size="11">−90°</text><line x1="540" y1="160" x2="621.9152044288992" y2="102.64235636489539" stroke="#d9534f" stroke-width="1.6" opacity="1"/><circle cx="621.9152044288992" cy="102.64235636489539" r="7" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><path d="M590,160 A50,50 0 0 0 581.0,131.3" fill="none" stroke="#4a8fe0" stroke-width="2"/><text x="598" y="148" text-anchor="start" font-weight="600" fill="#4a8fe0">E</text><text x="574.9576022144496" y="123.32117818244768" text-anchor="end" font-weight="600" fill="#4a8fe0">D</text><text x="540" y="298" text-anchor="middle" font-size="11">0° Horizont, +90° direkt oben</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">AED: Der Azimut wird in der Horizontalebene gemessen, die Elevation vom Horizont nach oben, die Distanz entlang der Linie zum Lautsprecher.</figcaption>
</figure>














AED beschreibt dieselbe Position wahrnehmungsorientiert, ausgehend vom Zentrum des Hörraums:

- **A (Azimut)** – horizontaler Winkel in Grad (0° = vorne, 90° = rechts, 180° / -180° = hinten, 270° / -90° = links; im Uhrzeigersinn, wie ein Kompass)
- **E (Elevation)** – vertikaler Winkel in Grad (0° = Horizontalebene, +90° = direkt oben, -90° = direkt unten)
- **D (Distanz)** – Abstand des Lautsprechers vom Zentrum in Metern

**Wann AED verwenden?** Wenn du intuitiv nach Richtung und Höhe denkst, nicht nach Koordinaten. AED entspricht der Art, wie Menschen Richtung beschreiben: „Der Lautsprecher hängt links oben, 45° seitlich und 30° erhöht."

AED ist besonders nützlich für:

- schnelle manuelle Konfiguration symmetrischer Arrays
- konzeptuelle Planung von Lautsprecheranordnungen
- Anpassungen im Betrieb, wenn die Geometrie im Kopf schon klar ist

---

## Beide Systeme gleichzeitig

Im Speaker-Parameter-Editor des ICST AmbiDecoders siehst du für jeden Lautsprecher immer beide Darstellungen:

```
Cartesian XYZ:   -1.186    3.110    0.000
Polar AED:        339.12   0.00     3.328
```

Änderst du einen Wert in XYZ, aktualisiert sich AED automatisch – und umgekehrt. Du verlierst keine Präzision, egal welches System du verwendest.

> **Tipp:** Doppelklick auf ein Parameterfeld öffnet die direkte numerische Eingabe. So kannst du Messwerte ohne Umrechnungsfehler übertragen.

---

## Typisches Praxisszenario

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Oktagon-Array in AED" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar4" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><circle cx="200" cy="155" r="100" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><circle cx="200" cy="155" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="200" y="22" text-anchor="middle" font-size="11">vorne</text><rect x="182.0" y="43.0" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#d9534f" stroke-width="1.5" opacity="1"/><text x="200.0" y="59.0" text-anchor="middle" font-size="11">LS 1</text><rect x="252.7" y="72.3" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="270.7" y="88.3" text-anchor="middle" font-size="11">LS 2</text><rect x="282.0" y="143.0" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="300.0" y="159.0" text-anchor="middle" font-size="11">LS 3</text><rect x="252.7" y="213.7" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="270.7" y="229.7" text-anchor="middle" font-size="11">LS 4</text><rect x="182.0" y="243.0" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="200.0" y="259.0" text-anchor="middle" font-size="11">LS 5</text><rect x="111.30000000000001" y="213.7" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="129.3" y="229.7" text-anchor="middle" font-size="11">LS 6</text><rect x="82.0" y="143.0" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="100.0" y="159.0" text-anchor="middle" font-size="11">LS 7</text><rect x="111.30000000000001" y="72.3" width="36" height="24" rx="5" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="129.3" y="88.3" text-anchor="middle" font-size="11">LS 8</text><path d="M200.0,115.0 A40,40 0 0 1 238.6,144.6" fill="none" stroke="#d9a441" stroke-width="2" marker-end="url(#ar4)"/><text x="200" y="187" text-anchor="middle" font-size="10"></text><text x="200" y="290" text-anchor="middle" font-size="11">Nummerierung im Uhrzeigersinn, mit wachsendem Azimut</text><text x="470" y="70" text-anchor="start" font-weight="600">Alle acht Lautsprecher:</text><text x="470" y="104" text-anchor="start" font-size="13">E = 0°  (Ohrhöhe)</text><text x="470" y="134" text-anchor="start" font-size="13">D = 3,0 m</text><text x="470" y="164" text-anchor="start" font-size="13">A = 0°, 45°, 90° … 315°</text><text x="470" y="206" text-anchor="start" fill="#d9534f" font-size="11">LS 1 (rot) steht genau vorne.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Oktagon: Nur der Azimut ändert sich von Lautsprecher zu Lautsprecher – in XYZ bräuchte jede Position Sinus und Cosinus.</figcaption>
</figure>














**Szenario:** Du baust ein Oktagon-Array auf (8 Lautsprecher gleichmässig im Kreis, alle auf Ohrhöhe, alle 3 Meter vom Zentrum entfernt).

Mit **AED** geht das schnell:

| Lautsprecher | Azimut (A) | Elevation (E) | Distanz (D) |
|---|---|---|---|
| LS 1 | 0° | 0° | 3.0 m |
| LS 2 | 45° | 0° | 3.0 m |
| LS 3 | 90° | 0° | 3.0 m |
| LS 4 | 135° | 0° | 3.0 m |
| LS 5 | 180° | 0° | 3.0 m |
| ... | ... | ... | ... |

Mit **XYZ** wäre dafür Trigonometrie nötig. AED ist hier eindeutig schneller.

**Gegenbeispiel:** Du hast ein Konzertsaal-Setup eingemessen und erhältst die Positionen als CAD-Export. Die Koordinaten liegen als `X=2.45, Y=-3.11, Z=1.20` vor. Hier nimmst du die XYZ-Werte direkt – keine Umrechnung, kein Fehler.

---

## Häufige Fehlerquelle: Azimut-Konvention

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 334" role="img" aria-label="Azimut-Konvention im Vergleich" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar5" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><text x="180" y="24" text-anchor="middle" font-weight="600">ICST AmbiDecoder</text><circle cx="180" cy="170" r="95" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><line x1="71" y1="170" x2="289" y2="170" stroke="currentColor" stroke-width="1" opacity="0.35"/><line x1="180" y1="61" x2="180" y2="279" stroke="currentColor" stroke-width="1" opacity="0.35"/><circle cx="180" cy="170" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="180.0" y="56.0" text-anchor="middle" font-size="12">0°</text><text x="298.0" y="174.0" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="13">90°</text><text x="180.0" y="292.0" text-anchor="middle" font-size="12">180°</text><text x="62.0" y="174.0" text-anchor="middle" font-size="12">270°</text><path d="M180.0,110.0 A60,60 0 0 1 236.4,149.5" fill="none" stroke="#3fa968" stroke-width="2" marker-end="url(#ar5)"/><text x="180" y="326" text-anchor="middle" font-size="11">im Uhrzeigersinn, 90° = rechts (wie ein Kompass)</text><text x="540" y="24" text-anchor="middle" font-weight="600">Mathematische Konvention</text><circle cx="540" cy="170" r="95" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="3 4"/><line x1="431" y1="170" x2="649" y2="170" stroke="currentColor" stroke-width="1" opacity="0.35"/><line x1="540" y1="61" x2="540" y2="279" stroke="currentColor" stroke-width="1" opacity="0.35"/><circle cx="540" cy="170" r="5" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><text x="540.0" y="56.0" text-anchor="middle" font-size="12">0°</text><text x="658.0" y="174.0" text-anchor="middle" font-size="12">270°</text><text x="540.0" y="292.0" text-anchor="middle" font-size="12">180°</text><text x="422.0" y="174.0" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="13">90°</text><path d="M540.0,110.0 A60,60 0 0 0 483.6,149.5" fill="none" stroke="#d9534f" stroke-width="2" marker-end="url(#ar5)"/><text x="540" y="326" text-anchor="middle" font-size="11">gegen den Uhrzeigersinn, 90° = links (z.B. IEM-Plugins)</text><text x="360" y="175" text-anchor="middle" font-weight="600" font-size="34">≠</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Derselbe Winkel, 90°, zeigt auf gegenüberliegende Seiten. Konvention prüfen, bevor Koordinaten aus anderen Tools importiert werden.</figcaption>
</figure>














Nicht alle Systeme verwenden dieselbe Azimut-Richtung. Im ICST AmbiDecoder gilt:

- **0°** = Front (Richtung Y+)
- **90°** = Rechts (Richtung X+)
- **180° / -180°** = Back
- **270° / -90°** = Links (Richtung X-)

Der Azimut wächst also **im Uhrzeigersinn**, wie bei einem Kompass. Viele mathematische und Ambisonics-Tools zählen stattdessen gegen den Uhrzeigersinn (90° = links). Wenn du Koordinaten aus anderen Tools importierst, prüfe die Konvention.

---

## Zusammenfassung

### Decoder-Serie: Geometrie

Wenn du den Decoder als Dreischritt denkst, ist diese Seite der Teil **Geometrie**:

- **Geometrie** bestimmt, **wo** Lautsprecher im Raum stehen
- **Laufzeit** bestimmt, **wann** Signale dort ankommen
- **Abstimmung** bestimmt, **wie deutlich** oder **wie gefärbt** das Ergebnis wahrgenommen wird

Falsche Koordinaten sind deshalb kein klanglicher Charakterzug, sondern ein Setup-Fehler. Erst wenn die Geometrie stimmt, sind spätere Entscheidungen über Delay, Gewichtung oder Filterung sinnvoll beurteilbar.

| | XYZ | AED |
|---|---|---|
| **Sinnvoll wenn…** | Messdaten vorhanden | Intuitive Winkelplanung |
| **Stärke** | präzise, direkt aus CAD/Laser | wahrnehmungsorientiert, schnell |
| **Typischer Kontext** | Konzertinstallation, Forschung | Studio, Probe, Schnelleinstieg |
| **Editierbar im Decoder** | ja | ja |

Du musst dich nicht entscheiden. Der Decoder zeigt immer beide – nutze das, was die Situation gerade erfordert.

---

## Weiterführende Seiten

- [ICST Decoder – Einrichtung und Bedienung](/de/icst-ambisonics-plugins/08_icst_decoder/)
- [Skalierung und Laufzeitkompensation](/de/post/decoder-skalierung-laufzeitkompensation/)
- [Der Filter-Tab – Praxisbeispiele und Anwendungsfälle](/de/post/decoder-filter-praxisbeispiele/)
- [Warum der Decoder klingt wie er klingt – Methodischer Kontext](/de/post/decoder-methodological-context/)

<p class="ai-credit" style="font-size:.85em;opacity:.7"><em>Diagramme und Erklärvideos mit Hilfe von Claude (Anthropic) erstellt. <a href="/de/about/#about-this-site">→</a></em></p>
