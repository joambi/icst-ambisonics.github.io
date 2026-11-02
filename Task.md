# Aufgaben

## Animator-Seite (`content/ICST Ambisonics Plugins/11_animator/`)

Die Seite steht auf `draft: true` und wird erst mit Release 4.0 freigeschaltet. Die TODO-Kommentare in `index.md` und `index.de.md` bleiben bis dahin als Anker an der jeweiligen Stelle stehen. Diese Liste ist die Hauptliste. Erledigtes hier abhaken und den Kommentar in beiden Sprachdateien entfernen.

### Vor dem Release 4.0

- [ ] **Download-Link** einsetzen (Seitenanfang, Button ist deaktiviert). Danach Kontrast und Dark Theme des Buttons prüfen.
- [ ] **Parametermatrix** (Abschnitt „Movement types and their parameters") gegen den 4.0-Dialog abgleichen.
- [ ] **Videos** für Polygon, Lissajous, Rose, Helix, Random Walk und MoveTo (Polar) aufnehmen (Abschnitt „Spline and Polygon: waypoints" und folgende).
- [ ] **Rezepte** (Abschnitt „Recipes"): alle Werte im Plugin testen und anpassen, pro Rezept ein kurzes Video.
- [ ] **Einschränkungen** (Abschnitt „Limitations (v4.0)") gegen 4.0 abgleichen. Die zwei Punkte entfernen, sobald der Fix in einem Release ist.
- [ ] **Repetitions mit Relative During Clip** mit dem Entwickler klären: Sie addieren sich (3 × 90° = 270°), für Hin und Zurück gilt Palindrome. Nach Bestätigung in den Abschnitt „Timing" übernehmen.
- [ ] **Release Notes** (Abschnitt „Release notes"): Neuerungen von 4.0 gegenüber 3.2.0.9 ergänzen.
- [ ] `draft: false` setzen, in der Navigation und in „Was ist neu" einhängen (der v4.0-Block in „Was ist neu" ist auskommentiert), `hugo` bauen und die CI-Checks laufen lassen.

### Qualität und Barrierefreiheit

- [x] Grosse PNGs (`AT-BAS-03`, `AT-BAS-05`, `AT-CLP-01`) nach WebP umgestellt (2,0 MB auf 0,55 MB).
- [ ] Windows-Teststatus nennen (getestet ist REAPER 7.74–7.82 auf macOS arm64).
- [ ] Textalternativen für die Videos (Kurzbeschreibung pro Video, bei Videos mit Ton ein Transkript).
- [ ] Optional: Untertitel (VTT) und `<track>` im `video`-Shortcode.
- [ ] Optional: Seite aufteilen („Konzept & Start", „Movement- und Action-Clips", „Referenz").
- [ ] Optional: Demo-Szenen (XML) und REAPER-Projekt zum Download, Verweis auf den Animator Choreographer unter „Nächste Schritte".

## Site und Repo

- [x] Link- und Accessibility-Check auf der gebauten Site: `.github/workflows/a11y.yml` (lychee offline + pa11y/axe, `.pa11yci.json`), vorerst nur berichtend (`continue-on-error`). Erster Lauf manuell starten, Befunde sichten, dann auf blockierend umstellen.
- [ ] `pagefind` mit fester Version pinnen (`npx -y pagefind` in `hugo.yml`).
- [ ] Barrierefreiheit offen (aus dem statischen Audit von `public/`):
  - [x] Dropdown-Menüs (Tutorials, Studio, Ascolta, Docs), Sprachwähler und mobiler Menü-Burger sind jetzt `<button>` mit `aria-expanded`/`aria-controls` (vorher versteckte Checkbox, per Tastatur nicht bedienbar). Escape schliesst, Klick ausserhalb schliesst. Im Browser prüfen.
  - [ ] Menünamen in der DE-Navbar sind Englisch (Start, Tutorials, Docs): übersetzen oder mit `lang="en"` auszeichnen.
  - [x] Theme-Umschalter ist jetzt ein `<button>` mit `aria-label` (Handler in `anatole-theme-switcher.js` unverändert, Click bubbelt zu `.themeswitch`). Im Browser mit Tab/Enter/Leertaste und in beiden Themes prüfen.
  - [ ] Überschriften-Sprünge (z. B. h2 auf h4 auf der Startseite, 101 Seiten).
  - [ ] Zwei `h1` auf rund 40 Beiträgen: der Titel plus ein `# ` im Markdown (z. B. `post/circle-selected`, `post/gp-manipulation`, `00_new`).
  - [ ] Doppelte id `fuma-vs-ambix` in `ambisonics-101/formats` (EN und DE).
  - [ ] Suchfeld in `blog/b-format-archive` ohne Label.
  - [ ] Farbkontrast nicht geprüft (Download-Button der Animator-Seite mit Inline-Farben, Dark Theme). Das erledigt erst der axe-Lauf.
  - [ ] Videos ohne Untertitel (VTT) und ohne `<track>`.
- [ ] `.github/workflows/format.yml` hört auf den Branch `master`, das Repo nutzt `main`: läuft nie. Entfernen oder korrigieren.
- [ ] 404-Seite: kein `canonical`/`hreflang`, dafür `noindex`.
- [ ] Doppeltes Deployment klären (`netlify.toml` und GitHub Pages).
- [ ] Repo aufräumen: `docs/` (Altbestand), `Evernote/`, `Attachments/`, `Clippings/`, `exports/`, Pasted-Image-Dateien im Root, `Volumes/`, `resources/_gen` aus dem Tracking nehmen. Grosse Medien nach Git LFS oder extern, danach Historie verkleinern (vorher Backup).
- [ ] `CLAUDE.md` und `.gitignore` zu `public/downloads` angleichen.
- [ ] Zweit-Clone auf `T7 WORK` entscheiden (behalten oder entfernen).
