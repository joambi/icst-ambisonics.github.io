---
title: "Formate, Stems und Archivierung"
description: "B-Format-Archivierungskonventionen, Stem-Struktur und Lieferformate für Festivals, Labels, Streaming und Langzeiterhaltung."
date: 2026-01-01T00:00:00
weight: 84
draft: true
translationKey: "composing-formats-archiving"
languageCode: de
---

Das Abschliessen einer Ambisonics-Komposition stellt sofort eine praktische Frage: Was liefert man tatsächlich, und an wen? Die Antwort hängt vom Kontext ab — Festival-Aufführung, Label-Veröffentlichung, Streaming-Plattform oder Langzeitarchiv — und jeder Kontext erfordert ein anderes Format oder eine Kombination. Das von Beginn an richtig zu machen vermeidet aufwändige Re-Exporte und stellt sicher, dass das Werk auch in Zukunft zugänglich und dekodierbar bleibt.

> [!note]
> Diese Seite konzentriert sich bewusst auf den **ICST- bzw. B-Format-zentrierten Workflow** und die häufigsten daraus abgeleiteten Lieferwege. Themen wie **ADM/BWAV**, **MPEG-H**, plattformspezifische Streaming-Pipelines oder die Integration in **Game-Engines** werden hier nur angerissen oder auf externe Ressourcen ausgelagert. Wer ein wirkliches **„All-formats“-Howto** für Broadcast, Streaming, VR und interaktive Medien sucht, muss ergänzend recherchieren.

### Externe Einstiege

