---@class MythicBuddyFrames
MythicBuddyFrames = {}--

---comment Create a new frame with a unique namespace
---@param name string for fstack id
---@param template Template
---@param selfpoint string new object - where we are anchored
---@param obj Frame
---@param objPoint FramePoint
---@param selfParent FramePoint
---@param xoffset number x offset in pixels, positive is right
---@param yOffsett number y offset in pixels, poitive is down
---@param width number width in pixels
---@param height number height in pixels
---@return any# pseudo-method 
function MythicBuddyFrames:CreateNewFrame(name, template, selfpoint, obj, objPoint, selfParent, xoffset, yOffsett, width, height)
	local frame = CreateFrame("frame", name, selfParent, template)
	frame:SetPoint(selfpoint, obj, objPoint, xoffset, yOffsett)
	frame:SetSize(width, height)
	return frame
end

---comment
---@param name string unique identifier for fstack
---@param selfParent any 
---@param selfPoint any this obj connection point
---@param obj any other object to connect to
---@param objPoint any point on the other object
---@param xOffset any in pixels
---@param yOffset any in pixels
---@param text any 
---@return fontstring
function MythicBuddyFrames:AddFontString(name, selfParent, selfPoint, obj, objPoint, xOffset, yOffset, text)
	local fontString = selfParent:CreateFontString(name, "OVERLAY")
	fontString:SetFontObject("GameFontNormal")
	--(This Region Point, relative to obj, obj point)
	fontString:SetPoint(selfPoint, obj, objPoint, xOffset, yOffset)
	fontString:SetText(text)
	return fontString
end

---comment Must be anchored to a frame
---@param UIParent Frame
---@param point any
---@param textureID string|number [wowhead](https://www.wowhead.com/icon=134532/inv-mushroom-11)
---@param width number in pixels
---@param height number in pixels
---@return any
function MythicBuddyFrames:AddIcon(UIParent, point, textureID, width, height)

	-- UIParent = UIParent or nil
	-- point = point or "CENTER"
	-- textureID = textureID or ""

	local tex = UIParent:CreateTexture()
	tex:SetPoint(point)
	tex:SetTexture(textureID)
	tex:SetSize(width, height)
	return tex
end


