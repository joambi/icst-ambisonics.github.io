---
title: "Working with Ambisonics: Workshop fuer Fortgeschrittene"
description: "Vierstuendiger ICST-Workshop zu HOA-Signalketten, Ambisonics-Aufnahmen, ambiX/FuMa-Formaten, Produktion, Live-Performance, Max/MSP, Csound und kompositorischer Praxis."
date: 2026-05-03T00:00:00
draft: false
slug: working-with-ambisonics-workshop
languageCode: de
tags:
  - ambisonics
  - hoa
  - workshop
  - reaper
  - maxmsp
  - csound
---

WORKING WITH AMBISONICS  
Workshop fuer Fortgeschrittene | 4 Stunden | Voraussetzung: HOA-Grundkenntnisse  
Tonmeister:innen | Electroacoustic Composers | HOA-Practitioners  
ICST Ambisonics | Zuercher Hochschule der Kuenste | ambisonics.ch

Dieser Workshop fuehrt durch den vollstaendigen ICST-Workflow: von der Planung einer Ambisonics-Aufnahme ueber A-to-B-Konversion, B-Format-Produktion und Format-Audit bis zu Live-Setups, Installationen und generativer kompositorischer Praxis.

## Uebergeordnete Lernziele

Nach diesem Workshop kannst du:

- die ICST-Signalkette `Source -> Encoder -> Bformat Master -> Decoder` sicher aufbauen und debuggen
- Ambisonics-Aufnahmen technisch professionell planen und durchfuehren
- Dateiformate und Konventionen wie ambiX, FuMa und ACN/SN3D sicher einsetzen
- den Produktions-Workflow von Aufnahme bis Delivery als zusammenhaengende Kette denken
- HOA-Systeme fuer Live-Performance und Installation konzipieren
- Raum als kompositorisches Material gestalten: Bewegung, Tiefe, Kontrapunkt
- Csound via Cabbage als VST in REAPER integrieren und generative HOA-Patches in Max/MSP aufbauen

## Ablauf

| Teil | Dauer | Fokus |
|---|---:|---|
| Einstieg | 5 min | Was kann HOA, was Stereo nicht kann? |
| Block 1 | 45 min | Signalkette, Setup-Reihenfolge, Best Practices, Troubleshooting |
| Pause | 10 min |  |
| Block 2 | 60 min | Ambisonics aufnehmen: Mikrofone, A-to-B, Fieldrecording |
| Pause | 10 min |  |
| Block 3 | 40 min | Dateiformate: A-Format, B-Format, FuMa, ambiX, ACN/SN3D |
| Pause | 10 min |  |
| Block 4 | 30 min | Overall Workflow: von der Aufnahme bis zur Delivery |
| Pause | 10 min |  |
| Block 5 | 30 min | Live-Performance und Installation: System-Design, Max/MSP, OSC |
| Pause | 10 min |  |
| Block 6 | 55 min | Kompositorische Praxis: Raum, Bewegung, Csound, Hands-on |
| Abschluss | 15 min | Diskussion, Feedback, Ressourcen |

## Einstieg: Was kann HOA kompositorisch, was Stereo nicht kann?

Stereo organisiert Klang primaer auf einer Links-Rechts-Achse. HOA beschreibt dagegen ein Schallfeld um einen Hoerpunkt. Das macht Ambisonics nicht nur zu einer technischen Erweiterung, sondern zu einer anderen kompositorischen Denkweise.

**Szenenbasierung**  
Der gesamte Schallraum wird kodiert, nicht einzelne Lautsprecherfeeds. Das B-Format bleibt decoder-agnostisch.

**Elevation**  
HOA kann eine vollstaendige Kugel abbilden: oben, unten, hinten, vorne. Stereo kennt im Kern nur Links/Rechts.

**Skalierbarkeit**  
Der gleiche HOA-Stream kann heute binaural, morgen auf einem 24-Kanal-Array und spaeter in einem Dome dekodiert werden.

**Kontrapunkt**  
Unabhaengige Raumkurven pro Stimme ermoeglichen raeumliche Polyphonie ohne kanalbasiertes Uebersprechen.

