local PhysicsSystem = {}

function PhysicsSystem:update(registry, dt)
    local positions = registry.components["position"]
    local velocities = registry.components["velocity"]
    local masses = registry.components["mass"]
    local sprites = registry.components["sprite"]

    -- Iterate through all entities with physics components
    for entity, position in pairs(positions) do
        local velocity = velocities[entity]
        local mass = masses[entity]
        local sprite = sprites[entity]
        -- print(position.y .. " " .. love.graphics.getHeight())

        if velocity and mass and sprite then
            if (position.y + sprite.image:getHeight()) <= love.graphics.getHeight() then
                -- Apply gravity (adjust as needed)
                local gravity = 9.8 * mass.value
                velocity.dy = velocity.dy + gravity * dt

                -- Update position based on velocity
                -- position.x = position.x + velocity.vx * dt
                -- position.y = position.y + velocity.vy * dt
            else
                velocity.dy = 0
            end
        end
    end

end

return PhysicsSystem