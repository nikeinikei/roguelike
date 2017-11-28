--base class for all gamestates
--it implements all callback functions
local Gamestate = Object:extend()

function Gamestate:new(application)
    self.app = application
end

function Gamestate:setApp(application)
    self.app = application
end

function Gamestate:getApp()
    return self.app
end

function Gamestate:update(dt)
end

function Gamestate:draw()
end

function Gamestate:quit()
end

function Gamestate:keypressed(key, code, isRepeat)
end

function Gamestate:keyreleased(key, code)
end

function Gamestate:mousepressed(x, y, button, isTouch)
end

function Gamestate:mousereleased(x, y, button, isTouch)
end

function Gamestate:focus(f)
end

return Gamestate
