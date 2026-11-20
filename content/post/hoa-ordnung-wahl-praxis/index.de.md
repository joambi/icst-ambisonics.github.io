---
title: Welche Ambisonics-Ordnung brauche ich? – HOA-Wahl in der Praxis
description: "FOA, HOA3 oder HOA7? Dieser Artikel erklärt, wann welche Ordnung sinnvoll ist: Kanalzahl, räumliche Auflösung, Lautsprecher-Anforderungen, CPU-Last und binaural – als klare Entscheidungshilfe für den Produktionsalltag."
date: 2026-03-21T18:00:00+01:00
year: 2026
month: 2026-03
weight: 38
tags: ["hoa", "foa", "ordnung", "order", "kanalzahl", "workflow", "konzept", "reaper"]
key_points:
  - "Die Formel (N+1)² bestimmt die Kanalzahl: 1st=4, 3rd=16, 7th=64 Kanäle"
  - "Das Lautsprecher-System ist der limitierende Faktor – nicht die DAW"
  - "So hoch wie die CPU erlaubt arbeiten (idealerweise HOA7): die Ordnung lässt sich später reduzieren, aber nie nachträglich erhöhen"
difficulty: "beginner"
post_kind: "background"
---

Level: Beginner–Intermediate | **Audience:** Komponist:in, Producer:in, alle die eine neue Ambisonics-Session aufsetzen.

---

Die Wahl der Ambisonics-Ordnung ist eine der ersten Entscheidungen jeder Produktion – und sie bestimmt Kanalzahl, CPU-Last, Plugin-Anforderungen und die klangliche Qualität auf einem Lautsprecher-System. Dieser Artikel erklärt die Zusammenhänge ohne Mathematik und gibt klare Empfehlungen für typische Situationen.

---

## Die Grundformel

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 205" role="img" aria-label="Die Kanalzahl wächst mit dem Quadrat der Ordnung" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar1" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><circle cx="149.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="158.5" cy="64.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="149.5" cy="73.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="158.5" cy="73.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><text x="154.0" y="100" text-anchor="middle" font-weight="600" font-size="12">N = 1</text><text x="154.0" y="118" text-anchor="middle" fill="#4a8fe0" font-size="12">4 ch</text><circle cx="225.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="234.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="243.5" cy="64.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="225.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="234.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="243.5" cy="73.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="225.5" cy="82.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="234.5" cy="82.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><circle cx="243.5" cy="82.5" r="2.97" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><text x="234.5" y="109" text-anchor="middle" font-weight="600" font-size="12">N = 2</text><text x="234.5" y="127" text-anchor="middle" fill="#4a8fe0" font-size="12">9 ch</text><circle cx="310.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="319.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="328.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="337.5" cy="64.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="310.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="319.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="328.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="337.5" cy="73.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="310.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="319.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="328.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="337.5" cy="82.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="310.5" cy="91.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="319.5" cy="91.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="328.5" cy="91.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><circle cx="337.5" cy="91.5" r="2.97" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><text x="324.0" y="118" text-anchor="middle" font-weight="600" font-size="12">N = 3</text><text x="324.0" y="136" text-anchor="middle" fill="#3fa968" font-size="12">16 ch</text><circle cx="404.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="413.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="422.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="431.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="440.5" cy="64.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="449.5" cy="64.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="404.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="413.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="422.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="431.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="440.5" cy="73.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="449.5" cy="73.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="404.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="413.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="422.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="431.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="440.5" cy="82.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="449.5" cy="82.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="404.5" cy="91.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="413.5" cy="91.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="422.5" cy="91.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="431.5" cy="91.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="440.5" cy="91.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="449.5" cy="91.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="404.5" cy="100.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="413.5" cy="100.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="422.5" cy="100.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="431.5" cy="100.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="440.5" cy="100.5" r="2.97" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="449.5" cy="100.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="404.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="413.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="422.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="431.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="440.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><circle cx="449.5" cy="109.5" r="2.97" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><text x="427.0" y="136" text-anchor="middle" font-weight="600" font-size="12">N = 5</text><text x="427.0" y="154" text-anchor="middle" fill="#d9a441" font-size="12">36 ch</text><circle cx="516.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="64.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="64.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="72.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="72.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="80.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="80.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="88.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="88.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="96.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="96.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="104.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="104.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="524.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="532.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="540.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="548.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="556.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="564.0" cy="112.0" r="2.64" fill="currentColor" stroke="currentColor" stroke-width="1.5"/><circle cx="572.0" cy="112.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="516.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="524.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="532.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="540.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="548.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="556.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="564.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><circle cx="572.0" cy="120.0" r="2.64" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="544.0" y="146" text-anchor="middle" font-weight="600" font-size="12">N = 7</text><text x="544.0" y="164" text-anchor="middle" fill="#d9534f" font-size="12">64 ch</text><text x="360" y="26" text-anchor="middle" font-weight="600" font-size="15">(N + 1)²</text><text x="360" y="44" text-anchor="middle" font-size="11">jeder Schritt fügt eine L-förmige Schicht neuer Kanäle hinzu</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Punkte sind Kanäle. Das farbige L zeigt, was eine höhere Ordnung hinzufügt: 4, 9, 16, 36, 64 Kanäle bei den Ordnungen 1, 2, 3, 5 und 7.</figcaption>
</figure>