Uebergang: Die Grundlage ist klar. Jetzt geht es direkt in die Praxis: zuerst der stabile Signalfluss.

## Block 1: How to work with and prepare for Ambisonics

45 min | Signalkette | Setup-Reihenfolge | Best Practices | Troubleshooting

Ziel: Die Logik des ICST-Workflows verstehen, bevor eine Session aufgebaut wird. Retrofitting von Routing ist eine der haeufigsten Fehlerquellen. Siehe dazu auch die [ICST Best Practices](/de/icst-ambisonics-plugins/15_best_practices/).

### Die Signalkette in einer Minute

| Pfad | Signalfluss |
|---|---|
| Grundkette | `Source -> Encoder -> Bformat Master -> Decoder -> Speakers` |
| Monitoring | `Bformat Master -> Binaural Decoder -> Kopfhoerer` |
| Export | `Bformat Master` solo rendern, nie den Decoder-Output |

- Ambisonics speichert kein Lautsprecherlayout, sondern eine Schallfeld-Repraesentation.
- Der Decoder projiziert das bereits kodierte Feld auf ein konkretes Setup. Er erzeugt den Raum nicht nachtraeglich.
- Der Bformat Master ist der zentrale HOA-Bus: stabil benennen, nicht ueberschreiben.
- Binaural-Monitoring und Lautsprecher-Decoder sind getrennte Pfade.

### HOA-Ordnung zuerst waehlen

| Ordnung | Kanaele | Typischer Einsatz |
|---|---:|---|
| 1st Order | 4 | Basis-Archivierung, kleine Setups, Einstieg |
| 3rd Order | 16 | Studio und Konzert, Empfehlung fuer viele Produktionen |
| 5th Order | 36 | Grosse Installationen, hoehere Aufloesung |
| 7th Order | 64 | Maximale Ordnung im ICST-System |

- Die Ordnung an das Lautsprecherarray anpassen. HOA7 auf einem 8-Kanal-Ring bringt keinen praktischen Vorteil.
- Ambisonics-Tracks im ICST-Workflow standardmaessig auf 64 Kanaele setzen, damit beim Routing kein stilles Channel-Dropping entsteht.

### Setup-Reihenfolge

1. Alle HOA-Tracks auf die korrekte Kanalzahl fuer die gewaehlte Ordnung setzen.
2. HOA-Bus und Decoder-Struktur anlegen.
3. Eine Quelle einfuegen und Routing end-to-end testen.
4. Decoder-Preset fuer das Lautsprecher-Setup laden und Lautsprecherreihenfolge verifizieren.
5. Binaural-Monitoring-Pfad separat einrichten.
6. Erst danach Automation, Recording und Rendering beginnen.

Die meisten vermeidbaren Fehler entstehen, wenn Decoder, Monitoring und Export schon veraendert werden, bevor Source, HOA-Bus und Decoder-Grundstruktur stabil sind.

### Routing-Disziplin

- Kein direkter Source-to-Master-Pfad: alle Quellen laufen ueber den HOA-Bus.
- Pegel an der Quelle korrigieren, nicht am Decoder-Output kompensieren.
- Das B-Format-Feld traegt raeumliche Information in seinen Amplitudenverhaeltnissen. Unerwartete Gain-Aenderungen verzerren das Klangbild.
- Decoder-Preset pruefen nach Preset-Wechsel, Lautsprecher-Setup-Aenderung oder Projekt-Reopen.
- Lautsprecher- und Binaural-Monitoring niemals unbeabsichtigt parallel laufen lassen.
- Exportfehler vermeiden: nicht vom Decoder-Output rendern, sondern vom Bformat Master.
- ambiX und FuMa Channel-Ordering nicht zwischen Produktion und Delivery verwechseln.

### Session-Hygiene

