---
title: "Live-Elektronik und Performance in Ambisonics"
description: "Ambisonics im Aufführungskontext: Echtzeit-Raumverarbeitung, Instrument und Live-Elektronik, Performance-Workflow und spezifische Herausforderungen."
date: 2026-01-01T00:00:00
weight: 88
translationKey: "composing-live-electronics"
---

Das bisher beschriebene Komponieren in Ambisonics ist vorwiegend auf **festes Medium** ausgerichtet: ein Stück wird im Studio produziert, als B-Format-Master archiviert und in der Aufführung abgespielt. Dieser Workflow hat klare Vorteile — vollständige Kontrolle über jeden Parameter, unabhängige Qualitätskontrolle, Transferierbarkeit über Formate und Setups hinweg.

Sobald aber Ambisonics im **Live-Kontext** eingesetzt wird — mit Instrumenten, Stimme, oder interaktiver Elektronik — verschieben sich die Prioritäten grundlegend. An die Stelle von Kontrolle tritt Reaktionsfähigkeit. Stabilität und Präzision müssen mit Echtzeit-Anforderungen, variierenden Aufführungsbedingungen und der Dynamik des performativen Moments ausbalanciert werden.

## Was unterscheidet Live-Ambisonics von Fixed Media

Der entscheidende Unterschied ist die **Zeitstruktur der Entscheidungen**. Im Produktionsstudio können räumliche Entscheidungen jederzeit rückgängig gemacht oder verfeinert werden. In der Aufführung sind sie irreversibel: Was einmal im Ambisonics-Feld platziert ist, bleibt dort — bis zur nächsten steuerbaren Veränderung.

Das hat direkte kompositorische Konsequenzen:

- **Räumliche Präzision** muss gegen Robustheit abgewogen werden. Eine aufwändige Automatisierung, die im Studio perfekt klingt, kann in der Aufführung durch Latenz, Hardware-Varianz oder Monitoring-Abweichungen destabilisiert werden.
- **Monitoring für Interpreten** ist grundsätzlich anders als Monitoring für Produktion. Wer auf einer Bühne spielt, hört das Ambisonics-Feld oft nur partiell oder gar nicht — oder über Bühnenmonitore, die kein räumliches Bild liefern.
- **Räumliche Dramaturgie** muss live-tauglich sein: Übergänge, Bewegungen und Klangfeldveränderungen müssen reproduzierbar und unter Aufführungsbedingungen sicher ausführbar sein.

## Typische Live-Setups im ICST-Kontext

Im ICST-Studio haben sich drei Haupt-Konfigurationen für Live-Ambisonics herausgebildet:

### 1. Fixed Media mit Live-Instrument

Die häufigste Konfiguration: Ein vorproduziertes Ambisonics-Playback wird durch ein Instrument ergänzt, das seinerseits live in Ambisonics enkodiert wird. Das Fixed-Media-Playback liefert den räumlichen „Boden" des Stückes; das Instrument trägt Live-Material ins Feld.

**Kompositorische Überlegungen:**
- Die Trennbarkeit von Fixed-Media-Quellen und Live-Instrument im Ambisonics-Feld hängt von ihrer räumlichen Positionierung und timbalen Differenzierung ab.
- Das Live-Instrument kann statisch positioniert sein (fester Azimut/Elevation im Encoder) oder durch eine Performance-Person oder OSC-Steuerung bewegt werden.
- Bei rein statischer Positionierung des Instruments kann dessen Ambisonics-Verortung trotzdem durch Raumeffekte (Hall, Spread) variiert werden.

### 2. Vollständig Live — Echtzeit-Ambisonics

Alle Klangereignisse werden in Echtzeit enkodiert und räumlich verarbeitet. Typisch für interaktive Systeme, algorithmische Komposition oder improvisierte räumliche Musik.

**Technische Grundvoraussetzungen:**
- Niedrige Latenz ist essenziell: für Ambisonics-Encoding mit ICST-Plugins ist REAPER in einem stabilen Echtzeitmodus zu betreiben (ASIO oder CoreAudio-Treiber, Puffergrößen typischerweise 64–256 Samples)
- Dedizierte Hardware: performancetaugliche CPU, stabile Audioschnittstelle
- OSC oder MIDI für Echtzeit-Steuerung räumlicher Parameter ist empfehlenswert, wenn mehrere Quellen gleichzeitig bewegt werden sollen

