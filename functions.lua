local _, addon = ...

---@class MythicBuddyFunctions
MythicBuddyFunctions = {}


---comment
---@param infoType string
---@return any
function MythicBuddyFunctions:GetDungeonInfo(infoType)
    local name, typeID, difficultyIndex, difficultyName, maxPlayers,
    dynamicDifficulty, isDynamic, instanceMapId, lfgID = GetInstanceInfo()
    ---@type table<string,any>
    local infoTable = {
        ["INSTANCE_NAME"] = name,
        ["typeID"] = typeID,
        ["INSTANCE_DIFF_ID"] = difficultyIndex,
        ["INSTANCE_DIFF_NAME"] = difficultyName,
        ["maxPlayers"] = maxPlayers,
        ["dynamicDifficulty"] = dynamicDifficulty,
        ["isDynamic"] = isDynamic,
        ["instanceMapId"] = instanceMapId,
        ["lfgID"] = lfgID
    }
    return infoTable[infoType]
end

---comment in_inst is boolean, inst_type string
---@param type string
---@return boolean|string
function MythicBuddyFunctions:InInstance(type)
    local inInstance, instanceType = IsInInstance()
    local t = {
        ["In_Inst"] = inInstance,
        ["Inst_Type"] = instanceType,
    }
    return t[type]
end

---comment returns my key level
---@return string
function MythicBuddyFunctions:MyKeyLevel()
    local keyStoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
    if keyStoneLevel == nil then
        return "No Key"
    else
        local i = "(" .. keyStoneLevel .. ")"
        return i
    end
end

---comment name of the keystone as a string
function MythicBuddyFunctions.MyKeystone()
    local mapID = C_MythicPlus.GetOwnedKeystoneMapID()
    if mapID == nil then
        return "|cfffc2003Not Found|r"
    else
        ---@alias k string
        local k = addon.mythicDungeonByID[mapID]
        return k
    end
end

---comment returns the affix as a name || string
---@param affixNum string #"'affix1', 'affix2', 'affix3'""
function MythicBuddyFunctions:CurrentAffixes(affixNum)
    local affix = C_MythicPlus.GetCurrentAffixes()
    local name = addon.AffixInfo
    local affixTable = {
        ["AFFIX1"] = name[affix[1].id][1],
        ["AFFIX2"] = name[affix[2].id][1],
        ["AFFIX3"] = name[affix[3].id][1]
    }
        return affixTable[affixNum]
    end


function MythicBuddyFunctions:MyAffTooltip(affixNum)
    local affix = C_MythicPlus.GetCurrentAffixes()
    local name = addon.AffixInfo
    local affixTable = {
        ["AFFIX1"] = name[affix[1].id][2],
        ["AFFIX2"] = name[affix[2].id][2],
        ["AFFIX3"] = name[affix[3].id][2],
        ["AFFIX9"] = addon.AffixInfo[120][2] -- longest string for testing
    }
        return affixTable[affixNum]
    end


function MythicBuddyFunctions:MyAffIcon(affixNum)
    local affix = C_MythicPlus.GetCurrentAffixes()
    local name = addon.AffixInfo
    local affixTable = {
        ["AFFIX1"] = name[affix[1].id][3],
        ["AFFIX2"] = name[affix[2].id][3],
        ["AFFIX3"] = name[affix[3].id][3]
    }
        return affixTable[affixNum]
    end




function MythicBuddyFunctions:WhiteText(text)
    local w = "|cffffffff" .. text .. "|r"
    return w
end


---@return string
function MythicBuddyFunctions:RedText(text)
    local w = "|cffff0000" .. text .. "|r"
    return w
end

---comment tests if the players current key is for the dungeon they are in
---@return boolean
function MythicBuddyFunctions:CanUseMyKey()
    local currentMapID = strsplit(",", select(8, GetInstanceInfo()))
    local currentSelfKeystoneNameID = C_MythicPlus.GetOwnedKeystoneMapID()

    if tonumber(currentSelfKeystoneNameID) == tonumber(currentMapID) then
        return true
    else
        print(currentSelfKeystoneNameID)
        print(currentMapID)
        return false
    end
end

