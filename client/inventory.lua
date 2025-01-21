-- Open Inventory
RegisterNetEvent('ps-adminmenu:client:openInventory', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local player = selectedData["Player"].value
    TriggerServerEvent("ps-adminmenu:server:OpenInv", player)
end)

-- Open Stash
RegisterNetEvent('ps-adminmenu:client:openStash', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local stash = selectedData["Stash"].value
    TriggerServerEvent("ps-adminmenu:server:OpenStash", stash)
end)

RegisterNetEvent('ps-adminmenu:client:ClearInventory', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    print('hiii')
    local src = source
    local player = selectedData["Player"].value
    TriggerServerEvent("ps-adminmenu:server:ClearInventory", player)

end)