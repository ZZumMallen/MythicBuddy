local addonName, addon = ...
---@class FX
---@field mythicDungeonByID table
---@field AFFIX_id_name_desc function
local FX = addon.L

---@class MythicBuddyFunctions
---@field MyAffixes function
---@field AddFontString function
MythicBuddyFunctions = {}

------------------------------------------------------------------------
--Frames
------------------------------------------------------------------------
---@diagnostic disable:undefined-global
function MythicBuddyFunctions:GetDungeonInfo(infoType)
    local name, typeID, difficultyIndex, difficultyName, maxPlayers,
    dynamicDifficulty, isDynamic, instanceMapId, lfgID = GetInstanceInfo()
    local infoTable = {
        ["INSTANCE_NAME"] = name,
        ["typeID"] = typeID,
        ["INSTANCE_DIFF_NAME"] = difficultyIndex,
        ["difficultyName"] = difficultyName,
        ["maxPlayers"] = maxPlayers,
        ["dynamicDifficulty"] = dynamicDifficulty,
        ["isDynamic"] = isDynamic,
        ["instanceMapId"] = instanceMapId,
        ["lfgID"] = lfgID
    }
    return infoTable[infoType]
end

function MythicBuddyFunctions:GetInst(type)
    local inInstance, instanceType = IsInInstance()
    local t = {
        ["In_Inst"] = inInstance,
        ["Inst_Type"] = instanceType,
    }
    return t[type]
end


function MythicBuddyFunctions:MyKeyLvl()
    local keyStoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
    if keyStoneLevel == nil then
        return ""
    else
        local i = "(" .. keyStoneLevel .. ")"
        return i
    end
end


function MythicBuddyFunctions:MyKeystone()
    local mapID = C_MythicPlus.GetOwnedKeystoneMapID()
    if mapID == nil then
        return "|cfffc2003Not Found|r"
    else
        local k = FX.mythicDungeonByID[mapID]
        return k
    end
end

-- 10, 124, 11 | fort, storming, bursting

---@param affixNum string #"'affix1', 'affix2', 'affix3'""
function MythicBuddyFunctions:MyAffixes(affixNum)
    local affix = C_MythicPlus.GetCurrentAffixes()
    local name = FX.AFFIX_id_name_desc
    local affixTable = {
        ["AFFIX1"] = name[affix[1].id][1],
        ["AFFIX2"] = name[affix[2].id][1],
        ["AFFIX3"] = name[affix[3].id][1]
    }

    
        return affixTable[affixNum]
    end


function MythicBuddyFunctions:MyAffTooltip(affixNum)
    local affix = C_MythicPlus.GetCurrentAffixes()
    local name = FX.AFFIX_id_name_desc
    local affixTable = {
        ["AFFIX1"] = name[affix[1].id][2],
        ["AFFIX2"] = name[affix[2].id][2],
        ["AFFIX3"] = name[affix[3].id][2]
    }
    
        return affixTable[affixNum]
    end


function MythicBuddyFunctions:MyAffIcon(affixNum)
    local affix = C_MythicPlus.GetCurrentAffixes()
    local name = FX.AFFIX_id_name_desc
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

function MythicBuddyFunctions:RedText(text)
    local w = "|cffff0000" .. text .. "|r"
    return w
end
