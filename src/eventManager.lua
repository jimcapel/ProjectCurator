EventManager = {
    listeners = {}
}

function EventManager:subscribe(eventType, callback)
    self.listeners[eventType] = self.listeners[eventType] or {}
    table.insert(self.listeners[eventType], callback)
end

function EventManager:trigger(eventType, data)
    if self.listeners[eventType] then
        for _, callback in ipairs(self.listeners[eventType]) do
            callback(data)
        end
    end
end

return EventManager