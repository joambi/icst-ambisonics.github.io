---
title: Welche Ambisonics-Ordnung brauche ich? – HOA-Wahl in der Praxis
description: "FOA, HOA3 oder HOA7? Dieser Artikel erklärt, wann welche Ordnung sinnvoll ist: Kanalzahl, räumliche Auflösung, Lautsprecher-Anforderungen, CPU-Last und binaural – als klare Entscheidungshilfe für den Produktionsalltag."
date: 2026-03-21T18:00:00+01:00
year: 2026
month: 2026-03
weight: 38
tags: ["hoa", "foa", "ordnung", "order", "kanalzahl", "workflow", "konzept", "reaper"]
key_points:
  - "Die Formel (N+1)² bestimmt die Kanalzahl: 1st=4, 3rd=16, 7th=64 Kanäle"
  - "Das Lautsprecher-System ist der limitierende Faktor – nicht die DAW"
  - "HOA3 ist der produktive Sweetspot: gute Auflösung, handhabbare CPU-Last, breite Plugin-Unterstützung"
difficulty: "beginner"
---

Level: Beginner–Intermediate | **Audience:** Komponist:in, Producer:in, alle die eine neue Ambisonics-Session aufsetzen.

---

Die Wahl der Ambisonics-Ordnung ist eine der ersten Entscheidungen jeder Produktion – und sie bestimmt Kanalzahl, CPU-Last, Plugin-Anforderungen und die klangliche Qualität auf einem Lautsprecher-System. Dieser Artikel erklärt die Zusammenhänge ohne Mathematik und gibt klare Empfehlungen für typische Situationen.

---

## Die Grundformel

Die Anzahl der Kanäle im B-Format-Master ergibt sich aus der gewählten Ordnung:

**(N + 1)² = Kanalzahl**

| Ordnung | Kanalzahl | Neue Kanäle |
|---|---|---|
| 1st Order (FOA) | **4** | 4 |
| 2nd Order | **9** | 5 |
| 3rd Order | **16** | 7 |
| 4th Order | **25** | 9 |
| 5th Order | **36** | 11 |
| 7th Order | **64** | 15 |

Höhere Ordnung bedeutet: mehr Kanäle, mehr sphärische Information, feinere räumliche Auflösung – und mehr Rechenaufwand.

---

## Was sich mit der Ordnung ändert

### Räumliche Auflösung

Mit steigender Ordnung werden Klangquellen schärfer lokalisierbar. Bei 1st Order klingt eine Punktquelle leicht diffus – ein Lautsprecher in einem Cluster ist schwer von seinen Nachbarn zu unterscheiden. Bei 3rd Order ist die Lokalisation für die meisten Abhörsituationen überzeugend. Bei 7th Order nähert sich die Auflösung dem, was das menschliche Gehör unter idealen Bedingungen auflösen kann.

Ein einfaches Bild: Ordnung verhält sich ähnlich wie Bildauflösung bei einem Foto. FOA ist 480p – erkennbar, aber unscharf. HOA3 ist 1080p – gut für fast alle Zwecke. HOA7 ist 4K – man braucht ein sehr gutes Wiedergabesystem, um den Unterschied zu hören.

### Sweetspot-Größe

Der Sweetspot ist der Bereich, in dem das Schallfeld korrekt reproduziert wird. Er wächst mit der Ordnung. Bei FOA ist er bei mittleren und hohen Frequenzen kaum größer als ein Kopf. Bei HOA3 reicht er für eine kleine Gruppe von Zuhörer:innen. Für große Räume und viele Personen ist HOA5 oder HOA7 relevant.

In der Praxis: Wer für Studio-Produktion und Kopfhörer arbeitet, merkt den Sweetspot-Unterschied kaum. Wer für ein 31-Speaker-Konzertsystem produziert, macht den Unterschied zwischen HOA3 und HOA7 je nach Repertoire und Saal hörbar.

### Minimale Lautsprecher-Anzahl

Das Lautsprecher-System setzt die praktische Obergrenze der nutzbaren Ordnung. Die Faustregel:

> **Mindestens (N+1)² Lautsprecher für Ordnung N**

| Ordnung | Mindest-Lautsprecher |
|---|---|
| 1st | 4 |
| 2nd | 9 |
| 3rd | 16 |
| 5th | 36 |
| 7th | 64 |

In einem System mit 8 Lautsprechern ist HOA3 wenig sinnvoll – das System kann die 16-kanalige Information nicht vollständig reproduzieren. Der Decoder rechnet zwar, aber die räumliche Auflösung ist durch die Lautsprecher gedeckelt. Das **ICST Composition Studio an der ZHdK** hat 31 Lautsprecher – dort ist HOA3 gut ausgenutzt, HOA5 bereits anspruchsvoll.

> **Wichtig:** In REAPER und den ICST Plugins kannst du jede Ordnung verwenden, egal wie viele Lautsprecher du hast. Das System rechnet korrekt. Aber die klangliche Qualität wird durch das schwächste Glied bestimmt – das Abhörsystem.

