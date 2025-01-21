-- Clear Inventory
RegisterNetEvent('ps-adminmenu:server:ClearInventory', function(player)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(player)
    if not Player then
        return lib.notify(src, { title = locale("not_online"), type =  'error', duration = 7500})
    end

    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:ClearInventory(player)
    else
        exports[Config.Inventory]:ClearInventory(Player.PlayerData.source, nil)
    end
    
    lib.notify(src, {title = locale("invcleared", Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname), type =  'success', duration = 7500})
end)


-- Clear Inventory Offline
RegisterNetEvent('ps-adminmenu:server:ClearInventoryOffline', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source
    local citizenId = selectedData["Citizen ID"].value
    local Player = RSGCore.Functions.GetPlayerByCitizenId(citizenId)
    if Player then
        if Config.Inventory == 'ox_inventory' then
            exports.ox_inventory:ClearInventory(Player.PlayerData.source)
        else
            exports[Config.Inventory]:ClearInventory(Player.PlayerData.source, nil)
        end
        lib.notify(src, {title = locale("invcleared", Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname), type =  'success', duration = 7500})

    else
        MySQL.Async.fetchAll("SELECT * FROM players WHERE citizenid = @citizenid", { ['@citizenid'] = citizenId },
            function(result)
                if result and result[1] then
                    MySQL.Async.execute("UPDATE players SET inventory = '{}' WHERE citizenid = @citizenid",
                        { ['@citizenid'] = citizenId })
                    lib.notify(src, { title = "Player's inventory cleared", type = 'success', duration =  7500})
                else
                    lib.notify(src, {title = locale("player_not_found"), type =  'error', duration = 7500})

                end
            end)
    end
end)

-- Open Inv [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenInv', function(player)
    local src = source
    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:forceOpenInventory(src, 'player', data)
    else
        exports['rsg-inventory']:OpenInventoryById(src, player)
    end
end)

-- Open Stash [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenStash', function(data)
    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:forceOpenInventory(source, 'stash', data)
    else
    exports['rsg-inventory']:OpenInventory(source, tostring(data))
    end
end)

-- Open Trunk [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenTrunk', function(data)
    exports.ox_inventory:forceOpenInventory(source, 'trunk', data)
end)

-- Give Item
RegisterNetEvent('ps-adminmenu:server:GiveItem', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local target = selectedData["Player"].value
    local item = selectedData["Item"].value
    local amount = selectedData["Amount"].value
    local Player = RSGCore.Functions.GetPlayer(target)

    if not item or not amount then return end
    if not Player then
        return lib.notify(source, { title = locale("not_online"), type =  'error', duration = 7500})
    end

    Player.Functions.AddItem(item, amount)
        lib.notify(source, { title = locale("give_item", tonumber(amount) .. " " .. item,
        Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname), type =  "success", duration = 7500})
end)

-- Give Item to All
RegisterNetEvent('ps-adminmenu:server:GiveItemAll', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local item = selectedData["Item"].value
    local amount = selectedData["Amount"].value
    local players = RSGCore.Functions.GetPlayers()

    if not item or not amount then return end

    for _, id in pairs(players) do
        local Player = RSGCore.Functions.GetPlayer(id)
        Player.Functions.AddItem(item, amount)
        lib.notify(source, { title = locale("give_item_all", amount .. " " .. item), type =  "success", duration = 7500})
        
    end
end)
