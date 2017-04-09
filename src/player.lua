local Player = {}

local w = 30
local h = 30
local x = (love.graphics.getWidth()/2) - (w/2)
local y = (love.graphics.getHeight()/2) - (h/2)
local v = 400

function Player:update(dt)
    if love.keyboard.isDown("up") then
        y = y - (v*dt)
    end
    if love.keyboard.isDown("right") then
        x = x + (v*dt)
    end
    if love.keyboard.isDown("down") then
        y = y + (v*dt)
    end
    if love.keyboard.isDown("left") then
        x = x - (v*dt)
    end
end

function Player:draw()
    love.graphics.setColor(220,220,220,255)
    love.graphics.rectangle("fill", x, y, w, h)
end

function Player:getWidth()
    return w
end

function Player:getPosition()
    return x, y
end

function Player:getDimensions()
    return w, h
end

return Player
