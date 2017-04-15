local Array2d = require "array2d"

local Graph = {}
Graph.__index = Graph

function Graph:new()
    local o = {}
    setmetatable(o, self)
    o.matrix = Array2d:new()
    o.vertices = {}
    o.size = 0
    return o
end

function Graph:addVertice(id)
    self.size = self.size + 1
    self.vertices[self.size] = id
    for i = 1, self.size do
        self.matrix:set(self.size, i, -1)
        self.matrix:set(i, self.size, -1)
    end
    self.matrix:set(self.size, self.size, 0)
end

function Graph:getIndex(id)
    local index = -1
    for k, v in pairs(self.vertices) do
        if v == id then
            index = k
            break
        end
    end
    return index
end

function Graph:addEdge(id1, id2, weight)
    weight = weight or 1
    local index1 = self:getIndex(id1)
    local index2 = self:getIndex(id2)
    if index1 >= 1 and index2 >= 1 then
        self.matrix:set(index1, index2, weight)
        self.matrix:set(index2, index1, weight)
    end
end

function Graph:getAllEdges()
    local edges = {}
    for i = 1, self.size do
        for j = 1, self.size do
            local val = self.matrix:get(i, j)
            if val >= 1 then
                table.insert(edges, {start = self.vertices[i], destination = self.vertices[j], weight = val})
            end
        end
    end
    return edges
end

local function printEdge(edge)
    print("start: ", edge.start, "destination: ", edge.destination, "weight: ", edge.weight)
end

function Graph:print()
    print("All Vertices:")
    for _, v in pairs(self.vertices) do
        print(v)
    end
    print("all edges:")
    local edges = self:getAllEdges()
    for _, v in pairs(edges) do
        printEdge(v)
    end
    print()
end

function Graph:getEdges(id)
    local index = self:getIndex(id)
    local edges = {}
    for i = 1, self.size do
        local val = self.matrix:get(index, i)
        if val >= 1 then
            table.insert(edges, {start = self.vertices[index], destination = self.vertices[i], weight = val})
        end
    end
    return edges
end

function Graph:clear()
    self.matrix:clear()
    self.vertices = {}
    self.size = 0
end

return Graph
