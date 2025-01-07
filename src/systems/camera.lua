-- libs
local gamera = require("libs.gamera")

-- constants
local CONSTANTS = require("src.config.constants")

CameraSystem = {}

function CameraSystem:initialise(registry, entity)
    self.camera = gamera.new(CONSTANTS.WOLRD.X, CONSTANTS.WOLRD.Y, CONSTANTS.WOLRD.X + CONSTANTS.WOLRD.WIDTH, CONSTANTS.WOLRD.Y + CONSTANTS.WOLRD.HEIGHT)
    self.entityToFollow = entity

    local positions = registry.components["position"]
    local position = positions[entity]

    local sprites = registry.components["sprite"]
    local sprite = sprites[entity]

    if position and sprite then 
        self.camera:setPosition(position.x + (0.5 * sprite.image:getWidth()), position.y + (0.5 * sprite.image:getHeight()))
    end 
end

function CameraSystem:update(registry)
    local positions = registry.components["position"]
    local position = positions[self.entityToFollow]

    local sprites = registry.components["sprite"]
    local sprite = sprites[self.entityToFollow]

    if sprite and position then
        local xPosition = position.x + (0.5 * sprite.image:getWidth())
        local yPosition =  position.y + (0.5 * sprite.image:getHeight())
        
        self.camera:setPosition(xPosition, yPosition)
    end
end

function CameraSystem:draw(drawWorld)
    self.camera:draw(drawWorld)
end

return CameraSystem