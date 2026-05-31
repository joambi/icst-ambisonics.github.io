# REAPER Workshop Setup — Installation

## Schritt 1: Ordner anlegen

Ordner erstellen:
```
/Applications/ICST Ambisonics Workshop 2026/
```

## Schritt 2: REAPER.app installieren

REAPER.app **manuell** in diesen Ordner ziehen:
```
/Applications/ICST Ambisonics Workshop 2026/REAPER.app
```

→ Download: https://www.reaper.fm/download.php

## Schritt 3: Workshop-Dateien kopieren

Den Inhalt dieses Ordners (`reaper-setup/`) vollständig in den Workshop-Ordner kopieren:
```
/Applications/ICST Ambisonics Workshop 2026/
  ├── REAPER.app          ← manuell hinzufügen
  ├── ICST_Ambisonics_Default.RPP
  ├── scripts/
  │   ├── ICST_Preflight_Check.lua
  │   └── ICST_Setup_Source_Routing.lua
  └── plugins/            ← ICST Ambisonics Plugins
```

## Schritt 4: Plugins prüfen

REAPER starten → FX-Browser öffnen → nach "ICST" suchen.
Alle Plugins sichtbar? → Setup erfolgreich.

Falls nicht: https://ambisonics.ch/icst-ambisonics-plugins/02_installation/
