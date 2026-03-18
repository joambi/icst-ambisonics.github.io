---
title: Schritt-für-Schritt-Setup
weight: 50
date: 2025-01-23T15:38:00
---

# Schritt-für-Schritt-Setup-Anleitung für die ICST AmbiPlugins in Reaper

---
### Voraussetzungen

Bevor du startest, stelle sicher, dass **Reaper**, die **ICST Ambisonics Plugins** und alle empfohlenen **Drittanbieter-Plugins** installiert sind.

> [!Important]
> Empfohlene Basis vor dem Start:
> - Reaper-Projekt-Samplerate: **48 kHz**
> - Alle Ambisonics-Spuren auf **64 Kanäle**
> - ICST-Plugin-Set installiert und im FX-Browser sichtbar
> - Ausgangszuordnung des Audio-Interfaces geprüft

### Reaper-Vorlage erstellen

Wir erstellen die Vorlage Schritt für Schritt von oben nach unten.

#### 1. Reaper vorbereiten

1. Öffne eine **neue, leere Reaper-Session**.
   ![empty_reaper](empty_reaper.png)
2. Erstelle eine neue Spur (**Doppelklick** oder über das Menü).
3. Benenne die Spur **Decoder** und entferne den Master-Bus.
   ![01_dec](01_Decoder_A.gif)

> [!Tip]
> Erstelle alle Spuren standardmäßig mit **64 Kanälen** und achte auf das Routing.

#### 2. Decoder-Routing einrichten

Decoder-Routing für ein Oktagon-Setup:
- **Eingänge:** 64 Kanäle vom **Bformat Master**
- **Ausgänge:** 8 Kanäle zum Audio-Interface

1. Öffne den **ICST AmbiPlugins Decoder** im **FX-Fenster**.
   ![open__FX_decoder](FX_Decoder.png)
2. Öffne den AmbiDecoder.
   ![open_decoder](open_decoder.gif)
3. Wähle ein **Lautsprecher-Preset** (z. B. Oktagon).
   ![open_dec](choose_dec_preset.gif)
4. Passe die AmbiDecoder-Einstellungen an:
   - Ambisonics-Gewichtung
   - Ambisonics-Ordnung (1. bis 7. Ordnung)
   ![Dec-setting](7_choose_dec_setting.gif)
5. Führe einen Lautsprechertest durch:
   - Nutze die Schaltfläche **Lautsprechertest** oder prüfe einzelne Lautsprecher.
   ![speaker_test](speaker_test.png)

> [!Warning]
> Achte auf den Ausgangspegel.

> [!Tip]
> **Routing-Schnellcheck (20 Sek.):**
> 1. Sende Rosa Rauschen oder ein Testsignal in den Bformat Master.
> 2. Prüfe Pegelaktivität am Decoder-Eingang.
> 3. Starte den Lautsprechertest und verifiziere die physische Kanalreihenfolge.

#### 3. Bformat-Masterspur erstellen

Erstelle die Spur **Bformat Master**:

![02_BF-Master | 700](02_BF-Master.gif)

- Diese Spur empfängt Signale von:
  - Ambience Encodern
  - B-Format-SFX
  - B-Format-Playern
- Sie ist der zentrale Aufnahme- und Render-Punkt für das finale **B-Format**.
- Empfohlen: Spurfarbe **rot**.
- Route zur **AmbiDecoder**-Spur und parallel zu einer **Binaural-Monitor**-Spur.

#### 4. Bformat-Player-Spur erstellen

- Erstelle eine **64-Kanal-Spur** und route sie in den **Bformat Master**.

![bformat-player](bformat-player.png)

> [!Tip]
> So kannst du **B-Format-Dateien von der 1. bis zur 7. Ordnung** abspielen.

#### 5. Binaurales Monitoring aktivieren

- Erstelle eine neue **64-Kanal-Spur** und lade ein **binaurales Plugin** (z. B. _DearVR Ambi Micro.vst3_).
- Verschiebe die Spur nach oben in deinem Reaper-Projekt.
- Route den **Ausgang vom Bformat Master** auf diese Binaural-Spur.
- Stummschalte den **AmbiDecoder**, wenn du nur binaural hören willst.

![Binaural-track](Binaural_Track.gif)
![DearVR_binaural](DearVR_binaurl.png)