Die Anzahl der Kanäle im B-Format-Master ergibt sich aus der gewählten Ordnung:

**(N + 1)² = Kanalzahl**

| Ordnung | Kanalzahl | Neue Kanäle |
|---|---|---|
| 1st Order (FOA) | **4** | 4 |
| 2nd Order | **9** | 5 |
| 3rd Order | **16** | 7 |
| 4th Order | **25** | 9 |
| 5th Order | **36** | 11 |
| 7th Order | **64** | 15 |

Höhere Ordnung bedeutet: mehr Kanäle, mehr sphärische Information, feinere räumliche Auflösung – und mehr Rechenaufwand.

---

## Was sich mit der Ordnung ändert

### Räumliche Auflösung

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 315" role="img" aria-label="Richtwirkung einer Punktquelle bei verschiedenen Ordnungen" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar2" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><circle cx="300" cy="160" r="57.5" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="2 4"/><circle cx="300" cy="160" r="115" fill="none" stroke="currentColor" stroke-width="1" stroke-dasharray="2 4"/><line x1="300" y1="37" x2="300" y2="283" stroke="currentColor" stroke-width="1" opacity="0.3"/><line x1="177" y1="160" x2="423" y2="160" stroke="currentColor" stroke-width="1" opacity="0.3"/><polyline points="300.0,45.0 304.0,45.1 308.0,45.5 312.0,46.0 315.9,46.8 319.8,47.8 323.6,49.1 327.3,50.5 330.9,52.2 334.4,54.0 337.8,56.1 341.1,58.3 344.2,60.7 347.2,63.3 350.0,66.0 352.6,68.9 355.1,71.9 357.3,75.0 359.4,78.2 361.3,81.5 363.0,84.9 364.4,88.4 365.7,92.0 366.7,95.6 367.6,99.2 368.2,102.8 368.6,106.4 368.8,110.0 368.7,113.6 368.5,117.2 368.1,120.7 367.4,124.1 366.6,127.5 365.6,130.8 364.4,134.0 363.1,137.0 361.5,140.0 359.9,142.8 358.1,145.5 356.1,148.1 354.0,150.5 351.8,152.7 349.6,154.8 347.2,156.7 344.7,158.4 342.2,160.0 339.7,161.4 337.1,162.6 334.4,163.6 331.8,164.5 329.1,165.1 326.5,165.6 323.9,166.0 321.3,166.1 318.8,166.1 316.3,165.9 313.9,165.6 311.5,165.1 309.3,164.5 307.1,163.8 305.1,162.9 303.1,161.9 301.3,160.9 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 298.7,160.9 296.9,161.9 294.9,162.9 292.9,163.8 290.7,164.5 288.5,165.1 286.1,165.6 283.7,165.9 281.2,166.1 278.7,166.1 276.1,166.0 273.5,165.6 270.9,165.1 268.2,164.5 265.6,163.6 262.9,162.6 260.3,161.4 257.8,160.0 255.3,158.4 252.8,156.7 250.4,154.8 248.2,152.7 246.0,150.5 243.9,148.1 241.9,145.5 240.1,142.8 238.5,140.0 236.9,137.0 235.6,134.0 234.4,130.8 233.4,127.5 232.6,124.1 231.9,120.7 231.5,117.2 231.3,113.6 231.2,110.0 231.4,106.4 231.8,102.8 232.4,99.2 233.3,95.6 234.3,92.0 235.6,88.4 237.0,84.9 238.7,81.5 240.6,78.2 242.7,75.0 244.9,71.9 247.4,68.9 250.0,66.0 252.8,63.3 255.8,60.7 258.9,58.3 262.2,56.1 265.6,54.0 269.1,52.2 272.7,50.5 276.4,49.1 280.2,47.8 284.1,46.8 288.0,46.0 292.0,45.5 296.0,45.1 300.0,45.0" fill="none" stroke="#d9534f" stroke-width="2.2"/><polyline points="300.0,45.0 304.0,45.3 308.0,46.1 311.8,47.4 315.6,49.2 319.1,51.5 322.5,54.3 325.6,57.5 328.4,61.0 330.9,65.0 333.0,69.3 334.8,73.8 336.3,78.5 337.3,83.5 338.0,88.5 338.3,93.7 338.2,98.9 337.8,104.0 337.0,109.1 335.9,114.1 334.5,118.9 332.8,123.6 330.8,128.1 328.7,132.3 326.4,136.2 324.0,139.9 321.5,143.2 318.9,146.3 316.2,149.0 313.7,151.5 311.1,153.6 308.6,155.4 306.3,156.9 304.1,158.2 302.0,159.2 300.1,159.9 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.8,160.3 301.4,160.6 302.0,161.0 302.5,161.3 302.9,161.7 303.2,162.0 303.4,162.3 303.5,162.6 303.5,162.8 303.5,162.9 303.3,163.0 303.1,163.0 302.8,162.9 302.4,162.7 302.0,162.4 301.6,162.0 301.2,161.6 300.7,161.1 300.3,160.5 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 299.7,160.5 299.3,161.1 298.8,161.6 298.4,162.0 298.0,162.4 297.6,162.7 297.2,162.9 296.9,163.0 296.7,163.0 296.5,162.9 296.5,162.8 296.5,162.6 296.6,162.3 296.8,162.0 297.1,161.7 297.5,161.3 298.0,161.0 298.6,160.6 299.2,160.3 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 299.9,159.9 298.0,159.2 295.9,158.2 293.7,156.9 291.4,155.4 288.9,153.6 286.3,151.5 283.8,149.0 281.1,146.3 278.5,143.2 276.0,139.9 273.6,136.2 271.3,132.3 269.2,128.1 267.2,123.6 265.5,118.9 264.1,114.1 263.0,109.1 262.2,104.0 261.8,98.9 261.7,93.7 262.0,88.5 262.7,83.5 263.7,78.5 265.2,73.8 267.0,69.3 269.1,65.0 271.6,61.0 274.4,57.5 277.5,54.3 280.9,51.5 284.4,49.2 288.2,47.4 292.0,46.1 296.0,45.3 300.0,45.0" fill="none" stroke="#d9a441" stroke-width="2.2"/><polyline points="300.0,45.0 304.0,45.8 307.8,48.3 311.3,52.3 314.4,57.7 316.9,64.3 318.7,71.9 319.9,80.3 320.3,89.2 320.0,98.4 319.1,107.5 317.6,116.4 315.6,124.9 313.3,132.6 310.8,139.7 308.2,145.8 305.7,151.0 303.3,155.2 301.1,158.5 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.6,159.6 301.2,159.3 301.7,159.2 302.0,159.1 302.0,159.2 301.9,159.3 301.7,159.5 301.3,159.6 300.8,159.8 300.3,159.9 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.2,160.0 300.5,160.1 300.7,160.2 300.9,160.3 300.9,160.3 300.9,160.4 300.8,160.4 300.6,160.3 300.4,160.2 300.2,160.1 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.1,160.1 300.2,160.4 300.3,160.6 300.4,160.7 300.5,160.9 300.4,160.9 300.4,160.9 300.3,160.8 300.2,160.6 300.1,160.3 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 299.9,160.3 299.8,160.6 299.7,160.8 299.6,160.9 299.6,160.9 299.5,160.9 299.6,160.7 299.7,160.6 299.8,160.4 299.9,160.1 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 299.8,160.1 299.6,160.2 299.4,160.3 299.2,160.4 299.1,160.4 299.1,160.3 299.1,160.3 299.3,160.2 299.5,160.1 299.8,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 299.7,159.9 299.2,159.8 298.7,159.6 298.3,159.5 298.1,159.3 298.0,159.2 298.0,159.1 298.3,159.2 298.8,159.3 299.4,159.6 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 300.0,160.0 298.9,158.5 296.7,155.2 294.3,151.0 291.8,145.8 289.2,139.7 286.7,132.6 284.4,124.9 282.4,116.4 280.9,107.5 280.0,98.4 279.7,89.2 280.1,80.3 281.3,71.9 283.1,64.3 285.6,57.7 288.7,52.3 292.2,48.3 296.0,45.8 300.0,45.0" fill="none" stroke="#3fa968" stroke-width="2.2"/><text x="300" y="31" text-anchor="middle" font-size="11">Quellrichtung</text><line x1="520" y1="120" x2="550" y2="120" stroke="#d9534f" stroke-width="3" opacity="1"/><text x="560" y="124" text-anchor="start" font-size="12">FOA (N=1)</text><line x1="520" y1="148" x2="550" y2="148" stroke="#d9a441" stroke-width="3" opacity="1"/><text x="560" y="152" text-anchor="start" font-size="12">HOA3</text><line x1="520" y1="176" x2="550" y2="176" stroke="#3fa968" stroke-width="3" opacity="1"/><text x="560" y="180" text-anchor="start" font-size="12">HOA7</text><text x="520" y="100" text-anchor="start" font-weight="600" font-size="11">gleiche Quelle, drei Ordnungen</text><text x="360" y="308" text-anchor="middle" font-size="11">Max-rE-Gewichtung, Polardarstellung; schematisch, keine Messung.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Höhere Ordnung bündelt die Quelle in einer schmaleren Keule. FOA ist breit und weich, HOA7 ist scharf.</figcaption>
</figure>














