local Player = require "player"
local playerw, playerh = Player:getDimensions()

local camera = {}

local padding = 200
local transx = 0
local transy = 0

local player

function camera:setPlayer(nPlayer)
    player = nPlayer
end

function camera:update()
    if player == nil then
        error("player not initialized in camera yet.")
    end
    local playerx, playery = player:getPosition()
    if playerx < transx + padding then
        transx = playerx - padding
    end
    if playerx + playerw > transx + love.graphics.getWidth() - padding then
        transx = playerx + playerw + padding - love.graphics.getWidth()
    end
    if playery < transy + padding then
        transy = playery - padding
    end
    if playery + playerh > transy + love.graphics.getHeight() - padding then
        transy = playery + playerh + padding - love.graphics.getHeight()
    end
end

function camera:apply()
    --havent quite figured out why it has to be minus, but *shrug*
    love.graphics.translate(-transx, -transy)
end

function camera:reset()
    transx = 0
    transy = 0
end

return camera
