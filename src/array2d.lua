local Array2d = {}
Array2d.__index = Array2d

local function assertNumber(n)
    if type(n) ~= "number" then
        local errormessage = "wrong input. " .. n .. " is not a number"
        error(errormessage)
    end
end

function Array2d:new()
    local o = {}
    setmetatable(o, self)
    o.array = {}
    return o
end

function Array2d:set(x, y, val)
    assertNumber(x)
    assertNumber(y)
    if self.array[x] == nil then
        self.array[x] = {}
    end
    self.array[x][y] = val
end

function Array2d:get(x, y)
    assertNumber(x)
    assertNumber(y)
    if self.array[x] == nil then
        return nil
    end
    return self.array[x][y]
end

function Array2d:clear()
    self.array = {}
end

function Array2d:size()
    local count = 0
    for k, v in pairs(self.array) do
        count = count + #v
    end
    return count
end

return Array2d
