local Util = {}

Util.safeDestroy = function(object)
    if object.body:isDestroyed() == false then
        object.body:destroy()
    end
    if object.fixture:isDestroyed() == false then
        object.fixture:destroy()
    end
end

Util.deepcopy = function(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[Util.deepcopy(orig_key)] = Util.deepcopy(orig_value)
        end
        setmetatable(copy, Util.deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

Util.scrambleTable = function(t)
    local copy = Util.deepcopy(t)
    local scrambled = {}
    while #copy ~= 0 do
        local size = #copy
        local randomNumber = love.math.random(size)
        table.insert(scrambled, table.remove(copy, randomNumber))
    end
    return scrambled
end

Util.printTable = function(t)
    for _, v in pairs(t) do
        if type(v) == "table" then
            Util.printTable(v)
        else
            print(v)
        end
    end
end

return Util
