---
title: Skalierung und Laufzeitkompensation im ICST AmbiDecoder
description: "Wie die Scaling-Funktion des ICST AmbiDecoders Raumgrösse und Lautsprecherabstände berücksichtigt und warum Laufzeitkompensation für geometrisch kohärente Wiedergabe entscheidend ist."
date: 2026-03-21T11:00:00+01:00
year: 2026
month: 2026-03
weight: 32
tags: ["decoder", "skalierung", "delay", "laufzeitkompensation", "setup", "installation", "konfiguration"]
key_points:
  - "Die Scaling-Funktion skaliert alle Lautsprecherkoordinaten auf eine reale Raumgrösse"
  - "Laufzeit-Delays werden automatisch aus den Distanzangaben berechnet"
  - "Ohne Laufzeitkompensation bei ungleichen Abständen entsteht ein inkohärentes Klangbild"
difficulty: "intermediate"
post_kind: "reference"
tool: ["AmbiDecoder"]
---

Level: Intermediate | **Audience:** Techniker:in, Installationskünstler:in, Studiobetreiber:in.

Diese Seite erklärt, wie die Scaling- und Delay-Kompensationsfunktion des ICST AmbiDecoders funktioniert und wann du sie brauchst.

> **Gemeinsamer Kernsatz dieser Decoder-Serie:** Der Decoder erzeugt den Raum nicht neu, sondern projiziert ein B-Format-Feld auf ein reales System.
>
> In diesem Artikel geht es um den zweiten Schritt dieser Projektion: **Laufzeit**. Delay-Kompensation bestimmt, **wann** Signale am Hörzentrum ankommen, nachdem die Geometrie bereits festgelegt wurde.

---

## Das Problem: Lautsprecher stehen nicht alle gleich weit weg

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 232" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Lautsprecher in 2,7, 3,4 und 4,2 Metern Abstand: ohne Kompensation erreichen ihre Signale den Hörpunkt zu verschiedenen Zeiten, mit Kompensation gleichzeitig." xmlns="http://www.w3.org/2000/svg"><defs><marker id="md" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="140" y="20" text-anchor="middle" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">Aufstellung (Draufsicht)</text><circle cx="140" cy="125" r="64.8" fill="none" stroke="currentColor" stroke-opacity=".2" stroke-width="1" stroke-dasharray="3 4"/><circle cx="140" cy="125" r="81.6" fill="none" stroke="currentColor" stroke-opacity=".2" stroke-width="1" stroke-dasharray="3 4"/><circle cx="140" cy="125" r="100.8" fill="none" stroke="currentColor" stroke-opacity=".2" stroke-width="1" stroke-dasharray="3 4"/><circle cx="140.0" cy="125.0" r="5" fill="currentColor" fill-opacity="1"/><line x1="140" y1="125" x2="98.3" y2="75.4" stroke="currentColor" stroke-opacity=".3" stroke-width="1"/><circle cx="98.3" cy="75.4" r="9" fill="#4a8fe0" fill-opacity="0.85"/><text x="98.34736289231225" y="79.36032008589021" text-anchor="middle" font-size="11" font-weight="600" fill="#fff" fill-opacity="1">A</text><text x="84.34736289231225" y="79.36032008589021" text-anchor="end" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">2,7 m</text><line x1="140" y1="125" x2="202.5" y2="72.5" stroke="currentColor" stroke-opacity=".3" stroke-width="1"/><circle cx="202.5" cy="72.5" r="9" fill="#4a8fe0" fill-opacity="0.85"/><text x="202.5092265585086" y="76.5485310495784" text-anchor="middle" font-size="11" font-weight="600" fill="#fff" fill-opacity="1">B</text><text x="216.5092265585086" y="76.5485310495784" text-anchor="start" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">3,4 m</text><line x1="140" y1="125" x2="122.5" y2="224.3" stroke="currentColor" stroke-opacity=".3" stroke-width="1"/><circle cx="122.5" cy="224.3" r="9" fill="#4a8fe0" fill-opacity="0.85"/><text x="122.49626369117343" y="228.26862150363058" text-anchor="middle" font-size="11" font-weight="600" fill="#fff" fill-opacity="1">C</text><text x="136.49626369117343" y="228.26862150363058" text-anchor="start" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">4,2 m</text><text x="395" y="22" text-anchor="start" font-size="12" font-weight="600" fill="#d9534f" fill-opacity="1">Ohne Kompensation: gestaffelt</text><text x="387" y="45" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">A</text><rect x="395" y="36" width="151.2" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><line x1="546.2" y1="33" x2="546.2" y2="51" stroke="#d9534f" stroke-width="2.5"/><text x="387" y="65" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">B</text><rect x="395" y="56" width="190.4" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><line x1="585.4" y1="53" x2="585.4" y2="71" stroke="#d9534f" stroke-width="2.5"/><text x="387" y="85" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">C</text><rect x="395" y="76" width="235.2" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><line x1="630.2" y1="73" x2="630.2" y2="91" stroke="#d9534f" stroke-width="2.5"/><text x="395" y="128" text-anchor="start" font-size="12" font-weight="600" fill="#3fa968" fill-opacity="1">Mit Kompensation: gleichzeitig</text><text x="387" y="151" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">A</text><line x1="395" y1="148" x2="479.0" y2="148" stroke="currentColor" stroke-opacity=".5" stroke-width="2" stroke-dasharray="4 3"/><rect x="479.0" y="142" width="151.2" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><text x="387" y="171" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">B</text><line x1="395" y1="168" x2="439.8" y2="168" stroke="currentColor" stroke-opacity=".5" stroke-width="2" stroke-dasharray="4 3"/><rect x="439.8" y="162" width="190.4" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><text x="387" y="191" text-anchor="end" font-size="11" font-weight="600" fill="currentColor" fill-opacity="0.9">C</text><rect x="395.0" y="182" width="235.2" height="12" rx="3" fill="#4a8fe0" fill-opacity=".55"/><line x1="630.2" y1="136" x2="630.2" y2="198" stroke="#3fa968" stroke-width="2.5"/><line x1="395" y1="212" x2="660.2" y2="212" stroke="currentColor" stroke-opacity=".5" stroke-width="1.2" marker-end="url(#md)"/><text x="664.2" y="216" text-anchor="start" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Zeit →</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Die Delay-Kompensation hält die näheren Lautsprecher zurück, bis der entfernteste aufgeholt hat.</figcaption>
</figure>



