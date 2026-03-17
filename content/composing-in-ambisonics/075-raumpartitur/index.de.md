---
title: Räumliche Notation und Raumpartitur
description: Wie lässt sich Raumklang aufschreiben? Überblick über
  Notationsansätze, vom grafischen Klang-Zeit-Diagramm bis zur praktischen
  Raumpartitur im ICST/REAPER-Kontext.
date: 2026-01-01T00:00:00
weight: "77"
draft: false
translationKey: composing-spatial-notation
---

In der traditionellen Partitur bewegt sich Notation auf zwei Achsen: Zeit (horizontal) und Tonhöhe (vertikal). Raum erscheint, wenn überhaupt, als Randbemerkung — „ff aus der Kulisse", „Fernorchester", „linkes Seitenorchester" — statt als strukturell verankerte Dimension. Für Ambisonics-Kompositionen, in denen Azimut, Elevation, Distanz, Bewegung und Diffusion gleichwertige Parameter sein können, ist diese Lücke erheblich.

Die Frage der Raumpartitur ist daher nicht nur praktisch-archivisch. Sie ist auch konzeptuell: In welchem Format lässt sich räumliche Form überhaupt sichtbar machen — für sich selbst, für andere Studios, für spätere Rekonstruktionen und für die Aufführungspraxis?

## Bestehende Ansätze

Es gibt kein universelles Notationssystem für Raumklang. In der Praxis haben sich mehrere Formate herausgebildet, die je nach Kontext unterschiedliche Vor- und Nachteile haben.

### Grafische Partitur

Die grafische Partitur der Neuen Musik — Feldman, Cardew, Haubenstock-Ramati — macht Form und Energie sichtbar, ohne Tonhöhe zu fixieren. Für Raumklang lässt sich dieser Ansatz erweitern: Klangobjekte erscheinen auf einer Zeitachse, ihre räumliche Position wird als geometrische Lage im Bild codiert. Viele elektroakustische Komponistinnen und Komponisten — darunter Denis Smalley, Hildegard Westerkamp, Barry Truax — verwenden solche grafischen Darstellungen in Analysen und Kommentaren.

**Stärke:** Expressiv, kommunikativ, gut lesbar als Überblick.  
**Schwäche:** Selten präzise genug für eine technische Rekonstruktion.

### Draufsicht-Diagramm (Radar-Plan)

Am verbreitetsten in der Raumklangpraxis ist das **Draufsicht-Diagramm**: eine Kreisscheibe, in der Azimut-Positionen als Winkel und Distanz als Radialabstand eingetragen werden. Dieses Format findet sich auch im ICST MultiEncoder als interaktive Radar-GUI.

Es eignet sich gut für statische Schnappschüsse — Positionen zu einem bestimmten Zeitpunkt oder innerhalb einer Phase — sowie für Trajektorien, die als Pfeile oder Kurven eingezeichnet werden.

**Stärke:** Intuitiv, direkt mit dem ICST-Workflow verknüpfbar, gut für Bewegungsverläufe in der Horizontalen.  
**Schwäche:** Elevation und zeitliche Verläufe sind schwer darstellbar.

### Parameter-Timeline

Das Format, das der DAW-Arbeit am nächsten kommt, ist die **Parameter-Timeline**: eine Zeitleiste, in der räumliche Parameter wie Azimut, Elevation, Distanz und Spread als übereinanderliegende Kurven dargestellt werden. Dies entspricht im Wesentlichen einer lesbaren Exportversion der REAPER-Automationsspuren.

**Stärke:** Präzise, direkt rekonstruierbar, lückenloser Zeitverlauf.  
**Schwäche:** Schwer intuitiv lesbar; kommuniziert räumliche Gesten kaum als Gesamtbild.

### Equirektanguläre Projektion

Für vollständig dreidimensionale Verläufe bietet die **equirektanguläre Projektion** die vollständigste Darstellung: eine rechteckige Karte, in der Azimut horizontal und Elevation vertikal eingetragen ist. Trajektorien erscheinen als Kurven auf dieser Fläche. Das Format ist aus der 360°-Video- und VR-Notation bekannt und liegt einigen Forschungsstandards wie SpatDIF (Spatial Sound Description Interchange Format) zugrunde.

**Stärke:** Vollständige 3D-Abbildung; geeignet für Stücke mit starker Vertikaldimension.  
**Schwäche:** Weniger intuitiv lesbar; Verzerrungen an den Polen.

## Die Ambisonics-Raumpartitur in der Praxis

Für den ICST-Kontext empfiehlt sich eine **pragmatische Mischform**: kein einziges universelles Notationsformat, sondern ein Dokumentationspaket, das verschiedene Perspektiven auf die räumliche Struktur versammelt.

Ein minimales Raumpartiturdokument enthält:

**1. Technische Rahmendaten**  
Ordnung und Formatkonvention (z.B. 3. Ordnung, ACN/SN3D), verwendete Decoder-Konfiguration, Plugins und Versionsnummern, primäres Zielsystem.

