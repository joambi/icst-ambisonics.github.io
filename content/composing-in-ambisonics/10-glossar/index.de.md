---
title: "Glossar"
description: "Fachbegriffe aus Ambisonics, Psychoakustik und räumlicher Komposition — kompakt erklärt."
date: 2026-01-01T00:00:00
weight: 100
translationKey: "composing-glossary"
---

Dieses Glossar erklärt die zentralen Fachbegriffe, die im Bereich *Composing in Ambisonics* verwendet werden. Die Einträge sind alphabetisch geordnet und auf kompositorische Relevanz ausgerichtet.

---

**ACN (Ambisonic Channel Numbering)**
Standardisierte Nummerierung der Ambisonics-Kanäle: Kanal 0 = W (omnidirektional), Kanal 1 = Y, Kanal 2 = Z, Kanal 3 = X, und so fort für höhere Ordnungen. ACN ist Teil der ambiX-Konvention und heute der gebräuchlichste Standard für HOA-Produktionen. Gegensatz: FuMa-Kanalreihenfolge (W, X, Y, Z).

---

**ambiX**
Modernes Ambisonics-Dateiformat, das ACN-Kanalreihenfolge mit SN3D-Normalisierung kombiniert. ambiX ist der aktuelle Industriestandard für den Austausch von HOA-Dateien und wird von den ICST Plugins, der IEM Plugin Suite und SPARTA unterstützt. Ältere Systeme verwenden stattdessen FuMa.

---

**ASW (Apparent Source Width)**
Psychoakustische Größe, die beschreibt, wie breit oder ausgedehnt eine Klangquelle wahrgenommen wird. ASW hängt von frühen seitlichen Reflexionen und der räumlichen Kohärenz des Signals ab und ist kompositorisch über Spread und Diffusion steuerbar.

---

**Azimut**
Horizontaler Winkel einer Klangquelle im Ambisonics-Koordinatensystem, gemessen in Grad (0° = vorne, ±180° = hinten). In der ambiX-Konvention entspricht +90° der linken Seite. Der Azimut ist der wichtigste Parameter für die horizontale Positionierung und Bewegung von Klängen.

---

**B-Format**
Das grundlegende Ambisonics-Signalformat. In FOA besteht es aus vier Kanälen: W (omnidirektional), X (vorne–hinten), Y (links–rechts) und Z (oben–unten). In HOA erweitert sich das B-Format auf (N+1)² Kanäle für die Ordnung N. Das B-Format ist sowohl primäres Arbeitsformat als auch bevorzugtes Archivformat im ICST-Kontext. Für den methodischen Hintergrund siehe auch [Warum der Decoder klingt wie er klingt – Methodischer Kontext](/post/decoder-methodischer-kontext/).

---

**Binaural**
Wiedergabeverfahren, das räumlichen Klang über Kopfhörer simuliert. Binaurales Rendering nutzt HRTFs, um Richtungs- und Distanzinformation für das menschliche Gehör zu kodieren. Ambisonics-Master lassen sich direkt in binaurale Stereoformate dekodieren; ab 3. Ordnung ist die binaurale Qualität für die meisten Anwendungen ausreichend.

---

**D/R-Verhältnis (Direkt-/Diffus-Verhältnis)**
Verhältnis zwischen direktem Schall einer Quelle und diffusem Hallanteil am Hörpunkt. Ein hohes D/R-Verhältnis signalisiert Nähe und Präsenz; ein niedriges D/R-Verhältnis erzeugt den Eindruck von Entfernung oder grossem Raumvolumen. Kompositorisch steuerbar über Distanz, Hallanteil und Raumgrösse.

---

**Dekodierung**
Umwandlung eines Ambisonics-Signals (B-Format) in ein lautsprecherspezifisches oder binaurales Ausgabeformat. Die Dekodierung ist setup-abhängig und kann für unterschiedliche Lautsprecherkonfigurationen aus demselben B-Format-Master erzeugt werden, ohne die Komposition zu verändern. Eine vertiefende Einordnung bietet [Warum der Decoder klingt wie er klingt – Methodischer Kontext](/post/decoder-methodischer-kontext/).

---

**Diffusion / Spread**
Kompositorischer Parameter, der bestimmt, wie konzentriert oder flächig ein Klangobjekt im Raum wahrgenommen wird. Geringe Diffusion (geringer Spread) ergibt punktgenaue Lokalisation; hohe Diffusion erzeugt Einhüllung, Feldcharakter und räumliche Breite. Spread ist im ICST MonoEncoder und MultiEncoder_64 direkt automatisierbar.

