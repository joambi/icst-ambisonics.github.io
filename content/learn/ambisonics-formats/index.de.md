---
title: "Ambisonics-Formate erklärt: A-Format, B-Format, FuMa, ambiX, FOA und HOA"
description: "Praxisnahe Referenz zu Ambisonics-Formaten: A-Format, B-Format, FuMa, ambiX, ACN, SN3D, N3D, FOA, HOA, Kanalzahlen und ICST-Empfehlung."
date: 2026-05-01T00:00:00
draft: false
slug: ambisonics-formats
languageCode: de
tags:
  - ambisonics
  - b-format
  - ambix
  - hoa
---

Level: Einstieg bis Intermediate | Zielgruppe: Komponist:innen, Studierende, Producer, Techniker:innen, Studio-Residents.

Nutze diese Seite, wenn du Begriffe wie **A-Format**, **B-Format**, **FuMa**, **ambiX**, **ACN/SN3D**, **FOA** oder **HOA** siehst und wissen willst, was sie praktisch bedeuten.

<div class="hero__links">
  <a class="hero__link" href="#quick-checklist">Quick Checklist</a>
  <a class="hero__link" href="#icst-empfehlung">ICST-Empfehlung</a>
  <a class="hero__link" href="/de/blog/b-format-archive/">B-Format-Archiv</a>
</div>

## 1. Warum "Format" in Ambisonics verwirrend ist

In Ambisonics bezeichnet **Format** mehrere unterschiedliche Dinge:

- das Rohsignal eines Mikrofons
- das interne räumliche Signal in einer DAW
- die Kanalreihenfolge in einer Datei
- die Normierung der Kugelflächenfunktionen
- die Ambisonics-Ordnung, die die Kanalzahl bestimmt

Darum ist die Frage "Ist das B-Format?" oft nicht genau genug. Praktischer ist:

> Ist das eine ambiX-B-Format-Datei mit ACN-Kanalreihenfolge und SN3D-Normierung, und welche Ambisonics-Ordnung verwendet sie?

## 2. A-Format vs. B-Format

**A-Format** ist meistens das Rohsignal eines Ambisonics-Mikrofons. Bei einem tetraedrischen Mikrofon erster Ordnung bedeutet das: vier Kapselsignale vor räumlicher Korrektur oder Umrechnung. A-Format ist mikrofonspezifisch und sollte normalerweise nicht als fertiger Ambisonics-Master behandelt werden.

**B-Format** ist die Ambisonics-Signalrepräsentation für Produktion, Austausch, Dekodierung und Archivierung. Es beschreibt ein Klangfeld um einen Hörpunkt. B-Format erster Ordnung hat vier Kanäle; Higher-Order-B-Format hat entsprechend mehr.

Praktische Regel:

- A-Format kommt vom Mikrofon und muss konvertiert werden.
- B-Format ist die räumliche Szene, die du editieren, routen, dekodieren, archivieren oder rendern kannst.

## 3. FuMa vs. ambiX

**FuMa** ist die ältere Ambisonics-Konvention. Sie verwendet benannte Kanäle wie `W`, `X`, `Y`, `Z` und eine MaxN-artige Normierung. FuMa begegnet einem noch in älteren Tools, historischen Dateien und manchen First-Order-Workflows.

**ambiX** ist die moderne Austauschkonvention für Ambisonics. Sie verwendet:

- **ACN**-Kanalreihenfolge
- **SN3D**-Normierung
- normale Mehrkanal-Audiodateien, meistens WAV oder RF64

Im aktuellen ICST-Workflow ist **ambiX der Standard**. Wenn ein Tool nach Kanalreihenfolge und Normierung fragt, wähle `ACN/SN3D`, sofern es keinen klaren Grund für etwas anderes gibt.

## 4. ACN, SN3D und N3D

**ACN** bedeutet Ambisonic Channel Number. Es definiert die Kanalreihenfolge. Statt historischer Namen wie `W`, `X`, `Y`, `Z` bekommt jede Kugelflächenfunktion eine nummerierte Kanalposition.

**SN3D** und **N3D** sind Normierungskonventionen. Sie definieren die Skalierung der Ambisonics-Komponenten. Die räumliche Szene kann konzeptuell dieselbe sein, aber ein Mismatch zwischen SN3D und N3D verändert Kanalverhältnisse und kann die Dekodierung verfälschen.

Für die meiste Plugin- und DAW-Arbeit heute gilt:

- `ACN/SN3D` = ambiX, empfohlen für Austausch und Produktion
- `ACN/N3D` = verbreitet in manchen Forschungs-, Analyse- und Mathematik-Kontexten
- `FuMa` = Legacy-Konvention, vor allem First-Order

