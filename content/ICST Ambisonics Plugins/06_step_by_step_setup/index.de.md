---
title: Schritt-für-Schritt-Setup
date: 2025-01-23T15:38:00
---
Institut für Computermusik und Soundtechnologie / (ICST) Zurich University of the Arts

---
# Schritt-für-Schritt-Setup-Anleitung für die ICST AmbiPlugins in Reaper

---
### Voraussetzungen

Stellen Sie vor dem Start sicher, dass Sie **Reaper**, die **ICST Ambisonics Plugins** und alle empfohlenen **3rd-Party-Plugins** installiert haben.

### Erstellen einer Reaper-Vorlage

Wir werden die Vorlage Schritt für Schritt von oben nach unten erstellen.

#### 1. Reaper vorbereiten

1. Öffnen Sie eine **neue, leere Reaper-Sitzung**.
    ![empty_reaper](empty_reaper.png)
2. Erstellen Sie eine neue Spur (**Doppelklick** oder verwenden Sie das Menü).
3. Benennen Sie die Spur mit **Decoder** und entfernen Sie den Master-Bus.
    ![01_dec](01_Decoder_A.gif)

> [!Tip:]
>  Erstellen Sie alle Spuren mit **64 Kanälen** standardmäßig und behalten Sie das **Routing** im Auge.

#### 2. Decoder-Routing einrichten

-  **Decoder-Routing für ein Oktagon-Setup:**
- **Eingaben:** 64 Kanäle vom "Bformat Master Track"
- **Ausgaben**: 8 Kanäle zur Audio-Schnittstelle
1. **ICST AmbiPlugins Decoder** im **FX-Fenster**.
   ![open__FX_decoder](FX_Decoder.png)
2. Öffnen Sie den AmbiDecoder
   ![open_decoder](open_decoder.gif)
3. Wählen Sie eine **Lautsprecher-Voreinstellung** (z.B. Oktagon).
    ![open_dec](choose_dec_preset.gif)
4. **AmbiDecoder-Einstellungen anpassen**:
- Ambisonics-Gewichtung
- Ambisonics-Ordnung (1. bis 7. Ordnung)
  ![Dec-setting](7_choose_dec_setting.gif)5. **Lautsprechertest durchführen**:
	- Drücken Sie die "Speaker Test"-Schaltfläche oder testen Sie einzelne Lautsprecher.
![speaker_test](speaker_test.png)

> [!Attention:]  Behalten Sie den Lautstärkepegel im Auge!


9. Erstellen Sie den "Bformat-Master Track"
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

- Erstellen Sie einen **64-Kanal-Track** und routen Sie ihn in den **Bformat Master Track**.

![bformat-player](bformat-player.png)
> [!Tip:] Dies ermöglicht die Wiedergabe von **B-Format-Dateien von der 1. bis zur 7. Ordnung**.

#### 5. Binaurales Hören aktivieren

- Erstellen Sie einen neuen **64-Kanal-Track** und laden Sie einen **Binauralen Plugin** (z.B. _DearVR Ambi Micro.vst3_).
- Verschieben Sie den Track **nach oben**.
- Routen Sie die Ausgabe vom **Format Master** zu diesem **Binauralen Decoder**.
- **Stummschalten Sie den AmbiDecoder**, um nur das binaurale Decodersignal zu hören.

> [!Tip:] Vergleichen Sie mit _Solo/Mute_ zwischen AmbiDecoder und Binaural Decoder.


![1.order_bf](first-order.png)
Beispiel B zeigt ein 5th-Order B-Format Ambisonics.

![5th-order_bf](5th-order-bf.png)
Jetzt können wir B-Format-Dateien auf acht Lautsprecher abspielen und anhören.

Um das B-Format über Kopfhörer abhören zu können, richten wir nun einen Binauralen Decoder ein:
- Erstellen Sie einen neuen **64-Kanal-Track** und laden Sie einen **Binauralen Plugin** Ihrer Wahl ins FX-Fenster (z.B. _DearVR Ambi Micro.vst3_).
- Verschieben Sie den Track **an den Anfang** des Reaper-Racks.
- Routen Sie die **Ausgabe des Bformat Master Tracks** zu diesem Binauralen Decoder (siehe GIF).

