-- entities
local createPlayer = require("src.entities.player")
local createPanda = require("src.entities.panda")

-- systems
local Registry = require("src.ecs.registry")
local MovementSystem = require("src.systems.movement")
local RenderSystem = require("src.systems.render")
local CollisionSystem = require("src.systems.collision")
local PhysicsSystem = require("src.systems.physics")
local InputSystem = require("src.systems.input")
local TileMapSystem = require("src.systems.tileMap")

-- config
local playerConfig = require("src.config.player")

local registry, movementSystem, renderSystem, collisionSystem, physicsSystem, inputSystem, tileMapSystem

function love.load()
    registry = Registry:new()

    movementSystem = MovementSystem
    renderSystem = RenderSystem
    collisionSystem = CollisionSystem
    physicsSystem = PhysicsSystem
    inputSystem = InputSystem
    tileMapSystem = TileMapSystem

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