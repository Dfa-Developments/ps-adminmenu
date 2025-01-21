local PedList = require "data.ped"

-- Returns a list of vehicles from RSGCore.Shared.Vehicles
local function GetVehicles()
    local vehicles = {}

    for _, v in pairs(RSGCore.Shared.Vehicles) do
        vehicles[#vehicles + 1] = { label = v.name, value = v.model }
    end

    return vehicles
end

-- Returns a list of items from RSGCore.Shared.Items
local function GetItems()
    local items = {}
    local ItemsData = RSGCore.Shared.Items

    if Config.Inventory == "ox_inventory" then
        ItemsData = exports.ox_inventory:Items()
    end

    for name, v in pairs(ItemsData) do
        items[#items + 1] = { label = v.label, value = name }
    end

    return items
end

-- Returns a list of jobs from RSGCore.Shared.Jobs
local function GetJobs()
    local jobs = {}

    for name, v in pairs(RSGCore.Shared.Jobs) do
        local gradeDataList = {}

        for grade, gradeData in pairs(v.grades) do
            gradeDataList[#gradeDataList + 1] = { name = gradeData.name, grade = grade, isboss = gradeData.isboss }
        end

        jobs[#jobs + 1] = { label = v.label, value = name, grades = gradeDataList }
    end

    return jobs
end

-- Returns a list of gangs from RSGCore.Shared.Gangs
local function GetGangs()
    local gangs = {}

    for name, v in pairs(RSGCore.Shared.Gangs) do
        local gradeDataList = {}

        for grade, gradeData in pairs(v.grades) do
            gradeDataList[#gradeDataList + 1] = { name = gradeData.name, grade = grade, isboss = gradeData.isboss }
        end

        gangs[#gangs + 1] = { label = v.label, value = name, grades = gradeDataList }
    end

    return gangs
end

-- Returns a list of locations from RSGCore.Shared.Loactions
local function GetLocations()
    local locations = {}

    for name, v in pairs(RSGCore.Shared.Locations) do
        locations[#locations + 1] = { label = name, value = v }
    end

    return locations
end

-- Sends data to the UI on resource start
function GetData()
    SendNUIMessage({
        action = "data",
        data = {
            vehicles = GetVehicles(),
            items = GetItems(),
            jobs = GetJobs(),
            gangs = GetGangs(),
            locations = GetLocations(),
            pedlist = PedList
        },
    })
end