---

**Elevation**
Vertikaler Winkel einer Klangquelle im Ambisonics-Koordinatensystem: 0° = Ohrhöhe, +90° = Zenit (direkt oben), −90° = Nadir (direkt unten). Elevation ist der zentrale Parameter für die vertikale Dimension des Schallfeldes und ein kompositorisches Alleinstellungsmerkmal gegenüber horizontalen Surround-Formaten.

---

**Enkodierung**
Umwandlung eines Mono- oder Mehrkanalaudiosignals in das Ambisonics-B-Format. Die Enkodierung definiert Position (Azimut, Elevation, Distanz), Bewegung und Spread einer Quelle im Schallfeld. Im ICST-Workflow übernehmen MonoEncoder, StereoEncoder und MultiEncoder_64 diese Funktion.

---

**Envelopment (Einhüllung)**
Psychoakustisches Wahrnehmungsmerkmal: das Gefühl, von Klang umgeben zu sein statt vor einer Quelle zu stehen. Envelopment (→ LEV) wird durch Diffusion, Hallstruktur und laterale Raumenergie erzeugt und ist ein zentrales kompositorisches Ziel in der räumlichen Musik.

---

**FOA (First Order Ambisonics)**
Ambisonics 1. Ordnung mit 4 Kanälen (W, X, Y, Z). FOA bietet eine räumliche Auflösung von ca. 45° und ist das historisch erste praktikable Ambisonics-Format. Heute wird FOA als robustes Archivformat und für einfache Produktionen eingesetzt; für präzise Komposition empfiehlt sich HOA.

---

**FuMa (Furse-Malham)**
Ältere Normalisierungskonvention und Kanalreihenfolge für Ambisonics, benannt nach Dave Furse und Richard Malham. FuMa ist inkompatibel mit dem modernen ambiX-Standard (ACN/SN3D). Bei der Arbeit mit älteren Plugins oder Audiodateien muss die Konvention explizit geprüft und ggf. konvertiert werden.

---

**HOA (Higher Order Ambisonics)**
Ambisonics höherer Ordnung (2. Ordnung und darüber). Durch die Verwendung sphärischer Harmonischer höherer Ordnung ermöglicht HOA feinere räumliche Auflösung, einen grösseren Sweet Spot und präzisere Lokalisation. Die Kanalzahl berechnet sich als (N+1)² für die 3D-Ordnung N: 3. Ordnung = 16 Kanäle, 5. Ordnung = 36 Kanäle, 7. Ordnung = 64 Kanäle.

---

**HRTF (Head-Related Transfer Function)**
Frequenzgangfunktion, die beschreibt, wie Aussenohr, Kopf und Schultern Schall aus einer bestimmten Richtung modifizieren, bevor er die Ohren erreicht. HRTFs sind die Grundlage für binaurales Rendering. Individuelle HRTFs verbessern die Externalisation; generische HRTFs sind für die meisten Produktionskontexte ausreichend.

---

**ICST Ambisonics Plugins**
Suite von Ambisonics-Werkzeugen für REAPER, entwickelt am ICST (Institut für Computer Music und Sound Technology) der ZHdK Zürich. Umfasst MonoEncoder, StereoEncoder, MultiEncoder_64, AmbiDecoder sowie weitere Hilfs-Plugins. Die Plugins arbeiten im ambiX-Format (ACN/SN3D).

---

**ILD (Interaural Level Difference)**
Pegelunterschied zwischen linkem und rechtem Ohr, verursacht durch Schallbeugung am Kopf. ILD ist ein wichtiger binauraler Lokalisationshinweis, besonders für hohe Frequenzen und seitliche Schallereignisse (oberhalb ca. 1,5 kHz).

---

**ITD (Interaural Time Difference)**
Zeitunterschied zwischen dem Eintreffen eines Schallsignals am linken und rechten Ohr. ITD ist der wichtigste binaurale Lokalisationshinweis für tiefe und mittlere Frequenzen (bis ca. 1,5 kHz). Schall von links erreicht das linke Ohr früher als das rechte; das Gehirn nutzt diese Differenz zur Richtungsbestimmung.

---

**LEV (Listener Envelopment)**
Psychoakustische Größe für das Ausmass, in dem ein Hörer das Gefühl hat, von Schall umhüllt zu sein. LEV wird hauptsächlich durch späte laterale Schallreflexionen erzeugt und ist ein zentrales Qualitätsmerkmal räumlicher Klangwiedergabe. In Ambisonics-Kompositionen über Diffusion, Hallcharakter und rückwärtige/seitliche Schallanteile steuerbar.

