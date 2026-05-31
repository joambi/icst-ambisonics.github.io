---
categories:
  - ICST Ambisonics Workshop
---


# ICST Ambisonics Workshop: Installation, LuaSocket, Python, and OSC Preparation

Diese Anleitung richtet eine externe/portable REAPER-Installation für ICST AmbiEncoder_64, OSC-Steuerung und ReaScript-Vorbereitung ein.

Der empfohlene Workshop-Weg ist:

1. REAPER extern/portable vorbereiten
2. ICST AmbiEncoder_64 installieren und testen
3. OSC-Empfang im AmbiEncoder aktivieren
4. Python fuer OSC-Steuerung prüfen
5. Lua-ReaScript als GUI/Launcher in REAPER laden
6. LuaSocket nur optional installieren, falls wirklich ein reines Lua-UDP-Script gebraucht wird

## 1. Externen REAPER-Ordner pruefen

In REAPER:

```text
Options > Show REAPER resource path in Finder
```

Der Resource Path sollte zu deiner externen REAPER-Installation gehoeren, z.B.:

```text
/Applications/ICST AmbiPlugins Tests/
```

Wichtige Unterordner:

```text
/Applications/ICST AmbiPlugins Tests/Scripts/
/Applications/ICST AmbiPlugins Tests/UserPlugins/
```

Falls `Scripts/Ambi_Scripts` noch nicht existiert:

```bash
mkdir -p "/Applications/ICST AmbiPlugins Tests/Scripts/Ambi_Scripts"
```

## 2. ReaPack installieren

1. ReaPack herunterladen:

```text
https://reapack.com
```

2. Die passende Datei fuer macOS in den externen REAPER-Ordner kopieren:

```text
/Applications/ICST AmbiPlugins Tests/UserPlugins/
```

3. REAPER neu starten.

4. Danach sollte in REAPER erscheinen:

```text
Extensions > ReaPack
```

## 3. ICST AmbiEncoder_64 vorbereiten

1. Track in REAPER erstellen.
2. FX oeffnen.
3. `AmbiEncoder_64 (ICST)` laden.
4. Im Plugin oben rechts `16 in+out` oder passende Kanalzahl waehlen.
5. OSC im Plugin aktivieren.

Im ICST AmbiEncoder:

```text
Settings/Zahnrad > OSC In
Receive OSC = On
Port = 50001
```

Der OSC-Statusbalken sollte gruen werden, sobald Daten ankommen.

## 4. OSC-Adresse fuer Source-Positionen

Unser Script steuert einzelne Quellen ueber:

```text
/icst/ambi/sourceindex/xyz
```

Argumente:

```text
index x y z
```

Beispiel:

```text
/icst/ambi/sourceindex/xyz 1 0.5 0.2 0.0
```

Dabei ist `index` die Source-Nummer, z.B. `1` bis `16`.

## 5. Python pruefen

Der empfohlene Weg fuer den Workshop ist Python, weil Python UDP/OSC-Pakete ohne native LuaSocket-Probleme senden kann.

Im Terminal:

```bash
python3 --version
```

Erwartet wird z.B.:

```text
Python 3.11.x
```

Falls `python3` fehlt, auf macOS installieren:

```bash
brew install python
```

Danach erneut pruefen:

```bash
python3 --version
```

## 6. Workshop-Scripts installieren

Diese beiden Dateien muessen im externen REAPER-Scripts-Ordner liegen:

```text
/Applications/ICST AmbiPlugins Tests/Scripts/Ambi_Scripts/ICST_AmbiEncoder64_Testbewegungen_OSC.lua
/Applications/ICST AmbiPlugins Tests/Scripts/Ambi_Scripts/ICST_AmbiEncoder64_LissajousOSC_helper.py
```

Die Lua-Datei ist das REAPER-GUI.

Die Python-Datei sendet die OSC-Daten.

## 7. Script in REAPER laden

In REAPER:

```text
Actions > Show action list
New action... > Load ReaScript...
```

Dann diese Datei auswaehlen:

```text
/Applications/ICST AmbiPlugins Tests/Scripts/Ambi_Scripts/ICST_AmbiEncoder64_Testbewegungen_OSC.lua
```

Danach erscheint in der Action List:

```text
Script: ICST_AmbiEncoder64_Testbewegungen_OSC.lua
```

Diese Action ausfuehren.

## 8. OSC-GUI bedienen

Das GUI bietet:

```text
Start
Pause / Resume
Stop
Presets
Motion
Source Map
Radius
Z amount
Period sec
Speed scale
OSC Hz
OSC Port
Save
Load
```

Empfohlener Workshop-Start:

```text
Motion: Lissajous
Radius: 0.82
Z amount: 0.55
Period sec: 24
Speed scale: 1.0
OSC Hz: 20
Port: 50001
```

Dann:

