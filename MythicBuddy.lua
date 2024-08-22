local ADDON_NAME, addon = ...
local B = addon.L

local MB_EV = MythicBuddyEvents
local MB_FX = MythicBuddyFunctions
local MB_FR = MythicBuddyFrames

ZONE_CHANGE_COUNTER = 0 or {}

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

SLASH_MYTHICBUDDY1 = "/bff"
SlashCmdList.MYTHICBUDDY = function() Troubleshooting() end;

local function CheckAddonLoaded(arg1)
    if arg1 == "MythicBuddy" then
        print("MythicBuddy Loaded")
    end
end

MythicBuddyEvents:Register("ADDON_LOADED", CheckAddonLoaded, "CheckAddonLoaded")

function ZoneChanged()
    if MB_FX:InInstance("In_Inst") == true and MB_FX:InInstance("Inst_Type") == 'party' then
        ZONE_CHANGE_COUNTER = ZONE_CHANGE_COUNTER + 1
        if ZONE_CHANGE_COUNTER == 1 then
            CreateBuddy()
        else return end
    end
end

MB_EV:Register("UPDATE_INSTANCE_INFO", ZoneChanged, 'ZoneChanged')

local previousWindow
local previousTooltip
local w

function CreateBuddy()

    if previousWindow then
        previousWindow:Hide()
        w.Glow:Hide()
        previousWindow = nil
    end

    ---@class w: frame
    w = MB_FR:CreateNewFrame("BuddyBackground", "InsetFrameTemplate3", "BOTTOMLEFT", ChatFrame1, "TOPLEFT", UIParent, 5,
        40, 400, 200)

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

    if MB_FX:CanUseMyKey() then
        w.Glow = MB_FR:CreateNewFrame("BuddyBackgroundGlow", "GlowBorderTemplate", "TOPLEFT", w, "TOPLEFT", w, 0,
        0, 400, 200)
    else
        return

    end

    --#region Affix Functions
    --affix1-----------------
    w.affix_container_1 = MB_FR:CreateNewFrame("affix_container_1", "", "TOPLEFT", w.MyKeystoneInfo,
        "BOTTOMLEFT", w, 0, -10, 400, 20)
    w.affix_icon_1 = MB_FR:AddIcon(w.affix_container_1, "LEFT", MB_FX:MyAffIcon("AFFIX1"), 20, 20)
    w.affix_string_1 = MB_FR:AddFontString("AFFIX1", w, "LEFT", w.affix_icon_1, "RIGHT", 5, 0,
        MB_FX:WhiteText(MB_FX:CurrentAffixes("AFFIX1")))
    w.affix_string_1:SetScript("OnEnter", function() DisplayTooltip(MB_FX:MyAffTooltip("AFFIX1")) end)

    --affix 2---------------
    w.affix_container_2 = MB_FR:CreateNewFrame("affix_container_2", "", "TOPLEFT", w.affix_container_1, "BOTTOMLEFT", w, 0, -10, 400, 20)
    w.affix_icon_2 = MB_FR:AddIcon(w.affix_container_2, "LEFT", MB_FX:MyAffIcon("AFFIX2"), 20, 20)
    w.affix_string_2 = MB_FR:AddFontString("AFFIX2", w, "LEFT", w.affix_icon_2, "RIGHT", 5, 0,
        MB_FX:WhiteText(MB_FX:CurrentAffixes("AFFIX2")))
    w.affix_string_2:SetScript("OnEnter", function() DisplayTooltip(MB_FX:MyAffTooltip("AFFIX2")) end)

    --affix 3---------------
    w.affix_container_3 = MB_FR:CreateNewFrame("affix_container_3", "", "TOPLEFT", w.affix_container_2, "BOTTOMLEFT", w, 0, -10, 400, 20)
    w.affix_icon_3 = MB_FR:AddIcon(w.affix_container_3, "LEFT", MB_FX:MyAffIcon("AFFIX3"), 20, 20)
    w.affix_string_3 = MB_FR:AddFontString("AFFIX3", w, "LEFT", w.affix_icon_3, "RIGHT", 5, 0,
        MB_FX:WhiteText(MB_FX:CurrentAffixes("AFFIX3")))
    w.affix_string_3:SetScript("OnEnter", function() DisplayTooltip(MB_FX:MyAffTooltip("AFFIX3")) end)
    --#endregion

    w:Show()

    previousWindow = w
    return previousWindow, w
end




---comment it makes the tooltips appear or else it gets the hose again
---@param text string
---@return Frame
function DisplayTooltip(text)

    if previousTooltip then
        previousTooltip:Hide()
        previousTooltip = nil
    end

    ---@class ttw: frame
    local ttw = MB_FR:CreateNewFrame("AboveFrameTooltip","InsetFrameTemplate3","BOTTOMLEFT", previousWindow,"TOPLEFT", previousWindow, 0, 10, 400, 70)
        ttw:SetScript("onMouseDown", function() ttw:Hide() end)
        ttw.tooltip_string = MB_FR:AddFontString("AboveWindowTooltip", ttw, 'TOPLEFT', ttw, "TOPLEFT", 8, -5, text)
        ttw.tooltip_string:SetWordWrap(true)
        ttw.tooltip_string:SetSize(385, 55)
        ttw.tooltip_string:SetJustifyH("LEFT")
        ttw.tooltip_string:SetJustifyV("TOP")
        ttw.tooltip_string:SetFontObject("Game13Font")

        previousTooltip = ttw
    return previousTooltip
end


function HideOnLeavingWorld()
    if previousWindow then
        previousWindow:Hide()
        ResetZoneChangeCounter()
        return
    end
end

MB_EV:Register("PLAYER_LEAVING_WORLD", HideOnLeavingWorld, "HideOnLeavingWorld")

function HideOnDungeonStart()
    ResetZoneChangeCounter()
    w:Hide()
end

MB_EV:Register("CHALLENGE_MODE_START", HideOnDungeonStart, "HideOnDungeonStart")

function ResetZoneChangeCounter()
    ZONE_CHANGE_COUNTER = {}
end


function Troubleshooting()
    CreateBuddy()
end