- Track-Namen konsistent halten: Source, HOA Bus, Decoder.
- Decoder-Presets, OSC-Ports und Export-Formate in Session Notes dokumentieren.
- OSC-Setups sind in der REAPER-Projektdatei oft nicht sichtbar genug. Sie muessen explizit dokumentiert werden.
- Versionen nummerieren: `project_v01.rpp`, `project_v02.rpp`.
- Templates nutzen: ICST Default-Template als Ausgangspunkt fuer neue Produktionen.
- Download-Pack: [REAPER Template + HOA Routing Checklist](/de/blog/download-pack-1-hoa-reaper-template/).

### Hands-on: Setup-Check

10 min

- ICST Default-Template laden und Signalfluss pruefen: Source -> HOA-Bus -> Decoder.
- Binaural-Monitoring verifizieren: Rotation-Test mit AmbiEncoder.
- Einen klassischen Routing-Fehler gezielt einbauen und diagnostizieren.

## Block 2: How to Record Ambisonics

60 min | Mikrofontypen | A-to-B-Konversion | Fieldrecording

Ziel: Ambisonics-Aufnahmen sicher planen und durchfuehren, von der Mikrofonposition bis zur sauberen B-Format-Datei. A-Format kommt vom Mikrofon und muss konvertiert werden. B-Format ist die Ambisonics-Szene fuer Produktion und Archiv. Eine Begriffsreferenz steht unter [Ambisonics-Formate](/de/learn/ambisonics-formats/).

### Mikrofonvergleich

| Mikrofon | Ordnung / Kanaele | Staerken | Einschraenkungen |
|---|---:|---|---|
| Sennheiser Ambeo VR | 1st Order / 4 ch | robust, weit verbreitet, guter Klang | FOA-Aufloesung |
| Rode NT-SF1 | 1st Order / 4 ch | guenstiger Einstieg, solide Qualitaet | FOA-Aufloesung |
| Zylia ZM-1 | 3rd Order / 19 ch | hohe Aufloesung | empfindlicher, teurer |
| EigenMike em32 | 4th Order / 32 ch | Referenz-HOA, Studio-Einsatz | hoher Aufwand |
| DPA d:mension | 1st Order / 4 ch | sehr linearer Klang, Musikaufnahmen | FOA-Aufloesung |

### A-to-B-Konversion

- A-Format sind Rohdaten der Kapseln, noch kein fertiges Ambisonics-Kugelformat.
- Die Konversionsmatrix kompensiert Kapselabstand, Frequenzgang und Phasenfehler.
- Geeignete Tools sind unter anderem Sennheiser Ambeo Orbiter, SoundField Ambisonic Toolkit oder eigene Matrizen in REAPER per JS-Plugin.
- Direkter B-Format-Output vereinfacht die Produktion, reduziert aber die Flexibilitaet in der Postproduktion.
- Qualitaetskontrolle: Phasen- und Kanalzuordnung testen, bevor Material archiviert wird.

### Fieldrecording-Workflow

- Vorab akustische Kartierung des Ortes: Reflexionen, Stoerquellen, begehbare Hoerzonen.
- Aufstellungshoehe etwa Ohrhoehe, also ca. 1.5 m, wenn eine immersive Hoerperspektive gewuenscht ist.
- Bei Aussenaufnahmen Doppelwindschutz und Suspension einplanen.
- Pegelmanagement: ca. -18 dBFS Zielpegel, 12 dB Headroom.
- Binaural waehrend der Aufnahme monitoren.
- Mehrfach-Takes aufnehmen: statisch und mit Bewegung.
- Metadaten direkt nach der Aufnahme notieren: Ort, Mikrofonposition, Wetter, Setup, Take-Nummer.

### Troubleshooting

- Kanalvertauschung: W/X/Y/Z oder ACN-Zuordnung vor Ort testen.
- Falsche A-to-B-Konversion: auf Kammfilter, instabile Richtung und spektrale Artefakte achten.
- Clipping auf einzelner Kapsel: alle Rohkanaele separat monitoren.
- Windgeraeusche: LF-Roll-off unter 80 Hz pruefen, ohne das Nutzsignal zu stark auszuduenne.

### Hands-on: Aufnahme-Simulation

20 min