In idealen Setups – z.B. einem gleichmässigen Oktagon oder einer Kugelform – haben alle Lautsprecher denselben Abstand vom Hörzentrum. Die Signale kommen also gleichzeitig an.

In realen Räumen ist das fast nie der Fall:

- Konzerthäuser haben asymmetrische Wände
- Lautsprecher hängen auf verschiedenen Ebenen
- Subwoofer stehen oft anders platziert als Breitbänder
- Installationen passen sich vorhandenen Strukturen an

Wenn Lautsprecher unterschiedlich weit entfernt sind, erreichen die Signale das Hörzentrum zu unterschiedlichen Zeiten. Das verschlechtert Phantomschallquellenbildung, Lokalisationsschärfe und das Kohärenzgefühl des Klangfeldes deutlich.

---

## Die Lösung: Delay-Kompensation

Der ICST AmbiDecoder berechnet aus den Distanzangaben jedes Lautsprechers automatisch einen individuellen Delay-Wert. Weiter entfernte Lautsprecher erhalten ein grösseres vorangestelltes Delay – so dass alle Signale (akustisch gesehen) gleichzeitig am Hörzentrum ankommen.

Die Delay-Werte sind in der Speaker-Tabelle sichtbar:

| CH | Name | D [m] | Delay [ms] | Delay comp. [ms] |
|----|------|--------|------------|------------------|
| 1  | L    | 3.376  | 9.84       | 3.57             |
| 2  | R    | 3.347  | 9.76       | 3.65             |
| 5  | SUB  | 2.709  | 7.88       | 5.45             |

- **D [m]** – gemessene Distanz des Lautsprechers vom Zentrum
- **Delay [ms]** – berechnete Laufzeit des Schalls (Distanz / Schallgeschwindigkeit)
- **Delay comp. [ms]** – tatsächlich angewendete Verzögerung zur Kompensation

> **Merksatz:** Der Lautsprecher, der am weitesten entfernt ist, braucht keine Verzögerung – er ist ohnehin am langsamsten. Alle anderen werden so verzögert, dass sie auf ihn warten.

---

