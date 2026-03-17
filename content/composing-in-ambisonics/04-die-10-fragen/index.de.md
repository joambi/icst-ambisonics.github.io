---
title: "Die 10 Fragen im 3D-Raum"
description: "Ein kompositorischer Fragenkatalog fuer Ambisonics-Stücke."
date: 2026-01-01T00:00:00
weight: 40
draft: false
translationKey: "composing-10-questions"
---

Die folgenden Fragen sind als **kompositorisches Arbeitsblatt** gedacht. Sie helfen nicht nur bei der Analyse bestehender Werke, sondern auch beim Entwerfen eigener Stücke, bei Proben im Studio und bei der späteren Dokumentation.

## So benutzt du diese Seite

Diese Seite hat zwei Ebenen, die bewusst zusammengehören:

- **Zehn kurze REAPER-Studien**: kleine Skizzen, mit denen du jede Leitfrage sofort praktisch testen kannst
- **Die zehn Fragen selbst**: ein strukturierter Katalog für Stückplanung, Analyse und Dokumentation

Am produktivsten ist die Seite, wenn du **nicht alles linear liest**, sondern zwischen beidem hin- und hergehst: erst eine Miniatur bauen, dann mit der passenden Leitfrage schärfen, was daran kompositorisch eigentlich entschieden wurde.

<figure class="big">
  <img src="/images/ten-questions-clusters-de.svg" alt="Diagramm der zehn Fragen im 3D-Raum, gruppiert in vier Bereiche: Welt und Form, räumliche Organisation, Hören und Kontext sowie Werk und Dokumentation" loading="lazy" />
  <figcaption><strong>Vier Gruppen statt zehn Einzelthemen.</strong> Die Fragen lassen sich als Bewegungen zwischen Weltentwurf, räumlicher Organisation, Hörsituation und Werkidentität lesen. Gerade dadurch werden sie zu einem brauchbaren Arbeitsmodell für Komposition.</figcaption>
</figure>

Ein möglicher Arbeitsrhythmus sieht so aus: **Frage wählen → Mini-Studie bauen → hören → nachschärfen → dokumentieren**. Die Fragen sind also nicht nur Analysebegriffe, sondern direkt an Routing, Automation, Hören und Überarbeitungen gebunden.

<figure class="big">
  <img src="/images/ten-questions-workflow-de.svg" alt="Workflow für die zehn Fragen im 3D-Raum: Leitfrage wählen, Mini-Studie skizzieren, Raumparameter setzen, hören und vergleichen, dokumentieren und ins Stück übertragen" loading="lazy" />
  <figcaption><strong>Von der Leitfrage zur Stückentscheidung.</strong> Die zehn Fragen funktionieren am besten als iterativer Arbeitsprozess: skizzieren, hören, vergleichen, anpassen und nur das Behalten, was räumlich wirklich trägt.</figcaption>
</figure>

## Zehn kurze REAPER-Studien

Die folgenden Miniaturen sind als **1- bis 2-minütige Skizzen** gedacht. Jede Studie beantwortet eine der zehn Leitfragen auf praktische Weise und laesst sich in **REAPER** mit den **ICST Ambisonics Plugins** oder aehnlichen HOA-Toolchains schnell umsetzen. Sie sind bewusst klein gehalten: eher **kompositorische Etueden** als fertige Stuecke.

Als Basissetup genuegt in allen Beispielen:

- 1 Masterspur mit `AmbiDecoder` oder `MultiDecoder`
- 2 bis 6 Klangspuren mit `MonoEncoder` oder `MultiEncoder_64`
- ambiX / ACN-SN3D
- ein Ziel-Setup wie `binaural`, `IEM BinauralDecoder` oder ein vorhandenes Dome-Preset

### Schnellüberblick