![Binaural-track](Binaural_Track.gif)
- Stummschalten Sie den AmbiDecoder, um nur das binaurale Decodersignal zu hören.
![DearVR_binaural](DearVR_binaurl.png)

>[!Tip:]
>Vergleichen Sie Solo/Mute zwischen AmbiDecoder und Binauraler Decoder.

### 6. Monoquelle & Ambisonics Encoder

- Erstellen Sie einen neuen Track "Mono-Source" und laden Sie eine Mono-Audiodatei.

Tip: Sehen Sie sich diesen [Video](https://www.youtube.com/watch?v=aDa-vNWriLM&t=119s) an

12. Mono AmbieEncoder Übersicht.
	![open monoencoder](MonoEncoder_01.png)
    ![open_MonoEncoder](MonoEncoder_load.png)
- Laden Sie im FX-Fenster den ICST MonoEncoder.
- Fügen Sie einen AmbiEncoder(ICST) (1-4) --> Mono-Encoder hinzu
Routing:
- MonoEncoder → 64-Kanal-Ausgang → Bformat Master.

  ![MonnoEncoder](MonoEncoder.png)
#### 7. Bewegungen im Reaper-Track aufnehmen

 Nehmen Sie Bewegungen im MonoEncoder auf:
 ![rec_xyz](rec_xyz.gif)

 Gespeicherte Bewegung wiedergeben:

![play_xyt](play_xyz.gif)

### 8. Verwenden des Multi-Encoders

Im nächsten Beispiel zeige ich, wie wir den **Multi-Encoder** verwenden:

1. **Den Multi-Encoder-Track einfügen**

    - Klicken Sie mit der rechten Maustaste in den leeren Reaper-Spurbereich und wählen Sie **"Spur aus Vorlage einfügen"**.
    - Navigieren Sie zu **ICST AmbiPlugins** und wählen Sie **"ICST_AmbiEncoder_Multi_8src"**.
    - Dies öffnet einen Multi-Encoder mit **8 Monoquellen**, bereits in den Encoder geroutet.

    ![MultiEncoder_routing | 550](MultiEncoder_routing.png)
	2. **Quellen im Multi-Encoder steuern**

	- Wenn das Routing korrekt konfiguriert ist, können Sie jetzt die **Platzierung und Bewegung** von bis zu **8 Quellen** im Multi-Encoder steuern.
### AmbiEncoder-Einstellungen

  3. **AmbiEncoder-Einstellungen verstehen**- Die **AmbiEncoder-Einstellungen** sind entscheidend für Ihren Workflow. - Das folgende GIF zeigt die wichtigsten **AmbiEncoder-Funktionen**:

        ![Enc_Settings](Enc_Settings.gif)
	 ![Enc_Settings](Enc_Settings.gif)

>[!Tip: ] Sehen Sie sich das AmbiEncoder [Video-Tutorial](https://www.youtube.com/watch?v=aDa-vNWriLM&t=31s) an, um mehr Details zu erfahren.

4. **ICST Distanzfunktion**
    - Ein einzigartiges Merkmal des **ICST Ambisonics Encoders** ist seine **Distanzfunktion**, entwickelt von **Martin Neukom** am ICST.
    - Diese Funktion ermöglicht es Ihnen, verschiedene **räumliche Konfigurationen** zu erstellen und Bewegungsgeschwindigkeiten von sehr schnell bis extrem langsam zu simulieren.
      ![Distanc_overview](Distance.gif)Detaillierte Anweisungen finden Sie im **Distance-Tutorial**.

> [!Tip:] Wenn Sie mit **Distanz** arbeiten, legen Sie diese **am Anfang** Ihres Projekts fest, um alle **XYZ-Koordinaten** korrekt zu skalieren. _(Beispiel: Distanzskala von 0,0 bis 1,0).

### Aufnahme & Bearbeitung von Quellbewegungen

5. **Bewegungen im Multi-Encoder aufnehmen**

    - Um zu verstehen, wie der Multi-Encoder funktioniert, gehen wir durch ein **Aufnahmebeispiel**:
        - **Automatisierungshüllen** auf **"Schreiben"** setzen.
        - Drücken Sie **Play** (Leerzeichen) in Reaper und verschieben Sie **Src_1** im Multi-Encoder Radar.
        - Wiederholen Sie den Vorgang für andere Quellen.

		MultiEnc_01_write:
     ![MultiEnc_01_write](MultiEnc_01_write.gif)

	  Hier ist ein Beispiel mit **Src_3**:

       ![Encoder_move_03](Move_03.gif)

Hier ist ein Beispiel mit **Src_3**: Der nächste Schritt zeigt, wie man die XYZ-Hüllen manuell bearbeitet.
![Manuel_edit](MultiEnc_Manuell_edit.gif)

6. **XYZ-Hüllen manuell bearbeiten**

	- Um Bewegungen zu verfeinern, passen Sie manuell die **XYZ-Hüllen** an:
	- Halten Sie **Shift** und klicken Sie auf die Hülle, um einen neuen Bearbeitungspunkt zu erstellen.
	- Verschieben Sie den Punkt, um die **XYZ-Koordinaten** anzupassen.

7. Wiedergabe der aufgezeichneten Ambisonics-Szene

![MultiEnc_plays_scene](play_multienc.gif)

### Arbeiten mit Gruppen

8. **Eine Gruppe im Multi-Encoder erstellen**

    - Wählen Sie im **Radar-Display** mehrere **Src-Punkte**, um eine Gruppe zu bilden.
    - Weisen Sie einen **Gruppennamen** zu (z.B. **G1**).

![create_a_GP](GP_select_scaled.png)
![GP_name](GP_edit_scaled.png)

9. **Gruppenbewegungen aufnehmen**

- Wählen Sie einen Aufnahmemodus:
    - **"Latch"** – Nimmt nur einen Quellpunkt auf.
    - **"Touch"** – Startet die Aufnahme, wenn ein Punkt berührt wird.
    - **"Write"** – Überschreibt vorherige Aufnahmen.
     ![Rec_GP](Rec_GP.gif)

	9. **Wiedergabe & Bewertung**
     ![Play_GP](play_GP.gif)
	- Hören Sie die endgültige **Gruppenbewegungsaufnahme** über **Lautsprecher (Decoder)** oder **Kopfhörer (Binauraler Decoder)**.

### Finalisierung & Export

11. **Rendering des B-Format Masters**
	- Folgen Sie nach Zufriedenheit diesen Schritten, um das **B-Format zu exportieren**:
	    - Wählen Sie **Bformat-Master Track** und stellen Sie ihn auf **Solo**.
	    - Öffnen Sie **Menü > Rendern**.

**Render-Einstellungen:**

  ![Render_Master | 200](render-master.png)


1. **Track auswählen (Stem Render)** → Wählen Sie **Bformat-Master**.
2. **Dateiname** → Weisen Sie einen **B-Format-Dateinamen** zu.
3. **Abtastrate** → 48.000 kHz.
4. **Kanäle** → 64 (für **7. Ordnung Ambisonics**).
5. **Mehrkanalige Format** → Auf **Mehrkanalige Dateien** einstellen.
6. **Große Dateiunterstützung** → Verwenden Sie **Wave/RF64**.
7. **Klicken Sie auf "Rendern"**.

Rendering-Info:
     ![render-info](render_info.png)
	Nach dem Rendering-Prozess erhalten Sie ein Rendering-Info-Fenster mit Peak- und LUFS-Informationen.

8. Das ist alles, jetzt können Sie Ihr B-Format auf den B-Format Player-Track ziehen und ablegen, es auf "Solo" stellen und das Endergebnis über den ICST Decoder oder den Binauralen Decoder anhören.


🎧 Viel Spaß mit Ambisonics!

---
<span style="font-size:9px;color:#9f9f9f;">©2025 ICST</span>
