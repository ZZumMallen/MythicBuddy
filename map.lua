MAP = WorldMapFrame.ScrollContainer

local mapFrame

function TestShow()
	local f = CreateFrame("Frame")
	f:SetAllPoints(MAP, true)
	f:SetFrameStrata("DIALOG")
	f:Show()

	local fs = f:CreateFontString(nil, "OVERLAY", "Game13Font")
	fs:SetPoint("TOPLEFT")
	fs:SetText("IT WORKED BABY")

	mapFrame = f
	return mapFrame
end

function TestHide()
	mapFrame:Hide()
	print("HIDE")
end



local f = CreateFrame("Frame","MBD",UIParent)
f:RegisterFrame{"ADDON_LOADED"}
f:SetSript("OnEvent", function(self,event,addonName,...)
	if event == "ADDON_LOADED" and addonName == "MythicBuddy" then
		print("Mythic Buddy Loaded")
		WorldMapFrame:HookScript("OnShow", function() print("Hook Script Hooked") end);
		--WorldMapFrame:HookScript("OnHide", function ()
		f:UnRegisterEvent("ADDON_LOADED");
	end
end)

