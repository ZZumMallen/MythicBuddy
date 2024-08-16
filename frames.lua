---@class MythicBuddyFrames #Creates Frames 
---@
MythicBuddyFrames = {}


---comment
---@param name string for fstack id
---@param template string xml template
---@param selfpoint string new object - where we are anchored
---@param obj string object - what whe are anchoring to
---@param objPoint string  object - where on the object  
---@param selfParent string parent frame
---@param xoffset number x offset in pixels, positive is right
---@param yOffsett number y offset in pixels, poitive is down
---@param width number width in pixels
---@param height number height in pixels
---@return any # pseudo-method 
function MythicBuddyFrames:CreateNewFrame(name, template, selfpoint, obj, objPoint, selfParent, xoffset, yOffsett, width, height)
	local frame = CreateFrame("frame", name, selfParent, template)
	frame:SetPoint(selfpoint, obj, objPoint, xoffset, yOffsett)
	frame:SetSize(width, height)
	return frame
end


---@
function MythicBuddyFrames:AddFontString(name, selfParent, selfPoint, obj, objPoint, xOffset, yOffset, text)
	local fontString = selfParent:CreateFontString(name, "OVERLAY")
	fontString:SetFontObject("GameFontNormal")
	--(This Region Point, relative to obj, obj point)
	fontString:SetPoint(selfPoint, obj, objPoint, xOffset, yOffset)
	fontString:SetText(text)
	return fontString
end

--https://www.wowhead.com/icon=134532/inv-mushroom-11
-- must be anchored to a frame
function MythicBuddyFrames:AddIcon(UIParent, point, textureID, width, height)
	local tex = UIParent:CreateTexture()
	tex:SetPoint(point)
	tex:SetTexture(textureID)
	tex:SetSize(width, height)
	return tex
end

-- /run ChatFrame1:Clear()
