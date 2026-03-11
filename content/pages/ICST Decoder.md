---
title: "ICST Ambisonics Decoder"
categories:
  - "ICST Ambisonics Plugins"
---

Das Decoding ist die zentrale Schnittstelle zwischen dem Ambisonics-B-Format und der physischen Lautsprecherwiedergabe – seine Qualität entscheidet über räumliche Präzision, Tiefenstaffelung und Lokalisation.

# Decoder for Speakers

Das Dekodieren ist eine **Schlüsselfunktion im Umgang mit 3D-Audio im Ambisonics-Format**. Von der Qualität des Decoders hängt maßgeblich ab, wie präzise und räumlich korrekt ein aufgezeichnetes oder synthetisch erzeugtes B-Format wiedergegeben wird.
Wenn sie mit Kopfhörern arbeiten, haben sie heute fast keine Probleme mehr, da die Algorithmen der Dekodierung vom B-Format ins Binaural-Format mit den verschiedensten Binaural-Plugins von IEM, Sparta und anderen Herstellern sehr gut funktionieren.  

Mit dem **ICST Ambisonics Decoder** steht Ihnen ein leistungsfähiges und praxisnahes Werkzeug zur Verfügung, das Ihnen ein leichteres Arbeiten beim Dekodieren mit den verschiedensten Lautsprecher-Arrays ermöglicht. So lassen sich Standardkonfigurationen wie Quadro, Octagon, Atmos 7.1.4 etc. sowie nicht-symmetrische Lautsprecheraufstellungen beispielhaft zeigen.
Der Decoder wurde auf Basis umfangreicher Erfahrungen im Studio- und Live-Einsatz entwickelt, kontinuierlich erprobt und optimiert. Ziel war es, ein flexibles, zuverlässiges und klanglich präzises Decoding-System für unterschiedlichste Lautsprecher-Setups bereitzustellen.

In diesem Blog möchte ich Ihnen die **zentralen Funktionen, Besonderheiten und Spezialitäten** des ICST-Ambisonics-Decoders im Detail vorstellen und anhand praktischer Beispiele erläutern.

Die **ICST Ambisonics Decoder Plugins** sind verfügbar als:
- VST3  
- AU (Component)  
- LV2 *(experimentell – nicht für produktiven Einsatz empfohlen)*

Weitere Informationen zur Installation:  
https://ambisonics.ch/icst-ambisonics-plugins/
Hinweise zur **Installation der ICST Ambisonics Plugins** finden Sie auf dieser Blog-Seite:  
[ambisonics.ch](https://ambisonics.ch/icst-ambisonics-plugins/)
Alternativ bietet dieses Video eine anschauliche Schritt-für-Schritt-Einführung:  
<https://www.youtube.com/watch?v=2GXb5tbqW1Y>
Wiki ICST Ambisonics Plugins:
https://github.com/schweizerweb/icst-ambisonics-plugins/wiki

Alle Beispiele werden in der DAW Reaper durchgeführt, da Reaper bis zu 128 Audiospuren pro Track verarbeitet. Dies macht Reaper zur prädestinierten DAW für das Arbeiten mit Ambisonics und 3D-Audio.

---
### Overview ICST Ambisonics Decoder

![](/icst-ambisonics-plugins/08_icst_decoder/decoder-overview.png)
1. Radar Horizontal Ansicht der Laustprecher-Anordnung (ICST Kompositionsstudio)
2. Vertikale Radaransicht (Z-Achse)
3. Speaker-Parmeter:
	- CH 1 = index
	- Name = Speakername
	- Cartesian (XYZ) & Polar (AED) Koordinates

> [!tip]
> Doppelklick in die Parameternfelder um direkt zu schreiben

Settings:

![](/icst-ambisonics-plugins/08_icst_decoder/speaker-settings-icon.png)
4. Preferences & Help
	- Zahnrad = Öffnen des "Speaker settings" Fensters
	- "Fragezeichen" = öffnet das Help-Fenster
5. Speaker-Parmeter Editor
	 ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-11%20at%2010.59.50@2x.png)

#### Actions affecting sound:

| Action                       | Mouse/Keyboard   |     |
| ---------------------------- | ---------------- | --- |
| Mute selected source/speaker | Ctrl + Shift + m |     |
| Solo selected source/speaker | Ctrl + Shift + s |     |

> [!example]
> Video ICST Ambisonics Plugins Overview
> https://www.youtube.com/watch?v=xkauhHMYt5k

> [!info]
> Wiki ICST Ambisonics Plugins
> https://github.com/schweizerweb/icst-ambisonics-plugins/wiki

---
### Workflow Ambisonics Decoding in Reaper

![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-10%20at%2017.28.25@2x.png)
Der Workflow in Reaper: schematisch dargestellt.

