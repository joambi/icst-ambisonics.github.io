---
tags:
  - Blog
---
---

# Decoder für Lautsprecher

Das **Decoding ist eine Schlüsselfunktion im Umgang mit 3D‑Audio im Ambisonics‑Format**. Von der Qualität des Decoders hängt maßgeblich ab, wie präzise und räumlich korrekt ein aufgezeichnetes oder synthetisch erzeugtes B‑Format wiedergegeben wird.[1]

Beim Arbeiten mit Kopfhörern gibt es heute kaum noch Hürden: Die Umwandlung von B‑Format in binaurales Format funktioniert mit aktuellen Plugins – etwa von IEM, SPARTA und anderen Herstellern – bereits sehr zuverlässig. Herausfordernder wird es, sobald das B‑Format auf reale Lautsprecher‑Arrays decodiert werden soll – insbesondere bei mehrkanaligen, nicht‑symmetrischen Setups.[2][3][4]

Mit dem **ICST Ambisonics Decoder** steht ein leistungsfähiges, praxisnah entwickeltes Werkzeug zur Verfügung, das das Arbeiten mit unterschiedlichsten Lautsprecher‑Anordnungen deutlich vereinfacht. Standard‑Konfigurationen wie Quadrophonie, Octagon, Atmos 7.1.4 usw. lassen sich ebenso ansteuern wie frei definierte, nicht symmetrische Lautsprecher‑Layouts. Der Decoder wurde auf Basis umfangreicher Studio‑ und Live‑Erfahrung entwickelt, kontinuierlich erprobt und optimiert.[5][6][1]

In diesem Blog zeige ich Ihnen die **zentralen Funktionen, Besonderheiten und Spezialitäten** des ICST‑Ambisonics‑Decoders und illustriere den Workflow anhand konkreter Reaper‑Beispiele.[7][1]

***

## Verfügbarkeit und Installation

Die **ICST Ambisonics Decoder Plugins** stehen in folgenden Formaten zur Verfügung:[8][1]

- VST3  
- AU (Component)  
- LV2 *(experimentell – derzeit nicht für produktiven Einsatz empfohlen)*  

Reaper eignet sich besonders gut für Ambisonics‑Projekte, da es bis zu 64 Audiokanäle pro Track unterstützt, was für höhere Ambisonics‑Ordnungen und komplexe Routing‑Strukturen ideal ist.[6][9][10]

Weitere Informationen und Downloads:

- ICST Ambisonics Plugins – Überblick & Download:[1]
  https://ambisonics.ch/icst-ambisonics-plugins/  
- Blogseite mit Installationshinweisen:[1]
  https://ambisonics.ch/icst-ambisonics-plugins/  
- Schritt‑für‑Schritt Video zur Installation:  
  https://www.youtube.com/watch?v=2GXb5tbqW1Y[11]
- Wiki zu den ICST Ambisonics Plugins:  
  https://github.com/schweizerweb/icst-ambisonics-plugins/wiki[5][8]

***

## Überblick: ICST Ambisonics Decoder

### Hauptansicht

1. Horizontale Radar‑Ansicht  
   Darstellung der Lautsprecheranordnung in der Horizontalebene (Beispiel: ICST Kompositionsstudio).
2. Vertikale Radar‑Ansicht  
   Darstellung entlang der Z‑Achse (Höhenebene).
3. Speaker‑Parameter  
   - CH 1 = Kanalindex  
   - Name = Lautsprecher‑Bezeichnung  
   - Cartesian (XYZ) & Polar (AED) Koordinaten  

> Tipp: Doppelklick in ein Parameterfeld ermöglicht die direkte Eingabe von Werten.

### Einstellungen und Hilfen

4. Preferences & Help  
   - Zahnrad‑Symbol: Öffnet das Fenster „Speaker Settings“.  
   - Fragezeichen‑Symbol: Öffnet das Hilfe‑Fenster.
5. Speaker‑Parameter‑Editor  
   Detaillierte Bearbeitung der Lautsprecherkoordinaten sowie Verwaltung von Presets.

