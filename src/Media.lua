-- -----------------------------------------------------------------------------
--  LuiExtended
--  Distributed under The MIT License (MIT) (see LICENSE file)
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
local LUIE = LUIE
-- -----------------------------------------------------------------------------
LUIE.BorderTextures =
{
    ["ESO Gold"] = "EsoUI/Art/Miscellaneous/borderedinsettransparent_edgefile.dds",
    ["ESO Chat"] = "EsoUI/Art/chatwindow/chat_bg_edge.dds",
    ["ESO Rounded"] = "EsoUI/Art/miscellaneous/interactkeyframe_edge.dds",
    ["ESO Blue Highlight"] = "EsoUI/Art/miscellaneous/textentry_highlight_edge.dds",
    ["ESO Blue Glow"] = "EsoUI/Art/crafting/crafting_tooltip_glow_edge_blue64.dds",
    ["ESO Red Glow"] = "EsoUI/Art/crafting/crafting_tooltip_glow_edge_red64.dds",
    ["ESO Red Overlay"] = "EsoUI/Art/uicombatoverlay/uicombatoverlayedge.dds",
}
-- -----------------------------------------------------------------------------
LUIE.BackgroundTextures =
{
    ["ESO Black"] = "EsoUI/Art/Miscellaneous/borderedinset_center.dds",
    ["ESO Chat"] = "EsoUI/Art/chatwindow/chat_bg_center.dds",
    ["ESO Gray"] = "EsoUI/Art/itemtooltip/simpleprogbarbg_center.dds",
    ["Solid"] = "",
}
-- -----------------------------------------------------------------------------
LUIE.Fonts =
{
    ["Adventure"] = "LuiExtended/media/fonts/Adventure/adventure.slug",
    ["ArchivoNarrow Bold"] = "LuiExtended/media/fonts/ArchivoNarrow/ArchivoNarrow-Bold.slug",
    ["ArchivoNarrow BoldItalic"] = "LuiExtended/media/fonts/ArchivoNarrow/ArchivoNarrow-BoldItalic.slug",
    ["ArchivoNarrow Italic"] = "LuiExtended/media/fonts/ArchivoNarrow/ArchivoNarrow-Italic.slug",
    ["ArchivoNarrow Medium"] = "LuiExtended/media/fonts/ArchivoNarrow/ArchivoNarrow-Medium.slug",
    ["ArchivoNarrow MediumItalic"] = "LuiExtended/media/fonts/ArchivoNarrow/ArchivoNarrow-MediumItalic.slug",
    ["ArchivoNarrow Regular"] = "LuiExtended/media/fonts/ArchivoNarrow/ArchivoNarrow-Regular.slug",
    ["ArchivoNarrow SemiBold"] = "LuiExtended/media/fonts/ArchivoNarrow/ArchivoNarrow-SemiBold.slug",
    ["ArchivoNarrow SemiBoldItalic"] = "LuiExtended/media/fonts/ArchivoNarrow/ArchivoNarrow-SemiBoldItalic.slug",
    ["Bazooka"] = "LuiExtended/media/fonts/Bazooka/bazooka.slug",
    ["Consolas"] = "/EsoUI/Common/Fonts/consola.slug",
    ["Cooline"] = "LuiExtended/media/fonts/Cooline/cooline.slug",
    ["Diogenes"] = "LuiExtended/media/fonts/Diogenes/diogenes.slug",
    ["EnigmaBold"] = "LuiExtended/media/fonts/Enigma/EnigmaBold.slug",
    ["EnigmaReg"] = "LuiExtended/media/fonts/Enigma/EnigmaReg.slug",
    ["FORCED SQUARE"] = "LuiExtended/media/fonts/ForcedSquare/FORCED_SQUARE.slug",
    ["Fontin Bold"] = "LuiExtended/media/fonts/Fontin/fontin_sans_b.slug",
    ["Fontin Italic"] = "LuiExtended/media/fonts/Fontin/fontin_sans_i.slug",
    ["Fontin Regular"] = "LuiExtended/media/fonts/Fontin/fontin_sans_r.slug",
    ["Fontin SmallCaps"] = "LuiExtended/media/fonts/Fontin/fontin_sans_sc.slug",
    ["Futura Condensed Bold"] = "/EsoUI/Common/Fonts/FTN87.slug",
    ["Futura Condensed Light"] = "/EsoUI/Common/Fonts/FTN47.slug",
    ["Futura Condensed"] = "/EsoUI/Common/Fonts/FTN57.slug",
    ["Ginko"] = "LuiExtended/media/fonts/Ginko/ginko.slug",
    ["Heroic"] = "LuiExtended/media/fonts/Heroic/heroic.slug",
    ["Metamorphous"] = "LuiExtended/media/fonts/Metamorphous/metamorphous.slug",
    ["Porky"] = "LuiExtended/media/fonts/Porky/porky.slug",
    ["ProFontWindows"] = "LuiExtended/media/fonts/ProFontWindows/ProFontWindows.slug",
    ["ProseAntique"] = ZoFontBookPaper:GetFontInfo(),
    ["Roboto Bold Italic"] = "LuiExtended/media/fonts/Roboto/Roboto-BoldItalic.slug",
    ["Roboto Bold"] = "LuiExtended/media/fonts/Roboto/Roboto-Bold.slug",
    ["Skyrim Handwritten"] = ZoFontBookLetter:GetFontInfo(),
    ["Talisman"] = "LuiExtended/media/fonts/Talisman/talisman.slug",
    ["Trajan Pro Bold"] = "LuiExtended/media/fonts/TrajanPro/TrajanProBold.slug",
    ["Trajan Pro"] = ZoFontBookTablet:GetFontInfo(),
    ["Transformers"] = "LuiExtended/media/fonts/Transformers/transformers.slug",
    ["Univers 55"] = "/EsoUI/Common/Fonts/univers55.slug",
    ["Univers 57"] = ZoFontGame:GetFontInfo(),
    ["Univers 67"] = ZoFontWinH1:GetFontInfo(),
    ["Yellowjacket"] = "LuiExtended/media/fonts/Yellowjacket/yellowjacket.slug",
}
-- -----------------------------------------------------------------------------
LUIE.Sounds =
{
    ["Death Recap Killing Blow"] = SOUNDS.DEATH_RECAP_KILLING_BLOW_SHOWN,
    ["LFG Find Replacement"] = SOUNDS.LFG_FIND_REPLACEMENT,
    ["LFG Search Started"] = SOUNDS.LFG_SEARCH_STARTED,
    ["Group Election Requested"] = SOUNDS.GROUP_ELECTION_REQUESTED,
    ["Group Leave"] = SOUNDS.GROUP_LEAVE,
    ["Duel Accepted"] = SOUNDS.DUEL_ACCEPTED,
    ["Duel Boundary Warning"] = SOUNDS.DUEL_BOUNDARY_WARNING,
    ["Duel Forfeit"] = SOUNDS.DUEL_FORFEIT,
    ["Duel Invite Received"] = SOUNDS.DUEL_INVITE_RECEIVED,
    ["Duel Start"] = SOUNDS.DUEL_START,
    ["Duel Won"] = SOUNDS.DUEL_WON,
    ["Trial - Scored Added High"] = SOUNDS.RAID_TRIAL_SCORE_ADDED_HIGH,
    ["Trial - Scored Added Low"] = SOUNDS.RAID_TRIAL_SCORE_ADDED_LOW,
    ["Trial - Scored Added Normal"] = SOUNDS.RAID_TRIAL_SCORE_ADDED_NORMAL,
    ["Trial - Scored Added Very High"] = SOUNDS.RAID_TRIAL_SCORE_ADDED_VERY_HIGH,
    ["Trial - Scored Added Very Low"] = SOUNDS.RAID_TRIAL_SCORE_ADDED_VERY_LOW,
    ["Display Announcement"] = SOUNDS.DISPLAY_ANNOUNCEMENT,
    ["Tel Var Multiplier Up"] = SOUNDS.TELVAR_MULTIPLIERUP,
    ["Book Collection Completed"] = SOUNDS.BOOK_COLLECTION_COMPLETED,
    ["Collectible Unlocked"] = SOUNDS.COLLECTIBLE_UNLOCKED,
    ["Voice Chat Channel Made Active"] = SOUNDS.VOICE_CHAT_ALERT_CHANNEL_MADE_ACTIVE,
    ["Console Game Enter"] = SOUNDS.CONSOLE_GAME_ENTER,
    ["Quest Shared"] = SOUNDS.QUEST_SHARED,
    ["Ultimate Ready"] = SOUNDS.ABILITY_ULTIMATE_READY,
    ["Champion Points Committed"] = SOUNDS.CHAMPION_POINTS_COMMITTED,
    ["Champion Damage Taken"] = SOUNDS.CHAMPION_DAMAGE_TAKEN,
    ["Champion Respec Accept"] = SOUNDS.CHAMPION_RESPEC_ACCEPT,
    ["Champion Star Locked"] = SOUNDS.CHAMPION_STAR_LOCKED,
    ["Champion Cycled"] = SOUNDS.CHAMPION_CYCLED_TO_WARRIOR,
}
-- -----------------------------------------------------------------------------
LUIE.StatusbarTextures =
{
    ["Aluminium"]              = "LuiExtended/media/unitframes/textures/Aluminium.dds",
    ["Armory"]                 = "LuiExtended/media/unitframes/textures/Armory.dds",
    ["BantoBar"]               = "LuiExtended/media/unitframes/textures/BantoBar.dds",
    ["Bars"]                   = "LuiExtended/media/unitframes/textures/Bars.dds",
    ["Bumps"]                  = "LuiExtended/media/unitframes/textures/Bumps.dds",
    ["Button"]                 = "LuiExtended/media/unitframes/textures/Button.dds",
    ["Charcoal"]               = "LuiExtended/media/unitframes/textures/Charcoal.dds",
    ["Cilo"]                   = "LuiExtended/media/unitframes/textures/Cilo.dds",
    ["Cloud"]                  = "LuiExtended/media/unitframes/textures/Cloud.dds",
    ["Comet"]                  = "LuiExtended/media/unitframes/textures/Comet.dds",
    ["Dabs"]                   = "LuiExtended/media/unitframes/textures/Dabs.dds",
    ["DarkBottom"]             = "LuiExtended/media/unitframes/textures/DarkBottom.dds",
    ["Diagonal"]               = "LuiExtended/media/unitframes/textures/Diagonal.dds",
    ["Elder Scrolls Gradient"] = "LuiExtended/media/unitframes/textures/ElderScrollsGrad.dds",
    ["Empty"]                  = "LuiExtended/media/unitframes/textures/Empty.dds",
    ["Falumn"]                 = "LuiExtended/media/unitframes/textures/Falumn.dds",
    ["Fifths"]                 = "LuiExtended/media/unitframes/textures/Fifths.dds",
    ["Flat"]                   = "LuiExtended/media/unitframes/textures/Flat.dds",
    ["Fourths"]                = "LuiExtended/media/unitframes/textures/Fourths.dds",
    ["Frost"]                  = "LuiExtended/media/unitframes/textures/Frost.dds",
    ["Glamour"]                = "LuiExtended/media/unitframes/textures/Glamour.dds",
    ["Glamour2"]               = "LuiExtended/media/unitframes/textures/Glamour2.dds",
    ["Glamour3"]               = "LuiExtended/media/unitframes/textures/Glamour3.dds",
    ["Glamour4"]               = "LuiExtended/media/unitframes/textures/Glamour4.dds",
    ["Glamour5"]               = "LuiExtended/media/unitframes/textures/Glamour5.dds",
    ["Glamour6"]               = "LuiExtended/media/unitframes/textures/Glamour6.dds",
    ["Glamour7"]               = "LuiExtended/media/unitframes/textures/Glamour7.dds",
    ["Glass"]                  = "LuiExtended/media/unitframes/textures/Glass.dds",
    ["Glaze"]                  = "LuiExtended/media/unitframes/textures/Glaze.dds",
    ["Gloss"]                  = "LuiExtended/media/unitframes/textures/Gloss.dds",
    ["Grainy"]                 = "LuiExtended/media/unitframes/textures/grainy.dds",
    ["Graphite"]               = "LuiExtended/media/unitframes/textures/Graphite.dds",
    ["Grid"]                   = "LuiExtended/media/unitframes/textures/Grid.dds",
    ["Hatched"]                = "LuiExtended/media/unitframes/textures/Hatched.dds",
    ["Healbot"]                = "LuiExtended/media/unitframes/textures/Healbot.dds",
    ["Horizontal Gradient 1"]  = "LuiExtended/media/unitframes/textures/HorizontalGrad.dds",
    ["Horizontal Gradient 2"]  = "LuiExtended/media/unitframes/textures/HorizontalGradV2.dds",
    ["Inner Glow"]             = "LuiExtended/media/unitframes/textures/InnerGlow.dds",
    ["Inner Shadow Glossy"]    = "LuiExtended/media/unitframes/textures/InnerShadowGloss.dds",
    ["Inner Shadow"]           = "LuiExtended/media/unitframes/textures/InnerShadow.dds",
    ["LiteStep"]               = "LuiExtended/media/unitframes/textures/LiteStep.dds",
    ["LiteStepLite"]           = "LuiExtended/media/unitframes/textures/LiteStepLite.dds",
    ["Lyfe"]                   = "LuiExtended/media/unitframes/textures/Lyfe.dds",
    ["Melli Dark Rough"]       = "LuiExtended/media/unitframes/textures/MelliDarkRough.dds",
    ["Melli Dark"]             = "LuiExtended/media/unitframes/textures/MelliDark.dds",
    ["Melli"]                  = "LuiExtended/media/unitframes/textures/Melli.dds",
    ["Minimalist"]             = "LuiExtended/media/unitframes/textures/Minimalist.dds",
    ["Minimalistic"]           = "LuiExtended/media/unitframes/textures/Minimalistic.dds",
    ["Otravi"]                 = "LuiExtended/media/unitframes/textures/Otravi.dds",
    ["Outline"]                = "LuiExtended/media/unitframes/textures/Outline.dds",
    ["Perl v2"]                = "LuiExtended/media/unitframes/textures/Perl2.dds",
    ["Perl"]                   = "LuiExtended/media/unitframes/textures/Perl.dds",
    ["Plain"]                  = "LuiExtended/media/unitframes/textures/Plain.dds",
    ["Rain"]                   = "LuiExtended/media/unitframes/textures/Rain.dds",
    ["Rocks"]                  = "LuiExtended/media/unitframes/textures/Rocks.dds",
    ["Round"]                  = "LuiExtended/media/unitframes/textures/Round.dds",
    ["Ruben"]                  = "LuiExtended/media/unitframes/textures/Ruben.dds",
    ["Runes"]                  = "LuiExtended/media/unitframes/textures/Runes.dds",
    ["Sand Paper 1"]           = "LuiExtended/media/unitframes/textures/SandPaper.dds",
    ["Sand Paper 2"]           = "LuiExtended/media/unitframes/textures/SandPaperV2.dds",
    ["Shadow"]                 = "LuiExtended/media/unitframes/textures/Shadow.dds",
    ["Skewed"]                 = "LuiExtended/media/unitframes/textures/Skewed.dds",
    ["Smooth v2"]              = "LuiExtended/media/unitframes/textures/Smoothv2.dds",
    ["Smooth"]                 = "LuiExtended/media/unitframes/textures/Smooth.dds",
    ["Smudge"]                 = "LuiExtended/media/unitframes/textures/Smudge.dds",
    ["Steel"]                  = "LuiExtended/media/unitframes/textures/Steel.dds",
    ["Striped"]                = "LuiExtended/media/unitframes/textures/Striped.dds",
    ["Tube"]                   = "LuiExtended/media/unitframes/textures/Tube.dds",
    ["Water"]                  = "LuiExtended/media/unitframes/textures/Water.dds",
    ["Wglass"]                 = "LuiExtended/media/unitframes/textures/Wglass.dds",
    ["Wisps"]                  = "LuiExtended/media/unitframes/textures/Wisps.dds",
    ["Xeon"]                   = "LuiExtended/media/unitframes/textures/Xeon.dds",
}
-- -----------------------------------------------------------------------------
local table_insert = table.insert
local LMP = LibMediaProvider
local cm = LUIE.callbackObject
-- -----------------------------------------------------------------------------
-- Media type definitions
local MEDIA_TYPES =
{
    FONT = "font",
    SOUND = "sound",
    STATUSBAR = "statusbar",
    BORDER = "border",
    BACKGROUND = "background",
}
-- -----------------------------------------------------------------------------
-- Pre-initialize the media lists for direct access
local FontsList = {}
local SoundsList = {}
local StatusbarTexturesList = {}
local BorderTexturesList = {}
local BackgroundTexturesList = {}
-- -----------------------------------------------------------------------------
-- Expose the lists globally through LUIE.Media
LUIE.Media =
{
    FontList = FontsList,
    SoundList = SoundsList,
    StatusbarTexturesList = StatusbarTexturesList,
    BorderTexturesList = BorderTexturesList,
    BackgroundTexturesList = BackgroundTexturesList,
}
-- -----------------------------------------------------------------------------
-- Helper function to update media lists
local function UpdateMediaList(mediaType, luieSource, mediaList)
    -- Add LUIE media first
    for key, path in pairs(luieSource) do
        LMP:Register(mediaType, key, path)
        table_insert(mediaList, key)
    end

    -- Add media from other addons
    for _, name in pairs(LMP:List(mediaType)) do
        if not luieSource[name] then
            table_insert(mediaList, name)
        end
    end
