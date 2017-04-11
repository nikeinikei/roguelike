--shows inheritance of a gamestate from the base class gamestate
--the functions of the base class can be overridden here

local Gamestate = require "gamestate"
local grid = require "grid"
local Player = require "player"
local Room = require "room"
local camera = require "camera"
local bump = require "bump"
local settings = require "settings"

local room
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
    player = Player:new(world)
    camera:setPlayer(player)
    room = Room:new(world, settings.startingTile.gridx, settings.startingTile.gridy)

    return o
end

function PlayingState:update(dt)
    player:update(dt)
    camera:update()
end

function PlayingState:draw()
    camera:apply()

    grid:draw()
    player:draw()
    room:draw()

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

function PlayingState:quit()
end

return PlayingState
