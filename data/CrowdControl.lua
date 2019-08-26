--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Effects namespace
LUIE.Data.CrowdControl = {}
local CrowdControl = LUIE.Data.CrowdControl

-- CrowdControl.aoePlayerUltimate
-- CrowdControl.aoePlayerNormal
-- CrowdControl.aoePlayerSet
-- CrowdControl.aoeTrap
-- cc.aoeBoss
-- CrowdControl.aoeElite
-- CrowdControl.aoeNormal
-- Increment by 1 here if we want to change priority. Best way to do this is +1 for a new ability, and shared morphs or other damage sources from a shared attack don't increment.
-- Priority system doesn't support gaps so NEVER more than +1 here, also the FIRST ability in each tier needs to be +0 to prevent skips if a category is disabled in the options.
CrowdControl.aoePlayerUltimate = {

    -- Dragonknight
    [28995] = 0, -- Dragonknight Standard
    [32960] = 0, -- Shifting Standard
    [32964] = 0, -- Shifting Standard
    [32948] = 0, -- Standard of Might

    -- Warden
    [86247] = 1, -- Sleet Storm (Sleet Storm)
    [88860] = 0, -- Northern Storm (Northern Storm)
    [88863] = 0, -- Permafrost (Permafrost)

    -- Templar
    [21753] = 1, -- Nova
    [21756] = 0, -- Solar Prison
    [21759] = 0, -- Solar Disturbance

    -- Nightblade
    [36490] = 1, -- Veil of Blades (Veil of Blades)

    -- Necromancer
    [122178] = 1, -- Frozen Colossus (Frozen Colossus)
    [122399] = 0, -- Pestilent Colossus (Pestilent Colossus)
    [122400] = 0, -- Pestilent Colossus (Pestilent Colossus)
    [122401] = 0, -- Pestilent Colossus (Pestilent Colossus)
    [122392] = 0, -- Glacial Colossus (Glacial Colossus)
    [118289] = 1, -- Ravenous Goliath (Ravenous Goliath)

    -- Sorcerer
    [80435] = 1, -- Suppression Field (Suppression Field)

    -- Destruction Staff
    [85127] = 1, --Fiery Rage
    [85131] = 0, --Thunderous Rage
    [85129] = 0, --Icy Rage
    [83683] = 1, --Eye of Flame
    [83687] = 0, --Eye of Lightning
    [83685] = 0, --Eye of Frost
    [83626] = 1, --Fire Storm
    [83631] = 0, --Thunder Storm
    [83629] = 0, --Ice Storm

    -- Mages Guild
    [63429] = 1, -- Meteor
    [63454] = 0, -- Ice Comet
    [63471] = 0, -- Shooting Star

    -- Vampire
    [32625] = 1, -- Bat Swarm
    [38935] = 0, -- Clouding Swarm
    [38934] = 0, -- Devouring Swarm

    -- Volendrung
    [116669] = 1, -- Ebony Cyclone (Ruinous Cyclone)

}

