Config = Config or {}

Config.ResourcePerms = 'admin' -- permission to control resource(start stop restart)
Config.ShowCommandsPerms = 'admin' -- permission to show all commands

-- Key Bindings
Config.Keybindings = true
Config.AdminKey = 0x446258B6
Config.NoclipKey = 0x110AD1D2

-- Give Horse
Config.AdminHorse = {
    {
         horsename = 'Arabian White',
         horsehash = 'a_c_horse_arabian_white',
    },
    {
         horsename = 'Missouri Foxtrotter',
         horsehash = 'a_c_horse_missourifoxtrotter_sablechampagne',
    },
    {
         horsename = 'Nokota Whiteroan',
         horsehash = 'a_c_horse_nokota_whiteroan',
    },
    {
         horsename = 'Turkoman Gold',
         horsehash = 'a_c_horse_turkoman_gold',
    },
    {
         horsename = 'Thoroughbred',
         horsehash = 'a_c_horse_thoroughbred_reversedappleblack',
    },
}

Config.Actions = {
    ["admin_car"] = {
        label = "Admin Horse",
        type = "client",
        event = "ps-adminmenu:client:horseoptions",
        perms = "mod",
    },

    ["ban_player"] = {
        label = "Ban Player",
        perms = "mod",
        dropdown = {
            { label = "Player", option = "dropdown", data = "players" },
            { label = "Reason", option = "text" },
            {
                label = "Duration",
                option = "dropdown",
                data = {
                    { label = "Permanent",  value = "2147483647" },
                    { label = "10 Minutes", value = "600" },
                    { label = "30 Minutes", value = "1800" },
                    { label = "1 Hour",     value = "3600" },
                    { label = "6 Hours",    value = "21600" },
                    { label = "12 Hours",   value = "43200" },
                    { label = "1 Day",      value = "86400" },
                    { label = "3 Days",     value = "259200" },
                    { label = "1 Week",     value = "604800" },
                    { label = "3 Week",     value = "1814400" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:BanPlayer" },
        },
    },

    ["bring_player"] = {
        label = "Bring Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:BringPlayer" },
        },
    },

    ["change_weather"] = {
        label = "Change Weather",
        perms = "mod",
        dropdown = {
            {
                label = "Weather",
                option = "dropdown",
                data = {
                    { label = "Extrasunny", value = "sunny" },
                    { label = "Clouds",      value = "clouds" },
                    { label = "Overcast Dark",    value = "overcastdark" },
                    { label = "Misty",       value = "misty" },
                    { label = "Foggy",      value = "fog" },
                    { label = "Overcast",   value = "overcast" },
                    { label = "Drizzle",     value = "drizzle" },
                    { label = "Rain",       value = "rain" },
                    { label = "Thunder",    value = "thunder" },
                    { label = "Thunder Strom",    value = "thunderstorm" },
                    { label = "Hurricane",       value = "hurricane" },
                    { label = "Shower",   value = "shower" },
                },
            },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:ChangeWeather" },
        },
    },
    

    ["clear_inventory"] = {
        label = "Clear Inventory",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "client", event = "ps-adminmenu:client:ClearInventory" },
        },
    },

    ["clear_inventory_offline"] = {
        label = "Clear Inventory Offline",
        perms = "mod",
        dropdown = {
            { label = "Citizen ID", option = "text",   data = "players" },
            { label = "Confirm",    option = "button", type = "server", event = "ps-adminmenu:server:ClearInventoryOffline" },
        },
    },

    ["copy_coords"] = {
        label = "Copy Coords",
        perms = "mod",
        dropdown = {
            {
                label = "Copy Coords",
                option = "dropdown",
                data = {
                    { label = "Copy Vector2", value = "vector2" },
                    { label = "Copy Vector3", value = "vector3" },
                    { label = "Copy Vector4",    value = "vector4" },
                    { label = "Copy Heading",  value = "heading" },
                },
            },
            { label = "Copy to Clipboard", option = "button", type = "client", event = "ps-adminmenu:client:copyToClipboard"},
        },
    },

    ["delete_vehicle"] = {
        label = "Delete Vehicle",
        type = "command",
        event = "dv",
        perms = "mod",
    },

    ["freeze_player"] = {
        label = "Freeze Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:FreezePlayer" },
        },
    },

    ["drunk_player"] = {
        label = "Make Player Drunk",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:DrunkPlayer" },
        },
    },

    ["remove_stress"] = {
        label = "Remove Stress",
        perms = "mod",
        dropdown = {
            { label = "Player (Optional)", option = "dropdown", data = "players" },
            { label = "Confirm",           option = "button",   type = "server", event = "ps-adminmenu:server:RemoveStress" },
        },
    },

    ["set_ammo"] = {
        label = "Set Ammo",
        perms = "admin",
        dropdown = {
            { label = "Ammo Ammount", option = "text" },
            { label = "Confirm",      option = "button", type = "client", event = "ps-adminmenu:client:SetAmmo" },
        },
    },

    -- ["nui_focus"] = {
    --     label = "Give NUI Focus",
    --     perms = "mod",
    --     dropdown = {
    --         { label = "Player",  option = "dropdown", data = "players" },
    --         { label = "Confirm", option = "button",   type = "client", event = "" },
    --     },
    -- },

    ["god_mode"] = {
        label = "God Mode",
        type = "client",
        event = "ps-adminmenu:client:ToggleGodmode",
        perms = "mod",
    },

    ["invisible"] = {
        label = "Invisible",
        type = "client",
        event = "ps-adminmenu:client:ToggleInvisible",
        perms = "mod",
    },

    ["toggle_duty"] = {
        label = "Toggle Duty",
        type = "server",
        event = "RSGCore:ToggleDuty",
        perms = "mod",
    },

    ["set_perms"] = {
        label = "Set Perms",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            {
                label = "Permissions",
                option = "dropdown",
                data = {
                    { label = "Mod",   value = "mod" },
                    { label = "Admin", value = "admin" },
                    { label = "God",   value = "god" },
                },
            },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:SetPerms" },
        },
    },

    ["set_bucket"] = {
        label = "Set Routing Bucket",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Bucket",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:SetBucket" },
        },
    },

    ["get_bucket"] = {
        label = "Get Routing Bucket",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:GetBucket" },
        },
    },

    ["mute_player"] = {
        label = "Mute Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "client", event = "ps-adminmenu:client:MutePlayer" },
        },
    },

    ["noclip"] = {
        label = "Noclip",
        type = "client",
        event = "ps-adminmenu:client:ToggleNoClip",
        perms = "mod",
    },

    ["open_inventory"] = {
        label = "Open Inventory",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "client", event = "ps-adminmenu:client:openInventory" },
        },
    },

    ["open_stash"] = {
        label = "Open Stash",
        perms = "mod",
        dropdown = {
            { label = "Stash",   option = "text" },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:openStash" },
        },
    },

    ["revive_all"] = {
        label = "Revive All",
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = "mod",
    },

    ["revive_player"] = {
        label = "Revive Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:Revive" },
        },
    },

    ["revive_radius"] = {
        label = "Revive Radius",
        type = "server",
        event = "ps-adminmenu:server:ReviveRadius",
        perms = "mod",
    },

    ["set_job"] = {
        label = "Set Job",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Job",     option = "dropdown", data = "jobs" },
            { label = "Grade",   option = "text",     data = "grades" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:SetJob" },
        },
    },

    ["set_gang"] = {
        label = "Set Gang",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Gang",    option = "dropdown", data = "gangs" },
            { label = "Grade",   option = "text",     data = "grades" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:SetGang" },
        },
    },

    ["give_money"] = {
        label = "Give Money",
        perms = "admin",
        dropdown = {
            { label = "Player", option = "dropdown", data = "players" },
            { label = "Amount", option = "text" },
            {
                label = "Type",
                option = "dropdown",
                data = {
                    { label = "Cash",   value = "cash" },
                    { label = "Blood Money",   value = "bloodmoney" },
                    { label = "Valentine Bank",   value = "valbank" },
                    { label = "Rhodes Bank",   value = "rhobank" },
                    { label = "BlackWater Bank",   value = "blkbank" },
                    { label = "Armadillo Bank",   value = "armbank" },
                    { label = "Saint Denis (Main Bank)",   value = "bank" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:GiveMoney" },
        },
    },

    ["give_money_all"] = {
        label = "Give Money to All",
        perms = "admin",
        dropdown = {
            { label = "Amount",  option = "text" },
            {
                label = "Type",
                option = "dropdown",
                data = {
                    { label = "Cash",   value = "cash" },
                    { label = "Blood Money",   value = "bloodmoney" },
                    { label = "Valentine Bank",   value = "valbank" },
                    { label = "Rhodes Bank",   value = "rhobank" },
                    { label = "BlackWater Bank",   value = "blkbank" },
                    { label = "Armadillo Bank",   value = "armbank" },
                    { label = "Saint Denis (Main Bank)",   value = "bank" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:GiveMoneyAll" },
        },
    },

    ["remove_money"] = {
        label = "Remove Money",
        perms = "admin",
        dropdown = {
            { label = "Player", option = "dropdown", data = "players" },
            { label = "Amount", option = "text" },
            {
                label = "Type",
                option = "dropdown",
                data = {
                    { label = "Cash", value = "cash" },
                    { label = "Bank", value = "bank" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:TakeMoney" },
        },
    },

    ["give_item"] = {
        label = "Give Item",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Item",    option = "dropdown", data = "items" },
            { label = "Amount",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:GiveItem" },
        },
    },

    ["give_item_all"] = {
        label = "Give Item to All",
        perms = "mod",
        dropdown = {
            { label = "Item",    option = "dropdown", data = "items" },
            { label = "Amount",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:GiveItemAll" },
        },
    },

    ["spectate_player"] = {
        label = "Spectate Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:SpectateTarget" },
        },
    },

    ["telport_to_player"] = {
        label = "Teleport to Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:TeleportToPlayer" },
        },
    },

    ["telport_to_coords"] = {
        label = "Teleport to Coords",
        perms = "mod",
        dropdown = {
            { label = "Coords",  option = "text" },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:TeleportToCoords" },
        },
    },

    ["teleport_to_location"] = {
        label = "Teleport to Location",
        perms = "mod",
        dropdown = {
            {
                label = "Location",
                option = "dropdown",
                data = {
                    { label = "VALENTINE",  value = vector3(-309.86, 788.44, 117.63) },
                    { label = "VAN HORN", value = vector3(2973.88, 561.59, 44.43) },
                    { label = "ANNESBURG", value = vector3(2927.31, 1326.51, 44.11) },
                    { label = "RHODES",    value = vector3(1311.22, -1297.73, 75.94) },
                    { label = "SAINT DENIS",     value = vector3(2603.40, -1215.81, 53.35) },
                    { label = "BLACKWATER",   value = vector3(-800.35, -1337.08, 43.54) },
                    { label = "STRAWBERRY",      value = vector3(-1814.13, -391.82, 161.59) },
                    { label = "ARMADILLO",     value = vector3(-3679.53, -2612.38, -14.08) },
                    { label = "TUMBLEWEED",     value = vector3(-5513.73, -2956.16, -1.59) },
                    { label = "GUARMA",     value = vector3(1270.34, -6857.038, 43.168) },
                },
            },
            { label = "Confirm",  option = "button",   type = "client",   event = "ps-adminmenu:client:TeleportToLocation" },
        },
    },

    ["teleport_to_marker"] = {
        label = "Teleport to Marker",
        type = "command",
        event = "tpm",
        perms = "mod",
    },

    ["teleport_back"] = {
        label = "Teleport Back",
        type = "client",
        event = "ps-adminmenu:client:TeleportBack",
        perms = "mod",
    },

    ["toggle_coords"] = {
        label = "Toggle Coords",
        type = "client",
        event = "ps-adminmenu:client:ToggleCoords",
        perms = "mod",
    },

    ["toggle_names"] = {
        label = "Toggle Names",
        type = "client",
        event = "ps-adminmenu:client:toggleNames",
        perms = "mod",
    },

    ["toggle_cuffs"] = {
        label = "Toggle Cuffs",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "client", event = "ps-adminmenu:client:CuffPlayer" },
        },
    },

    ["warn_player"] = {
        label = "Warn Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Reason",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:WarnPlayer" },
        },
    },

    ["infinite_ammo"] = {
        label = "Infinite Ammo",
        type = "client",
        event = "ps-adminmenu:client:setInfiniteAmmo",
        perms = "mod",
    },

    ["kick_player"] = {
        label = "Kick Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Reason",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:KickPlayer" },
        },
    },


    ["play_sound"] = {
        label = "Play Sound",
        perms = "mod",
        dropdown = {
            { label = "Player",     option = "dropdown", data = "players" },
            {
                label = "Sound",
                option = "dropdown",
                data = {
                    { label = "Knock",      value = "knock" },
                    { label = "Amongus",      value = "amongus" },
                    { label = "Discord Disconnect",      value = "discord-disconnect" },
                    { label = "Dramatic Fart",      value = "dramatic-fart" },
                    { label = "Fart Reverb",      value = "fart-reverb" },
                    { label = "Mario Fart",       value = "mario-fart" },
                    { label = "Minecraft Creeper",       value = "minecraft-creeper" },
                    { label = "Spongebob",       value = "spongebob" },
                    { label = "Troll Laugh",       value = "troll-laugh" },
                    { label = "Youre Gonna Die Clown",       value = "youre-gonna-die-clown" },
                    { label = "Cuff",       value = "cuff" },
                    { label = "Rick Rock Roll", value = "rickrockroll" },
                },
            },
            { label = "Play Sound", option = "button",   type = "client", event = "ps-adminmenu:client:PlaySound" },
        },
    },
}

Config.PlayerActions = {
    ["teleportToPlayer"] = {
        label = "Teleport to Player",
        type = "server",
        event = "ps-adminmenu:server:TeleportToPlayer",
        perms = "mod",
    },
    ["bringPlayer"] = {
        label = "Bring Player",
        type = "server",
        event = "ps-adminmenu:server:BringPlayer",
        perms = "mod",
    },
    ["revivePlayer"] = {
        label = "Revive Player",
        event = "ps-adminmenu:server:Revive",
        perms = "mod",
        type = "server"
    },
    ["banPlayer"] = {
        label = "Ban Player",
        event = "ps-adminmenu:server:BanPlayer",
        perms = "mod",
        type = "server"
    },
    ["kickPlayer"] = {
        label = "Kick Player",
        event = "ps-adminmenu:server:KickPlayer",
        perms = "mod",
        type = "server"
    }
}

Config.OtherActions = {
    ["toggleDevmode"] = {
        type = "client",
        event = "ps-adminmenu:client:ToggleDev",
        perms = "admin",
        label = "Toggle Devmode"
    }
}

AddEventHandler("onResourceStart", function()
    Wait(100)
    if GetResourceState('ox_inventory') == 'started' then
        Config.Inventory = 'ox_inventory'
    elseif GetResourceState('rsg-inventory') == 'started' then
        Config.Inventory = 'rsg-inventory'
    end
end)
