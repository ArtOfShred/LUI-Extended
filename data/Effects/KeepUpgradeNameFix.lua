--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

--- @class (partial) LuiExtended
local LUIE = LUIE

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--- @class (partial) KeepUpgradeNameFix
local KeepUpgradeNameFix =
{
    [Abilities.Keep_Upgrade_Food_Mage_Abilities] = Abilities.Keep_Upgrade_Food_Mage_Abilities_Fix,
}


--- @class (partial) KeepUpgradeNameFix
LUIE.Data.Effects.KeepUpgradeNameFix = KeepUpgradeNameFix