> [!Tip]
> Vergleiche die Wiedergabe per **Solo/Stumm** zwischen AmbiDecoder und Binaural-Decoder.

![1.order_bf](first-order.png)
Beispiel B unten zeigt eine B-Format-Datei in 5. Ordnung:

![5th-order_bf](5th-order-bf.png)
Jetzt kannst du B-Format über Lautsprecher oder Kopfhörer kontrollieren.

### Namenskonvention (empfohlen)

Nutze früh stabile Spur-Namen, um Routing-Fehler zu vermeiden:
- `DECODER`
- `BFORMAT_MASTER`
- `BINAURAL_MONITOR`
- `SRC_01` ... `SRC_08`
- `MULTIENCODER_8SRC`

### 6. Mono-Quelle und Ambisonics Encoder

- Erstelle eine neue Spur **Mono-Quelle** und lade eine Mono-Audiodatei.

Tip: Sieh dir dieses [Video](https://www.youtube.com/watch?v=aDa-vNWriLM&t=119s) an.

Mono-AmbiEncoder-Überblick:
![open monoencoder](MonoEncoder_01.png)
![open_MonoEncoder](MonoEncoder_load.png)

- Lade im FX-Fenster den **ICST MonoEncoder**.
- Füge einen **AmbiEncoder (ICST)** (1-4) zur Mono-Quelle hinzu.

Routing:
- MonoEncoder -> 64-Kanal-Ausgang -> Bformat Master

![MonnoEncoder](MonoEncoder.png)

#### 7. Bewegungen in Reaper aufnehmen

Bewegungen im MonoEncoder aufnehmen:
![rec_xyz](rec_xyz.gif)

Gespeicherte Bewegung abspielen:
![play_xyt](play_xyz.gif)

### 8. Multi-Encoder verwenden

Im nächsten Beispiel nutzen wir den **Multi-Encoder**:

1. **Multi-Encoder-Spur einfügen**

   - Rechtsklick in einen leeren Spurbereich und **Spur aus Vorlage einfügen** wählen.
   - Zu **ICST AmbiPlugins** navigieren und **ICST_AmbiEncoder_Multi_8src** wählen.
   - Dadurch öffnet sich ein Multi-Encoder mit **8 Monoquellen**, bereits geroutet.

   ![MultiEncoder_routing | 550](MultiEncoder_routing.png)

2. **Quellen im Multi-Encoder steuern**

   - Wenn das Routing korrekt ist, kannst du die **Position und Bewegung** von bis zu **8 Quellen** steuern.

### AmbiEncoder-Einstellungen

3. **AmbiEncoder-Einstellungen verstehen**

- Die AmbiEncoder-Einstellungen sind zentral für den Workflow.
- Das folgende GIF zeigt wichtige Funktionen:

![Enc_Settings](Enc_Settings.gif)

> [!Tip]
> Sieh dir das AmbiEncoder-[Video-Tutorial](https://www.youtube.com/watch?v=aDa-vNWriLM&t=31s) für mehr Details an.

4. **ICST-Distanzfunktion**

- Ein besonderes Merkmal des **ICST Ambisonics Encoders** ist die **Distanzfunktion**, entwickelt von **Martin Neukom** am ICST.
- Sie ermöglicht verschiedene räumliche Konfigurationen mit sehr schnellen bis sehr langsamen Bewegungen.

![Distanc_overview](Distance.gif)

Für detaillierte Anleitungen siehe das **Distance-Tutorial**.

> [!Tip]
> Wenn du mit **Distanz** arbeitest, definiere sie zu Projektbeginn, damit die **XYZ-Skalierung** konsistent bleibt (Beispiel: `0.0` bis `1.0`).

### Aufnahme und Bearbeitung von Quellbewegungen

> [!Tip]
> **Kurzleitfaden zu Automationsmodi:**
> - **Write (Schreiben):** überschreibt komplett (ideal für den ersten Take)
> - **Touch (Berühren):** schreibt nur während der aktiven Berührung
> - **Latch (Halten):** schreibt nach erster Berührung bis Stop
>
> Für saubere Ergebnisse: erst in **Write (Schreiben)** aufnehmen, dann in **Touch (Berühren)** verfeinern.

5. **Bewegungen im Multi-Encoder aufnehmen**

Zum Verständnis der Multi-Encoder-Logik:
- Setze die Automationskurven auf **Write (Schreiben)**.
- Drücke **Play** (Leertaste) und bewege **Src_1** im Multi-Encoder-Radar.
- Wiederhole das für weitere Quellen.

![MultiEnc_01_write](MultiEnc_01_write.gif)
Beispiel mit **Src_3**:
![Encoder_move_03](Move_03.gif)

Im nächsten Schritt bearbeitest du XYZ-Kurven manuell:
![Manuel_edit](MultiEnc_Manuell_edit.gif)

6. **XYZ-Kurven manuell bearbeiten**

- Für feinere Bewegungen bearbeite die **XYZ-Kurven** manuell.
- Halte **Shift** und klicke auf eine Kurve, um einen neuen Punkt zu erstellen.
- Verschiebe den Punkt, um XYZ-Koordinaten anzupassen.

7. **Aufgenommene Ambisonics-Szene abspielen**

![MultiEnc_plays_scene](play_multienc.gif)

### Arbeiten mit Gruppen

8. **Gruppe im Multi-Encoder erstellen**

- Wähle im **Radar-Display** mehrere **Src-Punkte**, um eine Gruppe zu bilden.
- Vergib einen **Gruppennamen** (z. B. **G1**).

![create_a_GP](GP_select_scaled.png)
![GP_name](GP_edit_scaled.png)

9. **Gruppenbewegungen aufnehmen**

- Wähle einen Aufnahmemodus:
  - **Latch (Halten):** schreibt nach erster Berührung
  - **Touch (Berühren):** schreibt nur während Berührung
  - **Write (Schreiben):** überschreibt vorhandene Automation

![Rec_GP](Rec_GP.gif)

10. **Wiedergabe und Bewertung**

![Play_GP](play_GP.gif)

- Höre die finale Gruppenbewegung über **Lautsprecher (Decoder)** oder **Kopfhörer (binauraler Decoder)**.

### Finalisieren und Export

Für einen kompakten eigenständigen Render-Leitfaden siehe [B-Format in REAPER rendern](/icst-ambisonics-plugins/12_render_bformat/).

### Pre-Render-Checkliste

Vor dem Rendern prüfen:
- **Bformat Master** ist auf Solo
- Ambisonics-Format/Ordnung passt zur Ziel-Pipeline
- Kein unbeabsichtigter Limiter/Kompressor im Master-Pfad
- Dateiname enthält Ordnung und Take-Nummer (Beispiel: `scene01_O5_take03.wav`)

11. **Bformat Master rendern**

Wenn alles passt:
- Spur **Bformat Master** auf **Solo** setzen
- **Menü > Rendern** öffnen

**Render-Einstellungen:**

![Render_Master | 200](render-master.png)

1. **Spur wählen (Stem-Render)** -> **Bformat Master**
2. **Dateiname** -> B-Format-Dateinamen vergeben
3. **Abtastrate** -> **48,000 Hz**
4. **Kanäle** -> 64 (für **Ambisonics 7. Ordnung**)
5. **Mehrkanalformat** -> **Mehrkanaldateien**
6. **Unterstützung großer Dateien** -> **Wave/RF64**
7. **Rendern** klicken

Render-Info:
![render-info](render_info.png)
Nach dem Rendern zeigt Reaper ein **Render-Info**-Fenster mit Peak- und LUFS-Werten.

12. Ziehe die gerenderte B-Format-Datei auf die **Bformat-Player**-Spur, setze sie auf **Solo**, und prüfe die Wiedergabe über ICST-Decoder oder binauralen Decoder.

### Troubleshooting (Kurz)

- **Keine Bewegungswiedergabe:** Sichtbarkeit der Automationskurven und Write-/Touch-/Latch-Modus prüfen.
- **Kein Decoder-Ausgang:** Send vom Bformat Master zum Decoder-Eingang kontrollieren.
- **Falsche Lokalisation:** Lautsprechertest erneut durchführen und Hardware-Ausgangszuordnung prüfen.
- **Nur binaural / keine Lautsprecher:** Stumm-/Solo-Status zwischen Decoder- und Binaural-Spur prüfen.
