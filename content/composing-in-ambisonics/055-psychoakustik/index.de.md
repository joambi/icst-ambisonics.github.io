---
title: "Psychoakustische Grundlagen der Raumwahrnehmung"
description: "Wie das Gehör räumliche Klänge lokalisiert — und was Komponist:innen daraus ableiten können."
date: 2026-01-01T00:00:00
weight: 55
translationKey: "composing-psychoacoustics"
---

Räumliche Komposition setzt voraus, dass Wahrnehmungseffekte zuverlässig erzielt werden können. Ein Klang soll näher klingen, eine Stimme soll von oben kommen, eine Bewegung soll von links nach rechts verlaufen — all das kann nur dann als kompositorisches Material funktionieren, wenn es vom Gehör tatsächlich so erlebt wird. Dieses Kapitel gibt einen Überblick über die wichtigsten Mechanismen räumlicher Wahrnehmung und leitet daraus konkrete Konsequenzen für das Komponieren in Ambisonics ab.

Die psychoakustischen Grundlagen der Raumwahrnehmung sind kein rein technisches Thema. Sie beschreiben, was das Gehör leisten kann, wo es an Grenzen stößt und unter welchen Bedingungen räumliche Ereignisse stabil, mehrdeutig oder wirkungslos werden. Wer diese Mechanismen kennt, komponiert nicht gegen die Wahrnehmung, sondern mit ihr.

## Das binaurale System: Horizontale Lokalisation

Der erste und grundlegendste Mechanismus räumlicher Wahrnehmung ist binauraler Natur: Das Gehirn vergleicht die Signale beider Ohren und wertet Unterschiede aus, um horizontale Positionen zu bestimmen.

**ITD (Interaural Time Difference)** bezeichnet den Laufzeitunterschied eines Schallereignisses zwischen linkem und rechtem Ohr. Ein Klang von links erreicht das linke Ohr früher. Diese Zeitdifferenz wird vom Gehirn präzise ausgewertet und ist vor allem bei tiefen Frequenzen (unter ca. 1,5 kHz) der dominant Lokalisationshinweis.

**ILD (Interaural Level Difference)** beschreibt den Pegelunterschied zwischen beiden Ohren, der durch den Schallschatten des Kopfes entsteht: Das dem Klang abgewandte Ohr erhält weniger Energie. ILD ist besonders bei hohen Frequenzen (über ca. 1,5 kHz) wirksam.

Beide Cues ergänzen sich im sogenannten **Duplex-Modell**: Tieffrequente Klanganteile werden primär über ITD lokalisiert, hochfrequente über ILD. Klangobjekte mit breitem Frequenzspektrum sind daher am leichtesten und zuverlässigsten zu lokalisieren.

*Kompositorische Konsequenz:* Schmalbandige Tieftöne (Bässe, Sinustöne unter 500 Hz) sind lateral schlecht lokalisierbar. Wer räumliche Trennschärfe benötigt — etwa für einen klar geführten Kontrapunkt zwischen zwei Stimmen — sollte auf Klangmaterial zurückgreifen, das ausreichend Energie im Mittel- und Hochfrequenzbereich trägt. Tieffrequente Materialien eignen sich eher für diffuse Felder oder Einhüllungseffekte.

## HRTF: Elevation und Vorne-Hinten

Die horizontale Ebene allein genügt nicht, um ein dreidimensionales Klangbild zu erzeugen. Für Elevation (oben/unten) und für die Auflösung der Vorne-Hinten-Ambiguität ist ein weiterer Mechanismus zuständig: die **Head-Related Transfer Function (HRTF)**.

HRTFs beschreiben, wie Aussenohr (Ohrmuschel), Kopf und Schultern eintreffenden Schall je nach Richtung spektral färben. Ein Klang von oben wird anders gefiltert als einer von unten oder von hinten — diese charakteristischen Spektralspuren werden vom Gehirn als Richtungshinweise ausgewertet.

HRTFs sind **individuell**: Jede Person hat leicht andere Ohrmuscheln, einen anderen Kopf, eine andere Schulterform. Generische HRTFs (wie sie in Binaural-Decodern verwendet werden) funktionieren bei vielen Hörer:innen gut genug, können aber bei einzelnen Personen zu fehlerhafter Elevation, zu Innen-Klang (In-Head-Localisation) oder zu Verwechslungen von vorne und hinten führen.

*Kompositorische Konsequenz:* Elevation-Gesten sind wirksam, aber fragil. Sie sind besonders anfällig für starke spektrale Eingriffe (EQ, Effekte), die die HRTF-Fingerabdrücke maskieren. Für kompositorische Wirkung ist es hilfreich, Elevationsunterschiede mit anderen Cues zu kombinieren — etwa mit Distanz- oder Bewegungsveränderungen — um die Wahrnehmung zu stabilisieren.

## Distanzwahrnehmung: Mehrere Hinweise, keine zuverlässige Einzelgrösse

Distanz wird nicht durch einen einzelnen Mechanismus, sondern durch das Zusammenwirken mehrerer Cues bestimmt:

