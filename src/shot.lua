local Shot = {}
local Shot_mt = {__index = Shot}

local function toRadians(a)
    return a * math.pi / 180
end

local r = 10

--hitbox of shot will be approximated with a rectangle which has a side length which is 0.7 * the diameter of the circle
local sidelength = r * 2 * 0.7

function Shot:new(world, x, y, a, v)
    local self = {}
    setmetatable(self, Shot_mt)
    world:add(self, x - (sidelength / 2), y - (sidelength / 2), sidelength, sidelength)
    self.world = world
    self.x = x
    self.y = y
    self.dx = math.cos(toRadians(a)) * v
    self.dy = math.sin(toRadians(a)) * v
    self.name = "shot"
    return self
end

local function filter(_, other)
    if other.name == "player" then
        return "cross"
    end
    if other.name == "shot" then
        return "cross"
    end
    return "touch"
end

--method returns wether shot should be destroyed
function Shot:update(dt)
    local len, cols
    self.x, self.y, cols, len = self.world:move(self, self.dx * dt, self.dy * dt, filter)
    local shouldBeDestroyed = false
    for _, v in pairs(cols) do
        if v.type ~= "cross" then
            shouldBeDestroyed = true
            print("destroy me bby. other = ")
            for m, n in pairs(v.other) do
                print(m, n)
            end
            break
        end
    end
    return shouldBeDestroyed
end

function Shot:draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle("fill", self.x, self.y, 10)
end

function Shot:destroy()
    self.world:remove(self)
end

return Shot