1. Erstellen Sie in Reaper einen 3x einen 64-kanaligen Audio-Track 
   ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-10%20at%2017.36.04@2x.png)
     - B-Format Source (1st to 7th order ambisonics file)
     - Ambisonics Bus collects all B-Formats and hosted the Mastering FX's.
     - ICST AmbiDecoder host for the ICST AmbiDecoder

### ICST AmbiDecoder 

1. Add a ICST AmbiDecoder Plugin in the "ICST AmbiDecoder"
   ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-10%20at%2017.54.52@2x.png)
	- Standart mässig öffnet sich der Decoder mit dem Stereo (90°) Setting. 
   ![](/icst-ambisonics-plugins/08_icst_decoder/Choose_Quadro.gif)
2. Um ihr Lautsprecher-Setting zu finden, gehen Sie ins Decoder "Speaker settings“-Fenster, klicken Sie auf das "Zahnrad“ und dann auf „Speaker“, um die "Speaker settings" zu öffnen. Wählen Sie eines der vielen Standard-Settings oder geben Sie Ihre eigene Lautsprecherkonfiguration ein. (siehe next gif)
   ![](/icst-ambisonics-plugins/08_icst_decoder/Speaker_Editing.gif)

3. Aktivieren und öffnen sie die "Filter" um jeden Lautsprecher separat zu filtern. (optional)
   ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-11%20at%2011.05.51@2x.png)
	- Folgende Filter stehen zu Verfügung. (siehe Bild unten)
   ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-11%20at%2011.11.32@2x.png)
   
	- Im untenstehend Bild sehen sie das ausgemessene Lautsprecher Setup des ICST Kompositionsstudio.
   ![](/icst-ambisonics-plugins/08_icst_decoder/speaker-settings-detail.png)
3. Unter "Speakers" können Sie die Speaker-Parameter direkt editieren und anschließend als Preset speichern.
   ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-10%20at%2018.57.37@2x.png)
4. Unter "Ambisonics" können sie die Channel weights wählen, sowie die Ambisonics Order. (max 7th-order)
   
5. In "Ambisonics Order" können sie leicht ihre gewünschte Ordnung wählen.
   ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-11%20at%2009.30.18@2x.png)

6. Skaliere die Raumgrössen Verhältnisse und die Lautsprecher Koordinaten als auch die Laufzeit-Delays werden automatisch mitgerechnet.
   ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-11%20at%2010.19.42@2x.png)
7. Ein wichtiges Features ist die direkt eingebaute Audio-test Funktion:

   ### 8. Audio Test 
   ![](/icst-ambisonics-plugins/08_icst_decoder/Decoder%20Audio%20test.gif)
9. Der Decoder erlaubt einen direkten Audio-test mit Pinknoise. Es lassen sich die einzelnen Lautsprecher manuell testen und/oder mit dem "test all speakers" in serie nacheinander im Uhrzeigersinn.
10. Mit dem KeyShortcut "shift+ctrl. & M" lässt sich eine Gruppe oder einzelne Lautsprecher muten. Mit "shift+ctrl. & S" auch Solo schalten. 
### Save & Load Presets
![](/icst-ambisonics-plugins/08_icst_decoder/save%20decoder%20presets.gif)

> [!tip]
> 
Export the speaker configuration as a txt file and load it into the external ‘ambidecode~’ with a ‘coll’.
![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-11%20at%2014.23.51@2x.png)

Example: 
#### import speaker-setting.xml

# Overview ICST MultiDecoder

![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-11%20at%2013.46.56@2x.png)
1. Aktivate the Multi-Decoder mode
	- Dieses Flag kann auch zum Vergleich aktiviert & deaktiviert werden.
2. Bis zu vier separate Decoders können hier gewählt und konfiguriert werden.                       (Exemple: Höhe/Mitte/Unten)
3. Jeder der gewählten Decoder kann folgende Parameter separat handeln:
   - Lautsprecher Auswahl
   ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-11%20at%2013.55.43@2x.png)
- Selection of the ambisonics sequence and its weighting
  ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-11%20at%2013.59.16@2x.png)
- Jede Decodereinheit kann eine eigene spezifische Filtrierung erhalten. Zum Beispiel für die oberen Lautsprecher, wie im folgenden Bild erläutert.
  ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-11%20at%2014.05.58@2x.png)
	Neben den Ambisonics-Parametern lassen sich auch diese Audio-parameter getrennt einstellen:
  ![](/icst-ambisonics-plugins/08_icst_decoder/CleanShot%202026-02-11%20at%2014.09.04@2x.png)
    1. Die Filter können pro Decodereinheit aktiviert oder deaktiviert werden.
    2. Jede Decodereinheit verfügt über ihr eigenes Volumen.
    3. Mute/UnMute

---
