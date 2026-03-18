---
title: "Formats, Stems, and Archiving"
description: "B-format archiving conventions, stem structure, and delivery formats for festivals, labels, streaming, and long-term preservation."
date: 2026-01-01T00:00:00
weight: 84
draft: false
translationKey: "composing-formats-archiving"
---

Finishing a composition in Ambisonics raises an immediate practical question: what do you actually hand over, and to whom? The answer depends on the context — festival performance, label release, streaming platform, or long-term archive — and each requires a different format or combination of formats. Getting this right from the beginning of a project avoids costly re-exports and ensures the work remains accessible and decodable in the future.

## The B-Format Master: The Archival Core

The most important file to preserve is the **B-format master** — the encoded Ambisonics signal before any decoding or downmix. This is the format-agnostic archival version from which any future playback format can be derived: loudspeaker arrays of any geometry, binaural stereo, stereo downmix, or formats not yet invented.

### AmbiX vs. FuMa

Two conventions exist for storing B-format signals in audio files:

| Convention | Channel order | Normalisation | Status |
|------------|--------------|---------------|--------|
| **AmbiX** | ACN (W, Y, Z, X, …) | SN3D | Current standard; used by IEM, SPARTA, YouTube 360, Apple |
| **FuMa** | W, X, Y, Z, … | MaxN | Legacy; used in older Cycling '74 and SuperCollider tools |

**Always archive in AmbiX.** FuMa support is declining and many modern tools do not recognise it. If you receive material in FuMa, convert to AmbiX before archiving using tools such as the IEM MultichannelConverter or the `ambix_converter` utility.

### HOA Order and Channel Count

The number of channels in a B-format file depends on the Ambisonics order:

| Order | Channels (3D) | Channels (2D) |
|-------|--------------|--------------|
| 1st (FOA) | 4 | 3 |
| 2nd | 9 | 5 |
| 3rd | 16 | 7 |
| 5th | 36 | 11 |
| 7th | 64 | 15 |

Archive at the **highest order used during production**. Downsampling to a lower order loses spatial resolution permanently; upsizing from a lower order adds no information. If the piece was produced in 3rd-order Ambisonics, archive 16 channels. Do not reduce to 4 channels for storage convenience.

### File Format and Technical Specifications

- **Container**: WAV (Broadcast WAV / BWF recommended for embedded metadata) or AIFF
- **Bit depth**: 24-bit minimum; 32-bit float preserves headroom and avoids clipping during processing
- **Sample rate**: 48 kHz (broadcast/film standard) or 96 kHz (high-resolution audio); avoid 44.1 kHz for spatial audio masters
- **Metadata**: embed the AmbiX channel order tag in the file's metadata where possible; include a README or sidecar text file documenting the convention, order, and normalisation

## Stems

A full stem package documents the compositional layers and allows future remix, spatialisation for different venues, or archival reconstruction. A typical Ambisonics stem structure includes:

**Source stems** (pre-spatialisation):
- Individual dry or lightly processed mono/stereo sources, labelled by instrument or layer
- Useful for re-spatialisation if the target venue differs significantly from the production context

**Spatial bus stem**:
- The encoded B-format mix of all spatialised sources, without master processing (no limiting, no bus EQ)
- This is the primary creative document of the spatial decisions made during production

**Master B-format stem**:
- The final B-format output with all master processing applied
- The file sent to a decoder or used for all format derivations

**Derived delivery stems**:
- Binaural stereo (with HRTF documented)
- Loudspeaker multichannel renders (see below)
- Stereo downmix

Not all contexts require all stems. For a festival performance, the master B-format is often sufficient. For label delivery or institutional archiving, the full stem tree is good practice.

## Concert and Festival Delivery

Festivals and concert venues typically request a **pre-decoded multichannel audio file** matched to their specific loudspeaker layout, rather than a B-format file they decode themselves. Common configurations:

| Format | Channel count | Notes |
|--------|--------------|-------|
| Ring 8 | 8 | Common in smaller venues; decode from B-format in advance |
| Ring 16 | 16 | Mid-sized concert halls; typical ICST setup |
| Ring 24 | 24 | Large-scale festival systems (Acousmonium-style) |
| Dome 24–32 | 24–32 | 3D dome with elevated speakers |
| Custom | Variable | Always request the venue's exact layout file |

**Workflow**: obtain the venue's loudspeaker layout file (typically a `.json` or `.txt` with azimuth/elevation/distance per channel), load it into the ICST Ambisonics Plugins decoder or IEM AllRADecoder, render offline to a multichannel WAV, and deliver.

**Channel order conventions**: confirm with the venue whether they use standard interleaved channel order or a custom mapping. A mislabelled channel order can result in inverted or rotated spatial images at the concert — always request a technical check before the premiere.

**File naming**: use a clear naming scheme, e.g.:
```
PieceTitle_24ch_ring_48k24b.wav
PieceTitle_binaural_KU100_48k24b.wav
PieceTitle_ambiX_3OA_48k32f.wav
```

## Streaming and Online Distribution

Online platforms handle spatial audio in different ways:

| Platform | Format | Notes |
|----------|--------|-------|
| YouTube 360 | AmbiX FOA (4ch) or spatial audio metadata | Requires specific upload workflow; YouTube applies its own binaural decode |
| Apple Music / Spatial Audio | Dolby Atmos ADM/BWF | Requires Atmos authoring tools; 3rd-party encoder can convert from HOA |
| Bandcamp / SoundCloud | Stereo only | Deliver binaural stereo master |
| Streaming (general) | Stereo | –14 LUFS integrated; –1 dBTP true peak |

For most label and streaming releases, a **binaural stereo master** is the practical distribution format. Document the HRTF used and whether the file is intended for headphone playback only.

## Label and Publisher Delivery

When delivering to a label for a fixed-media release:

- Provide the **B-format master** as the archival source (label keeps it for future re-releases)
- Provide the **binaural stereo master** as the primary release format for streaming
- Provide a **stereo downmix** for compatibility with platforms that do not support binaural tagging
- Include a **technical sheet** documenting: Ambisonics order, normalisation convention, HRTF used for binaural, sample rate, bit depth, and software versions used

Many labels working with spatial audio are still building their archiving practices. Delivering a clear technical sheet helps ensure the work is preserved correctly.

## Long-Term Archiving

Ambisonics formats have changed before (FuMa → AmbiX) and will likely change again. For institutional or personal long-term archives:

- Store the **B-format master in AmbiX** as the primary archival file
- Store **source stems** separately, clearly labelled
- Include a **README** in plain text documenting all technical parameters
- Maintain a **decoded loudspeaker render** (e.g., 8-channel ring) as a secondary archival format — this is immediately playable even if the decoding tools of the future have changed
- Consider storing a **binaural stereo version** as the most accessible long-term listening copy

Software, plugins, and operating systems change. A raw B-format WAV with a plain-text README is more durable than a project file that depends on a specific plugin version.

## Checklist

Before closing a project:

- [ ] B-format master exported at full production order (AmbiX, 24-bit or 32-bit float, 48 kHz+)
- [ ] Source stems exported and labelled
- [ ] Binaural stereo master exported, HRTF documented
- [ ] Stereo downmix exported
- [ ] Multichannel render for primary performance venue exported
- [ ] Technical sheet written (order, normalisation, HRTF, software, sample rate, bit depth)
- [ ] All files backed up in at least two locations