- **D/R-Verhältnis (Direct-to-Reverberant Ratio):** Das Verhältnis von Direktschall zu diffusem Hallanteil ist der stärkste Distanzhinweis. Viel Direktschall → nah; viel Hallanteil → fern. Dieser Effekt lässt sich in Ambisonics über die Distanzparameter im Encoder steuern.
- **Lautstärke:** Stärkerer Pegel wird tendenziell als Nähe wahrgenommen — ist aber stark kontextabhängig und durch musikalische Gewohnheiten überlagert.
- **Luftabsorption:** Bei großen Distanzen dämpft Luft bevorzugt hohe Frequenzen. Dieser Effekt kann kompositorisch simuliert werden (Hochfrequenzabsenkung = mehr Distanz).
- **Spectral Brightness:** Nähe wird oft mit grösserem Höhenpegel assoziiert; Ferne mit einem dumpfen, gefilterten Klangbild.

*Kompositorische Konsequenz:* Die stärkste Distanzwirkung entsteht durch das **kombinierte Steuern** von D/R-Verhältnis, Pegelverlauf und spektraler Helligkeit. Wer nur den Pegel ändert, erzeugt Lautheit, nicht Distanz. Erst das gleichzeitige Verschieben mehrerer Cues macht Nähe und Ferne überzeugend erlebbar.

## Einhüllung und Quellenbreite: LEV und ASW

Zwei psychoakustische Größen beschreiben, wie ein Klangfeld als immersiv oder objektorientiert erlebt wird:

**LEV (Listener Envelopment)** ist das Gefühl, von Klang umgeben zu sein. Es wird primär durch **späte laterale Reflexionen** erzeugt — also durch diffuse Energie, die aus seitlichen und rückwärtigen Richtungen eintrifft. Hohe LEV lässt sich durch Diffusion, rückwärtige Spreizung und hallige Texturschichten erzeugen.

**ASW (Apparent Source Width)** beschreibt, wie breit eine Quelle erscheint. Es wird primär durch **frühe laterale Reflexionen** bestimmt. Eine Quelle mit hohem Spread oder breiter Multikanal-Enkodierung klingt grösser und raumfüllender.

Der kompositorisch entscheidende Unterschied: ASW betrifft die **wahrgenommene Grösse eines Objekts**, LEV betrifft die **räumliche Umgebung**. Beide lassen sich in Ambisonics über Spread, Diffusion und Hallanteil unabhängig voneinander gestalten.

*Kompositorische Konsequenz:* Für ein überzeugendes immersives Klangerlebnis reicht es nicht, Quellen im Kreis zu verteilen. Envelopment entsteht erst durch **diffuse Energie** — durch Texturen, Hall und Schichten, die von allen Seiten gleichzeitig eintreffen. Präzise lokalisierte Punkt-Quellen allein erzeugen kein Einhüllungsgefühl, egal wie viele es sind.

## Das System als Ganzes: Konsistenz der Cues

Die wirkmächtigsten räumlichen Momente entstehen nicht dadurch, dass ein einzelner Cue stark ist, sondern dadurch, dass **mehrere Cues konsistent zusammenwirken**. Ein überzeugend nahes Klangereignis hat hohen Direktschall, wenig Hall, helle Spektralmischung und eine klare ILD-Lateral-Position. Wenn diese Cues widersprüchlich sind — zum Beispiel ein sehr lauter Klang mit viel Nachhall — entsteht räumliche Mehrdeutigkeit oder Instabilität.

Diese Konsistenz ist zugleich eine kompositorische Ressource: Widersprüchliche Cues können als Mittel der Irritation oder Verfremdung eingesetzt werden. Räumliche Instabilität ist keine Fehlfunktion, sondern ein kompositorisch steuerbarer Effekt.

## Perceptual Limits: Was zuverlässig ist, was fragil

Einige Parameter der räumlichen Wahrnehmung sind robust, andere sind kontext- und setupabhängig.

**Zuverlässig:** Laterale Lokalisation (links/rechts) über ITD und ILD funktioniert bei breitbandigen Klängen auf Lautsprechern wie binaural gut. Grobe Distanzunterschiede (nah vs. fern) sind gut wahrnehmbar, wenn mehrere Cues zusammenwirken. Envelopment über diffuse Energie ist robust.

**Fragil:** Elevation ist HRTF-abhängig und setup-sensitiv. Auf Lautsprechern mit physischen Höhenkanälen ist sie besser als binaural. Front-Back-Auflösung kann auf Lautsprechern versagen, wenn das Dekodiergitter zu grob ist oder der Hörpunkt ausserhalb des Sweet Spots liegt. Präzise Distanzkodierung braucht konsistente Hallbedingungen — sie versagt, wenn die Raumakustik des Wiedergaberaums die kodierten Raumanteile überdeckt.

*Kompositorische Konsequenz:* Je stärker eine räumliche Idee von fragilen Cues abhängt, desto wichtiger ist es, sie mit robusteren zu kombinieren. Ein Klang, der sich nur durch Elevation definiert, kann in vielen Aufführungssituationen verloren gehen. Wer Elevation kompositorisch nutzen will, verknüpft sie mit Distanz-, Bewegungs- oder spektralen Veränderungen, die auch dann noch wahrnehmbar sind, wenn die HRTF-Auflösung nachlässt.

---

Das Wissen über diese Mechanismen ist keine Einschränkung für das Komponieren — es ist das Fundament, auf dem räumliche Form verlässlich gebaut werden kann. Die folgenden Kapitel bauen auf dieser Grundlage auf: Raumparameter beschreibt, wie die einzelnen Parameter kompositorisch eingesetzt werden; Spatial Counterpoint zeigt, wie mehrere Quellen in räumlicher Stimmführung zueinander in Beziehung gesetzt werden.