---

## Praktische Entscheidungshilfe

### Wann reicht FOA (1st Order)?

- Binaural-only Produktion für Kopfhörer oder Streaming
- Kompositorische Skizze oder Konzeptarbeit ohne finales Lautsprecher-System
- Echtzeit-Performance auf kleinem System (4–8 Lautsprecher, z.B. Oktagon)
- Ambisonics-Mikrofon-Aufnahmen (Ambeo, NT-SF1 – diese liefern ausschliesslich FOA)
- Ressourcenknappe Live-Situation (älteres Laptop, instabiler Rechner)

### Wann ist HOA3 die richtige Wahl?

HOA3 ist der **produktive Standard** für die meisten Ambisonics-Produktionen heute:

- Professionelle Komposition für ein Mehrlautsprecher-System ab ca. 16 Lautsprechern
- Binaural-Render mit hoher Qualität (IEM BinauralDecoder nutzt HOA3 voll aus)
- Mischung aus Encoder-Quellen und Mikrofon-Aufnahmen (Zylia ZM-1 liefert HOA3)
- Export für Plattformen wie YouTube 360° oder VR (die meisten Plattformen akzeptieren maximal HOA3)
- Studioproduktion mit modernem Rechner ohne spezifischen Bedarf an HOA7

### Wann braucht es HOA5 oder HOA7?

- Große Konzerthäuser mit 40+ Lautsprechern (z.B. Kuppelinstallationen, IMAX-ähnliche Systeme)
- Archive und Masterdateien, die für zukünftige höhere Systeme ausgelegt sind
- Spezielle Höhenabbildung in dichten 3D-Arrays
- Akademische oder Forschungs-Kontexte mit Präzisionsanforderungen

### Binaural: Wie viel Ordnung klingt besser?

Für binaurales Kopfhörer-Monitoring gilt: der wahrnehmbare Qualitätssprung liegt zwischen FOA und HOA3 – deutlich. Zwischen HOA3 und HOA7 ist der Unterschied im Binaural-Rendering messbar, aber perceptuell weniger dramatisch. Ab HOA3 ist Binaural für die meisten Zwecke ausreichend hochauflösend.

---

## CPU-Last in REAPER

| Ordnung | Kanäle | Relative CPU | Praktisch |
|---|---|---|---|
| FOA | 4 | sehr gering | problemlos auch auf älteren Systemen |
| HOA3 | 16 | moderat | Standard auf modernem Rechner, kein Problem |
| HOA5 | 36 | merklich | große Sessions erfordern Freeze-Strategie |
| HOA7 | 64 | hoch | bei vielen Quellen: Freeze oder Render-to-File |

In REAPER: Wenn HOA7-Spuren einzufrieren sind, *Freeze*-Funktion nutzen (rechtsklick auf Track → Freeze). Der eingefrorene Track wird als voll berechnetes Multichannel-File intern gespeichert und verursacht keine Encoder-CPU mehr – nur noch Bus-Routing.

---

## Ordnung wechseln während der Produktion

Es ist möglich, die Ordnung einer laufenden Session zu ändern – aber es erfordert Anpassungen:

1. **B-Format-Bus Kanalzahl** anpassen (Rechtsklick → Track Channels)
2. **Alle AmbiEncoder** auf die neue Ordnung setzen (Order-Parameter im Plugin)
3. **ICST AmbiDecoder** auf die neue Ordnung setzen
4. **BinauralDecoder** passt sich automatisch an (IEM erkennt Kanalzahl)

Am einfachsten ist: Ordnung vor dem Produktionsstart festlegen und ein REAPER-Template auf dieser Ordnung aufbauen. Das ICST Download-Pack enthält vorbereitete Templates.

---

## Empfehlung für den ICST-Workflow

Wer am **ICST Composition Studio** (31 Lautsprecher) produziert: **HOA3** als Standard. Das Studio ist für HOA3 optimiert und kalibriert. HOA7 ist technisch möglich, bringt aber auf diesem System einen geringen Mehrwert.

Wer für **Kopfhörer und Binaural** produziert: **HOA3** als sinnvoller Kompromiss zwischen Qualität und Performance.

Wer eine **erste eigene Session** aufbaut: Mit **FOA oder HOA3** beginnen – die Konzepte sind dieselben, und der Einstieg ist leichter.

---

## Weiterführende Seiten

- [Koordinatensysteme: XYZ und AED im Vergleich](/post/xyz-vs-aed-koordinatensysteme/)
- [ICST AmbiDecoder – Skalierung und Laufzeitkompensation](/post/decoder-skalierung-laufzeitkompensation/)
- [Binaural Monitoring im ICST-Workflow](/post/binaural-monitoring-icst-workflow/)
- [Den B-Format-Master exportieren](/post/b-format-export-reaper/)
- [Ambisonics-Mikrofon aufnehmen – A-Format, B-Format und die ICST-Integration](/post/ambisonics-mikrofon-a-format-b-format/)
