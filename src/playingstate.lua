--shows inheritance of a gamestate from the base class gamestate
--the functions of the base class can be overridden here

local Gamestate = require "gamestate"
local grid = require "grid"
local Player = require "player"
local camera = require "camera"
local bump = require "bump"
local rooms = require "rooms"
local shots = require "shots"

local player
local world

--inherit from Gamestate
local PlayingState = Gamestate:extend()

function PlayingState:new(application)
    self:setApp(application)
    
    grid:reset()
    camera:reset()
    shots:reset()
    
    world = bump.newWorld()
    rooms:reset(world)
    player = Player(world)
    camera:setPlayer(player)
end

function PlayingState:update(dt)
    --if player:update() wont return nil, nil the player has hit an open door
    local gridx, gridy = player:update(dt)
    if gridx ~= nil and gridy ~= nil then
        rooms:addRoom(player.gridx, player.gridy, gridx, gridy)
    end
    shots:update(dt)
    camera:update()
end

function PlayingState:draw()
    camera:apply()
    
    grid:draw()
    player:draw()
    rooms:draw()
    shots:draw()
    
    --reset the transformations done by the camera
    love.graphics.origin()
    love.graphics.setColor(1, 1, 1, 1)
    local fps = "fps: " .. love.timer.getFPS()
    love.graphics.print(fps)
end

function PlayingState:keypressed(key, _, isRepeat)
    if key == "escape" then
        love.event.quit()
    end
    --easy restart
    if key == "r" then
        love.event.quit("restart")
    end
    if key == "space" and isRepeat == false then
        local x, y = player:getCenter()
        shots:add(world, x, y, player.direction)
    end
end

return PlayingState
