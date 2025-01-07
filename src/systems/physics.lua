local CONSTANTS = require("src.config.constants")

local PhysicsSystem = {}

function PhysicsSystem:update(registry, dt)
    local positions = registry.components["position"]
    local velocities = registry.components["velocity"]
    local masses = registry.components["mass"]
    local sprites = registry.components["sprite"]
    local onGroundValues = registry.components["onGround"]

    -- iterate through all entities with physics components
    for entity, position in pairs(positions) do
        local velocity = velocities[entity]
        local mass = masses[entity]
        local sprite = sprites[entity]
        local onGround = onGroundValues[entity]

        if velocity and mass and sprite and onGround then
            -- apply gravity if entity not on ground
            if not onGround.value then
                local gravity = CONSTANTS.GRAVITY * mass.value
                velocity.dy = velocity.dy + gravity * dt
            end
        end
    end

end

return PhysicsSystem