| Frage | Dauer | Spuren | Hauptautomation | Ziel |
| --- | --- | --- | --- | --- |
| 1. Ontologie | 1:30 | 3 | Position, Distanz, Hoehe | dieselbes Material in drei Raumwelten hoerbar machen |
| 2. Raum vs. Spektrum/Zeit | 2:00 | 2 | Azimut, Elevation, Distanz vs. Audio-FX | vergleichen, ob Form eher durch Raum oder Klangwandel entsteht |
| 3. Raumebenen | 1:30 | 3 Gruppen | Distanz, Spread, langsame Kreisbewegung | Vordergrund, Mittelfeld und Fernfeld stabil staffeln |
| 4. Objektzahl/Dichte | 2:00 | 6-8 | Quellenanzahl, Position, Gruppierung | Kippmoment zwischen Klarheit und Wolke finden |
| 5. Trajektorien | 1:30 | 3 | Kreis, Linie, Aufstieg, Implosion | Bewegungs-Vokabular als formale Marker testen |
| 6. Lokalisation vs. Diffusitaet | 1:30 | 1-2 | Spread, Distance, Decorrelator-Mix | Fokus- und Defokus-Gesten komponieren |
| 7. Abhoerszenario | 1:00-2:00 | 3 | Overhead vs. laterale Bewegung | Unterschiede zwischen Dome- und Binaural-Mix hoerbar machen |
| 8. Publikum | 1:30 | 3-4 | kleine vs. grosse Raumkontraste | Lesbarkeit fuer unterschiedliche Hoergewohnheiten pruefen |
| 9. Realraum/Archetypen | 2:00 | 3 | Raumcharakter, EQ, Hall, Achsenbewegung | Tunnel, Platz und offener Raum als Archetypen bauen |
| 10. Werkidentitaet | 1:00 | 2-3 | eine klare Haupttrajektorie | Miniatur plus saubere Dokumentation fuer Uebertragbarkeit |

### Mini-Studie 1 — Ontologie: Was fuer eine Welt ist das?

<div class="study-card">

**Dauer:** ca. 90 Sekunden

**Idee:** Baue in REAPER drei kurze Versionen desselben Materials: eine **reale Szene**, eine **abstrahierte Szene** und eine **rein imaginierte Raumwelt**.

**Material:**
- Spur 1: Schritte oder Atem
- Spur 2: Field Recording oder Rauschen
- Spur 3: synthetischer Sinus-/Granularklang

**Ablauf:**
| Zeit | Fokus | Aktion |
| --- | --- | --- |
| `0:00-0:30` | realistisch | Schritte vorne links, Umgebungsaufnahme als breite Kulisse, kaum unmoegliche Bewegungen |
| `0:30-1:00` | abstrahiert | Dasselbe Material wird gedehnt, in Hoehe verschoben und klanglich entfremdet |
| `1:00-1:30` | imaginierter Raum | Nur noch spektrale Spuren, diffuse Flaechen und unklare Tiefenstaffelung |

**REAPER-Fokus:** Positioniere dieselben Quellen in drei verschiedenen Raumlogiken. So wird sofort hoerbar, wie stark die **Ontologie** des Stuecks die kompositorischen Entscheidungen bestimmt.

</div>

### Mini-Studie 2 — Raum vs. Spektrum/Zeit: Was traegt die Form?

<div class="study-card">

**Dauer:** ca. 2 Minuten

**Idee:** Komponiere zwei kontrastierende Abschnitte: einmal entsteht Form fast nur durch **Raumbewegung**, einmal fast nur durch **spektral-zeitliche Veraenderung**.

**Material:**
- ein stabiler Drone-Klang
- ein kurzer perkussiver Klang

**Ablauf:**
| Zeit | Fokus | Aktion |
| --- | --- | --- |
| `0:00-1:00` | Raumbewegung | Spektrum bleibt fast gleich, aber der Drone wandert von Boden zu Decke, von Ring zu Zentrum, von scharf zu diffus |
| `1:00-2:00` | Spektrum/Zeit | Raum bleibt fast statisch, dafuer veraendern Filter, Granulation und Rhythmus die Form |

**REAPER-Fokus:** Zeichne im ersten Teil vor allem `Azimut`, `Elevation`, `Distanz` und `Spread`. Im zweiten Teil bleiben diese Werte fast unveraendert, waehrend Audioeffekte die Form uebernehmen.

</div>

### Mini-Studie 3 — Raumebenen: Vordergrund, Mittelfeld, Fernfeld

<div class="study-card">

**Dauer:** ca. 90 Sekunden

**Idee:** Lege drei klar unterscheidbare **Layer** an und pruefe, ob sie auch bei geschlossenen Augen stabil als Ebenen wahrnehmbar bleiben.

**Material:**
- Vordergrund: kurze Klicks oder einzelne Toene
- Mittelfeld: schwebende Textur
- Fernfeld: diffuse Hall- oder Windwolke

**Ablauf:**
| Zeit | Fokus | Aktion |
| --- | --- | --- |
| `0:00-0:30` | Staffelung | Ebenen klar trennen |
| `0:30-1:00` | Bewegung | Mittelfeld beginnt langsam zu kreisen |
| `1:00-1:30` | Verschiebung | Vordergrund sinkt in die Textur ein, Fernfeld wird kurz heller und naeher |

