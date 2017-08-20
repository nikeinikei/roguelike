--base class for all gamestates
--it implements all callback functions
local Gamestate = {}
local Gamestate_mt = {__index = Gamestate}

function Gamestate:new(application)
    local self = {}
    setmetatable(self, Gamestate_mt)
    self.app = application
    return self
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
