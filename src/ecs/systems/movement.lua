-- local CONSTANTS = require("src.config.constants")

local MovementSystem = {}

function MovementSystem:initialise()
    EventManager:subscribe("playerJump", function (data) print(data) end)
end

function MovementSystem:update(registry, dt)
    local positions = registry.components["position"]
    local velocities = registry.components["velocity"]
    local sprites = registry.components["sprite"]

    for entity, position in pairs(positions or {}) do
        local velocity = velocities[entity]
        local sprite = sprites[entity]
        if velocity then
            position.x = position.x + velocity.dx * dt

            -- clamp y position to bottom of screen, need to increase physics checks really
            -- position.y = math.min(position.y + velocity.dy * dt, CONSTANTS.WOLRD.HEIGHT - sprite.image:getHeight())
            position.y = position.y + velocity.dy * dt
        end
    end
end

return MovementSystem