### Aktionen, die den Klang betreffen

| Aktion                        | Tastaturkürzel        | Beschreibung                                |
| ----------------------------- | ---------------------- | ------------------------------------------- |
| Mute ausgewählter Source/Speaker | Ctrl + Shift + M       | Stummschalten der gewählten Quelle(n)       |
| Solo ausgewählter Source/Speaker | Ctrl + Shift + S       | Solo‑Schalten der gewählten Quelle(n)       |

Weiterführende Ressourcen:

- Video „ICST Ambisonics Plugins Overview“:  
  https://www.youtube.com/watch?v=xkauhHMYt5k[11]
- Wiki ICST Ambisonics Plugins:  
  https://github.com/schweizerweb/icst-ambisonics-plugins/wiki[8][5]

***

## Workflow: Ambisonics Decoding in Reaper

Der grundlegende Workflow in Reaper lässt sich schematisch wie folgt beschreiben:[7]

1. Erstellen Sie drei 64‑kanalige Tracks in Reaper:
   - **B‑Format Source**: Track für das eingehende B‑Format (1st–7th Order Ambisonics).  
   - **Ambisonics Bus**: Sammelt alle B‑Format‑Signale und hostet Mastering‑Effekte.  
   - **ICST AmbiDecoder**: Host‑Track für den ICST AmbiDecoder.  

2. Stellen Sie sicher, dass alle relevanten Tracks 64 Kanäle besitzen, damit die Ambisonics‑Signale korrekt durch die Kette geroutet werden können.[9][6][7]

***

## ICST AmbiDecoder im Detail

1. Fügen Sie im Track „ICST AmbiDecoder“ das **ICST AmbiDecoder Plugin** ein.  
   Standardmäßig öffnet sich der Decoder mit einem Stereo‑(90°)‑Preset.[5]

2. Öffnen Sie das Fenster **Speaker Settings**:  
   Klicken Sie auf das Zahnrad‑Symbol und anschließend auf „Speaker“, um die Lautsprecher‑Einstellungen zu öffnen.  
   Dort können Sie:
   - aus zahlreichen Standard‑Layouts wählen (z.B. Quadro, 5.1, 7.1.4, Octagon),  
   - oder Ihre eigene Lautsprecher‑Konfiguration eingeben (inkl. asymmetrischer Setups).[6][5]

3. Aktivieren Sie bei Bedarf die **Filter‑Sektion**, um jeden Lautsprecher separat zu entzerren (optional).  
   - Es stehen verschiedene Filtertypen zur Verfügung (z.B. Shelving, parametrische EQs, etc.).[5]
   - Im Beispiel‑Screenshot ist das ausgemessene Lautsprecher‑Setup des ICST Kompositionsstudios zu sehen.[6]

4. Im Tab **Speakers** können Sie alle Speaker‑Parameter direkt bearbeiten und Ihre Konfiguration anschließend als Preset speichern.[5]

5. Im Tab **Ambisonics** legen Sie u.a. fest:
   - Ambisonics Order (bis max. 7. Ordnung),  
   - Channel Weights und Decoding‑Gewichtungen.  

6. Unter **Ambisonics Order** können Sie die gewünschte Ordnung komfortabel wählen.[5]

7. Skalieren Sie bei Bedarf die **Raumgröße**:  
   Die Lautsprecherkoordinaten sowie die Laufzeit‑Delays werden automatisch entsprechend angepasst.[5]

8. Eine wichtige Funktion ist die integrierte **Audio‑Test‑Sektion**.

### Audio Test

9. Der Decoder erlaubt einen direkten Audio‑Test mit Pink Noise:  
   - Einzelne Lautsprecher können gezielt angesteuert und geprüft werden.  
   - Mit „Test all speakers“ lassen sich alle Lautsprecher der Reihe nach im Uhrzeigersinn durchschalten.[5]

