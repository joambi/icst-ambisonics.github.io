---
title: "Spatial Audio - Lesson 5"
source: "https://spatial-audio.acoucou.org/course/course/spatial-audio/2436bc98-de27-4481-8416-a6b3c96b4e1e"
author:
published:
created: 2026-01-15
description:
tags:
  - "clippings"
---
EN PL DE

## 1.5 Raum im der Räumlichkeit

## 1.5 Raum im der Räumlichkeit

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

### Einführung

In Spatial Audio ist es entscheidend, effektive Mittel zur Beschreibung eines Punktes im Raum zu haben, um den Raum, in dem die Audioquellen positioniert werden, gezielt nutzen und definieren zu können. Das vorliegende Modul gibt einen Überblick über Koordinatensysteme, akustische Phänomene, die mit Raum in Verbindung stehen, wie Hall, Verdeckung von Schall und Beugung, sowie räumliche Eigenschaften von Klangquellen, wie ihre Ausdehnung und Richtcharakteristik. Diese Aspekte sind wichtige Bausteine von Spatial Audio.

### Koordinatensysteme

Mathematisch werden die drei Dimensionen eines Raums durch ein Koordinatensystem beschrieben. Das uns am besten bekannte ist das kartesische Koordinatensystem \[[1](https://spatial-audio.acoucou.org/course/course/spatial-audio/#cite.0@cartesian)\], das einen Punkt im Raum anhand der intuitiven Raumrichtungen von links nach rechts, von vorne nach hinten und von unten nach oben beschreibt. Jeder dieser Richtungen wird eine Variable zugewiesen, die meist als $x$ , $y$ , und $z$ definiert werden. Abb. [1](https://spatial-audio.acoucou.org/course/course/spatial-audio/#x1-20031) zeigt den dreidimensionalen Raum in Form von drei zueinander senkrechten Achsen. Leider gibt es keinen einheitlichen Standard in den Werkzeugen zur Erstellung von Spatial Audio. Das bedeutet, dass $x$ , $y$ und $z$ in verschiedenen Tools unterschiedliche Richtungen bezeichnen können. Der Ursprung der Achsen kann entweder mit dem Mittelpunkt des Raums übereinstimmen oder eine Verschiebung dazu aufweisen (zum Beispiel kann er in einer Raumecke liegen). Noch problematischer ist, dass positive und negative Werte in verschiedenen Tools gegensätzliche Richtungen repräsentieren können.

Ein weiteres häufig verwendetes Koordinatensystem sind die Kugelkoordinaten \[[2](https://spatial-audio.acoucou.org/course/course/spatial-audio/#cite.0@sphere)\], die ebenfalls in Abb. [1](https://spatial-audio.acoucou.org/course/course/spatial-audio/#x1-20031) dargestellt sind. Es wird üblicherweise für egozentrische Situationen genutzt und beschreibt einen Punkt im Raum durch seinen Azimut, seine Elevation und seinen Radius. Ähnlich wie bei den kartesischen Koordinaten können verschiedene Tools unterschiedliche Definitionen für 0 ° im Azimut und Elevation haben, und auch die Skalierung der Distanz kann variieren.

![Figure 1: Die beiden gängigen Koordinatensysteme im Bereich der räumlichen Audiotechnologie: links: dreidimensionale kartesische Koordinaten, rechts: Kugelkoordinaten. Die x, y, und z-Achsen stellen die
            Dimensionen des Raumes in Form eines rechtshändigen Systems dar. In Spatial-Audio-Tools kann auch ein linkshändiges System vorkommen, bei dem die x- und y-Achsen vertauscht sind.](https://spatial-audio.acoucou.org/course/static//lms/theory/course01/lesson05/figure-1.svg)

Figure 1: Die beiden gängigen Koordinatensysteme im Bereich der räumlichen Audiotechnologie: links: dreidimensionale kartesische Koordinaten, rechts: Kugelkoordinaten. Die x, y, und z -Achsen stellen die Dimensionen des Raumes in Form eines rechtshändigen Systems dar. In Spatial-Audio-Tools kann auch ein linkshändiges System vorkommen, bei dem die - und -Achsen vertauscht sind.

Beide Koordinatensysteme findest du in Tools zur Erstellung von räumlichem Audio. Allgemein gesagt wird das kartesische Koordinatensystem für rechteckige Räume wie Kinos, Live-Veranstaltungsorte und Heimkinos bevorzugt. Das sphärische Koordinatensystem wird für egozentrische Blickwinkel wie in 360 ° -Videos und für sphärische Räume wie Planetarien und andere Kuppeln bevorzugt. Zum Glück können kartesische Koordinaten einfach in sphärische Koordinaten und umgekehrt umgewandelt werden. Einige Tools bieten daher die Möglichkeit, zwischen den beiden Koordinatensystemen zu wechseln. Ob sie die zugrunde liegenden Variablen ändern oder ob sie lediglich die Ansicht in der Benutzeroberfläche wechseln, hängt vom jeweiligen Tool ab.

Achte darauf, welche Variablen im Tool verwendet und gespeichert werden, wo der Koordinatenursprung definiert ist und welche Skala angewendet wird. Unterschiede in verschiedenen Tools können problematisch werden, wenn du Positionsinformationen von einem Tool in ein anderes übertragen oder kopieren möchtest.

### Entfernung

Die Entfernung definiert die direkte Pfadlänge zwischen Audioquelle und Zuhörer/in. Ihre Wahrnehmung hängt von der Pegelabschwächung, der Dissipation (Absorption) in der Luft und dem Verhältnis von direktem und nachhallendem Signal, sowie vom Reflexionsmuster ab (Modul 8). Spatial-Audio-Systeme können diese Parameter expliziter nutzen als herkömmliche Audiosysteme, um die Wahrnehmung der gewünschten Entfernung zu erzeugen, aber nicht alle tun dies. Einige verwenden nur eine Teilmenge der Parameter, zum Beispiel nur die Pegelabschwächung oder nur die Dissipation in der Luft. In diesem Fall kannst du die Parameter selbst anpassen, indem du Filter einstellst und das Verhältnis von direktem zu nachhallendem Signal änderst. Je mehr Parameter du verwendest, desto überzeugender kann die Entfernungswahrnehmung sein.

### Räumliche Ausdehnung von Schallquellen

Wenn wir Audioquellen in einem Raum platzieren, werden diese normalerweise als Punktquellen angenommen, und das Wiedergabesystem wird sein Bestes tun, um den Klang, der von diesem Punkt im Raum kommen soll, wiederzugeben. In der realen Welt existieren ideale Punktschallquellen jedoch nicht. In vielen Fällen in Spatial Audio ist die Annahme einer Punktschallquelle eine praktikable Lösung. Aber manchmal stellt sie eine Einschränkung dar, die man vermeiden möchte. Denk an einen Vogelruf im Vergleich zu einem breiten Flusslauf in einer Szene: Während der Vogel perfekt als Punkt im Raum repräsentiert werden kann, breitet sich der Fluss weit in der Szene aus und kann nicht als einzelner Punkt im Raum dargestellt werden. Um dieses Phänomen nachzubilden, bieten viele Werkzeuge einen Größen- oder Ausdehnungsfaktor, der typischerweise die Lokalisierung der Klangwahrnehmung verschwimmen lässt, indem das Quellsignal auf mehrere Lautsprecher rund um die Position der Audioquelle verteilt wird. Dies führt tendenziell dazu, dass die Korrelation zwischen den Signalen, die am linken und rechten Ohr des/der Zuhörers/in entstehen, verringert wird. Du wirst in den Modulen 14 und 15 lernen, dass ein ähnlicher Effekt erzielt werden kann, wenn man Signale aus einer Mehrkanalaufnahme einer Schallquelle verwendet, da die verschiedenen Mikrofonkanäle eine geringe Korrelation aufweisen können. Aufnahme-Techniken mit 3D-Mikrofonarrays ermöglichen die Abbildung aller Arten von Schallquellen, die in einer Klangszene auftreten, in der richtigen Größe. Jedes der Mikrofone einer solchen Aufnahme wird dabei wieder als Punkt im Raum dargestellt, und der Größen- oder Ausbreitungsfaktor kann helfen, eine gleichmäßigere Verteilung im Raum zu ermöglichen, wenn die Anzahl der Lautsprecher, die für die Wiedergabe verwendet werden, größer ist als die Anzahl der Mikrofone, die für die Aufnahme des Klangs verwendet wurden.

### Virtuelle Akustik

In der realen Welt breitet sich eine Schallwelle auf einer geraden Linie von ihrem Ursprung zum Zuhörer/in aus. Dies wird als Direktschall bezeichnet. Die Schallwelle wird auch von Oberflächen in der Umgebung reflektiert, wodurch eine Reihe von frühen Reflexionen entsteht, die den Zuhörer/in aus verschiedenen Richtungen erreichen und sich über die Zeit zu einem dichten Nachhall entwickeln. Die Gesamtheit des Einflusses eines (echten order virtuellen) Raumes auf die Schallausbreitung wird im vorliegenden Kontext als Akustik des Raums bezeichnet. Sie prägt den Klang maßgebend und ist wichtig für unsere Fähigkeit, die Schallquelle zu lokalisieren und deren Entfernung vom Zuhörer/in zu bestimmen, aber auch für die Bestimmung des Charakters eines Raums (Modul 9).

In einer Spatial-Audio-Produktion kann die Nutzung von virtueller Akustik eine wichtige Rolle spielen, um einen plausiblen Raum zu schaffen. Du wirst Tools finden, die integrierte virtuelle Akustik bieten und dabei die Balance zwischen direktem Signal, frühen Reflexionen und Nachhall in Abhängigkeit von der Entfernung der Schallquelle zum Zuhörer/in berücksichtigen. Einige berücksichtigen die Position der Quelle und des/der Zuhörers/in innerhalb der Geometrie des Raums, da es einen hörbaren Unterschied machen kann, ob die nächstgelegene reflektierende Oberfläche nahe oder weit entfernt ist.

Quellsignal, das mit virtueller Akustik behandelt und in einen Spatial-Audio-Mix integriert werden soll, sollte mit möglichst wenig frühen Reflexionen und Nachhall aufgenommen werden, damit so wenig Einfluss wie möglich von der aufgenommenen auf doe virtuelle Akustik entsteht. Eine Alternative ist es, die gesamte Akustik des Raumes mit einem Mikrofon-Array aufzunehmen (Modul 15).

### Verdeckung und Beugung

Verdeckung tritt auf, wenn ein Hindernis den direkten Weg zwischen der Schallquelle und dem Zuhörer/in blockiert. Beugung beschreibt die Fähigkeit einer Schallwelle sich um ein Hindernis herum zu bewegen, siehe Abb. [2](https://spatial-audio.acoucou.org/course/course/spatial-audio/#x1-60012). Aufgrund der Beugung können wir auch verdeckte Schallquellen hören. Schall beugt sich um ein Hindernis, wenn seine Wellenlänge in der Größenordnung oder länger als die Dimensionen des Objekts ist. Die Wellenlänge von Schall in der Luft beträgt etwa $3$ $m$ bei einer Frequenz von $100$ $Hz$ , $30$ $cm$ bei $1$ $kHz$ und $3$ $cm$ bei $10$ $kHz$ . Schall mit Wellenlängen, die kürzer als die Dimensionen des Objekts sind, wird verdeckt (d.h. abgeschirmt). Dieser Effekt spielt eine wichtige Rolle bei Game-Audio, sowie bei Audio für Augmented- und Virtual-Reality.

![Figure 2: Beugung von Schall um ein Hindernis zwischen Schallquelle und Zuhörer/in.](https://spatial-audio.acoucou.org/course/static//lms/theory/course01/lesson05/figure-2.svg)

Figure 2: Beugung von Schall um ein Hindernis zwischen Schallquelle und Zuhörer/in.

### Direktivität von Schallquellen

Schallquellen in der realen Welt sind nie perfekt omnidirektional. Eine Trompete zum Beispiel erzeugt je nach Frequenz einen richtungsabhängigen Schallstrahl aus ihrem Schalltrichter, wie in Abb. [3](https://spatial-audio.acoucou.org/course/course/spatial-audio/#x1-70013) dargestellt. Andere Schallquellen können sehr komplexe Direktivitätsmuster aufweisen. Das spektrale Gleichgewicht kann sich daher je nach Orientierung einer Schallquelle drastisch ändern. Direktivität und Orientierung der Schallquelle können auch in herkömmlichem Audio technisch berücksichtigt werden, wobei der Effekt in der Regel begrenzt ist. Dennoch bieten nur sehr wenige Spatial-Audio-Tools die Möglichkeit, Direktivität und Orientierung einer virtuellen Schallquelle zu beinflussen. Diese Funktion ist jedoch ein wichtiges Tool in der Game-, Augmented- und Virtual-Reality-Produktion, um realistische Szenen zu erschaffen.

![Figure 3: Direktivität einer Trompete. Nach [3].](https://spatial-audio.acoucou.org/course/static//lms/theory/course01/lesson05/figure-3.svg)

Figure 3: Direktivität einer Trompete. Nach \[ 3 \].

### Systemeinschränkungen

Bei der Erstellung von Spatial-Audio-Inhalten ist es wichtig, die Fähigkeiten des Abspielsystems zu berücksichtigen. Spatial Audio wird oft synonym mit 3D-Audio verwendet, da nur 3D-Audio, wie der Name schon sagt, in der Lage ist, den dreidimensionalen physischen Raum wiederzugeben. Auch Surround-Sound-Systeme können zur Erstellung und Darbietung von Spatial-Audio-Szenen genutzt werden, wobei natürlich keine Information außerhalb der Horizontalebene dargestellt werden kann. Dies ist normalerweise eine Einschränkung, die aus praktischen oder finanziellen Gründen akzeptiert wird, da die Installation von Höhenlautsprechern nicht möglich oder zu umständlich ist.

Die meisten Lautsprecher-Wiedergabesysteme sind nicht in der Lage, eine Audioquelle korrekt wiederzugeben, wenn sie sich zwischen dem Lautsprecher und dem/der Zuhörer/in befindet. Typischerweise hört man die Quelle in dem Abstand, in dem sich die Lautsprecher befinden. Einige Rendering-Methoden versuchen gezielt dies zu überwinden, und zukünftige Technologien könnten entwickelt werden, die diese Aufgabe noch überzeugender bewältigen können. Bei Kopfhörern und Binaural-Rendering-Technologie ist die physische Entfernung von Lautsprecher und Zuhörer/in minimal, sodass Audioquellen extrem nah an den Ohren des/der Zuhörers/in wahrgenommen werden können. Dies ist ein Effekt, der beispielsweise in ASMR-Anwendungen genutzt wird.

Die Verdeckung und Direktivität von Lautsprechern können ebenfalls zu einer unbeabsichtigten Veränderung der wahrgenommenen Spatial-Audio-Szene führen und sind in der Regel nicht gewollt, es sei denn, sie werden absichtlich im Prozess der Spatial-Audio-Erstellung eingesetzt. Daher ist eine sorgfältige Planung eines Spatial-Audio-Wiedergabesystems wichtig und keine triviale Aufgabe, insbesondere wenn ein größeres Publikum bedient werden soll.

### References

\[1\]

Christopher Stover and Eric W. Weisstein. "Cartesian Coordinates." From MathWorld-A Wolfram Web Resource.url: [https://mathworld.wolfram.com/CartesianCoordinates.html](https://mathworld.wolfram.com/CartesianCoordinates.html).

\[2\]

Eric W. Weisstein. "Spherical Coordinates." From MathWorld-A Wolfram Web Resource.url: [https://mathworld.wolfram.com/SphericalCoordinates.html](https://mathworld.wolfram.com/SphericalCoordinates.html).

\[3\]

J.Meyer. Akustik und musikalische Aufführungspraxis. Fifth edition, PPVMEDIEN, Edition Bochinsky, 2004.

## Die Schuhschachtel-Benutzeroberfläche

Das gebräuchlichste Panning-Werkzeug basiert auf einem Schuhschachtel-Modell eines Raums. Die Benutzeroberfläche zeigt entweder die Achsen in 2D-Ebenen oder alle drei kombiniert in einem 3D-Modell.

x

y

z

Spatial Audio ist Teil der Acoucou-Plattform © 2024 Bereitgestellt unter der Creative Commons-Lizenz [\[CC BY-NC-ND 4.0\]](https://creativecommons.org/licenses/by-nc-nd/4.0/)