**REAPER-Fokus:** Arbeite mit drei Spurgruppen und unterschiedlichen Distanz-/Spread-Werten. Ziel ist nicht Bewegung allein, sondern **lesbare Staffelung**.

</div>

### Mini-Studie 4 — Objektzahl und Dichte: Wann kippt Klarheit in Wolke?

<div class="study-card">

**Dauer:** ca. 2 Minuten

**Idee:** Beginne mit einem Objekt und verdichte die Szene schrittweise bis zur Ueberfuellung, dann raeume sie wieder auf.

**Material:**
- 6 bis 8 kurze Klangobjekte, zum Beispiel metallische Samples, Sprachsplitter oder Sinustoene

**Ablauf:**
| Zeit | Fokus | Aktion |
| --- | --- | --- |
| `0:00-0:30` | Klarheit | 1-2 klar lokalisierte Objekte |
| `0:30-1:00` | Verdichtung | 3-4 Objekte mit eigener Bahn |
| `1:00-1:30` | Ueberfuellung | 6-8 Objekte, teilweise ueberlagert |
| `1:30-2:00` | Ruecknahme | Ruecknahme auf 2 Objekte und breite Restwolke |

**REAPER-Fokus:** Nutze `MultiEncoder_64`, um mehrere Quellen schnell zu schichten. Hoere genau, ab welchem Punkt die Szene nicht mehr kontrapunktisch, sondern nur noch textural wirkt.

</div>

### Mini-Studie 5 — Trajektorien und Gestentypen

<div class="study-card">

**Dauer:** ca. 90 Sekunden

**Idee:** Baue ein kleines Bewegungs-Vokabular aus vier Gesten: **Kreis**, **Linie**, **Aufstieg**, **Implosion**.

**Material:**
- ein heller Ton
- ein geraues Rauschen
- ein Impuls- oder Glockenklang

**Ablauf:**
| Zeit | Fokus | Aktion |
| --- | --- | --- |
| `0:00-0:20` | Kreis | Kreisbewegung um den Kopf |
| `0:20-0:40` | Linie | gerade Fahrt von hinten nach vorne |
| `0:40-1:00` | Aufstieg | vertikaler Aufstieg |
| `1:00-1:30` | Implosion | mehrere Punkte ziehen ins Zentrum |

**REAPER-Fokus:** Zeichne fuer jede Geste nur eine dominante Automation. Dadurch wird hoerbar, wie unterschiedlich sich Bewegungstypen als **formale Marker** verhalten.

</div>

### Mini-Studie 6 — Lokalisation vs. Diffusitaet

<div class="study-card">

**Dauer:** ca. 90 Sekunden

**Idee:** Ein einziges Klangmaterial durchlaeuft mehrfach den Weg von **punktgenau** zu **nebelhaft diffus** und wieder zurueck.

**Material:**
- ein kurzer perkussiver Klang oder Sprachfragment
- optional Decorrelator / Reverb / Granular-Effekt

**Ablauf:**
| Zeit | Fokus | Aktion |
| --- | --- | --- |
| `0:00-0:20` | Fokus | trocken, scharf lokalisierbar |
| `0:20-0:45` | Aufweitung | zunehmender Spread und Decorrelator |
| `0:45-1:05` | Wolke | maximale Wolke |
| `1:05-1:30` | Rueckfokussierung | Rueckfokussierung auf einen einzelnen Punkt |

**REAPER-Fokus:** Automatisiere `Spread`, `Distance` und den Anteil diffuser Effekte. Diese Studie eignet sich gut, um **Fokus- und Defokus-Gesten** als Formelement zu testen.

</div>

### Mini-Studie 7 — Ziel-Abhoerszenario

<div class="study-card">

**Dauer:** ca. 1-2 Minuten

**Idee:** Entwirf eine Skizze, die einmal fuer **Dome** und einmal fuer **binaural** optimiert wird, und vergleiche die Prioritaeten.

**Material:**
- 3 Klangquellen mit deutlichen Richtungsprofilen

**Ablauf:**
| Variante | Fokus | Aktion |
| --- | --- | --- |
| Version A | Dome-Logik | starker Einsatz von Overhead und vertikalen Verschiebungen |
| Version B | binaurale Lesbarkeit | dieselbe Form, aber mit staerkerem Gewicht auf lateralen Bewegungen und klaren Vorder-/Hinterachsen |