**2. Schematische Quellenübersicht**  
Liste der Spuren oder Quellen mit ihrer kompositorischen Funktion (Hauptstimme, Begleitschicht, Raumfeldelement), typischer räumlicher Zone und Bewegungscharakteristik.

**3. Radar-Plan für strukturell wichtige Momente**  
Draufsicht-Diagramme als Schnappschüsse für Schlüsselmomente: Beginn, Höhepunkt, Auflösung. Trajektorien eingezeichnet als Pfeile oder Kurven.

**4. Automation-Screenshot**  
Export oder Screenshot der REAPER-Automationsspuren für die wesentlichen räumlichen Parameter (Azimut, Elevation, Distanz, Spread). Dies ist technisch präzise und direkt mit der Session verknüpfbar.

**5. Verbale Beschreibung der räumlichen Dramaturgie**  
Ein kurzer Text, der festhält, wo die Knotenpunkte räumlicher Veränderung liegen, welche Gesten strukturell konstitutiv sind und wo Präzision wesentlich ist — im Gegensatz zu Bereichen, in denen Flexibilität erlaubt ist.

## Raum-Zeitachsen als kompositorisches Planungswerkzeug

Die Raumpartitur ist nicht nur für die Dokumentation abgeschlossener Stücke nützlich. Sie kann auch als **kompositorisches Planungswerkzeug** eingesetzt werden — bevor die Session aufgebaut wird.

Eine grobe Raum-Zeitachse hält fest, welche räumlichen Zonen zu welchem Zeitpunkt aktiv oder dominant sind: vorne/hinten, hoch/tief, nah/fern, diffus/fokussiert. Dieses Vorgehen ähnelt dem Skizzieren einer Klangfarben-Dramaturgie oder eines harmonischen Spannungsbogens: Man beschreibt nicht jeden Klang im Detail, sondern den räumlichen Formverlauf des Stückes.

| Zeit | Vorne | Hinten | Oben | Distanz | Diffusion |
|------|-------|--------|------|---------|-----------|
| 0:00–1:00 | Hauptquelle | leer | leer | nah | gering |
| 1:00–2:30 | Hauptquelle | Resonanzschicht | — | mittel | zunehmend |
| 2:30–3:30 | — | — | Einhüllung | weit | hoch |
| 3:30–4:00 | Rückkehr | — | — | nah | gering |

Auch grob gehalten macht eine solche Tabelle sofort sichtbar, ob das Stück räumlich abwechslungsreich gebaut ist — oder ob alle Energie in einer einzigen Zone verharrt. Lücken in der Tabelle werden zu kompositorischen Fragen: Was passiert hinten, wenn vorne die Hauptstimme läuft? Ist das eine bewusste Entscheidung?

## Notation als Kommunikationsaufgabe

Jenseits der eigenen Arbeit stellt sich die Frage, welche Informationen andere Studios, Interpreten oder Aufführungssituationen benötigen, um das Stück zu realisieren. In diesem Sinn ist die Raumpartitur eine **Kommunikationsaufgabe**.

Für Aufführungskontexte sind besonders relevant:

- Lautsprecherplan und Decoder-Konfiguration
- HOA-Ordnung und Formatkonvention
- kritische Abhängigkeiten von bestimmten Raumzonen — insbesondere Vertikalbewegungen, die ohne Overhead-Lautsprecher verloren gehen
- Monitoringanforderungen und Flexibilitätsspielraum (was kann das Stück wegstecken, was nicht?)

Ein einfaches Notationsdokument, das diese Punkte abdeckt, erhöht erheblich die Chance, dass ein Stück nicht nur im Entstehungskontext, sondern auch in fremden Aufführungsumgebungen funktioniert.

## Kompositorische Konsequenz

Die Raumpartitur ist kein bürokratischer Zusatzaufwand, sondern ein direkter Reflex auf eine grundlegende Eigenheit räumlicher Komposition: **Räumliche Entscheidungen lassen sich schwer hörbar kommunizieren.** Ein Akkord lässt sich benennen; eine räumliche Geste — die koordinierte Bewegung von drei Quellen über einen Sphärenbereich in fünfzehn Sekunden — lässt sich ohne Diagramm oder Automation-Screenshot kaum vollständig beschreiben.

Das Erstellen einer Raumpartitur zwingt dazu, die eigene räumliche Komposition zu formalisieren: was konstitutiv ist, was flexibel, was situationsabhängig. Dieser Formalisierungsakt schärft den kompositorischen Blick — nicht anders als das Niederschreiben einer harmonischen Analyse das Verständnis einer Passage verändern kann.

Im ICST-Studio gehört die Raumpartitur daher zum Standard-Repertoire der Kompositionsdokumentation — nicht als Pflicht, sondern als Denkwerkzeug. Die [10 Fragen](/de/composing-in-ambisonics/04-die-10-fragen/) bieten einen praktischen Einstiegsrahmen: Frage 10 (Werkidentität und Dokumentation) lässt sich direkt in die hier beschriebenen Dokumentationsebenen übersetzen.
