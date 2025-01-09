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

-- if tile draw origin is within screen relative to camera position, then draw tile
local function isTileOnScreen(xTile, yTile, cameraXPosition, cameraYPosition, screenWidth, screenheight, tileSize)
    if (xTile < (cameraXPosition + screenWidth / 2) and xTile > (cameraXPosition - tileSize - screenWidth / 2))
        and ((yTile < (cameraYPosition + screenheight / 2) and yTile > (cameraYPosition - tileSize - screenheight / 2)))
    then
        return true
    end
     return false
end

function TileMapSystem:draw(cameraSystem)
    local image = love.graphics.newImage("assets/sprites/grassBlock.png")

    local screenWidth, screenHeight = love.graphics.getDimensions()
    local cameraXPosition, cameraYPosition = cameraSystem.camera:getPosition()

    for y = 1, #self.tileMap do
        for x = 1, #self.tileMap do
            local xPos = (x - 1) * self.tileSize
            local yPos = (y - 1) * self.tileSize
            if (isTileOnScreen(xPos, yPos, cameraXPosition, cameraYPosition, screenWidth, screenHeight, self.tileSize)) then
                love.graphics.draw(image, xPos, yPos, 0, 0.128, 0.128)
            end
        end
    end
end

return TileMapSystem

