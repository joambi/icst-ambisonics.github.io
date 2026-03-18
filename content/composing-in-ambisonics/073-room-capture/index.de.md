---
title: "Raum erfassen und Raum synthetisch erzeugen"
description: "Ein praktischer Leitfaden für Ambisonics-Komponist:innen zu akustischer Eingewöhnung, Raumanalyse und der Entscheidung zwischen Trockenproduktion, künstlichem Hall und Faltungshall."
date: 2026-01-01T00:00:00
weight: 78
draft: false
translationKey: "composing-room-capture"
languageCode: de
---

Zu Beginn eines musikalischen Arbeitsprozesses ist es für Musiker:innen essenziell, sich mit den akustischen Eigenschaften des jeweiligen Raumes vertraut zu machen, sei es ein Konzertsaal, eine Kirche oder ein Studio. Als Komponist:in für 3D-Ambisonics-Fixed-Media stellen sich dieselben grundlegenden Fragen — und darüber hinaus einige spezifische, die aus der Natur der räumlichen Audiotechnik entstehen.

## Akustische Eingewöhnung

Bevor eine Arbeitssession beginnt, hört und beurteilt jede erfahrene Interpretin den Raum. Eine Geigerin testet, wie ihr Bogendruck und Vibrato mit einer langen Nachhallzeit interagieren. Eine Sängerin passt Artikulation und Dynamik an, damit Text und Ausdruck nicht im Hallnachhall des Saals verloren gehen (Kalkandjiev & Weinzierl, 2023). Ein Schlagzeuger könnte das Becken abkleben, um unerwünschte Hochfrequenzstreuung zu reduzieren.

Das Äquivalent für Ambisonics-Komponist:innen ist ein **Hörgang**: Bewege dich durch den Raum, bevor du anfängst zu arbeiten. Klatsche, und beobachte, was du hörst. Frage dich: Wo sammelt sich der Klang? Wie lang ist der Nachhall? Verschmiert er Transienten? Was passiert an den Raumgrenzen?

Dieser erste Eindruck prägt alle kompositorischen Entscheidungen, die folgen.

## Den Raum analysieren

Nach dem ersten Hören ist eine systematischere Analyse nützlich. Werkzeuge zur Messung von Raumimpulsantworten (RIR) wie Room EQ Wizard, Maat thEQred oder auch eine einfache Startpistolen-Aufnahme liefern:

- **RT60** — die Zeit, die der Schall braucht, um um 60 dB abzuklingen, aufgeteilt nach Frequenzbändern
- **Frühe Reflexionen** — die ersten diskreten Rückwürfe, die Klarheit und räumliche Breite prägen
- **Frequenzgang** — Resonanzmoden, die bestimmte Tonhöhen einfärben
- **Diffusfeld-Verhalten** — wie gleichmässig Energie über den Raum abklingt

Ein Raum mit RT60 > 2 Sekunden verschmiert rhythmisch dichte Figuren. Ein sehr kurzer Abklingwert (< 0,3 s, typisch für kleine Studios) macht trockene räumliche Positionierung sehr präzise, kann aber auf Dauer ermüdend wirken. Diese Kenntnis ermöglicht **informierte kompositorische Entscheidungen**, anstatt Probleme erst beim Konzert zu entdecken.

## Anpassungen und praktische Korrekturen

Wenn der Raumcharakter bekannt ist, stellt sich die Frage: Was lässt sich überhaupt verändern?

- **Hallanteil**: Künstlichen Reverb im Ambisonics-Mix reduzieren, wenn der Saal selbst bereits genug Raum liefert
- **Distanzsimulation**: Quellen etwas nach innen ziehen, damit sie im stark hallenden Raum nicht übermässig weit entfernt klingen
- **Filterung**: Tiefe Frequenzen leicht absenken, wenn der Raum starke Basshäufung aufweist
- **Tempo und Gestendichte**: Schnelle Gesten und dichte räumliche Bewegungen kollabieren in langen Nachhallzeiten; ruhigere, langsamere räumliche Schreibweisen überstehen den Transfer oft besser
- **Trockene vs. diffuse Quellen**: Eine trockene, nahklingende Quelle schneidet besser durch; ein diffuses Klangbett füllt und verbindet