### 3. Hybridform — Interaktive Triggerung

Eine Zwischenform: Räumliche Ereignisse oder Positionen werden live getriggert oder moduliert, aber innerhalb einer vordefinierten Struktur. Das Stück hat eine feste dramaturgische Logik, aber der Interpret kann innerhalb festgelegter Zonen räumlich agieren.

Diese Konfiguration ist besonders geeignet für kompositorisch kontrollierte, aber performativ lebendige Aufführungssituationen.

## Für Komponierende: ICST Externals, Envelopes und Ableton Live

Wenn du Live-Elektronik in Ambisonics komponierst, sind nicht nur die REAPER-Plugins relevant, sondern auch die **ICST Ambisonics Tools** in Max/MSP und deren Erweiterung in Ableton-orientierte Workflows.

- **ICST Ambisonics Tools / Externals**: für eigene Live-Patches, algorithmische Verräumlichung und Echtzeit-Quellensteuerung in Max. Das ist der richtige Weg, wenn die Performance-Logik selbst Teil der Komposition ist. Siehe [ICST Ambisonics Tools](/de/icst-ambisonics-tools/).
- **Envelope-basierte Bewegung in REAPER**: für Stücke, in denen räumliche Verläufe reproduzierbar, aber trotzdem performativ ausführbar bleiben sollen. Das eignet sich für cue-basierte Live-Formen, Hybrid-Playback oder präzise zeitlich gesetzte Einsätze. Siehe [Step by Step Setup](/de/icst-ambisonics-plugins/06_step_by_step_setup/) und [ICST ReaScripts](/de/post/icst-scripts/).
- **Ableton Live + ICST Workflow**: sinnvoll, wenn Clips, Szenenlogik, Max for Live oder hybride elektronische Performance zentral für das Stück sind. Siehe [Ableton Live & ICST Ambisonics Integration](/de/post/ableton_reaper/).
- **Envelop for Live und verwandte Ableton-zentrierte Ansätze**: relevant, wenn räumliche Performance über Live-Sets, Max-for-Live-Devices und gestische Kontrolle organisiert wird. Für den grösseren Werkzeugvergleich siehe [Werkzeuge und Software](/de/composing-in-ambisonics/08-werkzeuge-und-software/).

Ein konkreter ICST-Live-Referenzfall ist Vincent Cears' **A Year in Dark Tones**, dokumentiert in [ASCOLTA #3](/de/blog/ascolta/03-ascolta/): eine **Live-Improvisation in Ambisonics 3. Ordnung**, die während der Residency entstand und Performance, immersive Inszenierung und praktische Ambisonics-Konvertierung verbindet.

Ein weiteres künstlerisches Referenzbeispiel ist Franziska Baumanns Live-Arbeit im Raum:

{{< youtube g2ZGXN_2oX4 >}}

## Monitoring im Live-Kontext

Im Studio kann Monitoring zwischen verschiedenen Perspektiven wechseln — Lautsprecher, binaural, unterschiedliche Decoder. Im Aufführungskontext ist diese Flexibilität eingeschränkt. Das hat praktische Konsequenzen:

**Interpreten-Monitoring:** Bühnenmonitore liefern in der Regel kein räumliches Bild des Ambisonics-Feldes. Instrumentalistinnen und Instrumentalisten hören sich selbst und das Fixed-Media-Playback als Mono- oder Stereo-Mix. Das bedeutet: Die räumliche Einbettung des Instruments ins Ambisonics-Feld ist primär für das Publikum — nicht für die Interpretin.

**Konsequenz für Notation und Partitur:** Wenn Interpreten räumliche Aspekte ihres Spiels anpassen sollen (z.B. durch Bewegung des Instruments, durch veränderte Spieldynamik in bestimmten Raumzonen), muss die Partitur das explizit angeben. Die räumliche Rückkopplung fehlt; was im Studio als unmittelbare Reaktion auf das Gehörte möglich war, ist auf der Bühne blind.

