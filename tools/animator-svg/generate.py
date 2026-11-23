#!/usr/bin/env python3
"""Generate the SVG figures for the ICST Animator docs page.

Output goes into the page bundle content/ICST Ambisonics Plugins/11_animator/:

  anim-startwert-de.svg / anim-startwert-en.svg   start value: defined vs. taken over
  anim-typ-<slug>.svg                            one top-view path per movement type

The movement paths reproduce the formulas of Encoder/Source/AnimatorMath.h
(schweizerweb/icst-ambisonics-plugins, branch animator-3), including the
PerlinNoise used by Random Walk, so the drawings match what the plug-in plays.
Coordinates follow the AmbiEncoder XY radar: +X right, +Y up; positive
Rotations run clockwise.

Run from the repository root:  python3 tools/animator-svg/generate.py
"""

import math
from pathlib import Path

OUT = Path(__file__).resolve().parents[2] / "content" / "ICST Ambisonics Plugins" / "11_animator"

MOVE = "#e64980"   # movement colour (same as the Grundkonzept figure)
ACTION = "#339af0"  # action colour
FONT = "font-family=\"sans-serif\""


def f(v):
    return f"{v:.1f}".rstrip("0").rstrip(".")


# ---------------------------------------------------------------------------
# Figure 1: start value defined vs. taken over
# ---------------------------------------------------------------------------

STARTWERT_TEXT = {
    "de": {
        "aria": "Drei Durchläufe einer Rotation Z um 90 Grad. Mit Use Start Value 0 Grad läuft jeder Durchlauf von 0 auf 90 Grad. "
                "Ohne Startwert beginnt jeder Durchlauf am Ende des vorigen: 0 bis 90, 90 bis 180, 180 bis 270 Grad.",
        "clip": "Action-Clip: Rotation Z, Relative During Clip 90°",
        "top": "Use Start Value 0° (festgelegt)",
        "top2": "jeder Lauf gleich",
        "bottom": "ohne Startwert (übernommen)",
        "bottom2": "jeder Lauf baut auf dem vorigen auf",
        "snap": "Sprung auf 0°",
        "play": "Play {}",
        "stop": "Stop",
    },
    "en": {
        "aria": "Three runs of a 90 degree Rotation Z. With Use Start Value 0 degrees every run goes from 0 to 90 degrees. "
                "Without a start value each run begins where the previous one ended: 0 to 90, 90 to 180, 180 to 270 degrees.",
        "clip": "Action clip: Rotation Z, Relative During Clip 90°",
        "top": "Use Start Value 0° (defined)",
        "top2": "every run the same",
        "bottom": "no start value (taken over)",
        "bottom2": "each run builds on the previous one",
        "snap": "jump to 0°",
        "play": "Play {}",
        "stop": "Stop",
    },
}