- Vorhandene A-Format-Datei laden und A-to-B-Konversion durchfuehren.
- Kapsel- und Kanalzuordnung verifizieren.
- Ergebnis binaural abhoeren und raeumliche Kohaerenz beurteilen.
- Deliberate Error: falsche Kanalzuordnung erzeugen, Artefakt erkennen, beheben.

Reflexionsfrage: Welcher Schritt im Aufnahme- oder Konvertierungs-Workflow war bisher eine Blackbox?

## Block 3: Which File Formats

40 min | A-Format | B-Format | FuMa | ambiX | ACN/SN3D | FOA/HOA

Ziel: Dateiformate und Konventionen sicher einsetzen. Falsches Channel-Ordering klingt nicht einfach falsch, sondern oft nur seltsam.

### Warum "Format" in Ambisonics verwirrend ist

Das Wort Format bezeichnet mehrere Ebenen gleichzeitig:

- Rohoutput eines Mikrofons: A-Format
- internes Raumsignal in der DAW: B-Format
- Kanalreihenfolge: ACN oder FuMa
- Normalisierung der sphaerischen Harmonischen: SN3D, N3D oder FuMa
- Ambisonics-Ordnung und daraus folgende Kanalzahl

Die bessere Frage lautet also nicht: "Ist das B-Format?", sondern: "Ist das ambiX B-Format mit ACN-Ordering und SN3D-Normalisierung, und welche Ordnung?"

### A-Format vs. B-Format

**A-Format** ist das Rohsignal des Mikrofons vor raeumlicher Decodierung. Es ist mikrofon-spezifisch und kein fertiger Ambisonics-Master.

**B-Format** ist die Ambisonics-Signalrepraesentation fuer Produktion, Austausch, Decodierung und Archivierung. Es beschreibt ein Schallfeld um einen Hoerpunkt.

Praktische Regel: A-Format kommt vom Mikrofon und muss konvertiert werden. B-Format ist die raeumliche Szene.

### FuMa vs. ambiX

| Konvention | Bedeutung | Einsatz |
|---|---|---|
| FuMa | aeltere Konvention mit W, X, Y, Z und MaxN-artiger Normalisierung | Legacy, historisches Material, manche FOA-Tools |
| ambiX | moderne Austausch-Konvention: ACN Channel-Ordering + SN3D-Normalisierung | neue ICST-Produktionen, Austausch, Archiv |

ICST-Empfehlung: fuer neue Produktionen ambiX verwenden, also ACN Channel-Ordering und SN3D-Normalisierung.

### FOA vs. HOA

| Ordnung | Kanalzahl | Formel |
|---|---:|---|
| 1st Order / FOA | 4 | `(1 + 1)^2` |
| 2nd Order | 9 | `(2 + 1)^2` |
| 3rd Order | 16 | `(3 + 1)^2` |
| 5th Order | 36 | `(5 + 1)^2` |
| 7th Order | 64 | `(7 + 1)^2` |

Ambisonics ist szenenbasiert. Die Kanaele sind keine Lautsprecherfeeds. Derselbe B-Format-Master kann fuer Dome, Oktagon, Studio-Array, Kopfhoerer oder Stereo gerendert werden.

### Export: welches Format wann?

- ambiX B-Format verwenden, wenn eine neue Produktion gestartet, mit modernen HOA-Tools gearbeitet oder ein Archiv-Master exportiert wird.
- A-Format nur fuer Rohaufnahmen vor der A-to-B-Konversion verwenden.
- FuMa nur verwenden, wenn ein aelteres Tool es explizit erfordert oder historisches Material konvertiert wird.
- Immer dokumentieren: Ordnung, Kanalzahl, Channel-Ordering, Normalisierung, Sample Rate, Bit Depth.

### Hands-on: Format-Audit

15 min

- Unbekannte WAV-Datei oeffnen: Kanalzahl, Ordering und Normalisierung identifizieren.
- FuMa nach ambiX konvertieren und in REAPER laden.
- Binaural-Render exportieren und HRTF-Auswahl vergleichen: Genelec SAM, KEMAR oder individualisierte SOFA-Files.