Mit steigender Ordnung werden Klangquellen schärfer lokalisierbar. Bei 1st Order klingt eine Punktquelle leicht diffus – ein Lautsprecher in einem Cluster ist schwer von seinen Nachbarn zu unterscheiden. Bei 3rd Order ist die Lokalisation für die meisten Abhörsituationen überzeugend. Bei 7th Order nähert sich die Auflösung dem, was das menschliche Gehör unter idealen Bedingungen auflösen kann.

Ein einfaches Bild: Ordnung verhält sich ähnlich wie Bildauflösung bei einem Foto. FOA ist 480p – erkennbar, aber unscharf. HOA3 ist 1080p – gut für fast alle Zwecke. HOA7 ist 4K – man braucht ein sehr gutes Wiedergabesystem, um den Unterschied zu hören.

### Sweetspot-Grösse

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 300" role="img" aria-label="Korrekt wiedergegebener Hörbereich bei 1 kHz" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar3" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><circle cx="250" cy="150" r="114.66000000000003" fill="none" stroke="#3fa968" stroke-width="2"/><text x="335.07608600000003" y="72.92391399999998" text-anchor="start" fill="#3fa968" font-size="11">N=7</text><circle cx="250" cy="150" r="81.9" fill="none" stroke="#d9a441" stroke-width="2"/><text x="311.91149" y="96.08851" text-anchor="start" fill="#d9a441" font-size="11">N=5</text><circle cx="250" cy="150" r="49.14" fill="none" stroke="#4a8fe0" stroke-width="2"/><text x="288.746894" y="119.253106" text-anchor="start" fill="#4a8fe0" font-size="11">N=3</text><circle cx="250" cy="150" r="16.38" fill="none" stroke="#d9534f" stroke-width="2"/><text x="236" y="182.38" text-anchor="middle" fill="#d9534f" font-size="11">N=1</text><circle cx="250" cy="150" r="26.099999999999998" fill="none" stroke="currentColor" stroke-width="1.5" stroke-dasharray="2 3"/><text x="250" y="154" text-anchor="middle" font-size="10">Kopf</text><text x="560" y="92" text-anchor="middle" font-weight="600">Korrekter Bereich bei 1 kHz</text><circle cx="480" cy="128" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="496" y="133" text-anchor="start" font-size="13">N=1: r ≈ 5 cm</text><circle cx="480" cy="158" r="6" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><text x="496" y="163" text-anchor="start" font-size="13">N=3: r ≈ 16 cm</text><circle cx="480" cy="188" r="6" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><text x="496" y="193" text-anchor="start" font-size="13">N=5: r ≈ 27 cm</text><circle cx="480" cy="218" r="6" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><text x="496" y="223" text-anchor="start" font-size="13">N=7: r ≈ 38 cm</text><text x="480" y="262" text-anchor="start" font-size="11">Faustformel r ≈ N·c / (2π·f)</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Der Bereich, in dem das Schallfeld korrekt reproduziert wird, wächst mit der Ordnung. Bei FOA ist er kleiner als ein Kopf, bei HOA3 reicht er für eine Person, bei HOA7 für eine kleine Gruppe.</figcaption>
</figure>














