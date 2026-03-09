---
title: Schritt-für-Schritt-Setup
weight: 70
date: 2025-01-23T15:38:00
---
Institute for Computer Music and Sound Technology (ICST) Zurich University of the Arts

---

# Schritt-für-Schritt-Setup-Anleitung für die ICST AmbiPlugins in Reaper

---
### Voraussetzungen

Stelle vor dem Start sicher, dass du **Reaper**, die **ICST Ambisonics Plugins** und alle empfohlenen **3rd-Party-Plugins** installiert hast.

### Erstellen einer Reaper-Vorlage

Wir werden die Vorlage Schritt für Schritt von oben nach unten erstellen.

#### 1. Reaper vorbereiten

1. Öffne eine **neue, leere Reaper-Sitzung**.
    ![empty_reaper](empty_reaper.png)
2. Erstelle eine neue Spur (**Doppelklick** oder verwende das Menü).
3. Benenne die Spur mit **Decoder** und entferne den Master-Bus.
    ![01_dec](01_Decoder_A.gif)

> [!Tip:]
>  Erstelle alle Spuren mit **64 Kanälen** standardmäßig und behalte das **Routing** im Auge.

#### 2. Decoder-Routing einrichten

-  **Decoder-Routing für ein Oktagon-Setup:**
- **Eingaben:** 64 Kanäle vom "Bformat Master Track"
- **Ausgaben**: 8 Kanäle zur Audio-Schnittstelle
1. **ICST AmbiPlugins Decoder** im **FX-Fenster**.
   ![open__FX_decoder](FX_Decoder.png)
2. Öffne den AmbiDecoder
   ![open_decoder](open_decoder.gif)
3. Wähle eine **Lautsprecher-Voreinstellung** (z.B. Oktagon).
    ![open_dec](choose_dec_preset.gif)
4. **AmbiDecoder-Einstellungen anpassen**:
- Ambisonics-Gewichtung
- Ambisonics-Ordnung (1. bis 7. Ordnung)
  ![Dec-setting](7_choose_dec_setting.gif)5. **Lautsprechertest durchführen**:
	- Drücke die "Speaker Test"-Schaltfläche oder teste einzelne Lautsprecher.
![speaker_test](speaker_test.png)

> [!Attention:]  Behalte den Lautstärkepegel im Auge!


9. Erstelle den "Bformat-Master Track"
![02_BF-Master | 700](02_BF-Master.gif)

#### 3. Einen Bformat Master-Track erstellen

- Der **Bformat Master Track** empfängt alle Signale von:
- **Ambience Encodern**
- **BFormat SFX**
- **BFormat Playern**
- Da dies der Master-Track ist, wird das endgültige **B-Format** hier aufgezeichnet oder durchgemischt.
- Dieser Track ist **rot** gefärbt.
- Er führt sowohl zum **AmbiDecoder** als auch parallel zu einem **Binauralen Track**.

#### 4. Einen Bformat Player-Track erstellen

- Erstelle einen **64-Kanal-Track** und route ihn in den **Bformat Master Track**.

![bformat-player](bformat-player.png)
> [!Tip:] Dies ermöglicht die Wiedergabe von **B-Format-Dateien von der 1. bis zur 7. Ordnung**.

#### 5. Binaurales Hören aktivieren

- Erstelle einen neuen **64-Kanal-Track** und lade ein **binaurales Plugin** (z.B. _DearVR Ambi Micro.vst3_).
- Verschiebe den Track **nach oben**.
- Route die Ausgabe vom **Format Master** zu diesem **Binauralen Decoder**.
- **Schalte stumm den AmbiDecoder**, um nur das binaurale Decodersignal zu hören.

> [!Tip:] Vergleiche mit _Solo/Mute_ zwischen AmbiDecoder und Binaural Decoder.


![1.order_bf](first-order.png)
Beispiel B zeigt ein 5th-Order B-Format Ambisonics.

![5th-order_bf](5th-order-bf.png)
Jetzt können wir B-Format-Dateien auf acht Lautsprecher abspielen und anhören.

