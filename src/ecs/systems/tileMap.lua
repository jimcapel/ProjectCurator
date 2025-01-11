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
            if y < 51 then
                tileMap[x][y] = 2
            else
                tileMap[x][y] = 1
            end
        end
    end
    
    self.tileMap = tileMap 
    self.tileSprites = {
        [1] = {
            sprite = love.graphics.newImage("assets/sprites/dirt.png"),
            isSolid = true,
            type = "dirt"
        },
        [2] = {
            sprite = love.graphics.newImage("assets/sprites/sky.png"),
            isSolid = false,
            type = "air"
        },
    }
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
    local screenWidth, screenHeight = love.graphics.getDimensions()
    local cameraXPosition, cameraYPosition = cameraSystem.camera:getPosition()

    for y = 1, #self.tileMap do
        for x = 1, #self.tileMap do
            local xPos = (x - 1) * self.tileSize
            local yPos = (y - 1) * self.tileSize
            if (isTileOnScreen(xPos, yPos, cameraXPosition, cameraYPosition, screenWidth, screenHeight, self.tileSize)) then
                local spriteIndex = self.tileMap[x][y]
                love.graphics.draw(self.tileSprites[spriteIndex].sprite, xPos, yPos, 0, 0.49, 0.49)
            end
        end
    end
end

return TileMapSystem