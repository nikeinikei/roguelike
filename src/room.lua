local grid = require "grid"
local Wall = require "wall"
local Door = require "door"

local Room = {}
Room.__index = Room

local probabilityMultiplier = 0.985 --this will generate approximately 10 unit squares everytime

local function makePair(x, y)
    local o = {}
    o.x = x
    o.y = y
    return o
end

local probability
local rooms

--todo create another algorithm which takes a random room everytime of the iteration instead of chaining the rooms together
local function addRoom(x, y)
    local randomNumber = love.math.random()
    if randomNumber <= probability then
        probability = probability * probabilityMultiplier
        grid:set(x, y)
        table.insert(rooms, makePair(x, y))
        local directions = {}
        if grid:get(x, y - 1) == false then
            table.insert(directions, "top")
        end
        if grid:get(x + 1, y) == false then
            table.insert(directions, "right")
        end
        if grid:get(x, y + 1) == false then
            table.insert(directions, "lower")
        end
        if grid:get(x - 1, y) == false then
            table.insert(directions, "left")
        end
        if #directions > 0 then
            local randomDirection = directions[love.math.random(#directions)]
            if randomDirection == "top" then
                addRoom(x, y - 1)
            end
            if randomDirection == "right" then
                addRoom(x + 1, y)
            end
            if randomDirection == "lower" then
                addRoom(x, y + 1)
            end
            if randomDirection == "left" then
                addRoom(x - 1, y)
            end
        end
    end
end

local walls
local function addWalls(world, room)
    local x = room.x
    local y = room.y

    if grid:get(x, y - 1) == false then
        table.insert(walls, Wall:new(world, x, y, "top"))
    end
    if grid:get(x + 1, y) == false then
        table.insert(walls, Wall:new(world, x, y, "right"))
    end
    if grid:get(x, y + 1) == false then
        table.insert(walls, Wall:new(world, x, y, "lower"))
    end
    if grid:get(x - 1, y) == false then
        table.insert(walls, Wall:new(world, x, y, "left"))
    end
end

function Room:new(world, x, y)
    local o = {}
    setmetatable(o, self)

    rooms = {}
    probability = 1
    addRoom(x, y)
    o.rooms = rooms

    --wallgeneration
    walls = {}
    for _, v in pairs(rooms) do
        addWalls(world, v)
    end
    o.walls = walls
    o.world = world
    o.doors = {}

    return o
end

function Room:addDoor()
    local validWalls = {}
    for _, v in pairs(self.walls) do
        if v:isOpen() then
            table.insert(validWalls, v)
        end
    end
    if #validWalls > 0 then
        local randomWall = validWalls[love.math.random(#validWalls)]
        local wallx = randomWall.gridx
        local wally = randomWall.gridy
        local wallorientation = randomWall.orientation
        randomWall:destroy()
        local index
        for k, v in pairs(self.walls) do
            if v == randomWall then
                index = k
            end
        end
        if index == nil then
            error("this error shuoldnt happen.")
        end
        table.remove(self.walls, index)
        table.insert(self.doors, Door:new(self.world, wallx, wally, wallorientation))
        return true
    end
    return false
end

function Room:draw()
    for _, v in pairs(self.walls) do
        v:draw()
    end
    for _, v in pairs(self.doors) do
        v:draw()
    end
end

function Room:contains(gridx, gridy)
    --print("Room:contains(). self.rooms:", self.rooms)
    for k, v in pairs(self.rooms) do
        if v.x == gridx and v.y == gridy then
            return true
        end
    end
    return false
end

return Room
