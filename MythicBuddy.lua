local _, addon = ...
local B = addon.L

local MB_EV = MythicBuddyEvents
local MB_FX = MythicBuddyFunctions
local MB_FR = MythicBuddyFrames



local function CheckAddonLoaded(arg1)
    if arg1 == "MythicBuddy" then
        local a=0
    end
end
MythicBuddyEvents:Register("ADDON_LOADED", CheckAddonLoaded, "CheckAddonLoaded")


--#region Dungeon Checks
local Trigger = {}
Trigger.old = 0
Trigger.new = 0

function LoadBuffer()
    Trigger.new = Trigger.new + 1
    if Trigger.new == 3 then
        ZoneChanged()
        return
    end
end

function ZoneChanged()
    Trigger.old = 0
    Trigger.new = 0

    if MB_FX:InInstance("In_Inst") == true and MB_FX:GetDungeonInfo("maxPlayers") == 5 and MB_FX:GetDungeonInfo("INSTANCE_DIFF_ID") == 23 then
        CreateBuddy()
        return
    else
        return
    end
end
--#endregion

MythicBuddyEvents:Register("UPDATE_INSTANCE_INFO", LoadBuffer, 'ZoneChanged')

local previousWindow


function CreateBuddy()
    -- Removes the old window if a new one is created
    if previousWindow then
        previousWindow:Hide()
        previousWindow = nil
    end


    ---@class w: frame
    local w = MB_FR:CreateNewFrame("BuddyBackground", "InsetFrameTemplate3", "BOTTOMLEFT", ChatFrame1, "TOPLEFT", UIParent, 5, 40, 400, 200)

    -----------------------------------------------------------------------------------------------------------
    -- Title Frame || Dunngeon ( dungeon difficulty )
    -----------------------------------------------------------------------------------------------------------
    
    w.Title = MB_FR:AddFontString("dungeonTitle", w, "TOPLEFT", w, "TOPLEFT", 5, -5, "")
    if MB_FX:GetDungeonInfo("INSTANCE_DIFF_NAME") == "Mythic" then
        w.Title:SetText(MB_FX:GetDungeonInfo("INSTANCE_NAME") ..
            " (" .. MB_FX:WhiteText(MB_FX:GetDungeonInfo("INSTANCE_DIFF_NAME")) .. ")")
    else
        w.Title:SetText(MB_FX:GetDungeonInfo("INSTANCE_NAME") ..
            " (" .. MB_FX:RedText(MB_FX:GetDungeonInfo("INSTANCE_DIFF_NAME")) .. ")")
    end
    w.Title:SetFontObject("GameFontNormalLarge")
    w.Title:SetScale(1.5)


    w.MyKeystoneInfo = MB_FR:AddFontString("MyKeyLvl", w, "TOPLEFT", w.Title, "BOTTOMLEFT", 0, -5, nil)
    w.MyKeystoneInfo:SetText("Current Keystone: " .. MB_FX:WhiteText(MB_FX.MyKeystone()) .. MB_FX:WhiteText(MB_FX:MyKeyLevel()))

    --#region Affix Functions
    --affix1----------------------------------------------------------------------------------------------------------------------------
    w.affix_container_1 = MB_FR:CreateNewFrame("affix_container_1", "", "TOPLEFT", w.MyKeystoneInfo,
        "BOTTOMLEFT", w, 0, -10, 400, 20)
    w.affix_icon_1 = MB_FR:AddIcon(w.affix_container_1, "LEFT", MB_FX:MyAffIcon("AFFIX1"), 20, 20)
    w.affix_string_1 = MB_FR:AddFontString("AFFIX1", w, "LEFT", w.affix_icon_1, "RIGHT", 5, 0,
        MB_FX:WhiteText(MB_FX:CurrentAffixes("AFFIX1")))
   

    --affix 2----------------------------------------------------------------------------------------------------------------------------
    w.affix_container_2 = MB_FR:CreateNewFrame("affix_container_2", "", "TOPLEFT", w.affix_container_1, "BOTTOMLEFT", w, 0, -10, 400, 20)
    w.affix_icon_2 = MB_FR:AddIcon(w.affix_container_2, "LEFT", MB_FX:MyAffIcon("AFFIX2"), 20, 20)
    w.affix_string_2 = MB_FR:AddFontString("AFFIX2", w, "LEFT", w.affix_icon_2, "RIGHT", 5, 0,
        MB_FX:WhiteText(MB_FX:CurrentAffixes("AFFIX2")))
 

    --affix 3----------------------------------------------------------------------------------------------------------------------------
    w.affix_container_3 = MB_FR:CreateNewFrame("affix_container_3", "", "TOPLEFT", w.affix_container_2, "BOTTOMLEFT", w, 0, -10,
        400, 20)
    w.affix_icon_3 = MB_FR:AddIcon(w.affix_container_3, "LEFT", MB_FX:MyAffIcon("AFFIX3"), 20, 20)
    w.affix_string_3 = MB_FR:AddFontString("AFFIX3", w, "LEFT", w.affix_icon_3, "RIGHT", 5, 0,
        MB_FX:WhiteText(MB_FX:CurrentAffixes("AFFIX3")))
    --#endregion

    w:Show()

    previousWindow = w
    return previousWindow
end

function HideOnLeavingWorld()
    if previousWindow then
        print("found f, leaving world")
        previousWindow:Hide()
        return
    else
        print("f not found")
        return
    end

end
MythicBuddyEvents:Register("PLAYER_LEAVING_WORLD", HideOnLeavingWorld, 'HideOnLeavingWorld')

function HideOnDungeonStart()
    if previousWindow then
        C_Timers.After(3, function ()
            previousWindow.Hide()
        end)
    end
end
MythicBuddyEvents:Register("CHALLENGE_MODE_START", HideOnDungeonStart, 'HideOnLeavingWorld')


