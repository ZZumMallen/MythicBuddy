---@diagnostic disable:undefined-global
MythicBuddyEvents = CreateFrame("Frame","MythicBuddy")
MythicBuddyEvents.db = {}

-- @param fx function #called when fired
-- @param name string OPTIONAL name for function for ID purposes

function MythicBuddyEvents:NewObject(fx, name)
    local obj = {}
    obj.name = name or 'anonymous'
    obj.method = fx

    return obj
end

function MythicBuddyEvents:Register(event, fx, name)
    if self:IsRegistered(event, name) then return end
    local obj = self:NewObject(fx, name)

    if not self.db[event] then
        self.db[event] = {}
        MythicBuddyEvents:RegisterEvent(event)
    end
    self.db[event][name] = obj
end

function MythicBuddyEvents:UnRegister(event, name)
    local objs = self.db[event]
    if not objs then
        return
    end

    objs[name] = nil

    if next(objs) == nil then
        self:UnregisterEvent(event)
    end
end

function MythicBuddyEvents:IsRegistered(event, name)
    local objs = self.db[event]
    if not objs then return false end

    if objs[name] then
        return true
    else
        return false
    end
end

function MythicBuddyEvents:GetRegisteredFunction(event, handler)
    local objs = self.db[event]
    if not objs then return end

    if objs[handler] then
        return objs[handler].method
    else
        return nil
    end
end

function MythicBuddyEvents:OnEvent(event, ...)
    local objs = self.db[event]
    if not objs then
        return
    end
    for _, obj in pairs(objs) do
        obj.method(...)
    end
end

MythicBuddyEvents:SetScript("OnEvent", MythicBuddyEvents.OnEvent)


