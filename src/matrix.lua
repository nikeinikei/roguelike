local Matrix = {}
Matrix.__index = Matrix

function Matrix:new()
    local o = {}
    setmetatable(o, self)
    o.matrix = {}
    o.vertices = {}
    return o
end

function Matrix:addVertice(identifier)

end



return Matrix
