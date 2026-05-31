#!/usr/bin/env bash
# =============================================================================
# build_workshop_zip.sh
# ICST Ambisonics Workshop 2026 — ZIP-Paket erstellen
#
# Erstellt: static/downloads/ICST_Ambisonics_Workshop_2026.zip
# Das ZIP enthält alles in einem self-contained Ordner mit relativen Pfaden.
#
# Verwendung (vom Repo-Root ausführen):
#   bash scripts/build_workshop_zip.sh
#
# Voraussetzung: zip, rsync (macOS: vorinstalliert)
# =============================================================================

set -euo pipefail

# ── Konfiguration ─────────────────────────────────────────────────────────────
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_ROOT/static/downloads/workshop-2026"
BUILD_DIR="/tmp/.workshop_build_icst"
ZIP_NAME="ICST_Ambisonics_Workshop_2026"
ZIP_TMP="/tmp/${ZIP_NAME}.zip"
ZIP_OUT="$REPO_ROOT/static/downloads/${ZIP_NAME}.zip"
INNER="$BUILD_DIR/$ZIP_NAME"        # Entpackt als: ICST_Ambisonics_Workshop_2026/

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  ICST Ambisonics Workshop 2026 — ZIP Builder            ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "  Repo:    $REPO_ROOT"
echo "  Quelle:  $SRC"
echo "  Ziel:    $ZIP_OUT"
echo ""

# ── Build-Verzeichnis vorbereiten ─────────────────────────────────────────────
rm -rf "$BUILD_DIR"
mkdir -p "$INNER"

