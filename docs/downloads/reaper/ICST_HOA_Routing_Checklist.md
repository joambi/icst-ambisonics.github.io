# ICST HOA Routing Checklist

## Before you start
- Open the REAPER project and save it under a new name.
- Verify audio device, sample rate, and buffer size.
- Make sure the required ICST Ambisonics plugins are installed.

## Channel count
- Set the Master track to `64` channels.
- Set all HOA-relevant tracks to `64` channels.
- Match the decoder output to the actual loudspeaker setup.

## Signal flow
- Sources feed a clearly named HOA bus.
- The HOA bus feeds the decoder.
- The optional binaural monitoring path comes from the same HOA bus.
- Avoid accidental direct source-to-master routes.

## Plugin placement
- On source tracks: `ICST MonoEncoder` or `ICST MultiEncoder`.
- On the decoder track: the decoder plugin that matches the loudspeaker setup.
- Load the decoder preset before rehearsing or recording.

## Quick test
- Solo a single source.
- Move the encoder position slightly and listen for the expected spatial change.
- Confirm level on the HOA bus.
- Confirm the decoder outputs reach the expected speakers.
- If binaural monitoring is used, check the headphone path separately.

## Common mistakes
- One track in the HOA path is not set to `64` channels.
- The decoder is placed on the Master instead of after the HOA bus.
- The wrong loudspeaker preset is loaded.
- Sources still send directly to Master.
- Monitoring is happening through the wrong output path.

## Before recording or export
- Run one more short test signal.
- Save a project version.
- Document export format and channel ordering.
