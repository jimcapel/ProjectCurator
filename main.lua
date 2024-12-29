-- entities
local createPlayer = require("src.entities.player")
local createPanda = require("src.entities.panda")

-- systems
local registry = require("src.ecs.registry")
local movementSystem = require("src.systems.movement")
local renderSystem = require("src.systems.render")
local collisionSystem = require("src.systems.collision")
local physicsSystem = require("src.systems.physics")
local inputSystem = require("src.systems.input")
local tileMapSystem = require("src.systems.tileMap")

-- config
local playerConfig = require("src.config.player")

function love.load()
    registry = registry:new()

    -- init systems
    movementSystem:initialise()

    -- load tilemap
    tileMapSystem:loadMap({{1 , 1}}, {})

    -- create entities
    createPlayer(registry, playerConfig.startingPosition.x, playerConfig.startingPosition.y)
    createPanda(registry, 300, 300)
end

function love.draw()
    renderSystem:draw(registry)
    tileMapSystem:draw()
end

function love.update(dt)
    inputSystem:update(registry)
    physicsSystem:update(registry, dt)
    movementSystem:update(registry, dt)
    collisionSystem:update(registry)
    
end