**REAPER-Fokus:** Speichere zwei Decoder- oder Mixvarianten desselben Projekts. So wird sofort deutlich, wie das angestrebte **Wiedergabeszenario** die Komposition beeinflusst.

</div>

### Mini-Studie 8 — Publikum und Hoererfahrung

<div class="study-card">

**Dauer:** ca. 90 Sekunden

**Idee:** Komponiere denselben Ablauf in zwei Lesbarkeitsstufen: einmal fuer ein **erfahrenes Spatial-Audio-Publikum**, einmal fuer ein eher **allgemeines Publikum**.

**Material:**
- 3 bis 4 Klangobjekte

**Ablauf:**
| Zeit | Fokus | Aktion |
| --- | --- | --- |
| `0:00-0:45` | erfahrenes Publikum | subtile Unterschiede, kleine Winkelveraenderungen, feine Hoehenstaffelung |
| `0:45-1:30` | allgemeines Publikum | dieselbe Idee in groberer, klarerer Form mit staerkeren Kontrasten |

**REAPER-Fokus:** Doppelte Version derselben Passage mit unterschiedlichen Automationskurven. Die Frage ist hier nicht nur, was moeglich ist, sondern **was schnell lesbar bleibt**.

</div>

### Mini-Studie 9 — Realraum-Bezug und Archetypen

<div class="study-card">

**Dauer:** ca. 2 Minuten

**Idee:** Komponiere eine kurze Passage durch drei Raum-Archetypen: **Tunnel**, **Platz**, **Dach / offener Himmel**.

**Material:**
- Schritte oder Impulse
- Ambience oder Wind
- Hall / Filter zur Raumcharakterisierung

**Ablauf:**
| Zeit | Archetyp | Aktion |
| --- | --- | --- |
| `0:00-0:40` | Tunnel | enge Achse, vorne-hinten-Betonung, wenig Breite |
| `0:40-1:20` | Platz | mehr Offenheit, seitliche Weite, klarere Reflexionsfreiheit |
| `1:20-2:00` | Dach | Hoehe, Luft, Fernfeld und Overhead-Praesenz |

**REAPER-Fokus:** Nutze nicht nur Position, sondern auch Halltyp, EQ und Dynamik. So wird Raum nicht als Metapher behauptet, sondern **kompositorisch gebaut**.

</div>

### Mini-Studie 10 — Werkidentitaet und Dokumentation

<div class="study-card">

**Dauer:** ca. 1 Minute plus Dokumentation

**Idee:** Erstelle eine kurze Studie und dokumentiere sie anschliessend so, als sollte sie in einem anderen Studio rekonstruiert werden.

**Material:**
- 2 bis 3 Klangobjekte
- eine klare Raumform, zum Beispiel Dialog links/rechts mit Aufstieg in die Decke

**Ablauf:**
| Zeit | Fokus | Aktion |
| --- | --- | --- |
| `0:00-1:00` | vollstaendige Miniatur | Anfang, Verdichtung und Schlussgeste in einer kompakten Raumform |

**REAPER-Fokus:** Exportiere danach nicht nur Audio, sondern notiere:
- HOA-Order und Format
- verwendete Decoder-Annahme
- wichtige Trajektorien
- kritische Raumzonen
- Screenshot der Automation oder Radar-Ansicht

</div>

Diese zehn Studien koennen einzeln bearbeitet oder zu groesseren Projektskizzen verbunden werden. Besonders produktiv ist es, **dieselbe Klangquelle** durch mehrere Fragen hindurch zu testen. So wird hoerbar, dass sich die Leitfragen nicht nur auf Inhalte beziehen, sondern direkt auf **Form, Routing, Automation und Dramaturgie**.

Die zehn Fragen machen sichtbar, dass räumliche Komposition nicht allein aus Positionen und Bewegungen besteht, sondern von der Wahrnehmbarkeit und Stabilität klanglicher Einheiten abhängt. Bevor räumliche Beziehungen zwischen mehreren Klangobjekten präzise gestaltet werden können, muss daher geklärt werden, wodurch ein Klang im Raum überhaupt als Gestalt hervortritt. Das folgende Kapitel wendet sich deshalb der **Akustischen Gestalt eines Klanges** zu.

## Die zehn Fragen im Überblick

Die folgende Übersicht ist kein starres Formular, sondern eine **kompositorische Karte**. Einige Fragen betreffen eher den Weltentwurf eines Stücks, andere seine räumliche Lesbarkeit, wieder andere das spätere Hören, Rendern und Dokumentieren. Gerade in der Arbeit an Ambisonics-Stücken springen diese Ebenen ständig ineinander.

