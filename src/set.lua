local Set = Object:extend()

function Set:new()
    self.items = {}
end

--o: object
--t: table
local function indexOf(o, t)
    local index = -1
    for k, v in pairs(t) do
        if v == o then
            index = k
        end
    end
    return index
end

function Set:add(o)
    local index = indexOf(o, self.items)
    if index == -1 then
        table.insert(self.items, o)
    end
end

function Set:remove(o)
    local index = indexOf(o, self.items)
    if index ~= -1 then
        table.remove(self.items, index)
    end
end

function Set:clear()
    self.items = {}
end

return Set
