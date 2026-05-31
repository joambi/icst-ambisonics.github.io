### REAPER Workshop: Spatial Trajectories, Movement, Depth, Counterpoint

DOWNLOAD: 

Files:

- `spatial_counterpoint_workshop.RPP` - REAPER project with three mono stems, markers and preview automation
- `setup_icst_routing.lua` - ReaScript that sets up the audio sends for the ICST exercise
- `audio/01_percussion_impulses_mono.wav` - short impulses for localisation and circular movement
- `audio/02_depth_drone_mono.wav` - texture for depth, distance, spread and reverb amount
- `audio/03_counterpoint_melody_mono.wav` - melodic line for spatial counterpoint

## Workshop Concept

1. Open the project in REAPER.
2. First listen to the three sources dry.
3. Load and run `setup_icst_routing.lua` in REAPER via `Actions > Show action list... > ReaScript: Load...`.
4. Treat the existing stereo pan automation only as a quick preview.
5. For the actual ambisonics exercise, position the three sources spatially in the ICST MultiEncoder or with individual ICST MonoEncoders.
6. Use `10 ICST MultiEncoder placeholder` as the encoder track.
7. Use `11 B-Format-Master-HOA-Bus` as the central HOA bus and export from there.
8. Use `12 Binaural Monitor / Decoder: Placeholder` for headphone or loudspeaker decoders.

## Audio Routing Created

After running the script:

```text
01 Percussion Impulses  -> 10 ICST MultiEncoder input 1
02 Depth Drone          -> 10 ICST MultiEncoder input 2
03 Melody               -> 10 ICST MultiEncoder input 3

10 ICST MultiEncoder    -> 11 B-Format Master HOA Bus
11 B-Format Master      -> 12 Binaural Monitor / Decoder
12 Binaural Monitor     -> Master output
```

The master sends of the three sources, the encoder track and the B-Format master are disabled. Only the decoder/monitor track is routed to the master. For B-Format exports, render directly from `11 B-Format-Master HOA Bus` rather than from the decoder.

## Suggested Spatial Trajectories

- Percussion: circular azimuth, clear localisation, short distance.
- Drone: slowly pull towards the back/above, increase distance/spread, reduce level and high frequencies slightly.
- Melody: independent counter-movement to the percussion; let them cross at two points.

## Listening Questions

- When does movement read as a line, and when only as an effect?
- Which source occupies the foreground?
- How diffuse can the drone become before it obscures the contours of the other sources?
- Does a spatial counterpoint emerge between percussion and melody, or merely a left/right alternation?
