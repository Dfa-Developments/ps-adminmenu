RSGCore = exports['rsg-core']:GetCoreObject()

lib.addCommand('admin', {
    help = 'Open the admin menu',
    restricted = 'RSGCore.mod'
}, function(source)
    if not RSGCore.Functions.IsOptin(source) then lib.notify(source, { title = 'You are not on admin duty', type = 'error', duration = 5000}); return end
    TriggerClientEvent('ps-adminmenu:client:OpenUI', source)
end)
-- Callbacks