Der Sweetspot ist der Bereich, in dem das Schallfeld korrekt reproduziert wird. Er wächst mit der Ordnung. Bei FOA ist er bei mittleren und hohen Frequenzen kaum grösser als ein Kopf. Bei HOA3 reicht er für eine kleine Gruppe von Zuhörer:innen. Für grosse Räume und viele Personen ist HOA5 oder HOA7 relevant.

In der Praxis: Wer für Studio-Produktion und Kopfhörer arbeitet, merkt den Sweetspot-Unterschied kaum. Wer für ein grosses Konzertsystem produziert, macht den Unterschied zwischen HOA3 und HOA7 je nach Repertoire und Saal hörbar.

### Minimale Lautsprecher-Anzahl

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 250" role="img" aria-label="Lautsprecheranzahl und nutzbare Ordnung" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar4" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><line x1="40" y1="120" x2="680" y2="120" stroke="currentColor" stroke-width="2" opacity="1"/><line x1="80.0" y1="112" x2="80.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="80.0" y="146" text-anchor="middle" font-size="11">4</text><text x="80.0" y="162" text-anchor="middle" font-size="10.5">N=1</text><line x1="130.0" y1="112" x2="130.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="130.0" y="146" text-anchor="middle" font-size="11">9</text><text x="130.0" y="162" text-anchor="middle" font-size="10.5">N=2</text><line x1="200.0" y1="112" x2="200.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="200.0" y="146" text-anchor="middle" font-size="11">16</text><text x="200.0" y="162" text-anchor="middle" font-size="10.5">N=3</text><line x1="290.0" y1="112" x2="290.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="290.0" y="146" text-anchor="middle" font-size="11">25</text><text x="290.0" y="162" text-anchor="middle" font-size="10.5">N=4</text><line x1="400.0" y1="112" x2="400.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="400.0" y="146" text-anchor="middle" font-size="11">36</text><text x="400.0" y="162" text-anchor="middle" font-size="10.5">N=5</text><line x1="530.0" y1="112" x2="530.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="530.0" y="146" text-anchor="middle" font-size="11">49</text><text x="530.0" y="162" text-anchor="middle" font-size="10.5">N=6</text><line x1="680.0" y1="112" x2="680.0" y2="128" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="680.0" y="146" text-anchor="middle" font-size="11">64</text><text x="680.0" y="162" text-anchor="middle" font-size="10.5">N=7</text><line x1="120.0" y1="100" x2="120.0" y2="62" stroke="#d9534f" stroke-width="2.5" opacity="1"/><circle cx="120.0" cy="60" r="6" fill="#d9534f" stroke="#d9534f" stroke-width="1.5"/><text x="120.0" y="44" text-anchor="middle" font-weight="600" fill="#d9534f" font-size="11">Oktagon (8)</text><line x1="200.0" y1="100" x2="200.0" y2="42" stroke="#4a8fe0" stroke-width="2.5" opacity="1"/><circle cx="200.0" cy="40" r="6" fill="#4a8fe0" stroke="#4a8fe0" stroke-width="1.5"/><text x="200.0" y="24" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="11">16 Lautsprecher</text><line x1="220.0" y1="100" x2="220.0" y2="62" stroke="#3fa968" stroke-width="2.5" opacity="1"/><circle cx="220.0" cy="60" r="6" fill="#3fa968" stroke="#3fa968" stroke-width="1.5"/><text x="220.0" y="44" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="11">ICST-Studio (18)</text><line x1="680.0" y1="100" x2="680.0" y2="42" stroke="#d9a441" stroke-width="2.5" opacity="1"/><circle cx="680.0" cy="40" r="6" fill="#d9a441" stroke="#d9a441" stroke-width="1.5"/><text x="674.0" y="24" text-anchor="end" font-weight="600" fill="#d9a441" font-size="11">Dom (64)</text><text x="360" y="200" text-anchor="middle" font-size="12">Lautsprecher → nutzbare Ordnung ist das grösste N mit (N+1)² ≤ Lautsprecherzahl</text><text x="360" y="225" text-anchor="middle" font-size="11">Höhere Ordnungen werden zwar gerechnet, aber nicht vollständig wiedergegeben.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Die Marken zeigen die Mindestanzahl Lautsprecher je Ordnung. Ein 8-Lautsprecher-Ring reicht bis FOA, das 18-Lautsprecher-Studio bis zur 3. Ordnung.</figcaption>
</figure>














