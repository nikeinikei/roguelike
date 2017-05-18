--todo resizable window
local settings = require "settings"
local padding = settings.camera.padding
local minimumWidth = padding * 2 + settings.player.w
local minimumHeight = padding * 2 + settings.player.h

function love.conf(t)
    t.console = true
    t.window.title = "Roguelike"
    t.window.width = 1024
    t.window.height = 768
    t.window.resizable = true
    t.window.minwidth = minimumWidth
    t.window.minheight = minimumHeight
end
