local Graph = require "graph"
local Room = require "room"
local settings = require "settings"
--convenience variables
local startx = settings.startingTile.gridx
local starty = settings.startingTile.gridy

--singleton / global variable which holds all doors
local Rooms = {}

local graph = Graph()
local rooms = {}
local world

function Rooms:reset(newWorld)
    graph = Graph()
    world = newWorld
    local room = Room(world, startx, starty)
    room:addDoors()
    rooms = {room}
    graph:addVertice(room)
end

function Rooms:draw()
    for _, v in pairs(rooms) do
        v:draw()
    end
end

local grid = require "grid"
local function getDoor(gridx, gridy)
    if grid:get(gridx, gridy) == false then
        error("grid at ", gridx, gridy, " is empty")
        return nil
    end
    --print("graph.vertices: ", graph.vertices)
    for k, v in pairs(graph.vertices) do
        if v:contains(gridx, gridy) then
            return v
        end
    end
    return nil --actually not needed
end

local Queue = require "queue"
local util = require "util"
function Rooms:addRoom(prevx, prevy, x, y)
    --print("called add room with arguments:", prevx, prevy, x, y)
    local newRoom = Room(world, x, y)
    graph:addVertice(newRoom)
    local prevDoor = getDoor(prevx, prevy)
    if prevDoor == nil then
        error("this error shouldnt happen.")
    end
    graph:addEdge(newRoom, prevDoor)
    --"breitensuche"
    local queue = Queue()
    local visited = {}
    queue:add(newRoom)
    while queue:isEmpty() == false do
        local room = queue:poll()
        local result = room:addDoors()
        if result == false then
            table.insert(visited, room)
            local edges = graph:getEdges(room)
            for k, v in pairs(edges) do
                local destination = v.destination
                local alreadyVisited = false
                for k, v in pairs(visited) do
                    if v == destination then
                        alreadyVisited = true
                        break
                    end
                end
                if alreadyVisited == false then
                    queue:add(destination)
                end
            end
        end
    end
    table.insert(rooms, newRoom)
end

function Rooms:getGraph()
    return graph
end

--function getRoom(gridx, gridy)
--
--end

return Rooms