CrowdControl.aoePlayerNormal = {

    -- Psijic Order
    [104007] = 0, -- Time Stop
    [104072] = 0, -- Borrowed Time
    [104082] = 0, -- Time Freeze

    -- Dragonknight
    [32711] = 1, -- Eruption (Eruption)

    -- Warden
    [88783] = 1, -- Impaling Shards (Impaling Shards)
    [88791] = 0, -- Gripping Shards (Gripping Shards)
    [88802] = 0, -- Winter's Revenge (Winter's Revenge)

    -- Templar
    [26192] = 1, -- Spear Shards
    [95931] = 0, -- Spear Shards
    [26859] = 0, -- Luminous Shards
    [95955] = 0, -- Luminous Shards
    [26871] = 0, -- Blazing Spear
    [26879] = 0, -- Blazing Spear
    [80172] = 1, -- Ritual of Retribution (Ritual of Retribution)

    -- Sorcerer
    [23189] = 1, -- Lightning Splash (Lightning Splash)
    [23202] = 0, -- Liquid Lightning (Liquid Lightning)
    [23208] = 0, -- Lightning Flood (Lightning Flood)

    -- Nightblade
    [36052] = 1, -- Twisting Path (Twisting Path)

    -- Necromancer
    [115254] = 1, -- Boneyard (Boneyard)
    [117809] = 0, -- Unnerving Boneyard (Unnerving Boneyard)
    [117854] = 0, -- Avid Boneyard (Avid Boneyard)

    [116410] = 1, -- Shocking Siphon (Shocking Siphon)
    [118766] = 0, -- Detonating Siphon (Detonating Siphon)
    [118011] = 0, -- Mystic Siphon (Mystic Siphon)

    -- Destruction Staff
    [62896] = 1, -- Wall of Fire
    [62971] = 0, -- Wall of Storms
    [62931] = 0, -- Wall of Frost
    [39054] = 1, -- Unstable Wall of Fire
    [39079] = 0, -- Unstable Wall of Storms
    [39071] = 0, -- Unstable Wall of Frost
    [62912] = 1, -- Blockade of Fire
    [62990] = 0, -- Blockade of Storms
    [62951] = 0, -- Blockade of Frost

    -- Two-Handed
    [126474] = 1, -- Stampede

    -- Bow
    [28877] = 1, -- Volley
    [38690] = 0, -- Endless Hail
    [38696] = 0, -- Arrow Barrage

    -- Assault
    [38561] = 1, -- Caltrops (Caltrops)
    [40267] = 0, -- Anti-Cavalry Caltrops (Anti-Cavalry Caltrops)
    [40252] = 0, -- Razor Caltrops (Razor Caltrops)

}

CrowdControl.aoePlayerSet = {

    -- Sets
    [102136] = 0, -- Zaan
    [59568] = 1, -- Malubeth
    [80522] = 1, -- Stormfist
    [59498] = 1, -- Mephala's Web (Spawm of Mephala)
    [60972] = 1, -- Fiery Breath (Maw of the Infernal)
    [80525] = 1, -- Ilambris
    [80526] = 0, -- Ilambris
    [84502] = 1, -- Grothdarr
    [80561] = 1, -- Iceheart
    [97883] = 1, -- Domihaus
    [97899] = 0, -- Domihaus
    [80565] = 1, -- Kra'gh
    [106783] = 1, -- Dustcloud Damage (Adept Rider's)
    [75692] = 1, -- Bahraha's Curse (of Bahraha's Curse)
    [57209] = 1, -- Storm Knight's Plate (of the Storm Knight)
    [59696] = 1, -- Embershield (Embershield)
    [67204] = 1, -- Leeching Plate (of Leeching)
    [102094] = 1, -- Thurvokun (Thurvokun)
    [116920] = 1, -- Auroran's Thunder (Auroran's Thunder)

    -- Siege
    [104693] = 1, -- Meatbag Catapult
    [104695] = 1, -- Scattershot Catapult

}

