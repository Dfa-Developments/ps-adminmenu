-- Ban Player
RegisterNetEvent('ps-adminmenu:server:BanPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local player = selectedData["Player"].value
    local reason = selectedData["Reason"].value or ""
    local time = selectedData["Duration"].value

    local banTime = tonumber(os.time() + time)
    local timeTable = os.date('*t', banTime)

    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)',
        { GetPlayerName(player), RSGCore.Functions.GetIdentifier(player, 'license'), RSGCore.Functions.GetIdentifier(
            player, 'discord'), RSGCore.Functions.GetIdentifier(player, 'ip'), reason, banTime, GetPlayerName(source) })

    if time == 2147483647 then
        DropPlayer(player, locale("banned") .. '\n' .. locale("reason") .. reason .. locale("ban_perm"))
    else
        DropPlayer(player,
            locale("banned") ..
            '\n' ..
            locale("reason") ..
            reason ..
            '\n' ..
            locale("ban_expires") ..
            timeTable['day'] ..
            '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'])
    end

    lib.notify(source, {title = locale("playerbanned", player, banTime, reason), type = 'success', duration = 7500})

end)

-- Warn Player
RegisterNetEvent('ps-adminmenu:server:WarnPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local targetId = selectedData["Player"].value
    local target = RSGCore.Functions.GetPlayer(targetId)
    local reason = selectedData["Reason"].value
    local sender = RSGCore.Functions.GetPlayer(source)
    local warnId = 'WARN-' .. math.random(1111, 9999)
    if target ~= nil then
        lib.notify(target.PlayerData.source, {title = locale("warned") .. ", for: " .. locale("reason") .. ": " .. reason, type = 'inform', duration = 10000})
        lib.notify(source, {title = locale("warngiven") .. GetPlayerName(target.PlayerData.source) .. ", for: " .. reason, type = 'inform', duration = 10000})
        MySQL.insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)',
            {
                sender.PlayerData.license,
                target.PlayerData.license,
                reason,
                warnId
            })
    else
        lib.notify(source, {title = locale("not_online"), type = 'error'})

    end
end)

RegisterNetEvent('ps-adminmenu:server:KickPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local src = source
    local target = RSGCore.Functions.GetPlayer(selectedData["Player"].value)
    local reason = selectedData["Reason"].value

    if not target then
        lib.notify(src, {title = locale("not_online"), type = 'error', duration = 7500})
        return
    end

    DropPlayer(target.PlayerData.source, locale("kicked") .. '\n' .. locale("reason") .. reason)
end)

-- Revive Player
RegisterNetEvent('ps-adminmenu:server:Revive', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local player = selectedData["Player"].value

    TriggerClientEvent('rsg-medic:client:adminRevive', player)
end)

-- Revive All
RegisterNetEvent('ps-adminmenu:server:ReviveAll', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    TriggerClientEvent('rsg-medic:client:adminRevive', -1)
end)

-- Revive Radius
RegisterNetEvent('ps-adminmenu:server:ReviveRadius', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source
    local ped = GetPlayerPed(src)
    local pos = GetEntityCoords(ped)
    local players = RSGCore.Functions.GetPlayers()

    for k, v in pairs(players) do
        local target = GetPlayerPed(v)
        local targetPos = GetEntityCoords(target)
        local dist = #(pos - targetPos)

        if dist < 15.0 then
            TriggerClientEvent("rsg-medic:client:adminRevive", v)
        end
    end
end)

-- Set RoutingBucket
RegisterNetEvent('ps-adminmenu:server:SetBucket', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source
    local player = selectedData["Player"].value
    local bucket = selectedData["Bucket"].value
    local currentBucket = GetPlayerRoutingBucket(player)

    if bucket == currentBucket then
        return lib.notify(src, {title = locale("target_same_bucket", player), type = 'error', duration = 7500})
    end

    SetPlayerRoutingBucket(player, bucket)
    lib.notify(src, {title = locale("bucket_set_for_target", player, bucket), type = 'success', duration = 7500})

end)

-- Get RoutingBucket
RegisterNetEvent('ps-adminmenu:server:GetBucket', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source
    local player = selectedData["Player"].value
    local currentBucket = GetPlayerRoutingBucket(player)

    lib.notify(src, {title = locale("bucket_get", player, currentBucket), type = 'success', duration = 7500})

end)

-- Give Money
RegisterNetEvent('ps-adminmenu:server:GiveMoney', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source
    local target, amount, moneyType = selectedData["Player"].value, selectedData["Amount"].value,
        selectedData["Type"].value
    local Player = RSGCore.Functions.GetPlayer(tonumber(target))

    if Player == nil then
        return lib.notify(src, {title = locale("not_online"), type = 'error', duration = 7500})
    end

    Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
    lib.notify(src, {title = locale((moneyType == "crypto" and "give_money_crypto" or "give_money"), tonumber(amount), Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname), type = 'success', duration = 7500})
end)

-- Give Money to all
RegisterNetEvent('ps-adminmenu:server:GiveMoneyAll', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source
    local amount, moneyType = selectedData["Amount"].value, selectedData["Type"].value
    local players = RSGCore.Functions.GetPlayers()

    for _, v in pairs(players) do
        local Player = RSGCore.Functions.GetPlayer(tonumber(v))
        Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
        lib.notify(src, {title = locale((moneyType == "crypto" and "give_money_all_crypto" or "give_money_all"), tonumber(amount), Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname), type = 'success', duration = 7500})

    end
end)

-- Take Money
RegisterNetEvent('ps-adminmenu:server:TakeMoney', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source
    local target, amount, moneyType = selectedData["Player"].value, selectedData["Amount"].value,
        selectedData["Type"].value
    local Player = RSGCore.Functions.GetPlayer(tonumber(target))

    if Player == nil then
        return lib.notify(src, {title = locale("not_online"), type = 'error', duration = 7500})
    end

    if Player.PlayerData.money[moneyType] >= tonumber(amount) then
        Player.Functions.RemoveMoney(moneyType, tonumber(amount), "state-fees")
    else
        lib.notify(src, { title = locale('not_enough_money'), type = 'inform', duration = 7500})
    end

            lib.notify(src, { title = locale((moneyType == "crypto" and "take_money_crypto" or "take_money"), tonumber(amount) .. "$",
            Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname), type = 'success', duration = 7500})

end)

-- Blackout
local Blackout = false
RegisterNetEvent('ps-adminmenu:server:ToggleBlackout', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    Blackout = not Blackout

    local src = source

    if Blackout then
        lib.notify(src, { title = locale("blackout", "enabled"), type = 'inform', duration = 7500})
        while Blackout do
            Wait(0)
            exports["rsg-weathersync"]:setBlackout(true)
        end
        exports["rsg-weathersync"]:setBlackout(false)
        lib.notify(src, { title = locale("blackout", "disabled"), type = 'inform', duration = 7500})

    end
end)



-- Set Ped
RegisterNetEvent("ps-adminmenu:server:setPed", function(data, selectedData)
    local src = source
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then
        lib.notify(src, { title = locale("no_perms"), type = 'error', duration = 7500})
        return
    end

    local ped = selectedData["Ped Models"].label
    local tsrc = selectedData["Player"].value
    local Player = RSGCore.Functions.GetPlayer(tsrc)

    if not Player then
    lib.notify(src, { title = locale("not_online"), type = 'error', duration = 7500})

        return
    end

    TriggerClientEvent("ps-adminmenu:client:setPed", Player.PlayerData.source, ped)
end)
