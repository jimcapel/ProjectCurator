local InputSystem = {}

function InputSystem:update(registry)
    local velocities = registry.components["velocity"]
    local controllers = registry.components["controller"]

    for entity, _ in pairs(controllers or {}) do
        local velocity = velocities[entity]
        if velocity then
            if love.keyboard.isDown("right") then
                velocity.dx = 200
            elseif love.keyboard.isDown("left") then
                velocity.dx = -200
            else
                velocity.dx = 0
            end

            if love.keyboard.isDown("up") then
                velocity.dy = -200
            elseif love.keyboard.isDown("down") then
                velocity.dy = 200
            else
                -- velocity.dy = 0
            end
        end
    end
end

return InputSystem