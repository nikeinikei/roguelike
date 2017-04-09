--entry point of the program
--all callback functions get implemented and call the apropriate method of the Application

require("application")

function love.load()
    Application:load()
end

function love.update(dt)
    Application:update(dt)
end

function love.draw()
    Application:draw()
end

function love.quit()
    Application:quit()
end

function love.keypressed(key, code, isRepeat)
    Application:keypressed(key, code, isRepeat)
end

function love.keyreleased(key, code)
    Application:keyreleased(key, code)
end

function love.mousepressed(x, y, button, isTouch)
    Application:mousepressed(x, y, button, isTouch)
end

function love.mousereleased(x, y, button, isTouch)
    Application:mousereleased(x, y, button, isTouch)
end

function love.focus(f)
    Application:focus(f)
end
