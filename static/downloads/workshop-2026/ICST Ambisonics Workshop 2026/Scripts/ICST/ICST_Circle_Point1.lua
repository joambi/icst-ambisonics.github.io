-- ICST_Circle_Point1.lua
-- Geprüfte ImGui Version mit Child-Block, Start/Stop Button und sauberem Context

-- =========================
-- Globale Variablen
-- =========================
local ctx = reaper.ImGui_CreateContext('ICST Circle Point 1')

local speed       = 1.0
local radiusScale = 1.0
local axisMode    = 0
local running     = false
local startTime   = 0.0

-- Beispielpunkte (normalerweise von deinem AmbiEncoder Setup)
local points = {}
for i = 1, 8 do -- testweise 8 Punkte
  points[i] = { name = 'P'..i }
end

local selected = {}

-- =========================
-- Deine Logik hier einsetzen
-- =========================
local function readBasePositions()
  reaper.ShowConsoleMsg("Startpositionen gelesen!\n")
end

local function updatePoints()
  -- Hier deine Logik einbauen
end

-- =========================
-- Hauptloop
-- =========================
local function loop()
  local visible, open = reaper.ImGui_Begin(ctx, 'AmbiEncoder64 Group 64', true)

  if visible then
    _, speed       = reaper.ImGui_SliderDouble(ctx, 'Speed (rev/s)', speed, 0.0, 2.0, '%.2f')
    _, radiusScale = reaper.ImGui_SliderDouble(ctx, 'Radius Scale', radiusScale, 0.0, 2.0, '%.2f')
    _, axisMode    = reaper.ImGui_Combo(ctx, 'Achse', axisMode, 'XY\0XZ\0\0')

    reaper.ImGui_Separator(ctx)
    reaper.ImGui_Text(ctx, 'Punkte auswählen:')

    -- Fix: flags-Argument ergänzen
    if reaper.ImGui_BeginChild(ctx, 'scroll', 0.0, 200.0, true, 0) then
      for i, p in ipairs(points) do
        selected[i] = selected[i] or false
        _, selected[i] = reaper.ImGui_Checkbox(ctx, p.name, selected[i])
      end
      reaper.ImGui_EndChild(ctx)
    end

    reaper.ImGui_Separator(ctx)

    if reaper.ImGui_Button(ctx, running and '⏹ Stop' or '▶️ Start (liest Startpos)') then
      running = not running
      if running then
        startTime = reaper.time_precise()
        readBasePositions()
      end
    end
  end

  reaper.ImGui_End(ctx)

  if running then updatePoints() end

  if open then
    reaper.defer(loop)
  else
    reaper.ImGui_DestroyContext(ctx)
  end
end

reaper.defer(loop)