---

**MonoEncoder / StereoEncoder / MultiEncoder_64**
Einzelne Plugins der ICST Ambisonics Suite für REAPER. Der MonoEncoder enkodiert eine Mono-Quelle, der StereoEncoder eine Stereoquelle, der MultiEncoder_64 bis zu 64 Quellen simultan mit einer gemeinsamen Radar-GUI und Gruppensteuerung. Alle drei Plugins unterstützen Automation von Azimut, Elevation, Distanz und Spread.

---

**N3D (Full Normalization)**
Normalisierungskonvention für Ambisonics, bei der alle sphärischen Harmonischen auf denselben maximalen Wert normiert sind. N3D wird in einigen wissenschaftlichen Kontexten und IEM-Plugins verwendet; für Produktionsaustausch ist SN3D heute verbreiteter.

---

**Perspektivischer Raum**
Kategorie aus Denis Smalleys *space-form*-Theorie: das Erleben eines imaginierten akustischen Ortes (Kathedrale, Wald, abstrakter Klangkörper). Kompositorisch über Hallcharakter, Distanzstaffelung und Frequenzverteilung steuerbar. Gegensatz: Source-bonded Space, Spektraler Raum.

---

**SN3D (Semi-Normalized)**
Normalisierungskonvention für Ambisonics-Signale, bei der die sphärischen Harmonischen nach einem einheitlichen Schema normiert werden. SN3D ist Teil der ambiX-Konvention und heute der bevorzugte Standard für HOA-Produktionen und Plugin-Interoperabilität.

---

**Source-bonded Space**
Kategorie aus Denis Smalleys *space-form*-Theorie: Raum, der an erkennbare Klangobjekte geknüpft ist — die Distanz einer Stimme, die Bewegungsbahn eines Instruments. Source-bonded Space ermöglicht narrative räumliche Ereignisse (Annäherung, Flucht, Dialog). Gegensatz: Spektraler Raum, Perspektivischer Raum.

---

**Spektraler Raum**
Kategorie aus Denis Smalleys *space-form*-Theorie: Raum, der aus der räumlichen Verteilung spektraler Qualitäten entsteht statt aus diskreter Lokalisation. Zum Beispiel: Hochfrequenzen in der oberen Hemisphäre, Tieffrequenzen bodennah. Kompositorisch besonders relevant für diffuse Texturen und Raumatmosphären.

---

**Sphärische Harmonische**
Mathematische Basisfunktionen auf der Kugeloberfläche, die das Fundament der HOA-Mathematik bilden. Ambisonics-Signale sind gewichtete Summen sphärischer Harmonischer bis zur gewählten Ordnung N. Die Anzahl der Terme wächst mit (N+1)²; höhere Ordnungen erfassen feinere Richtungsstrukturen. Ein lesbarer Einstieg in ihre Rolle für den Decoder steht in [Warum der Decoder klingt wie er klingt – Methodischer Kontext](/post/decoder-methodischer-kontext/).

---

**Spectromorphology**
Analytisches Konzept von Denis Smalley zur Beschreibung zeitlicher Entwicklung elektroakustischer Klänge. Beschreibt, wie sich Spektrum, Textur und Klangform über die Zeit entfalten. Im Ambisonics-Kontext erweitert sich der Begriff zur Spatio-Morphologie: räumliche und spektrale Entwicklung als integrierte Dimension.

---

**Sweet Spot**
Zone im Lautsprecherarray, in der räumliche Darstellung und Lokalisation wie beabsichtigt funktionieren. In FOA ist der Sweet Spot sehr klein (idealerweise ein einzelner Punkt); in HOA wächst er mit steigender Ordnung und ermöglicht mehreren Zuhörer:innen gleichzeitig eine korrekte räumliche Wahrnehmung.

---

**Trajektorie**
Bewegungsbahn einer Klangquelle durch das Ambisonics-Schallfeld über die Zeit, definiert durch Automation von Azimut, Elevation und/oder Distanz. Trajektorien sind ein zentrales Element des Spatial Counterpoint und können geometrisch (Kreis, Linie, Spirale) oder gestisch (Annäherung, Flucht, Implosion) gestaltet werden.

---

**W, X, Y, Z**
Die vier Kanäle eines FOA-B-Format-Signals in der FuMa-Konvention. W ist omnidirektional (0. Ordnung); X, Y und Z sind gerichtete Komponenten 1. Ordnung (vorne–hinten, links–rechts, oben–unten). In der ambiX-Konvention (ACN) entsprechen diese Kanälen 0, 3, 1, 2.