## Block 4: Overall Workflow

30 min | Von der Aufnahme bis zur Delivery

Ziel: Den Produktionsprozess als zusammenhaengende Kette verstehen. Jede Entscheidung frueh im Prozess beeinflusst spaetere Schritte.

### Der vollstaendige Produktionsprozess

| Aufnahme | Konversion | Komposition | Mix | Decode | Delivery |
|---|---|---|---|---|---|
| A-Format WAV | A-to-B / ambiX | REAPER + ICST | HOA-Bus, FX | Binaural / Array | WAV, Binaural, YouTube |

### Export und Rendering

- Bformat Master solo rendern, nie den Decoder-Output.
- Sample Rate: 48 kHz, bei grossen Multichannel-Dateien Wave/RF64 verwenden.
- Kanalzahl zur HOA-Ordnung passend setzen: 4, 9, 16, 25, 36, 49 oder 64.
- ambiX-Konvention verwenden, ausser das Zielsystem erfordert FuMa.
- Dateinamen sprechend halten: `scene01_O3_take02.wav`.
- Zuerst eine kurze Test-Datei rendern, re-importieren und per Decoder oder Binaural-Pfad verifizieren.

Vorgeschlagener Meta-Text fuer REAPER Project Notes:

```text
Render: B-format master | Format: ambiX (ACN/SN3D) | SR: 48000 Hz | Channels: 16 | HOA: 3rd | Monitoring: Binaural OK / Array OK
```

### Monitoring und Verifikation

- Jede Session mit einer einzelnen Mono-Testquelle auf bekannter Encoder-Position starten.
- Bewegung, Pegel und Lautsprecherzuordnung vor dem Arbeiten pruefen.
- 30-Sekunden-Signalcheck vor jeder Aufnahme oder jedem Export.
- Downmix-Check: B-Format auf Mono oder Stereo falten und pruefen, ob wichtige Quellen hoerbar bleiben.

### Delivery-Formate

| Delivery | Format | Tool | Anmerkung |
|---|---|---|---|
| Archiv / Master | Multichannel WAV/RF64, ambiX, 48 kHz / 32-bit float | REAPER Render | unveraenderter Bformat Master |
| Binaural Stereo | 2-Kanal WAV | AmbiHeadphone oder IEM BinauralDecoder | Streaming, Preview, Kopfhoerer |
| Lautsprecher-Stems | N-Kanal WAV | ICST Decoder mit Array-Preset | Auffuehrung, Installation |
| YouTube 360 | binaural/spatial metadata workflow | Spatial Media Metadata Tool | nach Zielplattform pruefen |
| Streaming | 2-Kanal binaural | DAW Render | maximale Kompatibilitaet |

## Block 5: Live-Performance und Installation

30 min | System-Design | Max/MSP | OSC | Lautsprecher-Arrays

Ziel: HOA-Systeme fuer Echtzeit-Kontexte konzipieren. Buehne, Club und Galerie haben andere Prioritaeten als Studio und Postproduktion: Latenz, Robustheit und Flexibilitaet.

### System-Design

- Kernfrage: Wer decodiert wo? Laptop on stage, FOH-System oder dedizierter Render-Rechner?
- Latenz: HOA-Encoding und Decoding sind meist nicht das Problem, aber die Gesamtkette muss getestet werden.
- Robustheit: Backup-Binaural-Mix bei Array-Ausfall einplanen.
- Monitoring: Performer:innen brauchen oft einen anderen Hoerpfad als FOH.
- Lautsprecherarray-Geometrie: Ring, Dome, Sphere oder irregulaeres Array.
- ICST AmbiDecoder: Lautsprecherlayout als Preset laden und ohne Projektumbau austauschen.
- Irregular Arrays: AllRADecoder aus der IEM Suite pruefen.

### Max/MSP fuer Live-HOA

