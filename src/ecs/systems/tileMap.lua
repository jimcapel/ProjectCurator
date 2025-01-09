local TileMapSystem = {
    tileMap = {},
    tileSize = 32,
    tileSprites = {},
}

function TileMapSystem:loadMap(
    -- _, tileSprites
)


    local tileMap = {}
    for x = 1, 100 do
        tileMap[x] = {}
        for y = 1, 100 do
            tileMap[x][y] = 1
        end
    end
    
    self.tileMap = tileMap 
    -- self.tileSprites = tileSprites 
end

-- need to change this to screen size and y direction
local function shouldRenderTile(xTile, yTile, xPosition, yPosiiton)
    if ((xTile < xPosition and xTile > xPosition - 100) 
        or (xTile > xPosition and xTile < xPosition + 150))
        and (
            (yTile < yPosiiton and yTile > yPosiiton - 100)
            or (yTile > yPosiiton and yTile < yPosiiton + 200)
        )
    then
        return true
    end
     return false
end

function TileMapSystem:draw(registry, entity)
    local positions = registry.components["position"]
    local position = positions[entity]

    local image = love.graphics.newImage("assets/sprites/grassBlock.png")

    for y = 1, #self.tileMap do
        for x = 1, #self.tileMap do
            local xPos = (x - 1) * self.tileSize
            local yPos = (y - 1) * self.tileSize
            if (shouldRenderTile(xPos, yPos, position.x, position.y)) then
                love.graphics.draw(image, xPos, yPos, 0, 0.128, 0.128)
            end
        end
    end
end

return TileMapSystem

