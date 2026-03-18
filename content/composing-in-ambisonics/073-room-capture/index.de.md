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

Nach dem ersten Hören ist eine systematischere Analyse nützlich. Werkzeuge zur Messung von Raumimpulsantworten (RIR) wie [Room EQ Wizard](https://www.roomeqwizard.com/), [Maat thEQred](https://maat.digital/theqred/) oder auch eine einfache Startpistolen-Aufnahme liefern:

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

### Drei Wege zur Integration von Raumakustik

Sobald der Raum verstanden ist, stehen drei Produktionswege zur Verfügung — jeder mit unterschiedlichen technischen Anforderungen und künstlerischen Ergebnissen.

---

**Weg 1 — Den Raum als Faltungshall aufnehmen**

<figure class="big">
  <img src="/images/room-capture-approach-1.svg" alt="Signalfluss: Sinussweep-Generator speist einen Lautsprecher im Raum; ein Ambisonics-Mikrofon nimmt die Antwort auf; der IR-Decoder wandelt in eine B-Format-IR-Datei um; in der Produktion wird die IR in ein Faltungshall-Plugin geladen." loading="lazy" />
</figure>

Die Impulsantwort (IR) des Zielraumes mit einem Ambisonics-Mikrofon aufnehmen und als räumlichen Faltungshall in der Produktion einsetzen. So lässt sich die Akustik des Konzertsaals bereits im Studio in das Stück einarbeiten.

Workflow:
1. Sinussweep erzeugen (mit [Room EQ Wizard](https://www.roomeqwizard.com/), [Reaper](https://www.reaper.fm/) oder ähnlichem) und über einen Breitband-Lautsprecher im Zielraum abspielen
2. Antwort mit einem Ambisonics-Mikrofon aufnehmen — das **[Zylia ZM-1](https://www.zylia.co/zylia-zm-1-microphone.html)** (3. Ordnung HOA, 19 Kapseln) liefert exzellente räumliche Auflösung; das **[Sennheiser Ambeo VR Mic](https://www.sennheiser.com/en-gb/catalog/products/microphones/ambeo-vr-mic/ambeo-vr-mic-506180)** oder **[Rode NT-SF1](https://rode.com/en/microphones/360-ambisonic/nt-sf1)** eignen sich für First-Order-Aufnahmen; auch **[Core Sound TetraMic](https://www.core-sound.com/TetraMic/1.php)** oder **[Eigenmike em32](https://mhacoustics.com/products)** sind geeignet
3. Die aufgenommene IR zu B-Format (AmbiX) dekodieren — mit der mitgelieferten Mikrofon-Software oder mit [IEM-](https://plugins.iem.at/) / [SPARTA-](https://leomccormack.github.io/sparta-site/)Tools
4. Die B-Format-IR im DAW als Faltungshall auf einzelne Quellen oder den Ambisonics-Bus anwenden — Plugins wie **[Reapers ReaVerb](https://www.reaper.fm/reaplugs/)**, **[Altiverb](https://www.audioease.com/altiverb/)** oder der **[IEM RoomEncoder](https://plugins.iem.at/docs/roomencoder/)** unterstützen Mehrkanal-Faltung

Das Ergebnis ist ein Stück, das die akustische Signatur des Zielraums bereits trägt. Bei der Aufführung in diesem Saal verschmelzen enkodierter und realer Raum — was künstlerisch sehr wirkungsvoll sein kann, aber gelegentlich problematisch, wenn das Abklingen sich zu stark verdoppelt. Falls der Aufführungsort wechselt, kann eine neue IR eingesetzt werden, ohne die Komposition neu zu bearbeiten.

**Stärke:** Physikalisch präzise; der räumliche Charakter des spezifischen Raumes bleibt vollständig in 3D erhalten.
**Einschränkung:** Erfordert vorab Zugang zum Venue; IR-Aufnahme dauert vor Ort 30–60 Minuten.

---

**Weg 2 — Einen virtuellen Raum in Ambisonics synthetisieren**

<figure class="big">
  <img src="/images/room-capture-approach-2.svg" alt="Signalfluss: DAW-Quelle speist eine räumliche Hall-Engine (Spat5, IEM FdnReverb, SPARTA). Raumparameter wie Raumgrösse, RT60, frühe Reflexionen und Diffusion sind vollständig steuerbar. Ausgabe: B-Format HOA." loading="lazy" style="width:100%;max-width:1100px;height:auto;" />
</figure>

Statt einen realen Raum aufzunehmen, einen synthetischen räumlichen Nachhall algorithmisch erzeugen. Dieser Ansatz ist vollständig studiobasiert und gibt vollständige kreative Kontrolle über alle Raumparameter.

Wichtige Werkzeuge:

- **[IRCAM Spat5](https://forum.ircam.fr/projects/detail/spat/)** (Max/MSP, Standalone oder VST) — die leistungsfähigste räumliche Hall-Umgebung für Ambisonics-Arbeit; unterstützt Raummodellierung, Quell-Direktheit und vollständigen HOA-Output bis zu beliebiger Ordnung; Raumgrösse, RT60, frühe Reflexionen, Diffusion und Luftabsorption sind pro Quelle steuerbar
- **[SPARTA AmbiBIN / Hybrid Reverb](https://leomccormack.github.io/sparta-site/)** — kostenloser VST mit Ambisonics-eigenem Hall und Binaural-Output
- **[IEM FdnReverb](https://plugins.iem.at/docs/fdnreverb/)** — kostenloser Feedback-Delay-Network-Hall mit Ambisonics-Output, geeignet für Einhüllung und Grossraumsimulation
- **[Aalto Spatial](https://aaltospatial.com/)** / **[dearVR Spatial Connect](https://www.dear-reality.com/products/dearvr-spatial-connect)** — kommerzielle Optionen mit HRTF-basierter Raumsimulation
- **[Panoramix](https://forum.ircam.fr/projects/detail/panoramix/)** (IRCAM, Max/MSP) — in vielen akusmatischen Konzert-Kontexten eingesetzt; direktionaler Hall und Spatialisation in einer Umgebung

Mit einem Werkzeug wie Spat5 lässt sich ein Raum bauen, der nicht existiert — ein 40 Meter hohes Steingewölbe, eine sphärische Kammer, ein schalltotes Volumen — und gezielt für seine Eigenschaften komponieren. Der Raum wird zum kompositorischen Instrument statt zur physikalischen Bedingung.

**Stärke:** Vollständige kreative Freiheit; kein Venue-Zugang nötig; Raumparameter können über Abschnitte des Stückes hinweg wechseln.
**Einschränkung:** Synthetischer Hall klingt bei bestimmtem Material weniger physikalisch überzeugend als ein reales IR; erfordert Zeit für eine kohärente Kalibrierung.

---

**Weg 3 — Beide kombinieren: hybride Produktion**

<figure class="big">
  <img src="/images/room-capture-approach-3.svg" alt="Signalfluss für hybride Produktion: Quelle wird enkodiert und über Spat5 für frühe Reflexionen (synthetischer Pfad) geleitet; die Venue-IR speist ein Faltungshall-Plugin für den späten Nachhall (realer IR-Pfad). Beide Pfade werden auf dem Ambisonics-Bus zusammengeführt." loading="lazy" />
</figure>

Der flexibelste Ansatz kombiniert eine reale aufgenommene IR (für den übergeordneten räumlichen Charakter) mit einer synthetischen Hall-Schicht (für kompositorische Kontrolle). Typische hybride Setups:

- Die **reale IR** als leichten Faltungsschwanz auf dem Ambisonics-Bus einsetzen — dem Stück den „Klang" des Zielraums geben — während der individuelle Quell-Hall **synthetisch** bleibt für präzise Kontrolle von frühen Reflexionen und Quell-Distanz
- Mit [Spat5](https://forum.ircam.fr/projects/detail/spat/) die **frühen Reflexionen** formen (die den entscheidendsten Einfluss auf wahrgenommene Quell-Distanz und Raumgrösse haben) und nur für den **späten diffusen Nachhall** eine reale IR verwenden
- In [Reaper](https://www.reaper.fm/): Quellen über Spat5-Insert für räumliche Positionierung und frühe Reflexionen routen, dann den Ambisonics-Bus durch einen mit der Venue-IR geladenen Faltungshall schicken

Dieser Ansatz ist in der professionellen Fixed-Media-Produktion am ICST und am IRCAM verbreitet: Das reale Raumimpuls gibt der akustischen Situation Glaubwürdigkeit; die synthetische Schicht liefert kompositorische Präzision, die eine rohe IR allein nicht bieten kann.

**Stärke:** Physikalisch verankert, aber kompositorisch steuerbar; funktioniert auch wenn die Venue-IR noch nicht verfügbar ist (mit einer ähnlichen Referenz-IR aufbauen, später austauschen).
**Einschränkung:** Komplexeres Routing; sorgfältiges Gain-Staging nötig, um Hall-Verdopplung zu vermeiden.

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
