local Sprite = {}

function Sprite:new(imageName)
    return {
        image = love.graphics.newImage("assets/sprites/" .. imageName)
    }
end

return Sprite