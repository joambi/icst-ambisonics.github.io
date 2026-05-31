-- ============================================================================
-- heli_osc_trajectory.lua
-- Reaper ReaScript (Lua) – Helikopter-Trajektorie via OSC → ICST AmbiEncoder
-- ============================================================================
--
-- Kein LuaSocket nötig: nutzt Python 3 (auf macOS immer vorhanden) als
-- UDP-Helfer. Lua schreibt Koordinaten zeilenweise in den Python-Stdin-Pipe,
-- Python kodiert OSC binär und sendet via UDP.
--
-- Voraussetzungen:
--   • Reaper (beliebige Version)
--   • Python 3  (macOS: vorinstalliert)
--   • ICST AmbiEncoder 64: Settings → OSC In → Enable, Port 50001
--   • Helikopter-WAV als Item auf Track 1, ab Zeitposition 0:00
--
-- Starten: Actions → Load / Run ReaScript → heli_osc_trajectory.lua
-- Beenden: Script erneut ausführen (Toggle) oder Playback stoppen
-- ============================================================================

-- ─── Konfiguration ─────────────────────────────────────────────────────────

local OSC_HOST   = "127.0.0.1"
local OSC_PORT   = 50001
local SOURCE_IDX = 1
local Z_FIXED    = 0.17      -- ~10° Elevation
local TOTAL_SECS = 127       -- Länge der Trajektorie

-- ─── Trajektorie (128 Punkte, t = 0…127 s) ─────────────────────────────────
-- x = sin(az)*d,  y = cos(az)*d   (ICST-Koordinatensystem: y=vorne)

local XP = {
  -0.02,  0.08,  0.18,  0.30,  0.45,  0.58,  0.68,  0.74,
   0.76,  0.72,  0.62,  0.48,  0.30,  0.10, -0.10, -0.28,
  -0.44, -0.56, -0.64, -0.67, -0.64, -0.56, -0.44, -0.28,
  -0.08,  0.14,  0.34,  0.50,  0.62,  0.68,  0.70,  0.66,
   0.56,  0.42,  0.24,  0.04, -0.16, -0.34, -0.50, -0.60,
  -0.66, -0.65, -0.58, -0.44, -0.25, -0.04,  0.18,  0.38,
   0.54,  0.64,  0.68,  0.65,  0.56,  0.40,  0.22,  0.02,
  -0.18, -0.36, -0.50, -0.58, -0.60, -0.55, -0.44, -0.28,
  -0.08,  0.14,  0.34,  0.52,  0.64,  0.70,  0.70,  0.63,
   0.50,  0.33,  0.12, -0.10, -0.30, -0.48, -0.60, -0.66,
  -0.65, -0.58, -0.44, -0.26, -0.05,  0.16,  0.36,  0.52,
   0.62,  0.66,  0.62,  0.52,  0.36,  0.16, -0.05, -0.26,
  -0.44, -0.58, -0.65, -0.66, -0.60, -0.48, -0.30, -0.10,
   0.12,  0.33,  0.50,  0.63,  0.70,  0.70,  0.64,  0.52,
   0.34,  0.14, -0.08, -0.28, -0.44, -0.55, -0.60, -0.58,
  -0.50, -0.36, -0.18,  0.02,  0.22,  0.40,  0.56,  0.65,
}