## 5. FOA vs. HOA

**FOA** bedeutet First-Order Ambisonics. Es verwendet 4 Kanäle und ist sinnvoll für einfache Aufnahmen, grundlegende Spatialisation, Kompatibilität und viele Mikrofon-Workflows.

**HOA** bedeutet Higher-Order Ambisonics. Es beginnt ab zweiter Ordnung und erhöht die räumliche Auflösung durch zusätzliche Kugelflächenfunktionen.

Höhere Ordnung kann präzisere Lokalisation, stabileres Rendering und einen grösseren nutzbaren Hörbereich ermöglichen, braucht aber mehr Kanäle und sorgfältigeres Routing.

## 6. Kanalzahlen nach Ordnung

Für volles 3D-Ambisonics gilt:

```text
Kanäle = (Ordnung + 1)^2
```

| Ordnung | Name | Kanäle |
|---:|---|---:|
| 1 | FOA | 4 |
| 2 | HOA-2 | 9 |
| 3 | HOA-3 | 16 |
| 4 | HOA-4 | 25 |
| 5 | HOA-5 | 36 |
| 6 | HOA-6 | 49 |
| 7 | HOA-7 | 64 |

In REAPER verwenden ICST-Sessions deshalb oft einen **64-Kanal-B-Format-Bus**: Er kann HOA-7 tragen, ohne höhere Ordnungskomponenten still abzuschneiden.

## 7. Szenenbasiert vs. kanalbasiert

Ambisonics ist **szenenbasiert**. Die Kanäle sind keine Lautsprecherkanäle. Sie sind Komponenten einer räumlichen Klangfeldrepräsentation.

Das unterscheidet Ambisonics von **kanalbasiertem** Audio, bei dem Kanal 1 beispielsweise linker Lautsprecher, Kanal 2 rechter Lautsprecher, Kanal 3 Center usw. bedeutet.

In Ambisonics entscheidet der Decoder, wie die B-Format-Szene zu Lautsprechersignalen oder binauralem Kopfhörer-Output wird. Genau deshalb kann derselbe B-Format-Master für eine Kuppel, ein Oktagon, ein Studio-Array, Kopfhörer oder Stereo gerendert werden.

<div id="icst-empfehlung"></div>

## 8. Praktische ICST-Empfehlung

> **ICST-Empfehlung**
>
> Für neue Ambisonics-Arbeiten: **ambiX** verwenden:
> **ACN-Kanalreihenfolge + SN3D-Normierung**.
>
> Für Higher-Order-Arbeit in REAPER bei Bedarf einen **64-Kanal-B-Format-Bus** für HOA-7 verwenden. Erst in der Monitoring- oder Render-Stufe dekodieren.

So bleibt die Session offen: derselbe B-Format-Master kann Lautsprecher-Decoding, binaurales Monitoring, Archivexport und spätere Neuinterpretation auf einem anderen Wiedergabesystem bedienen.

<div id="quick-checklist"></div>

## 9. Quick Checklist: Welches Format soll ich verwenden?

Verwende **ambiX B-Format, ACN/SN3D**, wenn:

- du eine neue Ambisonics-Produktion beginnst
- du mit ICST, IEM, SPARTA oder anderen modernen HOA-Tools arbeitest
- du einen B-Format-Archivmaster exportierst
- du verlässlichen Austausch zwischen DAWs, Plugins und Render-Tools brauchst

Verwende **A-Format** nur, wenn:

- du rohe Ambisonics-Mikrofonaufnahmen vor der Konvertierung bearbeitest
- der herstellerspezifische A-to-B-Konvertierungsschritt noch aussteht

Verwende **FuMa** nur, wenn:

- ein älteres Tool oder Archiv es ausdrücklich verlangt
- du historisches First-Order-Material konvertierst

Immer dokumentieren:

- Ambisonics-Ordnung
- Kanalzahl
- Kanalreihenfolge
- Normierung
- Sample Rate und Bit Depth
- verwendeter Decoder oder Renderer fürs Monitoring

## Verwandte Seiten

- [Ambisonics 101](/de/ambisonics-101/)
- [ICST B-Format-Archiv](/de/blog/b-format-archive/)
- [ICST Encoders](/de/icst-ambisonics-plugins/10_icst_encoders/)
- [ICST Decoder](/de/icst-ambisonics-plugins/08_icst_decoder/)
- [B-Format in REAPER rendern](/de/icst-ambisonics-plugins/12_render_bformat/)
