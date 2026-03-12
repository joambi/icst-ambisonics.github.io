# ICST HOA Routing-Checkliste

## Vor dem Start
- REAPER-Projekt oeffnen und unter neuem Namen speichern.
- Audio-Device, Sample Rate und Buffer-Groesse pruefen.
- Sicherstellen, dass die benoetigten ICST Ambisonics Plugins installiert sind.

## Kanalanzahl
- Master-Track auf `64` Kanaele setzen.
- Alle HOA-relevanten Tracks auf `64` Kanaele setzen.
- Decoder-Ausgang an das reale Lautsprecher-Setup anpassen.

## Signalfluss
- Quellen laufen in einen klar benannten HOA-Bus.
- Der HOA-Bus speist den Decoder.
- Optionaler binauraler Kontrollpfad kommt aus demselben HOA-Bus.
- Keine unbeabsichtigten Direktwege von Quellen zum Master offen lassen.

## Plugin-Platzierung
- Auf Quelltracks: `ICST MonoEncoder` oder `ICST MultiEncoder`.
- Auf dem Decoder-Track: passendes Decoder-Plugin fuer das Lautsprecher-Setup.
- Decoder-Preset laden, bevor geprobt oder aufgenommen wird.

## Schnelltest
- Eine einzelne Quelle solo abhoeren.
- Position im Encoder leicht veraendern und auf korrekte Bewegung achten.
- Pruefen, ob Pegel am HOA-Bus anliegt.
- Pruefen, ob Decoder-Ausgaenge auf den erwarteten Lautsprechern landen.
- Falls binaural genutzt wird: Kopfhoererpfad separat kurz kontrollieren.

## Typische Fehler
- Ein Track im HOA-Pfad hat nicht `64` Kanaele.
- Der Decoder haengt direkt auf dem Master statt hinter dem HOA-Bus.
- Ein falsches Lautsprecher-Preset ist geladen.
- Quellen senden versehentlich direkt auf den Master.
- Monitoring erfolgt ueber den falschen Ausgangspfad.

## Vor Aufnahme oder Export
- Noch einmal mit einem kurzen Testsignal pruefen.
- Projektversion speichern.
- Exportformat und Kanalreihenfolge dokumentieren.
