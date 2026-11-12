# Konzept: Taxonomie und Navigation für ambisonics.ch

Stand 12.11.2026. Zum Prüfen, noch nichts im Site-Code geändert.

## Befunde

- 29 Posts in `content/post/`, die Tags sind frei vergeben (`workflow`, `reaper`, `ambiencoder` fast überall) und taugen nicht zum Filtern.
- **11 Posts nur auf Deutsch** (kein `index.de.md`/`index.md`-Paar), 1 Thema doppelt als zwei getrennte Posts (`decoder-methodischer-kontext` / `decoder-methodological-context`).
- **Drei ähnliche Einsteiger-Tutorials:** `ambisonics-in-30-minutes`, `reaper-setup-20-minuten`, `getting-started-icst-plugins-reaper` (+ `stereo-to-hoa7-session`).
- Der Bereich „Blog“ enthält ein Gemisch: Studio-Seiten, ASCOLTA, Downloads, FAQ, B-Format-Archiv. Der Name passt nicht.

## Vorschlag Einordnung (Frontmatter)

Neue Felder pro Post: `kind` (tutorial | reference | background | news), `tool` (Liste), `level` (beginner | intermediate | advanced).

| Slug | kind | tool | level | Hinweis |
|---|---|---|---|---|
| ambisonics-in-30-minutes | tutorial | REAPER | beginner | Einstiegspfad 1, mit 20-Minuten-Setup zusammenlegen? |
| reaper-setup-20-minuten | tutorial | REAPER, AmbiEncoder | beginner | Einstiegspfad 1 |
| getting-started-icst-plugins-reaper | tutorial | REAPER, AmbiEncoder | beginner | Dopplung prüfen |
| stereo-to-hoa7-session | tutorial | REAPER | intermediate | |
| ableton_reaper | tutorial | AmbiEncoder, Ableton | intermediate | |
| ambisonics-mikrofon-a-format-b-format | tutorial | Aufnahme | intermediate | nur DE |
| b-format-export-reaper | tutorial | REAPER | intermediate | nur DE |
| binaural-monitoring-icst-workflow | tutorial | Binaural | beginner | nur DE |
| szenen-rotation-b-format-transform | tutorial | REAPER, OSC | advanced | nur DE |
| ambisonics-to-atmos-bed | tutorial | Delivery | advanced | nur DE |
| decoder-filter-praxisbeispiele | tutorial | AmbiDecoder | intermediate | nur DE |
| gp-manipulation | tutorial | MultiEncoder, Animator | intermediate | |
| circle_selected | tutorial | AmbiEncoder, Lua | intermediate | |
| icst-scripts (Spiral Walk) | tutorial | AmbiEncoder, Lua | intermediate | |
| GYROSC | tutorial | AmbiEncoder, OSC | intermediate | |
| icst-grapes | tutorial | AmbiEncoder, OSC | intermediate | sehr kurz |
| icst-ambisonics-plugins-icst-ambimonitor-bidirectional-osc-communication | tutorial | Max, OSC | advanced | |
| osc-2-fx | tutorial | OSC, REAPER | intermediate | |
| osc-10-key-messages | reference | OSC | beginner | |
| osc-syntax-for-the-icst-ambiencoder-plugin | reference | OSC | advanced | |
| multi-decoder-mode | reference | AmbiDecoder | intermediate | |
| decoder-skalierung-laufzeitkompensation | reference | AmbiDecoder | advanced | nur DE |
| xyz-vs-aed-koordinatensysteme | reference | AmbiDecoder | intermediate | nur DE |
| decoder-methodischer-kontext / -methodological-context | background | AmbiDecoder | advanced | zu **einem** Post mit DE+EN zusammenlegen |
| hoa-ordnung-wahl-praxis | background | – | beginner | nur DE |
| komposition-in-ambisonics | background | – | beginner | nur DE |
| Blauertsche_Bänder | background | – | advanced | |
| icst-animator-choreographer | tutorial | Animator | intermediate | Tool-Vorstellung |
| relaunch-2026 | news | – | – | |

## Umsetzung (Schritte)

1. Felder `kind`, `tool`, `level` in die 29 Posts schreiben (Skript, danach Durchsicht).
2. Übersichtsseite mit Suchfeld und Filter-Chips (Art, Werkzeug, Level, Sprache), clientseitig aus einem von Hugo erzeugten JSON-Index.
3. Startseite: vier Einstiegskarten (Anfangen / Tun / Nachschlagen / Verstehen) auf die gefilterte Übersicht.
4. Menü auf sechs Hauptpunkte kürzen: Start | Lernen | Werkzeuge (EcoSystem) | Studio & Residencies | Archiv | Downloads.
5. Pro Post „Nächster Schritt / Siehe auch“ aus `kind` und `tool` automatisch vorschlagen.

## Entscheidungen von dir

- Die 11 deutschen Posts ohne englische Version: übersetzen oder bewusst nur DE lassen?
- Drei Einsteiger-Tutorials: zusammenlegen oder als „Pfad“ (1, 2, 3) kennzeichnen?
- „Blog“ umbenennen (z. B. „Docs & Studio“)?
