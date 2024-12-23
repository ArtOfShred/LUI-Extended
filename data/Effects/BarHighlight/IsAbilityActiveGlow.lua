--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

---@class (partial) Effects
local Effects = LUIE.Data.Effects

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- EFFECTS TABLE FOR BAR HIGHLIGHT RELATED OVERRIDES
--------------------------------------------------------------------------------------------------------------------------------

Effects.IsAbilityActiveGlow =
{

    [20824] = true,  -- Power Lash (Flame Lash)

    [126659] = true, -- Flying Blade (Flying Blade)

    [137156] = true, -- Carnage (Pounce)
    [137184] = true, -- Brutal Carnage (Brutal Pounce)
    [137164] = true, -- Feral Carnage (Feral Pounce)
}