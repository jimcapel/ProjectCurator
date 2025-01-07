local TileMapSystem = {
    tileMap = {},
    tileSize = 16,
    tileSprites = {},
}

function TileMapSystem:loadMap(tileMap, tileSprites)
    self.tileMap = tileMap 
    self.tileSprites = tileSprites 
end

function TileMapSystem:draw()
    local image = love.graphics.newImage("assets/sprites/dirt.png")

    for y = 1, #self.tileMap do
        for x = 1, #self.tileMap do
            love.graphics.draw(image, (x-1) * self.tileSize, (y-1) * self.tileSize)
        end
    end
end

return TileMapSystem

