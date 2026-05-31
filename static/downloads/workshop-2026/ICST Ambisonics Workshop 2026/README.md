# ICST Ambi Automation for REAPER

Dieses Paket fasst einen schnellen REAPER-Workflow fuer Automation mit `ICST AmbiEncoder_64` zusammen.

## A. Effizientester Workflow fuer XYZ-Automation

Fuer den `ICST AmbiEncoder_64` ist in REAPER meist nicht die freie Bearbeitung von drei langen X/Y/Z-Kurven am effizientesten, sondern ein gestufter Workflow:

1. **Zuerst Bewegungsidee festlegen**
   - `Links/Rechts`: zuerst mit normaler `Pan`-Automation denken
   - `Vorne/Hinten`, `Hoehe`, `Distanz`: erst danach als gezielte Verfeinerung

2. **Fuer horizontale Bewegungen zunaechst mit Pan arbeiten**
   - Pan ist schneller zu schreiben, zu lesen und mit der Maus zu editieren.
   - Danach mit `ICST_Pan_to_AmbiXYZ.lua` in `X/Y/Z` uebertragen.
   - Das ist besonders effizient fuer:
     - Pendelbewegungen
     - Frontalboegen
     - einfache Kreis-/Halbbogen-Ideen

3. **Touch oder Latch statt Write fuer Feinarbeit**
   - `Touch`: gut fuer kurze Korrekturen
   - `Latch`: gut fuer laengere Fahrten
   - `Write` nur bewusst einsetzen, weil es schnell bestehende Automation ueberschreibt

4. **Automation Items fuer Phrasen statt durchgehender Punktwolken**
   - kurze Bewegungsbausteine als Automation Items anlegen
   - duplizieren, verschieben, strecken
   - besonders gut fuer wiederkehrende Raumgesten

5. **Nur die benoetigten Envelopes sichtbar halten**
   - fuer schnelle Sessions nicht alle FX-Parameter offen lassen
   - ideal:
     - `Pan` beim Entwurf
     - danach `X`, `Y`, optional `Z`
     - `Distanz` nur wenn wirklich gebraucht

6. **Punkte nach dem Schreiben reduzieren**
   - bei geschriebenen Bewegungen oder Script-Transfer danach `Remove unnecessary points`
   - dadurch werden die Kurven wieder lesbarer

## B. Wichtigste Actions

Diese Actions sind fuer Ambisonics-Automation in REAPER besonders nützlich:

### Automationsmodus

- `40401` Automation: Set track automation mode to read
- `40402` Automation: Set track automation mode to touch
- `40403` Automation: Set track automation mode to write
- `40404` Automation: Set track automation mode to latch
- `42023` Automation: Set track automation mode to latch preview
- `40400` Automation: Set track automation mode to trim/read

### Envelopes anzeigen / aufraeumen

- `40407` Track: Toggle track pan envelope visible
- `41151` Envelope: Toggle show all envelopes for tracks
- `43588` Envelope: Remove unnecessary points
- `_S&M_REMOVE_ALLENVS` SWS/S&M: Remove all envelopes for selected tracks

### Punkte und Formen

- `40106` Envelope: Insert new point at current position
- `40612` Envelope: Select all points
- `40329` Envelope: Delete all points in time selection
- `40189` Envelope: Set shape of selected points to linear
- `40428` Envelope: Set shape of selected points to fast start
- `40429` Envelope: Set shape of selected points to fast end
- `40424` Envelope: Set shape of selected points to slow start/end
- `40190` Envelope: Set shape of selected points to square

### Automation Items

- `40852` Automation item: New automation item
- `42086` Envelope: Delete automation items

### Ambisonics-spezifisch

- `ICST_Pan_to_AmbiXYZ.lua`
  - uebertraegt vorhandene `Pan`-Automation auf `X/Y/Z`
  - ideal fuer schnellen Einstieg in AmbiEncoder-Bewegungen

## C. Empfohlene Toolbar-Logik

Die Toolbar `ICST Ambi Automation` in diesem Paket ist bewusst in 5 Gruppen aufgeteilt:

1. `Mode`
   - Read, Touch, Latch, Write, Latch Preview
2. `Show`
   - Pan zeigen, alle Envelopes zeigen, alle Envelopes entfernen
3. `Edit`
   - Punkt setzen, Punkte selektieren, Punkte in Time Selection loeschen
4. `Shape`
   - Linear, Fast Start, Fast End, Slow, Square
5. `Build`
   - Automation Item neu, Punkte reduzieren, Pan -> XYZ

## Zusaetzliche kombinierte Toolbar

Dieses Paket enthaelt ausserdem eine zweite Toolbar:

- `AmbiEdit + ICST`

Sie kombiniert deine bestehende `PSS Automation`-Toolbar mit dem ICST-spezifischen `Pan -> XYZ`-Schritt. Sie ist sinnvoll, wenn du lieber nur **eine** zentrale Automationsleiste fuer Ambisonics-Editing offen hast.

## Installation

Siehe [install.md](./install.md).
