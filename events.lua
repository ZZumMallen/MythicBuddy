MythicBuddyEvents = CreateFrame("Frame","MythicBuddy")
MythicBuddyEvents.db = {}


---comment create named object
---@param func function # CreateFrame
---@param name string
---@return table
function MythicBuddyEvents:NewObject(func, name)
    local obj = {}
    obj.name = name or 'anonymous'
    obj.method = func

    return obj
end

---comment quick event reguster with local name and function
---@param event string # 'EVENT_NAME'
---@param func function #GetDungeonInfo
---@param name any
function MythicBuddyEvents:Register(event, func, name)
    if self:IsRegistered(event, name) then return end
    local obj = self:NewObject(func, name)

    if not self.db[event] then
        self.db[event] = {}
        MythicBuddyEvents:RegisterEvent(event)
    end
    self.db[event][name] = obj
end


---comment unregistering event and  unique name
---@param event string # 'EVENT_NAME'
---@param name string
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


---comment checks if registerd event is still registered
---@param event string # 'EVENT_NAME'
---@param name string
---@return boolean
function MythicBuddyEvents:IsRegistered(event, name)
    local objs = self.db[event]
    if not objs then return false end

    if objs[name] then
        return true
    else
        return false
    end
end

---comment
---@param event string # 'EVENT_NAME'
---@param handler any
---@return any
function MythicBuddyEvents:GetRegisteredFunction(event, handler)
    local objs = self.db[event]

    if not objs then
        return
    end

    

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


