local RenderSystem = {}

function RenderSystem:draw(registry)
    local positions = registry.components["position"]
    local sprites = registry.components["sprite"]
    local boundingBox = registry.components["boundingBox"]

    for entity, position in pairs(positions or {}) do
        local sprite = sprites[entity]
        if sprite then
            love.graphics.draw(sprite.image, position.x, position.y)

            -- debugging
            if boundingBox and boundingBox[entity] then
                love.graphics.rectangle("line", position.x, position.y, sprite.image:getWidth(), sprite.image:getHeight())
            end
        end

    end
end

return RenderSystem