Dieselbe Anpassungslogik, die ein Streichquartett auf seine Artikulation in einer Kirche anwendet, gilt für den Ambisonics-Mix: **Der Raum ist Teil des Instruments**.

## Ambisonics-spezifische Herausforderungen

### Bewegungen in unterschiedlichen Raumkonfigurationen

Eine räumliche Trajektorie — ein Klang, der von vorne nach hinten wandert oder spiralförmig über Kopf läuft — klingt je nach Wiedergabesystem deutlich unterschiedlich. Was im dichten 24-Lautsprecher-Ring des ICST-Studios scharf und klar ist, kann in einem weniger symmetrischen Konzertsaal-Array als breiter Schmier ankommen. Das ist keine Schwäche der Komposition, sondern eine Eigenschaft von Ambisonics: Das dekodierte Klangbild interagiert immer mit der Wiedergabegeometrie und dem Hörsaal.

Praktisch bedeutet das:

- Langsame Bewegungen überstehen den Transfer auf andere Aufführungsorte besser als sehr schnelle
- Breite, diffuse Klangfelder sind layout-robuster als enge Punktquelltrajektorien
- Wenn präzise Lokalisation künstlerisch wesentlich ist, sollte das Stück vor der Uraufführung auf mehreren Systemen getestet werden

### Downmix auf Stereo und Kopfhörer

Eine zweite Schlüsselfrage ist: **Funktioniert das Stück im Stereo-Downmix und auf Kopfhörern?** Viele Hörer:innen werden das Werk genau in diesen Formaten erleben — bei Dokumentationen, auf Streaming-Plattformen oder zu Hause.

Ein binaurales Dekodierung eines gut strukturierten Ambisonics-Mixes vermittelt den räumlichen Charakter in der Regel gut. Ein naiver Stereo-Downmix (alle Kanäle auf zwei zusammenfalten) verliert möglicherweise den grössten Teil der räumlichen Information. Entscheidungen, die frühzeitig getroffen werden sollten:

- Hat jede Quelle bedeutungsvolle Anteile im W-Kanal (Omnidirektional), damit ein Mono-Downmix noch kohärent ist?
- Ist das Stück auch ohne räumliche Information verständlich, oder trägt die Raumebene strukturelles Gewicht, das verloren geht?
- Soll ein separater Binaural-Master geliefert werden?

### Studio versus grosser Saal

Was in einem 8 × 8 m Studio funktioniert, klingt in einem 30 × 70 m Konzertsaal anders. Der Saal legt seinen eigenen langen Nachhall über den kodierten. Räumliche Bewegungen, die im Studio gelenkig und artikuliert klingen, wirken im grossen Massstab träge und verschmiert. Umgekehrt kann eine langsam diffundierende Textur, die im Studio statisch klingt, im grossen Hallraum aufblühen.

Wenn die Möglichkeit besteht, **teste das Stück vor der Uraufführung im Zielort**. Wenn nicht, sind folgende Faustregeln nützlich: Plane mehr räumliche Einfachheit, als du zu brauchen glaubst; lass dem Saal Raum zum Atmen; und vermeide kodierten Kunsthall, der sich mit dem natürlichen Abklingen des Saals unkontrolliert multipliziert.

## Methodologische Ansätze

### Trockenproduktion versus nasse Produktion

Eine der grundlegenden Entscheidungen in der Fixed-Media-Ambisonics-Komposition ist, ob **trocken** produziert wird — Quellen ohne Hall in B-Format enkodiert — oder **nass** — Hall von Anfang an in das B-Format eingebacken.

