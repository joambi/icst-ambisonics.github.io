# ICST Kristall Motion Map — What's New

## v2.2.8 — Reset → Cubic Default
**New:** The **Reset** button in the status bar now loads the **Cubic 2×2×2 preset** (8 instances with breathing motion) instead of a single blank instance. Reset now gives an immediately playable starting state rather than an empty canvas.

---

## v2.2.7 — ↺ Def Button
**New:** A small **↺ Def** button appears in the top-right corner of the Instance parameter panel (always visible, does not scroll away). Clicking it restores all parameter values of the selected instance(s) to factory defaults — position, offsets, rate, step count, repetition mode, rotation, scale, bounds, and smoothing are all reset. The instance **name** and **colour** are preserved so it stays identifiable in the list. Works as a batch operation: if multiple instances are selected (Shift-click or Cmd+A), all are reset at once.

---

## v2.2.6 — Cmd+A · Cubic Breathing
**New — Cmd+A:** Pressing **Cmd+A** selects all instances at once, filling the multi-select set. A status message confirms how many were selected. The shortcut works alongside existing Shift-click and Shift-drag multi-select.

**New — Cubic preset motion:** The **Cubic** preset now generates actual movement. Each corner instance is given an inward-pointing offset vector so it oscillates from its lattice position toward the centre (0, 0, 0) and back, in PingPong mode. All 8 corners converge simultaneously, creating a "breathing cube" effect. Previously all offsets were zero and the preview was static.

---

## v2.2.5 — Cmd+Click+Drag to Scrub Values
**New:** **Cmd+click and drag vertically** on any numeric value field to scrub its value without typing. Drag up to increase, drag down to decrease. Hold **Shift** additionally for a finer (×0.1) step. The scrub respects the same per-key step sizes as the scroll nudge and propagates to all selected instances as a relative delta.

*Background: Cmd+scroll was the original plan but macOS intercepts that gesture at the system level before REAPER's GFX window receives it, so vertical drag was used instead.*

---

## v2.2.4 — Plain Scroll to Nudge (no Cmd required)
**Change:** Removed the Cmd modifier requirement from the scroll-nudge feature introduced in v2.2.3. **Plain scroll wheel** on a focused value field now adjusts the value. Cmd+scroll was silently intercepted by macOS and never reached the script.

---

## v2.2.3 — Scroll Wheel Value Nudge
**New:** **Click any value field** to focus it, then **scroll the mouse wheel** to nudge the value without typing. Each scroll notch increments or decrements by a key-appropriate step:

| Field type | Step |
|---|---|
| Step Count | 1 (integer) |
| Rotation fields | 1.0° |
| Offset fields | 0.005 |
| Rate | 0.05 |
| Start position | 0.01 |
| Smoothing / Glide | 0.01 |
| Global Rate | 0.1 |
| Global Move / Trans | 0.01 |
| Global Rotation | 1.0° |
| Global Zoom | 0.01 |

Hold **Shift** while scrolling for a ×10 coarser step.

---

## v2.2.2 — Bug Fixes

**Bug fix — Mouse wheel had no effect on value fields:** The `pField` draw helper registered param-field entries in `ui.param_fields` without storing the `inst` reference. The wheel handler checked `f.inst` to identify numeric fields and nudge their values, but since `f.inst` was always `nil`, every scroll event fell through to panel scrolling instead of value adjustment. Fixed by adding `inst=inst` to every `pField` registration.

**Bug fix — Shift+drag on lattice dots hit wrong positions:** The hit-test coordinates for the lattice preview dots were computed from a stale comment that described a different call signature for `drawLatticePreview`. The actual call is `drawLatticePreview(right_x, 0, right_w, prev_h)`, giving `cy = prev_h × 0.55` and `iso_scale = min(right_w, prev_h) × 0.17`. The old code used an extra `prev_h` offset for `cy` and used the param-panel height instead of the preview height for `iso_scale`, placing the hit targets far from the visible dots. Fixed to match the actual draw call.