def startwert_svg(lang):
    t = STARTWERT_TEXT[lang]
    W, H = 640, 432
    x0, x1 = 64, 588
    runs = [(0.0, 1.0), (1.35, 2.35), (2.7, 3.7)]
    tmax = 3.7
    sx = lambda tt: x0 + (x1 - x0) * tt / tmax
    panels = [(96, 206), (276, 386)]  # (top, bottom) of each plot, 0..270 deg
    sy = lambda p, deg: panels[p][1] - (panels[p][1] - panels[p][0]) * deg / 270.0
    pid = f"sw-{lang}"

    o = []
    o.append(f'<svg viewBox="0 0 {W} {H}" width="100%" style="max-width:{W}px;color:inherit" role="img" aria-label="{t["aria"]}">')
    o.append(f'  <defs><marker id="{pid}-ah" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">'
             f'<path d="M0,0 L10,5 L0,10 z" fill="currentColor"/></marker></defs>')

    # clip strip
    for i, (a, b) in enumerate(runs):
        o.append(f'  <rect x="{f(sx(a))}" y="22" width="{f(sx(b) - sx(a))}" height="20" rx="4" fill="{ACTION}" fill-opacity=".18" stroke="{ACTION}" stroke-width="1.2"/>')
        o.append(f'  <path d="M{f(sx(a) + 8)} 27 l-4 6 h4 l-2 5 l7 -8 h-4 l2 -3 z" fill="{ACTION}"/>')
    o.append(f'  <text x="{x0}" y="16" {FONT} font-size="14" fill="currentColor" opacity=".8">{t["clip"]}</text>')

    for p in range(2):
        top, bottom = panels[p]
        # clip shading + grid
        for a, b in runs:
            o.append(f'  <rect x="{f(sx(a))}" y="{top}" width="{f(sx(b) - sx(a))}" height="{bottom - top}" fill="{ACTION}" fill-opacity=".06"/>')
        for deg in (0, 90, 180, 270):
            y = sy(p, deg)
            o.append(f'  <line x1="{x0}" y1="{f(y)}" x2="{x1}" y2="{f(y)}" stroke="currentColor" stroke-width="{1 if deg == 0 else .6}" opacity="{.5 if deg == 0 else .22}"/>')
            o.append(f'  <text x="{x0 - 8}" y="{f(y + 4)}" text-anchor="end" {FONT} font-size="13" fill="currentColor" opacity=".7">{deg}°</text>')
        title = t["top"] if p == 0 else t["bottom"]
        sub = t["top2"] if p == 0 else t["bottom2"]
        o.append(f'  <text x="{x0}" y="{top - 14}" {FONT} font-size="16" font-weight="600" fill="{ACTION}">{title}'
                 f'<tspan font-weight="400" fill="currentColor" opacity=".75"> – {sub}</tspan></text>')

        # value curve
        starts = [0, 0, 0] if p == 0 else [0, 90, 180]
        for i, (a, b) in enumerate(runs):
            s = starts[i]
            o.append(f'  <line x1="{f(sx(a))}" y1="{f(sy(p, s))}" x2="{f(sx(b))}" y2="{f(sy(p, s + 90))}" stroke="{ACTION}" stroke-width="3" stroke-linecap="round"/>')
            o.append(f'  <circle cx="{f(sx(b))}" cy="{f(sy(p, s + 90))}" r="4" fill="{ACTION}"/>')
            o.append(f'  <text x="{f(sx(b))}" y="{f(sy(p, s + 90) - 9)}" text-anchor="middle" {FONT} font-size="15" font-weight="600" fill="currentColor">{s + 90}°</text>')
            if i < 2:
                nxt = runs[i + 1][0]
                # state is held while stopped
                o.append(f'  <line x1="{f(sx(b))}" y1="{f(sy(p, s + 90))}" x2="{f(sx(nxt))}" y2="{f(sy(p, s + 90))}" stroke="currentColor" stroke-width="1.4" stroke-dasharray="3 3" opacity=".55"/>')
                if p == 0:
                    o.append(f'  <line x1="{f(sx(nxt))}" y1="{f(sy(p, 90) + 3)}" x2="{f(sx(nxt))}" y2="{f(sy(p, 0) - 5)}" stroke="currentColor" stroke-width="1.4" stroke-dasharray="3 3" marker-end="url(#{pid}-ah)"/>')
        if p == 0:
            o.append(f'  <text x="{f(sx(runs[1][0]) - 6)}" y="{f(sy(0, 45) + 4)}" text-anchor="end" {FONT} font-size="13" fill="currentColor" opacity=".8">{t["snap"]}</text>')

    # time labels
    yl = panels[1][1] + 22
    for i, (a, b) in enumerate(runs):
        o.append(f'  <text x="{f((sx(a) + sx(b)) / 2)}" y="{yl}" text-anchor="middle" {FONT} font-size="15" fill="currentColor">{t["play"].format(i + 1)}</text>')
        if i < 2:
            o.append(f'  <text x="{f((sx(b) + sx(runs[i + 1][0])) / 2)}" y="{yl}" text-anchor="middle" {FONT} font-size="13" fill="currentColor" opacity=".6">{t["stop"]}</text>')
    o.append(f'  <line x1="{x0}" y1="{yl + 10}" x2="{x1}" y2="{yl + 10}" stroke="currentColor" stroke-width="1" opacity=".4" marker-end="url(#{pid}-ah)"/>')
    o.append("</svg>")
    return "\n".join(o) + "\n"


