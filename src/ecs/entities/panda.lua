local Position = require("src.ecs.components.position")
local Sprite = require("src.ecs.components.sprite")
local Collider = require("src.ecs.components.collider")
local BoundingBox = require("src.ecs.components.boundingBox")

local function createPanda(registry, x, y)
    local panda = registry:createEntity()

    registry:addComponent(panda, "position", Position:new(x, y))
    registry:addComponent(panda, "sprite", Sprite:new("panda.png"))
    registry:addComponent(panda, "collider", Collider:new())

    -- debugging
    registry:addComponent(panda, "boundingBox", BoundingBox:new())
    
    return panda
end

return createPanda