10. Tastaturkürzel für die schnelle Kontrolle:  
    - **Shift + Ctrl + M**: Mute einer Gruppe oder einzelner Lautsprecher.  
    - **Shift + Ctrl + S**: Solo einer Gruppe oder einzelner Lautsprecher.[5]

### Presets speichern und laden

Sie können komplette Lautsprecher‑Konfigurationen und Decoder‑Einstellungen als Presets sichern und bei Bedarf wieder laden.[5]

> Tipp:  
> Exportieren Sie die Speaker‑Konfiguration als **.txt‑Datei** und laden Sie diese extern in das Max‑External `ambidecode~` (z.B. via `coll`).[5]

***

## Überblick: ICST MultiDecoder

Der **ICST MultiDecoder** ist eine erweiterte Betriebsart des AmbiDecoders und ermöglicht bis zu vier parallel arbeitende Decoder‑Instanzen innerhalb eines Plugins.[5]

1. Aktivieren Sie den **Multi‑Decoder‑Modus**.  
   Dieses Flag kann auch zum schnellen A/B‑Vergleich ein‑ und ausgeschaltet werden.[5]

2. Bis zu **vier separate Decoder‑Einheiten** können ausgewählt und individuell konfiguriert werden (z.B. für Ebenen wie Oben/Mitte/Unten).[5]

3. Für jede dieser Decoder‑Einheiten lassen sich unabhängig einstellen:
   - Lautsprecher‑Auswahl und ‑Zuordnung,  
   - Ambisonics‑Order und Gewichtung,  
   - Filter‑Konfiguration (z.B. spezifische Filter nur für obere Lautsprecher),  
   - zusätzliche Audio‑Parameter wie:
     - Ein/Aus der Filter pro Einheit,  
     - individueller Lautstärke‑Regler,  
     - Mute/Unmute.[5]

So können Sie beispielsweise für unterschiedliche Lautsprecher‑Ebenen separate Frequenzgänge, Gewichtungen und Ordnungen einsetzen und psychoakustische Zielsetzungen (z.B. Tiefenstaffelung, Präsenz, Höhe) gezielt modellieren.[5]

***

## Die Idee hinter dem ICST MultiDecoder

Der **ICST MultiDecoder** entstand im Rahmen einer empirischen Versuchsreihe im Studio‑ und Konzertkontext. Ausgangspunkt war die wiederholte Beobachtung, dass konventionelle Ambisonics‑Decoder zwar ein physikalisch konsistentes und räumlich kohärentes Klangfeld erzeugen, die subjektiv wahrgenommene Tiefenstaffelung jedoch teilweise als diffus oder in ihrer Distanzabbildung reduziert beschrieben wird.[6][5]

Diese Beobachtung ist nicht als methodischer Fehler zu verstehen, sondern als Konsequenz des feldbasierten Ansatzes von Ambisonics: Ambisonics zielt primär auf die Rekonstruktion eines physikalisch konsistenten Schallfeldes. Die menschliche Raumwahrnehmung beruht jedoch auf komplexen psychoakustischen Integrationsprozessen, die über rein physikalische Parameter hinausgehen.[12]

***

## Psychoakustische Grundlagen

Die räumliche Wahrnehmung ist **frequenzabhängig organisiert**:[12]

- Tieffrequente Anteile werden vor allem über interaurale Zeitdifferenzen (ITD) verarbeitet.  
- Mittlere Frequenzen integrieren ITD‑ und Pegeldifferenzen (ILD).  
- Hochfrequente Komponenten werden überwiegend über Pegel‑, Richtungs‑ und spektrale Cues lokalisiert.  

Diese frequenzspezifische Verarbeitung beeinflusst die empfundene Distanz, Präzision und Tiefenstaffelung eines Klangereignisses maßgeblich. Ein rein feldtheoretisch optimiertes Rendering kann psychoakustisch daher weniger differenziert wirken, obwohl es physikalisch korrekt ist.[12]

***

## Abgrenzung zu vektorbasierten Verfahren