## Die Scaling-Funktion

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 244" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Ein normalisiertes Lautsprecher-Preset auf dem Einheitskreis wird auf die realen Raumabmessungen skaliert; Koordinaten, Distanzen und Delay-Werte werden neu berechnet." xmlns="http://www.w3.org/2000/svg"><defs><marker id="ms" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><text x="130" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Preset (normalisiert)</text><text x="130" y="38" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">alle Lautsprecher bei D = 1 m</text><circle cx="130" cy="130" r="70" fill="none" stroke="currentColor" stroke-opacity=".3" stroke-width="1.2" stroke-dasharray="3 4"/><circle cx="194.7" cy="156.8" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="156.8" cy="194.7" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="103.2" cy="194.7" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="65.3" cy="156.8" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="65.3" cy="103.2" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="103.2" cy="65.3" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="156.8" cy="65.3" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="194.7" cy="103.2" r="7" fill="#4a8fe0" fill-opacity="0.85"/><circle cx="130.0" cy="130.0" r="4" fill="currentColor" fill-opacity="1"/><line x1="235" y1="130" x2="400" y2="130" stroke="currentColor" stroke-width="1.6" marker-end="url(#ms)"/><text x="318" y="120" text-anchor="middle" font-size="12" font-weight="600" fill="currentColor" fill-opacity="1">Scaling</text><text x="560" y="22" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor" fill-opacity="1">Dein Raum</text><text x="560" y="38" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">X × Y × Z in Metern</text><rect x="430" y="70" width="260" height="130" rx="6" fill="currentColor" fill-opacity=".05" stroke="currentColor" stroke-opacity=".5" stroke-width="1.5"/><circle cx="661.8" cy="154.3" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="602.2" cy="181.5" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="517.8" cy="181.5" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="458.2" cy="154.3" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="458.2" cy="115.7" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="517.8" cy="88.5" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="602.2" cy="88.5" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="661.8" cy="115.7" r="7" fill="#3fa968" fill-opacity="0.85"/><circle cx="560.0" cy="135.0" r="4" fill="currentColor" fill-opacity="1"/><text x="560" y="218" text-anchor="middle" font-size="12" font-weight="600" fill="currentColor" fill-opacity="0.8">X</text><text x="420" y="139" text-anchor="end" font-size="12" font-weight="600" fill="currentColor" fill-opacity="0.8">Y</text><text x="560" y="232" text-anchor="middle" font-size="11" font-weight="400" fill="currentColor" fill-opacity="0.75">Koordinaten, Distanzen und Delays werden neu berechnet.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Scaling streckt ein normalisiertes Preset auf deinen Raum.</figcaption>
</figure>



Wenn du ein Lautsprecher-Preset für einen Raum konfigurierst, sind die Koordinaten manchmal in normierten Einheiten angegeben (z.B. als Vektoren der Länge 1, also alle Lautsprecher auf einer Einheitskugel). Das ist praktisch für Presets, die in verschiedenen Räumen funktionieren sollen – aber es bildet die reale Geometrie nicht ab.

Die **Scaling-Funktion** erlaubt dir, alle Lautsprecherkoordinaten auf eine tatsächliche Raumgrösse zu skalieren:

1. Klicke auf **Scaling** im Speaker-Settings-Fenster.
2. Gib die Raummasse ein: **X** (Breite), **Y** (Tiefe), **Z** (Höhe) in Metern.
3. Der Decoder skaliert alle Koordinaten proportional – und berechnet danach die Laufzeit-Delays neu.

Dabei werden automatisch aktualisiert:

- alle kartesischen Lautsprecherkoordinaten (XYZ)
- alle polaren Distanzwerte (D in AED)
- alle daraus resultierenden Delay-Werte

---

## Wann brauchst du Scaling?

**Szenario 1: Preset aus einer anderen Raumgrösse**
Du verwendest ein vorhandenes Oktagon-Preset, das für einen 6×6 m Raum konfiguriert wurde. Dein Raum ist aber 8×9 m. Mit Scaling passt du das Preset in wenigen Sekunden an, ohne jeden Lautsprecher manuell editieren zu müssen.

**Szenario 2: Normiertes Preset, realer Raum**
Viele Standard-Presets verwenden Einheitsvektoren (Distanz = 1.0 m). Du gibst deine echten Raumdimensionen ein – und alle Lautsprecherkoordinaten werden korrekt skaliert.

**Szenario 3: Tournee oder Gastspiel**
Du spielst dasselbe Stück in drei verschiedenen Räumen. Statt drei separate Presets zu pflegen, hast du ein normiertes Basis-Preset und skalierst es für jeden Raum individuell – mit automatischer Delay-Neuberechnung.

---

## Manueller Delay-Override

Neben der automatischen Berechnung kannst du Delay-Werte für einzelne Lautsprecher auch manuell überschreiben. Das ist sinnvoll, wenn:

- ein Lautsprecher baubedingt eine andere akustische Charakteristik hat (z.B. eingebaut hinter einer Membran)
- du raumakustische Korrekturen machst, die über reine Laufzeit hinausgehen
- du im Betrieb kleine Feinkorrekturen vornehmen willst

