-- ============================================================================
-- flugshow_demo.lua
-- Reaper ReaScript (Lua) – Generative Flugshow über die ganze Kugel
-- ============================================================================
--
-- Erzeugt eine 90-sekündige räumliche Flugshow über alle Bereiche der Kugel:
--   • Weite Kreise auf verschiedenen Höhen
--   • Nahüberflug (Near-Field, d ≈ 0.3)
--   • Zenitdurchflug (direkt über dem Kopf)
--   • Tiefflug unter den Horizont
--   • Beschleunigte Spirale zum Finale
--
-- Trajektorie ist rein mathematisch (Summe von Sinuswellen + Gauss-Pulse) →
-- garantiert stetig und glatt, keine Sprünge.
--
-- Voraussetzungen:
--   • Python 3 (auf macOS vorinstalliert)
--   • ICST AmbiEncoder 64: Settings → OSC In → Enable, Port 50001
--   • Reaper-Playhead bei 0:00 starten
--
-- Starten: Actions → Load/Run ReaScript → flugshow_demo.lua
-- ============================================================================

-- ─── Konfiguration ─────────────────────────────────────────────────────────

local OSC_HOST   = "127.0.0.1"
local OSC_PORT   = 50001
local SOURCE_IDX = 1
local DURATION   = 90.0   -- Gesamtdauer der Show in Sekunden

-- ─── Dramaturgie ────────────────────────────────────────────────────────────
-- Zeitmarken für die Konsolenausgabe (zur Orientierung im Workshop)

local PHASES = {
  {  0, "Start: Einflug von rechts-hinten"},
  { 10, "Weiter Horizontalkreis (r ≈ 1.4)"},
  { 22, "Aufsteigende Spirale"},
  { 35, "Nahüberflug! (Near-Field, d ≈ 0.3)"},
  { 42, "Weiter Abstand, Höhe steigt"},
  { 50, "Zenitdurchflug (direkt oben)"},
  { 60, "Abstieg → unter den Horizont"},
  { 70, "Tiefflug (z < 0)"},
  { 78, "Finale: enger werdende Spirale"},
  { 88, "Abflug nach oben-hinten"},
}

-- ─── Trajektorienfunktion ───────────────────────────────────────────────────
-- Mathematisch glatte Kurve: Summe mehrerer Sinuswellen + Gauss-Pulse
-- für dramatische Ereignisse. Kein Tabellen-Lookup, keine Sprünge.

local pi = math.pi

-- Gauss-Puls: klingt an t=center auf, Breite = sigma Sekunden
local function gauss(t, center, sigma)
  local dt = t - center
  return math.exp(-(dt * dt) / (2 * sigma * sigma))
end

local function get_pos(t)

  -- ── Azimuth ──────────────────────────────────────────────────────────────
  -- Hauptrotation + zwei überlagerte Wobbles → unregelmäßige Kreisbahn
  local az_deg =   t * 26.0                          -- 26°/s Grundrotation
    +  35 * math.sin(t * 0.17)                       -- langsame Schwingung
    +  18 * math.sin(t * 0.53 + 1.3)                -- mittlere Schwingung
    +   8 * math.sin(t * 1.40 + 0.5)                -- schnelle Variation

  -- Finale: schnellere Rotation ab t≈78s
  if t > 78 then
    az_deg = az_deg + (t - 78) * 18
  end

  -- ── Elevation ────────────────────────────────────────────────────────────
  local el_deg =  12 * math.sin(t * 0.20)            -- Haupthöhenschwingung
    +  10 * math.sin(t * 0.44 + 0.9)                -- Überlagerung
    +  58 * gauss(t, 50, 4.5)                        -- Zenitpuls (t=50s, bis ~80°)
    -  32 * gauss(t, 70, 5.0)                        -- Tiefflugpuls (t=70s, bis ~-20°)
    +  40 * gauss(t, 88, 3.0)                        -- Abflug nach oben (t=88s)

  -- Elevation auf ±88° begrenzen (Polsingularität vermeiden)
  el_deg = math.max(-88, math.min(88, el_deg))

  -- ── Distanz ──────────────────────────────────────────────────────────────
  local r = 1.10                                     -- Grunddistanz
    + 0.55 * math.sin(t * 0.28 + 0.4)              -- langsames Atmen
    + 0.20 * math.sin(t * 0.80 + 2.1)              -- kurze Variation
    + 0.70 * gauss(t, 18, 4.0)                      -- Weiter Bogen (t=18s)
    - 0.85 * gauss(t, 35, 2.0)                      -- Nahüberflug! (t=35s, d≈0.3)
    + 0.50 * gauss(t, 55, 4.0)                      -- Weitflug nach Zenit

  -- Finale: Spirale wird enger
  if t > 78 then
    r = r - (t - 78) * 0.035
  end

  r = math.max(0.28, r)   -- Mindestdistanz 28 cm

  -- ── Sphärisch → Kartesisch ───────────────────────────────────────────────
  local az = az_deg * pi / 180
  local el = el_deg * pi / 180

  local cos_el = math.cos(el)
  local x = r * cos_el * math.sin(az)
  local y = r * cos_el * math.cos(az)
  local z = r * math.sin(el)

  return x, y, z
