--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local ChatAnnouncements = LUIE.ChatAnnouncements

local zo_strformat = zo_strformat

local chatNameDisplayOptions        = { "@UserID", "Character Name", "Character Name @UserID" }
local chatNameDisplayOptionsKeys    = { ["@UserID"] = 1, ["Character Name"] = 2, ["Character Name @UserID"] = 3 }
local linkBracketDisplayOptions     = { "No Brackets", "Display Brackets" }
local linkBracketDisplayOptionsKeys = { ["No Brackets"] = 1, ["Display Brackets"] = 2}
local bracketOptions4               = { "[]", "()", "-", "No Brackets" }
local bracketOptions4Keys           = { ["[]"] = 1, ["()"] = 2, ["-"] = 3, ["No Brackets"] = 4 }
local bracketOptions5               = { "[]", "()", "-", ":", "No Brackets" }
local bracketOptions5Keys           = { ["[]"] = 1, ["()"] = 2, ["-"] = 3, [":"] = 4, ["No Brackets"] = 5 }
local guildRankDisplayOptions       = { "Self Only", "All w/ Permissions", "All Rank Changes" }
local guildRankDisplayOptionsKeys   = { ["Self Only"] = 1, ["All w/ Permissions"] = 2, ["All Rank Changes"] = 3 }
local duelStartOptions              = { "Message + Icon", "Message Only", "Icon Only" }
local duelStartOptionsKeys          = { ["Message + Icon"] = 1, ["Message Only"] = 2, ["Icon Only"] = 3 }

