---
title: ICST AmbiDecoder – Multi-Decoder Mode
description: "How to use the Multi-Decoder Mode in ICST AmbiDecoder v3.2 — four independent decoders for complex loudspeaker arrays."
date: 2025-11-10T10:00:00
year: 2025
month: 2025-11
weight: 11
tags: ["decoder", "multi-decoder", "v3.2", "loudspeaker", "spatial audio"]
---
Institute for Computer Music and Sound Technology (ICST) Zurich University of the Arts

---

# Multi-Decoder Mode

The **Multi-Decoder Mode**, introduced in **ICST AmbiDecoder v3.2**, allows you to run up to **four fully independent decoders** within a single plugin instance. This is ideal for complex loudspeaker setups that combine different speaker arrays — for example, a main Ambisonics ring together with height speakers, a subwoofer group, or a separate near-field array.

![Multi-Decoder overview](Multidecoder.png)

---

## When to use Multi-Decoder Mode

Use Multi-Decoder Mode when your setup includes:

- **Multiple speaker layers** (e.g. horizontal ring + height dome)
- **Mixed-order decoding** (e.g. 3rd order for horizontal, 1st order for height)
- **Different speaker geometries** that require separate presets
- **Independent gain and filter settings** per group of loudspeakers

For straightforward setups (single array, single geometry), the standard single-decoder mode is sufficient.

---

## Activating Multi-Decoder Mode

1. Open the **ICST AmbiDecoder** plugin in your REAPER FX chain.
2. In the **Decoder Settings** panel, locate the **Multi-Decoder** toggle.
3. Enable Multi-Decoder Mode — four decoder slots (A, B, C, D) will appear.

> [!Tip:]
> Each decoder slot is fully independent and can be configured separately without affecting the others.

---

## Configuring Each Decoder

For each of the four decoders, you can set:

### 1. Name and Color
- Give each decoder a descriptive name (e.g. "Ring", "Height", "Sub", "Near").
- Assign a custom color for easy identification in the UI.

### 2. Loudspeaker Selection
- Each decoder has its **own speaker selection**.
- Assign specific speakers from your loudspeaker preset to each decoder.
- Speakers can only belong to one decoder at a time.

### 3. Ambisonics Order
- Set the **decoding order independently** per decoder (1st to 7th order).
- Lower orders (1st–2nd) are suitable for sparse or difficult speaker geometries.
- Higher orders (3rd–7th) give more precise localisation for dense arrays.

### 4. Ambisonics Weighting
- Choose the weighting scheme (e.g. MaxRe, inPhase, Basic) per decoder.
- MaxRe is recommended for most practical setups.

### 5. Filters
- Eight filter options are available per decoder.
- Adjust per-decoder EQ and spatial filtering independently.

### 6. Mute and Gain
- Each decoder has an independent **mute** button and **gain** control.
- Use mute to isolate individual decoders during setup and testing.

---

## Routing in REAPER

When using Multi-Decoder Mode, the plugin still receives the same **B-Format master bus** as input. The routing within the plugin distributes the signal to each decoder internally.

Output channels are assigned sequentially:
- Decoder A → Outputs 1–N (based on its speaker count)
- Decoder B → Outputs N+1–M
- Decoder C → continues after B
- Decoder D → continues after C

Make sure your REAPER track has enough output channels configured to cover all speakers across all four decoders.

> [!Attention:]
> Check your track channel count and routing carefully. Missing channels will result in silent speakers without any error message.

---

## Speaker Testing

To verify each decoder:

1. **Mute** decoders B, C, and D.
2. Click **Speaker Test** on decoder A and step through its speakers.
3. Repeat for each decoder after unmuting it.

Use `Shift + Control + S` / `Shift + Control + M` (macOS) for keyboard-based solo and mute during testing.

---

## Example: Horizontal Ring + Height Dome

A common multi-decoder use case at ICST is an **Oktagon ring** (8 speakers, horizontal) combined with a **height layer** (4 elevated speakers):

| Decoder | Speakers        | Order | Weighting |
|---------|----------------|-------|-----------|
| A       | Ring (1–8)      | 3rd   | MaxRe     |
| B       | Height (9–12)   | 1st   | MaxRe     |

This setup allows fine-tuned decoding for each layer independently, with separate gain compensation for the height speakers.

---

## Further Resources

- 📖 [ICST AmbiDecoder Wiki](https://github.com/schweizerweb/icst-ambisonics-plugins/wiki)
- 📥 [Download v3.2](https://github.com/schweizerweb/icst-ambisonics-plugins/releases)
- 📺 [ICST Ambisonics Videos on YouTube](https://www.youtube.com/@ZHDK_ICST/search?query=ambisonics+plugins)

---
<span style="font-size:9px;color:#9f9f9f;">©2025 ICST</span>