end
-- -----------------------------------------------------------------------------
-- Update functions for each media type
function LUIE.UpdateFonts()
    ZO_ClearTable(FontsList)
    UpdateMediaList(MEDIA_TYPES.FONT, LUIE.Fonts, FontsList)
end

-- -----------------------------------------------------------------------------
function LUIE.UpdateSounds()
    ZO_ClearTable(SoundsList)
    UpdateMediaList(MEDIA_TYPES.SOUND, LUIE.Sounds, SoundsList)
end

-- -----------------------------------------------------------------------------
function LUIE.UpdateStatusbarTextures()
    ZO_ClearTable(StatusbarTexturesList)
    UpdateMediaList(MEDIA_TYPES.STATUSBAR, LUIE.StatusbarTextures, StatusbarTexturesList)
end

-- -----------------------------------------------------------------------------
function LUIE.UpdateBorderTextures()
    ZO_ClearTable(BorderTexturesList)
    UpdateMediaList(MEDIA_TYPES.BORDER, LUIE.BorderTextures, BorderTexturesList)
end

-- -----------------------------------------------------------------------------
function LUIE.UpdateBackgroundTextures()
    ZO_ClearTable(BackgroundTexturesList)
    UpdateMediaList(MEDIA_TYPES.BACKGROUND, LUIE.BackgroundTextures, BackgroundTexturesList)
