
NarciGuideMixin = {};
local tutorial;     --NarcissusDB
local L = Narci.L;

local FIXED_WIDTH = 270;
local TEXT_INSET = 18;
local CRITERIA_MET_MARK = "[OK]"

local function CloseGuide(self)
    self:GetParent():Hide();
end

local function EmptyFunc()
    return;
end

function NarciGuideMixin:OnShow()
    if tutorial[self.KeyValue] then
        tutorial[self.KeyValue] = false;
    end
    UIFrameFadeIn(self, 0.25, 0, 1);
    self:SetScale(NarcissusDB["GlobalScale"]);
    self:SetWidth(FIXED_WIDTH);
    local height = (self.Header:GetHeight() + self.Text:GetHeight() + 2 * (TEXT_INSET - 6) + 24 + 4 + 1);
    self:SetHeight(height);
    PlaySound(869, "SFX");
end

function NarciGuideMixin:OnHide()
    self:StopAnimating();
end

function NarciGuideMixin:NewText(title, description, anchorTo, offsetX, offsetY, buttonDelay, buttonFunc)
    self:Hide();
    self:ClearAllPoints();
    self.Header:SetText(title);
    self.Text:SetText(description);
    self:SetPoint("BOTTOM", anchorTo, "TOP", offsetX or 0, offsetY or 0);
    self:Show();
    self.Next:Hide();
    local t = buttonDelay or -1;
    if t >= 0 then
        C_Timer.After(t, function()
            UIFrameFadeIn(self.Next, 0.25, 0, 1);
        end);
        if buttonFunc then
            if type(buttonFunc) == "string" and buttonFunc == "END" then
                self.Next.IconClose:Show();
                self.Next.IconNext:Hide();
                self.Next:SetScript("OnClick", CloseGuide);
            else
                self.Next:SetScript("OnClick", buttonFunc);
            end
        end
    end
end

---------------------------------------------------------------------------------------
-------------------------
-----Race Change Alert---
-------------------------
local StopTimer = Narci_BioAlertFrame_StopTimer;     --PlayerModel.lua
local function RaceChangeAlert_OnShow(self)
    StopTimer();
    --tutorial["RaceChange"] = false;
end


--------------------------------
--Model Movement: New Gestures--
--------------------------------
local function GestureListener()

end


-------------------------
--Equipment Set Manager--
-------------------------


-------------------------
--Spell Visual Browser---
-------------------------
local BrowserGuide;
local LeftClickUsed, RightClickUsed = false, false;

local function MoveToEditBox()
    BrowserGuide:NewText(L["Guide Input Headline"], L["Guide Input Line1"], Narci_SpellVisualBrowser.ExpandableFrames.EditBox, 0, -4, 5, "END");
end

local function MoveToReApplyButton()
    BrowserGuide:NewText(L["Refresh Model"], L["Guide Refresh Line1"], Narci_SpellVisualBrowser.ExpandableFrames.ResetButton, 0, -4, 4, MoveToEditBox);
end

local function MoveToHistoryTab()
    C_Timer.After(1, function()
        BrowserGuide:NewText(L["Guide History Headline"], L["Guide History Line1"], Narci_SpellVisualBrowser.ExpandableFrames.HistoryFrame, 0, -6, 4.5, MoveToReApplyButton);
    end);
end

local function OnTabChanged(self, value)
    C_Timer.After(2, function()
        BrowserGuide:NewText(L["Guide Spell Headline"], L["Guide Spell Line1"].."\n"..L["Guide Spell Criteria1"].."\n"..L["Guide Spell Criteria2"], Narci_SpellVisualBrowser.ExpandableFrames.ListFrame);
        
        hooksecurefunc(NarciPlayerModelFrame1, "ApplySpellVisualKit", function(self, visualID, oneshot)
            if LeftClickUsed and RightClickUsed then
                return;
            end
            if BrowserGuide:IsVisible() then
                if oneshot then
                    if not LeftClickUsed then
                        LeftClickUsed = true;
                        if not RightClickUsed then
                            BrowserGuide.Text:SetText(L["Guide Spell Line1"].."\n".."|cff007236"..CRITERIA_MET_MARK..L["Guide Spell Criteria1"].."|r\n"..L["Guide Spell Criteria2"]);
                        else
                            BrowserGuide.Text:SetText(L["Guide Spell Line1"].."\n".."|cff007236"..CRITERIA_MET_MARK..L["Guide Spell Criteria1"].."\n"..CRITERIA_MET_MARK..L["Guide Spell Criteria2"]);
                            MoveToHistoryTab()
                        end
                    end
                else
                    if not RightClickUsed then
                        RightClickUsed = true;
                        if not LeftClickUsed then
                            BrowserGuide.Text:SetText(L["Guide Spell Line1"].."\n"..L["Guide Spell Criteria1"].."\n|cff007236"..CRITERIA_MET_MARK.. L["Guide Spell Criteria2"]);
                        else
                            BrowserGuide.Text:SetText(L["Guide Spell Line1"].."\n".."|cff007236"..CRITERIA_MET_MARK..L["Guide Spell Criteria1"].."\n"..CRITERIA_MET_MARK..L["Guide Spell Criteria2"]);
                            MoveToHistoryTab()
                        end
                    end
                end
            end
        end);

    end)