Im Unterschied zu vektorbasierten Ansätzen – etwa der ALLRAD‑Methode, wie sie im IEM AllRADecoder implementiert ist – verfolgt der ICST MultiDecoder konsequent einen feldbasierten Ansatz.[13][2]

Vektorbasiertes Decoding optimiert die Lautsprecheransteuerung direkt und liefert robuste, lokalisationsstabile Ergebnisse. Dabei wird die rein sphärisch‑harmonische Rekonstruktion zugunsten einer hybriden Lösung erweitert, bei der z.B. virtuelle Lautsprecher‑Layouts und VBAP‑Mapping kombiniert werden.[2][13][12]

Das Ziel des MultiDecoders ist hingegen, das Ambisonics‑Paradigma nicht zu verlassen, sondern **innerhalb** seiner strukturellen Logik eine feinere psychoakustische Abbildung zu ermöglichen.[5]

***

## Methodischer Ansatz

Der ICST MultiDecoder basiert im Kern auf folgenden Prinzipien:[6][5]

1. Beibehaltung der sphärisch‑harmonischen Feldbeschreibung.  
2. Frequenzabhängige Optimierungsstrategien im Rendering.  
3. Empirische Validierung durch vergleichende Hörtests im Studio‑ und Konzertbetrieb.  
4. Berücksichtigung realer, auch nicht‑symmetrischer Lautsprecheranordnungen.  

Ziel ist eine Verbesserung der subjektiv wahrgenommenen Tiefenstaffelung bei gleichzeitiger Wahrung der energetischen und phasenbezogenen Kohärenz des rekonstruierten Schallfeldes.[12][5]

***

## Einordnung

Der ICST MultiDecoder versteht sich nicht als Ersatz konventioneller Ambisonics‑Decoder, sondern als **konzeptionelle Erweiterung innerhalb des feldbasierten Paradigmas**. Er versucht, physikalische Modelltreue und psychoakustische Wahrnehmungsrealität in ein ausgewogeneres Verhältnis zu bringen, ohne die Ambisonics‑Grundidee aufzugeben.[6][5]

Quellen
[1] 01_Overview https://ambisonics.ch/icst-ambisonics-plugins/01_overview/
[2] AllRADecoder Guide - IEM Plug-in Suite https://plugins.iem.at/docs/allradecoder/
[3] GitHub - tu-studio/IEMPluginSuite https://github.com/tu-studio/IEMPluginSuite
[4] SPARTA - Spatial Audio Real-Time Applications https://leomccormack.github.io/sparta-site/
[5] Johannes Schuett | ICST Ambisonics Plugins v3.1 https://ambisonics.ch/icst-ambisonics-plugins/new/
[6] ICST Ambisonics Plugins https://zenodo.org/records/7702351
[7] Johannes Schuett | 06_step_by_step_setup - The ICST Ambisonics https://ambisonics.ch/icst-ambisonics-plugins/06_step_by_step_setup/
[8] GitHub - schweizerweb/icst-ambisonics-plugins https://github.com/schweizerweb/icst-ambisonics-plugins
[9] [PDF] ATK Reaper: The Ambisonic Toolkit as JSFX plugins https://www.ambisonictoolkit.net/assets/files/2014-ICMC-ATK-Reaper.pdf
[10] GP-4 multichannel outputs - General discussion about Gig Performer https://community.gigperformer.com/t/gp-4-multichannel-outputs/7064
[11] ICST Ambisonics Tutorial - Points and Radars https://www.youtube.com/watch?v=aDa-vNWriLM
[12] Ambisonic Transcoding – SPAT Revolution https://doc.flux.audio/spat-revolution/Spatialisation_Technology_Ambisonic_transcoding.html
[13] Plug-in Descriptions - IEM Plug-in Suite https://plugins.iem.at/docs/plugindescriptions/
[14] Ambisonic Mixing in Reaper https://dxarts.washington.edu/wiki/ambisonic-mixing-reaper
[15] ICST Ambisonics Plugins - spæs https://spaes.org/ICST-Ambisonics-Plugins