function ChatAnnouncements.CreateSettings()
    -- Load LibAddonMenu
    local LAM = LibAddonMenu2
    if LAM == nil then return end

    local Defaults = ChatAnnouncements.Defaults
    local Settings = ChatAnnouncements.SV

    local panelDataChatAnnouncements = {
        type = "panel",
        name = zo_strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_CA)),
        displayName = zo_strformat("<<1>> <<2>>", LUIE.name, GetString(SI_LUIE_LAM_CA)),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        feedback = LUIE.feedback,
        translation = LUIE.translation,
        donation = LUIE.donation,
        slashCommand = "/luica",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local optionsDataChatAnnouncements = {}

    -- Chat Announcements Module Description
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_CA_DESCRIPTION),
    }

    -- ReloadUI Button
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }

    -- Chat Announcements - Chat Message Settings Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_CHATHEADER),
        controls = {
            {
                -- Player Name Display Method
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_NAMEDISPLAYMETHOD),
                tooltip = GetString(SI_LUIE_LAM_CA_NAMEDISPLAYMETHOD_TP),
                choices = chatNameDisplayOptions,
                getFunc = function() return chatNameDisplayOptions[Settings.ChatPlayerDisplayOptions] end,
                setFunc = function(value) Settings.ChatPlayerDisplayOptions = chatNameDisplayOptionsKeys[value] ChatAnnouncements.IndexGroupLoot() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = chatNameDisplayOptions[2],
            },
            {
                -- Character Name Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_CHARACTER),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_CHARACTER_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[Settings.BracketOptionCharacter] end,
                setFunc = function(value) Settings.BracketOptionCharacter = linkBracketDisplayOptionsKeys[value] ChatAnnouncements.IndexGroupLoot() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.BracketOptionCharacter,
            },
            --[[{
                -- Notification Color
                type = "colorpicker",
                name = "Notification Color (Unimplemented)",
                tooltip = "This message will be used to colorize various generic notification messages that are not Social/Guild related or error messages.",
                getFunc = function() return unpack(Settings.Notify.NotificationColor) end,
                setFunc = function(r, g, b, a) Settings.Notify.NotificationColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.TodoLater end,
                default = {r=Defaults.Notify.NotificationColor[1], g=Defaults.Notify.NotificationColor[2], b=Defaults.Notify.NotificationColor[3]}
            },]]--
            {
                -- Choose Chat Print Method
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_CHATMETHOD),
                tooltip = GetString(SI_LUIE_LAM_CA_CHATMETHOD_TP),
                choices = { "Print to All Tabs", "Print to Specific Tabs" },
                getFunc = function() return Settings.ChatMethod end,
                setFunc = function(value) Settings.ChatMethod = value end,
                width = "full",
                sort = "name-up",
                default = Defaults.ChatMethod,
            },

            {
                -- TODO: REMOVE LATER - CHAT NOTE
                type = "description",
                text = "Note: The Harrowstorm update significantly modified the way the Chat System works. I'm not sure if its possible to print to individual chat tabs any longer.\n\nFor the time being none of these settings work except the Timestamp options. The rest of the settings will hopefully be re-enabled in the future.",
            },

            {
                -- Bypass LUIE to use other chat addons
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CHATBYPASS)),
                tooltip = GetString(SI_LUIE_LAM_CA_CHATBYPASS_TP),
                getFunc = function() return Settings.ChatBypass end,
                setFunc = function(value) Settings.ChatBypass = value end,
                width = "full",
                --disabled = function() return Settings.ChatMethod == "Print to Specific Tabs" end,
                disabled = true,
                default = Defaults.ChatBypass,
            },
            {
                -- Print Chat Announcements & Messages to Tab 1
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "1"),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "1"),
                getFunc = function() return Settings.ChatTab[1] end,
                setFunc = function(value) Settings.ChatTab[1] = value end,
                width = "full",
                --disabled = function() return Settings.ChatMethod == "Print to All Tabs" end,
                disabled = true,
                default = Defaults.ChatTab[1],
            },
            {
                -- Print Chat Announcements & Messages to Tab 2
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "2"),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "2"),
                getFunc = function() return Settings.ChatTab[2] end,
                setFunc = function(value) Settings.ChatTab[2] = value end,
                width = "full",
                --disabled = function() return Settings.ChatMethod == "Print to All Tabs" end,
                disabled = true,
                default = Defaults.ChatTab[2],
            },
            {
                -- Print Chat Announcements & Messages to Tab 3
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "3"),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "3"),
                getFunc = function() return Settings.ChatTab[3] end,
                setFunc = function(value) Settings.ChatTab[3] = value end,
                width = "full",
                --disabled = function() return Settings.ChatMethod == "Print to All Tabs" end,
                disabled = true,
                default = Defaults.ChatTab[3],
            },
            {
                -- Print Chat Announcements & Messages to Tab 4
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "4"),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "4"),
                getFunc = function() return Settings.ChatTab[4] end,
                setFunc = function(value) Settings.ChatTab[4] = value end,
                width = "full",
                --disabled = function() return Settings.ChatMethod == "Print to All Tabs" end,
                disabled = true,
                default = Defaults.ChatTab[4],
            },
            {
                -- Print Chat Announcements & Messages to Tab 5
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "5"),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "5"),
                getFunc = function() return Settings.ChatTab[5] end,
                setFunc = function(value) Settings.ChatTab[5] = value end,
                width = "full",
                --disabled = function() return Settings.ChatMethod == "Print to All Tabs" end,
                disabled = true,
                default = Defaults.ChatTab[5],
            },
            {
                -- Display System & Notifications in all Tabs
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CHATTABSYSTEMALL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CHATTABSYSTEMALL_TP),
                getFunc = function() return Settings.ChatSystemAll end,
                setFunc = function(value) Settings.ChatSystemAll = value end,
                width = "full",
                --disabled = function() return Settings.ChatMethod == "Print to All Tabs" end,
                disabled = true,
                default = Defaults.ChatSystemAll,
            },
            {
                -- Include Timestamp
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_TIMESTAMP),
                tooltip = GetString(SI_LUIE_LAM_CA_TIMESTAMP_TP),
                getFunc = function() return Settings.TimeStamp end,
                setFunc = function(value) Settings.TimeStamp = value end,
                width = "full",
                default = Defaults.TimeStamp,
            },
            {
                -- Timestamp Format
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_TIMESTAMPFORMAT)),
                tooltip = GetString(SI_LUIE_LAM_CA_TIMESTAMPFORMAT_TP),
                getFunc = function() return Settings.TimeStampFormat end,
                setFunc = function(value) Settings.TimeStampFormat = value end,
                width = "full",
                disabled = function() return not Settings.TimeStamp end,
                default = Defaults.TimeStampFormat,
            },
            {
                -- Timestamp Color
                type    = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_TIMESTAMPCOLOR)),
                tooltip = GetString(SI_LUIE_LAM_CA_TIMESTAMPCOLOR_TP),
                getFunc = function() return unpack(Settings.TimeStampColor) end,
                setFunc = function(r, g, b, a) Settings.TimeStampColor = { r, g, b, a } LUIE.UpdateTimeStampColor() end,
                width = "full",
                disabled = function() return not Settings.TimeStamp end,
                default = {r=Settings.TimeStampColor[1], g=Settings.TimeStampColor[2], b=Settings.TimeStampColor[3]},
            },
        },
    }

    -- Chat Announcements - Currency Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_CURRENCY_HEADER),
        controls = {
            {
                -- Show Currency Icons
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWICONS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWICONS_TP),
                getFunc = function() return Settings.Currency.CurrencyIcon end,
                setFunc = function(value) Settings.Currency.CurrencyIcon = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyIcon,
            },
            {
                -- Show Gold
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLD),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLD_TP),
                getFunc = function() return Settings.Currency.CurrencyGoldChange end,
                setFunc = function(value) Settings.Currency.CurrencyGoldChange = value ChatAnnouncements.RegisterGoldEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyGoldChange,
            },
            {
                -- Show Gold Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDCOLOR)),
                getFunc = function() return unpack(Settings.Currency.CurrencyGoldColor) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyGoldColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyGoldColor[1], g=Defaults.Currency.CurrencyGoldColor[2], b=Defaults.Currency.CurrencyGoldColor[3]}
            },
            {
                -- Show Gold Name
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDNAME_TP),
                getFunc = function() return Settings.Currency.CurrencyGoldName end,
                setFunc = function(value) Settings.Currency.CurrencyGoldName = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyGoldName,
            },
            {
                -- Show Gold Total Amount
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_TP),
                getFunc = function() return Settings.Currency.CurrencyGoldShowTotal end,
                setFunc = function(value) Settings.Currency.CurrencyGoldShowTotal = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyGoldShowTotal,
            },
            {
                -- Total Currency Message (Gold)
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_MSG_TP),
                getFunc = function() return Settings.Currency.CurrencyMessageTotalGold end,
                setFunc = function(value) Settings.Currency.CurrencyMessageTotalGold = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Currency.CurrencyGoldChange and Settings.Currency.CurrencyGoldShowTotal) end,
                default = Defaults.Currency.CurrencyMessageTotalGold,
            },
            {
                -- Show Gold Threshold
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHRESHOLD_TP),
                getFunc = function() return Settings.Currency.CurrencyGoldFilter end,
                setFunc = function(value) Settings.Currency.CurrencyGoldFilter = value end,
                min = 0,
                max = 10000,
                step = 50,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyGoldFilter,
            },
            {
                -- Throttle Gold Looted
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHROTTLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHROTTLE_TP),
                getFunc = function() return Settings.Currency.CurrencyGoldThrottle end,
                setFunc = function(value) Settings.Currency.CurrencyGoldThrottle = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyGoldThrottle,
            },
            {
                -- Hide Gold Spent on AH (Listing)
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHLIST)),
                tooltip = zo_strformat("<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHLIST_TP)),
                getFunc = function() return Settings.Currency.CurrencyGoldHideListingAH end,
                setFunc = function(value) Settings.Currency.CurrencyGoldHideListingAH = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyGoldHideListingAH,
            },
            {
                -- Hide Gold Spent on AH (Purchase)
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT)),
                tooltip = zo_strformat("<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT_TP)),
                getFunc = function() return Settings.Currency.CurrencyGoldHideAH end,
                setFunc = function(value) Settings.Currency.CurrencyGoldHideAH = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyGoldHideAH,
            },
            {
                -- Show Alliance Points
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAP),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAP_TP),
                getFunc = function() return Settings.Currency.CurrencyAPShowChange end,
                setFunc = function(value) Settings.Currency.CurrencyAPShowChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyAPShowChange,
            },
            {
                -- Show Alliance Points Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPCOLOR)),
                getFunc = function() return unpack(Settings.Currency.CurrencyAPColor) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyAPColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyAPColor[1], g=Defaults.Currency.CurrencyAPColor[2], b=Defaults.Currency.CurrencyAPColor[3]}
            },
            {
                -- Show Alliance Points Name
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME_TP),
                getFunc = function() return Settings.Currency.CurrencyAPName end,
                setFunc = function(value) Settings.Currency.CurrencyAPName = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.TotalCurrencyAPName,
            },
            {
                -- Show Alliance Points Total
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL_TP),
                getFunc = function() return Settings.Currency.CurrencyAPShowTotal end,
                setFunc = function(value) Settings.Currency.CurrencyAPShowTotal = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyAPShowTotal,
            },
            {
                -- Total Currency Message (Alliance Points)
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_APTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_APTOTAL_MSG_TP),
                getFunc = function() return Settings.Currency.CurrencyMessageTotalAP end,
                setFunc = function(value) Settings.Currency.CurrencyMessageTotalAP = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Currency.CurrencyAPShowChange and Settings.Currency.CurrencyAPShowTotal) end,
                default = Defaults.Currency.CurrencyMessageTotalAP,
            },
            {
                -- Show Alliance Points Threshold
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD_TP),
                getFunc = function() return Settings.Currency.CurrencyAPFilter end,
                setFunc = function(value) Settings.Currency.CurrencyAPFilter = value end,
                min = 0,
                max = 10000,
                step = 50,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyAPFilter,
            },
            {
                -- Throttle Alliance Points Earned
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHROTTLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHROTTLE_TP),
                getFunc = function() return Settings.Currency.CurrencyAPThrottle end,
                setFunc = function(value) Settings.Currency.CurrencyAPThrottle = value end,
                min = 0,
                max = 5000,
                step = 50,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyAPThrottle,
            },
            {
                -- Show Tel Var
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTV),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTV_TP),
                getFunc = function() return Settings.Currency.CurrencyTVChange end,
                setFunc = function(value) Settings.Currency.CurrencyTVChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyTVChange,
            },
            {
                -- Show Tel Var Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVCOLOR)),
                getFunc = function() return unpack(Settings.Currency.CurrencyTVColor) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyTVColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyTVColor[1], g=Defaults.Currency.CurrencyTVColor[2], b=Defaults.Currency.CurrencyTVColor[3]}
            },
            {
                -- Show Tel Var Name
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME_TP),
                getFunc = function() return Settings.Currency.CurrencyTVName end,
                setFunc = function(value) Settings.Currency.CurrencyTVName = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyTVName,
            },
            {
                -- Show Tel Var Total
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL_TP),
                getFunc = function() return Settings.Currency.CurrencyTVShowTotal end,
                setFunc = function(value) Settings.Currency.CurrencyTVShowTotal = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyTVShowTotal,
            },
            {
                -- Total Currency Message (Tel Var)
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_TVTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_TVTOTAL_MSG_TP),
                getFunc = function() return Settings.Currency.CurrencyMessageTotalTV end,
                setFunc = function(value) Settings.Currency.CurrencyMessageTotalTV = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Currency.CurrencyAPShowChange and Settings.Currency.CurrencyTVShowTotal) end,
                default = Defaults.Currency.CurrencyMessageTotalTV,
            },
            {
                -- Show Tel Var Stones Threshold
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHRESHOLD_TP),
                getFunc = function() return Settings.Currency.CurrencyTVFilter end,
                setFunc = function(value) Settings.Currency.CurrencyTVFilter = value end,
                min = 0,
                max = 10000,
                step = 50,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyTVFilter,
            },
            {
                -- Throttle Tel Var Stones Looted
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHROTTLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHROTTLE_TP),
                getFunc = function() return Settings.Currency.CurrencyTVThrottle end,
                setFunc = function(value) Settings.Currency.CurrencyTVThrottle = value end,
                min = 0,
                max = 5000,
                step = 50,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyTVThrottle,
            },
            {
                -- Show Writ Vouchers
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER_TP),
                getFunc = function() return Settings.Currency.CurrencyWVChange end,
                setFunc = function(value) Settings.Currency.CurrencyWVChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyWVChange,
            },
            {
                -- Show Writ Vouchers Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERCOLOR)),
                getFunc = function() return unpack(Settings.Currency.CurrencyWVColor) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyWVColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyWVColor[1], g=Defaults.Currency.CurrencyWVColor[2], b=Defaults.Currency.CurrencyWVColor[3]}
            },
            {
                -- Show Writ Vouchers Name
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME_TP),
                getFunc = function() return Settings.Currency.CurrencyWVName end,
                setFunc = function(value) Settings.Currency.CurrencyWVName = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyWVName,
            },
            {
                -- Show Writ Vouchers Total
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL_TP),
                getFunc = function() return Settings.Currency.CurrencyWVShowTotal end,
                setFunc = function(value) Settings.Currency.CurrencyWVShowTotal = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyWVShowTotal,
            },
            {
                -- Total Currency Message (Writ Vouchers)
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_WVTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_WVTOTAL_MSG_TP),
                getFunc = function() return Settings.Currency.CurrencyMessageTotalWV end,
                setFunc = function(value) Settings.Currency.CurrencyMessageTotalWV = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Currency.CurrencyWVChange and Settings.Currency.CurrencyWVShowTotal) end,
                default = Defaults.Currency.CurrencyMessageTotalWV,
            },
            {
                -- Show Undaunted Keys
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWUNDAUNTED),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWUNDAUNTED_TP),
                getFunc = function() return Settings.Currency.CurrencyUndauntedChange end,
                setFunc = function(value) Settings.Currency.CurrencyUndauntedChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyUndauntedChange,
            },
            {
                -- Show Undaunted Keys Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWUNDAUNTEDCOLOR)),
                getFunc = function() return unpack(Settings.Currency.CurrencyUndauntedColor) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyUndauntedColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyUndauntedChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyUndauntedColor[1], g=Defaults.Currency.CurrencyUndauntedColor[2], b=Defaults.Currency.CurrencyUndauntedColor[3]}
            },
            {
                -- Show Undaunted Keys Name
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWUNDAUNTEDNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWUNDAUNTEDNAME_TP),
                getFunc = function() return Settings.Currency.CurrencyUndauntedName end,
                setFunc = function(value) Settings.Currency.CurrencyUndauntedName = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyUndauntedChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyUndauntedName,
            },
            {
                -- Show Undaunted Keys Total
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWUNDAUNTEDTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWUNDAUNTEDTOTAL_TP),
                getFunc = function() return Settings.Currency.CurrencyUndauntedShowTotal end,
                setFunc = function(value) Settings.Currency.CurrencyUndauntedShowTotal = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyUndauntedChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyUndauntedShowTotal,
            },
            {
                -- Total Currency Message (Undaunted Keys)
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_UNDAUNTEDTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_UNDAUNTEDTOTAL_MSG_TP),
                getFunc = function() return Settings.Currency.CurrencyMessageTotalUndaunted end,
                setFunc = function(value) Settings.Currency.CurrencyMessageTotalUndaunted = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Currency.CurrencyUndauntedChange and Settings.Currency.CurrencyUndauntedShowTotal) end,
                default = Defaults.Currency.CurrencyMessageTotalUndaunted,
            },
            {
                -- Show Outfit Tokens
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENS_TP),
                getFunc = function() return Settings.Currency.CurrencyOutfitTokenChange end,
                setFunc = function(value) Settings.Currency.CurrencyOutfitTokenChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyOutfitTokenChange,
            },
            {
                -- Show Outfit Tokens Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSCOLOR)),
                getFunc = function() return unpack(Settings.Currency.CurrencyOutfitTokenColor) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyOutfitTokenColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyOutfitTokenChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyOutfitTokenColor[1], g=Defaults.Currency.CurrencyOutfitTokenColor[2], b=Defaults.Currency.CurrencyOutfitTokenColor[3]}
            },
            {
                -- Show Outfit Tokens Name
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSNAME_TP),
                getFunc = function() return Settings.Currency.CurrencyOutfitTokenName end,
                setFunc = function(value) Settings.Currency.CurrencyOutfitTokenName = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyOutfitTokenChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyOutfitTokenName,
            },
            {
                -- Show Outfit Tokens Total
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSTOTAL_TP),
                getFunc = function() return Settings.Currency.CurrencyOutfitTokenShowTotal end,
                setFunc = function(value) Settings.Currency.CurrencyOutfitTokenShowTotal = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyOutfitTokenChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyOutfitTokenShowTotal,
            },
            {
                -- Total Currency Message (Outfit Tokens)
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_TOKENSTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_TOKENSTOTAL_MSG_TP),
                getFunc = function() return Settings.Currency.CurrencyMessageTotalOutfitToken end,
                setFunc = function(value) Settings.Currency.CurrencyMessageTotalOutfitToken = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Currency.CurrencyOutfitTokenChange and Settings.Currency.CurrencyOutfitTokenShowTotal) end,
                default = Defaults.Currency.CurrencyMessageTotalOutfitToken,
            },
            {
                -- Show Transmute Crystals
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTE_TP),
                getFunc = function() return Settings.Currency.CurrencyTransmuteChange end,
                setFunc = function(value) Settings.Currency.CurrencyTransmuteChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyTransmuteChange,
            },
            {
                -- Show Transmute Crystals Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTECOLOR)),
                getFunc = function() return unpack(Settings.Currency.CurrencyTransmuteColor) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyTransmuteColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyTransmuteChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyTransmuteColor[1], g=Defaults.Currency.CurrencyTransmuteColor[2], b=Defaults.Currency.CurrencyTransmuteColor[3]}
            },
            {
                -- Show Transmute Crystals Name
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTENAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTENAME_TP),
                getFunc = function() return Settings.Currency.CurrencyTransmuteName end,
                setFunc = function(value) Settings.Currency.CurrencyTransmuteName = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyTransmuteChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyTransmuteName,
            },
            {
                -- Show Transmute Crystals Total
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTETOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTETOTAL_TP),
                getFunc = function() return Settings.Currency.CurrencyTransmuteShowTotal end,
                setFunc = function(value) Settings.Currency.CurrencyTransmuteShowTotal = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyTransmuteChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyTransmuteShowTotal,
            },
            {
                -- Total Currency Message (Transmute Crystals)
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_TRANSMUTETOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_TRANSMUTETOTAL_MSG_TP),
                getFunc = function() return Settings.Currency.CurrencyMessageTotalTransmute end,
                setFunc = function(value) Settings.Currency.CurrencyMessageTotalTransmute = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Currency.CurrencyTransmuteChange and Settings.Currency.CurrencyTransmuteShowTotal) end,
                default = Defaults.Currency.CurrencyMessageTotalTransmute,
            },
            {
                -- Show Event Tickets
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENT_TP),
                getFunc = function() return Settings.Currency.CurrencyEventChange end,
                setFunc = function(value) Settings.Currency.CurrencyEventChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyEventChange,
            },
            {
                -- Show Event Tickets Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTCOLOR)),
                getFunc = function() return unpack(Settings.Currency.CurrencyEventColor) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyEventColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyEventChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyEventColor[1], g=Defaults.Currency.CurrencyEventColor[2], b=Defaults.Currency.CurrencyEventColor[3]}
            },
            {
                -- Show Event Tickets Name
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTNAME_TP),
                getFunc = function() return Settings.Currency.CurrencyEventName end,
                setFunc = function(value) Settings.Currency.CurrencyEventName = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyEventChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyEventName,
            },
            {
                -- Show Event Tickets Total
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTTOTAL_TP),
                getFunc = function() return Settings.Currency.CurrencyEventShowTotal end,
                setFunc = function(value) Settings.Currency.CurrencyEventShowTotal = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyEventChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyEventShowTotal,
            },
            {
                -- Total Currency Message (Event Tickets)
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_EVENTTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_EVENTTOTAL_MSG_TP),
                getFunc = function() return Settings.Currency.CurrencyMessageTotalEvent end,
                setFunc = function(value) Settings.Currency.CurrencyMessageTotalEvent = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Currency.CurrencyEventChange and Settings.Currency.CurrencyEventShowTotal) end,
                default = Defaults.Currency.CurrencyMessageTotalEvent,
            },
            {
                -- Show Crowns
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNS_TP),
                getFunc = function() return Settings.Currency.CurrencyCrownsChange end,
                setFunc = function(value) Settings.Currency.CurrencyCrownsChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyCrownsChange,
            },
            {
                -- Show Crowns Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSCOLOR)),
                getFunc = function() return unpack(Settings.Currency.CurrencyCrownsColor) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyCrownsColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyCrownsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyCrownsColor[1], g=Defaults.Currency.CurrencyCrownsColor[2], b=Defaults.Currency.CurrencyCrownsColor[3]}
            },
            {
                -- Show Crowns Name
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSNAME_TP),
                getFunc = function() return Settings.Currency.CurrencyCrownsName end,
                setFunc = function(value) Settings.Currency.CurrencyCrownsName = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyCrownsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyCrownsName,
            },
            {
                -- Show Crowns Total
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSTOTAL_TP),
                getFunc = function() return Settings.Currency.CurrencyCrownsShowTotal end,
                setFunc = function(value) Settings.Currency.CurrencyCrownsShowTotal = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyCrownsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyCrownsShowTotal,
            },
            {
                -- Total Currency Message (Crowns)
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNSTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNSTOTAL_MSG_TP),
                getFunc = function() return Settings.Currency.CurrencyMessageTotalCrowns end,
                setFunc = function(value) Settings.Currency.CurrencyMessageTotalCrowns = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Currency.CurrencyCrownsChange and Settings.Currency.CurrencyCrownsShowTotal) end,
                default = Defaults.Currency.CurrencyMessageTotalCrowns,
            },
            {
                -- Show Crown Gems
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMS_TP),
                getFunc = function() return Settings.Currency.CurrencyCrownGemsChange end,
                setFunc = function(value) Settings.Currency.CurrencyCrownGemsChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyCrownGemsChange,
            },
            {
                -- Show Crown Gems Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSCOLOR)),
                getFunc = function() return unpack(Settings.Currency.CurrencyCrownGemsColor) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyCrownGemsColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyCrownGemsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyCrownGemsColor[1], g=Defaults.Currency.CurrencyCrownGemsColor[2], b=Defaults.Currency.CurrencyCrownGemsColor[3]}
            },
            {
                -- Show Crown Gems Name
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSNAME_TP),
                getFunc = function() return Settings.Currency.CurrencyCrownGemsName end,
                setFunc = function(value) Settings.Currency.CurrencyCrownGemsName = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyCrownGemsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyCrownGemsName,
            },
            {
                -- Show Crown Gems Total
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSTOTAL_TP),
                getFunc = function() return Settings.Currency.CurrencyCrownGemsShowTotal end,
                setFunc = function(value) Settings.Currency.CurrencyCrownGemsShowTotal = value end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyCrownGemsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Currency.CurrencyCrownGemsShowTotal,
            },
            {
                -- Total Currency Message (Crown Gems)
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNGEMSTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNGEMSTOTAL_MSG_TP),
                getFunc = function() return Settings.Currency.CurrencyMessageTotalCrownGems end,
                setFunc = function(value) Settings.Currency.CurrencyMessageTotalCrownGems = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Currency.CurrencyCrownGemsChange and Settings.Currency.CurrencyCrownGemsShowTotal) end,
                default = Defaults.Currency.CurrencyMessageTotalCrownGems,
            },
        },
    }

    -- Chat Announcements - Loot Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_LOOT_HEADER),
        controls = {
            {
                -- Item Link Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ITEM),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ITEM_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[Settings.BracketOptionItem] end,
                setFunc = function(value) Settings.BracketOptionItem = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.BracketOptionItem,
            },
            {
                -- Show looted item icons
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWICONS),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWICONS_TP),
                getFunc = function() return Settings.Inventory.LootIcons end,
                setFunc = function(value) Settings.Inventory.LootIcons = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootIcons,
            },
            {
                -- Show Armor Type
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE_TP),
                getFunc = function() return Settings.Inventory.LootShowArmorType end,
                setFunc = function(value) Settings.Inventory.LootShowArmorType = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootShowArmorType,
            },
            {
                -- Show Item Style
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE_TP),
                getFunc = function() return Settings.Inventory.LootShowStyle end,
                setFunc = function(value) Settings.Inventory.LootShowStyle = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootShowStyle,
            },
            {
                -- Show Item Trait
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT_TP),
                getFunc = function() return Settings.Inventory.LootShowTrait end,
                setFunc = function(value) Settings.Inventory.LootShowTrait = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootShowTrait,
            },
            {
                -- Show loot total
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_TOTAL),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_TOTAL_TP),
                getFunc = function() return Settings.Inventory.LootTotal end,
                setFunc = function(value) Settings.Inventory.LootTotal = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootTotal,
            },
            {
                -- Loot total string
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_TOTALSTRING)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_TOTALSTRING_TP),
                getFunc = function() return Settings.Inventory.LootTotalString end,
                setFunc = function(value) Settings.Inventory.LootTotalString = value end,
                width = "full",
                disabled = function() return not (Settings.Inventory.LootTotal and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootTotalString,
            },
            {
                -- Show looted items
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMS),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMS_TP),
                getFunc = function() return Settings.Inventory.Loot end,
                setFunc = function(value) Settings.Inventory.Loot = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.Loot,
            },
            {
                -- Show notable loot
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE_TP),
                getFunc = function() return Settings.Inventory.LootOnlyNotable end,
                setFunc = function(value) Settings.Inventory.LootOnlyNotable = value end,
                width = "full",
                disabled = function() return not (Settings.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootOnlyNotable,
            },
            {
                -- Show group loot
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT_TP),
                getFunc = function() return Settings.Inventory.LootGroup end,
                setFunc = function(value) Settings.Inventory.LootGroup = value end,
                width = "full",
                disabled = function() return not (Settings.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootGroup,
            },
            {
                -- Hide annoying items
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_TP),
                getFunc = function() return Settings.Inventory.LootBlacklist end,
                setFunc = function(value) Settings.Inventory.LootBlacklist = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_WARNING),
                disabled = function() return not (Settings.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootBlacklist,
            },
            {
                -- Hide Trash Quality Items
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_HIDETRASH)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_HIDETRASH_TP),
                getFunc = function() return Settings.Inventory.LootNotTrash end,
                setFunc = function(value) Settings.Inventory.LootNotTrash = value end,
                width = "full",
                disabled = function() return not (Settings.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootNotTrash,
            },
            {
                -- Show Confiscated Items
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTCONFISCATED)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTCONFISCATED_TP),
                getFunc = function() return Settings.Inventory.LootConfiscate end,
                setFunc = function(value) Settings.Inventory.LootConfiscate = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not (Settings.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootConfiscate,
            },
            {
                -- Show Destroyed Items
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDESTROYED)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDESTROYED_TP),
                getFunc = function() return Settings.Inventory.LootShowDestroy end,
                setFunc = function(value) Settings.Inventory.LootShowDestroy = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not (Settings.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootShowDestroy,
            },
            {
                -- Show Removed Items
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWREMOVED)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWREMOVED_TP),
                getFunc = function() return Settings.Inventory.LootShowRemove end,
                setFunc = function(value) Settings.Inventory.LootShowRemove = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not (Settings.Inventory.Loot and Settings.Inventory.LootShowDestroy and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootShowRemove,
            },
            {
                -- Show Lockpick Break
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWLOCKPICK)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWLOCKPICK_TP),
                getFunc = function() return Settings.Inventory.LootShowLockpick end,
                setFunc = function(value) Settings.Inventory.LootShowLockpick = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not (Settings.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootShowLockpick,
            },
            {
                -- Show Quest Loot (Add)
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTADD),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTADD_TP),
                getFunc = function() return Settings.Inventory.LootQuestAdd end,
                setFunc = function(value) Settings.Inventory.LootQuestAdd = value ChatAnnouncements.RegisterLootEvents() ChatAnnouncements.AddQuestItemsToIndex() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootQuestAdd,
            },
            {
                -- Show Quest Loot (Remove)
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTREM),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTREM_TP),
                getFunc = function() return Settings.Inventory.LootQuestRemove end,
                setFunc = function(value) Settings.Inventory.LootQuestRemove = value ChatAnnouncements.RegisterLootEvents() ChatAnnouncements.AddQuestItemsToIndex() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootQuestRemove,
            },
            {
                -- Show Vendor Inventory Changes
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWVENDOR),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWVENDOR_TP),
                getFunc = function() return Settings.Inventory.LootVendor end,
                setFunc = function(value) Settings.Inventory.LootVendor = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootVendor,
            },
            {
                -- Merge Currency & Loot Message
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_MERGE)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_MERGE_TP),
                getFunc = function() return Settings.Inventory.LootVendorCurrency end,
                setFunc = function(value) Settings.Inventory.LootVendorCurrency = value end,
                width = "full",
                disabled = function() return not (Settings.Inventory.LootVendor and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootVendorCurrency,
            },
            {
                -- Loot Vendor Total Items
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALITEMS)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALITEMS_TP),
                getFunc = function() return Settings.Inventory.LootVendorTotalItems end,
                setFunc = function(value) Settings.Inventory.LootVendorTotalItems = value end,
                width = "full",
                disabled = function() return not (Settings.Inventory.LootVendor and Settings.Inventory.LootVendorCurrency and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootVendorTotalItems,
            },
            {
                -- Loot Vendor Total Currency
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALCURRENCY)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALCURRENCY_TP),
                getFunc = function() return Settings.Inventory.LootVendorTotalCurrency end,
                setFunc = function(value) Settings.Inventory.LootVendorTotalCurrency = value end,
                width = "full",
                disabled = function() return not (Settings.Inventory.LootVendor and Settings.Inventory.LootVendorCurrency and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootVendorTotalCurrency,
            },
            {
                -- Show Bank Inventory Changes
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWBANK),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWBANK_TP),
                getFunc = function() return Settings.Inventory.LootBank end,
                setFunc = function(value) Settings.Inventory.LootBank = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootBank,
            },
            {
                -- Show Craft
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_TP),
                getFunc = function() return Settings.Inventory.LootCraft end,
                setFunc = function(value) Settings.Inventory.LootCraft = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootCraft,
            },
            {
                -- Show Materials consumed when crafting
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS_TP),
                getFunc = function() return Settings.Inventory.LootShowCraftUse end,
                setFunc = function(value) Settings.Inventory.LootShowCraftUse = value end,
                width = "full",
                disabled = function() return not (Settings.Inventory.LootCraft and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Inventory.LootShowCraftUse,
            },
            {
                -- Show Mail Inventory Changes
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWMAIL),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWMAIL_TP),
                getFunc = function() return Settings.Inventory.LootMail end,
                setFunc = function(value) Settings.Inventory.LootMail = value ChatAnnouncements.RegisterMailEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootMail,
            },
            {
                -- Show Trade
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWTRADE),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWTRADE_TP),
                getFunc = function() return Settings.Inventory.LootTrade end,
                setFunc = function(value) Settings.Inventory.LootTrade = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootTrade,
            },
            {
                -- Show Disguise Equip
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDISGUISE),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDISGUISE_TP),
                getFunc = function() return Settings.Inventory.LootShowDisguise end,
                setFunc = function(value) Settings.Inventory.LootShowDisguise = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Inventory.LootShowDisguise,
            },
        },
    }

    -- Chat Announcements - Shared Currency/Loot Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_CURRENCY_CONTEXT_MENU),
        controls = {
            {
                -- Currency/Loot Message Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR),
                getFunc = function() return unpack(Settings.Currency.CurrencyColor) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable or Settings.Currency.CurrencyContextColor end,
                default = {r=Defaults.Currency.CurrencyColor[1], g=Defaults.Currency.CurrencyColor[2], b=Defaults.Currency.CurrencyColor[3]}
            },
            {
                -- Use Context Color for Currency/Loot Messages
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT_TP),
                getFunc = function() return Settings.Currency.CurrencyContextColor end,
                setFunc = function(value) Settings.Currency.CurrencyContextColor = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Currency.CurrencyContextColor,
            },
            {
                -- Positive Change Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_COLORUP)),
                getFunc = function() return unpack(Settings.Currency.CurrencyColorUp) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyColorUp = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyContextColor and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyColorUp[1], g=Defaults.Currency.CurrencyColorUp[2], b=Defaults.Currency.CurrencyColorUp[3]}
            },
            {
                -- Negative Change Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_COLORDOWN)),
                getFunc = function() return unpack(Settings.Currency.CurrencyColorDown) end,
                setFunc = function(r, g, b, a) Settings.Currency.CurrencyColorDown = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Currency.CurrencyContextColor and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Currency.CurrencyColorDown[1], g=Defaults.Currency.CurrencyColorDown[2], b=Defaults.Currency.CurrencyColorDown[3]}
            },
            {
                -- Context Messages Header
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_CONTEXT_HEADER),
                width = "full",
            },
            {
                -- Loot Message (Loot)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOOT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOOT_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageLoot end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageLoot = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageLoot,
            },
            {
                -- Loot Message (Receive)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RECEIVE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RECEIVE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageReceive end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageReceive = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageReceive,
            },
            {
                -- Earned Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageEarn end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageEarn = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageEarn,
            },
            {
                -- Loot Message (Steal)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageSteal end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageSteal = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageSteal,
            },
            {
                -- Loot Message (Pickpocket)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessagePickpocket end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessagePickpocket = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessagePickpocket,
            },
            {
                -- Loot Message (Confiscate)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageConfiscate end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageConfiscate = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageConfiscate,
            },
            {
                -- Loot Message (Spend)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageSpend end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageSpend = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageSpend,
            },
            {
                -- Loot Message (Pay)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PAY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PAY_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessagePay end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessagePay = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessagePay,
            },
            {
                -- Loot Message (TradeIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageTradeIn end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageTradeIn = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageTradeIn,
            },
            {
                -- Loot Message (TradeIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_NO_NAME_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageTradeInNoName end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageTradeInNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageTradeInNoName,
            },
            {
                -- Loot Message (TradeOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageTradeOut end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageTradeOut = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageTradeOut,
            },
            {
                -- Loot Message (TradeOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_NO_NAME_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageTradeOutNoName end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageTradeOutNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageTradeOutNoName,
            },
            {
                -- Loot Message (MailIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageMailIn end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageMailIn = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageMailIn,
            },
            {
                -- Loot Message (MailIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_NO_NAME_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageMailInNoName end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageMailInNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageMailInNoName,
            },
            {
                -- Loot Message (MailOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageMailOut end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageMailOut = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageMailOut,
            },
            {
                -- Loot Message (MailOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_NO_NAME_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageMailOutNoName end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageMailOutNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageMailOutNoName,
            },
            {
                -- Loot Message (Deposit)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageDeposit end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageDeposit = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageDeposit,
            },
            {
                -- Loot Message (Withdraw)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageWithdraw end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageWithdraw = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageWithdraw,
            },
            {
                -- Loot Message (Deposit Guild)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageDepositGuild end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageDepositGuild  = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageDepositGuild ,
            },
            {
                -- Loot Message (Withdraw Guild)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageWithdrawGuild  end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageWithdrawGuild  = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageWithdrawGuild ,
            },
            {
                -- Loot Message (Deposit)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITSTORAGE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITSTORAGE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageDepositStorage end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageDepositStorage = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageDepositStorage,
            },
            {
                -- Loot Message (Withdraw)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWSTORAGE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWSTORAGE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageWithdrawStorage end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageWithdrawStorage = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageWithdrawStorage,
            },
            {
                -- Lost Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageLost end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageLost = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageLost,
            },
            {
                -- Bounty Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageBounty end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageBounty = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageBounty,
            },
            {
                -- Repair Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageRepair end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageRepair = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageRepair,
            },
            {
                -- Trader Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageTrader end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageTrader = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageTrader,
            },
            {
                -- Listing Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageListing end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageListing = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageListing,
            },
            {
                -- Loot Message (Buy)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY_VALUE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageBuy end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageBuy = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageBuy,
            },
            {
                -- Loot Message (Buy) No Value
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageBuyNoV end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageBuyNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageBuyNoV,
            },
            {
                -- Loot Message (Buyback)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK_VALUE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageBuyback end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageBuyback = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageBuyback,
            },
            {
                -- Loot Message (Buyback) No Value
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageBuybackNoV end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageBuybackNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageBuybackNoV,
            },
            {
                -- Loot Message (Sell)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL_VALUE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageSell end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageSell = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageSell,
            },
            {
                -- Loot Message (Sell) No Value
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageSellNoV end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageSellNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageSellNoV,
            },
            {
                -- Loot Message (Fence)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE_VALUE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageFence end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageFence = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageFence,
            },
            {
                -- Loot Message (Fence)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageFenceNoV end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageFenceNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageFenceNoV,
            },
            {
                -- Loot Message (Launder)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER_VALUE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageLaunder end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageLaunder = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageLaunder,
            },
            {
                -- Loot Message (Launder)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageLaunderNoV end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageLaunderNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageLaunderNoV,
            },
            {
                -- Stable Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageStable end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageStable = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageStable,
            },
            {
                -- Storage Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageStorage end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageStorage = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageStorage,
            },
            {
                -- Wayshrine Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageWayshrine end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageWayshrine = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageWayshrine,
            },
            {
                -- Unstuck Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageUnstuck end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageUnstuck = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageUnstuck,
            },
            {
                -- Attributes Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageAttributes end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageAttributes = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageAttributes,
            },
            {
                -- Champion Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageChampion end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageChampion = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageChampion,
            },
            {
                -- Morphs Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageMorphs end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageMorphs = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageMorphs,
            },
            {
                -- Skills Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageSkills end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageSkills = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageSkills,
            },
            {
                -- Campaign Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CAMPAIGN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CAMPAIGN_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageCampaign end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageCampaign = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageCampaign,
            },
            {
                -- Loot Message (Use)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_USE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_USE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageUse end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageUse = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageUse,
            },
            {
                -- Loot Message (Craft)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CRAFT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CRAFT_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageCraft end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageCraft = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageCraft,
            },
            {
                -- Loot Message (Extract)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EXTRACT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EXTRACT_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageExtract end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageExtract = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageExtract,
            },
            {
                -- Loot Message (Upgrade)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageUpgrade end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageUpgrade = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageUpgrade,
            },
            {
                -- Loot Message (Upgrade)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE_FAIL),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE_FAIL_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageUpgradeFail end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageUpgradeFail = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageUpgradeFail,
            },
            {
                -- Loot Message (Refine)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REFINE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REFINE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageRefine end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageRefine = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageRefine,
            },
            {
                -- Loot Message (Deconstruct)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DECONSTRUCT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DECONSTRUCT_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageDeconstruct end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageDeconstruct = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageDeconstruct,
            },
            {
                -- Loot Message (Research)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RESEARCH),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RESEARCH_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageResearch end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageResearch = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageResearch,
            },
            {
                -- Loot Message (Destroy)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DESTROY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DESTROY_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageDestroy end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageDestroy = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageDestroy,
            },
            {
                -- Loot Message (Lockpick)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOCKPICK),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOCKPICK_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageLockpick end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageLockpick = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageLockpick,
            },
            {
                -- Loot Message Removed (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REMOVE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REMOVE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageRemove end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageRemove = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageRemove,
            },

            {
                -- Loot Message Turn In (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TURNIN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TURNIN_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageQuestTurnIn end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageQuestTurnIn = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageQuestTurnIn,
            },
            {
                -- Loot Message Use (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_QUESTUSE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_QUESTUSE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageQuestUse end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageQuestUse = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageQuestUse,
            },
            {
                -- Loot Message Exhaust (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EXHAUST),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EXHAUST_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageQuestExhaust end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageQuestExhaust = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageQuestExhaust,
            },
            {
                -- Loot Message Offer (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_OFFER),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_OFFER_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageQuestOffer end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageQuestOffer = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageQuestOffer,
            },
            {
                -- Loot Message Discard (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISCARD),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISCARD_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageQuestDiscard end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageQuestDiscard = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageQuestDiscard,
            },
            {
                -- Loot Message Discard (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_QUESTCONFISCATE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_QUESTCONFISCATE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageQuestConfiscate end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageQuestConfiscate = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageQuestConfiscate,
            },
            {
                -- Loot Message Combine (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_COMBINE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_COMBINE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageQuestCombine end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageQuestCombine = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageQuestCombine,
            },
            {
                -- Loot Message Mix (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MIX),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MIX_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageQuestMix end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageQuestMix = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageQuestMix,
            },
            {
                -- Loot Message Bundle (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUNDLE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUNDLE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageQuestBundle end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageQuestBundle = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageQuestBundle,
            },




            {
                -- Loot Message Group
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_GROUP),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_GROUP_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageGroup end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageGroup = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageGroup,
            },
            {
                -- Loot Message (Disguise Equip)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_EQUIP),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_EQUIP_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageDisguiseEquip end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageDisguiseEquip = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageDisguiseEquip,
            },
            {
                -- Loot Message (Disguise Remove)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_REMOVE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_REMOVE_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageDisguiseRemove end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageDisguiseRemove = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageDisguiseRemove,
            },
            {
                -- Loot Message (Disguise Destroy)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_DESTROY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_DESTROY_TP),
                getFunc = function() return Settings.ContextMessages.CurrencyMessageDisguiseDestroy end,
                setFunc = function(value) Settings.ContextMessages.CurrencyMessageDisguiseDestroy = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.ContextMessages.CurrencyMessageDisguiseDestroy,
            },
        },
    }

    -- Chat Announcements - Experience Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_EXP_HEADER),
        controls = {
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_ENLIGHTENED),
                width = "full",
            },
            {
                -- Enlightenment (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.XP.ExperienceEnlightenedCA end,
                setFunc = function(value) Settings.XP.ExperienceEnlightenedCA = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.XP.ExperienceEnlightenedCA,
            },
            {
                -- Enlightenment (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.XP.ExperienceEnlightenedCSA end,
                setFunc = function(value) Settings.XP.ExperienceEnlightenedCSA = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.XP.ExperienceEnlightenedCSA,
            },
            {
                -- Enlightenment (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.XP.ExperienceEnlightenedAlert end,
                setFunc = function(value) Settings.XP.ExperienceEnlightenedAlert = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.XP.ExperienceEnlightenedAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_LEVELUP),
                width = "full",
            },
            {
                -- Level Up (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.XP.ExperienceLevelUpCA end,
                setFunc = function(value) Settings.XP.ExperienceLevelUpCA = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.XP.ExperienceLevelUpCA,
            },
            {
                -- Level Up (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.XP.ExperienceLevelUpCSA end,
                setFunc = function(value) Settings.XP.ExperienceLevelUpCSA = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.XP.ExperienceLevelUpCSA,
            },
            {
                -- Level Up CSA Expanded
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_CSAEXPAND)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_CSAEXPAND_TP),
                getFunc = function() return Settings.XP.ExperienceLevelUpCSAExpand end,
                setFunc = function(value) Settings.XP.ExperienceLevelUpCSAExpand = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not (Settings.XP.ExperienceLevelUpCSA and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.XP.ExperienceLevelUpCSAExpand,
            },
            {
                -- Level Up (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.XP.ExperienceLevelUpAlert end,
                setFunc = function(value) Settings.XP.ExperienceLevelUpAlert = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.XP.ExperienceLevelUpAlert,
            },
            {
                -- Show Level Icon on Level Up
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_LVLUPICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_LVLUPICON_TP),
                getFunc = function() return Settings.XP.ExperienceLevelUpIcon end,
                setFunc = function(value) Settings.XP.ExperienceLevelUpIcon = value end,
                width = "full",
                disabled = function() return not (Settings.XP.ExperienceLevelUpCA or Settings.XP.ExperienceLevelUpCSA or Settings.XP.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.XP.ExperienceExperienceLevelUpIcon,
            },
            {
                -- Experience Level Up Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_LEVELUP_COLOR)),
                getFunc = function() return unpack(Settings.XP.ExperienceLevelUpColor) end,
                setFunc = function(r, g, b, a) Settings.XP.ExperienceLevelUpColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.XP.ExperienceLevelUpCA or Settings.XP.ExperienceLevelUpCSA or Settings.XP.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.XP.ExperienceLevelUpColor[1], g=Defaults.XP.ExperienceLevelUpColor[2], b=Defaults.XP.ExperienceLevelUpColor[3]}
            },
            {
                -- Color Level by Context
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT_TP),
                getFunc = function() return Settings.XP.ExperienceLevelColorByLevel end,
                setFunc = function(value) Settings.XP.ExperienceLevelColorByLevel = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not (Settings.XP.ExperienceLevelUpCA or Settings.XP.ExperienceLevelUpCSA or Settings.XP.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.XP.ExperienceLevelColorByLevel,
            },
            {
                -- Experience Points Header
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_EXPERIENCEGAIN),
                width = "full",
            },
            {
                -- Show Experience Gain
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPGAIN),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPGAIN_TP),
                getFunc = function() return Settings.XP.Experience end,
                setFunc = function(value) Settings.XP.Experience = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.XP.Experience,
            },
            {
                -- Show Experience Icon
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPICON_TP),
                getFunc = function() return Settings.XP.ExperienceIcon end,
                setFunc = function(value) Settings.XP.ExperienceIcon = value end,
                width = "full",
                disabled = function() return not (Settings.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.XP.ExperienceIcon,
            },
            {
                -- Experience Message Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_COLORMESSAGE)),
                getFunc = function() return unpack(Settings.XP.ExperienceColorMessage) end,
                setFunc = function(r, g, b, a) Settings.XP.ExperienceColorMessage = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.XP.ExperienceColorMessage[1], g=Defaults.XP.ExperienceColorMessage[2], b=Defaults.XP.ExperienceColorMessage[3]}
            },
            {
                -- Experience Name Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_COLORNAME)),
                getFunc = function() return unpack(Settings.XP.ExperienceColorName) end,
                setFunc = function(r, g, b, a) Settings.XP.ExperienceColorName = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.XP.ExperienceColorName[1], g=Defaults.XP.ExperienceColorName[2], b=Defaults.XP.ExperienceColorName[3]}
            },
            {
                -- Context Name for Experience Gain
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_MESSAGE)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_MESSAGE_TP),
                getFunc = function() return Settings.XP.ExperienceMessage end,
                setFunc = function(value) Settings.XP.ExperienceMessage = value end,
                width = "full",
                disabled = function() return not (Settings.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.XP.ExperienceMessage,
            },
            {
                -- Name for Experience Gain
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_NAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_NAME_TP),
                getFunc = function() return Settings.XP.ExperienceName end,
                setFunc = function(value) Settings.XP.ExperienceName = value end,
                width = "full",
                disabled = function() return not (Settings.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.XP.ExperienceName,
            },
            {
                -- Hide Experience from Kills
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS_TP),
                getFunc = function() return Settings.XP.ExperienceHideCombat end,
                setFunc = function(value) Settings.XP.ExperienceHideCombat = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not (Settings.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.XP.ExperienceHideCombat,
            },
            {
                -- Combat Experience Gain Filter Threshold
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD_TP),
                getFunc = function() return Settings.XP.ExperienceFilter end,
                setFunc = function(value) Settings.XP.ExperienceFilter = value end,
                min = 0,
                max = 10000,
                step = 100,
                width = "full",
                disabled = function() return not (Settings.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.XP.ExperienceFilter,
            },
            {
                -- Throttle Experience gained in combat
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT_TP),
                getFunc = function() return Settings.XP.ExperienceThrottle end,
                setFunc = function(value) Settings.XP.ExperienceThrottle = value end,
                min = 0,
                max = 5000,
                step = 50,
                width = "full",
                disabled = function() return not (Settings.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.XP.ExperienceThrottle,
            },
            {
                -- Skill Points Header
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_SKILL_POINTS),
                width = "full",
            },
            {
                -- Show Skill Points Updated ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Skills.SkillPointCA end,
                setFunc = function(value) Settings.Skills.SkillPointCA = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillPointCA,
            },
            {
                -- Show Skill Points Updated CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Skills.SkillPointCSA end,
                setFunc = function(value) Settings.Skills.SkillPointCSA = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillPointCSA,
            },
            {
                -- Show Skill Points Updated Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Skills.SkillPointAlert end,
                setFunc = function(value) Settings.Skills.SkillPointAlert = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillPointAlert,
            },
            {
                -- Skill Point Color 1
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_COLOR1)),
                getFunc = function() return unpack(Settings.Skills.SkillPointColor1) end,
                setFunc = function(r, g, b, a) Settings.Skills.SkillPointColor1 = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not ( Settings.Skills.SkillPointCA or Settings.Skills.SkillPointCSA or Settings.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Skills.SkillPointColor1[1], g=Defaults.Skills.SkillPointColor1[2], b=Defaults.Skills.SkillPointColor1[3]}
            },
            {
                -- Skill Point Color 2
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_COLOR2)),
                getFunc = function() return unpack(Settings.Skills.SkillPointColor2) end,
                setFunc = function(r, g, b, a) Settings.Skills.SkillPointColor2 = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not ( Settings.Skills.SkillPointCA or Settings.Skills.SkillPointCSA or Settings.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Skills.SkillPointColor2[1], g=Defaults.Skills.SkillPointColor2[2], b=Defaults.Skills.SkillPointColor2[3]}
            },
            {
                -- Skyshard Prefix
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALPREFIX)),
                tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALPREFIX_TP),
                getFunc = function() return Settings.Skills.SkillPointSkyshard end,
                setFunc = function(value) Settings.Skills.SkillPointSkyshard = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not ( Settings.Skills.SkillPointCA or Settings.Skills.SkillPointCSA or Settings.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Skills.SkillPointSkyshard,
            },
            {
                -- Skyshard Brackets
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALBRACKET)),
                tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALBRACKET_TP),
                choices = bracketOptions5,
                getFunc = function() return bracketOptions5[Settings.Skills.SkillPointBracket] end,
                setFunc = function(value) Settings.Skills.SkillPointBracket = bracketOptions5Keys[value] end,
                width = "full",
                disabled = function() return not ( Settings.Skills.SkillPointCA or Settings.Skills.SkillPointCSA or Settings.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Skills.SkillPointBracket
            },
            {
                -- Show Skill Points Updated Partial
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATEDPARTIAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATEDPARTIAL_TP),
                getFunc = function() return Settings.Skills.SkillPointsPartial end,
                setFunc = function(value) Settings.Skills.SkillPointsPartial = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not ( Settings.Skills.SkillPointCA or Settings.Skills.SkillPointCSA or Settings.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Skills.SkillPointsPartial,
            },
            {
                -- Skill Lines Header
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_SKILL_LINES),
                width = "full",
            },
            {
                -- Skill Line Unlocked ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Skills.SkillLineUnlockCA end,
                setFunc = function(value) Settings.Skills.SkillLineUnlockCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillLineUnlockCA,
            },
            {
                -- Skill Line Unlocked CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Skills.SkillLineUnlockCSA end,
                setFunc = function(value) Settings.Skills.SkillLineUnlockCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillLineUnlockCSA,
            },
            {
                -- Skill Line Unlocked Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Skills.SkillLineUnlockAlert end,
                setFunc = function(value) Settings.Skills.SkillLineUnlockAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillLineUnlockAlert,
            },
            {
                -- Skill Line Icon
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILL_LINE_ICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_SKILL_LINE_ICON_TP),
                getFunc = function() return Settings.Skills.SkillLineIcon end,
                setFunc = function(value) Settings.Skills.SkillLineIcon = value end,
                width = "full",
                disabled = function() return not (
                    Settings.Skills.SkillLineUnlockCA or
                    Settings.Skills.SkillLineUnlockCSA or
                    Settings.Skills.SkillLineUnlockAlert and
                    LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Skills.SkillLineIcon,
            },
            {
                -- Skill Line Progression ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Skills.SkillLineCA end,
                setFunc = function(value) Settings.Skills.SkillLineCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillLineCA,
            },
            {
                -- Skill Line Progression CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Skills.SkillLineCSA end,
                setFunc = function(value) Settings.Skills.SkillLineCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillLineCSA,
            },
            {
                -- Skill Line Progression Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Skills.SkillLineAlert end,
                setFunc = function(value) Settings.Skills.SkillLineAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillLineAlert,
            },
            {
                -- Skill Ability Progression ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Skills.SkillAbilityCA end,
                setFunc = function(value) Settings.Skills.SkillAbilityCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillAbilityCA,
            },
            {
                -- Skill Ability Progression CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Skills.SkillAbilityCSA end,
                setFunc = function(value) Settings.Skills.SkillAbilityCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillAbilityCSA,
            },
            {
                -- Skill Ability Progression Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Skills.SkillAbilityAlert end,
                setFunc = function(value) Settings.Skills.SkillAbilityAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillAbilityAlert,
            },
            {
                -- Skill Line Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILL_LINE_COLOR)),
                getFunc = function() return unpack(Settings.Skills.SkillLineColor) end,
                setFunc = function(r, g, b, a) Settings.Skills.SkillLineColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (
                    Settings.Skills.SkillLineUnlockCA or
                    Settings.Skills.SkillLineUnlockCSA or
                    Settings.Skills.SkillLineUnlockAlert or
                    Settings.Skills.SkillLineAlertCA or
                    Settings.Skills.SkillLineAlertCSA or
                    Settings.Skills.SkillLineAlertAlert or
                    Settings.Skills.SkillAbilityCA or
                    Settings.Skills.SkillAbilityCSA or
                    Settings.Skills.SkillAbilityAlert and
                    LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Skills.SkillLineColor[1], g=Defaults.Skills.SkillLineColor[2], b=Defaults.Skills.SkillLineColor[3]}
            },
            {
                -- Guild Reputation Header
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_GUILDREP),
                width = "full",
            },
            {
                -- Display Guild Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_ICON),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_ICON_TP),
                getFunc = function() return Settings.Skills.SkillGuildIcon end,
                setFunc = function(value) Settings.Skills.SkillGuildIcon = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillGuildIcon,
            },
            {
                -- Guild Reputation Message Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGECOLOR),
                getFunc = function() return unpack(Settings.Skills.SkillGuildColor) end,
                setFunc = function(r, g, b, a) Settings.Skills.SkillGuildColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = {r=Defaults.Skills.SkillGuildColor[1], g=Defaults.Skills.SkillGuildColor[2], b=Defaults.Skills.SkillGuildColor[3]}
            },
            {
                -- Guild Reputation Message Format
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGEFORMAT),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGEFORMAT_TP),
                getFunc = function() return Settings.Skills.SkillGuildMsg end,
                setFunc = function(value) Settings.Skills.SkillGuildMsg = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillGuildMsg,
            },
            {
                -- Guild Reputation Points Name
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGENAME),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGENAME_TP),
                getFunc = function() return Settings.Skills.SkillGuildRepName end,
                setFunc = function(value) Settings.Skills.SkillGuildRepName = value ChatAnnouncements.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillGuildRepName,
            },
            {
                -- Skill Fighters Guild
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_FG),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_FG_TP),
                getFunc = function() return Settings.Skills.SkillGuildFighters end,
                setFunc = function(value) Settings.Skills.SkillGuildFighters = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillGuildFighters,
            },
            {
                -- Guild Skill Point Color FG
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_FG_COLOR)),
                getFunc = function() return unpack(Settings.Skills.SkillGuildColorFG) end,
                setFunc = function(r, g, b, a) Settings.Skills.SkillGuildColorFG = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Skills.SkillGuildFighters) end,
                default = {r=Defaults.Skills.SkillGuildColorFG[1], g=Defaults.Skills.SkillGuildColorFG[2], b=Defaults.Skills.SkillGuildColorFG[3]}
            },
            {
                -- Fighter's Guild Threshold
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_THRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_THRESHOLD_TP),
                getFunc = function() return Settings.Skills.SkillGuildThreshold end,
                setFunc = function(value) Settings.Skills.SkillGuildThreshold = value end,
                min = 0,
                max = 5,
                step = 1,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Skills.SkillGuildFighters) end,
                default = Defaults.Skills.SkillGuildThreshold,
            },
            {
                -- Fighter's Guild Throttle
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_THROTTLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_THROTTLE_TP),
                getFunc = function() return Settings.Skills.SkillGuildThrottle end,
                setFunc = function(value) Settings.Skills.SkillGuildThrottle = value end,
                min = 0,
                max = 5000,
                step = 50,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Skills.SkillGuildFighters) end,
                default = Defaults.Skills.SkillGuildThrottle,
            },
            {
                -- Skill Mages Guild
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_MG),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MG_TP),
                getFunc = function() return Settings.Skills.SkillGuildMages end,
                setFunc = function(value) Settings.Skills.SkillGuildMages = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillGuildMages,
            },
            {
                -- Guild Skill Point Color MG
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_MG_COLOR)),
                getFunc = function() return unpack(Settings.Skills.SkillGuildColorMG) end,
                setFunc = function(r, g, b, a) Settings.Skills.SkillGuildColorMG = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Skills.SkillGuildMages) end,
                default = {r=Defaults.Skills.SkillGuildColorMG[1], g=Defaults.Skills.SkillGuildColorMG[2], b=Defaults.Skills.SkillGuildColorMG[3]}
            },
            {
                -- Skill Undaunted
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_UD),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_UD_TP),
                getFunc = function() return Settings.Skills.SkillGuildUndaunted end,
                setFunc = function(value) Settings.Skills.SkillGuildUndaunted = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillGuildUndaunted,
            },
            {
                -- Guild Skill Point Color UD
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_UD_COLOR)),
                getFunc = function() return unpack(Settings.Skills.SkillGuildColorUD) end,
                setFunc = function(r, g, b, a) Settings.Skills.SkillGuildColorUD = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Skills.SkillGuildUndaunted) end,
                default = {r=Defaults.Skills.SkillGuildColorUD[1], g=Defaults.Skills.SkillGuildColorUD[2], b=Defaults.Skills.SkillGuildColorUD[3]}
            },
            {
                -- Skill Thieves Guild
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_TG),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_TG_TP),
                getFunc = function() return Settings.Skills.SkillGuildThieves end,
                setFunc = function(value) Settings.Skills.SkillGuildThieves = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillGuildThieves,
            },
            {
                -- Guild Skill Point Color TG
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_TG_COLOR)),
                getFunc = function() return unpack(Settings.Skills.SkillGuildColorTG) end,
                setFunc = function(r, g, b, a) Settings.Skills.SkillGuildColorTG = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Skills.SkillGuildThieves) end,
                default = {r=Defaults.Skills.SkillGuildColorTG[1], g=Defaults.Skills.SkillGuildColorTG[2], b=Defaults.Skills.SkillGuildColorTG[3]}
            },
            {
                -- Skill Dark Brotherhood
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_DB),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_DB_TP),
                getFunc = function() return Settings.Skills.SkillGuildDarkBrotherhood end,
                setFunc = function(value) Settings.Skills.SkillGuildDarkBrotherhood = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillGuildDarkBrotherhood,
            },
            {
                -- Guild Skill Point Color DB
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_DB_COLOR)),
                getFunc = function() return unpack(Settings.Skills.SkillGuildColorDB) end,
                setFunc = function(r, g, b, a) Settings.Skills.SkillGuildColorDB = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Skills.SkillGuildDarkBrotherhood) end,
                default = {r=Defaults.Skills.SkillGuildColorDB[1], g=Defaults.Skills.SkillGuildColorDB[2], b=Defaults.Skills.SkillGuildColorDB[3]}
            },
            {
                -- Skill Psijic Order
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_PO),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_PO_TP),
                getFunc = function() return Settings.Skills.SkillGuildPsijicOrder end,
                setFunc = function(value) Settings.Skills.SkillGuildPsijicOrder = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillGuildPsijicOrder,
            },
            {
                -- Guild Skill Point Color PO
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_PO_COLOR)),
                getFunc = function() return unpack(Settings.Skills.SkillGuildColorPO) end,
                setFunc = function(r, g, b, a) Settings.Skills.SkillGuildColorPO = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and Settings.Skills.SkillGuildDarkBrotherhood) end,
                default = {r=Defaults.Skills.SkillGuildColorPO[1], g=Defaults.Skills.SkillGuildColorPO[2], b=Defaults.Skills.SkillGuildColorPO[3]}
            },
            {
                -- Skill Guild Alert
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_ALERT),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_ALERT_TP),
                getFunc = function() return Settings.Skills.SkillGuildAlert end,
                setFunc = function(value) Settings.Skills.SkillGuildAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Skills.SkillGuildAlert,
            },
        },
    }

    -- Chat Announcements - Collectible/Lorebooks Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_HEADER),
        controls = {
            {
                --
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COL_HEADER),
                width = "full",
            },
            {
                -- Show Collectibles Unlocked ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Collectibles.CollectibleCA end,
                setFunc = function(value) Settings.Collectibles.CollectibleCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Collectibles.CollectibleCA,
            },
            {
                -- Show Collectibles Unlocked CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Collectibles.CollectibleCSA end,
                setFunc = function(value) Settings.Collectibles.CollectibleCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Collectibles.CollectibleCSA,
            },
            {
                -- Show Collectibles Unlocked Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Collectibles.CollectibleAlert end,
                setFunc = function(value) Settings.Collectibles.CollectibleAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Collectibles.CollectibleAlert,
            },
            {
                -- Collectible Icon
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ICON_TP),
                getFunc = function() return Settings.Collectibles.CollectibleIcon end,
                setFunc = function(value) Settings.Collectibles.CollectibleIcon = value end,
                width = "full",
                disabled = function() return not (Settings.Collectibles.CollectibleCA or Settings.Collectibles.CollectibleCSA or Settings.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Collectibles.CollectibleIcon,
            },
            {
                -- Collectible Bracket
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[Settings.BracketOptionCollectible] end,
                setFunc = function(value) Settings.BracketOptionCollectible = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not (Settings.Collectibles.CollectibleCA or Settings.Collectibles.CollectibleCSA or Settings.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.BracketOptionCollectible,
            },
            {
                -- Collectible Color 1
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COLOR_ONE)),
                getFunc = function() return unpack(Settings.Collectibles.CollectibleColor1) end,
                setFunc = function(r, g, b, a) Settings.Collectibles.CollectibleColor1 = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Collectibles.CollectibleCA or Settings.Collectibles.CollectibleCSA or Settings.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Collectibles.CollectibleColor1[1], g=Defaults.Collectibles.CollectibleColor1[2], b=Defaults.Collectibles.CollectibleColor1[3]}
            },
            {
                -- Collectible Color 2
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COLOR_TWO)),
                getFunc = function() return unpack(Settings.Collectibles.CollectibleColor2) end,
                setFunc = function(r, g, b, a) Settings.Collectibles.CollectibleColor2 = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Collectibles.CollectibleCA or Settings.Collectibles.CollectibleCSA or Settings.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Collectibles.CollectibleColor2[1], g=Defaults.Collectibles.CollectibleColor2[2], b=Defaults.Collectibles.CollectibleColor2[3]}
            },
            {
                -- Collectible Message Prefix
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_MESSAGEPREFIX)),
                tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_MESSAGEPREFIX_TP),
                getFunc = function() return Settings.Collectibles.CollectiblePrefix end,
                setFunc = function(value) Settings.Collectibles.CollectiblePrefix = value end,
                width = "full",
                disabled = function() return not (Settings.Collectibles.CollectibleCA or Settings.Collectibles.CollectibleCSA or Settings.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Collectibles.CollectiblePrefix,
            },
            {
                -- Collectible Bracket Options
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_BRACKET)),
                tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_BRACKET_TP),
                choices = bracketOptions5,
                getFunc = function() return bracketOptions5[Settings.Collectibles.CollectibleBracket] end,
                setFunc = function(value) Settings.Collectibles.CollectibleBracket = bracketOptions5Keys[value] end,
                width = "full",
                disabled = function() return not (Settings.Collectibles.CollectibleCA or Settings.Collectibles.CollectibleCSA or Settings.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Collectibles.CollectibleBracket
            },
            {
                -- Collectible Category
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_CATEGORY)),
                tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_CATEGORY_TP),
                getFunc = function() return Settings.Collectibles.CollectibleCategory end,
                setFunc = function(value) Settings.Collectibles.CollectibleCategory = value end,
                width = "full",
                disabled = function() return not (Settings.Collectibles.CollectibleCA or Settings.Collectibles.CollectibleCSA or Settings.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Collectibles.CollectibleCategory,
            },
            {
                -- Collectible Usage
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_HEADER),
                width = "full",
            },
            {
                -- Collectible Used CA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Collectibles.CollectibleUseCA end,
                setFunc = function(value) Settings.Collectibles.CollectibleUseCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Collectibles.CollectibleUseCA,
            },
            {
                -- Collectible Used Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Collectibles.CollectibleUseAlert end,
                setFunc = function(value) Settings.Collectibles.CollectibleUseAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Collectibles.CollectibleUseAlert,
            },
            {
                -- Collectible Pet Nickname
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_PET_NICKNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_PET_NICKNAME_TP),
                getFunc = function() return Settings.Collectibles.CollectibleUsePetNickname end,
                setFunc = function(value) Settings.Collectibles.CollectibleUsePetNickname = value end,
                width = "full",
                disabled = function() return not (Settings.Collectibles.CollectibleUseCA or Settings.Collectibles.CollectibleUseAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Collectibles.CollectibleUsePetNickname,
            },
            {
                -- Collectible Icon
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_ICON_TP),
                getFunc = function() return Settings.Collectibles.CollectibleUseIcon end,
                setFunc = function(value) Settings.Collectibles.CollectibleUseIcon = value end,
                width = "full",
                disabled = function() return not (Settings.Collectibles.CollectibleUseCA or Settings.Collectibles.CollectibleUseAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Collectibles.CollectibleUseIcon,
            },
            {
                -- Collectible Bracket
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[Settings.BracketOptionCollectibleUse] end,
                setFunc = function(value) Settings.BracketOptionCollectibleUse = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not (Settings.Collectibles.CollectibleUseCA or Settings.Collectibles.CollectibleUseAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.BracketOptionCollectibleUse,
            },
            {
                -- Collectible Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COLOR_ONE)),
                getFunc = function() return unpack(Settings.Collectibles.CollectibleUseColor) end,
                setFunc = function(r, g, b, a) Settings.Collectibles.CollectibleUseColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Collectibles.CollectibleUseCA or Settings.Collectibles.CollectibleUseAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Collectibles.CollectibleUseColor[1], g=Defaults.Collectibles.CollectibleUseColor[2], b=Defaults.Collectibles.CollectibleUseColor[3]}
            },
            {
                type = "divider",
                width = "full",
            },
            {
                -- Enables collectible tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_CATEGORY), GetCollectibleCategoryInfo(3)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_CATEGORY_TP), GetCollectibleCategoryInfo(3)),
                getFunc = function() return Settings.Collectibles.CollectibleUseCategory3 end,
                setFunc = function(value) Settings.Collectibles.CollectibleUseCategory3 = value end,
                width = "full",
                default = Defaults.Collectibles.CollectibleUseCategory3,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables collectible tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_CATEGORY), GetCollectibleCategoryInfo(7)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_CATEGORY_TP), GetCollectibleCategoryInfo(7)),
                getFunc = function() return Settings.Collectibles.CollectibleUseCategory7 end,
                setFunc = function(value) Settings.Collectibles.CollectibleUseCategory7 = value end,
                width = "full",
                default = Defaults.Collectibles.CollectibleUseCategory7,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            --[[
            {
                -- Enables collectible tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_CATEGORY), GetCollectibleCategoryInfo(8)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_CATEGORY_TP), GetCollectibleCategoryInfo(8)),
                getFunc = function() return Settings.Collectibles.CollectibleUseCategory8 end,
                setFunc = function(value) Settings.Collectibles.CollectibleUseCategory8 = value end,
                width = "full",
                default = Defaults.Collectibles.CollectibleUseCategory8,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            ]]--
            {
                -- Enables collectible tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_CATEGORY), GetCollectibleCategoryInfo(10)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_CATEGORY_TP), GetCollectibleCategoryInfo(10)),
                getFunc = function() return Settings.Collectibles.CollectibleUseCategory10 end,
                setFunc = function(value) Settings.Collectibles.CollectibleUseCategory10 = value end,
                width = "full",
                default = Defaults.Collectibles.CollectibleUseCategory10,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables collectible tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_CATEGORY), GetCollectibleCategoryInfo(12)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_USE_CATEGORY_TP), GetCollectibleCategoryInfo(12)),
                getFunc = function() return Settings.Collectibles.CollectibleUseCategory12 end,
                setFunc = function(value) Settings.Collectibles.CollectibleUseCategory12 = value end,
                width = "full",
                default = Defaults.Collectibles.CollectibleUseCategory12,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_LORE_HEADER),
                width = "full",
            },
            {
                -- Lorebook Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_LOREBOOK),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_LOREBOOK_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[Settings.BracketOptionLorebook] end,
                setFunc = function(value) Settings.BracketOptionLorebook = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.BracketOptionLorebook,
            },
            {
                -- Show Lorebooks (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Lorebooks.LorebookCA end,
                setFunc = function(value) Settings.Lorebooks.LorebookCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Lorebooks.LorebookCA,
            },
            {
                -- Show Lorebooks (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Lorebooks.LorebookCSA end,
                setFunc = function(value) Settings.Lorebooks.LorebookCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Lorebooks.LorebookCSA,
            },
            {
                -- Show Lorebooks (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Lorebooks.LorebookAlert end,
                setFunc = function(value) Settings.Lorebooks.LorebookAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Lorebooks.LorebookAlert,
            },
            {
                -- Show Lorebook Collection Complete (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Lorebooks.LorebookCollectionCA end,
                setFunc = function(value) Settings.Lorebooks.LorebookCollectionCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Lorebooks.LorebookCollectionCA,
            },
            {
                -- Show Lorebook Collection Complete (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Lorebooks.LorebookCollectionCSA end,
                setFunc = function(value) Settings.Lorebooks.LorebookCollectionCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Lorebooks.LorebookCollectionCSA,
            },
            {
                -- Show Lorebook Collection Complete (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Lorebooks.LorebookCollectionAlert end,
                setFunc = function(value) Settings.Lorebooks.LorebookCollectionAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Lorebooks.LorebookCollectionAlert,
            },
            {
                -- Lorebooks Icon
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_ICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_ICON_TP),
                getFunc = function() return Settings.Lorebooks.LorebookIcon end,
                setFunc = function(value) Settings.Lorebooks.LorebookIcon = value end,
                width = "full",
                disabled = function() return not (
                Settings.Lorebooks.LorebookCA or
                Settings.Lorebooks.LorebookCSA or
                Settings.Lorebooks.LorebookAlert or
                Settings.Lorebooks.LorebookCollectionCA or
                Settings.Lorebooks.LorebookCollectionCSA or
                Settings.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Lorebooks.LorebookIcon,
            },
            {
                -- Lorebooks Color 1
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOREBOOK_COLOR1)),
                getFunc = function() return unpack(Settings.Lorebooks.LorebookColor1) end,
                setFunc = function(r, g, b, a) Settings.Lorebooks.LorebookColor1 = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (
                Settings.Lorebooks.LorebookCA or
                Settings.Lorebooks.LorebookCSA or
                Settings.Lorebooks.LorebookAlert or
                Settings.Lorebooks.LorebookCollectionCA or
                Settings.Lorebooks.LorebookCollectionCSA or
                Settings.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Lorebooks.LorebookColor1[1], g=Defaults.Lorebooks.LorebookColor1[2], b=Defaults.Lorebooks.LorebookColor1[3]}
            },
            {
                -- Lorebooks Color 2
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOREBOOK_COLOR2)),
                getFunc = function() return unpack(Settings.Lorebooks.LorebookColor2) end,
                setFunc = function(r, g, b, a) Settings.Lorebooks.LorebookColor2 = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (
                Settings.Lorebooks.LorebookCA or
                Settings.Lorebooks.LorebookCSA or
                Settings.Lorebooks.LorebookAlert or
                Settings.Lorebooks.LorebookCollectionCA or
                Settings.Lorebooks.LorebookCollectionCSA or
                Settings.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Lorebooks.LorebookColor2[1], g=Defaults.Lorebooks.LorebookColor2[2], b=Defaults.Lorebooks.LorebookColor2[3]}
            },
            {
                -- Lorebooks Prefix 1
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX1)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX1_TP),
                getFunc = function() return Settings.Lorebooks.LorebookPrefix1 end,
                setFunc = function(value) Settings.Lorebooks.LorebookPrefix1 = value end,
                width = "full",
                disabled = function() return not (
                Settings.Lorebooks.LorebookCA or
                Settings.Lorebooks.LorebookCSA or
                Settings.Lorebooks.LorebookAlert or
                Settings.Lorebooks.LorebookCollectionCA or
                Settings.Lorebooks.LorebookCollectionCSA or
                Settings.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Lorebooks.LorebookPrefix1,
            },
            {
                -- Lorebooks Prefix 2
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX2)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX2_TP),
                getFunc = function() return Settings.Lorebooks.LorebookPrefix2 end,
                setFunc = function(value) Settings.Lorebooks.LorebookPrefix2 = value end,
                width = "full",
                disabled = function() return not (
                Settings.Lorebooks.LorebookCA or
                Settings.Lorebooks.LorebookCSA or
                Settings.Lorebooks.LorebookAlert or
                Settings.Lorebooks.LorebookCollectionCA or
                Settings.Lorebooks.LorebookCollectionCSA or
                Settings.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Lorebooks.LorebookPrefix2,
            },
            {
                -- Lorebooks Collection Prefix
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX_COLLECTION)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX_COLLECTION_TP),
                getFunc = function() return Settings.Lorebooks.LorebookCollectionPrefix end,
                setFunc = function(value) Settings.Lorebooks.LorebookCollectionPrefix = value end,
                width = "full",
                disabled = function() return not (
                Settings.Lorebooks.LorebookCA or
                Settings.Lorebooks.LorebookCSA or
                Settings.Lorebooks.LorebookAlert or
                Settings.Lorebooks.LorebookCollectionCA or
                Settings.Lorebooks.LorebookCollectionCSA or
                Settings.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Lorebooks.LorebookCollectionPrefix,
            },
            {
                -- Lorebooks Bracket Options
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_BRACKET)),
                choices = bracketOptions5,
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_BRACKET_TP),
                getFunc = function() return bracketOptions5[Settings.Lorebooks.LorebookBracket] end,
                setFunc = function(value) Settings.Lorebooks.LorebookBracket = bracketOptions5Keys[value] end,
                width = "full",
                disabled = function() return not (
                Settings.Lorebooks.LorebookCA or
                Settings.Lorebooks.LorebookCSA or
                Settings.Lorebooks.LorebookAlert or
                Settings.Lorebooks.LorebookCollectionCA or
                Settings.Lorebooks.LorebookCollectionCSA or
                Settings.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Lorebooks.LorebookBracket
            },
            {
                -- Lorebooks Category
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_TP),
                getFunc = function() return Settings.Lorebooks.LorebookCategory end,
                setFunc = function(value) Settings.Lorebooks.LorebookCategory = value end,
                width = "full",
                disabled = function() return not (
                Settings.Lorebooks.LorebookCA or
                Settings.Lorebooks.LorebookCSA or
                Settings.Lorebooks.LorebookAlert or
                Settings.Lorebooks.LorebookCollectionCA or
                Settings.Lorebooks.LorebookCollectionCSA or
                Settings.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Lorebooks.LorebookCategory,
            },
            {
                -- Show hidden books
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_NOSHOWHIDE)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_NOSHOWHIDE_TP),
                getFunc = function() return Settings.Lorebooks.LorebookShowHidden end,
                setFunc = function(value) Settings.Lorebooks.LorebookShowHidden = value end,
                width = "full",
                disabled = function() return not (
                Settings.Lorebooks.LorebookCA or
                Settings.Lorebooks.LorebookCSA or
                Settings.Lorebooks.LorebookAlert or
                Settings.Lorebooks.LorebookCollectionCA or
                Settings.Lorebooks.LorebookCollectionCSA or
                Settings.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Lorebooks.LorebookShowHidden,
            },
        },
    }

    -- Chat Announcements - Achievements Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_HEADER),
        controls = {
            {
                -- Show Achievement Update ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Achievement.AchievementUpdateCA end,
                setFunc = function(value) Settings.Achievement.AchievementUpdateCA = value ChatAnnouncements.RegisterAchievementsEvent() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Achievement.AchievementUpdateCA,
            },
            {
                -- Show Achievement Update Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Achievement.AchievementUpdateAlert end,
                setFunc = function(value) Settings.Achievement.AchievementUpdateAlert = value ChatAnnouncements.RegisterAchievementsEvent() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Achievement.AchievementUpdateAlert,
            },
            {
                -- Show Detailed Achievement Info
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO)),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO_TP),
                getFunc = function() return Settings.Achievement.AchievementDetails end,
                setFunc = function(value) Settings.Achievement.AchievementDetails = value end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Achievement.AchievementDetails,
            },
            {
                -- Achievements Step Size
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE)),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE_TP),
                min = 0, max = 50, step = 1,
                getFunc = function() return Settings.Achievement.AchievementStep end,
                setFunc = function(value) Settings.Achievement.AchievementStep = value end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Achievement.AchievementStep,
            },
            {
                -- Enable Achievement Complete ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Achievement.AchievementCompleteCA end,
                setFunc = function(value) Settings.Achievement.AchievementCompleteCA = value ChatAnnouncements.RegisterAchievementsEvent() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Achievement.AchievementCompleteCA,
            },
            {
                -- Enable Achievement Complete CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Achievement.AchievementCompleteCSA end,
                setFunc = function(value) Settings.Achievement.AchievementCompleteCSA = value ChatAnnouncements.RegisterAchievementsEvent() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Achievement.AchievementCompleteCSA,
            },
            {
                -- Enable Achievement Complete Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Achievement.AchievementCompleteAlert end,
                setFunc = function(value) Settings.Achievement.AchievementCompleteAlert = value ChatAnnouncements.RegisterAchievementsEvent() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Achievement.AchievementCompleteAlert,
            },
            {
                -- Show 100% Completion on complete event
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEPERCENT)),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEPERCENT_TP),
                getFunc = function() return Settings.Achievement.AchievementCompPercentage end,
                setFunc = function(value) Settings.Achievement.AchievementCompPercentage = value end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Achievement.AchievementCompPercentage,
            },
            {
                -- Show Achievement Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_ICON),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_ICON_TP),
                getFunc = function() return Settings.Achievement.AchievementIcon end,
                setFunc = function(value) Settings.Achievement.AchievementIcon = value end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert or Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Achievement.AchievementIcon,
            },
            {
                -- Achievement Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ACHIEVEMENT),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ACHIEVEMENT_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[Settings.BracketOptionAchievement] end,
                setFunc = function(value) Settings.BracketOptionAchievement = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert or Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.BracketOptionAchievement,
            },
            {
                -- Achievement Message Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLOR1),
                getFunc = function() return unpack(Settings.Achievement.AchievementColor1) end,
                setFunc = function(r, g, b, a) Settings.Achievement.AchievementColor1 = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert or Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Achievement.AchievementColor1[1], g=Defaults.Achievement.AchievementColor1[2], b=Defaults.Achievement.AchievementColor1[3]}
            },
            {
                -- Achievement Message Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLOR2),
                getFunc = function() return unpack(Settings.Achievement.AchievementColor2) end,
                setFunc = function(r, g, b, a) Settings.Achievement.AchievementColor2 = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert or Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Achievement.AchievementColor2[1], g=Defaults.Achievement.AchievementColor2[2], b=Defaults.Achievement.AchievementColor2[3]}
            },
            {
                -- Context Name for Achievement Progress
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_PROGMSG),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_PROGMSG_TP),
                getFunc = function() return Settings.Achievement.AchievementProgressMsg end,
                setFunc = function(value) Settings.Achievement.AchievementProgressMsg = value end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert or Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Achievement.AchievementProgressMsg,
            },
            {
                -- Context Name for Achievement Completion
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEMSG),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEMSG_TP),
                getFunc = function() return Settings.Achievement.AchievementCompleteMsg end,
                setFunc = function(value) Settings.Achievement.AchievementCompleteMsg = value end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert or Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Achievement.AchievementCompleteMsg,
            },
            {
                -- Show Achievement Category
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWCATEGORY),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWCATEGORY_TP),
                getFunc = function() return Settings.Achievement.AchievementCategory end,
                setFunc = function(value) Settings.Achievement.AchievementCategory = value end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert or Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Achievement.AchievementCategory,
            },
            {
                -- Show Achievement Subcategory
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWSUBCATEGORY),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWSUBCATEGORY_TP),
                getFunc = function() return Settings.Achievement.AchievementSubcategory end,
                setFunc = function(value) Settings.Achievement.AchievementSubcategory = value end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert or Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Achievement.AchievementSubcategory,
            },
            {
                -- Prefix Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_BRACKET),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_BRACKET_TP),
                choices = bracketOptions5,
                getFunc = function() return bracketOptions5[Settings.Achievement.AchievementBracketOptions] end,
                setFunc = function(value) Settings.Achievement.AchievementBracketOptions = bracketOptions5Keys[value] end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert or Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Achievement.AchievementBracketOptions
            },
            {
                -- Category & Subcategory Bracket Options
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORYBRACKET),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORYBRACKET_TP),
                choices = bracketOptions4,
                getFunc = function() return bracketOptions4[Settings.Achievement.AchievementCatBracketOptions] end,
                setFunc = function(value) Settings.Achievement.AchievementCatBracketOptions = bracketOptions4Keys[value] end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCategory or Settings.Achievement.AchievementSubcategory) or not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert or Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Achievement.AchievementCatBracketOptions
            },
            {
                -- Color Achievement Progress
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLORPROGRESS),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLORPROGRESS_TP),
                getFunc = function() return Settings.Achievement.AchievementColorProgress end,
                setFunc = function(value) Settings.Achievement.AchievementColorProgress = value end,
                width = "full",
                disabled = function() return not (Settings.Achievement.AchievementCompleteCA or Settings.Achievement.AchievementCompleteCSA or Settings.Achievement.AchievementCompleteAlert or Settings.Achievement.AchievementUpdateCA or Settings.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Achievement.AchievementColorProgress,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_HEADER),
                width = "full",
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(1)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(1)),
                getFunc = function() return Settings.Achievement.AchievementCategory1 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory1 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory1,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(2)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(2)),
                getFunc = function() return Settings.Achievement.AchievementCategory2 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory2 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory2,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(3)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(3)),
                getFunc = function() return Settings.Achievement.AchievementCategory3 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory3 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory3,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(4)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(4)),
                getFunc = function() return Settings.Achievement.AchievementCategory4 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory4 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory4,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(5)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(5)),
                getFunc = function() return Settings.Achievement.AchievementCategory5 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory5 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory5,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(6)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(6)),
                getFunc = function() return Settings.Achievement.AchievementCategory6 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory6 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory6,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(7)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(7)),
                getFunc = function() return Settings.Achievement.AchievementCategory7 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory7 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory7,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(8)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(8)),
                getFunc = function() return Settings.Achievement.AchievementCategory8 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory8 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory8,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(9)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(9)),
                getFunc = function() return Settings.Achievement.AchievementCategory9 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory9 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory9,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(10)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(10)),
                getFunc = function() return Settings.Achievement.AchievementCategory10 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory10 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory10,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(11)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(11)),
                getFunc = function() return Settings.Achievement.AchievementCategory11 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory11 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory11,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(12)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(12)),
                getFunc = function() return Settings.Achievement.AchievementCategory12 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory12 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory12,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(13)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(13)),
                getFunc = function() return Settings.Achievement.AchievementCategory13 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory13 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory13,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(14)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(14)),
                getFunc = function() return Settings.Achievement.AchievementCategory14 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory14 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory14,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(15)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(15)),
                getFunc = function() return Settings.Achievement.AchievementCategory15 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory15 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory15,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(16)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(16)),
                getFunc = function() return Settings.Achievement.AchievementCategory16 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory16 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory16,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(17)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(17)),
                getFunc = function() return Settings.Achievement.AchievementCategory17 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory17 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory17,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(18)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(18)),
                getFunc = function() return Settings.Achievement.AchievementCategory18 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory18 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory18,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(19)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(19)),
                getFunc = function() return Settings.Achievement.AchievementCategory19 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory19 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory19,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(20)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(20)),
                getFunc = function() return Settings.Achievement.AchievementCategory20 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory20 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory20,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(21)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(21)),
                getFunc = function() return Settings.Achievement.AchievementCategory21 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory21 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory21,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(22)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(22)),
                getFunc = function() return Settings.Achievement.AchievementCategory22 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory22 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory22,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(23)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(23)),
                getFunc = function() return Settings.Achievement.AchievementCategory23 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory23 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory23,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(24)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(24)),
                getFunc = function() return Settings.Achievement.AchievementCategory24 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory24 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory24,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(25)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(25)),
                getFunc = function() return Settings.Achievement.AchievementCategory25 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory25 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory25,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(26)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(26)),
                getFunc = function() return Settings.Achievement.AchievementCategory26 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory26 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory26,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(27)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(27)),
                getFunc = function() return Settings.Achievement.AchievementCategory27 end,
                setFunc = function(value) Settings.Achievement.AchievementCategory27 = value end,
                width = "full",
                default = Defaults.Achievement.AchievementCategory27,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
        },
    }

    -- Chat Announcements - Quest Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_QUEST_HEADER),
        controls = {
            {
                -- Show Quest Share ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestShareCA end,
                setFunc = function(value) Settings.Quests.QuestShareCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestShareCA,
            },
            {
                -- Show Quest Share Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestShareAlert end,
                setFunc = function(value) Settings.Quests.QuestShareAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestShareAlert,
            },
            {
                -- Show Location Discovery (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestLocDiscoveryCA end,
                setFunc = function(value) Settings.Quests.QuestLocDiscoveryCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestLocDiscoveryCA,
            },
            {
                -- Show Location Discovery (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Quests.QuestLocDiscoveryCSA end,
                setFunc = function(value) Settings.Quests.QuestLocDiscoveryCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestLocDiscoveryCSA,
            },
            {
                -- Show Location Discovery (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestLocDiscoveryAlert end,
                setFunc = function(value) Settings.Quests.QuestLocDiscoveryAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestLocDiscoveryAlert,
            },
            {
                -- Show Location Objective (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestLocObjectiveCA end,
                setFunc = function(value) Settings.Quests.QuestLocObjectiveCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestLocObjectiveCA,
            },
            {
                -- Show Location Objective (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Quests.QuestLocObjectiveCSA end,
                setFunc = function(value) Settings.Quests.QuestLocObjectiveCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestLocObjectiveCSA,
            },
            {
                -- Show Location Objective (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestLocObjectiveAlert end,
                setFunc = function(value) Settings.Quests.QuestLocObjectiveAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestLocObjectiveAlert,
            },
            {
                -- Show Location Complete (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestLocCompleteCA end,
                setFunc = function(value) Settings.Quests.QuestLocCompleteCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestLocCompleteCA,
            },
            {
                -- Show Location Complete (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Quests.QuestLocCompleteCSA end,
                setFunc = function(value) Settings.Quests.QuestLocCompleteCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestLocCompleteCSA,
            },
            {
                -- Show Location Complete (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestLocCompleteAlert end,
                setFunc = function(value) Settings.Quests.QuestLocCompleteAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestLocCompleteAlert,
            },
            {
                -- Show Quest Accept (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestAcceptCA end,
                setFunc = function(value) Settings.Quests.QuestAcceptCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestAcceptCA,
            },
            {
                -- Show Quest Accept (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Quests.QuestAcceptCSA end,
                setFunc = function(value) Settings.Quests.QuestAcceptCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestAcceptCSA,
            },
            {
                -- Show Quest Accept (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestAcceptAlert end,
                setFunc = function(value) Settings.Quests.QuestAcceptAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestAcceptAlert,
            },
            {
                -- Show Quest Complete (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestCompleteCA end,
                setFunc = function(value) Settings.Quests.QuestCompleteCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestCompleteCA,
            },
            {
                -- Show Quest Complete (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Quests.QuestCompleteCSA end,
                setFunc = function(value) Settings.Quests.QuestCompleteCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestCompleteCSA,
            },
            {
                -- Show Quest Complete (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestCompleteAlert end,
                setFunc = function(value) Settings.Quests.QuestCompleteAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestCompleteAlert,
            },
            {
                -- Show Quest Abandon (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestAbandonCA end,
                setFunc = function(value) Settings.Quests.QuestAbandonCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestAbandonCA,
            },
            {
                -- Show Quest Abandon (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Quests.QuestAbandonCSA end,
                setFunc = function(value) Settings.Quests.QuestAbandonCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestAbandonCSA,
            },
            {
                -- Show Quest Abandon (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestAbandonAlert end,
                setFunc = function(value) Settings.Quests.QuestAbandonAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestAbandonAlert,
            },
            {
                -- Show Quest Failure (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestFailCA end,
                setFunc = function(value) Settings.Quests.QuestFailCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestFailCA,
            },
            {
                -- Show Quest Failure (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Quests.QuestFailCSA end,
                setFunc = function(value) Settings.Quests.QuestFailCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestFailCSA,
            },
            {
                -- Show Quest Failure (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestFailAlert end,
                setFunc = function(value) Settings.Quests.QuestFailAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestFailAlert,
            },
            {
                -- Show Quest Objective Updates (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestObjUpdateCA end,
                setFunc = function(value) Settings.Quests.QuestObjUpdateCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestObjUpdateCA,
            },
            {
                -- Show Quest Objective Updates (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Quests.QuestObjUpdateCSA end,
                setFunc = function(value) Settings.Quests.QuestObjUpdateCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestObjUpdateCSA,
            },
            {
                -- Show Quest Objective Updates (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestObjUpdateAlert end,
                setFunc = function(value) Settings.Quests.QuestObjUpdateAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestObjUpdateAlert,
            },
            {
                -- Show Quest Objective Complete (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestObjCompleteCA end,
                setFunc = function(value) Settings.Quests.QuestObjCompleteCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestObjCompleteCA,
            },
            {
                -- Show Quest Objective Complete (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Quests.QuestObjCompleteCSA end,
                setFunc = function(value) Settings.Quests.QuestObjCompleteCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestObjCompleteCSA,
            },
            {
                -- Show Quest Objective Complete (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestObjCompleteAlert end,
                setFunc = function(value) Settings.Quests.QuestObjCompleteAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestObjCompleteAlert,
            },
            {
                -- Show Quest Icon
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTICON_TP),
                getFunc = function() return Settings.Quests.QuestIcon end,
                setFunc = function(value) Settings.Quests.QuestIcon = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestIcon,
            },
            {
                -- Location Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR1)),
                getFunc = function() return unpack(Settings.Quests.QuestColorLocName) end,
                setFunc = function(r,g,b,a) Settings.Quests.QuestColorLocName={r,g,b} ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = { r=Defaults.Quests.QuestColorLocName[1], g=Defaults.Quests.QuestColorLocName[2], b=Defaults.Quests.QuestColorLocName[3] },
            },
            {
                -- Location Description Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR2)),
                getFunc = function() return unpack(Settings.Quests.QuestColorLocDescription) end,
                setFunc = function(r,g,b,a) Settings.Quests.QuestColorLocDescription={r,g,b} ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = { r=Defaults.Quests.QuestColorLocDescription[1], g=Defaults.Quests.QuestColorLocDescription[2], b=Defaults.Quests.QuestColorLocDescription[3] },
            },
            {
                -- Quest Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR3)),
                getFunc = function() return unpack(Settings.Quests.QuestColorName) end,
                setFunc = function(r,g,b,a) Settings.Quests.QuestColorName={r,g,b} ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = { r=Defaults.Quests.QuestColorName[1], g=Defaults.Quests.QuestColorName[2], b=Defaults.Quests.QuestColorName[3] },
            },
            {
                -- Quest Description Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR4)),
                getFunc = function() return unpack(Settings.Quests.QuestColorDescription) end,
                setFunc = function(r,g,b,a) Settings.Quests.QuestColorDescription={r,g,b} ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = { r=Defaults.Quests.QuestColorDescription[1], g=Defaults.Quests.QuestColorDescription[2], b=Defaults.Quests.QuestColorDescription[3] },
            },
            {
                -- Show Quest Long String
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTLONG)),
                tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTLONG_TP),
                getFunc = function() return Settings.Quests.QuestLong end,
                setFunc = function(value) Settings.Quests.QuestLong = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestLong,
            },
            {
                -- Show POI Completed Long String
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTOBJECTIVELONG)),
                tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTOBJECTIVELONG_TP),
                getFunc = function() return Settings.Quests.QuestLocLong end,
                setFunc = function(value) Settings.Quests.QuestLocLong = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestLocLong,
            },
        },
    }

    -- Chat Announcements - Social Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_SOCIAL_HEADER),
        controls = {
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_HEADER),
                width = "full",
            },
            {
                -- Show Friend/Ignore Events ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Social.FriendIgnoreCA end,
                setFunc = function(value) Settings.Social.FriendIgnoreCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.FriendIgnoreCA,
            },
            {
                -- Show Friend/Ignore Events Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Social.FriendIgnoreAlert end,
                setFunc = function(value) Settings.Social.FriendIgnoreAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.FriendIgnoreAlert,
            },
            {
                -- Friend Online/Offline ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Social.FriendStatusCA end,
                setFunc = function(value) Settings.Social.FriendStatusCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.FriendStatusCA,
            },
            {
                -- Friend Online/Offline Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Social.FriendStatusAlert end,
                setFunc = function(value) Settings.Social.FriendStatusAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.FriendStatusAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_HEADER),
                width = "full",
            },
            {
                -- Show Guild Events ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Social.GuildCA end,
                setFunc = function(value) Settings.Social.GuildCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.GuildCA,
            },
            {
                -- Show Guild Events Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Social.GuildAlert end,
                setFunc = function(value) Settings.Social.GuildAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.GuildAlert,
            },
            {
                -- Show Guild Rank Events ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Social.GuildRankCA end,
                setFunc = function(value) Settings.Social.GuildRankCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.GuildRankCA,
            },
            {
                -- Show Guild Rank Events Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Social.GuildRankAlert end,
                setFunc = function(value) Settings.Social.GuildRankAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.GuildRankAlert,
            },
            {
                -- Show Guild Rank Events Display Options
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANKOPTIONS)),
                tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANKOPTIONS_TP),
                choices = guildRankDisplayOptions,
                getFunc = function() return guildRankDisplayOptions[Settings.Social.GuildRankDisplayOptions] end,
                setFunc = function(value) Settings.Social.GuildRankDisplayOptions = guildRankDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not (Settings.Social.GuildRankCA or Settings.Social.GuildRankAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Social.GuildRankDisplayOptions,
            },
            {
                -- Show Guild Management ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Social.GuildManageCA end,
                setFunc = function(value) Settings.Social.GuildManageCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.GuildManageCA,
            },
            {
                -- Show Guild Management Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Social.GuildManageAlert end,
                setFunc = function(value) Settings.Social.GuildManageAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.GuildManageAlert,
            },
            {
                -- Show Guild Icons
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ICONS)),
                tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ICONS_TP),
                getFunc = function() return Settings.Social.GuildIcon end,
                setFunc = function(value) Settings.Social.GuildIcon = value end,
                width = "full",
                disabled = function() return not (
                Settings.Social.GuildCA or
                Settings.Social.GuildAlert or
                Settings.Social.GuildRankCA or
                Settings.Social.GuildRankAlert or
                Settings.Social.GuildManageCA or
                Settings.Social.GuildManageAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Social.GuildIcon,
            },
            {
                -- Guild Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR)),
                getFunc = function() return unpack(Settings.Social.GuildColor) end,
                setFunc = function(r, g, b, a) Settings.Social.GuildColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (
                Settings.Social.GuildCA or
                Settings.Social.GuildAlert or
                Settings.Social.GuildRankCA or
                Settings.Social.GuildRankAlert or
                Settings.Social.GuildManageCA or
                Settings.Social.GuildManageAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Social.GuildColor[1], g=Defaults.Social.GuildColor[2], b=Defaults.Social.GuildColor[3]}
            },
            {
                -- Use Alliance Color for Guild
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR_ALLIANCE)),
                tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR_ALLIANCE_TP),
                getFunc = function() return Settings.Social.GuildAllianceColor end,
                setFunc = function(value) Settings.Social.GuildAllianceColor = value end,
                width = "full",
                disabled = function() return not (
                Settings.Social.GuildCA or
                Settings.Social.GuildAlert or
                Settings.Social.GuildRankCA or
                Settings.Social.GuildRankAlert or
                Settings.Social.GuildManageCA or
                Settings.Social.GuildManageAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Social.GuildAllianceColor,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE_HEADER),
                width = "full",
            },
            {
                -- Show Trade Events
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Notify.NotificationTradeCA end,
                setFunc = function(value) Settings.Notify.NotificationTradeCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationTradeCA,
            },
            {
                -- Show Trade Events
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Notify.NotificationTradeAlert end,
                setFunc = function(value) Settings.Notify.NotificationTradeAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationTradeAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL_HEADER),
                width = "full",
            },
            {
                -- Show Duel Events (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Social.DuelCA end,
                setFunc = function(value) Settings.Social.DuelCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.DuelCA,
            },
            {
                -- Show Duel Events (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Social.DuelAlert end,
                setFunc = function(value) Settings.Social.DuelAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.DuelAlert,
            },
            {
                -- Duel Start ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Social.DuelStartCA end,
                setFunc = function(value) Settings.Social.DuelStartCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.DuelStartCA,
            },
            {
                -- Duel Start CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TPCSA), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Social.DuelStartCSA end,
                setFunc = function(value) Settings.Social.DuelStartCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.DuelStartCSA,
            },
            {
                -- Duel Start Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Social.DuelStartAlert end,
                setFunc = function(value) Settings.Social.DuelStartAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.DuelStartAlert,
            },
            {
                -- Duel Start Options
                type = "dropdown",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_OPTION)),
                tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_OPTION_TP),
                choices = duelStartOptions,
                getFunc = function() return duelStartOptions[Settings.Social.DuelStartOptions] end,
                setFunc = function(value) Settings.Social.DuelStartOptions = duelStartOptionsKeys[value] end,
                width = "full",
                default = duelStartOptions[1],
                disabled = function() return not (Settings.Social.DuelStartCA or Settings.Social.DuelStartCSA or Settings.Social.DuelStartAlert and LUIE.SV.ChatAnnouncements_Enable) end,
            },
            {
                -- Duel Won ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Social.DuelWonCA end,
                setFunc = function(value) Settings.Social.DuelWonCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.DuelWonCA,
            },
            {
                -- Duel Won CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Social.DuelWonCSA end,
                setFunc = function(value) Settings.Social.DuelWonCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.DuelWonCSA,
            },
            {
                -- Duel Won Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Social.DuelWonAlert end,
                setFunc = function(value) Settings.Social.DuelWonAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.DuelWonAlert,
            },
            {
                -- Duel Boundary ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Social.DuelBoundaryCA end,
                setFunc = function(value) Settings.Social.DuelBoundaryCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.DuelBoundaryCA,
            },
            {
                -- Duel Boundary CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Social.DuelBoundaryCSA end,
                setFunc = function(value) Settings.Social.DuelBoundaryCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.DuelBoundaryCSA,
            },
            {
                -- Duel Boundary Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Social.DuelBoundaryAlert end,
                setFunc = function(value) Settings.Social.DuelBoundaryAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.DuelBoundaryAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_SOCIAL_MARA_HEADER),
                width = "full",
            },
            {
                -- Show Pledge of Mara ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Social.PledgeOfMaraCA end,
                setFunc = function(value) Settings.Social.PledgeOfMaraCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.PledgeOfMaraCA,
            },
            {
                -- Show Pledge of Mara CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Social.PledgeOfMaraCSA end,
                setFunc = function(value) Settings.Social.PledgeOfMaraCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.PledgeOfMaraCSA,
            },
            {
                -- Show Pledge of Mara Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Social.PledgeOfMaraAlert end,
                setFunc = function(value) Settings.Social.PledgeOfMaraAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Social.PledgeOfMaraAlert,
            },
            {
                -- Pledge of Mara (Alert Only on Failure)
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_MARA_ALERT)),
                tooltip = GetString(SI_LUIE_LAM_CA_MISC_MARA_ALERT_TP),
                getFunc = function() return Settings.Social.PledgeOfMaraAlertOnlyFail end,
                setFunc = function(value) Settings.Social.PledgeOfMaraAlertOnlyFail = value end,
                width = "full",
                disabled = function() return not (Settings.Social.PledgeOfMaraAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = Defaults.Social.PledgeOfMaraAlertOnlyFail,
            },
        },
    }

    -- Chat Announcements - Group Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_GROUP_HEADER),
        controls = {
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_GROUP_BASE_HEADER),
                width = "full",
            },
            {
                -- Show Group ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Group.GroupCA end,
                setFunc = function(value) Settings.Group.GroupCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupCA,
            },
            {
                -- Show Group Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Group.GroupAlert end,
                setFunc = function(value) Settings.Group.GroupAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_GROUP_LFG_HEADER),
                width = "full",
            },
            {
                -- Show Group LFG ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Group.GroupLFGCA end,
                setFunc = function(value) Settings.Group.GroupLFGCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupLFGCA,
            },
            {
                -- Show Group LFG Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Group.GroupLFGAlert end,
                setFunc = function(value) Settings.Group.GroupLFGAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupLFGAlert,
            },
            {
                -- Show Group LFG ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Group.GroupLFGQueueCA end,
                setFunc = function(value) Settings.Group.GroupLFGQueueCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupLFGQueueCA,
            },
            {
                -- Show Group LFG Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Group.GroupLFGQueueAlert end,
                setFunc = function(value) Settings.Group.GroupLFGQueueAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupLFGQueueAlert,
            },
            {
                -- Show Group Vote ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Group.GroupVoteCA end,
                setFunc = function(value) Settings.Group.GroupVoteCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupVoteCA,
            },
            {
                -- Show Group Vote Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Group.GroupVoteAlert end,
                setFunc = function(value) Settings.Group.GroupVoteAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupVoteAlert,
            },
            {
                -- Show LFG Activity Completed ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Group.GroupLFGCompleteCA end,
                setFunc = function(value) Settings.Group.GroupLFGCompleteCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupLFGCompleteCA,
            },
            {
                -- Show LFG Activity Completed CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Group.GroupLFGCompleteCSA end,
                setFunc = function(value) Settings.Group.GroupLFGCompleteCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupLFGCompleteCSA,
            },
            {
                -- Show LFG Activity Completed Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Group.GroupLFGCompleteAlert end,
                setFunc = function(value) Settings.Group.GroupLFGCompleteAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupLFGCompleteAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_GROUP_RAID_HEADER),
                width = "full",
            },
            {
                -- Raid Announcements ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Group.GroupRaidCA end,
                setFunc = function(value) Settings.Group.GroupRaidCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidCA,
            },
            {
                -- Raid Announcements CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Group.GroupRaidCSA end,
                setFunc = function(value) Settings.Group.GroupRaidCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidCSA,
            },
            {
                -- Raid Announcements Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Group.GroupRaidAlert end,
                setFunc = function(value) Settings.Group.GroupRaidAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidAlert,
            },
            {
                -- Raid Score ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Group.GroupRaidScoreCA end,
                setFunc = function(value) Settings.Group.GroupRaidScoreCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidScoreCA,
            },
            {
                -- Raid Score CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Group.GroupRaidScoreCSA end,
                setFunc = function(value) Settings.Group.GroupRaidScoreCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidScoreCSA,
            },
            {
                -- Raid Score Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Group.GroupRaidScoreAlert end,
                setFunc = function(value) Settings.Group.GroupRaidScoreAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidScoreAlert,
            },
            {
                -- Raid Best Score ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Group.GroupRaidBestScoreCA end,
                setFunc = function(value) Settings.Group.GroupRaidBestScoreCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidBestScoreCA,
            },
            {
                -- Raid Best Score CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Group.GroupRaidBestScoreCSA end,
                setFunc = function(value) Settings.Group.GroupRaidBestScoreCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidBestScoreCSA,
            },
            {
                -- Raid Best Score Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Group.GroupRaidBestScoreAlert end,
                setFunc = function(value) Settings.Group.GroupRaidBestScoreAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidBestScoreAlert,
            },
            {
                -- Raid Revive Counter ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Group.GroupRaidReviveCA end,
                setFunc = function(value) Settings.Group.GroupRaidReviveCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidReviveCA,
            },
            {
                -- Raid Revive Counter CSA
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Group.GroupRaidReviveCSA end,
                setFunc = function(value) Settings.Group.GroupRaidReviveCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidReviveCSA,
            },
            {
                -- Raid Revive Counter Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Group.GroupRaidReviveAlert end,
                setFunc = function(value) Settings.Group.GroupRaidReviveAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidReviveAlert,
            },
        },
    }

    -- Chat Announcements - Display Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_DISPLAY_HEADER),
        controls = {
            {
                -- Display Announcements Header
                type = "description",
                text = GetString(SI_LUIE_LAM_CA_DISPLAY_DESCRIPTION),
            },
            {
                -- Display Announcement DEBUG
                type = "checkbox",
                name = "*** Show Display Announcement Debug Message ***",
                tooltip = "Display a debug message when a Display Announcement that has not yet been added to LUIE is triggered. Enable this option if you'd like to help out with the addon by posting the messages you receive from this event. Do not enable if you are not using the English client.",
                getFunc = function() return Settings.DisplayAnnouncements.Debug end,
                setFunc = function(value) Settings.DisplayAnnouncements.Debug = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.DisplayAnnouncements.Debug,
            },
            {
                -- Respec Notification (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Notify.NotificationRespecCA end,
                setFunc = function(value) Settings.Notify.NotificationRespecCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationRespecCA,
            },
            {
                -- Respec Notification (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Notify.NotificationRespecCSA end,
                setFunc = function(value) Settings.Notify.NotificationRespecCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationRespecCSA,
            },
            {
                -- Respec Notification (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Notify.NotificationRespecAlert end,
                setFunc = function(value) Settings.Notify.NotificationRespecAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationRespecAlert,
            },
            {
                -- Display Group Area Message (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Notify.NotificationGroupAreaCA end,
                setFunc = function(value) Settings.Notify.NotificationGroupAreaCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationGroupAreaCA,
            },
            {
                -- Display Group Area Message (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Notify.NotificationGroupAreaCSA end,
                setFunc = function(value) Settings.Notify.NotificationGroupAreaCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationGroupAreaCSA,
            },
            {
                -- Display Group Area Message (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Notify.NotificationGroupAreaAlert end,
                setFunc = function(value) Settings.Notify.NotificationGroupAreaAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationGroupAreaAlert,
            },
            {
                -- Arena Notifications (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Group.GroupRaidArenaCA end,
                setFunc = function(value) Settings.Group.GroupRaidArenaCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidArenaCA,
            },
            {
                -- Arena Notifications (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Group.GroupRaidArenaCSA end,
                setFunc = function(value) Settings.Group.GroupRaidArenaCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidArenaCSA,
            },
            {
                -- Arena Notifications (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Group.GroupRaidArenaAlert end,
                setFunc = function(value) Settings.Group.GroupRaidArenaAlert  = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidArenaAlert,
            },
            {
                -- Arena Round Notifications (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Group.GroupRaidArenaRoundCA end,
                setFunc = function(value) Settings.Group.GroupRaidArenaRoundCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidArenaRoundCA,
            },
            {
                -- Arena Round Notifications (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Group.GroupRaidArenaRoundCSA end,
                setFunc = function(value) Settings.Group.GroupRaidArenaRoundCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidArenaRoundCSA,
            },
            {
                -- Arena Round Notifications (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Group.GroupRaidArenaRoundAlert end,
                setFunc = function(value) Settings.Group.GroupRaidArenaRoundAlert  = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Group.GroupRaidArenaRoundAlert,
            },
            {
                -- Imperial City Display Announcement (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestICDiscoveryCA end,
                setFunc = function(value) Settings.Quests.QuestICDiscoveryCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestICDiscoveryCA,
            },
            {
                -- Imperial City Display Announcement (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Quests.QuestICDiscoveryCSA end,
                setFunc = function(value) Settings.Quests.QuestICDiscoveryCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestICDiscoveryCSA,
            },
            {
                -- Imperial City Display Announcement (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestICDiscoveryAlert end,
                setFunc = function(value) Settings.Quests.QuestICDiscoveryAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestICDiscoveryAlert,
            },
            {
                -- Imperial City Display Description
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_IC_DESCRIPTION)),
                tooltip = GetString(SI_LUIE_LAM_CA_QUEST_IC_DESCRIPTION_TP),
                getFunc = function() return Settings.Quests.QuestICDescription end,
                setFunc = function(value) Settings.Quests.QuestICDescription = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and (Settings.Quests.QuestICDiscoveryCA or Settings.Quests.QuestICDiscoveryCSA or Settings.Quests.QuestICDiscoveryAlert) ) end,
                default = Defaults.Quests.QuestICDiscoveryAlert,
            },
            {
                -- Craglorn Buff (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Quests.QuestCraglornBuffCA end,
                setFunc = function(value) Settings.Quests.QuestCraglornBuffCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestCraglornBuffCA,
            },
            {
                -- Craglorn Buff (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Quests.QuestCraglornBuffCSA end,
                setFunc = function(value) Settings.Quests.QuestCraglornBuffCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestCraglornBuffCSA,
            },
            {
                -- Craglorn Buff (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Quests.QuestCraglornBuffAlert end,
                setFunc = function(value) Settings.Quests.QuestCraglornBuffAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Quests.QuestCraglornBuffAlert,
            },
        },
    }

    -- Chat Announcements - Miscellaneous Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_MISC_HEADER),
        controls = {
            {
                -- Mail (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Notify.NotificationMailCA end,
                setFunc = function(value) Settings.Notify.NotificationMailCA = value ChatAnnouncements.RegisterMailEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationMailCA,
            },
            {
                -- Mail (ALERT)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Notify.NotificationMailAlert end,
                setFunc = function(value) Settings.Notify.NotificationMailAlert = value ChatAnnouncements.RegisterMailEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationMailAlert,
            },
            {
                -- Show Lockpick Events ChatAnnouncements
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Notify.NotificationLockpickCA end,
                setFunc = function(value) Settings.Notify.NotificationLockpickCA = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationLockpickCA,
            },
            {
                -- Show Lockpick Events Alert
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Notify.NotificationLockpickAlert end,
                setFunc = function(value) Settings.Notify.NotificationLockpickAlert = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationLockpickAlert,
            },
            {
                -- Show Justice Confiscate (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Notify.NotificationConfiscateCA end,
                setFunc = function(value) Settings.Notify.NotificationConfiscateCA = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationConfiscateCA,
            },
            {
                -- Show Justice Confiscate (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Notify.NotificationConfiscateAlert end,
                setFunc = function(value) Settings.Notify.NotificationConfiscateAlert = value ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.NotificationConfiscateAlert,
            },
            {
                -- Show Bag/Bank Upgrade (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Notify.StorageBagCA end,
                setFunc = function(value) Settings.Notify.StorageBagCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.StorageBagCA,
            },
            {
                -- Show Bag/Bank Upgrade (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Notify.StorageBagCSA end,
                setFunc = function(value) Settings.Notify.StorageBagCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.StorageBagCSA,
            },
            {
                -- Show Bag/Bank Upgrade (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Notify.StorageBagAlert end,
                setFunc = function(value) Settings.Notify.StorageBagAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.StorageBagAlert,
            },
            {
                -- Bag/Bank Upgrade Message Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_COLOR)),
                getFunc = function() return unpack(Settings.Notify.StorageBagColor) end,
                setFunc = function(r, g, b, a) Settings.Notify.StorageBagColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Notify.StorageBagCA or Settings.Notify.StorageBagCSA or Settings.Notify.StorageBagAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Notify.StorageBagColor[1], g=Defaults.Notify.StorageBagColor[2], b=Defaults.Notify.StorageBagColor[3]}
            },
            {
                -- Show Mount Upgrade (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Notify.StorageRidingCA end,
                setFunc = function(value) Settings.Notify.StorageRidingCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.StorageRidingCA,
            },
            {
                -- Show Mount Upgrade (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Notify.StorageRidingCSA end,
                setFunc = function(value) Settings.Notify.StorageRidingCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.StorageRidingCSA,
            },
            {
                -- Show Mount Upgrade (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Notify.StorageRidingAlert end,
                setFunc = function(value) Settings.Notify.StorageRidingAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.StorageRidingAlert,
            },
            {
                -- Mount Upgrade Message Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_COLOR)),
                getFunc = function() return unpack(Settings.Notify.StorageRidingColor) end,
                setFunc = function(r, g, b, a) Settings.Notify.StorageRidingColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Notify.StorageRidingCA or Settings.Notify.StorageRidingCSA or Settings.Notify.StorageRidingAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Notify.StorageRidingColor[1], g=Defaults.Notify.StorageRidingColor[2], b=Defaults.Notify.StorageRidingColor[3]}
            },
            {
                -- Mount Upgrade Message Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_COLOR_BOOK)),
                getFunc = function() return unpack(Settings.Notify.StorageRidingBookColor) end,
                setFunc = function(r, g, b, a) Settings.Notify.StorageRidingBookColor = { r, g, b, a } ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Notify.StorageRidingCA or Settings.Notify.StorageRidingCSA or Settings.Notify.StorageRidingAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=Defaults.Notify.StorageRidingBookColor[1], g=Defaults.Notify.StorageRidingBookColor[2], b=Defaults.Notify.StorageRidingBookColor[3]}
            },
            {
                -- Show Disguise Events (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Notify.DisguiseCA end,
                setFunc = function(value) Settings.Notify.DisguiseCA = value ChatAnnouncements.RegisterDisguiseEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.DisguiseCA,
            },
            {
                -- Show Disguise Events (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Notify.DisguiseCSA end,
                setFunc = function(value) Settings.Notify.DisguiseCSA = value ChatAnnouncements.RegisterDisguiseEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.DisguiseCSA,
            },
            {
                -- Show Disguise Events (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Notify.DisguiseAlert end,
                setFunc = function(value) Settings.Notify.DisguiseAlert = value ChatAnnouncements.RegisterDisguiseEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.DisguiseAlert,
            },
            {
                -- Show Disguise Warning (ChatAnnouncements)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return Settings.Notify.DisguiseWarnCA end,
                setFunc = function(value) Settings.Notify.DisguiseWarnCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.DisguiseWarnCA,
            },
            {
                -- Show Disguise Warning (CSA)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return Settings.Notify.DisguiseWarnCSA end,
                setFunc = function(value) Settings.Notify.DisguiseWarnCSA = value end,
                width = "full",
               disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.DisguiseWarnCSA,
            },
            {
                -- Show Disguise Warning (Alert)
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return Settings.Notify.DisguiseWarnAlert end,
                setFunc = function(value) Settings.Notify.DisguiseWarnAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = Defaults.Notify.DisguiseWarnAlert,
            },
            {
                -- Disguise Alert Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERTCOLOR)),
                tooltip = GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERTCOLOR_TP),
                getFunc = function() return unpack(Settings.Notify.DisguiseAlertColor) end,
                setFunc = function(r,g,b,a) Settings.Notify.DisguiseAlertColor={r,g,b} ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (Settings.Notify.DisguiseWarnCA or Settings.Notify.DisguiseWarnCSA or Settings.Notify.DisguiseWarnAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = { r=Defaults.Notify.DisguiseAlertColor[1], g=Defaults.Notify.DisguiseAlertColor[2], b=Defaults.Notify.DisguiseAlertColor[3] },
            },
        },
    }

    -- Register the settings panel
    if LUIE.SV.ChatAnnouncements_Enable then
        LAM:RegisterAddonPanel(LUIE.name .. 'ChatAnnouncementOptions', panelDataChatAnnouncements)
        LAM:RegisterOptionControls(LUIE.name .. 'ChatAnnouncementOptions', optionsDataChatAnnouncements)
    end
end