- **Ambisonics zu ADM / Atmos-Delivery**: [Von der Ambisonics-Szene zum Atmos Bed – Methodik und Werkzeuge](/post/ambisonics-to-atmos-bed/)
- **ADM / BWAV / ADM in BW64**: [EBU ADM Guidelines](https://adm.ebu.io/) und [ITU-R BS.2076 Audio Definition Model](https://www.itu.int/rec/R-REC-BS.2076/)
- **MPEG-H Audio**: [Fraunhofer IIS – MPEG-H Überblick](https://www.iis.fraunhofer.de/en/ff/amm/broadcast-streaming/mpegh.html)
- **Unity / Ambisonics**: [Unity Manual – Ambisonic Audio](https://docs.unity.cn/Components/AmbisonicAudio.html)
- **Unreal Engine / Ambisonics**: [Epic-Dokumentation – Ambisonics](https://dev.epicgames.com/documentation/en-us/unreal-engine/ambisonics)

## Das B-Format-Master: Der archivalische Kern

Die wichtigste Datei, die erhalten werden muss, ist das **B-Format-Master** — das enkodierte Ambisonics-Signal vor jeder Dekodierung oder jedem Downmix. Dies ist die formatunabhängige Archivversion, aus der jedes zukünftige Wiedergabeformat abgeleitet werden kann: Lautsprecherarrays beliebiger Geometrie, Binaural-Stereo, Stereo-Downmix oder Formate, die noch nicht erfunden wurden.

### AmbiX vs. FuMa

Zwei Konventionen existieren für die Speicherung von B-Format-Signalen in Audiodateien:

| Konvention | Kanalreihenfolge | Normalisierung | Status |
|------------|-----------------|----------------|--------|
| **AmbiX** | ACN (W, Y, Z, X, …) | SN3D | Aktueller Standard für HOA-Austausch und Archivierung; verwendet von IEM, SPARTA, YouTube 360 und vielen Ambisonics-Toolchains |
| **FuMa** | W, X, Y, Z, … | MaxN | Legacy; verwendet in älteren Cycling '74- und SuperCollider-Tools |

**Immer in AmbiX archivieren.** FuMa-Unterstützung nimmt ab und viele moderne Tools erkennen es nicht mehr. Wenn Material in FuMa vorliegt, vor der Archivierung mit dem IEM MultichannelConverter oder dem `ambix_converter`-Dienstprogramm in AmbiX konvertieren.

### HOA-Ordnung und Kanalanzahl

Die Kanalanzahl in einer B-Format-Datei hängt von der Ambisonics-Ordnung ab:

| Ordnung | Kanäle (3D) | Kanäle (2D) |
|---------|------------|------------|
| 1. (FOA) | 4 | 3 |
| 2. | 9 | 5 |
| 3. | 16 | 7 |
| 5. | 36 | 11 |
| 7. | 64 | 15 |

In der **höchsten während der Produktion verwendeten Ordnung** archivieren. Das Herunterrechnen auf eine niedrigere Ordnung verliert räumliche Auflösung dauerhaft; das Hochrechnen fügt keine Information hinzu. Wurde das Stück in 3. Ordnung produziert, werden 16 Kanäle archiviert — keine Reduktion auf 4 Kanäle aus Speicherbequemlichkeit.

### Dateiformat und technische Spezifikationen

- **Container**: WAV (Broadcast WAV / BWF empfohlen für eingebettete Metadaten) oder AIFF
- **Bittiefe**: mindestens 24-Bit; 32-Bit Float erhält Headroom und verhindert Clipping während der Verarbeitung
- **Samplerate**: 48 kHz (Broadcast-/Filmstandard) oder 96 kHz (High-Resolution Audio); 44,1 kHz für Spatial-Audio-Master vermeiden
- **Metadaten**: AmbiX-Kanalreihenfolge-Tag wo möglich in die Datei-Metadaten einbetten; README oder Sidecar-Textdatei mit Konvention, Ordnung und Normalisierung beilegen

## Stems

Ein vollständiges Stem-Paket dokumentiert die kompositorischen Schichten und ermöglicht zukünftigen Remix, Respatialisation für andere Aufführungsorte oder archivalische Rekonstruktion. Eine typische Ambisonics-Stem-Struktur umfasst:

**Quell-Stems** (vor der Spatialisation):
- Einzelne trockene oder leicht bearbeitete Mono-/Stereo-Quellen, nach Instrument oder Schicht beschriftet
- Nützlich für Respatialisation, wenn der Zielort erheblich vom Produktionskontext abweicht

**Spatial-Bus-Stem**:
- Der enkodierte B-Format-Mix aller spatialisierter Quellen, ohne Master-Processing (kein Limiting, keine Bus-EQ)
- Dies ist das primäre kreative Dokument der während der Produktion getroffenen Raumgesten-Entscheidungen

**Master-B-Format-Stem**:
- Der endgültige B-Format-Output mit allem angewendeten Master-Processing
- Die Datei, die an einen Decoder gesendet wird oder als Basis aller Formatableitungen dient

**Abgeleitete Liefer-Stems**:
- Binaural-Stereo (mit dokumentierter HRTF)
- Mehrkanal-Lautsprecher-Renders (siehe unten)
- Stereo-Downmix

Nicht alle Kontexte erfordern alle Stems. Wenn der Aufführungsort oder das Studio **vor Ort dekodiert**, ist das Master-B-Format oft ausreichend. Wenn eine **direkt abspielbare Mehrkanal-Datei** geliefert werden muss, wird ein vorab dekodierter Render notwendig. Für Label-Lieferung oder institutionelle Archivierung ist der vollständige Stem-Baum gute Praxis.

## Konzert- und Festival-Lieferung

Festivals und Konzertsäle arbeiten meist in einem von zwei Modi:

- **Dekodierung vor Ort**: Künstler:in liefert ein B-Format-Master, der Veranstaltungsort dekodiert selbst
- **Vorab dekodierte Wiedergabe**: Künstler:in liefert einen Mehrkanal-Render passend zum exakten Lautsprecherlayout

In vielen praktischen Festival-Situationen ist die **vorab dekodierte Mehrkanal-Datei** die sicherere Variante, besonders wenn vor Ort kein verlässlicher HOA-Decoding-Workflow vorhanden ist. Häufige Konfigurationen:

| Format | Kanalanzahl | Hinweise |
|--------|------------|---------|
| Ring 8 | 8 | Häufig in kleineren Venues; vorab aus B-Format dekodieren |
| Ring 16 | 16 | Mittelgrosse Konzertsäle; typisches ICST-Setup |
| Ring 24 | 24 | Grossmasstäbliche Festival-Systeme (Acousmonium-Stil) |
| Dome 24–32 | 24–32 | 3D-Dome mit erhöhten Lautsprechern |
| Individuell | variabel | Immer die genaue Layout-Datei des Venues anfordern |

**Workflow**: Layout-Datei des Venues anfordern (typischerweise eine `.json`- oder `.txt`-Datei mit Azimut/Elevation/Abstand pro Kanal), in den ICST Ambisonics Plugins Decoder oder IEM AllRADecoder laden, offline auf mehrkanal WAV rendern und liefern.

**Kanalreihenfolgen-Konventionen**: mit dem Venue bestätigen, ob Standard-Interleaved-Kanalreihenfolge oder ein individuelles Mapping verwendet wird. Eine falsch beschriftete Kanalreihenfolge kann im Konzert zu invertierten oder rotierten räumlichen Bildern führen — immer einen technischen Check vor der Uraufführung anfordern.

**Dateibenennung**: ein klares Benennungsschema verwenden, z.B.:
```
StückTitel_24ch_ring_48k24b.wav
StückTitel_binaural_KU100_48k24b.wav
StückTitel_ambiX_3OA_48k32f.wav
```

## Streaming und Online-Vertrieb

Online-Plattformen behandeln Spatial Audio unterschiedlich:

| Plattform | Format | Hinweise |
|-----------|--------|---------|
| YouTube 360 | AmbiX FOA (4ch) oder Spatial-Audio-Metadaten | Erfordert spezifischen Upload-Workflow; YouTube wendet eigene Binaural-Dekodierung an |
| Apple Music / Spatial Audio | Dolby Atmos ADM/BWF | Erfordert Atmos-Authoring-Tools; Drittanbieter-Encoder können aus HOA konvertieren |
| Bandcamp / SoundCloud | Nur Stereo | Binaural-Stereo-Master liefern |
| Streaming (allgemein) | Stereo | –14 LUFS integriert; –1 dBTP True Peak |

Für viele Label- und Streaming-Releases auf Plattformen, die **keine immersiven Master direkt annehmen**, ist ein **Binaural-Stereo-Master** das praktische Vertriebsformat. Wo eine Plattform ein immersives Lieferformat wie **Dolby Atmos ADM/BWF** verlangt, muss dieses plattformspezifische Master separat vorbereitet werden. Die verwendete HRTF dokumentieren und angeben, ob die binaurale Datei ausschliesslich für Kopfhörerwiedergabe bestimmt ist.

## Label- und Verlags-Lieferung

Bei der Lieferung an ein Label für eine Fixed-Media-Veröffentlichung:

- **B-Format-Master** als archivalische Quelle bereitstellen (Label behält es für zukünftige Wiederveröffentlichungen)
- **Binaural-Stereo-Master** als primäres Releaseformat für Streaming bereitstellen
- **Stereo-Downmix** für Kompatibilität mit Plattformen bereitstellen, die kein Binaural-Tagging unterstützen
- **Technisches Datenblatt** beilegen mit: Ambisonics-Ordnung, Normalisierungskonvention, verwendete HRTF für Binaural, Samplerate, Bittiefe und verwendete Softwareversionen

Viele Labels, die mit Spatial Audio arbeiten, bauen ihre Archivierungspraxis noch auf. Ein klares technisches Datenblatt hilft sicherzustellen, dass das Werk korrekt erhalten wird.

## Langzeitarchivierung

Ambisonics-Formate haben sich bereits gewandelt (FuMa → AmbiX) und werden sich wahrscheinlich erneut ändern. Für institutionelle oder persönliche Langzeitarchive:

- **B-Format-Master in AmbiX** als primäre Archivdatei speichern
- **Quell-Stems** separat und klar beschriftet speichern
- **README** in Plaintext mit allen technischen Parametern beilegen
- **Dekodierten Lautsprecher-Render** (z.B. 8-Kanal-Ring) als sekundäres Archivformat vorhalten — dieser ist unmittelbar abspielbar, auch wenn sich die Dekodier-Tools der Zukunft verändert haben
- **Binaural-Stereo-Version** als zugänglichste langfristige Hörkopie speichern

Software, Plugins und Betriebssysteme ändern sich. Ein roher B-Format-WAV mit einem Plaintext-README ist dauerhafter als eine Projektdatei, die von einer bestimmten Plugin-Version abhängt.

## Checkliste

Vor dem Abschluss eines Projekts:

- [ ] B-Format-Master exportiert in voller Produktions-Ordnung (AmbiX, 24-Bit oder 32-Bit Float, 48 kHz+)
- [ ] Quell-Stems exportiert und beschriftet
- [ ] Binaural-Stereo-Master exportiert, HRTF dokumentiert
- [ ] Stereo-Downmix exportiert
- [ ] Mehrkanal-Render für primären Aufführungsort exportiert
- [ ] Technisches Datenblatt geschrieben (Ordnung, Normalisierung, HRTF, Software, Samplerate, Bittiefe)
- [ ] Alle Dateien an mindestens zwei Orten gesichert
