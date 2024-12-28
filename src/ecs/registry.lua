local Registry = {}

-- create a new registry, setting the registry table on line 1 as the "base class"
function Registry:new()
    local obj = {
        entities = {},
        components = {}
    }

    setmetatable(obj, Registry)
    self.__index = self

    return obj
end

-- get the next available entity id and return to caller
function Registry:createEntity()
    -- # gets cardinality of table
    local entity = #self.entities + 1
    self.entities[entity] = true

    return entity
end

function Registry:addComponent(entity, componentType, data)
    if not self.components[componentType] then
        self.components[componentType] = {}
    end

    self.components[componentType][entity] = data
end

function Registry:removeComponent(entity, componentType)
    if self.components[componentType] then
        self.components[componentType].remove(entity)
    end
end

function Registry:getComponent(entity, componentType)
    return self.components[componentType] and self.components[componentType][entity]
end

function Registry:getEntitiesWithComponent(componentType)
    local result = {}

    for key, _ in ipairs(self.components[componentType] or {}) do
        table.insert(result, key)
    end

    return result
end

return Registry