Um das B-Format über Kopfhörer abhören zu können, richten wir nun einen Binauralen Decoder ein:
- Erstelle einen neuen **64-Kanal-Track** und lade ein **binaurales Plugin** deiner Wahl ins FX-Fenster (z.B. _DearVR Ambi Micro.vst3_).
- Verschiebe den Track **an den Anfang** des Reaper-Racks.
- Route die **Ausgabe des Bformat Master Tracks** zu diesem Binauralen Decoder (siehe GIF).

![Binaural-track](Binaural_Track.gif)
- Schalte stumm den AmbiDecoder, um nur das binaurale Decodersignal zu hören.
![DearVR_binaural](DearVR_binaurl.png)

>[!Tip:]
>Vergleiche Solo/Mute zwischen AmbiDecoder und Binauraler Decoder.

### 6. Monoquelle & Ambisonics Encoder

- Erstelle einen neuen Track "Mono-Source" und lade eine Mono-Audiodatei.

Tip: Sieh dir diesen [Video](https://www.youtube.com/watch?v=aDa-vNWriLM&t=119s) an

12. Mono AmbieEncoder Übersicht.
	![open monoencoder](MonoEncoder_01.png)
    ![open_MonoEncoder](MonoEncoder_load.png)
- Lade im FX-Fenster den ICST MonoEncoder.
- Füge einen AmbiEncoder(ICST) (1-4) --> Mono-Encoder hinzu
Routing:
- MonoEncoder → 64-Kanal-Ausgang → Bformat Master.

  ![MonnoEncoder](MonoEncoder.png)
#### 7. Bewegungen im Reaper-Track aufnehmen

 Nimm Bewegungen im MonoEncoder auf:
 ![rec_xyz](rec_xyz.gif)

 Gespeicherte Bewegung wiedergeben:

![play_xyt](play_xyz.gif)

### 8. Verwenden des Multi-Encoders

Im nächsten Beispiel zeige ich, wie wir den **Multi-Encoder** verwenden:

1. **Den Multi-Encoder-Track einfügen**

    - Klicke mit der rechten Maustaste in den leeren Reaper-Spurbereich und wähle **"Spur aus Vorlage einfügen"**.
    - Navigiere zu **ICST AmbiPlugins** und wähle **"ICST_AmbiEncoder_Multi_8src"**.
    - Dies öffnet einen Multi-Encoder mit **8 Monoquellen**, bereits in den Encoder geroutet.

    ![MultiEncoder_routing | 550](MultiEncoder_routing.png)
	2. **Quellen im Multi-Encoder steuern**

	- Wenn das Routing korrekt konfiguriert ist, kannst du jetzt die **Platzierung und Bewegung** von bis zu **8 Quellen** im Multi-Encoder steuern.
### AmbiEncoder-Einstellungen

  3. **AmbiEncoder-Einstellungen verstehen**- Die **AmbiEncoder-Einstellungen** sind entscheidend für deinen Workflow. - Das folgende GIF zeigt die wichtigsten **AmbiEncoder-Funktionen**:

        ![Enc_Settings](Enc_Settings.gif)
	 ![Enc_Settings](Enc_Settings.gif)

>[!Tip: ] Sieh dir das AmbiEncoder [Video-Tutorial](https://www.youtube.com/watch?v=aDa-vNWriLM&t=31s) an, um mehr Details zu erfahren.

4. **ICST Distanzfunktion**
    - Ein einzigartiges Merkmal des **ICST Ambisonics Encoders** ist seine **Distanzfunktion**, entwickelt von **Martin Neukom** am ICST.
    - Diese Funktion ermöglicht es dir, verschiedene **räumliche Konfigurationen** zu erstellen und Bewegungsgeschwindigkeiten von sehr schnell bis extrem langsam zu simulieren.
      ![Distanc_overview](Distance.gif)Detaillierte Anweisungen findest du im **Distance-Tutorial**.

> [!Tip:] Wenn du mit **Distanz** arbeitest, lege sie **am Anfang** deines Projekts fest, um alle **XYZ-Koordinaten** korrekt zu skalieren. _(Beispiel: Distanzskala von 0,0 bis 1,0).

### Aufnahme & Bearbeitung von Quellbewegungen

5. **Bewegungen im Multi-Encoder aufnehmen**

    - Um zu verstehen, wie der Multi-Encoder funktioniert, gehen wir durch ein **Aufnahmebeispiel**:
        - **Automatisierungshüllen** auf **"Schreiben"** setzen.
        - Drücke **Play** (Leerzeichen) in Reaper und verschiebe **Src_1** im Multi-Encoder Radar.
        - Wiederhole den Vorgang für andere Quellen.

		MultiEnc_01_write:
     ![MultiEnc_01_write](MultiEnc_01_write.gif)

	  Hier ist ein Beispiel mit **Src_3**:

       ![Encoder_move_03](Move_03.gif)

Hier ist ein Beispiel mit **Src_3**: Der nächste Schritt zeigt, wie man die XYZ-Hüllen manuell bearbeitet.
![Manuel_edit](MultiEnc_Manuell_edit.gif)

6. **XYZ-Hüllen manuell bearbeiten**

	- Um Bewegungen zu verfeinern, passe die **XYZ-Hüllen** manuell an:
	- Halte **Shift** und klicke auf die Hülle, um einen neuen Bearbeitungspunkt zu erstellen.
	- Verschiebe den Punkt, um die **XYZ-Koordinaten** anzupassen.

7. Wiedergabe der aufgezeichneten Ambisonics-Szene

![MultiEnc_plays_scene](play_multienc.gif)

### Arbeiten mit Gruppen

8. **Eine Gruppe im Multi-Encoder erstellen**

    - Wähle im **Radar-Display** mehrere **Src-Punkte**, um eine Gruppe zu bilden.
    - Weise einen **Gruppennamen** zu (z.B. **G1**).

![create_a_GP](GP_select_scaled.png)
![GP_name](GP_edit_scaled.png)

9. **Gruppenbewegungen aufnehmen**

- Wähle einen Aufnahmemodus:
    - **"Latch"** – Nimmt nur einen Quellpunkt auf.
    - **"Touch"** – Startet die Aufnahme, wenn ein Punkt berührt wird.
    - **"Write"** – Überschreibt vorherige Aufnahmen.
     ![Rec_GP](Rec_GP.gif)

	9. **Wiedergabe & Bewertung**
     ![Play_GP](play_GP.gif)
	- Höre die endgültige **Gruppenbewegungsaufnahme** über **Lautsprecher (Decoder)** oder **Kopfhörer (Binauraler Decoder)**.

### Finalisierung & Export

11. **Rendering des B-Format Masters**
	- Folge nach Zufriedenheit diesen Schritten, um das **B-Format zu exportieren**:
	    - Wähle **Bformat-Master Track** und stelle ihn auf **Solo**.
	    - Öffne **Menü > Rendern**.

**Render-Einstellungen:**

  ![Render_Master | 200](render-master.png)


1. **Track auswählen (Stem Render)** → Wähle **Bformat-Master**.
2. **Dateiname** → Weise einen **B-Format-Dateinamen** zu.
3. **Abtastrate** → 48.000 kHz.
4. **Kanäle** → 64 (für **7. Ordnung Ambisonics**).
5. **Mehrkanalige Format** → Auf **Mehrkanalige Dateien** einstellen.
6. **Große Dateiunterstützung** → Verwende **Wave/RF64**.
7. **Klicke auf "Rendern"**.

Rendering-Info:
     ![render-info](render_info.png)
	Nach dem Rendering-Prozess erhältst du ein Rendering-Info-Fenster mit Peak- und LUFS-Informationen.

8. Das ist alles, jetzt kannst du dein B-Format auf den B-Format Player-Track ziehen und ablegen, es auf "Solo" stellen und das Endergebnis über den ICST Decoder oder den Binauralen Decoder anhören.


🎧 Viel Spaß mit Ambisonics!

---
<span style="font-size:9px;color:#9f9f9f;">©2025 ICST</span>