<figure class="big">
  <img src="/images/ten-questions-map-de.svg" alt="Uebersicht der zehn Fragen im 3D-Raum als Karte mit den Bereichen Ontologie, Form, Layer, Dichte, Bewegung, Lokalisation, Ziel-Setup, Publikum, Archetypen und Werkidentität" loading="lazy" />
  <figcaption><strong>Die zehn Fragen als Arbeitskarte.</strong> Links entstehen Welt und Form, in der Mitte werden Objekte, Layer und Bewegungen organisiert, rechts folgen Hörsituation, Publikum und Werkdokumentation. Die Reihenfolge ist hilfreich, aber nicht zwingend linear.</figcaption>
</figure>

### 1. Ontologie des Stücks — Was ist da?

<div class="question-card">

**Leitfrage:** Welche Art von Welt baut das Stück im Raum auf?

**Unterfragen:** Arbeite ich mit erkennbaren Orten/Szenen (Stadt, Landschaft, Innenraum) oder mit abstrakten Raumgebilden? Gibt es identifizierbare Akteure (Klangobjekte) und Umgebungen (Felder, Texturen)?

**Entscheidungsoptionen:**
- realistisch / ökologisch
- abstrahiert aus realen Räumen
- rein abstrakt / „imaginärer Raum"
- Fokus auf Einzelobjekten
- Fokus auf Texturen/Feldern

</div>

---

### 2. Rolle des Raums — Raum vs. Spektrum/Zeit

<div class="question-card">

**Leitfrage:** Was trägt primär die Form — die Raumgesten oder die spektral‑zeitliche Entwicklung?

**Unterfragen:** Könnte das Stück in Stereo noch funktionieren, oder bricht die Form dann zusammen? Gibt es Abschnitte, die fast ausschließlich über räumliche Veränderungen definiert sind (space‑form)?

**Entscheidungsoptionen:**
- Form primär spektral/zeitlich, Raum sekundär
- Form gleichwertig Raum + Spektrum/Zeit
- Form primär räumlich (Raumarchitektur, Klänge füllen sie)
- Markiere pro Abschnitt: „R > S/T", „R = S/T" oder „R < S/T"

</div>

---

### 3. Raumebenen — Layer

<div class="question-card">

**Leitfrage:** Wie viele unterscheidbare räumliche Ebenen gibt es?

**Unterfragen:** Welche Zonen sind wichtig (vorne, hinten, oben, unten, Nähe, Ferne)? Gibt es eine konstante Kulisse, über der sich Vordergrundgesten abspielen?

**Entscheidungsoptionen:**
- Vordergrund‑Objekte (klar lokalisierbar)
- Mittelfeld‑Textur
- Hintergrund‑Ambience / Fernfeld
- Overhead‑Ebene / „Decke"
- Boden / unterhalb der Hörhöhe

**Notiere pro Ebene:** Klangtyp, Dichte, typische Bewegungen.

</div>

---

### 4. Objektzahl und Dichte

<div class="question-card">

**Leitfrage:** Wie voll ist der Raum zu welchem Zeitpunkt?

**Unterfragen:** Wie viele aktive Objekte können gleichzeitig bewusst verfolgt werden? Gibt es gezielte Dichte‑Kippen (Geste → Textur, Klarheit → Wolke)?

**Entscheidungsoptionen:**
- Max. Anzahl verfolgbarer Objekte: ___
- Typische Dichte pro Abschnitt (z.B. 1–3 / 4–8 / >8 Objekte)
- Markiere Stellen, wo du bewusst in Überfülle oder Leere gehst

</div>

---

### 5. Trajektorien und Gestentypen

<div class="question-card">

**Leitfrage:** Welche Arten von Bewegung kommen vor?

**Unterfragen:** Nutze ich geometrische Bewegungen (Kreise, Ringe, Spiralen) oder gestische Bewegungen (Annäherung, Flucht, Umschwirren)? Gibt es Signature‑Gesten, die wiederkehren?

**Entscheidungsoptionen:**
- Kreis / Umlaufbewegung
- Linie / Fahrt in eine Richtung
- Vertikale Bewegung (unten–oben / oben–unten)
- Explosion / Implosion
- Schwarm / Flock (viele ähnliche Trajektorien)

**Notiere pro Geste:** den Zweck, z.B. Beginn neuer Abschnitt oder Klimax‑Marker.

