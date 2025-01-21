    local function CopyCoords(data)
    local coords = GetEntityCoords(cache.ped)
    local heading = GetEntityHeading(cache.ped)
    local formats = { vector2 = "%.2f, %.2f", vector3 = "%.2f, %.2f, %.2f", vector4 = "%.2f, %.2f, %.2f, %.2f", heading = "%.2f" }
    local format = formats[data]

    local values = {coords.x, coords.y, coords.z, heading}
    if printListEnabled then
        local coordString = string.format(format, table.unpack(values, 1, #values))
        table.insert(coordsList, coordString)
    else
        lib.setClipboard(string.format(format, table.unpack(values, 1, #format)))
    end
end



local isPlayerIdsEnabled = false
local playerGamerTags = {}
local distanceToCheck = 150  

local fivemGamerTagCompsEnum = {
    GamerName = 0,
    HealthArmour = 2,
    AudioIcon = 4,
}

local redmGamerTagCompsEnum = {
    none = 0,
    icon = 1,
    complex = 3,
}

local redmSpeakerIconHash = GetHashKey('SPEAKER')
local redmColorYellowHash = GetHashKey('COLOR_YELLOWSTRONG')


local function cleanAllGamerTags()
    for _, v in pairs(playerGamerTags) do
        if IsMpGamerTagActive(v.gamerTag) then
            if IS_FIVEM then
                RemoveMpGamerTag(v.gamerTag)
            else
                Citizen.InvokeNative(0x839BFD7D7E49FE09, Citizen.PointerValueIntInitialized(v.gamerTag))
            end
        end
    end
    playerGamerTags = {}
end


local function setGamerTagFivem(targetTag, pid)
  
    SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.GamerName, 1)

   
    SetMpGamerTagHealthBarColor(targetTag, 129)
    SetMpGamerTagAlpha(targetTag, fivemGamerTagCompsEnum.HealthArmour, 255)
    SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.HealthArmour, 1)

   
    SetMpGamerTagAlpha(targetTag, fivemGamerTagCompsEnum.AudioIcon, 255)
    if NetworkIsPlayerTalking(pid) then
        SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.AudioIcon, true)
        SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.AudioIcon, 12) 
        SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.GamerName, 12) 
    else
        SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.AudioIcon, false)
        SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.AudioIcon, 0)
        SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.GamerName, 0)
    end
end



local function setGamerTagRedm(targetTag, pid)
    Citizen.InvokeNative(0x93171DDDAB274EB8, targetTag, redmGamerTagCompsEnum.complex) 
    if MumbleIsPlayerTalking(pid) then
        Citizen.InvokeNative(0x95384C6CE1526EFF, targetTag, redmSpeakerIconHash)      
        Citizen.InvokeNative(0x84BD27DDF9575816, targetTag, redmColorYellowHash)       
    else
        Citizen.InvokeNative(0x95384C6CE1526EFF, targetTag, nil)                       
        Citizen.InvokeNative(0x84BD27DDF9575816, targetTag, 0)                        
    end
end


local function clearGamerTagRedm(targetTag)
    Citizen.InvokeNative(0x93171DDDAB274EB8, targetTag, redmGamerTagCompsEnum.none)
end

local setGamerTagFunc = IS_FIVEM and setGamerTagFivem or setGamerTagRedm
local clearGamerTagFunc = IS_FIVEM and clearGamerTagFivem or clearGamerTagRedm

local function showGamerTags()
    local curCoords = GetEntityCoords(PlayerPedId())
    local allActivePlayers = GetActivePlayers()

    for _, pid in ipairs(allActivePlayers) do
        local targetPed = GetPlayerPed(pid)

        if
            not playerGamerTags[pid]
            or playerGamerTags[pid].ped ~= targetPed 
            or not IsMpGamerTagActive(playerGamerTags[pid].gamerTag)
        then
            local playerName = string.sub(GetPlayerName(pid) or "unknown", 1, 75)
            local playerStr = '[' .. GetPlayerServerId(pid) .. '] ' .. playerName
            playerGamerTags[pid] = {
                gamerTag = CreateFakeMpGamerTag(targetPed, playerStr, false, false, 0),
                ped = targetPed
            }
        end
        local targetTag = playerGamerTags[pid].gamerTag


        local targetPedCoords = GetEntityCoords(targetPed)
        if #(targetPedCoords - curCoords) <= distanceToCheck then
            setGamerTagFunc(targetTag, pid)
        else
            clearGamerTagFunc(targetTag)
        end
    end
end


local function createGamerTagThread()
    CreateThread(function()
        while isPlayerIdsEnabled do
            showGamerTags()
            Wait(250)
        end


        cleanAllGamerTags()
    end)
end


function toggleShowPlayerIDs(enabled)
    isPlayerIdsEnabled = enabled
    if isPlayerIdsEnabled then
        createGamerTagThread()
    else
        cleanAllGamerTags()
    end
    print('Show Player IDs Status: ' .. tostring(isPlayerIdsEnabled))
end

RegisterNetEvent('ps-adminmenu:client:toggleNames', function ()
    toggleShowPlayerIDs(not isPlayerIdsEnabled)
end)

RSGCore.Commands.Add('names', {}, {}, false, function(source, args)
    local src = source
    TriggerClientEvent('ps-adminmenu:client:toggleNames', src)
end, 'mod')