---
title: Was ist neu
date: 2025-11-03T16:13:00
weight: 20
---

# ICST Ambisonics Plugins v3.2

_**Jetzt verfügbar!**_

**Download:**
🔗 [**GitHub Releases**](https://github.com/schweizerweb/icst-ambisonics-plugins/releases)

Wir freuen uns, **v3.2** ankündigen zu können, mit einem großen Update für den **Multi-Decoder**, neuen Benutzeroberflächen-Layouts, verbesserten Filteroptionen, verbesserter OSC-Steuerung und zahlreichen Workflow-Verbesserungen basierend auf laufender empirischer Forschung am ICST.

📖 **Vollständige Dokumentation:**
🔗 [**Wiki**](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)

---
# ICST AmbiDecoder v3.2

## **Neue Funktionen & Verbesserungen**

### Bidirektionales Solo & Stummschaltung
- Stummschalten oder Solo einzelner Lautsprecher oder Gruppen ganz einfach.
- **Tastaturkürzel (macOS):**
	`Shift + Control + S` / `Shift + Control + M`

  ![bidi_mute](bidi_mute.gif)
### Neu gestaltetes Layout
Eine klarere und modularere Struktur:
- **Lautsprecher-Einstellungen**
- **Decoder-Einstellungen**
- **Filteroptionen**
- **Zusätzliche Funktionen** _(demnächst)_
  ![New_layout](Layout_v3_1.png)
### Neue CSV-Export- & Preset-Verwaltung
- Lautsprecherkoordinaten in **CSV** exportieren zur Verwendung in Max (und umgekehrt).
- Alle Presets als **XML** sichern und exportieren.
- Preset-Sicherungen direkt importieren.

![CSV](Speaker_setting_managment.gif)
### Verbesserte Filteroberfläche

- Acht neue Filteroptionen
- Aktualisierte Benutzeroberfläche für leichtere Vergleiche und Optimierung

	![filters](filters.png)
	![filter UI](filter_UI.png)

### Neuer Multi-Decoder-Modus

- Vier vollständig unabhängige Decoder
- Benutzerdefinierte Namen und Farben
- Pro-Decoder-Lautsprecherauswahl
- Unabhängige Ambisonics-Ordnung, Gewichtung, Filter, Stummschaltung und Verstärkung
- Präzise räumliche Optimierung für komplexe Arrays

📖 **Multi-Decoder-Anleitung:** [ICST AmbiDecoder – Multi-Decoder-Modus](/post/multi-decoder-mode/)
![MultiDecoder](Multidecoder.png)

### Neue Projektvorlagen

- ICST_AmbiPlugins_MonoEncoder
- ICST_AmbiPlugins_MultiEncoder

### Neue Spurvorlagen

- ICST AmbiPlugins
  ![ICST | 400](Track_temp_icst.png)
- ICST AmbiPlugins 3rdParty
  ![3rdParty | 400](Track_temp_3rd.png)

---
# **ICST AmbiEncoder v3.2**

## Neue Funktionen & Layout

- Neue Tab-basierte Layout-Struktur
- Ambisonics-Ordnung-Selektor
- Bidirektionales Solo & Stummschaltung

![Enc_layout](Enc_layout.png)
🔹 **Beispiel:** Layout

![Enc_M_S](Enc_M_S.gif)
🔹 **Beispiel:** Stummschaltung & Solo (bidirektional)

## **OSC-Steuerung**

Steuern Sie Gruppen über OSC mit **absoluten Euler-Winkeln**:
- OSC-Eingabe aktivieren (z.B. **50001**)
- Absolute Winkel von externen Tools senden (Max, TouchDesigner, usw.)
- Sanfte, präzise Rotation und Bewegung kodierter Quellen

![absolut_angel](OSC_abs_angel.gif)
🔹 **Beispiel:** OSC von Max 9.0+ zu ICST AmbiEncoder

💡 Weitere Details finden Sie im [Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki/ICST-AmbiEncoder).

---
# **Fehlerbehebungen**

- Initialisierung der Decoder-Audioausgabe behoben
- Problem mit der Radarrahmen-Sichtbarkeit gelöst
- Beschriftungsumkehrung korrigiert
- Absturz durch falsches Schließen von OSC-Fenstern behoben
- Tutorial-Link im Hilfemenü aktualisiert
- Lautsprecher-Test aktualisiert: White-Noise → **Pink-Noise**