Das Lautsprecher-System setzt die praktische Obergrenze der nutzbaren Ordnung. Die Faustregel:

> **Mindestens (N+1)² Lautsprecher für Ordnung N**

| Ordnung | Mindest-Lautsprecher |
|---|---|
| 1st | 4 |
| 2nd | 9 |
| 3rd | 16 |
| 5th | 36 |
| 7th | 64 |

In einem System mit 8 Lautsprechern ist HOA3 wenig sinnvoll – das System kann die 16-kanalige Information nicht vollständig reproduzieren. Der Decoder rechnet zwar, aber die räumliche Auflösung ist durch die Lautsprecher gedeckelt. Das **ICST Composition Studio an der ZHdK** hat 18 Lautsprecher – dort ist HOA3 gut ausgenutzt, höhere Ordnungen werden nicht mehr vollständig wiedergegeben.

> **Wichtig:** In REAPER und den ICST Plugins kannst du jede Ordnung verwenden, egal wie viele Lautsprecher du hast. Das System rechnet korrekt. Aber die klangliche Qualität wird durch das schwächste Glied bestimmt – das Abhörsystem.

---

## Praktische Entscheidungshilfe

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 215" role="img" aria-label="Welche Ordnung für welchen Zweck" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar5" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="20" width="210" height="175" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="120" y="50" text-anchor="middle" font-weight="600" fill="#4a8fe0" font-size="15">FOA (1st)</text><text x="29" y="86" text-anchor="start" font-size="12">• Nur Binaural / Streaming</text><text x="29" y="116" text-anchor="start" font-size="12">• Skizzen und Konzepte</text><text x="29" y="146" text-anchor="start" font-size="12">• Kleines System (4–8 LS)</text><text x="29" y="176" text-anchor="start" font-size="12">• Mikrofonaufnahmen (FOA)</text><text x="29" y="206" text-anchor="start" font-size="12">• Schwacher Laptop, Live</text><rect x="255" y="20" width="210" height="175" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="360" y="50" text-anchor="middle" font-weight="600" fill="#3fa968" font-size="15">HOA3</text><text x="269" y="86" text-anchor="start" font-size="12">• Standard für die meiste Arbeit</text><text x="269" y="116" text-anchor="start" font-size="12">• 16+ Lautsprecher</text><text x="269" y="146" text-anchor="start" font-size="12">• Hochwertiges Binaural</text><text x="269" y="176" text-anchor="start" font-size="12">• Zylia-ZM-1-Aufnahmen</text><text x="269" y="206" text-anchor="start" font-size="12">• Plattform-Export (VR/360°)</text><rect x="495" y="20" width="210" height="175" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="600" y="50" text-anchor="middle" font-weight="600" fill="#d9a441" font-size="15">HOA5 / HOA7</text><text x="509" y="86" text-anchor="start" font-size="12">• 40+ Lautsprecher, Dome</text><text x="509" y="116" text-anchor="start" font-size="12">• Archiv / Master-Dateien</text><text x="509" y="146" text-anchor="start" font-size="12">• Dichtes 3D-Höhen-Rendering</text><text x="509" y="176" text-anchor="start" font-size="12">• Forschung, hohe Präzision</text><text x="509" y="206" text-anchor="start" font-size="12">• Freeze bei vielen Quellen</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Drei typische Situationen. Arbeitsregel: so hoch wie die CPU erlaubt (HOA7); HOA3 ist der Fallback.</figcaption>
</figure>














