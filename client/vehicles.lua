RegisterNetEvent('ps-adminmenu:client:horseoptions', function()
    local option = {}
    for i = 1, #Config.AdminHorse do
        local name = Config.AdminHorse[i].horsename
        local hash = Config.AdminHorse[i].horsehash
        local content = { value = hash, label = name }
        option[#option + 1] = content
    end

    local input = lib.inputDialog('Spawn Admin Horse', {
        { type = 'select', options = option, required = true, default = 'Arabian White' }
    })
    if not input then return end

    TriggerEvent('ps-adminmenu:client:spawnhorse', input[1])

end)


RegisterNetEvent('ps-adminmenu:client:spawnhorse', function(HorseHash)
    local pos = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 3.0, 0.0)
    local heading = GetEntityHeading(cache.ped)
    local hash = HorseHash
    if not IsModelInCdimage(hash) then return end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end

    local horsePed = CreatePed(hash, pos.x, pos.y, pos.z -1, heading, true, false)
    TaskMountAnimal(cache.ped, horsePed, 10000, -1, 1.0, 1, 0, 0)
    SetRandomOutfitVariation(horsePed, true)
    EnableAttributeOverpower(horsePed, 0, 5000.0) -- health overpower
    EnableAttributeOverpower(horsePed, 1, 5000.0) -- stamina overpower
    EnableAttributeOverpower(horsePed, 0, 5000.0) -- set health with overpower
    EnableAttributeOverpower(horsePed, 1, 5000.0) -- set stamina with overpower
    SetPlayerOwnsMount(cache.ped, horsePed)
    ApplyShopItemToPed(horsePed, -447673416, true, true, true) -- add saddle
    NetworkSetEntityInvisibleToNetwork(horsePed, true)
end)



-- Get Vehicle Data
lib.callback.register("ps-adminmenu:client:getvehData", function(vehicle)
    lib.requestModel(vehicle)

    local coords = vec(GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 2.0, 0.5), GetEntityHeading(cache.ped) + 90)
    local veh = CreateVehicle(vehicle, coords, false, false)

    local prop = {}
    if DoesEntityExist(veh) then
        SetEntityCollision(veh, false, false)
        FreezeEntityPosition(veh, true)
        prop = RSGCore.Functions.GetVehicleProperties(veh)
        Wait(500)
        DeleteVehicle(veh)
    end

    return prop
end)
