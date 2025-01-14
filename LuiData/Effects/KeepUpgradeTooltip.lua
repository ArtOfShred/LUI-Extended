-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
local LUIE = LuiData

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--- @class (partial) KeepUpgradeTooltip
local KeepUpgradeTooltip =
{
    [Abilities.Keep_Upgrade_Food_Guard_Range] = Tooltips.Keep_Upgrade_Food_Guard_Range,
    [Abilities.Keep_Upgrade_Food_Heartier_Guards] = Tooltips.Keep_Upgrade_Food_Heartier_Guards,
    [Abilities.Keep_Upgrade_Food_Resistant_Guards] = Tooltips.Keep_Upgrade_Food_Resistant_Guards,
    [Abilities.Keep_Upgrade_Food_Stronger_Guards] = Tooltips.Keep_Upgrade_Food_Stronger_Guards,
    [Abilities.Keep_Upgrade_Ore_Armored_Guards] = Tooltips.Keep_Upgrade_Ore_Armored_Guards,
    [Abilities.Keep_Upgrade_Ore_Corner_Build] = Tooltips.Keep_Upgrade_Ore_Corner_Build,
    [Abilities.Keep_Upgrade_Ore_Siege_Platform] = Tooltips.Keep_Upgrade_Ore_Siege_Platform,
    [Abilities.Keep_Upgrade_Ore_Stronger_Walls] = Tooltips.Keep_Upgrade_Ore_Stronger_Walls,
    [Abilities.Keep_Upgrade_Ore_Wall_Regeneration] = Tooltips.Keep_Upgrade_Ore_Wall_Regeneration,
    [Abilities.Keep_Upgrade_Wood_Archer_Guard] = Tooltips.Keep_Upgrade_Wood_Archer_Guard,
    [Abilities.Keep_Upgrade_Wood_Door_Regeneration] = Tooltips.Keep_Upgrade_Wood_Door_Regeneration,
    [Abilities.Keep_Upgrade_Wood_Siege_Cap] = Tooltips.Keep_Upgrade_Wood_Siege_Cap,
    [Abilities.Keep_Upgrade_Wood_Stronger_Doors] = Tooltips.Keep_Upgrade_Wood_Stronger_Doors,
    [Abilities.Keep_Upgrade_Food_Mender_Abilities] = Tooltips.Keep_Upgrade_Food_Mender_Abilities,
    [Abilities.Keep_Upgrade_Food_Mage_Abilities] = Tooltips.Keep_Upgrade_Food_Mage_Abilities,
    [Abilities.Keep_Upgrade_Food_Honor_Guard_Abilities] = Tooltips.Keep_Upgrade_Food_Honor_Guard_Abilities,
    [Abilities.Keep_Upgrade_Food_Guard_Abilities] = Tooltips.Keep_Upgrade_Food_Guard_Abilities,
}

--- @class (partial) KeepUpgradeTooltip
LUIE.Data.Effects.KeepUpgradeTooltip = KeepUpgradeTooltip