### Wann reicht FOA (1st Order)?

- Binaural-only Produktion für Kopfhörer oder Streaming
- Kompositorische Skizze oder Konzeptarbeit ohne finales Lautsprecher-System
- Echtzeit-Performance auf kleinem System (4–8 Lautsprecher, z.B. Oktagon)
- Ambisonics-Mikrofon-Aufnahmen (Ambeo, NT-SF1 – diese liefern ausschliesslich FOA)
- Ressourcenknappe Live-Situation (älteres Laptop, instabiler Rechner)

### Wann ist HOA3 die richtige Wahl?

HOA3 ist der **praktische Fallback**, wenn CPU oder Plugin-Kette HOA7 nicht erlauben, und das übliche Ziel für die Auslieferung:

- Professionelle Komposition für ein Mehrlautsprecher-System ab ca. 16 Lautsprechern
- Binaural-Render mit hoher Qualität (IEM BinauralDecoder nutzt HOA3 voll aus)
- Mischung aus Encoder-Quellen und Mikrofon-Aufnahmen (Zylia ZM-1 liefert HOA3)
- Export für Plattformen wie YouTube 360° oder VR (die meisten Plattformen akzeptieren maximal HOA3)
- Studioproduktion mit modernem Rechner ohne spezifischen Bedarf an HOA7

