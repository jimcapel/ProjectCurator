local CollisionSystem = {}

local function isColliding(positionA, colliderA, spriteA, positionB, colliderB, spriteB)
    local widthA = spriteA.image:getWidth()
    local heightA = spriteA.image:getHeight()

    local widthB = spriteB.image:getWidth()
    local heightB = spriteB.image:getHeight()

     return positionA.x < positionB.x + widthB and
           positionA.x + widthA > positionB.x and
           positionA.y < positionB.y + heightB and
           positionA.y + heightA > positionB.y  
end

local function resolveCollision(positionA, spriteA, velocityA, positionB, spriteB, velocityB)
    local overlapX = math.min(
        (positionA.x + spriteA.image:getWidth()) - positionB.x,
        (positionB.x + spriteB.image:getWidth()) - positionA.x
    )

    local overlapY = math.min(
        (positionA.y + spriteA.image:getHeight()) - positionB.y,
        (positionB.y + spriteB.image:getHeight()) - positionA.y
    )

    if overlapX < overlapY then
        -- resolve horizontal collision
        if positionA.x < positionB.x then
            -- push left
            positionA.x = positionB.x - spriteA.image:getWidth()
        else
            -- push right
            positionA.x = positionB.x + spriteB.image:getWidth()
        end
        -- stop horizontal movement
        if velocityA then velocityA.dx = 0 end
    else
        -- resolve vertical collision
        if positionA.y < positionB.y then
            -- push up
            positionA.y = positionB.y - spriteA.image:getHeight()
        else
            -- push down
            positionA.y = positionB.y + spriteB.image:getHeight()
        end
        -- stop vertical movement
        if velocityA then velocityA.dy = 0 end
    end
end

function CollisionSystem:update(registry)
    local colliders = registry.components["collider"]
    local positions = registry.components["position"]
    local sprites = registry.components["sprite"]
    local velocities = registry.components["velocity"]
    local onGroundValues = registry.components["onGround"]

    for entityA, colliderA in pairs(colliders or {}) do        
        local spriteA = sprites[entityA]
        local positionA = positions[entityA]
        local velocityA = velocities[entityA]
        local onGround = onGroundValues[entityA]

        for entityB, colliderB in pairs(colliders or {}) do
            if entityA ~= entityB then
                local spriteB = sprites[entityB]
                local positionB = positions[entityB]
                local velocityB = velocities[entityB]

                local collided = isColliding(positionA, colliderA, spriteA, positionB, colliderB, spriteB)

                if collided then
                    resolveCollision(positionA, spriteA, velocityA, positionB, spriteB, velocityB)

                end
            end
        end
    
        -- check if entity is on ground
        if positionA.y + spriteA.image:getHeight() >= love.graphics.getHeight() then
            velocityA.dy = 0
            if onGround then
                onGround.value = true
            end
        elseif onGround then
            onGround.value = false
        end
    end 


end

return CollisionSystem