end

local function BuildBrowserGuide()
    local Browser = Narci_SpellVisualBrowser;
    Browser.ShowGuide = true;
    BrowserGuide = CreateFrame("Frame", nil, Browser, "NarciGenericGuideTemplate");
    local TabListener = CreateFrame("SLIDER", "TestSlider", BrowserGuide);
    TabListener:SetMinMaxValues(-1, 5);     --Necessary!
    TabListener:SetScript("OnValueChanged", OnTabChanged);
    BrowserGuide.TabListener = TabListener;

    --Guide.Next:SetScript("OnClick", RelocateGuide);
    local ExpandableFrames = Browser.ExpandableFrames;
    ExpandableFrames:SetScript("OnShow", function(self)
        C_Timer.After(0.6, function()
            BrowserGuide:NewText(L["Category"], L["Guide Spell Choose Category"], ExpandableFrames.ListFrame);
            tutorial["SpellVisualBrowser"] = false;
        end);
        self:SetScript("OnShow", EmptyFunc);
    end);
end

local function RelocateGuide(self)
    local Browser = Narci_SpellVisualBrowser;
    --BrowserGuide:
end



----------------------------
--Exit Confirmation Dialog--
----------------------------
local function MakeItInsanelyLarge()
    local ExitConfirm = Narci_ExitConfirmationDialog;
    ExitConfirm:SetScale(4);
    ExitConfirm:SetScript("OnHide", function(self)
        self:SetScale(1);
        tutorial["ExitConfirmation"] = false;
    end)
end


----------------------------------------------------------
local Initialization = CreateFrame("Frame");
Initialization:RegisterEvent("VARIABLES_LOADED");
Initialization:SetScript("OnEvent", function(self, event, ...)
    self:UnregisterEvent("VARIABLES_LOADED");
    C_Timer.After(3, function()
        tutorial = NarcissusDB.Tutorials;
        if not tutorial then return; end;
        --True ~ will show tutorial
        --Race change
        local key = tutorial["RaceChangeFixed"];
        if key then
            local ActorPortrait = NarciModelControl_ActorButton;
            local Tip = CreateFrame("Frame", nil, ActorPortrait, "NarciGenericGuideTemplate");
            ActorPortrait:SetScript("OnShow", function(self)
                SetPortraitTexture(self.Portrait1, "player");
                C_Timer.After(1, function()
                    Tip:NewText(L["Race Change"], L["Race Change Line1"], ActorPortrait, 0, -6, 5, "END");
                    tutorial["RaceChangeFixed"] = false;
                end);
                self:SetScript("OnShow", function(self)
                    SetPortraitTexture(self.Portrait1, "player");
                end);
            end)
        end

        --Enlarged Exit Confirmation
        key = tutorial["ExitConfirmation"];
        if key then
            MakeItInsanelyLarge();
        end

        --Spell Visual Browser
        key = tutorial["SpellVisualBrowser"];
        if key then
            BuildBrowserGuide();
        end

        --Equipment Set Manager
        key = tutorial["EquipmentSetManager"];
        if key then
            local ManagerFrame = Narci_EquipmentSetManagerFrame;
            local Tip = CreateFrame("Frame", nil, ManagerFrame, "NarciGenericGuideTemplate");
            ManagerFrame:SetScript("OnShow", function(self)
                C_Timer.After(1, function()
                    Tip:NewText(L["Equipment Manager"], L["Guide Equipment Manager Line1"], Narci_EquipmentSetManagerFrame, 0, 0, 2, "END");
                    tutorial["EquipmentSetManager"] = false;
                end);
                self:SetScript("OnShow", EmptyFunc);
            end)



        end

        --Character Movement
        key = tutorial["Movement"];
        if key then
            local Movement = CreateFrame("Frame", nil, Narci_ModelSettings, "NarciGenericGuideTemplate");
            Narci_ModelSettings:SetScript("OnShow", function(self)
                self:RegisterEvent("MODIFIER_STATE_CHANGED");
                C_Timer.After(2, function()
                    Movement:NewText(L["Guide Model Control Headline"], L["Guide Model Control Line1"], Narci_ModelSettings, 0, 32, 2, "END");
                    tutorial["Movement"] = false;
                end);
                self:SetScript("OnShow", function(self)
                    self:RegisterEvent("MODIFIER_STATE_CHANGED");
                end);
            end);
            
        end

        --Minimap button can be influenced by other addons
        key = tutorial["IndependentMinimapButton"];
        if key then
            local mini = CreateFrame("Frame", nil, Minimap, "NarciGenericGuideTemplate");
            C_Timer.After(1, function()
                mini:NewText(L["Guide Minimap Button Headline"], L["Guide Minimap Button Line1"], Narci_MinimapButton, 0, 0, 2, "END");
            end)
            tutorial["IndependentMinimapButton"] = false;
        end
    end)
end);

function Narci:ResetGuide()
    wipe(NarcissusDB.Tutorials);
end