# ---------------------------------------------------------------------------
# Figure 2: movement types (formulas from AnimatorMath.h)
# ---------------------------------------------------------------------------

M32 = 0xFFFFFFFF


def perlin_hash(seed, i):
    h = (seed ^ (i & M32)) & M32
    h ^= h >> 16
    h = (h * 0x85EBCA6B) & M32
    h ^= h >> 13
    h = (h * 0xC2B2AE35) & M32
    h ^= h >> 16
    return h


def noise1d(seed, t):
    i0 = math.floor(t)
    fr = t - i0
    g0 = perlin_hash(seed, i0) / M32 * 2 - 1
    g1 = perlin_hash(seed, i0 + 1) / M32 * 2 - 1
    d0, d1 = g0 * fr, g1 * (fr - 1)
    u = fr * fr * fr * (fr * (fr * 6 - 15) + 10)
    return d0 + u * (d1 - d0)


def walk_seed(user_seed, axis):
    h = (user_seed * 2654435761) & M32
    h ^= (axis * 0x9E3779B9) & M32
    h ^= h >> 15
    h = (h * 0x2545F491) & M32
    h ^= h >> 13
    return h


def cardinal(points, tension, closed, n=24):
    out = []
    cnt = len(points)
    spans = cnt if closed else cnt - 1
    idx = (lambda i: i % cnt) if closed else (lambda i: max(0, min(cnt - 1, i)))
    for s in range(spans):
        p0, p1, p2, p3 = (points[idx(s - 1)], points[idx(s)], points[idx(s + 1)], points[idx(s + 2)])
        m1 = [(p2[k] - p0[k]) * 0.5 * (1 - tension) for k in range(2)]
        m2 = [(p3[k] - p1[k]) * 0.5 * (1 - tension) for k in range(2)]
        for j in range(n + (1 if s == spans - 1 else 0)):
            u = j / n
            u2, u3 = u * u, u * u * u
            h00, h10 = 2 * u3 - 3 * u2 + 1, u3 - 2 * u2 + u
            h01, h11 = -2 * u3 + 3 * u2, u3 - u2
            out.append(tuple(p1[k] * h00 + m1[k] * h10 + p2[k] * h01 + m2[k] * h11 for k in range(2)))
    return out


WAYPOINTS = [(-0.72, -0.38), (-0.38, 0.62), (0.42, 0.55), (0.78, -0.18), (0.08, -0.7)]


def sample(fn, n=400):
    return [fn(i / n) for i in range(n + 1)]


