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
        -- Resolve horizontal collision
        if positionA.x < positionB.x then
            positionA.x = positionB.x - spriteA.image:getWidth() -- Push left
        else
            positionA.x = positionB.x + spriteB.image:getWidth() -- Push right
        end
        if velocityA then velocityA.dx = 0 end -- Stop horizontal movement
    else
        -- Resolve vertical collision
        if positionA.y < positionB.y then
            positionA.y = positionB.y - spriteA.image:getHeight() -- Push up
        else
            positionA.y = positionB.y + spriteB.image:getHeight() -- Push down
        end
        if velocityA then velocityA.dy = 0 end -- Stop vertical movement
    end
end

function CollisionSystem:update(registry)
    local colliders = registry.components["collider"]
    local positions = registry.components["position"]
    local sprites = registry.components["sprite"]
    local velocities = registry.components["velocity"]

    for entityA, colliderA in pairs(colliders or {}) do        
        local spriteA = sprites[entityA]
        local positionA = positions[entityA]
        local velocityA = velocities[entityA]

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
    end 

end

return CollisionSystem