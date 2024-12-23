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

--------------------------------------------------------------------------------------------------------------------------------
-- We don't add bar highlights for 0 duration abilities, a few abilities with dynamic durations show as 0 duration so we need this override table.
--------------------------------------------------------------------------------------------------------------------------------
Effects.AddNoDurationBarHighlight =
{

    -- Necromancer
    [115240] = true, -- Bitter Harvest
    [124165] = true, -- Deaden Pain
    [124193] = true, -- Necrotic Potency
    [118814] = true, -- Enduring Undeath
}