# ── 1. HTML-Handouts ──────────────────────────────────────────────────────────
echo "→ HTML-Handouts …"
mkdir -p "$INNER/html"
cp "$SRC"/html/*.html                           "$INNER/html/"
# reaper-workshop-raumkurven.html liegt im Root, kommt ebenfalls in html/
cp "$SRC/reaper-workshop-raumkurven.html"       "$INNER/html/"

# ── 2. Csound-Instrumente ─────────────────────────────────────────────────────
echo "→ Csound …"
mkdir -p "$INNER/csound"
# HRTF-Dateien MÜSSEN im gleichen Ordner wie die CSD-Files liegen
cp "$SRC"/csound/*.csd                          "$INNER/csound/"
cp "$SRC"/csound/*.dat                          "$INNER/csound/"
# Setup-Anleitung falls vorhanden
[ -f "$SRC/csound/README.md" ] && \
  cp "$SRC/csound/README.md"                    "$INNER/csound/"
[ -f "$SRC/csound/icst_cabbage_to_icst_multiencoder_setup.txt" ] && \
  cp "$SRC/csound/icst_cabbage_to_icst_multiencoder_setup.txt" "$INNER/csound/"

# ── 3. REAPER-Projekt ─────────────────────────────────────────────────────────
echo "→ REAPER …"
mkdir -p "$INNER/reaper/audio"
cp "$SRC/reaper-setup/spatial_counterpoint_workshop.RPP"  "$INNER/reaper/"
cp "$SRC/reaper-setup/setup_icst_routing.lua"             "$INNER/reaper/"
cp "$SRC/reaper-setup/INSTALLATION.md"                    "$INNER/reaper/"
cp "$SRC/reaper-setup/audio"/*.wav                        "$INNER/reaper/audio/"
# automation_plan.csv falls vorhanden
[ -f "$SRC/reaper-setup/automation_plan.csv" ] && \
  cp "$SRC/reaper-setup/automation_plan.csv"              "$INNER/reaper/"

# ── 4. Max/MSP Patches ───────────────────────────────────────────────────────
echo "→ Max/MSP …"
mkdir -p "$INNER/maxmsp"
cp "$SRC"/maxmsp/*.maxpat                       "$INNER/maxmsp/"
# Ableton Live-Preset falls vorhanden
[ -f "$SRC/maxmsp/E4L Multi-Panner_OSC.adv" ] && \
  cp "$SRC/maxmsp/E4L Multi-Panner_OSC.adv"    "$INNER/maxmsp/"
[ -f "$SRC/maxmsp/README.md" ] && \
  cp "$SRC/maxmsp/README.md"                   "$INNER/maxmsp/"

# ── 5. additive VST3-Plugin (macOS only, separat gekennzeichnet) ──────────────
echo "→ VST3-Plugin (macOS) …"
mkdir -p "$INNER/plugins-macos"
if [ -d "$SRC/addiditve.vst3" ]; then
  cp -R "$SRC/addiditve.vst3"                  "$INNER/plugins-macos/"
fi
cat > "$INNER/plugins-macos/README.txt" << 'PLUGINREADME'
Additiv-Synth VST3-Plugin (macOS only)
=======================================
addiditve.vst3 → in ~/Library/Audio/Plug-Ins/VST3/ kopieren
               → REAPER neu starten → Plugin erscheint in der Plug-in-Liste

Hinweis: Dieses Plugin ist nur unter macOS lauffähig.
PLUGINREADME

# ── 6. START_HIER.md (Einstiegspunkt für Workshop-Teilnehmer) ─────────────────
echo "→ START_HIER.md …"
cat > "$INNER/START_HIER.md" << 'STARTMD'
# ICST Ambisonics Workshop 2026
## So startest du

Entpacke dieses ZIP in einen Ordner deiner Wahl.
Alle relativen Pfade (Audio ↔ REAPER-Projekt, HRTF ↔ Csound) funktionieren
dann automatisch — solange du die Ordnerstruktur nicht veränderst.

---

## Ordnerinhalt

| Ordner | Inhalt | Programm |
|---|---|---|
| `html/` | Workshop-Handouts, Raumkurven-Diagramm | Browser |
| `csound/` | Cabbage/Csound-Instrumente + HRTF-Files | Cabbage oder csound CLI |
| `reaper/` | REAPER-Projekt + Mono-Audio-Quellen | REAPER |
| `maxmsp/` | Max/MSP OSC-Patcher | Max/MSP |
| `plugins-macos/` | Additive-Synth VST3 (nur macOS) | manuell installieren |

---

## Schnellstart nach Umgebung

### Browser (kein Download nötig)
Die HTML-Handouts können auch direkt online aufgerufen werden:
→ https://ambisonics.ch/downloads/workshop-2026/html/ICST_Workshop_Ablauf.html

### REAPER
1. ICST Ambisonics Plugins installieren (→ ambisonics.ch/start)
2. `reaper/spatial_counterpoint_workshop.RPP` in REAPER öffnen
3. Plugin-Pfade beim ersten Öffnen bestätigen

### Csound / Cabbage
1. Cabbage installieren (→ cabbageaudio.com)
2. Eine `.csd`-Datei aus `csound/` in Cabbage öffnen
3. Die HRTF-Files (`hrtf-48000-left.dat` / `hrtf-48000-right.dat`) liegen
   bereits im selben Ordner — kein SSDIR-Setup nötig

### Ambisonics Exercise (Csound)
`csound/icst_ambisonics_exercise.csd`
→ Binaural-Monitoring + B-Format 16ch-Datei-Ausgabe
→ Öffne in Cabbage oder starte mit:
   `csound csound/icst_ambisonics_exercise.csd`
→ Die B-Format-Datei wird im `csound/`-Ordner abgelegt.

---

## Voraussetzungen

- **REAPER** 7.x → https://reaper.fm
- **ICST Ambisonics Plugins** (AmbiEncoder, AmbiDecoder, etc.)
  → https://ambisonics.ch/start
- **Cabbage** (für Csound-Instrumente) → https://cabbageaudio.com
- **Max/MSP** (für Patcher) → https://cycling74.com

---

ICST / Zurich University of the Arts — https://ambisonics.ch
STARTMD

# ── ZIP erstellen ─────────────────────────────────────────────────────────────
echo ""
echo "→ ZIP erstellen …"
cd "$BUILD_DIR"
zip -r --quiet "$ZIP_TMP" "$ZIP_NAME"

# ZIP an Zielort kopieren (überschreibt bestehende Datei)
cp -f "$ZIP_TMP" "$ZIP_OUT"
rm -f "$ZIP_TMP"

# Grösse ausgeben
ZIP_SIZE=$(du -sh "$ZIP_OUT" | cut -f1)
FILE_COUNT=$(unzip -l "$ZIP_OUT" | tail -1 | awk '{print $2}')

# ── Aufräumen ─────────────────────────────────────────────────────────────────
rm -rf "$BUILD_DIR"

echo ""
echo "✓ Fertig!"
echo ""
echo "  Datei:   $ZIP_OUT"
echo "  Grösse:  $ZIP_SIZE"
echo "  Dateien: $FILE_COUNT"
echo ""
echo "  Online unter:"
echo "  https://ambisonics.ch/downloads/${ZIP_NAME}.zip"
echo ""
