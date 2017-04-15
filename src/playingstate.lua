--shows inheritance of a gamestate from the base class gamestate
--the functions of the base class can be overridden here

local Gamestate = require "gamestate"
local grid = require "grid"
local Player = require "player"
local camera = require "camera"
local bump = require "bump"
local rooms = require "rooms"

local player
local world

local PlayingState = Gamestate:new()
PlayingState.__index = PlayingState

function PlayingState:new(application)
    local o = {}
    setmetatable(o, self)
    o:setApp(application)

    grid:reset()

    world = bump.newWorld()
    rooms:reset(world)
    player = Player:new(world)
    camera:setPlayer(player)

    return o
end

function PlayingState:update(dt)
    local gridx, gridy = player:update(dt)
    if gridx ~= nil and gridy ~= nil then
        rooms:addRoom(player.gridx, player.gridy, gridx, gridy)
    end
    camera:update()
end

function PlayingState:draw()
    camera:apply()

    grid:draw()
    player:draw()
    rooms:draw()

    --reset the transformations done by the camera
    love.graphics.origin()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print(love.timer.getFPS())
end

function PlayingState:keypressed(key, code, isRepeat)
    if key == "escape" then
        love.event.quit()
    end
    --easy restart
    if key == "r" then
        love.event.quit("restart")
    end
end

return PlayingState