**Publikums-Monitoring:** Die Hörposition des Publikums variiert bei jeder Aufführung. Fixed Seating im Sweet Spot ist selten; in Dome-Setups oder Lautsprecher-Arrays hören verschiedene Personen unterschiedliche Versionen des Klangfeldes. Kompositionen für Live-Ambisonics sollten daher mehr auf räumliche Energie und Einhüllung setzen, die auch aus nicht-zentralen Positionen erfahrbar sind, als auf präzise Lokalisation, die nur im Zentrum funktioniert.

## Räumliche Parameter im Live-Kontext

Nicht alle räumlichen Parameter sind gleich gut für den Live-Einsatz geeignet.

**Robuste Parameter für Live:**
- Azimut-Positionierung (Seitlichkeit) — zuverlässig wahrnehmbar über das gesamte Publikumsfeld
- Spread/Diffusion — gut steuerbar, liefert konstante Wirkung über den Raum
- Distance/Reverb-Balance — erzeugt LEV-Effekte, die setup-unabhängig wahrnehmbar sind
- Slow movement / largo trajectories — können auf der Bühne sicher ausgeführt werden

**Fragile Parameter für Live:**
- Elevation bei kleinen Arrays — viele Aufführungsorte haben kein oder ein schwaches Overhead-Setup
- Präzise Lokalisation kleiner Winkelabstände — hängt von Decoder-Qualität und Lautsprecher-Kalibrierung ab
- Schnelle Bewegungen über enge Azimut-Bereiche — können bei Latenz oder Jitter instabil wirken

## Notation für Live-Ambisonics

Für Stücke mit Live-Ambisonics-Komponenten empfiehlt sich eine **performancetaugliche Notation**, die parametrische Präzision mit szenarischer Lesbarkeit verbindet. Einige Leitlinien:

**Was in der Partitur stehen sollte:**
- Räumliche Zonen (nicht exakte Winkel) für jede Quelle: „links hinten", „über dem Publikum", „Vorderfeld"
- Timing und Dauer von räumlichen Ereignissen oder Übergängen
- Kritische Momente wo räumliche Abstimmung zwischen Instrument und Playback wichtig ist
- Hinweise auf Monitoring-Situation und Abhängigkeiten

**Was technisch zu klären ist:**
- Latenz-Kompensation zwischen Fixed Media und Live-Encoding
- Lautsprecher-Konfiguration am Aufführungsort: HOA-Ordnung anpassen?
- OSC/MIDI-Routing für eventuell bewegte Parameter
- Soundcheck-Zeit für räumliche Kalibrierung

## Kompositorische Konsequenz

Live-Ambisonics ist kein einfach erweiterter Produktionsstudio-Workflow. Es ist ein eigenes kompositorisches Genre mit eigenen Stärken und Einschränkungen. Die Stärken liegen in der Reaktionsfähigkeit, im performativen Moment, in der Verbindung von Körper und Raumklang. Die Einschränkungen liegen in der geringeren Präzision, dem eingeschränkten Monitoring und der erhöhten Abhängigkeit von wechselnden Aufführungsbedingungen.

Kompositorisch fruchtbar wird Live-Ambisonics dort, wo die Unschärfe des Live-Moments selbst zum Material wird — wo räumliche Varianz nicht als Fehler gilt, sondern als Teil der Aufführungsdimension. Das unterscheidet sich grundlegend von einem Produktionsansatz, der auf maximale Reproduzierbarkeit abzielt. Wer für den Live-Kontext komponiert, komponiert auch für das Unvorhergesehene: das Raumprofil des Aufführungsorts, die Besetzung des Publikumsraums, die Energie des performativen Moments.

Das ICST bietet im Rahmen seiner [Residenzprogramme](/residenzen/) Möglichkeiten, Live-Ambisonics-Konzepte in unterschiedlichen Aufführungskontexten zu erproben. Die technische Dokumentation der ICST-Plugins enthält zudem Hinweise zur [Echtzeit-Routing-Konfiguration in REAPER](/icst-ambisonics-plugins/06_step_by_step_setup/).