</div>

---

### 6. Lokalisation vs. Diffusität

<div class="question-card">

**Leitfrage:** Wann sollen Klänge punktgenau sein, wann flächig?

**Unterfragen:** Gibt es dramaturgisch wichtige Momente mit maximaler Schärfe oder mit maximaler Umhüllung? Nutze ich Fokus/Defokus‑Übergänge gezielt als Formbaustein?

**Entscheidungsoptionen — Skala 1–5 für jeden Abschnitt:**
- 1 = sehr diffus / Wolke
- 3 = gemischt
- 5 = sehr präzise Lokalisation

**Markiere Stellen:** Fokus‑Geste (diffus → punktuell) / Defokus‑Geste (punktuell → diffus).

</div>

---

### 7. Ziel‑Abhörszenario

<div class="question-card">

**Leitfrage:** Für welches reale Wiedergabesetting komponiere ich?

**Unterfragen:** Welche Lautsprecherkonfiguration habe ich im Kopf (Dome, 5.1/7.1, Kopfhörer)? Muss das Stück in mehreren Formaten funktionieren?

**Entscheidungsoptionen — Primärziel:**
- 3D‑Dome / spezifisches Array
- Mehrkanal (5.1 / 7.1 / 22.2)
- Binaural (Kopfhörer)

**Sekundär:** Stereo‑Kompatibilität wichtig / unwichtig. Notiere pro Ziel ggf. Einschränkungen (z.B. Overhead‑Strukturen werden binaural abgeschwächt).

**Hören:** [#13 Listening Twice — Stereo vs. Immersive](/blog/ascolta/13-ascolta/) · [#14 5.1 Surround vs. Ambisonics UHJ](/blog/ascolta/14-ascolta/) · [#15 UHJ-Aufnahmen aus den 1970ern](/blog/ascolta/15-ascolta/)

</div>

---

### 8. Publikum und Hörerfahrung

<div class="question-card">

**Leitfrage:** Wie räumlich „trainiert" ist das angenommene Publikum?

**Unterfragen:** Wird das Stück eher in Festivals mit erfahrenem Publikum oder in general audience-Kontexten gespielt? Müssen Kontraste klar und lesbar sein, oder dürfen sie subtil bleiben?

**Entscheidungsoptionen:**
- räumlich erfahrenes Publikum
- gemischt
- wenig Erfahrung

**Konsequenz:** starke, klare Raumkontraste / feinere, mikroskopische Differenzen / Kombination (z.B. klarer Makro‑Bogen + subtile Details).

**Hören:** [Alle ASCOLTA-Sessions](/blog/ascolta/) — von Fachpublikum bis Ersthörende

</div>

---

### 9. Realraum‑Bezug und Archetypen

<div class="question-card">

**Leitfrage:** Wie verhalte ich mich zu realen Räumen und Raum‑Metaphern?

**Unterfragen:** Nutze ich bekannte Archetypen (Tunnel, Platz, Innenraum, Außen, Höhe, Abgrund)? Will ich reale Räume nachbilden, verfremden oder etwas physisch Unmögliches bauen?

**Entscheidungsoptionen:**
- Mimesis (Nachbildung realer Räume)
- Verfremdung / Überzeichnung
- Unmögliche Räume

**Notiere:** die verwendeten Archetypen und ihre musikalische Funktion (z.B. Tunnel = Übergang, Platz = Kulminationsort).

**Hören:** [#10 Natasha Barrett — räumliches Argument über Einschluss und Öffnung](/blog/ascolta/10-ascolta/)

</div>

---

### 10. Werkidentität und Dokumentation

<div class="question-card">

**Leitfrage:** Was ist eigentlich das „Werk" — und wie dokumentiere ich es?

**Unterfragen:** Ist die HOA‑Masterdatei der eigentliche Werkkern oder eine bestimmte Decoder‑Konfiguration? Braucht es Partitur, Patch, Textinstruktionen und Layoutpläne, um das Stück rekonstruierbar zu halten?

**Entscheidungsoptionen — Referenz:**
- HOA‑Master (z.B. 7. Ordnung)
- konkrete Lautsprecher‑Version (z.B. 24.1 Layout X)
- binaurale Veröffentlichung

**Dokumentation:**
- Lautsprecher‑Plan(e)
- Textbeschreibung der Raumform(en)
- Screenshots/Exports von Trajektorien / Automation
- eigene „Raum‑Partitur" (Diagramme/Timeline)

</div>