```text
Start
```

## 9. Source Maps fuer Gruppen-Varianten

Die Source Map routet einzelne Quellen auf verschiedene Bewegungsarten.

Format:

```text
Quellen:bewegung;Quellen:bewegung
```

Beispiel A:

```text
1-4:orbit;5-8:rose;9-16:spiral
```

Beispiel B:

```text
1,2,3:lissajous;4,6,8:rose;5,7,9:orbit;10-16:spiral
```

Erlaubte Bewegungen:

```text
lissajous
orbit
figure8
rose
spiral
```

Im GUI:

```text
Source Map > Custom
```

dann Mapping eingeben und mit `Save` als Preset speichern.

## 10. User-Presets speichern

Im GUI:

```text
Save
```

speichert:

```text
Source Map
Motion Type
Radius
Z amount
Period sec
Speed scale
OSC Hz
OSC Port
```

Preset-Datei:

```text
/Applications/ICST AmbiPlugins Tests/Scripts/Ambi_Scripts/ICST_Lissajous_user_presets.tsv
```

Zum Laden:

```text
Load
```

Nummer des Presets eingeben.

## 11. OSC-Port aendern

Im GUI:

```text
Port 50001
```

anklicken und z.B. eingeben:

```text
50003
```

Wichtig: Im ICST AmbiEncoder muss derselbe Port eingestellt sein.

## 12. LuaSocket optional installieren

LuaSocket ist nur noetig, wenn ein Script direkt aus REAPER-Lua UDP senden soll.

In unserem Workshop-Setup ist LuaSocket nicht notwendig, weil:

```text
Lua GUI -> startet Python Helper -> Python sendet OSC
```

Auf macOS kann LuaSocket in REAPER 7 problematisch sein, wenn `socket/core.so` nicht gegen REAPERs eingebettete Lua-C-API laden kann.

Typischer Fehler:

```text
symbol not found in flat namespace '_luaL_addlstring'
```

Falls LuaSocket trotzdem installiert werden soll:

```bash
brew install lua@5.4 luarocks
luarocks --lua-version=5.4 --lua-dir=/opt/homebrew/opt/lua@5.4 install luasocket --tree ~/luasocket-reaper54
```

Danach nach REAPER kopieren:

```bash
mkdir -p "/Applications/ICST AmbiPlugins Tests/Scripts/Lua/socket"
mkdir -p "/Applications/ICST AmbiPlugins Tests/Scripts/Lua/mime"

cp ~/luasocket-reaper54/share/lua/5.4/socket.lua "/Applications/ICST AmbiPlugins Tests/Scripts/Lua/"
cp ~/luasocket-reaper54/share/lua/5.4/mime.lua "/Applications/ICST AmbiPlugins Tests/Scripts/Lua/"
cp -R ~/luasocket-reaper54/share/lua/5.4/socket/. "/Applications/ICST AmbiPlugins Tests/Scripts/Lua/socket/"
cp ~/luasocket-reaper54/lib/lua/5.4/socket/core.so "/Applications/ICST AmbiPlugins Tests/Scripts/Lua/socket/"
cp ~/luasocket-reaper54/lib/lua/5.4/mime/core.so "/Applications/ICST AmbiPlugins Tests/Scripts/Lua/mime/"
```

Wenn REAPER LuaSocket trotzdem nicht laden kann, fuer den Workshop den Python-Weg verwenden.

## 13. Troubleshooting

### Kein OSC-Empfang

Pruefen:

```text
AmbiEncoder OSC In = On
Port im Plugin = Port im Script
Plugin zeigt OSC gruen
```

### Nur eine Source sichtbar

Im AmbiEncoder auf passende Source-/Kanalzahl stellen:

```text
16 in+out
```

### Script startet, aber keine Bewegung

Pruefen:

```text
Python vorhanden
Helper-Datei liegt neben Lua-Datei
Start wurde im GUI gedrückt
Pause ist nicht aktiv
```

### Python-Datei darf nicht ausgeführt werden

Im Terminal:

```bash
chmod +x "/Applications/ICST AmbiPlugins Tests/Scripts/Ambi_Scripts/ICST_AmbiEncoder64_LissajousOSC_helper.py"
```

### macOS blockiert Dateien

Wenn macOS Dateien blockiert:

```text
System Settings > Privacy & Security > Allow Anyway
```

Danach REAPER neu starten.

## 14. Minimaler Workshop-Test

1. AmbiEncoder_64 laden.
2. OSC In aktivieren.
3. Port `50001` einstellen.
4. Lua-GUI in REAPER starten.
5. `Start` klicken.
6. Im AmbiEncoder müssen sich Sources 1-16 bewegen.
7. `Pause` friert die Bewegung ein.
8. `Resume` führt sie fort.
9. `Stop` setzt alle Sources ins Zentrum.

