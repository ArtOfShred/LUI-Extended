------------------
-- Effects namespace
LUIE.Effects = {}

-- Performance Enhancement
local E = LUIE.Effects
local T = LUIE.Tooltips
local U = LUIE.UnitNames
local A = LUIE.GetAbility()

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities considered for Ultimate generation - used by CombatInfo to determine when Ultimate is being generated (Uses base abilityName sent to the listener - so we need the default names, not LUIE modified ones)
--------------------------------------------------------------------------------------------------------------------------------
E.IsWeaponAttack = {
    [A.Skill_Light_Attack]                  = true, -- Light Attack
    [A.Skill_Heavy_Attack]                  = true, -- Heavy Attack
    [A.Skill_Heavy_Attack_Dual_Wield]       = true, -- Heavy Attack (Dual Wield)
    [A.Skill_Heavy_Attack_Werewolf]         = true, -- Heavy Attack (Werewolf)
    [A.Skill_Heavy_Attack_Shock]            = true, -- Heavy Attack (Shock)
}

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities flagged as a Toggle. For the purpose of adding a "T" label to the buff icon.
--------------------------------------------------------------------------------------------------------------------------------
E.IsToggle = {

    -- Innate
    [20299] = true, -- Sneak (Innate) -- Used for hidden
    [20301] = true, -- Crouch (Innate) -- Used for invisibility
    [A.Innate_Disguised] = true, -- Disguised (Innate) -- NOTE: We use this name as the fake ID for the player disguise buff
    [14890] = true, -- Block (Player)
    [40165] = true, -- Scene Choreo Brace (Monster Fight))
    [29761] = true, -- Brace (Guard)
    [973] = true, -- Sprint (Innate)
    [33439] = true, -- Mount Sprint (Generic)

    -- Sets
    [117082] = true, -- Frozen Watcher (Frozen Watcher)

    -- Sorcerer
    [23304] = true, -- Summon Unstable Familiar
    [23319] = true, -- Summon Unstable Clannfear
    [23316] = true, -- Summon Volatile Familiar
    [24613] = true, -- Summon Winged Twilight
    [24636] = true, -- Summon Twilight Tormentor
    [24639] = true, -- Summon Twilight Matriarch
    [24785] = true, -- Overload
    [24806] = true, -- Energy Overload
    [24804] = true, -- Power Overload

    -- Warden
    [85982] = true, -- Feral Guardian
    [85986] = true, -- Eternal Guardian
    [85990] = true, -- Wild Guardian

    -- Psijic Order
    [103923] = true, -- Concentrated Barrier
    [103966] = true, -- Concentrated Barrier
    [103543] = true, -- Mend Wounds
    [103747] = true, -- Mend Spirit
    [103755] = true, -- Symbiosis

    -- Support
    [80923] = true, -- Guard (Guard)
    [80947] = true, -- Mystic Guard (Mystic Guard)
    [64080] = true, -- Minor Vitality (Mystic Guard)
    [80983] = true, -- Stalwart Guard (Stalwart Guard)
    [80986] = true, -- Minor Force (Stalwart Guard)

    -- NPC Abilities
    [53462] = true, -- Siphoning Strikes (Nightblade)
    [44258] = true, -- Magelight (Soulbrander)
}

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities flagged to display a Proc highlight / sound notification in Combat Info when the Ability Bar is updated with a matching id.
--------------------------------------------------------------------------------------------------------------------------------
E.IsAbilityProc = {
    [20824] = true, -- Power Lash (Flame Lash
    [61907] = true, -- Assassin's Will (Grim Focus)
    [61932] = true, -- Assassin's Scourge (Relentless Focus)
    [61930] = true, -- Assassin's Will (Merciless Resolve)
}

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities flagged to display a Proc highlight / sound notification when an ability with a matching name appears as a buff.
--------------------------------------------------------------------------------------------------------------------------------
E.HasAbilityProc = {
    [A.Skill_Crystal_Fragments]   = 46327,
}

--------------------------------------------------------------------------------------------------------------------------------
-- Context Based Hidden Effects - Used by SCB.UpdateContextHideList to bulk hide certain abilities from displaying Buffs/Debuffs in the menu options.
--------------------------------------------------------------------------------------------------------------------------------

-- Vampire Stages
E.IsVamp = {
    [35771] = true, -- Stage 1 Vampirism
    [35996] = true, -- Stage 2 Vampirism
    [35783] = true, -- Stage 3 Vampirism
    [35792] = true, -- Stage 4 Vampirism
}

-- Werewolf Buff
E.IsLycan = {
    [35658] = true, -- Lycanthrophy
}

-- Werewolf & Vampire Precursor Diseases
E.IsVampLycanDisease = {
    [39472] = true, -- Vampirism (NPC Bite)
    [40360] = true, -- Vampirism (Player Bite)
    [31068] = true, -- Sanies Lupinus (NPC Bite)
    [40521] = true, -- Sanies Lupinus (Player Bite)
}

-- Werewolf & Vampire Bite cooldown timers
E.IsVampLycanBite = {
    [40359] = true, -- Fed on ally (Vampire)
    [40525] = true, -- Bit an ally (Werewolf)
}

-- Mundus passives
E.IsBoon = {
    [13940] = true, -- The Warrior
    [13943] = true, -- The Mage
    [13974] = true, -- The Serpent
    [13975] = true, -- The Thief
    [13976] = true, -- The Lady
    [13977] = true, -- The Steed
    [13978] = true, -- The Lord
    [13979] = true, -- The Apprentice
    [13980] = true, -- The Ritual
    [13981] = true, -- The Lover
    [13982] = true, -- The Atronach
    [13984] = true, -- The Shadow
    [13985] = true, -- The Tower
}

-- Cyrodiil passives
E.IsCyrodiil = {

    [39671] = true, -- Emperorship Alliance Bonus
    [11346] = true, -- Home Keep Bonus -- CONFIRM
    [11341] = true, -- Enemy Keep Bonus I
    [11343] = true, -- Enemy Keep Bonus II
    [11345] = true, -- Enemy Keep Bonus III -- CONFIRM
    [11347] = true, -- Enemy Keep Bonus IV
    [11348] = true, -- Enemy Keep Bonus V
    [11350] = true, -- Enemy Keep Bonus VI
    [11352] = true, -- Enemy Keep Bonus VII
    [11353] = true, -- Enemy Keep Bonus VIII
    [11356] = true, -- Enemy Keep Bonus IX
    [15060] = true, -- Defensive Scroll Bonus I
    [16350] = true, -- Defensive Scroll Bonus II
    [15058] = true, -- Offensive Scroll Bonus I
    [16348] = true, -- Offensive Scroll Bonus II
    [66282] = true, -- Blessing of War -- CONFIRM
}

-- Soul Summons
E.IsSoulSummons = {
    [43752] = true, -- Soul Summons
}

-- Internal Cooldown for cheat death set procs
E.IsSetICD = {
    [90936] = true, -- Phoenix
    [90938] = true, -- Immortal Warrior
    [90939] = true, -- Eternal Warrior
}

-- Food & Drink Buffs
E.IsFoodBuff = {
    -- Food Buff
    [61259] = true, -- Health Food
    [61260] = true, -- Magicka Food
    [61261] = true, -- Stamina Food
    [61294] = true, -- Magicka + Stamina Food
    [61255] = true, -- Health + Stamina Food
    [61257] = true, -- Health + Magicka Food
    [61218] = true, -- Triple Food
    [72819] = true, -- Orzorga's Tripe Trifle Pocket
    [72822] = true, -- Orzorga's Blood Price Pie
    [72824] = true, -- Orzorga's Smoked Bear Haunch
    [100502] = true, -- Deregulated Mushroom Stew
    [100498] = true, -- Clockwork Citrus Filet
    [107789] = true, -- Artaeum Takeaway Broth
    [107748] = true, -- Artaeum Pickled Fish Bowl
    [84681] = true, -- Crisp and Crunchy Pumpkin Skewer
    [84709] = true, -- Crunchy Spider Skewer
    [84725] = true, -- Frosted Brains
    [84678] = true, -- Sweet Sanguine Apples
    [86798] = true, -- Alcaire Festival Sword-Pie
    [86749] = true, -- Jagga-Drenched "Mud Ball"
    [86673] = true, -- Lava Foot Soup-and-Saltrice
    [86560] = true, -- Old Aldmeri Orphan Gruel
    [86787] = true, -- Rajhin's Sugar Claws
    [89955] = true, -- Candied Jester's Coins
    [89971] = true, -- Jewels of Misrule
    [89956] = true, -- Princess' Delight
    [66551] = true, -- Vendor Health Food
    [66568] = true, -- Vendor Magicka Food
    [66576] = true, -- Vendor Stamina Food
    [72961] = true, -- Cyrodilic Field Bar
    [72956] = true, -- Cyrodilic Field Tack
    [72959] = true, -- Cyrodilic Field Treat
    [85484] = true, -- Crown Crate Fortifying Meal
    [68411] = true, -- Crown Fortifying Meal
    [92435] = true, -- Crown Combat Mystic's Stew
    [92474] = true, -- Crown Vigorous Ragout

    -- Drink Buff
    [61322] = true, -- Health Drink
    [61325] = true, -- Magicka Drink
    [61328] = true, -- Stamina Drink
    [61345] = true, -- Magicka + Stamina Drink
    [61340] = true, -- Health + Stamina Drink
    [61335] = true, -- Health + Magicka Drink
    [61350] = true, -- Triple Drink
    [72816] = true, -- Orzorga's Red Frothgar
    [100488] = true, -- Spring-Loaded Infusion
    [84700] = true, -- Bowl of "Peeled Eyeballs"
    [84735] = true, -- Double Bloody Mara
    [84720] = true, -- Ghastly Eye Bowl
    [84704] = true, -- Witchmother's Party Punch
    [84731] = true, -- Witchmother's Potent Brew
    [86677] = true, -- Bergama Warning Fire
    [86746] = true, -- Betnikh Twice-Spiked Ale
    [86559] = true, -- Hissmir Fish-Eye Rye
    [86791] = true, -- Snow Bear Glow-Wine
    [89957] = true, -- Dubious Camoran Throne
    [66586] = true, -- Vendor Health Drink
    [66590] = true, -- Vendor Magicka Drink
    [66594] = true, -- Vendor Stamina Drink
    [72971] = true, -- Cyrodilic Field Tonic
    [72965] = true, -- Cyrodilic Field Brew
    [72968] = true, -- Cyrodilic Field Tea
    [85497] = true, -- Crown Crate Refreshing Drink
    [68416] = true, -- Crown Refreshing Drink
    [92433] = true, -- Crown Stout Magic Liqueur
    [92476] = true, -- Crown Vigorous Tincture
}


-- Experience Buffs
E.IsExperienceBuff = {
    -- Consumable
    [64210] = true, -- Psijic Ambrosia
    [89683] = true, -- Aetherial Ambrosia
    [88445] = true, -- Mythic Aetherial Ambrosia
    [66776] = true, -- Crown Experience Scroll
    [85501] = true, -- Crown Crate Experience Scroll
    [85502] = true, -- Major Crown Crate Experience Scroll
    [85503] = true, -- Grand Crown Crate Experience Scroll

    -- Event
    [91369] = true, -- The Pie of Misrule (Jester's Experience Boost Pie)
    [92232] = true, -- Pelinal's Ferocity
    [91449] = true, -- Breda's Magnificent Mead
    [86075] = true, -- Breda's Magnificent Mead
    [77123] = true, -- Anniversary EXP Buff
    [118985] = true, -- Anniversary EXP Buff
    [96118] = true, -- Witchmother's Boon -- TODO: Check one more time
}

-- Block buffs (NPC and Player)
E.IsBlock = {
    [14890] = true, -- Block
    [29761] = true, -- Brace
    [40165] = true, -- Scene Choreo Brace
}


--------------------------------------------------------------------------------------------------------------------------------
-- Grim Focus Id's - Used by SCB to track the id's for Grim Focus & its morphs - These id's are merged with the Override for stack tracking
--------------------------------------------------------------------------------------------------------------------------------
E.IsGrimFocus = {
    [61905] = true, -- Grim Focus
    [61928] = true, -- Relentless Focus
    [61920] = true, -- Merciless Resolve
}

--------------------------------------------------------------------------------------------------------------------------------
-- Grim Focus Override Id's - Used by SCB to track the id's for Grim Focus & its morphs - These id's are merged with the base buff for stack tracking
--------------------------------------------------------------------------------------------------------------------------------
E.IsGrimFocusOverride = {
    [61902] = true, -- Grim Focus
    [61927] = true, -- Relentless Focus
    [61919] = true, -- Merciless Resolve
}

--------------------------------------------------------------------------------------------------------------------------------
-- Ground Mine Auras tracking
--------------------------------------------------------------------------------------------------------------------------------
E.IsGroundMineAura = {

    -- Nightblade
    [37475] = true, -- Manifestation of Terror (Nightblade)

    -- Sorcerer
    [24830] = true, -- Daedric Mines (Daedric Mines)
    [24847] = true, -- Daedric Mines (Daedric Tomb)
    [25158] = true, -- Daedric Mines (Daedric Minefield)

    -- Fighters Guild
    [35750] = true, -- Trap Beast (Trap Beast)
    [40382] = true, -- Rearming Trap (Rearming Trap)
    [40388] = true, -- Rearming Trap (Rearming Trap)
    [40372] = true, -- Lightweight Beast Trap (Lightweight Beast Trap)

    -- Mages Guild
    [31632] = true, -- Fire Rune (Fire Rune)
    [40470] = true, -- Volcanic Rune (Volcanic Rune)
    [40465] = true, -- Scalding Rune (Scalding Rune)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Abilities flagged as Ground Mines that need a stack counter, when an EFFECT_RESULT_FADED event occurs for these buffs decrement by 1 instead of being removed
--------------------------------------------------------------------------------------------------------------------------------
E.IsGroundMineStack = {

    -- Sets
    [75930] = true, -- Deadric Mines (Eternal Hunt)

    -- Warden
    [86175] = true, -- Frozen Gate (Frozen Gate)
    [86179] = true, -- Frozen Device (Frozen Device)
    [86183] = true, -- Frozen Retreat (Frozen Retreat)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Linked id's for tracking ground mine explosions - These id's all all merged into one and considered for the purpose of reducing the stack count of certain mine abilities
--------------------------------------------------------------------------------------------------------------------------------
E.LinkedGroundMine = {

    [76631] = 37475, -- Manifestation of Terror (Nightblade)

    [24832] = 24830, -- Daedric Mines (Daedric Mines)
    [24833] = 24830, -- Daedric Mines (Daedric Mines)

    [24846] = 24847, -- Daedric Mines (Daedric Tomb)
    [24844] = 24847, -- Daedric Mines (Daedric Tomb)

    [25157] = 25158, -- Daedric Mines (Daedric Minefield)
    [25159] = 25158, -- Daedric Mines (Daedric Minefield)
    [25160] = 25158, -- Daedric Mines (Daedric Minefield)
    [25162] = 25158, -- Daedric Mines (Daedric Minefield)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Filter out Debuffs to always display regardless of whether they are sourced from the player - useful for some odd effects that get applied by the player or a player pet but aren't actually sourced from them on the API
--------------------------------------------------------------------------------------------------------------------------------
E.DebuffDisplayOverrideId = {

    ----------------------------------------------------------------
    -- INNATE / SHARED ---------------------------------------------
    ----------------------------------------------------------------

    -- Basic (Shared)
    [2727] = true, -- Off-Balance (Generic)
    [102771] = true, -- Off Balance Immunity

    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    -- Item Sets
    [52705] = true, -- Way of Martial Knowledge (... of Martial Knowledge)
    [51315] = true, -- Destructive Mage (Aether ... of Destruction)
    [75753] = true, -- Line Breaker (of Alkosh)
    [93001] = true, -- Mad Tinkerer (Stun from Fabricant)

    -- Dragonknight
    [98447] = true, -- Shackle Snare (Dragonknight Standard Synergy)

    -- Templar
    [31562] = true, -- Supernova (Nova Synergy)
    [34443] = true, -- Gravity Crush (Solar Prison Synergy)

    -- Warden
    [87560] = true, -- Frozen Gate Root (Frozen Gate)
    [92039] = true, -- Frozen Gate Root (Frozen Device)
    [92060] = true, -- Frozen Retreat Root (Frozen Retreat)

    -- Undaunted
    [42007] = true, -- Black Widow Poison (Shadow Silk - Black Widows Synergy)

    ----------------------------------------------------------------
    -- NPC ABILITIES -----------------------------------------------
    ----------------------------------------------------------------

    -- Human NPC's
    [88281] = true, -- Call Ally (Pet Ranger)
    [89017] = true, -- Dark Shade (Dreadweaver)
    [88561] = true, -- Summon the Dead (Necromancer)
    [88504] = true, -- Summon Abomination (Bonelord)
    [92158] = true, -- Raise the Earth (Beastcaller)
    [29597] = true, -- Combustion (Shaman)
    [29598] = true, -- Off Balance (Shaman)
    [89301] = true, -- Summon Spiderling (Spider Daedra)

    -- Monsters
    [89399] = true, -- Summon Spectral Lamia (Lamia)
    [89127] = true, -- Summon Beast (Spriggan)
    [42794] = true, -- Strangler: (Strangler)
    [48294] = true, -- Consuming Omen (Troll - Ranged)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Filter out Debuffs to always display regardless of whether they are sourced from the player - BY NAME -- Used for all Major / Minor Debuffs
--------------------------------------------------------------------------------------------------------------------------------
E.DebuffDisplayOverrideName = {
    [A.Skill_Minor_Breach]              = true,
    [A.Skill_Major_Breach]              = true,
    [A.Skill_Minor_Defile]              = true,
    [A.Skill_Major_Defile]              = true,
    [A.Skill_Minor_Fracture]            = true,
    [A.Skill_Major_Fracture]            = true,
    [A.Skill_Minor_Maim]                = true,
    [A.Skill_Major_Maim]                = true,
    [A.Skill_Minor_Vulnerability]       = true,
    [A.Skill_Major_Vulnerability]       = true,
    [A.Skill_Minor_Mangle]              = true,
    [A.Skill_Minor_Cowardice]           = true,
    [A.Skill_Minor_Enveration]          = true,
    [A.Skill_Minor_Uncertainty]         = true,
    [A.Skill_Minor_Magickasteal]        = true,
    [A.Skill_Minor_Lifesteal]           = true,
}

--------------------------------------------------------------------------------------------------------------------------------
-- Hide these effects on a target that is dead - only shows up when the player is able to target dead bodies, which, seems to be really inconsistent outside of being in Werewolf form.
--------------------------------------------------------------------------------------------------------------------------------
E.EffectHideWhenDead = {
    [33097] = true, -- Scary Immunities (Various NPC's)
    [44176] = true, -- Flying Immunities (Various NPC's)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Adds this aura to a list of fake Ground auras to display when the player casts them
--------------------------------------------------------------------------------------------------------------------------------
E.EffectGroundDisplay = {

    -- Required:
        -- buff, debuff, ground = true/false -- Choose whether this effect shows up in any of these containers
    -- Optional:
        --name = '' -- Add a custom name
        --icon = '' -- Add a custom icon
        --stackAdd = # -- How many stacks to add when this effect begins (used for Ground Mines)
        --stackRemove = # -- How many stacks to remove when this effect ends (used for Ground Mines)
        --stackReset = # -- Maximum stack counter (used for Ground Mines)
        --noRemove = true -- Do not end this aura on EFFECT_RESULT_FADED

    -- Cyrodiil
    [88714] = { icon = 'esoui/art/icons/ava_siege_ammo_003.dds', name = A.Skill_Meatbag_Catapult, buff = false, debuff = false, ground = true }, -- Meatbag (Meatbag Catapult)
    [104700] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_oil.dds', name = A.Skill_Oil_Catapult, buff = false, debuff = false, ground = true }, -- Twisting Path (Oil Catapult)
    [104690] = { icon = 'esoui/art/icons/ava_siege_ammo_005.dds', name = A.Skill_Scattershot_Catapult, buff = false, debuff = false, ground = true }, -- Twisting Path (Scattershot Catapult)

    -- Monster Sets
    [59590] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_bogdan.dds', name = A.Set_Bogdan_the_Nightflame, buff = true, debuff = false, ground = false }, -- Imperial Prison Item Set (Bogdan the Nightflame)
    [97901] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_stone.dds', buff = true, debuff = false, ground = true }, -- Domihaus (Domihaus)
    [97882] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_fire.dds', buff = true, debuff = false, ground = true }, -- Domihaus (Domihaus)
    [97855] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_earthgore.dds', buff = true, debuff = false, ground = false }, -- Earthgore (Earthgore)
    [80529] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_ilambris_shock.dds', buff = false, debuff = false, ground = true }, -- Ilambris (Ilambris)
    [80527] = { icon = 'esoui/art/icons/ava_siege_ui_002.dds', buff = false, debuff = false, ground = true }, -- Ilambris (Ilambris)
    [59587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_lord_warden.dds', name = A.Set_Lord_Warden_Dusk, buff = true, debuff = false, ground = false }, -- Lord Warden (Lord Warden)
    [59568] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds', name = A.Set_Malubeth_the_Scourger, buff = true, debuff = false, ground = false }, -- Scourge Harvest (Malubeth)
    [59508] = { icon = 'esoui/art/icons/achievement_ic_020.dds', name = A.Set_Maw_of_the_Infernal, buff = true, debuff = false, ground = false }, -- Banished Cells Item Set (Maw of the Infernal)
    [81036] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds', buff = true, debuff = false, ground = false }, -- Sentinel of Rkugamz
    [80954] = { icon = 'esoui/art/icons/achievement_ic_017.dds', name = A.Set_Shadowrend, buff = true, debuff = false, ground = false }, -- Shadowrend Summon (Shadowrend)
    [59497] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', buff = false, debuff = false, ground = true }, -- Spawn of Mephala (Spawn of Mephala)
    [80523] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_stormfist.dds', buff = false, debuff = false, ground = true }, -- Stormfist (Stormfist)
    [102093] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_thurvokun.dds', buff = false, debuff = false, ground = true }, -- Thurvokun
    --[102136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_zaan.dds', buff = true, debuff = false, ground = false }, -- Zaan -- Buff icon for Zaan, may reimplement if I add a way to override tooltips for these.

    -- Crafted Sets
    [75930] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds', name = A.Set_Eternal_Hunt, buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 7 }, -- Daedric Mines (Eternal Hunt)
    [71671] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_light_attack.dds', buff = true, debuff = false, ground = false }, -- Morkuldin (Morkuldin)
    [106784] = { name = A.Set_Dust_Cloud, buff = false, debuff = false, ground = true }, -- Dustcloud (Adept Rider's)

    -- Overland Sets
    [75691] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', buff = false, debuff = false, ground = true }, -- Bahraha's Curse

    -- Dungeon Sets
    [97538] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds', buff = true, debuff = false, ground = false }, -- Draugr's Rest
    [102106] = { icon = 'esoui/art/icons/achievement_bossflavoreasy.dds', name = A.Set_Plague_Slinger, buff = false, debuff = false, ground = true }, -- Skeever Corpse
    [97908] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds', buff = true, debuff = false, ground = true }, -- Hagraven's Garden (Hagraven's)
    [67205] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds', buff = false, debuff = false, ground = true }, -- Leeching Plate (of Leeching)
    [84354] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', buff = false, debuff = false, ground = true }, -- Hand of Mephala (of Mephala's Hand)

    -- Trial Sets
    [107141] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vestment_of_olirime.dds', name = A.Set_Vestment_of_Olorime, buff = true, debuff = false, ground = false }, -- Vestment of Olirime (Olirime's)
    [109084] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vestment_of_olirime.dds', name = A.Set_Vestment_of_Olorime, buff = true, debuff = false, ground = false }, -- Ideal Vestment of Olirime (Olirime's Perfect)
    [107095] = { icon = 'LuiExtended/media/icons/abilities/ability_set_mantle_of_siroria.dds', buff = true, debuff = false, ground = false, }, -- Mantle of Siroria (Siroria's)
    [109081] = { icon = 'LuiExtended/media/icons/abilities/ability_set_mantle_of_siroria.dds', name = A.Set_Mantle_of_Siroria, buff = true, debuff = false, ground = false, }, -- Ideal Mantle of Siroria (Perfect Siroria's)

    ---------------------------
    -- Class Abilities --------
    ---------------------------

    -- Dragonknight
    [28988] = { buff = false, debuff = false, ground = true }, -- Dragonknight Standard (Dragonknight Standard)
    [32958] = { buff = false, debuff = false, ground = true, noRemove = true }, -- Shifting Standard (Shifting Standard)
    [32947] = { buff = false, debuff = false, ground = true }, -- Standard of Might (Standard of Might)
    [29059] = { buff = true, debuff = false, ground = false }, -- Ash Cloud (Ash Cloud)
    [20779] = { buff = true, debuff = false, ground = false }, -- Cinder Storm (Cinder Storm)
    [32710] = { buff = false, debuff = false, ground = true }, -- Eruption (Eruption)

    -- Nightblade
    [33195] = { buff = false, debuff = false, ground = true }, -- Path of Darkness (Path of Darkness)
    [36049] = { buff = false, debuff = false, ground = true }, -- Twisting Path (Twisting Path)
    [36028] = { buff = false, debuff = false, ground = true }, -- Refreshing Path (Refreshing Path)
    [38517] = { buff = true, debuff = false, ground = false }, -- Summon Shade (Summon Shade)
    [35438] = { name = A.Skill_Dark_Shade, buff = true, debuff = false, ground = false }, -- Dark Shade (Dark Shade)
    [38528] = { name = A.Skill_Shadow_Image, buff = true, debuff = false, ground = false }, -- Shadow (Shadow Image)
    [37475] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 2 }, -- Manifestation of Terror (Nightblade)
    [25411] = { buff = true, debuff = false, ground = false }, -- Consuming Darkness (Consuming Darkness)
    [36493] = { buff = true, debuff = false, ground = false }, -- Bolstering Darkness (Bolstering Darkness)
    [36485] = { buff = true, debuff = false, ground = false }, -- Veil of Blades (Veil of Blades)

    -- Sorcerer
    [24830] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3, icon = 'esoui/art/icons/ability_sorcerer_daedric_mines.dds' }, -- Daedric Mines (Daedric Mines)
    [24847] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3, icon = 'esoui/art/icons/ability_sorcerer_daedric_tomb.dds', name = A.Skill_Daedric_Tomb }, -- Daedric Mines (Daedric Tomb)
    [25158] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 5, icon = 'esoui/art/icons/ability_sorcerer_daedric_minefield.dds', name = A.Skill_Daedric_Minefield }, -- Daedric Mines (Daedric Minefield)
    [27706] = { buff = false, debuff = false, ground = true }, -- Negate Magic (Negate Magic)
    [28341] = { buff = false, debuff = false, ground = true }, -- Suppression Field (Suppression Field)
    [28348] = { buff = false, debuff = false, ground = true }, -- Absorption Field (Absorption Field)
    [23182] = { buff = false, debuff = false, ground = true }, -- Lightning Splash (Lightning Splash)
    [23200] = { buff = false, debuff = false, ground = true }, -- Liquid Lightning (Liquid Lightning)
    [23205] = { buff = false, debuff = false, ground = true }, -- Lightning Flood (Lightning Flood)

    -- Templar
    [95933] = { icon = 'esoui/art/icons/ability_templar_sun_strike.dds', buff = false, debuff = false, ground = true }, -- Spear Shards (Spear Shards)
    [95957] = { icon = 'esoui/art/icons/ability_templar_light_strike.dds', buff = false, debuff = false, ground = true }, -- Luminous Shards (Luminous Shards)
    [26880] = { icon = 'esoui/art/icons/ability_templarsun_thrust.dds', buff = false, debuff = false, ground = true }, -- Blazing Spear (Blazing Spear)
    [21976] = { buff = false, debuff = false, ground = true }, -- Nova (Nova)
    [22003] = { buff = false, debuff = false, ground = true }, -- Solar Prison (Solar Prison)
    [22001] = { buff = false, debuff = false, ground = true }, -- Solar Disturbance (Solar Disturbance)
    [80540] = { icon = 'esoui/art/icons/ability_templar_cleansing_ritual.dds', buff = true, debuff = false, ground = false }, -- Cleansing Ritual (Cleansing Ritual)
    [80547] = { icon = 'esoui/art/icons/ability_templar_purifying_ritual.dds', buff = true, debuff = false, ground = false }, -- Ritual of Retribution (Ritual of Retribution)
    [80553] = { icon = 'esoui/art/icons/ability_templar_extended_ritual.dds', buff = true, debuff = false, ground = false }, -- Extended Ritual (Extended Ritual)
    --[22234] = { buff = true, debuff = false, ground = false }, -- Rune Focus (Rune Focus)
    --[22240] = { buff = true, debuff = false, ground = false }, -- Channeled Focus (Channeled Focus)
    --[22237] = { buff = true, debuff = false, ground = false }, -- Restoring Focus (Restoring Focus)

    -- Warden Actives
    [86161] = { buff = false, debuff = false, ground = true }, -- Impaling Shards (Impaling Shards)
    [86165] = { buff = false, debuff = false, ground = true }, -- Gripping Shards (Gripping Shards)
    [86169] = { buff = false, debuff = false, ground = true }, -- Winter's Revenge (Winter's Revenge)
    [85578] = { buff = true, debuff = false, ground = false }, -- Healing Seed (Healing Seed)
    [85840] = { buff = true, debuff = false, ground = false }, -- Budding Seeds (Budding Seeds)
    [85845] = { buff = true, debuff = false, ground = false }, -- Corrupting Pollen (Corrupting Pollen)
    [85532] = { buff = true, debuff = false, ground = false }, -- Secluded Grove (Secluded Grove)
    [85804] = { buff = true, debuff = false, ground = false }, -- Enchanted Forest (Enchanted Forest)
    [85807] = { buff = true, debuff = false, ground = false }, -- Healing Thicket (Healing Thicket)
    [86175] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3 }, -- Frozen Gate (Frozen Gate)
    [86179] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3 }, -- Frozen Device (Frozen Device)
    [86183] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 3 }, -- Frozen Retreat (Frozen Retreat)

    ---------------------------
    -- Bow --------------------
    ---------------------------

    [28876] = { buff = false, debuff = false, ground = true }, -- Volley (Volley)
    [38689] = { buff = false, debuff = false, ground = true }, -- Endless Hail (Endless Hail)
    [38695] = { buff = false, debuff = false, ground = true }, -- Arrow Barrage (Arrow Barrage)
    [85458] = { buff = false, debuff = false, ground = true }, -- Ballista (Ballista)

    ---------------------------
    -- Destruction Staff ------
    ---------------------------

    [28807] = { buff = false, debuff = false, ground = true }, -- Wall of Fire (Wall of Elements)
    [28854] = { buff = false, debuff = false, ground = true }, -- Wall of Storms (Wall of Elements)
    [28849] = { buff = false, debuff = false, ground = true }, -- Wall of Frost (Wall of Elements)
    [39053] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Fire (Unstable Wall of Elements)
    [39073] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Storms (Unstable Wall of Elements)
    [39067] = { buff = false, debuff = false, ground = true }, -- Unstable Wall of Frost (Unstable Wall of Elements)
    [39012] = { buff = false, debuff = false, ground = true }, -- Blockade of Fire (Elemental Blockade)
    [39018] = { buff = false, debuff = false, ground = true }, -- Blockade of Storms (Elemental Blockade)
    [39028] = { buff = false, debuff = false, ground = true }, -- Blockade of Frost (Elemental Blockade)
    [83625] = { buff = false, debuff = false, ground = true }, -- Fire Storm (Elemental Storm)
    [83630] = { buff = false, debuff = false, ground = true }, -- Thunder Storm (Elemental Storm)
    [83628] = { buff = false, debuff = false, ground = true }, -- Ice Storm (Elemental Storm)
    [85126] = { buff = false, debuff = false, ground = true }, -- Fiery Rage (Elemental Rage)
    [85130] = { buff = false, debuff = false, ground = true }, -- Thunderous Rage (Elemental Rage)
    [85128] = { buff = false, debuff = false, ground = true }, -- Icy Rage (Elemental Rage)

    ---------------------------
    -- Restoration Staff ------
    ---------------------------

    [28385] = { buff = true, debuff = false, ground = false, noRemove = true }, -- Grand Healing (Grand Healing)
    [40058] = { buff = true, debuff = false, ground = false, noRemove = true }, -- Illustrious Healing (Illustrious Healing)
    [40060] = { buff = true, debuff = false, ground = false, noRemove = true }, -- Healing Springs (Healing Springs)

    ---------------------------
    -- Fighters Guild ---------
    ---------------------------

    [35737] = { buff = true, debuff = false, ground = false }, -- Circle of Protection (Circle of Protection)
    [40181] = { buff = true, debuff = false, ground = false }, -- Turn Undead (Turn Undead)
    [40169] = { buff = true, debuff = false, ground = false }, -- Ring of Preservation (Ring of Preservation)
    [35750] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Trap Beast (Trap Beast)
    [40382] = { buff = false, debuff = false, ground = true, stackAdd = 2, stackRemove = 2, stackReset = 2 }, -- Rearming Trap (Rearming Trap)
    [40388] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Rearming Trap (Rearming Trap)
    [40372] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Lightweight Beast Trap (Lightweight Beast Trap)

    ---------------------------
    -- Mages Guild ------------
    ---------------------------

    [31632] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Fire Rune (Fire Rune)
    [40470] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Volcanic Rune (Volcanic Rune)
    [40465] = { buff = false, debuff = false, ground = true, stackAdd = 1, stackRemove = 1, stackReset = 1 }, -- Scalding Rune (Scalding Rune)
    [63430] = { icon = 'esoui/art/icons/ability_mageguild_005.dds', buff = false, debuff = false, ground = true }, -- Meteor (Meteor)
    [63456] = { icon = 'esoui/art/icons/ability_mageguild_005_b.dds', buff = false, debuff = false, ground = true }, -- Ice Comet (Ice Comet)
    [63473] = { icon = 'esoui/art/icons/ability_mageguild_005_a.dds', buff = false, debuff = false, ground = true }, -- Shooting Star (Shooting Star)

    ---------------------------
    -- Undaunted --------------
    ---------------------------

    [39489] = { buff = true, debuff = false, ground = false }, -- Blood Altar (Blood Altar)
    [41967] = { buff = true, debuff = false, ground = false }, -- Sanguine Altar (Sanguine Altar)
    [41958] = { buff = true, debuff = false, ground = false }, -- Overflowing Altar (Overflowing Altar)
    [39425] = { buff = false, debuff = false, ground = true }, -- Trapping Webs (Trapping Webs)
    [41990] = { buff = false, debuff = false, ground = true }, -- Shadow Silk (Shadow Silk)
    [42012] = { buff = false, debuff = false, ground = true }, -- Tangling Webs (Tangling Webs)

    ---------------------------
    -- Assault ----------------
    ---------------------------

    [38549] = { icon = 'esoui/art/icons/ability_ava_001.dds', buff = false, debuff = false, ground = true }, -- Caltrops (Caltrops)
    [40265] = { icon = 'esoui/art/icons/ability_ava_001_a.dds', buff = false, debuff = false, ground = true }, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40251] = { icon = 'esoui/art/icons/ability_ava_001_b.dds', name = A.Skill_Razor_Caltrops, buff = false, debuff = false, ground = true }, -- Caltrops (Razor Caltrops)

    ---------------------------
    -- Support ----------------
    ---------------------------

    [38570] = { buff = true, debuff = false, ground = false }, -- Siege Shield (Siege Shield)
    [40229] = { buff = true, debuff = false, ground = false }, -- Siege Weapon Shield (Siege Weapon Shield)
    [40226] = { buff = true, debuff = false, ground = false }, -- Propelling Shield (Propelling Shield)
    [61522] = { name = A.Skill_Lingering_Flare, buff = false, debuff = false, ground = true }, -- Nova (Lingering Flare)
}

--------------------------------------------------------------------------------------------------------------------------------
-- This will create an effect on the player or target when X skill is detected as active. SCB creates the buff by the name listed here, this way if 3 or 4 effects all need to display for 1 ability, it will only show the one aura.
--------------------------------------------------------------------------------------------------------------------------------
E.EffectCreateSkillAura = {

    -- Required:
        -- abilityId = #
    -- Optional:
        --name = '' -- Add a custom name
        --icon = '' -- Add a custom icon
        -- alwaysShow = true -- Ignore the menu setting and always show this ability - Used for PVE abilities where we need to create additional information
        -- removeOnEnd = true -- Remove this aura when one of these effects ends.
        -- consolidate = true -- Also use this when consolidated auras is enabled.
        -- extendedDisplay = true -- This will only display if the option to display single effects is enabled as well.
        -- requiredStack = number -- Requires this number of stacks to apply

    -- Dragonknight
    [75088] = { removeOnEnd = true, consolidate = true, extendedDisplay = true, abilityId = 28969 }, -- Major Prophecy --> Inferno
    [76420] = { removeOnEnd = true, consolidate = true, abilityId = 61945 }, -- Major Prophecy --> Flames of Oblivion
    [76426] = { removeOnEnd = true, consolidate = true, abilityId = 61945 }, -- Major Savagery --> Flames of Oblivion
    [76433] = { removeOnEnd = true, consolidate = true, extendedDisplay = true, abilityId = 76429 }, -- Major Prophecy --> Cauterize
    [29011] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 29004 }, -- Major Fortitude --> Dragon Blood
    [32748] = { removeOnEnd = false, consolidate = true, abilityId = 32744 }, -- Major Endurance --> Green Dragon Blood
    [61884] = { removeOnEnd = false, consolidate = true, abilityId = 32744 }, -- Major Fortitude --> Green Dragon Blood
    [91670] = { removeOnEnd = false, consolidate = true, abilityId = 32744 }, -- Minor Vitality --> Green Dragon Blood
    [91674] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 32722 }, -- Major Fortitude --> Coagulating Blood
    [92507] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 29043 }, -- Major Sorcery --> Molten Weapons
    [76518] = { removeOnEnd = false, consolidate = true, abilityId = 31874 }, -- Major Brutality --> Igneous Weapons
    [92503] = { removeOnEnd = false, consolidate = true, abilityId = 31874 }, -- Major Sorcery --> Igneous Weapons
    [31818] = { removeOnEnd = false, consolidate = true, abilityId = 31816 }, -- Minor Resolve (Stone Giant)
    [108801] = { removeOnEnd = false, consolidate = true, abilityId = 31816 }, -- Minor Ward (Stone Giant)

    -- Nightblade
    [90587] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 33375 }, -- Major Evasion --> Blur
    [90593] = { removeOnEnd = false, consolidate = true, abilityId = 35414 }, -- Major Evasion --> Mirage
    [61817] = { removeOnEnd = false, consolidate = true, abilityId = 35414 }, -- Minor Resolve --> Mirage
    [68512] = { removeOnEnd = false, consolidate = true, abilityId = 35414 }, -- Minor Ward --> Mirage
    [90620] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 35419 }, -- Major Evasion --> Double Take
    [33317] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 33316  }, --> Major Brutality --> Drain Power
    [36903] = { removeOnEnd = false, consolidate = true, extendedDisplay = true, abilityId = 36901 }, --> Major Brutality --> Power Extraction
    [36894] = { removeOnEnd = false, consolidate = true, abilityId = 36891 }, -- Major Brutality --> Sap Essence
    [62240] = { removeOnEnd = false, consolidate = true, abilityId = 36891 }, -- Major Sorcery --> Sap Essence

    -- Templar
    [26213] = { removeOnEnd = true, consolidate = true, abilityId = 26209 }, -- Minor Fortitude (Restoring Aura)
    [26216] = { removeOnEnd = true, consolidate = true, abilityId = 26209 }, -- Minor Intellect (Restoring Aura)
    [26215] = { removeOnEnd = true, consolidate = true, abilityId = 26209 }, -- Minor Endurance (Restoring Aura)
    [22236] = { consolidate = true, abilityId = 22234 }, -- Major Resolve (Rune Focus)
    [44820] = { consolidate = true, abilityId = 22234 }, -- Major Ward (Rune Focus)

    -- Warden
    [86267] = { consolidate = true, abilityId = 86037 }, -- Major Expedition --> Falcon's Swiftness
    [86268] = { consolidate = true, abilityId = 86037 }, -- Major Endurance --> Falcon's Swiftness
    [89076] = { consolidate = true, abilityId = 86041 }, -- Major Expedition --> Deceptive Predator
    [89077] = { consolidate = true, abilityId = 86041 }, -- Major Endurance --> Deceptive Predator
    [89078] = { consolidate = true, abilityId = 86045 }, -- Major Expedition --> Bird of Prey
    [89079] = { consolidate = true, abilityId = 86045 }, -- Major Endurance --> Bird of Prey
    [86300] = { consolidate = true, abilityId = 85862 }, -- Minor Intellect (Enchanted Growth)
    [87019] = { consolidate = true, abilityId = 85862 }, -- Minor Endurance (Enchanted Growth)
    [86224] = { consolidate = true, abilityId = 86122 }, -- Major Resolve --> Frost Cloak
    [86225] = { consolidate = true, abilityId = 86122 }, -- Major Ward --> Frost Cloak
    [88758] = { consolidate = true, abilityId = 86126 }, -- Major Resolve --> Expansive Frost Cloak
    [88759] = { consolidate = true, abilityId = 86126 }, -- Major Ward --> Expansive Frost Cloak
    [88761] = { consolidate = true, abilityId = 86130 }, -- Major Resolve --> Ice Fortress
    [88762] = { consolidate = true, abilityId = 86130 }, -- Major Ward --> Ice Fortress
    [87194] = { consolidate = true, abilityId = 86130 }, -- Minor Protection --> Ice Fortress

    -- Dual Wield
    [28613] = { alwaysShow = true, removeOnEnd = true, abilityId = 999001 }, -- Blade Cloak (Blade Cloak) -- Fake ID for Major Evasion
    [38901] = { alwaysShow = true, removeOnEnd = true, abilityId = 999002 }, -- Quick Cloak (Quick Cloak) -- Fake ID for Major Evasion
    [38906] = { alwaysShow = true, removeOnEnd = true, abilityId = 999003 }, -- Deadly Cloak (Deadly Cloak) -- Fake ID for Major Evasion
    [68807] = { consolidate = true, extendedDisplay = true, abilityId = 21157 }, -- Major Brutality (Hidden Blade)
    [68859] = { consolidate = true, extendedDisplay = true, abilityId = 38914 }, -- Major Brutality (Shrouded Daggers)
    [68814] = { consolidate = true, extendedDisplay = true, abilityId = 38910 }, -- Major Brutality (Flying Blade)

    -- Destruction Staff
    [53881] = { removeOnEnd = true, abilityId = 29173 }, -- Major Breach --> Weakness to Elements
    [62775] = { removeOnEnd = true, abilityId = 39089 }, -- Major Breach (Elemental Susceptibility)
    [62787] = { removeOnEnd = true, abilityId = 39095 }, -- Major Breach (Elemental Drain)
    [39100] = { removeOnEnd = true, abilityId = 39095 }, -- Minor Magickasteal (Elemental Drain)

    -- Restoration Staff
    [37247] = { consolidate = true, abilityId = 37243 }, -- Minor Resolve (Blessing of Protection)
    [62619] = { consolidate = true, abilityId = 37243 }, -- Minor Ward (Blessing of Protection)
    [62626] = { consolidate = true, abilityId = 40103, name = A.Skill_Blessing_of_Restoration }, -- Minor Resolve (Blessing of Restoration)
    [62627] = { consolidate = true, abilityId = 40103, name = A.Skill_Blessing_of_Restoration }, -- Minor Ward (Blessing of Restoration)
    [62634] = { consolidate = true, abilityId = 40094 }, -- Minor Resolve (Combat Prayer)
    [62635] = { consolidate = true, abilityId = 40094 }, -- Minor Ward (Combat Prayer)
    [62636] = { consolidate = true, abilityId = 40094 }, -- Minor Berserk (Combat Prayer)
    [88565] = { removeOnEnd = true, abilityId = 31531 }, -- Minor Lifesteal (Force Siphon)
    [88575] = { removeOnEnd = true, abilityId = 40109 }, -- Minor Lifesteal (Siphon Spirit)
    [88576] = { removeOnEnd = true, abilityId = 40109 }, -- Minor Lifesteal (Siphon Spirit)
    [88606] = { removeOnEnd = true, abilityId = 40116 }, -- Minor Lifesteal (Quick Siphon)

    -- Armor
    [63015] = { consolidate = true, extendedDisplay = true, abilityId = 29556 }, -- Major Evasion --> Evasion
    [63019] = { consolidate = true, extendedDisplay = true, abilityId = 39195 }, -- Major Evasion --> Shuffle
    [63030] = { consolidate = true, extendedDisplay = true, abilityId = 39192 }, -- Major Evasion --> Elude
    [63084] = { consolidate = true, abilityId = 29552 }, -- Major Resolve --> Immovable
    [63085] = { consolidate = true, abilityId = 29552 }, -- Major Ward --> Immovable
    [63134] = { consolidate = true, abilityId = 39205 }, -- Major Resolve --> Immovable Brute
    [63135] = { consolidate = true, abilityId = 39205 }, -- Major Ward --> Immovable Brute
    [63119] = { consolidate = true, abilityId = 39197 }, -- Major Resolve --> Unstoppable
    [63120] = { consolidate = true, abilityId = 39197 }, -- Major Ward --> Unstoppable

    -- Fighters Guild
    [64509] = { consolidate = true, extendedDisplay = true, removeOnEnd = true, abilityId = 999004 }, -- Major Savagery --> Expert Hunter

    -- Mages Guild
    [77928] = { consolidate = true, extendedDisplay = true, removeOnEnd = true, abilityId = 999005 }, -- Major Prophecy --> Magelight
    [77945] = { consolidate = true, extendedDisplay = true, removeOnEnd = true, abilityId = 999006 }, -- Major Prophecy --> Inner Light
    [77958] = { consolidate = true, extendedDisplay = true, removeOnEnd = true, abilityId = 999007 }, -- Major Prophecy --> Radiant Magelight
    [40443] = { consolidate = true, abilityId = 40441 }, -- Balance --> Major Ward
    [80160] = { consolidate = true, abilityId = 40441 }, -- Balance --> Major Resolve

    -- Psijic Order
    [103521] = { consolidate = true, extendedDisplay = true, abilityId = 103503 }, -- Minor Force --> Accelerate
    [103708] = { consolidate = true, extendedDisplay = true, abilityId = 103706 }, -- Minor Force --> Channeled Acceleration
    [103712] = { consolidate = true, extendedDisplay = true, abilityId = 103710 }, -- Minor Force --> Race Against Time

    -- Assault
    [57472] = { alwaysShow = true, removeOnEnd = true, abilityId = 38566 }, -- Major Gallop (Rapid Maneuver)
    [57477] = { alwaysShow = true, removeOnEnd = true, abilityId = 40211 }, -- Major Gallop (Retreating Maneuver)
    [57481] = { alwaysShow = true, removeOnEnd = true, abilityId = 40215 }, -- Major Gallop (Charging Maneuver)

    -- Sets
    [106867] = { alwaysShow = true, abilityId = 106865 }, -- Major Evasion --> Grace of Gloom
    [116742] = { alwaysShow = true, abilityId = 116775, requiredStack = 10 }, -- Precision --> Minor Force (Tzogvin's Warband)

    -- NPC's
    -- Always Show = show regardless of menu setting
    [65235] = { alwaysShow = true, removeOnEnd = true, abilityId = 33097 }, -- Enrage (Vosh Rakh Devoted)
    [50187] = { alwaysShow = true, removeOnEnd = true, abilityId = 33097 }, -- Enrage (Mantikora)
    [56689] = { alwaysShow = true, removeOnEnd = true, abilityId = 33097 }, -- Enraged (Mantikora)
    [72725] = { alwaysShow = true, removeOnEnd = true, abilityId = 28301 }, -- Fool Me Once (Sentinel) (TG DLC)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Function called in CombatInfo to toggle a few options for some potentially useful skills. Called by CombatInfo when changing menu settings for Bar Highlight Overrides.
--------------------------------------------------------------------------------------------------------------------------------
function E.BarHighlightRefresh()
    if LUIE.CombatInfo.SV.ShowToggledSecondary then
        -- Dragonknight
        E.BarHighlightOverride[31816] = { newId = 31818, showFakeAura = true, secondary = true, noRemove = true } -- Stone Giant --> Minor Resolve

        -- Nightblade
        E.BarHighlightOverride[25255] = { newId = 25256, secondary = true } -- Veiled Strike --> Off Balance
        E.BarHighlightOverride[25267] = { newId = 34737, secondary = true } -- Concealed Weapon --> Off Balance

        -- Templar
        E.BarHighlightOverride[26792] = { duration = 8000, showFakeAura = true, secondary = true, noRemove = true } -- Biting Jabs --> Major Savagery
        E.BarHighlightOverride[22144] = { newId = 55214 } -- Empowering Sweep --> Major Protection

        -- Restoration Staff
        E.BarHighlightOverride[85132] = { newId = 85154, showFakeAura = true, secondary = true, noRemove = true } -- Light's Champion --> Major Force

        -- Werewolf
        E.BarHighlightOverride[39113] = { newId = 45834, secondary = true } -- Ferocious Roar --> Off Balance
        E.BarHighlightOverride[39114] = { newId = 111788, secondary = true } -- Deafening Roar --> Major Fracture

        -- Mages Guild
        E.BarHighlightOverride[28567] = { newId = 63223, showFakeAura = true, secondary = true, noRemove = true } -- Entropy --> Major Sorcery
        E.BarHighlightOverride[40457] = { newId = 63227, showFakeAura = true, secondary = true, noRemove = true } -- Degeneration --> Major Sorcery
        E.BarHighlightOverride[40452] = { newId = 63231, showFakeAura = true, secondary = true, noRemove = true } -- Structured Entropy --> Major Sorcery
    else
        -- Dragonknight
        E.BarHighlightOverride[31816] = { newId = 31817} -- Stone Giant

        -- Nightblade
        E.BarHighlightOverride[25255] = { newId = 33185 } -- Veiled Strike
        E.BarHighlightOverride[25267] = { newId = 34736 } -- Concealed Weapon

        -- Templar
        E.BarHighlightOverride[26792] = { newId = 76912, duration = 2000, showFakeAura = true, noRemove = true } -- Biting Jabs
        E.BarHighlightOverride[22144] = { newId = 62599 } -- Empowering Sweep

        -- Restoration Staff
        E.BarHighlightOverride[85132] = nil -- Light's Champion

        -- Werewolf
        E.BarHighlightOverride[39113] = nil -- Ferocious Roar
        E.BarHighlightOverride[39114] = nil -- Deafening Roar

        -- Mages Guild
        E.BarHighlightOverride[28567] = nil -- Entropy
        E.BarHighlightOverride[40457] = nil -- Degeneration
        E.BarHighlightOverride[40452] = nil -- Structured Entropy
    end
end

--------------------------------------------------------------------------------------------------------------------------------
-- Replaces the tracking ID on an ability bar ability with a different id for the purpose of tracking effect duration on Bar Highlight tracker.
--------------------------------------------------------------------------------------------------------------------------------
E.BarHighlightOverride = {

    -- Optional
        -- newId = # -- Replace ID
        -- showFakeAura = true -- USE EVENT_COMBAT_EVENT instead - allows auras to display even if they weren't applied. Should be used with major/minor effects.
        -- secondary = true -- If the menu option for Secondary effects set to false, hide this ID
        -- noRemove = ture -- don't remove effect on fading -- Doesn't apply to hostile effects. Should be used with major/minor effects.
        -- duration = # -- override duration
        -- emulateGround = true -- Don't remove this highlight on target change
        -- hide = true -- Hide this bar highlight

    ---------------------------
    -- Dragonknight -----------
    ---------------------------

    -- Ardent Flame
    [23806] = { newId = 23808, secondary = true }, -- Lava Whip --> Off Balance
    [20805] = { newId = 20806, secondary = true }, -- Molten Whip --> Off Balance
    [20816] = { newId = 34117, secondary = true }, -- Flame Lash --> Off Balance
    [20657] = { newId = 44363 }, -- Searing Strike
    [20668] = { newId = 44369 }, -- Venomous Claw
    [20660] = { newId = 44373 }, -- Burning Embers
    [20917] = { newId = 31102 }, -- Fiery Breath
    [20944] = { newId = 31103 }, -- Noxious Breath
    [20930] = { newId = 31104 }, -- Engulfing Flames
    [20492] = { newId = 76498, showFakeAura = true, secondary = true, noRemove = true }, -- Fiery Grip --> Major Expedition (Note doesn't refresh when longer duration Major Expedition is present)
    [20499] = { newId = 76506, showFakeAura = true, secondary = true, noRemove = true }, -- Empowering Chains --> Major Expedition (Note doesn't refresh when longer duration Major Expedition is present)
    [20496] = { newId = 76502, showFakeAura = true, secondary = true, noRemove = true }, -- Unrelenting Grip --> Major Expedition (Note doesn't refresh when longer duration Major Expedition is present)
    [32963] = { newId = 32958 }, -- Shifting Standard

    -- Draconic Power
    [20245] = { newId = 20527 }, -- Dark Talons
    [20252] = { newId = 31898 }, -- Burning Talons
    [20251] = { newId = 20528 }, -- Choking Talons
    [29004] = { showFakeAura = true, noRemove = true }, -- Dragon Blood
    [32744] = { showFakeAura = true, noRemove = true }, -- Green Dragon Blood
    [32722] = { showFakeAura = true, noRemove = true }, -- Coagulating Blood
    [31837] = { newId = 31841, showFakeAura = true }, -- Inhale
    [32792] = { newId = 32796, showFakeAura = true }, -- Deep Breath
    [32785] = { newId = 32788, showFakeAura = true }, -- Draw Essence
    [29012] = { newId = 114590 }, -- Dragon Leap --> Stun
    [32719] = { newId = 114600 }, -- Take Flight --> Stun
    [32715] = { newId = 61814 }, -- Ferocious Leap

    -- Earthen Heart
    [29032] = { newId = 29034}, -- Stonefist
    [31820] = { newId = 31821}, -- Obsidian Shard
    [31816] = { newId = 31817}, -- Stone Giant
    [29043] = { newId = 92507, showFakeAura = true, noRemove = true }, -- Molten Weapons --> Major Sorcery
    [31874] = { newId = 92503, showFakeAura = true, noRemove = true }, -- Igneous Weapons --> Major Sorcery
    [31888] = { newId = 76537 }, -- Molten Armaments

    ---------------------------
    -- Nightblade -------------
    ---------------------------

    -- Assassination
    [18342] = { newId = 25887 }, -- Teleport Strike
    [25493] = { newId = 35336 }, -- Lotus Fan
    [25484] = { newId = 25959 }, -- Ambush
    [33375] = { newId = 90587, showFakeAura = true, noRemove = true }, -- Blur --> Major Evasion
    [35414] = { newId = 90593, showFakeAura = true, noRemove = true }, -- Mirage --> Major Evasion
    [35419] = { newId = 90620, showFakeAura = true, noRemove = true }, -- Double Take --> Major Evasion
    [61907] = { newId = 61902 }, -- Grim Focus --> Assassin's Will
    [61932] = { newId = 61927 }, -- Relentless Focus --> Assassin's Scourge
    [61930] = { newId = 61919 }, -- Merciless Resolve --> Assassin's Will
    [33398] = { newId = 61389 }, -- Death Stroke --> Damage Taken Increased
    [36508] = { newId = 61393 }, -- Incapacitating Strike --> Damage Taken Increased
    [36514] = { newId = 61400} , -- Soul Harvest --> Damage Taken Increased

    -- Shadow
    [25255] = { newId = 33185 }, -- Veiled Strike
    [25260] = { newId = 34734 }, -- Surprise Attack
    [25267] = { newId = 34736 }, -- Concealed Weapon
    [25375] = { newId = 25376 }, -- Shadow Cloak
    [25380] = { newId = 25381 }, -- Shadowy Disguise
    --[25352] = { }, -- Aspect of Terror -- TODO: Disabled because API won't return correct duration for Fear
    --[37470] = { }, -- Mass Hysteria -- TODO: Disabled because API won't return correct duration for Fear
    [37475] = { newId = 76639 }, -- Manifestation of Terror
    [33211] = { newId = 38517 }, -- Summon Shade
    [35434] = { newId = 35438 }, -- Dark Shade --> Summon Shade
    [35441] = { newId = 38528 }, -- Shadow Image --> Shadow
    [35445] = { newId = 38528 }, -- Shadow Image Teleport --> Shadow

    -- Siphoning
    [33291] = { newId = 33292 }, -- Strife
    [34838] = { newId = 34840 }, -- Funnel Health
    [34835] = { newId = 34836 }, -- Swallow Soul
    [33308] = { newId = 108925, secondary = true, noRemove = true }, -- Malevolent Offering
    [34721] = { newId = 108927, secondary = true, noRemove = true }, -- Shrewd Offering
    [34727] = { newId = 108932, secondary = true, noRemove = true }, -- Healthy Offering
    [33326] = { newId = 33329 }, -- Cripple
    [36943] = { newId = 36950 }, -- Debilitate
    [36957] = { newId = 36965 }, -- Crippling Grasp
    [33316] = { newId = 33317, showFakeAura = true, noRemove = true }, -- Drain Power --> Major Brutality
    [36901] = { newId = 36903, showFakeAura = true, noRemove = true }, -- Power Extraction --> Major Brutality
    [36891] = { newId = 36894, showFakeAura = true, noRemove = true }, -- Sap Essence --> Major Brutality
    [25091] = { newId = 25093 }, -- Soul Shred

    ---------------------------
    -- Sorcerer ---------------
    ---------------------------

    -- Dark Magic
    [46331] = { newId = 46332 }, -- Crystal Blast
    [24371] = { newId = 24559 }, -- Rune Prison
    [24578] = { newId = 24581 }, -- Rune Cage
    [24584] = { newId = 114903 }, -- Dark Exchange
    [24595] = { newId = 114908 }, -- Dark Deal
    [24589] = { newId = 114909 }, -- Dark Conversion
    [24828] = { newId = 24830 }, -- Daedric Mines
    [24842] = { newId = 24847 }, -- Daedric Tomb --> Daedric Mines
    [24834] = { newId = 25158 }, -- Daedric Minefield --> Daedric Mines

    -- Daedric Summoning
    [108840] = { newId = 108843 }, -- Summon Unstable Familiar --> Volatile Familiar
    [77182] = { newId = 88933 }, -- Summon Volatile Familiar --> Volatile Familiar
    [24330] = { newId = 89491 }, -- Haunting Curse
    [77140] = { newId = 88937 }, -- Summon Twilight Tormentor --> Twilight Tormentor
    [23634] = { newId = 80459 }, -- Summon Storm Atronach
    [23492] = { newId = 80463 }, -- Greater Storm Atronach
    [23495] = { newId = 80468 }, -- Summon Charged Atronach

    -- Storm Calling
    [18718] = { newId = 18746 }, -- Mages' Fury
    [19123] = { newId = 19125 }, -- Mages' Wrath
    [19109] = { newId = 19118 }, -- Endless Fury
    [23234] = { newId = 23235 }, -- Bolt Escape
    [23236] = { newId = 28482 }, -- Streak
    [23277] = { newId = 23278 }, -- Ball of Lightning

    ---------------------------
    -- Templar ----------------
    ---------------------------

    -- Aedric Spear
    [26114] = { newId = 76908, duration = 2000, showFakeAura = true, noRemove = true }, -- Puncturing Strikes
    [26792] = { newId = 76912, duration = 2000, showFakeAura = true, noRemove = true }, -- Biting Jabs
    [26797] = { newId = 76916, duration = 2000, showFakeAura = true, noRemove = true }, -- Puncturing Sweep
    [26158] = { newId = 37409 }, -- Piercing Javelin
    [26800] = { newId = 37414 }, -- Aurora Javelin
    [26804] = { newId = 32099 }, -- Binding Javelin
    [22149] = { newId = 49205 }, -- Focused Charge
    [22161] = { newId = 49213 }, -- Explosive Charge
    [15540] = { newId = 15546 }, -- Toppling Charge
    [26188] = { newId = 95933 }, -- Spear Shards (Spear Shards)
    [26858] = { newId = 95957 }, -- Luminous Shards (Luminous Shards)
    [26869] = { newId = 26880 }, -- Blazing Spear (Blazing Spear)
    [22178] = { newId = 22179 }, -- Sun Shield
    [22182] = { newId = 22183 }, -- Radiant Ward
    [22180] = { newId = 49091 }, -- Blazing Shield
    [22138] = { newId = 62593 }, -- Radial Sweep
    [22144] = { newId = 62599 }, -- Empowering Sweep
    [22139] = { newId = 62607 }, -- Crescent Sweep

    -- Dawn's Wrath
    [21726] = { newId = 21728 }, -- Sun Fire
    [21729] = { newId = 21731 }, -- Vampire's Bane
    [21732] = { newId = 21734 }, -- Reflective Light (Reflective Light)
    [22057] = { newId = 109418, secondary = true }, -- Solar Flare --> Empower
    [22110] = { newId = 24686 }, -- Dark Flare
    [21752] = { newId = 21976 }, -- Nova (Nova)
    [21755] = { newId = 22003 }, -- Solar Prison (Solar Prison)
    [21758] = { newId = 22001 }, -- Solar Disturbance (Solar Disturbance)

    -- Restoring Light
    [22253] = { newId = 35632, secondary = true }, -- Honor the Dead
    [22314] = { newId = 108935, secondary = true, showFakeAura = true, noRemove = true }, -- Hasty Prayer --> Minor Expedition
    [26209] = { newId = 26220 }, -- Restoring Aura
    [26807] = { newId = 26809 }, -- Radiant Aura
    [22265] = { newId = 80540 }, -- Cleansing Ritual (Cleansing Ritual)
    [22259] = { newId = 80547 }, -- Ritual of Retribution (Ritual of Retribution)
    [22262] = { newId = 80553 }, -- Extended Ritual (Extended Ritual)

    [22234] = { showFakeAura = true, emulateGround = true }, -- Rune Focus --> Major Resolve
    [22240] = { showFakeAura = true, emulateGround = true }, -- Channeled Focus
    [22237] = { showFakeAura = true, emulateGround = true }, -- Restoring Focus

    [22223] = { showFakeAura = true }, -- Rite of Passage
    [22229] = { showFakeAura = true }, -- Remembrance
    [22226] = { showFakeAura = true }, -- Practiced Incantation

    ---------------------------
    -- Warden -----------------
    ---------------------------

    -- Animal Companions
    [86023] = { newId = 101703 }, -- Swarm
    [86027] = { newId = 101904 }, -- Fetcher Infection
    [86031] = { newId = 101944 }, -- Growing Swarm
    [86037] = { showFakeAura = true, noRemove = true }, -- Falcon's Swiftness
    [86041] = { showFakeAura = true, noRemove = true }, -- Deceptive Predator
    [86045] = { showFakeAura = true, noRemove = true }, -- Bird of Prey

    -- Green Balance
    [85862] = { newId = 87019, showFakeAura = true, noRemove = true }, -- Enchanted Growth
    [85922] = { newId = 85840 }, -- Budding Seeds
    [85564] = { newId = 90266 }, -- Nature's Grasp
    [85858] = { newId = 87074 }, -- Nature's Embrace

    -- Winter's Embrace
    [86122] = { newId = 86224, showFakeAura = true, noRemove = true }, -- Frost Cloak --> Major Resolve
    [86126] = { newId = 88758, showFakeAura = true, noRemove = true }, -- Expansive Frost Cloak --> Major Resolve
    [86130] = { newId = 88761, showFakeAura = true, noRemove = true }, -- Ice Fortress --> Major Resolve
    [86148] = { newId = 90833 }, -- Arctic Wind
    [86152] = { newId = 90835 }, -- Polar Wind
    [86156] = { newId = 90834 }, -- Arctic Blast

    ---------------------------
    -- Two Handed -------------
    ---------------------------

    [38814] = { newId = 38816 }, -- Dizzying Swing
    [38788] = { newId = 38791 }, -- Stampede
    [20919] = { newId = 31059 }, -- Cleave --> Cleave Bleed
    [38745] = { newId = 38747 }, -- Carve --> Carve Bleed
    [38754] = { newId = 38759 }, -- Brawler --> Brawler Bleed
    [83216] = { newId = 83217 }, -- Berserker Strike
    [83229] = { newId = 83230 }, -- Onslaught
    [83238] = { newId = 83239 }, -- Berserker Rage

    ---------------------------
    -- One Hand and Shield ----
    ---------------------------

    [28306] = { newId = 28307, showFakeAura = true }, -- Puncture --> Major Fracture
    [38256] = { newId = 62474, showFakeAura = true }, -- Ransack --> Major Fracture
    [38250] = { newId = 62484, showFakeAura = true }, -- Pierce Armor --> Major Fracture
    [28304] = { newId = 29308, showFakeAura = true }, -- Low Slash --> Minor Maim
    [38268] = { newId = 62495, showFakeAura = true }, -- Deep Slash --> Minor Maim
    [38264] = { newId = 62504, showFakeAura = true }, -- Heroic Slash --> Minor Maim
    [28719] = { newId = 28720 }, -- Shield Charge
    [38401] = { newId = 38404 }, -- Shielded Assault
    [38405] = { newId = 38407 }, -- Invasion
    [28365] = { newId = 83433 }, -- Power Bash
    [38455] = { newId = 38838, showFakeAura = true }, -- Reverberating Bash --> Major Defile
    [38452] = { newId = 80625 }, -- Power Slam

    ---------------------------
    -- Dual Wield -------------
    ---------------------------

    [28379] = { newId = 29293 }, -- Twin Slashes --> Twin Slashes Bleed
    [38839] = { newId = 38841 }, -- Rending Slashes --> Rending Slashes Bleed
    [38845] = { newId = 38852 }, -- Blood Craze
    [38891] = { newId = 68801, showFakeAura = true, noRemove = true }, -- Whirling Blades --> Major Endurance
    [21157] = { newId = 68807, showFakeAura = true, noRemove = true }, -- Hidden Blade --> Major Brutality
    [38914] = { newId = 68859, showFakeAura = true, noRemove = true }, -- Shrouded Daggers --> Major Brutality
    [38910] = { newId = 68814, showFakeAura = true, noRemove = true }, -- Flying Blade --> Major Brutality
    [83600] = { newId = 85156 }, -- Lacerate
    [85187] = { newId = 85192 }, -- Rend
    [85179] = { newId = 85184 }, -- Thrive in Chaos

    ---------------------------
    -- Bow --------------------
    ---------------------------

    [38685] = { newId = 38686, showFakeAura = true }, -- Lethal Arrow --> Major Defile
    [38687] = { newId = 38699 }, -- Focused Aim
    [28879] = { newId = 28887 }, -- Scatter Shot
    [38672] = { newId = 38674 }, -- Magnum Shot
    [38669] = { newId = 38670 }, -- Draining Shot
    [31271] = { newId = 31272 }, -- Arrow Spray
    [38705] = { newId = 38707 }, -- Bombard
    [38701] = { newId = 38703 }, -- Acid Spray
    [28869] = { newId = 44540 }, -- Poison Arrow
    [38645] = { newId = 44545 }, -- Venom Arrow
    [38660] = { newId = 44549 }, -- Poison Injection
    [85257] = { newId = 85261 }, -- Toxic Barrage
    [85451] = { newId = 85458 }, -- Ballista

    ---------------------------
    -- Destruction Staff ------
    ---------------------------

    [46348] = { newId = 48011 }, -- Crushing Shock --> Uber Attack
    [29073] = { newId = 62648 }, -- Flame Touch (Destructive Touch)
    [29089] = { newId = 62722 }, -- Shock Touch (Destructive Touch)
    [29078] = { newId = 62692 }, -- Frost Touch (Destructive Touch)
    [38985] = { newId = 62668 }, -- Flame Clench (Destructive Clench)
    [38993] = { newId = 62733 }, -- Shock Clench (Destructive Clench)
    [38989] = { newId = 62702 }, -- Frost Clench (Destructive Clench)
    [38944] = { newId = 62682 }, -- Flame Reach (Destructive Reach)
    [38978] = { newId = 62745 }, -- Shock Reach (Destructive Reach)
    [38970] = { newId = 62712 }, -- Frost Reach (Destructive Reach)
    [29173] = { newId = 53881 }, -- Weakness to Elements (Weakness to Elements)
    [39089] = { newId = 62775 }, -- Elemental Susceptibility (Elemental Susceptibility)
    [39095] = { newId = 62787 }, -- Elemental Drain (Elemental Drain)
    [39162] = { newId = 39168 }, -- Flame Pulsar --> Minor Mangle
    [39167] = { newId = 39181 }, -- Storm Pulsar --> Minor Mangle
    [39163] = { newId = 39180 }, -- Frost Pulsar --> Minor Mangle

    ---------------------------
    -- Restoration Staff ------
    ---------------------------

    [28385] = { noRemove = true }, -- Grand Healing (Grand Healing)
    [40058] = { noRemove = true }, -- Illustrious Healing (Illustrious Healing)
    [40060] = { noRemove = true }, -- Healing Springs (Healing Springs)

    [37243] = { showFakeAura = true, noRemove = true }, -- Blessing of Protection (Blessing of Protection)
    [40103] = { showFakeAura = true, noRemove = true }, -- Blessing of Restoration (Blessing of Restoration)
    [40094] = { showFakeAura = true, noRemove = true }, -- Combat Prayer (Combat Prayer)
    [31531] = { newId = 88565 }, -- Force Siphon (Force Siphon)
    [40109] = { newId = 88575 }, -- Siphon Spirit (Siphon Spirit)
    [40116] = { newId = 88606 }, -- Quick Siphon (Quick Siphon)

    ---------------------------
    -- Armor ------------------
    ---------------------------

    [29556] = { newId = 63015, showFakeAura = true, noRemove = true }, -- Evasion --> Major Evasion
    [39195] = { newId = 63019, showFakeAura = true, noRemove = true }, -- Shuffle  --> Major Evasion
    [39192] = { newId = 63030, showFakeAura = true, noRemove = true }, -- Elude --> Major Evasion
    [29552] = { showFakeAura = true, noRemove = true }, -- Immovable
    [39205] = { showFakeAura = true, noRemove = true }, -- Immovable Brute
    [39197] = { showFakeAura = true, noRemove = true }, -- Unstoppable

    ---------------------------
    -- Vampire ----------------
    ---------------------------

    [32893] = { newId = 68883 }, -- Drain Essence -- TODO: For some reason these won't show up unless the ID is switched, they don't get added to the table at all
    [38949] = { newId = 68892 }, -- Invigorating Drain -- TODO: For some reason these won't show up unless the ID is switched, they don't get added to the table at all
    [38956] = { newId = 81493 }, -- Accelerating Drain -- TODO: For some reason these won't show up unless the ID is switched, they don't get added to the table at all
    [88158] = { newId = 38932 }, -- Materialize --> Clouding Swarm

    ---------------------------
    -- Werewolf ---------------
    ---------------------------

    [58317] = { newId = 58318 }, -- Hircine's Rage
    [58855] = { newId = 58856 }, -- Infectious Claws --> Infection
    [58864] = { newId = 58865 }, -- Claws of Anguish --> Infection
    [58879] = { newId = 58880 }, -- Claws of Life --> Infection

    ---------------------------
    -- Fighters Guild ---------
    ---------------------------

    [35721] = { newId = 35736 }, -- Silver Bolts
    [40300] = { newId = 40302 }, -- Silver Shards
    [40336] = { newId = 40340 }, -- Silver Leash
    [35750] = { newId = 68595, showFakeAura = true }, -- Trap Beast (Trap Beast)
    [40382] = { newId = 68632, showFakeAura = true }, -- Rearming Trap (Rearming Trap)
    [40372] = { newId = 68628, showFakeAura = true }, -- Lightweight Beast Trap (Lightweight Beast Trap)
    [35713] = { newId = 62305 }, -- Dawnbreaker (Dawnbreaker)
    [40161] = { newId = 62310 }, -- Flawless Dawnbreaker (Flawless Dawnbreaker)
    [40158] = { newId = 62314 }, -- Dawnbreaker of Smiting (Dawnbreaker of Smiting)

    ---------------------------
    -- Mages Guild ------------
    ---------------------------

    [31642] = { newId = 48131, secondary = true }, -- Equilibrium
    [40445] = { newId = 40449, showFakeAura = true }, -- Spell Symmetry (Spell Symmetry)
    [40441] = { newId = 40443, showFakeAura = true, noRemove = true }, -- Balance --> Major Ward
    [16536] = { newId = 63430 }, -- Meteor
    [40489] = { newId = 63456 }, -- Ice Comet
    [40493] = { newId = 63473 }, -- Shooting Star

    ---------------------------
    -- Psijic Order -----------
    ---------------------------

    [103488] = { newId = 104050 }, -- Time Stop
    [104059] = { newId = 104078 }, -- Borrowed Time
    [104079] = { newId = 104085 }, -- Time Freeze
    [103503] = { newId = 103521, showFakeAura = true, noRemove = true }, -- Accelerate --> Minor Force
    [103706] = { newId = 103708, showFakeAura = true, noRemove = true }, -- Channeled Acceleration --> Minor Force
    [103710] = { newId = 103712, showFakeAura = true, noRemove = true }, -- Race Against Time --> Minor Force
    [103543] = { hide = true }, -- Mend Wounds
    [103747] = { hide = true }, -- Mend Spirit
    [103755] = { hide = true }, -- Symbiosis

    ---------------------------
    -- Undaunted --------------
    ---------------------------

    [39475] = { newId = 41942, showFakeAura = true }, -- Inner Fire
    [42056] = { newId = 42059, showFakeAura = true }, -- Inner Rage
    [42060] = { newId = 42062, showFakeAura = true }, -- Inner Beast
    --[39298] = { hide = true }, -- Necrotic Orb
    --[42028] = { hide = true }, -- Mystic Orb
    --[42038] = { hide = true }, -- Energy Orb

    ---------------------------
    -- Assault ----------------
    ---------------------------

    [38566] = { newId = 57472 }, -- Rapid Maneuver --> Major Gallop
    [40211] = { newId = 57477 }, -- Retreating Maneuver --> Major Gallop
    [40215] = { newId = 57481 }, -- Charging Maneuver --> Major Gallop
    [61503] = { newId = 61504 }, -- Vigor
    [61505] = { newId = 61506 }, -- Echoing Vigor
    [61507] = { newId = 61509 }, -- Resolving Vigor
    [33376] = { newId = 38549 }, -- Caltrops
    [40255] = { newId = 40265 }, -- Anti-Cavalry Caltrops
    [40242] = { newId = 40251 }, -- Razor Caltrops --> Caltrops
    [38563] = { newId = 38564 }, -- War Horn
    [40223] = { newId = 40224 }, -- Aggressive Horn
    [40220] = { newId = 40221 }, -- Sturdy Horn

    ---------------------------
    -- Support ----------------
    ---------------------------

    [61489] = { newId = 61496 }, -- Revealing Flare
    [61519] = { newId = 61522 }, -- Lingering Flare --> Nova
    [61524] = { newId = 61528 }, -- Scorching Flare
    [40237] = { newId = 40238 }, -- Reviving Barrier --> Reviving Barrier Heal

}

--------------------------------------------------------------------------------------------------------------------------------
-- Data for icon & description to show for the fake Disguise buff applied to the player.
--------------------------------------------------------------------------------------------------------------------------------
E.DisguiseIcons = {

    -- Required:
        -- icon = '' -- Icon to use
        -- description = '' -- String to use for description when equipped (used by Chat Announcements)
        -- id = # -- Ability id to pull a tooltip description from

    [2571]  = { icon = 'LuiExtended/media/icons/disguises/disguise_midnight_union_disguise.dds', description = 'as a Midnight Union thief.', id = 35607 },
    [27266] = { icon = 'LuiExtended/media/icons/disguises/disguise_vanguard_uniform.dds', description = 'as a soldier in Tanval\'s Vanguard.', id = 50177 },
    [29536] = { icon = 'LuiExtended/media/icons/disguises/disguise_stormfist_disguise.dds', description = 'as a Stormfist soldier.', id = 19086 },
    [40283] = { icon = 'LuiExtended/media/icons/disguises/disguise_keepers_garb.dds', description = 'as a Keeper of the Shell.', id = 31118 },
    [40286] = { icon = 'LuiExtended/media/icons/disguises/disguise_seadrake_disguise.dds', description = 'as a Seadrake pirate.', id =  27457 },
    [40294] = { icon = 'LuiExtended/media/icons/disguises/disguise_pirate_disguise.dds', description = 'as a Blackheart Haven pirate.', id = 29986 },
    [40296] = { icon = 'LuiExtended/media/icons/disguises/disguise_red_rook_disguise.dds', description = 'as a Red Rook bandit.', id = 28076 },
    [42413] = { icon = 'LuiExtended/media/icons/disguises/disguise_colovian_uniform.dds', description = 'as a Colovian soldier.', id =  31766 },
    [42736] = { icon = 'LuiExtended/media/icons/disguises/disguise_servants_robes.dds', description = 'as a servant of Headman Bhosek.', id = 32045 },
    [43046] = { icon = 'LuiExtended/media/icons/disguises/disguise_forebear_dishdasha.dds', description = 'as a member of the Forebears.', id = 33220 },
    [43047] = { icon = 'LuiExtended/media/icons/disguises/disguise_crown_dishdasha.dds', description = 'as a member of the Crowns.', id = 33221 },
    [43508] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'in a Seaside Sanctuary disguise.', id = nil }, -- NO ICON (Probably doesn't exist)
    [43511] = { icon = 'LuiExtended/media/icons/disguises/disguise_sea_viper_armor.dds', description = 'as a Maormer soldier.', id = 33534 }, -- NO ICON
    [43515] = { icon = 'LuiExtended/media/icons/disguises/disguise_imperial_disguise.dds', description = 'as an Imperial soldier.', id = 34267 },
    [44448] = { icon = 'LuiExtended/media/icons/disguises/disguise_frostedge_bandit_disguise.dds', description = 'as a Frostedge bandit.', id = 38167 },
    [44580] = { icon = 'LuiExtended/media/icons/disguises/disguise_hollow_moon_garb.dds', description = 'as a member of the Hollow Moon.', id = nil },
    [44587] = { icon = 'LuiExtended/media/icons/disguises/disguise_northwind_disguise.dds', description = 'as a Stonetalon clan member.', id = 38878 },
    [44697] = { icon = 'LuiExtended/media/icons/disguises/disguise_hallins_stand_seventh_legion_disguise.dds', description = 'as a member of the Seventh Legion.', id = 39295 },
    [45006] = { icon = 'LuiExtended/media/icons/disguises/disguise_phaer_mercenary_disguise.dds', description = 'as a Phaer Mercenary.', id = 43716 },
    [45007] = { icon = 'LuiExtended/media/icons/disguises/disguise_quendeluun_veiled_heritance_disguise.dds', description = 'as a member of the invading Ebonheart Pact forces.', id = 43719 },
    [45008] = { icon = 'LuiExtended/media/icons/disguises/disguise_vulkhel_guard_marine_disguise.dds', description = 'as a First Auridon Marine.', id = 43722 },
    [45781] = { icon = 'LuiExtended/media/icons/disguises/disguise_kollopi_essence.dds', description = 'by the Kollopi Essence.', id = 30879 },
    [45803] = { icon = 'LuiExtended/media/icons/disguises/disguise_bloodthorn_disguise.dds', description = 'as a Bloodthorn Cultist.', id = 46281 },
    [54332] = { icon = 'LuiExtended/media/icons/disguises/disguise_fort_amol_guard_disguise.dds', description = 'as a Fort Amol guard.', id = 47574 },
    [54380] = { icon = 'LuiExtended/media/icons/disguises/disguise_steel_shrike_uniform.dds', description = 'as a member of the Steel Shrikes.', id = 19013 },
    [54483] = { icon = 'LuiExtended/media/icons/disguises/disguise_courier_uniform.dds', description = 'as a Gold Coast mercenary courier.', id = 48429 },
    [54994] = { icon = 'LuiExtended/media/icons/disguises/disguise_shadowsilk_gem.dds', description = 'as a Shadowsilk Goblin.', id = 51906 },
    [55014] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a member of Wolfbane Watch.', id = nil }, -- (Not sure it exists)
    [64260] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'in colorful Dark Elf clothing.', id = nil }, -- NO ICON (Not sure it exists)
    [71090] = { icon = 'LuiExtended/media/icons/disguises/disguise_servants_outfit.dds', description = 'as a servant of the Iron Wheel.', id = 27649 }, -- TODO: Check this ID is right
    [71541] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Castle Kvatch sentinel.', id = nil }, -- NO ICON (Not sure it exists)
    [71789] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Castle Kvatch sentinel.', id = nil }, -- NO ICON (Not sure it exists)
    --[79332] = { icon = 'LuiExtended/media/icons/disguises/disguise_monks_disguise.dds', description = 'as a monk.' }, -- HAS AN AURA SO NOT NECESSARY (Note - we make an exception to HIDE this itemId to prevent errors)
    [79505] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'as a Sentinel Guard.', id = nil }, -- NO ICON (Not sure it exists)
    [94209] = { icon = 'LuiExtended/media/icons/disguises/disguise_scarlet_judges_regalia.dds', description = 'as The Scarlet Judge.', id = 85204 },
    -- TODO: Are we missing Dunmer Cultural Garb?
    [0] = { icon = 'LuiExtended/media/icons/disguises/disguise_generic.dds', description = 'by the Earring of Disguise.', id = nil }, -- Generic Disguise override - at least the Arenthia quest in Reaper's March applies a disguise without utilizing an item -- TODO -- check others
}

--------------------------------------------------------------------------------------------------------------------------------
-- Icon to display for Assistant Collectibles
--------------------------------------------------------------------------------------------------------------------------------
E.AssistantIcons = {
    [GetCollectibleName(301)] = 'LuiExtended/media/icons/abilities/ability_innate_assistant_nuzhimeh.dds',
    [GetCollectibleName(300)] = 'LuiExtended/media/icons/abilities/ability_innate_assistant_pirharri.dds',
    [GetCollectibleName(267)] = 'LuiExtended/media/icons/abilities/ability_innate_assistant_tythis.dds',
}

--------------------------------------------------------------------------------------------------------------------------------
-- When a target name matches a string here, add id's in the table with the name and icon specified. We use this primarily to add CC Immunity buffs for bosses.
--------------------------------------------------------------------------------------------------------------------------------
E.AddNameAura = {

    -- World Bosses
    ['Norendo'] = { [1] = { id = 33097 } }, -- Auridon (Soulfire Plateau)
    ['Eraman'] = { [1] = { id = 33097 } }, -- Auridon (Soulfire Plateau)
    ['Quendia'] = { [1] = { id = 33097 } }, -- Auridon (Soulfire Plateau)
    ['Quenyas'] = { [1] = { id = 33097 } }, -- Auridon (Seaside Scarp Camp)
    ['Captain Blanchete'] = { [1] = { id = 33097 } }, -- Auridon (Wreck of the Raptor)
    ['Snapjaw'] = { [1] = { id = 33097 } }, -- Auridon (Heretic's Summons)
    ['The Nestmother'] = { [1] = { id = 33097 } }, -- Auridon (Nestmothers Den)
    ['Anarume'] = { [1] = { id = 33097 } }, -- Auridon (Heritance Proving Ground)

    ['Bavura the Blizzard'] = { [1] = { id = 33097 } }, -- Grahtwood (Nindaeril's Perch)
    ['Nindaeril the Monsoon'] = { [1] = { id = 33097 } }, -- Grahtwood (Nindaeril's Perch)
    ['Shagura'] = { [1] = { id = 33097 } }, -- Grahtwood (Hircine's Henge)
    ['Gurgozu'] = { [1] = { id = 33097 } }, -- Grahtwood (Hircine's Henge)
    ['Valanir\'s Shield'] = { [1] = { id = 33097 } }, -- Grahtwood (Valanir's Rest)
    ['Lady Solace'] = { [1] = { id = 33097 } }, -- Grahtwood (Lady Solace's Fen)
    ['Otho Rufinus'] = { [1] = { id = 33097 } }, -- Grahtwood (Poacher Camp)
    ['Thugrub the Reformed'] = { [1] = { id = 33097 } }, -- Grahtwood (Thugrub's Cave)

    ['Gathongor the Mauler'] = { [1] = { id = 33097 } }, -- Greenshade (Gathongor's Mine)
    ['Smiles-With-Knife'] = { [1] = { id = 33097 } }, -- Greenshade (Reconnaissance Camp)
    ['Maheelius'] = { [1] = { id = 33097 } }, -- Greenshade (Reconnaissance Camp)
    ['Navlos'] = { [1] = { id = 33097 } }, -- Greenshade (Reconnaissance Camp)
    ['Heart of Rootwater'] = { [1] = { id = 33097 } }, -- Greenshade (Rootwater Spring)
    ['Thodundor of the Hill'] = { [1] = { id = 33097 } }, -- Greenshade (Thodundor's View)
    ['Neiral'] = { [1] = { id = 33097 } }, -- Greenshade (Maormer Camp View)
    ['Hetsha'] = { [1] = { id = 33097 } }, -- Greenshade (Maormer Camp View)
    ['Jahlasri'] = { [1] = { id = 33097 } }, -- Greenshade (Maormer Camp View)


    -- Public Dungeon
    ['Nitch'] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    ['Thek Elf-Stabber'] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    ['Black Bessie'] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    ['Bloodroot'] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    ['Togga the Skewerer'] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    ['Dzeizik'] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    ['Slakkith'] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)
    ['Gorg'] = { [1] = { id = 33097 } }, -- Auridon (Toothmaul Gully)

    ['Great Thorn'] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)
    ['The Devil Wrathmaw'] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)
    ['Rootbiter'] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)
    ['Silent Claw'] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)
    ['Thick-Bark'] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)
    ['Guardian of Root Sunder'] = { [1] = { id = 33097 } }, -- Grahtwood (Root Sunder Ruins)

    ['Lost Master'] = { [1] = { id = 33097 } }, -- Greenshade (Rulanyil's Fall)
    ['Utiasl'] = { [1] = { id = 33097 } }, -- Greenshade (Rulanyil's Fall)
    ['Skirar the Decaying'] = { [1] = { id = 33097 } }, -- Greenshade (Rulanyil's Fall)
    ['Magna Tharn'] = { [1] = { id = 33097 } }, -- Greenshade (Rulanyil's Fall)
    ['Hannat the Bonebringer'] = { [1] = { id = 33097 } }, -- Greenshade (Rulanyil's Fall)

    -- MSQ
    ['Ragjar'] = { [1] = { id = 33097 } },
    ['Manifestation of Regret'] = { [1] = { id = 33097 } },
    ['Ancient Clannfear'] = { [1] = { id = 33097 } },
    ['Manifestation of Terror'] = { [1] = { id = 33097 } },
    ['Mannimarco'] = { [1] = { id = 33097 } },

    -- Mages Guild
    ['Uncle Leo'] = { [1] = { id = 33097 } },
    ['Haskill'] = { [1] = { id = 33097 } },

    -- Aldmeri Dominion
    ['High Kinlady Estre'] = { [1] = { id = 33097 } },
    ['Mayor Aulus'] = { [1] = { id = 33097 } },
    ['Prince Naemon'] = { [1] = { id = 33097 } },
    ['Vicereeve Pelidil'] = { [1] = { id = 33097 } },

    -- Dolmen Bosses
    ['Dread Xivkyn Cauterizer'] = { [1] = { id = 33097 } },
    ['Dread Xivkyn Dreadweaver'] = { [1] = { id = 33097 } },
    ['Dread Xivkyn Voidstalker'] = { [1] = { id = 33097 } },
    ['Dread Xivkyn Chillfiend'] = { [1] = { id = 33097 } },
    ['Dread Xivkyn Banelord'] = { [1] = { id = 33097 } },
    ['Vika'] = { [1] = { id = 33097 } },
    ['Dylora'] = { [1] = { id = 33097 } },
    ['Jansa'] = { [1] = { id = 33097 } },
    ['Medrike'] = { [1] = { id = 33097 } },
    ['Anaxes'] = { [1] = { id = 33097 } },

    -- NPC's
    ['Flame Atronach'] = { [1] = { id = 4891 } },
    ['Frost Atronach'] = { [1] = { id = 33549 } },
    ['Ice Barrier'] = { [1] = { id = 33097 } },
    --['Aura of Protection'] = { [1] = { id = 33097 } }, -- TODO: Not actually CC immune despite CC not doing anything (maybe switch to knockback immunity eventually)
    --['Ice Pillar'] = { [1] = { id = 33097 } }, -- TODO: Not actually CC immune despite CC not doing anything (maybe switch to knockback immunity eventually)

    -- Bosses
    ['War Chief Ozozai'] = { [1] = { id = 33097 } },
    ['Broodbirther'] = { [1] = { id = 33097 } },
    ['Mad Griskild'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- A Web of Troubles
    ['Veya Releth'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell - Family Reunion
    ['Old Rust-Eye'] = { [1] = { id = 33097 } }, -- Delve -- Vvardenfell - Khartag Point
    ['Cliff Strider Matriarch'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Beckoner Morvayn'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Confessor Dradas'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Coaxer Veran'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Castigator Athin'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Stone-Boiler Omalas'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Brander Releth'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Mountain-Caller Hlaren'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Wakener Maras'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Nevena Nirith'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON - Vvardenfell - The Forgotten Wastes
    ['Mud-Tusk'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Guardian of Bthark'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Renduril the Hammer'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Friar Hadelar'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Steamreaver'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Artisan Lenarmen'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Nchulaeon the Eternal'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Nilarion the Cavalier'] = { [1] = { id = 33097 } }, -- PUBLIC DUNGEON -- Vvardenfell - Nchuleftingth
    ['Curate Erydno'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Inquires
    ['Savarak Fels'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Reclamining Vos
    ['Th\'krak the Tunnel-King'] = { [1] = { id = 33097 } }, -- Delve -- Vvardenfell -- Matus-Akin Egg Mine
    ['Slavemaster Arenim'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- The Heart of a Telvanni
    ['Chodala'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Intervention
    ['Clockwork Guardian'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Jovval Mortal-Bane'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Defense Core'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Mediator'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Mediator Core'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Clockwork Assembly Core'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration
    ['Barbas'] = { [1] = { id = 33097 } }, -- Quest -- Vvardenfell -- Divine Restoration

    --------------------------------------------
    -- DUNGEONS --------------------------------
    --------------------------------------------

    -- Banished Cells I
    ['Cell Haunter'] = { [1] = { id = 33097 } }, -- Cell Haunter
    ['Shadowrend'] = { [1] = { id = 33097 } }, -- Shadowrend
    ['Angata the Clannfear Handler'] = { [1] = { id = 33097 } }, -- Angata the Clannfear Handler
    ['High Kinlord Rilis'] = { [1] = { id = 33097 } }, -- High Kinlord Rilis

    -- Banished Cells II
    ['Keeper Areldur'] = { [1] = { id = 33097 } }, -- Keeper Areldur
    ['Maw of the Infernal'] = { [1] = { id = 33097 } }, -- Maw of the Infernal
    ['Keeper Voranil'] = { [1] = { id = 33097 } }, -- Keeper Voranil
    ['Keeper Imiril'] = { [1] = { id = 33097 } }, -- Keeper Imiril

    -- Elden Hollow I
    ['Ancient Spriggan'] = { [1] = { id = 33097 } }, -- Ancient Spriggan
    ['Akash gra-Mal'] = { [1] = { id = 33097 } }, -- Akash gra-Mal
    ['Chokethorn']  = { [1] = { id = 33097 } }, -- Chokethorn
    ['Nenesh gro-Mal']  = { [1] = { id = 33097 } }, -- Nenesh gro-Mal
    ['Leafseether']  = { [1] = { id = 33097 } }, -- Leafseether
    ['Canonreeve Oraneth']  = { [1] = { id = 33097 } }, -- Canonreeve Oraneth

    -- Elden Hollow II
    ['Dubroze the Infestor'] = { [1] = { id = 33097 } }, -- Dubroze the Infestor
    [U.Boss_Dark_Root] = { [1] = { id = 33097 } }, -- Dark Root

    -- Frostvault
    ['Coldsnap Ogre'] = { [1] = { id = 33097 } }, -- Coldsnap Ogre
    ['Icestalker'] = { [1] = { id = 33097 } }, -- Icestalker

}




--------------------------------------------------------------------------------------------------------------------------------
-- Synergy Icon Overrides - When a synergy with a matching ability name appears, change the icon or name.
--------------------------------------------------------------------------------------------------------------------------------
E.SynergyNameOverride = {
    ['Tonal Inverter'] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_tonal_inverter.dds' }, -- Tonal Inverter (Divine Intervention)
    [A.Skill_Blade_of_Woe] = { icon = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_blade_of_woe.dds' }, -- Blade of Woe (Dark Brotherhood)
    [A.Skill_Black_Widows] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds' }, -- Black Widows (Undaunted)
    [A.Skill_Arachnophobia] = { icon = 'esoui/art/icons/ability_undaunted_003_b.dds' }, -- Arachnophobia (Undaunted)
    [A.Skill_Feed] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds' }, -- Feed (Vampire)
    [A.Skill_Devour] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }, -- Devour (Werewolf)
    [A.Set_Shield_of_Ursus] = { icon = 'LuiExtended/media/icons/abilities/ability_set_haven_of_ursus.dds', name = A.Set_Ursus_Blessing }, -- Ursus's Blessing (Haven of Ursus)
}

--------------------------------------------------------------------------------------------------------------------------------
-- When a bar ability proc with a matching id appears, change the icon.
--------------------------------------------------------------------------------------------------------------------------------
E.BarIdOverride = {

    -- Dragonknight
    [20824] = 'LuiExtended/media/icons/abilities/ability_dragonknight_power_lash.dds', -- Power Lash (Flame Lash)

    -- Nightblade
    [61907] = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds', -- Assassin's Will (Grim Focus)
    [61932] = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds', -- Assassin's Scourge (Relentless Focus)
    [61930] = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds', -- Assassin's Will (Merciless Resolve)
    [35445] = 'LuiExtended/media/icons/abilities/ability_nightblade_shadow_image_teleport.dds', -- Shadow Image Teleport (Shadow Image)

    -- Sorcerer
    [108840] = 'esoui/art/icons/ability_sorcerer_unstable_fimiliar_summoned.dds', -- Summon Unstable Familiar (Summon Unstable Familiar)
    [108845] = 'esoui/art/icons/ability_sorcerer_lightning_prey_summoned.dds', -- Winged Twilight Restore (Summon Winged Twilight)

    -- Support
    [78338] = 'esoui/art/icons/ability_ava_guard.dds', -- Guard (Guard)
    [81415] = 'esoui/art/icons/ability_ava_mystic_guard.dds', -- Mystic Guard (Mystic Guard)
    [81420] = 'esoui/art/icons/ability_ava_stalwart_guard.dds', -- Stalwart Guard (Stalwart Guard)

}

--------------------------------------------------------------------------------------------------------------------------------
-- When a bar ability proc with a matching id appears, display the toggle highlight
--------------------------------------------------------------------------------------------------------------------------------
E.IsAbilityActiveHighlight = {

    -- Support
    [78338] = true, -- Guard (Guard)
    [81415] = true, -- Mystic Guard (Mystic Guard)
    [81420] = true, -- Stalwart Guard (Stalwart Guard)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Table of effects to adjust only based off a specific target - this allows us to override the name/icon or hide an effect only when the source is a specific NPC. Used to change icons for attacks with the same id coming from different types of animals, etc...
--------------------------------------------------------------------------------------------------------------------------------
E.EffectOverrideByName = {
    -- TUTORIAL
    [1718] =    { -- Attack (CH + Vvardenfell Tutorial)
                    ['Naryu Virian'] =              { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attacklight.dds' } -- Attack (Tutorial)
                },

    -- HUMAN NPCS
    [29521] =   { -- Aura of Protection (Shaman)
                    ['Aura of Protection'] =        { hide = true } -- Aura of Protection (Aura of Protection) -- Hides this buff only on the Goblin Aura of Protection to prevent duplicate display
                },

    [86704] =   { -- Chop (Peasant)
                    ['Hleran Noble'] =              { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_dagger_light.dds' }, -- Chop (Hleran Noble)
                },
    [86705] =   { -- Lop (Peasant)
                    ['Hleran Noble'] =              { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_dagger_light.dds' }, -- Lop (Hleran Noble)\
                },

    [88251] =   {
                    ['Great Bear'] =                { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_bear.dds' }, -- Call Ally (Pet Ranger)
                    ['Spider'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_tiger.dds' }, -- Call Ally (Pet Ranger)
                },

    [88248] =   {
                    ['Spider'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
                    ['Venomspit Spider'] =          { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
                    ['Websnare Spider'] =           { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_spider.dds' }, -- Call Ally (Pet Ranger)
                },

    -- ANIMALS
    [7170] =    { -- Rend (Lion)
                    ['Lion'] =                      { icon = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds' }, -- Rend (Lion)
                    ['Lioness'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
                    ['Sabre Cat'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_rend.dds' }, -- Rend (Sabre Cat)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Nindaeril the Monsoon'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['The Tiger'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Spectral Senche-Tiger'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Esh\'tabe'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Raakhet'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Razorclaw'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                },
    [60630] =   { -- Rend (Lion)
                    ['Lion'] =                      { icon = 'LuiExtended/media/icons/abilities/ability_lion_rend.dds' }, -- Rend (Lion)
                    ['Lioness'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
                    ['Sabre Cat'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_rend.dds' }, -- Rend (Sabre Cat)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Nindaeril the Monsoon'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['The Tiger'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Spectral Senche-Tiger'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Esh\'tabe'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Raakhet'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                    ['Razorclaw'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_rend.dds' }, -- Rend (Senche-Tiger)
                },
    [60641] =   { -- Claw (Lion)
                    ['Sabre Cat'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_claw.dds' }, -- Claw (Sabre Cat)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['Nindaeril the Monsoon'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['The Tiger'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['Spectral Senche-Tiger'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['Esh\'tabe'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['Raakhet'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                    ['Razorclaw'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_claw.dds' }, -- Claw (Senche-Tiger)
                },
    [7158] =    { -- Bite (Lion)
                    ['Lion'] =                      { icon = 'LuiExtended/media/icons/abilities/ability_lion_bite.dds' }, -- Bite (Lion)
                    ['Lioness'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_lioness_bite.dds' }, -- Bite (Lion)
                    ['Sabre Cat'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_bite.dds' }, -- Bite (Sabre Cat)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['Nindaeril the Monsoon'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['The Tiger'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['Spectral Senche-Tiger'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['Esh\'tabe'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['Raakhet'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                    ['Razorclaw'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_bite.dds' }, -- Bite (Senche-Tiger)
                },
    [7161] =    { -- Double Strike (Lion)
                    ['Sabre Cat'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_sabrecat_double_strike.dds' }, -- Double Strike (Sabre Cat)
                    ['Senche-Tiger'] =              { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['Nindaeril the Monsoon'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['The Tiger'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['Spectral Senche-Tiger'] =     { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['Esh\'tabe'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['Raakhet'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                    ['Razorclaw'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_senche_double_strike.dds' }, -- Double Strike (Senche-Tiger)
                },
    [5362] =    { -- Slam (Skeever / Kagouti)
                    ['Kagouti'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_slam.dds' }, -- Slam (Kagouti)
                    ['Bull Kagouti'] =              { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_slam.dds' }, -- Slam (Kagouti)

                    ['Daedrat'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_daedrat_slam.dds' }, -- Slam (Daedrat)
                },
    [21904] =   { -- Rend (Skeever)
                    ['Daedrat'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_daedrat_rend.dds' }, -- Rend (Daedrat)
                },
    [4022] =    { -- Bite (Wolf)
                    ['Jackal'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_jackal_bite.dds' }, -- Bite (Jackal)
                },
    [42844] =   { -- Rotbone (Wolf)
                    ['Jackal'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_jackal_rotbone.dds' }, -- Rotbone (Wolf)
                },
    [14523] =   { -- Helljoint (Wolf)
                    ['Jackal'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_jackal_helljoint.dds' }, -- Helljoint (Wolf)
                },
    [75818] =   { -- Helljoint (Wolf)
                    ['Jackal'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_jackal_helljoint.dds' }, -- Helljoint (Wolf)
                },
    [8569] =    { -- Devastating Leap (Bloodfiend)
                    ['Skaafin Miscreal'] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_devastating_leap.dds' }, -- Devastating Leap (Skaafin Miscreal)
                    ['Skeleton'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_devastating_leap.dds' }, -- Devastating Leap (Skeleton)
                },
    [8550] =    { -- Slash (Bloodfiend)
                    ['Skeleton'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Skeleton)
                    ['Bone Flayer'] =               { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Bone Flayer)
                    ['Risen Dead'] =                { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Risen Dead)
                    ['Skaafin Wretch'] =            { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Wretch)
                    ['Skaafin Miscreal'] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Miscreal)
                },
    [8551] =    { -- Slash (Bloodfiend)
                    ['Skeleton'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Skeleton)
                    ['Bone Flayer'] =               { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Bone Flayer)
                    ['Risen Dead'] =                { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_slash.dds' }, -- Slash (Risen Dead)
                    ['Skaafin Wretch'] =            { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Wretch)
                    ['Skaafin Miscreal'] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_slash.dds' }, -- Slash (Skaafin Miscreal)
                },
    [8564] =    { -- Rending Slash (Bloodfiend)
                    ['Skeleton'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Rending Slash (Skeleton)
                    ['Bone Flayer'] =               { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Rending Slash (Bone Flayer)
                    ['Skaafin Wretch'] =            { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_rending_slash.dds' }, -- Rending Slash (Skaafin Wretch)
                    ['Skaafin Miscreal'] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_rending_slash.dds' }, -- Rending Slash (Skaafin Miscreal)
                },
    [9194] =    { -- Flurry (Bloodfiend)
                    ['Skeleton'] =                  { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Skeleton)
                    ['Bone Flayer'] =               { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_flurry.dds' }, -- Flurry (Bone Flayer)
                    ['Skaafin Wretch'] =            { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_flurry.dds' }, -- Flurry (Skaafin Wretch)
                    ['Skaafin Miscreal'] =          { icon = 'LuiExtended/media/icons/abilities/ability_skaafin_flurry.dds' }, -- Flurry (Skaafin Miscreal)
                },

    -- MONSTERS
    [9670] =    {
                    ['Spectral Lamia'] =            { icon = 'LuiExtended/media/icons/abilities/ability_lamia_strike_spectral.dds' }, -- Strike (Lamia)
                },

    [89119] =   {
                    ['Dire Wolf'] =                 { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_wolf.dds' }, -- Summon Beast (Spriggan)
                    ['Websnare Spider'] =           { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_spider.dds' }, -- Summon Beast (Spriggan)
                    ['Spider'] =                    { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_spider.dds' }, -- Summon Beast (Spriggan)
                    ['Venomspit Spider'] =          { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_spider.dds' }, -- Summon Beast (Spriggan)
                },
    [89102] =   {
                    ['Thunderbug'] =                { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_thunderbug.dds' }, -- Summon Beast (Spriggan)
                    ['Thunderbug Lord'] =           { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_thunderbug.dds' }, -- Summon Beast (Spriggan)
                    ['Hoarvor'] =                   { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_hoarvor.dds' }, -- Summon Beast (Spriggan)
                },

    -- QUESTS
    [37021] =   {
                    ['Auroran Battlemage'] =        { icon = 'LuiExtended/media/icons/abilities/ability_mage_empower_weapon_flame_sword.dds' }, -- Empower Weapon: Flame (Auroran Battlemage)
                },
    [37028] =   {
                    ['Auroran Battlemage'] =        { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', name = A.Skill_Quick_Strike }, -- Quick Strike (Auroran Battlemage)
                },
    [37029] =   {
                    ['Auroran Battlemage'] =        { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', name = A.Skill_Quick_Strike }, -- Quick Strike (Auroran Battlemage)
                },
    [37030] =   {
                    ['Auroran Battlemage'] =        { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', name = A.Skill_Quick_Strike }, -- Quick Strike (Auroran Battlemage)
                },

    -- GENERIC
    [44176] =   { -- Flying Immunities
                   ['Cell Haunter'] = { hide = true }, -- Cell Haunter
                   ['The Feast'] = { hide = true }, -- The Feast
                },
}

--------------------------------------------------------------------------------------------------------------------------------
-- Override source name - when one of these abilities hits change the source to match this name. Used for death recap to rename odd trap or source names for damage.
--------------------------------------------------------------------------------------------------------------------------------
E.EffectSourceOverride = {

    -- PLAYER ABILITIES
    [71678] = { pet = 'Morkuldin' }, -- Light Attack {Morkuldin} -- TODO: Localize
    [71679] = { pet = 'Morkuldin' }, -- Cleave {Morkuldin} -- TODO: Localize

    -- BATTLEGROUNDS

    -- TRAPS
    [62769] = { source = A.Trap_Cold_Fire_Trap }, -- Coldharbour Flames {MQ Tutorial}
    [62770] = { source = A.Trap_Cold_Fire_Trap }, -- Coldharbour Flames {MQ Tutorial}
    [17314] = { source = A.Trap_Fire_Trap }, -- Fire Trap (Fire Trap)

    [72888] = { source = A.Trap_Fire_Trap }, -- Fire Attack 1 (Fire) -- Banished Cells II
    [72889] = { source = A.Trap_Fire_Trap }, -- Fire Attack 2 (Fire) -- Banished Cells II

    -- TRAPS (Go back over these)
    [92150] = {source = 'Dwarven Furnace'}, -- Fire Trap {Vvardenfell}
    [89481] = {source = 'Flame Jet Trap'}, -- Flame Jet {Vvardenfell}
    [88491] = {source = 'Flame Jet Trap'}, -- Searing Flame {Vvardenfell}
    [88411] = {source = 'Hammer Trap'}, -- Hammer {Vvardenfell}
    [88405] = {source = 'Hammer Trap'}, -- Hammer {Vvardenfell}
    [89663] = {source = 'Hammer Trap'}, -- Hammer {Vvardenfell}
    [89664] = {source = 'Hammer Trap'}, -- Hammer {Vvardenfell}
    [88404] = {source = 'Blade Trap'}, -- Blade {Vvardenfell}
    [88454] = {source = 'Blade Trap'}, -- Blade {Vvardenfell}
    [88455] = {source = 'Blade Trap'}, -- Blade {Vvardenfell}
    [91659] = {source = A.Trap_Falling_Rocks}, -- Falling Rocks {Vvardenfell}
    [92672] = {source = 'Red Mountain'}, -- Pyroclast  {Vvardenfell}
    [84527] = {source = 'Steam Vent'}, -- Searing Steam {Vvardenfell}

    -----------------------------------------------
    -- VVARDENFELL
    -----------------------------------------------

    -- Main Quest
    [88467] = {source = 'Baar Dau'}, -- Skyfall {Divine Disaster}
    [87102] = {source = 'Spinning Blade Trap'}, -- Spinning Blade {Divine Restoration}
    [91969] = {source = 'Spinning Blade Trap'}, -- Spinning Blade {Divine Restoration}
    [86743] = {source = 'Vapor Cloud'}, -- Accelerated Transposition {Like Blood from a Stone}

    -- Sidequests
    [89282] = {source = 'Exploding Spider'}, -- Spider Explosion {A Web of Trouble}
}

--------------------------------------------------------------------------------------------------------------------------------
-- If one of these ability Names is applied then we set the buffSlot for ON_EFFECT_CHANGED to be a single name identifier to prevent more than one aura from appearing. Only works with unlimited duration or equal duration effects.
--------------------------------------------------------------------------------------------------------------------------------
E.EffectMergeName = {

    [A.Skill_Overcharge] = "MERGED_EFFECT_OVERCHARGE",
	[A.Skill_Minor_Slayer] = "MERGED_EFFECT_SLAYER",
	[A.Skill_Minor_Aegis] = "MERGED_EFFECT_AEGIS",
    [A.Skill_Boulder_Toss] = "MERGED_EFFECT_BOULDER_TOSS",

}

--------------------------------------------------------------------------------------------------------------------------------
-- If one of these id's is applied then we set the buffSlot for ON_EFFECT_CHANGED to be a single name identifier to prevent more than one aura from appearing. Only works with unlimited duration or equal duration effects.
--------------------------------------------------------------------------------------------------------------------------------
E.EffectMergeId = {

    [21314] = "MERGED_EFFECT_SPIKE_TRAP_QUEST", -- Trap Sprung! (Auridon - An Act of Kindness)
    [47768] = "MERGED_EFFECT_CC_IMMUNITY_QUEST", -- RobS Immunities 6 Sec (Grahtwood - A Lasting Winter)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Hide this ID from appearing in any way on Combat Cloud Text - Useful for spammy ids.
--------------------------------------------------------------------------------------------------------------------------------
E.EffectHideSCT = {

    -- Player - Basic
    [20301] = true, -- Crouch Drain
    [15356] = true, -- Sprint Drain
    [55400] = true, -- Magicka Restore
    [55401] = true, -- Magicka Restore
    [45982] = true, -- Bash Stun

    -- Player - Champion Points
    [64245] = true, -- Shadowstrike

    -- Player - Weapons
    [18429] = true, -- Heavy Attack (Unarmed)
    [16041] = true, -- Heavy Attack (2H)
    [15279] = true, -- Heavy Attack (1H)
    [16420] = true, -- Heavy Attack (Dual Wield)
    [16691] = true, -- Heavy Attack (Bow)
    [16261] = true, -- Heavy Attack (Frost)
    [15383] = true, -- Heavy Attack (Flame)

    -- Player - Werewolf
    [111832] = true, -- Werewolf Transformation
    [111843] = true, -- Pack Leader
    [111844] = true, -- Werewolf Berserker

    -- Sets
    [32755] = true, -- Nikulas' Heavy Armor (of Nikulas)

    [59499] = true, -- Mephala's Web (Spawn of Mephala)
    [75706] = true, -- Bahraha's Curse (of Bahraha's Curse)
    [34870] = true, -- Wilderqueen's Arch (of the Wilderqueen)
    [84357] = true, -- Hand of Mephala Webbing (of Mephala's Hand)

    ----------------------------
    -- Nightblade
    ----------------------------

    [25375] = true, -- Shadow Cloak (Shadow Cloak)
    [25380] = true, -- Shadowy Disguise (Shadowy Disguise)
    [25412] = true, -- Consuming Darkness (Consuming Darkness)
    [36495] = true, -- Bolstering Darkness (Bolstering Darkness)
    [36487] = true, -- Veil of Blades (Veil of Blades)

    ----------------------------
    -- Dragonknight
    ----------------------------

    [21007] = true, -- Reflective Scale
    [21014] = true, -- Reflective Plate
    [21017] = true, -- Dragon Fire Scale
    [29126] = true, -- Ash Cloud
    [20780] = true, -- Cinder Storm
    [32712] = true, -- Eruption

    ----------------------------
    -- Sorcerer
    ----------------------------

    [114903] = true, -- Dark Exchange
    [114908] = true, -- Dark Deal
    [114909] = true, -- Dark Conversion

    [26098] = true, -- Zap Snare (Summon Storm Atronach - All Morphs)
    [29824] = true, -- Negate Magic
    [47147] = true, -- Negate Magic
    [47160] = true, -- Suppression Field
    [47159] = true, -- Suppression Field
    [47168] = true, -- Absorption Field
    [47167] = true, -- Absorption Field

    ----------------------------
    -- Templar
    ----------------------------

    -- Passives
    [80195] = true, -- Sacred Ground (Sacred Ground) - Rune Focus
    [80230] = true, -- Sacred Ground (Sacred Ground) - Cleansing Ritual
    [80261] = true, -- Sacred Ground (Sacred Ground) - Rite of Passage

    -- Actives
    [24307] = true, -- Solar Disturbance Snare (Solar Disturbance)
    [37009] = true, -- Channeled Focus (Channeled Focus)
    [114842] = true, -- Restoring Focus (Restoring Focus)
    [63020] = true, -- Repentance Remover (Repentance)

    ----------------------------
    -- Warden
    ----------------------------

    [114852] = true, -- Betty Netch (Betty Netch)
    [114854] = true, -- Betty Netch (Blue Betty)
    [114853] = true, -- Bull Netch (Bull Netch)
    [86238] = true, -- Impaling Shards (Impaling Shards)
    [87448] = true, -- Gripping Shards (Gripping Shards)
    [88801] = true, -- Winter's Revenge (Gripping Shards)
    [86250] = true, -- Sleet Storm (Sleet Storm)
    [88858] = true, -- Northern Storm (Northern Storm)
    [88861] = true, -- Permafrost (Permafrost)

    ----------------------------
    -- One Hand and Shield
    ----------------------------

    [28727] = true, -- Defensive Posture (Defensive Posture)
    [38312] = true, -- Defensive Stance (Defensive Stance)
    [83301] = true, -- Spell Wall (Spell Wall)

    ----------------------------
    -- Destruction Staff
    ----------------------------

    [68719] = true, -- Frozen (Wall of Elements)
    [62928] = true, -- Wall of Frost (Wall of Elements)
    [39068] = true, -- Unstable Wall of Frost (Unstable Wall of Elements)
    [62948] = true, -- Blockade of Frost (Elemental Blockade)
    [104825] = true, -- Icy Rage (Elemental Rage)

    [89837] = true, -- Fiery Pulsar (Pulsar)
    [89844] = true, -- Shock Pulsar (Pulsar)
    [89840] = true, -- Frost Pulsar (Pulsar)

    ----------------------------
    -- Vampire Quest
    ----------------------------

    [39728] = true, -- VampInit_TheaterFeed
    [39509] = true, -- VampInit_PC Becomes a Vampire

    ----------------------------
    -- Psijic Order
    ----------------------------

    [103538] = true, -- Time Stop (Time Stop)
    [104007] = true, -- Time Stop (Time Stop)
    [104009] = true, -- Time Stop (Time Stop)
    [104071] = true, -- Borrowed Time (Borrowed Time)
    [104072] = true, -- Borrowed Time (Borrowed Time)
    [104073] = true, -- Borrowed Time (Borrowed Time)
    [104080] = true, -- Time Freeze (Time Freeze)
    [104081] = true, -- Time Freeze (Time Freeze)
    [104082] = true, -- Time Freeze (Time Freeze)
    [104083] = true, -- Time Freeze (Time Freeze)

    ----------------------------
    -- Undaunted
    ----------------------------

    [80079] = true, -- Trapping Webs (Trapping Webs)
    [80108] = true, -- Shadow Silk (Shadow Silk)
    [80130] = true, -- Tangling Webs (Tangling Webs)

    ----------------------------
    -- Assault
    ----------------------------

    [113769] = true, -- Caltrops (Caltrops)
    [113770] = true, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [113771] = true, -- Razor Caltrops (Razor Caltrops)

    -- NPC Basic
    [36845] = true, -- Shadow Cloak Stun Remover

    -- Cyrodiil
    [12355] = true, -- Destroy Siege Weapon

    -- Human NPC
    [10648] = true, -- Throw Oil (Synergy)
    [35391] = true, -- Defiled Grave (Bonelord)
    [87066] = true, -- Volanic Debris (Fire-Binder)
    [37132] = true, -- Ice Cage (Battlemage)

    -- Cyrodiil NPC
    [21632] = true, -- Lifesteal (Cryodiil Mage T1)
    [46718] = true, -- Stolen Essence (Cryodiil Mage T2)
    [51893] = true, -- Negate Magic (Cyrodiil Mender T1 + T2)

    -- Daedra NPC
    [35278] = true, -- Soul Flame (Daedric Titan)
    [51646] = true, -- Frozen Ground (Frost Atronach)
    [4829] = true, -- Fire Brand (Flesh Atronach)
    [6410] = true, -- Tail Clip (Winged Twilight)

    -- Undead NPC
    [22525] = true, -- Defiled Ground (Lich)
    [13972] = true, -- Swipe (Zombie)

    -- Monster
    [32268] = true, -- Grapple (Hag)
    [33459] = true, -- Hurricane (Nereid)
    [5881] = true, -- Smash (Ogre)
    [82685] = true, -- CC (Crown Control) Shared Cool
    [14221] = true, -- Grapple (Strangler)
    [75954] = true, -- Brimstone Hailfire (Minotaur Shaman)

    -- Main Quest
    [61648] = true, -- Replenish Stamina (Tutorial - Child of Bones)

    -- Mages Guild
    [40851] = true, -- Polymorph Snare (The Mad God's Bargain)

    -- Auridon
    [84047] = true, -- Defiled Ground (World Boss - Quenyas)

    -- Grahtwood
    [38748] = true, -- Aulus's Tongue (The Grips of Madness)

    -- Greenshade
    [83155] = true, -- Thunderous Smash (Thodundor of the Hill)

    -- Vvardenfell
    [82272] = true, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [82273] = true, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [89903] = true, -- Tonal Inverter (Divine Intervention)
    [86989] = true, -- Succubus Touch (Echoes of a Fallen House)

    -- Nchuleftingth (Public Dungeon)
    [86624] = true, -- Piston Thrust (Dwarven Piston)
    [90857] = true, -- Spike Trap (Dwarven Piston)
    [84334] = true, -- Demolish (Nchulaeon the Eternal)
    [84336] = true, -- Demolish (Nchulaeon the Eternal)

    -- Forgotten Wastes (Public Dungeon)
    [86934] = true, -- Volcanic Debris
    [86938] = true, -- Volcanic Debris
    [92707] = true, -- Volcanic Debris
    [92704] = true, -- Volcanic Debris

    ----------------------------
    -- Dungeons
    ----------------------------

    -- Elden Hollow II
    [34378] = true, -- Flame Geyser (Dubroze the Infestor)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Hide this ID from displaying a cleanse notification on Combat Text - used to stop some spammy abilities, or abilities that cannot be cleansed from displaying a cleanse alert.
--------------------------------------------------------------------------------------------------------------------------------
E.EffectCleanseOverride = { -- Force hide display of cleanse alert (USED BY COMBAT CLOUD ONLY!!!)

    -- Insects
    [69392] = true, -- Vile Bite Poison (Necrotic Hoarvor)

    -- Main Story Quest
    [27776] = true, -- Feeding (Daughter of Giants)
    [38215] = true, -- Death's Gaze (Shadow of Sancre Tor)

    --------------
    -- DUNGEONS --
    --------------

    -- Banished Cells I
    [19028] = true, -- Drain Essence (Shadowrend)
    [18772] = true, -- Feeding (Shadowrend)

    -- Elden Hollow I
    [42601] = true, -- Necrotic Circle (Canonreeve Oraneth)

    -- Frostvault
    [117286] = true, -- Rending Bleed (Coldsnap Goblin - Shared)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Using a separate chart for ZOS Artificial Effects just in case this is significantly expanded at any point -- Overrides Artificial Effect id name or icon.
--------------------------------------------------------------------------------------------------------------------------------
E.ArtificialEffectOverride = {
    --[0] = { icon = 'esoui/art/icons/artificialeffect_battle-spirit.dds' }, -- Battle Spirit (Cyrodiil, Duel)
    [2] = { name = zo_strformat("<<1>> (<<2>>)", A.Skill_Battle_Spirit, A.Skill_Imperial_City) }, -- Battle Spirit Imperial City
    [3] = { tooltip = T.Innate_Battleground_Deserter }, -- Battleground Deserter Penalty
}

--------------------------------------------------------------------------------------------------------------------------------
-- Table of NAME or ID's to add a third line to the tooltip. Any ability listed here should use its source ability as the tooltip, and this added 3 line will describe the effect. Used for major/minor effects & potions/poison primarily.
--------------------------------------------------------------------------------------------------------------------------------
E.TooltipNameOverride = {

    -- Major/Minor Buffs
    [A.Skill_Minor_Resolve]         = T.Skill_Minor_Resolve,
    [A.Skill_Major_Resolve]         = T.Skill_Major_Resolve,
    [A.Skill_Minor_Ward]            = T.Skill_Minor_Ward,
    [A.Skill_Major_Ward]            = T.Skill_Major_Ward,
    [A.Skill_Minor_Fortitude]       = T.Skill_Minor_Fortitude,
    [A.Skill_Major_Fortitude]       = T.Skill_Major_Fortitude,
    [A.Skill_Minor_Endurance]       = T.Skill_Minor_Endurance,
    [A.Skill_Major_Endurance]       = T.Skill_Major_Endurance,
    [A.Skill_Minor_Intellect]       = T.Skill_Minor_Intellect,
    [A.Skill_Major_Intellect]       = T.Skill_Major_Intellect,
    [A.Skill_Minor_Sorcery]         = T.Skill_Minor_Sorcery,
    [A.Skill_Major_Sorcery]         = T.Skill_Major_Sorcery,
    [A.Skill_Minor_Prophecy]        = T.Skill_Minor_Prophecy,
    [A.Skill_Major_Prophecy]        = T.Skill_Major_Prophecy,
    [A.Skill_Minor_Brutality]       = T.Skill_Minor_Brutality,
    [A.Skill_Major_Brutality]       = T.Skill_Major_Brutality,
    [A.Skill_Minor_Savagery]        = T.Skill_Minor_Savagery,
    [A.Skill_Major_Savagery]        = T.Skill_Major_Savagery,
    [A.Skill_Minor_Berserk]         = T.Skill_Minor_Berserk,
    [A.Skill_Major_Berserk]         = T.Skill_Major_Berserk,
    [A.Skill_Minor_Force]           = T.Skill_Minor_Force,
    [A.Skill_Major_Force]           = T.Skill_Major_Force,
    [A.Skill_Minor_Vitality]        = T.Skill_Minor_Vitality,
    [A.Skill_Major_Vitality]        = T.Skill_Major_Vitality,
    [A.Skill_Minor_Mending]         = T.Skill_Minor_Mending,
    [A.Skill_Major_Mending]         = T.Skill_Major_Mending,
    [A.Skill_Minor_Protection]      = T.Skill_Minor_Protection,
    [A.Skill_Major_Protection]      = T.Skill_Major_Protection,
    [A.Skill_Minor_Evasion]         = T.Skill_Minor_Evasion,
    [A.Skill_Major_Evasion]         = T.Skill_Major_Evasion,
    [A.Skill_Minor_Expedition]      = T.Skill_Minor_Expedition,
    [A.Skill_Major_Expedition]      = T.Skill_Major_Expedition,
    [A.Skill_Major_Gallop]          = T.Skill_Major_Gallop,
    [A.Skill_Minor_Heroism]         = T.Skill_Minor_Heroism,
    [A.Skill_Major_Heroism]         = T.Skill_Major_Heroism,
    [A.Skill_Minor_Toughness]       = T.Skill_Minor_Toughness,
    [A.Skill_Major_Courage]         = T.Skill_Major_Courage,

    -- Major/Minor Debuffs
    [A.Skill_Minor_Breach]          = T.Skill_Minor_Breach,
    [A.Skill_Major_Breach]          = T.Skill_Major_Breach,
    [A.Skill_Minor_Fracture]        = T.Skill_Minor_Fracture,
    [A.Skill_Major_Fracture]        = T.Skill_Major_Fracture,
    [A.Skill_Minor_Vulnerability]   = T.Skill_Minor_Vulnerability,
    [A.Skill_Minor_Maim]            = T.Skill_Minor_Maim,
    [A.Skill_Major_Maim]            = T.Skill_Major_Maim,
    [A.Skill_Minor_Defile]          = T.Skill_Minor_Defile,
    [A.Skill_Major_Defile]          = T.Skill_Major_Defile,
    [A.Skill_Minor_Magickasteal]    = T.Skill_Minor_Magickasteal,
    [A.Skill_Minor_Lifesteal]       = T.Skill_Minor_Lifesteal,
    [A.Skill_Minor_Enveration]      = T.Skill_Minor_Enveration,
    [A.Skill_Minor_Uncertainty]     = T.Skill_Minor_Uncertainty,
    [A.Skill_Minor_Cowardice]       = T.Skill_Minor_Cowardice,
    [A.Skill_Minor_Mangle]          = T.Skill_Minor_Mangle,

    -- Misc Buffs & Debuffs
    [A.Skill_Empower]               = T.Skill_Empower,
    [A.Skill_Hindrance]             = T.Skill_Hindrance,
    [A.Skill_Stun]                  = T.Generic_Stun,
    [A.Skill_Off_Balance]           = T.Generic_Off_Balance,
    [A.Skill_Revealed]              = T.Generic_Reveal,
    [A.Skill_Marked]                = T.Generic_Marked,

    -- Potions
    [45239]                         = T.Generic_CC_Immunity, -- ... of Immovability (2 Traits)
    [45463]                         = T.Generic_CC_Immunity, -- ... of Immovability (3 Traits)
    [72930]                         = T.Generic_CC_Immunity, -- Alliance Health Draught
    [86698]                         = T.Generic_CC_Immunity, -- Gold Coast Survivor Elixir
    [92416]                         = T.Generic_CC_Immunity, -- Gold Coast Swift Survivor Elixir
    [45237]                         = T.Generic_Invisibility, -- ... of Invisibility (2 Traits)
    [45460]                         = T.Generic_Invisibility, -- ... of Invisibility (3 Traits)
    [86780]                         = T.Generic_Invisibility, -- Crown Invisibility Potion
    [86699]                         = T.Generic_Invisibility, -- Gold Coast Survivor Elixir
    [78058]                         = T.Generic_Invisibility, -- Roguish Escape Draught
    [79709]                         = T.Generic_Bleed, -- ... of Creeping Ravage Health (2 Traits)
    [46113]                         = T.Generic_Bleed, -- ... of Ravage Health (2 Traits)
    [46217]                         = T.Generic_Bleed, -- ... of Ravage Health (3 Traits)
    [45236]                         = T.Generic_Detection_Potion, -- ... of Detection (2 Traits)
    [45458]                         = T.Generic_Detection_Potion, -- ... of Detection (3 Traits)
    [79705]                         = T.Generic_HoT_1Sec, -- ... of Lingering Restore Health (2 Traits)
    [79706]                         = T.Generic_HoT_1Sec, -- ... of Lingering Restore Health (3 Traits)
    [46193]                         = T.Generic_Ravage_Magicka_Potion, -- ... of Ravage Magicka (2 Traits)
    [46237]                         = T.Generic_Ravage_Magicka_Potion, -- ... of Ravage Magicka (3 Traits)
    [46199]                         = T.Generic_Ravage_Stamina_Potion, -- ... of Ravage Stamina (2 Traits)
    [46240]                         = T.Generic_Ravage_Stamina_Potion, -- ... of Ravage Stamina (3 Traits)

    -- Poisons
    [79133]                         = T.Generic_Poison, -- ... of Drain Health (2 Traits)
    [79134]                         = T.Generic_HoT_1Sec, -- ... of Drain Health (2 Traits)
    [79135]                         = T.Generic_Poison, -- ... of Drain Health (3 Traits)
    [79136]                         = T.Generic_HoT_1Sec, -- ... of Drain Health (3 Traits)
    [79025]                         = T.Generic_Poison, -- ... of Ravage Health (2 Traits)
    [78922]                         = T.Generic_Poison, -- ... of Ravage Health (3 Traits)
    [79137]                         = T.Generic_Ravage_Magicka_Poison, -- of Drain Magicka (2 Traits)
    [79138]                         = T.Generic_Magicka_Regen, -- of Drain Magicka (2 Traits)
    [79037]                         = T.Generic_Ravage_Magicka_Poison, -- of Damage Magicka (2 Traits)
    [79139]                         = T.Generic_Ravage_Magicka_Poison, -- of Drain Magicka (3 Traits)
    [79140]                         = T.Generic_Magicka_Regen, -- of Drain Magicka (3 Traits)
    [79044]                         = T.Generic_Ravage_Magicka_Poison, -- of Damage Magicka (3 Traits)
    [79141]                         = T.Generic_Ravage_Stamina_Poison, -- of Drain Stamina (2 Traits)
    [79142]                         = T.Generic_Stamina_Regen, -- of Drain Stamina (2 Traits)
    [79045]                         = T.Generic_Ravage_Stamina_Poison, -- of Damage Stamina (2 Traits)
    [79143]                         = T.Generic_Ravage_Stamina_Poison, -- of Drain Stamina (3 Traits)
    [79144]                         = T.Generic_Stamina_Regen, -- of Drain Stamina (3 Traits)
    [79046]                         = T.Generic_Ravage_Stamina_Poison, -- of Damage Stamina (3 Traits)
    [79457]                         = T.Generic_Immobilize, -- Escapist's Poison (2 Traits)
    [79458]                         = T.Generic_CC_Immunity, -- Escapist's Poison (2 Traits)
    [79122]                         = T.Generic_Immobilize, -- Entrapping Poison (2 Traits)
    [79459]                         = T.Generic_Immobilize, -- Escapist's Poison (3 Traits)
    [79460]                         = T.Generic_CC_Immunity, -- Escapist's Poison (3 Traits)
    [79996]                         = T.Generic_Reveal, -- Stealth-Draining Poison (2 Traits)
    [80003]                         = T.Generic_Marked, -- Conspicuous Posion (2 Traits)
    [80002]                         = T.Generic_Reveal, -- Stealth-Draining Poison (2 Traits)
    [80004]                         = T.Generic_Marked, -- Conspicuous Posion (2 Traits)
    [79699]                         = T.Generic_Poison, -- ... of Gradual Drain Health (2 Traits)
    [79700]                         = T.Generic_HoT_1Sec, -- ... of Gradual Drain Health (2 Traits)
    [79701]                         = T.Generic_Poison, -- ... of Gradual Drain Health (3 Traits)
    [79702]                         = T.Generic_HoT_1Sec, -- ... of Gradual Drain Health (3 Traits)
    [79707]                         = T.Generic_Poison, -- ... of Gradual Ravage Health (2 Traits)
    [81553]                         = T.Generic_Poison, -- Cloudy Damage Health Poison
    [81551]                         = T.Generic_Poison, -- Cloudy Gradual Ravage Health Poison
    [88476]                         = T.Generic_Poison, -- Crown Debilitating Poison
    [88471]                         = T.Generic_Ravage_Magicka_Poison, -- Crown Draining Poison
    [88475]                         = T.Generic_Ravage_Stamina_Poison, -- Crown Draining Poison
    [88473]                         = T.Generic_Magicka_Regen, -- Crown Draining Poison
    [88474]                         = T.Generic_Stamina_Regen, -- Crown Draining Poison
    [88462]                         = T.Generic_Immobilize, -- Crown Trapping Poison
    [81274]                         = T.Generic_Poison, -- Crown Lethal Poison
    [81275]                         = T.Generic_Poison, -- Crown Lethal Poison

    -- Justice NPC's
    [77941]                         = T.Generic_Reveal_No_Dur, -- Revealed
    [72695]                         = T.Generic_Reveal_No_Dur, -- Revealed

    -- NPC Abilities
    [85362]                         = T.Skill_Major_Fracture_NPC, -- Major Fracture (Peasant)

}

--------------------------------------------------------------------------------------------------------------------------------
-- LUIE for the most part overwrites default ability tooltips due to the fact they are only exposed for buffs/debuffs that are on the player. In some cases there is no description with scaling or we need to still use the default where possible.
-- The most noteworthy case of this is Mundus Boons, where there is a tooltip but no description. We want to display a generic tooltip describing the effect if mousing over another player - but display the default value with accurate number for self.
--------------------------------------------------------------------------------------------------------------------------------
E.TooltipUseDefault = {

[13940] = true, -- Boon: The Warrior
[13943] = true, -- Boon: The Mage
[13974] = true, -- Boon: The Serpent
[13975] = true, -- Boon: The Thief
[13976] = true, -- Boon: The Lady
[13977] = true, -- Boon: The Steed
[13978] = true, -- Boon: The Lord
[13979] = true, -- Boon: The Apprentice
[13980] = true, -- Boon: The Ritual
[13981] = true, -- Boon: The Lover
[13982] = true, -- Boon: The Atronach
[13984] = true, -- Boon: The Shadow
[13985] = true, -- Boon: The Tower

}

--------------------------------------------------------------------------------------------------------------------------------
-- Override various information displayed for Effect auras
--------------------------------------------------------------------------------------------------------------------------------
E.EffectOverride = {
    -- Optional:
    -- icon = '' -- Change Icon
    -- name = '' -- Change Name
    -- tooltip = '' -- Set a custom tooltip to display for this ability
    -- hide = true -- Hide this aura from appearing
    -- type = 1 or BUFF_EFFECT_TYPE_DEBUFF -- Adjust this effect to be a debuff or not a debuff to fix API errors (Commonly used as most undispellable debuffs show as a buff)
    -- duration = # modify the duration display of this effect. Option 1 - Set a negative value - to subtract x seconds from the duration of the effect. Option 2 - Set to 0 to display the buff for an unlimited amount of time until an action result of fade occurs.
    -- unbreakable = true -- flag this aura as unremoveable and change border color to grey for debuffs or cyan for buffs
    -- forcedContainer = 'short' or 'long' - Forces a buff to appear in one of these containers
    -- consolidate = true -- If the menu option to consolidate buffs is enabled, this auras will be hidden.
    -- consolidateExtra = true -- If the menu option to consolidate buffs for Single Auras as well is enabled, this auras will be hidden
    -- groundLabel = true -- "Display a "G" ground label on this effect to indicate it is the result of standing in a ground aura
    -- noDuplicate = true -- Adds to a table that uses an expensive function - in some cases effects like Shuffle add a new aura every time the effect is cast. This will flag the effect to only show the latest casted one and hide the others.
    -- hideReduce = true -- Hide this aura if the "HIDE PAIRED AURAS" menu setting is enabled. Merging similar effects so as not to clutter the UI such as the Sun Fire effect with its snare.
    -- tooltipValue2Mod = # -- Needed in some cases to derive a value on an ability tooltip. This value is used for effects like the snare from Sun Fire, when the duration needs to be derived from either buff since one can potentially be hidden.
    -- refreshOnly = true -- Only show this effect when the duration is updated/refreshed - Toggle this to hide some goofy effects that have a travel time aura for their projectile before the actual effect applies.
    -- hideGround = true -- Hide this effect if ground effect damaging auras are set to show - we want damage to always prioritize so that the aura always shows even if the player is immune to the snare or other effect of the ability.

    -- TEMP MOVE LATER
    [54119] = { forcedContainer = 'short' }, -- Remembrance (The Anger of a King)

    -- Craglorn buffs
    [82294] = { icon = 'esoui/art/icons/achievement_craglorn_001.dds' }, -- Magicka Attunement
    [81894] = { icon = 'esoui/art/icons/achievement_craglorn_002.dds' }, -- Yokudan Might
    [82499] = { icon = 'esoui/art/icons/achievement_craglorn_003.dds' }, -- Nirncrux Infusion

    ----------------------------------------------------------------
    -- POTIONS -----------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Potions (2 Traits)
    [64564] = { icon = 'LuiExtended/media/icons/potions/potion_007.dds', tooltip = A.Potion }, -- of Armor (Major Resolve)
    [79709] = { icon = 'LuiExtended/media/icons/potions/potion_014r.dds', tooltip = A.Potion }, -- of Creeping Ravage Health (Creeping Ravage Health)
    [79857] = { icon = 'LuiExtended/media/icons/potions/potion_007r.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Potion }, -- of Defile (Minor Defile)
    [45236] = { icon = 'LuiExtended/media/icons/potions/potion_009.dds', tooltip = A.Potion }, -- of Detection (Increase Detection)
    [45222] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds', tooltip = A.Potion }, -- of Health (Major Fortitude)
    [45239] = { icon = 'LuiExtended/media/icons/potions/potion_008.dds', tooltip = A.Potion }, -- of Immovability (Unstoppable)
    [45237] = { icon = 'LuiExtended/media/icons/potions/potion_011.dds', name = A.Potion_Invisiblity, tooltip = A.Potion }, -- of Invisibility (Vanish)
    [79705] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds', tooltip = A.Potion }, -- of Lingering Health (Lingering Restore Health)
    [45224] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds', tooltip = A.Potion }, -- of Magicka (Major Intellect)
    [79712] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds', tooltip = A.Potion }, -- of Protection (Minor Protection)
    [46208] = { icon = 'LuiExtended/media/icons/potions/potion_021.dds', tooltip = A.Potion }, -- of Ravage Armor (Minor Fracture)
    [46113] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = A.Potion_Ravage_Health, tooltip = A.Potion }, -- of Ravage Health (Health Potion Poison)
    [46193] = { icon = 'LuiExtended/media/icons/potions/potion_016.dds', tooltip = A.Potion }, -- of Ravage Magicka (Ravage Magicka)
    [47204] = { icon = 'LuiExtended/media/icons/potions/potion_020.dds', tooltip = A.Potion }, -- of Ravage Spell Critical (Minor Uncertainty)
    [46202] = { icon = 'LuiExtended/media/icons/potions/potion_020.dds', tooltip = A.Potion }, -- of Ravage Spell Power (Minor Cowardice)
    [46206] = { icon = 'LuiExtended/media/icons/potions/potion_018.dds', tooltip = A.Potion }, -- of Ravage Spell Protection (Minor Breach)
    [46199] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds', tooltip = A.Potion }, -- of Ravage Stamina (Ravage Stamina)
    [47203] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds', tooltip = A.Potion }, -- of Ravage Weapon Critical (Minor Enervation)
    [46204] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds', tooltip = A.Potion }, -- of Ravage Weapon Power (Minor Maim)
    [46210] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds', tooltip = A.Potion }, -- of Slow (Hindrance)
    [64566] = { icon = 'LuiExtended/media/icons/potions/potion_010.dds', tooltip = A.Potion }, -- of Speed (Major Expedition)
    [64570] = { icon = 'LuiExtended/media/icons/potions/potion_013.dds', tooltip = A.Potion }, -- of Spell Critical (Major Prophecy)
    [64558] = { icon = 'LuiExtended/media/icons/potions/potion_006.dds', tooltip = A.Potion }, -- of Spell Power (Major Sorcery)
    [64562] = { icon = 'LuiExtended/media/icons/potions/potion_004.dds', tooltip = A.Potion }, -- of Spell Protection (Major Ward)
    [45226] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds', tooltip = A.Potion }, -- of Stamina (Major Endurance)
    [68565] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', tooltip = A.Potion }, -- of Stun (Stun)
    [79848] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds', tooltip = A.Potion }, -- of Vitality (Major Vitality)
    [79844] = { icon = 'LuiExtended/media/icons/potions/potion_001r.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Potion }, -- of Vulnerability (Minor Vulnerability)
    [64568] = { icon = 'LuiExtended/media/icons/potions/potion_012.dds', tooltip = A.Potion }, -- of Weapon Critical (Major Savagery)
    [64555] = { icon = 'LuiExtended/media/icons/potions/potion_005.dds', tooltip = A.Potion }, -- of Weapon Power (Major Brutality)

    -- Crafted Potions (3 Traits)
    [64565] = { icon = 'LuiExtended/media/icons/potions/potion_007.dds', tooltip = A.Potion }, -- of Armor (Major Resolve)
    -- No ... of Creeping Ravage Health
    [79860] = { icon = 'LuiExtended/media/icons/potions/potion_007r.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Potion }, -- of Defile (Minor Defile)
    [45458] = { icon = 'LuiExtended/media/icons/potions/potion_009.dds', tooltip = A.Potion }, -- of Detection (Increase Detection)
    [63670] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds', tooltip = A.Potion }, -- of Health (Major Fortitude)
    [45463] = { icon = 'LuiExtended/media/icons/potions/potion_008.dds', tooltip = A.Potion }, -- of Immovability (Unstoppable)
    [45460] = { icon = 'LuiExtended/media/icons/potions/potion_011.dds', name = A.Potion_Invisiblity, tooltip = A.Potion }, -- of Invisibility (Vanish)
    [79706] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds', tooltip = A.Potion }, -- of Lingering Health (Lingering Restore Health)
    [63676] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds', tooltip = A.Potion }, -- of Magicka (Major Intellect)
    [79714] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds', tooltip = A.Potion }, -- of Protection (Minor Protection)
    [46250] = { icon = 'LuiExtended/media/icons/potions/potion_021.dds', tooltip = A.Potion }, -- of Ravage Armor (Minor Fracture)
    [46217] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = A.Potion_Ravage_Health, tooltip = A.Potion }, -- of Ravage Health (Health Potion Linger Effect) (Different name than 2 trait)
    [46237] = { icon = 'LuiExtended/media/icons/potions/potion_016.dds', tooltip = A.Potion }, -- of Ravage Magicka (Ravage Magicka)
    -- No ... of Ravage Spell Critical
    [46244] = { icon = 'LuiExtended/media/icons/potions/potion_020.dds', tooltip = A.Potion }, -- of Ravage Spell Power (Minor Cowardice)
    [46248] = { icon = 'LuiExtended/media/icons/potions/potion_018.dds', tooltip = A.Potion }, -- of Ravage Spell Protection (Reduce Spell Resistance) (Should be Minor Breach)
    [46240] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds', tooltip = A.Potion }, -- of Ravage Stamina (Ravage Stamina)
    [47202] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds', tooltip = A.Potion }, -- of Ravage Weapon Critical (Reduce Weapon Critical) (Should be Minor Enervation)
    [46246] = { icon = 'LuiExtended/media/icons/potions/potion_019.dds', tooltip = A.Potion }, -- of Ravage Weapon Power (Minor Maim)
    [46252] = { icon = 'LuiExtended/media/icons/potions/potion_017.dds', tooltip = A.Potion }, -- of Slow (Hindrance)
    [64567] = { icon = 'LuiExtended/media/icons/potions/potion_010.dds', tooltip = A.Potion }, -- of Speed (Major Expedition)
    [64572] = { icon = 'LuiExtended/media/icons/potions/potion_013.dds', tooltip = A.Potion }, -- of Spell Critical (Major Prophecy)
    [64561] = { icon = 'LuiExtended/media/icons/potions/potion_006.dds', tooltip = A.Potion }, -- of Spell Power (Major Sorcery)
    [64563] = { icon = 'LuiExtended/media/icons/potions/potion_004.dds', tooltip = A.Potion }, -- of Spell Protection (Major Ward)
    [63681] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds', tooltip = A.Potion }, -- of Stamina (Major Endurance)
    -- No ... of Stun
    [79850] = { icon = 'LuiExtended/media/icons/potions/potion_014.dds', tooltip = A.Potion }, -- of Vitality (Major Vitality)
    [79846] = { icon = 'LuiExtended/media/icons/potions/potion_001r.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Potion }, -- of Vulnerability (Minor Vulnerability)
    [64569] = { icon = 'LuiExtended/media/icons/potions/potion_012.dds', tooltip = A.Potion }, -- of Weapon Critical (Major Savagery)
    [64554] = { icon = 'LuiExtended/media/icons/potions/potion_005.dds', tooltip = A.Potion }, -- of Weapon Power (Major Brutality)

    -- Vendor Potions + AVA Potions + Roguish Draughts
    [63672] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds', tooltip = A.Potion  }, -- of Health (Major Fortitude)
    [63678] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds', tooltip = A.Potion }, -- of Magicka (Major Intellect)
    [63683] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds', tooltip = A.Potion }, -- of Stamina (Major Endurance)
    [72935] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds', tooltip = A.Potion }, -- Alliance Battle Draught (Major Endurance)
    [72936] = { icon = 'LuiExtended/media/icons/potions/potion_ava_yellow.dds', tooltip = A.Potion }, -- Alliance Battle Draught (Major Brutality)
    [72930] = { icon = 'LuiExtended/media/icons/potions/potion_ava_red.dds', tooltip = A.Potion }, -- Alliance Health Draught (Unstoppable )
    [72928] = { icon = 'LuiExtended/media/icons/potions/potion_ava_red.dds', tooltip = A.Potion }, -- Alliance Health Draught (Major Fortitude)
    [72933] = { icon = 'LuiExtended/media/icons/potions/potion_ava_teal.dds', tooltip = A.Potion }, -- Alliance Spell Draught (Major Sorcery)
    [72932] = { icon = 'LuiExtended/media/icons/potions/potion_ava_blue.dds', tooltip = A.Potion }, -- Alliance Spell Draught (Major Intellect)
    [78058] = { icon = 'LuiExtended/media/icons/potions/potion_ava_purple.dds', name = A.Potion_Invisiblity, tooltip = A.Potion }, -- Roguish Stealth Draught (Vanish)
    [78054] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds', tooltip = A.Potion }, -- Roguish Stealth Draught (Major Endurance)
    [78081] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds', tooltip = A.Potion }, -- Roguish Escape Draught (Major Expedition)
    [78080] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds', tooltip = A.Potion }, -- Roguish Escape Draught (Major Endurance)

    -- Crown Store Potions
    [68405] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', tooltip = A.Potion }, -- Crown Tri-Restoration Potion (Major Fortitude)
    [68406] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds', tooltip = A.Potion }, -- Crown Tri-Restoration Potion (Major Intellect)
    [68408] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds', tooltip = A.Potion }, -- Crown Tri-Restoration Potion (Major Endurance)
    [86780] = { icon = 'LuiExtended/media/icons/potions/potion_crown_pink.dds', tooltip = A.Potion }, -- Crown Invisibility Potion (Invisibility)
    [86683] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds', tooltip = A.Potion }, -- Crown Spellcaster's Elixir (Major Intellect)
    [86684] = { icon = 'LuiExtended/media/icons/potions/potion_crown_teal.dds', tooltip = A.Potion }, -- Crown Spellcaster's Elixir (Major Prophecy)
    [86685] = { icon = 'LuiExtended/media/icons/potions/potion_crown_teal.dds', tooltip = A.Potion }, -- Crown Spellcaster's Elixir (Major Sorcery)
    [86697] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', tooltip = A.Potion }, -- Crown Survivor's Elixir (Major Fortitude)
    [86698] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', tooltip = A.Potion }, -- Crown Survivor's Elixir (Unstoppable)
    [86699] = { icon = 'LuiExtended/media/icons/potions/potion_crown_pink_alt.dds', tooltip = A.Potion }, -- Crown Survivor's Elixir (Invisibility)
    [86693] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds', tooltip = A.Potion }, -- Crown Warrior's Elixir (Major Endurance)
    [86694] = { icon = 'LuiExtended/media/icons/potions/potion_crown_yellow.dds', tooltip = A.Potion }, -- Crown Warrior's Elixir (Major Savagery)
    [86695] = { icon = 'LuiExtended/media/icons/potions/potion_crown_yellow.dds', tooltip = A.Potion }, -- Crown Warrior's Elixir (Major Brutality)
    [92415] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', tooltip = A.Potion }, -- Major Fortitude (Gold Coast Swift Survivor Elixir)
    [92418] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds', tooltip = A.Potion }, -- Major Expedition (Gold Coast Swift Survivor Elixir)
    [92416] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', tooltip = A.Potion }, -- Unstoppable (Gold Coast Swift Survivor Elixir)

    ----------------------------------------------------------------
    -- POTION UP FRONT EFFECTS -------------------------------------
    ----------------------------------------------------------------

    --Crafted Potions (2 Traits)
    [45221] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- Restore Health
    [45223] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- Restore Magicka
    [46111] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds' }, -- Ravage Health
    [45225] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- Restore Stamina

    --Crafted Potions (3 Traits)
    [45382] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- Restore Health
    [45385] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- Restore Magicka
    [46215] = { icon = 'LuiExtended/media/icons/potions/potion_015.dds', name = A.Potion_Ravage_Health }, -- Damage Health
    [45388] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- Restore Stamina

    -- Vendor Potions + AVA Potions + Roguish Draughts
    [17302] = { icon = 'LuiExtended/media/icons/potions/potion_001.dds' }, -- Restore Health (Vendor)
    [17323] = { icon = 'LuiExtended/media/icons/potions/potion_002.dds' }, -- Restore Magicka (Vendor)
    [17328] = { icon = 'LuiExtended/media/icons/potions/potion_003.dds' }, -- Restore Stamina (Vendor)
    [72934] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Restore Stamina (Alliance Battle Draught)
    [72927] = { icon = 'LuiExtended/media/icons/potions/potion_ava_red.dds' }, -- Restore Health (Alliance Health Draught)
    [72931] = { icon = 'LuiExtended/media/icons/potions/potion_ava_blue.dds' }, -- Restore Magicka (Alliance Spell Draught)
    [78053] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Restore Stamina (Roguish Stealth Draught)
    [78079] = { icon = 'LuiExtended/media/icons/potions/potion_ava_green.dds' }, -- Restore Stamina (Roguish Escape Draught)

    -- Crown Store Potions
    [68401] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', name = A.Potion_Restore_Health }, -- Restore All Resources (Crown Tri-Restoration Potion)
    [68407] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds' }, -- Restore Magicka (Crown Tri-Restoration Potion)
    [68409] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds' }, -- Restore Stamina (Crown Tri-Restoration Potion)
    [86682] = { icon = 'LuiExtended/media/icons/potions/potion_crown_blue.dds', name = A.Potion_Restore_Magicka }, -- Crown Spellcaster's Elixir (Crown Spellcaster's Elixir)
    [86696] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', name = A.Potion_Restore_Health }, -- Crown Survivor's Elixir (Crown Survivor's Elixir)
    [86692] = { icon = 'LuiExtended/media/icons/potions/potion_crown_green.dds', name = A.Potion_Restore_Stamina }, -- Crown Warrior's Elixir (Crown Warrior's Elixir)
    [92414] = { icon = 'LuiExtended/media/icons/potions/potion_crown_red.dds', name = A.Potion_Restore_Health }, -- Crown Survivor's Elixir (Gold Coast Swift Survivor Elixir)

    ----------------------------------------------------------------
    -- POSIONS -----------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Poisons (2 Traits)
    [79133] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', tooltip = A.Poison }, -- Drain Health (Drain Health Poison) DEBUFF
    [79134] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', tooltip = A.Poison }, -- Restore Health (Drain Health Poison) BUFF
    [79025] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', tooltip = A.Poison }, -- Ravage Health (Damage Health Poison) DEBUFF
    [79137] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_r.dds', tooltip = A.Poison }, -- Drain Magicka (Drain Magicka Poison) DEBUFF
    [79138] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_g.dds', tooltip = A.Poison }, -- Restore Magicka (Drain Magicka Poison) BUFF
    [79037] = { icon = 'LuiExtended/media/icons/poisons/poison_1_blue_r.dds', tooltip = A.Poison }, -- Ravage Magicka (Damage Magicka Poison) DEBUFF
    [79141] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', tooltip = A.Poison }, -- Drain Stamina (Drain Stamina Poison) DEBUFF
    [79142] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', tooltip = A.Poison }, -- Restore Stamina (Drain Stamina Poison) BUFF
    [79045] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', tooltip = A.Poison }, -- Ravage Stamina (Damage Stamina Poison) DEBUFF
    [79284] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', tooltip = A.Poison }, -- Drain Spell Resist (Ward-Draining Poison) DEBUFF
    [79285] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', tooltip = A.Poison }, -- Minor Ward (Ward-Draining Poison) BUFF
    [79087] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', tooltip = A.Poison }, -- Minor Breach (Breaching Poison) DEBUFF
    [79309] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Drain Physical Resist (Resolve-Draining Poison) DEBUFF
    [79310] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', tooltip = A.Poison }, -- Minor Resolve (Resolve-Draining Poison) BUFF
    [79090] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Minor Fracture (Fracturing Poison) DEBUFF
    [79193] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_r.dds', tooltip = A.Poison }, -- Minor Cowardice (Sorcery-Draining Poison) DEBUFF
    [79221] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_g.dds', tooltip = A.Poison }, -- Minor Sorcery (Sorcery-Draining Poison) BUFF
    [79069] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', tooltip = A.Poison }, -- Minor Cowardice (Cowardice Poison) DEBUFF
    [79280] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_r.dds', name = A.Skill_Minor_Maim, tooltip = A.Poison }, -- Drain Weapon Power (Brutality-Draining Poison) DEBUFF
    [79281] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_g.dds', tooltip = A.Poison }, -- Minor Brutality (Brutality-Draining Poison) BUFF
    [79083] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Maim (Maiming Poison) DEBUFF
    [79446] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', tooltip = A.Poison }, -- Minor Uncertainty (Prophecy-Draining Poison) DEBUFF
    [79447] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_g.dds', tooltip = A.Poison }, -- Minor Prophecy (Prophecy-Draining Poison) BUFF
    [79117] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', tooltip = A.Poison }, -- Minor Uncertainty (Uncertainty Poison) DEBUFF
    [79450] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Enervation (Savagery-Draining Poison) DEBUFF
    [79453] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_g.dds', tooltip = A.Poison }, -- Minor Savagery (Savagery-Draining Poison) BUFF
    [79113] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Enervation (Enervating Poison) DEBUFF
    [79457] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', tooltip = A.Poison }, -- Immobilize (Escapist's Poison) DEBUFF
    [79458] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', tooltip = A.Poison }, -- Unstoppable (Escapist's Poison) BUFF
    [79122] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', tooltip = A.Poison }, -- Immobilize (Entrapping Poison) DEBUFF
    [79996] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', name = A.Skill_Revealed, tooltip = A.Poison }, -- Revealing Poison (Stealth-Draining Poison) DEBUFF
    [80003] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', name = A.Skill_Marked, tooltip = A.Poison }, -- Marking Poison (Conspicuous Poison) DEBUFF
    [79367] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', name = A.Skill_Hindrance, tooltip = A.Poison }, -- Hindrance (Speed-Draining Poison) DEBUFF
    [79368] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', tooltip = A.Poison }, -- Major Expedition (Speed-Draining Poison) BUFF
    [79094] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', tooltip = A.Poison }, -- Hindrance (Hindering Poison) DEBUFF
    [79699] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', name = A.Poison_Creeping_Drain_Health, tooltip = A.Poison }, -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [79700] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', name = A.Poison_Lingering_Restore_Health, tooltip = A.Poison }, -- Restore Health (Gradual Health Drain Poison) BUFF
    [79707] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Creeping Ravage Health (Gradual Ravage Health Poison) DEBUFF
    [79723] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', tooltip = A.Poison }, -- Minor Vulnerability (Protection-Reversing Poison) DEBUFF
    [79725] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', tooltip = A.Poison }, -- Minor Protection (Protection-Reversing Poison) BUFF
    [79715] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', tooltip = A.Poison }, -- Minor Vulnerability (Vulnerability Poison) DEBUFF
    [79851] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Minor Defile (Vitality-Draining Poison) DEBUFF
    [79852] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', tooltip = A.Poison }, -- Minor Vitality (Vitality-Draining Poison) BUFF
    [79861] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Minor Defile (Defiling Poison) DEBUFF

    -- Crafted Poisons (3 Traits)
    [79135] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', tooltip = A.Poison }, -- Drain Health (Drain Health Poison) DEBUFF
    [79136] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', tooltip = A.Poison }, -- Restore Health (Drain Health Poison) BUFF
    [78922] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', tooltip = A.Poison }, -- Ravage Health (Damage Health Poison) DEBUFF
    [79139] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_r.dds', tooltip = A.Poison }, -- Drain Magicka (Drain Magicka Poison) DEBUFF
    [79140] = { icon = 'LuiExtended/media/icons/poisons/poison_2_blue_g.dds', tooltip = A.Poison }, -- Restore Magicka (Drain Magicka Poison) BUFF
    [79044] = { icon = 'LuiExtended/media/icons/poisons/poison_1_blue_r.dds', tooltip = A.Poison }, -- Ravage Magicka (Damage Magicka Poison) DEBUFF
    [79143] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', tooltip = A.Poison }, -- Drain Stamina (Drain Stamina Poison) DEBUFF
    [79144] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', tooltip = A.Poison }, -- Restore Stamina (Drain Stamina Poison) BUFF
    [79046] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', tooltip = A.Poison }, -- Ravage Stamina (Damage Stamina Poison) DEBUFF
    [79306] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', tooltip = A.Poison }, -- Drain Spell Resist (Ward-Draining Poison) DEBUFF
    [79307] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', tooltip = A.Poison }, -- Minor Ward (Ward-Draining Poison) BUFF
    [79086] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', tooltip = A.Poison }, -- Minor Breach (Breaching Poison) DEBUFF
    [79311] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Drain Physical Resist (Resolve-Draining Poison) DEBUFF
    [79312] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', tooltip = A.Poison }, -- Minor Resolve (Resolve-Draining Poison) BUFF
    [79091] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Minor Fracture (Fracturing Poison) DEBUFF
    [79278] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_r.dds', tooltip = A.Poison }, -- Minor Cowardice (Sorcery-Draining Poison) DEBUFF
    [79279] = { icon = 'LuiExtended/media/icons/poisons/poison_2_cyan_g.dds', tooltip = A.Poison }, -- Minor Sorcery (Sorcery-Draining Poison) BUFF
    [79082] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', tooltip = A.Poison }, -- Minor Cowardice (Cowardice Poison) DEBUFF
    [79282] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_r.dds', tooltip = A.Poison }, -- Drain Weapon Power (Brutality-Draining Poison) DEBUFF
    [79283] = { icon = 'LuiExtended/media/icons/poisons/poison_2_yellow_g.dds', tooltip = A.Poison }, -- Minor Brutality (Brutality-Draining Poison) BUFF
    [79085] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Maim (Maiming Poison) DEBUFF
    [79448] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_r.dds', tooltip = A.Poison }, -- Minor Uncertainty (Prophecy-Draining Poison) DEBUFF
    [79449] = { icon = 'LuiExtended/media/icons/poisons/poison_1_cyan_g.dds', tooltip = A.Poison }, -- Minor Prophecy (Prophecy-Draining Poison) BUFF
    -- No Uncertainty
    [79454] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Enervation (Savagery-Draining Poison) DEBUFF
    [79455] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_g.dds', tooltip = A.Poison }, -- Minor Savagery (Savagery-Draining Poison) BUFF
    [79116] = { icon = 'LuiExtended/media/icons/poisons/poison_1_yellow_r.dds', tooltip = A.Poison }, -- Minor Enervation (Enervating Poison) DEBUFF
    [79459] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_r.dds', tooltip = A.Poison }, -- Immobilize (Escapist's Poison) DEBUFF
    [79460] = { icon = 'LuiExtended/media/icons/poisons/poison_2_red_g.dds', tooltip = A.Poison }, -- Unstoppable (Escapist's Poison) BUFF
    -- No Entrapping
    [80002] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', name = A.Skill_Revealed, tooltip = A.Poison }, -- Revealing Poison (Stealth-Draining Poison) DEBUFF
    [80004] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', name = A.Skill_Marked, tooltip = A.Poison }, -- Marking Poison (Conspicuous Poison) DEBUFF
    [79369] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_r.dds', name = A.Skill_Hindrance, tooltip = A.Poison }, -- Hindrance (Speed-Draining Poison) DEBUFF
    [79370] = { icon = 'LuiExtended/media/icons/poisons/poison_2_green_g.dds', tooltip = A.Poison }, -- Major Expedition (Speed-Draining Poison) BUFF
    [79102] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', name = A.Skill_Hindrance, tooltip = A.Poison }, -- Hindrance (Hindering Poison) DEBUFF
    [79701] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [81348] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Drain Health (Gradual Health Drain Poison) DEBUFF
    [79702] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', tooltip = A.Poison }, -- Restore Health (Gradual Health Drain Poison) BUFF
    -- No Gradual Ravage Health
    [79726] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_r.dds', tooltip = A.Poison }, -- Minor Vulnerability (Protection-Reversing Poison) DEBUFF
    [79727] = { icon = 'LuiExtended/media/icons/poisons/poison_2_violet_g.dds', tooltip = A.Poison }, -- Minor Protection (Protection-Reversing Poison) BUFF
    [79720] = { icon = 'LuiExtended/media/icons/poisons/poison_1_violet_r.dds', tooltip = A.Poison }, -- Minor Vulnerability (Vulnerability Poison) DEBUFF
    [79854] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_r.dds', tooltip = A.Poison }, -- Minor Defile (Vitality-Draining Poison) DEBUFF
    [79855] = { icon = 'LuiExtended/media/icons/poisons/poison_2_orange_g.dds', tooltip = A.Poison }, -- Minor Vitality (Vitality-Draining Poison) BUFF
    [79862] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Minor Defile (Defiling Poison) DEBUFF

    -- Vendor Poisons
    [81553] = { icon = 'LuiExtended/media/icons/poisons/poison_1_red_r.dds', tooltip = A.Poison }, -- Ravage Health (Cloudy Damage Health Poison) DEBUFF
    [81551] = { icon = 'LuiExtended/media/icons/poisons/poison_1_orange_r.dds', tooltip = A.Poison }, -- Creeping Ravage Health (Cloudy Gradual Ravage Health Poison) DEBUFF
    [81554] = { icon = 'LuiExtended/media/icons/poisons/poison_1_green_r.dds', tooltip = A.Poison }, -- Hindrance (Cloudy Hindering Poison) DEBUFF

    -- Crown Poisons
    [88476] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds', tooltip = A.Poison }, -- Creeping Ravage Health (Crown Debilitating Poison)
    [88477] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds', tooltip = A.Poison }, -- Hindrance (Crown Debilitating Poison)
    [88471] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_blue_r.dds', tooltip = A.Poison }, -- Drain Magicka (Crown Draining Poison)
    [88475] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds', tooltip = A.Poison }, -- Drain Stamina (Crown Draining Poison)
    [88473] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_blue_g.dds', tooltip = A.Poison }, -- Restore Magicka (Crown Draining Poison)
    [88474] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_g.dds', tooltip = A.Poison }, -- Restore Stamina (Crown Draining Poison)
    [88469] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_yellow_r.dds', tooltip = A.Poison }, -- Minor Maim (Crown Enfeebling Poison)
    [88470] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds', tooltip = A.Poison }, -- Minor Defile (Crown Enfeebling Poison)
    [81274] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_red_r.dds', tooltip = A.Poison }, -- Ravage Health (Crown Lethal Poison) DEBUFF
    [81275] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_orange_r.dds', tooltip = A.Poison }, -- Creeping Ravage Health (Crown Lethal Poison) DEBUFF
    [88462] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_red_r.dds', tooltip = A.Poison }, -- Immobilize (Crown Trapping Poison)
    [88463] = { icon = 'LuiExtended/media/icons/poisons/poison_crown_green_r.dds', tooltip = A.Poison }, -- Hindrance (Crown Trapping Poison)

    ----------------------------------------------------------------
    -- FOOD & DRINK ------------------------------------------------
    ----------------------------------------------------------------

    -- Crafted Food
    [61259] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds', tooltip = T.Food_Crafted_Health }, -- Health Food
    [61260] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds', tooltip = T.Food_Crafted_Magicka }, -- Magicka Food
    [61261] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds', tooltip = T.Food_Crafted_Stamina }, -- Stamina Food
    [61294] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds', tooltip = T.Food_Crafted_Magicka_Stamina }, -- Magicka + Stamina Food
    [61255] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds', tooltip = T.Food_Crafted_Health_Stamina }, -- Health + Stamina Food
    [61257] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_blue.dds', tooltip = T.Food_Crafted_Health_Magicka }, -- Health + Magicka Food
    [61218] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_purple.dds', tooltip = T.Food_Crafted_Triple }, -- Triple Food
    [72819] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_tripe_trifle_pocket.dds', name = A.Food_Orzorgas_Tripe_Trifle_Pocket }, -- Orzorga's Tripe Trifle Pocket
    [72822] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_blood_price_pie.dds', name = A.Food_Orzorgas_Blood_Price_Pie }, -- Orzorga's Blood Price Pie
    [72824] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_bear_haunch.dds', name = A.Food_Orzorgas_Smoked_Bear_Haunch }, -- Orzorga's Smoked Bear Haunch
    [100502] = { icon = 'LuiExtended/media/icons/consumables/consumable_deregulated_mushroom_stew.dds' }, -- Deregulated Mushroom Stew
    [100498] = { icon = 'LuiExtended/media/icons/consumables/consumable_clockwork_citrus_filet.dds' }, -- Clockwork Citrus Filet
    [107789] = { icon = 'LuiExtended/media/icons/consumables/consumable_artaeum_takeaway_broth.dds' }, -- Artaeum Takeaway Broth
    [107748] = { icon = 'LuiExtended/media/icons/consumables/consumable_artaeum_pickled_fish_bowl.dds', name = A.Food_Artaeum_Pickled_Fish_Bowl }, -- Lure Allure (Artaeum Pickled Fish Bowl)

    -- Crafted Drink
    [61322] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Recovery), tooltip = T.Drink_Crafted_Health }, -- Health Drink
    [61323] = { hide = true }, -- Well Fed
    [61325] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Magicka_Recovery), tooltip = T.Drink_Crafted_Magicka }, -- Magicka Drink
    [61326] = { hide = true }, -- Well Fed
    [61328] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_green.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Stamina_Recovery), tooltip = T.Drink_Crafted_Stamina }, -- Stamina Drink
    [61329] = { hide = true }, -- Well Fed
    [61345] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Magicka_Stamina_Recovery), tooltip = T.Drink_Crafted_Magicka_Stamina }, -- Magicka + Stamina Drink
    [61346] = { hide = true }, -- Well Fed
    [61348] = { hide = true }, -- Well Fed
    [61340] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Stamina_Recovery), tooltip = T.Drink_Crafted_Health_Stamina }, -- Health + Stamina Drink
    [61341] = { hide = true }, -- Well Fed
    [61344] = { hide = true }, -- Well Fed
    [61335] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_blue.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Magicka_Recovery), tooltip = T.Drink_Crafted_Health_Magicka }, -- Health + Magicka Drink
    [61336] = { hide = true }, -- Well Fed
    [61339] = { hide = true }, -- Well Fed
    [61350] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_purple.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Primary_Stat_Recovery), tooltip = T.Drink_Crafted_Triple }, -- Triple Drink
    [72816] = { icon = 'LuiExtended/media/icons/consumables/consumable_orzorga_red_frothgar.dds', name = A.Drink_Orzorgas_Red_Frothgar }, -- Orzorga's Red Frothgar
    [61354] = { hide = true }, -- Well Fed: Magicka Regen
    [100488] = { icon = 'LuiExtended/media/icons/consumables/consumable_spring-loaded_infusion.dds' }, -- Spring-Loaded Infusion
    [100490] = { hide = true }, -- Magicka Consumable
    [100489] = { hide = true }, -- Stamina Consumable

    -- Crafted Seasonal Food
    [84681] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_crisp_and_crunchy_pumpkin.dds', name = A.Food_Pumpkin_Snack_Skewer }, -- Crisp and Crunchy Pumpkin Snack Skewer
    [84709] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_crunchy_spider_skewer.dds' }, -- Crunchy Spider Skewer
    [84725] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_frosted_brains.dds', name = A.Food_Frosted_Brains }, -- Frosted Brains
    [84678] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_green.dds' }, -- Sweet Sanguine Apples (Generic shared id for other seasonal magicka food)
    [86789] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_alcaire_festival_sword-pie.dds' }, -- Alcaire Festival Sword-Pie
    [86749] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_jagga-drenched_mud_ball.dds', name = A.Food_Jagga_Drenched_Mud_Ball }, -- Jagga-Drenched "Mud Ball"
    [86673] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_lava_foot_soup-and-saltrice.dds', name = A.Food_Lava_Foot_Soup }, -- Lava Foot Soup-and-Saltrice
    [86787] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_rajhins_sugar_claws.dds' }, -- Rajhin's Sugar Claws
    [89955] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_candied_jesters_coins.dds' }, -- Candied Jester's Coins

    -- Crafted Seasonal Drink
    [84700] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_bowl_of_peeled_eyeballs.dds', name = A.Drink_Bowl_of_Peeled_Eyeballs }, -- Bowl of "Peeled Eyeballs"
    [84735] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_double_bloody_mara.dds', tooltip = T.Drink_Double_Bloody_Mara }, -- Double Bloody Mara
    [84720] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_ghastly_eye_bowl.dds', name = A.Drink_Ghastly_Eye_Bowl }, -- Ghastly Eye Bowl
    [84704] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_witchmothers_party_punch.dds' }, -- Witchmother's Party Punch
    [84731] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_witchmothers_potent_brew.dds' }, -- Witchmother's Potent Brew
    [86677] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_bergama_warning_fire.dds', name = A.Drink_Bergama_Warning_Fire }, -- Bergama Warning Fire
    [86746] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_betnikh_twice-spiked_ale.dds', name = A.Drink_Betnikh_Twice_Spiked_Ale }, -- Betnikh Twice-Spiked Ale
    [86559] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_hissmir_fish-eye_rye.dds', name = A.Drink_Hissmir_Fish_Eye_Rye, tooltip = T.Drink_Hissmir }, -- Hissmir Fish-Eye Rye
    [86791] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_snow_bear_glow-wine.dds', name = A.Drink_Snow_Bear_Glow_Wine }, -- Snow Bear Glow-Wine
    [89957] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_dubious_camoran_throne.dds' }, -- Dubious Camoran Throne
    [89971] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_jewels_of_misrule.dds' }, -- Jewels of Misrule

    -- Vendor Food & Drink
    [66551] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds', tooltip = T.Food_Vendor_Health }, -- Vendor Health Food
    [66568] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds', tooltip = T.Food_Vendor_Magicka }, -- Vendor Magicka Food
    [66576] = { icon = 'LuiExtended/media/icons/consumables/consumable_food_white.dds', tooltip = T.Food_Vendor_Stamina }, -- Vendor Stamina Food
    [66586] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Recovery), tooltip = T.Drink_Vendor_Health }, -- Vendor Health Drink
    [66590] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Magicka_Recovery), tooltip = T.Drink_Vendor_Magicka }, -- Vendor Magicka Drink
    [66594] = { icon = 'LuiExtended/media/icons/consumables/consumable_drink_white.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Stamina_Recovery), tooltip = T.Drink_Vendor_Stamina }, -- Vendor Stamina Drink

    -- AVA Food & Drink
    [72961] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_bar.dds', name = A.Food_Magicka_Stamina_Increase, tooltip = T.Food_Cyrodilic_Field_Bar }, -- Cyrodilic Field Bar
    [72956] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tack.dds', name = A.Food_Health_Stamina_Increase, tooltip = T.Food_Cyrodilic_Field_Tack }, -- Cyrodilic Field Tack
    [72959] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_treat.dds', name = A.Food_Health_Magicka_Increase, tooltip = T.Food_Cyrodilic_Field_Treat }, -- Cyrodilic Field Treat
    [72971] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tonic.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Magicka_Stamina_Recovery), tooltip = T.Drink_Cyrodilic_Field_Tonic }, -- Cyrodilic Field Tonic
    [72965] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_brew.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Stamina_Recovery), tooltip = T.Drink_Cyrodilic_Field_Brew }, -- Cyrodilic Field Brew
    [72968] = { icon = 'LuiExtended/media/icons/consumables/consumable_ava_field_tea.dds', name = zo_strformat("<<1>> <<2>>", A.Drink_Increase, A.Drink_Health_Magicka_Recovery), tooltip = T.Drink_Cyrodilic_Field_Tea }, -- Cyrodilic Field Tea

    -- Crown Food & Drink
    [85484] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_crate_food.dds', name = A.Food_Crown_Crate_Meal, tooltip = T.Food_Crown_Crate_Meal }, -- Crown Crate Fortifying Meal
    [68411] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_food.dds', name = A.Food_Crown_Meal, tooltip = T.Food_Crown_Meal }, -- Crown Fortifying Meal
    [85497] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_crate_drink.dds', name = A.Drink_Crown_Crate_Drink, tooltip = T.Drink_Crown_Crate_Drink }, -- Crown Crate Refreshing Drink
    [68416] = { icon = 'LuiExtended/media/icons/consumables/consumable_crown_drink.dds', name = A.Drink_Crown_Drink, tooltip = T.Drink_Crown_Drink }, -- Crown Refreshing Drink
    [92435] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_magickahealth_food.dds', name = A.Food_Crown_Combat_Mystics_Stew }, -- Crown Combat Mystic's Stew
    [92474] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_staminahealth_food.dds', name = A.Food_Crown_Vigorous_Ragout }, -- Crown Vigorous Ragout
    [92433] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_magickahealth_drink.dds', name = A.Drink_Crown_Stout_Magic_Liqueur }, -- Crown Stout Magic Liqueur
    [92476] = { icon = 'LuiExtended/media/icons/consumables/consumable_crowncrate_staminahealth_drink.dds', name = A.Drink_Crown_Vigorous_Tincture }, -- Crown Vigorous Tincture

    -- Experience Bonuses
    [64210] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_psijic_ambrosia.dds', name = A.Experience_Psijic_Ambrosia, tooltip = T.Experience_Psijic_Ambrosia }, -- Psijic Ambrosia
    [89683] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_aetherial_ambrosia.dds', name = A.Experience_Aetherial_Ambrosia, tooltip = T.Experience_Aetherial_Ambrosia }, -- Aetherial Ambrosia
    [88445] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_mythic_aetherial_ambrosia.dds', name = A.Experience_Mythic_Ambrosia, tooltip = T.Experience_Mythic_Aetherial_Ambrosia }, -- Mythic Aetherial Ambrosia
    [66776] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_scroll.dds', name = A.Experience_Crown_Scroll, tooltip = T.Experience_Crown }, -- Crown Experience Scroll
    [85501] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_1.dds', name = A.Experience_Crown_Crate_Scroll_1, tooltip = T.Experience_Gold_Coast }, -- Gold Coast Experience Scroll
    [85502] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_2.dds', name = A.Experience_Crown_Crate_Scroll_2, tooltip = T.Experience_Major_Gold_Coast }, -- Major Gold Coast Experience Scroll
    [85503] = { icon = 'LuiExtended/media/icons/consumables/consumable_xp_cratescroll_3.dds', name = A.Experience_Crown_Crate_Scroll_3, tooltip = T.Experience_Grand_Gold_Coast }, -- Grand Gold Coast Experience Scroll

    -- Other
    [113432] = { icon = 'esoui/art/icons/achievement_su_groupboss_2.dds', name = zo_strformat("<<1>> <<2>>", A.Innate_Summon, A.Innate_Nascent_Indrik) }, -- 68235 Stun (Nascent Indrik)
    [70582] = { hide = true }, -- Roll 1d1000 (Merethic Restorative Resin)
    [63427] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fillet_fish.dds', name = A.Innate_Fillet_Fish }, -- Clean Fish
    [78052] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_pardon_edict_low.dds', name = A.Innate_Pardon_Edict_Low }, -- Minor Pardon
    [76350] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_pardon_edict_medium.dds', name = A.Innate_Pardon_Edict_Medium }, -- Moderate Pardon
    [76349] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_pardon_edict_high.dds', name = A.Innate_Pardon_Edict_High }, -- Full Pardon

    -- Seasonal Mementos & Items
    [86792] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_festival_mints.dds', name = A.Consumable_Festival_Mints }, -- Eating (High Hrothgar Festival Mints)
    [86794] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_festival_mints.dds', name = A.Consumable_Festival_Mints, tooltip = T.Event_Festival_Mints, unbreakable = 1 }, -- Very Cold (High Hrothgar Festival Mints)
    [86739] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_festival_grog.dds', name = A.Consumable_Sailors_Grog }, -- Drinking (Sailor's Warning Festival Grog)
    [86740] = { icon = 'LuiExtended/media/icons/consumables/consumable_event_festival_grog.dds', name = A.Consumable_Sailors_Grog, tooltip = T.Event_Festival_Grog, unbreakable = 1 }, -- Very Drunk (Sailor's Warning Festival Grog)
    [85355] = {icon = 'LuiExtended/media/icons/abilities/ability_event_torch_juggling.dds', name = A.Memento_Fire_Breathers_Torches, unbreakable = 1 }, -- Flame Juggling (Consumable Version)
    [85354] = {icon = 'LuiExtended/media/icons/abilities/ability_event_knife_juggling.dds', name = A.Memento_Jugglers_Knives, unbreakable = 1 }, -- Dagger Juggling (Consumable Verison)
    [85353] = {icon = 'LuiExtended/media/icons/abilities/ability_event_sword_swallowing.dds', name = A.Memento_Sword_Swallowers_Blade, unbreakable = 1 }, -- Sword Swallowing (Consumable Version)
    [86774] = { icon = 'esoui/art/icons/achievement_newlifefestival_001.dds', name = A.Memento_Mud_Ball }, -- Mudball (Mud Ball Pouch)
    [87964] = { icon = 'LuiExtended/media/icons/abilities/ability_event_dazzler_1.dds', name = A.Consumable_Sparkwreath_Dazzler }, -- Jester's Festival Illusion Daz (Sparkwreath Dazzler)
    [87965] = { icon = 'LuiExtended/media/icons/abilities/ability_event_dazzler_1.dds', name = A.Consumable_Plume_Dazzler }, -- Jester's Festival Illusion Daz (Plume Dazzler)
    [87966] = { icon = 'LuiExtended/media/icons/abilities/ability_event_dazzler_1.dds', name = A.Consumable_Spiral_Dazzler }, -- Jester's Festival Illusion Daz (Spiral Dazzler)
    [88374] = { icon = 'LuiExtended/media/icons/abilities/ability_event_dazzler_2.dds', name = A.Skill_Sparkly_Hat_Dazzler }, -- Jester's Festival Illusion Daz (Sparkly Hat Dazzler)
    [87963] = { icon = 'LuiExtended/media/icons/abilities/ability_event_flower_garland.dds', name = A.Memento_Cherry_Blossom_Branch }, -- Bestowed Cherry Blossoms (Cherry Blossom Branch)
    [116879] = { icon = 'esoui/art/icons/event_jestersday_pie1.dds', name = A.Consumable_Revelry_Pie }, -- Alliance Pie (Revelry Pie)
    [116942] = { tooltip = T.Event_Revelry_Pie }, -- Covered in Pie (Revelry Pie)
    [116944] = { tooltip = T.Event_Revelry_Pie }, -- Covered in Pie (Revelry Pie)
    [116943] = { tooltip = T.Event_Revelry_Pie }, -- Covered in Pie (Revelry Pie)
    [102077] = { icon = 'LuiExtended/media/icons/mementos/memento_jesters_scintillator.dds', name = A.Memento_Jesters_Scintillator, unbreakable = 1 }, -- Jester's Festival Scintillator (Jester's Scintillator)
    [77027] = { hide = true }, -- Anniversary Cake - Forreals (Jubilee Cake)
    [87998] = { hide = true }, -- Anniversary Cake (2nd Annual Jubilee Cake)
    [102009] = { hide = true }, -- Anniversary Cake (3rd Annual Jubilee Cake)
    [77123] = { icon = 'LuiExtended/media/icons/mementos/memento_event_jubilee_cake.dds', name = A.Memento_Jubliee_Cake, tooltip = T.Experience_Seasonal_Event }, -- Anniversary EXP Buff (Other Jubilee Cake)
    [118985] = { icon = 'LuiExtended/media/icons/mementos/memento_event_jubilee_cake.dds', name = A.Memento_Jubliee_Cake, tooltip = T.Experience_Seasonal_Event }, -- Anniversary EXP Buff (2019 Jubilee Cake)
    [81575] = { icon = 'LuiExtended/media/icons/mementos/memento_witchmothers_whistle.dds', name = A.Memento_Witchmothers_Whistle, hide = true }, -- Event - WitchFest Cauldron (Witchmother's Whistle)
    [96118] = { icon = 'LuiExtended/media/icons/abilities/ability_event_witchmothers_brew.dds', tooltip = T.Experience_Seasonal_Event } , -- Witchmother's Boon (Witchmother's Whistle)
    [84364] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [84365] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [84366] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [84367] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [84368] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [84369] = { icon = 'esoui/art/icons/achievement_witchesfestival_01.dds' }, -- Witchmother's Brew (Witchmother's Whistle)
    [91369] = { icon = 'LuiExtended/media/icons/abilities/ability_event_steamy_spring_pie.dds', name = A.Memento_The_Pie_of_Misrule, tooltip = T.Experience_Seasonal_Event }, -- Jester's Experience Boost Pie (The Pie of Misrule)
    [92232] = { icon = 'LuiExtended/media/icons/abilities/ability_event_pelinals_ferocity.dds', tooltip = T.Experience_Seasonal_Pelinal }, -- Pelinal's Ferocity (Scroll of Pelinal's Ferocity)
    [91449] = { icon = 'LuiExtended/media/icons/abilities/ability_event_bredas_magnificent_mead.dds', tooltip = T.Experience_Seasonal_Event }, -- Breda's Magnificent Mead (Breda's Bottomless Mead Mug)
    [86075] = { icon = 'LuiExtended/media/icons/abilities/ability_event_bredas_magnificent_mead.dds', tooltip = T.Experience_Seasonal_Event }, -- Breda's Magnificent Mead (Breda's Magnificent Mead)

    -- Base Mementos
    [26829] = { icon = 'LuiExtended/media/icons/mementos/memento_almalexias_enchanted_lantern.dds', name = A.Memento_Almalexias_Lantern, unbreakable = 1, tooltip = T.Memento_Almalexias_Lantern }, -- Light of the Tribunal (Almalexia's Enchanted Lantern)
    [26736] = { icon = 'LuiExtended/media/icons/mementos/memento_battered_bear_trap.dds', name = A.Memento_Battered_Bear_Trap }, -- Bear Trap (Battered Bear Trap)
    [16846] = { icon = 'LuiExtended/media/icons/mementos/memento_blackfeather_court_whistle.dds', hide = true }, -- Blackfeather Court Whistle (Blackfeather Court Whistle)
    [41988] = {icon = 'LuiExtended/media/icons/mementos/memento_bonesnap_binding_stone.dds', unbreakable = 1, tooltip = T.Memento_Bonesnap_Binding_Talisman }, -- Bonesnap Binding Stone (Bonesnap Binding Stone)
    [39245] = {icon = 'LuiExtended/media/icons/mementos/memento_discourse_amaranthine.dds', name = A.Memento_Discourse_Amaranthine, unbreakable = 1, tooltip = T.Memento_Discourse_Amaranthine }, -- Glimpse of the Forbidden (Discoure Amaranthine)
    [41950] = { icon = 'LuiExtended/media/icons/mementos/memento_fetish_of_anger.dds', tooltip = T.Memento_Fetish_of_Anger, unbreakable = 1 }, -- Fetish of Anger (Fetish of Anger)
    [21226] = { icon = 'LuiExtended/media/icons/mementos/memento_finvirs_trinket.dds', tooltip = T.Memento_Finvirs_Trinket, unbreakable = 1 }, -- Finvir's Trinket (Finvir's Trinket)
    [41948] = { icon = 'LuiExtended/media/icons/mementos/memento_glanirs_smoke_bomb.dds' }, -- Glanir's Smoke Bomb (Glanir's Smoke Bomb)
    [25703] = { hide = true }, -- Justal's Falcon (Justal's Falcon)
    [43700] = { hide = true, icon = 'LuiExtended/media/icons/mementos/memento_lenas_wand_of_finding.dds', name = A.Menento_Lenas_Wand_of_Finding }, -- Wand of Finding (Lena's Wand of Finding)
    [43702] = { hide = true }, -- Invis Chicken Delay (Lena's Wind of Finding)
    [43703] = { hide = true }, -- Extracting... (Lena's Wind of Finding)
    [43704] = { hide = true }, -- Extracting... (Lena's Wind of Finding)
    [43701] = { hide = true }, -- Extracting... (Lena's Wind of Finding)
    [42076] = { icon = 'LuiExtended/media/icons/mementos/memento_mezha-dros_sealing_amulet.dds', name = A.Memento_Sealing_Amulet, unbreakable = 1 }, -- Tear (Mezha-dro's Sealing Amulet)
    [42105] = { icon = 'LuiExtended/media/icons/mementos/memento_nanwens_sword.dds' }, -- Nanwen's Sword (Nanwen's Sword)
    [34578] = { icon = 'LuiExtended/media/icons/mementos/memento_nirnroot_wine.dds', unbreakable = 1 }, -- Nirnroot Wine (Nirnroot Wine)
    [26339] = { icon = 'LuiExtended/media/icons/mementos/memento_questionable_meat_sack.dds', name = A.Memento_Mystery_Meat, unbreakable = 1, tooltip = T.Memento_Mystery_Meat }, -- Questionable Meat Sack (Questionable Meat Sack)
    [25369] = { icon = 'LuiExtended/media/icons/mementos/memento_sanguines_goblet.dds', name = A.Memento_Sanguines_Goblet, unbreakable = 1, tooltip = T.Memento_Sanguines_Goblet }, -- Sanguine's Goblet (Sanguine's Goblet)
    [42008] = { icon = 'LuiExtended/media/icons/mementos/memento_token_of_root_sunder.dds', name = A.Memento_Token_of_Root_Sunder, unbreakable = 1, tooltip = T.Memento_Token_of_Root_Sunder }, -- Blessing of Root Sunder (Token of Root Sunder)
    [42053] = { icon = 'LuiExtended/media/icons/mementos/memento_yokudan_totem.dds', name = A.Memento_Yokudan_Totem, unbreakable = 1 }, -- Yokudan Salute (Yokudan Totem)

    -- DLC Mementos
    [89550] = { icon = 'LuiExtended/media/icons/mementos/memento_twilight_shard.dds', name = A.Memento_Twilight_Shard, unbreakable = 1 }, -- TROPHY Azura's Light (Twilight Shard)
    [79510] = { icon = 'LuiExtended/media/icons/mementos/memento_blade_of_the_blood_oath.dds', name = A.Memento_Blade_of_the_Blood_Oath, unbreakable = 1 }, -- TROPHY Blood Oath (Blade of the Blood Oath)

    [92862] = { hide = true, icon = 'LuiExtended/media/icons/mementos/memento_dreamers_chime.dds', name = A.Memento_Dreamers_Chime, unbreakable = 1 }, -- Dreamers Chime (Ringing Bell)
    [92863] = { hide = true }, -- Dreamers Chime (Stun)
    [77785] = { hide = true }, -- Rain of Coins (Coin of Illusory Riches)
    [77786] = { icon = 'LuiExtended/media/icons/mementos/memento_coin_of_illusory_riches.dds', name = A.Memento_Coin_of_Illusory_Riches, unbreakable = 1 }, -- Stun (Coin of Illusory Riches)

    [74151] = { icon = 'LuiExtended/media/icons/mementos/memento_hidden_pressure_vent.dds', name = A.Memento_Hidden_Pressure_Vent, unbreakable = 1 }, -- Stun (Hidden Pressure Vent)
    [73685] = { hide = true }, -- Rkindaleft Trophy (Hidden Pressure Vent)
    [73686] = { hide = true, icon = 'LuiExtended/media/icons/mementos/memento_malacaths_wrathful_flame.dds', name = A.Memento_Malacaths_Wrathful_Flame }, -- Old Orsinium Trophy (Malacath's Wrathful Flame)
    [74232] = { hide = true }, -- Stun (Malacath's Wrathful Flame)

    -- Crown Store Mementos
    [85344] = { icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_aura.dds', name = A.Memento_Storm_Atronach_Aura, forcedContainer = 'short', tooltip = T.Memento_Storm_Atronach_Aura, unbreakable = 1 }, -- Atronach Aura (Storm Atronach Aura)
    [85349] = { icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_transform.dds', name = A.Memento_Storm_Atronach_Transform, tooltip = T.Memento_Storm_Atronach_Transform, unbreakable = 1 }, -- Storm Atronach Transform (Atronach Transformation)
    [85347] = { icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_juggle.dds', name = A.Memento_Storm_Orb_Juggle, unbreakable = 1 }, -- Storm Orb Juggle (Atronach Juggling)
    [86976] = { icon = 'LuiExtended/media/icons/mementos/memento_wild_hunt_leaf-dance_aura.dds', name = A.Memento_Wild_Hunt_Aura, forcedContainer = 'short', tooltip = T.Memento_Wild_Hunt_Leaf_Dance_Aura, unbreakable = 1 }, -- Spriggan Aura (Wild Hunt Leaf-Dance Aura)
    [86977] = {icon = 'LuiExtended/media/icons/mementos/memento_wild_hunt_transform.dds', name = A.Memento_Wild_Hunt_Transform, tooltip = T.Memento_Wild_Hunt_Transform, unbreakable = 1 }, -- Spriggan Transformation (Wild Hunt Transform)
    [86978] = { icon = 'LuiExtended/media/icons/mementos/memento_floral_swirl_aura.dds', name = A.Memento_Floral_Swirl_Aura, forcedContainer = 'short', tooltip = T.Memento_Floral_Swirl_Aura, unbreakable = 1 }, -- Grand Spriggan Aura (Floral Swirl Aura)
    [92866] = { icon = 'LuiExtended/media/icons/mementos/memento_dwarven_puzzle_orb.dds', name = A.Memento_Dwarven_Puzzle_Orb, unbreakable = 1, tooltip = T.Memento_Dwarven_Puzzle_Orb }, -- Dwarven Globe (Dwarven Puzzle Orb)
    [92867] = { icon = 'LuiExtended/media/icons/mementos/memento_dwarven_tonal_forks.dds', name = A.Memento_Dwarven_Tonal_Forks, unbreakable = 1, tooltip = T.Memento_Dwarven_Tonal_Forks }, -- Dwarven Tuning Forks (Dwarven Tonal Forks)
    [92868] = {icon = 'LuiExtended/media/icons/mementos/memento_dwemervamidium_mirage.dds', name = A.Memento_Dwemervamidium_Mirage, unbreakable = 1, tooltip = T.Memento_Dwemervamidium_Mirage }, -- Dwarven Transformation (Dwemervamidium Mirage)
    [97273] = { icon = 'LuiExtended/media/icons/mementos/memento_crows_calling.dds', name = A.Memento_Crows_Calling, unbreakable = 1 }, -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [97274] = { icon = 'esoui/art/icons/achievement_update16_017.dds', name = A.Memento_Swarm_of_Crows, unbreakable = 1, tooltip = T.Memento_Swarm_of_Crows }, -- Swarm of Crows (Swarm of Crows)
    [98378] = { hide = true }, -- Murderous Strike (Murderous Strike)
    [99318] = { icon = 'LuiExtended/media/icons/mementos/memento_fiery_orb.dds', name = A.Memento_Fiery_Orb, unbreakable = 1 }, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    [99319] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_pixie.dds', name = A.Memento_Flame_Pixie, unbreakable = 1 }, -- Flame Crate Memento 2 (Flame Pixie)
    [99320] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_eruption.dds', name = A.Memento_Flame_Eruption, unbreakable = 1 }, -- TROPHY Flame Crate Mem 3 (Flame Eruption)
    [101874] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_frost_shard.dds', name = A.Memento_Frost_Shard, unbreakable = 1 }, -- _CRWN Dragon Priest Mem2 Ice T (Scalecaller Frost Shard)
    [101877] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_rune_of_levitation.dds', name = A.Memento_Rune_of_Levitation, unbreakable = 1 }, -- _CRWN Dragon Priest Mem1 Fl/St (Scalecaller Rune of Levitation)
    [101872] = { icon = 'LuiExtended/media/icons/mementos/memento_bone_dragon_summons_focus.dds', name = A.Memento_Dragon_Summons_Focus, unbreakable = 1 }, -- _CRWN Dragon Priest Memento3 (Bone Dragon Summons Focus)
    [104324] = { icon = 'LuiExtended/media/icons/mementos/memento_psijic_celestial_orb.dds', name = A.Memento_Psijic_Celestial_Orb, unbreakable = 1 }, -- Psijic Pearl Summon (Psijic Celestial Orb)
    [104323] = { icon = 'LuiExtended/media/icons/mementos/memento_psijic_tautology_glass.dds', name = A.Memento_Psijic_Tautology_Glass, unbreakable = 1 }, -- Psijic Hourglass (Psijic Tautology Glass)
    [104325] = { icon = 'LuiExtended/media/icons/mementos/memento_sapiarchic_discorporation_lens.dds', name = A.Memento_Sapiarchic_Discorporation, unbreakable = 1, hide = true }, -- Psijic Disintegrate (Sapiarchic Discorporation Lens)
    [110482] = { icon = 'LuiExtended/media/icons/mementos/memento_rind_renewing_pumpkin.dds', unbreakable = 1 }, -- Rind-Renewing Pumpkin (Rind-Renewing Pumpkin)
    [110481] = { icon = 'LuiExtended/media/icons/mementos/memento_gourd_gallows_stump.dds', unbreakable = 1 }, -- Gourd-Gallows Stump (Gourd-Gallows Stump)
    [110483] = { icon = 'LuiExtended/media/icons/mementos/memento_ghost_lantern.dds', name = A.Memento_Ghost_Lantern, unbreakable = 1, tooltip = T.Memento_Ghost_Lantern }, -- Ghost Lantern (Ghost Lantern)

    [113288] = { icon = 'LuiExtended/media/icons/mementos/memento_mire_drum.dds', name = A.Memento_Mire_Drum, unbreakable = 1 }, -- U20 Crown Memento 1 (Mire Drum)
    [113291] = { icon = 'LuiExtended/media/icons/mementos/memento_vossa_satl.dds', name = A.Memento_Vossa_Satl, unbreakable = 1 }, -- U20 Crown Memento 2 (Vossa-satl)

    -- Non-Combat Pets
    [76364] = { hide = true }, -- _CRWN_5s (Echalette)
    [76365] = { hide = true }, -- _CRWN_Echalette_Buck (Echalette)
    [76367] = { hide = true }, -- _CRWN_ResetPosture (Echalette)
    [76368] = { hide = true }, -- _CRWN_1s (Turquoise Nixad)
    [78642] = { hide = true }, -- _CRWN_Jackal_Mouse (Jackal)
    [78643] = { hide = true }, -- _CRWN_Jackal_Digging (Jackal)

    [72955] = { hide = true }, -- _CRWN Pet Goat,Black (Sanguine's Black Goat)
    [81352] = { hide = true }, -- _CRWN_12.5s (Spotted Snow Senche-Leopard)

    -- Assistants
    [77645] = { hide = true }, -- Stealth (Pirharri the Smuggler)

    ----------------------------------------------------------------
    -- ENCHANTS ----------------------------------------------------
    ----------------------------------------------------------------

    [28919] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_health.dds' }, -- Life Drain (Glyph of Absorb Health)
    [28921] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_health.dds' }, -- Life Drain (Glyph of Absorb Health)
    [46743] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_magicka.dds' }, -- Absorb Magicka (Glyph of Absorb Magicka)
    [46744] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_magicka.dds' }, -- Absorb Magicka (Glyph of Absorb Magicka)
    [46746] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_stamina.dds' }, -- Absorb Stamina (Glyph of Absorb Stamina)
    [46747] = { icon = 'LuiExtended/media/icons/glyphs/glyph_absorb_stamina.dds' }, -- Absorb Stamina (Glyph of Absorb Stamina)
    [17906] = { icon = 'LuiExtended/media/icons/glyphs/glyph_crushing.dds', name = A.Item_Glyph_of_Crushing, tooltip = T.Item_Glyph_of_Crushing }, -- Crusher (Glyph of Crushing)
    [46749] = { icon = 'LuiExtended/media/icons/glyphs/glyph_decrease_health.dds', name = A.Item_Glyph_of_Decrease_Health }, -- Damage Health (Glyph of Decrease Health)
    [17895] = { icon = 'LuiExtended/media/icons/glyphs/glyph_flame.dds' }, -- Fiery Weapon (Glyph of Flame)
    [17904] = { icon = 'LuiExtended/media/icons/glyphs/glyph_foulness.dds' }, -- Befouled Weapon (Glyph of Foulness)
    [17897] = { icon = 'LuiExtended/media/icons/glyphs/glyph_frost.dds' }, -- Frozen Weapon (Glyph of Frost)
    --[17947] = { icon = 'LuiExtended/media/icons/glyphs/glyph_hardening.dds', name = A.Item_Glyph_of_Hardening }, -- Hardening (Glyph of Hardening) (DUMMY EVENT }, HERE JUST IN CASE)
    [21578] = { icon = 'LuiExtended/media/icons/glyphs/glyph_hardening.dds', name = A.Item_Glyph_of_Hardening, tooltip = T.Item_Glyph_of_Hardening }, -- Hardening (Glyph of Hardening)
    [17902] = { icon = 'LuiExtended/media/icons/glyphs/glyph_poison.dds' }, -- Poisoned Weapon (Glyph of Poison)
    [40337] = { icon = 'LuiExtended/media/icons/glyphs/glyph_prismatic.dds' }, -- Primatic Weapon (Glyph of Prismatic Onslaught)
    [17899] = { icon = 'LuiExtended/media/icons/glyphs/glyph_shock.dds' }, -- Charged Weapon (Glyph of Shock)
    [17945] = { icon = 'LuiExtended/media/icons/glyphs/glyph_weakening.dds', name = A.Item_Glyph_of_Weakening, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Item_Glyph_of_Weakening, }, -- Weakening (Glyph of Weakening)
    --[17910] = { icon = 'LuiExtended/media/icons/glyphs/glyph_weapon_damage.dds', name = A.Item_Glyph_of_Weapon_Damage }, -- Weapon Damage (Glyph of Weapon Damage) (DUMMY EVENT }, HERE JUST IN CASE)
    [21230] = { icon = 'LuiExtended/media/icons/glyphs/glyph_weapon_damage.dds', name = A.Item_Glyph_of_Weapon_Damage, tooltip = T.Item_Glyph_of_Weapon_Damage }, -- Berserker (Glyph of Weapon Damage) (Added in case ever needed)

    ----------------------------------------------------------------
    -- STATUS EFFECT PROCS -----------------------------------------
    ----------------------------------------------------------------

    [18084] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_burning.dds', tooltip = T.Generic_Burn_2_Sec }, -- Burning (Fire Status Effect)
    [21925] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_diseased.dds' }, -- Diseased (Disease Status Effect)
    [21927] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_diseased.dds', tooltip = A.Proc_Diseased }, -- Major Defile (Disease Status Effect)
    [21481] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_chill.dds', name = A.Proc_Chilled }, -- Chill (Frost Status Effect)
    [68368] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_chill.dds', tooltip = A.Proc_Chilled }, -- Minor Maim (Frost Status Effect)
    [21929] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_poisoned.dds', tooltip = T.Generic_Poison_2_Sec }, -- Poisoned (Poison Status Effect)
    [21487] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_concussion.dds' }, -- Concussion (Shock Status Effect)
    [68359] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_proc_concussion.dds', tooltip = A.Proc_Concussion }, -- Minor Vulnerability (Shock Status Effect)

    ----------------------------------------------------------------
    -- MUNDUS STONE BOONS ------------------------------------------
    ----------------------------------------------------------------

    [13940] = { tooltip = T.Boon_Warrior }, -- Boon: The Warrior
    [13943] = { tooltip = T.Boon_Mage }, -- Boon: The Mage
    [13974] = { tooltip = T.Boon_Serpent }, -- Boon: The Serpent
    [13975] = { tooltip = T.Boon_Thief }, -- Boon: The Thief
    [13976] = { tooltip = T.Boon_Lady }, -- Boon: The Lady
    [13977] = { tooltip = T.Boon_Steed }, -- Boon: The Steed
    [13978] = { tooltip = T.Boon_Lord }, -- Boon: The Lord
    [13979] = { tooltip = T.Boon_Apprentice }, -- Boon: The Apprentice
    [13980] = { tooltip = T.Boon_Ritual }, -- Boon: The Ritual
    [13981] = { tooltip = T.Boon_Lover }, -- Boon: The Lover
    [13982] = { tooltip = T.Boon_Atronach }, -- Boon: The Atronach
    [13984] = { tooltip = T.Boon_Shadow }, -- Boon: The Shadow
    [13985] = { tooltip = T.Boon_Tower }, -- Boon: The Tower

    ----------------------------------------------------------------
    -- EQUIPMENT ---------------------------------------------------
    ----------------------------------------------------------------

    -- Asylum Weapons
    [100302] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_piercing_spray.dds', tooltip = T.Set_Asylum_Bow }, -- Piercing Spray (Asylum Bow)
    [100294] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_disciplined_slash.dds' }, -- Disciplined Slash (Asylum 2H)
    [100462] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Asylum 1H + Shield)
    [100464] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Asylum 1H + Shield)
    [100308] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_timeless_blessing.dds', tooltip = T.Set_Aslyum_Restoration_Staff }, -- Timeless Blessing (Asylum Restoration Staff)
    [100306] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_concentrated_force.dds', tooltip = T.Set_Asylum_Destruction_Staff }, -- Concentrated Force (Asylum Destruction Staff)

    -- Asylum Weapons (Perfected)
    [99363] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_piercing_spray.dds', tooltip = T.Set_Asylum_Bow_Perfect }, -- Piercing Spray (Perfected) (Perfected Asylum Bow)
    [99361] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_disciplined_slash.dds' }, -- Disciplined Slash (Perfected) (Perfected Asylum 2H)
    [99920] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Perfected) (Perfected Asylum 1H + Shield)
    [99919] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_defensive_position.dds' }, -- Defensive Position (Perfected) (Perfected Asylum 1H + Shield)
    [99582] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_timeless_blessing.dds', tooltip = T.Set_Aslyum_Restoration_Staff_P }, -- Timeless Blessing (Perfected) (Perfected Asylum Restoration Staff)
    [99989] = { icon = 'LuiExtended/media/icons/abilities/ability_set_asylum_concentrated_force.dds', name = A.Set_Asylum_Destruction_Staff, tooltip = T.Set_Asylum_Destruction_Staff_P }, -- Concentrated Force (P) (Asylum Destruction Staff)

    -- Maelstrom Weapons
    [99806] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_cruel_flurry.dds', tooltip = T.Set_Maelstrom_DW }, -- Cruel Flurry (Maelstrom Dual Wield)
    [99789] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_merciless_charge.dds', tooltip = T.Generic_Bleed_1_Sec }, -- Merciless Charge (Maelstrom 2H)
    [100588] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds', tooltip = T.Set_Maelstrom_1H }, -- Rampaging Slash (Maelstrom 1H + Shield)
    [100587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds' }, -- Rampaging Slash (Maelstrom 1H + Shield)
    [100589] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_rampaging_slash.dds' }, -- Rampaging Slash (Maelstrom 1H + Shield)
    [99887] = { icon = 'LuiExtended/media/icons/abilities/ability_set_maelstrom_precise_regeneration.dds' }, -- Precise Regeneration (Maelstrom Restoration Staff)

    -- Master Weapons
    [99761] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_puncturing_remedy.dds' }, -- Puncturing Remedy (Master 1H + shield)
    [100575] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_puncturing_remedy.dds', tooltip = T.Set_Master_1H }, -- Puncturing Remedy (Master 1H + shield)
    [99781] = { icon = 'LuiExtended/media/icons/abilities/ability_set_master_grand_rejuvenation.dds' }, -- Grand Rejuvenation (Master Restoration Staff)

    -- Blackrose Weapons
    [113617] = { name = A.Skill_Major_Protection, tooltip = A.Set_Blackrose_DW }, -- Spectral Cloak (Blackrose DW)
    [113619] = { hide = true }, -- Virulent Shot (Blackrose Bow) -- SHOWS ONLY ON TARGET PLAYERS
    [113627] = { icon = 'LuiExtended/media/icons/abilities/ability_set_virulent_shot.dds', tooltip = T.Generic_Poison_2_Sec }, -- Virulent Shot (Blackrose Bow)
    [113553] = { icon = 'LuiExtended/media/icons/abilities/ability_set_radial_uppercut.dds' }, -- Radial Uppercut (Blackrose 2H)
    [113608] = { icon = 'LuiExtended/media/icons/abilities/ability_set_gallant_charge.dds', tooltip = T.Set_Blackrose_1H }, -- Gallant Charge (Blackrose 1H)
    [115003] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds', tooltip = T.Set_Blackrose_Destro_Staff }, -- Wild Impulse (Blackrose Destruction Staff)
    [114988] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds' }, -- Wild Impulse (Blackrose Destruction Staff)
    [115005] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds' }, -- Wild Impulse (Blackrose Destruction Staff)
    [115006] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wild_impulse.dds' }, -- Wild Impulse (Blackrose Destruction Staff)
    [113653] = { tooltip = A.Set_Blackrose_Resto_Staff }, -- Major Vitality (Blackrose Restoration Staff)

    -- Monster Sets
    [111505] = { icon = 'esoui/art/icons/vmh_killhulks.dds', tooltip = T.Set_Balorgh }, -- Balorgh (Balorgh)
    [59517] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_blood_spawn.dds', tooltip = T.Generic_Phy_Spell_Resist_Duration }, -- Blood Spawn (Blood Spawn)
    [61274] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_blood_spawn.dds' }, -- Blood Spawn (Blood Spawn)
    [59590] = { tooltip = T.Set_Bogdan_the_Nightflame }, -- Imperial Prison Item Set (Bogdan the Nightflame)
    [59591] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_bogdan.dds', name = A.Set_Bogdan_the_Nightflame, groundLabel = true, tooltip = T.Generic_AOE_Heal_1_Sec }, -- Bogdan Totem (Bogdan the Nightflame)
    [81069] = { hide = true }, -- Chokethorn (Chokethorn)
    [81077] = { icon = 'esoui/art/icons/mh_hedgeguardian_strang.dds', tooltip = T.Generic_HoT_08Sec }, -- Chokethorn (Chokethorn)
    [97901] = { tooltip = T.Set_Domihaus_Stamina_Damage }, -- Domihaus (Domihaus)
    [97900] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_stone.dds', forcedContainer = 'short', groundLabel = true, tooltip = T.Set_Domihaus_Stamina_Buff }, -- Domihaus (Domihaus)
    [97899] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_stone.dds', groundLabel = true, tooltip = T.Generic_AOE_Physical_1_Sec }, -- Domihaus (Domihaus)
    [97882] = { tooltip = T.Set_Domihaus_Magicka_Damage }, -- Domihaus (Domihaus)
    [97896] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_fire.dds', forcedContainer = 'short', groundLabel = true, tooltip = T.Set_Domihaus_Magicka_Buff }, -- Domihaus (Domihaus)
    [97883] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_domihaus_fire.dds', groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, -- Domihaus (Domihaus)
    [97855] = { tooltip = T.Set_Earthgore }, -- Earthgore (Earthgore)
    [97857] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_earthgore.dds', groundLabel = true, tooltip = T.Generic_AOE_Heal_1_Sec }, -- Earthgore (Earthgore)
    [84504] = { icon = 'esoui/art/icons/achievement_update11_dungeons_033.dds', tooltip = T.Set_Grothdarr }, -- Grothdarr (Grothdarr)
    [84502] = { icon = 'esoui/art/icons/achievement_update11_dungeons_033.dds', groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, -- Grothdarr (Grothdarr)
    [80562] = { icon = 'esoui/art/icons/achievement_wrothgar_042.dds', tooltip = T.Set_Iceheart }, -- Iceheart (Iceheart)
    [80561] = { icon = 'esoui/art/icons/achievement_wrothgar_042.dds' }, -- Iceheart (Iceheart)
    [80529] = { tooltip = T.Set_Ilambris_Shock }, -- Ilambris (Ilambris)
    [80526] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_ilambris_shock.dds', groundLabel = true, tooltip = T.Generic_AOE_Shock_1_Sec }, -- Ilambris (Ilambris)
    [80527] = { tooltip = T.Set_Ilambris_Fire }, -- Ilambris (Ilambris)
    [80525] = { icon = 'esoui/art/icons/ava_siege_ui_002.dds', groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, -- Ilambris (Ilambris)
    [83405] = { hide = true }, -- Infernal Guardian (Infernal Guardian)
    [83409] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_infernal_guardian.dds' }, -- Infernal Guardian (Infernal Guardian)
    [80566] = { hide = true }, -- Kra'gh (Kra'gh)
    [80565] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_kragh.dds' }, -- Kra'gh (Kra'gh)
    [59586] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_lord_warden.dds', name = A.Set_Lord_Warden_Dusk, duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = T.Set_Lord_Warden_Ground }, -- Lord Warden (Lord Warden)
    [59587] = { tooltip = T.Set_Lord_Warden_Buff }, -- Lord Warden (Lord Warden)
    [59568] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds', name = A.Set_Malubeth_the_Scourger, tooltip = T.Set_Malubeth }, -- Scourge Harvest (Malubeth)
    [59573] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_malubeth.dds', name = A.Set_Malubeth_the_Scourger }, -- Scourge Harvest (Malubeth)
    [59508] = { icon = 'esoui/art/icons/achievement_ic_020.dds', name = A.Set_Maw_of_the_Infernal, tooltip = T.Set_Maw_of_the_Infernal }, -- Banished Cells Item Set (Maw of the Infernal)
    [60974] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_maw_of_the_infernal.dds'}, -- Jagged Claw (Maw of the Infernal)
    [60972] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds'}, -- Fiery Breath (Maw of the Infernal)
    [60973] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds'}, -- Fiery Jaws (Maw of the Infernal)
    [80482] = { tooltip = A.Set_Mighy_Chudan }, -- Major Ward (Mighty Chudan)
    [91983] = { tooltip = A.Set_Mighy_Chudan }, -- Major Resolve (Mighty Chudan)
    [66808] = { icon = 'LuiExtended/media/icons/abilities/ability_set_molag_kena.dds', tooltip = T.Set_Molag_Kena }, -- Molag Kena (Molag Kena)
    [66812] = { icon = 'LuiExtended/media/icons/abilities/ability_set_molag_kena.dds', tooltip = T.Set_Molag_Kena_Overkill }, -- Overkill (Molag Kena)
    [59593] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_nerieneth.dds', name = A.Set_Nerieneth }, -- Lich Crystal (Nerien'eth)
    [98421] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [98419] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [98420] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [81675] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [83288] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [83287] = { tooltip = T.Set_Pirate_Skeleton }, -- Pirate Skeleton
    [80853] = { tooltip = A.Set_Pirate_Skeleton }, -- Major Protection (Pirate Skeleton)
    [85637] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Set_Pirate_Skeleton }, -- Minor Defile (Pirate Skeleton)
    [80606] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_selene.dds' }, -- Selene (Selene)
    [80607] = { hide = true }, -- Dummy (Selene)
    [80609] = { hide = true }, -- Dummy (Selene)
    [80544] = { icon = 'esoui/art/icons/achievement_thievesguild_021.dds' }, -- Sellistrix (Sellistrix)
    [80549] = { icon = 'esoui/art/icons/achievement_thievesguild_021.dds', tooltip = T.Generic_Stun }, -- Sellistrix (Sellistrix)
    [81036] = { hide = true, tooltip = T.Set_Sentinel_of_Rkugamz }, -- Sentinel of Rkugamz
    [81038] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds', groundLabel = true, tooltip = T.Generic_AOE_Heal_1_Sec }, -- Sentinel of Rkugamz
    [81041] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_heal.dds' }, -- Sentinel of Rkugamz
    [80955] = { hide = true }, -- Shadowrend (Shadowrend)
    [80954] = { hide = true, tooltip = T.Set_Shadowrend }, -- Shadowrend Summon (Shadowrend)
    [80980] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_shadowrend_headbutt.dds', name = A.Skill_Headbutt }, -- Shadowrend (Shadowrend)
    [80990] = { icon = 'esoui/art/icons/ability_debuff_minor_maim.dds', tooltip = A.Set_Shadowrend }, -- Minor Maim (Shadowrend)
    [80989] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_shadowrend_tail_spike.dds', name = A.Skill_Tail_Spike }, -- Shadowrend (Shadowrend)
    [81034] = { tooltip = A.Set_Shadowrend }, -- Minor Maim (Shadowrend)
    [80481] = { tooltip = A.Set_Slimecraw }, -- Minor Berserk (Slimecraw)
    [59497] = { tooltip = T.Set_Spawn_of_Mephala }, -- Spawn of Mephala (Spawn of Mephala)
    [59498] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', name = A.Set_Spawn_of_Mephala, groundLabel = true, tooltip = T.Skill_Spawn_of_Mephala_Ground }, -- Mephala's Web (Spawn of Mephala)
    [59499] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', name = A.Set_Spawn_of_Mephala, duration = 0, groundLabel = true, tooltip = T.Skill_Spawn_of_Mephala_Ground, hideGround = true }, -- Mephala's Web (Spawn of Mephala)
    [80523] = { tooltip = T.Set_Stormfist }, -- Stormfist (Stormfist)
    [80522] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_stormfist.dds', groundLabel = true, tooltip = T.Skill_Stormfist_Ground }, -- Stormfist (Stormfist)
    [80521] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_stormfist.dds' }, -- Stormfist (Stormfist)
    [84419] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = A.Set_Swarm_Mother },
    [80593] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = A.Set_Swarm_Mother },
    [59522] = { hide = true }, -- Engine Guardian
    [59540] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_stamina.dds', name = A.Set_Engine_Guardian, tooltip = T.Set_Engine_Guardian_Stamina }, -- Engine Guardian Stamina
    [59533] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_magicka.dds', name = A.Set_Engine_Guardian, tooltip = T.Set_Engine_Guardian_Magicka }, -- Engine Guardian Magicka
    [59543] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_engine_guardian_health.dds', name = A.Set_Engine_Guardian, tooltip = T.Set_Engine_Guardian_Health }, -- Engine Guardian Health
    [80504] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_regeneration.dds', name = A.Set_The_Troll_King, tooltip = T.Set_The_Troll_King }, -- The Troll King
	[102094] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_thurvokun.dds', groundLabel = true, tooltip = T.Generic_AOE_Disease_1_Sec }, -- Thurvokun
    [102097] = { tooltip = A.Set_Thurvokun }, -- Minor Maim (Thurvokun)
    [102100] = { tooltip = A.Set_Thurvokun }, -- Minor Defile (Thurvokun)
    [102093] = { tooltip = T.Set_Thurvokun }, -- Thurvokun (Thurvokun)
    [80865] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds' }, -- Tremorscale
    [80866] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds', tooltip = T.Generic_Snare_70 }, -- Tremorscale
    [59596] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_valkyn_skoria.dds' }, -- Valkyn Skoria
    [61273] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_valkyn_skoria.dds' }, -- Valkyn Skoria
    [80490] = { icon = 'esoui/art/icons/achievement_update11_dungeons_035.dds' }, -- Velidreth
    [111354] = { tooltip = A.Set_Vykosa }, -- Major Maim (Vykosa)
    [102136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_zaan.dds', tooltip = T.Set_Zaan }, -- Zaan
    [102142] = { hide = true }, -- Zaan

    [116839] = { icon = 'esoui/art/icons/ability_skeevatonschock.dds', name = A.Set_Energy_Charge, tooltip = T.Set_Energy_Charge }, -- Charging (Stonekeeper)
    [116847] = { icon = 'esoui/art/icons/achievement_frostvault_killmonstersb.dds' }, -- Stonekeeper (Stonekeeper)
    [116877] = { icon = 'esoui/art/icons/achievement_frostvault_killmonstersb.dds' }, -- Stonekeeper (Stonekeeper)
    [116878] = { icon = 'esoui/art/icons/achievement_frostvault_killmonstersb.dds' }, -- Stonekeeper (Stonekeeper)
    [116880] = { hide = true }, -- Stonekeeper (Stonekeeper)

    [117111] = { icon = 'esoui/art/icons/achievement_depthsofmalatar_killmonstersb.dds', tooltip = T.Set_Meridias_Favor }, -- Meridia's Favor (Symphony of Blades)
    [117118] = { icon = 'esoui/art/icons/achievement_depthsofmalatar_killmonstersb.dds' }, -- Meridia's Favor (Symphony of Blades)
    [117119] = { icon = 'esoui/art/icons/achievement_depthsofmalatar_killmonstersb.dds' }, -- Meridia's Favor (Symphony of Blades)

    -- Crafted Sets
    [34502] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ashen_grip.dds' }, -- Ashen Grip
    [34592] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', tooltip = T.Set_Alessias_Bulwark }, -- Alessia's Bulwark
    [75746] = { icon = 'LuiExtended/media/icons/abilities/ability_set_clever_alchemist.dds', tooltip = T.Set_Clever_Alchemist }, -- Clever Alchemist
    [92774] = { tooltip = A.Set_Daedric_Trickery }, -- Major Mending (Daedric Trickery)
    [92771] = { tooltip = A.Set_Daedric_Trickery }, -- Major Expedition (Daedric Trickery)
    [92775] = { tooltip = A.Set_Daedric_Trickery }, -- Major Heroism (Daedric Trickery)
    [92776] = { tooltip = A.Set_Daedric_Trickery }, -- Major Vitality (Daedric Trickery)
    [92773] = { tooltip = A.Set_Daedric_Trickery }, -- Major Protection (Daedric Trickery)
    [33764] = { icon = 'LuiExtended/media/icons/abilities/ability_set_deaths_wind.dds', tooltip = T.Generic_Knockback }, -- Death's Wind
    [52289] = { icon = 'LuiExtended/media/icons/abilities/ability_set_deaths_wind.dds', hide = true }, -- Death's Wind
    [75930] = { tooltip = T.Set_Eternal_Hunt }, -- Eternal Hunt
    [75929] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds' }, -- Eternal Hunt
    [76533] = { icon = 'LuiExtended/media/icons/abilities/ability_set_eternal_hunt.dds', tooltip = T.Generic_Immobilize }, -- Eternal Hunt
    [86555] = { name = A.Skill_Major_Evasion, tooltip = A.Set_Hist_Bark }, -- Hist Bark
    [57207] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kagrenacs_hope.dds', hide = true }, -- Kagrenac's Hope
    [34381] = { hide = true }, -- Magnus
    [99204] = { icon = 'esoui/art/icons/achievement_update16_015.dds', tooltip = T.Set_Mechanical_Acuity }, -- Mechanical Acuity (of Mechanical Acuity)
    [71671] = { hide = true, tooltip = T.Set_Morkuldin }, -- Morkuldin (Morkuldin)
    [71678] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_light_attack.dds' }, -- Light Attack (Morkuldin)
    [71679] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morkuldin_cleave.dds' }, -- Cleave (Morkuldin)
    [61784] = { icon = 'esoui/art/icons/achievement_028.dds', name = A.Set_Redistribution, hide = true }, -- Redistribution
    [49126] = { icon = 'esoui/art/icons/achievement_update15_036.dds' }, -- Shalidor's Curse
    [75726] = { icon = 'LuiExtended/media/icons/abilities/ability_set_tavas_favor.dds', tooltip = T.Set_Tavas_Favor }, -- Tava's Favor
    [61851] = { hide = true }, -- Armor Master
    [61870] = { icon = 'esoui/art/icons/ava_siege_hookpoint_005.dds', tooltip = T.Generic_Phy_Spell_Resist_Duration }, -- Armor Master
    [34386] = { tooltip = A.Skill_Night_Mothers_Gaze }, -- Major Fracture (Night Mother's Gaze)
    [61781] = { icon = 'LuiExtended/media/icons/abilities/ability_set_nobles_conquest.dds' }, -- Noble's Conquest
    [61782] = { tooltip = A.Skill_Nobles_Conquest }, -- Minor Vulnerability (Noble's Conquest)
    [34587] = { icon = 'esoui/art/icons/achievement_021.dds' }, -- Song of Lamae
    [34588] = { icon = 'esoui/art/icons/achievement_021.dds' }, -- Song of Lamae
    [71067] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_melee_alt.dds', tooltip = T.Set_Trials_Shock }, -- Trial by Shock (Trials)
    [71058] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_melee_alt.dds', tooltip = T.Set_Trials_Fire }, -- Trial by Fire (Trials)
    [71019] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cold_melee_alt.dds', tooltip = T.Set_Trials_Frost }, -- Trial by Frost (Trials)
    [71072] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_melee_alt.dds', tooltip = T.Set_Trials_Poison }, -- Trial by Poison (Trials)
    [71069] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_disease_melee_alt.dds', tooltip = T.Set_Trials_Disease }, -- Trial by Disease (Trials)
    [79089] = { icon = 'esoui/art/icons/achievement_ic_survival.dds', name = A.Set_Varens_Legacy, tooltip = T.Set_Varens_Legacy }, -- Varen's Wall (Varen's Legacy)
    [79093] = { hide = true }, -- Remove Trigger (Varen's Legacy)
    [57170] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vampires_kiss.dds', tooltip = T.Generic_HoT_2Sec }, -- Vampire's Kiss
    [49236] = { icon = 'LuiExtended/media/icons/abilities/ability_set_whitestrake.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Whitestake's Retribution (Whitestrake's)
    [106776] = { forcedContainer = 'short', tooltip = A.Set_Adept_Rider }, -- Major Evasion (Adept Rider's)
    [106790] = { forcedContainer = 'short', tooltip = A.Set_Adept_Rider, groundLabel = true }, -- Major Evasion (Adept Rider's)
    [106783] = { name = A.Set_Dust_Cloud, groundLabel = true, tooltip = T.Generic_AOE_Physical_1_Sec }, -- Dustcloud Damage (Adept Rider's)
    [106784] = { tooltip = T.Set_Adept_Rider }, -- Dustcloud (Adept Rider's)
    [106804] = { icon = 'esoui/art/icons/achievement_su_mainquest_6.dds', name = A.Set_Nocturnals_Favor }, -- Nocturnal's Heal (Nocturnal's Favor)
    [106798] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sloads_semblance.dds', tooltip = T.Generic_Oblivion_1_Sec }, -- Sload's Semblance (Sload's)
    [113092] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sloads_semblance.dds', name = A.Set_Sloads_Semblance, hide = true }, -- Sload's Projectile (Sloads)
    [113185] = { icon = 'esoui/art/icons/mm_teaser.dds' }, -- Grave-Stake Collector (Grave-Stake Collector)
    [113237] = { icon = 'esoui/art/icons/mm_teaser.dds' }, -- Grave-Stake Collector (Grave-Stake Collector)
    [113312] = { stack = 3, tooltip = A.Set_Might_of_the_Lost_Legion }, -- Empower (Might of the Lost Legion)
    [114945] = { stack = 2, tooltip = A.Set_Might_of_the_Lost_Legion }, -- Empower (Might of the Lost Legion)
    [114952] = { stack = 1, tooltip = A.Set_Might_of_the_Lost_Legion }, -- Empower (Might of the Lost Legion)
    [113306] = { tooltip = A.Set_Naga_Shaman }, -- Minor Vitality (Naga Shaman)
    [113307] = { tooltip = A.Set_Naga_Shaman }, -- Minor Mending (Naga Shaman)

    -- Overland Sets (Light)
    [75691] = { tooltip = T.Set_Bahrahas_Curse }, -- Bahraha's Curse
    [75707] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds' }, -- Bahraha's Curse
    [75692] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', groundLabel = true, tooltip = T.Skill_Bahrahas_Curse_Ground }, -- Bahraha's Curse
    [75706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', tooltip = T.Skill_Bahrahas_Curse_Ground, groundLabel = true, hideGround = true }, -- Bahraha's Curse
    [34522] = { icon = 'esoui/art/icons/achievement_wrothgar_012.dds' }, -- Bloodthorn's Touch (Bloodthorn)
    [57177] = { icon = 'esoui/art/icons/achievement_wrothgar_012.dds' }, -- Bloodthorn's Touch (Bloodthorn)
    [48913] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dreamers_mantle.dds', tooltip = T.Generic_Knockdown }, -- Dreamer's Mantle (Dreamer's)
    [57133] = { icon = 'LuiExtended/media/icons/abilities/ability_set_dreamers_mantle.dds' }, -- Dreamer's Mantle (Dreamer's)
    [85776] = { icon = 'esoui/art/icons/achievement_update11_dungeons_010.dds' }, -- Robes of the Hist (of Hist Sap)
    [52705] = { icon = 'LuiExtended/media/icons/abilities/ability_set_martial_knowledge.dds', tooltip = T.Set_Way_of_Martial_Knowledge }, -- Way of Martial Knowledge (of Martial Knowledge)
    [85825] = { icon = 'esoui/art/icons/achievement_update16_011.dds' }, -- Prisoner's Rags (Prisoner's)
    [79200] = { tooltip = A.Set_Sithis_Touch }, -- Major Berserk (Sithis' Touch)
    [85592] = { tooltip = A.Set_Skooma_Smuggler }, -- Major Expedition (Skooma Smuggler)
    [34506] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syrabane.dds' }, -- Syrabane's Grip (of Syrabane)
    [57173] = { icon = 'LuiExtended/media/icons/abilities/ability_set_withered_hand.dds' }, -- Withered Hand
    [57175] = { icon = 'LuiExtended/media/icons/abilities/ability_set_withered_hand.dds', hide = true }, -- Withered Hand
    [71657] = { icon = 'LuiExtended/media/icons/abilities/ability_set_trinimacs_valor.dds' }, -- Trinimac's Valor
    [71658] = { icon = 'LuiExtended/media/icons/abilities/ability_set_trinimacs_valor.dds' }, -- Trinimac's Valor
    [93026] = { hide = true }, -- Mad Tinkerer (Mad Tinkerer's)
    [92982] = { hide = true }, -- Mad Tinkerer (Mad Tinkerer's)
    [93002] = { icon = 'esoui/art/icons/achievement_update16_029.dds' }, -- Mad Tinkerer (Mad Tinkerer's)
    [93003] = { icon = 'esoui/art/icons/achievement_update16_029.dds', hide = true }, -- Mad Tinkerer (Mad Tinkerer's)
    [93001] = { icon = 'esoui/art/icons/achievement_update16_029.dds', tooltip = T.Generic_Knockback }, -- Mad Tinkerer (Mad Tinkerer's)
    [106806] = { tooltip = A.Set_Wisdom_of_Vanus }, -- Major Mending (Wisdom of Vanus)

    -- Overland Sets (Medium)
    [71106] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds' }, -- Briarheart
    [71107] = { tooltip = T.Set_Briarheart }, -- Briarheart
    [93308] = { hide = true }, -- Defiler
    [93307] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds' }, -- Defiler
    [93305] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds', tooltip = T.Generic_Stun }, -- Defiler
    [93326] = { hide = true }, -- Defiler
    [100704] = { hide = true }, -- Defiler
    [34875] = { icon = 'LuiExtended/media/icons/abilities/ability_set_night_terror.dds' }, -- Night Terror (of Night Terror)
    [34611] = { icon = 'esoui/art/icons/perks_fighters_guild_002.dds', tooltip = T.Set_Senche }, -- Senche's Bite (Senche's)
    [76344] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syvarras_scales.dds', name = A.Set_Syvarras_Scales, hide = true }, -- Serpent's Spirit (Syvarra's Scales)
    [75718] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syvarras_scales.dds', name = A.Set_Syvarras_Scales, tooltip = T.Generic_Poison_1_Sec }, -- Serpent's Spirit (Syvarra's Scales)
    [52709] = { icon = 'LuiExtended/media/icons/abilities/ability_set_way_of_air.dds', tooltip = T.Generic_Weapon_Spell_Damage_Duration }, -- Way of Air (of the Air)
    [34383] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_infernal_guardian.dds' }, -- Shadow of the Red Mountain (of the Red Mountain)
    [34817] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twin_sisters.dds', name = A.Set_Twin_Sisters, tooltip = T.Generic_Bleed_2_Sec }, -- Twin Sisters Bleed
    [34870] = { icon = 'LuiExtended/media/icons/abilities/ability_set_wilderqueen.dds', tooltip = T.Generic_Snare_30 }, -- Wilderqueen's Arch (of the Wilderqueen)
    [99268] = { icon = 'LuiExtended/media/icons/abilities/ability_set_unfathomable_darkness.dds', tooltip = T.Set_Unfathomable_Darknesss }, -- Unfathomable Darkness (of Unfathomable Darkness)
    [99267] = { icon = 'LuiExtended/media/icons/abilities/ability_set_unfathomable_darkness.dds', hide = true }, -- Unfathomable Darkness (of Unfathomable Darkness)
    [34508] = { icon = 'LuiExtended/media/icons/abilities/ability_set_werewolf_hide.dds' }, -- Hide of the Werewolf (Werewolf Hide)
    [18993] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds' }, -- Witchman Armor (Witchman's)
    [85818] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds' }, -- Witchman Armor (Witchman's)
    [106860] = { tooltip = A.Set_Gyphons_Ferocity }, -- Minor Expedition (Gyphon's Ferocity)
    [106861] = { tooltip = A.Set_Gyphons_Ferocity }, -- Minor Force (Gyphon's Ferocity)
    [114977] = { icon = 'esoui/art/icons/achievement_murkmire_friend_dead_water.dds' }, -- Dead-Water's Guile (Dead-Water's Guile)

    -- Overland Sets (Heavy)
    [34711] = { icon = 'LuiExtended/media/icons/abilities/ability_set_meridia.dds', tooltip = T.Generic_Blind }, -- Meridia's Blessed Armor (Blessed)
    [57298] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds', hide = true }, -- Draugr's Heritage
    [57296] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds', tooltip = T.Generic_Knockdown }, -- Draugr's Heritage
    [57297] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_heritage.dds' }, -- Draugr's Heritage
    [99286] = { icon = 'esoui/art/icons/achievement_vvardenfel_046.dds' }, -- Livewire
    [79123] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morihaus.dds' }, -- Hide of Morihaus (of Morihaus)
    [79112] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morihaus.dds', tooltip = T.Generic_Knockdown }, -- Hide of Morihaus (of Morihaus)
    [34526] = { icon = 'LuiExtended/media/icons/abilities/ability_set_seventh_legion.dds', tooltip = T.Generic_Weapon_Damage_Duration }, -- Seventh Legion Brute (Seventh Legion)
    [57186] = { icon = 'LuiExtended/media/icons/abilities/ability_set_seventh_legion.dds' }, -- Seventh Legion Brute (Seventh Legion)
    [85593] = { tooltip = A.Set_Shalk_Exoskeleton }, -- Minor Heroism (Shalk's)
    [85594] = { icon = 'esoui/art/icons/ability_buff_minor_heroism.dds' }, -- Minor Heroism (Shalk's)
    [52711] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_melee.dds', name = A.Set_Way_of_Fire }, -- Fiery Weapon (Way of Fire)
    [112523] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hatchlings_shell.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Hatchling's Shell (of the Hatchling's Shell)
    [85565] = { tooltip = A.Set_Order_of_Diagna }, -- Minor Vitality (Order of Diagna)
    [57210] = { icon = 'LuiExtended/media/icons/abilities/ability_set_storm_knight.dds', tooltip = T.Set_Storm_Knight }, -- Storm Knight's Plate (of the Storm Knight)
    [57209] = { icon = 'LuiExtended/media/icons/abilities/ability_set_storm_knight.dds' }, -- Storm Knight's Plate (of the Storm Knight)
    [85551] = { tooltip = A.Set_Vampire_Cloak }, -- Minor Protection (Vampire's Cloak)
    [33514] = { icon = 'esoui/art/icons/perks_fighters_guild_003.dds', tooltip = T.Generic_Weapon_Damage_Duration }, -- Armor of the Veiled Heritance (of the Veiled Heritance)
    [33497] = { icon = 'esoui/art/icons/achievement_vvardenfel_035.dds' }, -- Thunderbug's Carapace (Thunderbug's)
    [92762] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds', tooltip = A.Set_Warrior_Poet }, -- Minor Toughness (Warrior-Poet's)
    [106865] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grace_of_gloom.dds', tooltip = T.Set_Grace_of_Gloom }, -- Grace of Gloom (Gloom-Graced)
    [106867] = { tooltip = A.Set_Grace_of_Gloom }, -- Major Evasion (Gloom-Graced)
    [106868] = { icon = 'LuiExtended/media/icons/abilities/ability_set_grace_of_gloom.dds' }, -- Grace of Gloom (Gloom-Graced)
    [113284] = { name = A.Skill_Minor_Heroism, tooltip = A.Set_Champion_of_the_Hist }, -- Champion of the Hist (Champion of the Hist)
    [113286] = { icon = 'esoui/art/icons/ability_buff_minor_heroism.dds' }, -- Minor Heroism (Champion of the Hist)

    -- Dungeon Sets (Light)
    [61459] = { icon = 'LuiExtended/media/icons/abilities/ability_set_burning_spellweave.dds', tooltip = T.Generic_Spell_Damage_Duration }, -- Burning Spellweave
    [102027] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds', hide = true }, -- Caluurion's Legacy (Fire)
    [102032] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_frost_ranged.dds', hide = true }, -- Caluurion's Legacy (Frost)
    [102033] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', hide = true }, -- Caluurion's Legacy (Disease)
    [102034] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', hide = true }, -- Caluurion's Legacy (Shock)
    [97538] = { tooltip = T.Set_Draugrs_Rest }, -- Draugr's Rest (Draugr's Rest)
    [97539] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds', groundLabel = true, tooltip = T.Generic_AOE_Heal_1_Sec }, -- Draugr's Rest
    [97574] = { icon = 'LuiExtended/media/icons/abilities/ability_set_flame_blossom.dds' }, -- Flame Blossom
    [84341] = { tooltip = A.Set_Gossamer }, -- Major Evasion (Gossamer)
    [85610] = { icon = 'esoui/art/icons/achievement_021.dds' }, -- Lamia's Song (Lamia's)
    [67129] = { icon = 'LuiExtended/media/icons/abilities/ability_set_overwhelming.dds', tooltip = T.Set_Overwhelming_Surge }, -- Overwhelming Surge (Overwhelming)
    [67136] = { icon = 'LuiExtended/media/icons/abilities/ability_set_overwhelming.dds' }, -- Overwhelming Surge (Overwhelming)
    [34504] = { icon = 'LuiExtended/media/icons/abilities/ability_set_prayer.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Prayer Shawl (of Prayer)
    [32834] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hircine.dds', tooltip = T.Set_Sanctuary }, -- Sanctuary (of Sanctuary)
    [66902] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_courage.dds', tooltip = A.Set_Spell_Power_Cure }, -- Spell Power Cure
    [67098] = { icon = 'LuiExtended/media/icons/abilities/ability_set_combat_physician.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Combat Physician (of the Combat Physician)
    [57164] = { icon = 'esoui/art/icons/achievement_ic_014.dds', tooltip = T.Set_Shroud_of_the_Lich }, -- Shroud of the Lich (of the Lich)
    [34813] = { icon = 'LuiExtended/media/icons/abilities/ability_set_magicka_furnace.dds' }, -- Magicka Furnace (of the Magicka Furnace)
    [34373] = { name = A.Set_Noble_Duelist, tooltip = T.Generic_LA_HA_Damage_Duration }, -- Noble Duelist's Silks (Noble Duelist)
    [67288] = { icon = 'esoui/art/icons/ava_siege_hookpoint_002.dds', tooltip = T.Generic_Spell_Damage_Duration }, -- Scathing Mage (of the Scathing Mage)
    [59676] = { icon = 'LuiExtended/media/icons/abilities/ability_set_undaunted_unweaver.dds', tooltip = T.Generic_LA_HA_Damage_Duration }, -- Undaunted Unweaver (of the Undaunted Unweaver)
    [57163] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_027.dds' }, -- Robes of the Warlock (of the Warlock)
    [47367] = { icon = 'LuiExtended/media/icons/abilities/ability_set_worm_cult.dds', tooltip = T.Set_Worms_Raiment }, -- Worm's Raiment (of the Worm Cult)
    [85613] = { tooltip = A.Set_Treasure_Hunter }, -- Major Prophecy (Treasure Hunter's)
    [111377] = { tooltip = A.Set_Hanus_Compassion }, -- Major Heroism (Hanu's Compassion)
    [111380] = { tooltip = A.Set_Hanus_Compassion }, -- Major Heroism (Hanu's Compassion)
    [111204] = { icon = 'esoui/art/icons/achievement_thievesguild_003.dds', tooltip = T.Set_Moon_Hunter }, -- Moon Hunter (Moon Hunter)

    [117666] = { icon = 'LuiExtended/media/icons/abilities/ability_set_icy_conjuror.dds', hide = true }, -- Icy Conjuror
    [116727] = { icon = 'LuiExtended/media/icons/abilities/ability_set_icy_conjuror.dds', tooltip = T.Generic_Freeze_1_Sec }, -- Icy Conjuror (Icy Conjuror)

    [116884] = { icon = 'LuiExtended/media/icons/abilities/ability_set_aurorans_thunder.dds', tooltip = T.Set_Aurorans_Thunder }, -- Auroran's Thunder (Auroran's Thunder)
    [116920] = { icon = 'LuiExtended/media/icons/abilities/ability_set_aurorans_thunder.dds' }, -- Auroran's Thunder (Auroran's Thunder)

    -- Dungeon Sets (Medium)
    [85977] = { icon = 'LuiExtended/media/icons/abilities/ability_set_barkskin.dds' }, -- Barkskin
    [85978] = { icon = 'LuiExtended/media/icons/abilities/ability_set_barkskin.dds' }, -- Barkskin
    [84310] = { tooltip = A.Set_Heem_Jas }, -- Major Berserk (Heem-Jas' Retribution)
    [47365] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hircine.dds', tooltip = T.Set_Hircines_Veneer }, -- Hircine's Veneer (Hircine's)
    [85602] = { tooltip = A.Set_Jailbreaker }, -- Minor Expedition (Jailbreaker)
    [34612] = { hide = true }, -- Oblivion's Edge (of Oblivion)
    [57206] = { icon = 'LuiExtended/media/icons/abilities/ability_set_oblivion.dds' }, -- Oblivion's Edge (of Oblivion)
    [97716] = { icon = 'LuiExtended/media/icons/abilities/ability_set_pillar_of_nirn.dds' }, -- Pillar of Nirn
    [97743] = { icon = 'LuiExtended/media/icons/abilities/ability_set_pillar_of_nirn.dds', tooltip = T.Generic_Bleed_2_Sec }, -- Pillar of Nirn
    [102106] = { tooltip = T.Set_Plague_Slinger }, -- Skeever Corpse (Plague Slinger)
    [102113] = { icon = 'LuiExtended/media/icons/abilities/ability_set_plague_slinger.dds'} , -- Plague Slinger
    [67141] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sheer_venom.dds', tooltip = T.Generic_Poison_1_Sec }, -- Sheer Venom
    [60060] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sunderflame.dds' }, -- Sunderflame
    [85635] = { icon = 'LuiExtended/media/icons/abilities/ability_set_spelunker.dds' }, -- Spelunker (Spelunker's)
    [70297] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_melee.dds' }, -- Storm Master (Storm Master's)
    [70298] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_melee.dds', tooltip = T.Set_Storm_Master }, -- Storm Master (Storm Master's)
    [60416] = { tooltip = A.Set_Sunderflame }, -- Minor Fracture (Sunderflame)
    [108825] = { tooltip = A.Set_Sunderflame }, -- Minor Breach (Sunderflame)
    [49220] = { hide = true }, -- Extra dodge (of the Crusader)
    [67334] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds', tooltip = T.Set_Essence_Thief }, -- Essence Thief (of the Essence Thief)
    [70284] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds' }, -- Essence Thief (of the Essence Thief)
    [70290] = { icon = 'LuiExtended/media/icons/abilities/ability_set_essence_thief.dds' }, -- Essence Thief (of the Essence Thief)
    [59667] = { icon = 'LuiExtended/media/icons/abilities/ability_set_undaunted_infiltrator.dds', tooltip = T.Generic_LA_HA_Damage_Duration }, -- Undaunted Infiltrator (of the Undaunted Infiltrator)
    [33691] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vipers_sting.dds', tooltip = T.Generic_Poison_1_Sec }, -- Viper's Sting
    [85605] = { tooltip = A.Set_Toothrow }, -- Major Savagery (Toothrow)
    [101970] = { icon = 'LuiExtended/media/icons/abilities/ability_set_invigoration.dds' }, -- Trappings of Invigoration
    [84350] = { icon = 'esoui/art/icons/achievement_update11_dungeons_035.dds' }, -- Widowmaker
    [111387] = { icon = 'esoui/art/icons/mh_no_rage_cleanse.dds', tooltip = T.Set_Blood_Moon_Scent }, -- Blood Scent (Blood Moon)
    [111386] = { icon = 'LuiExtended/media/icons/abilities/ability_set_blood_moon.dds', tooltip = T.Set_Blood_Moon_Frenzied }, -- Frenzied (Blood Moon)
    [111216] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_bleed.dds', tooltip = T.Generic_Bleed_2_Sec }, -- Savage Werewolf (Savage Werewolf)

    [116742] = { icon = 'esoui/art/icons/achievement_wrothgar_003.dds', tooltip = T.Set_Tzogvins_Warband }, -- Precision (Tzogvin's Warband)
    [116775] = { tooltip = A.Set_Tzogvins_Warband, hide = true }, -- Minor Force (Tzogvin's Warband)

    [116954] = { hide = true }, -- Stalked (Scavenging Demise)
    [116991] = { icon = 'LuiExtended/media/icons/abilities/ability_set_scavenging_demise.dds', name = A.Set_Scavenging_Demise }, -- Stalked (Scavenging Demise)
    [117025] = { tooltip = A.Set_Scavenging_Demise }, -- Minor Vulnerability (Scavenging Demise)

    -- Dungeon Sets (Heavy)
    [102023] = { icon = 'LuiExtended/media/icons/abilities/ability_set_curse_of_doylemish.dds' }, -- Curse of Doylemish
    [34527] = { tooltip = A.Set_Duroks_Bane }, -- Durok's Bane Major Defile (of Durok's Bane)
    [47362] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ebon.dds', tooltip = T.Set_Ebon_Armory }, -- Ebon Armory (Ebon)
    [59695] = { icon = 'LuiExtended/media/icons/abilities/ability_set_embershield.dds', tooltip = T.Set_Embershield }, -- Embershield (Embershield)
    [59696] = { icon = 'LuiExtended/media/icons/abilities/ability_set_embershield.dds' }, -- Embershield (Embershield)
    [97908] = { tooltip = T.Set_Hagravens_Garden}, -- Hagraven's Garden (Hagraven's)
    [97918] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds' }, -- Hagraven's Garden (Hagraven's)
    [114802] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds', name = A.Set_Hagravens_Garden, tooltip = T.Generic_Knockback }, -- Stun (Hagraven's)
    [34404] = { icon = 'LuiExtended/media/icons/abilities/ability_set_ice_furnace.dds', name = A.Set_Ice_Furnace }, -- Frostfire (Ice Furnace)
    [97626] = { icon = 'esoui/art/icons/achievement_update11_dungeons_036.dds', unbreakable = 1, tooltip = T.Generic_Snare_50 }, -- Ironblood
    [97627] = { tooltip = A.Set_Ironblood }, -- Major Protection (Ironblood)
    [67078] = { icon = 'LuiExtended/media/icons/abilities/ability_set_jolting.dds', tooltip = T.Set_Jolting_Arms }, -- Jolting Arms (Jolting)
    [67080] = { icon = 'LuiExtended/media/icons/abilities/ability_set_jolting.dds', name = A.Set_Jolting_Arms }, -- Shocking Bash (Jolting)
    [85620] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_028.dds' }, -- Knight-Errant's Mail (Knight-Errant's)
    [67205] = { tooltip = T.Set_Leeching_Plate }, -- Leeching Plate (of Leeching)
    [69345] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds' }, -- Leeching Plate (of Leeching)
    [67204] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds', groundLabel = true, tooltip = T.Skill_Leeching_Plate_Ground }, -- Leeching Plate (of Leeching)
    [84277] = { icon = 'esoui/art/icons/achievement_update11_dungeons_006.dds' }, -- Aspect of Mazzatun (of Mazzatun)
    [84278] = { icon = 'esoui/art/icons/achievement_update11_dungeons_006.dds' }, -- Aspect of Mazzatun (of Mazzatun)
    [84279] = { icon = 'esoui/art/icons/achievement_update11_dungeons_006.dds' }, -- Aspect of Mazzatun (of Mazzatun)
    [85611] = { tooltip = A.Set_Medusa }, -- Minor Force (of Medusa)
    [84354] = { tooltip = T.Set_Hand_of_Mephala }, -- Hand of Mephala (Mephala's Hand)
    [84357] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds', name = A.Set_Hand_of_Mephala, duration = 0, tooltip = T.Skill_Hand_of_Mephala_Ground, groundLabel = true }, -- Hand of Mephala Webbing (of Mephala's Hand)
    [84355] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_spawn_of_mephala.dds' }, -- Hand of Mephala (of Mephala's Hand)
    [84358] = { tooltip = A.Set_Hand_of_Mephala }, -- Hand of Mephala (of Mephala's Hand)
    [85623] = { tooltip = A.Set_Rattlecage }, -- Major Sorcery (Rattlecage)
    [32735] = { tooltip = A.Set_Dreugh_King_Slayer }, -- Major Brutality (Dreugh King Slayer)
    [34511] = { tooltip = A.Set_Dreugh_King_Slayer }, -- Major Expedition (Dreugh King Slayer)
    [66887] = { icon = 'LuiExtended/media/icons/abilities/ability_set_imperium.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Brands of the Imperium (of the Imperium)
    [33512] = { tooltip = A.Set_Knightmare }, -- Minor Maim (of the Knightmare)
    [67283] = { icon = 'esoui/art/icons/achievement_ic_025_heroic.dds', name = A.Set_Tormentor, tooltip = T.Generic_Phy_Spell_Resist_Duration }, -- Tormentor Resistance (of the Tormentor)
    [61200] = { icon = 'esoui/art/icons/achievement_undaunteddailies_003.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Undaunted Bastion (of the Undaunted Bastion)
    [86070] = { icon = 'esoui/art/icons/achievement_thievesguild_034.dds', tooltip = T.Generic_Weapon_Damage_Duration }, -- Armor of Truth (of Truth)
    [112414] = { icon = 'LuiExtended/media/icons/abilities/ability_set_haven_of_ursus.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Ursus's Blessing (Haven of Ursus)
    [111445] = { icon = 'LuiExtended/media/icons/abilities/ability_set_haven_of_ursus.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Ursus's Blessing (Haven of Ursus)
    [111221] = { tooltip = A.Set_Jailers_Tenacity }, -- Major Vitality (Jailer's Tenacity)

    [116804] = { tooltip = A.Set_Mighty_Glacier }, -- Major Ward (Mighty Glacier)
    [116805] = { tooltip = A.Set_Mighty_Glacier }, -- Major Resolve (Mighty Glacier)

    [117082] = { icon = 'esoui/art/icons/ability_wrothgar_bitingcold.dds', forcedContainer = 'short', tooltip = T.Set_Frozen_Watcher }, -- Frozen Watcher (Frozen Watcher)
    [117060] = { icon = 'esoui/art/icons/ability_wrothgar_bitingcold.dds' }, -- Frozen Watcher (Frozen Watcher)

    -- Trial Sets (Hel Ra Citadel)
    [50978] = { icon = 'esoui/art/icons/achievement_update11_dungeons_001.dds', tooltip = T.Set_Berserking_Warrior }, -- Berserking Warrior (Advancing Yokeda)
    [90937] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior.dds', unbreakable = 1, tooltip = T.Generic_Immunity }, -- Immortal Warrior (Immortal Yokeda)
    [90938] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Set_Immortal_Warrior, A.Set_Cooldown), tooltip = T.Set_Eternal_Immortal_Warrior }, -- Immortal Warrior (Immortal Yokeda)
    [86907] = { icon = 'LuiExtended/media/icons/abilities/ability_set_defending_warrior.dds' }, -- Defending Warrior (Resilient Yokeda)
    [50992] = { icon = 'LuiExtended/media/icons/abilities/ability_set_defending_warrior.dds' }, -- Defending Warrior (Resilient Yokeda)
    [76618] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_minor_aegis.dds', tooltip = T.Skill_Minor_Aegis }, -- Minor Aegis (Eternal Yokeda)
    [90940] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior.dds', unbreakable = 1, tooltip = T.Generic_Immunity }, -- Eternal Warrior (Eternal Yokeda)
    [61437] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior.dds' }, -- Eternal Warrior (Eternal Yokeda)
    [90939] = { icon = 'LuiExtended/media/icons/abilities/ability_set_immortal_warrior_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Set_Eternal_Warrior, A.Set_Cooldown), tooltip = T.Set_Eternal_Immortal_Warrior }, -- Eternal Warrior (Eternal Yokeda)

    -- Trial Sets (Aetherian Archive)
    [51315] = { icon = 'LuiExtended/media/icons/abilities/ability_set_destructive_mage.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Set_Destructive_Mage }, -- Destructive Mage (Aether... of Destruction)
    [51320] = { icon = 'LuiExtended/media/icons/abilities/ability_set_destructive_mage.dds', name = A.Set_Destructive_Mage }, -- Mage Destruction Bomb (Aether... of Destruction)
    [51443] = { icon = 'LuiExtended/media/icons/abilities/ability_set_healing_mage.dds', name = A.Set_Healing_Mage, tooltip = T.Set_Healing_Mage }, -- Healing Bane (of Mending)
    [51434] = { tooltip = A.Set_Wise_Mage }, -- Minor Vulnerability (Aether ... of Strategy)
    [76617] = { icon = 'esoui/art/icons/achievement_vvardenfel_060.dds', tooltip = T.Skill_Minor_Slayer }, -- Minor Slayer (of the Infallible Aether)
    [81519] = { tooltip = A.Set_Infallible_Mage }, -- Minor Vulnerability (of the Infallible Aether)

    -- Trial Sets (Sanctum Ophidia)
    [51241] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vipers_sting.dds' }, -- Poisonous Serpent (Ophidian ... of Venom)
    [51176] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_010.dds', tooltip = T.Set_Twice_Fanged_Serpent }, -- Twice-Fanged Serpent (of the Two-Fanged Snake)
    [98103] = { icon = 'esoui/art/icons/achievement_vvardenfel_060.dds', tooltip = T.Skill_Minor_Slayer }, -- Minor Slayer (of the Vicious Ophidian)
    [50997] = { tooltip = A.Set_Quick_Serpent }, -- Major Expedition (Ophidian.. of Celerity)
    [81524] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds', name = A.Skill_Major_Expedition, tooltip = A.Set_Vicious_Serpent }, -- Quick Serpent (of the Vicious Ophidian)
    [81522] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicious_serpent.dds', name = A.Set_Vicious_Serpent }, -- Serpent Stamina (of the Vicious Ophidian)

    -- Trial Sets (Maw of Lorkhaj)
    [75801] = { icon = 'LuiExtended/media/icons/abilities/ability_set_moondancer_lunar.dds', tooltip = T.Generic_Magicka_Recovery_Duration }, -- Lunar Blessing (Moondancer)
    [75804] = { icon = 'LuiExtended/media/icons/abilities/ability_set_moondancer_shadow.dds', tooltip = T.Generic_Spell_Damage_Duration }, -- Shadow Blessing (Moondancer)
    [98102] = { icon = 'esoui/art/icons/achievement_vvardenfel_060.dds', tooltip = T.Skill_Minor_Slayer }, -- Minor Slayer (of Alkosh)
    [75752] = { icon = 'LuiExtended/media/icons/abilities/ability_set_alkosh.dds' }, -- Roar of Alkosh (of Alkosh)
    [75753] = { icon = 'LuiExtended/media/icons/abilities/ability_set_alkosh.dds', tooltip = T.Set_Alkosh }, -- Line Breaker (of Alkosh)
    [76667] = { icon = 'LuiExtended/media/icons/abilities/ability_set_alkosh.dds', tooltip = T.Generic_Bleed_1_Sec }, -- Roar of Alkosh (of Alkosh)
    [75815] = { icon = 'LuiExtended/media/icons/abilities/ability_set_lunar_bastion.dds', duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = T.Set_Lunar_Bastion }, -- Lunar Bastion (of the Lunar Bastion)
    [75770] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds', tooltip = T.Generic_HoT_1Sec }, -- Twilight Remedy (of Twilight Remedy)
    [76564] = { tooltip = A.Set_Twilight_Remedy }, -- Minor Force (of Twilight Remedy)

    -- Trial Sets (Halls of Fabrication)
    [93444] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_aegis.dds', tooltip = T.Skill_Major_Aegis }, -- Major Aegis (Automated Defense)
    [93125] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_aegis.dds', tooltip = T.Skill_Major_Aegis }, -- Major Aegis (Inventor's Guard)
    [93120] = { icon = 'esoui/art/icons/achievement_vvardenfel_061.dds', tooltip = T.Skill_Major_Slayer }, -- Major Slayer (Master Architect)
    [93442] = { icon = 'esoui/art/icons/achievement_vvardenfel_061.dds', tooltip = T.Skill_Major_Slayer }, -- Major Slayer (War Machine)

    -- Trial Sets (Cloudrest)
    [107141] = { tooltip = T.Set_Vestment_of_Olorime }, -- Vestment of Olirime (Olirime's)
    [109994] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_courage.dds', tooltip = A.Set_Vestment_of_Olorime }, -- Major Courage (Olirime's)
    [109084] = { tooltip = T.Set_Vestment_of_Olorime }, -- Ideal Vestment of Olirime (Olirime's Perfect)
    [110020] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_major_courage.dds', tooltip = A.Set_Vestment_of_Olorime }, -- Major Courage (Olirime's Perfect)
    [107095] = { tooltip = T.Set_Mantle_of_Siroria }, -- Mantle of Siroria (Siroria's)
    [110118] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sirorias_boon.dds', tooltip = T.Set_Sirorias_Boon }, -- Siroria's Boon (Siroria's)
    [109081] = { tooltip = T.Set_Mantle_of_Siroria }, -- Ideal Mantle of Siroria (Siroria's)
    [110142] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sirorias_boon.dds', tooltip = T.Set_Sirorias_Boon }, -- Siroria's Boon (Perfect Siroria's)
    [110504] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds', tooltip = T.Set_Relequens }, -- Arms of Relequen (Perfect Relequen's)
    [107203] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds' }, -- Arms of Relequen (Perfect Relequen's)
    [110512] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds', name = A.Set_Arms_of_Relequen, tooltip = T.Set_Relequens }, -- Ideal Arms of Relequen (Relequen's)
    [109086] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arms_of_relequen.dds', name = A.Set_Arms_of_Relequen }, -- Ideal Arms of Relequen (Relequen's)
    [109976] = { tooltip = A.Set_Aegis_of_Galenwe }, -- Empower (Aegis of Galenwe)
    [109989] = { tooltip = A.Set_Aegis_of_Galenwe }, -- Empower (Ideal Aegis of Galenwe)

    -- Battleground Sets
    [92908] = { tooltip = A.Set_Cowards_Gear }, -- Major Expedition (Coward's Gear)
    [92909] = { tooltip = A.Set_Cowards_Gear }, -- Major Protection (Coward's Gear)
    [93104] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_oblivion.dds' }, -- Knight Slayer
    [92916] = { icon = 'esoui/art/icons/achievement_update15_041.dds', tooltip = T.Set_Vanguards_Challenge }, -- Vanguard's Challenge
    [92921] = { tooltip = A.Set_Wizards_Riposte }, -- Minor Maim (Wizard's Riposte)

    -- Imperial City Sets
    [61762] = { hide = true }, -- Black Rose (of the Black Rose)
    [79421] = { icon = 'LuiExtended/media/icons/abilities/ability_set_galerions_revenge.dds', tooltip = T.Set_Galerions_Revenge }, -- Mark of Revenge (Galerion's)
    [79420] = { icon = 'LuiExtended/media/icons/abilities/ability_set_galerions_revenge.dds' }, -- Galerion's Revenge (Galerion's)
    [65706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_meritorious_service.dds', tooltip = T.Set_Meritorius_Service }, -- Meritorious Service (of Meritorious Service)
    [90935] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds', unbreakable = 1, tooltip = T.Generic_Immunity }, -- Phoenix (of the Phoenix)
    [90936] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Set_Phoenix, A.Set_Cooldown), tooltip = T.Set_Phoenix }, -- Phoenix (of the Phoenix)
    [68940] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds' }, -- Phoenix (of the Phoenix)
    [70405] = { icon = 'LuiExtended/media/icons/abilities/ability_set_phoenix.dds' }, -- Phoenix (of the Phoenix)
    [61771] = { icon = 'LuiExtended/media/icons/abilities/ability_set_powerful_assault.dds', tooltip = T.Generic_Weapon_Spell_Damage_Duration }, -- Powerful Assault (of the Powerful Assault)
    [68974] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_oblivion.dds' }, -- Shield Breaker (of the Shield Breaker)
    [79363] = { icon = 'esoui/art/icons/achievement_029.dds' }, -- Thews of the Harbinger (of the Harbinger)
    [79469] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicecanon.dds', name = A.Set_Vicecannon_of_Venom, tooltip = T.Generic_Poison_1_Sec }, -- Deadly Venom (the Vicanon's)
    [79471] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vicecanon.dds', name = A.Set_Vicecannon_of_Venom }, -- Deadly Venom (the Vicanon's)

    -- Cyrodiil Sets (Light)
    [34605] = { icon = 'LuiExtended/media/icons/abilities/ability_set_almalexias_mercy.dds' }, -- Almalexia's Mercy (of Almalexia's Mercy)
    [70392] = { icon = 'LuiExtended/media/icons/abilities/ability_set_arch-mage.dds' }, -- The Arch-Mage (of the Arch-Mage)

    [117359] = { icon = 'LuiExtended/media/icons/abilities/ability_set_syrabane.dds' }, -- Curse-Eater (Curse-Eating)

    [111550] = { icon ='esoui/art/icons/achievement_darkbrotherhood_027.dds', tooltip = T.Set_Light_of_Cyrodiil }, -- Light of Cyrodiil (of Cyrodiil's Light)
    [112750] = { hide = true }, -- Light of Cyrodiil (of Cyrodiil's Light)
    [33498] = { icon = 'esoui/art/icons/achievement_update11_dungeons_007.dds' }, -- Desert Rose (of the Desert Rose)

    -- Cyrodiil Sets (Medium)
    [34876] = { tooltip = A.Set_Ward_of_Cyrodiil }, -- Major Defile (of Cyrodiil's Ward)
    [34509] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_kiss.dds' }, -- Kyne's Kiss (of Kyne's Kiss)
    [70492] = { icon = 'LuiExtended/media/icons/abilities/ability_set_kynes_kiss.dds' }, -- Kyne's Kiss (of Kyne's Kiss)
    [34384] = { icon = 'LuiExtended/media/icons/abilities/ability_set_morag_tong.dds', tooltip = T.Set_Morag_Tong }, -- The Morag Tong (of the Morag Tong)

    [117391] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sentry.dds', tooltip = T.Set_Sentry }, -- Sentry (of the Sentry)
    [117397] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sentry_icd.dds', tooltip = T.Set_Sentry_Cooldown, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, name = zo_strformat("<<1>> <<2>>", A.Set_Sentry, A.Set_Cooldown) }, -- Exhausted Sentry (of the Sentry)

    [57180] = { icon = 'esoui/art/icons/achievement_thievesguild_011.dds' }, -- Shadow Walker (of the Shadow Walker)
    [57181] = { icon = 'esoui/art/icons/achievement_thievesguild_011.dds' }, -- Shadow Walker (of the Shadow Walker)
    [47358] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds' }, -- Vengeance Leech (of Vengeance Leech)
    [47359] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds' }, -- Vengeance Leech (of Vengeance Leech)
    [47360] = { icon = 'LuiExtended/media/icons/abilities/ability_set_twilight_remedy.dds' }, -- Vengeance Leech (of Vengeance Leech)

    -- Cyrodiil Sets (Heavy)
    [34787] = { icon = 'LuiExtended/media/icons/abilities/ability_set_affliction.dds' }, -- Affliction (Afflicted)
    [29122] = { icon = 'LuiExtended/media/icons/abilities/ability_set_beckoning_steel.dds', tooltip = T.Set_Beckoning_Steel }, -- Beckoning Steel (Beckoning Steel)

    [111575] = { icon = 'LuiExtended/media/icons/abilities/ability_set_crest_of_cyrodiil.dds' }, -- Crest of Cyrodiil (Cyrodiil's Crest)

    [34872] = { icon = 'LuiExtended/media/icons/abilities/ability_set_the_ravager.dds', tooltip = T.Generic_Weapon_Damage_Duration }, -- The Ravager (Ravaging)
    [34512] = { icon = 'LuiExtended/media/icons/abilities/ability_set_the_juggernaut.dds' }, -- The Juggernaut (of the Juggernaut)

    -- Rewards for the Worthy Sets
    [113523] = { icon = 'LuiExtended/media/icons/abilities/ability_set_battalion_defender.dds' }, -- Battalion Defender (Battalion Defender)
    [113355] = { tooltip = A.Set_Indomitable_Fury }, -- Indomitable Fury (Indomitable Fury)
    [113354] = { icon = 'esoui/art/icons/ability_buff_minor_heroism.dds' }, -- Indomitable Fury (Indomitable Fury)
    [113356] = { tooltip = A.Set_Indomitable_Fury }, -- Indomitable Fury (Indomitable Fury)
    [113461] = { icon = 'esoui/art/icons/achievement_murkmire_rescue_villagers.dds', name = A.Set_Soldier_of_Anguish, tooltip = T.Set_Soldier_of_Anguish }, -- Heal Absorption (Soldier of Anguish)
    [113382] = { icon = 'esoui/art/icons/achievement_blackrose_boss_5.dds', tooltip = T.Set_Spell_Strategist }, -- Spell Strategist (Spell Strategist)
    [113417] = { hide = true }, -- Spell Strategist (Spell Strategist)
    [113509] = { tooltip = A.Set_Steadfast_Hero }, -- Major Protection (Steadfast Hero)

    [76947] = { name = A.Skill_Minor_Defile, tooltip = A.Set_Fasallas_Guile }, -- Fasalla's Guile (of Fasalla's Guile)
    [76950] = { icon = 'esoui/art/icons/ability_warrior_025.dds', tooltip = T.Set_Warriors_Fury }, -- Warrior's Fury (of Fury)
    [76936] = { icon = 'LuiExtended/media/icons/abilities/ability_set_transmutation.dds', tooltip = T.Set_Robes_of_Transmutation }, -- Transmutation (of Transmutation)
    [76938] = { icon = 'esoui/art/icons/procs_003.dds' }, -- Vicious Death (of Vicious Death)

    -- Maelstrom Arena Sets
    [71264] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_melee_alt.dds', tooltip = T.Set_Succession_Flame }, -- Fire Ascendant (of Succession)
    [71265] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_melee_alt.dds', tooltip = T.Set_Succession_Shock  }, -- Lightning Ascendant (of Succession)
    [71266] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cold_melee_alt.dds', tooltip = T.Set_Succession_Frost }, -- Frost Ascendant (of Succession)
    [73296] = { icon = 'LuiExtended/media/icons/abilities/ability_set_winterborn.dds', name = A.Set_Winterborn, duration = 0, groundLabel = true, tooltip = T.Generic_Snare_60_No_Dur }, -- Winterborn Snare (Winterborn)
    [71646] = { icon = 'LuiExtended/media/icons/abilities/ability_set_winterborn.dds' }, -- Winterborn (Winterborn)
    [71188] = { icon = 'esoui/art/icons/ability_rogue_019.dds', name = A.Set_Glorious_Defender, tooltip = T.Set_Glorious_Defender }, -- Glorious Defense (of Glory)
    [71605] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hunt_leader.dds' }, -- Hunt Leader (of the Hunt)
    [74106] = { icon = 'LuiExtended/media/icons/abilities/ability_set_hunt_leader.dds' }, -- Hunt Leader (of the Hunt)
    [71193] = { icon = 'LuiExtended/media/icons/abilities/ability_set_para_bellum.dds', name = A.Set_Para_Bellum, duration = 0, forcedContainer = 'short', tooltip = T.Set_Para_Bellum }, -- Para Bellum Shield (Para Bellum)

    -- Dragonstar Arena Sets
    [29096] = { tooltip = A.Set_Healers_Habit }, -- Minor Mending (of the Healer)

    -- DISGUISES
    [82631] = { icon = 'LuiExtended/media/icons/disguises/disguise_monks_disguise.dds', name = A.Disguise_Monks_Disguise }, -- Monk Disguise Timer (Monk's Disguise)

    ----------------------------------------------------------------
    -- CHAMPION POINTS ---------------------------------------------
    ----------------------------------------------------------------

    -- The Steed
    [98313] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_invigorating_bash.dds' }, -- Invigorating Bash
    [98294] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_phase.dds', tooltip = T.Champion_Phase }, -- Phase
    [61661] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_resilient.dds' }, -- Resilient
    [98314] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_reinforced.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Reinforced

    -- The Lady
    [63110] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_spell_absorption.dds' }, -- Spell Absorption
    [60371] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_critical_leech.dds' }, -- Critical Leech
    [98316] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_unchained.dds', tooltip = T.Champion_Unchained }, -- Unchained

    -- The Lord
    [98404] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_infusion.dds', tooltip = T.Generic_Magicka_Recovery_Duration }, -- Infusion
    [98414] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_reinforced.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Revival
    [61015] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_warrior_reinforced.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Determination

    -- The Tower
    [98308] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_thief_ensnare.dds', tooltip = T.Generic_Snare_20 }, -- Ensnare
    [92428] = { icon = 'esoui/art/icons/ability_healer_012.dds', tooltip = T.Champion_Siphoner }, -- Siphoner
    [62518] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_thief_maras_gift.dds' }, -- Mara's Gift

    -- The Lover
    [63878] = { icon = 'esoui/art/icons/ability_healer_033.dds' }, -- Synergizer

    -- The Shadow
    [64244] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_thief_shadowstrike.dds', tooltip = T.Generic_Invisibility }, -- Shadowstrike
    [64245] = { hide = true }, -- Shadowstrike

    -- The Apprentice
    [63152] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_vengeance.dds', name = A.Champion_Vengeance_Charge, tooltip = T.Champion_Vengeance_Charge }, -- Vengeance Count
    [63151] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_vengeance_full.dds', tooltip = T.Champion_Vengeance }, -- Vengeance
    [59530] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_foresight.dds', tooltip = T.Champion_Foresight }, -- Foresight
    [63114] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_arcane_well.dds' }, -- Arcane Well
    [88784] = { hide = true }, -- Arcane Well

    -- The Atronach
    [63106] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_retaliation.dds', tooltip = T.Champion_Retaliation }, -- Retaliation
    [60230] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_riposte.dds' }, -- Riposte
    [63108] = { name = A.Skill_Off_Balance, tooltip = A.Champion_Tactician }, -- Off-Balance (Tactician)

    -- The Ritual
    [98307] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_opportunist.dds', tooltip = T.Champion_Opportunist }, -- Opportunist
    [100408] = { icon = 'LuiExtended/media/icons/abilities/ability_champion_mage_opportunist.dds', tooltip = T.Champion_Opportunist }, -- Opportunist
    [65133] = { tooltip = A.Champion_Last_Stand }, -- Major Heroism (Last Stand)

    ----------------------------------------------------------------
    -- PLAYER ABILITIES - BASIC ------------------------------------
    ----------------------------------------------------------------

    -- Test
    [16415] = { tooltip = T.Generic_Test }, -- Test

    -- Roll Dodge
    [29721] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_roll_dodge.dds', tooltip = T.Innate_Immobilize_Immunity }, -- Immobilize Immunity
    [69143] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_dodge_fatigue.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Innate_Dodge_Fatigue }, -- Dodge Fatigue

    -- Crouch
    [20299] = { tooltip = T.Innate_Hidden }, -- Sneak
    [20309] = { tooltip = T.Innate_Invisible }, -- Crouch

    [20301] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds', name = A.Innate_Crouch }, -- Crouch Drain
    [26245] = { icon = 'esoui/art/icons/achievement_darkbrotherhood_018.dds', name = A.Innate_Stealth_Stun, tooltip = T.Generic_Stun }, -- Slam Stun (Stun from crouch attack)

    -- Sprint
    [973] = {  tooltip = T.Innate_Sprint }, -- Sprint
    [15356] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_sprint.dds', name = A.Innate_Sprint }, -- Sprint Drain

    -- Misc
    [10950] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fall_snare.dds', name = A.Innate_Fall_Damage }, -- Fall Snare
    [6811] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recall.dds', tooltip = T.Innate_Recall_Penalty }, -- Recall
    [69293] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recall.dds', name = A.Innate_Recall }, -- Recall
    [14644] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_resurrection_immunity.dds', name = A.Innate_Revive }, -- Revive (Death Dialogue)
    [31221] = { hide = true }, -- Skyshard Collect (Aura on Skyshard when player collects it)
    [32346] = { icon = 'esoui/art/icons/ability_mage_050.dds', name = A.Innate_Absorbing_Skyshard, unbreakable = 1}, -- Skyshard Collect
    [63601] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_eso_plus_member.dds', tooltip = T.Innate_ESO_Plus }, -- ESO Plus Member
    [47270] = { icon = 'esoui/art/icons/achievement_update11_dungeons_017.dds', hide = true }, -- Ritual of Mara
    [2727] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = A.Skill_Off_Balance, tooltip = "" }, -- Off-Balance
    [102771] = { stack = 0, type = 1, tooltip = T.Generic_Off_Balance_Immunity }, -- Off Balance Immunity
    [85701] = { hide = true, tooltip = T.Innate_Battle_Spirit }, -- Dueling Flag
    [21263] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_ayleid_well.dds', name = A.Innate_Ayleid_Well, tooltip = T.Innate_Ayleid_Well }, -- Ayleid Health Bonus
    [100862] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_ayleid_well.dds', name = A.Innate_Ayleid_Well_Fortified, tooltip = T.Innate_Ayleid_Well_Fortified }, -- Ayleid Health Bonus
    [105188] = { hide = true }, -- Grim Focus Combat Trigger
    [105190] = { hide = true }, -- Grim Focus Combat Trigger
    [105192] = { hide = true }, -- Grim Focus Combat Trigger
    [105194] = { hide = true }, -- RF Combat Trigger

    -- Mount
    [37059] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_mounted.dds' }, -- Mount Up
    [115607] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hard_dismount.dds', name = A.Innate_Hard_Dismount, unbreakable = 1, tooltip = T.Generic_Knockdown }, -- Dismount Stun
    [33439] = { tooltip = T.Innate_Gallop },

    -- Block
    [14890] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', forcedContainer = 'short', tooltip = T.Innate_Block }, -- Block
    [16270] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = A.Innate_Block }, -- Brace Cost
    [88724] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = A.Innate_Block }, -- Brace Cost
    [86310] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, hide = true, tooltip = T.Generic_Stagger }, -- Stagger (Player blocks NPC charged attack)
    [86309] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, tooltip = T.Generic_Stun }, -- Stun (Player blocks NPC charged attack)
    [86312] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, tooltip = T.Generic_Stun }, -- Stun (Player blocks Ogrim Body Slam)
    [45902] = { name = A.Skill_Off_Balance, tooltip = "" }, -- Off-Balance

    -- Bash
    [21970] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_bash.dds' }, -- Bash
    [21973] = { icon = '' }, -- Bash (Hides icon for interrupt)
    [21972] = { tooltip = T.Generic_Stagger }, -- Stagger
    [21971] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', tooltip = T.Generic_Stun }, -- Bash Stun (Stun from bashing cast)
    [45982] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', tooltip = T.Generic_Stun }, -- Bash Stun (Stun from bashing cast when NPC is pinned against an obstacle)

    -- Off-Balance Exploit
    [16825] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_off-balance_exploit.dds', tooltip = T.Generic_Knockdown }, -- Off-Balance Exploit

    -- Mundus Stone Events
    [14031] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_mundus_use.dds', name = A.Innate_Receiving_Boon, unbreakable = 1}, -- Mundus Use

    -- Death/Resurrection
    [14646] = { tooltip = T.Innate_Resurrection_Immunity }, -- Recently Revived
    [55400] = { hide = true }, -- Magicka Restore
    [55401] = { hide = true }, -- Magicka Restore

    -- Basic Attacks
    [16593] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_melee_snare.dds', tooltip = T.Generic_Snare }, -- Melee Snare
    [48532] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_melee_snare.dds', hide = true }, -- Charge Snare
    --[61737] = { tooltip = T.Skill_Empower }, -- Empower
    [55080] = { hide = true }, -- Pet Hidden
    [28301] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', tooltip = T.Generic_CC_Immunity }, -- Crowd Control Immunity
    [38117] = { hide = true }, -- Crowd Control Immunity

    -- Taunt Effects
    [38254] = { icon = 'esoui/art/icons/ability_warrior_010.dds' }, -- Taunt
    [38541] = { icon = 'esoui/art/icons/ability_warrior_010.dds', tooltip = T.Innate_Taunt }, -- Taunt

    -- Disguise Effects
    [50602] = { tooltip = T.Innate_Disguised }, -- Disguised
    [13371] = { hide = true }, -- Acting Suspicious

    -- Pet Effects
    [63794] = { hide = true }, -- Taunt
    [112170] = { hide = true }, -- CC Immunity

    -- Housing
    [89469] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_create_station_blacksmith.dds', name = A.Innate_Create_Station_Blacksmith }, -- 68235 Stun
    [89645] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_create_station_clothing.dds', name = A.Innate_Create_Station_Clothing }, -- 68235 Stun
    [105217] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_create_station_jewelry.dds', name = A.Innate_Create_Station_Jewelry }, -- 68235 Stun
    [89654] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_create_station_woodwork.dds', name = A.Innate_Create_Station_Woodwork }, -- 68235 Stun

    ----------------------------------------------------------------
    -- WORLD EVENTS  -----------------------------------------------
    ----------------------------------------------------------------

    -- Daedric Anchor
    [86717] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_anchor_drop.dds', name = A.Innate_Anchor_Drop }, -- Drop Anchor
    [46690] = { hide = true }, -- Power of the Daedra
    [46689] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_power_of_the_daedra.dds', name = A.Innate_Power_of_the_Daedra }, -- Vitality of the Daedra
    [51632] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_power_of_the_daedra.dds', name = A.Innate_Power_of_the_Daedra }, -- Vitality of the Daedra
    [51633] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_power_of_the_daedra.dds', name = A.Innate_Power_of_the_Daedra }, -- Vitality of the Daedra
    [95813] = { type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1, tooltip = T.Skill_Static_Charge, groundLabel = true }, -- Static Charge
    [46291] = { hide = true }, -- Rain of Doom
    [46293] = { hide = true }, -- Stun

    -- Daedric Anchor Bosses
    [89249] = { hide = true }, -- Summon Daedra (Ozozzachar)
    [89251] = { hide = true }, -- Summon Daedra (Ozozzachar)

    -- Misc World + Theater
    [822] = { hide = true }, -- Ward
    [48899] = { icon = 'esoui/art/icons/achievement_newlifefestival_007.dds', tooltip = T.Innate_Firelight }, -- Firelight

    ----------------------------------------------------------------
    -- DRAGONKNIGHT PASSIVES ---------------------------------------
    ----------------------------------------------------------------

    -- Ardent Flame
    [29424] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 1)
    [108806] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 1)
    [108809] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 1)
    [45011] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 2)
    [108816] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 2)
    [108815] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_combustion.dds' }, -- Combustion (Combustion - Rank 2)
    [29436] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_warmth.dds', tooltip = T.Generic_Snare_15 }, -- Warmth (Warmth - Rank 1)
    [45016] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_warmth.dds', tooltip = T.Generic_Snare_30 }, -- Warmth (Warmth - Rank 2)
    [29451] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_world_in_ruin.dds' }, -- World in Ruin (World in Ruin - Rank 1)
    [45029] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_world_in_ruin.dds' }, -- World in Ruin (World in Ruin - Rank 2)

    -- Earthen Heart
    [29465] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 1)
    [29466] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 1)
    [29467] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 1)
    [44986] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 2)
    [44987] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 2)
    [44988] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_battle_roar.dds' }, -- Battle Roar (Battle Roar - Rank 2)
    [29468] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_eternal_mountain.dds' }, -- Eternal Mountain (Eternal Mountain - Rank 1)
    [44996] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_eternal_mountain.dds' }, -- Eternal Mountain (Eternal Mountain - Rank 2)
    [61798] = { tooltip = A.Skill_Mountains_Blessing }, -- Minor Brutality (Mountain's Blessing - Rank 1)
    [29474] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds' }, -- Mountain's Blessing (Mountain's Blessing - Rank 1)
    [61799] = { tooltip = A.Skill_Mountains_Blessing }, -- Minor Brutality (Mountain's Blessing - Rank 2)
    [45005] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_mountains_blessing.dds' }, -- Mountain's Blessing (Mountain's Blessing - Rank 2)
    [29475] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 1)
    [29476] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 1)
    [45009] = { icon = 'LuiExtended/media/icons/abilities/passive_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 2)
    [45010] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_helping_hands.dds' }, -- Helping Hands (Helping Hands - Rank 2)

    ----------------------------------------------------------------
    -- DRAGONKNIGHT ACTIVE ABILITIES -------------------------------
    ----------------------------------------------------------------

    -- Lava Whip / Molten Whip / Flame Lash
    [23808] =  { tooltip = A.Skill_Lava_Whip }, -- Off Balance (Lava Whip)
    [20806] = { tooltip = A.Skill_Molten_Whip }, -- Off Balance (Molten Whip)
    [34117] = { tooltip = A.Skill_Flame_Lash }, -- Off Balance (Flame Lash)
    [20824] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_power_lash.dds' }, -- Power Lash (Flame Lash)
    [23105] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_power_lash.dds', tooltip = T.Generic_HoT_1Sec }, -- Power Lash (Flame Lash)

    -- Searing Strike / Venomous Claw /Burning Embers
    [44363] = { tooltip = T.Generic_Burn_2_Sec }, -- Searing Strike (Searing Strike)
    [44369] = { tooltip = T.Generic_Poison_2_Sec }, -- Venomous Claw (Venomous Claw)
    [44373] = { tooltip = T.Skill_Burning_Embers }, -- Burning Embers (Burning Embers)

    -- Fiery Breath / Noxious Breath / Engulfing Flames
    [31102] = { tooltip = T.Generic_Burn_2_Sec }, -- Fiery Breath (Fiery Breath)
    [31103] = { tooltip = T.Generic_Poison_2_Sec }, -- Noxious Breath (Noxious Breath)
    [48946] = { tooltip = A.Skill_Noxious_Breath }, -- Major Fracture (Noxious Breath)
    [31104] = { tooltip = T.Skill_Engulfing_Flames }, -- Engulfing Flames (Engulfing Flames)

    -- Fiery Grip / Empowering Chains / Unrelenting Grip
    [76498] = { tooltip = A.Skill_Fiery_Grip }, -- Major Expedition (Fiery Grip)
    [76506] = { tooltip = A.Skill_Empowering_Chains }, -- Major Expedition (Empowering Chains)
    [108679] = { tooltip = A.Skill_Empowering_Chains, stack = 2 }, -- Empower (Empowering Chains)
    [109206] = { tooltip = A.Skill_Empowering_Chains, stack = 1 }, -- Empower (Empowering Chains)
    [62004] = { hide = true }, -- Unrelenting Grip (Unrelenting Grip)
    [76502] = { tooltip = A.Skill_Unrelenting_Grip }, -- Major Expedition (Unrelenting Grip)
    [77105] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds' }, -- Unrelenting Grip (Unrelenting Grip)

    -- Inferno / Flames of Oblivion / Cauterize
    [75088] = { consolidateExtra = true, tooltip = A.Skill_Inferno }, -- Major Prophecy (Inferno)
    [28967] = { tooltip = T.Skill_Inferno_Active }, -- Inferno (Inferno)
    [28969] = { tooltip = T.Skill_Inferno_Base }, -- Inferno (Inferno)
    [76420] = { consolidate = true, tooltip = A.Skill_Flames_of_Oblivion }, -- Major Prophecy (Flames of Oblivion)
    [76426] = { consolidate = true, tooltip = A.Skill_Flames_of_Oblivion }, -- Major Savagery (Flames of Oblivion)
    [32853] = { tooltip = T.Skill_Inferno_Active }, -- Inferno (Inferno)
    [61945] = { tooltip = T.Skill_Flames_of_Oblivion_Base }, -- Inferno (Inferno)
    [76433] = { consolidateExtra = true, tooltip = A.Skill_Cauterize }, -- Major Prophecy (Cauterize)
    [32881] = { tooltip = T.Skill_Cauterize_Active }, -- Inferno (Inferno)
    [76429] = { tooltip = T.Skill_Cauterize_Base }, -- Inferno (Inferno)

    -- Dragonknight Standard / Shifting Standard / Standard of Might
    [98438] = { name = A.Skill_Shackle }, -- Shackle Damage (Dragonknight Standard - Shackle Synergy)
    [98447] = { name = A.Skill_Shackle, tooltip = T.Generic_Immobilize }, -- Shackle Snare (Dragonknight Standard - Shackle Synergy)
    [108805] = { hide = true }, -- Synergy Damage Bonus (Dragonknight Standard - Shackle Synergy)
    [28988] = { tooltip = T.Skill_Dragonknight_Standard }, -- Dragonknight Standard (Dragonknight Standard)
    [29230] = { duration = 0, groundLabel = true, tooltip = A.Skill_Dragonknight_Standard }, -- Major Defile (Dragonknight Standard)
    [32958] = { tooltip = T.Skill_Dragonknight_Standard }, -- Shifting Standard (Shifting Standard)
    [70735] = { hide = true }, -- Shifting Standard (Shifting Standard)
    [32961] = { duration = 0, groundLabel = true, tooltip = A.Skill_Shifting_Standard }, -- Major Defile (Shifting Standard)
    [32965] = { duration = 0, name = A.Skill_Major_Defile, groundLabel = true, tooltip = A.Skill_Shifting_Standard }, -- Major Defile (Shifting Standard)
    [32947] = { tooltip = T.Skill_Dragonknight_Standard }, -- Standard of Might (Standard of Might)
    [32956] = { tooltip = T.Skill_Standard_of_Might_Buff, groundLabel = true}, -- Standard of Might (Standard of Might)
    [32949] = { duration = 0, groundLabel = true, tooltip = A.Skill_Standard_of_Might }, -- Major Defile (Standard of Might)

    [28995] = { groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, -- Dragonknight Standard
    [32960] = { groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, -- Shifting Standard
    [32964] = { groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, -- Shifting Standard
    [32948] = { groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, -- Standard of Might

    -- Spiked Armor / Hardened Armor / Volatile Armor
    [61815] = { consolidate = true, tooltip = A.Skill_Spiked_Armor }, -- Major Resolve (Spiked Armor)
    [61816] = { consolidate = true, tooltip = A.Skill_Spiked_Armor }, -- Major Ward (Spiked Armor)
    [61827] = { consolidate = true, tooltip = A.Skill_Hardened_Armor }, -- Major Resolve (Hardened Armor)
    [61828] = { consolidate = true, tooltip = A.Skill_Hardened_Armor }, -- Major Ward (Hardened Armor)
    [31808] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Hardened Armor (Hardened Armor)
    [61836] = { consolidate = true, tooltip = A.Skill_Volatile_Armor }, -- Major Resolve (Volatile Armor)
    [61837] = { consolidate = true, tooltip = A.Skill_Volatile_Armor }, -- Major Ward (Volatile Armor)
    [20326] = { tooltip = T.Generic_Magic_2_Sec }, -- Volatile Armor (Volatile Armor)

    -- Dark Talons / Burning Talons / Choking Talons
    [108807] = { hide = true }, -- Synergy Damage Bonus (Dark Talons - Ignite Synergy)
    [20527] = { tooltip = T.Generic_Immobilize }, -- Dark Talons (Dark Talons)
    [31898] = { tooltip = T.Skill_Burning_Talons }, -- Burning Talons (Burning Talons)
    [20253] = { hideReduce = true, tooltip = T.Skill_Burning_Talons }, -- Burning Talons (Burning Talons)
    [31899] = { tooltip = A.Skill_Choking_Talons }, -- Minor Maim (Choking Talons)
    [20528] = { tooltip = T.Generic_Immobilize }, -- Choking Talons (Choking Talons)

    -- Dragon Blood / Green Dragon Blood / Coagulating Blood
    [29011] = { consolidateExtra = true, tooltip = A.Skill_Dragon_Blood }, -- Major Fortitude (Dragon Blood)
    [32748] = { consolidate = true, tooltip = A.Skill_Green_Dragon_Blood }, -- Major Endurance (Green Dragon Blood)
    [61884] = { consolidate = true, tooltip = A.Skill_Green_Dragon_Blood }, -- Major Fortitude (Green Dragon Blood)
    [91670] = { consolidate = true, tooltip = A.Skill_Green_Dragon_Blood }, -- Minor Vitality (Green Dragon Blood)
    [61891] = { hide = true }, -- Coagulating Blood Bonus Heal (Coagulating Blood)
    [91674] = { consolidateExtra = true, tooltip = A.Skill_Coagulating_Blood }, -- Major Fortitude (Coagulating Blood)

    -- Reflective Scales / Reflective Plate / Dragon Fire Scale
    [21007] = { tooltip = T.Skill_Reflective_Scale }, -- Reflective Scale (Reflective Scale)
    [21014] = { tooltip = T.Skill_Reflective_Plate }, -- Reflective Plate (Reflective Plate)
    [108798] = { name = A.Skill_Reflective_Plate, tooltip = T.Skill_Reflective_Plate, hideReduce = true, noDuplicate = true }, -- Snare Removal (Reflective Plate)
    [21017] = { tooltip = T.Skill_Dragon_Fire_Scale }, -- Dragon Fire Scale (Dragon Fire Scale)

    -- Inhale / Deep Breath / Draw Essence
    [31841] = { tooltip = T.Skill_Inhale }, -- Inhale (Inhale)
    [31859] = { icon = 'esoui/art/icons/ability_dragonknight_012.dds', name = A.Skill_Inhale }, -- Inhale Heal (Inhale)
    [32796] = { tooltip = T.Skill_Inhale }, -- Deep Breath (Deep Breath)
    [32795] = { icon = 'esoui/art/icons/ability_dragonknight_012_a.dds' }, -- Deep Breath (Deep Breath)
    [32797] = { icon = '' }, -- Deep Breath (Deep Breath) -- Hide for Interrupt notification on Combat Text
    [32788] = { tooltip = T.Skill_Draw_Essence }, -- Draw Essence (Draw Essence)
    [32786] = { icon = 'esoui/art/icons/ability_dragonknight_012_b.dds' }, -- Draw Essence (Draw Essence)
    [32789] = { hide = true, icon = 'esoui/art/icons/ability_dragonknight_012_b.dds' }, -- Draw Essence (Draw Essence)

    -- Dragon Leap / Take Flight / Ferocious Leap
    [29016] = { icon = 'esoui/art/icons/ability_dragonknight_009.dds' }, -- Dragon Leap (Dragon Leap)
    [114590] = { name = A.Skill_Dragon_Leap, tooltip = T.Generic_Knockback }, -- Stun (Dragon Leap)
    [114600] = { name = A.Skill_Take_Flight, tooltip = T.Generic_Knockback }, -- Stun (Take Flight)
    [61814] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Ferocious Leap (Ferocious Leap)
    [114601] = { name = A.Skill_Ferocious_Leap, tooltip = T.Generic_Knockback }, -- Stun (Ferocious Leap)

    -- Stonefist / Obsidian Shard / Stone Giant
    [29034] = { tooltip = T.Generic_Stun }, -- Stonefist (Stonefist)
    [31821] = { tooltip = T.Generic_Stun }, -- Obsidian Shard (Obsidian Shard)
    [68763] = { icon = 'esoui/art/icons/ability_dragonknight_013_b.dds' }, -- Obsidian Shard (Obsidian Shard)
    [31817] = { tooltip = T.Generic_Stun }, -- Stone Giant (Stone Giant)
    [31818] = { consolidate = true, tooltip = A.Skill_Stone_Giant }, -- Minor Resolve (Stone Giant)
    [108801] = { consolidate = true, tooltip = A.Skill_Stone_Giant }, -- Minor Ward (Stone Giant)

    -- Molten Weapons / Igneous Weapons / Molten Armaments
    [92507] = { consolidateExtra = true, tooltip = A.Skill_Molten_Weapons }, -- Major Sorcery (Molten Weapons)
    [76518] = { consolidate = true, tooltip = A.Skill_Igneous_Weapons }, -- Major Brutality (Igneous Weapons)
    [92503] = { consolidate = true, tooltip = A.Skill_Igneous_Weapons }, -- Major Sorcery (Igneous Weapons)
    [76537] = { tooltip = T.Skill_Molten_Armaments }, -- Molten Armaments (Molten Armaments)
    [92512] = { tooltip = A.Skill_Molten_Armaments }, -- Major Sorcery (Molten Armaments)

    -- Obsidian Shield / Igneous Shield / Fragmented Shield
    [29071] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Obsidian Shield (Obsidian Shield)
    [108675] = { tooltip = A.Skill_Obsidian_Shield }, -- Major Mending (Obsidian Shield)
    [29224] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Igneous Shield (Igneous Shield)
    [55033] = { tooltip = A.Skill_Igneous_Shield }, -- Major Mending (Igneous Shield)
    [32673] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Fragmented Shield (Fragmented Shield)
    [108676] = { tooltip = A.Skill_Fragmented_Shield }, -- Major Mending (Fragmented Shield)

    -- Petrify / Fossilize / Shattering Rocks
    [29037] = { tooltip = T.Skill_Petrify_Stun }, -- Petrify (Petrify)
    [32685] = { tooltip = T.Skill_Fossilize_Stun }, -- Fossilize (Fossilize)
    [61785] = { tooltip = T.Generic_Immobilize }, -- Fossilize (Fossilize)
    [32678] = { tooltip = T.Skill_Shattering_Rocks_Stun }, -- Shattering Rocks (Shattering Rocks)
    [108813] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, name = A.Skill_Shattering_Rocks, tooltip = T.Skill_Shattering_Rocks }, -- Heal Trigger Shattering Rocks (Shattering Rocks)
    [108811] = { icon = 'esoui/art/icons/ability_dragonknight_014b.dds', name = A.Skill_Shattering_Rocks }, -- Shattering Rocks Heal (Shattering Rocks)

    -- Ash Cloud / Cinder Storm / Eruption
    [29059] = { tooltip = T.Skill_Ash_Cloud }, -- Ash Cloud (Ash Cloud)
    [29126] = { duration = 0, groundLabel = true, tooltip = T.Generic_Snare_70_No_Dur }, -- Ash Cloud (Ash Cloud)
    [20779] = { tooltip = T.Skill_Ash_Cloud }, -- Cinder Storm (Cinder Storm)
    [20780] = { duration = 0, groundLabel = true, tooltip = T.Generic_Snare_70_No_Dur }, -- Cinder Storm (Cinder Storm)
    [32710] = { tooltip = T.Skill_Eruption }, -- Eruption (Eruption)
    [32712] = { duration = 0, groundLabel = true, tooltip = T.Skill_Eruption_Ground, hideGround = true }, -- Eruption (Eruption)

    [61772] = { groundLabel = true, tooltip = T.Generic_AOE_Heal_1_Sec }, -- Ash Cloud (Ash Cloud)
    [34791] = { groundLabel = true, tooltip = T.Generic_AOE_Heal_1_Sec }, -- Cinder Storm (Cinder Storm)
    [32711] = { groundLabel = true, tooltip = T.Skill_Eruption_Ground }, -- Eruption (Eruption)

    -- Magma Armor / Magma Shell / Corrosive Armor
    [15957] = { tooltip = T.Skill_Magma_Armor }, -- Magma Armor (Magma Armor)
    [17874] = { tooltip = T.Skill_Magma_Armor }, -- Magma Shell (Magma Shell)
    [76483] = { refreshOnly = true, tooltip = T.Generic_Damage_Shield_Duration }, -- Magma Shell (Magma Shell)
    [17878] = { tooltip = T.Skill_Corrosive_Armor }, -- Corrosive Armor (Corrosive Armor)

    ----------------------------------------------------------------
    -- NIGHTBLADE PASSIVES -----------------------------------------
    ----------------------------------------------------------------

    -- Assassination
    [36616] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_master_assassin.dds' },
    [45038] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_master_assassin.dds' },
    [36630] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 1)
    [101435] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 1)
    [36633] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 1)
    [45048] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 2)
    [101436] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 2)
    [45050] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_executioner.dds' }, -- Executioner (Executioner - Rank 2)
    [36636] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_pressure_points.dds' },
    [45053] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_pressure_points.dds' },
    [36641] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_hemorrhage.dds' },
    [61882] = { tooltip = A.Skill_Hemorrhage }, -- Minor Savagery (Hemorrhage)
    [45060] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_hemorrhage.dds' },
    [61898] = { tooltip = A.Skill_Hemorrhage }, -- Minor Savagery (Hemorrhage)

    -- Shadow
    [36549] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_refreshing_shadows.dds' },
    [45103] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_refreshing_shadows.dds' },
    [18866] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_shadow_barrier.dds' },
    [18868] = { tooltip = A.Skill_Shadow_Barrier }, -- Major Ward (Shadow Barrier)
    [66075] = { tooltip = A.Skill_Shadow_Barrier }, -- Major Resolve (Shadow Barrier)
    [45071] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_shadow_barrier.dds' },
    [45076] = { tooltip = A.Skill_Shadow_Barrier }, -- Major Ward (Shadow Barrier)
    [66083] = { tooltip = A.Skill_Shadow_Barrier }, -- Major Resolve (Shadow Barrier)
    [36532] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_vigor.dds' },
    [45084] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_vigor.dds' },
    [36552] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_veil.dds' },
    [45115] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_dark_veil.dds' },

    -- Siphoning
    [36560] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_catalyst.dds' }, -- Catalyst (Catalyst - Rank 1)
    [63705] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_catalyst.dds' }, -- Amphibious Regen (Catalyst - Rank 1)
    [45135] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_catalyst.dds' }, -- Catalyst (Catalyst - Rank 2)
    [63707] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_catalyst.dds' }, -- Amphibious Regen (Catalyst - Rank 2)
    [36595] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_magicka_flood.dds' },
    [45150] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_magicka_flood.dds' },
    [36603] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_soul_siphoner.dds' },
    [45155] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_soul_siphoner.dds' },
    [36587] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 1)
    [36589] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 1)
    [45145] = { icon = 'LuiExtended/media/icons/abilities/passive_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 2)
    [45146] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_transfer.dds' }, -- Transfer (Transfer - Rank 2)

    ----------------------------------------------------------------
    -- NIGHTBLADE ACTIVES ------------------------------------------
    ----------------------------------------------------------------

    -- Assassin's Blade / Killer's Blade / Impale
    [61787] = { icon = 'esoui/art/icons/ability_nightblade_017_a.dds' }, -- Killer's Blade (Killer's Blade)
    [34851] = { hide = true }, -- Impale (Impale)

    -- Teleport Strike / Lotus Fan / Ambush
    [25887] = { tooltip = T.Generic_Stun }, -- Teleport Strike (Teleport Strike)
    [35334] = { icon = 'esoui/art/icons/ability_nightblade_008_a.dds' }, -- Lotus Fan (Lotus Fan)
    [35336] = { tooltip = T.Skill_Lotus_Fan }, -- Lotus Fan (Lotus Fan)
    [25959] = { tooltip = T.Generic_Stun }, -- Ambush (Ambush)

    -- Blur / Mirage / Double Take
    [90587] = { consolidateExtra = true, tooltip = A.Skill_Blur }, -- Major Evasion (Blur)
    [90593] = { consolidate = true, tooltip = A.Skill_Mirage }, -- Major Evasion (Mirage)
    [61817] = { consolidate = true, tooltip = A.Skill_Mirage }, -- Minor Resolve (Mirage)
    [68512] = { consolidate = true, tooltip = A.Skill_Mirage }, -- Minor Ward (Mirage)
    [90620] = { consolidateExtra = true, tooltip = A.Skill_Double_Take }, -- Major Evasion (Double Take)
    [61833] = { tooltip = A.Skill_Double_Take }, -- Major Expedition (Double Take)

    -- Mark Target / Piercing Mark / Reaper's Mark
    [33363] = { consolidate = true, tooltip = A.Skill_Mark_Target }, -- Major Breach (Mark Target)
    [63909] = { consolidate = true, tooltip = A.Skill_Mark_Target }, -- Major Fracture (Mark Target)
    [33373] = { hide = true, icon = 'esoui/art/icons/ability_nightblade_014.dds' }, -- Mark Target (Mark Target)
    [36980] = { consolidate = true, tooltip = A.Skill_Piercing_Mark }, -- Major Breach (Piercing Mark)
    [63915] = { consolidate = true, tooltip = A.Skill_Piercing_Mark }, -- Major Fracture (Piercing Mark)
    [36994] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Marked, tooltip = A.Skill_Piercing_Mark, noDuplicate = true }, -- Piercing Mark (Piercing Mark)
    [36983] = { hide = true, icon = 'esoui/art/icons/ability_nightblade_014_b.dds', name = A.Skill_Piercing_Mark }, -- Mark Target (Piercing Mark)
    [36972] = { consolidate = true, tooltip = A.Skill_Reapers_Mark }, -- Major Breach (Reaper's Mark)
    [63919] = { consolidate = true, tooltip = A.Skill_Reapers_Mark }, -- Major Fracture (Reaper's Mark)
    [36975] = { hide = true, icon = 'esoui/art/icons/ability_nightblade_014_a.dds' }, -- Reaper's Mark (Reaper's Mark)
    [36973] = { tooltip = A.Skill_Reapers_Mark }, -- Major Berserk (Reaper's Mark)

    -- Grim Focus / Relentless Focus / Merciless Resolve
    [61902] = { tooltip = T.Skill_Grim_Focus }, -- Grim Focus (Grim Focus)
    [61907] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds' }, -- Assassin's Will (Grim Focus)
    [64047] = { consolidate = true, tooltip = A.Skill_Grim_Focus }, -- Minor Berserk (Grim Focus)
    [61905] = { hide = true }, -- Grim Focus (Grim Focus)
    [61927] = { tooltip = T.Skill_Relentless_Focus }, -- Relentless Focus (Relentless Focus)
    [61932] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds' }, -- Assassin's Scourge (Relentless Focus)
    [64051] = { consolidate = true, tooltip = A.Skill_Relentless_Focus }, -- Minor Berserk (Relentless Focus)
    [62056] = { consolidate = true, tooltip = A.Skill_Relentless_Focus }, -- Minor Endurance (Relentless Focus)
    [61928] = { hide = true}, -- Relentless Focus (Relentless Focus)
    [61919] = { tooltip = T.Skill_Grim_Focus }, -- Merciless Resolve (Merciless Resolve)
    [61930] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_assassins_will.dds' }, -- Assassin's Will (Merciless Resolve)
    [64055] = { consolidate = true, tooltip = A.Skill_Merciless_Resolve }, -- Minor Berserk (Merciless Resolve)
    [61920] = { hide = true }, -- Merciless Resolve (Merciless Resolve)

    -- Death Stroke / Incapacitating Strike / Soul Harvest
    [33399] = { tooltip = A.Skill_Death_Stroke }, -- Major Defile (Death Stroke)
    [61389] = { icon = 'esoui/art/icons/ability_nightblade_007.dds', name = A.Skill_Death_Stroke, tooltip = T.Skill_Death_Stroke_Debuff }, -- Damage Taken Increased (Death Stroke)
    [36509] = { tooltip = A.Skill_Incapacitating_Strike }, -- Major Defile (Incapacitating Strike)
    [61393] = { name = A.Skill_Incapacitating_Strike, tooltip = T.Skill_Death_Stroke_Debuff }, -- Damage Taken Increased (Incapacitating Strike)
    [113110] = { tooltip = A.Skill_Incapacitating_Strike }, -- Major Defile (Incapacitating Strike)
    [113107] = { icon = 'esoui/art/icons/ability_nightblade_007_c.dds', name = A.Skill_Incapacitating_Strike, tooltip = T.Skill_Incapacitating_Strike }, -- Damage Taken Increased (Incapacitating Strike)
    [113109] = { icon = 'esoui/art/icons/ability_nightblade_007_c.dds', tooltip = T.Skill_Incapacitating_Strike, hideReduce = true }, -- Incapacitating Strike (Incapacitating Strike)
    [36515] = { tooltip = A.Skill_Soul_Harvest }, -- Major Defile (Soul Harvest)
    [61400] = { name = A.Skill_Soul_Harvest, tooltip = T.Skill_Death_Stroke_Debuff }, -- Damage Taken Increased (Soul Harvest)
    [36519] = { icon = 'esoui/art/icons/ability_nightblade_007_b.dds', name = A.Skill_Soul_Harvest }, -- Rapid Stroke Passive (Soul Harvest)

    -- Veiled Strike / Surprised Attack / Concealed Weapon
    [25256] = { tooltip = A.Skill_Veiled_Strike }, -- Off Balance (Veiled Strike)
    [33185] = { tooltip = T.Generic_Stun }, -- Veiled Strike (Veiled Strike)
    [34733] = { tooltip = A.Skill_Surprise_Attack }, -- Off Balance (Surprise Attack)
    [34732] = { tooltip = T.Generic_Stun }, -- Surprise Attack (Surprise Attack)
    [34734] = { tooltip = A.Skill_Surprise_Attack }, -- Major Fracture (Surprise Attack)
    [34737] = { tooltip = A.Skill_Concealed_Weapon }, -- Off Balance (Concealed Weapon)
    [34736] = { tooltip = T.Generic_Stun }, -- Concealed Weapon (Concealed Weapon)

    -- Shadow Cloak / Shadowy Disguise / Dark Cloak
    [25375] = { hide = true }, -- Shadow Cloak (Shadow Cloak)
    [25376] = { tooltip = T.Generic_Invisibility }, -- Shadow Cloak (Shadow Cloak)
    [25380] = { hide = true }, -- Shadowy Disguise (Shadowy Disguise)
    [25381] = { tooltip = T.Generic_Invisibility }, -- Shadowy Disguise (Shadowy Disguise)
    [62141] = { tooltip = T.Skill_Shadowy_Disguise }, -- Shadowy Disguise (Shadowy Disguise)
    [25377] = { tooltip = T.Generic_HoT_1Sec }, -- Dark Cloak (Dark Cloak)
    [108913] = { consolidate = true, tooltip = A.Skill_Dark_Cloak }, -- Minor Protection (Dark Cloak)

    -- Path of Darkness / Twisting Path / Refreshing Path
    [33195] = { tooltip = T.Skill_Path_of_Darkness }, -- Path of Darkness (Path of Darkness)
    [33210] = { duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = A.Skill_Path_of_Darkness }, -- Major Expedition (Path of Darkness)
    [36049] = { tooltip = T.Skill_Twisting_Path }, -- Twisting Path (Twisting Path)
    [36050] = { duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = A.Skill_Twisting_Path }, -- Major Expedition (Twisting Path)
    [36052] = { tooltip = T.Generic_AOE_Magic_1_Sec, groundLabel = true }, -- Twisting Path (Twisting Path)
    [36028] = { tooltip = T.Skill_Refreshing_Path }, -- Refreshing Path (Refreshing Path)
    [64005] = { duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = A.Skill_Refreshing_Path }, -- Major Expedition (Refreshing Path)
    [64006] = { groundLabel = true, tooltip = T.Skill_Refreshing_Path_Ground }, -- Refreshing Path (Refreshing Path)

    -- Aspect of Terror / Mass Hysteria / Manifestation of Terror
    [25352] = { tooltip = T.Generic_Fear_No_Dur }, -- Aspect of Terror (Aspect of Terror)
    [76683] = { name = A.Skill_Aspect_of_Terror, tooltip = T.Generic_Snare_50 }, -- Mass Hysteria (Aspect of Terror)
    [37470] = { tooltip = T.Generic_Fear_No_Dur }, -- Mass Hysteria (Mass Hysteria)
    [37473] = { tooltip = T.Generic_Snare_50 }, -- Mass Hysteria (Mass Hysteria)
    [37472] = { tooltip = A.Skill_Mass_Hysteria }, -- Minor Maim (Mass Hysteria)
    [37475] = { tooltip = T.Skill_Manifestation_of_Terror }, -- Manifestation of Terror (Manifestation of Terror)
    [76639] = { tooltip = T.Generic_Fear }, -- Manifestation of Terror (Manifestation of Terror)
    [76629] = { hide = true }, -- Remove Trap (Manifestation of Terror)
    [76635] = { hide = true }, -- Remove Trap (Manifestation of Terror)
    [38208] = { hide = true }, -- Birth Manifestation of Terror (Manifestation of Terror)
    [76632] = { hide = true }, -- Manifestation of Terror (Manifestation of Terror)
    [76638] = { name = A.Skill_Manifestation_of_Terror, tooltip = T.Generic_Snare_50 }, -- Mass Hysteria (Manifestation of Terror)

    -- Summon Shade / Dark Shade / Shadow Image
    [65269] = { hide = true }, -- Shade Initialize (Summon Shade - All Morphs)
    [85086] = { hide = true }, -- Boss (Summon Shade - All Morphs)
    [33219] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode.dds', name = A.Skill_Corrode }, -- Corrode (Shade) (Summon Shade - Summon Shade/Dark Shade)
    [33228] = { tooltip = A.Skill_Summon_Shade }, -- Minor Maim (Summon Shade)
    [38517] = { hide = true, tooltip = T.Skill_Summon_Shade }, -- Summon Shade (Summon Shade)

    [35438] = { hide = true, tooltip = T.Skill_Summon_Shade }, -- Summon Shade (Dark Shade)
    [108936] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_whirlwind.dds' }, -- Whirlwind (Dark Shade)
    [108939] = { tooltip = A.Skill_Summon_Shade }, -- Minor Maim (Dark Shade)

    [38528] = { hide = true, tooltip = T.Skill_Shadow_Image }, -- Shadow (Shadow Image)
    [51556] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode_ranged.dds' }, -- Corrode (Shadow Image)
    [51558] = { name = A.Skill_Minor_Maim, tooltip = A.Skill_Shadow_Image }, -- Shade Corrode (Shadow Image)

    -- Consuming Darkness / Bolstering Darkness / Veil of Blades
    [37729] = { tooltip = T.Generic_Invisibility }, -- Hidden Refresh (Hidden Refresh)
    [37732] = { tooltip = T.Generic_HoT_05Sec }, -- Hidden Refresh (Hidden Refresh)
    [108808] = { hide = true}, -- Synergy Damage Bonus (Consuming Darkness - Hidden Refresh Synergy)
    [25411] = { tooltip = T.Skill_Consuming_Darkness }, -- Consuming Darkness (Consuming Darkness)
    [44871] = { forcedContainer = 'short', tooltip = A.Skill_Consuming_Darkness, groundLabel = true }, -- Major Protection (Consuming Darkness)
    [25412] = { tooltip = T.Generic_Snare_70_No_Dur, groundLabel = true }, -- Consuming Darkness (Consuming Darkness)
    [36493] = { tooltip = T.Skill_Bolstering_Darkness }, -- Bolstering Darkness (Bolstering Darkness)
    [44862] = { forcedContainer = 'short', tooltip = A.Skill_Bolstering_Darkness, groundLabel = true }, -- Major Protection (Bolstering Darkness)
    [36495] = { tooltip = T.Generic_Snare_70_No_Dur, groundLabel = true }, -- Bolstering Darkness (Bolstering Darkness)
    [36485] = { tooltip = T.Skill_Veil_of_Blades }, -- Veil of Blades (Veil of Blades)
    [44854] = { forcedContainer = 'short', tooltip = A.Skill_Veil_of_Blades, groundLabel = true }, -- Major Protection (Veil of Blades)
    [36490] = { groundLabel = true, tooltip = T.Skill_Veil_of_Blades_Ground }, -- Veil of Blades (Veil of Blades)
    [36487] = { tooltip = T.Skill_Veil_of_Blades_Ground, groundLabel = true, hideGround = true }, -- Veil of Blades (Veil of Blades)

    -- Strife / Funnel Health / Swallow Soul
    [33292] = { tooltip = T.Generic_HoT_2Sec }, -- Strife (Strife)
    [34840] = { tooltip = T.Generic_HoT_2Sec }, -- Funnel Health (Funnel Health)
    [34841] = { tooltip = T.Generic_HoT_2Sec }, -- Funnel Health (Funnel Health)
    [35469] = { hide = true }, -- Funnel Health (Funnel Health)
    [34836] = { tooltip = T.Generic_HoT_2Sec }, -- Swallow Soul (Swallow Soul)

    -- Malevolent Offering / Shrewd Offering / Healthy Offering
    [108925] = { unbreakable = 1, tooltip = T.Skill_Malevolent_Offering }, -- Malevolent Offering (Malevolent Offering)
    [108927] = { unbreakable = 1, tooltip = T.Skill_Malevolent_Offering }, -- Shrewd Offering (Shrewd Offering)
    [108932] = { unbreakable = 1, tooltip = T.Skill_Malevolent_Offering }, -- Healthy Offering (Healthy Offering)
    [108934] = { tooltip = A.Skill_Healthy_Offering }, -- Minor Mending (Healthy Offering)

    -- Cripple / Debilitate / Crippling Grasp
    [33329] = { tooltip = T.Skill_Cripple }, -- Cripple (Cripple)
    [33327] = { icon = 'esoui/art/icons/ability_nightblade_006.dds', tooltip = T.Skill_Cripple, hideReduce = true }, -- Cripple (Cripple)
    [33328] = { tooltip = A.Skill_Cripple }, -- Major Expedition (Cripple)
    [36943] = { hide = true }, -- Debilitate (Debilitate)
    [36950] = { tooltip = T.Skill_Cripple }, -- Debilitate (Debilitate)
    [36945] = { icon = 'esoui/art/icons/ability_nightblade_006_a.dds', tooltip = T.Skill_Cripple, hideReduce = true }, -- Debilitate (Debilitate)
    [36946] = { tooltip = A.Skill_Debilitate }, -- Major Expedition (Debilitate)
    [62196] = { icon = 'esoui/art/icons/ability_nightblade_006_a.dds' }, -- Debilitate (Debilitate)
    [36965] = { tooltip = T.Skill_Cripple }, -- Crippling Grasp (Crippling Grasp)
    [36958] = { icon = 'esoui/art/icons/ability_nightblade_006_b.dds', tooltip = T.Skill_Cripple, hideReduce = true }, -- Crippling Grasp (Crippling Grasp)
    [36959] = { tooltip = A.Skill_Crippling_Grasp }, -- Major Expedition (Crippling Grasp)
    [36963] = { icon = 'esoui/art/icons/ability_nightblade_006_b.dds' }, -- Crippling Grasp (Crippling Grasp)
    [36964] = { tooltip = T.Generic_Immobilize }, -- Crippling Grasp (Crippling Grasp)

    -- Siphoning Strikes / Leeching Strikes / Siphoning Attacks
    [33319] = { tooltip = T.Skill_Siphoning_Strikes }, -- Siphoning Strikes (Siphoning Strikes)
    [33321] = { icon = 'esoui/art/icons/ability_nightblade_003.dds' }, -- Siphoning Strikes (Siphoning Strikes)
    [114957] = { icon = 'esoui/art/icons/ability_nightblade_003.dds' }, -- Siphoning Strikes (Siphoning Strikes)
    [36908] = { tooltip = T.Skill_Leeching_Strikes }, -- Leeching Strikes (Leeching Strikes)
    [36935] = { tooltip = T.Skill_Siphoning_Attacks }, -- Siphoning Attacks (Siphoning Attacks)

    -- Drain Power / Power Extraction / Sap Essence
    [33317] = { consolidateExtra = true, tooltip = A.Skill_Drain_Power }, -- Major Brutality (Drain Power)
    [36903] = { consolidateExtra = true, tooltip = A.Skill_Power_Extraction }, -- Major Brutality (Power Extraction)
    [36894] = { consolidate = true, tooltip = A.Skill_Sap_Essence }, -- Major Brutality (Sap Essence)
    [62240] = { consolidate = true, tooltip = A.Skill_Sap_Essence }, -- Major Sorcery (Sap Essence)
    [36899] = { icon = 'esoui/art/icons/ability_nightblade_013_a.dds', name = A.Skill_Sap_Essence }, -- Sap Will (Sap Essence)

    -- Soul Shred / Soul Siphon / Soul Tether
    [108814] = { hide = true }, -- Synergy Damage Bonus (Synergy - Soul Shred)
    [25171] = { icon = 'esoui/art/icons/ability_nightblade_018.dds' }, -- Soul Leech (Synergy - Soul Shred)
    [25091] = { hide = true }, -- Soul Shred (Soul Shred)
    [25093] = { tooltip = T.Generic_Stun }, -- Soul Shred (Soul Shred)
    [35508] = { tooltip = T.Generic_HoT_05Sec }, -- Soul Siphon (Soul Siphon)
    [63533] = { tooltip = A.Skill_Soul_Siphon }, -- Major Vitality (Soul Siphon)
    [106133] = { icon = 'esoui/art/icons/ability_nightblade_018_b.dds' }, -- Soul Siphon (Soul Siphon)
    [35613] = { hide = true }, -- Soul Leech (Soul Siphon)
    [35460] = { tooltip = T.Skill_Soul_Tether }, -- Soul Tether (Soul Tether)
    [35466] = { tooltip = T.Skill_Soul_Tether, hideReduce = true }, -- Soul Tether (Soul Tether)
    [36606] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds' }, -- Soul Tether (Soul Tether)
    [35462] = { name = A.Skill_Soul_Tether }, -- Soul Tether Leech (Soul Tether)
    [35461] = { hide = true }, -- Soul Leech (Soul Tether)

    ----------------------------------------------------------------
    -- SORCERER PASSIVES -------------------------------------------
    ----------------------------------------------------------------

    -- Dark Magic
    [108858] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_persistence.dds', name = A.Passive_Persistence, tooltip = T.Skill_Persistence_Rank_1 }, -- Persistance Cost Reduction (Persistence - Rank 1)
    [108862] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_persistence.dds', name = A.Passive_Persistence, tooltip = T.Skill_Persistence_Rank_2 }, -- Persistance Cost Reduction (Persistence - Rank 2)
    [62319] = { tooltip = A.Skill_Exploitation }, -- Minor Prophecy (Exploitation - Rank 1)
    [62320] = { tooltip = A.Skill_Exploitation }, -- Minor Prophecy (Exploitation - Rank 2)
    [31384] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_blood_magic.dds' }, -- Blood Magic (Blood Magic - Rank 1)
    [45173] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_blood_magic.dds' }, -- Blood Magic (Blood Magic - Rank 2)

    -- Daedric Summoning
    [64860] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_rebate.dds' }, -- Rebate (Rebate - Rank 1)
    [64861] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_rebate.dds' }, -- Rebate (Rebate - Rank 2)
    [31415] = { hide = true }, -- Expert Summoner (Expert Summoner - Rank 1)
    [46198] = { hide = true }, -- Expert Summoner (Expert Summoner - Rank 2)

    ----------------------------------------------------------------
    -- SORCERER ACTIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Crystal Shard / Crystal Blast / Crystal Fragments
    [46332] = { tooltip = T.Generic_Stun }, -- Crystal Blast (Crystal Blast)
    [46327] = { name = A.Skill_Crystal_Fragments, tooltip = T.Skill_Crystal_Fragments }, -- Crystal Fragments Proc (Crystal Fragments)

    -- Encase / Shattering Prison / Restraining Prison
    [28025] = { tooltip = T.Generic_Immobilize }, -- Encase (Encase)
    [28308] = { tooltip = T.Skill_Shattering_Prison }, -- Shattering Prison (Shattering Prison)
    [28311] = { tooltip = T.Generic_Immobilize }, -- Restraining Prison (Restraining Prison)
    [108832] = { tooltip = A.Skill_Restraining_Prison }, -- Major Vitality (Restraining Prison)

    -- Rune Prison / Rune Cage / Defensive Rune
    [24371] = { hide = true }, -- Rune Prison (Rune Prison)
    [24559] = { tooltip = T.Generic_Stun }, -- Rune Prison (Rune Prison)
    [24578] = { hide = true }, -- Rune Cage (Rune Cage)
    [24581] = { tooltip = T.Skill_Rune_Cage }, -- Rune Cage (Rune Cage)
    [24574] = { tooltip = T.Skill_Defensive_Rune }, -- Defensive Rune (Defensive Rune)
    [114602] = { hide = true }, -- Defensive Rune Constrict (Defensive Rune)
    [24576] = { tooltip = T.Generic_Stun }, -- Defensive Rune (Defensive Rune)

    -- Dark Exchange / Dark Deal / Dark Conversion
    [24585] = { icon = 'esoui/art/icons/ability_sorcerer_dark_exchange.dds' }, -- Dark Exchange (Dark Exchange)
    [24587] = { icon = 'esoui/art/icons/ability_sorcerer_dark_exchange.dds', name = A.Skill_Dark_Exchange }, -- Dark Exchange Heal (Dark Exchange)
    [114903] = { tooltip = T.Generic_Magicka_Regen }, -- Dark Exchange (Dark Exchange)
    [24596] = { icon = 'esoui/art/icons/ability_sorcerer_dark_deal.dds', name = A.Skill_Dark_Deal }, -- Dark Exchange (Dark Deal)
    [24597] = { icon = 'esoui/art/icons/ability_sorcerer_dark_deal.dds', name = A.Skill_Dark_Deal }, -- Dark Exchange Heal (Dark Deal)
    [114908] = { tooltip = T.Generic_Stamina_Regen }, -- Dark Deal (Dark Deal)
    [24591] = { icon = 'esoui/art/icons/ability_sorcerer_dark_conversion.dds', name = A.Skill_Dark_Conversion }, -- Dark Exchange (Dark Conversion)
    [24592] = { icon = 'esoui/art/icons/ability_sorcerer_dark_conversion.dds', name = A.Skill_Dark_Conversion }, -- Dark Exchange Heal (Dark Conversion)
    [114909] = { icon = 'esoui/art/icons/ability_sorcerer_dark_conversion.dds', name = A.Skill_Dark_Conversion, tooltip = T.Generic_Magicka_Regen }, -- Dark Exchange (Dark Exchange)

    -- Daedric Mines / Daedric Tomb / Daedric Minefield
    [24830] = { tooltip = T.Skill_Daedric_Mines }, -- Daedric Mines (Daedric Mines)
    [27935] = { tooltip = T.Generic_Immobilize }, -- Daedric Mines (Daedric Mines)
    [24847] = { tooltip = T.Skill_Daedric_Mines }, -- Daedric Mines (Daedric Tomb)
    [28452] = { tooltip = T.Generic_Immobilize }, -- Daedric Tomb (Daedric Tomb)
    [25158] = { tooltip = T.Skill_Daedric_Mines }, -- Daedric Mines (Daedric Minefield)
    [28454] = { tooltip = T.Generic_Immobilize }, -- Daedric Minefield (Daedric Minefield)

    -- Negate Magic / Suppression Field / Absorption Field
    [27706] = { tooltip = T.Skill_Negate_Magic }, -- Negate Magic (Negate Magic)
    [29824] = { duration = 0, groundLabel = true, tooltip = T.Generic_Silence_No_Dur }, -- Negate Magic (Negate Magic)
    [47147] = { duration = 0, groundLabel = true, tooltip = T.Generic_Stun_No_Dur }, -- Negate Magic (Negate Magic)
    [28341] = { tooltip = T.Skill_Suppression_Field }, -- Suppression Field (Suppression Field)
    [47160] = { duration = 0, groundLabel = true, tooltip = T.Skill_Suppression_Field_Silence, hideGround = true }, -- Suppression Field (Suppression Field)
    [47159] = { duration = 0, groundLabel = true, tooltip = T.Skill_Suppression_Field_Stun }, -- Suppression Field (Suppression Field)
    [80435] = { groundLabel = true, tooltip = T.Skill_Suppression_Field_Silence }, -- Suppression Field (Suppression Field)
    [28348] = { tooltip = T.Skill_Absorption_Field }, -- Absorption Field (Absorption Field)
    [47168] = { duration = 0, groundLabel = true, tooltip = T.Generic_Silence_No_Dur }, -- Absorption Field (Absorption Field)
    [47167] = { duration = 0, groundLabel = true, tooltip = T.Generic_Stun_No_Dur }, -- Absorption Field (Absorption Field)
    [80405] = { groundLabel = true, tooltip = T.Generic_AOE_Heal_0_5_Sec }, -- Absorption Field (Absorption Field)

    -- Summon Unstable Familiar / Summon Unstable Clannfear / Summon Volatile Familiar
    [27287] = { hide = true }, -- Birth Unstable Familiar (Summon Unstable Familiar - All Morphs)
    [43963] = { hide = true }, -- Pet Bonus Threat (Summon Unstable Familiar - All Morphs)
    [23304] = { tooltip = T.Skill_Unstable_Familiar }, -- Summon Unstable Familiar (Summon Unstable Familiar)
    [27850] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_familiar_melee.dds', name = A.Skill_Entropic_Touch }, -- Familiar Melee (Summon Unstable Familiar + Summon Volatile Familiar)
    [108842] = { name = A.Skill_Unstable_Pulse, tooltip = T.Skill_Familiar_Damage_Pulse, icon = 'esoui/art/icons/ability_sorcerer_unstable_fimiliar_summoned.dds'  }, -- Volatile Familiar Damage Pulsi (Summon Unstable Familiar)
    [108843] = { name = A.Skill_Unstable_Pulse, tooltip = T.Skill_Familiar_Damage_Pulse_Self, icon = 'esoui/art/icons/ability_sorcerer_unstable_fimiliar_summoned.dds'  }, -- Volatile Familiar (Summon Unstable Familiar)
    [108844] = { name = A.Skill_Unstable_Pulse, icon = 'esoui/art/icons/ability_sorcerer_unstable_fimiliar_summoned.dds' }, -- Familiar Damage Pulse (Summon Unstable Familiar)
    [23319] = { tooltip = T.Skill_Unstable_Clannfear }, -- Summon Unstable Clannfear (Summon Unstable Clannfear)
    [29528] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_claw.dds', name = A.Skill_Headbutt }, -- Claw (Summon Unstable Clannfear)
    [29529] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_tail_spike.dds' }, -- Tail Spike (Summon Unstable Clannfear)
    [23316] = { tooltip = T.Skill_Volatile_Familiar }, -- Summon Volatile Familiar (Summon Volatile Familiar)
    [77187] = { name = A.Skill_Volatile_Pulse, tooltip = T.Skill_Familiar_Stun_Pulse }, -- Volatile Familiar Damage Pulsi (Summon Volatile Familiar)
    [88933] = { name = A.Skill_Volatile_Pulse, tooltip = T.Skill_Familiar_Stun_Pulse_Self }, -- Volatile Familiar (Summon Volatile Familiar)
    [77186] = { name = A.Skill_Volatile_Pulse }, -- Familiar Damage Pulse (Summon Volatile Familiar)
    [77243] = { tooltip = T.Generic_Stun, name = A.Skill_Volatile_Pulse }, -- Volatile Familiar Stun (Summon Volatile Familiar)
    [117255] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_familiar_melee.dds', name = A.Skill_Entropic_Touch }, -- Volatile Familiar Melee (Summon Volatile Familiar)

    -- Daedric Curse / Daedric Prey / Haunting Curse
    [24326] = { tooltip = T.Skill_Daedric_Curse }, -- Daedric Curse (Daedric Curse)
    [24328] = { tooltip = T.Skill_Daedric_Prey }, -- Daedric Prey (Daedric Prey)
    [24330] = { tooltip = T.Skill_Haunting_Curse }, -- Haunting Curse (Haunting Curse)
    [89491] = { tooltip = T.Skill_Haunting_Curse }, -- Haunting Curse (Haunting Curse)

    -- Summon Winged Twilight / Summon Twilight Tormentor / Summon Twilight Matriarch
    [24617] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_zap.dds', name = A.Skill_Zap }, -- Zap (Summon Winged Twilight - All Morphs)
    [28027] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_kick.dds', name = A.Skill_Kick }, -- Kick (Summon Winged Twilight - All Morphs)
    [24613] = { tooltip = T.Skill_Winged_Twilight }, -- Summon Winged Twilight (Summon Winged Twilight)
    [24739] = { hide = true }, -- Summon Winged Twilight (Summon Winged Twilight)
    [108847] = { name = A.Skill_Winged_Twilight_Restore, icon = 'esoui/art/icons/ability_sorcerer_lightning_prey_summoned.dds' }, -- Summon Twilight Matriarch (Summon Winged Twilight)
    [108846] = { name = A.Skill_Winged_Twilight_Restore, icon = 'esoui/art/icons/ability_sorcerer_lightning_prey_summoned.dds' }, -- Summon Twilight Matriarch (Summon Winged Twilight)
    [24636] = { tooltip = T.Skill_Twilight_Tormentor }, -- Summon Twilight Tormentor (Summon Twilight Tormentor)
    [24741] = { hide = true }, -- Twilight Tormentor (Summon Twilight Tormentor)
    [77354] = { name = A.Skill_Tormentor_Damage_Boost, tooltip = T.Skill_Tormentor_Damage_Boost }, -- Summon Twilight Tormentor (Summon Twilight Tormentor)
    [88937] = { name = A.Skill_Tormentor_Damage_Boost, tooltip = T.Skill_Tormentor_Damage_Boost_Self }, -- Twilight Tormentor (Summon Twilight Tormentor)
    [117274] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_zap.dds', name = A.Skill_Zap }, -- Twilight Tormentor Zap (Summon Twilight Tormentor)
    [117273] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_kick.dds', name = A.Skill_Kick }, -- Twilight Tormentor Kick (Summon Twilight Tormentor)
    [24639] = { tooltip = T.Skill_Twilight_Matriarch }, -- Summon Twilight Matriarch (Summon Twilight Matriarch)
    [24742] = { hide = true }, -- Twilight Matriarch (Summon Twilight Matriarch)
    [77407] = { name = A.Skill_Twilight_Matriarch_Restore }, -- Summon Twilight Matriarch (Summon Twilight Matriarch)
    [77371] = { name = A.Skill_Twilight_Matriarch_Restore }, -- Summon Twilight Matriarch (Summon Twilight Matriarch)
    [117321] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_zap.dds', name = A.Skill_Zap }, -- Twilight Matriarch Zap (Summon Twilight Matriarch)
    [117320] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_kick.dds', name = A.Skill_Kick }, -- Twilight Matriarch Kick (Summon Twilight Matriarch)

    -- Conjured Ward / Hardened Ward / Empowered Ward
    [28418] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Conjured Ward (Conjured Ward)
    [28421] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Conjured Ward (Conjured Ward)
    [28832] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Conjured Ward (Conjured Ward)
    [29489] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Hardened Ward (Hardened Ward)
    [29490] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Hardened Ward (Hardened Ward)
    [29491] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Hardened Ward (Hardened Ward)
    [29482] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Empowered Ward (Empowered Ward)
    [29483] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Empowered Ward (Empowered Ward)
    [29484] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Empowered Ward (Empowered Ward)
    [77418] = { tooltip = A.Skill_Empowered_Ward }, -- Minor Intellect (Empowered Ward)

    -- Bound Armor / Bound Armaments / Bound Aegis
    [24158] = { tooltip = T.Skill_Bound_Armor }, -- Bound Armor (Bound Armor)
    [24165] = { tooltip = T.Skill_Bound_Armor }, -- Bound Armaments (Bound Armaments)
    [24163] = { tooltip = T.Skill_Bound_Armor }, -- Bound Aegis (Bound Aegis)

    -- Summon Storm Atronach / Greater Storm Atronach / Summon Charged Atronach
    [48078] = { tooltip = A.Skill_Charged_Lightning }, -- Major Berserk (Charged Lightning Synergy)
    [62195] = { tooltip = A.Skill_Charged_Lightning }, -- Major Berserk (Charged Lightning Synergy)
    [23428] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_atronach_zap.dds', tooltip = T.Skill_Atronach_Zap }, -- Atronach Zap (Summon Storm Atronach - All Morphs)
    [26098] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_atronach_zap.dds', name = A.Skill_Atronach_Zap, hide = true }, -- Zap Snare (Summon Storm Atronach - All Morphs)
    [23636] = { tooltip = T.Skill_Storm_Atronach }, -- Summon Storm Atronach (Summon Storm Atronach)
    [80459] = { tooltip = T.Skill_Storm_Atronach }, -- Summon Storm Atronach (Summon Storm Atronach)
    [23658] = { tooltip = T.Generic_Stun }, -- Summon Storm Atronach (Summon Storm Atronach)
    [23665] = { tooltip = T.Skill_Storm_Atronach }, -- Greater Storm Atronach (Greater Storm Atronach)
    [80463] = { tooltip = T.Skill_Storm_Atronach }, -- Greater Storm Atronach (Greater Storm Atronach)
    [23662] = { tooltip = T.Generic_Stun }, -- Greater Storm Atronach (Greater Storm Atronach)
    [23668] = { tooltip = T.Skill_Charged_Atronach }, -- Summon Charged Atronach (Summon Charged Atronach)
    [80468] = { tooltip = T.Skill_Charged_Atronach }, -- Summon Charged Atronach (Summon Charged Atronach)
    [23666] = { tooltip = T.Generic_Stun }, -- Summon Charged Atronach (Summon Charged Atronach)
    [29806] = { hide = true }, -- Lightning Strike (Summon Charged Atronach)
    [43764] = { hide = true }, -- Lightning Strike (Summon Charged Atronach)
    [43767] = { hide = true }, -- Lightning Strike (Summon Charged Atronach)
    [43765] = { hide = true }, -- Lightning Strike (Summon Charged Atronach)
    [43766] = { hide = true }, -- Lightning Strike (Summon Charged Atronach)
    [29809] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_lightning_strike.dds' }, -- Lightning Strike (Summon Charged Atronach)

    -- Mages' Fury, Mages' Wrath, Endless Fury
    [18746] = { tooltip = T.Skill_Mages_Fury }, -- Mages' Fury (Mages' Fury)
    [19125] = { tooltip = T.Skill_Mages_Fury }, -- Mages' Wrath (Mages' Wrath)
    [19118] = { tooltip = T.Skill_Endless_Fury }, -- Endless Fury (Endless Fury)

    -- Lightning Form / Hurricane / Boundless Storm
    [23210] = { tooltip = T.Skill_Lightning_Form }, -- Lightning Form (Lightning Form)
    [62159] = { consolidate = true, tooltip = A.Skill_Lightning_Form }, -- Major Resolve (Lightning Form)
    [62160] = { consolidate = true, tooltip = A.Skill_Lightning_Form }, -- Major Ward (Lightning Form)
    [23231] = { tooltip = T.Skill_Hurricane }, -- Hurricane (Hurricane)
    [62167] = { consolidate = true, tooltip = A.Skill_Hurricane }, -- Major Ward (Hurricane)
    [62168] = { consolidate = true, tooltip = A.Skill_Hurricane }, -- Major Resolve (Hurricane)
    [82797] = { consolidate = true, tooltip = A.Skill_Hurricane }, -- Minor Expedition (Hurricane)
    [23213] = { tooltip = T.Skill_Lightning_Form }, -- Boundless Storm (Boundless Storm)
    [23216] = { tooltip = A.Skill_Boundless_Storm }, -- Major Expedition (Boundless Storm)
    [62175] = { consolidate = true, tooltip = A.Skill_Boundless_Storm }, -- Major Resolve (Boundless Storm)
    [62176] = { consolidate = true, tooltip = A.Skill_Boundless_Storm }, -- Major Ward (Boundless Storm)

    -- Lightning Splash / Liquid Lightning / Lightning Flood
    [108607] = {hide = true }, -- Synergy Damage Bonus (Lightning Splash - Conduit Synergy)
    [23182] = { tooltip = T.Skill_Lightning_Splash }, -- Lightning Splash (Lightning Splash)
    [23200] = { tooltip = T.Skill_Lightning_Splash }, -- Liquid Lightning (Liquid Lightning)
    [23205] = { tooltip = T.Skill_Lightning_Splash }, -- Lightning Flood (Lightning Flood)
    [23189] = { groundLabel = true, tooltip = T.Generic_AOE_Shock_1_Sec }, -- Lightning Splash (Lightning Splash)
    [23202] = { groundLabel = true, tooltip = T.Generic_AOE_Shock_1_Sec }, -- Liquid Lightning (Liquid Lightning)
    [23208] = { groundLabel = true, tooltip = T.Generic_AOE_Shock_1_Sec }, -- Lightning Flood (Lightning Flood)

    -- Surge / Power Surge / Critical Surge
    [23670] = { tooltip = T.Skill_Surge }, -- Surge (Surge)
    [23673] = { consolidate = true, tooltip = A.Skill_Surge }, -- Major Brutality (Surge)
    [23674] = { tooltip = T.Skill_Surge }, -- Power Surge (Power Surge)
    [62062] = { consolidate = true, tooltip = A.Skill_Power_Surge }, -- Major Sorcery (Power Surge)
    [62060] = { consolidate = true, tooltip = A.Skill_Power_Surge }, -- Major Brutality (Power Surge)
    [23678] = { tooltip = T.Skill_Surge }, -- Critical Surge (Critical Surge)
    [62147] = { consolidate = true, tooltip = A.Skill_Critical_Surge }, -- Major Brutality (Critical Surge)

    -- Bolt Escape
    [51392] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Bolt_Escape_Fatigue }, -- Bolt Escape Fatigue (Bolt Escape - All Morphs)
    [23235] = { tooltip = T.Generic_Stun }, -- Bolt Escape (Bolt Escape)
    [28482] = { tooltip = T.Generic_Stun }, -- Streak (Streak)
    [23283] = { hide = true }, -- Summoned Ball of Lightning (Ball of Lightning)
    [23284] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_intercept.dds', duration = 0, forcedContainer = 'short', tooltip = T.Skill_Intercept, groundLabel = true }, -- Intercept (Ball of Lightning)
    [23279] = { hide = true }, -- Ball of Lightning (Ball of Lightning)
    [23278] = { tooltip = T.Generic_Stun }, -- Ball of Lightning (Ball of Lightning)

    -- Overload / Power Overload / Energy Overload
    [24785] = { tooltip = T.Skill_Overload }, -- Overload (Overload)
    [24806] = { tooltip = T.Skill_Overload }, -- Power Overload (Power Overload)
    [114769] = { icon = 'esoui/art/icons/ability_sorcerer_power_overload.dds' }, -- Power Overload Light Attack (Power Overload)
    [24804] = { tooltip = T.Skill_Energy_Overload }, -- Energy Overload (Energy Overload)
    [114773] = { icon = 'esoui/art/icons/ability_sorcerer_energy_overload.dds' }, -- Energy Overload Light Attack (Energy Overload)
    [114798] = { icon = 'esoui/art/icons/ability_sorcerer_energy_overload.dds', name = A.Skill_Energy_Overload_Heavy }, -- Power Overload Heavy Attack (Energy Overload)
    [29740] = { icon = 'esoui/art/icons/ability_sorcerer_energy_overload.dds' }, -- Energy Overload (Energy Overload)

    ----------------------------------------------------------------
    -- TEMPLAR PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Aedric Spear
    [114838] = { tooltip = A.Skill_Spear_Wall }, -- Minor Protection (Spear Wall - Rank 1)
    [114841] = { tooltip = A.Skill_Spear_Wall }, -- Minor Protection (Spear Wall - Rank 2)
    [31720] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 1)
    [80153] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 1)
    [44731] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 2)
    [80170] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_burning_light.dds' }, -- Burning Light (Burning Light - Rank 2)
    [31565] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_balanced_warrior.dds' }, -- Balanced Warrior
    [44732] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_balanced_warrior.dds' }, -- Balanced Warrior

    -- Dawn's Wrath
    [31746] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_prism.dds' }, -- Prism (Prism - Rank 1)
    [45217] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_prism.dds' }, -- Prism (Prism - Rank 2)
    [31721] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_restoring_spirit.dds' }, -- Restoring Spirt
    [45212] = { icon = 'LuiExtended/media/icons/abilities/passive_templar_restoring_spirit.dds' }, -- Restoring Spirt
    [62799] = { tooltip = A.Skill_Illuminate }, -- Minor Sorcery (Illuminate)
    [62800] = { tooltip = A.Skill_Illuminate }, -- Minor Sorcery (Illuminate)

    -- Restoring Light
    [31757] = { icon = 'esoui/art/icons/ability_templar_032.dds' }, -- Sacred Ground
    [45207] = { icon = 'esoui/art/icons/ability_templar_032.dds' }, -- Sacred Ground
    [31759] = { duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = A.Skill_Sacred_Ground }, -- Minor Mending (Sacred Ground - Rank 1 & 2)
    [77082] = { duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = A.Skill_Sacred_Ground }, -- Minor Mending (Sacred Ground - Rank 1 & 2)
    [80195] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0, groundLabel = true, tooltip = T.Generic_Snare_40_No_Dur }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)
    [80230] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0, groundLabel = true, tooltip = T.Generic_Snare_40_No_Dur }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)
    [80261] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_sacred_ground.dds', duration = 0, groundLabel = true, tooltip = T.Generic_Snare_40_No_Dur }, -- Sacred Ground (Sacred Ground - Rank 1 & 2)
    [31760] = { icon = 'esoui/art/icons/ability_templar_014.dds' }, -- Light Weaver
    [45208] = { icon = 'esoui/art/icons/ability_templar_014.dds' }, -- Light Weaver
    [52703] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_light_weaver.dds', name = A.Passive_Light_Weaver }, -- Light Weaver Ultimate (Light Weaver - Rank 1 & 2)

    ----------------------------------------------------------------
    -- TEMPLAR ACTIVE ABILITIES ------------------------------------
    ----------------------------------------------------------------

    -- Puncturing Strikes / Biting Jabs / Puncturing Sweep
    [76908] = { tooltip = T.Generic_Snare_70 }, -- Puncturing Strikes (Puncturing Strikes)
    [26795] = { tooltip = A.Skill_Biting_Jabs }, -- Major Savagery (Biting Jabs)
    [76912] = { tooltip = T.Generic_Snare_70 }, -- Biting Jabs (Biting Jabs)
    [55183] = { icon = 'esoui/art/icons/ability_templar_reckless_attacks.dds', name = A.Skill_Puncturing_Sweep }, -- Puncturing Sweep Heal (Puncturing Sweep)
    [76916] = { tooltip = T.Generic_Snare_70 }, -- Puncturing Sweep (Puncturing Sweep)

    -- Piercing Javelin / Aurora Javelin / Binding Javelin
    [37409] = { tooltip = T.Generic_Knockback }, -- Piercing Javelin (Piercing Javelin)
    [37414] = { name = A.Skill_Aurora_Javelin, tooltip = T.Generic_Knockback }, -- Piercing Javelin (Aurora Javelin)
    [32099] = { tooltip = T.Generic_Knockdown }, -- Binding Javelin (Binding Javelin)

    -- Focused Charge / Explosive Charge / Toppling Charge
    [26508] = { icon = '' }, -- Charge (Focused Charge) -- Hide for Interrupt notification on Combat Text
    [49204] = { icon = 'esoui/art/icons/ability_templar_focused_charge.dds' }, -- Focused Charge (Focused Charge)
    [49205] = { icon = 'esoui/art/icons/ability_templar_focused_charge.dds', tooltip = T.Generic_Stun }, -- Focused Charge (Focused Charge)
    [26522] = { hide = true, icon = '' }, -- Charge (Explosive Charge)
    [49213] = { icon = 'esoui/art/icons/ability_templar_double_tipped_charge.dds', tooltip = T.Generic_Stun }, -- Explosive Charge (Explosive Charge)
    [15546] = { tooltip = T.Generic_Stun }, -- Toppling Charge (Toppling Charge)
    [26518] = { icon = '' }, -- Charge (Toppling Charge)
    [44422] = { name = A.Skill_Off_Balance }, -- Toppling Charge (Toppling Charge)
    [115940] = { tooltip = T.Generic_Stun }, -- Toppling Charge (Toppling Charge)

    -- Spear Shards / Luminous Shards / Blazing Spear
    [108924] = { hide = true }, -- Synergy Damage Bonus (Spear Shards - Blessed Shards Synergy)
    [108821] = { hide = true }, -- Synergy Damage Bonus (Luminous Shards - Holy Shards Synergy)
    [95933] = { tooltip = T.Skill_Spear_Shards }, -- Spear Shards (Spear Shards)
    [95931] = { icon = 'esoui/art/icons/ability_templar_sun_strike.dds', groundLabel = true, tooltip = T.Generic_AOE_Magic_1_Sec }, -- Spear Shards (Spear Shards)
    [95957] = { tooltip = T.Skill_Luminous_Shards }, -- Luminous Shards (Luminous Shards)
    [95955] = { icon = 'esoui/art/icons/ability_templar_light_strike.dds', groundLabel = true, tooltip = T.Generic_AOE_Magic_1_Sec }, -- Luminous Shards (Luminous Shards)
    [26880] = { tooltip = T.Skill_Spear_Shards }, -- Blazing Spear (Blazing Spear)
    [26879] = { groundLabel = true, tooltip = T.Generic_AOE_Magic_1_Sec }, -- Blazing Spear

    -- Sun Shield / Radiant Ward / Blazing Shield
    [22179] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Sun Shield (Sun Shield)
    [26724] = { hide = true }, -- Sun Shield Hit Bonus (Sun Shield)
    [22183] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Radiant Ward (Radiant Ward)
    [26732] = { hide = true }, -- Sun Shield Hit Bonus (Radiant Ward)
    [49091] = { tooltip = T.Skill_Blazing_Shield }, -- Blazing Shield (Blazing Shield)
    [49090] = { hide = true }, -- Sun Shield Hit Bonus (Blazing Shield)
    [22181] = { hide = true }, -- Blazing Shield (Blazing Shield)

    -- Radial Sweep /  Empowering Sweep / Crescent Sweep
    [62593] = { tooltip = T.Skill_Radial_Sweep }, -- Radial Sweep (Radial Sweep)
    [55214 ] = { name = A.Skill_Major_Protection, tooltip = A.Skill_Empowering_Sweep }, -- Empowering Sweep (Empowering Sweep)
    [62599] = { name = A.Skill_Empowering_Sweep, tooltip = T.Skill_Radial_Sweep }, -- Radial Sweep (Empowering Sweep)
    [62598] = { name = A.Skill_Empowering_Sweep }, -- Radial Sweep (Empowering Sweep)
    [62607] = { icon = 'esoui/art/icons/ability_templar_crescent_sweep.dds', tooltip = T.Skill_Radial_Sweep  }, -- Crescent Sweep (Crescent Sweep)
    [62606] = { icon = 'esoui/art/icons/ability_templar_crescent_sweep.dds', name = A.Skill_Crescent_Sweep }, -- Radial Sweep (Crescent Sweep)

    -- Dawn's Wrath

    -- Sun Fire / Vampire's Bane / Reflective Light
    [21727] = { icon = 'esoui/art/icons/ability_templar_sun_fire.dds', tooltip = T.Skill_Sun_Fire_Snare, tooltipValue2Mod = 2.3, hideReduce = true }, -- Sun Fire (Sun Fire)
    [21728] = { tooltip = T.Skill_Sun_Fire, tooltipValue2Mod = -2.3 }, -- Sun Fire (Sun Fire)
    [62747] = { tooltip = A.Skill_Sun_Fire }, -- Major Prophecy (Sun Fire)
    [21730] = { icon = 'esoui/art/icons/ability_templar_vampire_bane.dds', tooltip = T.Skill_Sun_Fire_Snare, tooltipValue2Mod = 4.3, hideReduce = true }, -- Vampire's Bane (Vampire's Bane)
    [21731] = { tooltip = T.Skill_Sun_Fire, tooltipValue2Mod = -4.3 }, -- Vampire's Bane (Vampire's Bane)
    [62751] = { tooltip = A.Skill_Vampires_Bane }, -- Major Prophecy (Vampire's Bane)
    [21733] = { icon = 'esoui/art/icons/ability_templar_reflective_light.dds', tooltip = T.Skill_Sun_Fire_Snare, tooltipValue2Mod = 2.3, hideReduce = true }, -- Reflective Light (Reflective Light)
    [21734] = { tooltip = T.Skill_Sun_Fire, tooltipValue2Mod = -2.3 }, -- Reflective Light (Reflective Light)
    [62755] = { tooltip = A.Skill_Reflective_Light }, -- Major Prophecy (Reflective Light)

    -- Solar Flare / Dark Flare / Solar Barrage
    [109418] = { tooltip = A.Skill_Solar_Flare }, -- Empower (Solar Flare)
    [24686] = { tooltip = A.Skill_Dark_Flare }, -- Major Defile (Dark Flare)
    [109419] = { tooltip = A.Skill_Dark_Flare }, -- Empower (Dark Flare)
    [22095] = { tooltip = T.Skill_Solar_Barrage }, -- Solar Barrage (Solar Barrage)

    -- Backlash / Purifying Light / Power of the Light
    [21761] = { tooltip = T.Skill_Backlash }, -- Backlash (Backlash)
    [21765] = { tooltip = T.Skill_Purifying_Light }, -- Purifying Light (Purifying Light)
    [68581] = { name = A.Skill_Purifying_Light, icon = 'esoui/art/icons/ability_templar_purifying_light.dds', unbreakable = 1, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Skill_Purifying_Light_HoT }, -- Purifying Light Tick (Purifying Light)
    [21908] = { icon = 'esoui/art/icons/ability_templar_purifying_light.dds' }, -- Purifying Light (Purifying Light)
    [21763] = { tooltip = T.Skill_Power_of_the_Light }, -- Power of the Light (Power of the Light)
    [64144] = { consolidate = true, tooltip = A.Skill_Power_of_the_Light }, -- Minor Fracture (Power of the Light)
    [68588] = { consolidate = true, tooltip = A.Skill_Power_of_the_Light }, -- Minor Breach (Power of the Light)

    -- Eclipse / Total Dark / Unstable Core
    [21776] = { tooltip = T.Skill_Eclipse }, -- Eclipse (Eclipse)
    [22006] = { tooltip = T.Skill_Total_Dark }, -- Total Dark (Total Dark)
    [63083] = { icon = 'esoui/art/icons/ability_templar_total_dark.dds' }, -- Total Dark (Total Dark)
    [68729] = { icon = 'esoui/art/icons/ability_templar_total_dark.dds' }, -- Total Dark (Total Dark)
    [22004] = { tooltip = T.Skill_Unstable_Core }, -- Unstable Core (Unstable Core)
    [100211] = { icon = 'esoui/art/icons/ability_templar_unstable_core.dds', name = A.Skill_Unstable_Core, tooltip = T.Skill_Eclipse }, -- Eclipse Trigger (Unstable Core)
    [100210] = { icon = 'esoui/art/icons/ability_templar_unstable_core.dds', name = A.Skill_Unstable_Core }, -- Eclipse (Unstable Core)

    -- Radiant Destruction / Radiant Glory / Radiant Oppression
    [63029] = { tooltip = T.Skill_Radiant_Destruction }, -- Radiant Destruction (Radiant Destruction)
    [63044] = { tooltip = T.Skill_Radiant_Destruction }, -- Radiant Glory (Radiant Glory)
    [69118] = { icon = 'esoui/art/icons/ability_templar_under_exposure.dds', name = A.Skill_Radiant_Glory }, -- Radiant Glory Heal (Radiant Glory)
    [63956] = { icon = 'esoui/art/icons/ability_templar_under_exposure.dds' }, -- Radiant Glory (Radiant Glory)
    [63046] = { tooltip = T.Skill_Radiant_Destruction }, -- Radiant Oppression (Radiant Oppresion)
    [63961] = { icon = 'esoui/art/icons/ability_templar_stendarr_aura.dds'}, -- Radiant Destruction (Radiant Oppression)

    -- Nova / Solar Prison / Solar Disturbance
    [108822] = { hide = true }, -- Synergy Damage Bonus (Nova - Supernova Synergy)
    [31562] = { tooltip = T.Generic_Stun }, -- Supernova (Nova - Supernova Synergy)
    [21976] = { tooltip = T.Skill_Nova }, -- Nova (Nova)
    [21754] = { name = A.Skill_Major_Maim, duration = 0, groundLabel = true, tooltip = A.Skill_Nova }, -- Nova (Nova)
    [108823] = { hide = true }, -- Synergy Damage Bonus (Solar Prison - Gravity Crush Synergy)
    [34443] = { tooltip = T.Generic_Stun }, -- Gravity Crush (Solar Prison - Gravity Crush Synergy)
    [22003] = { tooltip = T.Skill_Solar_Prison }, -- Solar Prison (Solar Prison)
    [21757] = { name = A.Skill_Major_Maim, duration = 0, groundLabel = true, tooltip = A.Skill_Solar_Prison }, -- Solar Prison (Solar Prison)
    [22001] = { tooltip = T.Skill_Solar_Disturbance, tooltipValue2Mod = -4.8 }, -- Solar Disturbance (Solar Disturbance)
    [21760] = { name = A.Skill_Major_Maim, tooltip = A.Skill_Solar_Disturbance }, -- Solar Disturbance (Solar Disturbance)
    [24307] = { icon = 'esoui/art/icons/ability_templar_solar_disturbance.dds', name = A.Skill_Solar_Disturbance, internalStack = 0, groundLabel = true, tooltip = T.Skill_Solar_Disturbance_Ground, hideGround = true }, -- Solar Disturbance Snare (Solar Disturbance)

    [21753] = { groundLabel = true, tooltip = T.Generic_AOE_Magic_1_Sec }, -- Nova
    [21756] = { groundLabel = true, tooltip = T.Generic_AOE_Magic_1_Sec }, -- Solar Prison
    [21759] = { groundLabel = true, tooltip = T.Skill_Solar_Disturbance_Ground }, -- Solar Disturbance

    -- Restoring Light
    [35632] = { tooltip = T.Generic_Magicka_Regen_2_Sec }, -- Honor the Dead (Honor the Dead)
    [44391] = { icon = 'esoui/art/icons/ability_templar_breath_of_life.dds' }, -- Breath of Life (Breath of Life)

    -- Healing Ritual
    [22307] = { icon = 'esoui/art/icons/ability_templar_healing_ritual.dds' }, -- Healing Ritual (Healing Ritual)
    [22331] = { icon = 'esoui/art/icons/ability_templar_ritual_of_rebirth.dds' }, -- Ritual of Rebirth (Ritual of Rebirth)
    [88456] = { icon = 'esoui/art/icons/ability_templar_ritual_of_rebirth.dds' }, -- Ritual of Rebirth (Ritual of Rebirth)
    [108935] = { icon = 'esoui/art/icons/ability_buff_minor_expedition.dds', tooltip = A.Skill_Hasty_Prayer }, -- Minor Expedition (Hasty Prayer)

    -- Restoring Aura / Radiant Aura / Cleansing Ritual
    [26213] = { consolidate = true, tooltip = A.Skill_Restoring_Aura }, -- Minor Fortitude (Restoring Aura - All Morphs)
    [26216] = { consolidate = true, tooltip = A.Skill_Restoring_Aura }, -- Minor Intellect (Restoring Aura - All Morphs)
    [26215] = { consolidate = true, tooltip = A.Skill_Restoring_Aura }, -- Minor Endurance (Restoring Aura - All Morphs)
    [26220] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds', tooltip = A.Skill_Restoring_Aura }, -- Minor Magickasteal (Restoring Aura)
    [88472] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds' }, -- Minor Magickasteal (Restoring Aura)
    [26809] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds', tooltip = A.Skill_Radiant_Aura }, -- Minor Magickasteal (Radiant Aura)
    [88486] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds' }, -- Minor Magickasteal (Radiant Aura)
    [26823] = { icon = 'esoui/art/icons/ability_templar_persistant_sigil.dds' }, -- Repentance Magicka Restore (Repentance)
    [26824] = { icon = 'esoui/art/icons/ability_templar_persistant_sigil.dds' }, -- Repentance Heal (Repentance)

    -- Cleansing Ritual / Ritual of Retribution / Extended Ritual
    [108824] = { hide = true }, -- Synergy Damage Bonus (Cleansing Ritual - Purify Synergy)
    [44013] = { icon = 'esoui/art/icons/ability_templar_cleansing_ritual.dds' }, -- Purify (Cleansing Ritual - Purify Synergy)
    [26286] = { name = A.Skill_Cleansing_Ritual, groundLabel = true, tooltip = T.Generic_AOE_Heal_2_Sec }, -- Healing Ritual (Cleansing Ritual)
    [80540] = { tooltip = T.Skill_Cleansing_Ritual }, -- Cleansing Ritual (Cleansing Ritual)
    [26298] = { icon = 'esoui/art/icons/ability_templar_purifying_ritual.dds', groundLabel = true, tooltip = T.Generic_AOE_Heal_2_Sec }, -- Ritual of Retribution (Ritual of Retribution)
    [80172] = { icon = 'esoui/art/icons/ability_templar_purifying_ritual.dds', groundLabel = true, tooltip = T.Generic_AOE_Magic_2_Sec }, -- Ritual of Retribution (Ritual of Retribution)
    [80547] = { tooltip = T.Skill_Ritual_of_Retribution }, -- Ritual of Retribution (Ritual of Retribution)
    [26303] = { icon = 'esoui/art/icons/ability_templar_extended_ritual.dds', groundLabel = true, tooltip = T.Generic_AOE_Heal_2_Sec }, -- Extended Ritual (Extended Ritual)
    [80553] = { tooltip = T.Skill_Cleansing_Ritual }, -- Extended Ritual (Extended Ritual)

    -- Rune Focus / Channeled Focus / Restoring Focus
    [22236] = { consolidate = true, tooltip = A.Skill_Rune_Focus }, -- Major Resolve (Rune Focus)
    [44820] = { consolidate = true, tooltip = A.Skill_Rune_Focus }, -- Major Ward (Rune Focus)
    [112145] = { name = A.Skill_Rune_Focus, tooltip = T.Skill_Rune_Focus_Bonus, forcedContainer = "short", groundLabel = 1 }, -- Rune Focus Circle Bonus (Rune Focus)
    [44828] = { consolidate = true, tooltip = A.Skill_Channeled_Focus }, -- Major Resolve (Channeled Focus)
    [44827] = { consolidate = true, tooltip = A.Skill_Channeled_Focus }, -- Major Ward (Channeled Focus)
    [37009] = { tooltip = T.Generic_Magicka_Regen },  -- Channeled Focus (Channeled Focus)
    [112166] = { name = A.Skill_Channeled_Focus, tooltip = T.Skill_Rune_Focus_Bonus, forcedContainer = "short", groundLabel = 1 }, -- Rune Focus Circle Bonus (Channeled Focus)
    [44836] = { consolidate = true, tooltip = A.Skill_Restoring_Focus }, -- Major Resolve (Restoring Focus)
    [44835] = { consolidate = true, tooltip = A.Skill_Restoring_Focus }, -- Major Ward (Restoring Focus)
    [114842] = { tooltip = T.Generic_Stamina_Regen },  -- Restoring Focus (Restoring Focus)
    [112167] = { name = A.Skill_Restoring_Focus, tooltip = T.Skill_Rune_Focus_Bonus, forcedContainer = "short", groundLabel = 1 }, -- Rune Focus Circle Bonus (Restoring Focus)

    -- Rite of Passage / Remembrance / Practiced Incantation
    [22223] = { tooltip = T.Skill_Rite_of_Passage }, -- Rite of Passage (Rite of Passage)
    [22225] = { icon = 'esoui/art/icons/ability_templar_rite_of_passage.dds', tooltip = T.Generic_AOE_Heal_1_Sec, groundLabel = true }, -- Rite of Passage (Rite of Passage)
    [22229] = { tooltip = T.Skill_Rite_of_Passage }, -- Remembrance (Remembrance)
    [22231] = { icon = 'esoui/art/icons/ability_templar_remembrance.dds', tooltip = T.Generic_AOE_Heal_1_Sec, groundLabel = true }, -- Remembrance (Remembrance)
    [22233] = { tooltip = A.Skill_Remembrance }, -- Remembrance (Remembrance)
    [22226] = { tooltip = T.Skill_Rite_of_Passage }, -- Practiced Incantation (Practiced Incantation)
    [22228] = { icon = 'esoui/art/icons/ability_templar_practiced_incantation.dds', tooltip = T.Generic_AOE_Heal_1_Sec, groundLabel = true }, -- Practiced Incantation (Practiced Incantation)

    ----------------------------------------------------------------
    -- WARDEN PASSIVE ABILITIES ------------------------------------
    ----------------------------------------------------------------

    -- Animal Companions
    [86064] = { name = A.Passive_Bond_with_Nature }, -- Bond With Nature (Bond With Nature - Rank 1)
    [88986] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_bond_with_nature.dds', name = A.Passive_Bond_with_Nature }, -- Bond With Nature (Bond With Nature - Rank 1)
    [86065] = { name = A.Passive_Bond_with_Nature }, -- Bond With Nature (Bond With Nature - Rank 2)
    [88988] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_bond_with_nature.dds', name = A.Passive_Bond_with_Nature }, -- Bond With Nature (Bond With Nature - Rank 2)
    [88512] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_savage_beast.dds', name = A.Passive_Savage_Beast }, -- Savage Beast Ultimate (Savage Beast - Rank 1)
    [88513] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_savage_beast.dds', name = A.Passive_Savage_Beast }, -- Transfer (Savage Beast - Rank 2)

    -- Green Balance
    [88525] = { tooltip = A.Skill_Accelerated_Growth }, -- Major Mending (Accelerated Growth - Rank 1)
    [88528] = { tooltip = A.Skill_Accelerated_Growth }, -- Major Mending (Accelerated Growth - Rank 2)
    [88483] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds', name = A.Passive_Natures_Gift }, -- Nature's Give (Nature's Gift - Rank 1)
    [93054] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds' }, -- Nature's Gift (Nature's Gift - Rank 1)
    [93072] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds', name = A.Passive_Natures_Gift }, -- Nature's Give (Nature's Gift - Rank 2)
    [93073] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_natures_gift.dds' }, -- Nature's Gift (Nature's Gift - Rank 2)
    [88492] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds', tooltip = A.Skill_Maturation }, -- Minor Toughness (Maturation - Rank 1)
    [88509] = { icon = 'esoui/art/icons/ability_buff_minor_toughness.dds', tooltip = A.Skill_Maturation }, -- Minor Toughness (Maturation - Rank 2)

    ----------------------------------------------------------------
    -- WARDEN ACTIVE ABILITIES ------------------------------------
    ----------------------------------------------------------------

    -- ANIMAL COMPANIONS

    -- Scorch / Subterranean Assault / Deep Fissure
    [86009] = { tooltip = T.Skill_Scorch }, -- Scorch (Scorch)
    [86019] = { tooltip = T.Skill_Subterranean_Assault }, -- Subterranean Assault (Subterranean Assault)
    [94444] = { tooltip = A.Skill_Subterranean_Assault }, -- Major Fracture (Subterranean Assault)
    [86015] = { tooltip = T.Skill_Deep_Fissure }, -- Deep Fissure (Deep Fissure)
    [94424] = { icon = 'esoui/art/icons/ability_warden_015_a.dds' }, -- Deep Fissure (Deep Fissure)
    [108951] = { tooltip = A.Skill_Deep_Fissure }, -- Major Breach (Deep Fissure)

    -- Swarm / Fetcher Infection / Growing Swarm
    [101703] = { tooltip = T.Generic_Magic_2_Sec }, -- Swarm (Swarm)
    [91416] = { forcedContainer = 'short', name = A.Skill_Fetcher_Infection, tooltip = T.Skill_Fetcher_Infection_Bonus }, -- Fetcher Infection Bonus Damage (Fetcher Infection)
    [101904] = { tooltip = T.Generic_Magic_2_Sec }, -- Fetcher Infection (Fetcher Infection)
    [101944] = { tooltip = T.Skill_Growing_Swarm }, -- Growing Swarm (Growing Swarm)
    [101948] = { tooltip = T.Generic_Magic_2_Sec }, -- Growing Swarm (Growing Swarm)

    -- Betty Netch / Blue Betty / Bull Netch
    [86050] = { tooltip = T.Skill_Betty_Netch }, -- Betty Netch (Betty Netch)
    [87929] = { consolidateExtra = true, tooltip = A.Skill_Betty_Netch }, -- Major Sorcery (Betty Netch)
    [114852] = { icon = 'esoui/art/icons/ability_warden_017_a.dds' }, -- Betty Netch (Betty Netch)
    [86054] = { tooltip = T.Skill_Blue_Betty }, -- Blue Betty (Blue Betty)
    [89107] = { consolidateExtra = true, tooltip = A.Skill_Blue_Betty }, -- Major Sorcery (Blue Betty)
    [114854] = { name = A.Skill_Blue_Betty, icon = 'esoui/art/icons/ability_warden_017.dds' }, -- Betty Netch (Blue Betty)
    [86058] = { tooltip = T.Skill_Bull_Netch }, -- Bull Netch (Bull Netch)
    [89110] = { consolidate = true, tooltip = A.Skill_Bull_Netch }, -- Major Brutality (Bull Netch)
    [95125] = { consolidate = true, tooltip = A.Skill_Bull_Netch }, -- Major Sorcery (Bull Netch)
    [89109] = { hide = true }, -- Bull Netch (Bull Netch)
    [114853] = { icon = 'esoui/art/icons/ability_warden_017_b.dds' }, -- Bull Netch (Bull Netch)

    -- Falcon's Swiftness / Deceptive Predator / Bird of Prey
    [86267] = { consolidate = true, tooltip = A.Skill_Falcons_Swiftness }, -- Major Expedition (Falcon's Swiftness)
    [86268] = { consolidate = true, tooltip = A.Skill_Falcons_Swiftness }, -- Major Endurance (Falcon's Swiftness)
    [89076] = { consolidate = true, tooltip = A.Skill_Deceptive_Predator }, -- Major Expedition (Deceptive Predator)
    [89077] = { consolidate = true, tooltip = A.Skill_Deceptive_Predator }, -- Major Endurance (Deceptive Predator)
    [114858] = { tooltip = A.Skill_Deceptive_Predator }, -- Minor Evasion (Deceptive Predator)
    [89078] = { consolidate = true, tooltip = A.Skill_Bird_of_Prey }, -- Major Expedition (Bird of Prey)
    [89079] = { consolidate = true, tooltip = A.Skill_Bird_of_Prey }, -- Major Endurance (Bird of Prey)
    [114862] = { tooltip = A.Skill_Bird_of_Prey }, -- Minor Berserk (Bird of Prey)

    -- Feral Guardian / Eternal Guardian / Wild Guardian
    [101438] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity, tooltip = T.Generic_CC_Immunity }, -- Bear Immunity (Feral Guardian - All Morphs)
    [85982] = { tooltip = T.Skill_Feral_Guardian }, -- Feral Guardian (Feral Guardian)
    [89135] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_swipe.dds', name = A.Skill_Bite }, -- Swipe (Feral Guardian)
    [89128] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }, -- Crushing Swipe (Feral Guardian)
    [89129] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds', tooltip = T.Generic_Knockdown }, -- Crushing Swipe (Feral Guardian)
    [90284] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Guardians_Wrath }, -- Guardian's Wrath (Feral Guardian)
    [93144] = { hide = true }, -- Guardian's Wrath Trigger (Feral Guardian)
    [85986] = { tooltip = T.Skill_Eternal_Guardian }, -- Eternal Guardian (Eternal Guardian)
    [109982] = { hide = true }, -- Eternal Guardian (Eternal Guardian)
    [105906] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_swipe.dds', name = A.Skill_Bite }, -- Swipe (Eternal Guardian)
    [105907] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }, -- Crushing Swipe (Eternal Guardian)
    [105908] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds', tooltip = T.Generic_Knockdown }, -- Crushing Swipe (Eternal Guardian)
    [94625] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Guardians_Wrath }, -- Guardian's Wrath (Eternal Guardian)
    [94626] = { hide = true }, -- Guardian's Wrath Trigger (Eternal Guardian)
    [109983] = { hide = true }, -- Eternal Guardian Revive (Eternal Guardian)
    [110384] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_eternal_guardian_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Eternal_Guardian, A.Set_Cooldown), tooltip = T.Skill_Eternal_Guardian_Cooldown, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Eternal Guardian (Eternal Guardian)
    [85990] = { tooltip = T.Skill_Wild_Guardian }, -- Wild Guardian (Wild Guardian)
    [89219] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_swipe.dds', name = A.Skill_Bite }, -- Swipe (Wild Guardian)
    [89220] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds' }, -- Crushing Swipe (Wild Guardian)
    [92666] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_crushing_swipe.dds', tooltip = T.Generic_Knockdown }, -- Crushing Swipe (Wild Guardian)
    [92163] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Guardians_Savagery }, -- Guardian's Savagery (Wild Guardian)
    [93233] = { hide = true }, -- Guardian's Savagery Trigger (Wild Guardian)

    -- GREEN BALANCE

    -- Fungal Growth / Enchanted Growth / Soothing Spores
    [86300] = { consolidate = true, tooltip = A.Skill_Enchanted_Growth }, -- Minor Intellect (Enchanted Growth)
    [87019] = { consolidate = true, tooltip = A.Skill_Enchanted_Growth }, -- Minor Endurance (Enchanted Growth)

    -- Healing Seed / Budding Seeds / Corrupting Pollen
    [108826] = { hide = true }, -- Synergy Damage Bonus (Healing Seed - Harvest Synergy)
    [85577] = { tooltip = T.Generic_HoT_1Sec }, -- Harvest (Healing Seed - Harvest Synergy)
    [85578] = { tooltip = T.Skill_Healing_Seed } , -- Healing Seed (Healing Seed)
    [85582] = { name = A.Skill_Healing_Seed }, -- Healing Seed Heal (Healing Seed)
    [85840] = { tooltip = T.Skill_Budding_Seeds } , -- Budding Seeds (Budding Seeds)
    [85841] = { name = A.Skill_Budding_Seeds }, -- Budding Seeds (Budding Seeds)
    [85925] = { name = A.Skill_Budding_Seeds }, -- Budding Seeds (Budding Seeds)
    [85845] = { tooltip = T.Skill_Corrupting_Pollen } , -- Corrupting Pollen (Corrupting Pollen)
    [85846] = { name = A.Skill_Corrupting_Pollen }, -- Corrupting Pollen Heal (Corrupting Pollen)
    [85944] = { tooltip = A.Skill_Corrupting_Pollen }, -- Major Defile (Corrupting Pollen)

    -- Living Vines / Leeching Vines / Living Trellis
    [85552] = { tooltip = T.Skill_Living_Vines }, -- Living Vines (Living Vines)
    [85559] = { name = A.Skill_Living_Vines }, -- Living Vines Heal (Living Vines)
    [85850] = { tooltip = T.Skill_Leeching_Vines }, -- Leeching Vines (Leeching Vines)
    [86307] = { tooltip = A.Skill_Leeching_Vines }, -- Minor Lifesteal (Leeching Vines)
    [85851] = { tooltip = T.Skill_Living_Trellis }, -- Living Trellis (Living Trellis)
    [88721] = { name = A.Skill_Living_Trellis }, -- Living Trellis Heal (Living Trellis)
    [88723] = { icon = 'esoui/art/icons/ability_warden_010_b.dds', name = A.Skill_Living_Trellis }, -- Living Trellis Heal Burst (Living Trellis)

    -- Lotus Flower / Green Lotus / Lotus Blossom
    [85539] = { tooltip = T.Skill_Lotus_Flower }, -- Lotus Flower (Lotus Flower)
    [85854] = { tooltip = T.Skill_Lotus_Flower }, -- Green Lotus (Green Lotus)
    [87061] = { consolidateExtra = true, tooltip = A.Skill_Green_Lotus }, -- Major Savagery (Green Lotus)
    [85855] = { tooltip = T.Skill_Lotus_Flower }, -- Lotus Blossom (Lotus Blossom)
    [86303] = { consolidateExtra = true, tooltip = A.Skill_Lotus_Blossom }, -- Major Prophecy (Lotus Blossom)
    [88695] = { name = A.Skill_Lotus_Blossom }, -- Lotus Blossom Heal (Lotus Blossom)
    [94590] = { icon = 'esoui/art/icons/ability_warden_009_b.dds', name = A.Skill_Lotus_Blossom }, -- Lotus Blossom Heal (Lotus Blossom)

    -- Nature's Grasp / Bursting Vines / Nature's Embrace
    [90266] = { tooltip = T.Skill_Natures_Grasp }, -- Nature's Grasp (Nature's Grasp)
    [108943] = { icon = 'esoui/art/icons/ability_warden_011.dds', name = A.Skill_Natures_Grasp }, -- Nature's Grasp Ultimate Restor (Nature's Grasp)
    [108947] = { icon = 'esoui/art/icons/ability_warden_011_a.dds', name = A.Skill_Bursting_Vines }, -- Bursting Vines Ultimate Rest (Bursting Vines)
    [88726] = { tooltip = T.Skill_Natures_Grasp }, -- Nature's Embrace (Nature's Embrace)
    [87074] = { tooltip = T.Skill_Natures_Grasp_Self }, -- Nature's Embrace (Nature's Embrace)
    [108945] = { icon = 'esoui/art/icons/ability_warden_011_b.dds', name = A.Skill_Natures_Embrace }, -- Nature's Embrace Ultimate Rest (Nature's Embrace)

    -- Secluded Grove / Enchanted Forest / Healing Thicket
    [85532] = { tooltip = T.Skill_Secluded_Grove }, -- Secluded Grove (Secluded Grove)
    [85533] = { name = A.Skill_Secluded_Grove }, -- Secluded Grove Instant Heal (Secluded Grove)
    [85534] = { name = A.Skill_Secluded_Grove, groundLabel = true, tooltip = T.Generic_AOE_Heal_1_Sec }, -- Secluded GroveTick Heal (Secluded Grove)

    [85804] = { tooltip = T.Skill_Secluded_Grove }, -- Enchanted Forest (Enchanted Forest)
    [88748] = { name = A.Skill_Enchanted_Forest }, -- Enchanted Forest Burst (Enchanted Forest)
    [86357] = { icon = 'esoui/art/icons/ability_warden_012_a.dds', name = A.Skill_Enchanted_Forest }, -- Enchanted Forest Ultimate Rest (Enchanted Forest)
    [88747] = { groundLabel = true, tooltip = T.Generic_AOE_Heal_1_Sec }, -- Enchanted Forest (Enchanted Forest)

    [85807] = { tooltip = T.Skill_Healing_Thicket }, -- Healing Thicket (Healing Thicket)
    [88750] = { name = A.Skill_Healing_Thicket }, -- Healing Thicket Instant Heal (Healing Thicket)
    [91819] = { tooltip = T.Generic_HoT_1Sec }, -- Healing Thicket (Healing Thicket)

    -- WINTER'S EMBRACE

    -- Frost cloak / Expansive Frost Cloak / Ice Fortress
    [86224] = { consolidate = true, tooltip = A.Skill_Frost_Cloak }, -- Major Resolve (Frost Cloak)
    [86225] = { consolidate = true, tooltip = A.Skill_Frost_Cloak  }, -- Major Ward (Frost Cloak)
    [88758] = { consolidate = true, tooltip = A.Skill_Expansive_Frost_Cloak }, -- Major Resolve (Expansive Frost Cloak)
    [88759] = { consolidate = true, tooltip = A.Skill_Expansive_Frost_Cloak }, -- Major Ward (Expansive Frost Cloak)
    [88761] = { consolidate = true, tooltip = A.Skill_Ice_Fortress }, -- Major Resolve (Ice Fortress)
    [88762] = { consolidate = true, tooltip = A.Skill_Ice_Fortress }, -- Major Ward (Ice Fortress)
    [87194] = { consolidate = true, tooltip = A.Skill_Ice_Fortress }, -- Minor Protection (Ice Fortress)

    -- Impaling Shards / Gripping Shards / Winter's Revenge
    [86161] = { tooltip = T.Skill_Impaling_Shards }, -- Impaling Shards (Impaling Shards)
    [86238] = { tooltip = T.Skill_Impaling_Shards_Ground, duration = 0, groundLabel = true, hideGround = true }, -- Impaling Shards (Impaling Shards)
    [86165] = { tooltip = T.Skill_Impaling_Shards }, -- Gripping Shards (Gripping Shards)
    [87443] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_root_frost.dds', name = A.Skill_Frozen, tooltip = T.Generic_Immobilize }, -- Gripping Shards (Gripping Shards)
    [87448] = { tooltip = T.Skill_Impaling_Shards_Ground, duration = 0, groundLabel = true, hideGround = true }, -- Gripping Shards (Gripping Shards)
    [86169] = { tooltip = T.Skill_Impaling_Shards }, -- Winter's Revenge (Winter's Revenge)
    [88801] = { tooltip = T.Skill_Impaling_Shards_Ground, duration = 0, groundLabel = true, hideGround = true }, -- Winter's Revenge (Winter's Revenge)

    [88783] = { groundLabel = true, tooltip = T.Skill_Impaling_Shards_Ground }, -- Impaling Shards (Impaling Shards)
    [88791] = { groundLabel = true, tooltip = T.Skill_Impaling_Shards_Ground }, -- Gripping Shards (Gripping Shards)
    [88802] = { groundLabel = true, tooltip = T.Skill_Impaling_Shards_Ground }, -- Winter's Revenge (Winter's Revenge)

    -- Arctic Wind / Polar Wind / Arctic Blast
    [90833] = { tooltip = T.Skill_Arctic_Wind }, -- Arctic Wind (Arctic Wind)
    [90835] = { tooltip = T.Skill_Arctic_Wind }, -- Polar Wind (Polar Wind)
    [86156] = { hide = true }, -- Artic Blast (Arctic Blast)
    [90834] = { tooltip = T.Skill_Arctic_Wind }, -- Arctic Blast (Arctic Blast)
    [114875] = { name = A.Skill_Arctic_Blast, tooltip = T.Generic_Stun }, -- Artic Blast Stun (Artic Blast)

    -- Crystallized Shield / Crystallized Slab / Shimmering Shield
    [86135] = { tooltip = T.Skill_Crystallized_Shield }, -- Crystallized Shield (Crystallized Shield)
    [92068] = { icon = 'esoui/art/icons/ability_warden_002.dds', name = A.Skill_Crystallized_Shield }, -- Crystalized Shield (Crystallized Shield)
    [87224] = { icon = 'esoui/art/icons/ability_warden_002.dds', name = A.Skill_Crystallized_Shield }, -- Combat Restore Crystalized Shi (Crystallized Shield)
    [86139] = { tooltip = T.Skill_Crystallized_Slab }, -- Crystallized Slab (Crystallized Slab)
    [92168] = { icon = 'esoui/art/icons/ability_warden_002_a.dds', name = A.Skill_Crystallized_Slab }, -- Crystalized Slab (Crystallized Slab)
    [88766] = { icon = 'esoui/art/icons/ability_warden_002_a.dds', name = A.Skill_Crystallized_Slab }, -- Crystalized Slab Restore (Crystallized Slab)
    [93175] = { hide = true }, -- Crystallized Slab (Crystallized Slab)
    [86143] = { tooltip = T.Skill_Shimmering_Shield }, -- Shimmering Shield (Shimmering Shield)
    [92170] = { icon = 'esoui/art/icons/ability_warden_002_b.dds' }, -- Shimmering Shield (Shimmering Shield)
    [88771] = { icon = 'esoui/art/icons/ability_warden_002_b.dds', name = A.Skill_Shimmering_Shield }, -- Shimmering Shield Restore (Shimmering Shield)
    [87234] = { tooltip = A.Skill_Shimmering_Shield }, -- Major Heroism (Shimmering Shield)

    -- Frozen Gate / Frozen Device / Frozen Retreat
    [86175] = { tooltip = T.Skill_Frozen_Gate }, -- Frozen Gate (Frozen Gate)
    [87560] = { name = A.Skill_Frozen_Gate, tooltip = T.Generic_Immobilize }, -- Frozen Gate Root (Frozen Gate)
    [86179] = { tooltip = T.Skill_Frozen_Device }, -- Frozen Device (Frozen Device)
    [92039] = { name = A.Skill_Frozen_Device, tooltip = T.Generic_Immobilize }, -- Frozen Gate Root (Frozen Device)
    [92041] = { tooltip = A.Skill_Frozen_Device }, -- Minor Maim (Frozen Device)
    [86183] = { tooltip = T.Skill_Frozen_Retreat }, -- Frozen Retreat (Frozen Retreat)
    [92060] = { name = A.Skill_Frozen_Retreat, tooltip = T.Generic_Immobilize }, -- Frozen Retreat Root (Frozen Retreat)
    [103321] = { tooltip = A.Skill_Icy_Escape }, -- Major Expedition (Frozen Retreat - Icy Escape Synergy)

    -- Sleet Storm / Northern Storm / Permafrost
    [86109] = { tooltip = T.Skill_Sleet_Storm }, -- Sleet Storm (Sleet Storm)
    [86249] = { forcedContainer = 'short', groundLabel = true, tooltip = A.Skill_Sleet_Storm }, -- Major Protection (Sleet Storm)
    [86250] = { duration = 0, groundLabel = true, tooltip = T.Skill_Sleet_Storm_Ground, hideGround = true }, -- Sleet Storm (Sleet Storm)
    [86113] = { tooltip = T.Skill_Sleet_Storm }, -- Northern Storm (Northern Storm)
    [88859] = { forcedContainer = 'short', groundLabel = true, tooltip = A.Skill_Northern_Storm }, -- Major Protection (Northern Storm)
    [88858] = { duration = 0, groundLabel = true, tooltip = T.Skill_Sleet_Storm_Ground, hideGround = true }, -- Northern Storm (Northern Storm)
    [86117] = { tooltip = T.Skill_Permafrost }, -- Permafrost (Permafrost)
    [88862] = { duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = A.Skill_Permafrost }, -- Major Protection (Permafrost)
    [88861] = { duration = 0, groundLabel = true, tooltip = T.Skill_Permafrost_Ground, hideGround = true }, -- Permafrost (Permafrost)
    [90943] = { icon = 'esoui/art/icons/ability_warden_006_b.dds', tooltip = T.Generic_Stun }, -- Permafrost (Permafrost)

    [86247] = { groundLabel = true, tooltip = T.Skill_Sleet_Storm_Ground }, -- Sleet Storm (Sleet Storm)
    [88860] = { groundLabel = true, tooltip = T.Skill_Sleet_Storm_Ground }, -- Northern Storm (Northern Storm)
    [88863] = { groundLabel = true, tooltip = T.Skill_Permafrost_Ground }, -- Permafrost (Permafrost)

    ----------------------------------------------------------------
    -- PLAYER WEAPON ATTACKS ---------------------------------------
    ----------------------------------------------------------------

    [23604] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attacklight.dds' }, -- Light Attack
    [18430] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [18431] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackheavy.dds' }, -- Heavy Attack
    [60772] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Unarmed)
    [16037] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Light Attack
    [17162] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [17163] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack
    [60757] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (2H)
    [15435] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Light Attack
    [15282] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [15829] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack
    [60759] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Shield)
    [16499] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Light Attack
    [17170] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [17169] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy_dw.dds', name = A.Skill_Heavy_Attack_Main_Hand }, -- Heavy Attack
    [18622] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy_dw.dds', name = A.Skill_Heavy_Attack_Off_Hand }, -- Heavy Attack (Dual Wield)
    [60758] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackrestore_dw.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Dual Wield)
    [16688] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds' }, -- Light Attack
    [17174] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [17173] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attackheavy.dds' }, -- Heavy Attack
    [60761] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Bow)
    [16277] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attacklight.dds' }, -- Light Attack
    [18405] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [18406] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_frost_attackheavy.dds' }, -- Heavy Attack
    [60762] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Frost)
    [16165] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attacklight.dds' }, -- Light Attack
    [15385] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [16321] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_flame_attackheavy.dds' }, -- Heavy Attack
    [60763] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Fire)
    [18350] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attacklight.dds' }, -- Light Attack
    [18396] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds', name = A.Skill_Heavy_Attack, tooltip = T.Skill_Heavy_Attack_Lightning }, -- Heavy Attack (Shock)
    [19277] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavypulse.dds', name = A.Skill_Heavy_Attack, hide = true }, -- Shock Pulse
    [60764] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Shock)
    [16145] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attacklight.dds' }, -- Light Attack
    [16212] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_attackheavy.dds', tooltip = T.Generic_Magic }, -- Heavy Attack
    [32760] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Restoration)

    ----------------------------------------------------------------
    -- PLAYER PASSIVES WEAPONS -------------------------------------
    ----------------------------------------------------------------

    -- Two Handed
    [30821] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_forceful.dds' }, -- Forceful (Rank 1)
    [45445] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_forceful.dds' }, -- Forceful (Rank 2)
    [29375] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_heavy_weapons.dds' }, -- Heavy Weapons (Rank 1)
    [29383] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = A.Passive_Heavy_Weapons, tooltip = T.Generic_Bleed_2_Sec }, -- Heavy Weapons Bleed (Rank 1)
    [45430] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_heavy_weapons.dds' }, -- Heavy Weapons (Rank 2)
    [45431] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = A.Passive_Heavy_Weapons, tooltip = T.Generic_Bleed_2_Sec }, -- Heavy Weapons Bleed (Rank 2)
    [29388] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_balanced_blade.dds' }, -- Balanced Blade (Rank 1)
    [45443] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_balanced_blade.dds' }, -- Balanced Blade (Rank 2)
    [29389] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_follow_up.dds' }, -- Follow Up (Follow Up - Rank 1)
    [60860] = { icon = 'esoui/art/icons/ability_warrior_018.dds', tooltip = T.Skill_Follow_Up_Rank_1 }, -- Bonus Damage (Follow Up - Rank 1)
    [45446] = { icon = 'LuiExtended/media/icons/abilities/passive_2handed_follow_up.dds' }, -- Follow Up (Follow Up - Rank 2)
    [60888] = { icon = 'esoui/art/icons/ability_warrior_018.dds', name = A.Passive_Follow_Up, tooltip = T.Skill_Follow_Up_Rank_2 }, -- Bonus Damage (Follow Up - Rank 2)
    [29392] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_battle_rush.dds', tooltip = T.Skill_Battle_Rush_Rank_1 }, -- Battle Rush (Battle Rush - Rank 1)
    [45450] = { icon = 'LuiExtended/media/icons/abilities/ability_2handed_battle_rush.dds', tooltip = T.Skill_Battle_Rush_Rank_2 }, -- Battle Rush (Battle Rush - Rank 2)

    -- One Hand and Shield
    [29420] = { icon = 'esoui/art/icons/ability_weapon_029.dds' }, -- Fortress (Fortress - Rank 1)
    [45471] = { icon = 'esoui/art/icons/ability_weapon_029.dds' }, -- Fortress (Fortress - Rank 2)
    [29397] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_sword_and_board.dds' }, -- Sword and Board (Sword and Board - Rank 1)
    [45452] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_sword_and_board.dds' }, -- Sword and Board (Sword and Board - Rank 2)
    [29415] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_deadly_bash.dds' }, -- Deadly Bash (Deadly Bash - Rank 1)
    [45469] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_deadly_bash.dds' }, -- Deadly Bash (Deadly Bash - Rank 2)
    [29399] = { icon = 'esoui/art/icons/ability_weapon_003.dds' }, -- Deflect Bolts (Deflect Bolts - Rank 1)
    [45472] = { icon = 'esoui/art/icons/ability_weapon_003.dds' }, -- Deflect Bolts (Deflect Bolts - Rank 2)
    [29422] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_battlefield_mobility.dds' }, -- Battlefield Mobility (Battlefield Mobility - Rank 1)
    [45473] = { icon = 'LuiExtended/media/icons/abilities/passive_1handed_battlefield_mobility.dds' }, -- Battlefield Mobility (Battlefield Mobility - Rank 2)

    -- Dual Wield
    [30872] = { icon = 'esoui/art/icons/ability_weapon_020.dds' }, -- Controlled Fury (Controlled Fury - Rank 1)
    [45478] = { icon = 'esoui/art/icons/ability_weapon_020.dds' }, -- Controlled Fury (Controlled Fury - Rank 2)
    [21114] = { icon = 'esoui/art/icons/ability_weapon_012.dds' }, -- Ruffian (Ruffian - Rank 1)
    [45481] = { icon = 'esoui/art/icons/ability_weapon_012.dds' }, -- Ruffian (Ruffian - Rank 2)
    [30894] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = A.Passive_Twin_Blade_and_Blunt, tooltip = T.Generic_Bleed_2_Sec }, -- Twin Blade and Blunt Bleed (Rank 1)
    [45483] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleed.dds', name = A.Passive_Twin_Blade_and_Blunt, tooltip = T.Generic_Bleed_2_Sec }, -- Twin Blade and Blunt Bleed (Rank 2)

    -- Bow
    [30930] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_accuracy.dds' }, -- Accuracy (Accuracy - Rank 1)
    [45492] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_accuracy.dds' }, -- Accuracy (Accuracy - Rank 2)
    [30942] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_ranger.dds' }, -- Ranger (Ranger) - Rank 1)
    [45493] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_ranger.dds' }, -- Ranger (Ranger) - Rank 2)
    [30936] = { icon = 'esoui/art/icons/ability_weapon_024.dds' }, -- Hawk Eye (Hawk Eye - Rank 1)
    [78854] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_hawk_eye.dds', tooltip = T.Skill_Hawk_Eye_Rank_1 }, -- Hawk Eye (Hawk Eye - Rank 1)
    [45497] = { icon = 'esoui/art/icons/ability_weapon_024.dds' }, -- Hawk Eye (Hawk Eye - Rank 2)
    [78855] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_hawk_eye.dds', tooltip = T.Skill_Hawk_Eye_Rank_2 }, -- Hawk Eye (Hawk Eye - Rank 2)
    [30923] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_hasty_retreat.dds' }, -- Hasty Retreat (Hasty Retreat - Rank 1)
    [98489] = { tooltip = A.Skill_Hasty_Retreat }, -- Major Expedition (Hasty Retreat - Rank 1)
    [45498] = { icon = 'LuiExtended/media/icons/abilities/passive_bow_hasty_retreat.dds' }, -- Hasty Retreat (Hasty Retreat - Rank 2)
    [98490] = { tooltip = A.Skill_Hasty_Retreat }, -- Major Expedition (Hasty Retreat - Rank 2)

    -- Destruction Staff
    [30948] = { icon = 'LuiExtended/media/icons/abilities/passive_destructionstaff_tri_focus.dds' }, -- Tri Focus (Tri Focus - Rank 1)
    [69774] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_tri_focus.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Tri Focus (Tri Focus - Rank 1)
    [45500] = { icon = 'LuiExtended/media/icons/abilities/passive_destructionstaff_tri_focus.dds' }, -- Tri Focus (Tri Focus - Rank 2)
    [69773] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_tri_focus.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Tri Focus (Tri Focus - Rank 2)
    [30951] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds' }, -- Shock (Tri Focus - Rank 1)
    [45505] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_lightning_attackheavy.dds' }, -- Shock (Tri Focus - Rank 2)
    [30959] = { icon = 'esoui/art/icons/ability_weapon_007.dds' }, -- Ancient Knowledge (Ancient Knowledge - Rank 1)
    [45513] = { icon = 'esoui/art/icons/ability_weapon_007.dds' }, -- Ancient Knowledge (Ancient Knowledge - Rank 2)
    [30966] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_destruction_expert.dds' }, -- Magicka Restore (Destruction Expert - Rank 1)
    [45515] = { icon = 'LuiExtended/media/icons/abilities/ability_destructionstaff_destruction_expert.dds', name = A.Passive_Destruction_Expert }, -- Magicka Restore (Destruction Expert - Rank 2)

    -- Restoration Staff
    [30973] = { icon = 'esoui/art/icons/ability_weapon_002.dds' }, -- Essence Drain (Essence Drain -  Rank 1)
    [77918] = { tooltip = A.Skill_Essence_Drain }, -- Major Mending (Essence Drain -  Rank 1)
    [30978] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_essence_drain.dds' }, -- Essence Drain (Essence Drain -  Rank 1)
    [45517] = { icon = 'esoui/art/icons/ability_weapon_002.dds' }, -- Essence Drain (Essence Drain -  Rank 2)
    [77922] = { tooltip = A.Skill_Essence_Drain }, -- Major Mending (Essence Drain -  Rank 2)
    [45518] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_essence_drain.dds' }, -- Essence Drain (Essence Drain -  Rank 2)
    [30971] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_absorb.dds' }, -- Absorb (Absorb - Rank 1)
    [45522] = { icon = 'LuiExtended/media/icons/abilities/ability_restorationstaff_absorb.dds' }, -- Absorb (Absorb - Rank 2)
    [30981] = { icon = 'LuiExtended/media/icons/abilities/passive_restorationstaff_restoration_master.dds' }, -- Restoration Master
    [45524] = { icon = 'LuiExtended/media/icons/abilities/passive_restorationstaff_restoration_master.dds' }, -- Restoration Master

    -----------------------------------------
    -- TWO HANDED ACTIVES -------------------
    -----------------------------------------

    -- Uppercut / Dizzying Swing / Wrecking Blow
    [38816] = { tooltip = T.Generic_Knockback }, -- Dizzying Swing (Dizzying Swing)
    [38818] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds' }, -- Dizzying Swing (Dizzying Swing)

    -- Critical Charge / Stampede / Critical Rush
    [38791] = { tooltip = T.Generic_Snare_60 }, -- Stampede (Stampede)

    -- Cleave / Carve / Brawler
    [31059] = { icon = 'esoui/art/icons/ability_2handed_002.dds', name = A.Skill_Cleave, tooltip = T.Generic_Bleed_2_Sec }, -- Cleave Bleed (Cleave)
    [38747] = { icon = 'esoui/art/icons/ability_2handed_002_a.dds', name = A.Skill_Carve, tooltip = T.Generic_Bleed_2_Sec }, -- Carve Bleed (Carve)
    [38746] = { tooltip = A.Skill_Carve }, -- Minor Heroism (Carve)
    [38759] = { icon = 'esoui/art/icons/ability_2handed_002_b.dds', name = A.Skill_Brawler, tooltip = T.Generic_Bleed_2_Sec }, -- Brawler Bleed (Brawler)
    [38763] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Brawler (Brawler)

    -- Reverse Slash / Reverse Slice / Executioner
    [38827] = { icon = 'esoui/art/icons/ability_2handed_004_b.dds' }, -- Reverse Slice (Reverse Slice)

    -- Momentum / Forward Momentum / Rally
    [28297] = { tooltip = T.Generic_HoT_2Sec }, -- Momentum (Momentum)
    [61670] = { consolidateExtra = true, tooltip = A.Skill_Momentum }, -- Major Brutality (Momentum)
    [28299] = { icon = 'esoui/art/icons/ability_2handed_005.dds' }, -- Momentum (Momentum)
    [38794] = { tooltip = T.Generic_HoT_2Sec }, -- Forward Momentum (Forward Momentum)
    [62387] = { consolidateExtra = true, tooltip = A.Skill_Forward_Momentum }, -- Major Brutality (Forward Momentum)
    [38797] = { tooltip = T.Innate_Immobilize_Immunity }, -- Forward Momentum (Forward Momentum)
    [62385] = { icon = 'esoui/art/icons/ability_2handed_005_a.dds', name = A.Skill_Forward_Momentum }, -- Momentum (Forward Momentum)
    [38802] = { tooltip = T.Skill_Rally }, -- Rally (Rally)
    [62415] = { consolidateExtra = true, tooltip = A.Skill_Rally }, -- Major Brutality (Rally)
    [38805] = { icon = 'esoui/art/icons/ability_2handed_005_b.dds' }, -- Rally (Rally)

    -- Berserker Strike / Onslaught / Berserker Rage
    [83217] = { tooltip = T.Skill_Berserker_Strike }, -- Berserker Strike (Berserker Strike)
    [83230] = { tooltip = T.Skill_Onslaught }, -- Onslaught (Onslaught)
    [83346] = { icon = 'esoui/art/icons/ability_2handed_006_a.dds' }, -- Onslaught (Onslaught)
    [83239] = { tooltip = T.Skill_Berserker_Rage }, -- Berserker Rage (Berserker Rage)

    -----------------------------------------
    -- ONE HAND AND SHIELD ACTIVES ----------
    -----------------------------------------

    -- Puncture / Ransack / Pierce Armor
    [28307] = { tooltip = A.Skill_Puncture }, -- Major Fracture (Puncture)
    [62474] = { tooltip = A.Skill_Ransack }, -- Major Fracture (Ransack)
    [62475] = { tooltip = A.Skill_Ransack }, -- Major Breach (Ransack)
    [62484] = { tooltip = A.Skill_Pierce_Armor }, -- Major Fracture (Pierce Armor)
    [62485] = { tooltip = A.Skill_Pierce_Armor }, -- Major Breach (Pierce Armor)

    -- Low Slash / Deep Slash / Heroic Slash
    [29308] = { tooltip = A.Skill_Low_Slash }, -- Minor Maim (Low Slash)
    [28305] = { name = A.Skill_Low_Slash, tooltip = T.Generic_Snare_60 }, -- Low Slash Snare (Low Slash)
    [62495] = { tooltip = A.Skill_Deep_Slash }, -- Minor Maim (Deep Slash)
    [38271] = { tooltip = T.Generic_Snare_60 }, -- Deep Slash (Deep Slash)
    [62504] = { tooltip = A.Skill_Heroic_Slash }, -- Minor Maim (Heroic Slash)
    [38266] = { name = A.Skill_Heroic_Slash, tooltip = T.Generic_Snare_60 }, -- Heroic Slash Snare (Heroic Slash)
    [62505] = { tooltip = A.Skill_Heroic_Slash }, -- Minor Heroism (Heroic Slash)

    -- Defensive Posture / Defensive Stance / Absorb Magic
    [28727] = { tooltip = T.Skill_Defensive_Posture }, -- Defensive Posture (Defensive Posture)
    [38312] = { tooltip = T.Skill_Defensive_Stance }, -- Defensive Stance (Defensive Stance)
    [38315] = { tooltip = T.Generic_Stun }, -- Defensive Stance (Defensive Stance)
    [38317] = { tooltip = T.Skill_Absorb_Magic }, -- Absorb Magic (Absorb Magic)
    [38398] = { icon = 'esoui/art/icons/ability_1handed_004_b.dds' }, -- Absorb Magic (Absorb Magic)

    -- Shield Charge / Shielded Assault / Invasion
    [28720] = { tooltip = T.Generic_Knockdown }, -- Shield Charge (Shield Charge)
    [38404] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Shielded Assault (Shielded Assault)
    [38403] = { tooltip = T.Generic_Knockdown }, -- Shielded Assault (Shielded Assault)
    [38407] = { name = A.Skill_Invasion, tooltip = T.Generic_Knockdown }, -- Invasion (Invasion)

    -- Power Bash / Reverberating Bash / Power Slam
    [83433] = { tooltip = T.Generic_Stun }, -- Power Bash (Power Bash)
    [83446] = { tooltip = T.Generic_Stun }, -- Reverberating Bash (Reverberating Bash)
    [38838] = { tooltip = A.Skill_Reverberating_Bash }, -- Major Defile (Reverberating Bash)
    [80625] = { tooltip = T.Skill_Power_Slam }, -- Power Slam (Power Slam)

    -- Shield Wall / Spell Wall / Shield Discipline
    [83272] = { tooltip = T.Skill_Shield_Wall }, -- Shield Wall (Shield Wall)
    [83292] = { tooltip = T.Skill_Spell_Wall }, -- Spell Wall (Spell Wall)
    [83310] = { tooltip = T.Skill_Shield_Discipline }, -- Shield Discipline (Shield Discipline)

    -----------------------------------------
    -- DUAL WIELD ACTIVES -------------------
    -----------------------------------------

    -- Twin Slashes / Rending Slashes / Blood Craze
    [29293] = { icon = 'esoui/art/icons/ability_dualwield_001.dds', name = A.Skill_Twin_Slashes, tooltip = T.Generic_Bleed_2_Sec }, -- Twin Slashes Bleed (Twin Slashes)
    [38841] = { icon = 'esoui/art/icons/ability_dualwield_001_a.dds', name = A.Skill_Rending_Slashes, tooltip = T.Skill_Rending_Slashes }, -- Rending Slashes Bleed (Rending Slashes)
    [38848] = { icon = 'esoui/art/icons/ability_dualwield_001_a.dds', name = A.Skill_Blood_Craze, tooltip = T.Skill_Blood_Craze }, -- Blood Craze Bleed (Blood Craze)
    [38852] = { tooltip = T.Skill_Blood_Craze_Heal }, -- Blood Craze (Blood Craze)

    -- Whirlwind / Whirling Blades / Steel Tornado
    [68801] = { tooltip = A.Skill_Whirling_Blades }, -- Major Endurance (Whirling Blades)

    -- Blade Cloak / Quick Cloak / Deadly Cloak
    [28613] = { tooltip = T.Skill_Blade_Cloak }, -- Blade Cloak (Blade Cloak)
    [999001] = { name = A.Skill_Major_Evasion, icon = 'esoui/art/icons/ability_buff_major_evasion.dds', tooltip = A.Skill_Blade_Cloak }, -- Major Evasion fake aura for Blade Cloak
    [38901] = { tooltip = T.Skill_Blade_Cloak }, -- Quick Cloak (Quick Cloak)
    [999002] = { name = A.Skill_Major_Evasion, icon = 'esoui/art/icons/ability_buff_major_evasion.dds', tooltip = A.Skill_Quick_Cloak }, -- Major Evasion fake aura for Quick Cloak
    [62531] = { tooltip = A.Skill_Quick_Cloak }, -- Major Expedition (Quick Cloak)
    [62529] = { name = A.Skill_Quick_Cloak }, -- Blade Cloak (Quick Cloak)
    [38906] = { tooltip = T.Skill_Blade_Cloak }, -- Deadly Cloak (Deadly Cloak)
    [999003] = { name = A.Skill_Major_Evasion, icon = 'esoui/art/icons/ability_buff_major_evasion.dds', tooltip = A.Skill_Deadly_Cloak }, -- Major Evasion fake aura for Deadly Cloak
    [62547] = { name = A.Skill_Deadly_Cloak }, -- Blade Cloak (Deadly Cloak)

    -- Hidden Blade / Shrouded Daggers / Flying Blade
    [68807] = { consolidateExtra = true, tooltip = A.Skill_Hidden_Blade }, -- Major Brutality (Hidden Blade)
    [28378] = { tooltip = T.Generic_Snare_40 }, -- Hidden Blade (Hidden Blade)
    [68859] = { consolidateExtra = true, tooltip = A.Skill_Shrouded_Daggers }, -- Major Brutality (Shrouded Daggers)
    [68861] = { tooltip = T.Generic_Snare_40 }, -- Shrouded Daggers (Shrouded Daggers)
    [68814] = { consolidateExtra = true, tooltip = A.Skill_Flying_Blade }, -- Major Brutality (Flying Blade)
    [38912] = { tooltip = T.Generic_Snare_40 }, -- Flying Blade (Flying Blade)

    -- Lacerate / Rend / Thrive in Chaos
    [85156] = { tooltip = T.Skill_Lacerate }, -- Lacerate (Lacerate)
    [85192] = { tooltip = T.Skill_Lacerate }, -- Rend (Rend)
    [85182] = { tooltip = T.Skill_Lacerate }, -- Thrive in Chaos (Thrive in Chaos)
    [85184] = { tooltip = T.Skill_Thrive_in_Chaos }, -- Thrive in Chaos (Thrive in Chaos)

    -----------------------------------------
    -- BOW ACTIVES --------------------------
    -----------------------------------------

    -- Snipe / Lethal Arrow / Focused Aim
    [38686] = { tooltip = A.Skill_Lethal_Arrow }, -- Major Defile (Lethal Arrow)
    [38698] = { hide = true }, -- Focused Aim (Focused Aim)
    [38699] = { tooltip = T.Skill_Focused_Aim }, -- Focused Aim (Focused Aim)
    [38688] = { consolidateExtra = true, tooltip = A.Skill_Focused_Aim }, -- Minor Fracture (Focused Aim)

    -- Volley / Endless Hail / Arrow Barrage
    [28876] = { tooltip = T.Skill_Volley }, -- Volley (Volley)
    [28877] = { groundLabel = true, tooltip = T.Generic_AOE_Physical_0_5_Sec }, -- Volley (Volley)
    [38689] = { tooltip = T.Skill_Endless_Hail }, -- Endless Hail (Endless Hail)
    [38690] = { groundLabel = true, tooltip = T.Generic_AOE_Physical_0_5_Sec }, -- Endless Hail (Endless Hail)
    [38695] = { tooltip = T.Skill_Volley }, -- Arrow Barrage (Arrow Barrage)
    [38696] = { groundLabel = true, tooltip = T.Generic_AOE_Physical_0_5_Sec }, -- Arrow Barrage (Arrow Barrage)

    -- Scatter Shot / Magnum Shot / Draining Shot
    [28888] = { icon = 'esoui/art/icons/ability_bow_004.dds' }, -- Scatter Shot (Scatter Shot)
    [28887] = { tooltip = T.Generic_Stun }, -- Scatter Shot (Scatter Shot)
    [38676] = { icon = 'esoui/art/icons/ability_bow_004_b.dds', name = A.Skill_Magnum_Shot }, -- Scatter Shot (Magnum Shot)
    [38675] = { icon = 'esoui/art/icons/ability_bow_004_b.dds', name = A.Skill_Magnum_Shot }, -- Scatter Shot (Magnum Shot)
    [38674] = { name = A.Skill_Magnum_Shot, tooltip = T.Generic_Stun }, -- Scatter Shot (Magnum Shot)
    [38671] = { icon = 'esoui/art/icons/ability_bow_004_a.dds' }, -- Draining Shot (Draining Shot)
    [38670] = { tooltip = T.Skill_Draining_Shot }, -- Draining Shot (Draining Shot)
    [80764] = { name = A.Skill_Draining_Shot }, -- Draining Shot Heal (Draining Shot)

    -- Arrow Spray / Bombarb / Acid Spray
    [31272] = { icon = 'esoui/art/icons/ability_bow_005.dds', tooltip = T.Generic_Snare_40 }, -- Arrow Spray (Arrow Spray)
    [38707] = { tooltip = T.Skill_Bombard }, -- Bombard (Bombard)
    [38706] = { icon = 'esoui/art/icons/ability_bow_005_a.dds', tooltip = T.Generic_Snare_40 }, -- Bombard (Bombard)
    [38702] = { hideReduce = true, tooltip = T.Skill_Acid_Spray, icon = 'esoui/art/icons/ability_bow_005_b.dds'  }, -- Acid Spray (Acid Spray)
    [38703] = { tooltip = T.Skill_Acid_Spray }, -- Acid Spray (Acid Spray)

    -- Poison Arrow / Venom Arrow / Poison Injection
    [44540] = { tooltip = T.Generic_Poison_2_Sec }, -- Poison Arrow (Venom Arrow)
    [44545] = { tooltip = T.Generic_Poison_2_Sec }, -- Venom Arrow (Venom Arrow)
    [38648] = { icon = '' }, -- Poison Arrow (Venom Arrow)
    [38649] = { icon = 'esoui/art/icons/ability_bow_002_a.dds', name = A.Skill_Venom_Arrow, tooltip = T.Generic_Stagger }, -- Poison Arrow (Venom Arrow)
    [38650] = { name = A.Skill_Venom_Arrow, tooltip = T.Generic_Stun }, -- Poison Arrow (Venom Arrow)
    [44549] = { tooltip = T.Skill_Poison_Injection }, -- Poison Injection (Poison Injection)

    -- Rapid Fire / Toxic Barrage / Ballista
    [85261] = { tooltip = T.Generic_Poison_2_Sec }, -- Toxic Barrage (Toxic Barrage)
    [85458] = { tooltip = T.Skill_Ballista }, -- Ballista (Ballista)

    -----------------------------------------
    -- DESTRUCTION STAFF ACTIVES ------------
    -----------------------------------------

    -- Force Shock / Crushing Shock / Force Pulse
    [48010] = { icon = '' }, -- Force Shock (Destruction) (Crushing Shock)
    [48009] = { icon = 'esoui/art/icons/ability_destructionstaff_001a.dds', name = A.Skill_Crushing_Shock, tooltip = T.Generic_Stagger }, -- Stagger (Crushing Shock)
    [48011] = { name = A.Skill_Crushing_Shock, tooltip = T.Generic_Stun }, -- Uber Attack (Crushing Shock)
    [48016] = { icon = 'esoui/art/icons/ability_destructionstaff_001b.dds' }, -- Force Pulse (Force Pulse)
    [48022] = { icon = 'esoui/art/icons/ability_destructionstaff_001b.dds' }, -- Force Pulse (Force Pulse)

    -- Wall of Elements / Unstable Wall of Elements / Elemental Blockade
    [68719] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_root_frost.dds', tooltip = T.Generic_Immobilize }, -- Frozen (Wall of Elements) -- Frost
    [28807] = { tooltip = T.Skill_Wall_of_Elements_Fire }, -- Wall of Fire (Wall of Fire)
    [28854] = { tooltip = T.Skill_Wall_of_Elements_Shock }, -- Wall of Storms (Wall of Storms)
    [62968] = { tooltip = A.Skill_Wall_of_Storms }, -- Off Balance (Wall of Storms)
    [28849] = { tooltip = T.Skill_Wall_of_Elements_Frost }, -- Wall of Frost (Wall of Frost)
    [62928] = { duration = 0, groundLabel = true, tooltip = T.Skill_Wall_of_Elements_Ground_Frost, hideGround = true }, -- Wall of Frost (Wall of Elements) -- Frost
    [39053] = { tooltip = T.Skill_U_Wall_of_Elements_Fire }, -- Unstable Wall of Fire (Unstable Wall of Fire)
    [39073] = { tooltip = T.Skill_U_Wall_of_Elements_Shock }, -- Unstable Wall of Storms (Unstable Wall of Storms)
    [39077] = { tooltip = A.Skill_Unstable_Wall_of_Storms }, -- Off Balance (Unstable Wall of Storms)
    [39067] = { tooltip = T.Skill_U_Wall_of_Elements_Frost }, -- Unstable Wall of Frost (Unstable Wall of Frost)
    [39068] = { duration = 0, groundLabel = true, tooltip = T.Skill_U_Wall_of_Elements_Ground_Frost, hideGround = true }, -- Unstable Wall of Frost (Unstable Wall of Elements) -- Frost
    [39012] = { tooltip = T.Skill_Wall_of_Elements_Fire }, -- Blockade of Fire (Blockade of Fire)
    [39018] = { tooltip = T.Skill_Wall_of_Elements_Shock }, -- Blockade of Storms (Blockade of Storms)
    [62988] = { tooltip = A.Skill_Blockade_of_Storms }, -- Off Balance (Blockade of Storms)
    [39028] = { tooltip = T.Skill_Wall_of_Elements_Frost }, -- Blockade of Frost (Blockade of Frost)
    [62948] = { duration = 0, groundLabel = true, tooltip = T.Skill_Wall_of_Elements_Ground_Frost, hideGround = true }, -- Blockade of Frost (Elemental Blockade) -- Frost

    [62896] = { groundLabel = true, tooltip = T.Skill_Wall_of_Elements_Ground_Fire }, -- Wall of Fire
    [62971] = { groundLabel = true, tooltip = T.Skill_Wall_of_Elements_Ground_Shock }, -- Wall of Storms
    [62931] = { groundLabel = true, tooltip = T.Skill_Wall_of_Elements_Ground_Frost }, -- Wall of Frost
    [39054] = { groundLabel = true, tooltip = T.Skill_U_Wall_of_Elements_Ground_Fire }, -- Unstable Wall of Fire
    [39079] = { groundLabel = true, tooltip = T.Skill_U_Wall_of_Elements_Ground_Shock }, -- Unstable Wall of Storms
    [39071] = { groundLabel = true, tooltip = T.Skill_U_Wall_of_Elements_Ground_Frost }, -- Unstable Wall of Frost
    [62912] = { groundLabel = true, tooltip = T.Skill_Wall_of_Elements_Ground_Fire }, -- Blockade of Fire
    [62990] = { groundLabel = true, tooltip = T.Skill_Wall_of_Elements_Ground_Shock }, -- Blockade of Storms
    [62951] = { groundLabel = true, tooltip = T.Skill_Wall_of_Elements_Ground_Frost }, -- Blockade of Frost

    -- Destructive Touch / Destructive Clench / Destructive Reach
    [62648] = { name = A.Skill_Flame_Touch, tooltip = T.Skill_Flame_Touch }, -- Fire Touch (Destructive Touch) -- Fire
    [38172] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = A.Skill_Flame_Touch, tooltip = T.Skill_Flame_Touch_Alt, hideReduce = true }, -- Stun After Knockback Movement (Destructive Touch) -- Fire
    [29075] = { icon = 'esoui/art/icons/ability_destructionstaff_007.dds', name = A.Skill_Flame_Touch }, -- Fire Touch (destruction) (Destructive Touch) -- Fire
    [62722] = { tooltip = T.Skill_Shock_Touch }, -- Shock Touch (Destructive Touch)
    [68536] = { tooltip = T.Skill_Shock_Touch_Alt, hideReduce = true }, -- Shock Touch (Destructive Touch)
    [62692] = { tooltip = T.Skill_Frost_Touch }, -- Frost Touch (Destructive Touch)
    [30450] = { icon = 'esoui/art/icons/ability_destructionstaff_005.dds', name = A.Skill_Frost_Touch, tooltip = T.Skill_Frost_Touch_Alt, hideReduce = true }, -- Frost Touch (Destructive Touch) -- Frost
    [62668] = { name = A.Skill_Flame_Clench, tooltip = T.Skill_Flame_Touch }, -- Fire Clench (Destructive Clench) -- Fire
    [38987] = { icon = 'esoui/art/icons/ability_destructionstaff_007_a.dds', name = A.Skill_Flame_Clench, tooltip = T.Skill_Flame_Touch_Alt, hideReduce = true }, -- Stun After Knockback Movement (Destructive Clench) -- Fire
    [38986] = { icon = 'esoui/art/icons/ability_destructionstaff_007_a.dds', name = A.Skill_Flame_Clench }, -- Fire Touch (destruction) (Destructive Clench) -- Fire
    [62733] = { tooltip = T.Skill_Shock_Touch }, -- Shock Clench (Destructive Clench) -- Shock
    [68635] = { name = A.Skill_Shock_Clench, tooltip = T.Skill_Shock_Touch_Alt, hideReduce = true }, -- Shock Touch (Destructive Clench) -- Shock
    [62734] = { name = A.Skill_Shock_Clench, hide = true }, -- Shock Clench Explosion (Destructive Clench) -- Shock
    [62702] = { tooltip = T.Skill_Frost_Clench }, -- Frost Clench (Destructive Clench)
    [38990] = { icon = 'esoui/art/icons/ability_destructionstaff_005_a.dds', name = A.Skill_Frost_Clench, tooltip = T.Skill_Frost_Clench_Alt, hideReduce = true }, -- Deep Freeze (Destructive Clench) -- Frost
    [62682] = { tooltip = T.Skill_Flame_Touch }, -- Flame Reach (Destructive Reach)
    [38946] = { icon = 'esoui/art/icons/ability_destructionstaff_007_b.dds', name = A.Skill_Flame_Reach, tooltip = T.Skill_Flame_Touch_Alt, hideReduce = true }, -- Stun After Knockback Movement (Destructive Reach) -- Fire
    [38945] = { icon = 'esoui/art/icons/ability_destructionstaff_007_b.dds', name = A.Skill_Flame_Reach }, -- Flame Reach (destruction) (Destructive Reach) -- Fire
    [62745] = { tooltip = T.Skill_Shock_Touch }, -- Shock Reach (Destructive Reach) -- Shock
    [68574] = { name = A.Skill_Shock_Reach, tooltip = T.Skill_Shock_Touch_Alt, hideReduce = true }, -- Shock Touch (Destructive Reach) -- Shock
    [62712] = { tooltip = T.Skill_Frost_Touch_Alt }, -- Frost Reach (Destructive Reach)
    [38971] = { icon = 'esoui/art/icons/ability_destructionstaff_005_b.dds', name = A.Skill_Frost_Reach, tooltip = T.Skill_Frost_Touch_Alt, hideReduce = true }, -- Frost Grip (Destructive Reach) -- Frost

    -- Weakness to Elements / Elemental Susceptibility / Elemental Drain
    [53881] = { consolidate = true, tooltip = A.Skill_Weakness_to_Elements }, -- Major Breach (Weakness to Elements)
    [62775] = { consolidate = true, tooltip = A.Skill_Elemental_Susceptibility }, -- Major Breach (Elemental Susceptibility)
    [39100] = { consolidate = true, tooltip = A.Skill_Elemental_Drain }, -- Minor Magickasteal (Elemental Drain)
    [62787] = { consolidate = true, tooltip = A.Skill_Elemental_Drain }, -- Minor Magickasteal (Elemental Drain)
    [39099] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds' }, -- Minor Magickasteal (Elemental Drain)

    -- Impulse / Elemental Ring / Pulsar
    [39168] = { tooltip = A.Skill_Flame_Pulsar }, -- Minor Mangle (Flame Pulsar)
    [39181] = { tooltip = A.Skill_Storm_Pulsar }, -- Minor Mangle (Storm Pulsar)
    [39180] = { tooltip = A.Skill_Frost_Pulsar }, -- Minor Mangle (Frost Pulsar)

    -- Elemental Storm / Elemental Rage / Eye of the Storm
    [83625] = { tooltip = T.Skill_Fire_Storm }, -- Fire Storm (Elemental Storm)
    [83630] = { tooltip = T.Skill_Thunder_Storm }, -- Thunder Storm (Elemental Storm)
    [83628] = { tooltip = T.Skill_Ice_Storm }, -- Ice Storm (Elemental Storm)
    [85126] = { tooltip = T.Skill_Fiery_Rage }, -- Fiery Rage (Elemental Rage)
    [85130] = { tooltip = T.Skill_Thunder_Storm }, -- Thunderous Rage (Elemental Rage)
    [85128] = { tooltip = T.Skill_Icy_Rage }, -- Icy Rage (Elemental Rage)
    [104825] = { tooltip = T.Generic_Immobilize }, -- Icy Rage (Elemental Rage)
    [83682] = { tooltip = T.Skill_Eye_of_Flame }, -- Eye of Flame (Eye of the Storm)
    [83686] = { tooltip = T.Skill_Eye_of_Lightning }, -- Eye of Lightning (Eye of the Storm)
    [83684] = { tooltip = T.Skill_Eye_of_Frost }, -- Eye of Frost (Eye of the Storm)

    [83626] = { groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, --Fire Storm
    [83631] = { groundLabel = true, tooltip = T.Generic_AOE_Shock_1_Sec }, --Thunder Storm
    [83629] = { groundLabel = true, tooltip = T.Generic_AOE_Frost_1_Sec }, --Ice Storm

    [85127] = { groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, --Fiery Rage
    [85131] = { groundLabel = true, tooltip = T.Generic_AOE_Shock_1_Sec }, --Thunderous Rage
    [85129] = { groundLabel = true, tooltip = T.Generic_AOE_Frost_1_Sec }, --Icy Rage

    [83683] = { groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, --Eye of Flame
    [83687] = { groundLabel = true, tooltip = T.Generic_AOE_Shock_1_Sec }, --Eye of Lightning
    [83685] = { groundLabel = true, tooltip = T.Generic_AOE_Frost_1_Sec }, --Eye of Frost

    -----------------------------------------
    -- RESTORATION STAFF ACTIVES ------------
    -----------------------------------------

    -- Grand Healing / Illustrious Healing / Healing Springs
    [28385] = { tooltip = T.Skill_Secluded_Grove }, -- Grand Healing (Grand Healing)
    [28386] = { icon = 'esoui/art/icons/ability_restorationstaff_004.dds', tooltip = T.Generic_AOE_Heal_1_Sec, groundLabel = true }, -- Grand Healing (Grand Healing)
    [40058] = { tooltip = T.Skill_Secluded_Grove }, -- Illustrious Healing (Illustrious Healing)
    [40059] = { icon = 'esoui/art/icons/ability_restorationstaff_004b.dds', tooltip = T.Generic_AOE_Heal_1_Sec, groundLabel = true }, -- Illustrious Healing (Illustrious Healing)
    [40060] = { tooltip = T.Skill_Secluded_Grove }, -- Healing Springs (Healing Springs)
    [40061] = { icon = 'esoui/art/icons/ability_restorationstaff_004a.dds', tooltip = T.Generic_AOE_Heal_1_Sec, groundLabel = true }, -- Healing Springs (Healing Springs)
    [40062] = { icon = 'esoui/art/icons/ability_restorationstaff_004a.dds' }, -- Healing Springs (Healing Springs)

    -- Regeneration / Rapid Regeneration / Mutagen
    [28536] = { tooltip = T.Generic_HoT_2Sec }, -- Regeneration (Regeneration)
    [40076] = { tooltip = T.Generic_HoT_1_5_Sec }, -- Rapid Regeneration (Rapid Regeneration)
    [40079] = { tooltip = T.Skill_Mutagen }, -- Mutagen (Mutagen)

    -- Blessing of Protection / Blessing of Restoration / Combat Prayer
    [37243] = { hide = true }, -- Blessing of Protection (Blessing of Protection)
    [37247] = { consolidate = true, tooltip = A.Skill_Blessing_of_Protection }, -- Minor Resolve (Blessing of Protection)
    [62619] = { consolidate = true, tooltip = A.Skill_Blessing_of_Protection }, -- Minor Ward (Blessing of Protection)
    [40103] = { hide = true, name = A.Skill_Blessing_of_Restoration }, -- Blessing of Restoration (Blessing of Restoration)
    [62626] = { consolidate = true, tooltip = A.Skill_Blessing_of_Restoration }, -- Minor Resolve (Blessing of Restoration)
    [62627] = { consolidate = true, tooltip = A.Skill_Blessing_of_Restoration }, -- Minor Ward (Blessing of Restoration)
    [40094] = { hide = true }, -- Combat Prayer (Combat Prayer)
    [62634] = { consolidate = true, tooltip = A.Skill_Combat_Prayer }, -- Minor Resolve (Combat Prayer)
    [62635] = { consolidate = true, tooltip = A.Skill_Combat_Prayer }, -- Minor Ward (Combat Prayer)
    [62636] = { consolidate = true, tooltip = A.Skill_Combat_Prayer }, -- Minor Berserk (Combat Prayer)

    -- Steadfast Ward / Ward Ally / Healing Ward
    [37232] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Steadfast Ward (Steadfast Ward)
    [40130] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Ward Ally (Ward Ally)
    [40132] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Ward Ally (Ward Ally)
    [40126] = { tooltip = T.Skill_Healing_Ward }, -- Healing Ward (Healing Ward)
    [40128] = { hide = true }, -- Healing Ward (Healing Ward)

    -- Force Siphon / Siphon Spirit / Quick Siphon
    [88565] = { consolidate = true, tooltip = A.Skill_Force_Siphon }, -- Minor Lifesteal (Force Siphon)
    [33541] = { icon = 'esoui/art/icons/ability_buff_minor_lifesteal.dds' }, -- Minor Lifesteal (Force Siphon)
    [88575] = { consolidate = true, tooltip = A.Skill_Siphon_Spirit }, -- Minor Lifesteal (Siphon Spirit)
    [88576] = { consolidate = true, tooltip = A.Skill_Siphon_Spirit }, -- Minor Magickasteal (Siphon Spirit)
    [40110] = { icon = 'esoui/art/icons/ability_buff_minor_lifesteal.dds' }, -- Minor Lifesteal (Siphon Spirit)
    [40114] = { icon = 'esoui/art/icons/ability_buff_minor_magickasteal.dds' }, -- Minor Lifesteal (Siphon Spirit)
    [88606] = { consolidate = true, tooltip = A.Skill_Quick_Siphon }, -- Minor Lifesteal (Quick Siphon)
    [40117] = { icon = 'esoui/art/icons/ability_buff_minor_lifesteal.dds' }, -- Minor Lifesteal (Quick Siphon)

    -- Panacea / Life Giver / Light's Champion
    [83552] = { tooltip = T.Generic_HoT_1Sec }, -- Panacea (Panacea)
    [83850] = { tooltip = T.Generic_HoT_1Sec }, -- Life Giver (Life Giver)
    [85132] = { tooltip = T.Skill_Lights_Champion }, -- Light's Champion (Light's Champion)
    [85154] = { tooltip = A.Skill_Lights_Champion }, -- Major Force (Light's Champion)
    [85155] = { tooltip = A.Skill_Lights_Champion }, -- Major Protection (Light's Champion)

    ----------------------------------------------------------------
    -- ARMOR PASSIVES ----------------------------------------------
    ----------------------------------------------------------------

    -- Light Armor
    [29668] = { icon = 'esoui/art/icons/passive_armor_001.dds' }, -- Prodigy (Prodigy - Rank 1)
    [45561] = { icon = 'esoui/art/icons/passive_armor_001.dds' }, -- Prodigy (Prodigy - Rank 2)

    -- Heavy Armor
    [29825] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }, -- Resolve (Resolve - Rank 1)
    [45531] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }, -- Resolve (Resolve - Rank 2)
    [45533] = { icon = 'LuiExtended/media/icons/abilities/passive_armor_resolve.dds' }, -- Resolve (Resolve - Rank 3)
    [29769] = { icon = 'esoui/art/icons/ability_armor_013.dds' }, -- Constitution (Constitution - Rank 1)
    [58428] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 1)
    [58503] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 1)
    [45526] = { icon = 'esoui/art/icons/ability_armor_013.dds' }, -- Constitution (Constitution - Rank 2)
    [58430] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 2)
    [58431] = { icon = 'LuiExtended/media/icons/abilities/ability_armor_constitution.dds' }, -- Constitution (Constitution - Rank 2)
    [29773] = { icon = 'esoui/art/icons/passive_armor_014.dds' }, -- Revitalize (Revitalize - Rank 1)
    [45528] = { icon = 'esoui/art/icons/passive_armor_014.dds' }, -- Revitalize (Revitalize - Rank 2)

    ----------------------------------------------------------------
    -- ARMOR ACTIVES -----------------------------------------------
    ----------------------------------------------------------------

    -- LIGHT ARMOR
    [29338] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Annulment (Annulment)
    [39186] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Dampen Magic (Dampen Magic)
    [39188] = { hide = true }, -- Dampen Magic (Dampen Magic)
    [39182] = { tooltip = T.Skill_Harness_Magicka }, -- Harness Magicka (Harness Magicka)

    -- MEDIUM ARMOR
    [63015] = { consolidateExtra = true, tooltip = A.Skill_Evasion }, -- Major Evasion (Evasion)
    [63019] = { consolidateExtra = true, tooltip = A.Skill_Shuffle }, -- Major Evasion (Shuffle)
    [39196] = { noDuplicate = true, tooltip = T.Innate_Immobilize_Immunity }, -- Shuffle (Shuffle)
    [63030] = { consolidateExtra = true, tooltip = A.Skill_Elude }, -- Major Evasion (Elude)

    -- HEAVY ARMOR
    [29553] = { tooltip = T.Generic_CC_Immunity }, -- Immovable (Immovable)
    [63084] = { consolidate = true, tooltip = A.Skill_Immovable }, -- Major Resolve (Immovable)
    [63085] = { consolidate = true, tooltip = A.Skill_Immovable }, -- Major Ward (Immovable)
    [63133] = { tooltip = T.Generic_CC_Immunity }, -- Immovable Brute (Immovable Brute)
    [63134] = { consolidate = true, tooltip = A.Skill_Immovable_Brute }, -- Major Resolve (Immovable Brute)
    [63135] = { consolidate = true, tooltip = A.Skill_Immovable_Brute }, -- Major Ward (Immovable Brute)
    [63118] = { tooltip = T.Generic_CC_Immunity }, -- Unstoppable (Unstoppable)
    [63119] = { consolidate = true, tooltip = A.Skill_Unstoppable }, -- Major Resolve (Unstoppable)
    [63120] = { consolidate = true, tooltip = A.Skill_Unstoppable }, -- Major Ward (Unstoppable)

    ----------------------------------------------------------------
    -- SOUL MAGIC PASSIVES -----------------------------------------
    ----------------------------------------------------------------

    [39266] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 1)
    [39267] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 1)
    [39268] = { hide = true }, -- Soul Shatter (Soul Shatter - Rank 1)
    [45583] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 2)
    [45584] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_shatter.dds' }, -- Soul Shatter (Soul Shatter - Rank 2)
    [45585] = { hide = true }, -- Soul Shatter (Soul Shatter - Rank 2)
    [39269] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_summons.dds' }, -- Soul Summons
    [45590] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_summons.dds' }, -- Soul Summons
    [43752] = { icon = 'LuiExtended/media/icons/abilities/ability_otherclass_soul_summons_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Passive_Soul_Summons, A.Set_Cooldown), tooltip = T.Skill_Soul_Summons }, -- Soul Summons
    [39263] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_lock.dds' }, -- Soul Lock
    [39264] = { hide = true }, -- Soul Trap (Soul Lock - Rank 1)
    [45580] = { icon = 'LuiExtended/media/icons/abilities/passive_otherclass_soul_lock.dds' }, -- Soul Lock
    [45582] = { hide = true }, -- Soul Trap (Soul Lock - Rank 2)

    ----------------------------------------------------------------
    -- SOUL MAGIC ACTIVES ------------------------------------------
    ----------------------------------------------------------------

    [26768] = { tooltip = T.Skill_Soul_Trap }, -- Soul Trap (Soul Trap)
    [26769] = { hide = true}, -- Soul Trap (Soul Trap)
    [40328] = { tooltip = T.Skill_Soul_Trap }, -- Soul Splitting Trap (Soul Splitting Trap)
    [40329] = { hide = true}, -- Soul Splitting Trap (Soul Splitting Trap)
    [40317] = { tooltip = T.Skill_Consuming_Trap }, -- Consuming Trap (Consuming Trap)
    [40319] = { hide = true}, -- Consuming Trap (Consuming Trap)
    [40323] = { icon = 'esoui/art/icons/ability_otherclass_001_b.dds' }, -- Consuming Trap (Consuming Trap)
    [40321] = { icon = 'esoui/art/icons/ability_otherclass_001_b.dds' }, -- Consuming Trap (Consuming Trap)
    [40326] = { icon = 'esoui/art/icons/ability_otherclass_001_b.dds' }, -- Consuming Trap (Consuming Trap)

    ----------------------------------------------------------------
    -- VAMPIRE PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    [39472] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_noxiphilic_sanguivoria.dds', name = A.Passive_Noxiphilic_Sanguivoria, tooltip = T.Skill_Noxiphilic_Sanguivoria }, -- Vampirism (Blood Ritual)
    [40360] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_noxiphilic_sanguivoria.dds', name = A.Passive_Noxiphilic_Sanguivoria, tooltip = T.Skill_Noxiphilic_Sanguivoria }, -- Vampirism (Blood Ritual)
    [35771] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_1.dds', stack = 1, tooltip = T.Skill_Vampirism_Stage_1 }, -- Stage 1 Vampirism (Vampire General)
    [35776] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_2.dds', stack = 2, tooltip = T.Skill_Vampirism_Stage_2 }, -- Stage 2 Vampirism (Vampire General)
    [35783] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_3.dds', stack = 3, tooltip = T.Skill_Vampirism_Stage_3 }, -- Stage 3 Vampirism (Vampire General)
    [35792] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_4.dds', stack = 4, tooltip = T.Skill_Vampirism_Stage_4 }, -- Stage 4 Vampirism (Vampire General)
    [33152] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', tooltip = T.Skill_Feed }, -- Feed
    [33177] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds' }, -- Feed
    [33175] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', unbreakable = 1 }, -- Feed (Vampire - Feed)
    [33182] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', name = A.Passive_Savage_Feeding, tooltip = T.Generic_Stun }, -- Uber Attack (Savage Feeding - Rank 1)
    [33183] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = A.Skill_Off_Balance, tooltip = A.Passive_Savage_Feeding }, -- Off-Balance Self (Savage Feeding - Rank 1)
    [46047] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_savage_feeding.dds', name = A.Passive_Savage_Feeding, tooltip = T.Generic_Stun }, -- Uber Attack (Savage Feeding - Rank 2)
    [46046] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = A.Skill_Off_Balance, tooltip = A.Passive_Savage_Feeding }, -- Off-Balance Self (Savage Feeding - Rank 2)
    [40349] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, duration = .95, tooltip = T.Generic_Stun }, -- Feed (Blood Ritual - Rank 1)
    [40351] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds' }, -- Feed (Blood Ritual - Rank 1)
    [40350] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', unbreakable = 1 }, -- Feed (Blood Ritual - Rank 1)
    [40353] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', name = A.Skill_Feed, tooltip = T.Generic_Stun }, -- Uber Attack (Blood Ritual - Rank 1)
    [40359] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_blood_ritual_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Passive_Blood_Ritual, A.Set_Cooldown), tooltip = T.Skill_Blood_Ritual }, -- Fed on ally (Blood Ritual)

    ----------------------------------------------------------------
    -- VAMPIRE ACTIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Drain Essence / Invigorating Drain / Accelerating Drain
    [32893] = { tooltip = T.Skill_Drain_Essence }, -- Drain Essence
    [68883] = { tooltip = T.Generic_Stun }, -- Drain Essence
    [38949] = { tooltip = T.Skill_Invigorating_Drain }, -- Invigorating Drain
    [68892] = { tooltip = T.Generic_Stun }, -- Invigorating Drain
    [38956] = { tooltip = T.Skill_Drain_Essence }, -- Accelerating Drain
    [81493] = { tooltip = T.Generic_Stun }, -- Accelerating Drain
    [63558] = { tooltip = A.Skill_Accelerating_Drain }, -- Minor Expedition (Accelerating Drain)

    -- Mist Form / Elusive Mist / Baleful Mist
    [32986] = { tooltip = T.Skill_Mist_Form }, -- Mist Form
    [38963] = { tooltip = T.Skill_Mist_Form }, -- Elusive Mist
    [38967] = { tooltip = A.Skill_Elusive_Mist }, -- Major Expedition (Elusive Mist)
    [38965] = { tooltip = T.Skill_Baleful_Mist }, -- Baleful Mist

    -- Bat Swarm / Clouding Swarm / Devouring Swarm
    [32624] = { tooltip = T.Skill_Bat_Swarm }, -- Bat Swarm
    [38932] = { tooltip = T.Skill_Bat_Swarm }, -- Clouding Swarm
    [38931] = { tooltip = T.Skill_Devouring_Swarm }, -- Devouring Swarm

    [32625] = { groundLabel = true, tooltip = T.Generic_AOE_Magic_1_Sec }, -- Bat Swarm
    [38935] = { groundLabel = true, tooltip = T.Generic_AOE_Magic_1_Sec }, -- Clouding Swarm
    [38934] = { groundLabel = true, tooltip = T.Skill_Devouring_Swarm_Ground }, -- Devouring Swarm

    ----------------------------------------------------------------
    -- VAMPIRE QUEST ---------------------------------------------
    ----------------------------------------------------------------

    [42821] = { hide = true }, -- VampInt_LamaeFirstFeed
    [44676] = { hide = true }, -- SELF SNARE
    [39507] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_profane_symbol.dds', name = A.Skill_Profane_Symbol }, -- VampInitStun_Profane
    [44222] = { hide = true }, -- VampireInitiation_Lamae
    [39728] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', name = A.Skill_Feed }, -- VampInit_TheaterFeed
    [39509] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_vampirism_stage_4.dds', name = A.Skill_Vampirism }, -- VampInit_PC Becomes a Vampire
    [39422] = { hide = true }, -- Mist Form
    [56684] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike
    [39692] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', type = BUFF_EFFECT_TYPE_DEBUFF, duration = -5.2, tooltip = T.Skill_Feed }, -- Feed
    [39698] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds' }, -- Feed
    [39693] = { hide = true }, -- Feed

    ----------------------------------------------------------------
    -- WEREWOLF PASSIVES -------------------------------------------
    ----------------------------------------------------------------

    [35658] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_lycanthrophy.dds', tooltip = T.Skill_Lycanthrophy }, -- Lycanthrophy
    [31068] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_sanies_lupinus.dds', tooltip = T.Skill_Sanies_Lupinus }, -- Sanies Lupinus (from NPC Bite)
    [40521] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_sanies_lupinus.dds', tooltip = T.Skill_Sanies_Lupinus }, -- Sanies Lupinus (from Player Bite)
    [32464] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attacklight.dds' }, -- Light Attack
    [89146] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackbleed.dds', tooltip = T.Generic_Bleed_2_Sec }, -- Werewolf Bleed
    [32477] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Were)
    [32479] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [32480] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack Werewolf
    [32494] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Heavy Attack
    [60773] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackrestore.dds', name = A.Skill_Heavy_Attack }, -- Stamina Return
    [33208] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', hide = true }, -- Devour (Devour)
    [33209] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }, -- Devour (Devour)
    [40515] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }, -- Devour (Blood Moon)
    [40520] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', name = A.Skill_Devour, unbreakable = 1, tooltip = T.Generic_Stun }, -- Q3047 - Knockdown (Blood Moon)
    [40525] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_bloodmoon_icd.dds', name = zo_strformat("<<1>> <<2>>", A.Passive_Bloodmoon, A.Set_Cooldown), tooltip = T.Skill_Blood_Moon }, -- Bit an Ally (Blood Moon)

    ----------------------------------------------------------------
    -- WEREWOLF ACTIVES --------------------------------------------
    ----------------------------------------------------------------

    -- Hircine's Bounty / Hircine's Rage / Hircine's Fortitude
    [58318] = { tooltip = A.Skill_Hircines_Rage, name = A.Skill_Major_Brutality }, -- Hircine's Rage (Hircine's Rage)

    -- Roar / Ferocious Roar / Defeaning Roar
    [32633] = { tooltip = T.Generic_Fear }, -- Roar (Roar)
    [39113] = { tooltip = T.Generic_Fear }, -- Ferocious Roar (Ferocious Roar)
    [45834] = { tooltip = A.Skill_Ferocious_Roar }, -- Off Balance (Ferocious Roar)
    [39114] = { tooltip = T.Generic_Fear }, -- Deafening Roar (Deafening Roar)
    [111788] = { tooltip = A.Skill_Deafening_Roar }, -- Major Fracture (Deafening Roar)

    -- Piercing Howl / Howl of Despair / Howl of Agony
    [58775] = { tooltip = T.Skill_Feeding_Frenzy }, -- Feeding Frenzy (Howl of Despair - Feeding Frenzy Synergy)

    -- Infectious Claws / Claws of Anguish / Claws of Life
    [58856] = { name = A.Skill_Infectious_Claws, tooltip = T.Generic_Disease_2_Sec }, -- Infection (Infectious Claws)
    [58865] = { name = A.Skill_Claws_of_Anguish, tooltip = T.Generic_Disease_2_Sec }, -- Infection (Claws of Anguish)
    [58869] = { tooltip = A.Skill_Claws_of_Anguish }, -- Major Defile (Claws of Anguish)
    [58880] = { name = A.Skill_Claws_of_Life, tooltip = T.Skill_Claws_of_Life }, -- Infection (Claws of Life)

    -- Werewolf Transformation / Pack Leader / Werewolf Berserker
    [39477] = { hide = true }, -- De-Werewolf (Werewolf Transformation - All Morphs)
    [32455] = { tooltip = T.Skill_Werewolf_Transformation }, -- Werewolf Transformation (Werewolf Transformation)
    [111832] = { tooltip = T.Generic_Fear }, -- Werewolf Transformation
    [39075] = { tooltip = T.Skill_Pack_Leader }, -- Pack Leader (Pack Leader)
    [111843] = { tooltip = T.Generic_Fear }, -- Pack Leader
    [80180] = { hide = true }, -- Birth Direwolf (Pack Leader)
    [80177] = { hide = true }, -- Pack Leader (Pack Leader)
    [80178] = { hide = true }, -- Pack Leader (Pack Leader)
    [80184] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge_pack_leader.dds' }, -- Lunge (Pack Leader)
    [80189] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }, -- Gnash (Pack Leader)
    [80190] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }, -- Gnash (Pack Leader)
    [39076] = { tooltip = T.Skill_Werewolf_Transformation }, -- Werewolf Berserker (Werewolf Berserker)
    [111844] = { icon = 'esoui/art/icons/ability_werewolf_001_b.dds', tooltip = T.Generic_Fear }, -- Werewolf Berserker
    [89147] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackbleed.dds', name = A.Skill_Werewolf_Bleed, tooltip = T.Generic_Bleed_2_Sec }, -- Werewolf Berserker Bleed (Werewolf Bleed)

    ----------------------------------------------------------------
    -- WEREWOLF QUEST ABILITIES ------------------------------------
    ----------------------------------------------------------------

    [55885] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attacklight.dds' }, -- Light Attack
    [55886] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack (Were)
    [55888] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackmedium.dds', name = A.Skill_Medium_Attack }, -- Heavy Attack
    [55891] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', name = A.Skill_Heavy_Attack }, -- Heavy Attack Werewolf
    [55890] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Heavy Attack
    [40124] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', hide = true }, -- Devour
    [40125] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds' }, -- Devour

    ----------------------------------------------------------------
    -- DARK BROTHERHOOD PASSIVES -----------------------------------
    ----------------------------------------------------------------

    [76325] = { icon = 'LuiExtended/media/icons/abilities/ability_darkbrotherhood_blade_of_woe.dds' }, -- Blade of Woe
    [79623] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds', tooltip = A.Skill_Padomaic_Sprint }, -- Major Expedition (Padomaic Sprint - Rank 1) (Blade of Woe Kill)
    [79624] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds', tooltip = A.Skill_Padomaic_Sprint }, -- Major Expedition (Padomaic Sprint - Rank 2) (Blade of Woe Kill)
    [79625] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds', tooltip = A.Skill_Padomaic_Sprint }, -- Major Expedition (Padomaic Sprint - Rank 3) (Blade of Woe Kill)
    [79877] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds', tooltip = A.Skill_Padomaic_Sprint }, -- Major Expedition (Padomaic Sprint - Rank 4) (Blade of Woe Kill)
    [80392] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds', tooltip = A.Skill_Padomaic_Sprint }, -- Major Expedition (Padomaic Sprint - Rank 1) (Normal Kill)
    [80394] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds', tooltip = A.Skill_Padomaic_Sprint }, -- Major Expedition (Padomaic Sprint - Rank 2) (Normal Kill)
    [80396] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds', tooltip = A.Skill_Padomaic_Sprint }, -- Major Expedition (Padomaic Sprint - Rank 3) (Normal Kill)
    [80398] = { icon = 'esoui/art/icons/ability_buff_major_expedition.dds', tooltip = A.Skill_Padomaic_Sprint }, -- Major Expedition (Padomaic Sprint - Rank 4) (Normal Kill)


    ----------------------------------------------------------------
    -- FIGHTERS GUILD PASSIVES -------------------------------------
    ----------------------------------------------------------------

    [29062] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_intimidating_presence.dds' },
    [35803] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' },
    [45595] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' },
    [45596] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_slayer.dds' },
    [35800] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 1)
    [35801] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 1)
    [45597] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 2)
    [45598] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 2)
    [45599] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 3)
    [45600] = { icon = 'LuiExtended/media/icons/abilities/ability_fightersguild_banish_the_wicked.dds' }, -- Banish the Wicked (Banish the Wicked - Rank 3)
    [40393] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_skilled_tracker.dds' },
    [35804] = { icon = 'LuiExtended/media/icons/abilities/passive_fightersguild_bounty_hunter.dds' },

    ----------------------------------------------------------------
    -- FIGHTERS GUILD ACTIVE ABILITIES -----------------------------
    ----------------------------------------------------------------

    -- Silver Bolts / Silver Shards / Silver Leash
    [35736] = { icon = 'esoui/art/icons/ability_fightersguild_003.dds', tooltip = T.Generic_Snare_40 }, -- Silver Bolts (Silver Bolts - Rank 1)
    [40302] = { icon = 'esoui/art/icons/ability_fightersguild_003_a.dds', tooltip = T.Generic_Snare_40 }, -- Silver Shards (Silver Shards - Rank 1)
    [40340] = { icon = 'esoui/art/icons/ability_fightersguild_003_b.dds', tooltip = T.Generic_Snare_40 }, -- Silver Leash (Silver Leash - Rank 1)
    [109354] = { icon = 'esoui/art/icons/ability_fightersguild_003_b.dds' }, -- Silver Leash (Silver Leash - Rank 1)

    -- Circle of Protection / Turn Undead / Ring of Preservation
    [35737] = { tooltip = T.Skill_Circle_of_Protection }, -- Circle of Protection
    [80271] = { forcedContainer = 'short', consolidate = true, groundLabel = true, tooltip = A.Skill_Circle_of_Protection }, -- Minor Endurance (Circle of Protection)
    [35739] = { forcedContainer = 'short', consolidate = true, groundLabel = true, tooltip = A.Skill_Circle_of_Protection }, -- Minor Protection (Circle of Protection)
    [40181] = { tooltip = T.Skill_Circle_of_Protection }, -- Turn Undead
    [80276] = { forcedContainer = 'short', consolidate = true, groundLabel = true, tooltip = A.Skill_Turn_Undead }, -- Minor Endurance (Turn Undead)
    [40185] = { forcedContainer = 'short', consolidate = true, groundLabel = true, tooltip = A.Skill_Turn_Undead }, -- Minor Protection (Turn Undead)
    [40187] = { tooltip = T.Generic_Fear }, -- Turn Undead (Turn Undead)
    [40169] = { tooltip = T.Skill_Ring_of_Preservation }, -- Ring of Preservation
    [80284] = { forcedContainer = 'short', consolidate = true, groundLabel = true, tooltip = A.Skill_Ring_of_Preservation }, -- Minor Endurance (Ring of Preservation)
    [40171] = { forcedContainer = 'short', consolidate = true, groundLabel = true, tooltip = A.Skill_Ring_of_Preservation }, -- Minor Protection (Ring of Preservation)
    [80293] = { tooltip = T.Skill_Ring_of_Preservation_Ground, groundLabel = true, icon = 'esoui/art/icons/ability_fightersguild_001_b.dds' }, -- Ring of Preservation (Ring of Preservation)

    -- Expert Hunter / Evil Hunter / Camouflaged Hunter
    [64509] = { consolidateExtra = true, tooltip = A.Skill_Expert_Hunter }, -- Major Savagery
    [999004] = { name = A.Skill_Expert_Hunter, icon = 'esoui/art/icons/ability_fightersguild_002.dds', tooltip = T.Skill_Expert_Hunter_Passive }, -- Major Savagery fake aura for Expert Hunter
    [35762] = { tooltip = T.Skill_Expert_Hunter }, -- Expert Hunter (Expert Hunter)
    [80307] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed, tooltip = A.Skill_Expert_Hunter }, -- Expert Hunter (Expert Hunter)
    [40194] = { tooltip = T.Skill_Evil_Hunter }, -- Evil Hunter (Evil Hunter)
    [80381] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed, tooltip = A.Skill_Evil_Hunter }, -- Evil Hunter (Evil Hunter)
    [40195] = { tooltip = T.Skill_Expert_Hunter}, -- Camouflaged Hunter (Camouflaged Hunter)
    [80338] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed, tooltip = A.Skill_Camouflaged_Hunter }, -- Camouflaged Hunter (Camouflaged Hunter)
    [80471] = { tooltip = A.Skill_Camouflaged_Hunter }, -- Minor Berserk (Camouflaged Hunter)

    -- Trap Beast / Rearming Trap / Lightweight Beast Trap
    [35750] = { tooltip = T.Skill_Trap_Beast }, -- Trap Beast (Trap Beast)
    [35756] = { tooltip = T.Skill_Trap_Beast_Debuff }, -- Trap Beast (Trap Beast)
    [35753] = { hideReduce = true, tooltip = T.Skill_Trap_Beast_Debuff }, -- Trap Beast (Trap Beast)
    [68595] = { tooltip = A.Skill_Trap_Beast }, -- Minor Force (Trap Beast)
    [40382] = { tooltip = T.Skill_Rearming_Trap }, -- Rearming Trap (Rearming Trap)
    [40388] = { tooltip = T.Skill_Rearming_Trap }, -- Rearming Trap (Rearming Trap)
    [40385] = { tooltip = T.Skill_Trap_Beast_Debuff }, -- Rearming Trap (Rearming Trap)
    [40384] = { hideReduce = true, tooltip = T.Skill_Trap_Beast_Debuff }, -- Rearming Trap (Rearming Trap)
    [40391] = { hideReduce = true, tooltip = T.Skill_Trap_Beast_Debuff }, -- Rearming Trap (Rearming Trap)
    [68632] = { tooltip = A.Skill_Rearming_Trap }, -- Minor Force (Rearming Trap)
    [40372] = { tooltip = T.Skill_Trap_Beast }, -- Lightweight Beast Trap (Lightweight Beast Trap)
    [40375] = { tooltip = T.Skill_Trap_Beast_Debuff }, -- Lightweight Beast Trap (Lightweight Beast Trap)
    [40374] = { hideReduce = true, tooltip = T.Skill_Trap_Beast_Debuff }, -- Lightweight Beast Trap (Lightweight Beast Trap)
    [68628] = { tooltip = A.Skill_Lightweight_Beast_Trap }, -- Minor Force (Lightweight Beast Trap)

    -- Dawnbreaker / Flawless Dawnbreaker / Dawnbreaker of Smiting
    [62305] = { tooltip = T.Generic_Bleed_2_Sec }, -- Dawnbreaker
    [62310] = { tooltip = T.Generic_Bleed_2_Sec }, -- Flawless Dawnbreaker
    [40160] = { tooltip = T.Skill_Dawnbreaker_of_Smiting, hideReduce = true }, -- Dawnbreaker of Smiting
    [62314] = { tooltip = T.Skill_Dawnbreaker_of_Smiting }, -- Dawnbreaker of Smiting

    ----------------------------------------------------------------
    -- MAGES GUILD PASSIVES ----------------------------------------
    ----------------------------------------------------------------

    [29061] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_persuasive_will.dds' }, -- Persuasive Will
    [40436] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_mage_adept.dds' }, -- Mage Adept (Rank 1)
    [45601] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_mage_adept.dds' }, -- Mage Adept (Rank 2)
    [40437] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_everlasting_magic.dds' }, -- Everlasting Magic (Rank 1)
    [45602] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_everlasting_magic.dds' }, -- Everlasting Magic (Rank 2)
    [40438] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_magicka_controller.dds' }, -- Magicka Controller (Rank 1)
    [45603] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_magicka_controller.dds' }, -- Magicka Controller (Rank 2)
    [43561] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_might_of_the_guild.dds' }, -- Might of the Guild (Rank 1)
    [65507] = { tooltip = A.Skill_Might_of_the_Guild }, -- Empower (Might of the Guild)
    [45607] = { icon = 'LuiExtended/media/icons/abilities/passive_mageguild_might_of_the_guild.dds' }, -- Might of the Guild (Rank 2)
    [65541] = { tooltip = A.Skill_Might_of_the_Guild }, -- Empower (Might of the Guild)

    ----------------------------------------------------------------
    -- MAGES GUILD ACTIVE ABILITIES --------------------------------
    ----------------------------------------------------------------

    -- Magelight / Radiant Magelight / Inner Light
    [77928] = { consolidateExtra = true, tooltip = A.Skill_Magelight }, -- Major Prophecy (Magelight)
    [30920] = { tooltip = T.Skill_Expert_Hunter }, -- Magelight (Magelight)
    [31079] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed, tooltip = A.Skill_Magelight }, -- Magelight (Magelight)
    [77945] = { consolidateExtra = true, tooltip = A.Skill_Inner_Light }, -- Major Prophecy (Inner Light)
    [40478] = { tooltip = T.Skill_Expert_Hunter }, -- Inner Light (Inner Light)
    [40480] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Skill_Inner_Light }, -- Inner Light (Inner Light)
    [77958] = { consolidateExtra = true, tooltip = A.Skill_Radiant_Magelight }, -- Major Prophecy (Radiant Magelight)
    [40483] = { tooltip = T.Skill_Radiant_Magelight }, -- Radiant Magelight (Radiant Magelight)
    [40484] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', name = A.Skill_Revealed, tooltip = A.Skill_Radiant_Magelight }, -- Radiant Magelight (Radiant Magelight)
    [999005] = { icon = 'esoui/art/icons/ability_mageguild_002.dds', name = A.Skill_Magelight, tooltip = T.Skill_Magelight_Passive }, -- Magelight Fake ID for Consolidate
    [999006] = { icon = 'esoui/art/icons/ability_mageguild_002_b.dds', name = A.Skill_Inner_Light, tooltip = T.Skill_Inner_Light_Passive }, -- Inner Light Fake ID for Consolidate
    [999007] = { icon = 'esoui/art/icons/ability_mageguild_002_a.dds', name = A.Skill_Radiant_Magelight, tooltip = T.Skill_Radiant_Magelight_Passive }, -- Radiant Magelight Fake ID for Consolidate

    -- Entropy / Degeneration / Structured Entropy
    [28567] = { tooltip = T.Skill_Entropy }, -- Entropy
    [63223] = { tooltip = A.Skill_Entropy }, -- Major Sorcery
    [40457] = { tooltip = T.Skill_Degeneration }, -- Degeneration
    [63227] = { tooltip = A.Skill_Degeneration }, -- Major Sorcery (Degeneration)
    [40452] = { tooltip = T.Skill_Structured_Entropy }, -- Structured Entropy
    [63231] = { tooltip = A.Skill_Structured_Entropy }, -- Major Sorcery (Structured Entropy)

    -- Fire Rune / Volcanic Rune / Scalding Rune
    [31632] = { tooltip = T.Skill_Fire_Rune }, -- Fire Rune (Fire Rune)
    [31633] = { hide = true }, -- Fire Rune (Fire Rune)
    [40470] = { tooltip = T.Skill_Volcanic_Rune }, -- Volcanic Rune (Volcanic Rune)
    [40477] = { icon = 'esoui/art/icons/ability_mageguild_001_a.dds', hide = true }, -- Volcanic Rune (Volcanic Rune)
    [40476] = { tooltip = T.Generic_Stun }, -- Volcanic Rune (Volcanic Rune)
    [40472] = { hide = true}, -- Volcanic Rune (Volcanic Rune)
    [40465] = { tooltip = T.Skill_Scalding_Rune }, -- Scaling Rune (Scalding Rune)
    [40468] = { tooltip = T.Generic_Burn_2_Sec }, -- Scalding Rune (Scalding Rune)
    [40467] = { hide = true}, -- Scalding Rune (Scalding Rune)

    -- Equilibrium / Spell Symmetry / Balance
    [48131] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Equilibrium }, -- Equilibrium (Equilibrium)
    [48136] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Equilibrium }, -- Spell Symmetry (Spell Symmetry)
    [40449] = { tooltip = T.Skill_Spell_Symmetry }, -- Spell Symmetry (Spell Symmetry)
    [40443] = { consolidate = true, tooltip = A.Skill_Balance }, -- Major Ward (Balance)
    [80160] = { consolidate = true, tooltip = A.Skill_Balance }, -- Major Resolve (Balance)
    [48141] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Equilibrium }, -- Balance (Balance)

    -- Meteor / Ice Comet / Shooting Star
    [63430] = { tooltip = T.Skill_Meteor }, -- Meteor
    [16538] = { icon = 'esoui/art/icons/ability_mageguild_005.dds', name = A.Skill_Meteor }, -- Meteor Knockback (Meteor)
    [63429] = { tooltip = T.Generic_AOE_Fire_1_Sec, groundLabel = true }, -- Meteor (Meteor)
    [114701] = { name = A.Skill_Meteor, tooltip = T.Generic_Knockback }, -- Stun (Meteor)
    [63456] = { tooltip = T.Skill_Ice_Comet }, -- Ice Comet
    [40492] = { tooltip = T.Generic_Snare_50 }, -- Ice Comet
    [63457] = { icon = 'esoui/art/icons/ability_mageguild_005_b.dds' }, -- Ice Comet (Ice Comet)
    [63455] = { icon = 'esoui/art/icons/ability_mageguild_005_b.dds', name = A.Skill_Ice_Comet }, -- Ice Comet Knockback (Ice Comet)
    [63454] = { icon = 'esoui/art/icons/ability_mageguild_005_b.dds', tooltip = T.Generic_AOE_Frost_1_Sec, groundLabel = true }, -- Ice Comet (Ice Comet)
    [114714] = { name = A.Skill_Ice_Comet, tooltip = T.Generic_Knockback }, -- Stun (Ice Comet)
    [63473] = { tooltip = T.Skill_Meteor }, -- Shooting Star
    [63472] = { icon = 'esoui/art/icons/ability_mageguild_005_a.dds' }, -- Shooting Star (Shooting Star)
    [40495] = { icon = 'esoui/art/icons/ability_mageguild_005_a.dds' }, -- Shooting Star (Shooting Star)
    [63471] = { tooltip = T.Generic_AOE_Fire_1_Sec, groundLabel = true }, -- Shooting Star (Shooting Star)
    [114715] = { name = A.Skill_Shooting_Star, tooltip = T.Generic_Knockback }, -- Shooting Star (Shooting Star)

    ----------------------------------------------------------------
    -- PSIJIC ORDER PASSIVES ---------------------------------------
    ----------------------------------------------------------------

    [103820] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds', tooltip = T.Skill_Spell_Orb }, -- Spell Orb (Spell Orb - Rank 1)
    [103827] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds', hide = true }, -- Spell Orb (Spell Orb - Rank 1)
    [103828] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds', hide = true }, -- Spell Orb (Spell Orb - Rank 1)
    [103879] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds', tooltip = T.Skill_Spell_Orb }, -- Spell Orb (Spell Orb - Rank 2)
    [103880] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds', hide = true }, -- Spell Orb (Spell Orb - Rank 2)
    [103881] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_spell_orb.dds', hide = true }, -- Spell Orb (Spell Orb - Rank 2)
    [103923] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_concentrated_barrier.dds', forcedContainer = 'short', tooltip = T.Skill_Concentrated_Barrier }, -- Concentrated Barrier (Concentrated Barrier - Rank 1)
    [103966] = { icon = 'LuiExtended/media/icons/abilities/ability_psijic_concentrated_barrier.dds', forcedContainer = 'short', tooltip = T.Skill_Concentrated_Barrier }, -- Concentrated Barrier (Concentrated Barrier - Rank 2)

    ----------------------------------------------------------------
    -- PSIJIC ORDER ACTIVE ABILITIES -------------------------------
    ----------------------------------------------------------------

    -- Time Stop / Borrowed Time / Time Freeze
    [103538] = { tooltip = T.Skill_Time_Stop, groundLabel = true }, -- Time Stop (Time Stop)
    [104007] = { tooltip = T.Skill_Time_Stop, groundLabel = true }, -- Time Stop (Time Stop)
    [104009] = { tooltip = T.Skill_Time_Stop, groundLabel = true }, -- Time Stop (Time Stop)
    [104050] = { tooltip = T.Generic_Stun }, -- Time Stop (Time Stop)
    [104071] = { tooltip = T.Skill_Borrowed_Time, groundLabel = true }, -- Borrowed Time (Borrowed Time)
    [104072] = { tooltip = T.Skill_Borrowed_Time, groundLabel = true }, -- Borrowed Time (Borrowed Time)
    [104073] = { tooltip = T.Skill_Borrowed_Time, groundLabel = true }, -- Borrowed Time (Borrowed Time)
    [104075] = { hideReduce = true, tooltip = T.Skill_Borrowed_Time_Stun }, -- Borrowed Time (Borrowed Time)
    [104078] = { tooltip = T.Skill_Borrowed_Time_Stun }, -- Borrowed Time (Borrowed Time)
    [104080] = { tooltip = T.Skill_Time_Freeze, groundLabel = true }, -- Time Freeze (Time Freeze)
    [104081] = { tooltip = T.Skill_Time_Freeze, groundLabel = true }, -- Time Freeze (Time Freeze)
    [104082] = { tooltip = T.Skill_Time_Freeze, groundLabel = true }, -- Time Freeze (Time Freeze)
    [104083] = { tooltip = T.Skill_Time_Freeze, groundLabel = true }, -- Time Freeze (Time Freeze)
    [104085] = { tooltip = T.Generic_Stun }, -- Time Freeze (Time Freeze)

    -- Imbue Weapon / Elemental Weapon / Crushing Weapon
    [103483] = { tooltip = T.Skill_Imbue_Weapon }, -- Imbue Weapon (Imbue Weapon)
    [110420] = { icon = 'esoui/art/icons/ability_psijic_003.dds', name = A.Skill_Imbue_Weapon }, -- Imbue Weapon Restore (Imbue Weapon)
    [103571] = { tooltip = T.Skill_Elemental_Weapon }, -- Elemental Weapon (Elemental Weapon)
    [110421] = { icon = 'esoui/art/icons/ability_psijic_003_a.dds', name = A.Skill_Elemental_Weapon }, -- Elemental Weapon Restore (Elemental Weapon)
    [103623] = { tooltip = T.Skill_Crushing_Weapon }, -- Crushing Weapon (Crushing Weapon)
    [110422] = { icon = 'esoui/art/icons/ability_psijic_003_b.dds', name = A.Skill_Crushing_Weapon }, -- Crushing Weapon Restore (Crushing Weapon)

    -- Accelerate / Channeled Acceleration / Race Against Time
    [103520] = { tooltip = A.Skill_Accelerate }, -- Major Expedition (Accelerate)
    [103521] = { consolidateExtra = true, tooltip = A.Skill_Accelerate }, -- Minor Force (Accelerate)
    [103707] = { tooltip = A.Skill_Channeled_Acceleration }, -- Major Expedition (Channeled Acceleration)
    [103708] = { consolidateExtra = true, tooltip = A.Skill_Channeled_Acceleration }, -- Minor Force (Channeled Acceleration)
    [103711] = { tooltip = A.Skill_Race_Against_Time }, -- Major Expedition (Race Against Time)
    [103712] = { consolidateExtra = true, tooltip = A.Skill_Race_Against_Time }, -- Minor Force (Race Against Time)

    -- Mend Wounds / Mend Spirit / Symbiosis
    [103543] = { tooltip = T.Skill_Mend_Wounds }, -- Mend Wounds (Mend Wounds)
    [107583] = { refreshOnly = true, tooltip = T.Generic_HoT_2Sec }, -- Mend Wounds (Mend Wounds)
    [107579] = { duration = 0, forcedContainer = 'short', tooltip = T.Skill_Mend_Wounds_Channel }, -- Mend Wounds (Mend Wounds)
    [103747] = { tooltip = T.Skill_Mend_Spirit }, -- Mend Spirit (Mend Spirit)
    [107629] = { refreshOnly = true, tooltip = T.Generic_HoT_2Sec }, -- Mend Spirit (Mend Spirit)
    [107632] = { forcedContainer = 'short', tooltip = A.Skill_Mend_Spirit }, -- Major Resolve (Mend Spirit)
    [107631] = { forcedContainer = 'short', tooltip = A.Skill_Mend_Spirit }, -- Major Ward (Mend Spirit)
    [107630] = { duration = 0, forcedContainer = 'short', tooltip = T.Skill_Mend_Wounds_Channel }, -- Mend Spirit (Mend Spirit)
    [103752] = { forcedContainer = 'short', tooltip = A.Skill_Mend_Spirit }, -- Major Resolve (Mend Spirit)
    [103751] = { forcedContainer = 'short', tooltip = A.Skill_Mend_Spirit }, -- Major Ward (Mend Spirit)
    [103755] = { tooltip = T.Skill_Symbiosis }, -- Symbiosis (Symbiosis)
    [107636] = { refreshOnly = true, tooltip = T.Generic_HoT_2Sec }, -- Symbiosis (Symbiosis)
    [107637] = { name = A.Skill_Symbiosis, duration = 0, forcedContainer = 'short', tooltip = T.Skill_Mend_Wounds_Channel }, -- Symbiosis HA (Symbiosis)

    -- Meditate / Deep Thoughts / Introspection
    [103492] = { forcedContainer = 'short', tooltip = T.Skill_Meditate }, -- Meditate (Meditate)
    [103500] = { icon = 'esoui/art/icons/ability_psijic_004.dds' }, -- Meditate (Meditate)
    [103501] = { icon = 'esoui/art/icons/ability_psijic_004.dds' }, -- Meditate (Meditate)
    [103652] = { forcedContainer = 'short', tooltip = T.Skill_Meditate }, -- Deep Thoughts (Deep Thoughts)
    [103655] = { icon = 'esoui/art/icons/ability_psijic_004_a.dds' }, -- Deep Thoughts (Deep Thoughts)
    [103656] = { icon = 'esoui/art/icons/ability_psijic_004_a.dds' }, -- Deep Thoughts (Deep Thoughts)
    [103665] = { forcedContainer = 'short', tooltip = T.Skill_Introspection }, -- Introspection (Introspection)
    [103668] = { icon = 'esoui/art/icons/ability_psijic_004_b.dds' }, -- Introspection (Introspection)
    [103669] = { icon = 'esoui/art/icons/ability_psijic_004_b.dds' }, -- Introspection (Introspection)

    -- Undo / Precognition / Temporal Guard
    [103570] = { tooltip = A.Skill_Temporal_Guard }, -- Minor Protection (Temporal Guard)

    ----------------------------------------------------------------
    -- UNDAUNTED PASSIVES ------------------------------------------
    ----------------------------------------------------------------

    [55584] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 1)
    [55606] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 1)
    [55607] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = A.Passive_Undaunted_Command }, -- Undaunted Command Magicka Rest (Undaunted Command - Rank 1)
    [55608] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = A.Passive_Undaunted_Command }, -- Undaunted Command Stamina Rest (Undaunted Command - Rank 1)
    [55676] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 2)
    [55677] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds' }, -- Undaunted Command (Undaunted Command - Rank 2)
    [55678] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = A.Passive_Undaunted_Command }, -- Undaunted Command Stamina Rest (Undaunted Command - Rank 2)
    [55679] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_undaunted_command.dds', name = A.Passive_Undaunted_Command }, -- Undaunted Command Magicka Rest (Undaunted Command - Rank 2)
    [55366] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_mettle.dds' }, -- Undaunted Mettle (Undaunted Mettle - Rank 1)
    [55386] = { icon = 'LuiExtended/media/icons/abilities/passive_undaunted_undaunted_mettle.dds' }, -- Undaunted Mettle (Undaunted Mettle - Rank 2)

    ----------------------------------------------------------------
    -- UNDAUNTED ACTIVES -------------------------------------------
    ----------------------------------------------------------------

    -- Blood Altar / Sanguine Altar / Overflowing Altar
    [108782] = { hide = true }, -- Blood Funnel (Blood Altar - Blood Funnel Synergy)
    [80021] = { icon = 'esoui/art/icons/ability_buff_minor_lifesteal.dds' }, -- Minor Lifesteal (Blood Altar)
    [39501] = { icon = 'esoui/art/icons/ability_undaunted_001.dds' }, -- Blood Funnel (Blood Altar - Blood Funnel Synergy)
    [108787] = { hide = true }, -- Blood Feast (Overflowing Altar - Blood Feast Synergy)
    [41964] = { icon = 'esoui/art/icons/ability_undaunted_001_a.dds' }, -- Blood Feast (Overflowing Altar)
    [80020] = { tooltip = A.Skill_Blood_Altar, groundLabel = true }, -- Blood Altar (Blood Altar - Shared - All Morphs)
    [39489] = { tooltip = T.Skill_Blood_Altar }, -- Blood Altar (Blood Altar)
    [41967] = { tooltip = T.Skill_Blood_Altar }, -- Sanguine Altar (Sanguine Altar)
    [41958] = { tooltip = T.Skill_Overflowing_Altar }, -- Overflowing Altar (Overflowing Altar)

    -- Trapping Webs / Shadow Silk / Tangling Webs
    [108788] = { hide = true }, -- Synergy Damage Bonus (Trapping Webs - Spawn Broodlings Synergy)
    [39430] = { icon = 'esoui/art/icons/ability_undaunted_003.dds', tooltip = T.Skill_Spawn_Broodlings }, -- Spawn Broodlings (Trapping Webs - Spawn Broodlings Synergy)
    [39432] = { icon = 'esoui/art/icons/ability_undaunted_003.dds', tooltip = T.Skill_Spawn_Broodlings }, -- Spawn Broodlings (Trapping Webs - Spawn Broodlings Synergy)
    [77245] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_bite.dds' }, -- Bite (Trapping Webs - Spawn Broodlings Synergy)
    [39425] = { tooltip = T.Skill_Trapping_Webs }, -- Trapping Webs (Trapping Webs)
    [80079] = { duration = 0, tooltip = T.Skill_Trapping_Webs_Snare, groundLabel = true }, -- Trapping Webs (Trapping Webs)
    [108791] = { hide = true }, -- Synergy Damage Bonus (Shadow Silk - Black Widows Synergy)
    [41994] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds' }, -- Black Widows (Shadow Silk - Black Widows Synergy)
    [41998] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds', name = A.Skill_Black_Widows, tooltip = T.Skill_Spawn_Broodlings }, -- Spawn Broodlings (Shadow Silk - Black Widows Synergy)
    [41999] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds', name = A.Skill_Black_Widows, tooltip = T.Skill_Spawn_Broodlings }, -- Spawn Broodlings (Shadow Silk - Black Widows Synergy)
    [42000] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_undaunted_black_widow_poison.dds' }, -- Black Widow Poison (Shadow Silk - Black Widows Synergy)
    [42007] = { icon = 'LuiExtended/media/icons/abilities/ability_undaunted_black_widow_poison.dds', tooltip = T.Generic_Poison_2_Sec }, -- Black Widow Poison (Shadow Silk - Black Widows Synergy)
    [41990] = { tooltip = T.Skill_Shadow_Silk}, -- Shadow Silk (Shadow Silk)
    [80108] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds', duration = 0, tooltip = T.Skill_Trapping_Webs_Snare, groundLabel = true }, -- Shadow Silk (Shadow Silk)
    [80107] = { icon = 'esoui/art/icons/ability_undaunted_003_a.dds' }, -- Shadow Silk (Shadow Silk)
    [108792] = { hide = true }, -- Synergy Damage Bonus (Tangling Webs - Arachnophobia Synergy)
    [42016] = { icon = 'esoui/art/icons/ability_undaunted_003_b.dds' }, -- Arachnophobia (Tangling Webs - Arachnophobia Synergy)
    [42023] = { icon = 'esoui/art/icons/ability_undaunted_003_b.dds', tooltip = T.Generic_Fear }, -- Arachnophobia (Tangling Webs - Arachnophobia Synergy)
    [42020] = { tooltip = T.Skill_Spawn_Broodlings }, -- Arachnophobia (Tangling Webs - Arachnophobia Synergy)
    [42021] = { tooltip = T.Skill_Spawn_Broodlings }, -- Arachnophobia (Tangling Webs - Arachnophobia Synergy)
    [42012] = { tooltip = T.Skill_Tangling_Webs }, -- Tangling Webs (Tangling Webs)
    [80130] = { icon = 'esoui/art/icons/ability_undaunted_003_b.dds', duration = 0, tooltip = T.Skill_Trapping_Webs_Snare, groundLabel = true }, --  Tangling Webs (Tangling Webs)
    [80129] = { icon = 'esoui/art/icons/ability_undaunted_003_b.dds' }, --  Tangling Webs (Tangling Webs)

    -- Inner Fire / Inner Rage / Inner Beast
    [108793] = { hide = true }, -- Synergy Damage Bonus (Inner Fire - Radiate Synergy)
    [41838] = { tooltip = T.Skill_Radiate }, -- Radiate (Inner Fire - Radiate Synergy)

    -- Bone Shield / Spiked Bone Shield / Bone Surge
    [108794] = { hide = true }, -- Synergy Damage Bonus (Bone Shield - Bone Wall Synergy)
    [39379] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Bone Wall (Bone Shield - Bone Wall Synergy)
    [108797] = { hide = true }, -- Synergy Damage Bonus (Bone Surge - Spinal Surge Synergy)
    [42198] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Spinal Surge (Bone Surge - Spinal Surge Synergy)
    [42197] = { tooltip = A.Skill_Spinal_Surge }, -- Major Vitality (Bone Surge - Spinal Surge Synergy)
    [39369] = { tooltip = T.Skill_Bone_Shield }, -- Bone Shield
    [42138] = { tooltip = T.Skill_Spiked_Bone_Shield }, -- Spiked Bone Shield
    [42176] = { tooltip = T.Skill_Bone_Surge }, -- Bone Surge

    -- Necrotic Orb / Mystic Orb / Energy Orb
    [108799] = { hide = true }, -- Synergy Damage Bonus (Necrotic Orb - Combustion Synergy)
    [85432] = { icon = 'esoui/art/icons/ability_undaunted_004.dds' }, -- Combustion (Necrotic Orb - Combustion Synergy)
    [108802] = { hide = true }, -- Synergy Damage Bonus (Energy Orb - Healing Combustion Synergy)
    [95041] = { icon = 'esoui/art/icons/ability_undaunted_004b.dds', name = A.Skill_Healing_Combustion }, -- Combustion (Energy Orb - Healing Combustion Synergy)
    [95042] = { icon = 'esoui/art/icons/ability_undaunted_004b.dds', name = A.Skill_Healing_Combustion }, -- Combustion (Energy Orb - Healing Combustion Synergy)
    [63511] = { icon = 'esoui/art/icons/ability_undaunted_004b.dds', name = A.Skill_Healing_Combustion }, -- Combustion (Energy Orb - Healing Combustion Synergy)

    ----------------------------------------------------------------
    -- ASSAULT PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    [39248] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_continuous_attack.dds' }, -- Continuous Attack (Continuous Attack - Rank 1)
    [39249] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_continuous_attack.dds', tooltip = T.Skill_Continuous_Attack_Rank_1 }, -- Continuous Attack (Continuous Attack - Rank 1)
    [45614] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_continuous_attack.dds' }, -- Continuous Attack (Continuous Attack - Rank 2)
    [45617] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_continuous_attack.dds', tooltip = T.Skill_Continuous_Attack_Rank_2 }, -- Continuous Attack (Continuous Attack - Rank 2)
    [39254] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_reach.dds' }, -- Reach
    [45621] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_reach.dds' }, -- Reach
    [39252] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 1)
    [39253] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 1)
    [45619] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 2)
    [45620] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_combat_frenzy.dds' }, -- Combat Frenzy (Combat Frenzy - Rank 2)

    ----------------------------------------------------------------
    -- ASSAULT ACTIVES ---------------------------------------------
    ----------------------------------------------------------------

    -- Rapid Manuever / Retreating Maneuver / Charging Maneuver
    [38566] = { tooltip = T.Skill_Rapid_Maneuver }, -- Rapid Manuever (Rapid Maneuver)
    [101161] = { consolidate = true, tooltip = A.Skill_Rapid_Manuever }, -- Major Expedition (Rapid Maneuver)
    [57472] = { consolidate = true, tooltip = A.Skill_Rapid_Manuever }, -- Major Gallop (Rapid Maneuver)
    [40211] = { tooltip = T.Skill_Retreating_Maneuver }, -- Retreating Maneuver (Retreating Maneuver)
    [101169] = { consolidate = true, tooltip = A.Skill_Retreating_Manuever }, -- Major Expedition (Retreating Maneuver)
    [57477] = { consolidate = true, tooltip = A.Skill_Retreating_Manuever }, -- Major Gallop (Retreating Maneuver)
    [40215] = { tooltip = T.Skill_Charging_Maneuver }, -- Charging Maneuver (Charging Maneuver)
    [101178] = { consolidate = true, tooltip = A.Skill_Charging_Manuever }, -- Major Expedition (Charging Maneuver)
    [57481] = { consolidate = true, tooltip = A.Skill_Charging_Manuever }, -- Major Gallop (Charging Maneuver)
    [40219] = { tooltip = A.Skill_Charging_Manuever }, -- Minor Expedition (Charging Maneuver)

    -- Vigor / Echoing Vigor / Resolving Vigor
    [61504] = { tooltip = T.Generic_HoT_1Sec }, -- Vigor (Vigor)
    [61506] = { tooltip = T.Generic_HoT_1Sec }, -- Echoing Vigor (Echoing Vigor)
    [61509] = { tooltip = T.Generic_HoT_1Sec }, -- Resolving Vigor (Resolving Vigor)
    [61508] = { tooltip = T.Generic_HoT_1Sec }, -- Resolving Vigor (Resolving Vigor)

    -- Caltrops / Anti-Cavalry Caltrops / Razor Caltrops
    [38549] = { tooltip = T.Skill_Caltrops }, -- Caltrops (Caltrops)
    [38561] = { groundLabel = true, tooltip = T.Skill_Caltrops_Debuff }, -- Caltrops (Caltrops)
    [113769] = { tooltip = T.Skill_Caltrops_Debuff, groundLabel = true, hideGround = true }, -- Caltrops (Caltrops)
    [40265] = { tooltip = T.Skill_Anti_Cavalry_Caltrops }, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40267] = { groundLabel = true, tooltip = T.Skill_Anti_Cavalry_Caltrops_Debuff }, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [113770] = { tooltip = T.Skill_Anti_Cavalry_Caltrops_Debuff, groundLabel = true, hideGround = true }, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40251] = { tooltip = T.Skill_Caltrops }, -- Caltrops (Razor Caltrops)
    [113771] = { tooltip = T.Skill_Caltrops_Debuff, groundLabel = true, hideGround = true }, -- Razor Caltrops (Razor Caltrops)
    [40252] = { groundLabel = true, tooltip = T.Skill_Caltrops_Debuff }, -- Razor Caltrops (Razor Caltrops)
    [40253] = { name = A.Skill_Razor_Caltrops, tooltip = T.Generic_Snare_70 }, -- Hindered (Razor Caltrops)

    -- Magicka Detonation/ Inevitable Detonation / Proximity Detonation
    [61487] = { tooltip = T.Skill_Magicka_Detonation }, -- Magicka Detonation (Magicka Detonation)
    [66482] = { hide = true }, -- Magicka Detonation (Magicka Detonation)
    [61491] = { tooltip = T.Skill_Inevitable_Detonation }, -- Magicka Detonation (Inevitable Detonation)
    [66491] = { hide = true }, -- Magicka Detonation (Inevitable Detonation)
    [61500] = { tooltip = T.Skill_Proximity_Detonation }, -- Magicka Detonation (Proximity Detonation)
    [66499] = { hide = true }, -- Magicka Detonation (Proximity Detonation)

    -- War Horn
    [38564] = { tooltip = T.Skill_War_Horn }, -- War Horn (War Horn)
    [40224] = { tooltip = T.Skill_War_Horn }, -- Aggresive Horn (Aggresive Horn)
    [40225] = { tooltip = A.Skill_Aggressive_Horn }, -- Major Force (Aggresive Horn)
    [40221] = { tooltip = T.Skill_War_Horn }, -- Sturdy Horn (Sturdy Horn)
    [63532] = { consolidate = true, tooltip = A.Skill_Sturdy_Horn }, -- Minor Resolve (Sturdy Horn)
    [63571] = { consolidate = true, tooltip = A.Skill_Sturdy_Horn }, -- Minor Ward (Sturdy Horn)

    ----------------------------------------------------------------
    -- SUPPORT PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    [39255] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_magicka_aid.dds' }, -- Magicka Aid
    [45622] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_magicka_aid.dds' }, -- Magicka Aid
    [39259] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_medic.dds' }, -- Combat Medic
    [45624] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_combat_medic.dds' }, -- Combat Medic
    [39261] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_battle_resurrection.dds' }, -- Battle Resurrection
    [45625] = { icon = 'LuiExtended/media/icons/abilities/passive_ava_battle_resurrection.dds' }, -- Battle Resurrection

    ----------------------------------------------------------------
    -- SUPPORT ACTIVES ---------------------------------------------
    ----------------------------------------------------------------

    -- Siege Shield / Siege Weapon Shield / Propelling Shield
    [38570] = { tooltip = T.Skill_Siege_Shield_Ground }, -- Siege Shield (Siege Shield)
    [39844] = { duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = T.Skill_Siege_Shield }, -- Siege Shield (Siege Shield)
    [40229] = { tooltip = T.Skill_Siege_Weapon_Shield_Ground }, -- Siege Weapon Shield (Siege Weapon Shield)
    [40231] = { duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = T.Skill_Siege_Weapon_Shield }, -- Siege Weapon Shield (Siege Weapon Shield)
    [40226] = { tooltip = T.Skill_Propelling_Shield_Ground }, -- Propelling Shield (Siege Weapon Shield)
    [40227] = { duration = 0, forcedContainer = 'short', groundLabel = true, tooltip = T.Skill_Propelling_Shield }, -- Propelling Shield (Siege Weapon Shield)


    -- Purge / Efficient Purge / Cleanse
    [38571] = { tooltip = T.Skill_Purge }, -- Purge (Purge)
    [40232] = { tooltip = T.Skill_Purge }, -- Purge (Efficient Purge)
    [40234] = { tooltip = T.Skill_Purge } , -- Cleanse (Cleanse)
    [40235] = { hide = true }, -- Cleanse (Cleanse)

    -- Guard / Mystic Guard / Stalwart Guard
    [61511] = { duration = 0, forcedContainer = 'short', tooltip = T.Skill_Guard_Other }, -- Guard (Guard)
    [80923] = { duration = 0, tooltip = T.Skill_Guard_Self }, -- Guard (Guard)
    [61536] = { duration = 0, forcedContainer = 'short', tooltip = T.Skill_Guard_Other }, -- Mystic Guard (Mystic Guard)
    [80947] = { duration = 0, tooltip = T.Skill_Guard_Self }, -- Mystic Guard (Mystic Guard)
    [80953] = { duration = 0, forcedContainer = 'short', consolidate = true, tooltip = A.Skill_Mystic_Guard }, -- Minor Vitality (Mystic Guard)
    [64080] = { duration = 0, consolidate = true, tooltip = A.Skill_Mystic_Guard }, -- Minor Vitality (Mystic Guard)
    [80945] = { icon = 'esoui/art/icons/ability_ava_mystic_guard.dds' }, -- Mystic Guard (Mystic Guard)
    [61529] = { duration = 0, forcedContainer = 'short', tooltip = T.Skill_Guard_Other }, -- Stalwart Guard (Stalwart Guard)
    [80983] = { duration = 0, tooltip = T.Skill_Guard_Self }, -- Stalwart Guard (Stalwart Guard)
    [80984] = { duration = 0, forcedContainer = 'short', consolidate = true, tooltip = A.Skill_Stalwart_Guard }, -- Minor Force (Stalwart Guard)
    [80986] = { duration = 0, consolidate = true, tooltip = A.Skill_Stalwart_Guard }, -- Minor Force (Stalwart Guard)
    [80981] = { icon = 'esoui/art/icons/ability_ava_stalwart_guard.dds' }, -- Stalwart Guard (Stalwart Guard)

    -- Revealing Flare / Lingering Flare / Scorching Flare
    [61496] = { tooltip = T.Skill_Revealing_Flare }, -- Revealing Flare (Revealing Flare)
    [61522] = { tooltip = T.Skill_Lingering_Flare }, -- Nova (Lingering Flare)
    [61521] = { tooltip = T.Skill_Revealing_Flare }, -- Lingering Flare (Lingering Flare)
    [61528] = { name = A.Skill_Scorching_Flare, tooltip = T.Skill_Scorching_Flare }, -- Scorching Flare Reveal (Scorching Flare)
    [61552] = { hideReduce = true, tooltip = T.Skill_Scorching_Flare }, -- Scorching Flare (Scorching Flare)

    -- Barrier / Reviving Barrier / Replenishing Barrier
    [38573] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Barrier (Barrier)
    [40237] = { hideReduce = true, tooltip = T.Skill_Reviving_Barrier }, -- Reviving Barrier (Reviving Barrier)
    [40238] = { name = A.Skill_Reviving_Barrier, tooltip = T.Skill_Reviving_Barrier }, -- Reviving Barrier Heal (Reviving Barrier)
    [40239] = { tooltip = T.Generic_Damage_Shield_Duration }, -- Replenishing Barrier (Replenishing Barrier)
    [40240] = { icon = 'esoui/art/icons/ability_ava_006_a.dds' }, -- Replenishing Barrier (Replenishing Barrier)
    [40241] = { icon = 'esoui/art/icons/ability_ava_006_a.dds' }, -- Replenishing Barrier (Replenishing Barrier)

    ----------------------------------------------------------------
    -- EMPEROR PASSIVES --------------------------------------------
    ----------------------------------------------------------------

    [39625] = { icon = 'LuiExtended/media/icons/abilities/passive_emperor_monarch.dds' }, -- Monarch
    [39630] = { icon = 'LuiExtended/media/icons/abilities/passive_emperor_authority.dds' }, -- Authority
    [39644] = { icon = 'LuiExtended/media/icons/abilities/passive_emperor_domination.dds' }, -- Domination
    [39647] = { icon = 'LuiExtended/media/icons/abilities/passive_emperor_tactician.dds' }, -- Tactician
    [39641] = { icon = 'LuiExtended/media/icons/abilities/passive_emperor_emperor.dds' }, -- Emperor

    ----------------------------------------------------------------
    -- PLAYER PASSIVES RACIAL --------------------------------------
    ----------------------------------------------------------------

    -- Breton
    [36247] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_opportunist.dds' }, -- Opportunist
    [35995] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }, -- Gift of Magnus (Rank 1)
    [45259] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }, -- Gift of Magnus (Rank 2)
    [45260] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_gift_of_magnus.dds' }, -- Gift of Magnus (Rank 3)
    [36266] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }, -- Spell Resistance (Rank 1)
    [45261] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }, -- Spell Resistance (Rank 2)
    [45262] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_resistance.dds' }, -- Spell Resistance (Rank 3)
    [36303] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }, -- Magicka Mastery (Rank 1)
    [45263] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }, -- Magicka Mastery (Rank 2)
    [45264] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_magicka_mastery.dds' }, -- Magicka Mastery (Rank 3)

    -- Orc (Orsimer)
    [33293] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_craftsman.dds' }, -- Craftsman
    [33301] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }, -- Brawny (Rank 1)
    [45307] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }, -- Brawny (Rank 2)
    [45309] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_brawny.dds' }, -- Brawny (Rank 3)
    [84668] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }, -- Unflinching Rage (Rank 1)
    [118195] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }, -- Unflinching Rage (Rank 1)
    [118196] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }, -- Unflinching Rage (Rank 1)
    [84670] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }, -- Unflinching Rage (Rank 2)
    [118202] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }, -- Unflinching Rage (Rank 2)
    [118203] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }, -- Unflinching Rage (Rank 2)
    [84672] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_unflinching.dds' }, -- Unflinching Rage (Rank 3)
    [118205] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }, -- Unflinching Rage (Rank 3)
    [118206] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_unflinching.dds' }, -- Unflinching Rage (Rank 3)
    [33304] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }, -- Swift Warrior (Rank 1)
    [45311] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }, -- Swift Warrior (Rank 2)
    [45312] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_swift_warrior.dds' }, -- Swift Warrior (Rank 3)

    -- Redguard
    [84680] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_wayfarer.dds' }, -- Wayfarer
    [36009] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }, -- Martial Training (Rank 1)
    [45277] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }, -- Martial Training (Rank 2)
    [45278] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_exhilaration.dds' }, -- Martial Training (Rank 3)
    [117752] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }, -- Conditioning (Rank 1)
    [117753] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }, -- Conditioning (Rank 2)
    [117754] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_conditioning.dds' }, -- Conditioning (Rank 3)
    [36546] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }, -- Adrenaline Rush (Rank 1)
    [36548] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds' }, -- Adrenaline Rush (Adrenaline Rush - Rank 1)
    [45313] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }, -- Adrenaline Rush (Rank 2)
    [45314] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds' }, -- Adrenaline Rush (Adrenaline Rush - Rank 2)
    [45315] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_adrenaline_rush.dds' }, -- Adrenaline Rush (Rank 3)
    [45316] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_adrenaline_rush.dds' }, -- Adrenaline Rush (Adrenaline Rush - Rank 3)

    -- High Elf (Altmer)
    [35965] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_highborn.dds' }, -- Highborn
    [35993] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_recharge.dds' }, -- Spell Recharge (Rank 1)
    [118110] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }, -- Spell Recharge (Rank 1)
    [118111] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }, -- Spell Recharge (Rank 1)
    [45273] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_recharge.dds' }, -- Spell Recharge (Rank 2)
    [118113] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }, -- Spell Recharge (Rank 2)
    [118114] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }, -- Spell Recharge (Rank 2)
    [45274] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_spell_recharge.dds' }, -- Spell Recharge (Rank 3)
    [118116] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }, -- Spell Recharge (Rank 3)
    [118117] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_spell_recharge.dds' }, -- Spell Recharge (Rank 3)
    [117968] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_syrabanes_boon.dds' }, -- Syrabane's Boon (Rank 1)
    [117969] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_syrabanes_boon.dds' }, -- Syrabane's Boon (Rank 2)
    [117970] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_syrabanes_boon.dds' }, -- Syrabane's Boon (Rank 3)
    [35998] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }, -- Elemental Talent (Rank 1)
    [45275] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }, -- Elemental Talent (Rank 2)
    [45276] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_elemental_talent.dds' }, -- Elemental Talent (Rank 3)

    -- Wood Elf (Bosmer)
    [36008] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_acrobat.dds', hide = true }, -- Acrobat -- SHOWS ONLY ON TARGET PLAYERS
    [36022] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_hunters_eye.dds' }, -- Hunter's Eye (Rank 1)
    [49175] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_hunters_eye.dds', tooltip = T.Skill_Hunters_Eye_Rank_1 }, -- Hunter's Eye (Rank 1)
    [45295] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_hunters_eye.dds' }, -- Hunter's Eye (Rank 2)
    [49176] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_hunters_eye.dds', tooltip = T.Skill_Hunters_Eye_Rank_2 }, -- Hunter's Eye (Rank 2)
    [45296] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_hunters_eye.dds' }, -- Hunter's Eye (Rank 3)
    [49177] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_hunters_eye.dds', tooltip = T.Skill_Hunters_Eye_Rank_3 }, -- Hunter's Eye (Rank 3)
    [64279] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }, -- Y'ffre's Endurance (Rank 1)
    [64280] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }, -- Y'ffre's Endurance (Rank 2)
    [64281] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_yffres_endurance.dds' }, -- Y'ffre's Endurance (Rank 3)
    [36011] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }, -- Resist Affliction (Rank 1)
    [45317] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }, -- Resist Affliction (Rank 2)
    [45319] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_affliction.dds' }, -- Resist Affliction (Rank 3)

    -- Khajiit
    [36063] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_cutpurse.dds' }, -- Cutpurse
    [70386] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }, -- Nimble (Rank 1)
    [70388] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }, -- Nimble (Rank 2)
    [70390] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_nimble.dds' }, -- Nimble (Rank 3)
    [117846] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_lunar_blessings.dds' }, -- Lunar Blessings (Rank 1)
    [117847] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_lunar_blessings.dds' }, -- Lunar Blessings (Rank 2)
    [117848] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_lunar_blessings.dds' }, -- Lunar Blessings (Rank 3)
    [36067] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }, -- Carnage (Rank 1)
    [45299] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }, -- Carnage (Rank 2)
    [45301] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_carnage.dds' }, -- Carnage (Rank 3)

    -- Argonian
    [36582] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_amphibian.dds' }, -- Amphibian
    [36568] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }, -- Resourceful (Rank 1)
    [45243] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }, -- Resourceful (Rank 2)
    [45247] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resourceful.dds' }, -- Resourceful (Rank 3)
    [36583] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }, -- Argonian Resistance (Rank 1)
    [45253] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }, -- Argonian Resistance (Rank 2)
    [45255] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_argonian_resistance.dds' }, -- Argonian Resistance (Rank 3)
    [36585] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }, -- Quick to Mend (Rank 1)
    [45257] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }, -- Quick to Mend (Rank 2)
    [45258] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_quick_to_mend.dds' }, -- Quick to Mend (Rank 3)

    -- Dark Elf (Dunmer)
    [36588] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_ashlander.dds' }, -- Ashlander
    [36591] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }, -- Dynamic (Rank 1)
    [45265] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }, -- Dynamic (Rank 2)
    [45267] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_dynamic.dds' }, -- Dynamic (Rank 3)
    [36593] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }, -- Resist Flame (Rank 1)
    [45269] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }, -- Resist Flame (Rank 2)
    [45270] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_flame.dds' }, -- Resist Flame (Rank 3)
    [36598] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }, -- Destructive Ancestry (Rank 1)
    [45271] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }, -- Destructive Ancestry (Rank 2)
    [45272] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_destructive_ancestry.dds' }, -- Destructive Ancestry (Rank 3)

    -- Nord
    [36626] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_reveler.dds' }, -- Reveler
    [36064] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }, -- Stalwart (Rank 1)
    [118182] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_stalwart.dds' }, -- Stalwart (Rank 1)
    [45297] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }, -- Stalwart (Rank 2)
    [118184] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_stalwart.dds' }, -- Stalwart (Rank 2)
    [45298] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_stalwart.dds' }, -- Stalwart (Rank 3)
    [118186] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_stalwart.dds' }, -- Stalwart (Rank 3)
    [36627] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }, -- Resist Frost (Rank 1)
    [45303] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }, -- Resist Frost (Rank 2)
    [45304] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_resist_frost.dds' }, -- Resist Frost
    [36628] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }, -- Rugged (Rank 1)
    [45305] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }, -- Rugged (Rank 2)
    [45306] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_rugged.dds' }, -- Rugged (Rank 3)

    -- Imperial
    [36312] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_diplomat.dds' }, -- Diplomat
    [50903] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }, -- Tough (Rank 1)
    [50906] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }, -- Tough (Rank 2)
    [50907] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_tough.dds' }, -- Tough (Rank 3)
    [36153] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_imperial_mettle.dds' }, -- Imperial Mettle (Rank 1)
    [45279] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_imperial_mettle.dds' }, -- Imperial Mettle (Rank 2)
    [45280] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_imperial_mettle.dds' }, -- Imperial Mettle (Rank 3)
    [36155] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds' }, -- Red Diamond (Rank 1)
    [45291] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds' }, -- Red Diamond (Rank 2)
    [45293] = { icon = 'LuiExtended/media/icons/abilities/passive_racial_red_diamond.dds' }, -- Red Diamond (Rank 3)
    [63694] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 1)
    [63695] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 1)
    [63696] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 1)
    [63697] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 2)
    [63698] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 2)
    [63699] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 2)
    [63701] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 3)
    [63702] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 3)
    [63703] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_resourceful.dds' }, -- Resourceful (Resourceful - Rank 3)

    [36214] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 1)
    [121126] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 1)
    [121127] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 1)
    [45292] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 2)
    [121139] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 2)
    [121140] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 2)
    [45294] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 3)
    [121141] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 3)
    [121142] = { icon = 'LuiExtended/media/icons/abilities/ability_racial_red_diamond.dds' }, -- Red Diamond (Red Diamond - Rank 3)

    --[[
    [88480] = { hide = true }, -- Trap Triggerer (Various)
    [26530] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Bear Trap (Bear Trap)
    [65854] = { icon = 'esoui/art/icons/death_recap_environmental.dds', name = 'Spike Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spike Trap Snare (Spike Trap) (Orsinium - To Save a Chief)
    [65855] = { icon = 'esoui/art/icons/death_recap_environmental.dds', name = 'Spike Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Trap Sprung (Spike Trap) (Orsinium - To Save a Chief)
    [65856] = { hide = true }, -- Spike Trap (Spike Trap) (Orsinium - To Save a Chief)
    [20259] = { name = 'Sigil of Frost', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Sigil of Frost Snare (Sigil of Frost - Wrothgar - Coldwind's Den)
    [73103] = { hide = true }, -- Lava (Orsinium - The Hand of Morkul) (Lava)
    ]]--

    -- New Listing
    [73095] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds', name = A.Trap_Lava }, -- In Lava (Vvardenfell - Nchuleftingth - Public Dungeon)
    --[[
    [89481] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Flame Jet (Vvardenfell -- An Armiger's Duty)
    [88403] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Flame Jet (Vvardenfell -- Ancestral Adversity)
    [88491] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flame_jet.dds', name = 'Flame Jet Trap' }, -- Searing Flame (Vvardenfell -- Ancestral Adversity)
    [88510] = { name = A.Innate_Stagger, hide = true }, -- Staggered (Vvardenfell -- Ancestral Adversity)
    [88411] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88413] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88405] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88406] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [89663] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [89664] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_hammer.dds', name = 'Hammer Trap' }, -- Hammer (Vvardenfell -- Ancestral Adversity)
    [88404] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_blade.dds', name = 'Blade Trap' }, -- Blade (Vvardenfell -- Ancestral Adversity)
    [88454] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_blade.dds', name = 'Blade Trap' }, -- Blade (Vvardenfell -- Ancestral Adversity)
    [88455] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_wall_blade.dds', name = 'Blade Trap' }, -- Blade (Vvardenfell -- Ancestral Adversity)
    [87348] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser' }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [87349] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser' }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [87350] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser', unbreakable = 1 }, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [92150] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_dwarven_furnace.dds', name = 'Dwarven Furnace', hide = true }, -- Dwarven Furnace (Vvardenfell -- Divine Intervention)
    ]]--

    ----------------------------------------------------------------
    -- JUSTICE NPCS ------------------------------------------------
    ----------------------------------------------------------------

    [63153] = { hide = true }, -- Guard Immunities (Justice Guard)
    [63174] = { hide = true }, -- Guard Speed Boost (Justice Guard)
    [63148] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds', tooltip = A.Skill_Criminals_Bane }, -- Major Defile (Justice Guard)
    [63168] = { tooltip = T.Generic_Immobilize }, -- Cage Talons (Justice Guard 1H + 2H)
    [63095] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike.dds' }, -- Focused Strike (Justice Guard)
    [63157] = { icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash }, -- Heavy Blow (Justice Guard)
    [63268] = { icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash }, -- Uppercut (Justice Guard)
    [63160] = { icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash, tooltip = T.Generic_Stun }, -- Heavy Blow Knockdown (Justice Guard)
    [63094] = { tooltip = T.Generic_Stun }, -- Shield Charge (Justice Guard)
    [63261] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds' }, -- Heavy Blow (Justice Guard)
    [63265] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = A.Skill_Heavy_Blow }, -- Uppercut (Justice Guard)
    [63263] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = A.Skill_Heavy_Blow, tooltip = T.Generic_Stun }, -- Heavy Blow Knockdown (Justice Guard)
    [63093] = { name = A.Skill_Shield_Charge }, -- Charge (Justice Guard 1H)
    [63259] = { name = A.Skill_Mighty_Charge }, -- Charge (Justice Guard 2H)
    [63260] = { icon = 'esoui/art/icons/ability_2handed_003.dds', name = A.Skill_Mighty_Charge, tooltip = T.Generic_Stun }, -- Charge (Justice Guard 2H)
    [63198] = { name = A.Skill_Fiery_Grip }, -- Fiery Chain (Justice Guard)
    [63200] = { name = A.Skill_Fiery_Grip }, -- Firey Chain (Justice Guard)
    [64139] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_piercing_bolt.dds' }, -- Piercing Bolt (Justice Guard)
    [64267] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_shot.dds' }, -- Piercing Bolt (Justice Guard)
    [63911] = { hide = true }, -- Guard Stacking Damage
    [78804] = { hide = true }, -- Seek
    [78802] = { hide = true }, -- Seek
    [78760] = { hide = true }, -- Confusion
    [78764] = { hide = true }, -- Confusion
    [78775] = { hide = true }, -- Confusion
    [78767] = { hide = true }, -- Confusion
    [78768] = { hide = true }, -- Confusion
    [78769] = { hide = true }, -- Confusion
    [78770] = { hide = true }, -- Confusion
    [78766] = { hide = true }, -- Confusion
    [78772] = { hide = true }, -- Confusion
    [78771] = { hide = true }, -- Confusion
    [63179] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = A.Skill_Stonefist }, -- Flame Shard (Justice Guard 2H)
    [63194] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = A.Skill_Stonefist, tooltip = T.Generic_Stun }, -- Flame Shard (Justice Guard 2H)
    [78743] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds' }, -- Revealed (Guard)
    [78789] = { hide = true }, -- Flare (Guard)
    [78750] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds' }, -- Revealed (Guard)
    [78744] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flare_trap.dds' }, -- Flare (Guard)
    [75613] = { hide = true }, -- Shadowcloak Immunity (Mage Guard)
    [77919] = { hide = true }, -- Clairvoyance Tutorial (Mage Guard)
    [77937] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_detection.dds', name = A.Skill_Detection, tooltip = T.Generic_Detection_NPC }, -- Clairvoyance (Mage Guard)
    [77941] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1, groundLabel = true, tooltip = A.Skill_Detection }, -- Revealed (Mage Guard)
    [77917] = { hide = true }, -- Empower Weapon: Flame (Mage Guard)
    [74502] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike_staff.dds' }, -- Focused Strike (Mage Guard)
    [74503] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike_staff.dds' }, -- Focused Strike (Mage Guard)
    [74504] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_focused_strike_staff.dds' }, -- Focused Strike (Mage Guard)
    [74862] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_teleport_trap.dds' }, -- Teleport Trap (Mage Guard)
    [74870] = { hide = true }, -- Teleport Trap (Mage Guard)
    [74864] = { hide = true }, -- Teleport Trap (Mage Guard)
    [74863] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_teleport_trap.dds' }, -- Teleport Trap (Mage Guard)
    [74510] = { tooltip = T.Generic_Immobilize }, -- Encase
    [77449] = { hide = true }, -- Clairvoyance Tutorial (Mage Guard - Instanced)
    [72694] = { icon = 'LuiExtended/media/icons/abilities/ability_buff_detection.dds', name = A.Skill_Detection, tooltip = T.Generic_Detection_NPC }, -- Clairvoyance (Mage Guard - Instanced)
    [72695] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1, groundLabel = true, tooltip = A.Skill_Detection }, -- Revealed (Mage Guard - Instanced)
    [78060] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Skill_Detection }, -- Revealed (Mage Guard - Instanced)
    [75809] = { hide = true }, -- Guard Speed Boost (Mage Guard - Instanced)
    [64647] = { hide = true }, -- Remove Effects (Guard)
    [73226] = { hide = true }, -- Hurried Ward (DB Guard)
    [77452] = { hide = true }, -- Shadow Cloak Immunity (Basic Justice NPC)
    [78012] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Basic Justice NPC)
    [62472] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_stab.dds' }, -- Stab (Justice Rogue)
    [62506] = { icon = 'esoui/art/icons/ability_dualwield_deadlycloak.dds', name = A.Skill_Throw_Dagger, hide = true }, -- Thrown Dagger (Justice Rogue)
    [78013] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds', hide = true }, -- Quick Shot (Justice Archer)
    [62408] = { hide = true }, -- Bound Weapon (Justice Mage)
    [62409] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds' }, -- Fiery Wind (Justice Mage)
    [62502] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds' }, -- Fiery Wind (Justice Mage)
    [62407] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', hide = true }, -- Fiery Touch (Justice Mage)
    [63828] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Fiery Touch (Justice Mage)
    [61984] = { hide = true }, -- Invisibility Potion (Justice Mage)
    [78265] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_alarm.dds', hide = true }, -- Alarm (Estate Marshal - DB)
    [78266] = { hide = true }, -- Alarm (Estate Marshal - DB)
    [52471] = { icon = 'esoui/art/icons/ability_mage_036.dds', hide = true }, -- Nullify (Estate Spellbreaker - DB)
    [52473] = { icon = 'esoui/art/icons/ability_mage_036.dds', tooltip = T.Generic_Silence }, -- Nullify (Estate Spellbreaker - DB)
    [52474] = { icon = 'esoui/art/icons/ability_mage_036.dds', tooltip = T.Generic_Stun }, -- Nullify (Estate Spellbreaker - DB)
    [66669] = { hide = true }, -- Nullify (Estate Spellbreaker - DB)
    [73229] = { icon = 'esoui/art/icons/ability_mage_030.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Hurried Ward (Mage Guard - DB)

    ----------------------------------------------------------------
    -- NPC(Basic) --------------------------------------------------
    ----------------------------------------------------------------

    -- Shared NPC Passives
    [33097] = { icon = 'esoui/art/icons/achievement_wrothgar_007.dds', name = A.Skill_Boss_CC_Immunity, tooltip = T.Generic_Scary_Immunities }, -- Scary Immunities
    [44176] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_flying_immunities.dds', tooltip = T.Generic_Flying_Immunities }, -- Flying Immunities
    [13739] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_backstabber.dds', tooltip = T.Skill_Backstabber }, -- Backstabber
    [73768] = { hide = true }, -- GEN 5 Hits
    [79147] = { hide = true }, -- GEN 3 Hits
    [73916] = { hide = true }, -- GEN 2 Hits

    -- Shared NPC Active Events
    [8239] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_hamstrung.dds', name = A.Skill_Hamstring, tooltip = T.Generic_Snare_30 }, -- Hamstrung

    -- Standard NPC Abilities
    [2874] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger }, -- Staggered (Generic Stagger applied to player by many different NPC abilities)

    -- Critter events
    [79544] = { hide = true }, -- Mischievous Dodge (Nixad)
    [79555] = { hide = true }, -- Mischievous Dodge (Nixad)
    [40165] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = A.Innate_Block, duration = 0, tooltip = T.Innate_Block }, -- Scene Choreo Brace (Monster Fight)

    -- Friendly NPC Abilities
    [48330] = { hide = true }, -- Aspect of Terror (Abnur Tharn)
    [48331] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_aspect_of_terror_p.dds' }, -- Aspect of Terror (Abnur Tharn)
    [42905] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds' }, -- Recover
    [42937] = { hide = true }, -- TargetPriorityException

    [4197] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds', name = A.Skill_Recover, unbreakable = 1, tooltip = T.Skill_Recover_Duel }, -- Recovering
    [4198] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds', name = A.Skill_Recover }, -- PC Duel Heal

    -- Human NPC Abilities
    [18386] = { hide = true }, -- Run Away! (Used by various creatures)
    [10618] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Shared Human NPC)
    [12437] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds', hide = true }, -- Quick Shot (Shared Human NPC)
    [12456] = { icon = 'esoui/art/icons/ability_mage_009.dds', hide = true }, -- Ice Arrow (Shared Human NPC)
    [10639] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds', hide = true }, -- Flare (Shared Human NPC)
    [39058] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds' }, -- Bear Trap (Shared Human NPC)
    [39060] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Generic_Immobilize }, -- Bear Trap (Shared Human NPC)
    [39065] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds' }, -- Bear Trap (Shared Human NPC)
    [11039] = { hide = true }, -- Spread Out Sound (Synergy)
    [10650] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_oil_drenched.dds', tooltip = T.Generic_Snare_50_No_Dur, groundLabel = true }, -- Oil Drenched (Synergy)
    [12439] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds', name = A.Skill_Ignite }, -- Burning Arrow (Synergy - Archer)
    [14068] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds', groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, -- Ignite (Synergy - Archer)
    [10805] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds' }, -- Ignite (Synergy - Fire Mage)
    [10813] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds', groundLabel = true, tooltip = T.Generic_AOE_Fire_0_5_Sec }, -- Ignite (Synergy - Fire Mage)
    [38260] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds', groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, -- Ignite (Synergy - Fire Mage)
    [31385] = { hide = true }, -- Necromancer Synergy Move Back
    [31390] = { hide = true }, -- Necromancer Synergy Move Back
    [31387] = { hide = true }, -- Necromancer Snergy Kill Self
    [43757] = { hide = true }, -- Cultist Synergy Cast

    -- Footsoldier (1H)
    [14096] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Footsoldier)
    [28499] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds', hide = true }, -- Throw Dagger (Footsoldier)
    [28502] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds', tooltip = T.Skill_Throw_Dagger }, -- Throw Dagger (Footsoldier)
    [28504] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_throw_dagger.dds', hideReduce = true, tooltip = T.Skill_Throw_Dagger }, -- Throw Dagger (Footsoldier)

    -- Guard (1H + Shield)
    [29400] = { icon = 'esoui/art/icons/ability_1handed_005.dds' }, -- Power Bash (Guard)
    [29401] = { icon = 'esoui/art/icons/ability_1handed_005.dds', tooltip = T.Generic_Disorient }, -- Power Bash (Guard)
    [29402] = { icon = 'esoui/art/icons/ability_1handed_005.dds', hide = true, tooltip = T.Generic_Stagger }, -- Power Bash (Guard)
    [29761] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block.dds', name = A.Innate_Block, duration = 0, tooltip = T.Skill_Block_NPC }, -- Brace (Guard)
    [29762] = { hide = true }, -- Blocked Stack (Guard)
    [29757] = { hide = true }, -- Remove block (Guard)
    [29766] = { hide = true }, -- Blocked Stack (Guard)
    [29765] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, hide = true, tooltip = T.Generic_Stagger }, -- Uber Attack (Guard)
    [29767] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, tooltip = T.Generic_Stun }, -- Uber Attack (Guard)
    [84346] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, tooltip = T.Generic_Stun }, -- Uber Attack (Guard)

    -- Brute (1H + Shield)
    [34919] = { tooltip = T.Generic_Snare_60 }, -- Low Slash (Brute)
    [13701] = { icon = 'esoui/art/icons/ability_warrior_011.dds', name = A.Skill_Shield_Rush }, -- Focused Charge (Brute)
    [48542] = { hide = true }, -- Focused Charge (Brute)
    [14924] = { hide = true }, -- Focused Charge (Brute)
    [14925] = { icon = 'esoui/art/icons/ability_warrior_011.dds', name = A.Skill_Shield_Rush }, -- Charge (Brute)
    [14926] = { icon = 'esoui/art/icons/ability_warrior_011.dds', name = A.Skill_Shield_Rush, tooltip = T.Generic_Knockdown }, -- Charge (Brute)

    -- Ravager (2H)
    [29378] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing }, -- Uppercut (Ravager)
    [29379] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing, tooltip = T.Generic_Knockback }, -- Uppercut (Ravager)
    [29380] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing, hide = true }, -- Uppercut (Ravager)
    [29035] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Rogue/Skirmisher)
    [28408] = { icon = 'esoui/art/icons/ability_dualwield_005.dds' }, -- Whirlwind (Rogue/Skirmisher)
    [12381] = { icon = 'esoui/art/icons/ability_rogue_063.dds' }, -- Assassinate (Rogue/Skirmisher)
    [35164] = { hide = true }, -- Agony (Pointless projectile travel time aura)

    -- Berserker (Dual Wield)
    [76328] = { tooltip = T.Skill_Agony }, -- Agony (Berserker)
    [35165] = { tooltip = T.Generic_Magic_1_Sec }, -- Agony (Berserker)
    [10735] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds' }, -- Blood Craze (Berserker)
    [49252] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds' }, -- Blood Craze (Berserker)
    [49253] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds', tooltip = T.Skill_Blood_Craze_Heal }, -- Blood Craze (Berserker)
    [49254] = { icon = 'esoui/art/icons/ability_dualwield_001_b.dds', tooltip = T.Skill_Blood_Craze }, -- Blood Craze (Berserker)
    [44206] = { icon = 'esoui/art/icons/ability_debuff_minor_maim.dds', tooltip = A.Skill_Heated_Blades }, -- Minor Maim (Berserker)

    -- Dragonknight (NPC)
    [34742] = { icon = 'esoui/art/icons/ability_dragonknight_004.dds' }, -- Fiery Breath (Dragonknight)
    [34647] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = A.Skill_Off_Balance, tooltip = A.Skill_Lava_Whip }, -- Lava Whip (Dragonknight)
    [74472] = { icon = 'esoui/art/icons/ability_dragonknight_010.dds' }, -- Dark Talons (Dragonknight)
    [34706] = { tooltip = T.Generic_Immobilize }, -- Dark Talons (Dragonknight)
    [44227] = { icon = 'esoui/art/icons/ability_dragonknight_006.dds'}, -- Dragonknight Standard (Dragonknight - Elite)
    [44228] = { groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, -- Dragonknight Standard (Dragonknight - Elite)
    [44229] = { icon = 'esoui/art/icons/ability_debuff_major_defile.dds', duration = 0, groundLabel = true, tooltip = A.Skill_Dragonknight_Standard }, -- Major Defile (Dragonknight - Elite)
    [52041] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_blink_strike.dds' }, -- Blink Strike (Dragonknight  - Elite)
    [52045] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_blink_strike.dds' }, -- Blink Strike (Dragonknight  - Elite)
    [52051] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_blink_strike.dds', tooltip = T.Generic_Knockdown }, -- Blink Strike (Dragonknight  - Elite)

    -- Thundermaul
    [29510] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Thundermaul)
    [29511] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Thundermaul)
    [17867] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_aura.dds' }, -- Shock Aura (Thundermaul)
    [44407] = { tooltip = T.Skill_Lightning_Form }, -- Lightning Form (Thundermaul)
    [44408] = { icon = 'esoui/art/icons/ability_sorcerer_lightning_form.dds' }, -- Lightning Form (Thundermaul -- Boss)
    [81219] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_ranged.dds', hide = true }, -- Shock (Thundermaul -- Boss)
    [81215] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_blast.dds', name = A.Skill_Shock_Blast }, -- Shock Aura (Thundermaul -- Boss)
    [77906] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, tooltip = T.Generic_Knockback }, -- Stun (Thundermaul -- Boss)
    [81193] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_bolt.dds', hide = true }, -- Agonizing Strike (Thundermaul -- Boss)
    [81195] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_snare.dds'}, -- Agonizing Fury (Thundermaul -- Boss)
    [81196] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_snare.dds', displayStacks = true, maxStacks = 5, stack = 1, tooltip = T.Skill_Agonizing_Fury }, -- Agonizing Fury (Thundermaul -- Boss)
    [81197] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_shock_snare.dds'}, -- Agonizing Fury (Thundermaul -- Boss)
    [81217] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Thundermaul -- Boss)
    [81218] = { icon = 'LuiExtended/media/icons/abilities/ability_sorcerer_thunder_hammer.dds' }, -- Thunder Hammer (Thundermaul -- Boss)

    -- Nightblade (NPC)
    [73712] = { hide = true }, -- Shadow Cloak (Nightblade NPC) (Pointless .5 second aura applied on player)
    [73713] = { icon = 'esoui/art/icons/ability_nightblade_004.dds' }, -- Shadow Cloak (Nightblade)
    [36471] = { icon = 'esoui/art/icons/ability_nightblade_002.dds', tooltip = T.Generic_Stun }, -- Veiled Strike (Nightblade)
    [63822] = { icon = 'esoui/art/icons/ability_nightblade_008.dds', tooltip = T.Generic_Stun }, -- Teleport Strike (Nightblade)
    [44345] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds', hide = true }, -- Soul Tether (Nightblade - Elite)
    [44349] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds' }, -- Soul Tether (Nightblade - Elite)
    [44352] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds', hideReduce = true, tooltip = T.Skill_Soul_Tether_NPC }, -- Soul Tether (Nightblade - Elite)
    [44350] = { icon = 'esoui/art/icons/ability_nightblade_018_a.dds', tooltip = T.Skill_Soul_Tether_NPC }, -- Soul Tether (Nightblade - Elite)
    [53462] = { icon = 'esoui/art/icons/ability_nightblade_003.dds', tooltip = T.Skill_Siphoning_Strikes_NPC }, -- Siphoning Strikes (Nightblade - Elite)

    -- Archer
    [37109] = { icon = 'esoui/art/icons/ability_bow_005.dds', tooltip = T.Generic_Snare_75 }, -- Arrow Spray (Archer)
    [28628] = { icon = 'esoui/art/icons/ability_bow_003.dds' }, -- Volley (Archer)
    [28629] = { groundLabel = true, tooltip = T.Generic_AOE_Physical_0_5_Sec }, -- Volley (Archer)
    [74978] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_taking_aim.dds', hide = true }, -- Taking Aim (Archer)
    [74980] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_taking_aim.dds' }, -- Taking Aim (Archer)

    -- Pet Ranger
    [89460] = { hide = true }, -- Set Area (Pet Ranger)
    [36499] = { hide = true }, -- Roll Dodge (Pet Ranger)
    [44301] = { icon = 'esoui/art/icons/ability_fightersguild_004_b.dds', name = A.Skill_Lightweight_Beast_Trap }, -- Trap Beast (Pet Ranger)
    [44305] = { icon = 'esoui/art/icons/ability_fightersguild_004_b.dds', name = A.Skill_Lightweight_Beast_Trap, tooltip = T.Generic_Immobilize }, -- Trap Beast (Pet Ranger)
    [44307] = { icon = 'esoui/art/icons/ability_fightersguild_004_b.dds', name = A.Skill_Lightweight_Beast_Trap }, -- Trap Beast (Pet Ranger)
    [88251] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally.dds', tooltip = T.Skill_Call_Ally }, -- Call Ally (Pet Ranger)
    [88248] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_durzog.dds', tooltip = T.Skill_Call_Ally }, -- Call Ally (Pet Ranger)
    [89425] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_call_ally_kwama.dds', tooltip = T.Skill_Call_Ally }, -- Call Ally (Pet Ranger)
    [88275] = { hide = true }, -- Call Ally (Pet Ranger)
    [88265] = { hide = true }, -- Call Ally (Pet Ranger)
    [88288] = { hide = true }, -- Call Ally (Pet Ranger)
    [88268] = { hide = true }, -- Call Ally (Pet Ranger)
    [88281] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Skill_Weakness_NPC_Summon }, -- Call Ally (Pet Ranger)
    [88227] = { hide = true }, -- Call Ally (Pet Ranger)
    [88252] = { hide = true }, -- Call Ally (Pet Ranger)

    -- Fire Mage
    [15164] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds'}, -- Heat Wave (Fire Mage)
    [16588] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds', hide = true }, -- Heat Wave (Fire Mage)
    [47095] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_rune.dds' }, -- Fire Rune (Fire Mage)
    [47102] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_rune.dds', groundLabel = true, tooltip = T.Generic_AOE_Fire_0_9_Sec }, -- Fire Rune (Fire Mage)
    [14524] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_ranged.dds', hide = true }, -- Shock (Storm Mage)
    [29471] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_thunder_thrall.dds' }, -- Thunder Thrall (Storm Mage)
    [29470] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_thunder_thrall.dds' }, -- Thunder Thrall (Storm Mage)
    [29472] = { hide = true }, -- Thunder Thrall (Storm Mage) (self snare shows as buff)
    [12459] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Frost Mage)
    [12460] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Frost Mage)
    [14550] = { icon = 'esoui/art/icons/ability_mage_037.dds', tooltip = T.Generic_Immobilize }, -- Winter's Reach (Frost Mage)
    [14194] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_barrier.dds', tooltip = T.Skill_Ice_Barrier }, -- Ice Barrier (Frost Mage)
    [7145] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_barrier.dds', name = A.Proc_Chill, stack = 0, tooltip = T.Generic_Snare_20 }, -- Ice Barrier (Frost Mage)

    [35151] = { icon = 'esoui/art/icons/ability_mage_064.dds', tooltip = T.Skill_Spell_Absorption }, -- Spell Absorption (Spirit Mage)
    [14472] = { icon = 'esoui/art/icons/ability_mage_004.dds', tooltip = T.Skill_Burdening_Eye }, -- Burdening Eye (Spirit Mage)
    [37200] = { icon = 'esoui/art/icons/ability_mage_004.dds' }, -- Burden (Spirit Mage)
    [35142] = { icon = 'esoui/art/icons/ability_mage_004.dds', tooltip = T.Generic_Snare_80 }, -- Burden (Spirit Mage)
    [89057] = { hide = true }, -- Burdening Eye (Spirit Mage)
    [89042] = { hide = true }, -- Burdening Eye (Spirit Mage)
    [14477] = { hide = true }, -- Burdening (Spirit Mage)
    [35149] = { hide = true }, -- Burdening Eye (Spirit Mage)
    [37150] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Flare (Battlemage)
    [37028] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds', name = A.Skill_Staff_Strike }, -- Quick Strike (Battlemage)
    [37029] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds', name = A.Skill_Staff_Strike }, -- Quick Strike (Battlemage)
    [37030] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds', name = A.Skill_Staff_Strike }, -- Quick Strike (Battlemage)
    [37021] = { hide = true }, -- Empower Weapon: Flame (Battlemage)
    [37087] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Battlemage)
    [37156] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Battlemage)
    [37129] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds' }, -- Ice Cage (Battlemage)
    [37131] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds', groundLabel = true, tooltip = T.Skill_Ice_Cage }, -- Ice Cage (Battlemage)
    [37132] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_ice_cage.dds', duration = 0, groundLabel = true, tooltip = T.Skill_Ice_Cage, hideGround = true }, -- Ice Cage (Battlemage)
    [44216] = { icon = 'esoui/art/icons/ability_sorcerer_monsoon.dds' }, -- Negate Magic (Battlemage)
    [50108] = { icon = 'esoui/art/icons/ability_sorcerer_monsoon.dds', duration = 0, tooltip = T.Generic_Silence_No_Dur, groundLabel = true }, -- Negate Magic (Battlemage)
    [50107] = { icon = 'esoui/art/icons/ability_sorcerer_monsoon.dds', duration = 0, tooltip = T.Generic_Stun_No_Dur, groundLabel = true }, -- Negate Magic (Battlemage)
    [37126] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_ranged.dds' }, -- Entropic Flare (Timb Bomb Mage)
    [36986] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_aoe.dds' }, -- Void (Time Bomb Mage)
    [14370] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_aoe.dds' }, -- Void (Time Bomb Mage)
    [56828] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_fright_force_p.dds', hide = true }, -- Fright Force (Fear Mage)
    [14350] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_aspect_of_terror_p.dds', hide = true }, -- Aspect of Terror (Fear Mage)
    [37084] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_aspect_of_terror_p.dds', tooltip = T.Generic_Fear }, -- Aspect of Terror (Fear Mage)
    [35865] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_vanish.dds', name = A.Skill_Vanish, tooltip = T.Generic_Disorient }, -- Shadow Cloak (Fear Mage)
    [44247] = { hide = true }, -- Dark Shade (Dreadweaver)
    [89005] = { hide = true }, -- Dark Shade (Dreadweaver)
    [89006] = { hide = true }, -- Dark Shade (Dreadweaver)
    [89008] = { hide = true }, -- Dark Shade (Dreadweaver)
    [39729] = { hide = true }, -- TargetPriorityException (Dreadweaver)
    [44250] = { hide = true, icon = 'esoui/art/icons/ability_nightblade_001.dds', name = A.Skill_Summon_Shade }, -- Dark Shade (Dreadweaver)
    [89017] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -23, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Skill_Weakness_NPC_Summon }, -- Dark Shade (Dreadweaver)
    [89010] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_corrode.dds' }, -- Corrode (Dreadweaver)
    [89012] = { icon = 'esoui/art/icons/ability_debuff_minor_maim.dds', tooltip = A.Skill_Corrode }, -- Minor Maim (Dreadweaver)
    [44323] = { icon = 'esoui/art/icons/ability_armor_003_a.dds', tooltip = T.Skill_Dampen_Magic }, -- Dampen Magic (Soulbrander)
    [44258] = { icon = 'esoui/art/icons/ability_mageguild_002.dds', name = A.Skill_Magelight, tooltip = T.Skill_Radiant_Magelight_NPC }, -- Radiant Magelight (Soulbrander)
    [44263] = { hide = true }, -- Radiant Magelight (Soulbrander)
    [44259] = { icon = 'esoui/art/icons/ability_mageguild_002.dds', hide = true }, -- Magelight (Soulbrander)
    [29372] = { icon = 'esoui/art/icons/ability_mage_027.dds', hide = true }, -- Necrotic Spear (Necromancer)
    [88554] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_the_dead.dds', tooltip = T.Skill_Summon_the_Dead }, -- Summon the Dead (Necromancer)
    [88555] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_the_dead.dds', tooltip = T.Skill_Summon_the_Dead }, -- Summon the Dead (Necromancer)
    [88561] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Skill_Weakness_NPC_Summon }, -- Summon the Dead (Necromancer)
    [13397] = { icon = 'esoui/art/icons/achievement_update15_030.dds' }, -- Empower Undead (Necromancer)
    [31848] = { hide = true }, -- Summon the Dead (Necromancer)
    [88582] = { hide = true }, -- Summon the Dead (Necromancer)
    [88583] = { hide = true }, -- Summon the Dead (Necromancer)
    [88599] = { hide = true }, -- Summon the Dead (Necromancer)
    [88590] = { hide = true }, -- Summon the Dead (Necromancer)
    [88591] = { hide = true }, -- Summon the Dead (Necromancer)
    [88592] = { hide = true }, -- Summon the Dead (Necromancer)
    [88586] = { hide = true }, -- Summon the Dead (Necromancer)
    [88589] = { hide = true }, -- Summon the Dead (Necromancer)
    [88600] = { hide = true }, -- Summon the Dead (Necromancer)
    [88602] = { hide = true }, -- Summon the Dead (Necromancer)
    [88618] = { hide = true }, -- Summon the Dead (Necromancer)
    [88611] = { hide = true }, -- Summon the Dead (Necromancer)
    [88607] = { hide = true }, -- Summon the Dead (Necromancer)
    [88613] = { hide = true }, -- Summon the Dead (Necromancer)
    [88621] = { hide = true }, -- Summon the Dead (Necromancer)
    [88615] = { hide = true }, -- Summon the Dead (Necromancer)
    [88610] = { hide = true }, -- Summon the Dead (Necromancer)
    [88608] = { hide = true }, -- Summon the Dead (Necromancer)
    [88614] = { hide = true }, -- Summon the Dead (Necromancer)
    [88622] = { hide = true }, -- Summon the Dead (Necromancer)
    [88616] = { hide = true }, -- Summon the Dead (Necromancer)
    [88626] = { hide = true }, -- Summon the Dead (Necromancer)
    [88627] = { hide = true }, -- Summon the Dead (Necromancer)
    [88601] = { hide = true }, -- Summon the Dead (Necromancer)
    [88593] = { hide = true }, -- Summon the Dead (Necromancer)
    [88617] = { hide = true }, -- Summon the Dead (Necromancer)
    [88596] = { hide = true }, -- Summon the Dead (Necromancer)
    [88566] = { hide = true }, -- Summon the Dead (Necromancer)
    [88597] = { hide = true }, -- Summon the Dead (Necromancer)
    [88598] = { hide = true }, -- Summon the Dead (Necromancer)
    [7590] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_entropic_bolt.dds' }, -- Entropic Bolt (Bonelord)
    [35387] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds' }, -- Bone Cage (Bonelord)
    [88322] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds' }, -- Bone Cage (Bonelord)
    [35391] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_cage.dds', name = A.Skill_Bone_Cage, tooltip = T.Generic_Immobilize }, -- Defiled Grave (Bonelord)
    [88504] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Summon Abomination (Bonelord)
    [88506] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_abomination_flesh.dds' }, -- Summon Abomination (Bonelord)
    [88507] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_abomination_flesh.dds' }, -- Summon Abomination (Bonelord)
    [44339] = { icon = 'esoui/art/icons/ability_undaunted_005a.dds' }, -- Bone Surge (Bonelord)
    [10601] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_minor_wound.dds', hide = true }, -- Minor Wound (Healer)
    [57534] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds', tooltip = T.Skill_Focused_Healing }, -- Focused Healing (Healer)
    [57537] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds' }, -- Focused Healing (Healer)
    [57538] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds' }, -- Focused Healing (Healer)
    [50966] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_healer_immune.dds', name = A.Skill_Defensive_Ward, tooltip = T.Skill_Defensive_Ward }, -- Healer Immune (Healer)
    [50931] = { hide = true }, -- Healer Immune (Healer)
    [50975] = { hide = true }, -- Healer Immune (Healer)
    [50998] = { hide = true }, -- Rite of Passage (Healer)
    [44328] = { icon = 'esoui/art/icons/ability_templar_rite_of_passage.dds', hide = true }, -- Rite of Passage (Healer)
    [44329] = { icon = 'esoui/art/icons/ability_templar_rite_of_passage.dds', duration = 0, tooltip = T.Skill_Rite_of_Passage_NPC }, -- Rite of Passage (Healer)
    [29669] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_coiled_lash.dds', hide = true }, -- Coiled Lash (Shaman)
    [29520] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_aura_of_protection.dds', tooltip = T.Skill_Aura_of_Protection }, -- Aura of Protection (Shaman)
    [29521] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_aura_of_protection.dds', tooltip = T.Skill_Aura_of_Protection_Other }, -- Aura of Protection (Shaman)
    [29597] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Generic_Stun }, -- Combustion (Shaman)
    [65314] = { hide = true }, -- Aura of Protection (Shaman)
    [65432] = { hide = true }, -- Aura of Protection (Shaman)
    [83073] = { hide = true }, -- Summon Died (Shaman)
    [68866] = { icon = 'esoui/art/icons/ability_ava_003.dds', tooltip = T.Skill_War_Horn_NPC }, -- Warhorn (Faction NPCs)
    [68867] = { hide = true }, -- War Horn Battlecry (Faction NPC)
    [68868] = { hide = true }, -- War Horn Battlecry (Faction NPC)
    [68869] = { hide = true }, -- War Horn Battlecry (Faction NPC)
    [43644] = { hide = true, icon = 'esoui/art/icons/ability_ava_001.dds', name = A.Skill_Caltrops }, -- Barrier [monster synergy]  (Faction NPCs)
    [43645] = { hide = true, icon = 'esoui/art/icons/ability_ava_001.dds', name = A.Skill_Caltrops }, -- Barrier [monster synergy]  (Faction NPCs)
    [43646] = { hide = true, icon = 'esoui/art/icons/ability_ava_001.dds', name = A.Skill_Caltrops }, -- Barrier [monster synergy]  (Faction NPCs)
    [38119] = { icon = 'esoui/art/icons/ability_ava_001.dds', duration = 0, groundLabel = true, tooltip = T.Skill_Caltrops_NPC, hideGround = true }, -- Caltrops  (Faction NPCs)
    [38125] = { icon = 'esoui/art/icons/ability_ava_001.dds', groundLabel = true, tooltip = T.Skill_Caltrops_NPC }, -- Caltrops  (Faction NPCs)
    [65033] = { icon = 'esoui/art/icons/ability_warrior_014.dds', hide = true }, -- Retaliation (Winterborn Warrior)
    [69158] = { icon = 'esoui/art/icons/ability_warrior_014.dds', tooltip = T.Skill_Retaliation_NPC }, -- Retaliation (Winterborn Warrior)
    [67114] = { icon = 'esoui/art/icons/ability_warrior_014.dds' }, -- Retaliation (Winterborn Warrior)
    [69157] = { icon = 'esoui/art/icons/ability_warrior_014.dds', hide = true, tooltip = T.Generic_Stagger }, -- Retaliation (Winterborn Warrior)
    [69153] = { icon = 'esoui/art/icons/ability_warrior_014.dds', tooltip = T.Generic_Stun }, -- Retaliation (Winterborn Warrior)
    [1347] = { icon = 'esoui/art/icons/ability_debuff_offbalance.dds', name = A.Skill_Off_Balance, tooltip = A.Skill_Retaliation }, -- Off-Balance (Winterborn Warrior)
    [70070] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds', name = A.Skill_Heavy_Attack }, -- Heavy Strike (Winterborn Warrior)
    [64980] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_javelin.dds', hide = true }, -- Javelin (Winterborn Warrior)
    [14883] = { icon = 'esoui/art/icons/achievement_030.dds', name = A.Skill_Off_Balace_Immunity, tooltip = T.Generic_Off_Balance_Immunity }, -- Off-Balance (Winterborn Warrior)
    [69282] = { hide = true }, -- Roll Dodge Back (Winterborn Warrior)
    [54593] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Flare (Winterborn Mage)
    [55909] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds' }, -- Grasping Vines (Winterborn Mage)
    [55911] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds', hideReduce = true, tooltip = T.Skill_Grasping_Vines }, -- Grasping Vines (Winterborn Mage)
    [55918] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds', tooltip = T.Skill_Grasping_Vines }, -- Grasping Vines (Winterborn Mage)
    [55916] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vineburst.dds' }, -- Grasping Vineburst (Winterborn Mage)
    [64704] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds', hide = true }, -- Flames (Winterborn Mage)
    [64711] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_flames.dds', hide = true }, -- Flames (Winterborn Mage)
    [54184] = { hide = true }, -- Revenge 2 (Vosh Rakh Devoted)
    [54397] = { hide = true }, -- Rally (Vosh Rakh Devoted)
    [53987] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_inspire.dds', name = A.Skill_Inspire, tooltip = T.Skill_Inspire }, -- Rally (Vosh Rakh Devoted)
    [65235] = { icon = 'esoui/art/icons/ability_warrior_025.dds', tooltip = T.Skill_Enrage_Devoted }, -- Enrage (Vosh Rakh Devoted)
    [54027] = { icon = 'esoui/art/icons/ability_warrior_032.dds' }, -- Divine Leap (Vosh Rakh Devoted)
    [67272] = { hide = true }, -- Invisible No Target (Vosh Rakh Devoted)
    [54028] = { icon = 'esoui/art/icons/ability_warrior_032.dds' }, -- Divine Leap (Vosh Rakh Devoted)
    [67593] = { icon = 'esoui/art/icons/ability_warrior_032.dds', name = A.Skill_Divine_Leap, hide = true }, -- Divine Leap Stagger (Vosh Rakh Devoted)
    [54050] = { icon = 'esoui/art/icons/ability_warrior_032.dds', name = A.Skill_Divine_Leap, hide = true, tooltip = T.Generic_Stun }, -- Divine Leap Stun (Vosh Rakh Devoted)

    -- Dremora Caitiff (Craglorn)
    [51000] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_cleave_stance.dds', tooltip = T.Skill_Cleave_Stance }, -- Cleave Stance (Dremora Caitiff)
    [51923] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = A.Skill_Great_Cleave }, -- Cleave Stance (Dremora Caitiff)
    [51940] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = A.Skill_Great_Cleave }, -- Cleave Stance (Dremora Caitiff)
    [51942] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = A.Skill_Great_Cleave }, -- Cleave Stance (Dremora Caitiff)

    -- Sentinel (TG DLC)
    [74487] = { tooltip = T.Generic_Snare_60 }, -- Low Slash (Sentinel) (TG DLC)
    [74480] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', hide = true }, -- Fiery Grip (Sentinel) (TG DLC)
    [74483] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', tooltip = T.Generic_Stun }, -- Fiery Grip (Sentinel) (TG DLC)
    [72725] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage, tooltip = T.Skill_Enraged_Sentinel }, -- Fool Me Once (Sentinel) (TG DLC)
    [72723] = { hide = true }, -- Fool Me Once (Sentinel) (TG DLC)
    [77468] = { hide = true }, -- Fool Me Once (Sentinel) (TG DLC)

    -- Archer (TG DLC)
    [74630] = { hide = true }, -- Flare Trap Proxy (Archer) (TG DLC)
    [72716] = { icon = 'esoui/art/icons/ability_rogue_015.dds', tooltip = T.Skill_Uncanny_Dodge }, -- Uncanny Dodge (Archer) (TG DLC)
    [72719] = { hide = true }, -- Uncanny Dodge SUC REM (Archer) (TG DLC)
    [72214] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_poisoned_arrow.dds' }, -- Poisoned Arrow (Archer) (TG DLC)
    [72217] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_poisoned_arrow.dds', tooltip = T.Generic_Poison_1_Sec }, -- Poisoned Arrow (Archer) (TG DLC)
    [72222] = { icon = 'esoui/art/icons/ability_rogue_067.dds', name = A.Skill_Hide_in_Shadows, tooltip = T.Generic_Invisibility }, -- Shadow Cloak (Archer) (TG DLC)
    [76089] = { icon = 'esoui/art/icons/ability_bow_001.dds', hide = true }, -- Snipe (Archer) (TG DLC)
    [72220] = { icon = 'esoui/art/icons/ability_bow_001.dds', hide = true }, -- Snipe (Archer) (TG DLC)
    [74619] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_flare_trap.dds', hide = true }, -- Flare Trap (Archer) (TG DLC)
    [74621] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = A.Skill_Flare_Trap }, -- Revealed (Archer) (TG DLC)
    [74618] = { hide = true }, -- Flare Trap
    [74627] = { hide = true }, -- Flare Trap
    [74620] = { hide = true }, -- Flare Trap REM

    -- Bodyguard (DB DLC)
    [77472] = { icon = 'esoui/art/icons/ability_warrior_030.dds', tooltip = T.Skill_Til_Death }, -- 'Til Death (Bodyguard) (DB DLC)
    [79523] = { icon = 'esoui/art/icons/ability_warrior_030.dds', tooltip = T.Skill_Til_Death_Self }, -- 'Til Death (Bodyguard) (DB DLC)
    [77554] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77555] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', duration = 863700, tooltip = T.Skill_Shard_Shield }, -- Shard Shield (Bodyguard) (DB DLC)
    [77562] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77609] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_shard_shield.dds', tooltip = T.Generic_Stun }, -- Shard Shield (Bodyguard) (DB DLC)
    [77473] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Bodyguard) (DB DLC)
    [77815] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Bodyguard) (DB DLC)
    [77927] = { name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Staggered (Bodyguard) (DB DLC)
    [77474] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sentry.dds', tooltip = T.Skill_Dutiful_Fury }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77475] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77476] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77477] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage, tooltip = T.Skill_Dutiful_Fury_Proc }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77489] = { hide = true }, -- Dutiful Fury (Bodyguard) (DB DLC)
    [77748] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [77778] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [77765] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [77750] = { hide = true }, -- 'Til Death (Bodyguard) (DB DLC)
    [79534] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [83620] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [83624] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77838] = { hide = true }, -- Shield Charge (Bodyguard) (DB DLC)
    [77602] = { hide = true }, -- Shard Shield (Bodyguard) (DB DLC)
    [77672] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds', name = A.Skill_Recover, tooltip = T.Generic_Immunity }, -- 'Til Death (Bodyguard) (DB DLC)
    [77742] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds', name = A.Skill_Recover, tooltip = T.Generic_Immunity }, -- 'Til Death (Bodyguard) (DB DLC)

    -- Cyrodiil
    [47717] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Cyrodiil Guard T1)
    [46221] = { tooltip = T.Skill_Puncture_Cyrodiil }, -- Puncture (Cyrodiil Guard T1 & T2)
    [46830] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds' }, -- Bleeding Strike (Cyrodiil Guard T2)
    [46832] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', name = A.Skill_Bleeding_Strike, tooltip = T.Generic_Bleed_1_Sec }, -- Bleeding (Cyrodiil Guard T2)
    [46831] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', name = A.Skill_Bleeding_Strike }, -- Bleeding (Cyrodiil Guard T2)
    [46834] = { icon = 'esoui/art/icons/ability_1handed_005.dds' }, -- Power Bash (Cyrodiil Guard T2)
    [72639] = { icon = 'esoui/art/icons/ability_1handed_005.dds', hide = true, tooltip = T.Generic_Stagger }, -- Power Bash (Cyrodiil Guard T2)
    [72641] = { icon = 'esoui/art/icons/ability_1handed_005.dds', tooltip = T.Skill_Power_Bash_Cyrodiil }, -- Power Bash (Cyrodiil Guard T2)
    [74087] = { tooltip = T.Generic_Disorient }, -- Power Bash (Cyrodiil Guard T2)
    [36304] = { tooltip = T.Skill_Razor_Armor }, -- Razor Armor (Cyrodiil Guard T2)
    [36306] = { hide = true }, -- Razor Armor (Cyrodiil Guard T2)
    [36305] = { name = A.Skill_Razor_Armor }, -- Spike Armor Damage Return (Cyrodiil Guard T2)
    [7880] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', name = A.Skill_Shock_Torrent, hide = true }, -- Light Attack (Cyrodiil Mage T1)
    [46336] = { name = A.Skill_Crystal_Shard, tooltip = T.Generic_Stun }, -- Crystal Shard Stun (Cyrodiil Mage T1)
    [7883] = { groundLabel = true, tooltip = T.Generic_AOE_Shock_1_Sec }, -- Guardian Storm
    [21629] = { icon = 'esoui/art/icons/ability_mage_008.dds' }, -- Mage's Lifesteal (Cyrodiil Mage T1)
    [46711] = { hide = true }, -- Bound Aegis (Cyrodiil Mage T2)
    [46726] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', name = A.Skill_Improved_Shock_Torrent, hide = true }, -- Shock Torrent (Cyrodiil Mage T2)
    [46730] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_torrent.dds', name = A.Skill_Improved_Shock_Torrent, tooltip = T.Generic_Shock_1_Sec }, -- Shock Torrent (Cyrodiil Mage T2)
    [46819] = { icon = 'esoui/art/icons/ability_mage_068.dds', name = A.Skill_Lasting_Storm, groundLabel = true, tooltip = T.Generic_AOE_Shock_1_Sec }, -- Storm Damage (Cyrodiil Mage T2)
    [46704] = { icon = 'esoui/art/icons/ability_sorcerer_thunder_burst.dds' }, -- Crystal Blast (Cyrodiil Mage T2)
    [46705] = { icon = 'esoui/art/icons/ability_sorcerer_thunder_burst.dds' }, -- Crystal Blast (Cyrodiil Mage T2)
    [46706] = { icon = 'esoui/art/icons/ability_sorcerer_thunder_burst.dds', name = A.Skill_Crystal_Blast, tooltip = T.Generic_Stun }, -- Crystal Shard Stun (Cyrodiil Mage T2)
    [46716] = { icon = 'esoui/art/icons/ability_mage_008.dds', name = A.Skill_Steal_Essence }, -- Stolen Essence (Cyrodiil Mage T2)
    [46719] = { hide = true }, -- Stolen Essence (Cryodiil Mage T2) (Pointless aura)
    [52806] = { tooltip = T.Skill_Unstable_Core_Cyrodiil }, -- Unstable Core (Cyrodiil Mage T2)
    [75397] = { hide = true }, -- Unstable Core (Cryodiil Mage T2) (Pointless aura)
    [75395] = { hide = true }, -- Reflected FX (Cryodiil Mage T2) (Pointless aura)
    [57962] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_minor_wound.dds', hide = true }, -- Minor Wound (Cyrodiil Mender T1)
    [46272] = { duration = 0, groundLabel = true, tooltip = T.Generic_Damage_Shield_No_Duration }, -- Rune Focus (Cyrodiil Mender T1)
    [21638] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_telekinetic_disorient.dds', name = A.Skill_Telekinetic_Prison, tooltip = T.Generic_Disorient }, -- Telekinetic Disorient (Cyrodiil Mender T1)
    [46839] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_minor_wound.dds', hide = true }, -- Major Wound (Cyrodiil Mender T2)
    [46904] = { icon = 'esoui/art/icons/ability_templar_rune_focus.dds', duration = 0, groundLabel = true, tooltip = T.Generic_Damage_Shield_No_Duration }, -- Rune Focus (Cyrodiil Mender T2)
    [46906] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_telekinetic_disorient.dds', name = A.Skill_Shattering_Prison, tooltip = T.Skill_Shattering_Prison_Cyrodiil }, -- Telekinetic Disorient (Cyrodiil Mender T2)
    [46910] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_telekinetic_disorient.dds' }, -- Shattering Prison (Cyrodiil Mender T2)
    [52862] = { hide = true }, -- Health Boon (Cyrodiil Mender T2)
    [22469] = { hide = true }, -- Siege Shield (Cyrodiil Mender T1 + T2)
    [22489] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_healer_immune.dds', name = A.Skill_Siege_Barrier, tooltip = T.Skill_Siege_Shield_Cyrodiil }, -- Siege Bubble (Cyrodiil Mender T1 + T2)
    [51893] = { icon = 'esoui/art/icons/ability_sorcerer_monsoon.dds', duration = 0, tooltip = T.Generic_Stun_No_Dur, groundLabel = true }, -- Negate Magic (Cyrodiil Mender T1 + T2)
    [51894] = { duration = 0, tooltip = T.Generic_Silence_No_Dur, groundLabel = true }, -- Negate Magic (Cyrodiil Mender T1 + T2)
    [52864] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds' }, -- Quick Shot (Cyrodiil Archer T1 + T2)
    [52866] = { groundLabel = true, tooltip = T.Generic_AOE_Physical_0_5_Sec }, -- Volley (Cyrodiil Archer T1)
    [54258] = { name = A.Skill_Improved_Volley, groundLabel = true, tooltip = T.Generic_AOE_Physical_0_5_Sec }, -- Upgraded Volley (Cyrodiil Archer T2)
    [54264] = { icon = 'esoui/art/icons/ability_bow_001_a.dds', hide = true }, -- Lethal Arrow (Cryodiil Archer T2)
    [54265] = { icon = 'esoui/art/icons/ability_bow_001_a.dds', tooltip = T.Skill_Lethal_Arrow_Cyrodiil }, -- Lethal Arrow (Cryodiil Archer T2)
    [54259] = { icon = 'esoui/art/icons/ability_bow_004_a.dds', hide = true }, -- Draining Shot (Cryodiil Archer T2)
    [54261] = { icon = 'esoui/art/icons/ability_bow_004_a.dds', tooltip = T.Generic_Snare_50 }, -- Draining Shot (Cryodiil Archer T2)
    [70414] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_ignite.dds', tooltip = T.Generic_AOE_Fire_0_5_Sec, groundLabel = true }, -- Ignite (Synergy - Fire Mage)
    [16510] = { name = A.Skill_Fire_Torrent, hide = true }, -- Fire Salvo (Cyrodiil Honor Guard T1)
    [15780] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_aoe_alt.dds' }, -- Honor Guard Rage (Cyrodiil Honor Guard T1)
    [32446] = { icon = 'esoui/art/icons/ability_dragonknight_011.dds', name = A.Skill_Dragon_Blood, tooltip = T.Generic_Health_Recovery }, -- Guardian Heal (Cyrodiil Honor Guard T1)
    [35113] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', hide = true }, -- Extended Chains (Cyrodiil Honor Guard T1)
    [35115] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = A.Skill_Extended_Chains, hide = true, tooltip = T.Generic_Stun }, -- Pull (Cyrodiil Honor Guard T1)
    [46992] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_snare_shock.dds' }, -- Crippling Rage (Cyrodiil Honor Guard T2)
    [47001] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_snare_shock.dds', tooltip = T.Generic_Snare_50 }, -- Crippling Rage (Cyrodiil Honor Guard T2)
    [47004] = { icon = 'esoui/art/icons/ability_dragonknight_011.dds', name = A.Skill_Dragon_Blood, tooltip = T.Generic_Health_Recovery }, -- Guardian Heal (Cyrodiil Honor Guard T2)
    [47019] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', hide = true }, -- Puncturing Chains (Cyrodiil Honor Guard T2)
    [47023] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = A.Skill_Puncturing_Chains, tooltip = T.Skill_Puncturing_Chains }, -- Puncture (Cyrodiil Honor Guard T2)
    [47020] = { icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = A.Skill_Puncturing_Chains, hide = true, tooltip = T.Generic_Stun }, -- Pull (Cyrodiil Honor Guard T2)
    [15783] = { icon = 'esoui/art/icons/ability_warrior_022.dds' }, -- Triple Strike (Cyrodiil Honor Guard T1 + T2)
    [15782] = { icon = 'esoui/art/icons/ability_warrior_022.dds' }, -- Triple Strike (Cyrodiil Honor Guard T1 + T2)
    [46990] = { hide = true }, -- Improved Fire Torrent (Cyrodiil Honor Guard T2)
    [46991] = { icon = 'esoui/art/icons/ability_mage_011.dds', name = A.Skill_Improved_Fire_Torrent, tooltip = T.Generic_Burn_1_Sec }, -- Fire Torrent Burning (Cryodiil Honor Guard T2)

    -- Animals
    [5451] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_bite.dds' }, -- Bite (Alit)
    [5452] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds' }, -- Lacerate (Alit)
    [84356] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds' }, -- Lacerate (Alit)
    [56984] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds', name = A.Skill_Lacerate, tooltip = T.Generic_Bleed_1_Sec }, -- Laceration (Alit)
    [56983] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_lacerate.dds', name = A.Skill_Lacerate }, -- Laceration (Alit)
    [4413] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds', name = A.Skill_Bite }, -- Swipe (Bear)
    [4415] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Crushing Swipe (Bear)
    [38772] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Crushing Swipe (Bear)
    [18273] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', tooltip = T.Generic_Knockdown }, -- Crushing Swipe (Bear)
    [4416] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds' }, -- Savage Blows (Bear)
    [12380] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds' }, -- Savage Blows (Bear)
    [61594] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_savage_blows.dds', name = A.Skill_Savage_Blows, tooltip = T.Generic_Bleed_1_Sec }, -- Savage Blows Bleeding (Bear)
    [70355] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_bite.dds' }, -- Bite (Great Bear)
    [70357] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds' }, -- Lunge (Great Bear)
    [70359] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_lunge.dds' }, -- Lunge (Great Bear)
    [70366] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Slam (Great Bear)
    [89189] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds' }, -- Slam (Great Bear)
    [69073] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', name = A.Skill_Slam, tooltip = T.Generic_Knockdown }, -- Knockdown (Great Bear)
    [70374] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_ferocity.dds', tooltip = T.Skill_Ferocity }, -- Ferocity (Great Bear)
    [70372] = { hide = true }, -- Ferocity (Great Bear)
    [70376] = { hide = true }, -- Ferocity (Great Bear)
    [70375] = { hide = true }, -- Ferocity (Great Bear)

    -- Crocodile
    [4583] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds' }, -- Bite (Crocodile)
    [9642] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_bite.dds' }, -- Bite (Crocodile)
    [4587] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_crushing_chomp.dds' }, -- Crushing Chomp (Crocodile)
    [4591] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_sweep.dds' }, -- Sweep (Crocodile)
    [32051] = { icon = 'LuiExtended/media/icons/abilities/ability_crocodile_sweep.dds' }, -- Sweep (Crocodile)
    [4594] = { icon= 'LuiExtended/media/icons/abilities/ability_crocodile_ancient_skin.dds', tooltip = T.Skill_Ancient_Skin }, -- Ancient Skin (Crocodile)

    -- Duneripper
    [8971] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }, -- Bite (Duneripper)
    [9643] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_bite.dds' }, -- Bite (Duneripper)
    [8972] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_crushing_chomp.dds' }, -- Crushing Chomp (Duneripper)
    [8977] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds' }, -- Sweep (Duneripper)
    [32461] = { icon = 'LuiExtended/media/icons/abilities/ability_duneripper_sweep.dds' }, -- Sweep (Duneripper)

    -- Durzog
    [7214] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_bite.dds' }, -- Bite (Durzog)
    [7221] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rend.dds' }, -- Rend (Durzog)
    [7227] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rotbone.dds', name = A.Skill_Rip_and_Tear },-- Rotbone (Durzog)
    [16878] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rotbone.dds', name = A.Skill_Rip_and_Tear, tooltip = T.Generic_Bleed_1_Sec }, -- Rotbone (Durzog)

    -- Dreugh
    [6304] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_swipe.dds' }, -- Swipe (Dreugh)
    [18002] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }, -- Slash (Dreugh)
    [18003] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }, -- Slash (Dreugh)
    [18005] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_slash.dds' }, -- Slash (Dreugh)
    [6308] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_touch.dds' }, -- Shocking Touch (Dreugh)
    [6328] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }, -- Shocking Rake (Dreugh)
    [27100] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }, -- Shocking Rake (Dreugh)

    -- Echatere
    [54374] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_tusks.dds' }, -- Tusks (Echatere)
    [54375] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_shockwave.dds' }, -- Shockwave (Echatere)
    [54378] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_shockwave.dds' }, -- Shockwave (Echatere)
    [68971] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger }, -- Staggered (Echatere - Shockwave)
    [54380] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds' }, -- Headbutt (Echatere)
    [54382] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds' }, -- Headbutt (Echatere)
    [54381] = { icon = 'LuiExtended/media/icons/abilities/ability_echatere_headbutt.dds', tooltip = T.Generic_Knockdown }, -- Headbutt (Echatere)

    -- Giant Bat
    [60920] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_scrape.dds' }, -- Scrape (Giant Bat)
    [4632] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds' }, -- Screech (Giant Bat)
    [47321] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds' }, -- Screech (Giant Bat)
    [18319] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_screech.dds', tooltip = T.Generic_Stun }, -- Screech (Giant Bat)
    [4630] = { icon = 'LuiExtended/media/icons/abilities/ability_bat_draining_bite.dds', tooltip = T.Generic_Bleed_0_2_Sec }, -- Draining Bite (Giant Bat)

    -- Giant Snake
    [8540] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_strike.dds' }, -- Strike (Giant Snake)
    [5240] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_lash.dds' }, -- Lash (Giant Snake)
    [30214] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_lash.dds' }, -- Lash (Giant Snake)
    [5242] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_kiss_of_poison.dds' }, -- Kiss of Poison (Giant Snake)
    [21826] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_kiss_of_poison.dds', tooltip = T.Generic_Poison_0_5_Sec }, -- Kiss of Poison (Giant Snake)
    [5244] = { icon = 'LuiExtended/media/icons/abilities/ability_snake_shed_skin.dds', tooltip = T.Skill_Regeneration_Ogrim }, -- Shed Skin (Giant Snake)

    -- Guar
    [5440] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_bite.dds' }, -- Bite (Guar)
    [5443] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_headbutt.dds' }, -- Headbutt (Guar)
    [5441] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_dive.dds' }, -- Dive (Guar)
    [84359] = { icon = 'LuiExtended/media/icons/abilities/ability_guar_dive.dds' }, -- Dive (Guar)
    [5363] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_chomp.dds' }, -- Chomp (Kagouti)
    [5926] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds' }, -- Toss (Kagouti)
    [42889] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds' }, -- Toss (Kagouti)
    [42888] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds', hide = true }, -- Toss (Kagouti)
    [18198] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_toss.dds', tooltip = T.Generic_Knockback }, -- Toss (Kagouti)
    [14202] = { hide = true }, -- Charge (Kagouti)
    [14196] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds', name = A.Skill_Rush, hide = true }, -- Charge (Kagouti)
    [14819] = { hide = true }, -- Charge (Kagouti)
    [14825] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds', name = A.Skill_Rush }, -- Charge (Kagouti)
    [14828] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_charge.dds', name = A.Skill_Rush, tooltip = T.Generic_Knockdown }, -- Charge (Kagouti)
    [14829] = { hide = true }, -- Charge (Kagouti)
    [18751] = { hide = true }, -- Charge (Kagouti)
    [87310] = { hide = true }, -- Run Away! (Kagouti Whelp)
    [87312] = { hide = true }, -- Run Away! (Kagouti Whelp)
    [87276] = { icon = 'LuiExtended/media/icons/abilities/ability_kagouti_chomp.dds' }, -- Chomp (Kagouti Whelp)
    [7170] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
    [60630] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_rend.dds' }, -- Rend (Lion)
    [60641] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_claw.dds' }, -- Claw (Lion)
    [7158] = { icon = 'LuiExtended/media/icons/abilities/ability_lioness_bite.dds' }, -- Bite (Lion)
    [7161] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_double_strike.dds' }, -- Double Strike (Lion)
    [8705] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', tooltip = T.Skill_Weakness_Lion }, -- Weakness (Lion)
    [8601] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_mammoth_vigorous_swipes.dds', name = A.Skill_Vigorus_Swipes }, -- Vigorous Swipe (Mammoth)
    [75633] = { hide = true }, -- Vigorous Swipe (Mammoth)
    [75634] = { hide = true }, -- Vigorous Swipes (Mammoth)
    [8596] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_swipe.dds' }, -- Swipe (Mammoth)
    [8604] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_vigorous_swipes.dds', name = A.Skill_Vigorus_Swipes }, -- Vigorous Swipe (Mammoth)
    [8600] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_stomp.dds' }, -- Stomp (Mammoth)
    [23164] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_stomp.dds' }, -- Stomp (Mammoth)
    [23230] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', name = A.Skill_Stampede }, -- Charge (Mammoth)
    [48551] = { hide = true}, -- Focused Charge (Mammoth)
    [23222] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', name = A.Skill_Stampede }, -- Charge (Mammoth)
    [23227] = { icon = 'LuiExtended/media/icons/abilities/ability_mammoth_charge.dds', name = A.Skill_Stampede, tooltip = T.Generic_Knockdown }, -- Charge (Mammoth)
    [23225] = { hide = true }, -- Charge (Mammoth) (Pointless aura that does nothing)
    [4192] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_pincer.dds' }, -- Pincer (Mudcrab)
    [4224] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_double_claw_strike.dds' }, -- Double Claw Strike (Mudcrab)
    [4226] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_double_claw_strike.dds' }, -- Double Claw Strike (Mudcrab)
    [4200] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_unforgiving_claws.dds' }, -- Unforgiving Claws (Mudcrab)
    [85082] = { icon = 'LuiExtended/media/icons/abilities/ability_mudcrab_unforgiving_claws.dds' }, -- Unforgiving Claws (Mudcrab)
    [42841] = { hide = true }, -- Scuttle (Mudcrab)
    [16667] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_slap.dds' }, -- Slap (Netch)
    [16690] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_thrust.dds' }, -- Thrust (Netch)
    [16697] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_poisonbloom.dds' }, -- Poisonbloom (Netch)
    [16698] = { icon = 'LuiExtended/media/icons/abilities/ability_netch_poisonbloom.dds', groundLabel = true, tooltip = T.Generic_AOE_Poison_1_Sec }, -- Poisonbloom (Netch)
    [7266] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_strike.dds' }, -- Strike (Nix-Hound)
    [13416] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_strike.dds' }, -- Strike (Nix-Hound)
    [7268] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_leech.dds' }, -- Leech (Nix-Hound)
    [12303] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_leech.dds' }, -- Leech (Nix-Hound)
    [18344] = { hide = true }, -- Leech (Nix-Hound)
    [7273] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds' }, -- Dampworm (Nix-Hound)
    [38635] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds' }, -- Dampworm (Nix-Hound)
    [38640] = { icon = 'LuiExtended/media/icons/abilities/ability_nix-hound_dampworm.dds', tooltip = T.Generic_Snare_45 }, -- Dampworm (Nix-Hound)
    [5362] = { icon = 'LuiExtended/media/icons/abilities/ability_skeever_slam.dds' }, -- Slam (Skeever)
    [21904] = { icon = 'LuiExtended/media/icons/abilities/ability_skeever_rend.dds' }, -- Rend (Skeever)
    [21947] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_bite.dds' }, -- Bite (Wamasu)
    [21949] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }, -- Sweep (Wamasu)
    [46833] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds' }, -- Sweep (Wamasu)
    [37178] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_sweep.dds', tooltip = T.Generic_Knockdown }, -- Sweep (Wamasu)
    [21951] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds', hide = true }, -- Repulsion Shock (Wamasu)
    [21952] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_repulsion_shock.dds' }, -- Repulsion Shock (Wamasu)
    [22045] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_static.dds', tooltip = T.Skill_Wamasu_Static }, -- Static (Wamasu)
    [21957] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', name = A.Skill_Barreling_Charge }, -- Charge (Wamasu)
    [48556] = { hide = true }, -- Focused Charge (Wamasu)
    [21961] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', name = A.Skill_Barreling_Charge }, -- Charge (Wamasu)
    [21967] = { icon = 'LuiExtended/media/icons/abilities/ability_wamasu_charge.dds', name = A.Skill_Barreling_Charge, tooltip = T.Generic_Knockdown }, -- Charge (Wamasu)
    [21963] = { hide = true }, -- Charge (Wamasu) (Pointless aura that does nothing)
    [44781] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_swipe.dds', name = A.Skill_Bite }, -- Swipe (Welwa)
    [45937] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_cleave.dds', name = A.Skill_Swipe }, -- Cleave (Welwa)
    [44791] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_rear_kick.dds' }, -- Rear Kick (Welwa)
    [44792] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_rear_kick.dds' }, -- Rear Kick (Welwa)
    [50714] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = A.Skill_Blitz }, -- Charge (Welwa)
    [45986] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = A.Skill_Blitz }, -- Charge (Welwa)
    [45991] = { icon = 'LuiExtended/media/icons/abilities/ability_welwa_charge.dds', name = A.Skill_Blitz, tooltip = T.Generic_Knockdown }, -- Charge (Welwa)
    [45984] = { hide = true }, -- Charge (Welwa)
    [4022] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_bite.dds' }, -- Bite (Wolf)
    [42844] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_rotbone.dds' }, -- Rotbone (Wolf)
    [14523] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds', tooltip = T.Generic_Immobilize }, -- Helljoint (Wolf)
    [75818] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds' }, -- Helljoint (Wolf)
    [14272] = { hide = true, icon = 'esoui/art/icons/mh_second_wolf.dds' }, -- Call of the Pack (Wolf)
    [14273] = { hide = true }, -- Call of the Pack (Wolf)
    [26658] = { hide = true, icon = 'esoui/art/icons/achievement_thievesguild_043.dds' }, -- Call of the Pack (Jackal)
    [26659] = { hide = true }, -- Call of the Pack (Jackal)
    [72803] = { icon = 'esoui/art/icons/achievement_summerset_boss_006.dds', tooltip = T.Skill_Hardened_Shell }, -- Hardened Shell (Haj Mota)
    [74123] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_claw.dds' }, -- Claw (Haj Mota)
    [72787] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_horn_strike.dds' }, -- Horn Strike (Haj Mota)
    [73481] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_horn_strike.dds' }, -- Horn Strike (Haj Mota)
    [74272] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bite.dds', hide = true }, -- Bite (Haj Mota)
    [76578] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bite.dds', tooltip = T.Generic_Poison_1_Sec }, -- Bite (Haj Mota)
    [72793] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', hide = true }, -- Toxic Mucus (Haj Mota)
    [76577] = { hide = true }, -- Toxic Mucous (Haj Mota)
    [72815] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_slime_alt.dds', name = A.Skill_Toxic_Mucus, tooltip = T.Generic_Snare_40 }, -- Toxic Mucous (Haj Mota)
    [72794] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_gtaoe.dds', hide = true, groundLabel = true, tooltip = T.Generic_AOE_Poison_0_66_Sec }, -- Toxic Pool (Haj Mota)
    [72796] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds', hide = true}, -- Bog Burst (Haj Mota)
    [72799] = { hide = true }, -- Bog Burst (Haj Mota)
    [76183] = { hide = true }, -- Bog Burst (Haj Mota)
    [72800] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds'}, -- Bog Burst (Haj Mota)
    [74336] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds', tooltip = T.Generic_Knockback }, -- Bog Burst (Haj Mota)
    [74337] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds'}, -- Bog Burst (Haj Mota)
    [76184] = { hide = true }, -- Bog Burst (Haj Mota)
    [72789] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Shockwave (Haj Mota)
    [73494] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds', hide = true }, -- Shockwave (Haj Mota)
    [76319] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_backstabber.dds', name = A.Skill_Backstabber, tooltip = T.Skill_Backstabber }, -- Backstabber (Dire Wolf)
    [80382] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_bite.dds' }, -- Bite (Dire Wolf)
    [80383] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_bite.dds' }, -- Bite (Dire Wolf)
    [76307] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge.dds' }, -- Lunge (Dire Wolf)
    [76308] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_lunge.dds', tooltip = T.Generic_Bleed_1_Sec }, -- Lunge (Dire Wolf)
    [76303] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_nip.dds' }, -- Nip (Dire Wolf)
    [76304] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_nip.dds', tooltip = T.Generic_Bleed_2_Sec }, -- Nip (Dire Wolf)
    [76305] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }, -- Gnash (Dire Wolf)
    [76306] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_gnash.dds' }, -- Gnash (Dire Wolf)
    [85656] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_harry.dds', tooltip = T.Generic_Snare_60 }, -- Harry (Dire Wolf)
    [76312] = { hide = true }, -- Harry (Dire Wolf)
    [76324] = { icon = 'LuiExtended/media/icons/abilities/ability_direwolf_baleful_call.dds', tooltip = T.Skill_Baleful_Call }, -- Baleful Call (Dire Wolf)
    [76322] = { hide = true }, -- Baleful Call (Dire Wolf)
    [85200] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_scythe.dds' }, -- Scythe (Nix-Ox)
    [85198] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_snap.dds' }, -- Snap (Nix-Ox)
    [85201] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_gore.dds', name = A.Skill_Gore }, -- Bite (Nix-Ox)
    [85202] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_gore.dds' }, -- Gore (Nix-Ox)
    [85084] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_shriek.dds', hide = true }, -- Shriek (Nix-Ox)
    [85085] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_shriek.dds', hide = true }, -- Shriek (Nix-Ox)
    [90765] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds', hide = true }, -- Acid Spray (Nix-Ox)
    [90776] = { hide = true }, -- Acid Spray (Nix-Ox)
    [90780] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds' }, -- Acid Spray (Nix-Ox)
    [90778] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_gtaoe.dds', hide = true, tooltip = T.Generic_AOE_Poison_0_5_Sec, groundLabel = true }, -- Acid Pool (Nix-Ox)
    [90809] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds', hide = true }, -- Acid Spray (Nix-Ox)
    [90811] = { hide = true }, -- Acid Spray (Nix-Ox)
    [90812] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_acid_spray.dds' }, -- Acid Spray (Nix-Ox)
    [90815] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_gtaoe.dds', hide = true, tooltip = T.Generic_AOE_Poison_0_5_Sec, groundLabel = true }, -- Acid Pool (Nix-Ox)
    [85172] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds' }, -- Winnow (Nix-Ox)
    [85175] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds' }, -- Winnow (Nix-Ox)
    [85186] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds', tooltip = T.Generic_Knockback }, -- Winnow (Nix-Ox)
    [85173] = { icon = 'LuiExtended/media/icons/abilities/ability_nixox_winnow.dds' }, -- Winnow (Nix-Ox)
    [85203] = { icon = 'esoui/art/icons/ability_warrior_025.dds', hide = true, name = A.Skill_Enrage }, -- Nix-Call (Nix-Ox)
    [95389] = { hide = true }, -- Nix-Call (Nix-Ox)
    [90187] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage, tooltip = T.Skill_Enrage_Nix_Ox }, -- Nix-Call (Nix-Ox)
    [90190] = { hide = true }, -- Nix-Call (Nix-Ox)
    [89940] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', name = A.Skill_Bile_Spit }, -- Turret (Nix Hound)
    [85387] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_snap.dds' }, -- Snap (Cliff Strider)
    [85388] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_stab.dds' }, -- Stab (Cliff Strider)
    [93516] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_tail_lash.dds' }, -- Tail Lash (Cliff Strider)
    [85395] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds' }, -- Dive (Cliff Strider)
    [92085] = { hide = true }, -- Dive (Cliff Strider)
    [85398] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds' }, -- Dive (Cliff Strider)
    [90319] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds', tooltip = T.Generic_Knockback }, -- Dive (Cliff Strider)
    [90320] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_dive.dds' }, -- Dive (Cliff Strider)
    [85399] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_retch.dds' }, -- Retch (Cliff Strider)
    [85420] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_retch.dds' }, -- Retch (Cliff Strider)
    [85421] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_retch_aoe.dds', groundLabel = true, tooltip = T.Generic_AOE_Poison_0_5_Sec }, -- Retch (Cliff Strider)
    [85448] = { hide = true }, -- Frenzied Feast (Cliff Strider)
    [85390] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds', hide = true}, -- Slash (Cliff Strider Matriach)
    [85391] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }, -- Slash (Cliff Strider Matriach)
    [85394] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds', tooltip = T.Skill_Slash_Cliff_Strider }, -- Slash (Cliff Strider Matriach)
    [85392] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds', hideReduce = true, tooltip = T.Skill_Slash_Cliff_Strider }, -- Slash (Cliff Strider Matriach)
    [85393] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds' }, -- Slash (Cliff Strider Matriach)

    -- Daedra
    [51256] = { hide = true }, -- Siphon (Atronach Passive)
    [31115] = { icon = 'esoui/art/icons/achievement_089.dds', name = A.Skill_Summon_Daedric_Arch }, -- Summon Dark Anchor (Daedric Synergy)
    [59129] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity, tooltip = T.Generic_CC_Immunity }, -- Generic Status Immune (Daedric Synergy)
    [94481] = { hide = true }, -- Summon Dark Anchor (Daedric Synergy)
    [68453] = { hide = true }, -- Explosive Charge (Daedric Synergy)
    [68449] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds' }, -- Explosive Charge (Daedric Synergy)
    [68452] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds' }, -- Explosive Charge (Daedric Synergy)
    [48092] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds' }, -- Swipe (Air Atronach)
    [48093] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_swipe.dds' }, -- Swipe (Air Atronach)
    [48096] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flare.dds' }, -- Flare (Air Atronach)
    [48121] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_heavy_attack.dds' }, -- Heavy Attack (Air Atronach)
    [48137] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_tornado.dds' }, -- Tornado (Air Atronach)
    [51269] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_frost.dds', name = A.Skill_Empower_Atronach_Frost, tooltip = T.Skill_Empower_Atronach_Frost, hide = true }, -- Air Atronach Flame  (Air Atronach - Frost)
    [51267] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_frost.dds', name = A.Skill_Empower_Atronach_Frost, tooltip = T.Skill_Empower_Atronach_Frost }, -- Air Atronach Flame (Air Atronach - Frost)
    [50021] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_ice_vortex.dds' }, -- Ice Vortex (Air Atronach - Frost)
    [50022] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_ice_vortex.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Generic_Snare_70 }, -- Ice Vortex (Air Atronach - Frost)
    [51262] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_flame.dds', name = A.Skill_Empower_Atronach_Flame, hide = true }, -- Air Atronach Flame (Air Atronach - Flame)
    [51265] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_flame.dds', name = A.Skill_Empower_Atronach_Flame, tooltip = T.Skill_Empower_Atronach_Flame }, -- Air Atronach Flame (Air Atronach - Flame)
    [51281] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_tornado.dds' }, -- Flame Tornado (Air Atronach)
    [51282] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_flame_tornado.dds' }, -- Flame Tornado (Air Atronach)
    [51271] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_storm.dds', name = A.Skill_Empower_Atronach_Storm, tooltip = T.Skill_Empower_Atronach_Storm, hide = true }, -- Air Atronach Flame (Air Atronach - Storm)
    [51270] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_empower_storm.dds', name = A.Skill_Empower_Atronach_Storm, tooltip = T.Skill_Empower_Atronach_Storm }, -- Air Atronach Flame (Air Atronach - Storm)
    [50023] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds', tooltip = T.Skill_Lightning_Rod }, -- Lightning Rod (Air Atronach)
    [88902] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds' }, -- Lightning Rod (Air Atronach)
    [50026] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Lightning Rod (Air Atronach)

    [9743] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_entropic_touch.dds' }, -- Entropic Touch (Banekin)
    [9747] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_dire_wound.dds' }, -- Dire Wound (Banekin)
    [9748] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds' }, -- Envelop (Banekin)
    [9749] = { icon = 'LuiExtended/media/icons/abilities/ability_banekin_envelop.dds', groundLabel = true, tooltip = T.Generic_AOE_Magic_1_Sec }, -- Envelop (Banekin)
    [4798] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_headbutt.dds' }, -- Headbutt (Clannfear)
    [4799] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_spike.dds' }, -- Tail Spike (Clannfear)
    [84443] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_spike.dds' }, -- Tail Spike (Clannfear)
    [93745] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Clannfear)
    [93750] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Clannfear)
    [93748] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds', name = A.Skill_Rending_Leap, tooltip = T.Generic_Knockdown }, -- Rending Leap Ranged (Clannfear)
    [91395] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds', type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Skill_Devour_Clannfear }, -- Devour (Clannfear)
    [91398] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds' }, -- Devour (Clannfear)
    [26551] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_strike.dds' }, -- Strike (Daedric Titan)
    [32852] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_ranged.dds' }, -- Scourge Bolt (Daedric Titan)
    [26641] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_soul_flame.dds' }, -- Soul Flame (Daedric Titan)
    [32696] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_soul_flame.dds' }, -- Soul Flame (Daedric Titan)
    [35280] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_soul_flame.dds', tooltip = T.Generic_Stun }, -- Soul Flame (Daedric Titan)
    [73437] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_gtaoe.dds', tooltip = T.Skill_Soul_Flame, groundLabel = true }, -- Soul Flame (Daedric Titan)
    [35278] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_gtaoe.dds', tooltip = T.Skill_Soul_Flame, hideGround = true, duration = 0, groundLabel = true }, -- Soul Flame (Daedric Titan)
    [26554] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds', tooltip = T.Generic_Knockback }, -- Wing Gust (Daedric Titan)
    [33085] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds', tooltip = T.Generic_Snare }, -- Wing Gust (Daedric Titan)
    [33086] = { icon = 'LuiExtended/media/icons/abilities/ability_daedrictitan_wing_gust.dds' }, -- Wing Gust (Daedric Titan)
    [4750] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_jagged_claw.dds' }, -- Jagged Claw (Daedroth)
    [4778] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds' }, -- Fiery Jaws (Daedroth)
    [4771] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds', hide = true }, -- Fiery Breath (Daedroth)
    [4772] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds', hide = true }, -- Fiery Breath (Daedroth)
    [91946] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_ground_tremor.dds', hide = true }, -- Ground Tremor (Daedroth)
    [91953] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_ground_tremor.dds' }, -- Ground Tremor (Daedroth)
    [91949] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds', tooltip = T.Generic_Snare_50 }, -- Ground Tremor (Daedroth)
    [91937] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds' }, -- Burst of Embers (Daedroth)
    [91941] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds', hide = true }, -- Burst of Embers (Daedroth)
    [91940] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds', hide = true }, -- Burst of Embers (Daedroth)
    [91943] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_burst_of_embers.dds', tooltip = T.Generic_Knockback }, -- Burst of Embers (Daedroth)
    [91938] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_gtaoe.dds', groundLabel = true, tooltip = T.Generic_AOE_Fire_0_5_Sec }, -- Burst of Embers (Daedroth)
    [18471] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [18472] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [15157] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [12254] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds' }, -- Flare (Flame Atronach)
    [26324] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_lava_geyser.dds' }, -- Lava Geyser (Flame Atronach)
    [26325] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_lava_geyser.dds' }, -- Lava Geyser (Flame Atronach)
    [4891] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_radiance.dds', tooltip = T.Skill_Radiance }, -- Radiance (Flame Atronach)
    [4491] = { icon = 'LuiExtended/media/icons/abilities/ability_flameatronach_radiance.dds' }, -- Radiance (Flame Atronach)
    [50216] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_aoe.dds' }, -- Combustion (Flame Atronach)
    [50215] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_aoe.dds' }, -- Combustion (Flame Atronach)
    [67870] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_tremor.dds', name = A.Skill_Tremor }, -- Tremor AOE (Flesh Colossus)
    [67123] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_tremor.dds' }, -- Tremor (Flesh Colossus)
    [67636] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_falling_debris.dds' }, -- Falling Debris (Flesh Colossus)
    [66869] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds' }, -- Pin (Flesh Colossus)
    [65709] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds' }, -- Pin (Flesh Colossus)
    [49820] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_pin.dds', name = A.Skill_Pin, tooltip = T.Generic_Knockdown }, -- Stunned (Flesh Colossus)
    [65735] = { hide = true }, -- Miasma Channel (Flesh Colossus)
    [53233] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_disease_gtaoe.dds', groundLabel = true, tooltip = T.Generic_AOE_Disease_0_5_Sec }, -- Miasma Pool (Flesh Colossus)
    [67872] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds', hide = true }, -- Sweep (Flesh Colossus)
    [68824] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds', tooltip = T.Generic_Knockback }, -- Sweep (Flesh Colossus)
    [68813] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_sweep.dds', name = A.Skill_Sweep }, -- Sweep Knockback (Flesh Colossus)
    [68826] = { name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Staggered (Flesh Colossus - Block Sweep)
    [67842] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds', hide = true }, -- Sweep Shockwave (Flesh Colossus)
    [76129] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_stumble_forward.dds' }, -- Stumble Forward (Flesh Colossus)
    [76134] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Stumble Forward (Flesh Colossus)
    [65755] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Staggered (Flesh Colossus)
    [76133] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Stumble Forward (Flesh Colossus)
    [49430] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_smash.dds' }, -- Smash (Flesh Colossus)
    [49429] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_claw.dds' }, -- Claw (Flesh Colossus)
    [76128] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76139] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshcolossus_stumble_forward.dds', hide = true }, -- Stumble Forward (Flesh Colossus)
    [76140] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76130] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76131] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76143] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [79001] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76145] = { hide = true }, -- Stumble Forward (Flesh Colossus)
    [76146] = { hide = true }, -- Stumble Forward (Flesh Colossus) (Buff on Player)
    [67772] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage, hide = true }, -- Enraged (Flesh Colossus)
    [63275] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_claw.dds' }, -- Claw (Flesh Atronach)
    [63276] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_stomp.dds' }, -- Stomp (Flesh Atronach)
    [4829] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_fire_brand.dds' }, -- Fire Brand (Flesh Atronach)
    [35413] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_fire_brand.dds' }, -- Fire Brand (Flesh Atronach)
    [4817] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds' }, -- Unyielding Mace (Flesh Atronach)
    [20226] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', hideReduce = true, name = A.Skill_Unyielding_Mace, tooltip = T.Skill_Unyielding_Mace }, -- Stun (Flesh Atronach)
    [27326] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', hideReduce = true, tooltip = T.Skill_Unyielding_Mace }, -- Unyielding Mace (Flesh Atronach)
    [23077] = { icon = 'LuiExtended/media/icons/abilities/ability_fleshatronach_unyielding_mace.dds', name = A.Skill_Unyielding_Mace, tooltip = T.Skill_Unyielding_Mace }, -- Bleeding (Flesh Atronach)
    [17069] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_ice_spear.dds' }, -- Ice Spear (Frost Atronach)
    [5009] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_ice_shards.dds' }, -- Ice Shards (Frost Atronach)
    [33549] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_chilling_aura.dds', tooltip = T.Skill_Chilling_Aura }, -- Chilling Aura (Frost Atronach)
    [33551] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_chilling_aura.dds', internalStack = 0, tooltip = T.Generic_Snare_20_No_Dur, groundLabel = true }, -- Chilling Aura (Frost Atronach)
    [5017] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds' }, -- Hoarfrost Fist (Frost Atronach)
    [44906] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds' }, -- Hoarfrost Fist (Frost Atronach)
    [44907] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds', hide = true }, -- Hoarfrost Fist (Frost Atronach)
    [44908] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_hoarfrost_fist.dds', tooltip = T.Generic_Knockback }, -- Hoarfrost Fist (Frost Atronach)
    [33502] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds' }, -- Frozen Ground (Frost Atronach)
    [51645] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds', groundLabel = true, tooltip = T.Skill_Frozen_Ground }, -- Frozen Ground (Frost Atronach)
    [51646] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds', internalStack = 0, hide = true, groundLabel = true, tooltip = T.Skill_Frozen_Ground, hideGround = true }, -- Frozen Ground (Frost Atronach)
    [65926] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_slash.dds' }, -- Slash (Grevious Twilight)
    [65845] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_rend.dds' }, -- Rend (Grevious Twilight)
    [66643] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_rend.dds' }, -- Rend (Grevious Twilight)
    [50596] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shadow_bolt.dds' }, -- Shadow Bolt (Grevious Twilight)
    [50626] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }, -- Shadow Strike (Grevious Twilight)
    [50628] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }, -- Shadow Strike (Grevious Twilight)
    [65889] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }, -- Shadow Strike (Grevious Twilight)
    [65891] = { icon = 'LuiExtended/media/icons/abilities/ability_grevioustwilight_shadow_strike.dds' }, -- Shadow Strike (Grevious Twilight)
    [11076] = { icon = 'esoui/art/icons/ability_mage_029.dds', hide = true }, -- Chasten (Harvester)
    [11079] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_black_winter.dds', hide = true }, -- Black Winter (Harvester)
    [26008] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_black_winter.dds', hide = true }, -- Black Winter (Harvester)
    [74794] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger }, -- Black Winter (Harvester)
    [11083] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_the_feast.dds' }, -- The Feast (Harvester)
    [26110] = { icon = 'LuiExtended/media/icons/abilities/ability_harvester_the_feast.dds', tooltip = T.Generic_Levitate }, -- The Feast (Harvester)
    [26017] = { hide = true }, -- Creeping Doom (The Feast)
    [26018] = { hide = true }, -- Creeping Doom (The Feast)
    [88070] = { hide = true }, -- Creeping Doom (The Feast)
    [8204] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_strike.dds' }, -- Strike (Ogrim)
    [8205] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_regeneration.dds', tooltip = T.Skill_Regeneration_Ogrim }, -- Regeneration (Ogrim)
    [24690] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds' }, -- Body Slam (Ogrim)
    [48553] = { hide = true },  -- Focused Charge (Ogrim)
    [24693] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', hide = true }, -- Body Slam (Ogrim)
    [24700] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', tooltip = T.Generic_Knockdown }, -- Body Slam (Ogrim)
    [91848] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }, -- Stomp (Ogrim)
    [91850] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }, -- Stomp (Ogrim)
    [91851] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds', tooltip = T.Generic_Snare_35 }, -- Stomp (Ogrim)
    [91855] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Ogrim)
    [91874] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Ogrim)
    [91871] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds', tooltip = T.Generic_Knockdown }, -- Boulder Toss (Ogrim)
    [6158] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_ranged.dds' }, -- Flare (Scamp)
    [6166] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds' }, -- Heat Wave (Scamp)
    [6167] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds' }, -- Heat Wave (Scamp)
    [6160] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_rain_of_fire.dds' }, -- Rain of Fire (Scamp)
    [6162] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_rain_of_fire.dds', groundLabel = true, tooltip = T.Generic_AOE_Fire_1_Sec }, -- Rain of Fire (Scamp)
    [8778] = { icon = 'LuiExtended/media/icons/abilities/ability_spiderdaedra_strike.dds' }, -- Strike (Spider Daedra)
    [8808] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds', hide = true }, -- Spit (Spider Daedra)
    [8779] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Spider Daedra)
    [38658] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_onslaught.dds' }, -- Lightning Onslaught (Spider Daedra)
    [8773] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_spiderling.dds', tooltip = T.Skill_Summon_Spiderling }, -- Summon Spiderling (Spider Daedra)
    [89303] = { hide = true }, -- Summon Spiderling (Spider Daedra)
    [89301] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Skill_Weakness_NPC_Summon }, -- Summon Spiderling (Spider Daedra)
    [89306] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds' }, -- Web (Spider Daedra - Spiderling)
    [89307] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', duration = 0, groundLabel = true, tooltip = T.Generic_Snare_60_No_Dur }, -- Web (Spider Daedra - Spiderling)
    [8782] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_storm.dds' }, -- Lightning Storm (Spider Daedra)
    [20530] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_lightning_storm.dds' }, -- Lightning Storm (Spider Daedra)
    [4858] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_bash.dds' }, -- Bash (Storm Atronach)
    [13898] = { icon = 'LuiExtended/media/icons/abilities/ability_stormatronach_strike.dds' }, -- Strike (Storm Atronach)
    [35220] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_impending_storm.dds' }, -- Impending Storm (Storm Atronach)
    [35222] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_impending_storm.dds' }, -- Impending Storm (Storm Atronach)
    [4864] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)
    [35240] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)
    [12287] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds', tooltip = T.Skill_Storm_Bound }, -- Storm Bound (Storm Atronach)
    [12288] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds', hideReduce = true, tooltip = T.Skill_Storm_Bound }, -- Storm Bound (Storm Atronach)
    [12286] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds' }, -- Storm Bound (Storm Atronach)
    [7095] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Xivilai)
    [83072] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_freezing_edge.dds', tooltip = T.Generic_Snare_40 }, -- Freezing Edge (Xivilai)
    [49203] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_root_frost.dds', tooltip = T.Generic_Immobilize }, -- Frozen Weapon (Xivilai)
    [88947] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_pulse.dds' }, -- Lightning Grasp (Xivilai)
    [88949] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_pulse.dds' }, -- Lightning Grasp (Xivilai)
    [7100] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_hand_of_flame.dds'}, -- Hand of Flame (Xivilai)
    [25728] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_hand_of_flame.dds'}, -- Hand of Flame (Xivilai)
    [25726] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_daedra.dds' }, -- Summon Daedra (Xivilai)

    -- Watcher
    [4652] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gaze.dds' }, -- Gaze (Watcher)
    [4653] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds' }, -- Shockwave (Watcher)
    [43817] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds', name = A.Skill_Shockwave }, -- Shockwave Snare (Watcher)
    [95855] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds' }, -- Shockwave (Watcher)
    [95856] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds', hide = true }, -- Shockwave (Watcher)
    [53880] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_shockwave.dds' }, -- Shockwave (Watcher)
    [9219] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds', hide = true }, -- Doom-Truth's Gaze (Watcher)
    [9220] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [14518] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [14425] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds', hide = true }, -- Doom-Truth's Gaze (Watcher)
    [14426] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [14546] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze.dds' }, -- Doom-Truth's Gaze (Watcher)
    [12062] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_kick.dds' }, -- Kick (Winged Twilight)
    [13690] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_kick.dds' }, -- Kick (Winged Twilight)
    [6410] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_tail_clip.dds' }, -- Tail Clip (Winged Twilight)
    [63612] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_tail_clip.dds' }, -- Tail Clip (Winged Twilight)
    [6412] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_dusks_howl.dds', tooltip = T.Generic_Stun }, -- Dusk's Howl (Winged Twilight)
    [84825] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_slash.dds' }, -- Slash (Hunger)
    [84826] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_slash.dds' }, -- Slash (Hunger)
    [84827] = { hide = true }, -- Rake (Hunger)
    [84834] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_rake.dds' }, -- Rake (Hunger)
    [94903] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds' }, -- Spring (Hunger)
    [94908] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds', hide = true }, -- Spring (Hunger)
    [94907] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds', tooltip = T.Generic_Snare_40 }, -- Spring (Hunger)
    [87237] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds' }, -- Spring (Hunger)
    [87242] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds', hide = true }, -- Spring (Hunger)
    [87241] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_spring.dds', tooltip = T.Generic_Snare_40 }, -- Spring (Hunger)
    [87247] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds' }, -- Devour (Hunger)
    [87988] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds' }, -- Devour (Hunger)
    [87252] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds', tooltip = T.Skill_Devour_Hunger }, -- Devour (Hunger)
    [87253] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds' }, -- Devour (Hunger)
    [87251] = { hide = true }, -- Devour (Hunger)
    [87385] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds', hide = true }, -- Devour (Hunger)
    [87386] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_devour.dds', tooltip = T.Generic_Knockback }, -- Devour (Hunger)
    [87987] = { hide = true }, -- Devour (Hunger)
    [84944] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds' }, -- Hollow (Hunger)
    [91440] = { hide = true }, -- Hollow (Hunger)
    [91439] = { hide = true }, -- Hollow (Hunger)
    [84967] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds' }, -- Hollow (Hunger)
    [84988] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds', tooltip = T.Generic_Knockback }, -- Hollow (Hunger)
    [84990] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_hollow.dds' }, -- Hollow (Hunger)
    [87269] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds', hide = true }, -- Torpor (Hunger)
    [87270] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor_aura.dds', tooltip = T.Skill_Torpor }, -- Torpor (Hunger)
    [87538] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds' }, -- Torpor (Hunger)
    [87536] = { icon = 'LuiExtended/media/icons/abilities/ability_hunger_torpor.dds', tooltip = T.Generic_Stun }, -- Torpor (Hunger)
    [89751] = { hide = true }, -- Dispel Illusion (Hunger)
    [87271] = { hide = true }, -- Torpor (Hunger)
    [87273] = { hide = true }, -- Torpor (Hunger)
    [87639] = { hide = true }, -- Fade (Hunger)
    [91433] = { hide = true }, -- Fade (Voracity - Hunger Boss)
    [89030] = { hide = true }, -- Subduction (Iron Atronach)
    [88246] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_iron_hand.dds' }, -- Iron Hand (Iron Atronach)
    [88247] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_eruption.dds', tooltip = T.Generic_Burn_2_Sec }, -- Eruption (Iron Atronach)
    [88282] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_rock_stomp.dds' }, -- Rock Stomp (Iron Atronach)
    [88286] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_rock_stomp.dds' }, -- Rock Stomp (Iron Atronach)
    [88295] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_rock_stomp_ranged.dds' }, -- Rock Stomp (Iron Atronach)
    [88261] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_lava_wave.dds' }, -- Lava Wave (Iron Atronach)
    [88266] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_lava_wave.dds', hide = true }, -- Lava Wave (Iron Atronach)
    [95281] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_lava_wave.dds', hide = true }, -- Lava Wave (Iron Atronach)
    [89258] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_blast_furnace.dds', hide = true }, -- Subduction (Iron Atronach)
    [88297] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_blast_furnace.dds', hide = true }, -- Blast Furnace (Iron Atronach)
    [88323] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_blast_furnace.dds', hide = true, groundLabel = true, tooltip = T.Generic_AOE_Fire_0_5_Sec }, -- Blast Furnace (Iron Atronach)

    -- Dwemer
    [7484] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_blade.dds' }, -- Blade (Dwemer Sphere)
    [7485] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_dart.dds' }, -- Dart (Dwemer Sphere)
    [16031] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Richochet Wave (Dwemer Sphere)
    [29832] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Richochet Wave (Dwemer Sphere)
    [7520] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_steam_wall.dds' }, -- Steam Wall (Dwemer Sphere)
    [84216] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_steam_wall.dds' }, -- Steam Wall (Dwemer Sphere)
    [7544] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_quake.dds' }, -- Quake (Dwemer Sphere)
    [46053] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_quake.dds' }, -- Quake (Dwemer Sphere)

    [11245] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_axe.dds' }, -- Axe (Dwemer Centurion)
    [13783] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_hammer.dds' }, -- Hammer (Dwemer Centurion)
    [11247] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds' }, -- Sweeping Spin (Dwemer Centurion)
    [43554] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds' }, -- Sweeping Spin (Dwemer Centurion)
    [11262] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds', tooltip = T.Generic_Knockdown }, -- Sweeping Spin (Dwemer Centurion)
    [11246] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_steam_breath.dds', hide = true }, -- Steam Breath (Dwemer Centurion)
    [11282] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_steam_breath.dds' }, -- Steam Breath (Dwemer Centurion)

    [7719] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_shocking_touch.dds' }, -- Shocking Touch (Dwemer Spider)
    [20507] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_double_strike.dds' }, -- Double Strike (Dwemer Spider)
    [20508] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_double_strike.dds' }, -- Double Strike (Dwemer Spider)

    [7717] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_aoe.dds' }, -- Detonation (Dwemer Spider)
    [15206] = { hide = true }, -- Detonation (Dwemer Spider)
    [84019] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_aoe.dds' }, -- Detonation (Dwemer Spider)
    [13536] = { hide = true }, -- Detonation (Dwemer Spider)

    [64423] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', hide = true }, -- Sparks (Dwemer Sentry)
    [84312] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds', tooltip = T.Skill_Static_Shield }, -- Static Shield (Dwemer Sentry)
    [70133] = { hide = true }, -- Static Shield
    [64556] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds', name = A.Skill_Static_Shield }, -- Static Eruption (Dwemer Sentry)
    [64460] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds', tooltip = T.Skill_Static_Shield }, -- Static Shield (Dwemer Sentry)
    [70134] = { hide = true }, -- Static Shield (Dwemer Sentry)
    [68790] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_static_shield.dds', name = A.Skill_Static_Shield }, -- Static Shield Explosion (Dwemer Sentry)
    [64479] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Thunderbolt (Dwemer Sentry)
    [64543] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds', hide = true }, -- Thunderbolt (Dwemer Sentry)
    [64489] = { hide = true }, -- Find Turret (Dwemer Sentry)
    [64508] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_turret_mode.dds', name = A.Skill_Turret_Mode, tooltip = T.Skill_Turret_Mode }, -- Turret Mode (Dwemer Sentry)

    [85242] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensphere_dart.dds', name = A.Skill_Dart, hide = true }, -- Quick Shot (Dwemer Arquebus)
    [85255] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_shock_blast.dds' }, -- Shock Blast (Dwemer Arquebus)
    [88668] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_impulse_mine.dds' }, -- Impulse Mine (Dwemer Arquebus)
    [88728] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_impulse_mine.dds' }, -- Impulse Mine (Dwemer Arquebus)
    [85270] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_torrent.dds', tooltip = T.Skill_Shock_Barrage }, -- Shock Barrage (Dwemer Arquebus)
    [85288] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_torrent.dds', hide = true }, -- Shock Barrage (Dwemer Arquebus)
    [91013] = { hide = true }, -- Shock Barrage (Dwemer Arquebus)
    [85319] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds', name = A.Skill_Split_Bolt, hide = true }, -- Siege Ballista (Dwemer Arquebus)
    [91093] = { hide = true }, -- Split Bolt (Dwemer Arquebus)
    [91094] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds', groundLabel = true, tooltip = T.Generic_AOE_Shock_0_5_Sec }, -- Split Bolt (Dwemer Arquebus)
    [91095] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds', groundLabel = true, tooltip = T.Generic_AOE_Shock_0_5_Sec }, -- Split Bolt (Dwemer Arquebus)
    [91096] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_split_bolt.dds', groundLabel = true, tooltip = T.Generic_AOE_Shock_0_5_Sec }, -- Split Bolt (Dwemer Arquebus)

    [85326] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_polarizing_field.dds', hide = true }, -- Polarizing Field (Dwemer Arquebus)
    [85327] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenarquebus_polarizing_field.dds', duration = 0, tooltip = T.Skill_Polarizing_Field }, -- Polarizing Field (Dwemer Arquebus)
    [85334] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds', hide = true }, -- Polarizing Field (Dwemer Arquebus)

    [20238] = { hide = true }, -- Move Back (Dwemer Spider - Overcharge Synergy)
    [19970] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_static_field.dds', tooltip = T.Skill_Static_Field }, -- Static Field (Dwemer Spider)
    [19997] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_static_field.dds', hide = true, groundLabel = true, tooltip = T.Generic_AOE_Shock_1_Sec }, -- Static Field (Dwemer Spider)
    [20506] = { hide = true }, -- Overcharge Trigger (Dwemer Spider - Overcharge Synergy)
    [27333] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds', tooltip = T.Skill_Overcharge }, -- Overcharge Trigger (Dwemer Spider - Overcharge Synergy)
    [27458] = { hide = true }, -- tell others (Dwemer Spider - Overcharge Synergy)
    --[20207] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Dwemer Spider - Overcharge Synergy)
    [20206] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds', tooltip = T.Skill_Overcharge }, -- Overcharge (Dwemer Spider - Overcharge Synergy)
    [20221] = { hide = true }, -- Overcharge (Dwemer Spider - Overcharge Synergy)

    [20505] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds', hide = true }, -- Overcharge (Overcharge)
    [20222] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds', hide = true }, -- Overcharge (Overcharge)
    [20504] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Overcharge)
    [20220] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Overcharge)
    [52679] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Overcharge)
    [52680] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Overcharge)

    -- Insects
    [5278] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_bite.dds' }, -- Bite (Assassin Beetle)
    [6137] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', name = A.Skill_Lacerate }, -- Laceration (Assassin Beetle)
    [51736] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', name = A.Skill_Lacerate, tooltip = T.Generic_Bleed_1_Sec }, -- Bleeding (Assassin Beetle)
    [51735] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_laceration.dds', name = A.Skill_Lacerate }, -- Bleeding (Assassin Beetle)
    [5268] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_collywobbles.dds', tooltip = T.Generic_Snare_20 }, -- Collywobbles (Assassin Beetle)
    [91789] = { hide = true }, -- Ambush (Assassin Beetle)
    [91791] = { icon = 'LuiExtended/media/icons/abilities/ability_assassinbeetle_feast.dds', tooltip = T.Generic_Bleed_0_5_Sec }, -- Feast (Assassin Beetle)
    [13680] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_gtaoe.dds', tooltip = T.Generic_AOE_Poison_0_5_Sec, groundLabel = true }, -- Acid Blood (Assassin Beetle)
    [6754] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_pincer.dds' }, -- Pincer (Giant Scorpion)
    [6755] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_sting.dds' }, -- Sting (Giant Scorpion)
    [13671] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_sting.dds', tooltip = T.Generic_Poison_1_5_Sec }, -- Sting (Giant Scorpion)
    [6757] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_blurred_strike.dds' }, -- Blurred Strike (Giant Scorpion)
    [9040] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_blurred_strike.dds' }, -- Blurred Strike (Giant Scorpion)
    [6756] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_paralyze.dds' }, -- Paralyze (Giant Scorpion)
    [12312] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_paralyze.dds', name = A.Skill_Paralyze, tooltip = T.Generic_Snare_55 }, -- Snare (Giant Scorpion)
    [6758] = { icon = 'LuiExtended/media/icons/abilities/ability_scorpion_hardened_carapace.dds', tooltip = T.Skill_Hardened_Carapace }, -- Hardened Carapace (Giant Scorpion)
    [4731] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_bite.dds' }, -- Bite (Giant Spider)
    [44086] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds', name = A.Skill_Poisonous_Burst }, -- Poisonous Burst (Giant Spider)
    [5790] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds' }, -- Poisonous Burst (Giant Spider)
    [5685] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_corrosive_bite.dds' }, -- Corrosive Bite (Giant Spider)
    [8087] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_poison_spray.dds' }, -- Poison Spray (Giant Spider)
    [8088] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_poison_spray.dds' }, -- Poison Spray (Giant Spider)
    [4730] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_ranged.dds' }, -- Spit (Giant Spider)
    [4737] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = A.Skill_Web }, -- Encase (Giant Spider)
    [47318] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_web.dds', name = A.Skill_Web, duration = 0, groundLabel = true, tooltip = T.Generic_Snare_60_No_Dur }, -- Encase (Giant Spider)
    [13382] = { icon = 'LuiExtended/media/icons/abilities/ability_spider_devour.dds' }, -- Devour (Giant Spider)

    -- Giant Wasp
    [9225] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_bite.dds' }, -- Bite (Giant Wasp)
    [9226] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_sting.dds' }, -- Sting (Giant Wasp)
    [9229] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds' }, -- Inject Larva (Giant Wasp)
    [9237] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds', name = A.Skill_Inject_Larva, unbreakable = 1, tooltip = T.Skill_Inject_Larva }, -- Larva Gestation (Giant Wasp)
    [9238] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_larva_burst.dds' }, -- Larva Burst (Giant Wasp)
    [25110] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = A.Skill_Zoom }, -- Charge (Giant Wasp)
    [48559] = { hide = true }, -- Focused Charge (Giant Wasp)
    [25119] = { hide = true }, -- Charge (Giant Wasp)
    [25113] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = A.Skill_Zoom }, -- Charge (Giant Wasp)
    [25120] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_charge.dds', name = A.Skill_Zoom, tooltip = T.Generic_Knockdown }, -- Charge (Giant Wasp)
    [25112] = { hide = true }, -- Charge (Giant Wasp)

    -- Hoarvor
    [6788] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bite.dds' }, -- Bite (Hoarvor)
    [6800] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bloodletting.dds' }, -- Bloodletting (Hoarvor)
    [42292] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_bloodletting.dds' }, -- Bloodletting (Hoarvor)
    [6795] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds', tooltip = T.Skill_Latch_On }, -- Latch On (Hoarvor)
    [13585] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds' }, -- Latch On (Hoarvor)

    -- Necrotic Hoarvor (DLC)
    [61243] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds' }, -- Vile Bite (Hoarvor DLC)
    [69392] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_vile_bite.dds', name = A.Skill_Vile_Bite, tooltip = T.Generic_Poison_1_Sec }, -- Vile Bite Poison (Hoarvor DLC)
    [61244] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_fevered_retch.dds' }, -- Fevered Retch (Hoarvor DLC)
    [61245] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_fevered_retch.dds', tooltip = T.Generic_Poison_1_Sec }, -- Fevered Retch (Hoarvor DLC)
    [61360] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }, -- Infectious Swarm (Hoarvor DLC)
    [61377] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }, -- Infectious Swarm (Hoarvor DLC)
    [61372] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds', tooltip = T.Generic_Poison_0_5_Sec }, -- Infectious Swarm (Hoarvor DLC)
    [61374] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds' }, -- Infectious Swarm (Hoarvor DLC)
    [61376] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds', hide = true }, -- Infectious Swarm (Hoarvor DLC)
    [61375] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_poison.dds', name = A.Skill_Infectious_Swarm, tooltip = T.Generic_Snare_75 }, -- Infectious Swarm (Hoarvor DLC)
    [61427] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds' }, -- Necrotic Explosion (Hoarvor DLC)
    [61249] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', hide = true }, -- Necrotic Explosion (Hoarvor DLC)
    [61388] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', name = A.Skill_Necrotic_Explosion, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Generic_Snare_50 }, -- Necrotic Explosion Snare (Hoarvor DLC)

    -- Kwama Scrib
    [83977] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamascrib_bite.dds' }, -- Bite (Kwama Scrib)
    [8272] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', name = A.Skill_Contagion, hide = true }, -- Spit (Kwama Scrib)
    [47838] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_slime_alt.dds', tooltip = T.Generic_Snare_50 }, -- Contagion (Kwama Scrib)
    [42869] = { hide = true }, -- Burrow (Kwama Scrib)

    -- Kwama Worker
    [9287] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_bite.dds' }, -- Bite (Kwama Worker)
    [9291] = { hide = true }, -- Pounce (Kwama Worker)
    [83953] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_pounce.dds' }, -- Pounce (Kwama Worker)
    [14839] = { hide = true }, -- Charge (Kwama Worker)
    [14841] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow, hide = true }, -- Charge (Kwama Worker)
    [48539] = { hide = true }, -- Focused Charge (Kwama Worker)
    [14846] = { hide = true }, -- Charge (Kwama Worker)
    [18808] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow, hide = true }, -- Charge (Kwama Worker)
    [18810] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow, tooltip = T.Generic_Knockdown }, -- Charge (Kwama Worker)
    [14844] = { hide = true }, -- Charge (Kwama Worker)
    [14845] = { hide = true }, -- Charge (Kwama Worker)
    [18814] = { hide = true }, -- Charge (Kwama Worker)
    [18546] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds', duration = 0, groundLabel = true, tooltip = T.Generic_Snare_50_No_Dur }, -- Shattered Ground (Kwama Worker)

    -- Kwama Warrior
    [15011] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_swipe.dds' }, -- Swipe -- Kwama Warrior
    [9763] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_smash.dds' }, -- Smash -- Kwama Warrior
    [9764] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_smash.dds' }, -- Smash -- Kwama Warrior
    [9769] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_excavation.dds' }, -- Excavation -- Kwama Warrior
    [18585] = { hide = true },  -- Excavation -- Kwama Warrior
    [27463] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamawarrior_excavation.dds' }, -- Excavation -- Kwama Warrior
    [49192] = { hide = true }, -- Excavation (Kwama Scrib Summoned) (30 sec passive applied that doesn't have any effect)
    [18567] = { hide = true }, -- Excavation (Kwama Scrib Summoned) (30 sec passive applied that doesn't have any effect)

    -- Shalk
    [6127] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_bite.dds' }, -- Bite (Shalk)
    [5260] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fiery_breath.dds', name = A.Skill_Fiery_Breath }, -- Fiery Breath (Shalk)
    [10947] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fiery_breath.dds' }, -- Fiery Breath (Shalk)
    [5252] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fire_bite.dds' }, -- Fire Bite (Shalk)
    [6129] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_fire_bite.dds', tooltip = T.Generic_Burn_1_Sec }, -- Fire Bite (Shalk)
    [5262] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_burning_ground.dds' }, -- Burning Ground (Shalk)
    [5265] = { icon = 'LuiExtended/media/icons/abilities/ability_shalk_burning_ground.dds', tooltip = T.Generic_AOE_Fire_1_Sec, groundLabel = true }, -- Burning Ground (Shalk)

    -- Thunderbug
    [5308] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunder_bite.dds' }, -- Thunder Bite (Thunderbug)
    [8429] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds', tooltip = T.Skill_Lightning_Rod }, -- Zap (Thunderbug)
    [65079] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds' }, -- Zap (Thunderbug)
    [26379] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Zap (Thunderbug)
    [26382] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds' }, -- Bolt (Thunderbug)
    [26412] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunderstrikes.dds' }, -- Thunderstrikes (Thunderbug)
    [34980] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_thunderstrikes.dds' }, -- Thunderstrikes (Thunderbug)

    -- Kotu Gava
    [73166] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds', name = A.Skill_Leeching_Bite }, -- Bite (Kotu Gava)
    [73214] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds', name = A.Skill_Leeching_Bite, tooltip = T.Generic_Snare_40 }, -- Bite (Kotu Gava)
    [73215] = { hide = true }, -- Bite (Kotu Gava)

    -- Kotu Gava Broodmother
    [73184] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds', hide = true }, -- Vile Spit (Kotu Gava Broodmother)
    [73172] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds'}, -- Swarm (Kotu Gava Broodmother)
    [73173] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds', tooltip = T.Skill_Kotu_Gava_Swarm, tooltipValue2Mod = -1 }, -- Swarm (Kotu Gava Broodmother)
    [73193] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarm.dds', tooltip = T.Generic_Snare_40 }, -- Swarm (Kotu Gava Broodmother)
    [73177] = { hide = true }, -- Swarmburst (Kotu Gava Broodmother)
    [73174] = { hide = true }, -- Swarm (Kotu Gava Broodmother)
    [73175] = { hide = true }, -- Swarm (Kotu Gava Broodmother)
    [73176] = { hide = true }, -- Swarm (Kotu Gava Broodmother)
    [76579] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds', name = A.Skill_Leeching_Bite }, -- Bite (Kotu Gava Spawn)
    [76580] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_bite.dds', name = A.Skill_Leeching_Bite, tooltip = T.Generic_Snare_40 }, -- Bite (Kotu Gava Spawn)
    [76581] = { hide = true }, -- Bite (Kotu Gava Spawn)
    [73199] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarmburst.dds' }, -- Swarmburst (Kotu Gava Broodmother)
    [73200] = { hide = true }, -- Swarmburst (Kotu Gava Broodmother)
    [73195] = { hide = true }, -- Swarmburst (Kotu Gava Spawn)
    [73196] = { hide = true }, -- Swarmburst (Kotu Gava Spawn)
    [73197] = { hide = true }, -- Swarmburst (Kotu Gava Spawn)
    [73194] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_slime_alt.dds',  tooltip = T.Generic_Snare_40 }, -- Swarmburst (Kotu Gava Broodmother)
    [73198] = { icon = 'LuiExtended/media/icons/abilities/ability_kotugava_swarmburst.dds', tooltip = T.Skill_Kotu_Gava_Swarm, tooltipValue2Mod = -1 }, -- Swarmburst (Kotu Gava Broodmother)
    [87022] = { hide = true }, -- Summon Swarm (Fetcherfly Nest)
    [85524] = { hide = true }, -- Ashen Wind (Fetcherfly Swarm)
    [85525] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }, -- Ashen Wind (Fetcherfly Swarm)
    [85526] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }, -- Ashen Cloud (Fetcherfly Swarm)
    [85645] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_bombard.dds' }, -- Bombard (Fectherfly Nest)
    [85646] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_bombard.dds', name = A.Skill_Bombard }, -- Bomb (Fectherfly Nest)
    [87125] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_heat_vents.dds', hide = true }, -- Heat Vents (Fetcherfly Nest)
    [87126] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_heat_vents.dds', groundLabel = true, tooltip = T.Generic_AOE_Fire_0_5_Sec }, -- Heat Vents (Fetcherfly Nest)
    [92083] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_slam.dds' }, -- Slam (Fetcherfly Hive Golem)
    [87095] = { hide = true }, -- Colonize (Fetcherfly Hive Golem)
    [92078] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_colonize.dds', name = A.Skill_Fetcherfly_Colony }, -- Colonize (Fetcherfly Hive Golem)
    [92079] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_colonize.dds', tooltip = T.Skill_Colonize }, -- Colonize (Fetcherfly Hive Golem)
    [92081] = { hide = true }, -- Colonize (Fetcherfly Hive Golem)
    [87062] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }, -- Fetcherfly Storm (Fetcherfly Hive Golem)
    [92075] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflynest_ashen_wind.dds' }, -- Fetcherfly Storm (Fetcherfly Hive Golem)
    [87087] = { tooltip = T.Generic_Silence }, -- Fetcherfly Storm (Fetcherfly Hive Golem)
    [87030] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_focused_swarm.dds' }, -- Focused Swarm (Fetcherfly Hive Golem)
    [87031] = { icon = 'LuiExtended/media/icons/abilities/ability_fetcherflygolem_focused_swarm.dds' }, -- Focused Swarm (Fetcherfly Hive Golem)

    -- Monsters
    [10259] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_double_swipe.dds' }, -- Double Swipe (Gargoyle)
    [32672] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_double_swipe.dds' }, -- Double Swipe (Gargoyle)
    [10270] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds' }, -- Quake (Gargoyle)
    [10271] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_quake.dds' }, -- Quake (Gargoyle)
    [10256] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds' }, -- Lacerate (Gargoyle)
    [25716] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds', name = A.Skill_Lacerate, tooltip = T.Skill_Lacerate_Gargoyle, hideReduce = true }, -- Stun (Gargoyle)
    [25718] = { icon = 'LuiExtended/media/icons/abilities/ability_gargoyle_lacerate.dds', name = A.Skill_Lacerate, tooltip = T.Skill_Lacerate_Gargoyle }, -- Stun (Gargoyle)
    [25714] = { icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds', tooltip = T.Skill_Vampiric_Touch_Gargoyle }, -- Vampiric Touch (Gargoyle)
    [46845] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_sweep.dds' }, -- Sweep (Giant)
    [8674] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_kick.dds' }, -- Sweep (Giant)
    [26124] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_shatter.dds' }, -- Shatter (Giant)
    [26129] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_shatter.dds', hide = true }, -- Shatter (Giant)
    [15715] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds' }, -- Obliterate (Giant)
    [43743] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds' }, -- Obliterate (Giant)
    [43742] = { icon = 'LuiExtended/media/icons/abilities/ability_giant_obliterate.dds', tooltip = T.Generic_Knockback }, -- Obliterate (Giant)
    [2901] = { icon = 'LuiExtended/media/icons/abilities/ability_hag_staff_strike.dds' }, -- Staff Strike (Hag)
    [2786] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_steal_essence.dds', tooltip = T.Skill_Steal_Essence }, -- Steal Essence (Hag)
    [21642] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_steal_essence.dds' }, -- Steal Essence (Hag)
    [3349] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_reflective_shadows.dds', tooltip = T.Skill_Reflective_Shadows }, -- Reflective Shadows (Hag)
    [2821] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_luring_snare.dds', hide = true }, -- Luring Snare (Hag)
    [32267] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_luring_snare.dds', name = A.Skill_Luring_Snare, tooltip = T.Generic_Stun }, -- Grapple (Hag)

    -- Hagraven
    [10611] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fire_ranged.dds' }, -- Flare (Hagraven)
    [10615] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_raven_storm.dds' }, -- Raven Storm (Hagraven)
    [10616] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_raven_storm.dds' }, -- Raven Storm (Hagraven)
    [12426] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger }, -- Raven Storm (Hagraven)
    [10613] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fire_aoe_alt.dds' }, -- Fire Bomb (Hagraven)
    [10614] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fire_aoe_alt.dds' }, -- Fire Bomb (Hagraven)
    [64806] = { hide = true }, -- Briarheart Resurrection (Hagraven)
    [64808] = { icon = 'esoui/art/icons/ability_healer_028.dds', duration = 2.5, tooltip = T.Skill_Briarheart_Resurrection }, -- Briarheart Resurrection (Hagraven)
    [65027] = { icon = 'esoui/art/icons/ability_healer_028.dds', tooltip = T.Skill_Briarheart_Resurrection }, -- Briarheart Resurrection (Hagraven)

    [4112] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_talon.dds' }, -- Talon (Harpy)
    [4125] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_kick.dds' }, -- Kick (Harpy)
    [24551] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_zap.dds' }, -- Bolt (Harpy)
    [4684] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_zap.dds' }, -- Bolt (Harpy)
    [4123] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wing_slice.dds' }, -- Wing Slice (Harpy)
    [24369] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wing_slice.dds' }, -- Wing Slice (Harpy)
    [13515] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wind_gust.dds' }, -- Wind Gust (Harpy)
    [13516] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wind_gust.dds' }, -- Wind Gust (Harpy)
    [13517] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_wind_gust.dds', tooltip = T.Generic_Knockdown }, -- Wind Gust (Harpy)
    [24604] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_charged_ground.dds' }, -- Charged Ground (Harpy)
    [8628] = { icon = 'LuiExtended/media/icons/abilities/ability_harpy_charged_ground.dds', groundLabel = true, tooltip = T.Generic_AOE_Shock_0_7_Sec }, -- Charged Ground (Harpy)
    [4689] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_impending_storm.dds' }, -- Impending Storm (Harpy)
    [4690] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_impending_storm.dds' }, -- Impending Storm (Harpy)

    [9846] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_bite.dds' }, -- Bite (Ice Wraith)
    [43809] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_shard_burst.dds', tooltip = T.Generic_Immunity }, -- Shard Burst (Ice Wraith)
    [43810] = { hide = true }, -- Shard Burst (Ice Wraith)
    [38920] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_shard_burst.dds', tooltip = T.Generic_Stun }, -- Shard Burst (Ice Wraith)
    [24877] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_shard_burst.dds' }, -- Shard Burst (Ice Wraith)
    [24866] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_blood_in_the_water.dds', name = A.Skill_Assault }, -- Blood in the Water (Ice Wraith)
    [48549] = { hide = true }, -- Focused Charge (Ice Wraith)
    [24869] = { icon = 'LuiExtended/media/icons/abilities/ability_icewraith_blood_in_the_water.dds', name = A.Skill_Assault }, -- Blood in the Water (Ice Wraith)
    [46563] = { icon = 'esoui/art/icons/ability_mage_020.dds', duration = 0, groundLabel = true, tooltip = T.Generic_Snare_70_No_Dur }, -- Blood in the Water (Ice Wraith)

    [14801] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds', hide = true }, -- Flare (Imp - Fire)
    [14802] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_ranged.dds', hide = true }, -- Fireball (Imp - Fire)
    [17703] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_flame_ray.dds', tooltip = T.Skill_Flame_Ray }, -- Flame Ray (Imp - Fire)
    [65078] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_flame_ray.dds' }, -- Flame Ray (Imp - Fire)
    [17706] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_flamestrike.dds' }, -- Flame Ray (Imp - Fire)

    [7732] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', hide = true }, -- Bolt (Imp - Lightning)
    [13648] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', hide = true }, -- Spark (Imp - Lightning)
    [8884] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_zap.dds', tooltip = T.Skill_Lightning_Rod }, -- Zap (Imp - Lightning)
    [65077] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_zap.dds' }, -- Zap (Imp - Lightning)
    [14666] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Zap (Imp - Lightning)

    [88906] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_frost_ranged.dds', hide = true }, -- Frost Bolt (Imp - Frost)
    [88918] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_frost_ranged.dds', hide = true }, -- Frostball (Imp - Frost)

    [81794] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_frost_ray.dds', tooltip = T.Skill_Frost_Ray }, -- Frost Ray (Imp - Frost)
    [88907] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_frost_ray.dds', hide = true }, -- Frost Ray (Imp - Frost)
    [88915] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, hide = true }, -- Frost Ray (Imp - Frost)
    [88908] = { icon = 'LuiExtended/media/icons/abilities/ability_set_winterborn.dds' }, -- Frost Ray (Imp - Frost)

    [9670] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_strike.dds' }, -- Strike (Lamia)
    [9671] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_howling_strike.dds' }, -- Howling Strike (Lamia)
    [89382] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_howling_strike.dds' }, -- Howling Strike (Lamia)
    [9674] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Resonate (Lamia)
    [23281] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Resonate (Lamia)
    [7830] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_shockwave.dds', hide = true }, -- Shockwave (Lamia)
    [12074] = { hide = true }, -- Summon Spectral Lamia (Lamia)
    [9680] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_summon_spectral_lamia.dds', tooltip = T.Skill_Summon_Spectral_Lamia }, -- Summon Spectral Lamia (Lamia)
    [89399] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Skill_Weakness_NPC_Summon }, -- Summon Spectral Lamia (Lamia)
    [7835] = { icon = 'esoui/art/icons/ability_healer_033.dds', hide = true }, -- Convalescence (Lamia)
    [7831] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_harmony.dds' }, -- Harmony (Lamia)
    [24745] = { hide = true }, -- Harmony (Lamia)
    [23358] = { icon = 'LuiExtended/media/icons/abilities/ability_lamia_harmony.dds', tooltip = T.Skill_Harmony }, -- Harmony (Lamia)
    [24814] = { hide = true }, -- Harmony (Lamia)

    [3757] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_claw.dds' }, -- Claw (Lurcher)
    [3860] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_pulverize.dds' }, -- Pulverize (Lurcher)
    [32698] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger }, -- Pulverize (Lurcher)
    [3855] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs.dds' }, -- Crushing Limbs (Lurcher)
    [38554] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_crushing_limbs.dds', name = A.Skill_Crushing_Limbs, tooltip = T.Generic_Stun }, -- Crushing Limbs (Lurcher)
    [3767] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen.dds', hide = true }, -- Choking Pollen (Lurcher)
    [4769] = { icon = 'LuiExtended/media/icons/abilities/ability_lurcher_choking_pollen.dds', groundLabel = true, tooltip = T.Generic_AOE_Poison_0_5_Sec }, -- Choking Pollen (Lurcher)

    [5520] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_frost_ranged.dds', hide = true }, -- Frost Bolt (Nereid)
    [5559] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds' }, -- Icy Geyser (Nereid)
    [11024] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds' }, -- Icy Geyser (Nereid)
    [5540] = { icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds', hide = true }, -- Hurricane (Nereid)
    [16040] = { icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds', groundLabel = true, tooltip = T.Skill_Hurricane_Ground }, -- Hurricane (Nereid)
    [33459] = { icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds', duration = 0, groundLabel = true, tooltip = T.Skill_Hurricane_Ground, hideGround = true  }, -- Hurricane (Nereid)

    [5254] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_punch.dds' }, -- Punch (Ogre)
    [5257] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_backhand.dds' }, -- Backhand (Ogre)
    [5881] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Smash (Ogre)
    [24948] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Smash (Ogre)
    [34627] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds', tooltip = T.Generic_Snare_50 }, -- Smash (Ogre)
    [24949] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Smash (Ogre)
    [34614] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', tooltip = T.Generic_Knockdown }, -- Smash (Ogre)
    [5256] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }, -- Shockwave (Ogre)
    [34616] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }, -- Shockwave (Ogre)
    [5349] = { hide = true }, -- Stagger (Ogre - Shockwave)
    [6150] = { tooltip = A.Skill_Shockwave }, -- Off Balance (Ogre)
    [5349] = { tooltip = T.Generic_Stagger }, -- Stagger (Ogre)
    [8069] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds', tooltip = T.Generic_Fear }, -- Intimidating Roar (Ogre)
    [24985] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage, tooltip = T.Skill_Enrage_Ogre }, -- Intimidating Roar (Ogre)

    [53136] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [65434] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [53773] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [53774] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [65469] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [65470] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_frost_bolt.dds' }, -- Frost Bolt (Ogre Shaman)
    [53142] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_ice_pillar.dds', tooltip = T.Skill_Ice_Pillar }, -- Ice Pillar (Ogre Shaman)
    [74457] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_ice_pillar.dds', tooltip = T.Skill_Ice_Pillar }, -- Ice Pillar (Ogre Shaman)
    [34385] = { hide = true }, -- Generic AOE (Ogre Shaman)
    [53966] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_ice_pillar.dds', duration = 0, groundLabel = true, tooltip = T.Generic_Snare_60_No_Dur }, -- Ice Pillar Chill (Ogre Shaman)
    [54327] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_root_frost.dds', name = A.Skill_Frozen, tooltip = T.Generic_Immobilize }, -- Winter's Reach (Ogre Shaman)
    [64540] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_freeze_wounds.dds' }, -- Freeze Wounds (Ogre Shaman)
    [53137] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_freeze_wounds.dds' }, -- Freeze Wounds (Ogre Shaman)

    [2986] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_lacerate.dds' }, -- Lacerate (Spriggan)
    [21582] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm.dds' }, -- Nature's Swarm (Spriggan)
    [31699] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_natures_swarm.dds' }, -- Nature's Swarm (Spriggan)
    [13475] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_healing_salve.dds', tooltip = T.Skill_Healing_Salve }, -- Healing Salve (Spriggan)
    [89083] = { hide = true }, -- Healing Salve (Spriggan)
    [89084] = { hide = true }, -- Healing Salve (Spriggan)
    [89085] = { hide = true }, -- Healing Salve (Spriggan)

    [89143] = { hide = true }, -- Summon Beast (Spriggan)
    [89119] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast.dds', tooltip = T.Skill_Summon_Beast }, -- Summon Beast (Spriggan)
    [89102] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_tiger.dds', tooltip = T.Skill_Summon_Beast }, -- Summon Beast (Spriggan)
    [89157] = { hide = true }, -- Summon Beast (Spriggan)
    [89158] = { hide = true }, -- Summon Beast (Spriggan)
    [89159] = { hide = true }, -- Summon Beast (Spriggan)
    [89151] = { hide = true }, -- Summon Beast (Spriggan)
    [89154] = { hide = true }, -- Summon Beast (Spriggan)
    [89160] = { hide = true }, -- Summon Beast (Spriggan)
    [89168] = { hide = true }, -- Summon Beast (Spriggan)
    [89170] = { hide = true }, -- Summon Beast (Spriggan)
    [89127] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -120, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Skill_Weakness_NPC_Summon }, -- Summon Beast (Spriggan)
    [21570] = { hide = true }, -- Backstep (Spriggan)
    [13477] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_control_beast.dds', tooltip = T.Skill_Control_Beast }, -- Control Beast (Spriggan)

    [42793] = { hide = true }, -- Strangler: (Strangler)
    [42794] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Bash_Stun, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Generic_Stun }, -- Strangler: (Strangler)
    [9320] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_strike.dds' }, -- Strike (Strangler)
    [14219] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_ranged.dds' }, -- Spit (Strangler)
    [9346] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_strangle.dds', tooltip = T.Generic_Bleed_1_Sec }, -- Strangle (Strangler)
    [42211] = { hide = true }, -- Strangle (Strangler)
    [9322] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_poisoned_ground.dds' }, -- Poisoned Ground (Strangler)
    [9323] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_poisoned_ground.dds' }, -- Poisoned Ground (Strangler)
    [9321] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds' }, -- Grapple (Strangler)
    [9707] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds', tooltip = T.Generic_Stun }, -- Grapple (Strangler)
    [64132] = { hide = true }, -- Grapple Immunity (Strangler)

    [8926] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_regeneration.dds', tooltip = T.Skill_Regeneration_Troll }, -- Regeneration (Troll)
    [61225] = { hide = true }, -- Regeneration (Troll)
    [8925] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_slap.dds' }, -- Slap (Troll)
    [44736] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_swinging_cleave.dds', hide = true }, -- Swinging Cleave (Troll)
    [44737] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_swinging_cleave.dds' }, -- Swinging Cleave (Troll)
    [9009] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds', hide = true }, -- Tremor (Troll)
    [9011] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds' }, -- Tremor (Troll)

    [76266] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_rip.dds' }, -- Rip (River Troll)
    [76268] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }, -- Lope (River Troll)
    [78834] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }, -- Lope (River Troll)
    [76274] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds', tooltip = T.Generic_Snare_40 }, -- Lope (River Troll)

    [76277] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_close_wounds.dds', tooltip = T.Skill_Close_Wounds }, -- Close Wounds (River Troll)
    [76295] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_crab_toss.dds' }, -- Crab Toss (River Troll)
    [80506] = { hide = true }, -- Crab Toss (River Troll)
    [76297] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_crab_toss.dds' }, -- Crab Toss (River Troll)
    [76298] = { hide = true }, -- Crab Toss (River Troll)
    [81045] = { hide = true }, -- Crab Toss (River Troll)
    [76300] = { hide = true }, -- Scuttle (River Troll)

    [48253] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_rock_toss.dds' }, -- Rock Toss (Troll - Ranged)
    [60549] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_rock_toss.dds' }, -- Rock Toss (Troll - Ranged)
    [48256] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Troll - Ranged)
    [48257] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Troll - Ranged)
    [50387] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds', tooltip = T.Generic_Knockdown }, -- Boulder Toss (Troll - Ranged)
    [48282] = { icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds' }, -- Consuming Omen (Troll - Ranged)

    [48287] = { icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds', hide = true, tooltip = T.Skill_Consuming_Omen_Snare }, -- Consuming Omen (Troll - Ranged)
    [48294] = { icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Consuming_Omen }, -- Consuming Omen (Troll - Ranged)
    [48297] = { icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds' }, -- Consuming Omen (Troll - Ranged)

    [4304] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_assault.dds' }, -- Assault (Wisp)
    [18634] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_assault.dds' }, -- Assault (Wisp)
    [4309] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_dying_blast.dds' }, -- Dying Blast (Wisp)
    [64221] = { icon = 'LuiExtended/media/icons/abilities/ability_wisp_dying_blast.dds' }, -- Dying Blast (Wisp)

    [7976] = { icon = 'LuiExtended/media/icons/abilities/ability_wispmother_rain_of_wisps.dds' }, -- Rain of Wisps (Wispmother)
    [64211] = { hide = true }, -- Summon Wisp (Wispmother)
    [8025] = { hide = true },-- Rain of Wisps (Wispmother)
    [19043] = { hide = true },-- Rain of Wisps (Wispmother)
    [19050] = { hide = true },-- Rain of Wisps (Wispmother)
    [19056] = { hide = true },-- Rain of Wisps (Wispmother)
    [61204] = { hide = true },-- Rain of Wisps Tracker (Wispmother)
    [19061] = { icon = 'LuiExtended/media/icons/abilities/ability_wispmother_rain_of_wisps.dds' }, -- Rain of Wisps (Wispmother)
    [18040] = { hide = true }, -- Clone (Wispmother)
    [18049] = { hide = true }, -- Clone (Wispmother)
    [18060] = { hide = true }, -- Clone (Wispmother)

    -- Minotaur
    [75863] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_chop.dds' }, -- Chop (Minotaur)
    [75865] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_cleave.dds' }, -- Cleave (Minotaur)
    [75867] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_clobber.dds' }, -- Clobber (Minotaur)
    [80440] = { hide = true }, -- Clobber (Minotaur)
    [80014] = { hide = true }, -- Clobber (Minotaur)
    [75868] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_clobber.dds', tooltip = T.Generic_Stun }, -- Clobber (Minotaur)
    [75917] = { icon = 'esoui/art/icons/achievement_update15_015.dds' }, -- Ram (Minotaur)
    [75921] = { icon = 'esoui/art/icons/achievement_update15_015.dds' }, -- Ram (Minotaur)
    [75919] = { icon = 'esoui/art/icons/achievement_update15_015.dds', tooltip = T.Generic_Knockdown }, -- Ram (Minotaur)
    [75922] = { icon = 'esoui/art/icons/achievement_update15_015.dds' }, -- Ram (Minotaur)
    [79541] = { icon = 'esoui/art/icons/achievement_update15_022.dds', hide = true }, -- Flying Leap (Minotaur)
    [79539] = { icon = 'esoui/art/icons/achievement_update15_022.dds' }, -- Flying Leap (Minotaur)
    [75925] = { icon = 'LuiExtended/media/icons/abilities/ability_minotaur_elemental_weapon.dds', tooltip = T.Skill_Elemental_Weapon_NPC }, -- Elemental Weapon (Minotaur)
    [75928] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_aoe_alt.dds', hide = true, groundLabel = true, tooltip = T.Generic_AOE_Fire_0_66_Sec }, -- Elemental Pool (Minotaur)
    [75933] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_heat_wave.dds', hide = true }, -- Elemental Wave (Minotaur)

    [75949] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fiery_surge.dds', hide = true }, -- Fiery Surge (Minotaur Shaman)
    [77989] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fiery_surge.dds', hide = true }, -- Flame Wave (Minotaur Shaman)
    [75951] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_snare_fire.dds' }, -- Brimstone Hailfire (Minotaur Shaman)
    [75953] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_snare_fire.dds', hide = true, groundLabel = true, tooltip = T.Skill_Brimstone_Hailfire }, -- Brimstone Hailfire (Minotaur Shaman)
    [75954] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_snare_fire.dds', duration = 0, groundLabel = true, tooltip = T.Skill_Brimstone_Hailfire, hideGround = true }, -- Brimstone Hailfire (Minotaur Shaman)
    [75955] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds' }, -- Pillars of Nirn (Minotaur Shaman)
    [75980] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds', name = A.Skill_Pillars_of_Nirn }, -- Pillars Eruption (Minotaur Shaman)
    [75976] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds', name = A.Skill_Pillars_of_Nirn, hide = true, groundLabel = true, tooltip = T.Generic_AOE_Fire_0_66_Sec }, -- Pillar of Nirn (Minotaur Shaman)
    [75978] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds', name = A.Skill_Pillars_of_Nirn }, -- Pillar Explosion (Minotaur Shaman)
    [75994] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_molten_armor.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Molten Armor (Minotaur Shaman)

    [49395] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_punch.dds', name = A.Skill_Claw }, -- Punch (Mantikora)
    [49397] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_sweep.dds' }, -- Spear Sweep (Mantikora)
    [49499] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_throw.dds' }, -- Spear Throw (Mantikora)
    [51231] = { hide = true }, -- locomotion override (Mantikora)
    [53836] = { hide = true }, -- Spear Throw (Mantikora)
    [49505] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_throw.dds' }, -- Spear Throw (Mantikora)
    [49500] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_spear_throw.dds', tooltip = T.Generic_Knockdown }, -- Spear Throw (Mantikora)
    [53834] = { hide = true }, -- Get Spear Out (Mantikora)
    [49404] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_rear_up.dds' }, -- Rear Up (Mantikora)
    [49406] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_rear_up.dds' }, -- Rear Up (Mantikora)
    [49405] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger }, -- Rear Up (Mantikora)
    [49402] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_tail_whip.dds' }, -- Tail Whip (Mantikora)
    [49403] = { icon = 'LuiExtended/media/icons/abilities/ability_mantikora_tail_whip.dds' }, -- Tail Whip (Mantikora)
    [51242] = { hide = true }, -- Enrage (Mantikora)
    [50187] = { icon = 'esoui/art/icons/ability_warrior_025.dds', tooltip = T.Skill_Mantikora_Enrage }, -- Enrage (Mantikora)
    [56687] = { hide = true }, -- Enrage (Mantikora)
    [56688] = { hide = true }, -- Enrage (Mantikora)
    [87712] = { hide = true }, -- Enraged (Mantikora)
    [56689] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage, tooltip = T.Skill_Mantikora_Enrage }, -- Enraged (Mantikora)

    -- Yaghra Strider
    [103777] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lacerate.dds' }, -- Lacerate (Yaghra Strider)
    [103778] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lacerate.dds' }, -- Lacerate (Yaghra Strider)
    [105432] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lacerate.dds' }, -- Lacerate (Yaghra Strider)
    [105433] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lacerate.dds' }, -- Lacerate (Yaghra Strider)
    [103780] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lacerate.dds', name = A.Skill_Lacerate, tooltip = T.Generic_Bleed_0_5_Sec }, -- Bleeding Laceratation (Yaghra Strider)
    [104479] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_reave.dds' }, -- Reave (Yaghra Strider)
    [104509] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_reave.dds', hide = true }, -- Reave (Yaghra Strider)
    [104508] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_reave.dds', tooltip = T.Generic_Knockback }, -- Reave (Yaghra Strider)
    [105214] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lunge.dds' }, -- Lunge (Yaghra Strider)
    [105285] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_lunge.dds' }, -- Lunge (Yaghra Strider)
    [105330] = { icon = 'esoui/art/icons/ability_warrior_025.dds' }, -- Frenzy (Yaghra Strider)

    -- Yaghra Spewer
    [103776] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_slash.dds' }, -- Slash (Yaghra Spewer)
    [103775] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghra_chop.dds' }, -- Chop (Yaghra Spewer)
    [103784] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_melee_snare.dds', tooltip = T.Skill_Agonizing_Fury }, -- Dazed Snare (Yaghra Spewer)
    [103786] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_death_bolt.dds' }, -- Purge (Yaghra Spewer)
    [103804] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_frost_aoe_alt.dds', hide = true }, -- Deluge (Yaghra Spewer)
    [103862] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_frost_aoe_alt.dds', tooltip = T.Generic_AOE_Magic_0_66_Sec, groundLabel = true }, -- Deluge (Yaghra Spewer)
    [103864] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost_alt.dds', tooltip = T.Generic_Snare_50 }, -- Deluge (Yaghra Spewer)
    [103931] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_innate_death_bolt.dds' }, -- Luminescent Mark (Yaghra Spewer)
    [103958] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_death_bolt.dds', hide = true }, -- Luminescent Mark (Yaghra Spewer)
    [103957] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_death_bolt.dds', tooltip = T.Generic_Knockback }, -- Luminescent Mark (Yaghra Spewer)
    [103992] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_magic_aoe.dds', tooltip = T.Generic_AOE_Magic_0_66_Sec, groundLabel = true }, -- Luminescent Burn (Yaghra Spewer)

    -- Undead
    [38829] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_desecrated_ground_bonus.dds', name = A.Skill_Desecrated_Ground, duration = 0, groundLabel = true, tooltip = T.Generic_AOE_Heal_2_Sec }, -- Desecrated Ground Bonus
    [38834] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_desecrated_ground_snare.dds', name = A.Skill_Desecrated_Ground, groundLabel = true, tooltip = T.Skill_Desecrated_Ground, hideGround = true }, -- Desecrated Ground Snare (Desecrated Ground - Undead Synergy)
    [69950] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_desecrated_ground_snare.dds', groundLabel = true, tooltip = T.Skill_Desecrated_Ground }, -- Desecrated Ground (Desecrated Ground - Undead Synergy)
    [8550] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_slash.dds' }, -- Slash (Bloodfiend)
    [8551] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_slash.dds' }, -- Slash (Bloodfiend)
    [8564] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_rending_slash.dds' }, -- Rending Slash (Bloodfiend)
    [9194] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_flurry.dds' }, -- Flurry (Bloodfiend)
    [8569] = { icon = 'LuiExtended/media/icons/abilities/ability_bloodfiend_devastating_leap.dds' }, -- Devastating Leap (Bloodfiend)
    [32023] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger }, -- Generic Stagger Enemy (Bloodfiend)

    -- Bone Colossus
    [5028] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_strike.dds' }, -- Strike (Bone Colossus)
    [5050] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds', name = A.Skill_Colossal_Stomp }, -- Bone Saw (Bone Colossus)
    [30590] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds', name = A.Skill_Colossal_Stomp }, -- Bone Saw (Bone Colossus)
    [17206] = { name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Bone Saw (Bone Colossus)
    [5044] = { hide = true }, -- Risen Dead (Bone Colossus)
    [5030] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_voice_to_wake_the_dead.dds' }, -- Voice to Wake the Dead (Bone Colossus)
    [17221] = { icon = 'LuiExtended/media/icons/abilities/ability_boneflayer_rending_slash.dds' }, -- Slap (Bone Colossus - Risen Dead)
    [17207] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necromantic_implosion.dds', hide = true }, -- Necromantic Implosion (Bone Colossus - Risen Dead)
    [88828] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necromantic_implosion.dds' }, -- Necromantic Implosion (Bone Colossus - Risen Dead)
    [89533] = { hide = true }, -- Necromantic Implosion (Bone Colossus - Risen Dead)

    -- Ghost
    [8812] = { icon = 'LuiExtended/media/icons/abilities/ability_ghost_double_strike.dds' }, -- Double Strike (Ghost)
    [8813] = { icon = 'LuiExtended/media/icons/abilities/ability_ghost_double_strike.dds' }, -- Double Strike (Ghost)
    [18514] = { icon = 'esoui/art/icons/ability_mage_052.dds' }, -- Chill Touch (Ghost)
    [18515] = { icon = 'esoui/art/icons/ability_mage_052.dds', tooltip = T.Generic_Snare_40 }, -- Chill Touch (Ghost)
    [19137] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_haunting_spectre.dds' }, -- Haunting Spectre (Ghost)
    [19138] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_haunting_spectre.dds' }, -- Haunting Spectre (Ghost)
    [19140] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_haunting_spectre.dds', tooltip = T.Generic_Fear }, -- Haunting Spectre (Ghost)
    [9541] = { icon = 'esoui/art/icons/ability_mage_027.dds' }, -- Necrotic Spear (Lich)
    [20812] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_defiled_ground.dds', groundLabel = true, tooltip = T.Skill_Veil_of_Blades_Ground }, -- Defiled Ground (Lich)
    [22525] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_defiled_ground.dds', groundLabel = true, tooltip = T.Skill_Veil_of_Blades_Ground, hideGround = true }, -- Defiled Ground (Lich)
    [73925] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds', hide = true }, -- Soul Cage (Lich)
    [73929] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds', hide = true, groundLabel = true, tooltip = T.Generic_AOE_Magic_0_5_Sec }, -- Soul Cage (Lich)
    [73931] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds' }, -- Soul Rupture (Lich)
    [73926] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', name = A.Skill_Soul_Rupture, tooltip = T.Generic_Stun }, -- Soul Cage (Lich)
    [73937] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds', hide = true, groundLabel = true, tooltip = T.Generic_AOE_Magic_0_5_Sec }, -- Soul Cage (Lich)
    [73939] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds' }, -- Soul Rupture (Lich)
    [73934] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', name = A.Skill_Soul_Rupture, tooltip = T.Generic_Stun }, -- Soul Cage (Lich)
    [49702] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shadow_bolt.dds' }, -- Entropic Flare (Spellfiend)
    [50456] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shadow_bolt.dds' }, -- Entropic Flare (Spellfiend)
    [50182] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_consuming_energy.dds' }, -- Consuming Energy (Spellfiend)
    [50183] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_consuming_energy.dds' }, -- Consuming Energy (Spellfiend)
    [52398] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_consuming_energy.dds', tooltip = T.Generic_Stun }, -- Consuming Energy (Spellfiend)
    [68735] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', tooltip = T.Skill_Vampiric_Drain }, -- Vampiric Drain (Vampire)
    [68750] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', hide = true }, -- Vampiric Drain (Vampire)
    [68765] = { hide = true }, -- Vampiric Drain (Vampire)
    [68771] = { hide = true }, -- Vampiric Drain (Vampire)
    [68772] = { hide = true }, -- Vampiric Drain (Vampire)
    [2849] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_claw_slash.dds' }, -- Claw Slash (Werewolf)
    [4651] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_claw_slash.dds' }, -- Claw Slash (Werewolf)
    [2850] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attacklight.dds' }, -- Swipe (Werewolf)
    [2867] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_crushing_leap.dds' }, -- Crushing Leap (Werewolf)
    [45576] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger }, -- Generic Stagger Enemy (Werewolf)
    [3415] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', hide = true }, -- Flurry (Werewolf)
    [13950] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds', tooltip = T.Generic_Knockdown }, -- Flurry (Werewolf)
    [9467] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Flurry (Werewolf)
    [60636] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_attackheavy.dds' }, -- Flurry (Werewolf)
    [44055] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', tooltip = T.Skill_Devour_NPC }, -- Devour (Werewolf)
    --[5785] = { icon = 'esoui/art/icons/mos_dagrund_upheavel.dds' }, -- Blood Scent (Werewolf)

    -- Wraith
    [4323] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_frost_ranged.dds' }, -- Ice Bolt (Wraith)
    [4337] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Wraith)
    [4346] = { icon = 'esoui/art/icons/ability_mage_037.dds' }, -- Winter's Reach (Wraith)
    [43146] = { icon = 'esoui/art/icons/ability_mage_037.dds', tooltip = T.Generic_Immobilize }, -- Winter's Reach (Wraith)

    -- Zombie
    [2954] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }, -- Swipe (Zombie)
    [13972] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }, -- Swipe (Zombie)
    [63614] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_swipe.dds' }, -- Swipe (Zombie)
    [2969] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds' }, -- Pound (Zombie)
    [2960] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Zombie)
    [30347] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Zombie)
    [72980] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_singing_strike.dds' }, -- Singing Strike (Defiled Aegis)
    [72981] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_singing_strike.dds' }, -- Singing Strike (Defiled Aegis)
    [72979] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_dissonant_blow.dds' }, -- Dissonant Blow (Defiled Aegis)
    [72995] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_symphony_of_blades.dds' }, -- Symphony of Blades (Defiled Aegis)
    [72996] = { icon = 'LuiExtended/media/icons/abilities/ability_defiledaegis_symphony_of_blades.dds', hide = true }, -- Symphony of Blades (Defiled Aegis)
    [73020] = { hide = true }, -- Shattered Harmoney (Defiled Aegis)
    [73021] = { hide = true }, -- Shattered Harmony (Defiled Aegis)
    [76180] = { hide = true, icon = 'esoui/art/icons/achievement_thievesguild_029.dds' }, -- Shattered Harmony (Defiled Aegis)
    [73025] = { hide = true }, -- Tomb Guardian (Defiled Aegis)
    [73322] = { hide = true }, -- Shattered Harmony (Defiled Aegis)
    [74993] = { hide = true }, -- Shattered Harmony (Defiled Aegis)

    -- Vvardenfell NPC'S
    [88361] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_fright_force_o.dds', hide = true }, -- Vile Flare (Skaafin Masquer)
    [88327] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_o.dds' }, -- Shadeway (Skaafin Masquer)
    [88339] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_o.dds', hide = true }, -- Shadeway (Skaafin Masquer)
    [88341] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_o.dds', tooltip = T.Generic_Stun }, -- Shadeway (Skaafin Masquer)
    [88325] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_o.dds', hide = true }, -- Pool of Shadow (Skaafin Masquer)
    [88336] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_o.dds' }, -- Pool of Shadow (Skaafin Masquer)
    [88330] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_o.dds', groundLabel = true, tooltip = T.Generic_AOE_Magic_0_5_Sec }, -- Pool of Shadow (Skaafin Masquer)
    [88335] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_o.dds' }, -- Pool of Shadow (Skaafin Masquer)
    [88334] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_o.dds', groundLabel = true, tooltip = T.Generic_AOE_Magic_0_5_Sec }, -- Pool of Shadow (Skaafin Masquer)
    [88353] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88358] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88348] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_o.dds', tooltip = T.Skill_Shadowy_Duplicate }, -- Shadowy Duplicate (Skaafin Masquer)
    [88350] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88346] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_barrier_o.dds', name = A.Skill_Shadowy_Barrier, duration = 295, tooltip = T.Skill_Shadowy_Barrier }, -- Shadowy Duplicate (Skaafin Masquer)
    [88342] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88383] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88351] = { hide = true }, -- Shadowy Duplicate (Skaafin Masquer)
    [88349] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_o.dds' }, -- Shadowy Duplicate (Skaafin Masquer)
    [88354] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_o.dds', tooltip = T.Generic_Stun }, -- Shadowy Duplicate (Skaafin Masquer)
    [81545] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_fright_force_p.dds', hide = true }, -- Fright Force (Malacath Voidbringer)
    [76621] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_p.dds' }, -- Shadeway (Malacath Voidbringer)
    [76784] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_p.dds', hide = true }, -- Shadeway (Malacath Voidbringer)
    [76843] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadeway_p.dds', tooltip = T.Generic_Stun }, -- Shadeway (Malacath Voidbringer)
    [76619] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_p.dds', hide = true }, -- Pool of Shadow (Malacath Voidbringer)
    [76730] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_p.dds' }, -- Pool of Shadow (Malacath Voidbringer)
    [76624] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_p.dds', groundLabel = true, tooltip = T.Generic_AOE_Magic_0_5_Sec }, -- Pool of Shadow (Malacath Voidbringer)
    [76729] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_p.dds' }, -- Pool of Shadow (Malacath Voidbringer)
    [76728] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_pool_of_shadow_p.dds', groundLabel = true, tooltip = T.Generic_AOE_Magic_0_5_Sec }, -- Pool of Shadow (Malacath Voidbringer)
    [77005] = { hide = true }, -- Shadowy Duplicate (Malacath Voidbringer)
    [80211] = { hide = true }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76979] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_p.dds', tooltip = T.Skill_Shadowy_Duplicate }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76995] = { hide = true }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76969] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_barrier_p.dds', name = A.Skill_Shadowy_Barrier, duration = 295, tooltip = T.Skill_Shadowy_Barrier }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76955] = { hide = true }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76996] = { hide = true }, -- Shadowy Duplicate (Malacath Voidbringer)
    [76985] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_p.dds' }, -- Shadowy Duplicate (Malacath Voidbringer)
    [77009] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_shadowy_duplicate_p.dds', tooltip = T.Generic_Stun }, -- Shadowy Duplicate (Malacath Voidbringer)
    [84817] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_skaafin_flare.dds' }, -- Skaafin Flare (Skaafin Witchling)
    [84815] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_skaafin_flare.dds' }, -- Skaafin Flare (Skaafin Witchling)
    [84818] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_fiendish_healing.dds', tooltip = T.Skill_Fiendish_Healing }, -- Fiendish Healing (Skaafin Witchling)
    [84829] = { icon = 'esoui/art/icons/ability_warrior_025.dds', name = A.Skill_Enrage, tooltip = T.Skill_Wamasu_Static }, -- Fiendish Healing (Skaafin Witchling)
    [84833] = { hide = true }, -- Fiendish Healing (Skaafin Witchling)
    [84835] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_broken_pact.dds', hide = true }, -- Broken Pact (Skaafin)
    [84837] = { icon = 'LuiExtended/media/icons/abilities/ability_nightblade_broken_pact.dds', hide = true }, -- Broken Pact (Skaafin)
    [77020] = { hide = true }, -- Basilisk Powder (Tracker)
    [77089] = { icon = 'esoui/art/icons/ability_rogue_056.dds' }, -- Basilisk Powder (Tracker)
    [77087] = { icon = 'esoui/art/icons/ability_rogue_056.dds', hide = true }, -- Basilisk Powder (Tracker)
    [77086] = { icon = 'esoui/art/icons/ability_rogue_056.dds', tooltip = T.Skill_Basilisk_Powder }, -- Basilisk Powder (Tracker)
    [79954] = { icon = 'esoui/art/icons/ability_rogue_056.dds', tooltip = T.Skill_Basilisk_Powder, hideReduce = true }, -- Basilisk Powder (Tracker)
    [77019] = { icon = 'esoui/art/icons/ability_rogue_055.dds', hide = true }, -- Pin (Tracker)
    [77030] = { icon = 'esoui/art/icons/ability_rogue_055.dds', tooltip = T.Generic_Immobilize }, -- Pin (Tracker)
    [78432] = { icon = 'esoui/art/icons/ability_rogue_066.dds' }, -- Lunge (Tracker)
    [79955] = { hide = true}, -- Lunge (Tracker)
    [78435] = { icon = 'esoui/art/icons/ability_rogue_066.dds' }, -- Lunge (Tracker)
    [79930] = { icon = 'esoui/art/icons/ability_rogue_066.dds', tooltip = T.Generic_Knockback }, -- Lunge (Tracker)
    [79929] = { icon = 'esoui/art/icons/ability_rogue_066.dds' }, -- Lunge (Tracker)
    [88481] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_spectral_claw.dds' }, -- Spectral Claw (Beastcaller)
    [88478] = { icon = 'esoui/art/icons/ability_warden_014.dds', hide = true }, -- Swarm (Beastcaller)
    [88371] = { icon = 'esoui/art/icons/ability_warden_013.dds' }, -- Dive (Beastcaller)
    [88393] = { icon = 'esoui/art/icons/ability_warden_013.dds' }, -- Dive (Beastcaller)
    [88394] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_gore.dds' }, -- Gore (Beastcaller)
    [88400] = { icon = 'LuiExtended/media/icons/abilities/ability_warden_gore.dds', hide = true }, -- Gore (Beastcaller)
    [88409] = { icon = 'esoui/art/icons/ability_warden_018.dds', name = A.Skill_Feral_Guardian, tooltip = T.Skill_Feral_Guardian_NPC }, -- Raise the Earth (Beastcaller)
    [92303] = { hide = true }, -- Despawn Override (Beastcaller)
    [92158] = { icon = 'LuiExtended/media/icons/abilities/ability_debuff_weakness.dds', name = A.Skill_Weakness, duration = -60, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Skill_Weakness_NPC_Summon }, -- Raise the Earth (Beastcaller)
    [87854] = { icon = 'LuiExtended/media/icons/abilities/ability_bow_attacklight.dds', hide = true }, -- Quick Shot
    [87855] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_arrow_stab.dds' }, -- Arrow Stab (Arbalest)
    [87901] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bombard.dds' }, -- Bombard (Arbalest)
    [90399] = { hide = true}, -- Bombard (Arbalest)
    [87902] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bombard.dds', hide = true }, -- Bombard (Arbalest)
    [87713] = { icon = 'esoui/art/icons/ability_warrior_045.dds' }, -- Quakeshot (Arbalest)
    [87837] = { hide = true}, -- Quakeshot (Arbalest)
    [87852] = { hide = true}, -- Quakeshot (Arbalest)
    [87422] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_snare_frost.dds' }, -- Chilled Ground (Arbalest)
    [87491] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_snare_frost.dds', duration = 0, groundLabel = true, tooltip = T.Generic_Snare_40_No_Dur }, -- Chilled Ground (Arbalest)
    [86881] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }, -- Hack (Sixth House Supplicant)
    [86882] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }, -- Hack (Sixth House Supplicant)
    [86883] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }, -- Slash (Sixth House Supplicant)
    [86884] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_hammer_light.dds' }, -- Slash (Sixth House Supplicant)
    [85342] = { icon = 'esoui/art/icons/ability_dualwield_001.dds' }, -- Twin Slashes (Sixth House Supplicant)
    [85343] = { icon = 'esoui/art/icons/ability_dualwield_001.dds' }, -- Twin Slashes (Sixth House Supplicant)
    [85368] = { icon = 'esoui/art/icons/ability_dualwield_001.dds', name = A.Skill_Twin_Slashes, tooltip = T.Generic_Bleed_2_Sec }, -- Twin Slashes Bleed (Sixth House Supplicant)
    [86879] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_shovel_light.dds' }, -- Chop (Drudge)
    [86880] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_shovel_light.dds' }, -- Hack (Drudge)
    [85359] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_shovel_heavy.dds', name = A.Skill_Clobber }, -- Reverse Slash (Drudge)
    [85365] = { hide = true }, -- Assassinate Bonus (Drudge)
    [86704] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_pickaxe_light.dds' }, -- Chop (Hleran Noble)
    [86705] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_peasant_pickaxe_light.dds' }, -- Lop (Hleran Noble)
    [85361] = { icon = 'esoui/art/icons/ability_1handed_002.dds' }, -- Puncture (Hleran Noble)
    [85362] = { icon = 'esoui/art/icons/ability_debuff_major_fracture.dds', tooltip = A.Skill_Puncture }, -- Major Fracture (Hleran Noble)
    [87064] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris (Fire-Binder)
    [87065] = { hide = true }, -- Volcanic Debris (Fire-Binder)
    [92647] = { hide = true }, -- Volcanic Debris (Fire-Binder)
    [87069] = { icon = 'esoui/art/icons/ability_mage_006.dds', hide = true }, -- Volcanic Debris (Fire-Binder)
    [87068] = { icon = 'esoui/art/icons/ability_mage_006.dds', tooltip = T.Generic_Knockback }, -- Volcanic Debris (Fire-Binder)
    [87066] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris (Fire-Binder)
    [88845] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_empower_atronach.dds', tooltip = T.Skill_Empower_Atronach }, -- Empower Atronach (Fire-Binder)

    ----------------------------------------------------------------
    -- EVENT QUESTS ---------------------------------------------
    ----------------------------------------------------------------

    -- Jester's Festival
    [87474] = { icon = 'LuiExtended/media/icons/abilities/ability_event_flower_garland.dds', name = A.Event_Petal_Pelters }, -- Flower Garland -- Springtime Flair

    [88095] = { icon = 'LuiExtended/media/icons/abilities/ability_event_dazzler_3.dds', name = A.Event_Sparkle_Dazzler }, -- Illusion Dazzler - Royal Revelry
    [88123] = { icon = 'LuiExtended/media/icons/abilities/ability_event_dazzler_2.dds', name = A.Event_Burst_Dazzler }, -- Illusion Dazzler - Royal Revelry
    [88124] = { icon = 'LuiExtended/media/icons/abilities/ability_event_dazzler_1.dds', name = A.Event_Flash_Dazzler }, -- Illusion Dazzler - Royal Revelry


    -- New Life Festival
    [84847] = {icon = 'LuiExtended/media/icons/abilities/ability_event_celebratory_belch.dds', name = A.Skill_Celebratory_Belch, unbreakable = 1 }, -- Celebratory Belch (Stonetooth Bash)
    [83523] = { icon = 'LuiExtended/media/icons/abilities/ability_event_freezing.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Event_Freezing }, -- Freezing (Snow Bear Plunge)
    [83522] = { icon = 'LuiExtended/media/icons/abilities/ability_event_warm.dds', forcedContainer = 'short', tooltip = T.Event_Warm }, -- Warm (Snow Bear Plunge)

    -- Seasonal Quests (New Life Festival)
    [84125] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Breton Male Dance (Lava Foot Stomp)
    [84126] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Breton Female Dance (Lava Foot Stomp)
    [84127] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Dunmer Male Dance (Lava Foot Stomp)
    [84128] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Dunmer Female Dance (Lava Foot Stomp)
    [84130] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Altmer Male Dance (Lava Foot Stomp)
    [84131] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Altmer Female Dance (Lava Foot Stomp)
    [84133] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, unbreakable = 1 }, -- Nord Dance (Lava Foot Stomp)
    [84528] = {icon = 'LuiExtended/media/icons/abilities/ability_event_torch_juggling.dds', name = A.Skill_Torch_Juggling, unbreakable = 1 }, -- Flame Juggling (Castle Charm Challenge)
    [84506] = {icon = 'LuiExtended/media/icons/abilities/ability_event_knife_juggling.dds', name = A.Skill_Knife_Juggling, unbreakable = 1 }, -- Dagger Juggling (Castle Charm Challenge)
    [84533] = {icon = 'LuiExtended/media/icons/abilities/ability_event_sword_swallowing.dds', name = A.Skill_Sword_Swallowing, unbreakable = 1 }, -- Sword Swallowing (Castle Charm Challenge)
    [84330] = { icon = 'esoui/art/icons/achievement_newlifefestival_001.dds', name = A.Memento_Mud_Ball }, -- Mudball (Mud Ball Merriment)

    -- Seasonal Quests (Witches Festival)
    [83775] = { icon = 'LuiExtended/media/icons/mementos/memento_witchmothers_whistle.dds', name = A.Event_Crow_Caller }, -- Event - Q5742 WitchFest Intro (The Witchmother's Bargain)

    ----------------------------------------------------------------
    -- CYRODIIL ----------------------------------------------------
    ----------------------------------------------------------------

    [39671] = { icon = 'esoui/art/icons/achievement_ic_024.dds', passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_emperorship_alliance_bonus.dds' }, -- Emperorship Alliance Bonus
    [11346] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_home_keep_bonus.dds', passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_home_keep_bonus.dds' }, -- Home Keep Bonus
    [11341] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 1, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds' }, -- Enemy Keep Bonus I
    [11343] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 2, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds' }, -- Enemy Keep Bonus II
    [11345] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 3, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds' }, -- Enemy Keep Bonus III
    [11347] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 4, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds' }, -- Enemy Keep Bonus IV
    [11348] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 5, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds' }, -- Enemy Keep Bonus V
    [11350] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 6, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds' }, -- Enemy Keep Bonus VI
    [11352] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 7, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds' }, -- Enemy Keep Bonus VII
    [11353] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 8, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds' }, -- Enemy Keep Bonus VIII
    [11356] = { icon = 'esoui/art/icons/achievement_midyearevent_008.dds', stack = 9, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_enemy_keep_bonus.dds' }, -- Enemy Keep Bonus IX
    [15060] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_defensive_scroll_bonus.dds', stack = 1, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_defensive_scroll_bonus.dds' }, -- Defensive Scroll Bonus I
    [16350] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_defensive_scroll_bonus.dds', stack = 2, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_defensive_scroll_bonus.dds' }, -- Defensive Scroll Bonus II
    [15058] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_offensive_scroll_bonus.dds', stack = 1, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_offensive_scroll_bonus.dds' }, -- Offensive Scroll Bonus I
    [16348] = { icon = 'LuiExtended/media/icons/abilities/ability_cyrodiil_offensive_scroll_bonus.dds', stack = 2, passiveIcon = 'LuiExtended/media/icons/abilities/passive_cyrodiil_offensive_scroll_bonus.dds' }, -- Offensive Scroll Bonus II

    [66282] = { icon = 'esoui/art/icons/achievement_ic_007_c.dds', tooltip = T.Skill_Blessing_of_War }, -- Blessing of War

    [15177] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short', tooltip = T.Skill_Elder_Scroll_Altadoon }, -- Elder Scroll of Altadoon
    [15178] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short', tooltip = T.Skill_Elder_Scroll_Mnem }, -- Elder Scroll of Mnem
    [22282] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short', tooltip = T.Skill_Elder_Scroll_Ghartok }, -- Elder Scroll of Ghartok
    [22295] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short', tooltip = T.Skill_Elder_Scroll_Chim }, -- Elder Scroll of Chim
    [22297] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short', tooltip = T.Skill_Elder_Scroll_Ni_Mohk }, -- Elder Scroll of Ni-Mohk
    [22299] = { icon = 'esoui/art/icons/achievement_068.dds', forcedContainer = 'short', tooltip = T.Skill_Elder_Scroll_Alma_Ruma }, -- Elder Scroll of Alma Ruma

    [109862] = { hide = true }, -- Stronger Walls
    [109944] = { hide = true }, -- Stronger Doors
    [64674] = { icon = 'esoui/art/icons/ava_siege_hookpoint_005.dds', name = A.Skill_Guard_Detection, tooltip = T.Skill_Guard_Detection }, -- Cyrodiil Guard See Stealth
    [8077] = { hide = true }, -- Increased Guard Health
    [8639] = { hide = true }, -- Increased Damage
    [43754] = { hide = true }, -- Heavily Resistant Guards
    [8657] = { hide = true }, -- Heavily Armored Guards
    [8658] = { hide = true }, -- Eagle Eye Guards
    [25873] = { hide = true }, -- heal
    [72059] = { hide = true }, -- Portal Spawn

    [64197] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_sanctuary.dds', forcedContainer = 'short', tooltip = T.Skill_AvA_Sanctuary }, -- Sanctuary Cyrodiil passive is considered unlimited duration, but the effect is only while the player is in the area. Should show up under short buffs.
    [52291] = { hide = true }, -- Chain Pull Range Suppression
    [96091] = { hide = true }, -- Frozen Gate Suppression
    [97414] = { hide = true }, -- Nature Grasp Suppression
    [59079] = { hide = true }, -- Dragon Leap Range Suppression
    [90095] = { hide = true }, -- Falling Damage Reduction

    -- Siege Weapons

    [12256] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_pack_siege.dds', name = A.Skill_Stow_Siege_Weapon }, -- Pack Siege (Generic Siege)

    [29673] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Ballista) }, -- Create Ballista Bolt... (Ballista)
    [29672] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Ballista) }, -- Create Ballista Bolt... (Ballista)
    [29671] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Ballista) }, -- Create Ballista Bolt... (Ballista)
    [7468] = { icon = 'esoui/art/icons/ava_siege_ammo_006.dds' }, -- Ballista Bolt (Ballista)
    [7469] = { icon = 'esoui/art/icons/ava_siege_ammo_006.dds' }, -- Ballista Bolt (Ballista)
    [13043] = { icon = 'esoui/art/icons/ava_siege_ammo_006.dds' }, -- Ballista Bolt (Ballista)

    [30611] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Fire_Ballista) }, -- Create Ballista Fire Bolt... (Fire Ballista)
    [30607] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Fire_Ballista) }, -- Create Ballista Fire Bolt... (Fire Ballista)
    [16751] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Fire_Ballista) }, -- Create Ballista Fire Bolt... (Fire Ballista)
    [16775] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_fire_ballista_bolt.dds' }, -- Fire Ballista Bolt (Fire Ballista)
    [28480] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_fire_ballista_bolt.dds', tooltip = T.Generic_Burn_2_Sec }, -- Fire Ballista Bolt (Fire Ballista)
    [14367] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_fire_ballista_bolt.dds' }, -- Fire Ballista Bolt (Fire Ballista)

    [30612] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Lightning_Ballista) }, -- Create Ballista Lightning Bolt ... (Lightning Ballista)
    [30608] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Lightning_Ballista) }, -- Create Ballista Lightning Bolt ... (Lightning Ballista)
    [16752] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Lightning_Ballista) }, -- Create Ballista Lightning Bolt ... (Lightning Ballista)
    [14363] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_lightning_ballista_bolt.dds' }, -- Lightning Ballista Bolt (Lightning Ballista)
    [14364] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_lightning_ballista_bolt.dds', tooltip = T.Skill_Lightning_Ballista_Bolt }, -- Lightning Ballista Bolt (Lightning Ballista)
    [16776] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_lightning_ballista_bolt.dds' }, -- Lightning Ballista Bolt (Lightning Ballista)
    [76103] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_lightning_ballista_bolt.dds', name = A.Skill_Lightning_Ballista_Bolt }, -- Magicka Hit (Lightning Ballista)
    [30454] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_lightning_ballista_bolt.dds' }, -- Lightning Ballista Bolt (Lightning Ballista)

    [39914] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Stone_Trebuchet) }, -- Create Trebuchet... (Stone Trebuchet)
    [39917] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Stone_Trebuchet) }, -- Create Trebuchet... (Stone Trebuchet)
    [39910] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Stone_Trebuchet) }, -- Create Trebuchet... (Stone Trebuchet)

    [39913] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Iceball_Trebuchet) }, -- Create Trebuchet... (Iceball Trebuchet)
    [39916] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Iceball_Trebuchet) }, -- Create Trebuchet... (Iceball Trebuchet)
    [39909] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Iceball_Trebuchet) }, -- Create Trebuchet... (Iceball Trebuchet)
    [13551] = { icon = 'esoui/art/icons/ava_siege_ammo_002.dds' }, -- Iceball Trebuchet (Iceball Trebuchet)
    [64105] = { icon = 'esoui/art/icons/ava_siege_ammo_002.dds' }, -- Iceball Trebuchet (Iceball Trebuchet)
    [13588] = { icon = 'esoui/art/icons/ava_siege_ammo_002.dds', tooltip = T.Generic_Snare_50 }, -- Iceball Trebuchet (Iceball Trebuchet)
    [13552] = { icon = 'esoui/art/icons/ava_siege_ammo_002.dds' }, -- Iceball Trebuchet (Iceball Trebuchet)

    [13665] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Firepot_Trebuchet) }, -- Create Trebuchet... (Firepot Trebuchet)
    [13664] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Firepot_Trebuchet) }, -- Create Trebuchet... (Firepot Trebuchet)
    [13663] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Firepot_Trebuchet) }, -- Create Trebuchet... (Firepot Trebuchet)
    [7010] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_firepot_trebuchet.dds' }, -- Firepot Trebuchet (Firepot Trebuchet)
    [7429] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_firepot_trebuchet.dds' }, -- Firepot Trebuchet (Firepot Trebuchet)
    [28483] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_firepot_trebuchet.dds', tooltip = T.Generic_Burn_2_Sec }, -- Firepot Trebuchet (Firepot Trebuchet)
    [25869] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_firepot_trebuchet.dds', tooltip = T.Generic_Burn_2_Sec }, -- Firepot Trebuchet (Firepot Trebuchet)

    [30613] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_catapult.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Meatbag_Catapult) }, -- Create Catapult Meatbag (Meatbag Catapult)
    [30609] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_catapult.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Meatbag_Catapult) }, -- Create Catapult Meatbag (Meatbag Catapult)
    [16755] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_catapult.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Meatbag_Catapult) }, -- Create Catapult Meatbag (Meatbag Catapult)
    [88714] = { tooltip = T.Skill_Meatbag_Catapult_Ground }, -- Meatbag (Meatbag Catapult)
    [14774] = { icon = 'esoui/art/icons/ava_siege_ammo_003.dds' }, -- Meatbag Catapult (Meatbag Catapult)
    [104693] = { icon = 'esoui/art/icons/ava_siege_ammo_003.dds', tooltip = T.Skill_Meatbag_Catapult_AOE, groundLabel = true }, -- Meatbag Catapult (Meatbag Catapult)
    [32036] = { icon = 'esoui/art/icons/ava_siege_ammo_003.dds', tooltip = T.Skill_Meatbag_Catapult }, -- Meatbag Catapult (Meatbag Catapult)
    [36408] = { icon = 'esoui/art/icons/ava_siege_ammo_003.dds', type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Generic_Disease_2_Sec }, -- Meatbag Catapult (Meatbag Catapult)

    [30614] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_catapult.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Oil_Catapult) }, -- Create Catapult Oil Jar... (Oil Catapult)
    [30610] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_catapult.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Oil_Catapult) }, -- Create Catapult Oil Jar... (Oil Catapult)
    [16754] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_catapult.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Oil_Catapult) }, -- Create Catapult Oil Jar... (Oil Catapult)
    [104700] = { tooltip = T.Skill_Oil_Catapult_Ground }, -- Twisting Path (Oil Catapult)
    [16789] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_oil_catapult.dds' }, -- Oil Catapult (Oil Catapult)
    [104699] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_oil.dds', tooltip = T.Generic_Snare_50 }, -- Oil Catapult (Oil Catapult)
    [64108] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_oil_catapult.dds' }, -- Oil Catapult (Oil Catapult)
    [76105] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_oil_catapult.dds', name = A.Skill_Oil_Catapult }, -- Stamina Hit (Oil Catapult)
    [16790] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_oil_catapult.dds' }, -- Oil Catapult (Oil Catapult)

    [39915] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_catapult.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Scattershot_Catapult) }, -- Create Catapult Meatbag (Scattershot Catapult)
    [39918] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_catapult.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Scattershot_Catapult) }, -- Create Catapult Oil Jar... (Scattershot Catapult)
    [39911] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_catapult.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Scattershot_Catapult) }, -- Create Trebuchet... (Scattershot Catapult)
    [104690] = { tooltip = T.Skill_Scattershot_Catapult_Ground }, -- Twisting Path (Scattershot Catapult)
    [14611] = { icon = 'esoui/art/icons/ava_siege_ammo_005.dds' }, -- Scattershot Catapult (Scattershot Catapult)
    [104695] = { icon = 'esoui/art/icons/ava_siege_ammo_005.dds', tooltip = T.Skill_Scattershot_Catapult_AOE, groundLabel = true }, -- Scattershot Catapult (Scattershot Catapult)
    [104696] = { icon = 'esoui/art/icons/ava_siege_ammo_005.dds', tooltip = T.Skill_Scattershot_Catapult }, -- Scattershot Catapult (Scattershot Catapult)

    [66438] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_stone_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Cold_Stone_Trebuchet) }, -- Create Trebuchet... (Cold Stone Trebuchet)
    [66439] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_stone_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Cold_Stone_Trebuchet) }, -- Create Trebuchet... (Cold Stone Trebuchet)
    [66440] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_stone_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Cold_Stone_Trebuchet) }, -- Create Trebuchet... (Cold Stone Trebuchet)
    [66250] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_stone_trebuchet_shot.dds', name = A.Skill_Cold_Stone_Trebuchet }, -- Stone Cold Trebuchet (Cold Stone Trebuchet)
    [66251] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_stone_trebuchet_shot.dds', name = A.Skill_Cold_Stone_Trebuchet }, -- Stone Cold Trebuchet (Cold Stone Trebuchet)
    [66252] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_stone_trebuchet_shot.dds', name = A.Skill_Cold_Stone_Trebuchet }, -- Stone Cold Trebuchet (Cold Stone Trebuchet)

    [66434] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Cold_Fire_Trebuchet) }, -- Create Trebuchet... (Cold Fire Trebuchet)
    [66388] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Cold_Fire_Trebuchet) }, -- Create Trebuchet... (Cold Fire Trebuchet)
    [66387] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_trebuchet.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Cold_Fire_Trebuchet) }, -- Create Trebuchet... (Cold Fire Trebuchet)
    [66246] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_trebuchet_shot.dds', name = A.Skill_Cold_Fire_Trebuchet }, -- Firepot Trebuchet (Cold Fire Trebuchet)
    [66247] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_trebuchet_shot.dds', name = A.Skill_Cold_Fire_Trebuchet, tooltip = T.Generic_Burn_2_Sec }, -- Firepot Trebuchet (Cold Fire Trebuchet)
    [66248] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_trebuchet_shot.dds', name = A.Skill_Cold_Fire_Trebuchet }, -- Firepot Trebuchet (Cold Fire Trebuchet)
    [66245] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_trebuchet_shot.dds', name = A.Skill_Cold_Fire_Trebuchet, tooltip = T.Generic_Burn_2_Sec }, -- Cold Harbor Trebuchet (Cold Fire Trebuchet)

    [66437] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Cold_Fire_Ballista) }, -- Create Ballista... (Cold Fire Ballista)
    [66436] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Cold_Fire_Ballista) }, -- Create Ballista... (Cold Fire Ballista)
    [66435] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_ballista.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Cold_Fire_Ballista) }, -- Create Ballista... (Cold Fire Ballista)
    [66242] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_ballista_bolt.dds', name = A.Skill_Cold_Fire_Ballista_Bolt }, -- Fire Ballista Bolt (Cold Fire Ballista)
    [66244] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_ballista_bolt.dds', name = A.Skill_Cold_Fire_Ballista_Bolt }, -- Fire Ballista Bolt (Cold Fire Ballista)
    [66243] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_cold_fire_ballista_bolt.dds', name = A.Skill_Cold_Fire_Ballista_Bolt, tooltip = T.Generic_Burn_2_Sec }, -- Cold Harbor Ballista Bolt (Cold Fire Ballista)

    [22570] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_flaming_oil.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Deploy, A.Skill_Flaming_Oil) }, -- Create Boiling Oil... (Flaming Oil)
    [15775] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_burning_oil.dds', tooltip = T.Generic_Burn_2_Sec }, -- Flaming oil (Flaming Oil)
    [15776] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_burning_oil.dds', name = A.Skill_Flaming_Oil, tooltip = T.Generic_Burn_2_Sec }, -- Flaming oil (Flaming Oil)

    [15876] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ram.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Covenant, A.Skill_Battering_Ram) }, -- Create Large Ram... (Battering Ram)
    [16171] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ram.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Pact, A.Skill_Battering_Ram) }, -- Create Large Ram... (Battering Ram)
    [16170] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_ram.dds', name = zo_strformat("<<1>> <<2>> <<3>>", A.Skill_Deploy, A.Skill_Dominion, A.Skill_Battering_Ram) }, -- Create Large Ram... (Battering Ram)

    [12355] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds' }, -- Destroy Siege Weapon

    [13853] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_repair_kit_wall.dds', name = A.Skill_Keep_Wall_Repair_Kit }, -- Wall Repair Kit
    [16723] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_repair_kit_door.dds', name = A.Skill_Keep_Door_Repair_Kit }, -- Door Repair Kit
    [13601] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_repair_kit_siege.dds', name = A.Skill_Siege_Repair_Kit }, -- Advanced Siege Repair Kit
    [112975] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_repair_kit_bridge.dds', name = A.Skill_Bridge_Repair_Kit }, -- Wall Repair Kit (Bridge and Milegate Repair Kit)

    [19039] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_forward_camp_ep.dds', name = A.Skill_Pact_Forward_Camp }, -- Ebonheart Forward Camp
    [19040] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_forward_camp_ad.dds', name = A.Skill_Dominion_Forward_Camp }, -- Aldmeri Forward Camp
    [19041] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_forward_camp_dc.dds', name = A.Skill_Covenant_Forward_Camp }, -- Daggerfall Forward Camp

    -- Siege Warfare
    [35106] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_firepot_trebuchet.dds' , name = A.Skill_Firepot_Trebuchet }, -- Fire (Firepot Trebuchet)
    [35099] = { icon = 'esoui/art/icons/ava_siege_ammo_002.dds', name = A.Skill_Iceball_Trebuchet }, -- Ice Damage (Iceball Trebuchet)
    [35112] = { icon = 'esoui/art/icons/ava_siege_ammo_004.dds', name = A.Skill_Stone_Trebuchet }, -- Stoneball (Stone Trebuchet)
    [35094] = { icon = 'esoui/art/icons/ava_siege_ammo_006.dds', name = A.Skill_Ballista_Bolt }, -- Bolt (Ballista)
    [35055] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_fire_ballista_bolt.dds', name = A.Skill_Fire_Ballista_Bolt }, -- Fire (Firebolt Ballista)
    [35080] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_lightning_ballista_bolt.dds', name = A.Skill_Lightning_Ballista_Bolt }, -- Bolt (Lightning Ballista)
    [35121] = { icon = 'esoui/art/icons/ava_siege_ammo_005.dds', name = A.Skill_Scattershot_Catapult }, -- Ice Damage (Scattershot Catapult)
    [35136] = { icon = 'esoui/art/icons/ava_siege_ammo_003.dds' , name = A.Skill_Meatbag_Catapult }, -- Meatbag (Meatbag Catapult)
    [35132] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_oil_catapult.dds', name = A.Skill_Oil_Catapult }, -- Oil Pot (Oil Catapult)
    [33348] = { icon = 'LuiExtended/media/icons/abilities/ability_ava_repair_kit_practice_siege.dds' }, -- Practice Siege Repair Kit (Practice Siege Repair Kit)

    ----------------------------------------------------------------
    -- BATTLEGROUNDS -------------------------------------------------------
    ----------------------------------------------------------------

    [95826] = { icon = 'esoui/art/icons/achievement_042.dds', name = A.Skill_Mark_of_the_Worm, unbreakable = 1, type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Skill_Mark_of_the_Worm }, -- Worm Cult Curse
    [95829] = { hide = true }, -- FX Dummy
    [95830] = { hide = true }, -- Mark of the Worm
    [95831] = { icon = 'esoui/art/icons/achievement_042.dds', }, -- Mark of the Worm

    [87949] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds' }, -- Lava (Foyada Quarry)
    [87948] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds', name = A.Trap_Lava, duration = 0, groundLabel = true, unbreakable = 1, tooltip = T.Trap_Lava }, -- Lava Snare (Foyada Quarry)

    [92757] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = A.Trap_Blade_Trap }, -- Spinning Blade (Blade Trap)
    [92759] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = A.Trap_Blade_Trap, tooltip = T.Generic_Bleed_1_Sec }, -- Serrated Blade (Blade Trap)

    ----------------------------------------------------------------
    -- TRAPS -------------------------------------------------------
    ----------------------------------------------------------------

    -- Traps & World Hazards
    [62230] = { hide = true }, -- Coldharbour Flames (Flame Trap)
    [62771] = { hide = true }, -- Coldharbour Flames (Flame Trap)
    [62769] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_coldharbour_flames.dds', name = A.Trap_Cold_Fire_Trap, tooltip = T.Generic_Burn_2_Sec }, -- Coldharbour Flames (Flame Trap)
    [62770] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_coldharbour_flames.dds', name = A.Trap_Cold_Fire_Trap }, -- Coldharbour Flames (Flame Trap)

    [20888] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds' }, -- Falling Rocks (Falling Rocks)
    [27479] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', unbreakable = 1, tooltip = T.Generic_Stun }, -- Falling Rocks (Falling Rocks)

    [21940] = { hide = true }, -- Spike Trap (Spike Trap)
    [21943] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds', hide = true }, -- Spike Trap (Spike Trap)
    [21941] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds', name = A.Trap_Spike_Trap, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Spike_Trap }, -- Spike Trap Snare (Spike Trap)
    [21942] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds', name = A.Trap_Spike_Trap, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Spike_Trap, hideReduce = true }, -- Trap Sprung (Spike Trap)

    [20482] = { hide = true }, -- Mistwatch Collapse (Cave-In)
    [20483] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds' }, -- Falling Rocks (Cave-In)
    [29602] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds' }, -- Falling Rocks (Cave-In)

    [17198] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds' }, -- Fire Trap (Player)
    [31606] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', groundLabel = true, unbreakable = 1, tooltip = T.Skill_Fire_Trap, hideGround = true }, -- Fire Trap (Player)
    [17314] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', groundLabel = true, unbreakable = 1, tooltip = T.Skill_Fire_Trap }, -- Fire Trap (Player)

    [72888] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', name = A.Trap_Fire_Trap, hide = true, groundLabel = true, unbreakable = 1, tooltip = T.Skill_Fire_Trap_Cells }, -- Fire Attack 1 (Fire) -- Banished Cells II
    [72889] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', name = A.Trap_Fire_Trap, groundLabel = true, unbreakable = 1, tooltip = T.Skill_Fire_Trap_Cells }, -- Fire Attack 2 (Fire) -- Banished Cells II
    [72890] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', name = A.Trap_Fire_Trap, tooltip = T.Skill_Fire_Trap_Cells, groundLabel = true, unbreakable = 1, hideGround = true }, -- Laser Snare (Fire) -- Banished Cells II

    [26530] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Bear Trap (Bear Trap)
    [26531] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds' }, -- Bear Trap (Bear Trap)

    [20260] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_sigil_of_frost.dds', name = A.Trap_Sigil_of_Frost }, -- Rune Burst
    [20259] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_sigil_of_frost.dds', name = A.Trap_Sigil_of_Frost, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Sigil of Frost Snare

    -- Elinhir Private Arena
    [117428] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava_trap.dds', name = A.Trap_Lava_Trap }, -- Lava Eruption (Lava Trap)
    [118437] = { tooltip = A.Trap_Lava_Trap }, -- Lava Eruption (Lava Trap)
    [118438] = { tooltip = A.Trap_Lava_Trap }, -- Lava Eruption (Lava Trap)

    [117508] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds', name = A.Trap_Lightning_Trap }, -- Shock Wall (Lightning Trap)
    [117480] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds', tooltip = T.Generic_Snare_No_Dur, name = A.Trap_Lightning_Trap, duration = 0, groundLabel = true }, -- Shock Wall (Lightning Trap) -- TODO: Get snare %
    [117622] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds', name = A.Trap_Lightning_Trap }, -- Shock Wall (Lightning Trap)
    [117617] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds', tooltip = T.Generic_Snare_No_Dur, name = A.Trap_Lightning_Trap, duration = 0, groundLabel = true }, -- Shock Wall (Lightning Trap) -- TODO: Get snare %
    [117598] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds', name = A.Trap_Lightning_Trap }, -- Shock Wall (Lightning Trap)
    [117599] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_shock_wall.dds', tooltip = T.Generic_Snare_No_Dur, name = A.Trap_Lightning_Trap, duration = 0, groundLabel = true }, -- Shock Wall (Lightning Trap) -- TODO: Get snare %

    [117139] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = A.Trap_Blade_Trap }, -- Spinning Blade (Blade Trap), -- Spinning Blade
    [117145] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = A.Trap_Blade_Trap, tooltip = T.Generic_Bleed_0_5_Sec }, -- Spinning Blade (Blade Trap), -- Serrated Blade

    -- Lava & Slaughterfish
    [44029] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_slaughterfish.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Slaughterfish_Attack, groundLabel = true }, -- Slaughterfish Attack (Slaughterfish)
    [44034] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_slaughterfish.dds' }, -- Slaughterfish Attack (Slaughterfish)

    [113080] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_slaughterfish.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Slaughterfish_Attack, groundLabel = true }, -- Slaughterfish Attack (Slaughterfish)
    [113082] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_slaughterfish.dds' }, -- Slaughterfish Attack (Slaughterfish)

    [19224] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds', name = A.Trap_Lava }, -- In Lava (Lava - Halls of Torment)
    [11338] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds', name = A.Trap_Lava, tooltip = T.Skill_Lava, unbreakable = 1, groundLabel = true }, -- In Lava (Lava - The Earth Forge)

    -- Hiding Spot
    [72711] = { hide = true }, -- Hidden (Hiding Spot)
    [77335] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77336] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77337] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77338] = { hide = true }, -- Threat Drop (Hiding Spot)
    [77339] = { hide = true }, -- Threat Drop (Hiding Spot)
    [75670] = { hide = true }, -- Threat Drop (Hiding Spot)
    [75747] = { hide = true }, -- Hiding Spot (Hiding Spot)

    ----------------------------------------------------------------
    -- MAIN QUEST --------------------------------------------------
    ----------------------------------------------------------------

    -- Tutorial - Soul Shriven in Coldharbour
    [75527] = { hide = true }, -- Ultimate Protection (Tutorial)
    [64091] = { hide = true }, -- Power Bash (Tutorial - Used on Lyris)
    [61748] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Tutorial)
    [63269] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_heat_wave.dds', name = A.Skill_Wall_of_Flames }, -- Heat Wave
    [63270] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_heat_wave.dds', name = A.Skill_Wall_of_Flames, hide = true }, -- Heat Wave
    [63737] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (Dremora Churl)
    [63684] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing }, -- Uppercut (Dremora Caitiff)
    [63685] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing, tooltip = T.Generic_Knockback }, -- Uppercut Stun (Dremora Caitiff)
    [63686] = { icon = 'esoui/art/icons/ability_2handed_001_a.dds', name = A.Skill_Dizzying_Swing }, -- Uppercut (Dremora Caitiff)
    [63761] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_pound.dds' }, -- Pound (Feral Soul Shriven)
    [63752] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Feral Soul Shriven)
    [63753] = { icon = 'LuiExtended/media/icons/abilities/ability_zombie_vomit.dds' }, -- Vomit (Feral Soul Shriven)
    [63755] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds' }, -- Heat Wave (Skeletal Pyromancer)
    [63756] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_heat_wave.dds', hide = true }, -- Heat Wave - Used by Skeletal Pyromancer in Tutorial }, -- Heat Wave (Skeletal Pyromancer)
    [64072] = { icon = 'esoui/art/icons/ability_debuff_reveal.dds', type = BUFF_EFFECT_TYPE_DEBUFF, duration = 0, unbreakable = 1, tooltip = T.Generic_Stun_No_Dur, stack = 0 }, -- Eye of the Sentinel (CH Tutorial)
    [48345] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds', tooltip = T.Skill_Regeneration_Ogrim }, -- Focused Healing (The Prophet)
    [48346] = { hide = true }, -- Minor Wound (The Prophet)
    [63521] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw_tutorial.dds', name = A.Skill_Stomp }, -- Bone Crush (Child of Bones)
    [63522] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw_tutorial.dds', name = A.Skill_Stomp }, -- Bone Saw (Child of Bones)
    [61646] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_incapacitating_terror.dds', duration = 0, tooltip = T.Skill_Incapacitating_Terror }, -- Incapacitating Terror
    [64074] = { icon = 'LuiExtended/media/icons/abilities/ability_bone_colossus_incapacitating_terror.dds'}, -- Incapacitating Terror
    [75514] = { hide = true }, -- Greater Protection - CH Tutorial pointless aura
    [1718] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds', name = A.Skill_Light_Attack }, -- Attack
    [64772] = { hide = true }, -- MQ1 Input Lock LAtk - CH Tutorial pointless aura
    [63883] = { hide = true }, -- Major Protection - CH Tutorial pointless aura
    [64784] = { hide = true }, -- MQ1 Tutorial Block Heavy - CH Tutorial pointless aura
    [64798] = { hide = true }, -- MQ1 Heat Wave (Tutorial) - CH Tutorial pointless aura
    [61961] = { hide = true }, -- Perma Set Off Balance Target - CH Tutorial pointless aura
    [64677] = { hide = true }, -- MQ1 Tutorial Perma Off-Balance - CH Tutorial pointless aura
    [64069] = { hide = true }, -- Sentinel Barrier
    [64166] = { hide = true }, -- Major Protection - CH Tutorial pointless aura
    [63637] = { hide = true }, -- Teleport - CH Tutorial event when player teleports out

    -- Daughter of Giants
    [29994] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_inferno.dds' }, -- Inferno (Manifestation of Solitude)
    [27767] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Ancient Clannfear)
    [27769] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Ancient Clannfear)
    [27774] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds', name = A.Skill_Rending_Leap }, -- Knockdown (Ancient Clannfear)
    [27776] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds', name = A.Skill_Devour, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Feeding (Ancient Clannfear)
    [28718] = { hide = true }, -- Spawn (Manifestation of Terror)
    [28792] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gaze_alt.dds' }, -- Gaze (Manifestation of Terror)
    [28788] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze_alt.dds', name = A.Skill_Doom_Truths_Gaze }, -- MQ2_Boss_1_Doom-Truth'sGaze (Manifestation of Terror)
    [49958] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze_alt.dds', name = A.Skill_Doom_Truths_Gaze }, -- Fire Runes (Manifestation of Terror)
    [49961] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_doom-truths_gaze_alt.dds' }, -- Doom-Truth's Gaze (Manifestation of Terror)
    [28723] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gravity_well.dds' }, -- Gravity Well (Manifestation of Terror)
    [28730] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_gravity_well.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Gravity Well (Manifestation of Terror)
    [28745] = { hide = true }, -- Tentacle Whip (Manifestation of Terror)
    [28746] = { icon = 'LuiExtended/media/icons/abilities/ability_watcher_tentacle_whip.dds' }, -- Tentacle Whip (Manifestation of Terror)

    -- Castle of the Worm
    [41852] = { icon = 'LuiExtended/media/icons/abilities/ability_set_oblivion.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Necrotic, A.Skill_Barrier) }, -- Necrotic
    [16019] = { hide = true }, -- Bone Pile Explosion
    [33597] = { hide = true }, -- Invisible Underground
    [35794] = { hide = true }, -- Material Effect
    [33540] = { hide = true }, -- Intro Explosion
    [31244] = { hide = true }, -- Consuming Darkness
    [32563] = { hide = true }, -- Skeleton Stun Targetable
    [32561] = { hide = true }, -- Skeleton Stun
    [31232] = { hide = true }, -- Skeleton Stun Targetable
    [31222] = { hide = true }, -- Skeleton Stun
    [32557] = { hide = true }, -- Skeleton Stun Targetable
    [32555] = { hide = true }, -- Skeleton Stun
    [32558] = { hide = true }, -- Delay
    [32554] = { hide = true }, -- Delay
    [32564] = { hide = true }, -- Delay
    [32562] = { hide = true }, -- Ravager Weapons
    [32553] = { hide = true }, -- Ravager Weapons
    [32556] = { hide = true }, -- Fire Mage Weapons
    [34484] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds' }, -- Soul Cage (Mannimarco)
    [34470] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', name = A.Skill_Soul_Rupture }, -- Soul Cage (Mannimarco)
    [34463] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_rupture.dds', name = A.Skill_Soul_Rupture }, -- Soul Cage (Mannimarco)
    [34458] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds' }, -- Soul Cage (Mannimarco)
    [34460] = { icon = 'LuiExtended/media/icons/abilities/ability_lich_soul_cage.dds' }, -- Soul Cage (Mannimarco)
    [70409] = { icon = 'LuiExtended/media/icons/abilities/ability_set_sloads_semblance.dds' }, -- Necromantic Barrier
    [31321] = { hide = true }, -- Disruption
    [31334] = { hide = true }, -- Oblivion
    [31480] = { type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Overwhelming Power
    [31341] = { hide = true }, -- Unleashed Oblivion
    [14972] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, unbreakable = 1 }, -- CON_Knockback&Knockdown
    [14973] = { name = A.Skill_Knockback }, -- Fire Backlash

    -- Halls of Torment
    [36672] = { hide = true }, -- Summon Sword Saint
    [36858] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }, -- Swordstorm (Tharn Doppleganger)
    [36860] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds', name = A.Skill_Swordstorm }, -- Swordstorm damage (Tharn Doppleganger)
    [44561] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, unbreakable = 1 }, -- FGQ4 RGT Event Knockback
    [44563] = { name = A.Skill_Knockback }, -- Fire Backlash
    [37015] = { hide = true }, -- Lash of Torment
    [37173] = { icon = 'esoui/art/icons/ability_mage_010.dds' }, -- Flame Shield (Duchess of Anguish)
    [37176] = { hide = true }, -- Register (Duchess of Anguish)
    [37175] = { icon = 'esoui/art/icons/ability_mage_010.dds', name = A.Skill_Flame_Shield }, -- Flare Up (Duchess of Anguish)
    [38729] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_royal_strike.dds' }, -- Royal Strike (Duchess of Anguish)
    [38741] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_royal_strike.dds', name = A.Skill_Royal_Strike }, -- Royal Snare (Duchess of Anguish)
    [38728] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_daedra_fa_red.dds' }, -- Summon Daedra (Duchess of Anguish)

    -- Shadow of Sancre Tor
    [41021] = { hide = true }, -- Mannimarco's Triumph
    [39302] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_empower_atronach.dds' }, -- Necromantic Revival
    [39367] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_consecrate_shrine.dds', name = A.Skill_Consecrate_Shrine }, -- Altar Use
    [37827] = { hide = true, icon = 'esoui/art/icons/achievement_housing_033.dds', name = A.Skill_Remove_Ward }, -- Stendarr's Protection
    [46816] = { hide = true }, -- Shake
    [38207] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_death_bolt.dds', hide = true }, -- Death Bolt (Mannimarco)
    [41067] = { hide = true }, -- Dummy (Mannimarco)
    [40401] = { hide = true }, -- Daedric Step (Mannimarco)
    [40400] = { hide = true }, -- Daedric Step (Mannimarco)
    [40399] = { hide = true }, -- Daedric Step (Mannimarco)
    [38215] = { icon = 'esoui/art/icons/ability_mage_041.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Death's Gaze (Mannimarco)
    [38217] = { icon = 'esoui/art/icons/ability_mage_041.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, duration = 0 }, -- Death's Gaze (Mannimarco)
    [40425] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Shock, A.Skill_Nova) }, -- Impending Doom (Mannimarco)
    [40427] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Shock, A.Skill_Nova) }, -- Doom (Mannimarco)
    [40430] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_storm_bound.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Shock, A.Skill_Nova) }, -- Doom (Mannimarco)
    [41022] = { hide = true }, -- Nova (Mannimarco)
    [40429] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, unbreakable = 1 }, -- IntroKB (Mannimarco)
    [40426] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback }, -- Staggering Roar (Mannimarco)

    [40973] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_blue.dds', name = A.Skill_Unstable_Portal }, -- Portal Spawn (Mannimarco)
    [40978] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_blue.dds', name = A.Skill_Unstable_Portal }, -- Portal Spawn (Mannimarco)
    [40981] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_blue.dds', name = A.Skill_Unstable_Portal }, -- Portal Spawn (Mannimarco)

    [40976] = { hide = true }, -- dummy (Mannimarco)
    [44083] = { hide = true }, -- Ghostly (Mannimarco)
    [42083] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_portal_stabilize.dds', name = A.Skill_Stabilize_Portal }, -- PortalHoldstun (Mannimarco)
    [40573] = { hide = true }, -- StopPortalStun (Mannimarco)
    [40980] = { hide = true }, -- dummy (Mannimarco)
    [40983] = { hide = true }, -- dummy (Mannimarco)

    [41196] = { hide = true }, -- Smash (Molag Bal)
    [41198] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, unbreakable = 1 }, -- IntroKB (Mannimarco)
    [41197] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback }, -- Staggering Roar (Mannimarco)
    [41385] = { hide = true }, -- Dummystun (Molag Bal)

    -- Council of the Five Companions
    [36543] = { hide = true }, -- Portal Cast
    [36421] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_drink_mead.dds', name = A.Skill_Drink_Mead }, -- Drink with Lyris

    -- The Weight of Three Crowns
    [47186] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_close_unstable_rift.dds', name = A.Skill_Close_Unstable_Rift }, -- CHT Portal Killer


    ----------------------------------------------------------------
    -- QUESTS - FIGHTERS GUILD -------------------------------------
    ----------------------------------------------------------------

    -- Anchors from the Harbour
    [14974] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, unbreakable = 1 }, -- CON_Knockback&KnockdownSelf
    [14975] = { name = A.Skill_Knockback }, -- Fire Backlash

    -- The Prismatic Core
    [39357] = { hide = true }, -- Necrobomb Camerashake
    [39577] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_palolels_rage.dds' }, -- Palolel's Rage (Queen Palolel)
    [39579] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_palolels_rage.dds', name = A.Skill_Palolels_Rage }, -- CON_Knockback&Knockdown (Queen Palolel)
    [39578] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_palolels_rage.dds', name = A.Skill_Palolels_Rage }, -- Staggering Roar (Queen Palolel)

    -- Proving the Deed
    [25979] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds', name = A.Skill_Prismatic_Light, unbreakable = 1 }, -- FG4 RGT Event Knockback
    [25980] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds', name = A.Skill_Prismatic_Light }, -- FGQ4 RGT Event Knockback
    [25984] = { hide = true }, -- Subversion (Aelif)
    [64217] = { hide = true }, -- Damage Immunity Under 50% (Aelif)
    [64218] = { hide = true }, -- Combat Regen (Aelif)
    [64220] = { hide = true }, -- Base Damage Reduction (Aelif)

    -- Will of the Council
    [28939] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_set_flame_blossom.dds', name = A.Skill_Flame_Blossom }, -- Heat Wave (Sees-All-Colors)
    [28946] = { icon = 'LuiExtended/media/icons/abilities/ability_set_flame_blossom.dds', name = A.Skill_Flame_Blossom }, -- Heat Wave (Sees-All-Colors)
    [47758] = { hide = true }, -- Imprisonment
    [64111] = { hide = true }, -- Transformation

    ----------------------------------------------------------------
    -- QUESTS - MAGES GUILD ----------------------------------------
    ----------------------------------------------------------------

    -- Simply Misplaced
    [26406] = { stack = 1, stackAdd = 1 }, -- MG2 Captured Essence
    [31502] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks_brown.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Rock, A.Skill_Barrier), unbreakable = 1 }, -- MGQ2 Asakala Sahdina Barrier
    [31503] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks_brown.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Rock, A.Skill_Barrier), unbreakable = 1 }, -- MGQ2 Asakala Rashomta Barrier

    -- Circus of Cheerful Slaughter
    [29814] = { hide = true }, -- Ansei Ward
    [29815] = { hide = true }, -- Ansei Ward 3

    -- The Mad God's Bargain
    [39555] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_summon_scamp.dds', hide = true }, -- Summon Scamp (Haskill)
    [39527] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_polymorph.dds', name = A.Skill_Polymorph_Skeleton }, -- Skeleton Trap (Haskill)
    [39533] = { hide = true }, -- Polymorph (Haskill)
    [40851] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_polymorph.dds', name = A.Skill_Polymorph_Skeleton }, -- Polymorph Snare (Haskill)
    [35533] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_drain_vitality.dds', name = A.Skill_Drain_Vitality }, -- Polymorph (Haskill)
    [39556] = { hide = true }, -- Transform Scamp
    [39558] = { hide = true }, -- Rabbit
    [39559] = { hide = true }, -- Atronach
    [39560] = { hide = true }, -- Netch
    [39391] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_summon_pig.dds', name = A.Skill_Ungulate_Ordnance }, -- Summon Pig
    [39393] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_summon_pig.dds' }, -- Ungulate Ordnance

    --------------------------------------
    -- QUEST / ZONES - ALDMERI DOMINION --
    --------------------------------------

    --------------------
    -- Khenarthi's Roost
    --------------------

    -- Cast Adrift
    [35192] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lodestone.dds', name = A.Skill_Drain_Energy }, -- Q4620 Use Lodestone

    -- Tears of the Two Moons
    [32766] = { hide = true }, -- 4625 Uldor's Possession
    [31649] = { hide = true }, -- 4625 Ward 1
    [31665] = { hide = true }, -- 4625 Ward 2
    [31652] = { hide = true }, -- 4625 Gathwen Destory Ward
    [33231] = { hide = true }, -- 4625 Ward Destory
    [33136] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_blessing.dds', tooltip = T.Skill_Blessing_Gathwen }, -- Blessing (Gathwen)
    [35185] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_blessing.dds', name = A.Skill_Blessing, hide = true }, -- 4625 Heal (Gathwen)
    [32063] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_feedback.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Generic_Stun }, -- Feedback
    [35195] = { hide = true }, -- No Heal Check
    [31709] = { hide = true }, -- 4625 Gathwen Beam Ritual
    [33278] = { hide = true }, -- Increased Speed
    [32060] = { hide = true }, -- Shocked
    [33285] = { hide = true }, -- 4625 Uldor Banish
    [32705] = { hide = true }, -- 4625 No Yell
    [31969] = { hide = true }, -- Wrath (Uldor)
    [31970] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_lightning_strike.dds', hide = true }, -- Wrath (Uldor)
    [33449] = { hide = true }, -- 4625 Stop Bolts
    [33403] = { hide = true }, -- Wrath (Uldor)
    [33404] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_lightning_strike.dds', hide = true }, -- Wrath (Uldor)

    -- The Perils of Diplomacy
    [32264] = { hide = true }, -- Unconscious

    -- The Tempest Unleashed
    [34567] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lodestone.dds', name = A.Skill_Drain_Energy }, -- Q4621 PC Storm Drain
    [34701] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lodestone.dds', name = A.Skill_Disruption }, -- Q4621 Destory Horn
    [34747] = { hide = true }, -- a

    -- Dark Knowledge
    [35265] = { hide = true }, -- Q4667 Stun
    [35268] = { hide = true }, -- Sahira Screams

    -- The Root of the Problem
    [31948] = { hide = true }, -- Burrow
    [31947] = { hide = true }, -- Burrow

    -- A Pinch of Sugar
    [32335] = { hide = true }, -- Q4692 Thunderthrow

    --------------------
    -- Auridon
    --------------------

    -- World Boss - Seaside Scarp Camp
    [84047] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_defiled_ground.dds', duration = 0  }, -- Defiled Ground (Quenyas)
    [84045] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_defiled_ground.dds', name = A.Skill_Defiled_Ground }, -- Seal of Defilement (Quenyas)
    [83782] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds' }, -- Staff Strike (Quenyas)
    [83783] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_staff_strike.dds' }, -- Bash (Quenyas)
    [83776] = { hide = true }, -- Dark Summons (Quenyas)
    [84283] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds', name = A.Skill_Colossal_Stomp }, -- Coursing Bones (Oskana)
    [84285] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_bone_saw.dds', name = A.Skill_Colossal_Stomp }, -- Coursing Bones (Oskana)
    [84284] = { name = A.Innate_Stagger, hide = true }, -- Coursing Bones (Oskana)

    -- World Boss - Heretic's Summons
    [82934] = { hide = true }, -- Shrieking Summons
    [83013] = { hide = true }, -- Daedric Explosion
    [82935] = { hide = true }, -- Summon Brood
    [82937] = { hide = true }, -- Summon Brood
    [83151] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_headbutt.dds', name = A.Skill_Headbutt }, -- Savage Claw (Snapjaw)
    [83150] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_tail_whip.dds' }, -- Savage Claw (Snapjaw)
    [83009] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Snapjaw)
    [83011] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Snapjaw)
    [87989] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap.dds' }, -- Rending Leap (Snapjaw)
    [83012] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Devour (Snapjaw)
    [85649] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour.dds' }, -- Devour (Snapjaw)
    [83049] = { hide = true }, -- Charge (Clannfear)
    [83040] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_ferocious_charge.dds', name = A.Skill_Ferocious_Charge }, -- Focused Charge (Clannfear)
    [83039] = { hide = true }, -- Ferocious Charge (Clannfear)
    [83035] = { hide = true }, -- Ferocious Charge (Clannfear)
    [83042] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_ferocious_charge.dds' }, -- Ferocious Charge (Clannfear)
    [83016] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds', name = A.Skill_Daedric_Explosion }, -- Necrotic Explosion
    [83017] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds', hide = true }, -- Daedric Explosion
    [83018] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_coldfire_aoe.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Daedric Explosion

    -- World Boss - Heritance Proving Ground
    [47259] = { hide = true }, -- Frostarrows

    -- Rites of the Queen
    [48921] = { hide = true }, -- Ancestral Spirit
    [48924] = { hide = true }, -- Ancestral Spirit
    [48927] = { hide = true }, -- Ancestral Spirit

    -- The Unveiling
    [22718] = { hide = true }, -- Knock Out

    -- Lifting the Veil
    [23392] = { icon = 'LuiExtended/media/icons/disguises/disguise_altmer_glamour.dds', isDisguise = true }, -- Altmer Glamour

    -- Through the Ashes
    [48646] = { hide = true }, -- Magefire
    [2379] = { hide = true }, -- On Fire

    -- Breaking the Barrier
    [21876] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, unbreakable = 1 }, -- Q4260 West Barrier Teleport
    [21878] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, unbreakable = 1 }, -- Q4260 East Barrier Teleport

    -- Sever All Ties
    [22395] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, unbreakable = 1 }, -- Q4261 ROD Barrier Teleport
    [44138] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shockwave.dds', name = A.Skill_Shockwave }, -- Q4261 Estre Knockback
    [49224] = { hide = true }, -- Q4868 Aulus Knockback
    [44136] = { hide = true }, -- RobS Stun Perm

    -- The Serpent's Beacon
    [21364] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_maormer_rune.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Dispel, A.Skill_Barrier) }, -- Casting...
    [21409] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_teleport_scroll.dds', name = A.Skill_Teleport_Scroll }, -- Reading...

    -- Corruption Stones
    [22889] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_altmer_holy_symbol.dds', name = A.Skill_Purify, hide = true }, -- Purifying...

    -- The First Patient
    [22448] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bind_hands.dds', name = A.Skill_Bind_Hands }, -- Q4266 Tie up Hendil

    -- Depths of Madness
    [22158] = { hide = true }, -- Collecting with Magic Jar...
    [22141] = { hide = true }, -- Collecting...
    [22160] = { hide = true }, -- Collecting...
    [22187] = { hide = true }, -- Throwing Spore Potion
    [22271] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_teleport_scroll.dds', name = A.Skill_Teleport_Scroll }, -- Teleport Scroll AB

    -- Silent Village
    [21968] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_binding_gem.dds', name = A.Skill_Bind_Bear }, -- Binding Bear...
    [45784] = { hide = true }, -- Generic Spawn Fire Atronach AM

    -- The Mallari-Mora
    [28771] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_atherial_shift.dds', name = A.Skill_Aetherial_Shift, unbreakable = 1, tooltip = T.Generic_Stun }, -- Q4220 Thirster Stun (The Mallari-Mora)
    [21393] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_atherial_shift.dds', name = A.Skill_Aetherial_Shift }, -- Q4220 Spirit Layer Ability
    [21403] = { icon = 'esoui/art/icons/ability_mage_054.dds', tooltip = T.Skill_Spiritual_Cloak }, -- Spiritual Cloak

    -- An Act of Kindness
    [22931] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_micro_etched_crystal.dds', name = A.Skill_Free_Spirit }, -- Freeing Spirit...
    [21315] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds' }, -- Spike Trap
    [21313] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds', name = A.Trap_Spike_Trap, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Spike_Trap_Auridon }, -- Crippled!
    [21314] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_spike_trap.dds', name = A.Trap_Spike_Trap, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Spike_Trap_Auridon, hideReduce = true }, -- Trap Sprung!

    -- The Veiled Choice
    [23187] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bind_hands.dds', name = A.Skill_Unbind }, -- Q4236 PC Untie Palith

    -- Preventative Measure
    [23606] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_feedback_crystal.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Crystal, A.Skill_Backfire), unbreakable = 1, tooltip = T.Generic_Stun }, -- Q4326 Crystal Backfire
    [24535] = { hide = true }, -- Disrupting...

    -- Blessings of the Eight
    [47149] = { hide = true }, -- Magefire
    [23159] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_divine_speed.dds', tooltip = T.Skill_Divine_Speed }, -- Divine Speed
    [22728] = { hide = true }, -- Water Beam
    [23217] = { hide = true }, -- Fire Beam

    -- Rightful Inheritance
    [24826] = { hide = true }, -- Spiteful Essence

    --------------------
    -- Grahtwood
    --------------------

    -- World Events
    [40035] = { hide = true }, -- GW CTen Swinging Axe (Peacemaker Achievement Location)

    -- World Boss - Nindaeril's Perch
    [83515] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds' }, -- Hunter's Pounce (Bavura the Blizzard)
    [83517] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds' }, -- Hunter's Pounce (Bavura the Blizzard)
    [84018] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds', tooltip = T.Generic_Stun }, -- Hunter's Pounce (Bavura the Blizzard)
    [83521] = { icon = 'LuiExtended/media/icons/abilities/ability_lion_hunters_pounce.dds' }, -- Hunter's Pounce (Bavura the Blizzard)
    [83832] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge.dds' }, -- Frenzied Charge (Nindaeril the Monsoon)
    [83833] = { hide = true }, -- Frenzied Charge (Nindaeril the Monsoon)
    [83846] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge.dds' }, -- Frenzied Charge (Nindaeril the Monsoon)
    [83855] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge.dds', tooltip = T.Generic_Stun }, -- Frenzied Charge (Nindaeril the Monsoon)
    [83852] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_frenzied_charge.dds' }, -- Frenzied Charge (Nindaeril the Monsoon)
    [83548] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_mighty_roar.dds' }, -- Mighty Roar (Nindaeril the Monsoon)
    [83549] = { icon = 'LuiExtended/media/icons/abilities/ability_senche_mighty_roar.dds', tooltip = T.Generic_Fear }, -- Mighty Roar (Nindaeril the Monsoon)

    -- Public Dungeon - Root Sunder Ruins
    [34176] = { hide = true }, -- Blue Flam (The Bonemonger)

    -- Public Dungeon - Root Sunder Ruins -- Forgotten Soul
    [91627] = { hide = true }, -- Root Sunder's Favor

    -- The Grips of Madness
    [37276] = { hide = true }, -- Q4868 Beast Person
    [37296] = { hide = true }, -- Q4868 Change Beast Person
    [37297] = { hide = true }, -- Q4868 Change Beast Person
    [37295] = { hide = true }, -- Q4868 Change Beast Person
    [38499] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_innate_lightning_strike.dds', name = A.Skill_Lightning_Strike }, -- Wrath
    [38500] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_lightning_strike.dds', name = A.Skill_Lightning_Strike }, -- Wrath
    [37438] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_lightning_strike.dds', name = A.Skill_Lightning_Strike, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Generic_Stun }, -- Shocked
    [38516] = { hide = true }, -- Q4868 Rufinus Is Lightning
    [47720] = { hide = true }, -- RobS Stun 1 Sec
    [37463] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds', name = A.Skill_Push }, -- Q4868 Push NPC
    [37465] = { hide = true }, -- Q4842 Despawn Self
    [38942] = { hide = true }, -- Q4868 Rufinus Is Shocked
    [38596] = { hide = true }, -- Q4842 Stun
    [37583] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_old_scroll.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Dispel, A.Skill_Barrier) }, -- Q4868 Unlock Chapel
    [38744] = { hide = true }, -- Q4868 Sheo Teleports Player
    [38720] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_lightning_fury.dds', tooltip = T.Skill_Lightning_Fury }, -- Lightning Fury
    [47710] = { hide = true }, -- Lightning Fury
    [38748] = { icon = 'esoui/art/icons/ability_mage_036.dds', hide = true }, -- Aulus's Tongue
    [63710] = { icon = 'esoui/art/icons/ability_mage_036.dds', tooltip = T.Generic_Stun }, -- Aulus's Tongue
    [40702] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shockwave.dds', name = A.Skill_Shockwave }, -- Q4868 Aulus Knockback
    [44100] = { hide = true }, -- Q4868 Aulus Knockback
    [47709] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shockwave.dds', name = A.Skill_Shockwave }, -- Q4868 Aulus Knockback

    -- A Lasting Winter
    [38394] = { hide = true }, -- Shatter
    [47762] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity, duration = 3, tooltip = T.Generic_CC_Immunity }, -- Spawn Clone (General Endare)
    [47768] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_cc_immunity.dds', name = A.Innate_CC_Immunity, tooltip = T.Generic_CC_Immunity }, -- RobS Immunities 6 Sec (General Endare)
    [38441] = { hide = true }, -- Become
    [47783] = { hide = true }, -- Become

    -- Heart of the Matter
    [45997] = { hide = true }, -- Q4386 Ukaezai Split 3
    [46188] = { hide = true }, -- Q4386 Ukaezai Faints
    [45998] = { hide = true }, -- Q4386 Ukaezai Book Summon
    [40849] = { icon = 'LuiExtended/media/icons/abilities/ability_set_oblivion.dds' }, -- Annihilation
    [39956] = { hide = true }, -- Heart of Anumaril
    [46036] = { hide = true }, -- Q4386 Ukaezai Split 2
    [46037] = { hide = true }, -- Q4386 Ukaezai Split 1

    -- The Orrery of Elden Root
    [41979] = { hide = true }, -- RobS Despawn Me Flag
    [40504] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_quest_mantles_shadow.dds', name = A.Skill_Mantles_Shadow }, -- Q4922 Use Mantle on Device
    [40557] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_quest_mantles_shadow.dds', name = A.Skill_Mantles_Shadow }, -- (12127) CFX_4922 Mantle Cast S
    [41863] = { hide = true }, -- Q4922 Orrery Rumble
    [14568] = { hide = true }, -- TEST_Ritual Arcane
    [40394] = { hide = true }, -- CFX_4922 Naemon Ogre Glow

    [43820] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }, -- Quaking Stomp (Prince Naemon)
    [43822] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds' }, -- Quaking Stomp (Prince Naemon)
    [43823] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds', name = A.Skill_Quaking_Stomp, unbreakable = 1, tooltip = T.Generic_Knockback }, -- IntroKB (Prince Naemon)
    [43821] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds', name = A.Skill_Quaking_Stomp }, -- Staggering Roar (Prince Naemon)
    [43827] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_projectile_vomit.dds', hide = true }, -- Projectile Vomit (Prince Naemon)
    [43828] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_projectile_vomit.dds', name = A.Skill_Projectile_Vomit }, -- Belch (Prince Naemon)
    [40396] = { hide = true }, -- Q4922 Ayrenn Divine Glow

    -- Passage Denied
    [47301] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_ayleid_wand_of_blockade.dds', name = A.Skill_Close_Portal }, -- Stunned

    -- The Blacksap's Hold
    [39247] = { hide = true }, -- RobS Stun .5 Sec
    [39244] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds', name = A.Skill_Push }, -- Q4917 Push Player Back
    [39260] = { icon = 'esoui/art/icons/achievement_wrothgar_044.dds', name = A.Skill_Push, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Generic_Knockback }, -- Q4917 Push Player Back
    [41342] = { hide = true }, -- 10 Second Timer
    [39312] = { hide = true }, -- CON_Portal Perm
    [39308] = { hide = true }, -- Stun
    [39384] = { hide = true }, -- Q4917 Lurcher Construct Ground
    [41325] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_blacksaps_brew.dds', tooltip = T.Skill_Blacksaps_Brew }, -- Blacksap's Brew

    -- Luck of the Albatross
    [35984] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_captains_whistle.dds', name = A.Skill_Call_for_Help }, -- Q4436 Summon Pirate

    -- Scars Never Fade
    [41339] = { hide = true }, -- RobS Stun 3 Sec
    [43151] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bucket_of_water.dds', name = A.Skill_Throw_Water }, -- Q4768 Use Bucket

    -- Keeper of the Bones
    [35854] = { hide = true }, -- Q4773 Dringoth Splode
    [35862] = { hide = true }, -- Possessed
    [35857] = { hide = true }, -- Q4773 Dringoth Proxy Splode

    -- Bosmer Insight
    [36438] = { hide = true }, -- Q4833
    [36544] = { hide = true }, -- Fast Jumper
    [35991] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_vision_journey.dds', tooltip = T.Skill_Vision_Journey }, -- Vision Journey
    [36883] = { hide = true }, -- Q4833 Teleport into Tree
    [36882] = { hide = true }, -- Q4833 Teleport into Tree
    [36710] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_snake_scales.dds', name = A.Skill_Snake_Scales }, -- Q4833 Apply Snake Buff
    [36713] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_snake_scales.dds', tooltip = T.Skill_Snakes_Scales }, -- Snake Scales
    [36841] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_wolfs_pelt.dds', name = A.Skill_Wolfs_Pelt }, -- Q4833 Apply Wolf Buff
    [36843] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_wolfs_pelt.dds', tooltip = T.Skill_Wolfs_Pelt }, -- Wolf's Pelt
    [36824] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_tigers_fur.dds', name = A.Skill_Tigers_Fur }, -- Q4833 Apply Tiger Buff
    [36828] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_tigers_fur.dds', tooltip = T.Skill_Tigers_Fur }, -- Tiger's Fur

    -- The Unquiet Dead
    [37062] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bone_scepter.dds', hide = true }, -- Exorcise
    [36887] = { hide = true }, -- Kithshade Stun
    [36766] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_headgrab.dds', name = A.Skill_Feedback, tooltip = T.Generic_Stun, unbreakable = 1 }, -- Q4842 Stun Headgrab Knockback
    [36998] = { hide = true }, -- Bind Spirit
    [36996] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_bone_scepter.dds' }, -- Bind Spirit
    [37365] = { hide = true }, -- Q4842 Stun

    -- Eyes of Azura
    [37205] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds', name = A.Skill_Soul_Binding, tooltip = T.Skill_Soul_Binding }, -- Animus Geode
    [37677] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds', name = A.Skill_Soul_Binding }, -- Geodesic Corruption
    [37211] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds', name = A.Skill_Empower_Heart }, -- Q4854 Empower Heart
    [37386] = { hide = true }, -- Vas out
    [38246] = { hide = true, icon = 'LuiExtended/media/icons/abilities/ability_quest_sigil_geode.dds', name = A.Skill_Soul_Binding }, -- Animus Geode
    [37585] = { hide = true }, -- Q4854 Culanwe Fire B

    -- Flipping the Coin
    [39309] = { hide = true }, -- Q4983 Stone Cats

    --------------------
    -- Greenshade
    --------------------

    -- World Boss -- Rootwater's Spring
    [47084] = { hide = true }, -- Rootwater Healing Spring
    [47086] = { hide = true }, -- Rootwater Life Spring

    -- World Boss - Gathongor's Mine
    [84205] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_gtaoe.dds' }, -- Stinging Sputum (Gathongor the Mauler)
    [84206] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_gtaoe.dds', hide = true }, -- Stinging Sputum (Gathongor the Mauler)
    [84196] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Marsh Masher (Gathongor the Mauler)
    [84203] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds', hide = true }, -- Marsh Masher (Gathongor the Mauler)
    [84197] = { name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Marsh Masher (Gathongor the Mauler)
    [84208] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_savage_swipe.dds' }, -- Savage Swipe (Gathongor the Mauler)
    [84209] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_wrecking_jaws.dds', tooltip = T.Generic_Stun }, -- Wrecking Jaws (Gathongor the Mauler)
    [84211] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_wrecking_jaws.dds' }, -- Wrecking Jaws (Gathongor the Mauler)
    [84210] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_wrecking_jaws.dds', tooltip = T.Generic_Bleed }, -- Wrecking Jaws (Gathongor the Mauler) -- TODO: Add tick rate in here
    [84138] = { hide = true }, -- Minion of Stone (Gathongor the Mauler)
    [84139] = { hide = true }, -- Minion of Stone (Gathongor the Mauler)
    [84212] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_bog_slam.dds' }, -- Bog Slam (Gathongor the Mauler)
    [84214] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_bog_slam.dds', type = BUFF_EFFECT_TYPE_DEBUFF, tooltip = T.Generic_Knockdown }, -- Bog Slam (Gathongor the Mauler)
    [84213] = { icon = 'LuiExtended/media/icons/abilities/ability_argonianbehemoth_bog_slam.dds' }, -- Bog Slam (Gathongor the Mauler)

    -- World Boss - Thodundor's View
    [83164] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_punch.dds' }, -- Clobber (Thodundor of the Hill)
    [83165] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_backhand.dds' }, -- Sweeping Backhand (Thodundor of the Hill)
    [83124] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_intimidating_roar.dds', tooltip = T.Generic_Fear }, -- Ferocious Bellow (Thodundor of the Hill)
    [83155] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Thunderous Smash (Thodundor of the Hill)
    [83156] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Thunderous Smash (Thodundor of the Hill)
    [83159] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Thunderous Smash (Thodundor of the Hill)
    [83157] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds', tooltip = T.Generic_Stun }, -- Thunderous Smash (Thodundor of the Hill)
    [83160] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }, -- Stone Crusher (Thodundor of the Hill)
    [83163] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }, -- Stone Crusher (Thodundor of the Hill)
    [83162] = { name = A.Skill_Off_Balance }, -- Stone Crusher (Thodundor of the Hill)
    [83161] = { name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Stone Crusher (Thodundor of the Hill)
    [83136] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds', hide = true }, -- Ground Shock (Thodundor of the Hill)
    [83140] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Ground Shock (Thodundor of the Hill)
    [83141] = { name = A.Innate_Stagger, hide = true, tooltip = T.Generic_Stagger }, -- Ground Shock (Thodundor of the Hill)
    [83137] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds' }, -- Ground Shock (Thodundor of the Hill)
    [83777] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', hide = true }, -- Iron Grip (Thodundor of the Hill)
    [83780] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', tooltip = T.Generic_Stun }, -- Iron Grip (Thodundor of the Hill)

    -- Public Dungeon - Rulanyil's Fall
    [33581] = { hide = true }, -- DUN-RF_Event_Blue_Fire

    -- Audience with the Wilderking
    [37759] = { icon = 'esoui/art/icons/achievement_030.dds', tooltip = T.Skill_Spirit_Armor }, -- Spirit Armor

    -- The Witch of Silatar
    [33384] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_grasping_vines.dds', name = A.Skill_Restricting_Vines, unbreakable = 1, tooltip = T.Generic_Stun }, -- Q4586 Aranias Vine Stun
    [33066] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_change_clothes.dds', name = A.Skill_Change_Clothes, tooltip = T.Skill_Fancy_Clothing }, -- Q4586_ChangeClothes
    [49116] = { hide = true }, -- Q4586_HugeTree

    -- Throne of the Wilderking
    [35014] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_wilderkings_protection.dds' }, -- Wilderking's Protection
    [33594] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', hide = true }, -- Fire
    [49897] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', unbreakable = 1, tooltip = T.Generic_Snare }, -- Fire
    [33701] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds', name = A.Skill_Burrow, hide = true }, -- BurrowEND
    [33829] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_tremorscale.dds', name = A.Skill_Burrow, tooltip = T.Skill_Burrow }, -- Burrowing
    [37506] = { hide = true }, -- Stealth
    [33727] = { hide = true }, -- BurrowEND

    -- Pelidil's End
    [33577] = { icon = 'LuiExtended/media/icons/abilities/ability_ironatronach_blast_furnace.dds' }, -- Maormer Fire
    [48049] = { hide = true }, -- Q4765 Block Dummy Fire
    [48054] = { hide = true }, -- Q475 Impact Increment
    [50765] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_gtaoe.dds', name = A.Skill_Serpent_Spit }, -- CON_AOE_Template1

    -- Retaking the Pass
    [45650] = { hide = true }, -- Indaenir's Spell
    [29504] = { tooltip = T.Skill_Shadow_Wood }, -- Q4546 Shade Layer

    ----------------------------------------------------------------
    -- IC QUEST RELATED & QUEST BOSS HIDDEN ------------------------
    ----------------------------------------------------------------

    --[[
    [68660] = { hide = true }, -- Q5489 Zolgar Death Countdown - The Lock and the Legion
    [68720] = { hide = true }, -- Q5489 Regilus Death Timer - The Lock and the Legion
    [82788] = { hide = true }, -- IC Harvester Door Exception - The Imperial Standard (Barracks Defense)
    [69403] = { hide = true }, -- Healing Immunity - The Imperial Standard (Barracks Defense)
    [59168] = { hide = true }, -- Size and Strength - The Watcher in the Walls (Clannfear Boss)
    [59940] = { hide = true }, -- Summoning Call - The Watcher in the Walls (Clannfear Boss)
    [59181] = { hide = true }, -- Charge - The Watcher in the Walls (Clannfear Boss)
    [80678] = { hide = true }, -- Chasten - The Watcher in the Walls (Harvester Boss)
    [80674] = { hide = true }, -- Black Winter - The Watcher in the Walls (Harvester Boss)
    [60905] = { hide = true }, -- Summon - The Watcher in the Walls (Harvester Boss)
    [80650] = { hide = true }, -- Body Slam -- The Watcher in the Walls (Ogrim Boss)
    [53429] = { hide = true }, -- Call Final Boss - The Watcher in the Walls (Ogrim Boss)
    [53500] = { hide = true }, -- Spirit Shield - The Watcher in the Walls (Final Boss)
    [53480] = { hide = true }, -- Summon Flame Atronach - The Watcher in the Walls (Final Boss)
    [53489] = { hide = true }, -- Summon Flame Atronach - The Watcher in the Walls (Final Boss)
    [80657] = { hide = true }, -- Fright Force - The Watcher in the Walls (Final Boss)
    ]]--

    ----------------------------------------------------------------
    -- ORSINIUM EVENTS ---------------------------------------------
    ----------------------------------------------------------------

    --[[
    [74875] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Catapult (The Hidden Harvest)
    [64734] = { name = 'Harpy Swoop', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Q5318 - Harpy Swoop In (The Hidden Harvest)
    [74104] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Grasping Vines (The Hidden Harvest)
    [74105] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_grasping_vines.dds' }, -- Grasping Vines (The Hidden Harvest)
    [64316] = { icon = 'LuiExtended/media/icons/abilities/ability_frost_fortress.dds' }, -- Frost Fortress (For King and Glory - Urfon Ice-Heart)
    [64363] = { icon = 'esoui/art/icons/ability_wrothgar_bitingcold.dds' }, -- Savage Winds (For King and Glory - Urfon Ice-Heart)
    [66277] = { icon = 'LuiExtended/media/icons/equipment_disguise.dds', name = 'Vosh Rakh Illusion' }, -- Vosh Rakh Recruit Disg (The Anger of a King)
    [66397] = { icon = 'esoui/art/icons/ability_healer_027.dds' }, -- Avalian's Speed (The Anger of a King)
    [66399] = { icon = 'esoui/art/icons/ability_warrior_012.dds' }, -- Usunok's Strength (The Anger of a King)
    [66415] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Gust' }, -- Uppercut Stun (The Anger of a King)
    [53291] = { icon = 'esoui/art/icons/ability_destructionstaff_001a.dds', name = A.Skill_Crushing_Shock }, -- Uber Attack (The Anger of a King - Talviah Aliaria)
    [53302] = { icon = 'esoui/art/icons/ability_destructionstaff_008.dds', name = 'Minor Mangle' }, -- Icy Pulsar (The Anger of a King - Talviah Aliaria)
    [64430] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds' }, -- Royal Bash (Blood on a King's Hands)
    [66988] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Tear Down the Mountain (Blood on a King's Hands)
    [67084] = { type = BUFF_EFFECT_TYPE_DEBUFF }, -- Tear Down the Mountain (Blood on a King's Hands)
    [65835] = { icon = 'esoui/art/icons/ability_restorationstaff_002.dds' }, -- Restoring Waves (Forcing the Faith)
    [72154] = { icon = 'esoui/art/icons/ability_debuff_levitate.dds' }, -- Choke (Draugr Dilemma)
    [69789] = { hide = true }, -- WG - Frozen Ice (Invitation to Orsinium - Olarz the Cunning)
    [69603] = { hide = true }, -- Q5318 - Siege Hits Above (The Hidden Harvest)
    [69552] = { hide = true }, -- Frozen Aura (For King and Glory - Urfon Ice-Heart)
    [64306] = { hide = true }, -- Frozen Fortress (For King and Glory - Urfon Ice-Heart)
    [69410] = { hide = true }, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart)
    [69404] = { hide = true }, -- Winter's Heed (For King and Glory - Urfon Ice-Heart)
    [69949] = { hide = true }, -- Kinetic Resonator Damage Limit (Quarry Conundrum)
    [65765] = { hide = true }, -- Q5348 - Poison Mist (To Save a Chief)
    [75403] = { hide = true }, -- Q5348 - Poison Mist (To Save a Chief)
    [65781] = { hide = true }, -- Poison Mist (To Save a Chief)
    [65780] = { hide = true }, -- Poison Mist (To Save a Chief)
    [65779] = { hide = true }, -- Poison Mist (To Save a Chief)
    [70646] = { hide = true }, -- VR Disguise Warning (The Anger of a King)
    [66408] = { hide = true }, -- Heat Wave (The Anger of a King)
    [66475] = { hide = true }, -- Q5468 - Speaker (The Anger of a King)
    [66476] = { hide = true }, -- Q5468 - Speaker Transfer (The Anger of a King)
    [53270] = { hide = true }, -- Frost Clench (The Anger of a King - Talviah Aliaria)
    [71177] = { hide = true }, -- Alga's Hold (The King's Gambit)
    [71178] = { hide = true }, -- Q5468 - Speaker Alga (The King's Gambit)
    [66903] = { hide = true }, -- Q5481 - Injure Solgra (Blood on a King's Hands)
    [74912] = { hide = true }, -- Archer's Focus (Blood on a King's Hands)
    [67898] = { hide = true }, -- Q5481 - Tracking (Blood on a King's Hands)
    [70546] = { hide = true }, -- Alga's Resilience (Blood on a King's Hands)
    [75103] = { hide = true }, -- The King's Anger (Blood on a King's Hands)
    [75116] = { hide = true }, -- The King's Anger (Blood on a King's Hands)
    [70540] = { hide = true }, -- Oil Fire (Blood on a King's Hands)

    -- Side Quests
    [65852] = { hide = true }, -- Shatter (Forcing the Faith)
    [65828] = { hide = true }, -- Lightning Jolt Synergy (Forcing the Faith)
    [65832] = { hide = true }, -- Restoring Waves Synergy (Forcing the Faith)
    [65834] = { hide = true }, -- Restoring Waves (Forcing the Faith)
    [70702] = { hide = true }, -- Tremors (Draugr Dilemma)
    [72153] = { hide = true }, -- Choke (Draugr Dilemma)
    [69172] = { hide = true }, -- Collapsing from Fatigue (Sorrow's Kiss)
    [65925] = { hide = true }, -- Q5466 Sphere Sparking (Tinker Trouble)

    -- Delves
    [69290] = { hide = true }, -- Call Ally (Nikolvara the Durzog Trainer - Nikolvara's Kennel)
    [69322] = { hide = true }, -- Call Ally (Nikolvara the Durzog Trainer - Nikolvara's Kennel)

    -- Public Dungeons Orsinium
    [74762] = { icon = 'esoui/art/icons/ability_dragonknight_009.dds' }, -- Dragon Leap (Pyre Keeper Rugdrulz - Old Orsinium)
    [53829] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Lifting Strike' }, -- Uppercut Stun (Batunalulr - Old Orsinium)
    [53940] = { icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Pummel' }, -- Pummel Stun (Batunalulr - Old Orsinium)
    [53874] = { hide = true }, -- Pummel (Batunalulr - Old Orsinium)
    ]]--

    ----------------------------------------------------------------
    -- VVARDENFELL     ---------------------------------------------
    ----------------------------------------------------------------

    -- SQ (An Armiger's Duty)
    [90073] = { hide = true }, -- Blinding Light
    [89753] = { hide = true }, -- Shocking Rake (Old Rust-Eye - Khartag Point)
    [89754] = { icon = 'LuiExtended/media/icons/abilities/ability_dreugh_shocking_rake.dds' }, -- Shocking Rake (Old Rust-Eye - Khartag Point)
    [86865] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_powered_up.dds' }, -- Powered Up (Centurion Mthgrazzen - A Melodic Mistake)
    [86633] = { hide = true }, -- Barrier Break (A Melodic Mistake)
    [85264] = { hide = true }, -- Sacrifice (Divine Inquiries)
    [85265] = { hide = true }, -- Sacrifice (Divine Inquiries)
    [85266] = { hide = true }, -- Sacrifice (Divine Inquiries)
    [92580] = { hide = true }, -- Q5887 - AshurStealthOut (Fleeing the Past)
    [95123] = { hide = true }, -- Q5933 - NaryuStuckProtection (A Purposeful Writ)
    [86981] = { hide = true }, -- Summon Skaafin (Vvardenfell - Various Quest NPC's)
    [85105] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_unstable_reaction.dds', hide = true }, -- Unstable Reaction (Reclaiming Vos)
    [85537] = { hide = true }, -- Summon Personal Guard (Reclaiming Vos)
    [92720] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds' }, -- Necrotic Wave (Vvardenfell -- Ancestral Adversity)
    [92722] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds', name = 'Necrotic Wave' }, -- Stomp of Flame (Vvardenfell -- Ancestral Adversity)
    [92723] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds', name = 'Necrotic Wave', hide = true }, -- Fire Backlash (Vvardenfell -- Ancestral Adversity)
    [92721] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_necrotic_wave.dds', name = 'Necrotic Wave' }, -- CON_Knockback&Knockdown (Vvardenfell -- Ancestral Adversity)
    [86743] = { icon = 'esoui/art/icons/achievement_morrowind_031.dds', hide = true }, -- Accelerated Transposition (Like Blood from a Stone)
    [90511] = { icon = 'esoui/art/icons/achievement_morrowind_031.dds', hide = true }, -- Accelerated Transposition (Like Blood from a Stone)
    [88425] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds' }, -- Shattered Ground (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88416] = { hide = true }, -- Awaken the Colony (Th'krak the Tunnel-King -- Delve -- Matus-Akin Egg Mine)
    [88417] = { hide = true }, -- Awaken the Colony (Th'krak the Tunnel-King -- Delve -- Matus-Akin Egg Mine)
    [88419] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88422] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88427] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow, hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88431] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88432] = { hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88426] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88433] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_charge.dds', name = A.Skill_Plow, hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88435] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [88437] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = 'Charge Stun', hide = true }, -- Charge (Kwama Worker -- Delve -- Matus-Akin Egg Mine)
    [14374] = { hide = true }, -- Generic Dwemer Smoke Plume
    [93221] = { hide = true }, -- Surprise!
    [16910] = { hide = true }, -- Corruption Aura (Objections and Obstacles)
    [89756] = { icon = 'esoui/art/icons/achievement_wrothgar_006.dds', name = 'Centurion Drop', unbreakable = 1 }, -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    [89757] = { icon = 'esoui/art/icons/achievement_wrothgar_006.dds', name = 'Centurion Drop' }, -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    [84273] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_sweeping_spin.dds' }, -- Sweeping Spin (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)
    [87738] = { hide = true }, -- Powder Bomb (The Heart of a Telvanni)
    [89564] = { hide = true }, -- Knockout (The Heart of a Telvanni)
    [88244] = { hide = true }, -- The Slavemaster's Chains (The Heart of a Telvanni)
    [77541] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds', name = 'Mighty Strike' }, -- Brand's Cleave (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [77542] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_brands_cleave.dds', name = 'Mighty Strike' }, -- Brand's Cleave (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [82276] = { hide = true }, -- Dark Reach (The Heart of a Telvanni)
    [82274] = { icon = 'esoui/art/icons/ability_dragonknight_005.dds', name = A.Skill_Fiery_Grip }, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [82275] = { name = A.Skill_Fiery_Grip }, -- Dark Reach (Slavemaster Arenim -- Vvardenfell -- The Heart of a Telvanni)
    [89266] = { hide = true }, -- Summon Spider
    [89269] = { hide = true }, -- Summon Spider
    [89276] = { hide = true }, -- Summon Exploder
    [89278] = { hide = true }, -- Summon Exploder
    [89277] = { hide = true }, -- Summon Exploder
    [89268] = { hide = true }, -- Summon Spider
    [89282] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', hide = true }, -- Spider Explosion
    [89274] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spider Explosion
    [87958] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_ash_storm.dds' }, -- Ash Storm (Divine Delusions)
    [87959] = { icon = 'LuiExtended/media/icons/abilities/ability_dragonknight_ash_storm.dds' }, -- Ash Storm (Divine Delusions)
    [86972] = { hide = true }, -- Q5888 Chodala Magic Shield FX (Divine Delusions)
    [90630] = { hide = true }, -- Frenzy (Divine Delusions)
    [86353] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_mechanical_possession.dds' }, -- Mechanical Possession (Vvardenfell -- Divine Intervention)
    [86417] = { hide = true }, -- Mechanical Possession (Divine Intervention)
    [86349] = { hide = true }, -- Inactive Centurion (Divine Intervention)

    -- Vvardenfell MQ -- Divine Intervention
    [91006] = { hide = true }, -- Chodala's Shield
    [86815] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_fire_ranged.dds' }, -- Daedric Bolt
    [90140] = { hide = true}, -- Sunder's Echo
    [90148] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds' }, -- Sunder's Echo
    [90146] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds', hide = true }, -- Sunder's Echo
    [90147] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_pillar_of_nirn.dds' }, -- Sunder's Echo
    [90139] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_empowered_strike.dds' }, -- Empowered Strike
    [90141] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_empowered_strike.dds' }, -- Empowered Strike
    [90142] = { icon = 'LuiExtended/media/icons/abilities/ability_healer_empowered_strike.dds' }, -- Empowered Strike
    [88963] = {hide = true}, -- Delay

    -- VVARDENFELL MQ - Divine Disaster
    [88466] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds', }, -- Skyfall
    [88467] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Skyfall
    [92536] = { hide = true }, -- Vulnerability to Meteors

    -- VVARDENFELL MQ - Divine Restoration
    [90181] = { icon = 'LuiExtended/media/icons/abilities/ability_clockworkguardian_oily_smoke.dds' }, -- Oily Smoke
    [90182] = { icon = 'LuiExtended/media/icons/abilities/ability_clockworkguardian_oily_smoke.dds' }, -- Oily Smoke
    [87104] = { hide = true}, -- Stun (Blade Trap - Divine Restoration)
    [87102] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = 'Spinning Blade Trap' }, -- Spinning Blade
    [91970] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = 'Spinning Blade Trap', type = BUFF_EFFECT_TYPE_DEBUFF }, -- Serrated Blade
    [91969] = { icon = 'esoui/art/icons/achievement_vvardenfel_047.dds', name = 'Spinning Blade Trap' }, -- Serrated Blade
    [89330] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_torrent.dds', hide = true }, -- Defensive Flare
    [89750] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' }, -- Pulse
    [92213] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_ranged.dds', hide = true }, -- Sparks
    [92229] = { hide = true }, -- Pulse
    [92227] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' }, -- Pulse
    [92225] = { icon = 'esoui/art/icons/achievement_vvardenfel_013.dds' }, -- Repair
    [89761] = { hide = true }, -- Fabricate Beetle
    [90528] = { hide = true}, -- Loyal Hound
    [87038] = { icon = 'esoui/art/icons/ability_rogue_026.dds'}, -- Spinning Blades
    [87040] = { icon = 'esoui/art/icons/ability_rogue_026.dds', name = 'Spinning Blades', hide = true}, -- Pinning Blades
    [87039] = { icon = 'esoui/art/icons/ability_rogue_026.dds', name = 'Spinning Blades'}, -- Pinning Blades
    [87047] = {icon = 'esoui/art/icons/ability_rogue_066.dds'}, -- Lunge
    [87051] = {hide = true}, -- Lunge
    [87048] = {icon = 'esoui/art/icons/ability_rogue_066.dds'}, -- Lunge
    [87050] = {icon = 'esoui/art/icons/ability_rogue_066.dds', hide = true}, -- Lunge
    [87049] = {icon = 'esoui/art/icons/ability_rogue_066.dds'}, -- Lunge
    [87090] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_fire_ranged.dds', hide = true}, -- Barbs
    [87096] = { icon = 'LuiExtended/media/icons/abilities/ability_rogue_fire_ranged.dds'}, -- Barbs
    [90599] = { hide = true }, -- Daedric Vigor
    [92284] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_planar_shear.dds' }, -- Planar Shear
    [90627] = { hide = true }, -- targetable
    [90566] = { hide = true }, -- Loyal Hound
    [90567] = { hide = true }, -- Loyal Hound
    [90568] = { hide = true }, -- Loyal Hound
    [90569] = { hide = true }, -- Loyal Hound
    [87503] = { icon = 'esoui/art/icons/achievement_vvardenfel_012.dds', name = 'Divine Energy' }, -- Divine Hijack
    [90616] = { icon = 'esoui/art/icons/achievement_vvardenfel_012.dds', name = 'Divine Energy' }, -- Divine Hijack
    [87525] = { hide = true }, -- Divine Hijack
    [87522] = { icon = 'esoui/art/icons/achievement_vvardenfel_012.dds', name = 'Divine Energy' }, -- Divine Hijack
    [90524] = { hide = true }, -- Divine Hijack
    [92413] = { hide = true }, -- Contrived Portal

    -- Tutorial
    [92245] = { hide = true }, -- MQ1 Input Lock LAtk
    [83416] = { icon = 'LuiExtended/media/icons/abilities/ability_unarmed_attackheavy.dds'}, -- Heavy Attack
    [93577] = { hide = true }, -- MQ1 Tutorial Block Heavy
    [92263] = { hide = true }, -- Perma Set Off Balance Target
    [92266] = { hide = true }, -- MQ1 Tutorial Perma Off-Balance
    [92238] = { hide = true }, -- MQ1 Heat Wave (Tutorial)
    [92668] = { icon = 'esoui/art/icons/ability_dualwield_005.dds' }, -- Whirlwind
    [88904] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds', name = A.Skill_Bear_Trap, tooltip = T.Generic_Stun_No_Dur }, -- Metal Trap
    [88905] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_bear_trap.dds', name = A.Skill_Bear_Trap }, -- Metal Trap

    -- The Forgotten Wastes (Public Dungeon)
    [91659] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds', hide = true }, -- Falling Rocks -- Deadfall
    [88030] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds' }, -- Falling Rocks -- Deadfall
    [92671] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Pyroclast -- Meteor
    [92672] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_meteor.dds' }, -- Pyroclast -- Meteor
    [86983] = { icon = 'esoui/art/icons/ability_mage_018.dds', type = BUFF_EFFECT_TYPE_DEBUFF}, -- Succubus Touch
    [86984] = { hide = true }, -- Succubus Touch
    [86930] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [86932] = { hide = true}, -- Volcanic Debris
    [90500] = { hide = true}, -- Volcanic Debris
    [86934] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [86939] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [86938] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [92702] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [92709] = { hide = true}, -- Volcanic Debris
    [92703] = { hide = true}, -- Volcanic Debris
    [92707] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [92706] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris
    [92704] = { icon = 'esoui/art/icons/ability_mage_006.dds' }, -- Volcanic Debris

    -- Nchuleftingth (Public Dungeon)
    [84527] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam.dds' }, -- Searing Steam
    [90271] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_rod.dds' }, -- Charge-Wire Shock (Dwarven Charge-Wire)
    [90269] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_rod.dds' }, -- Charge-Wire Shock (Dwarven Charge-Wire)
    [90268] = { hide = true }, -- Charge Whire Shock -- Generic Flame Wave Target
    [92135] = { hide = true }, -- Nchuleftingth Electricity (Dwarven Charge-Wire)
    [86634] = { hide = true }, -- Swinging Cleave (Mud-Tusk)
    [86635] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_swinging_cleave.dds'}, -- Swinging Cleave (Mud-Tusk)
    [89210] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds'}, -- Boulder Toss (Mud-Tusk)
    [89240] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds'}, -- Boulder Toss (Mud-Tusk)
    [89239] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds'}, -- Boulder Toss (Mud-Tusk)
    [94935] = { hide = true }, -- Tremor (Mud-Tusk)
    [94936] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_tremor.dds' }, -- Tremor (Mud-Tusk)
    [86613] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Piston Thrust (Dwarven Piston)
    [86623] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Piston Thrust (Dwarven Piston)
    [90860] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Spike Trap (Dwarven Piston)
    [90859] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_steam_piston.dds', name = 'Steam Piston' }, -- Swinging Blades (Dwarven Piston)
    [86591] = { hide = true }, -- Piston Thrust
    [86592] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_piston_thrust.dds' }, -- Piston Thrust
    [86596] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_piston_thrust.dds' }, -- Piston Thrust
    [86595] = { hide = true }, -- Piston Thrust
    [69284] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_whirlwind_function.dds' }, -- Whirlwind Function (Guardian of Bthark)
    [86606] = { hide = true }, -- Steam Breath (Guardian of Bthark)
    [86607] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvencenturion_steam_breath.dds' }, -- Steam Breath (Guardian of Bthark)
    [90192] = { hide = true }, -- Overcharge (Nchuleftingth)
    [90212] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [90214] = { hide = true }, -- Overcharge (Nchuleftingth)
    [90215] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [90216] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [90217] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [71919] = { hide = true}, -- Turret Occupied (Nchuleftingth)
    [71920] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvensentry_turret_mode.dds' }, -- Turret Occupied (Nchuleftingth)
    [86566] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_fire_rune.dds' }, -- Fire Runes (Friar Hadelar)
    [86575] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Renduril the Hammer)
    [86570] = { icon = 'esoui/art/icons/ability_1handed_003.dds' }, -- Shield Charge (Renduril the Hammer)
    [86576] = { name = A.Innate_Stagger, hide = true }, -- Staggered (Renduril the Hammer)
    [95731] = { hide = true }, -- Dutiful Fury -- Renduril the Hammer
    [86574] = { hide = true }, -- Shield Charge -- Renduril the Hammer
    [51634] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_shocking_touch.dds' }, -- Shocking Touch (Steamreaver - Nchuleftingth)
    [86680] = { hide = true }, -- Auditory Signal (Steamreaver)
    [86691] = { hide = true }, -- Overcharge (Nchuleftingth)
    [86690] = { icon = 'LuiExtended/media/icons/abilities/ability_dwarvenspider_overcharge.dds' }, -- Overcharge (Nchuleftingth)
    [86688] = { hide = true }, -- Overcharge (Nchuleftingth)
    [86689] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe.dds' }, -- Overcharge (Nchuleftingth)
    [92136] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_crystal.dds', name = 'Overcharged Shock', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Laser Snare (Dwarven Charge-Wire)
    [92138] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_charge_wire_crystal.dds', name = 'Overcharged Shock' }, -- Laser Damage (Dwarven Charge-Wire)
    [89998] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90004] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90005] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90006] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90007] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90008] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90009] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [90010] = { hide = true }, -- Auditory Command (Artisan Lenarmen)
    [84333] = { icon = 'esoui/art/icons/achievement_vvardenfel_013.dds' }, -- Demolish (Nchulaeon the Eternal)
    [84336] = { icon = 'esoui/art/icons/achievement_vvardenfel_013.dds', hide = true }, -- Demolish (Nchulaeon the Eternal)
    [90788] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [84739] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [84755] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [91407] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90821] = { hide = true }, -- Enable (Nchulaeon the Eternal)
    [90863] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90867] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [91485] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90870] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [90874] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [91486] = { hide = true }, -- Indominable (Nchulaeon the Eternal)
    [84606] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' , hide = true }, -- Momentum
    [84616] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_aoe_alt.dds' }, -- Momentum
    [90597] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds' }, -- Overcharge Explusion
    [90598] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shock_pulse.dds', hide = true }, -- Overcharge Explusion

    ----------------------------------------------------------------
    -- SUMMERSET     -----------------------------------------------
    ----------------------------------------------------------------

    [100678] = { hide = true }, -- Major Protection (The Mind Trap)
    [100671] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attackheavy.dds' }, -- Heavy Attack (The Mind Trap)
    [100683] = { hide = true }, -- Block Me (The Mind Trap)
    [100677] = { hide = true }, -- Block Me (The Mind Trap)
    [100687] = { hide = true }, -- Off-Balance (The Mind Trap)
    [100690] = { hide = true }, -- Off-Balance (The Mind Trap)
    [100733] = { hide = true }, -- Heat Wave (The Mind Trap)

    [105498] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghralarva_flog.dds' }, -- Flog (Yaghra Larva)
    [105540] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghralarva_body_bash.dds' }, -- Body Bash (Yaghra Larva)
    [105561] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghralarva_momentous_discharge.dds', hide = true }, -- Momentous Discharge (Yaghra Larva)

    [105601] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds' }, -- Explosive Toxins (Yaghra Larva)
    [108773] = { hide = true }, -- Explosive Toxins (Yaghra Larva)
    [105604] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_necrotic_explosion.dds' }, -- Explosive Toxins (Yaghra Larva)

    [105737] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghranightmare_stab.dds' }, -- Stab (Yaghra Nightmare)
    [105739] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghranightmare_stab.dds' }, -- Stab (Yaghra Nightmare)
    [107282] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghranightmare_impale.dds' }, -- Impale (Yaghra Nightmare)
    [107299] = { icon = 'LuiExtended/media/icons/abilities/ability_yaghranightmare_impale.dds' }, -- Impale (Yaghra Nightmare)

    [105867] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_gtaoe.dds' }, -- Pustulant Eruption (Yaghra Nightmare)
    [105889] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_gtaoe.dds' }, -- Pustulant Eruption (Yaghra Nightmare)
    [105912] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_slime_alt.dds', duration = 0, groundLabel = true, tooltip = T.Generic_Snare_50 }, -- Pustulant Eruption (Yaghra Nightmare)
    [105893] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_slime_gtaoe.dds', name = A.Skill_Pustulant_Eruption }, -- Pustulant Film (Yaghra Nightmare)

    ----------------------------------------------------------------
    -- DUNGEONS    -------------------------------------------------
    ----------------------------------------------------------------

    -- Banished Cells I
    [19028] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_drain_essence.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Skill_Drain_Essence }, -- Drain Essence (Cell Haunter)

    [46258] = { hide = true }, -- Clannfear Arrives (Shadowrend)
    [18725] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_shadowrend_headbutt.dds' }, -- Spiked Headbutt (Shadowrend)
    [47587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_shadowrend_tail_spike.dds' }, -- Tail Smite (Shadowrend)
    [47608] = { icon = 'LuiExtended/media/icons/abilities/ability_set_monster_shadowrend_tail_spike.dds', name = A.Skill_Tail_Smite, tooltip = T.Generic_Knockdown }, -- Knocked Down (Shadowrend)
    [21886] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_shadow_proxy.dds', name = zo_strformat("<<1>> <<2>>", A.Innate_Summon, A.Skill_Shadow_Proxy), tooltip = T.Skill_Summon_Dark_Proxy }, -- Summon Dark Proxy (Shadowrend)
    [21887] = { hide = true }, -- Forward Charge (Dark Proxy)
    [35625] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap_shadowrend.dds' }, -- Pounce (Shadowrend)
    [18772] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_devour_shadowrend.dds', name = A.Skill_Devour, hide = true }, -- Feeding (Shadowrend)
    [18759] = { icon = 'LuiExtended/media/icons/abilities/ability_clannfear_rending_leap_shadowrend.dds', tooltip = T.Generic_Knockdown }, -- Pounce (Shadowrend)

    [18708] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_summon_daedra.dds', tooltip = T.Skill_Summon_Clannfear }, -- Summon Clannfear (Angata the Clannfear Handler)
    [18709] = { hide = true }, -- Summon Appearance (Angata the Clannfear Handler)

    [19025] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_dead_zone.dds' }, -- Dead Zone (Skeletal Destroyer)
    [19027] = { icon = 'LuiExtended/media/icons/abilities/ability_bonecolossus_dead_zone.dds', tooltip = T.Generic_AOE_Magic_1_5_Sec, groundLabel = true }, -- Dead Zone (Skeletal Destroyer)

    [18961] = { hide = true }, -- Ghostly Summon (Generic Invisible Target)
    [18798] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Slash (High Kinlord Rilis)
    [33189] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds' }, -- Crushing Blow (High Kinlord Rilis)
    [33190] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', hide = true }, -- Crushing Blow (High Kinlord Rilis)
    [33191] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Generic_Knockback }, -- Crushing Blow (High Kinlord Rilis)
    [33172] = { hide = true }, -- Oblivion Restoration (The Feast)
    [33165] = { hide = true }, -- Despawn Self (The Feast)

    [18840] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_death_bolt.dds', hide = true }, -- Soul Blast (High Kinlord Rilis)
    [18846] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_death_bolt.dds', hide = true }, -- Soul Blast (High Kinlord Rilis)
    [18847] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_death_bolt.dds', type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Generic_Knockback }, -- Soul Blast (High Kinlord Rilis)

    [18875] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_coldfire_gtaoe.dds', hide = true }, -- Daedric Tempest (High Kinlord Rilis)
    [33437] = { hide = true }, -- Daedric Tempest (High Kinlord Rilis)
    [33174] = { hide = true }, -- Daedric Tempest (High Kinlord Rilis)
    [33188] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_coldfire_gtaoe.dds', tooltip = T.Generic_AOE_Magic_1_5_Sec, groundLabel = true }, -- Daedric Tempest (High Kinlord Rilis)

    [36522] = { hide = true }, -- Daedric Flames (High Kinlord Rilis)
    [46296] = { hide = true }, -- Crystals (Binding Stones)

    -- Banished Cells II
    [64490] = { hide = true }, -- Shatter
    [46715] = { hide = true }, -- DUN_BCH Cruelty One Shot

    [28902] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_jagged_claw.dds' }, -- Swipe (Maw of the Infernal)
    [49150] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds', name = A.Skill_Breath_of_Flame }, -- Cone of Rot (Maw of the Infernal)
    [49149] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }, -- Breath of Flame (Maw of the Infernal)
    [35680] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds', unbreakable = 1, tooltip = T.Generic_Stun }, -- Immolating Bite (Maw of the Infernal)
    [28904] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_gtaoe.dds', name = A.Skill_Pool_of_Fire, groundLabel = true, tooltip = T.Generic_Aoe_Fire_1_5_Sec }, -- Immolating Bite (Maw of the Infernal)
    [47127] = { hide = true }, -- Nocom

    [48281] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Slash (Keeper Voranil)
    [27826] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds' }, -- Crushing Blow (Keeper Voranil)
    [27827] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', hide = true }, -- Crushing Blow (Keeper Voranil)
    [27828] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', tooltip = T.Generic_Knockback }, -- Crushing Blow (Keeper Voranil)
    [29018] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }, -- Berserker Frenzy (Keeper Voranil)
    [29020] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }, -- Berserker Frenzy (Keeper Voranil)
    [28750] = { icon = 'esoui/art/icons/ability_mage_008.dds', hide = true }, -- Essence Siphon (Keeper Voranil)

    [64518] = { hide = true }, -- Shatter

    [30734] = { hide = true }, -- Portal (Daedric Chaos)
    [31713] = { hide = true }, -- Root (Daedric Chaos)
    [31726] = { hide = true }, -- Corruption (Daedric Chaos)
    [32054] = { hide = true }, -- SpawnRun (Banekin)
    [32038] = { hide = true }, -- Into Portal (Keeper Imiril)
    [36631] = { hide = true }, -- ExitPortal (Keeper Imiril)

    [31727] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_daedric_chaos.dds', groundLabel = true, tooltip = T.Generic_AOE_Magic_1_Sec }, -- Corruption (Daedric Chaos)
    [28916] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Slash (Keeper Imiril)
    [29143] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_magic_aoe.dds' }, -- Daedric Blast (Keeper Imiril)

    [64526] = { hide = true }, -- Shatter

    [28962] = { icon = 'esoui/art/icons/ability_mage_030.dds', name = A.Skill_Sisters_Bond }, -- Sister's Love (Sister Sihna / Sister Vera)

    [35847] = { hide = true }, -- Shatter

    [28715] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_shock_ranged.dds' }, -- Daedric Bolt (High Kinlord Rilis)
    [28772] = { icon = 'esoui/art/icons/ability_debuff_levitate.dds', name = A.Skill_Levitate, unbreakable = 1, tooltip = T.Generic_Levitate }, -- Stun (High Kinlord Rilis)
    [28774] = { icon = 'esoui/art/icons/ability_debuff_levitate.dds', name = A.Skill_Levitate, unbreakable = 1, tooltip = T.Generic_Levitate }, -- Stun (High Kinlord Rilis)
    [28475] = { tooltip = T.Skill_Curse_of_Suffering, unbreakable = 1, duration = 0 }, -- Curse of Suffering (High Kinlord Rilis)
    [48308] = { icon = 'esoui/art/icons/ability_mage_023.dds' }, -- Curse of Suffering (High Kinlord Rilis)
    [28571] = { icon = 'esoui/art/icons/ability_mage_001.dds', tooltip = T.Skill_Curse_of_Dominance, unbreakable = 1, duration = 0 }, -- Curse of Dominance (High Kinlord Rilis)
    [48507] = { icon = 'esoui/art/icons/ability_mage_001.dds' }, -- Curse of Dominance (High Kinlord Rilis)

    [46967] = { hide = true }, -- Daedric Step (High Kinlord Rilis)
    [46964] = { hide = true }, -- Daedric Step (High Kinlord Rilis)
    [46965] = { hide = true }, -- Daedric Step (High Kinlord Rilis)
    [48909] = { hide = true }, -- The Feast (High Kinlord Rilis)
    [26070] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_the_feast_heal.dds' }, -- The Feast

    [48799] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_coldfire_gtaoe.dds' }, -- Daedric Tempest (High Kinlord Rilis)
    [48814] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_coldfire_gtaoe.dds' }, -- Daedric Tempest (High Kinlord Rilis)
    [48800] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_coldfire_gtaoe.dds', tooltip = T.Generic_AOE_Magic_1_5_Sec, groundLabel = true }, -- Daedric Tempest (High Kinlord Rilis)
    [48815] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_coldfire_gtaoe.dds', tooltip = T.Generic_AOE_Magic_1_5_Sec, groundLabel = true }, -- Daedric Tempest (High Kinlord Rilis)

    [28362] = { hide = true }, -- Black Sigil (High Kinlord Rilis)
    [36020] = { hide = true }, -- Black Sigil (High Kinlord Rilis)
    [28088] = { hide = true }, -- Red Sigil (High Kinlord Rilis)
    [36030] = { hide = true }, -- Red Sigil (High Kinlord Rilis)

    -- Elden Hollow I
    [14905] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Hacking Strike (Akash gra-Mal)
    [16834] = { icon = 'esoui/art/icons/ability_warrior_016.dds' }, -- Executioner's Strike (Akash gra-Mal)
    [25309] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = A.Skill_Executioners_Strike, hide = true }, -- Fire Backlash (Akash gra-Mal)
    [25310] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = A.Skill_Executioners_Strike, tooltip = T.Generic_Knockback }, -- CON_Knockback&Knockdown (Akash gra-Mal)
    [16003] = { icon = 'esoui/art/icons/ability_warrior_004.dds' }, -- Leaping Strike (Akash gra-Mal)
    [9936] = { icon = 'esoui/art/icons/ability_warrior_031.dds' }, -- Battlecry (Akash gra-Mal)
    [44093] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger }, -- Battlecry (Akash gra-Mal)
    [16016] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }, -- Berserker Frenzy (Akash gra-Mal)
    [16017] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }, -- Berserker Frenzy (Akash gra-Mal)
    [25300] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }, -- Berserker Frenzy (Akash gra-Mal)
    [25301] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }, -- Berserker Frenzy (Akash gra-Mal)
    [25302] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_swordstorm.dds' }, -- Berserker Frenzy (Akash gra-Mal)

    [15116] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_strike.dds' }, -- Piercing Strike (Chokethorn)
    [15114] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds', tooltip = T.Generic_Stun }, -- Pulling Grasp (Chokethorn)
    [25528] = { icon = 'LuiExtended/media/icons/abilities/ability_strangler_grapple.dds', tooltip = T.Generic_Stun }, -- Pulling Grasp (Chokethorn)

    [9910] = { icon = 'esoui/art/icons/mh_hedgeguardian_strang.dds', name = A.Skill_Summon_Saplings }, -- Summon Saplings (Chokethorn)
    [9930] = { icon = 'esoui/art/icons/mh_hedgeguardian_strang.dds', name = A.Skill_Heal_Spores, tooltip = T.Skill_Heal_Spores }, -- Heal Spores (Chokethorn)
    [9875] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_poison_aoe.dds' }, -- Fungal Burst (Chokethorn)
    [44092] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger }, -- Generic Stagger Enemy (Chokethorn)

    [44223] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_inhale.dds' }, -- Inhale (Leafseether)
    [44225] = { icon = 'LuiExtended/media/icons/abilities/ability_alit_inhale.dds', hide = true }, -- Inhale (Leafseether)

    [15120] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_entropic_bolt.dds' }, -- Phantasmal Bolt (Canonreeve Oraneth)
    [9845] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_poison_ranged.dds', hide = true }, -- Rotting Bolt (Canonreeve Oraneth)
    [9852] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_poison_ranged.dds', tooltip = T.Generic_Poison_2_Sec }, -- Rotting Bolt (Canonreeve Oraneth)

    [16262] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_necrotic_circle_ground.dds' }, -- Necrotic Circle (Canonreeve Oraneth)
    [25348] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_necrotic_circle.dds', tooltip = T.Generic_Stun }, -- Necrotic Circle (Canonreeve Oraneth)
    [42601] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_necrotic_circle_ground.dds', tooltip = T.Generic_AOE_Frost_0_5_Sec, groundLabel = true }, -- Necrotic Circle (Canonreeve Oraneth)
    [25370] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_necrotic_circle.dds' }, -- Necrotic Circle (Canonreeve Oraneth)
    [46800] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_necrotic_circle.dds', tooltip = T.Generic_Stun, unbreakable = 1 }, -- Necrotic Circle (Canonreeve Oraneth)

    [9944] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_necrotic_burst.dds' }, -- Necrotic Burst (Canonreeve Oraneth)
    [15682] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_necrotic_burst.dds', tooltip = T.Generic_Knockback }, -- Necrotic Burst (Canonreeve Oraneth)
    [15681] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_necrotic_burst.dds' }, -- Necrotic Burst (Canonreeve Oraneth)

    [9839] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_bone_hurricane.dds', tooltip = T.Generic_Damage_Shield_Duration }, -- Bone Hurricane (Canonreeve Oraneth)

    [27891] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_darkness_below.dds', tooltip = T.Generic_Stun }, -- Darkness Below (Elden Hollow)
    [27892] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_darkness_below.dds' }, -- Darkness Below (Elden Hollow)
    [27890] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_darkness_below.dds', tooltip = T.Generic_Stun, unbreakable = 1, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Darkness Below (Elden Hollow)
    [28886] = { hide = true }, -- Darkness Below

    -- Elden Hollow II
    [31114] = { hide = true }, -- EHH_Striker_Invis (Dremora Fearkyn)

    [34376] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }, -- Flame Geyser (Dubroze the Infestor)
    [34377] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds' }, -- Flame Geyser (Dubroze the Infestor)
    [34378] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_breath.dds', tooltip = T.Generic_Fear }, -- Flame Geyser (Dubroze the Infestor)

    [32709] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_lacerate.dds' }, -- Lacerate (Dark Root)
    [32569] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vestment_of_olirime.dds', hide = true }, -- Hammering Light (Dark Root)
    [32583] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vestment_of_olirime.dds', hide = true }, -- Hammering Light (Dark Root)
    [32587] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vestment_of_olirime.dds', hide = true }, -- Hammering Light (Dark Root)
    [32591] = { icon = 'LuiExtended/media/icons/abilities/ability_set_vestment_of_olirime.dds', hide = true }, -- Hammering Light (Dark Root)
    [32707] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_summon_beast_hoarvor.dds' }, -- Summon Guardians (Dark Root)
    [33334] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on_stamina.dds', name = A.Skill_Siphon_Stamina, tooltip = T.Skill_Siphon_Stamina }, -- Latch On Stamina (Frenzied Guardian)
    [33335] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on_stamina.dds', name = A.Skill_Siphon_Stamina }, -- Latch On Stamina (Frenzied Guardian)
    [33337] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on_magicka.dds', name = A.Skill_Siphon_Magicka, tooltip = T.Skill_Siphon_Magicka }, -- Latch On Magicka (Mystic Guardian)
    [33338] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on_magicka.dds', name = A.Skill_Siphon_Magicka }, -- Latch On MAgicka (Mystic Guardian)
    [32655] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_fortified_ground.dds', name = A.Skill_Fortified_Ground, groundLabel = true, tooltip = T.Skill_Dark_Root_Stamina }, -- Fortification (Fortified Guardian)
    [32614] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_empowered_ground.dds', name = A.Skill_Empowered_Ground, groundLabel = true, tooltip = T.Skill_Dark_Root_Magicka }, -- Empowered (Mystic Guardian)
    [32890] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_gleaming_light.dds', hide = true }, -- Gleaming Light (Dark Root)
    [33533] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_gleaming_light.dds', hide = true }, -- Glaring Light (Dark Root)
    [33535] = { icon = 'LuiExtended/media/icons/abilities/ability_spriggan_gleaming_light.dds' }, -- Brightening Light (Dark Root)

    -- Frostvault
    [117286] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', hide = true }, -- Rending Bleed (Coldsnap Goblin - Shared)
    [117486] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', name = A.Skill_Rending_Bleed, unbreakable = 1, tooltip = T.Generic_Bleed_2_Sec }, -- Bleed (Coldsnap Goblin - Shared)

    [109574] = { name = A.Skill_Rapid_Fire }, -- Fire Power (Coldsnap Harrier)
    [102945] = { icon = 'esoui/art/icons/ability_bow_006.dds', name = A.Skill_Rapid_Fire }, -- Firepower (Coldsnap Harrier)

    [117298] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_melee_attacklight.dds' }, -- Quick Strike (Coldsnap Snowstalker)
    [117352] = { icon = 'esoui/art/icons/ability_dualwield_005.dds' }, -- Whirlwind (Coldsnap Snowstalker)

    [117295] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_bite.dds' }, -- Bite (Coldsnap Durzog)
    [117296] = { icon = 'LuiExtended/media/icons/abilities/ability_durzog_rend.dds' }, -- Rend (Coldsnap Durzog)

    [117289] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_backhand.dds' }, -- Backhand (Coldsnap Ogre)
    [117290] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }, -- Shockwave (Coldsnap Ogre)
    [118491] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_shockwave.dds' }, -- Shockwave (Coldsnap Ogre)
    [117292] = { tooltip = A.Skill_Shockwave }, -- Off Balance (Coldsnap Ogre)
    [117291] = { hide = true, tooltip = T.Generic_Stagger }, -- Stagger (Coldsnap Ogre)
    [117287] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds' }, -- Crushing Blow (Coldsnap Ogre)
    [117288] = { icon = 'LuiExtended/media/icons/abilities/ability_ogre_smash.dds', tooltip = T.Generic_Knockdown }, -- Crushing Blow (Coldsnap Ogre)

    [117316] = { icon = 'esoui/art/icons/ability_mage_009.dds', hide = true }, -- Ice Arrow (Coldsnap Skysplitter)
    [117326] = { icon = 'esoui/art/icons/ability_mageguild_005_b.dds' }, -- Ice Comet (Coldsnap Skysplitter)
    [117327] = { icon = 'esoui/art/icons/ability_mageguild_005_b.dds' }, -- Ice Comet (Coldsnap Skysplitter)
    [117324] = { icon = 'esoui/art/icons/ability_mageguild_005_b.dds', tooltip = T.Generic_Knockdown }, -- Ice Comet (Coldsnap Skysplitter)

    [117309] = { icon = 'esoui/art/icons/ability_2handed_002.dds' }, -- Cleave (Coldsnap Frostbiter)

    [117346] = { tooltip = T.Generic_Snare_60 }, -- Low Slash (Coldsnap Toothbreaker)
    [114490] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_maim.dds', tooltip = T.Skill_Maim }, -- Maim (Coldsnap Toothbreaker)

    [109821] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_rock_toss.dds' }, -- Rock Toss (Icestalker)
    [109822] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_rock_toss.dds' }, -- Rock Toss (Icestalker)

    [109803] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }, -- Leaping Crush (Icestalker)
    [109802] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }, -- Leaping Crush (Icestalker)
    [109804] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }, -- Leaping Crush (Icestalker)
    [109805] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds' }, -- Leaping Crush (Icestalker)
    [116667] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds', name = A.Skill_Leaping_Crush }, -- Skeletal Smash (Icestalker)
    [116666] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_lope.dds', name = A.Skill_Leaping_Crush, tooltip = T.Generic_Knockback, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1 }, -- Skeletal Smash (Icestalker)

    [109827] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Icestalker)
    [109828] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds' }, -- Boulder Toss (Icestalker)
    [109831] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_boulder_toss.dds', tooltip = T.Generic_Knockdown }, -- Boulder Toss (Icestalker)

    [109811] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Ground Slam (Icestalker)
    [109819] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Ground Slam (Icestalker)
    [116684] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_shockwave.dds' }, -- Ground Slam (Icestalker)

    [109800] = { icon = 'LuiExtended/media/icons/abilities/ability_troll_slap.dds' }, -- Slap (Icestalker)

    [109833] = { icon = 'esoui/art/icons/achievement_frostvault_flavor_boss_1a.dds', name = A.Skill_Lifting_Strike }, -- Frenzied Pummeling (Icestalker)
    [109834] = { icon = 'esoui/art/icons/achievement_frostvault_flavor_boss_1a.dds' }, -- Lifting Strike (Icestalker)
    [109835] = { icon = 'esoui/art/icons/achievement_frostvault_flavor_boss_1a.dds', name = A.Skill_Lifting_Strike, type = BUFF_EFFECT_TYPE_DEBUFF, unbreakable = 1, tooltip = T.Generic_Knockback }, -- Frenzied Pummeling (Icestalker)

    [109837] = { icon = 'esoui/art/icons/achievement_frostvault_flavor_boss_2a.dds', name = A.Skill_Frenzied_Pummeling }, -- Frenzied Pummeling (Icestalker)
    [118489] = { icon = 'esoui/art/icons/achievement_frostvault_flavor_boss_2a.dds' }, -- Frenzied Pummeling (Icestalker)
    [121824] = { icon = 'esoui/art/icons/achievement_frostvault_flavor_boss_2a.dds' }, -- Frenzied Pummeling (Icestalker)
    [109838] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_recover.dds', name = A.Skill_Recover }, -- End Stun (Icestalker)

    [109806] = { icon = 'esoui/art/icons/ability_wrothgar_bitingcold.dds' }, -- Frozen Aura (Icestalker)
    [109808] = { icon = 'esoui/art/icons/ability_wrothgar_bitingcold.dds', name = A.Skill_Frozen_Aura, groundLabel = true, tooltip = T.Generic_Snare_50_No_Dur }, -- Frostbite (Icestalker)
    [109810] = { name = A.Innate_Stagger, tooltip = T.Generic_Stagger, hide = true }, -- Frozen Aura (Icestalker)

    [83430] = { icon = 'LuiExtended/media/icons/abilities/ability_set_icy_conjuror.dds' }, -- Skeletal Smash (Ice Wraith)
    [83454] = { icon = 'LuiExtended/media/icons/abilities/ability_set_icy_conjuror.dds' }, -- Skeletal Smash (Ice Wraith)
    [83453] = { icon = 'LuiExtended/media/icons/abilities/ability_set_icy_conjuror.dds', tooltip = T.Generic_Knockback }, -- Skeletal Smash (Ice Wraith)

    [116683] = { hide = true }, -- U23-DUN1 B N Intro (Skeevaton)

}

--------------------------------------------------------------------------------------------------------------------------------
-- If this abilityId is up, then pull the duration from another active ability Id to set its duration
--------------------------------------------------------------------------------------------------------------------------------
E.EffectPullDuration = {

    [107632] = 107629, -- Major Resolve --> Mend Spirit (Mend Spirit)
    [107631] = 107629, -- Major Ward --> Mend Spirit (Mend Spirit)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Buffs & Debuffs - Fake auras created by EVENT_COMBAT_EVENT for abilities that lack proper auras. Note tooltips & unbreakable status are determined in E.EffectOverride

    -- icon = '' -- Set an icon to use
    -- name = '' -- Set a name to use
	-- duration = # -- Set the duration of the effect
	-- ignoreFade = true -- Don't remove this effect when it fades.
	-- ignoreBegin = true -- Ignore effect begin and only apply on refresh - Emulates the same functionality as refreshOnly in E.EffectOverride. For stopping auras from being created for travel times.
	-- shiftId = # -- Shift the ability id displayed to use this id instead, for tooltip compatibility in some cases.
	-- overrideDuration = true -- Set duration to display as 0, but preserve the correct duration so this effect doesn't fade improperly.

--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Buffs applied onto the player by NPCs or Events (Friendly)
--------------------------------------------------------------------------------------------------------------------------------
E.FakeExternalBuffs = {

    -- Nightblade
    [64006] = { icon = 'esoui/art/icons/ability_nightblade_010_a.dds', name = A.Skill_Refreshing_Path, duration = 2000, overrideDuration = true }, -- Refreshing Path (Refreshing Path)

    -- MSQ
    [48345] = { icon = 'LuiExtended/media/icons/abilities/ability_templar_focused_healing.dds', name = A.Skill_Focused_Healing, duration = 4000 }, -- Focused Healing (The Prophet)

    -- Quests
    [21403] = { icon = 'esoui/art/icons/ability_mage_054.dds', name = A.Skill_Spiritual_Cloak, duration = 60000, ignoreFade = true }, -- Spiritual Cloak (The Mallari-Mora)

    ----------------
    -- Dungeons ----
    ----------------

    -- Elden Root II
    [32655] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_fortified_ground.dds', name = A.Skill_Fortified_Ground, duration = 0 }, -- Fortification (Fortified Guardian)
    [32614] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_empowered_ground.dds', name = A.Skill_Empowered_Ground, duration = 0 }, -- Empowered (Mystic Guardian)

}

--------------------------------------------------------------------------------------------------------------------------------
 -- Fake Debuffs applied onto the player by NPCs or Events (Hostile)
--------------------------------------------------------------------------------------------------------------------------------
E.FakeExternalDebuffs = {

    -- Nightblade
    [36964] = { icon = 'esoui/art/icons/ability_nightblade_006_b.dds', name = A.Skill_Crippling_Grasp, duration = 1500 }, -- Crippling Grasp (Crippling Grasp)

    -- Templar
    [24307] = { icon = 'esoui/art/icons/ability_templar_solar_disturbance.dds', name = A.Skill_Solar_Disturbance, duration = 0 }, -- Solar Disturbance Snare (Solar Disturbance)

    -- Destruction Staff
    [38946] = { icon = 'esoui/art/icons/ability_destructionstaff_007_b.dds', name = A.Skill_Flame_Reach, duration = 1800 }, -- Stun After Knockback Movement (Destructive Reach) -- Fire

    -- Werewolf
    [40520] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', name = A.Skill_Devour, duration = 7000 }, -- Q3047 - Knockdown (Blood Moon)

    -- Item Sets
    [75706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', name = A.Set_Bahrahas_Curse, duration = 0 }, -- Bahraha's Curse

    -- Traps
    [27479] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', name = A.Trap_Falling_Rocks, duration = 2000 }, -- Falling Rocks (Falling Rocks)
    [29602] = { icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', name = A.Trap_Falling_Rocks, duration = 2000 }, -- Falling Rocks (Cave-In)

    [31606] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', name = A.Trap_Fire_Trap, duration = 0 }, -- Fire Trap (Player)

    [72890] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', name = A.Trap_Fire_Trap, duration = 0 }, -- Laser Snare (Fire)

    [66153] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Trial of Flame', duration = 1500}, -- Trial of Flame (Wrothgar - Old Orsinium)
    [32246] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Steam Trap', duration = 2000}, -- Laser Snare (Steam Trap)

    -- Quest Traps
    [64535] = {icon = 'esoui/art/icons/ability_wrothgar_chillingwind.dds', name = 'Chilling Wind', duration = 2000}, -- Chilling Wind (Orsinium - Sorrow's Kiss)
    [67586] = {icon = 'esoui/art/icons/ability_wrothgar_avalanche.dds', name = 'Avalanche', duration = 2500}, -- Avalanche (Orsinium - Sorrow's Kiss)

    -- Justice NPC's
    [63160] = { icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash, duration = 2000 }, -- Heavy Blow Knockdown (Justice Guard)
    [63263] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = A.Skill_Heavy_Blow, duration = 2000 }, -- Heavy Blow Knockdown (Justice Guard)
    [63094] = { icon = 'esoui/art/icons/ability_1handed_003.dds', name = A.Skill_Shield_Charge, duration = 1500 }, -- Shield Charge (Justice Guard 1H)
    [63260] = { icon = 'esoui/art/icons/ability_2handed_003.dds', name = A.Skill_Mighty_Charge, duration = 1500 }, -- Shield Charge (Justice Guard 2H)
    [63194] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = A.Skill_Stonefist, duration = 6000 }, -- Flame Shard (Justice Guard 2H)
    [63168] = { icon = 'esoui/art/icons/ability_dragonknight_010.dds', name = A.Skill_Cage_Talons, duration = 3500, ignoreBegin = true }, -- Cage Talons (Justice Guard 1H + 2H)

    -- Standard NPC Abilities
    [29401] = { icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash, duration = 3000 }, --Power Bash (NPC Disorient)
    [14926] = { icon = 'esoui/art/icons/ability_warrior_011.dds', name = A.Skill_Shield_Rush, duration = 2000 }, -- Charge (Human NPC)
    [10650] = { icon = 'LuiExtended/media/icons/abilities/ability_warrior_oil_drenched.dds', name = A.Skill_Oil_Drenched, duration = 0 }, -- Oil Drenched
    [79930] = { icon = 'esoui/art/icons/ability_rogue_066.dds', name = A.Skill_Lunge, duration = 2500 }, -- Lunge (Tracker) (Morrowind)

    -- Animals
    [69073] = { icon = 'LuiExtended/media/icons/abilities/ability_bear_crushing_swipe.dds', name = A.Skill_Slam, duration = 2000 }, -- Knockdown (Bear Orsinium)
    [74336] = { icon = 'LuiExtended/media/icons/abilities/ability_hajmota_bog_burst.dds', name = A.Skill_Bog_Burst, duration = 2000 }, -- Bog Burst (Haj Mota)
    [14523] = { icon = 'LuiExtended/media/icons/abilities/ability_wolf_helljoint.dds', duration = 6000, name = A.Skill_Helljoint, ignoreBegin = true }, -- Helljoint (Wolf)
    [85394] = { icon = 'LuiExtended/media/icons/abilities/ability_cliffstrider_slash.dds', name = A.Skill_Slash, duration = 8000 }, -- Slash (Cliff Strider Matriach)

    -- Daedra
    [50023] = { icon = 'LuiExtended/media/icons/abilities/ability_airatronach_lightning_rod.dds', name = A.Skill_Lightning_Rod, duration = 4000, ignoreBegin = true }, -- Lightning Rod (Air Atronach)
    [33551] = { icon = 'LuiExtended/media/icons/abilities/ability_frostatronach_chilling_aura.dds', name = A.Skill_Chilling_Aura, duration = 0 }, -- Chilling Aura (Frost Atronach)
    [51646] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_snare_frost.dds', name = A.Skill_Frozen_Ground, duration = 0 }, -- Frozen Ground (Frost Atronach)
    [24700] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_body_slam.dds', name = A.Skill_Body_Slam, duration = 2000 }, -- Body Slam (Ogrim)
    [91851] = { icon = 'LuiExtended/media/icons/abilities/ability_kwamaworker_shattered_ground.dds', name = A.Skill_Stomp, duration = 2000 }, -- Stomp (Ogrim)
    [12287] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds', name = A.Skill_Storm_Bound, duration = 8000 }, -- Storm Bound (Storm Atronach) (DOT)
    [12288] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_storm_bound.dds', name = A.Skill_Storm_Bound, duration = 8000 }, -- Storm Bound (Storm Atronach) (Snare)
    [6412] = { icon = 'LuiExtended/media/icons/abilities/ability_wingedtwilight_dusks_howl.dds', name = A.Skill_Dusks_Howl, duration = 2000, ignoreBegin = true }, -- Dusk's Howl (Winged Twilight)

    -- Insects
    [9237] = { icon = 'LuiExtended/media/icons/abilities/ability_wasp_inject_larva.dds', name = A.Skill_Inject_Larva, duration = 10000 }, -- Larva Gestation (Giant Wasp)
    [6795] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on.dds', name = A.Skill_Latch_On, duration = 7500 }, -- Latch On (Hoarvor)
    [61372] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_infectious_swarm.dds', name = A.Skill_Infectious_Swarm, duration = 4000 }, -- Infectious Swarm (Necrotic Hoarvor)
    [8429] = { icon = 'LuiExtended/media/icons/abilities/ability_thunderbug_zap.dds', name = A.Skill_Zap, duration = 4000, ignoreBegin = true }, -- Zap (Thunderbug)

    -- Monsters
    [17703] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_flame_ray.dds', name = A.Skill_Flame_Ray, duration = 4000, ignoreBegin = true }, -- Flame Ray (Imp - Fire)
    [8884] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_zap.dds', name = A.Skill_Zap, duration = 4000, ignoreBegin = true }, -- Zap (Imp - Lightning)
    [81794] = { icon = 'LuiExtended/media/icons/abilities/ability_imp_frost_ray.dds', name = A.Skill_Frost_Ray, duration = 4000, ignoreBegin = true }, -- Frost Ray (Imp - Frost)
    [48287] = {icon = 'esoui/art/icons/achievement_update11_dungeons_029.dds', name = A.Skill_Consuming_Omen, duration = 1500}, -- Consuming Omen (Troll - Ranged) (Fake aura to replace bugged aura)

    -- Undead
    [38834] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_desecrated_ground_snare.dds', name = A.Skill_Desecrated_Ground, duration = 0 }, -- Desecrated Ground Snare (Desecrated Ground)
    [22525] = {icon = 'LuiExtended/media/icons/abilities/ability_mage_defiled_ground.dds', name = A.Skill_Defiled_Ground, duration = 0 }, -- Defiled Ground (Lich)
    [43146] = {icon = 'esoui/art/icons/ability_mage_037.dds', name = A.Skill_Winters_Reach, duration = 4000 }, -- Winter's Reach (Wraith)

    -- Cyrodiil
    [72641] = {icon = 'esoui/art/icons/ability_1handed_005.dds', name = A.Skill_Power_Bash, duration = 2000}, -- Power Bash (Cryodiil Guard T2)

    -- Craglorn: TODO
    [55862] = {icon = 'LuiExtended/media/icons/abilities/ability_stormbound.dds', name = A.Skill_Storm_Bound, duration = 8000}, --Storm Bound --Used by Craglorn Boss Wamasu (DOT)
    [55863] = {icon = 'LuiExtended/media/icons/abilities/ability_stormbound.dds', name = A.Skill_Storm_Bound, duration = 8000}, --Storm Bound --Used by Craglorn Boss Wamasu (Snare)

    -- Traps
    [11338] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_lava.dds', name = A.Trap_Lava, duration = 0 }, -- Lava -- In Lava

    ------------------------------
    -- Quests --------------------
    ------------------------------

    -- Main Story
    [14972] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, duration = 2000 }, -- CON_Knockback&Knockdown (Castle of the Worm)
    [44561] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, duration = 3000 }, -- FGQ4 RGT Event Knockback (Lyris Doppleganger - Halls of Torment)
    [38741] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_royal_strike.dds', name = A.Skill_Royal_Strike, duration = 4000 }, -- Royal Snare (Duchess of Anguish - Halls of Torment)
    [40429] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, duration = 2000 }, -- IntroKB (Mannimarco - Shadow of Sancre Tor)
    [41198] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, duration = 2000 }, -- IntroKB (Mannimarco - Shadow of Sancre Tor)

    -- Fighter's Guild
    [14974] = { icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = A.Skill_Knockback, duration = 2000 }, -- CON_Knockback&KnockdownSelf (Anchors from the Harbour)
    [39579] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_palolels_rage.dds', name = A.Skill_Palolels_Rage, duration = 2000 }, -- CON_Knockback&Knockdown (The Prismatic Core)
    [25979] = { icon = 'LuiExtended/media/icons/abilities/ability_set_draugrs_rest.dds', name = A.Skill_Prismatic_Light, duration = 1000 }, -- FG4 RGT Event Knockback

    -- Mages Guild
    [31502] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks_brown.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Rock, A.Skill_Barrier), duration = 4000 }, -- MGQ2 Asakala Sahdina Barrier
    [31503] = { icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks_brown.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Rock, A.Skill_Barrier), duration = 4000 }, -- MGQ2 Asakala Rashomta Barrier

    -- Aldmeri Dominion
    [21876] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, duration = 4500 }, -- Q4260 West Barrier Teleport (Breaking the Barrier)
    [21878] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, duration = 4500 }, -- Q4260 East Barrier Teleport (Breaking the Barrier)
    [22395] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_stun_generic.dds', name = A.Skill_Barrier_Rebuke, duration = 4000 }, -- Q4261 ROD Barrier Teleport (Sever All Ties)
    [28771] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_atherial_shift.dds', name = A.Skill_Aetherial_Shift, duration = 2000 }, -- Q4220 Thirster Stun (The Mallari-Mora)
    [23606] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_feedback_crystal.dds', name = zo_strformat("<<1>> <<2>>", A.Skill_Crystal, A.Skill_Backfire), duration = 2000 }, -- Q4326 Crystal Backfire (Preventative Measure)
    [43823] = { icon = 'LuiExtended/media/icons/abilities/ability_ogrim_stomp.dds', name = A.Skill_Quaking_Stomp, duration = 2150 }, -- IntroKB (Prince Naemon)
    [36766] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_headgrab.dds', name = A.Skill_Feedback, duration = 5000 }, -- Q4842 Stun Headgrab Knockback (The Unquiet Dead)
    [33384] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_grasping_vines.dds', name = A.Skill_Restricting_Vines, duration = 4000 }, -- Q4586 Aranias Vine Stun
    [49897] = { icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds', name = A.Skill_Fire, duration = 2000 }, -- Fire

    ----------------------------------------------------------------
    -- ORSINIUM EVENTS ---------------------------------------------
    ----------------------------------------------------------------

    --[[
    [69794] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Frozen Ground', duration = 2000}, -- Frozen Ground (Invitation to Orsinium - Olarz the Cunning)
    [53272] = {icon = 'esoui/art/icons/ability_destructionstaff_005.dds', name = 'Frost Clench', duration = 500}, -- Frost Clench (The Anger of a King - Talviah Aliaria)
    [66875] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Royal Strike', duration = 1500}, -- Royal Strike (Blood on a King's Hands)
    [65186] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'The King\'s Chains', duration = 4000}, -- The King's Chains (Blood on a King's Hands)
    [67014] = {icon = 'esoui/art/icons/ability_debuff_stun.dds', name = 'Tear Down the Mountain', duration = 2000}, -- Tear Down the Mountain (Blood on a King's Hands)
    [73861] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Murky Water', duration = 0}, -- Murky Water (Blood and the Sacred Words)
    [73864] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Murky Water', duration = 3000}, -- Murky Water (Blood and the Sacred Words)
    [72128] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Harmonic Wave Impact', duration = 2000}, -- Harmonic Wave Impact (Rkindaleft - Resonant Centurion)
    [25265] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Decapitation Function', duration = 2000}, -- Decapitation Function (Rkindaleft - Vessel of the Auditor)
    [70316] = {icon = 'esoui/art/icons/ability_debuff_knockback.dds', name = 'Vessel Knockback', duration = 2000}, -- Q5321 Centurian Knockback (Rkindaleft - Vessel of the Auditor)
    ]]--

    ----------------------------------------------------------------
    -- VVARDENFELL -------------------------------------------------
    ----------------------------------------------------------------

    -- The Forgotten Wastes (Public Dungeon)
    [88030] = {icon = 'LuiExtended/media/icons/abilities/ability_trap_falling_rocks.dds', name = A.Trap_Falling_Rocks, duration = 1500}, -- Falling Rocks -- Deadfall
    [87348] = {icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser', duration = 1500}, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [87350] = {icon = 'LuiExtended/media/icons/abilities/ability_trap_water_geyser.dds', name = 'Water Geyser', duration = 2000}, -- Water Geyser Burst (Vvardenfell -- A Hireling of House Telvanni)
    [89756] = {icon = 'esoui/art/icons/achievement_wrothgar_006.dds', name = 'Centurion Drop', duration = 2000}, -- Guardian Shockwave (Mzanchend Guardian -- Vvardenfell -- The Magister Makes a Move)

    ----------------------------------------------------------------
    -- DUNGEONS ----------------------------------------------------
    ----------------------------------------------------------------

    -- Banished Cells II
    [35680] = { icon = 'LuiExtended/media/icons/abilities/ability_daedroth_fiery_jaws.dds', name = A.Skill_Immolating_Bite, duration = 2250 }, -- Immolating Bite (Maw of the Infernal)
    [27828] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_heavy_blow.dds', name = A.Skill_Crushing_Blow, duration = 2500 }, -- Crushing Blow (Keeper Voranil)
    [28772] = { icon = 'esoui/art/icons/ability_debuff_levitate.dds', name = A.Skill_Levitate, duration = 5000 }, -- Stun (High Kinlord Rilis)
    [28774] = { icon = 'esoui/art/icons/ability_debuff_levitate.dds', name = A.Skill_Levitate, duration = 5000 }, -- Stun (High Kinlord Rilis)

    -- Frostvault
    [117486] = { icon = 'LuiExtended/media/icons/abilities/ability_weapon_bleeding_strike.dds', name = A.Skill_Rending_Bleed, duration = 18000 }, -- Bleed (Coldsnap Goblin - Shared)
    [109808] = { icon = 'esoui/art/icons/ability_wrothgar_bitingcold.dds', name = A.Skill_Frozen_Aura, duration = 0 }, -- Frostbite (Icestalker)

    -- Elden Hollow I
    [25310] = { icon = 'esoui/art/icons/ability_warrior_016.dds', name = A.Skill_Executioners_Strike, duration = 2500 }, -- Leaping Strike (Akash gra-Mal)
    [25348] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_necrotic_circle.dds', name = A.Skill_Necrotic_Circle, duration = 6000, ignoreBegin = true }, -- Necrotic Circle (Canonreeve Oraneth)
    [46800] = { icon = 'LuiExtended/media/icons/abilities/ability_mage_necrotic_circle.dds', name = A.Skill_Necrotic_Circle, duration = 1200 }, -- Necrotic Circle (Canonreeve Oraneth)

    -- Elden Hollow II
    [33334] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on_stamina.dds', name = A.Skill_Siphon_Stamina, ignoreBegin = true, duration = 7500 }, -- Latch On Stamina (Frenzied Guardian)
    [33337] = { icon = 'LuiExtended/media/icons/abilities/ability_hoarvor_latch_on_magicka.dds', name = A.Skill_Siphon_Magicka, ignoreBegin = true, duration = 7500 }, -- Latch On Magicka (Mystic Guardian)

}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake buffs applied onto the player by self (also supports debuffs with debuff = true)
--------------------------------------------------------------------------------------------------------------------------------
E.FakePlayerBuffs = {
    -- Misc Consumables
    --[85355] = {icon = 'LuiExtended/media/icons/mementos/memento_fire-breathers_torches.dds', name = A.Memento_Fire_Breathers_Torches, duration = 12000}, -- Flame Juggling (Consumable Version)
    --[85354] = {icon = 'LuiExtended/media/icons/mementos/memento_jugglers_knives.dds', name = A.Memento_Jugglers_Knives, duration = 12000}, -- Dagger Juggling (Consumable Verison)
    --[85353] = {icon = 'LuiExtended/media/icons/mementos/memento_sword-swallowers_blade.dds', name = A.Memento_Sword_Swallowers_Blade, duration = 12000}, -- Sword Swallowing (Consumable Version)

    -- Base Mementos
    [41988] = {icon = 'LuiExtended/media/icons/mementos/memento_bonesnap_binding_stone.dds', name = A.Memento_Bonesnap_Binding_Stone, duration = 10000}, -- Bonesnap Binding Stone (Bonesnap Binding Stone)
    [39245] = {icon = 'LuiExtended/media/icons/mementos/memento_discourse_amaranthine.dds', name = A.Memento_Discourse_Amaranthine, duration = 10000}, -- Glimpse of the Forbidden (Discoure Amaranthine)
    --[42076] = {icon = 'LuiExtended/media/icons/mementos/memento_mezha-dros_sealing_amulet.dds', name = A.Memento_Sealing_Amulet, duration = 8000}, -- Tear (Mezha-dro's Sealing Amulet)
    --[34578] = {icon = 'LuiExtended/media/icons/mementos/memento_nirnroot_wine.dds', name = A.Memento_Nirnroot_Wine, duration = 8000}, -- Nirnroot Wine (Nirnroot Wine)
    [26339] = {icon = 'LuiExtended/media/icons/mementos/memento_questionable_meat_sack.dds', name = A.Memento_Mystery_Meat, duration = 5500}, -- Questionable Meat Sack (Questionable Meat Sack)
    [25369] = {icon = 'LuiExtended/media/icons/mementos/memento_sanguines_goblet.dds', name = A.Memento_Sanguines_Goblet, duration = 10000}, -- Sanguine's Goblet (Sanguine's Goblet)
    [42008] = {icon = 'LuiExtended/media/icons/mementos/memento_token_of_root_sunder.dds', name = A.Memento_Token_of_Root_Sunder, duration = 10000}, -- Blessing of Root Sunder (Token of Root Sunder)
    --[42053] = {icon = 'LuiExtended/media/icons/mementos/memento_yokudan_totem.dds', name = A.Memento_Yokudan_Totem, duration = 10000}, -- Yokudan Salute (Yokudan Totem)

    -- DLC Mementos
    --[89550] = {icon = 'LuiExtended/media/icons/mementos/memento_twilight_shard.dds', name = A.Memento_Twilight_Shard, duration = 9000 }, -- TROPHY Azura's Light (Twilight Shard)
    --[79510] = {icon = 'LuiExtended/media/icons/mementos/memento_blade_of_the_blood_oath.dds', name = A.Memento_Blade_of_the_Blood_Oath, duration = 6500}, -- TROPHY Blood Oath (Blade of the Blood Oath)
    --[74151] = {icon = 'LuiExtended/media/icons/mementos/memento_hidden_pressure_vent.dds', name = A.Memento_Hidden_Pressure_Vent, duration = 2500}, -- Stun (Hidden Pressure Vent)

    -- Crown Store Mementos
    [85349] = {icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_transform.dds', name = A.Memento_Storm_Atronach_Transform, duration = 180000}, -- Storm Atronach Transform (Atronach Transformation)
    --[85347] = {icon = 'LuiExtended/media/icons/mementos/memento_storm_atronach_juggle.dds', name = A.Memento_Storm_Orb_Juggle, duration = 12000}, -- Storm Orb Juggle (Atronach Juggling)
    [86977] = {icon = 'LuiExtended/media/icons/mementos/memento_wild_hunt_transform.dds', name = A.Memento_Wild_Hunt_Transform, duration = 180000}, -- Spriggan Transformation (Wild Hunt Transform)
    [92868] = {icon = 'LuiExtended/media/icons/mementos/memento_dwemervamidium_mirage.dds', name = A.Memento_Dwemervamidium_Mirage, duration= 180000}, -- Dwarven Transformation (Dwemervamidium Mirage)
    --[97273] = { icon = 'LuiExtended/media/icons/mementos/memento_crows_calling.dds', name = A.Memento_Crows_Calling, duration = 9000 }, -- TROPHY Death Crate Mem 1 (Crow's Calling)
    [97274] = { icon = 'esoui/art/icons/achievement_update16_017.dds', name = A.Memento_Swarm_of_Crows, duration = 180000 }, -- Swarm of Crows (Swarm of Crows)

    --[99318] = { icon = 'LuiExtended/media/icons/mementos/memento_fiery_orb.dds', name = A.Memento_Fiery_Orb, duration = 9000 }, -- TROPHY Flame Crate Mem 1 (Fiery Orb)
    --[99319] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_pixie.dds', name = A.Memento_Flame_Pixie, duration = 8000 }, -- Flame Crate Memento 2 (Flame Pixie)
    --[99320] = { icon = 'LuiExtended/media/icons/mementos/memento_flame_eruption.dds', name = A.Memento_Flame_Eruption, duration = 2000 }, -- TROPHY Flame Crate Mem 3 (Flame Eruption)
    --[101874] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_frost_shard.dds', name = A.Memento_Frost_Shard, duration = 10000 }, -- _CRWN Dragon Priest Mem2 Ice T (Scalecaller Frost Shard)
    --[101877] = { icon = 'LuiExtended/media/icons/mementos/memento_scalecaller_rune_of_levitation.dds', name = A.Memento_Rune_of_Levitation, duration = 9000 }, -- _CRWN Dragon Priest Mem1 Fl/St (Scalecaller Rune of Levitation)
    --[101872] = { icon = 'LuiExtended/media/icons/mementos/memento_bone_dragon_summons_focus.dds', name = A.Memento_Dragon_Summons_Focus, duration = 5000 }, -- _CRWN Dragon Priest Memento3 (Bone Dragon Summons Focus)
    [110483] = { icon = 'LuiExtended/media/icons/mementos/memento_ghost_lantern.dds', name = A.Memento_Ghost_Lantern, duration = 6800 }, -- Ghost Lantern (Ghost Lantern)

    -- Set Items
    --[59573] = { icon = 'esoui/art/icons/ability_buff_major_vitality.dds', name = A.Skill_Major_Vitality, duration = 510 }, -- Major Vitality (Malubeth) TODO: Doesn't work
    [98421] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [98419] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [98420] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [81675] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [83288] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [83287] = { icon = 'esoui/art/icons/achievement_housing_038.dds', name = A.Set_Pirate_Skeleton, duration = 12000 }, -- Pirate Skeleton
    [71107] = { icon = 'LuiExtended/media/icons/abilities/ability_set_briarheart.dds', name = A.Set_Briarheart, duration = 10000 }, -- Briarheart
    [97627] = { icon = 'esoui/art/icons/achievement_update11_dungeons_036.dds', name = A.Set_Ironblood, duration = 10000, debuff = true, shiftId = 97626 }, -- Ironblood

    -- Player (Basic)
    [973] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_sprint.dds', name = A.Innate_Sprint, duration = 0}, -- Sprint
    [33439] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_mount_sprint.dds', name = A.Innate_Gallop, duration = 0}, -- Mount Sprint (Generic)
    --[32346] = {icon = 'esoui/art/icons/ability_mage_050.dds', name = A.Innate_Absorbing_Skyshard, duration = 5800}, -- Skyshard Collect
    --[14031] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_mundus_use.dds', name = A.Innate_Receiving_Boon, duration = 5000}, -- Mundus Use

    -----------------
    -- Class --------
    -----------------

    -- Dragonknight
    [32956] = { icon = 'esoui/art/icons/ability_dragonknight_006_b.dds', name = A.Skill_Standard_of_Might, duration = 0 }, -- Standard of Might (Standard of Might)
    [31841] = { icon = 'esoui/art/icons/ability_dragonknight_012.dds', name = A.Skill_Inhale, duration = 2500 }, -- Inhale
    [32796] = { icon = 'esoui/art/icons/ability_dragonknight_012_a.dds', name = A.Skill_Deep_Breath, duration = 2500 }, -- Deep Breath
    [32788] = { icon = 'esoui/art/icons/ability_dragonknight_012_b.dds', name = A.Skill_Draw_Essence, duration = 2500 }, -- Draw Essence

    -- Templar
    [22223] = { icon = 'esoui/art/icons/ability_templar_rite_of_passage.dds', name = A.Skill_Rite_Of_Passage, duration = 4000 }, -- Rite of Passage (Rite of Passage)
    [22229] = { icon = 'esoui/art/icons/ability_templar_remembrance.dds', name = A.Skill_Remembrance, duration = 4000 }, -- Remembrance (Remembrance)
    [22226] = { icon = 'esoui/art/icons/ability_templar_practiced_incantation.dds', name = A.Skill_Practiced_Incantation, duration = 6000 }, -- Practiced Incantation (Practiced Incantation)

    -- Vampire
    --[40350] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', name = A.Skill_Feed, duration = 5300 }, -- Feed (Blood Ritual)
    --[33175] = { icon = 'LuiExtended/media/icons/abilities/ability_vampire_feed.dds', name = A.Skill_Feed, duration = 6300 }, -- Feed (Vampire - Feed)

    -- Mages Guild
    [40449] = { icon = 'esoui/art/icons/ability_mageguild_003_a.dds', name = A.Skill_Spell_Symmetry, duration = 5000 }, -- Spell Symmetry (Spell Symmetry)

    -- Seasonal Quests (New Life Festival)
    --[84125] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Breton Male Dance (Lava Foot Stomp)
    --[84126] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Breton Female Dance (Lava Foot Stomp)
    --[84127] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Dunmer Male Dance (Lava Foot Stomp)
    --[84128] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Dunmer Female Dance (Lava Foot Stomp)
    --[84130] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Altmer Male Dance (Lava Foot Stomp)
    --[84131] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Altmer Female Dance (Lava Foot Stomp)
    --[84133] = {icon = 'esoui/art/icons/achievement_newlifefestival_002.dds', name = A.Skill_Lava_Foot_Stomp, duration = 10000}, -- Nord Dance (Lava Foot Stomp)
    --[84528] = {icon = 'LuiExtended/media/icons/abilities/ability_event_torch_juggling.dds', name = A.Skill_Torch_Juggling, duration = 12000}, -- Flame Juggling (Castle Charm Challenge)
    --[84506] = {icon = 'LuiExtended/media/icons/abilities/ability_event_knife_juggling.dds', name = A.Skill_Knife_Juggling, duration = 12000}, -- Dagger Juggling (Castle Charm Challenge)
    --[84533] = {icon = 'LuiExtended/media/icons/abilities/ability_event_sword_swallowing.dds', name = A.Skill_Sword_Swallowing, duration = 12000}, -- Sword Swallowing (Castle Charm Challenge)
    --[84847] = {icon = 'LuiExtended/media/icons/abilities/ability_event_celebratory_belch.dds', name = A.Skill_Celebratory_Belch, duration = 5000}, -- Celebratory Belch (Stonetooth Bash)

    ------------------------------
    -- Quests --------------------
    ------------------------------

    -- Mages Guild
    [26406] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_essence.dds', name = A.Skill_Essence, duration = 0 }, -- MG2 Captured Essence (Simply Misplaced)
    [26634] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_essence_greater.dds', name = A.Skill_Sahdinas_Essence, duration = 0 }, -- MG2 Captured Sahdina Essence
    [26581] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_essence_greater.dds', name = A.Skill_Rashomtas_Essence, duration = 0 }, -- MG2 Captured Rashomta Essence

    -- Aldmeri Dominion
    [33066] = { icon = 'LuiExtended/media/icons/disguises/disguise_fancy_clothing.dds', name = A.Skill_Fancy_Clothing, duration = 0, long = true, ignoreBegin = true }, -- Q4586_ChangeClothes
    [29504] = { icon = 'LuiExtended/media/icons/abilities/ability_quest_shadow_wood.dds', name = A.Skill_Shadow_Wood, duration = 0, long = true }, -- Q4546 Shade Layer

    -- Quest related (Craglorn)
    --[81807] = {icon = 'esoui/art/icons/achievement_104.dds', name = 'Power of the Stars', duration = 22000}, -- Power of the Stars (The Star-Gazers)

    -- Orsinium
    --[66453] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_hidden.dds', name = 'Hiding', duration = 45000}, -- Hiding (A Question of Succession)
}

--------------------------------------------------------------------------------------------------------------------------------
-- TODO: Fake buffs applied onto a target by the player
--------------------------------------------------------------------------------------------------------------------------------
E.FakePlayerExternalBuffs = {



}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake debuffs applied onto a target by the player
--------------------------------------------------------------------------------------------------------------------------------
E.FakePlayerDebuffs = {
    -- JUSTICE NPCS
    -- Disabled: Duration is too long and Guard always CC breaks. Maybe setup a calllater removal function?
    --[63194] = { icon = 'esoui/art/icons/ability_dragonknight_013.dds', name = A.Skill_Stonefist, duration = 6000 }, -- Flame Shard (Justice Guard 2H) -- If the player reflects

    ----------------------------------------------------------------
    -- PLAYER ABILITIES --------------------------------------------
    ----------------------------------------------------------------

    [86309] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, duration = 3000}, -- Stun (Player blocks NPC charged attack)
    [86312] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_block_stun.dds', name = A.Innate_Block_Stun, duration = 3000}, -- Stun (Player blocks Ogrim Body Slam)

    -- Nightblade
    [36964] = { icon = 'esoui/art/icons/ability_nightblade_006_b.dds', name = A.Skill_Crippling_Grasp, duration = 1500 }, -- Crippling Grasp (Crippling Grasp)

    -- Destruction Staff
    [38946] = { icon = 'esoui/art/icons/ability_destructionstaff_007_b.dds', name = A.Skill_Flame_Reach, duration = 1800 }, -- Stun After Knockback Movement (Destructive Reach) -- Fire

    -- Werewolf
    [40520] = { icon = 'LuiExtended/media/icons/abilities/ability_werewolf_devour.dds', name = A.Skill_Devour, duration = 7000 }, -- Q3047 - Knockdown (Blood Moon)

    -- Item Sets
    [75706] = { icon = 'LuiExtended/media/icons/abilities/ability_set_bahrahas_curse.dds', name = A.Set_Bahrahas_Curse, duration = 1100, overrideDuration = true }, -- Bahraha's Curse -- Note: We add 100 ms to buffer here because it doesn't really matter and stops flashing
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Stagger Effects - For debuffs applied on the player or on a target that don't need to check for a removal condition (Useful for effects like staggers where this is no way to break out of them for the short duration they are applied.
--------------------------------------------------------------------------------------------------------------------------------
E.FakeStagger = {
    -- Player Basic
    [115607] = {icon = 'LuiExtended/media/icons/abilities/ability_innate_hard_dismount.dds', name = A.Innate_Hard_Dismount, duration = 2000}, -- Dismount Stun

    -- Bow
    [38649] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Poison Arrow (Venom Arrow)

    -- Destruction Staff
    [48009] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Stagger (Crushing Shock)

    -- On Player
    [2874] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Staggered (Generic Stagger applied to player by many different NPC abilities)
    [29402] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Power Bash (Stagger when hit with Power Bash)
    [29765] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Uber Attack (Player staggers self by hitting Blocking NPC with Heavy Attack)
    [68971] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Staggered (Echatere - Shockwave)
    [12426] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Raven Storm (Hagraven)
    [32698] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Pulverize (Lurcher - Pulverize)
    [5349] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Stagger (Ogre - Shockwave)
    [49405] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Rear Up (Mantikora)
    [76134] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 600}, -- Stumble Forward (Flesh Colossus)
    [76133] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Stumble Forward (Flesh Colossus - Blocked)
    [65755] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 600}, -- Staggered (Flesh Colossus - Block Pin)
    [68826] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 600}, -- Staggered (Flesh Colossus - Block Sweep)
    [74794] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Black Winter (Harvester)
    [32023] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Generic Stagger Enemy (Bloodfiend)
    [17206] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Bone Saw(Bone Colossus)
    [45576] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Generic Stagger Enemy (Werewolf)
    [69157] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Retaliation (Winterborn Warrior)
    [69153] = {icon = 'esoui/art/icons/ability_warrior_014.dds', name = A.Skill_Retaliation, duration = 1000}, -- Retaliation (Winterborn Warrior)
    [54050] = {icon = 'esoui/art/icons/ability_warrior_032.dds', name = A.Skill_Divine_Leap, duration = 500}, -- Divine Leap Stun (Vosh Rakh Devoted)
    [77927] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Staggered (Bodyguard) (DB DLC)
    [72639] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Power Bash  (Cyrodiil Guard T2) (Stagger when hit with Power Bash)
    [74483] = {icon = 'esoui/art/icons/ability_dragonknight_005.dds', name = A.Skill_Fiery_Grip, duration = 1000}, -- Fiery Grip (Sentinel) (TG DLC)
    [35115] = {icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = A.Skill_Extended_Chains, duration = 1000},  -- Pull (Extended Chains) (Cyrodiil Guard T2)
    [47020] = {icon = 'esoui/art/icons/ability_dragonknight_005_a.dds', name = A.Skill_Puncturing_Chains, duration = 1000}, -- Pull (Puncturing Chains) (Cyrodiil Guard T2)

    -- Quest
    [84284] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433 }, -- Coursing Bones (Oskana)
    [84197] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433 }, -- Marsh Masher (Gathongor the Mauler)
    [83161] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433 }, -- Stone Crusher (Thodundor of the Hill)
    [83141] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433 }, -- Ground Shock (Thodundor of the Hill)

    --[[
    [52878] = {icon = 'esoui/art/icons/ability_dragonknight_005_b.dds', name = 'Empowering Chains', duration = 433}, -- Pull (Empowering Chains) (Rkindaleft - Sharga the Firestarter)
    [64322] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Glacial Spikes', duration = 1000}, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart) - TEMP FIX
    [72479] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Glacial Spikes', duration = 1000}, -- Glacial Spikes (For King and Glory - Urfon Ice-Heart) - TEMP FIX
    [53290] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Stagger (The Anger of a King - Talviah Aliaria)
    [75463] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Magma Diver (The King's Gambit - Shield-Wife Razbela)
    [67156] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Kindlepitch Slick', duration = 550}, -- Kindlepitch Slick (Blood on a King's Hands) (Can't be dispelled so best option)
    [70543] = {icon = 'esoui/art/icons/ability_debuff_snare.dds', name = 'Oil Fire', duration = 550}, -- Kindlepitch Slick (Blood on a King's Hands) (Can't be dispelled so best option)
    ]]--

    -- Vvardenfell
    [86576] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Renduril the Hammer (Nchuleftingth)
    [88510] = {icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433}, -- Staggered (Vvardenfell -- Ancestral Adversity)

    -- On Target
    [86310] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 500}, -- Stagger (Player Blocks charged NPC attack)
    [21972] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 500}, -- Stagger (Player interrupts NPC cast)

    -----------------
    -- Dungeons -----
    -----------------

    -- Elden Hollow I
    [44093] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433 }, -- Battlecry (Akash gra-Mal)
    [44092] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433 }, -- Generic Stagger Enemy (Chokethorn)

    -- Frostvault
    [117291] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 433 }, -- Stagger (Coldsnap Ogre)
    [109810] = { icon = 'esoui/art/icons/ability_debuff_stagger.dds', name = A.Innate_Stagger, duration = 600 }, -- Frozen Aura (Icestalker)
}

--------------------------------------------------------------------------------------------------------------------------------
-- Fake Ground Damaging Effect Auras - We use EffectOverride to pull information for these unlike the other tables above.
--------------------------------------------------------------------------------------------------------------------------------
E.AddGroundDamageAura = {

    --------------------
    -- PLAYER
    --------------------

    -- Siege
    [104693] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Meatbag Catapult
    [104695] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Scattershot Catapult

    -- Sets
    [59591] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Bogdan Totem (Bogdan the Nightflame)
	[97899] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Domihaus (Domihaus)
	[97883] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Domihaus (Domihaus)
	[97857] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Earthgore (Earthgore)
	[84502] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Grothdarr (Grothdarr)
	[80526] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Illambris
	[80525] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Illambris
	[81038] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Sentinel of Rkugamz
	[59498] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spawn of Mephala
	[80522] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Stormfist
	[102094] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Thurvokun
	[106783] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dustcloud Damage (Adept Rider's)
	[75692] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Bahraha's Curse
	[97539] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Draugr's Rest
    [67204] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Leeching Plate (of Leeching)

    -- Dragonknight
    [28995] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dragonknight Standard
    [32960] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shifting Standard
    [32964] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shifting Standard
    [32948] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Standard of Might

    [61772] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Ash Cloud (Ash Cloud)
    [34791] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Cinder Storm (Cinder Storm)
    [32711] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Eruption (Eruption)

    -- Nightblade
    [36052] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Twisting Path (Twisting Path)
    [36490] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Veil of Blades (Veil of Blades)

    -- Sorcerer
    [23189] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Lightning Splash (Lightning Splash)
    [23202] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Liquid Lightning (Liquid Lightning)
    [23208] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Lightning Flood (Lightning Flood)
    [80435] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Suppression Field (Suppression Field)
    [80405] = { duration = 600, type = BUFF_EFFECT_TYPE_BUFF }, -- Absorption Field (Absorption Field)

    -- Templar
    [95931] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Spear Shards
    [95955] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Luminous Shards
    [26879] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blazing Spear

    [26286] = { duration = 2100, type = BUFF_EFFECT_TYPE_BUFF }, -- Healing Ritual (Cleansing Ritual)
    [26298] = { duration = 2100, type = BUFF_EFFECT_TYPE_BUFF }, -- Ritual of Retribution
    [80172] = { duration = 2100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ritual of Retribution
    [26303] = { duration = 2100, type = BUFF_EFFECT_TYPE_BUFF }, -- Extended Ritual

    [22225] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Rite of Passage
    [22231] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Remembrance
    [22228] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Practiced Incantation

    [21753] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Nova
    [21756] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Solar Prison
    [21759] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Solar Disturbance

    -- Warden
    [85534] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Secluded Grove (Secluded Grove)
    [88747] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Enchanted Forest (Enchanted Forest)
    [88783] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Impaling Shards (Impaling Shards)
    [88791] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Gripping Shards (Gripping Shards)
    [88802] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Winter's Revenge (Winter's Revenge)

    [86247] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Sleet Storm (Sleet Storm)
    [88860] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Northern Storm (Northern Storm)
    [88863] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Permafrost (Permafrost)

    -- Bow
    [28877] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Volley (Volley)
    [38690] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Endless Hail (Endless Hail)
    [38696] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Arrow Barrage (Arrow Barrage)

    -- Destruction Staff
    [62896] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Wall of Fire
    [62971] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Wall of Storms
    [62931] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Wall of Frost
    [39054] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unstable Wall of Fire
    [39079] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unstable Wall of Storms
    [39071] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Unstable Wall of Frost
    [62912] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blockade of Fire
    [62990] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blockade of Storms
    [62951] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blockade of Frost

    [83626] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Fire Storm
    [83631] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Thunder Storm
    [83629] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Ice Storm
    [85127] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Fiery Rage
    [85131] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Thunderous Rage
    [85129] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Icy Rage
    [83683] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Eye of Flame
    [83687] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Eye of Lightning
    [83685] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, --Eye of Frost

    -- Restoration Staff
    [28386] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Grand Healing
    [40059] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Illustrious Healing
    [40061] = { duration = 1100, type = BUFF_EFFECT_TYPE_BUFF }, -- Healing Springs

    -- Fighters Guild
    [80293] = { duration = 600, type = BUFF_EFFECT_TYPE_BUFF, exception = ACTION_RESULT_EFFECT_GAINED }, -- Ring of Preservation (Ring of Preservation)

    -- Mages Guild
    [63429] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Meteor (Meteor)
    [63454] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ice Comet (Ice Comet)
    [63471] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Shooting Star (Shooting Star)

    -- Vampire
    [32625] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Bat Swarm
    [38935] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Clouding Swarm
    [38934] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Devouring Swarm

    -- Assault
    [38561] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Caltrops (Caltrops)
    [40267] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40252] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Razor Caltrops (Razor Caltrops)

    --------------------
    -- TRAPS
    --------------------

    [17314] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF, exception = ACTION_RESULT_DOT_TICK }, -- Fire Trap (Player)

    [72888] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Attack 1 (Fire) -- Banished Cells II
    [72889] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Attack 2 (Fire) -- Banished Cells II

    --------------------
    -- NPC
    --------------------

    -- Cyrodiil
    [7883] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Guardian Storm (Cyrodiil Mage)
    [46819] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Storm Damage (Cyrodiil Mage)
    [52866] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Volley (Cyrodiil Archer)
    [54258] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Upgraded Volley (Cyrodiil Archer)
    [70414] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Cyrodiil Archer)

    -- Human
    [38125] = { duration = 1500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Caltrops  (Faction NPCs)
    [14068] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Archer Synergy)
    [10813] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Mage Synergy)
    [38260] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ignite (Mage Synergy)
    [28629] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Volley (Archer)
    [47102] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Fire Rune (Fire Mage)
    [37131] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Ice Cage (Battlemage)
    [44228] = { duration = 1200, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dragonknight Standard (Dragonknight - NPC)

    [76624] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Voidbringer)
    [76728] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Voidbringer)

    [88330] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Masquer)
    [88334] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pool of Shadow (Masquer)

    -- Animal
    [16698] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Poisonbloom (Netch)
    [90778] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Acid Pool (Nix-Ox)
    [90815] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Acid Pool (Nix-Ox)
    [85421] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Retch (Cliff Strider)

    -- Insect
    [13680] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Acid Blood (Assassin Beetle)
    [5265] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Burning Ground (Shalk)
    [72794] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Toxic Pool (Haj Mota)
    [87126] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Heat Vents (Fetcherfly Nest)

    -- Monsters
    [4769] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Choking Pollen (Lurcher)
    [16040] = { duration = 1500, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Hurricane (Nereid)
    [75928] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Elemental Pool (Minotaur)
    [75953] = { duration = 2000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Brimstone Hailfire (Minotaur Shaman)
    [75976] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Pillar of Nirn (Minotaur Shaman)
    [8628] = { duration = 800, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Charged Ground (Harpy)
    [103862] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Deluge (Yaghra Spewer)
    [103992] = { duration = 750, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Luminescent Burn (Yaghra Spewer)

    -- Daedra
    [9749] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Envelop (Banekin)
    [91938] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Burst of Embers (Daedroth)
    [51645] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Frozen Ground (Frost Atronach)
    [6162] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Rain of Fire (Scamp)
    [88323] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Blast Furnace (Iron Atronach)
    [73437] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Soul Flame (Daedric Titan)
    [53233] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Miasma Pool (Flesh Colossus)

    -- Undead
    [20812] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Defiled Ground (Lich)
    [73929] = { duration = 1000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Soul Cage (Lich)
    [73937] = { duration = 1000, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Soul Cage (Lich)
    [69950] = { duration = 2100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Desecrated Ground (Desecrated Ground - Undead Synergy)

    -- Dwemer
    [19997] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Static Field (Dwemer Spider)

    [91094] = { duration = 650, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 1 }, -- Split Bolt (Dwemer Arquebus)
    [91095] = { duration = 650, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 1 }, -- Split Bolt (Dwemer Arquebus)
    [91096] = { duration = 650, type = BUFF_EFFECT_TYPE_DEBUFF, merge = 1 }, -- Split Bolt (Dwemer Arquebus)

    ------------------
    -- DUNGEONS ------
    ------------------

    -- Banished Cells I
    [19027] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Dead Zone (Skeletal Destroyer)
    [33188] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Daedric Tempest (High Kinlord Rilis)

    -- Banished Cells II
    [28904] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Immolating Bite (Maw of the Infernal)
    [31727] = { duration = 1100, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Corruption (Daedric Chaos)
    [48800] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Daedric Tempest (High Kinlord Rilis)
    [48815] = { duration = 1600, type = BUFF_EFFECT_TYPE_DEBUFF }, -- Daedric Tempest (High Kinlord Rilis)

    -- Elden Hollow I
    [42601] = { duration = 600, type = BUFF_EFFECT_TYPE_DEBUFF, exception = ACTION_RESULT_DOT_TICK }, -- Necrotic Circle (Canonreeve Oraneth)

}

--------------------------------------------------------------------------------------------------------------------------------
-- When GetCurrentMapZoneIndex() matches this filter, customize the ability based off this criteria.
--------------------------------------------------------------------------------------------------------------------------------
E.MapDataOverride = {

    [11338] = { -- In Lava
              [608] = { name = A.Skill_Fire, icon = 'LuiExtended/media/icons/abilities/ability_innate_fire_generic.dds' }, -- Vvardenfell Tutorial Area
              },

}
