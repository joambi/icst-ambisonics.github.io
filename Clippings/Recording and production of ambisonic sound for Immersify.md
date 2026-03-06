---
title: "Recording and production of ambisonic sound for Immersify"
source: "https://immersify.eu/2019/03/10/recording-and-production-of-ambisonic-sound-for-immersify/"
author:
  - "[[Immersify]]"
published:
created: 2026-01-14
description: "Recording and production of ambisonic sound for Immersify"
tags:
  - "clippings"
---
*Von Jan Skorupa, Wojciech Raszewski, Eryk Skotarczak und Maciej Głowiak, März 2019*

Im Februar 2019 begann das Poznań Supercomputing and Networking Center (PSNC) mit Experimenten mit ambisonischen Aufnahmen und Mehrkanal-Soundprojektion, die mit dem Immersify-Projekt zusammenhängen. Eine Jazzband namens Anomalia (deren Mitglieder Studenten der Ignacy Jan Paderewski Academy of Music in Poznań sind) wurde eingeladen, an dem Projekt teilzunehmen. Die von der Band aufgenommenen Audioinhalte wurden in einem kugelförmigen ambisonalen Raum gemischt, der von 24 Lautsprechern im New Media Laboratory von PSNC erstellt wurde. Neben den Tonaufnahmen wurden 8K- und 360°-Videos produziert, um Anomalias Performance zu zeigen. Das Audiomaterial wurde schließlich als Ambison-Sound der dritten und fünften Ordnung codiert, dann binaural dekodiert und schließlich mit einem 360°-Video kombiniert. All dies erforderte einen ordnungsgemäßen Workflow für die Produktion und Mischung von Surround-Sound für das Immersify-Projekt.

