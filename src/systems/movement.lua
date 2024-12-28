local MovementSystem = {}

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
            local newYPosition = math.min(position.y, love.graphics.getHeight() - sprite.image:getHeight())
            position.y = newYPosition + velocity.dy * dt
        end
    end
end

return MovementSystem