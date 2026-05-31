# Installation

## Enthalten

- `ICST_Pan_to_AmbiXYZ.lua`
- `toolbar_icst_ambi_automation.ini`
- `toolbar_ambiedit_icst_combined.ini`
- `icons/`

## Empfohlene Installation in REAPER

1. `ICST_Pan_to_AmbiXYZ.lua` nach `REAPER/Scripts/` kopieren
2. alle PNG-Dateien aus `icons/` nach `REAPER/Data/toolbar_icons/` kopieren
3. den Abschnitt aus `toolbar_icst_ambi_automation.ini` in `reaper-menu.ini` einfuegen
4. REAPER neu starten
5. Toolbar anzeigen:
   - `View -> Toolbars -> Floating toolbar 15`

## Zusaetzliche kombinierte Toolbar

Wenn du die kombinierte Toolbar verwendest:

- `View -> Toolbars -> Floating toolbar 17`

Titel:

- `AmbiEdit + ICST`

## Wichtiger Hinweis zum Script-Button

REAPER vergibt fuer ReaScripts erst dann eine Action-ID, wenn das Script einmal in die Action List geladen wurde.

Darum:

1. `Actions -> Show action list`
2. `ReaScript -> Load`
3. `ICST_Pan_to_AmbiXYZ.lua` laden
4. die erzeugte `_RS...`-ID merken
5. in `reaper-menu.ini` beim Toolbar-Button `Pan -> XYZ` die Platzhalter-ID ersetzen

Wenn du die Installation durch Codex direkt in deinen REAPER-Resource-Ordner machen laesst, kann dieser Schritt trotzdem noetig bleiben, falls REAPER das Script noch nicht registriert hat.