def types():
    T = {}
    # MoveTo (Cartesian): straight line start -> target
    s, e = (-0.7, -0.5), (0.68, 0.55)
    T["moveto-cartesian"] = dict(path=sample(lambda p: (s[0] + (e[0] - s[0]) * p, s[1] + (e[1] - s[1]) * p)),
                                 start=s, target=e)
    # MoveTo (Polar): shortest azimuth arc, constant distance, listener at origin
    r, a0, a1 = 0.72, math.radians(130), math.radians(-130)
    d = a1 - a0
    if d > math.pi: d -= 2 * math.pi
    if d < -math.pi: d += 2 * math.pi
    T["moveto-polar"] = dict(path=sample(lambda p: (r * math.cos(a0 + d * p), r * math.sin(a0 + d * p))),
                             start=(r * math.cos(a0), r * math.sin(a0)), target=(r * math.cos(a1), r * math.sin(a1)),
                             listener=True, ring=r)
    # Circle: Rotations 1, centre (0,0), start on top
    r, a0 = 0.72, math.pi / 2
    T["circle"] = dict(path=sample(lambda p: (r * math.cos(a0 - 2 * math.pi * p), r * math.sin(a0 - 2 * math.pi * p))),
                       start=(0, r), center=(0, 0), arrow_at=0.2)
    # Spiral: Rotations 2, Radius change -0.3 per rotation
    r0, cnt, rc = 0.82, 2, -0.3
    def spiral(p):
        a = 0 - 2 * math.pi * cnt * p
        rr = max(0.0, r0 + rc * cnt * p)
        return (rr * math.cos(a), rr * math.sin(a))
    T["spiral"] = dict(path=sample(spiral), start=(r0, 0), center=(0, 0), arrow_at=0.12)
    # Helix: Rotations 3, Height rise 1.3, drawn as an oblique view (y squashed, z up)
    r0, cnt, rise, z0 = 0.62, 3, 1.3, -0.68
    def helix(p):
        a = -math.pi / 2 - 2 * math.pi * cnt * p
        x, y, z = r0 * math.cos(a), r0 * math.sin(a), z0 + rise * p
        return (x, z + 0.28 * y)
    T["helix"] = dict(path=sample(helix, 600), start=helix(0), axis=((0, z0), (0, z0 + rise)), arrow_at=None)
    # Spline: Tension 0.5, closed
    T["spline"] = dict(path=cardinal(WAYPOINTS, 0.5, True), start=WAYPOINTS[0], waypoints=WAYPOINTS, arrow_at=0.1)
    # Polygon: closed
    T["polygon"] = dict(path=WAYPOINTS + [WAYPOINTS[0]], start=WAYPOINTS[0], waypoints=WAYPOINTS, arrow_at=0.1, linear=True)
    # Lissajous: Rotations 1, Frequency X 3 / Y 2, Phase 90°, amplitude from start offset
    ax, ay, fa, fb, ph = 0.78, 0.72, 3, 2, math.radians(90)
    lis = lambda p: (ax * math.sin(fa * 2 * math.pi * p + ph), ay * math.sin(fb * 2 * math.pi * p))
    T["lissajous"] = dict(path=sample(lis, 600), start=lis(0), center=(0, 0), arrow_at=0.04)
    # Rose: Rotations 1, Petals 3, Phase 0
    R, k = 0.8, 3
    def rose(p):
        sw = -2 * math.pi * p
        rr = R * math.cos(k * sw)
        return (rr * math.cos(sw), rr * math.sin(sw))
    T["rose"] = dict(path=sample(rose, 600), start=(R, 0), center=(0, 0), arrow_at=0.03)
    # Random Walk: Wander cycles 2.5, Seed 1; amplitude = 2 * |start - centre|.
    # (PerlinNoise is 0 at integer t, so whole-number cycles pass back through the start point.)
    c, st = (0.0, 0.0), (-0.22, 0.1)
    amp = 2 * math.hypot(st[0] - c[0], st[1] - c[1])
    sxs, sys_ = walk_seed(1, 0), walk_seed(1, 1)
    def walk(p):
        t = 2.5 * p
        return (st[0] + amp * (noise1d(sxs, t) - noise1d(sxs, 0)), st[1] + amp * (noise1d(sys_, t) - noise1d(sys_, 0)))
    pts = sample(walk)
    T["random-walk"] = dict(path=pts, start=st)
    return T


