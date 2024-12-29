local playerConfig = require("src.config.player")
local EventManager = require("src.eventManager")

local InputSystem = {}

function InputSystem:update(registry)
    local velocities = registry.components["velocity"]
    local controllers = registry.components["controller"]
    local onGroundValues = registry.components["onGround"]

    for entity, _ in pairs(controllers or {}) do
        local velocity = velocities[entity]
        if velocity then
            if love.keyboard.isDown("d") then
                velocity.dx = playerConfig.speed
            elseif love.keyboard.isDown("a") then
                velocity.dx = -playerConfig.speed
            else
                velocity.dx = 0
            end
        end
    end

    -- jump
    function love.keypressed(key, scancode, isrepeat)
        if key == "space" then
            for entity, _ in pairs(controllers or {}) do
                local velocity = velocities[entity]
                local onGround = onGroundValues[entity]

                if velocity and onGround.value then
                    EventManager:trigger("playerJump", "Test of event manager")
                    velocity.dy = -playerConfig.jumpVelocity
                end
            end 
        end
    end
end

return InputSystem