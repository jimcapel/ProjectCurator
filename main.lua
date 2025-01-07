-- entities
local createPlayer = require("src.ecs.entities.player")
local createPanda = require("src.ecs.entities.panda")

-- systems
local registry = require("src.ecs.registry")
local movementSystem = require("src.ecs.systems.movement")
local renderSystem = require("src.ecs.systems.render")
local collisionSystem = require("src.ecs.systems.collision")
local physicsSystem = require("src.ecs.systems.physics")
local inputSystem = require("src.ecs.systems.input")
local tileMapSystem = require("src.ecs.systems.tileMap")
local cameraSystem = require("src.ecs.systems.camera")

-- config
local playerConfig = require("src.config.player")

function love.load()
    registry = registry:new()

    -- load tilemap
    tileMapSystem:loadMap({{1 , 1}}, {})

    -- create entities
    local playerEntity = createPlayer(registry, playerConfig.startingPosition.x, playerConfig.startingPosition.y)
    createPanda(registry, 1500, 1300)

    -- init systems
    movementSystem:initialise()
    cameraSystem:initialise(registry, playerEntity)

end

function love.draw()
    cameraSystem:draw(function ()
        renderSystem:draw(registry)
        tileMapSystem:draw()
    end)
end

function love.update(dt)
    inputSystem:update(registry)
    physicsSystem:update(registry, dt)
    movementSystem:update(registry, dt)
    collisionSystem:update(registry)
    cameraSystem:update(registry)

end