---
title: "ICST Studio-Case: Warum unser 31-Speaker-Setup so geroutet ist"
description: "Praxis-Case zu Routing-Entscheidungen im 31-Lautsprecher-Ambisonics-Setup des ICST Kompositionsstudios — was wir gewählt haben, warum, und was es verhindert."
date: 2026-03-16T09:00:00+01:00
weight: -1
draft: false
group: "Studio"
tags: ["studio", "routing", "lautsprecher", "decoder", "case-study"]
---

**Level:** Intermediate — **Für:** Komponist:innen, Techniker:innen und Forschende, die im ICST Kompositionsstudio arbeiten oder es besuchen.

---

## Kontext

Jeder Mehrkanal-Ambisonics-Raum sammelt über die Zeit kleine Routing-Entscheidungen an — ein Bus hier hinzugefügt, ein Monitoring-Pfad dort umgeleitet. Im ICST Kompositionsstudio wurden diese Entscheidungen bewusst getroffen und dokumentiert, damit jede neue Residenz von einer stabilen, verstandenen Ausgangslage startet — nicht von einer rätselhaften Vorlage.

Dieser Artikel erklärt die vier Kernentscheidungen hinter dem 31-Lautsprecher-REAPER-Session-Template des Studios, die Probleme, die jede Entscheidung löst, und die Fehlerquellen, die sie verhindert.

---

## Entscheidung 1 — Ein dedizierter `Bformat-Master`-Track als zentrale Instanz

Alles Quellmaterial — unabhängig davon, wie viele Encoder oder Quell-Tracks aktiv sind — wird vor der Dekodierung in einen einzigen dedizierten B-Format-Master-Bus geleitet. Kein Quell-Track sendet Audio direkt an einen Decoder oder an die Lautsprecher-Ausgänge.

**Warum:** Wenn mehrere Komponist:innen über mehrere Tage in derselben Session arbeiten, kann ein Quell-Track leicht versehentlich an einen Monitoring-Bus oder einen Decoder-Eingang geroutet werden, der für ein anderes Signal gedacht war. Ein einziger, benannter B-Format-Master macht den Signalpfad auf einen Blick sichtbar und prüfbar. Er bedeutet auch, dass eine „trockene B-Format-Aufnahme" des gesamten Mixes — nützlich für die Archivierung oder Offline-Binaural-Rendering — genau einen Send von genau einem Track erfordert.

---

## Entscheidung 2 — Decoder-Ebene vollständig von der Quellen-Ebene getrennt

Der Decoder (AmbiDecoder) empfängt nur vom `Bformat-Master`. Er sitzt nicht in einer Kette mit Quell-Tracks, und sein Ausgang geht direkt in den Lautsprecher-Ausgangsbus — nirgendwo sonst.

**Warum:** Das Vermischen der Dekodierungsstufe mit der Quellverarbeitung ist die häufigste Ursache schwer zu diagnostizierender Pegel- und Phasenanomalien in Ambisonics-Sessions. Wenn der Pegel eines Quell-Tracks falsch ist, ist das sofort und lokal hörbar. Wenn der Decoder falsch konfiguriert ist — falsche Ordnung, falsche Normalisierungskonvention, falsches Lautsprecher-Preset — betrifft es alle Quellen gleichzeitig, und die Artefakte können wie ein Raumproblem erscheinen, nicht wie ein Routing-Problem. Den Decoder isoliert zu halten bedeutet, dass jede Fehlkonfiguration eindeutig an einem Ort liegt.

---

## Entscheidung 3 — Lautsprecher-Ausgang und Binaural-Monitoring als parallele Pfade

Das Session-Template enthält zwei Monitoring-Pfade, die per Konvention sich gegenseitig ausschliessen: den 31-Lautsprecher-Hardware-Ausgang und ein Stereo-Binaural-Render. Beide dekodieren vom selben `Bformat-Master`. Das Umschalten zwischen ihnen ist eine Frage des Stummschaltens eines Ausgangsbusses und des Aktivierens des anderen — keine Routing-Änderungen, kein Umpatchen.

**Warum:** Komponist:innen im Studio möchten ihren Mix häufig auf Kopfhörern prüfen, bevor sie eine Speaker-Session buchen, oder einen Binaural-Rohexport an Mitarbeitende schicken. Wenn Binaural-Monitoring eine Neuverkabelung der Session erfordert, wird es zur Unterbrechung und oft übersprungen. Mit parallelen Pfaden im Template ist es ein Ein-Klick-Toggle, der die räumliche Signalkette nicht berührt.

---

## Entscheidung 4 — Einheitliche Benennung und Kanal-Konventionen

Alle Tracks im Template folgen einer Benennungskonvention: `[Nummer]_[Funktion]_[Format]`, z.B. `01_source_mono`, `10_bformat-master_HOA3`, `20_decoder_out`. Kanalzahlen sind pro Track-Typ festgelegt und im Template dokumentiert.

**Warum:** In einer 31-Kanal-Umgebung kann ein einzelner falsch zugewiesener Kanal einen Ausfall produzieren, der von einem Hardware-Defekt des Lautsprechers nicht zu unterscheiden ist. Einheitliche Benennung bedeutet, dass ein:e Gastkünstler:in oder Techniker:in den Signalpfad in unter einer Minute prüfen kann, ohne jedes Plugin öffnen zu müssen. Es macht REAPERs Track-Liste auch als Dokumentation lesbar — eine neue Residenz kann die Session-Architektur verstehen, bevor Play gedrückt wird.

---

## Häufige Fehlerstellen, die dieses Setup verhindert

- **Gemischte HOA-Ordnungen auf dem B-Format-Master:** Eine dritter-Ordnung-Quelle zu einer Session erster Ordnung hinzuzufügen degradiert stumm auf erste Ordnung, wenn beide denselben Master speisen. Das Template dokumentiert die Zielordnung prominent im Master-Track-Namen.
- **Monitoring vom falschen Bus gespeist:** Ein direkter Send von einem Quell-Track zum Lautsprecher-Ausgang umgeht den Decoder und produziert ein Mono- oder Stereo-Signal durch ein 31-Lautsprecher-Array — sofort hörbar, aber verwirrend zu diagnostizieren. Die getrennten Ebenen machen dies im Template strukturell unmöglich.
- **Decoder-Preset passt nach einem System-Update nicht mehr:** Lautsprecher-Koordinatendateien werden im Template mit absolutem Pfad referenziert und im Dateinamen versioniert. Das Laden des falschen Presets ist die häufigste Ursache für falsch lokalisierte Quellen nach einem Software-Update.

---

## Weiterführende Links

- [Von Stereo zu HOA7: Eine Schritt-für-Schritt-Session](/post/stereo-to-hoa7-session/)
- [ICST AmbiDecoder — Multi-Decoder Modus](/post/multi-decoder-mode/)
- [ICST Kompositionsstudio — Guide für Residenzen](/for-residents/)
- [ICST Kompositionsstudio Übersicht](/blog/icst-composer-studio-overview/)