![](https://www.youtube.com/watch?v=xyh4GU7imhU)

Jan Skorupa und Wojciech Raszewski von PSNC erklären *ambisonischen Sound (Für englische Untertitel klicken Sie auf das Symbol unten rechts)*

### Aufzeichnungen

Das Projekt begann mit der Suche nach einer geeigneten Musikband. Wenn wir über das Ziel der Aufnahmen nachdenken, musste die gesuchte Band über ein ausreichend großes Line-up und vielfältiges Material verfügen, was eine interessante Projektion des räumlichen Sounds ermöglichen würde. Anomalie erfüllte unsere Erwartungen, da es sich um ein Jazz-Septet mit Musikern handelt: Schlagzeug, Kontrabass, Gitarre, Tenorsaxophon, Sopransaxophon, Posaune und Trompete.

![](https://www.youtube.com/watch?v=CmanK_HB9N4)

Am 7. Februar 2019 trafen sich die Musiker mit Forschern der New Media Department von PSNC, um Testaufnahmen zu machen. Für diese Aufgabe wurde ein schallangepasster Veranstaltungsraum im PSNC genutzt. Der Ort wurde auf stimmungsvolle Weise mit einigen historischen Bühnenlampen beleuchtet. Wir haben die Mitglieder der Band in einen Kreis gesteckt, obwohl wir nicht versucht haben, jedes der Instrumente zu trennen. Wir wollten möglichst räumliche und natürliche Aufzeichnungen erreichen. Um Blasinstrumente aufzunehmen, haben wir DPA 4099 Mikrofone verwendet. Für das Tenorsaxophon wurde ein zusätzliches Kondensatormikrofon SE2200a verwendet, um eine genauere Erfassung niedrigerer Frequenzen zu erhalten. Für die Aufnahme des Kontrabasses haben wir den Zeilenausgang des Verstärkers verwendet – diese Lösung war jedoch nicht voll zufriedenstellend, da es in dieser Konfiguration unmöglich war, die Wechselwirkungen zwischen den Saiten aufzunehmen. Um den gewünschten Effekt zu erzielen, haben wir zusätzlich ein DPA-Instrumentalmikrofon installiert. Für die E-Gitarre wurden, um den tiefstmöglichen Klang zu erhalten, zwei verschiedene Arten von Mikrofonen verwendet: dynamische Shure SM57 und Kondensator Audio Technica AT 2050. Um Umgebungsgeräusche zu erhalten, wurde Ambeo VR Mic von Sennheiser an der Decke über der Insta360 Pro-Kamera abgehängt, was Ambisonaufnahmen erster Ordnung ermöglichte. Das Material dieses Mikrofons diente in der weiteren Stufe (Mix) als Basis für Multi-Lautsprecher-Projektion. Die Live-Aufnahme wurde mit den Mikrofonvorverstärkern von Midas Pro erstellt und über KlarkTeknik DN9650 in Dante umgewandelt. Das digitale Signal wurde dann an eine Aufnahmearbeitsstation mit installierter Reaper DAW gesendet.

![](https://www.youtube.com/watch?v=p52diHjunZc)

### Überwachungssystem

Um das erhaltene Material zu mischen, wurde eine sphärische Ambisoninstallation von 25 Genelec 8010A Lautsprechern (einschließlich eines Subwoofers) und in einem separaten Studio aufgebaut. Die Lautsprecher waren in drei Ringebenen in unterschiedlichen Höhen angeordnet. Der erste Ring wurde bei 30 cm vom Boden aus platziert, wo sich die Lautsprecher im Winkel von 45 Grad zur Mitte der Kugel befanden; der zweite Ring - bei 165 cm, wo die Lautsprecher nicht zum Hörpunkt geneigt waren; und ein dritter Ring - bei 280 cm, wo die Lautsprecher im Winkel von 45 Grad zur Mitte der Kugel geneigt waren. Der Subwoofer wurde an der Vorderseite des Lautsprecherblocks positioniert.

Um das gesamte System zu bedienen, haben wir eine Focusrite Rednet 3-Schnittstelle verwendet, um die Dante-Ausgabe von der DAW in vier ADAT-Links umzuwandeln. Das war jedoch an vier Behringer ADA 8200 D/A-Wandler angeschlossen. Eine solche Schnittstellenkombination ermöglichte es uns, 32 symmetrische analoge Signalausgänge zu unterstützen.

![](https://www.youtube.com/watch?v=s11vjw_JHrA)

### Mixen und Produzieren von Audiodateien

Das Hauptproblem beim Mischen des aufgenommenen Materials in der Multi-Lautsprecher-Installation war die Suche nach geeigneten Werkzeugen. Die erste Aufgabe, die wir bewältigen mussten, war die Auswahl einer geeigneten DAW, die es uns ermöglichen würde, an einer solchen Produktion komfortabler zu arbeiten. Nach vielen Tests haben wir uns für Reaper entschieden – eine Anwendung, mit der wir mühelos Spuren mit bis zu 64 Audiokanälen erstellen können. Darüber hinaus unterstützt Reaper auch den Export des Endprodukts in eine 64-Kanal-WAV-Datei. Der nächste Schritt war, eine geeignete externe Software für die Realisierung von erfassten Aufnahmen im Ambisonbereich zu finden. Zu diesem Zweck haben wir VST-Plugins verwendet, die im Institut für Elektronische Musik und Akustik der Kunst Uni Graz erstellt wurden. Diese Tools ermöglichten einen umfassenden Mix und eine freie Verräumlichung der Aufnahmen in einem Ambisonsystem bis zum siebten Mal, sowie eine binaurale Darstellung des Effekts mit HRTF (Head – Realated Transfer Function).

### Schlussfolgerungen

Die Aufnahmen waren ein Experiment, das mit der Produktion des 3D-Audios innerhalb des Immersify-Projekts verbunden war. Die Audioinhalte sowie der erstellte Workflow trugen maßgeblich zur Erstellung der hochmodernen Immersify-Software bei. Es ist ein großer Schritt vorwärts bei der Verarbeitung von 3D-Sound in eine Anwendung, die als anspruchsvoller Audio- und Video-Player dient. Derzeit laufen weitere Arbeiten – wir verfolgen die Kombination von hochauflösendem 8K-Video mit dem aufgenommenen Ambisonmaterial.