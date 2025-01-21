-- Changes the time
RegisterNetEvent('ps-adminmenu:client:ChangeTime', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local time = selectedData["Time Events"].value

    if not time then return end
    
    TriggerServerEvent('weathersync:setTime', time, 00, 00, 00)
end)

-- Changes the weather
RegisterNetEvent('ps-adminmenu:client:ChangeWeather', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local weather = selectedData["Weather"].value
    TriggerServerEvent('weathersync:setWeather', weather)
end)

RegisterNetEvent('ps-adminmenu:client:copyToClipboard', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local dropdown = selectedData["Copy Coords"].value
    local ped = PlayerPedId()
    local string = nil
    if dropdown == 'vector2' then
        local coords = GetEntityCoords(ped)
        local x = RSGCore.Shared.Round(coords.x, 2)
        local y = RSGCore.Shared.Round(coords.y, 2)
        string = "vector2(".. x ..", ".. y ..")"
        lib.notify({title = locale("copy_vector2"), type = 'success'})
    elseif dropdown == 'vector3' then
        local coords = GetEntityCoords(ped)
        local x = RSGCore.Shared.Round(coords.x, 2)
        local y = RSGCore.Shared.Round(coords.y, 2)
        local z = RSGCore.Shared.Round(coords.z, 2)
        string = "vector3(".. x ..", ".. y ..", ".. z ..")"
        lib.notify({title = locale("copy_vector3"), type = 'success'})

    elseif dropdown == 'vector4' then
        local coords = GetEntityCoords(ped)
        local x = RSGCore.Shared.Round(coords.x, 2)
        local y = RSGCore.Shared.Round(coords.y, 2)
        local z = RSGCore.Shared.Round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = RSGCore.Shared.Round(heading, 2)
        string = "vector4(".. x ..", ".. y ..", ".. z ..", ".. h ..")"
        lib.notify({title = locale("copy_vector4"), type = 'success'})

    elseif dropdown == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = RSGCore.Shared.Round(heading, 2)
        string = h
        lib.notify({title = locale("copy_heading"), type = 'success'})

    elseif string == nil then 
        lib.notify({title = locale("empty_input"), type = 'error'})
    end

    lib.setClipboard(string)

end)