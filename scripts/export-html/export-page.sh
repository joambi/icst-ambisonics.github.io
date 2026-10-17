#!/usr/bin/env bash
# Exportiert eine Hugo-Seite als einzelne HTML-Datei mit eingebetteten Bildern und Videos (pandoc).
# Aufruf: scripts/export-html/export-page.sh "content/ICST Ambisonics Plugins/11_animator" [de|en] [Zielordner]
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"; cd "$ROOT"
BUNDLE="$1"; LANG_="${2:-de}"; DEST="${3:-$HOME/Desktop}"
SRC="$BUNDLE/index.md"; [ "$LANG_" = de ] && SRC="$BUNDLE/index.de.md"
SLUG="$(basename "$BUNDLE")"; MEDIA="static/icst-ambisonics-plugins/$SLUG"
TMP="$(mktemp -d)"; python3 scripts/export-html/prep.py "$SRC" "$TMP/page.md" "$MEDIA"
EMBED=--embed-resources; pandoc --help 2>/dev/null | grep -q -- --embed-resources || EMBED=--self-contained
mkdir -p "$DEST"
pandoc "$TMP/page.md" -f markdown -t html5 -s --toc --toc-depth=3 $EMBED \
  --resource-path=".:$BUNDLE:$MEDIA" -c scripts/export-html/style.css --metadata lang="$LANG_" \
  -o "$DEST/$SLUG-$LANG_.html"
echo "→ $DEST/$SLUG-$LANG_.html"
