-- Öffnet MiniMeters.app unter macOS

function open_miniMeters()
  local app_path = "/Applications/miniMeters.app"
  local command = 'open "' .. app_path .. '"'
  os.execute(command)
end

reaper.Undo_BeginBlock()
open_miniMeters()
reaper.Undo_EndBlock("MiniMeters.app gestartet", -1)