local YP = {
   1.00,  0.98,  0.92,  0.80,  0.62,  0.40,  0.16, -0.10,
  -0.34, -0.55, -0.70, -0.78, -0.78, -0.70, -0.55, -0.36,
  -0.14,  0.10,  0.32,  0.52,  0.66,  0.74,  0.74,  0.66,
   0.52,  0.30,  0.06, -0.18, -0.38, -0.54, -0.62, -0.62,
  -0.54, -0.40, -0.22, -0.02,  0.18,  0.36,  0.50,  0.56,
   0.56,  0.48,  0.34,  0.16, -0.04, -0.22, -0.36, -0.44,
  -0.44, -0.36, -0.20, -0.02,  0.16,  0.32,  0.44,  0.48,
   0.44,  0.34,  0.18,  0.00, -0.18, -0.34, -0.44, -0.48,
  -0.44, -0.32, -0.16,  0.04,  0.22,  0.38,  0.48,  0.50,
   0.44,  0.30,  0.12, -0.08, -0.26, -0.40, -0.48, -0.48,
  -0.40, -0.26, -0.08,  0.12,  0.30,  0.44,  0.50,  0.46,
   0.34,  0.16, -0.04, -0.22, -0.36, -0.44, -0.44, -0.36,
  -0.20, -0.00,  0.18,  0.34,  0.44,  0.48,  0.42,  0.28,
   0.10, -0.10, -0.28, -0.42, -0.48, -0.46, -0.36, -0.20,
  -0.00,  0.20,  0.36,  0.46,  0.48,  0.42,  0.28,  0.10,
  -0.10, -0.28, -0.42, -0.50, -0.48, -0.36, -0.18,  0.02,
}

-- ─── Python-Helfer schreiben und starten ────────────────────────────────────
-- Python übernimmt OSC-Binärcodierung + UDP-Senden.
-- Lua schreibt Zeilen "idx x y z\n" in den Stdin-Pipe.

local HELPER_PATH = "/tmp/heli_osc_helper.py"

local py_code = string.format([[
import sys, socket, struct

HOST = "%s"
PORT = %d

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

def osc_str(b):
    b = b + b'\x00'
    b += b'\x00' * ((-len(b)) %% 4)
    return b

ADDR  = osc_str(b'/icst/ambi/sourceindex/xyz')
TYPES = osc_str(b',ifff')

sys.stderr.write('heli_osc_helper: bereit\n')
sys.stderr.flush()

while True:
    line = sys.stdin.readline()
    if not line or line.strip() == 'quit':
        break
    line = line.strip()
    if not line:
        continue
    try:
        parts = line.split()
        idx = int(parts[0])
        x, y, z = float(parts[1]), float(parts[2]), float(parts[3])
        msg = ADDR + TYPES + struct.pack('>ifff', idx, x, y, z)
        s.sendto(msg, (HOST, PORT))
    except Exception as e:
        sys.stderr.write('OSC-Fehler: ' + str(e) + '\n')

s.close()
sys.stderr.write('heli_osc_helper: beendet\n')
]], OSC_HOST, OSC_PORT)

-- %% weil string.format % escaped
local hf = io.open(HELPER_PATH, "w")
if not hf then
  reaper.ShowMessageBox("Konnte /tmp/heli_osc_helper.py nicht schreiben.",
    "heli_osc_trajectory – Fehler", 0)
  return
end
hf:write(py_code)
hf:close()

-- Python als persistenten Subprozess starten (Stdin-Pipe)
local proc = io.popen("python3 -u " .. HELPER_PATH, "w")
if not proc then
  reaper.ShowMessageBox(
    "Python 3 konnte nicht gestartet werden.\nIst python3 im PATH?",
    "heli_osc_trajectory – Fehler", 0)
  return
end

-- ─── Daten vor-glätten ──────────────────────────────────────────────────────
-- 5-Punkt Gauss-ähnlicher Filter, mehrere Durchläufe.
-- Eliminiert Peaks (z.B. d≈0 bei t≈35s) bevor interpoliert wird.

local function smooth_pass(arr)
  local N   = #arr
  local out = {}
  for i = 1, N do
    local a = arr[math.max(1,   i - 2)]
    local b = arr[math.max(1,   i - 1)]
    local c = arr[i]
    local d = arr[math.min(N,   i + 1)]
    local e = arr[math.min(N,   i + 2)]
    out[i] = (a + 2*b + 4*c + 2*d + e) / 10.0
  end
  return out
end

