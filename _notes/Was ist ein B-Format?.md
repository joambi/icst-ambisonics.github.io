---
categories:
  - Ambisonics
  - Composition
  - Blog
---
----
## 1. Warum sollten wir für mehrkanaliges Audio im B-Format produzieren?


## 2. [Was ist ein B-Format?](https://ambisonic.info/ambisonics/channels.html)

Das B-Format ist das zentrale Signalformat von Ambisonics und enthält die räumlichen Informationen. 
Hierbei handelt es sich _um_ ein Mehrkanal-Audioformat, in dem die einzelnen Kanäle _nicht_ direkt mit Lautsprecher-Feeds übereinstimmen. Es gibt keinen "Front Left" -Kanal. Stattdessen enthalten die Kanäle Komponenten des Resonanzbodens, die erst in einem späteren Dekodierungsschritt kombiniert werden.
Das B-Format unterstützt volles 3D-Audio, was es für Virtual-Reality-(VR)-Anwendungen prädestiniert, da es sich leicht in jede mögliche Kopfdrehung drehen lässt.

Mit dem B-Format lassen sich Mehrkanal-Audio generieren, aufzeichnen und von Ort zu Ort übertragen, ohne sich Gedanken über die Lautsprecher machen zu müssen, die am Ende zur Wiedergabe verwendet werden. Es ist etwas komplexer zu arbeiten, aber es bedeutet, dass Sie Ihre Inhalte normalerweise nur einmal beherrschen müssen, statt sie separat für Stereo, 5.1, 7.1 usw. zu beherrschen. 

Es beschreibt einen Raumzustand um einen Hörpunkt (SweetSpot) herum, der aus Druck- und Richtungsanteilen besteht. In der ersten Ordnung bedeutet das:

- `W` ist die omnidirektionale Komponente, also der Druck bzw. die Präsenz im Raum.
- `X`, `Y` und `Z` sind gerichtete Anteile in drei Achsen (links-rechts, vorne-hinten, oben-unten), die angeben, aus welcher Richtung das Signal kommt.

Im engeren, klassischen Sinn bezeichnet B-Format dieses vierkanalige Ambisonics-Format erster Ordnung (`W`, `X`, `Y`, `Z`). Im erweiterten Sinn kann man das B-Format auch für höhere Ordnungen verwenden. Dann umfasst es alle Ambisonics-Koeffizienten bis zu einer bestimmten Ordnung, jeweils als eigener Audiokanal.
Ambisonics höherer Ordnung verwendet zusätzliche sphärische Harmonische.  Für die zweite und dritte Ordnung wurden diese mit zusätzlichen Buchstabenbezeichnungen versehen, doch für die allgemeine Betrachtung höherer Ordnungen sind andere, flexiblere Benennungsschemata erforderlich – die Wahl des zu verwendenden Schemas und sogar die Reihenfolge, in der die Signale höherer Ordnung aufgelistet und aufgezeichnet werden, sind in der Ambisonics-Community nach wie vor umstritten.  Es gibt auch einige Meinungsverschiedenheiten darüber, ob der Begriff B-Format auf Signalsätze erster Ordnung beschränkt sein sollte.

Dieser Satz von Signalen ermöglicht es, die zur Erzeugung von Lautsprechersignalen, zur Drehung des Schallfeldes und für verschiedene andere Transformationen erforderlichen Manipulationen mit möglichst einfacher Mathematik durchzuführen; daher ist er auch der Signalsatz, der sowohl für die Speicherung als auch für die Übertragung von Ambisonics-Material verwendet wird. 

Dieses Format kann anschließend auf verschiedene Ziel-Setups dekodiert werden, etwa auf Kopfhörer, Stereo oder Lautsprecher-Arrays. [1](https://en.wikipedia.org/wiki/Ambisonics) [2](https://ambisonic.info/ambisonics/channels.html)


---