def type_svg(slug, d):
    S, pad = 160, 16
    xs = [p[0] for p in d["path"]] + [d["start"][0]]
    ys = [p[1] for p in d["path"]] + [d["start"][1]]
    # fixed [-1,1] frame, except Random Walk which is fitted to its path
    if slug == "random-walk":
        cx, cy = (max(xs) + min(xs)) / 2, (max(ys) + min(ys)) / 2
        half = max(max(xs) - min(xs), max(ys) - min(ys)) / 2 * 1.15
    else:
        cx = cy = 0.0
        half = 1.0
    tx = lambda x: pad + (x - (cx - half)) / (2 * half) * (S - 2 * pad)
    ty = lambda y: S - pad - (y - (cy - half)) / (2 * half) * (S - 2 * pad)
    P = lambda pt: f"{f(tx(pt[0]))},{f(ty(pt[1]))}"
    mid = f"amt-{slug}-ah"

    o = [f'<svg viewBox="0 0 {S} {S}" width="100%" style="max-width:{S}px;color:inherit" aria-hidden="true" focusable="false">']
    o.append(f'  <defs><marker id="{mid}" viewBox="0 0 10 10" refX="7" refY="5" markerWidth="5" markerHeight="5" orient="auto">'
             f'<path d="M0,0 L10,5 L0,10 z" fill="{MOVE}"/></marker></defs>')
    o.append(f'  <rect x="1" y="1" width="{S - 2}" height="{S - 2}" rx="10" fill="none" stroke="currentColor" stroke-opacity=".15"/>')
    if "ring" in d:
        o.append(f'  <circle cx="{f(tx(0))}" cy="{f(ty(0))}" r="{f(d["ring"] / (2 * half) * (S - 2 * pad))}" fill="none" stroke="currentColor" stroke-opacity=".3" stroke-dasharray="2 3"/>')
    if "axis" in d:
        a, b = d["axis"]
        o.append(f'  <line x1="{f(tx(a[0]))}" y1="{f(ty(a[1]))}" x2="{f(tx(b[0]))}" y2="{f(ty(b[1]))}" stroke="currentColor" stroke-opacity=".35" stroke-dasharray="3 3"/>')
    if "waypoints" in d and not d.get("linear"):
        pts = d["waypoints"] + [d["waypoints"][0]]
        o.append(f'  <polyline points="{" ".join(P(p) for p in pts)}" fill="none" stroke="currentColor" stroke-opacity=".25" stroke-dasharray="2 3"/>')

    path = d["path"]
    closed_path = math.hypot(path[0][0] - path[-1][0], path[0][1] - path[-1][1]) < 1e-3
    end_marker = "" if closed_path else f' marker-end="url(#{mid})"'
    o.append(f'  <polyline points="{" ".join(P(p) for p in path)}" fill="none" stroke="{MOVE}" stroke-width="2.4" stroke-linejoin="round" stroke-linecap="round"{end_marker}/>')

    # direction arrow part-way along a closed path
    if d.get("arrow_at"):
        if d.get("linear"):
            a, b = path[0], path[1]
            m = ((a[0] + b[0]) / 2, (a[1] + b[1]) / 2)
            n = (m[0] + (b[0] - a[0]) * 0.02, m[1] + (b[1] - a[1]) * 0.02)
        else:
            i = int(d["arrow_at"] * (len(path) - 1))
            m, n = path[i], path[min(i + 2, len(path) - 1)]
        o.append(f'  <line x1="{P(m).split(",")[0]}" y1="{P(m).split(",")[1]}" x2="{P(n).split(",")[0]}" y2="{P(n).split(",")[1]}" stroke="{MOVE}" stroke-width="2.4" marker-end="url(#{mid})"/>')

    for w in d.get("waypoints", []):
        o.append(f'  <rect x="{f(tx(w[0]) - 3.5)}" y="{f(ty(w[1]) - 3.5)}" width="7" height="7" fill="none" stroke="currentColor" stroke-width="1.6"/>')
    if "center" in d:
        c = d["center"]
        o.append(f'  <path d="M{f(tx(c[0]) - 6)} {f(ty(c[1]))} h12 M{f(tx(c[0]))} {f(ty(c[1]) - 6)} v12" stroke="currentColor" stroke-width="1.8"/>')
    if d.get("listener"):
        # listener: head seen from above, nose pointing up (front)
        o.append(f'  <path d="M{f(tx(0) - 3.5)} {f(ty(0) - 5)} L{f(tx(0))} {f(ty(0) - 11)} L{f(tx(0) + 3.5)} {f(ty(0) - 5)} z" fill="currentColor" fill-opacity=".55"/>')
        o.append(f'  <circle cx="{f(tx(0))}" cy="{f(ty(0))}" r="6.5" fill="currentColor" fill-opacity=".55"/>')
    if "target" in d:
        t = d["target"]
        o.append(f'  <circle cx="{f(tx(t[0]))}" cy="{f(ty(t[1]))}" r="5" fill="none" stroke="currentColor" stroke-width="1.8"/>')
    s = d["start"]
    o.append(f'  <circle cx="{f(tx(s[0]))}" cy="{f(ty(s[1]))}" r="4.5" fill="currentColor"/>')
    o.append("</svg>")
    return "\n".join(o) + "\n"


def main():
    for lang in ("de", "en"):
        (OUT / f"anim-startwert-{lang}.svg").write_text(startwert_svg(lang), encoding="utf-8")
    for slug, d in types().items():
        (OUT / f"anim-typ-{slug}.svg").write_text(type_svg(slug, d), encoding="utf-8")
    print("written to", OUT)


if __name__ == "__main__":
    main()