> **Vorsicht:** Manuelle Delay-Eingriffe werden beim nächsten Scaling-Vorgang überschrieben. Speichere dein Preset vorher.

---

## Quick-Check vor der Aufführung

Bevor du einen Raum abspielst, prüfe folgende Punkte:

1. Sind die **Distanzwerte (D)** für alle Lautsprecher eingetragen und plausibel?
2. Stimmen die **Delay comp.**-Werte ungefähr mit den erwarteten Laufzeitunterschieden überein?
3. Hast du nach einer Skalierung das Preset **neu gespeichert**?
4. Ist die **Ambisonics Order** im Decoder auf das Quellmaterial abgestimmt?

Ein kurzer Pink-Noise-Test mit Mute/Solo-Überprüfung zeigt sofort, ob die zeitliche Kohärenz stimmt.

---

## Decoder-Serie: Laufzeit

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 120" style="width:100%;max-width:720px;height:auto;display:block" role="img" aria-label="Der Decoder in drei Schritten: Geometrie bestimmt wo, Laufzeit wann, Tuning wie klar oder gefärbt." xmlns="http://www.w3.org/2000/svg"><defs><marker id="mr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0 0L10 5L0 10z" fill="currentColor"/></marker></defs><rect x="10" y="24" width="210" height="62" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="115.0" y="52.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Geometrie</text><text x="115.0" y="69.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">wo die Lautsprecher stehen</text><line x1="222" y1="55" x2="251" y2="55" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><rect x="253" y="24" width="210" height="62" rx="8" stroke="#4a8fe0" fill="#4a8fe0" fill-opacity=".16" stroke-width="1.5"/><text x="358.0" y="52.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Laufzeit</text><text x="358.0" y="69.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">wann die Signale ankommen</text><line x1="465" y1="55" x2="494" y2="55" stroke="currentColor" stroke-width="1.6" marker-end="url(#mr)"/><rect x="496" y="24" width="210" height="62" rx="8" stroke="currentColor" fill="currentColor" fill-opacity=".06" stroke-width="1.5"/><text x="601.0" y="52.0" text-anchor="middle" font-size="13" font-weight="600" fill="currentColor">Tuning</text><text x="601.0" y="69.0" text-anchor="middle" font-size="11" fill="currentColor" fill-opacity=".75">wie klar oder gefärbt</text><text x="358" y="106" text-anchor="middle" font-size="11" font-weight="600" fill="#4a8fe0" fill-opacity="0.8">▲ diese Seite</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Decoder-Serie: Diese Seite behandelt den zweiten Schritt.</figcaption>
</figure>



Wenn du den Decoder als Dreischritt denkst, ist diese Seite der Teil **Laufzeit**:

- **Geometrie** bestimmt, **wo** Lautsprecher stehen
- **Laufzeit** bestimmt, **wann** ihre Signale ankommen
- **Abstimmung** bestimmt, **wie deutlich** oder **wie gefärbt** das Ergebnis erscheint

Scaling und Delay-Kompensation sind deshalb keine kreative Klangformung, sondern ein Übersetzungsschritt zwischen normiertem Preset und realem Raum. Erst wenn die Zeitverhältnisse stimmen, lassen sich Gewichtung, Filter oder MultiDecoder-Layer sinnvoll beurteilen.

---

## Preset speichern und exportieren

Nach jeder Skalierung solltest du das Setup als Preset speichern:

- **Speichern:** Speaker → Save preset → Namen vergeben (z.B. `ICST-Studio_HOA7_2026-03`)
- **Exportieren:** Die Konfiguration kann als **TXT-Datei** exportiert werden (Speaker → Export)

Die exportierte TXT-Datei enthält alle Lautsprecherpositionen im AED-Format und kann in externe Systeme (z.B. Max/MSP via `coll`-Objekt oder `ambidecode~`) geladen werden. Das ermöglicht eine plattformübergreifende Integration der Lautsprechergeometrie in hybride Systeme.

---

## Weiterführende Seiten

- [ICST Decoder – Einrichtung und Bedienung](/de/icst-ambisonics-plugins/08_icst_decoder/)
- [XYZ und AED – Koordinatensysteme im Vergleich](/de/post/xyz-vs-aed-koordinatensysteme/)
- [ICST MultiDecoder](/de/icst-ambisonics-plugins/09_icst_multidecoder/)
- [Der Filter-Tab – Praxisbeispiele und Anwendungsfälle](/de/post/decoder-filter-praxisbeispiele/)
- [Best Practices](/de/icst-ambisonics-plugins/17_best_practices/)
