Narci_GemInfo = {
    --[ItemID] = {"Attribute", Amount},
    ----8 BFA----
    [168636] = {"STR", 120},        --Leviathan's Eye of Strength
    [168637] = {"AGI", 120},        --Leviathan's Eye of Agility
    [168638] = {"INT", 120},        --Leviathan's Eye of Intellect

    [168639] = {"crit", 50},        --Deadly Lava Lazuli
    [168640] = {"mastery", 50},     --Masterful Sea Currant
    [168641] = {"haste", 50},       --Quick Sand Spinel
    [168642] = {"versatility", 50}, --Versatile Dark Opal
    [169220] = {"MSPD", 5},         --***Straddling Sage Agate

    [154126] = {"crit", 40},        --Deadly Amberblaze
    [154127] = {"haste", 40},       --Quick Owlseye
    [154128] = {"versatility", 40}, --Versatile Royal Quartz
    [154129] = {"mastery", 40},     --Masterful Tidal Amethyst

    [153707] = {"STR", 80},         --Kraken's Eye of Strength
    [153708] = {"AGI", 80},         --Kraken's Eye of Agility
    [153709] = {"INT", 80},         --Kraken's Eye of Intellect

    [153710] = {"crit", 30},        --Deadly Solstone
    [153711] = {"haste", 30},       --Quick Golden Beryl
    [153712] = {"versatility", 30}, --Versatile Kyanite
    [153713] = {"mastery", 30},     --Masterful Kubiline
    [153714] = {"EXP", 5},          --***Insightful Rubellite 
    [153715] = {"MSPD", 3},         --***Straddling Viridium

    ----7 LEG----
    [151580] = {"crit", 11},        --Deadly Deep Chemirine
    [151583] = {"haste", 11},       --Quick Lightsphene
    [151584] = {"mastery", 11},     --Masterful Argulite
    [151585] = {"versatility", 11}, --Versatile Labradorite

    [130219] = {"crit", 9},         --Deadly Eye of Prophecy
    [130220] = {"haste", 9},        --Quick Dawnlight
    [130221] = {"versatility", 9},   --Versatile Maelstrom Sapphire
    [130222] = {"mastery", 9},      --Masterful Shadowruby

    [130215] = {"crit", 7},         --Deadly Deep Amber
    [130216] = {"haste", 7},        --Quick Azsunite
    [130217] = {"versatility", 7},  --Versatile Skystone
    [130218] = {"mastery", 7},      --Masterful Queen's Opal
}

Narci_EnchantInfo = {
    --[EnchantID] = {"Attribute", Amount, SpellID},  --need to be parsed from itemstring
    ----8 BFA----
    ----Ring----
    [5938] = {"crit", 30, 255094},          --Seal of Critical Strike
    [5939] = {"haste", 30, 255095},         --Seal of Haste
    [5940] = {"mastery", 30, 255096},       --Seal of Mastery
    [5941] = {"versatility", 30, 255097},   --Seal of Versatility

    [5942] = {"crit", 40, 255098},          --Pact of Critical Strike
    [5943] = {"haste", 40, 255099},         --Pact of Haste
    [5944] = {"mastery", 40, 255100},       --Pact of Mastery
    [5945] = {"versatility", 40, 255101},   --Pact of Versatility

    [6108] = {"crit", 60, 298011},          --Accord of Critical Strike
    [6109] = {"haste", 60, 298016},         --Accord of Haste
    [6110] = {"mastery", 60, 298002},       --Accord of Mastery
    [6111] = {"versatility", 60, 297999},   --Accord of Versatility

    ----Weapon----
    [5946] = {"heal", 0, 255105},           --Coastal Surge***
    [5948] = {"leech", 0, 255112},          --Siphoning***
    [5949] = {"spell", 0, 255131},          --Torrent of Elements       proc an aura which increases your elemental spell damage by 10%
    [5950] = {"speed", 0, 255143},          --Gale-Force Striking       increases your attack speed by 15% for 15 sec
    [5962] = {"versatility", 0, 268879},    --Versatile Navigation      +50 per stack, up to 10 stacks
    [5963] = {"haste", 0, 268897},          --Quick Navigation
    [5964] = {"mastery", 0, 268903},        --Masterful Navigation
    [5965] = {"crit", 0, 268909},           --Deadly Navigation
    [5966] = {"armor", 0, 268915},          --Stalwart Navigation

    [6112] = {"INT", 0, 300770},            --Machinist's Brilliance    occasionally increase Intellect and Mastery, Haste, or Critical Strike. Your highest stat is always chosen.
    [6148] = {"STR", 0, 300788},            --Force Multiplier          occasionally increase Strength or Agility and Mastery, Haste, or Critical Strike. Your highest stat is always chosen.
    [6150] = {"AGI", 0, 300789},            --Naga Hide                 When you Block, Dodge, or Parry, you have a chance to increase Strength or Agility
    [6149] = {"INT", 0, 298515},            --Oceanic Restoration       occasionally increase Intellect and restore mana

    ----7 LEG----
    ----Ring----
    [5423] = {"crit", 7, 190866},           --Word of Critical Strike
    [5424] = {"haste", 7, 190867},          --Word of Haste
    [5425] = {"mastery", 7, 190868},        --Word of Mastery
    [5426] = {"versatility", 7, 190869},    --Word of Versatility

    [5427] = {"crit", 9, 190870},           --Binding of Critical Strike
    [5428] = {"haste", 9, 190871},          --Binding of Haste
    [5429] = {"mastery", 9, 190872},        --Binding of Mastery
    [5430] = {"versatility", 9, 190873},    --Binding of Versatility
    
    ----Cloak----
    [5431] = {"STR", 7, 190874},            --Word of Strength
    [5432] = {"AGI", 7, 190875},            --Word of Agility
    [5433] = {"INT", 7, 190876},            --Word of Intellect

    [5434] = {"STR", 9, 190877},            --Binding of Strength
    [5435] = {"AGI", 9, 190878},            --Binding of Agility
    [5436] = {"INT", 9, 190879},            --Binding of Intellect
    
}


local GemBorderTexture = {
	[0]  = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot",			--Empty
	[1]  = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot-Unique",	--Kraken's Eye
	[2]  = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot-Green",
	[3]  = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot-Unique",	--Prismatic	
	[4]  = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot-Unique",	--Meta
	[5]  = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot-Orange",	--Orange
	[6]  = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot-Purple",
    [7]  = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot-Yellow",	--Yellow	
	[8]  = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot-Blue",		--Blue
	[9]  = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot-Yellow",	--Empty
	[10] = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot-Red",		--Red
	[11] = "Interface/AddOns/Narcissus/Art/GemBorder/GemSlot",			--Artifact
}




--Some gems require you to assign colors manually
--itemID, itemType, itemSubType, itemEquipLoc, icon, itemClassID, itemSubClassID = GetItemInfoInstant(itemID or "itemString" or "itemName" or "itemLink") 
local function GetGemBorderTexture(itemID, itemSubClassID)
    local index = itemSubClassID or 0;
    if itemID == 153714 then
        index = 10;     --Red EXP bonus
    elseif itemID == 153715 or itemID == 169220 then
        index = 2;      --Movement Speed
    elseif itemID == 168636 or itemID == 168637 or itemID == 168638 or
    itemID == 153707 or itemID == 153708 or itemID == 153709 then
        index = 1;      --Primary
    end
    return index, GemBorderTexture[index]
end

Narci.GetGemBorderTexture = GetGemBorderTexture;