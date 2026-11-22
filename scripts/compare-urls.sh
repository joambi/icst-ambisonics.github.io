#!/usr/bin/env bash
# Vergleicht die URL-Mengen zweier Hugo-Builds (z. B. vor/nach einem Navigations-Umbau).
# Nutzung: scripts/compare-urls.sh <build-vorher> <build-nachher>
# Beispiel: hugo -d /tmp/vorher (auf main), hugo -d /tmp/nachher (auf dem Branch).
a="${1:?Verzeichnis vorher}"; b="${2:?Verzeichnis nachher}"
t=$(mktemp -d)
list() { (cd "$1" && find . -type f -name '*.html' | sed -e 's#/index\.html$#/#' -e 's#^\.##' | sort -u); }
list "$a" > "$t/a"; list "$b" > "$t/b"
comm -23 "$t/a" "$t/b" > "$t/rm"; comm -13 "$t/a" "$t/b" > "$t/add"
echo "URLs vorher: $(wc -l < "$t/a") | nachher: $(wc -l < "$t/b")"
echo "Entfernt: $(wc -l < "$t/rm")"; cat "$t/rm"
echo "Neu: $(wc -l < "$t/add")"; cat "$t/add"
n=$(wc -l < "$t/rm"); rm -rf "$t"
if [ "$n" -ne 0 ]; then echo "FEHLER: URLs verschwunden (Alias/Redirect ergänzen)"; exit 1; fi
echo "OK: keine URL verloren."
