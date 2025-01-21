local function getPlayers()
    local players = {}
    local GetPlayers = RSGCore.Functions.GetRSGPlayers()
    local vehicles = {}
    for k, v in pairs(GetPlayers) do
        local playerData = v.PlayerData

        players[#players + 1] = {
            id = k,
            name = playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname,
            cid = playerData.citizenid,
            license = RSGCore.Functions.GetIdentifier(k, 'license'),
            discord = RSGCore.Functions.GetIdentifier(k, 'discord'),
            steam = RSGCore.Functions.GetIdentifier(k, 'steam'),
            job = playerData.job.label,
            grade = playerData.job.grade.level,
            dob = playerData.charinfo.birthdate,
            cash = playerData.money.cash,
            bank = playerData.money.bank,
            phone = '03173889040',
            vehicles = vehicles
        }
    end

    table.sort(players, function(a, b) return a.id < b.id end)

    return players
end

lib.callback.register('ps-adminmenu:callback:GetPlayers', function(source)
    return getPlayers()
end)

-- Set Job
RegisterNetEvent('ps-adminmenu:server:SetJob', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local src = source
    local playerId, Job, Grade = selectedData["Player"].value, selectedData["Job"].value, selectedData["Grade"].value
    local Player = RSGCore.Functions.GetPlayer(playerId)
    local name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local jobInfo = RSGCore.Shared.Jobs[Job]
    local grade = jobInfo["grades"][selectedData["Grade"].value]

    if not jobInfo then
        lib.notify(src, { title = 'Not a valid job', type = 'error', duration = 7500})
        return
    end

    if not grade then
        lib.notify(src, { title = 'Not a valid grade', type = 'error', duration = 7500})
        return
    end

    Player.Functions.SetJob(tostring(Job), tonumber(Grade))

    lib.notify(src, { title = locale("jobset", name, Job, Grade), type = 'success', duration = 7500})

end)

-- Set Gang
RegisterNetEvent('ps-adminmenu:server:SetGang', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local src = source
    local playerId, Gang, Grade = selectedData["Player"].value, selectedData["Gang"].value, selectedData["Grade"].value
    local Player = RSGCore.Functions.GetPlayer(playerId)
    local name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local GangInfo = RSGCore.Shared.Gangs[Gang]
    local grade = GangInfo["grades"][selectedData["Grade"].value]

    if not GangInfo then
        lib.notify(src, { title = 'Not a valid Gang', type = 'error', duration = 7500})
        return
    end

    if not grade then
        lib.notify(src, { title = 'Not a valid grade', type = 'error', duration = 7500})
        return
    end

    Player.Functions.SetGang(tostring(Gang), tonumber(Grade))
    lib.notify(src, { title = locale("gangset", name, Gang, Grade), type = 'success', duration = 7500})

end)

-- Set Perms
RegisterNetEvent("ps-adminmenu:server:SetPerms", function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local src = source
    local rank = selectedData["Permissions"].value
    local targetId = selectedData["Player"].value
    local tPlayer = RSGCore.Functions.GetPlayer(tonumber(targetId))

    if not tPlayer then
        lib.notify(src, { title = locale("not_online"), type = 'error', duration = 7500})

        return
    end

    local name = tPlayer.PlayerData.charinfo.firstname .. ' ' .. tPlayer.PlayerData.charinfo.lastname

    RSGCore.Functions.AddPermission(tPlayer.PlayerData.source, tostring(rank))
    lib.notify(tPlayer.PlayerData.source, {title = locale("player_perms", name, rank), type = 'success', duration = 7500})

end)

-- Remove Stress
RegisterNetEvent("ps-adminmenu:server:RemoveStress", function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local src = source
    local targetId = selectedData['Player (Optional)'] and tonumber(selectedData['Player (Optional)'].value) or src
    local tPlayer = RSGCore.Functions.GetPlayer(tonumber(targetId))

    if not tPlayer then
        lib.notify(tPlayer.PlayerData.source, {title = locale("not_online"), type = 'error', duration = 7500})
        return
    end

    TriggerClientEvent('ps-adminmenu:client:removeStress', targetId)

    lib.notify(tPlayer.PlayerData.source, {title = locale("removed_stress_player"), type = 'success', duration = 7500})
end)