- ICST Externals wie `ambienc~`, `ambidec~` und `ambipan~` direkt im Performance-Patch verwenden.
- Typischer Signalfluss: Audio-Input -> `ambienc~` mit Azimut/Elevation -> `ambidec~` -> Multichannel-Out.
- OSC-Steuerung: Raumparameter ueber Netzwerk, Tablet, Sensor oder zweiten Performer steuern.
- Zufallsbewegung live: `drunk`, `noise~` oder `cycle~` auf Raumparameter.
- Granular- und Freeze-Strukturen vor dem Encoder platzieren und anschliessend raeumlich fuehren.
- Backup-Strategie: automatischer oder manueller Fallback auf Binaural.

### Installation

- Dauerbetrieb testen: Patch muss stundenlang stabil laufen.
- Sensorik: Kamera, Bewegungsmelder oder Ultraschall auf HOA-Panning mappen.
- Mehrere Hoerzonen: verschiedene Decoder-Outputs fuer verschiedene Raumbereiche.
- Galerie-Kontext: binaurale Kopfhoererstation als zusaetzlicher Zugang.
- Dokumentation: HOA-Master archivieren, damit die Installation auf anderem System re-deploybar bleibt.

| Kontext | Prioritaeten | Empfohlene Tools |
|---|---|---|
| Konzert / Buehne | Latenz, Robustheit, FOH-Kompatibilitaet | Max/MSP + ICST + REAPER Backup |
| Club / Electronic | Echtzeit-Panning, Interaktion, Beat-Sync | Max/MSP + OSC + Ableton Link |
| Galerie / Installation | Dauerbetrieb, Sensorik, mehrere Zonen | Max/MSP + Binaural-Station |
| Hybrid Studio/Live | Produktion + Performance | REAPER als Recorder, Max als Spatializer |

## Block 6: Kompositorische Praxis

55 min | Raum als Material | Bewegung | Csound | Hands-on

Ziel: Raeumliche Parameter nicht als technische Notwendigkeit, sondern als kompositorisches Ausdrucksmittel einsetzen. Werkzeuge: REAPER, Max/MSP und Csound, je nach Workflow der Teilnehmenden.

### Raum als kompositorisches Material

- Ambisonics bildet Schallfelder ab: nicht nur Positionen, sondern Szenen.
- Azimut: horizontale Bewegung, Rotation, Kreisen.
- Elevation: dramaturgisches Heben und Senken.
- Tiefe / Distanz: Near/Far durch Pegel, Hallanteil und Spektrum.
- Statik ist ebenfalls eine Entscheidung: ruhende Quelle und Bewegung koennen kontrastieren.
- Referenzen: Natasha Barrett, Luigi Nono, Francois Bayle.

### Bewegung als Kompositionsmittel

- Trajektorien: linear, kreisfoermig, chaotisch, atembasiert.
- Geschwindigkeit: langsame Bewegung ist nicht statisch, sondern kann Spannung erzeugen.
- Akzelerando und Rallentando im Raum als agogische Bewegungsparameter.
- Automation in REAPER: Azimut, Elevation und Radius als separate Kurven.
- Zufallsbewegung: LFO oder generativer Prozess auf Azimut und Elevation.
- Synchronisation: Bewegung mit Rhythmus koppeln oder bewusst dagegen setzen.

### Raeumlicher Kontrapunkt

- Unabhaengige Stimmen erhalten unabhaengige Raumkurven.
- Konsonanz im Raum: Quellen konvergieren auf eine Position.
- Dissonanz im Raum: Quellen bewegen sich auseinander oder kreuzen sich.
- Textur vs. Linie: diffuse Klangfelder gegen gefuehrte Einzelstimmen setzen.
- Uebung: drei Quellen mit drei unabhaengigen Raumkurven, ohne Kollision.

### Mixing-Strategien

- Tiefenstaffelung: EQ vor Encoder, Entfernung durch LPF und AmbiReverb-Anteil gestalten.
- Wet/Dry pro Quelle setzen: nahe Quellen trockener, ferne Quellen nasser.
- Binaural und Array immer beide abhoeren, weil sie unterschiedlich reagieren.
- Mono-Downmix nach jeder Session kontrollieren.

