---
title: ICST Decoder
date: 2025-01-01T00:00:00
weight: 80
draft: false
---

Institute for Computer Music and Sound Technology (ICST) Zurich University of the Arts

---

Institut für Computermusik und Klangtechnologie (ICST) · Zürcher Hochschule der Künste

---

# ICST Ambisonics Decoder

Decodierung ist die zentrale Schnittstelle zwischen dem Ambisonics-B-Format und der physischen Lautsprecherwiedergabe – ihre Qualität bestimmt räumliche Präzision, Tiefenstaffelung und Lokalisation.

Während die binaurale Wiedergabe über Kopfhörer durch etablierte Plug-ins (z. B. IEM, SPARTA) heute weitgehend ausgereift ist, bleibt die Decodierung für reale Lautsprecheranordnungen eine technisch und psychoakustisch anspruchsvolle Aufgabe. Geometrie, Laufzeiten, Gewichtungen, Filterung und Ambisonics-Order müssen präzise aufeinander abgestimmt werden.

Der **ICST Ambisonics Decoder** ist ein leistungsfähiges, praxisorientiertes Werkzeug, das speziell für flexible Lautsprecheraufbauten in Studio- und Live-Kontexten entwickelt wurde. Neben Standardkonfigurationen (z. B. Quadro, Oktagon, 7.1.4) können auch asymmetrische oder individuell eingemessene Lautsprecheranordnungen präzise abgebildet werden.

Der Decoder wurde im Kontext des 3D-Kompositionsstudios der ZHdK entwickelt und kontinuierlich im Studio- und Konzertbetrieb erprobt. Ziel war ein **flexibles, reproduzierbares und klanglich transparentes Decodiersystem** für Higher-Order-Ambisonics-Workflows.

---

## Plugin-Formate

Die **ICST Ambisonics Decoder Plugins** sind verfügbar als:
- VST3
- AU (Component)
- LV2 _(experimentell – nicht für den Produktionseinsatz empfohlen)_

Wiki: [ICST AmbiDecoder · schweizerweb/icst-ambisonics-plugins Wiki · GitHub](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiDecoder)

Alle Beispiele in diesem Artikel werden in REAPER durchgeführt. REAPER unterstützt bis zu 128 Audiokanäle pro Spur und eignet sich daher besonders gut für Higher-Order-Ambisonics-Produktionen.

---

## Übersicht ICST Ambisonics Decoder

![ICST Ambisonics Decoder Übersicht](decoder-overview.png)

### Hauptbereiche der Benutzeroberfläche

1. **Radar – horizontale Ansicht** der Lautsprecheranordnung (ICST Kompositionsstudio)
2. **Vertikale Radar-Ansicht (Z-Achse)**
3. **Lautsprecherparameter**
    - CH = Index
    - Name = Lautsprecherbezeichnung
    - Koordinaten: Kartesisch (XYZ) & Polar (Azimut, Elevation, Distanz)

> [!tip]
> Doppelklick auf die Parameterfelder ermöglicht die direkte Eingabe von Werten.

### Einstellungen & Hilfe <img src="speaker-settings-icon.png" width="16" style="vertical-align: middle;">

4. Zahnrad-Icon → Öffnet das _Speaker Settings_-Fenster
5. Fragezeichen → Hilfefenster

**Lautsprecher-Parameter-Editor:**

![Lautsprecher-Parameter-Editor](CleanShot%202026-02-11%20at%2010.59.50@2x.png)

### Tastenkürzel

| Aktion                              | Kürzel             |
| ----------------------------------- | ------------------ |
| Ausgewählte Quelle/Lautsprecher muten | `Ctrl + Shift + M` |
| Ausgewählte Quelle/Lautsprecher solo  | `Ctrl + Shift + S` |

> [!example]
> Video: ICST Ambisonics Plugins Übersicht
> https://www.youtube.com/watch?v=xkauhHMYt5k

> [!info]
> Wiki: ICST Ambisonics Plugins
> https://github.com/schweizerweb/icst-ambisonics-plugins/wiki

---

## Workflow: Ambisonics-Decodierung in REAPER

![Workflow-Schema](CleanShot%202026-02-10%20at%2017.28.25@2x.png)

### Empfohlene Spurstruktur

