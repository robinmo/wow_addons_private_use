------------------------------------------------------------
-- Custom.lua
--
-- Abin
-- 2010/3/29
------------------------------------------------------------

local format = format
local HandleModifiedItemClick = HandleModifiedItemClick
local strtrim = strtrim
local tonumber = tonumber
local GetSpellInfo = GetSpellInfo
local GameTooltip = GameTooltip

local MAX_SPELL_ID = 250000 -- for legion

local L = CompactRaid:GetLocale("RaidDebuff")
local module = CompactRaid:GetModule("RaidDebuff")
if not module then return end

local page = module.optionPage
local debuffList = page.debuffList
local tierId, instanceId, bossId

local list = UICreateVirtualScrollList(page:GetName().."CustomList", page, 15, 1, nil, "TABLE")
page.customLst = list
list:SetAllPoints(debuffList)
list:Hide()

local listLabel = list:CreateFontString(nil, "ARTWORK", "GameFontNormalLeft")
listLabel:SetPoint("BOTTOMLEFT", page.listPanel, "TOPLEFT")
listLabel:SetText(L["spell list"])

local function EnterCustomMode()
	tierId = page.tierCombo:GetSelection()
	instanceId = page.instanceCombo:GetSelection()
	bossId = page.bossCombo:GetSelection()
	if not tierId or not instanceId or not bossId then
		return
	end

	page.tierCombo:Disable()
	page.instanceCombo:Disable()
	page.bossCombo:Disable()
	debuffList:Hide()
	list:Show()
end

local function LeaveCustomMode()
	list:Hide()
	list:Clear()
	debuffList:Show()
	page.tierCombo:Enable()
	page.instanceCombo:Enable()
	page.bossCombo:Enable()
end

local buttonRegister = page:CreatePressButton(ADD)
buttonRegister:SetParent(list)
buttonRegister:Disable()
buttonRegister:SetAllPoints(page.buttonAdd)

buttonRegister:SetScript("OnHide", function(self)
	addon:PopupHide()
end)

buttonRegister:SetScript("OnClick", function(self)
	local data = self.data
	LeaveCustomMode()
	if not data then
		return
	end

	if module:IsDebuffRegistered(tierId, instanceId, data.name) then
		self:Print(format(L["debuff already registered"], data.name, module:GetInstanceName(tierId, instanceId)))
		return
	end

	local data = module:RegisterDebuff(tierId, instanceId, bossId, data.id, nil, 1)
	local position = debuffList:InsertData(data)
	debuffList:SetSelection(position)
	debuffList:EnsureVisible()
end)

local buttonCancel = page:CreatePressButton(CANCEL)
buttonCancel:SetParent(list)
buttonCancel:SetAllPoints(page.buttonDelete)
buttonCancel:SetScript("OnClick", LeaveCustomMode)

local label = list:CreateFontString(nil, "ARTWORK", "GameFontNormalLeft")
label:SetPoint("BOTTOMLEFT", page.listPanel, "TOPLEFT")
label:SetText(L["debuff list"])

function list:OnButtonCreated(button)
	button.text:SetTextColor(113 / 255, 213 / 255, 1)
end

function list:OnSelectionChanged(position, data)
	buttonRegister.data = data
	if data then
		buttonRegister:Enable()
	else
		buttonRegister:Disable()
	end
end

local function ProcessInput(text)
	text = strtrim(text or "")
	if text == "" then
		return 1
	end

	list:Clear()
	list:RefreshContents()

	local name, _, icon, link
	local id = tonumber(text)
	if id then
		name, _, icon = GetSpellInfo(id)
		if name then
			list:InsertData({ id = id, name = name, icon = icon, link = "|cff71d5ff|Hspell:"..id.."|h["..name.."]|h|r" })
		end
	else
		for id = 1, MAX_SPELL_ID do
			name, _, icon = GetSpellInfo(id)
			if name == text then
				list:InsertData({ id = id, name = name, icon = icon, link = "|cff71d5ff|Hspell:"..id.."|h["..name.."]|h|r" })
			end
		end
	end

	if list:GetDataCount() > 0 then
		EnterCustomMode()
	else
		module:Print(format(L["debuff or spell not found for"], text))
		return 1
	end
end

function module:StartCustomInput()
	addon:PopupShowInput(L["type debuff name or it's spell id"], ProcessInput)
end