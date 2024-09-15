-- MythicBuddyFrames = CreateFrame(...)
-- MythicBuddyFrames.db = {}

-- function MythicBuddyFrames:NewFrameObj(widget, name)
-- 	local obj = {}
-- 		obj.name = name
-- 		obj.method = widget
-- 	return obj
-- end


-- function MythicBuddyFrames:AddFrame(id, name, type, selfparent, template, selfPoint, sibling, relativePoint, xOffset, yOffset, width, height)
-- 	local obj = self.NewFrameObj(id, name)

-- 	selfparent = selfparent or UIParent
-- 	template = template or ""
-- 	selfPoint = selfPoint or "CENTER"
-- 	sibling = sibling or UIParent
-- 	relativePoint = relativePoint or "CENTER"
-- 	xOffset = xOffset or 0
-- 	yOffset = yOffset or 0
-- 	width = width or 0
-- 	height = height or 0


-- 	if not self.db[id] then
-- 		self.db[id] = {}
-- 		MythicBuddyEvents:CreateFrame(type, name, selfparent, template, id)
-- 		MythicBuddyEvents:SetPoint(selfPoint, sibling, relativePoint, xOffset, yOffset)
-- 		MythicBuddyEvents:SetSize(width, height)
-- 	end

-- 	self.db[id][name] = obj

-- end





-- local f = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")











--#region
-- function MythicBuddyFrames:CreateNewFrame(name, template, selfpoint, obj, objPoint, selfParent, xoffset, yOffsett, width, height)
-- 	local frame = CreateFrame("frame", name, selfParent, template)
-- 	frame:SetPoint(selfpoint, obj, objPoint, xoffset, yOffsett)
-- 	frame:SetSize(width, height)
-- 	return frame
-- end


-- function MythicBuddyFrames:AddFontString(name, selfParent, selfPoint, obj, objPoint, xOffset, yOffset, text)
-- 	local fontString = selfParent:CreateFontString(name, "OVERLAY")
-- 	fontString:SetFontObject("GameFontNormal")
-- 	fontString:SetPoint(selfPoint, obj, objPoint, xOffset, yOffset)
-- 	fontString:SetText(text)
-- 	return fontString
-- end


-- function MythicBuddyFrames:AddIcon(UIParent, point, textureID, width, height)
-- 	local tex = UIParent:CreateTexture()
-- 	tex:SetPoint(point)
-- 	tex:SetTexture(textureID)
-- 	tex:SetSize(width, height)
-- 	return tex
-- end
--#endregion

