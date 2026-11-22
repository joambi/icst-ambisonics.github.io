---
title: FOA oder HOA im Konzert? Die Ordnung für Lautsprecher-Aufführungen wählen
description: "Welche Ambisonics-Ordnung für ein Konzert? Saalgrösse, Lautsprecherzahl, Publikumsbereich, Zuspielung und Probenroutine: eine Entscheidungshilfe für FOA, HOA3 und HOA7 bei Aufführungen."
date: 2026-11-22T20:00:00+01:00
year: 2026
month: 2026-11
draft: true
weight: 40
tags: ["hoa", "foa", "ordnung", "konzert", "auffuehrung", "lautsprecher", "workflow"]
key_points:
  - "Die Lautsprecherzahl bestimmt die nutzbare Ordnung: mindestens (N+1)² Lautsprecher für Ordnung N"
  - "Eine höhere Ordnung vergrössert den Bereich mit korrekter Ortung, das zählt beim Publikum"
  - "In HOA7 produzieren, für den Raum ausspielen: die Ordnung lässt sich reduzieren, nie erhöhen"
difficulty: "intermediate"
post_kind: "background"
---

Level: Intermediate | **Audience:** Komponist:innen, Interpret:innen, Techniker:innen bei der Vorbereitung eines Lautsprecher-Konzerts.

---

**Kurzantwort:** Beim Konzert entscheidet der Raum. Bis etwa 8 Lautsprecher kann die Anlage nur FOA wiedergeben. Mit rund 16 Lautsprechern ist HOA3 die sinnvolle Ausspielordnung. Ab etwa 36 Lautsprechern (grosse Säle, Dome) lohnt sich HOA5 oder HOA7. Produziere in HOA7, solange dein Computer das schafft, und decodiere für den Raum.

---

## Was der Raum vorgibt

Die Lautsprecherzahl setzt die praktische Obergrenze. Für die Ordnung N brauchst du mindestens (N+1)² Lautsprecher: 4 für FOA, 16 für HOA3, 36 für HOA5, 64 für HOA7. Höhere Ordnungen werden berechnet, aber nicht vollständig wiedergegeben. Das ICST Kompositionsstudio mit seinen 18 Lautsprechern gibt etwa HOA3 vollständig wieder, ein Dome mit 64 Lautsprechern kann HOA7 nutzen.

Mehr Hintergrund in [Welche Ambisonics-Ordnung brauche ich?](/post/hoa-ordnung-wahl-praxis/).

---

## Warum das Publikum die Frage verändert

Am Kopfhörer oder auf einem einzelnen Sweet Spot liegen FOA und HOA3 oft nah beieinander. Ein Konzert hat viele Hörende auf vielen Plätzen. Der Bereich, in dem das Schallfeld korrekt wiedergegeben wird, wächst mit der Ordnung (bei 1 kHz etwa 5 cm bei FOA, 16 cm bei HOA3, 27 cm bei HOA5 und 38 cm bei HOA7, als Veranschaulichung). Bei FOA ist er kleiner als ein Kopf, bei HOA3 genügt er für eine Person, bei HOA7 für eine kleine Gruppe.

> [Aus deiner Erfahrung ergänzen: Wie verändert sich das Klangbild für Hörende abseits der Mitte im Studio oder im Konzertsaal? Welche Ordnung funktionierte für wie viele Plätze?]

---

## Ausspielung: reduzieren, nie erhöhen

Arbeite in der höchsten Ordnung, die dein Computer erlaubt, und decodiere für den Raum. Ein HOA7-Master lässt sich auf HOA3 oder FOA für eine kleinere Anlage, ein Stereo-Backup oder einen Binaural-Render reduzieren. Eine Session in niedrigerer Ordnung lässt sich nachträglich nie erhöhen. Siehe [B-Format-Master exportieren](/post/b-format-export-reaper/).

Bei schweren Sessions frierst du Encoder-Spuren zu Mehrkanal-Dateien ein. Das Abspielen einer eingefrorenen 64-Kanal-Datei brauchte in unserer REAPER-Messung 0.14 % CPU, statt der Encoder-Last jeder einzelnen Quelle.

---

## Decoder und Raum

In einem echten Saal stehen die Lautsprecher selten auf einer perfekten Kugel. Die Abstände sind verschieden, die Wände asymmetrisch. Skalierung und Laufzeitkompensation im Decoder sorgen dafür, dass der Schall zur richtigen Zeit bei den Hörenden ankommt. Siehe [ICST AmbiDecoder: Skalierung und Laufzeitkompensation](/post/decoder-skalierung-laufzeitkompensation/).

> [Aus deiner Erfahrung ergänzen: Für welche Lautsprecher-Layouts hast du decodiert (Ring, Dome, gemischt), und welche Decoder-Einstellungen hast du verwendet?]

---

## Checkliste für die Probe

- Die Lautsprecher-Zuordnung mit einem Testsignal auf jedem Kanal prüfen.
- Das Stück in der Zielordnung auf dem Aufführungsrechner laufen lassen, mit allen Effekten, und die CPU beobachten.
- Ein Stereo-Backup und einen Binaural-Render bereithalten.
- Eine Fassung in niedrigerer Ordnung (zum Beispiel HOA3) vorbereiten, falls die Anlage begrenzt ist.
- Plugin-Versionen und Interface-Routing schriftlich festhalten.

Die ausführliche Checkliste und die Aufführungsstrategie stehen in [Komposition in Ambisonics](/post/komposition-in-ambisonics/). Für Kopfhörer-Kontrollen in der Vorbereitung siehe [Binaural Monitoring](/post/binaural-monitoring-icst-workflow/).

> [Aus deiner Erfahrung ergänzen: deine übliche Probenroutine, wie lange der Soundcheck dauert, welche Probleme am häufigsten auftreten.]

---

## Empfehlung

| Situation | Ordnung |
|---|---|
| Kleine Anlage (4 bis 8 Lautsprecher), Skizzen, nur Kopfhörer | FOA |
| Studio oder Saal mit 16 bis etwa 35 Lautsprechern | HOA3 |
| Grosser Saal oder Dome mit 36 oder mehr Lautsprechern | HOA5 oder HOA7 |
| Archiv- und Masterdateien | HOA7 |
