local _, addon = ...
local B = addon.L

local MB_EV = MythicBuddyEvents
local MB_FX = MythicBuddyFunctions
local MB_FR = MythicBuddyFrames


SLASH_MYBUDDY1 = "/myb"
---@diagnostic disable:undefined-global
SlashCmdList["MYBUDDY"] = function() B.CreateBuddyWindow() end


local function CheckAddonLoaded(arg1)
    if arg1 == "MythicBuddy" then
        local a=0
    end
end
MythicBuddyEvents:Register("ADDON_LOADED", CheckAddonLoaded, "CheckAddonLoaded")


------------------------------------------------------------------------------------
--- Dungeon Checks
------------------------------------------------------------------------------------
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

    if MB_FX:GetInst("In_Inst") == true and MB_FX:GetDungeonInfo("maxPlayers") == 5 and MB_FX:GetDungeonInfo("difficultyIndex") == 23 then
        CreateBuddy()
        return
    else
        return
    end
end

MythicBuddyEvents:Register("UPDATE_INSTANCE_INFO", LoadBuffer, 'ZoneChanged')

local previousWindow


function CreateBuddy()
    -- Removes the old window if a new one is created
    if previousWindow then
        previousWindow:Hide()
        previousWindow = nil
    end

    -- Create the initial frame
    local window = MB_FR:CreateNewFrame("BuddyBackground", "InsetFrameTemplate3", "BOTTOMLEFT", ChatFrame1, "TOPLEFT", UIParent, 5, 40, 400, 200)

    -----------------------------------------------------------------------------------------------------------
    -- Title Frame || Dunngeon ( dungeon difficulty )
    -----------------------------------------------------------------------------------------------------------
    window.Title = MB_FR:AddFontString("dungeonTitle", window, "TOPLEFT", window, "TOPLEFT", 5, -5, "")
    if MB_FX:GetDungeonInfo("INSTANCE_DIFF_NAME") == "Mythic" then
        window.Title:SetText(MB_FX:GetDungeonInfo("INSTANCE_NAME") ..
            " (" .. MB_FX:WhiteText(MB_FX:GetDungeonInfo("INSTANCE_DIFF_NAME")) .. ")")
    else
        window.Title:SetText(MB_FX:GetDungeonInfo("INSTANCE_NAME") ..
            " (" .. MB_FX:RedText(MB_FX:GetDungeonInfo("INSTANCE_DIFF_NAME")) .. ")")
    end
    window.Title:SetFontObject("GameFontNormalLarge")
    window.Title:SetScale(1.5)

    -----------------------------------------------------------------------------------------------------------
    -- Current Keystone : Keystone
    -----------------------------------------------------------------------------------------------------------
    window.MyKeystoneInfo = MB_FR:AddFontString("MyKeyLvl", window, "TOPLEFT", window.Title, "BOTTOMLEFT", 0, -5, nil)
    window.MyKeystoneInfo:SetText("Current Keystone: " .. MB_FX:WhiteText(MB_FX.MyKeystone(self)) .. MB_FX:WhiteText(MB_FX:MyKeyLvl()))

    -----------------------------------------------------------------------------------------------------------
    -- Affix 1 Group
    -----------------------------------------------------------------------------------------------------------
    window.affix_container_1 = MB_FR:CreateNewFrame("affix_container_1", window, "TOPLEFT", window.MyKeystoneInfo,
        "BOTTOMLEFT", window, 0, -10, 400, 20)
    window.affix_icon_1 = MB_FR:AddIcon(window.affix_container_1, "LEFT", MB_FX:MyAffIcon("AFFIX1"), 20, 20)
    window.affix_string_1 = MB_FR:AddFontString("AFFIX1", window, "LEFT", window.affix_icon_2, "RIGHT", 5, 0,
        MB_FX:WhiteText(MB_FX:MyAffixes("AFFIX1")))

    -----------------------------------------------------------------------------------------------------------
    -- Affix 2 Group
    -----------------------------------------------------------------------------------------------------------
    window.affix_container_2 = MB_FR:CreateNewFrame("affix_container_2", window, "TOPLEFT", window.affix_container_1, "BOTTOMLEFT", window, 0, -10, 400, 20)
    window.affix_icon_2 = MB_FR:AddIcon(window.affix_container_2, "LEFT", MB_FX:MyAffIcon("AFFIX2"), 20, 20)
    window.a2str = MB_FR:AddFontString("AFFIX2", window, "LEFT", window.affix_icon_2, "RIGHT", 5, 0,
        MB_FX:WhiteText(MB_FX:MyAffixes("AFFIX2")))

    -----------------------------------------------------------------------------------------------------------
    -- Affix 3 Group
    -----------------------------------------------------------------------------------------------------------
    window.a3cont = MB_FR:CreateNewFrame("affix_container_3", window, "TOPLEFT", window.affix_container_2, "BOTTOMLEFT", window, 0, -10,
        400, 20)
    window.a3icon = MB_FR:AddIcon(window.a3cont, "LEFT", MB_FX:MyAffIcon("AFFIX3"), 20, 20)
    window.a3str = MB_FR:AddFontString("AFFIX3", window, "LEFT", window.a3icon, "RIGHT", 5, 0,
        MB_FX:WhiteText(MB_FX:MyAffixes("AFFIX3")))

    window:Show()

    previousWindow = window
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