### Wann braucht es HOA5 oder HOA7?

- Grosse Konzerthäuser mit 40+ Lautsprechern (z.B. Kuppelinstallationen, IMAX-ähnliche Systeme)
- Archive und Masterdateien, die für zukünftige höhere Systeme ausgelegt sind
- Spezielle Höhenabbildung in dichten 3D-Arrays
- Akademische oder Forschungs-Kontexte mit Präzisionsanforderungen

### Binaural: Wie viel Ordnung klingt besser?

Für binaurales Kopfhörer-Monitoring gilt: der wahrnehmbare Qualitätssprung liegt zwischen FOA und HOA3 – deutlich. Zwischen HOA3 und HOA7 ist der Unterschied im Binaural-Rendering messbar, aber perceptuell weniger dramatisch. Ab HOA3 ist Binaural für die meisten Zwecke ausreichend hochauflösend.

---

## CPU-Last in REAPER

| Ordnung | Kanäle | Relative CPU | Praktisch |
|---|---|---|---|
| FOA | 4 | sehr gering | problemlos auch auf älteren Systemen |
| HOA3 | 16 | moderat | Standard auf modernem Rechner, kein Problem |
| HOA5 | 36 | merklich | grosse Sessions erfordern Freeze-Strategie |
| HOA7 | 64 | hoch | bei vielen Quellen: Freeze oder Render-to-File |

In REAPER: Wenn HOA7-Spuren einzufrieren sind, *Freeze*-Funktion nutzen (rechtsklick auf Track → Freeze). Der eingefrorene Track wird als voll berechnetes Multichannel-File intern gespeichert und verursacht keine Encoder-CPU mehr – nur noch Bus-Routing.

---

## Ordnung wechseln während der Produktion