end

-- -----------------------------------------------------------------------------
-- Load all media
local function LoadMedia()
    LUIE.UpdateFonts()
    LUIE.UpdateSounds()
    LUIE.UpdateStatusbarTextures()
    LUIE.UpdateBorderTextures()
    LUIE.UpdateBackgroundTextures()
end
-- -----------------------------------------------------------------------------
-- Initialize media on load
LoadMedia()
-- -----------------------------------------------------------------------------
-- Register callback for media updates
local function OnMediaRegistered(mediatype, key)
    local mediaMap =
    {
        [MEDIA_TYPES.FONT] = { update = LUIE.UpdateFonts },
        [MEDIA_TYPES.SOUND] = { update = LUIE.UpdateSounds },
        [MEDIA_TYPES.STATUSBAR] = { update = LUIE.UpdateStatusbarTextures },
        [MEDIA_TYPES.BORDER] = { update = LUIE.UpdateBorderTextures },
        [MEDIA_TYPES.BACKGROUND] = { update = LUIE.UpdateBackgroundTextures },
    }

    local mapping = mediaMap[mediatype]
    if mapping then
        mapping.update()
    end
end
-- -----------------------------------------------------------------------------
cm:RegisterCallback("LibMediaProvider_Registered", OnMediaRegistered)
-- -----------------------------------------------------------------------------
