---
title: Was ist neu
date: 2026-11-14T08:00:00
weight: 15
---
# November 2026: REAPER-Bundle, Motion Map 2.4.5, Animator Choreographer

Neue Werkzeuge und Dokumentation zum Komponieren mit den ICST-Ambisonics-Plugins in REAPER. Alle drei sind Evaluationsbetas.

**ICST Ambi REAPER Bundle 1.1.3**
Ein portabler REAPER-Ordner, der für die ICST-Plugins schon eingerichtet ist: Ein Klick in der Toolbar legt Ambisonics-Spuren an (Ordnungen 1 bis 7), routet sie, bewegt Quellen und decodiert. macOS ist vollständig, Windows ist Beta und ungetestet; die Dateien sind nicht signiert.
📥 [Release 1.1.3 auf GitHub](https://github.com/joambi/ICST_Ambi_Reaper/releases/tag/v1.1.3) · 📖 [ICST Ambi REAPER Bundle](/de/icst-ambisonics-plugins/19_icst_ambi_reaper_bundle/)

**Motion Map GUI 2.4.5**
Bis zu 64 Quellen positionieren und animieren und die Bewegung als REAPER-Automation schreiben. Neu seit 2.2:
- **Figure Editor** (2.3): Jede Bewegungsfigur umformen, pro Quelle oder für alle Quellen mit dieser Figur.
- **Tempo-Sync** (2.4): Der Zyklus läuft in Beats und kann auf die Taktstriche einrasten.
- **Quantize** (2.4.3): Jede Figur wird zu einer gestuften Bewegung in Zeit und Raum.
- **Preview-Transport mit Sync** (2.4.4, 2.4.5): Die Vorschau folgt Play und Stop von REAPER, und Play/Stop in der GUI starten und stoppen den REAPER-Transport.
- **Latch** (2.4.5): Beschriebene Spuren werden immer auf Latch gesetzt.

📖 [Motion Mapping](/de/icst-ambisonics-plugins/15_icst_ambi_motion_map/) (mit Bildschirmaufnahme)

**Animator Choreographer 0.1.0**
Eine Desktop-App, die plant, wie sich Gruppen von Quellen im Raum bewegen, und die Szenen-XML für den ICST Animator exportiert, mit REAPER-Regionen als Abschnitten. Für macOS, Windows und Linux; noch nicht signiert.
📥 [Releases auf GitHub](https://github.com/joambi/animator-choreographer/releases) · 📖 [Animator Choreographer](/de/icst-ambisonics-plugins/20_animator_choreographer/)

---

# ICST Ambisonics Plugins Release 4.0

Wir freuen uns, die Version 4.0.0 unserer ICST-Ambisonics-Plugins vorstellen zu dürfen.

Dieses Release (v4.0.0) ist ein grosser Schritt nach vorn, um in Ambisonics mit Source-Gruppen zu komponieren: Choreographien direkt in der Reaper-Timeline erstellen und als XML-Scores speichern, um sie auch in anderen Projekten wieder einzubinden und neu gestalten zu können. Der ICST-Gruppen-Animator befindet sich im Stadium «Work in Progress» und wird weiter wachsen.

Auch im ICST AmbiEncoder_64 Plugin haben wir die Blauertschen Filter optimiert, und für eine sphärische Darbietung ohne Frontausrichtung kann nur die Z-Achse gewählt werden.

**Download:**
🔗 [GitHub Release 4.0.0](https://github.com/schweizerweb/icst-ambisonics-plugins/releases/tag/4.0.0)

**Dokumentation:**
📖 [ICST Animator](/de/icst-ambisonics-plugins/11_animator/)
