---
title: "Spatial Audio - Lesson 4"
source: "https://spatial-audio.acoucou.org/course/course/spatial-audio/a9b68924-4db5-4524-a730-f749e6103920"
author:
published:
created: 2026-01-15
description:
tags:
  - "clippings"
---
EN PL DE

## 5.4 Arbeiten mit Ambisonics

## 5.4 Arbeiten mit Ambisonics

Tasks:### [Welcome page](https://spatial-audio.acoucou.org/course/contents?screen=c770f0b3-36e6-4cf0-8e4d-3c9696b072f5)

### Überblick über Spatial Audio

[

### Einführung in Spatial Audio

](https://spatial-audio.acoucou.org/course/course/spatial-audio/f239b7a0-7087-41f4-9718-bdaf99dbada5)[

### Geschichte von Spatial Audio

](https://spatial-audio.acoucou.org/course/course/spatial-audio/08186a9f-636e-474d-9a09-0cd901495a63)[

### Entwicklung der Ästhetik (Mono zu Stereo zu Spatial)

](https://spatial-audio.acoucou.org/course/course/spatial-audio/c1ce9570-3b52-4b92-a5e7-74ad752f297d)[

### Anwendungen

](https://spatial-audio.acoucou.org/course/course/spatial-audio/11077099-dcca-4b8a-ba1f-0801662b2686)[

### Raum im der Räumlichkeit

](https://spatial-audio.acoucou.org/course/course/spatial-audio/2436bc98-de27-4481-8416-a6b3c96b4e1e)[

### Dynamik von Audioquellen und Zuhörern/innen

](https://spatial-audio.acoucou.org/course/course/spatial-audio/03b7315e-440f-4055-b2da-0c30ceceb4ee)

### Psychoakustik

[

### Auditorische Lokalisation und kopfbezogene Übertragungsfunktionen (HRTFs)

](https://spatial-audio.acoucou.org/course/course/spatial-audio/3de9642d-fa92-49fb-ba2b-d167ee178507)[

### Entfernungswahrnehmung

](https://spatial-audio.acoucou.org/course/course/spatial-audio/c6bd5391-5c2d-4ca2-aa80-781de1259484)[

### Wahrnehmung von Hall

](https://spatial-audio.acoucou.org/course/course/spatial-audio/99d61283-162e-4743-98b5-f6b573e0fcf5)[

### Multimodale Integration

](https://spatial-audio.acoucou.org/course/course/spatial-audio/ebd48d48-4a25-4f24-9dbd-7e386bf47346)[

### Psychoakustik der Stereofonie

](https://spatial-audio.acoucou.org/course/course/spatial-audio/3667c9b5-4d43-4144-96f8-38a36b684f2c)

### Wiedergabe

[

### Lautsprecher-Arrays

](https://spatial-audio.acoucou.org/course/course/spatial-audio/67c2ebd6-3b90-4f12-9190-bc5b8b030a18)[

### Kopfhörer

](https://spatial-audio.acoucou.org/course/course/spatial-audio/5f33c30e-8c05-48ae-a10e-adfed88bcd54)

### Fallstudien

[

### Atmos Truck Live Streaming

](https://spatial-audio.acoucou.org/course/course/spatial-audio/atmos-truck)[

### Beyond Chaos - Show for the Experimenta Science Dome

](https://spatial-audio.acoucou.org/course/course/spatial-audio/beyond-chaos)[

### IKO - Spatial Audio Instrument

](https://spatial-audio.acoucou.org/course/course/spatial-audio/iko-and-gerriet)[

### Strings Installation

](https://spatial-audio.acoucou.org/course/course/spatial-audio/strings-installation)[

### Spatial Audio for Health

](https://spatial-audio.acoucou.org/course/course/spatial-audio/spatial-audio-for-health)[

### Live Music Performance with Spatial Audio

](https://spatial-audio.acoucou.org/course/course/spatial-audio/live-music)[

### Spatial Audio in Automotive

](https://spatial-audio.acoucou.org/course/course/spatial-audio/spatial-audio-in-automotive)

### Schritt-für-Schritt-Anleitungen

[

### Channel-Based Production for Music

](https://spatial-audio.acoucou.org/course/course/spatial-audio/channel-based-production-for-music)[

### Dolby Atmos Mixing for Home Cinema

](https://spatial-audio.acoucou.org/course/course/spatial-audio/dolby-atmos-mixing-for-home-cinema)[

### Ambisonic Sound Production for 360 Film

](https://spatial-audio.acoucou.org/course/course/spatial-audio/ambisonic-sound-production-for-360-film)[

### Build Your Own Ambisonic Microphone Array

](https://spatial-audio.acoucou.org/course/course/spatial-audio/build-your-own-ambisonics-microphone-array)[

### Interactive Spatial Audio

](https://spatial-audio.acoucou.org/course/course/spatial-audio/interactive-spatial-audio)[

### Further Materials

](https://spatial-audio.acoucou.org/course/course/spatial-audio/further-materials)

### Die Bedeutung der Ordnung

Die Ordnung eines ambisonischen Signals (oder eines ambisonischen Aufnahme- oder Wiedergabesystems) ist ein sehr grundlegender Parameter. Aus Modul 18 wissen wir, dass die Anzahl der Lautsprecher in einem Wiedergabesystem oder die Anzahl der Mikrofonkapseln in einem Aufnahmesystem die maximal mögliche Ordnung bestimmen. Die eigentliche Ursache für diese Einschränkung liegt tief in der Physik des Methode verborgen und würde den Rahmen dieses Kurses sprengen. Aus praktischer Sicht gilt die Faustregel, dass ein Wiedergabesystem $N$ -ter Ordnung nur die niedrigsten $N$ Ordnungen des ambisonischen Signals, mit dem es angesteuert wird, reproduzieren kann, selbst wenn dieses Signal auch höhere Ordnungen als $N$ umfasst. Es ergeben sich keine besonderen Einschränkungen, wenn eine Lautsprecheranordnung höhere Ordnungen unterstützt, als ein ambisonisches Signal enthalten kann. Viele Decoder sind jedoch so konzipiert, dass das Ergebnis nicht optimal ist, wenn die Ordnung des Inhalts nicht der maximalen Ordnung entspricht, die das Wiedergabesystem unterstützt.

Je höher die Ordnung eines ambisonischen Signals ist, desto genauer bildet es die physikalische Struktur des aufgenommenen Schallfeldes ab. Was dies für die Wahrnehmung bedeutet, d. h. inwiefern sich dadurch der Klang der Szene verändert, lässt sich in wenigen Zeilen nur schwer sagen \[[1](https://spatial-audio.acoucou.org/course/course/spatial-audio/#cite.0@Barrett:2012)\]. Die Änderung der Ordnung hat bei der Dekodierung der Szene über ein Lautsprecher-Array andere Auswirkungen als bei der binauralen Dekodierung.

Bei der Lautsprecherwiedergabe ist ein deutlicher Effekt der ambisonischen Ordnung die Größe des Sweet Spots, d. h. des bevorzugten Hörorts. Es gibt keine starre Definition für den Sweet Spot. In der Regel handelt es sich um die Position oder den Bereich, in dem Wahrnehmungseigenschaften wie Lokalisierung und Klangfarbe optimal sind. Wie stark diese Eigenschaften vom Optimum abweichen müssen, damit man sich außerhalb des Sweet Spots oder Sweet Area befindet, ist nicht definiert.

Abb. [1](https://spatial-audio.acoucou.org/course/course/spatial-audio/#x1-10031) zeigt die Genauigkeit der Richtung des Energieflusses im reproduzierten Schallfeld für eine kreisförmige 8-Kanal-Lautsprecheranordnung. Diese Genauigkeit der Richtung des Energieflusses ist eng mit der Genauigkeit verbunden, mit der virtuelle Schallquellen lokalisiert werden. Wir können daher die Daten aus Abb. [1](https://spatial-audio.acoucou.org/course/course/spatial-audio/#x1-10031) als die Lokalisierungsgenauigkeit interpretieren. Die Autor/innen von \[[3](https://spatial-audio.acoucou.org/course/course/spatial-audio/#cite.0@Zotter:book2019)\] schlagen vor, dass der Sweet Spot alle Orte umfasst, an denen die Unsicherheit kleiner als $30$ $∘$ ist. Bei der in Abb. [1](https://spatial-audio.acoucou.org/course/course/spatial-audio/#x1-10031) (links) dargestellten Wiedergabe 1. Ordnung erstreckt sich der Sweet Spot (bzw. die Sweet Area) von der Mitte des Arrays halbwegs bis zu den Lautsprecher; bei der Wiedergabe 3. Ordnung in Abb. [1](https://spatial-audio.acoucou.org/course/course/spatial-audio/#x1-10031) (rechts) ist die Sweet Area fast so groß wie die gesamte Fläche innerhalb des Lautsprecher-Arrays. Die Sweet Area ist entsprechend kleiner, wenn man eine strengere Anforderung an die tolerierbare Lokalisierungsungenauigkeit wählt. In jedem Fall wächst die Größe der Sweet Area mit der ambisonischen Ordnung. Mit der höheren Lokalisationsgenauigkeit bei höheren Ordnungen geht in der Regel eine Schärfung der Lokalisierbarkeit einher. Das bedeutet, dass die virtuellen Quellen klarer lokalisierbar und weniger verschwommen sind als bei der Wiedergabe mit niedriger Ordnung. Abb. [2](https://spatial-audio.acoucou.org/course/course/spatial-audio/#x1-10052) veranschaulicht dies für die binaurale Wiedergabe. Abb. [2](https://spatial-audio.acoucou.org/course/course/spatial-audio/#x1-10052) (mitte) und (rechts) gelten auch für die Wiedergabe mit Lautsprechern, wobei die Wiedergabe 0. Ordnung mit Lautsprechern schlichtweg bedeutet, dass alle Lautsprecher das gleiche Signal abspielen.

![Figure 1: Illustration der Lokalisierungsgeneuigkeit in Grad für 1. Ordnung (links) und 3.Ordnung. Bilder aus [3, Abb. 4.7, CC-by-4.0].](https://spatial-audio.acoucou.org/course/static//lms/theory/course01/lesson20/figure-1.svg)

Figure 1: Illustration der Lokalisierungsgeneuigkeit in Grad für 1. Ordnung (links) und 3.Ordnung. Bilder aus \[ 3, Abb. 4.7, CC-by-4.0\].

Wir möchten die Bedeutung der Ordnung für die binaurale Wiedergabe anhand von Hörbeispielen verdeutlichen, die das vorliegende Modul begleiten. Der/die Hörer/in befindet sich garantiert im Sweet Spot der Wiedergabe, so dass die reine Lokalisierungsgenauigkeit keine große Rolle spielt. Die Klangfarbe und die Lokalisierbarkeit der virtuellen Quellen sind in diesem Fall zwei der betroffenen Wahrnehmungsaspekte. Achte also beim Hören auf diese Aspekte.

In beiden Fällen, ob binaurale oder lautsprecherbasierte Dekodierung, ist das Ergebnis nicht auf Anhieb überzeugend. Die Signale müssen entzerrt werden. Wir stellen sowohl rohe (nicht entzerrte) als auch entzerrte Hörbeispiele zur Verfügung, damit du den Unterschied lernen kannst. Diese Entzerrung beinhaltet komplizierte Signalverarbeitung und wird bei der lautsprecherbasierten Wiedergabe anders durchgeführt als bei der binauralen Wiedergabe. Für die lautsprecherbasierte Wiedergabe gibt es kein Standardverfahren, und jeder Decoder führt die Entzerrung ein klein wenig anders durch.

Bei der binauralen Wiedergabe ist die Situation etwas konkreter. Hier wird der Inhalt der Szene richtungsabhängig entzerrt. Mit anderen Worten wird eine Quelle, die sich auf der rechten Seite befindet, anders entzerrt als eine Quelle, die sich geradeaus befindet. Es ist leider nicht einfach, dies ohne Head-Tracking zu demonstrieren. Durch Drehen des Kopfes wird nämlich deutlich, dass nicht entzerrte binaurale Dekodierungen eine richtungsabhängige Färbung enthalten, die durch die Entzerrung abgeschwächt wird.

![Figure 2: Veranschaulichung der Auswirkung der ambisonischen Ordnung auf die Lokalisierung bei binauraler Wiedergabe. Links: Signal 0. Ordnung. Da ein Signal 0. Ordnung keine räumlichen Informationen enthält, erscheinen alle Schallquellen an der exakt gleichen Position, normalerweise in der Mitte des Kopfes. Mitte: Signal niedriger Ordnung, z. B. 1. bis 3. Ordnung. Die Schallquellen in der Szene sind lokalisierbar, aber ihre Position ist
            möglicherweise nicht immer leicht zu bestimmen, und es kommt zu Änderungen der Klangfarbe, wenn der Kopf bewegt wird. Rechts: Signal hoher Ordnung, z. B. 4. Ordnung und höher. Die Schallquellen sind eindeutig und stabil lokalisierbar, und ihre räumliche Ausdehnung ist kompakt.](https://spatial-audio.acoucou.org/course/static//lms/theory/course01/lesson20/figure-2.svg)

Figure 2: Veranschaulichung der Auswirkung der ambisonischen Ordnung auf die Lokalisierung bei binauraler Wiedergabe. Links: Signal 0. Ordnung. Da ein Signal 0. Ordnung keine räumlichen Informationen enthält, erscheinen alle Schallquellen an der exakt gleichen Position, normalerweise in der Mitte des Kopfes. Mitte: Signal niedriger Ordnung, z. B. 1. bis 3. Ordnung. Die Schallquellen in der Szene sind lokalisierbar, aber ihre Position ist möglicherweise nicht immer leicht zu bestimmen, und es kommt zu Änderungen der Klangfarbe, wenn der Kopf bewegt wird. Rechts: Signal hoher Ordnung, z. B. 4. Ordnung und höher. Die Schallquellen sind eindeutig und stabil lokalisierbar, und ihre räumliche Ausdehnung ist kompakt.

Ein weiterer Aspekt, der nicht außer Acht gelassen werden sollte, ist das Datenvolumen. Ein ambisonisches Signal der Ordnung 7 umfasst zum Beispiel $(7+1)2=64$ Kanäle. Das bedeutet, dass wir selbst bei moderater Dauer einer Aufnahme von Dateigrößen von Hunderten von Megabytes sprechen.

### Bearbeitung von ambisonischen Signalen

Da es eine strenge mathematische Beziehung zwischen den Signalen in den einzelnen Kanälen gibt, sollte man niemals einen einzelnen Kanal eines ambisonischen Signals separat bearbeiten. Die Kanäle verlieren dann ihre mathematische Beziehung zueinander, und ihre Wiedergabe kann ganz anders klingen, als man es erwartet hätte. Mit anderen Worten: Wenn man beispielsweise ein ambisonisches Signal aus-faden möchte, muss auf allen Kanälen der genau gleiche Fade-out angewendet werden. Ähnlich verhält es sich, wenn ein Entzerrer auf ein ambisonisches Signal angewandt werden soll: Es muss auf allen Kanälen genau die gleiche Entzerrung angewendet werden \[[3](https://spatial-audio.acoucou.org/course/course/spatial-audio/#cite.0@Zotter:book2019), Sec. 5.3-5.4\]. Wir betonen hier, dass es von größter Wichtigkeit ist, sich dessen bewusst zu sein. Die dynamische Kompression der gesamten Klangszene wird am besten mit dem $(n,m)=(0,0)$ -Kanal, d. h. dem ersten Kanal des ambisonischen Signals, als Steuersignal durchgeführt, da dieser die Signale aller Schallquellen der Szene enthält.

Wir haben bereits erwähnt, dass ein ambisonisches Signal zwar eine physikalische Darstellung einer Klangszene ist, dass es aber sehr schwierig ist, die Szene in ihe Bestandteile zu zerlegen, die für einen Menschen interpretierbar sind. Mit anderen Worten: Die einzelnen Kanäle eines ambisonischen Signals stellen abstrakte physikalische Komponenten der Szene dar. Sie ergeben für einen Menschen keinen Sinn. Was für den Menschen viel sinnvoller wäre, wäre eine Zerlegung in konkrete Objekte wie die einzelnen Quellsignale, den Nachhall usw. Dies ist eine große Herausforderung, für die es derzeit keine Lösung gibt.

Die schlechte Nachricht ist also, dass wir nicht eine einzelne Schallquelle aus einem ambisonischen Signal herausschneiden und an eine andere Position verschieben können. Die gute Nachricht ist, dass auch ohne die genaue Kenntnis der Bestandteile einer Szene räumliche Manipulationen möglich sind, die mit anderen Spatial-Audio-Formaten sehr schwer oder gar nicht zu erreichen sind. Aus praktischer Sicht bedeutet dies, dass es mathematische Operationen gibt, die eine bestimmte gewünschte Manipulation erreichen, wenn sie auf ambisonische Signale angewendet werden. Als Nutzer/in sind wir dabei auf Software-Plugins angewiesen, da diese mathematischen Operationen ziemlich kompliziert sein können.

Die bekanntesten Beispiele für räumliche Manipulationen sind \[[2](https://spatial-audio.acoucou.org/course/course/spatial-audio/#cite.0@Kronlachner:2014)\]:

- Drehung der gesamten Klangszene
- Richtungsabhängige Verstärkung oder Abschwächung
- Spiegeln (vorne-hinten, links-rechts, oben-unten)
- Directional Warping (z. B. räumliche Stauchung der Szene in eine bestimmte Richtung)

Die Effekt aller oben genannten Manipulationen ist bei Signalen höherer Ordnung tendenziell stärker, mit Ausnahme der Rotation, die immer gleich gut funktioniert. Wie bereits erwähnt, sind globale Manipulationen wie Entzerrung, Komprimierung, Fade-in/Fade-out usw. möglich, solange sie auf alle Kanäle in genau derselben Weise angewendet werden. Die bei weitem wichtigste der räumlichen Manipulationen ist die Drehung der gesamten Klangszene. Solche Rotationen können um jede beliebige Achse durchgeführt werden und sind verlustfrei - wie viele der anderen räumlichen Transformationen auch. Das heißt, wenn man eine Szene um einen bestimmten Winkel dreht und danach wieder zurückdreht, erhält man genau das, womit man begonnen hat. Drehungen sind deshalb so wichtig, weil sie Head-Tracking bei der binauralen Wiedergabe ermöglichen. Die binaurale Wiedergabe von ambisonischen Inhalten ist daher 3 DoF (Rotation um alle drei kartesischen Achsen ist möglich).

Die richtungsspezifische Dynamikkompression ist ein Effekt, der eine Mischform zwischen konventioneller Audiobearbeitung und ambisonischer Bearbeitung darstellt: Es gibt mathematische Operationen, die es ermöglichen, ein Winkelsegment aus einer Klangszene herauszuschneiden, z. B. ein Winkelsegment, das z. B. eine Gesangsstimme enthält, die dynamisch komprimiert werden soll. Die dynamische Kompression wird auf das Winkelsegment angewendet, das danach wieder in die Klangszene eingefügt wird.

Es ist zu beachten, dass eine Translation der Hörer/innenposition bei der binauralen Wiedergabe von ambisonischen Signalen im Allgemeinen nicht möglich ist (mit anderen Worten, der/die Nutzer/in kann sich nicht in der aufgenommenen Szene bewegen). In der wissenschaftlichen Literatur wurden hierfür einige Methoden vorgeschlagen, von denen jedoch keine uneingeschränkt einsatzbereit ist.

### Etwas Terminologie

Die Ambisonics-Community neigt dazu, eine sehr Ambisonics-spezifische Terminologie zu verwenden, deren Bedeutung nicht so einfach abgeleitet werden kann. Im Folgenden geben wir einen Überblick über die wichtigsten Begriffe.

| Encoding | Umwandlung der Signale von den Mikrofonen eines Mikrofonarrays in ein ambisonisches Signal sowie Umwandlung des Eingangssignals einer virtuellen Schallquelle und ihrer Metadaten (z. B. ihrer Position im Raum) in ein ambisonisches Signal |
| --- | --- |
|  |  |
| Decoding | Umwandlung eines ambisonischen Signals in Lautsprecher- oder Kopfhörersignale |
|  |  |
| ACN | Ambisonic Channel Number (Definition der Kanalreihenfolge eines Ambisonic-Signals, siehe Abb. 1 in Modul 17) |
|  |  |
| SID | Single Index Designation: Eine Reihenfolge der Kanäle in einem ambisonischen Signal, das sich von ACN unterscheidet |
|  |  |
| FuMa | Furse-Malham: Furse-Malham: Eine weitere Reihenfolge für die Kanäle in einem ambisonischen Signal. Siehe B-Format unten. |
|  |  |
| A-format | Die rohen Mikrofonsignale eines traditionellen Tetraeder-Mikrofon-Arrays der Ordnung 1, wie es in Abb. 1 in Modul 19 dargestellt ist. Wird gelegentlich auch bei Arrays höherer Ordnung als 1 verwendet. |
|  |  |
| B-format | Das traditionelle B-Format ist ein ambisonisches Signal erster Ordnung (es umfasst also 4 Kanäle). Die Kanäle werden als W, X, Y und Z bezeichnet. Sie entsprechen dem 1., 4., 2. und 3. Kanal in ACN (ACN = WYZX). FuMa ist die Erweiterung des traditionellen B-Formats auf höhere Ordnungen. Das Signalformat wird dann manchmal auch einfach als B-Format bezeichnet, selbst wenn es eine höhere Ordnung als 1 hat (und FuMa wird manchmal auch mit Signalen 1. Ordnung verwendet). |
|  |  |
| N3D, SN3D | 3D-Normalisierung und Schmidt-Seminormalisierung: Zwei verschiedene Möglichkeiten, die Kanäle in einem ambisonischen Signal relativ zueinander zu normalisieren. |
|  |  |

Es ist wichtig, dass die Einstellungen eines Software-Plugins korrekt für das zu verarbeitende ambisonische Signal gewählt werden, insbesondere hinsichtlich der Kanalreihenfolge und der Normalisierung.

### Software-Tools

Der Umstand, dass modernes Ambisonics in der akademischen Community große Beachtung fand, bevor es sich in der Industrie etablierte, hat dazu beigetragen, dass eine beträchtliche Anzahl freier Software-Tools zur Verfügung steht, von denen einige sehr fortschrittliche Funktionen aufweisen können. Nachfolgend findet du eine Zusammenfassung einiger beliebter Plugins in alphabetischer Reihenfolge. Alle bieten grundlegende Funktionen wie Kodierung und Dekodierung in binaural und für Lautsprecher. Wir erwähnen nur Beispiele für Funktionen, die darüber hinausgehen. Wie immer kann eine solche Liste nicht vollständig sein.  

| [ambiX](https://www.matthiaskronlachner.com/?p=2015) | Räumliche Manipulation |
| --- | --- |
| [Harpex](https://harpex.net/) | Surround-Dekodierung und räumliches Upmixing |
| [IEM Plugin Suite](https://plugins.iem.at/) | Umfangreiche Plugins inkl. direktionalem Kompressor, Reverb und |
|  | anderen Effekten, AllRADecoder |
| [mcfx](https://www.matthiaskronlachner.com/) | Streng genommen keine Ambisonic-Tools, aber sehr nützliche |
|  | Mehrkanaleffekte |
| [O3A Core Plugin Library](https://www.blueripplesound.com/pro_audio) | Breites Spektrum an Funktionalitäten |
| [Panoramix](https://forum.ircam.fr/projects/detail/panoramix/) | Verschiedene Spatialisierungsmethoden und eine Vielzahl von Effekten |
| [SPARTA](https://leomccormack.github.io/sparta-site/) | Umfangreiches Paket an Plugins mit einer Vielzahl von Effekten |
|  | inkl. Vergrößerung der räumlichen Ausdehnung einer Schallquelle |
| [Spatial Audio family](https://b-com.com/en/process/spatial-audio-family) | Enkoding in Mehrkanalformaten wie 5.1 |

### References

\[1\]

Natasha Barrett. The Perception, Evaluation And Creative Application Of High Order Ambisonics In Contemporary Music Practice. IRCAM Composer in Research Report. 2012.

\[2\]

Matthias Kronlachner and Franz Zotter. "Spatial transformations for the enhancement of Ambisonic recordings". In: Int. Conf. on Spatial Audio. Feb. 2014.

\[3\]

Franz Zotter and Matthias Frank. Ambisonics: A Practical 3D Audio Theory for Recording, Studio Production, Sound Reinforcement, and Virtual Reality. Freely available at [https://link.springer.com/book/10.1007/978-3-030-17207-7](https://link.springer.com/book/10.1007/978-3-030-17207-7). Heidelberg: Springer, 2019.

## Ambisonics-Signale unterschiedlicher Ordnungen

Wir haben erwähnt, dass es unter den gegebenen Umständen nicht einfach ist, die Bedeutung der Ambisonics-Ordnung anschaulich darzustellen. Hier versuchen wir es mit einigen computer-generierter Ambisonics-Signale unterschiedlicher Ordnungen, die binaural gerendert wurden. Die Unterschiede werden tendenziell deutlicher, wenn Head-Tracking angewendet wird, was hier leider nicht möglich ist. Die Musik, die du hören wirst, wird stattdessen um deinen Kopf kreisen, um ähnliche räumliche Dynamiken wie beim Head-Tracking zu erzeugen.  
  
Achte zum Beispiel darauf, wie gut die Signalanteile in den tiefen Frequenzen bei den verschiedenen Ordnungen lokalisiert werden können.  
  
Die Quellsignale für die Beispiele stammen von [hier](http://www.lam.jussieu.fr/Projets/index.php?page=AVAD-VR%22).

Das Video auf dieser Seite enthält binauralen Ton. Bitte stelle sicher, dass du Kopfhörer zum Hören benutzt.

## Entzerrt

Ambisonics-Ordnung 0

Ambisonics-Ordnung 1

Ambisonics-Ordnung 5

Ambisonics-Ordnung 7

## Nicht entzerrt

Ambisonics-Ordnung 0

Ambisonics-Ordnung 1

Ambisonics-Ordnung 5

Ambisonics-Ordnung 7

Spatial Audio ist Teil der Acoucou-Plattform © 2024 Bereitgestellt unter der Creative Commons-Lizenz [\[CC BY-NC-ND 4.0\]](https://creativecommons.org/licenses/by-nc-nd/4.0/)