local SMOOTH_PASSES = 4
for _ = 1, SMOOTH_PASSES do
  XP = smooth_pass(XP)
  YP = smooth_pass(YP)
end

-- Mindestdistanz: Quelle bleibt mindestens 0.30 vom Zentrum entfernt
local MIN_DIST = 0.30
local function clamp_dist(x, y)
  local d = math.sqrt(x * x + y * y)
  if d < MIN_DIST then
    if d < 0.001 then return MIN_DIST, 0.0 end   -- Richtung unklar → vorne
    local s = MIN_DIST / d
    return x * s, y * s
  end
  return x, y
end

-- ─── Interpolation (Catmull-Rom) ─────────────────────────────────────────────
-- Stetige Geschwindigkeit an allen Datenpunkten → keine Richtungssprünge

local function catmull_rom(p0, p1, p2, p3, t)
  return 0.5 * (
    (2 * p1) +
    (-p0 + p2) * t +
    (2*p0 - 5*p1 + 4*p2 - p3) * t * t +
    (-p0 + 3*p1 - 3*p2 + p3) * t * t * t
  )
end

local function get_xy(t_sec)
  local N    = #XP
  local i    = math.min(math.floor(t_sec) + 1, N - 1)
  local frac = t_sec - math.floor(t_sec)
  local i0   = math.max(1, i - 1)
  local i1   = i
  local i2   = math.min(N, i + 1)
  local i3   = math.min(N, i + 2)
  local x    = catmull_rom(XP[i0], XP[i1], XP[i2], XP[i3], frac)
  local y    = catmull_rom(YP[i0], YP[i1], YP[i2], YP[i3], frac)
  return clamp_dist(x, y)
end

local function send_xyz(x, y, z)
  proc:write(string.format("%d %f %f %f\n", SOURCE_IDX, x, y, z))
  proc:flush()   -- sofort senden, kein Puffer-Stau
end

-- ─── atexit ─────────────────────────────────────────────────────────────────

reaper.atexit(function()
  send_xyz(0.0, 0.0, 0.0)
  proc:write("quit\n")
  proc:close()
  os.remove(HELPER_PATH)
  reaper.ShowConsoleMsg("heli_osc_trajectory: beendet, Quelle auf Mitte.\n")
end)

reaper.ShowConsoleMsg(
  "heli_osc_trajectory: gestartet → " .. OSC_HOST .. ":" .. OSC_PORT ..
  "  Source " .. SOURCE_IDX .. "\n"
)

-- ─── Defer-Loop ─────────────────────────────────────────────────────────────

local last_log_t = -9999

local function main()
  local state = reaper.GetPlayState()

  if state == 0 then
    -- Gestoppt → Mitte, Script endet
    send_xyz(0.0, 0.0, 0.0)
    reaper.ShowConsoleMsg("heli_osc_trajectory: Playback gestoppt → Ende.\n")
    return
  end

  if state == 1 or state == 5 then   -- Play oder Play+Record
    local t = reaper.GetPlayPosition()

    if t >= 0 and t <= TOTAL_SECS then
      local x, y = get_xy(t)
      send_xyz(x, y, Z_FIXED)

      if t - last_log_t >= 5.0 then
        last_log_t = t
        local d  = math.sqrt(x * x + y * y)
        local az = math.atan(x, y) * (180 / math.pi)
        reaper.ShowConsoleMsg(string.format(
          "  t=%6.1fs  x=%7.3f  y=%7.3f  d=%.2f  az=%6.1f°\n",
          t, x, y, d, az))
      end

    elseif t > TOTAL_SECS then
      send_xyz(XP[#XP], YP[#YP], Z_FIXED)
    end
  end
  -- state == 2 (Pause): nichts senden, Position halten

  reaper.defer(main)
end

-- Playback starten falls noch nicht läuft
if reaper.GetPlayState() == 0 then
  reaper.Main_OnCommand(1007, 0)   -- Transport: Play
end

main()