### Max/MSP und Csound

Voraussetzung: Max/MSP mit ICST Externals oder Csound + Cabbage. REAPER-only-Teilnehmende arbeiten mit einem vorbereiteten REAPER-Template.

**Max/MSP + ICST Externals**

- `ambienc~`, `ambidec~`, `ambipan~` im Package Manager installieren.
- Signalfluss: Mono-Source -> `ambienc~` -> HOA-Bus -> `ambidec~` -> Multichannel-Out.
- Generatives Panning mit `drunk`, `line~`, `cycle~` auf Azimut und Elevation.
- OSC-Input oder Sensor-Daten direkt auf Raumparameter mappen.
- REAPER als Recorder/Mixer verwenden, Max als Spatializer.

**Csound direkt in REAPER via Cabbage**

- Cabbage kompiliert Csound-Instrumente als VST3/AU.
- Csound-Orchestra in Cabbage schreiben, als VST in REAPER laden und ohne externes Routing arbeiten.
- Zugriff auf Csound-Opcodes wie `bformenc1` und `bformdec1`.
- Typischer Workflow: Cabbage-Patch mit `bformenc1`, VST auf 16-Kanal-Track laden, Output auf HOA-Master-Bus routen.
- Score-basierte Komposition: Raumposition als p-Felder in der Note-Zeile.
- Algorithmische Bewegung: Csound-Funktionen definieren Trajektorien.

| Tool | Integration | Staerken | Typischer Einsatz |
|---|---|---|---|
| REAPER + ICST | nativ | Mixing, Automation, Postproduction | Studio, Unterricht, Produktion |
| Max/MSP + ICST | Audio-Routing | Live-Performance, generatives Panning, Interaktion | Buehne, Installation |
| Csound + Cabbage | VST3 in REAPER | algorithmische Komposition, Score-basiert, HOA-Synthese | Komposition, Experiment |
| Csound CLI + REAPER | offline | Batch-Rendering, Nicht-Echtzeit-Produktion | Render-Pipelines |

### Hands-on: Kompositorische Miniatur

30 min

Vorbereitete Templates: REAPER-Session mit drei Quellen, Max/MSP-Patch mit `ambienc~`, Cabbage-VST mit `bformenc1`. Teilnehmende waehlen ihr Tool.

| Zeit | Aufgabe |
|---:|---|
| 0-5 min | Template laden und Signalfluss verifizieren |
| 5-15 min | Raumkurven entwerfen: jede Quelle bekommt eine eigene Trajektorie |
| 15-22 min | Tiefenstaffelung mit EQ und Hall aufbauen |
| 22-27 min | Binaural-Render exportieren oder Live-Output abhoeren |
| 27-30 min | Gegenseitiges Abhoeren: Was wirkt raeumlich ueberzeugend, und warum? |

## Abschluss und Ressourcen

15 min

- Was war neu, was hat sich bestaetigt?
- Welche Luecken bleiben?
- Welche eigenen Projekte lassen sich direkt mit dem Gelernten weiterentwickeln?

### Weiterfuehrende Ressourcen

- [ambisonics.ch](https://ambisonics.ch/) - Tutorials, Best Practices, Formats, Render Guide
- [Ambisonics-Formate](/de/learn/ambisonics-formats/) - A-Format, B-Format, ambiX, FuMa
- [Best Practices](/de/icst-ambisonics-plugins/15_best_practices/) - Setup-Regeln und Troubleshooting
- [B-Format in REAPER rendern](/de/icst-ambisonics-plugins/12_render_bformat/) - Export-Guide
- [Download Pack #1](/de/blog/download-pack-1-hoa-reaper-template/) - REAPER Template und HOA Routing Checklist
- [ICST Ambisonics Plugins](/de/icst-ambisonics-plugins/) - Plugin-Dokumentation fuer REAPER und Max/MSP
- [Cabbage Audio](https://cabbageaudio.com/) - Csound als VST3/AU
- OpenAIR / SOFA-HRTF-Libraries - HRTF-Files fuer individualisierte binaurale Renderer
