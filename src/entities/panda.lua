local Position = require("src.components.position")
local Sprite = require("src.components.sprite")
local Collider = require("src.components.collider")
local BoundingBox = require("src.components.boundingBox")

local function createPanda(registry, x, y)
    local panda = registry:createEntity()

    registry:addComponent(panda, "position", Position:new(x, y))
    registry:addComponent(panda, "sprite", Sprite:new("panda.png"))
    registry:addComponent(panda, "collider", Collider:new())

    -- debugging
    registry:addComponent(panda, "boundingBox", BoundingBox:new())
end

return createPanda