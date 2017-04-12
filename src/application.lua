require("stack")
require("gamestate")
local PlayingState = require "playingstate"

local Application = {}

--hold all of the gamestates in a Stack data type
Application.gamestates = Stack:new()

--functions to change the gamestate
function Application:pushState(state)
    Application.gamestates:push(state)
end

function Application:popState()
    Application.gamestates:pop()
end

function Application:changeState(state)
    Application.gamestates:pop()
    Application.gamestates:push(state)
end


--all callback functions
function Application:load()
    Application.gamestates:push(PlayingState:new(Application))
end

function Application:update(dt)
    Application.gamestates:top():update(dt)
end

function Application:draw()
    Application.gamestates:top():draw()
end

function Application:quit()
    Application.gamestates:top():quit()
end

function Application:keypressed(key, code, isRepeat)
    Application.gamestates:top():keypressed(key, code, isRepeat)
end

function Application:keyreleased(key, code)
    Application.gamestates:top():keyreleased(key, code)
end

function Application:mousepressed(x, y, button, isTouch)
    Application.gamestates:top():mousepressed(x, y, button, isTouch)
end

function Application:mousereleased(x, y, button, isTouch)
    Application.gamestates:top():mousereleased(x, y, button, isTouch)
end

function Application:focus(f)
    Application.gamestates:top():focus(f)
end

return Application
