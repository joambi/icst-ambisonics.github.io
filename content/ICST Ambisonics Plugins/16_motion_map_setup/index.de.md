---
title: Motion Map Setup
date: 2026-06-28T00:00:00
weight: 88
draft: false
toc: true
translationKey: motion-map-setup
description: "Schritt-für-Schritt-Installation für die ICST Ambi Motion Map — Lua-Scripts in REAPER laden und Python für die Live-OSC-Vorschau einrichten. macOS und Windows."
---

Niveau: Einsteiger | Zielgruppe: Komponist:in, Sound Designer:in, Spatial-Audio-Techniker:in.

Diese Seite erklärt alles, was vor der Nutzung des [Motion Map GUIs](/icst-ambisonics-plugins/15_icst_ambi_motion_map/) installiert werden muss: Lua-Scripts in REAPER laden und — für die Live-OSC-Vorschau — Python 3 einrichten. Es müssen keine zusätzlichen Python-Pakete installiert werden.

---

## Was du brauchst

| Komponente | Wofür | Bezugsquelle |
|------------|-------|--------------|
| REAPER v6+ | Scripts ausführen | [reaper.fm](https://reaper.fm) |
| ICST AmbiEncoder_64 | Automation schreiben | [Downloads](/icst-ambisonics-plugins/08_downloads/) |
| Motion Map Bundle | Die Scripts | [Unten herunterladen](#1-bundle-herunterladen) |
| Python 3 | Nur für Live-OSC-Vorschau | Ab macOS 12 vorinstalliert; [python.org](https://www.python.org/downloads/) auf Windows |

{{< notice warning >}}
Python 3 wird **nur für die Live-OSC-Vorschau** benötigt. Das Schreiben von Automation funktioniert ohne Python.
{{< /notice >}}

---

## 1. Bundle herunterladen

Das [ICST Ambi Motion Map Bundle](/downloads/ICST_Ambi_Motion_Map_Bundle.zip) herunterladen und entpacken. Das Bundle enthält zwei Lua-Dateien:

```
JS_AmbiEncoder64_Motion_Map_GUI.lua          ← diese in REAPER laden
JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua  ← im selben Ordner lassen
```

Beide Dateien an einen dauerhaften Ort kopieren — zum Beispiel den REAPER-Scripts-Ordner:

- **macOS:** `~/Library/Application Support/REAPER/Scripts/`
- **Windows:** `%APPDATA%\REAPER\Scripts\`

{{< notice warning >}}
Beide Dateien müssen sich immer im **selben Ordner** befinden. Das GUI findet den Writer zur Laufzeit im eigenen Verzeichnis.
{{< /notice >}}

---

## 2. Script in REAPER laden

1. REAPER öffnen.
2. **Actions → Load ReaScript…** aufrufen.
3. Zum Ordner mit dem Bundle navigieren.
4. `JS_AmbiEncoder64_Motion_Map_GUI.lua` auswählen und **Open** klicken.

   Nur das GUI-Script wird geladen — der Writer wird automatisch aufgerufen.

5. REAPER bestätigt: *"Script loaded successfully."*

---

## 3. Script zum ersten Mal starten

1. In REAPER einen Track auswählen, der **ICST AmbiEncoder_64** als FX enthält.
2. Eine Time Selection (Loop-Range) in der Timeline setzen.
3. **Actions → Show action list…** öffnen (oder `?` drücken).
4. Nach `JS_AmbiEncoder64_Motion_Map_GUI` suchen.
5. **Run** klicken — das Motion Map Fenster öffnet sich.

---

## 4. Tastaturkürzel zuweisen (empfohlen)

Im Actions-Fenster:

1. `JS_AmbiEncoder64_Motion_Map_GUI` in der Liste suchen.
2. Neben dem *Shortcut*-Feld auf **Add…** klicken.
3. Gewünschte Tastenkombination drücken (z.B. `Ctrl+Shift+M`).
4. **OK** klicken.

Ab jetzt öffnet dieser Kürzel das GUI sofort.

---

## 5. Python für die Live-OSC-Vorschau einrichten

Die Live-OSC-Vorschau sendet Positionsdaten in Echtzeit an den AmbiEncoder, damit Bewegungen gehört werden können, bevor sie als Automation festgeschrieben werden. Der Python-Helfer verwendet ausschliesslich die eingebauten Module `socket` und `struct` — **kein pip install notwendig**.

### Prüfen, ob Python 3 bereits installiert ist

Ein Terminal öffnen (macOS: **Terminal.app** / Windows: **Eingabeaufforderung** oder **PowerShell**) und ausführen:

```bash
python3 --version
```

Bei einer Ausgabe wie `Python 3.11.4` ist alles bereit. Weiter zu [Schritt 6](#6-osc-in-reaper-einrichten).

### macOS — Python 3 installieren

**Option A — Xcode Command Line Tools** (einfachste Methode):

```bash
xcode-select --install
```

Den Anweisungen auf dem Bildschirm folgen. Danach ist `python3` unter `/usr/bin/python3` verfügbar.

**Option B — Homebrew** (empfohlen, wenn Homebrew bereits installiert ist):

```bash
brew install python
```

Anschliessend prüfen:

```bash
python3 --version
```

### Windows — Python 3 installieren

1. Auf [python.org/downloads](https://www.python.org/downloads/) gehen.
2. Den aktuellen **Python 3.x**-Installer herunterladen.
3. Installer starten. **Wichtig:** *„Add Python to PATH"* anhaken, bevor auf Install geklickt wird.
4. Nach der Installation eine neue Eingabeaufforderung öffnen und prüfen:

```cmd
python3 --version
```

   Falls das nicht klappt, `python --version` versuchen — auf manchen Windows-Systemen heisst der Befehl `python` statt `python3`. Das GUI probiert beide Varianten automatisch.

{{< notice warning >}}
Auf Windows kann Python aus dem Microsoft Store die Ausführung von Scripts innerhalb von REAPER blockieren. Falls die OSC-Vorschau nicht funktioniert, Python über [python.org](https://www.python.org/downloads/) neu installieren und dabei *„Add to PATH"* aktivieren.
{{< /notice >}}

---

## 6. OSC in REAPER einrichten

Die OSC-Vorschau sendet UDP-Pakete an REAPERs eingebauten OSC-Listener, auf den der AmbiEncoder_64 reagiert.

1. In REAPER: **Preferences → Control/OSC/web** (oder **Options → Preferences → Control/OSC/web**).
2. Im Bereich *Control surface / OSC / web* auf **Add** klicken.
3. Als Modus **OSC (Open Sound Control)** wählen.
4. Einen **Local listen port** festlegen — z.B. `9001`.
5. *Allow binding…* aktiviert lassen.
6. **OK** klicken und Preferences schliessen.

Zurück im Motion Map GUI:

- **Host** auf `127.0.0.1` setzen
- **Port** auf `9001` setzen (muss mit dem oben eingestellten Port übereinstimmen)
- **Connect** klicken

Der Status-Punkt wird grün, sobald der Python-Helfer erfolgreich gestartet ist.

---

## 7. Gesamtsetup testen

1. Das Motion Map GUI öffnen.
2. Source S0 aktivieren und als Form **Circle** zuweisen.
3. Im OSC-Preview-Bereich **Connect** klicken — Status-Punkt wird grün.
4. **Live Preview** aktivieren.

Im AmbiEncoder_64-Plugin-Fenster ist nun eine kreisende Bewegung zu sehen. Wenn das funktioniert, sind sowohl die Lua-Scripts als auch die Python-OSC-Verbindung korrekt eingerichtet.

---

## Windows — Schritt-für-Schritt-Anleitung

Eine vollständige Anleitung für Windows-Nutzer:innen — vom Download bis zur ersten Live-Vorschau, ohne zwischen den Abschnitten springen zu müssen.

### Schritt 1 — Dateien herunterladen und ablegen

1. Das [ICST Ambi Motion Map Bundle](/downloads/ICST_Ambi_Motion_Map_Bundle.zip) herunterladen und entpacken.
2. **Datei-Explorer** öffnen und diesen Pfad in die Adressleiste einfügen:
   ```
   %APPDATA%\REAPER\Scripts\
   ```
   Falls der Ordner noch nicht existiert, diesen anlegen.
3. **Beide** Lua-Dateien in diesen Ordner kopieren:
   ```
   JS_AmbiEncoder64_Motion_Map_GUI.lua
   JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua
   ```

{{< notice warning >}}
Beide Dateien müssen sich immer im **selben Ordner** befinden. Das GUI findet den Writer zur Laufzeit im eigenen Verzeichnis.
{{< /notice >}}

### Schritt 2 — Script in REAPER laden

1. REAPER öffnen.
2. **Actions → Load ReaScript…** aufrufen.
3. Zum Ordner `%APPDATA%\REAPER\Scripts\` navigieren.
4. `JS_AmbiEncoder64_Motion_Map_GUI.lua` auswählen und **Open** klicken.
5. REAPER bestätigt: *"Script loaded successfully."*

Nur das GUI-Script wird geladen — der Writer wird automatisch aufgerufen.

### Schritt 3 — Python 3 installieren (nur für Live-OSC-Vorschau)

Diesen Schritt überspringen, wenn nur Automation geschrieben werden soll (keine Live-Vorschau benötigt).

1. Auf [python.org/downloads](https://www.python.org/downloads/) den aktuellen **Python 3.x** Windows-Installer (64-bit empfohlen) herunterladen.
2. Installer starten. **Wichtig:** Ganz unten auf dem ersten Bildschirm **„Add Python to PATH"** anhaken, bevor auf *Install Now* geklickt wird.
3. Nach der Installation eine **neue** Eingabeaufforderung öffnen (`Win + R` → `cmd` eingeben → Enter) und prüfen:
   ```cmd
   python3 --version
   ```
   Bei einer Ausgabe wie `Python 3.x.x` ist Python bereit. Falls `'python3' wird nicht erkannt` erscheint, versuchen:
   ```cmd
   python --version
   ```
   Das Motion Map GUI probiert beide Befehle automatisch.

{{< notice warning >}}
Python **nicht** aus dem Microsoft Store installieren. Store-Versionen verwenden isolierte App-Pfade, die REAPER aus einem Lua-Script nicht aufrufen kann. Immer den Installer von [python.org](https://www.python.org/downloads/) verwenden.
{{< /notice >}}

### Schritt 4 — OSC in REAPER einrichten

1. In REAPER: **Options → Preferences → Control/OSC/web**
2. **Add** klicken und als Modus **OSC (Open Sound Control)** wählen.
3. **Local listen port** auf `9001` setzen.
4. *Allow binding…* aktiviert lassen und **OK** klicken.

### Schritt 5 — Python durch Windows-Firewall erlauben

Beim ersten Klick auf **Connect** im Motion Map GUI zeigt Windows Defender eine Sicherheitswarnung für `python.exe`. **Zugriff erlauben** klicken (Private Netzwerke genügt).

Falls versehentlich *Blockieren* geklickt wurde: **Windows Defender-Firewall → App durch Windows Defender-Firewall zulassen** öffnen, Python suchen und die Checkbox für Private aktivieren.

### Schritt 6 — Verbinden und testen

1. In REAPER einen Track auswählen, der **ICST AmbiEncoder_64** als FX geladen hat.
2. Eine Time Selection (Loop-Range) in der Timeline setzen.
3. Die Aktionsliste öffnen (`?`), `JS_AmbiEncoder64_Motion_Map_GUI` suchen und **Run** klicken.
4. Im GUI: **Host** auf `127.0.0.1`, **Port** auf `9001` setzen, dann **Connect** klicken — der Status-Punkt wird grün.
5. Source S0 aktivieren, Form **Circle** zuweisen, **Live Preview** einschalten.

Im AmbiEncoder_64-Plugin ist nun eine kreisende Bewegung zu sehen. Die Windows-Einrichtung ist abgeschlossen.

---

## Fehlerbehebung

### „Writer not found" beim Klick auf Write

Die beiden Lua-Dateien befinden sich nicht im selben Ordner. `JS_Write_AmbiEncoder64_Spat_Motion_Automation.lua` in denselben Ordner wie `JS_AmbiEncoder64_Motion_Map_GUI.lua` verschieben und das GUI neu laden.

### OSC Connect — Status-Punkt bleibt rot

Diese Punkte der Reihe nach prüfen:

1. **Python 3 installiert?** Im Terminal `python3 --version` ausführen.
2. **Port stimmt überein?** REAPER-OSC-Lauschport muss gleich dem Port-Feld im GUI sein.
3. **REAPER OSC aktiviert?** Preferences → Control/OSC/web — Eintrag vorhanden und nicht deaktiviert?
4. **Firewall?** Auf Windows kann beim ersten Start ein Firewall-Dialog erscheinen. UDP-Zugriff erlauben.
5. **Neustart:** Disconnect, dann erneut Connect klicken.

### macOS — `python3` nach xcode-select nicht gefunden

Ausführen:

```bash
sudo xcode-select --reset
python3 --version
```

### Windows — `python3` nicht erkannt

Das GUI versucht automatisch `python` als Fallback. Falls beides scheitert, Python von [python.org](https://www.python.org/downloads/) neu installieren und *„Add to PATH"* aktivieren.

---

## Nächste Schritte

Nach abgeschlossenem Setup:

- [Motion Map Benutzerhandbuch](/icst-ambisonics-plugins/15_icst_ambi_motion_map/) — vollständige Anleitung zu allen Funktionen
- [ICST Ambi Motion Markers](/icst-ambisonics-plugins/14_icst_ambi_motion_markers/) — cue-basierte Alternative für räumliche Bewegung
