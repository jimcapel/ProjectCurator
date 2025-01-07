local Position = require("src.ecs.components.position")
local Velocity = require("src.ecs.components.velocity")
local Sprite = require("src.ecs.components.sprite")
local Collider = require("src.ecs.components.collider")
local BoundingBox = require("src.ecs.components.boundingBox")
local Mass = require("src.ecs.components.mass")
local Controller = require("src.ecs.components.controller")
local OnGround = require("src.ecs.components.onGround")

local function createPlayer(registry, x, y)
    local player = registry:createEntity()

    registry:addComponent(player, "position", Position:new(x, y))
    registry:addComponent(player, "velocity", Velocity:new(0, 0))
    registry:addComponent(player, "sprite", Sprite:new("sheep.png"))
    registry:addComponent(player, "collider", Collider:new())
    registry:addComponent(player, "mass", Mass:new(150))
    registry:addComponent(player, "controller", Controller:new())
    registry:addComponent(player, "onGround", OnGround:new(true))

    -- debugging
    registry:addComponent(player, "boundingBox", BoundingBox:new())
    

    return player
end

return createPlayer