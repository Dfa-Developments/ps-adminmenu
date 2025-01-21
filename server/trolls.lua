-- Freeze Player
local frozen = false
RegisterNetEvent('ps-adminmenu:server:FreezePlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local src = source

    local target = selectedData["Player"].value

    local ped = GetPlayerPed(target)
    local Player = RSGCore.Functions.GetPlayer(target)

    if not frozen then
        frozen = true
        FreezeEntityPosition(ped, true)
        lib.notify(src, { title = locale("Frozen", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " | " .. Player.PlayerData.citizenid), type = 'Success', duration = 5000})
    else
        frozen = false
        FreezeEntityPosition(ped, false)
        lib.notify(src, { title = locale("deFrozen", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " | " .. Player.PlayerData.citizenid), type = 'Success', duration = 5000})
    end
    if Player == nil then return lib.notify(src, { title = locale("not_online"), type = 'error', duration = 5000}) end
end)

-- Drunk Player
RegisterNetEvent('ps-adminmenu:server:DrunkPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source
    local target = selectedData["Player"].value
    local targetPed = GetPlayerPed(target)
    local Player = RSGCore.Functions.GetPlayer(target)

    if not Player then
        return lib.notify(src, { title = locale("not_online"), type = 'error', duration = 5000})
    end

    TriggerClientEvent('ps-adminmenu:client:InitiateDrunkEffect', target)
    lib.notify(src, { title = locale("playerdrunk", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " | " .. Player.PlayerData.citizenid), type = 'Success', duration = 5000})
end)
