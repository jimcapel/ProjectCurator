local Position = require("src.components.position")
local Velocity = require("src.components.velocity")
local Sprite = require("src.components.sprite")
local Collider = require("src.components.collider")
local BoundingBox = require("src.components.boundingBox")
local Mass = require("src.components.mass")
local Controller = require("src.components.controller")

local function createPlayer(registry, x, y)
    local player = registry:createEntity()

    registry:addComponent(player, "position", Position:new(x, y))
    registry:addComponent(player, "velocity", Velocity:new(0, 0))
    registry:addComponent(player, "sprite", Sprite:new("sheep.png"))
    registry:addComponent(player, "collider", Collider:new())
    registry:addComponent(player, "mass", Mass:new(150))
    registry:addComponent(player, "controller", Controller:new())

    -- debugging
    registry:addComponent(player, "boundingBox", BoundingBox:new())

    return player
end

return createPlayer