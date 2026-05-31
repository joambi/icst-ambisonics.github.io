# REAPER Workshop: Raumkurven, Bewegung, Tiefe, Kontrapunkt

Dieses Paket enthaelt ein kleines REAPER-Projekt fuer eine 30-45 Sekunden Ambisonics-Uebung.

Dateien:

- `spatial_counterpoint_workshop.RPP` - REAPER-Projekt mit drei Mono-Stems, Markern und Preview-Automation
- `setup_icst_routing.lua` - ReaScript, das die Audio-Sends fuer die ICST-Uebung anlegt
- `audio/01_percussion_impulses_mono.wav` - kurze Impulse fuer Lokalisation und Kreisbewegung
- `audio/02_depth_drone_mono.wav` - Flaeche fuer Tiefe, Distanz, Spread und Hallanteil
- `audio/03_counterpoint_melody_mono.wav` - melodische Linie fuer raeumlichen Kontrapunkt

## Workshop-Idee

1. Projekt in REAPER öffnen.
2. Zuerst die drei Quellen trocken anhören.
3. `setup_icst_routing.lua` in REAPER über `Actions > Show action list... > ReaScript: Load...` laden und ausführen.
4. Die vorhandene Stereo-Pan-Automation nur als schnelle Preview verstehen.
5. Für die eigentliche Ambisonics-Übung die drei Quellen im ICST MultiEncoder oder mit einzelnen ICST MonoEncodern räumlich führen.
6. `10 ICST MultiEncoder placeholder` als Encoder-Spur verwenden.
7. `11 B-Format Master-HOA-Bus` als zentralen HOA-Bus verwenden und von dort aus exportieren.
8. `12 Binaural Monitor / Decoder: Platzhalter` für Kopfhörer- oder Lautsprecher-Decoder verwenden.

## Angelegtes Audio-Routing

Nach dem Script:

```text
01 Percussion Impulses  -> 10 ICST MultiEncoder input 1
02 Depth Drone          -> 10 ICST MultiEncoder input 2
03 Melody               -> 10 ICST MultiEncoder input 3

10 ICST MultiEncoder    -> 11 B-Format Master HOA Bus
11 B-Format Master      -> 12 Binaural Monitor / Decoder
12 Binaural Monitor     -> Master output
```

Die Master-Sends der drei Quellen, der Encoder-Spur und des B-Format-Masters werden deaktiviert. Nur die Decoder-/Monitor-Spur geht auf den Master. Für B-Format-Exports trotzdem direkt von `11 B-Format-Master HOA Bus` rendern, nicht vom Decoder.

## Vorgeschlagene Raumkurven

- Percussion: kreisfoermiger Azimut, klare Lokalisation, geringe Distanz.
- Drone: langsam nach hinten/oben ziehen, Distance/Spread erhoehen, Pegel und Hoehen leicht reduzieren.
- Melody: unabhaengige Gegenbewegung zur Percussion; an zwei Stellen kreuzen lassen.

## Hoerfragen

- Wann wirkt Bewegung als Linie, wann nur als Effekt?
- Welche Quelle traegt den Vordergrund?
- Wie stark darf die Drone diffus werden, bevor sie die Kontur der anderen Quellen verdeckt?
- Entsteht zwischen Percussion und Melody ein raeumlicher Kontrapunkt oder nur ein Wechsel links/rechts?
