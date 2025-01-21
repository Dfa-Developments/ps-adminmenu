local function noPerms(source)
    lib.notify(source, {title = "You are not Admin or God.", type = 'error'})
end

--- @param perms string
function CheckPerms(source, perms)
    local hasPerms = RSGCore.Functions.HasPermission(source, perms)
    if not hasPerms then
        return noPerms(source)
    end

    return hasPerms
end

function CheckDataFromKey(key)
    local actions = Config.Actions[key]
    if actions then
        local data = nil

        if actions.event then
            data = actions
        end

        if actions.dropdown then
            for _, v in pairs(actions.dropdown) do
                if v.event then
                    local new = v
                    new.perms = actions.perms
                    data = new
                    break
                end
            end
        end

        return data
    end

    local playerActions = Config.PlayerActions[key]
    if playerActions then
        return playerActions
    end

    local otherActions = Config.OtherActions[key]
    if otherActions then
        return otherActions
    end
end

lib.callback.register('ps-adminmenu:callback:CheckPerms', function(source, perms)
    return CheckPerms(source, perms)
end)


--- @param source number
--- @param target number
function CheckRoutingbucket(source, target)
    local sourceBucket = GetPlayerRoutingBucket(source)
    local targetBucket = GetPlayerRoutingBucket(target)

    if sourceBucket == targetBucket then return end

    SetPlayerRoutingBucket(source, targetBucket)
    lib.notify(source, { title = locale("bucket_set", targetBucket), type = 'error', duration = 5000})
end
