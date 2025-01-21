-- Mute Player
RegisterNetEvent("ps-adminmenu:client:MutePlayer", function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local playerId = selectedData["Player"].value
    if not playerId then return end
    exports["pma-voice"]:toggleMutePlayer(playerId)
end)

-- Remove Stress
RegisterNetEvent('ps-adminmenu:client:removeStress', function(data)
    TriggerServerEvent('hud:server:RelieveStress', 100)
end)