Drei 64-Kanal-Audiospuren in REAPER anlegen:

![Spuraufbau](CleanShot%202026-02-10%20at%2017.36.04@2x.png)

1. **B-Format-Quellspur** – Ambisonics-Datei 1.–7. Ordnung
2. **Ambisonics-Bus** – sammelt mehrere B-Format-Signale, beherbergt Mastering-FX
3. **Decoder-Spur** – beherbergt den ICST Ambisonics Decoder, Ausgabe an Lautsprecher

Diese klare Trennung gewährleistet Transparenz, Modularität und reproduzierbare Setups.

---

## ICST AmbiDecoder – Schritt-für-Schritt-Einrichtung

1. Das **ICST AmbiDecoder**-Plugin zur Decoder-Spur hinzufügen.

    ![Plugin hinzufügen](CleanShot%202026-02-10%20at%2017.54.52@2x.png)

    Standardmäßig öffnet der Decoder mit der Stereo-Einstellung (90°).

    ![Lautsprecher-Preset auswählen](Choose_Quadro.gif)

2. Das _Speaker Settings_-Fenster öffnen (Zahnrad-Icon → „Speaker"). Eines der vielen Standardpresets auswählen oder eine eigene Lautsprecherkonfiguration eingeben.

    ![Lautsprecher bearbeiten](Speaker_Editing.gif)

3. Optional den **Filter**-Bereich aktivieren, um einzelne Lautsprecher zu entzerren.

    ![Filter aktivieren](CleanShot%202026-02-11%20at%2011.05.51@2x.png)

    Verfügbare Filtertypen pro Lautsprecher:

    ![Filtertypen](CleanShot%202026-02-11%20at%2011.11.32@2x.png)

    > [!todo]
    > Screenshot hinzufügen: eingemessenes Lautsprecher-Setup des ICST Kompositionsstudios

4. Unter **„Speakers"** die Lautsprecherparameter direkt bearbeiten und als Preset speichern.

    ![Lautsprecher-Einstellungen Detail](CleanShot%202026-02-10%20at%2018.57.37@2x.png)

5. Unter **„Ambisonics"** die gewünschte Ordnung (bis zur 7. Ordnung) und Channel Weights auswählen.

    ![Ambisonics-Ordnung](CleanShot%202026-02-11%20at%2009.30.18@2x.png)

6. Raumdimensionen bei Bedarf skalieren – Lautsprecherkoordinaten und Laufzeiten werden automatisch neu berechnet.

    ![Raumskalierung](CleanShot%202026-02-11%20at%2010.19.42@2x.png)

---

## Audio-Testfunktion

![Audio-Test](Decoder%20Audio%20test.gif)

Der Decoder verfügt über einen integrierten Testbereich:

- Pink-Noise-Generator
- Einzeltest pro Lautsprecher
- Sequenzieller Test aller Lautsprecher im Uhrzeigersinn („Test all speakers")
- Mute / Solo via `Ctrl + Shift + M` / `Ctrl + Shift + S`

Dies ermöglicht eine schnelle technische Überprüfung des gesamten Systems vor Probe oder Aufführung.

---

## Presets speichern & laden

![Presets speichern](save%20decoder%20presets.gif)

Lautsprecherkonfigurationen können als Presets gespeichert und jederzeit neu geladen werden. Dies gewährleistet Reproduzierbarkeit über Sessions und Spielorte hinweg.

> [!tip]
> Die Lautsprecherkonfiguration als TXT-Datei exportieren und über ein `coll` in das externe `ambidecode~`-Objekt laden.

![TXT-Export](CleanShot%202026-02-11%20at%2014.23.51@2x.png)

---

## Zusammenfassung

Der ICST Ambisonics Decoder bietet:

- Präzise Higher-Order-Ambisonics-Decodierung
- Flexible Lautsprechergeometrien (symmetrisch & asymmetrisch)
- Lautsprecherindividuelle Filterung und Entzerrung
- Integrierte Test- und Messfunktionen
- Multi-Layer-MultiDecoder-Architektur
- Preset-Verwaltung für reproduzierbare Setups
- Nahtlose Integration in professionelle DAW-Workflows

Er bildet damit eine robuste Grundlage für künstlerische, wissenschaftliche und produktionsorientierte Anwendungen im Bereich 3D-Audio.

---