<figure style="margin:1.8rem 0">
<svg viewBox="0 0 720 190" role="img" aria-label="Ordnung in laufender Session ändern" style="width:100%;height:auto;display:block" font-family="sans-serif" font-size="13" fill="currentColor"><defs><marker id="ar6" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0L10,5L0,10z" fill="currentColor"/></marker></defs><rect x="15" y="50" width="150" height="64" rx="8" fill="none" fill-opacity="0" stroke="currentColor" stroke-width="1.5" opacity="1"/><text x="90.0" y="80.0" text-anchor="middle" font-weight="600">1. Bus-Kanäle</text><text x="90.0" y="97.0" text-anchor="middle" font-size="10.5">Track Channels</text><line x1="165" y1="82" x2="190" y2="82" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#ar6)"/><rect x="190" y="50" width="150" height="64" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#4a8fe0" stroke-width="1.5" opacity="1"/><text x="265.0" y="80.0" text-anchor="middle" font-weight="600">2. Encoder</text><text x="265.0" y="97.0" text-anchor="middle" font-size="10.5">Ordnungsparameter</text><line x1="340" y1="82" x2="365" y2="82" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#ar6)"/><rect x="365" y="50" width="150" height="64" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#3fa968" stroke-width="1.5" opacity="1"/><text x="440.0" y="80.0" text-anchor="middle" font-weight="600">3. Decoder</text><text x="440.0" y="97.0" text-anchor="middle" font-size="10.5">neue Ordnung</text><line x1="515" y1="82" x2="540" y2="82" stroke="currentColor" stroke-width="1.6" opacity="1" marker-end="url(#ar6)"/><rect x="540" y="50" width="150" height="64" rx="8" fill="currentColor" fill-opacity="0.12" stroke="#d9a441" stroke-width="1.5" opacity="1"/><text x="615.0" y="80.0" text-anchor="middle" font-weight="600">4. Binaural</text><text x="615.0" y="97.0" text-anchor="middle" font-size="10.5">passt sich an</text><text x="360" y="24" text-anchor="middle" font-weight="600">Vier Stellen, die mitziehen müssen</text><text x="360" y="160" text-anchor="middle" font-size="11">Die Ordnung vor der Produktion festlegen und ein Template sichern erspart alle vier Schritte.</text></svg>
<figcaption style="font-size:1.3rem;opacity:.8;margin-top:.6rem">Eine spätere Änderung berührt Bus, Encoder und Decoder. Der IEM BinauralDecoder folgt der Kanalzahl.</figcaption>
</figure>














Am besten startest du gleich in HOA7, wenn der Rechner es erlaubt – eine spätere Reduktion ist einfach, eine spätere Erhöhung nicht. Musst du die Ordnung einer laufenden Session trotzdem ändern, erfordert das Anpassungen:

1. **B-Format-Bus Kanalzahl** anpassen (Rechtsklick → Track Channels)
2. **Alle AmbiEncoder** auf die neue Ordnung setzen (Order-Parameter im Plugin)
3. **ICST AmbiDecoder** auf die neue Ordnung setzen
4. **BinauralDecoder** passt sich automatisch an (IEM erkennt Kanalzahl)

Am einfachsten ist: Ordnung (idealerweise HOA7) vor dem Produktionsstart festlegen und ein REAPER-Template auf dieser Ordnung aufbauen. Das ICST Download-Pack enthält vorbereitete Templates.

---

## Empfehlung für den ICST-Workflow

**Arbeitsregel:** In **HOA7** produzieren, solange die CPU des Rechners mitmacht. Ein Master in höherer Ordnung lässt sich jederzeit für ein bestimmtes System, eine Plattform oder Kopfhörer auf HOA3 oder FOA reduzieren; eine Session in niedriger Ordnung lässt sich nachträglich nie aufwerten. Wird HOA7 zu schwer (viele Quellen, viele Effekte), auf HOA5 oder HOA3 gehen oder Tracks freezen.

Wer am **ICST Composition Studio** (18 Lautsprecher) produziert: in **HOA7** arbeiten und für den Raum dekodieren. Die Lautsprecher geben etwa HOA3 vollständig wieder, der Rest ist Reserve für andere Systeme und fürs Archiv.

Wer für **Kopfhörer und Binaural** produziert: ebenfalls **HOA7**, wenn die CPU es erlaubt; **HOA3** ist der sinnvolle Fallback (der hörbare Sprung liegt vor allem zwischen FOA und HOA3).

Wer eine **erste eigene Session** aufbaut: Mit **FOA oder HOA3** beginnen – die Konzepte sind dieselben, und der Einstieg ist leichter. Auf HOA7 wechseln, sobald der Workflow vertraut ist.

---

## Weiterführende Seiten

- [Koordinatensysteme: XYZ und AED im Vergleich](/de/post/xyz-vs-aed-koordinatensysteme/)
- [ICST AmbiDecoder – Skalierung und Laufzeitkompensation](/de/post/decoder-skalierung-laufzeitkompensation/)
- [Binaural Monitoring im ICST-Workflow](/de/post/binaural-monitoring-icst-workflow/)
- [Den B-Format-Master exportieren](/de/post/b-format-export-reaper/)
- [Ambisonics-Mikrofon aufnehmen – A-Format, B-Format und die ICST-Integration](/de/post/ambisonics-mikrofon-a-format-b-format/)