end

-- ─── Python-OSC-Brücke (kein LuaSocket nötig) ───────────────────────────────

local HELPER = "/tmp/flugshow_osc.py"

local py = string.format([[
import sys, socket, struct

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

def osc_str(b):
    b = b + b'\x00'
    b += b'\x00' * ((-len(b)) %% 4)
    return b

ADDR  = osc_str(b'/icst/ambi/sourceindex/xyz')
TYPES = osc_str(b',ifff')

while True:
    line = sys.stdin.readline()
    if not line or line.strip() == 'quit': break
    line = line.strip()
    if not line: continue
    try:
        p = line.split()
        msg = ADDR + TYPES + struct.pack('>ifff',
              int(p[0]), float(p[1]), float(p[2]), float(p[3]))
        s.sendto(msg, ('%s', %d))
    except: pass
s.close()
]], OSC_HOST, OSC_PORT)

local hf = io.open(HELPER, "w")
if not hf then
  reaper.ShowMessageBox("Konnte " .. HELPER .. " nicht schreiben.",
    "flugshow_demo – Fehler", 0)
  return
end
hf:write(py)
hf:close()

local proc = io.popen("python3 -u " .. HELPER, "w")
if not proc then
  reaper.ShowMessageBox("Python 3 nicht gefunden.",
    "flugshow_demo – Fehler", 0)
  return
end

-- ─── OSC senden ─────────────────────────────────────────────────────────────

local function send_xyz(x, y, z)
  proc:write(string.format("%d %f %f %f\n", SOURCE_IDX, x, y, z))
  proc:flush()   -- sofort senden, kein Puffer-Stau
end

-- ─── Phasen-Anzeige ─────────────────────────────────────────────────────────

local next_phase = 1
local function check_phase(t)
  if next_phase <= #PHASES and t >= PHASES[next_phase][1] then
    reaper.ShowConsoleMsg(string.format(
      "  [%5.1fs] %s\n", t, PHASES[next_phase][2]))
    next_phase = next_phase + 1
  end
end

-- ─── atexit ─────────────────────────────────────────────────────────────────

reaper.atexit(function()
  send_xyz(0.0, 0.0, 0.0)
  proc:write("quit\n")
  proc:close()
  os.remove(HELPER)
  reaper.ShowConsoleMsg("flugshow_demo: beendet.\n")
end)

reaper.ShowConsoleMsg(string.format(
  "flugshow_demo: gestartet → %s:%d  (%.0fs Show)\n",
  OSC_HOST, OSC_PORT, DURATION))
for _, ph in ipairs(PHASES) do
  reaper.ShowConsoleMsg(string.format("  %3ds  %s\n", ph[1], ph[2]))
end
reaper.ShowConsoleMsg("\n")

-- ─── Defer-Loop ─────────────────────────────────────────────────────────────

local last_log = -9999

local function main()
  local state = reaper.GetPlayState()

  if state == 0 then
    send_xyz(0.0, 0.0, 0.0)
    reaper.ShowConsoleMsg("flugshow_demo: gestoppt.\n")
    return
  end

  if state == 1 or state == 5 then
    local t = reaper.GetPlayPosition()

    if t >= 0 and t <= DURATION then
      local x, y, z = get_pos(t)
      send_xyz(x, y, z)
      check_phase(t)

      -- Konsol-Log alle 2 Sekunden
      if t - last_log >= 2.0 then
        last_log = t
        local r  = math.sqrt(x*x + y*y + z*z)
        local el = math.asin(z / math.max(r, 0.001)) * 180 / pi
        local az = math.atan(x, y) * 180 / pi
        reaper.ShowConsoleMsg(string.format(
          "  t=%5.1fs  az=%6.1f°  el=%5.1f°  d=%.2f\n",
          t, az, el, r))
      end

    elseif t > DURATION then
      -- Show vorbei: Quelle sanft nach vorne-oben schicken
      send_xyz(0.0, 1.0, 0.3)
    end
  end

  reaper.defer(main)
end

-- Playback starten falls noch nicht läuft
if reaper.GetPlayState() == 0 then
  reaper.Main_OnCommand(1007, 0)   -- Transport: Play
end

main()