**Argumente für Trockenproduktion:**
- Reflexionen im Aufführungssaal häufen sich nicht mit kodiertem Hall zu unkontrollierten Klangmassen
- Das Stück bleibt in trockeneren Monitoring-Kontexten (Kopfhörer, Studio) lesbar
- Räumliche Positionen bleiben distinkt und präzise

**Argumente für nasse Produktion:**
- Die künstlerische Vision eines hüllenden, hallenden Raumes kann vollständig im Studio realisiert werden
- Das Stück funktioniert zuverlässiger auf Kopfhörern, wo kein Raumklang durch die Wiedergabeumgebung hinzukommt
- Faltungshall mit einem spezifischen Raum-Impuls kann räumlich enkodiert werden und erzeugt eine präzise geformte akustische Umgebung

In der Praxis nutzen viele Komponist:innen einen **hybriden Ansatz**: Quellen trocken mit genauen räumlichen Positionen enkodieren, dann einen bescheidenen gemeinsamen Hall auf dem Ambisonics-Bus hinzufügen — genug, um die Szene zu verbinden, aber nicht so viel, dass der Saal ihn verdoppelt.

### A/B-Vergleich

Eine einfache und wirksame Testmethode ist ein **A/B-Vergleich** zwischen:

- einer trockenen Version (Quellen mit minimaler Hallzugabe im Ambisonics positioniert)
- einer nassen Version (mit künstlichem oder gefalteten Hall angereichert)

Beide Versionen durch dasselbe System abzuspielen — idealerweise sowohl über Lautsprecher als auch Kopfhörer — zeigt, wie viel Raumklang die Komposition benötigt, und wo das Gleichgewicht zwischen räumlicher Klarheit und immersiver Tiefe liegt. Diese Art iterativer Prüfung ist genauso ein kompositorischer Akt wie das Skizzieren von melodischem Material.

### Raum aufnehmen und für Faltungshall verwenden

Ein dritter methodologischer Ansatz ist, die **Impulsantwort des Zielraumes aufzunehmen** und sie als Faltungshall in die Komposition zu integrieren. So lässt sich die Akustik des Konzertsaals bereits im Studio in das Stück "voreinbacken".

Workflow:
1. Raum-IR mit Sinussweep oder Startpistole in ein Ambisonics-Mikrofon aufnehmen (z.B. Sennheiser Ambeo VR Mic, Zylia ZM-1)
2. IR zu B-Format enkodieren
3. Im DAW als Faltungshall auf einzelne Quellen oder den Ambisonics-Bus anwenden

Das Ergebnis ist ein Stück, das den Zielraum bereits "kennt". Wenn es in diesem Saal wiedergegeben wird, verschmelzen enkodierter Raum und lebendiger Raum — was künstlerisch sehr wirkungsvoll sein kann, oder gelegentlich problematisch, wenn das Abklingen sich zu stark verdoppelt. Vorheriges Testen bleibt unerlässlich.

## Zusammenfassung: Fragen vor jeder Produktion

Vor dem Abschluss eines endgültigen Mixes diese Checkliste durchgehen:

- Wo und wie wird dieses Stück gespielt? Was ist der voraussichtliche RT60?
- Habe ich räumliche Bewegungen in einem dem Uraufführungsort vergleichbaren Raum getestet?
- Funktioniert das Stück auf Stereo und Kopfhörern?
- Habe ich bewusst zwischen trockener, nasser oder hybrider Produktion entschieden?
- Habe ich einen A/B-Vergleich zwischen verschiedenen Hallanteilen gemacht?
- Habe ich die Impulsantwort des Zielraums, und habe ich erwogen, sie zu verwenden?

Der Raum ist immer Mitkomponist:in. Je früher er im Arbeitsprozess berücksichtigt wird, desto mehr des Werks entsteht als bewusste Entscheidung und nicht als Zufall.

---

**Referenz:** Kalkandjiev, Z., & Weinzierl, S. (2023). *The effect of room acoustics on performance practice and musical interpretation.* Acoustics, 5(2), 454–467.