CrowdControl.aoeTraps = {

    -- TODO: Will need to add better categories here eventually
    [87949] = 0, -- Lava (Foyada Quarry)
    [44034] = 0, -- Slaughterfish Attack (Stirk)
    [113082] = 0, -- Slaughterfish Attack (Cyrodiil)
    [19224] = 0, -- In Lava (Halls of Torment)
    [11338] = 0, -- In Lava (The Earth Forge)
    [16589] = 0, -- Fire (Dummy ID for zone based name override) -- TODO: Maybe do something here
    [56277] = 0, -- Lava (City of Ash II)
    [5140] = 0, -- Lava (Dragonstar Arena)

    [62770] = 0, -- Coldharbour Flames (Flame Trap) - Coldharbour Tutorial
    [21943] = 0, -- Spike Trap (Spike Trap)
    [53169] = 0, -- Spike Trap (Spike Trap) - Dragonstar Arena
    [26531] = 0, -- Bear Trap (Bear Trap)
    [31086] = 0 -- Trap (Trap) - Selene's Web

    [17314] = 0, -- Fire Trap (Player)
    [72888] = 0, -- Fire Attack 1 (Fire) -- Banished Cells II
    [72889] = 0, -- Fire Attack 2 (Fire) -- Banished Cells II

    [92757] = 0, -- Spinning Blade (Ald Carac)

    [117508] = 0, -- Shock Wall (Lightning Trap - Elinhir Private Arena)
    [117622] = 0, -- Shock Wall (Lightning Trap - Elinhir Private Arena)
    [117598] = 0, -- Shock Wall (Lightning Trap - Elinhir Private Arena)
    [117139] = 0, -- Spinning Blade (Blade Trap - Elinhir Private Arena)

    [92150] = 0, -- Fire Trap (Vvardenfell -- Divine Delusions)
    [87102] = 0, -- Spinning Blade (Vvardenfell -- Divine Restoration)
    [92284] = 0, -- Planar Shear (Vvardenfell -- Divine Restoration)
    [86743] = 0, -- Accelerated Transposition (Vvardenfell -- Like Blood from a Stone)
    [84527] = 0, -- Searing Steam (Vvardenfell - Nchuleftingth)
    [90271] = 0, -- Charge-Wire Shock (Vvardenfell - Nchuleftingth)
    [92138] = 0, -- Laser Damage (Vvardenfell - Nchuleftingth)

    -- Dragonstar Arena
    [53341] = 0, -- Biting Cold (Player)
    [60421] = 0, -- Biting Cold (Player)
    [83498] = 0, -- Poisonous Cloud (Poison Cloud)
    [83468] = 0, -- Restoring Nature (Nature's Blessing)

    -- Maelstrom Arena
    [69101] = 0, -- Shock (Generator)
    [66797] = 0, -- Spinning Blade (Blade Trap)
    [67871] = 0, -- Shock (Water)
    [72525] = 0, -- Frigid Waters (Player)
    [67808] = 0, -- Frigid Waters (Player)

    -- City of Ash II
    [56068] = 0, -- Slag Geyser (Lava Pool)

}

CrowdControl.aoeNPCBoss = {

    -- Summerset
    [105889] = 0, -- Pustulant Eruption (Yaghra Nightmare)

    -- Vvardenfell
    [94936] = 1, -- Tremor (Nchuleftingth - Mud-Tusk)
    [86566] = 1, -- Fire Runes (Nchuleftingth - Friar Hadelar)
    [89754] = 1, -- Shocking Rake (Old Rust-Eye - Khartag Point)
    [90148] = 1, -- Sunder's Echo (Vvardenfell -- Divine Intervention)
    [90146] = 0, -- Sunder's Echo (Vvardenfell -- Divine Intervention)
    [69284] = 1, -- Whirlwind Function (Guardian of Bthark -- Nchuleftingth)
    [86607] = 1, -- Steam Breath (Guardian of Bthark -- Nchuleftingth)

    -- World Bosses
    [84045] = 1, -- Seal of Defilement (Quenyas) - World Boss - Seaside Scarp Camp
    [84206] = 1, -- Stinging Sputum (Gathongor the Mauler) - World Boss - Gathongor's Mine

    -- Quests
    [36860] = 1, -- Swordstorm Damage (MSQ - Halls of Torment)
    [87959] = 1, -- Ash Storm (Vvardenfell -- Divine Delusions)

    -- Dragonstar Arena
    [53660] = 1, -- Power Overload Heavy Attack (Nak'tah)
    [54084] = 1, -- Corrosive Armor (Earthen Heart Knight)
    [52903] = 1, -- Standard of Might (Anal'a Tu'wha0)
    [52933] = 1, -- Solar Disturbance (Shadow Knight)
    [55086] = 1, -- Poison Mist (Vampire Lord Thisa)
    [55092] = 1, -- Devouring Swarm (Vampire Lord Thisa)
    [55104] = 1, -- Marked for Death (Hiath the Battlemaster)
    [55182] = 0, -- Marked for Death (Hiath the Battlemaster)

    -- Maelstrom Arena
    [68197] = 1, -- Necrotic Essence (Necrotic Orb)
    [70901] = 1, -- Defiled Grave (Maxus the Many) -- NORMAL
    [72149] = 0, -- Defiled Grave (Maxus the Many) -- VETERAN
    [69366] = 1, -- Barrage Function (Centurion Champion)
    [69316] = 1, -- Electric Shield (Centurion Champion)
    [73880] = 1, -- Call Lightning (Lamia Queen)
    [67758] = 1, -- Queen's Poison (Lamia Queen)
    [68537] = 1, -- Overcharged Bolt (The Control Guardian)
    [70860] = 1, -- Overheated Flame (The Control Guardian)
    [68543] = 1, -- Overheated Volley (The Control Guardian)

    -- Banished Cells I
    [19027] = 1, -- Dead Zone (Skeletal Destroyer)
    [33188] = 1, -- Daedric Tempest (High Kinlord Rilis)

    -- Banished Cells II
    [28904] = 1, -- Immolating Bite (Maw of the Infernal)
    [29020] = 1, -- Berserker Frenzy (Keeper Voranil)
    [31727] = 1, -- Corruption (Keeper Imiril)
    [48800] = 1, -- Daedric Tempest (High Kinlord Rilis)
    [48815] = 0, -- Daedric Tempest (High Kinlord Rilis)

    -- Elden Hollow I
    [16017] = 1, -- Berserker Frenzy (Akasha gra-Mal)
    [25300] = 0, -- Berserker Frenzy (Akasha gra-Mal)
    [25301] = 0, -- Berserker Frenzy (Akasha gra-Mal)
    [25302] = 0, -- Berserker Frenzy (Akasha gra-Mal)
    [42601] = 1, -- Necrotic Circle (Canonreeve Oraneth)

    -- Elden Hollow II
    [34377] = 1, -- Flame Geyser (Dubroze the Infestor)
    [32972] = 1, -- Consuming Shadow (Murklight)
    [33050] = 1, -- Eclipse (Murklight)
    [33103] = 1, -- Spout Shadow (The Shadow Guard)
    [33434] = 1, -- Daedric Flame (Bogdan the Nightflame)

    -- City of Ash I
    [34960] = 1, -- Blazing Fire (Warden of the Shrine)
    [35145] = 1, -- Consuming Fire (Infernal Guardian)
    [34204] = 1, -- Burning Field (Rothariel Flameheart)

    -- City of Ash II
    [56415] = 1, -- Fire Runes (Urata the Legion)
    [55314] = 1, -- Slag Breath (Horvantud the Fire Maw)
    [55334] = 0, -- Fiery Breath (Horvantud the Fire Maw)
    [55321] = 0, -- Fiery Breath (Horvantud the Fire Maw)
    [55336] = 0, -- Fiery Breath (Horvantud the Fire Maw)
    [55327] = 0, -- Fiery Breath (Horvantud the Fire Maw)
    [55338] = 0, -- Fiery Breath (Horvantud the Fire Maw)
    [56010] = 1, -- Ground Quake (Horvantud the Fire Maw)
    [56151] = 1, -- Ethereal Flame (Ash Titan)
    [55175] = 1, -- Molten Rain (Ash Titan)
    [54637] = 1, -- Flame Tornado (Air Atronach)
    [55756] = 1, -- Burning (Valkyn Skoria)

    -- Tempest Island
    [26619] = 1, -- Shock (Sudden Storm)
    [6108] = 1, -- Lightning Storm (Yalorasse the Speaker)
    [26752] = 1, -- Enervating Stone (Stormfist)
    [26517] = 1, -- Electrical Shock (Twister)

    -- Selene's Web
    [30908] = 1, -- Summon Primal Swarm (Treethane Kerninn)
    [30773] = 1, -- Arrow Rain (Longclaw)
    [31150] = 1, -- Poison Burst (Longclaw)
    [31203] = 1, -- Venomous Burst (Queen Aklayah)

    -- Spindleclutch II
    [28006] = 1, -- Cave In (Blood Spawn)
    [47332] = 0, -- Cave-In (Blood Spawn)
    [27603] = 1, -- Blood Pool (Urvan Veleth)
    [27906] = 1, -- Blood Pool (Vorenor Winterbourne)

    -- Wayrest Sewers I
    [25591] = 1, -- Necrotic Essence (Investigator Garron)

}

CrowdControl.aoeNPCElite = {

    -- Overland / Standard NPC's
    [44228] = 0, -- Dragonknight Standard (Dragonknight - Elite)
    [81197] = 1, -- Agonizing Fury (Thundermaul - Boss)
    [21952] = 1, -- Repulsion Shock (Wamasu)
    [55867] = 0, -- Repulsion Shock (Wamasu - Boss)
    [72794] = 1, -- Toxic Pool (Haj Mota)
    [53233] = 1, -- Miasma Pool (Flesh Colossus)
    [52866] = 1, -- Volley (Cyrodiil Archer)
    [54258] = 1, -- Upgraded Volley (Cyrodiil Archer)
    [10271] = 1, -- Quake (Gargoyle)
    [9011] = 1, -- Tremor (Troll)
    [75928] = 1, -- Elemental Pool (Minotaur)
    [75953] = 1, -- Brimstone Hailfire (Minotaur Shaman)
    [75976] = 1, -- Pillar of Nirn (Minotaur Shaman)
    [75980] = 1, -- Pillar Eruption (Minotaur Shaman)
    [11282] = 1, -- Steam Breath (Dwemer Centurion)

    -- Dragonstar Arena
    [53314] = 1, -- Flame Volley (Sovngarde Ranger)
    [53280] = 1, -- Unstable Wall of Frost (Sovngarde Icemage)
    [53614] = 1, -- Thundering Presence (Nak'tah)
    [53625] = 1, -- Lightning Flood (Nak'tah)
    [56824] = 1, -- Puncturing Sweep (House Dres Templar)
    [54161] = 1, -- Berserker Frenzy (House Dres Slaver)
    [54080] = 1, -- Cinder Storm (Earthen Heart Knight)
    [52892] = 1, -- Flames of Oblivion (Anal'a Tu'wha)
    [25213] = 1, -- Whirlwind Function (Dwarven Fire Centurion)
    [55981] = 1, -- Ice Charge (Dwarven Ice Centurion)

    -- Maelstrom Arena
    [72159] = 1, -- Static Field (Dwarven Spider)
    [72203] = 1, -- Overcharge (Scavenger Thunder-Smith)

}

CrowdControl.aoeNPCNormal = {

    [37131] = 0, -- Ice Cage (Battlemage)
    [10813] = 1, -- Ignite (Synergy - Fire Mage)
    [38260] = 0, -- Ignite (Synergy - Fire Mage)
    [28629] = 1, -- Volley (Archer)
    [47102] = 1, -- Fire Rune (Fire Mage)
    [14068] = 1, -- Ignite (Synergy - Archer)
    [70414] = 0, -- Ignite (Synergy - Cyrodiil Archer)
    [38125] = 1, -- Caltrops  (Faction NPCs)
    [76730] = 1, -- Pool of Shadow (Voidbringer)
    [76624] = 0, -- Pool of Shadow (Voidbringer)
    [76729] = 0, -- Pool of Shadow (Voidbringer)
    [76728] = 0, -- Pool of Shadow (Voidbringer)
    [88336] = 0, -- Pool of Shadow (Skaafin Masquer)
    [88330] = 0, -- Pool of Shadow (Skaafin Masquer)
    [88335] = 0, -- Pool of Shadow (Skaafin Masquer)
    [88334] = 0, -- Pool of Shadow (Skaafin Masquer)
    [84837] = 1, -- Broken Pact (Skaafin)
    [62502] = 1, -- Fiery Wind (Justice Mage)
    [46819] = 1, -- Storm Damage (Cyrodiil Mage)
    [7883] = 1, -- Guardian Storm (Cyrodiil Mage)
    [8604] = 1, -- Vigorous Swipe (Mammoth)
    [27100] = 1, -- Shocking Rake (Dreugh)
    [16698] = 1, -- Poisonbloom (Netch)
    [90778] = 1, -- Acid Pool (Nix-Ox)
    [90815] = 0, -- Acid Pool (Nix-Ox)
    [85421] = 1, -- Retch (Cliff Strider)
    [85391] = 1, -- Slash (Cliff Strider)
    [13680] = 1, -- Acid Blood (Assassin Beetle)
    [10947] = 1, -- Fiery Breath (Shalk)
    [5265] = 1, -- Burning Ground (Shalk)
    [8088] = 1, -- Poison Spray (Giant Spider)
    [87126] = 1, -- Heat Vents (Fetcherfly Nest)
    [51282] = 1, -- Flame Tornado (Air Atronach - Flame)
    [9749] = 1, -- Envelop (Banekin)
    [73437] = 1, -- Soul Flame (Daedric Titan)
    [4772] = 1, -- Fiery Breath (Daedroth)
    [91938] = 1, -- Burst of Embers (Daedroth)
    [51645] = 1, -- Frozen Ground (Frost Atronach)
    [6162] = 1, -- Rain of Fire (Scamp)
    [88323] = 1, -- Blast Furnace (Iron Atronach)
    [69950] = 1, -- Desecrated Ground (Undead Synergy)
    [73937] = 1, -- Soul Cage (Lich)
    [73929] = 0, -- Soul Cage (Lich)
    [20812] = 1, -- Defiled Ground (Lich)
    [72996] = 1, -- Symphony of Blades (Defiled Aegis)
    [8628] = 1, -- Charged Ground (Harpy)
    [4769] = 1, -- Choking Pollen (Lurcher)
    [16040] = 1, -- Hurricane (Nereid)
    [19997] = 1, -- Static Field (Dwemer Spider - Synergy)
    [91094] = 1, -- Split Bolt (Dwemer Arquebus)
    [91095] = 0, -- Split Bolt (Dwemer Arquebus)
    [91096] = 0, -- Split Bolt (Dwemer Arquebus)
    [103862] = 1, -- Deluge (Yaghra Spewer)
    [103992] = 1, -- Luminescent Burn (Yaghra Spewer)

    -- Quests
    [90182] = 1, -- Oily Smoke (Vvardenfell -- Divine Restoration) -- TODO: Check, maybe is elite?

}


-- List of effects sourced by the player that damage self that should be shown
CrowdControl.LavaAlerts = {
    -- Player
    [115607] = true, -- Dismount Stun

    -- Consumables
    [68565] = true, -- Stun (Potion of Stun)

    -- Battlegrounds
    [87949] = true, -- Lava (Foyada Quarry)

    -- Traps & World
    [44034] = true, -- Slaughterfish Attack (Stirk)
    [113082] = true, -- Slaughterfish Attack (Cyrodiil)
    [19224] = true, -- In Lava (Halls of Torment)
    [11338] = true, -- In Lava (The Earth Forge)
    [56277] = true, -- Lava (City of Ash II)
    [5140] = true, -- Lava (Dragonstar Arena)

    [17314] = true, -- Fire Trap (Player)

    -- Quests
    [14974] = true, -- CON_Knockback&Knockdown (Anchors from the Harbour)
    [31502] = true, -- MGQ2 Asakala Sahdina Barrier (Simply Misplaced)
    [31503] = true, -- MGQ2 Asakala Rashomta Barrier (Simply Misplaced)
    [21876] = true, -- Q4260 West Barrier Teleport (Breaking the Barrier)
    [21878] = true, -- Q4260 East Barrier Teleport (Breaking the Barrier)
    [22395] = true, -- Q4261 ROD Barrier Teleport (Sever All Ties)
    [23606] = true, -- Q4326 Crystal Backfire (Preventative Measure)
    [37438] = true, -- Shocked (The Grips of Madness)
    [36766] = true, -- Q4842 Stun Headgrab Knockback (The Unquiet Dead)

    --------------
    -- Arenas ----
    --------------

    -- Dragonstar Arena
    [53341] = true, -- Biting Cold (Player)
    [60421] = true, -- Biting Cold (Player)
    [54405] = true, -- Celestial Blast (Player)

    -- Maelstrom Arena
    [72525] = true, -- Frigid Waters (Player)
    [67808] = true, -- Frigid Waters (Player)

    --------------
    -- Dungeons --
    --------------

    -- Elden Hollow II
    [30455] = true, -- Arachnophobia (The Opus of Torment)

    -- City of Ash I
    [70113] = true, -- Soul Scream (Scroll of Glorious Battle)

    -- City of Ash II
    [56563] = true, -- Book (Frigid Tome)

    -- Selene's Web
    [58521] = true, -- Web (Selene)
}

-- List of CC that can't be removed with Break Free
CrowdControl.UnbreakableList ={
    -- Player
    [115607] = true, -- Dismount Stun
    [40520] = true, -- Q3047 - Knockdown (Player Werewolf Bite stun)

    -- Quests
    [14972] = true, -- CON_Knockback&Knockdown (Castle of the Worm)
    [14974] = true, -- CON_Knockback&Knockdown (Anchors from the Harbour)
    [25979] = true, -- FG4 RGT Event Knockback (Proving the Deed)
    [31502] = true, -- MGQ2 Asakala Sahdina Barrier (Simply Misplaced)
    [31503] = true, -- MGQ2 Asakala Rashomta Barrier (Simply Misplaced)
    [32063] = true, -- Feedback (Tears of the Two Moons)
    [21876] = true, -- Q4260 West Barrier Teleport (Breaking the Barrier)
    [21878] = true, -- Q4260 East Barrier Teleport (Breaking the Barrier)
    [22395] = true, -- Q4261 ROD Barrier Teleport (Sever All Ties)
    [28771] = true, -- Q4220 Thirster Stun (The Mallari-Mora)
    [21314] = true, -- Trap Sprung! (An Act of Kindness)
    [23606] = true, -- Q4326 Crystal Backfire (Preventative Measure)
    [37438] = true, -- Shocked (The Grips of Madness)
    [43823] = true, -- IntroKB (The Orrery of Elden Root)
    [36766] = true, -- Q4842 Stun Headgrab Knockback (The Unquiet Dead)
    [33384] = true, -- Q4586 Aranias Vine Stun (The Witch of Silatar)

    -----------------
    -- ARENAS
    -----------------

    -- Dragonstar Arena
    [54405] = true, -- Celestial Blast (Player)

    -- Maelstrom Arena
    [71720] = true, -- Stun (Matriarch Runa)

    -----------------
    -- DUNGEONS
    -----------------

    -- Banished Cells II
    [33191] = true, -- Crushing Blow (High Kinlord Rilis)
    [18847] = true, -- Soul Blast (High Kinlord Rilis)

    -- Banished Cells II
    [35680] = true, -- Immolating Bite (Maw of the Infernal)
    [28772] = true, -- Stun (High Kinlord Rilis)
    [28774] = true, -- Stun (High Kinlord Rilis)

    -- Elden Hollow I
    [46800] = true, -- Necrotic Circle (Canonreeve Oraneth)
    [27890] = true, -- Darkness Below (Elden Hollow)

    -- Elden Hollow II
    [35372] = true, -- Emerge (Bogdan the Nightflame)
    [30455] = true, -- Arachnophobia (The Opus of Torment)

    -- City of Ash I
    [25036] = true, -- Crushing Blow (Golor the Banekin Handler)
    [34609] = true, -- Measured Uppercut (Warden of the Shrine)
    [49138] = true, -- Oblivion Portal

    -- City of Ash II
    [54768] = true, -- Backdraft (Ash Titan - Theater)
    [54224] = true, -- Monstrous Cleave (Ash Titan)
    [54873] = true, -- Heavy Slash (Ash Titan)
    [55575] = true, -- Meteor Strike (Valkyn Skoria)
    [55391] = true, -- Meteor Strike (Valkyn Skoria)
    [56563] = true, -- Book (Frigid Tome)
    [70113] = true, -- Soul Scream (Scroll of Glorious Battle)

    -- Tempest Island
    [26676] = true, -- IntroKB (Valaran Stormcaller)
    [26372] = true, -- Crushing Blow (Valaran Stormcaller)
    [28391] = true, -- Q4538 Stoen Explosion (Conduit Stone)
    [26716] = true, -- Skyward Slam (Stormfist)
    [26851] = true, -- Summon Storm Atronach (Stormfist)
    [26836] = true, -- Summon Storm Atronach (Stormfist)
    [46809] = true, -- Gust of Wind (Stormreeve Neider)

    -- Selene's Web
    [31247] = true, -- Ensnare (Treethane Kerninn)
    [58521] = true, -- Web (Selene)
    [30969] = true, -- Summon Primal Spirit (Selene)
    [30905] = true, -- IntroKB (Selene)

    -- Spindleclutch I
    [22087] = true, -- Inject Poison (Swarm Mother)
    [18116] = true, -- Arachnophobia (The Whisperer)
    [46219] = true, -- Web Blast (The Whisperer)
    [22033] = true, -- Daedric Explosion (The Whisperer)

    -- Spindleclutch II
    [47140] = true, -- Knockdown (Bloodspawn)
    [61442] = true, -- Harrowing Ring (Praxin Douare)
    [43176] = true, -- Shocked (Praxin Douare)
    [61444] = true, -- Shocked (Praxin Douare)
    [32100] = true, -- Arachnophobia (Vorenor Winterbourne)

    -- Wayrest Sewers I
    [48932] = true, -- Backlash (Investigator Garron)
    [25531] = true, -- Tidal Slash (Varaine Pellingare)
    [35051] = true, -- Penetrating Daggers (Allene Pellingare)

    -- Frostvault
    [116666] = true, -- Skeletal Smash (Icestalker) -- Frostvault
    [109835] = true, -- Frenzied Pummeling (Icestalker) -- Frostvault

    -- TODO: Resort/check later
    [88467] = true, -- Skyfall (Vvardenfell -- Divine Disaster)
    [89756] = true, -- Guardian Shockwave (Vvardenfell -- The Magister Makes a Move)
    [92671] = true, -- Pyroclast (Vvardenfell -- The Forgotten Wastes)
}

CrowdControl.IgnoreList ={
    [54363] = true, -- Halt (Guard)
    [4197] = true, -- Recovering (NPC Duel)

    -- Quests

    -- Vampire
    [44670] = true, -- Vamp Theater Head Grab Stun (Scion of the Blood Matron)

    -- MSQ
    [64072] = true, -- Eye of the Sentinel (Tutorial)
    [61646] = true, -- Incapacitating Terror (Tutorial)
    [28737] = true, -- Recovery (Manifestation of Terror)
    [48077] = true, -- Q4971 Shali Cast (Saved)
    [32060] = true, -- Shocked (Tears of the Two Moons)
    [38108] = true, -- Q4868 Sheo Teleports Player (The Grips of Madness)
    [35645] = true, -- Q4768 PC Tribunal Layer 2 Stun (Scars Never Fade)

    ----------------
    -- Arenas
    ----------------

    -- Dragonstar Arena
    [55221] = true, -- Sucked Under (Player)
    [55641] = true, -- Stun (Light of Boethia)

    ----------------
    -- Dungeons
    ----------------

    -- Banished Cells II
    [46433] = true, -- DUN_BCH_Knockback&Knockdown (High Kinlord Rilis)

    -- Elden Hollow I
    [25723] = true, -- CON_Knockback&Knockdown (Bakkhara)

    -- City of Ash II
    [55429] = true, -- Magma Prison (Valkyn Skoria)

    -- Tempest Island
    [26938] = true, -- Enervating Stone (Stormfist)

    -- Frostvault
    [109838] = true, -- End Stun (Icestalker) -- Frostvault
    [119461] = true, -- Teleport Failsafe (Border Chk) -- Frostvault
}

-- Not implemented - list of abilities that ACTION_RESULT_GAINED_DURATION fires in the opposite order of normal
CrowdControl.ReversedLogic = {
    [39260] = true, -- Q4917 Push Player Back (Grahtwood - The Blacksap's Hold)
    [83124] = true, -- Ferocious Bellow (Greenshade - World Boss - Thodundor's View)

    -- Dungeons
    [26716] = true, -- Skyward Slam (Stormfist) -- Tempest Island
}

-- Use on ACTION_RESULT_EFFECT_GAINED
CrowdControl.SpecialCC = {
    [55756] = true, -- Burning (Valkyn Skoria)
}