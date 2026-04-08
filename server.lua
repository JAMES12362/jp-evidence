if not Config or not Config.EvidenceStorage or not Config.EvidenceStorage.Enabled then
    print('[jp-evidence] config missing')
    return
end

local storages = {}
local withdrawGrade = 7

local function getPlayer(src)
    return exports.qbx_core:GetPlayer(src)
end

local function getGrade(src)
    local player = getPlayer(src)
    if not player then return end

    local job = player.PlayerData and player.PlayerData.job
    if not job or job.name ~= 'police' then return end

    local grade = job.grade

    if type(grade) == 'table' then
        return tonumber(grade.level or grade.grade or grade.rank) or 0
    end

    return tonumber(grade) or 0
end

local function canWithdraw(src)
    local grade = getGrade(src)
    return grade and grade >= withdrawGrade
end

local function getPrice(item)
    local list = Config.EvidenceStorage.ItemPayouts or {}

    if list[item] and list[item].price then
        return list[item].price
    end

    return (list.DEFAULT and list.DEFAULT.price) or 0
end

local function getCops()
    local players = exports.qbx_core:GetQBPlayers()
    local cops = {}

    for id, player in pairs(players) do
        local job = player.PlayerData and player.PlayerData.job
        if job and job.name == 'police' and job.onduty then
            cops[#cops + 1] = tonumber(id)
        end
    end

    return cops
end

local function getInv(id)
    return exports.ox_inventory:GetInventory(id)
end

local function getValue(stash)
    local inv = getInv(stash)
    if not inv or not inv.items then return 0, {} end

    local total = 0

    for _, item in pairs(inv.items) do
        if item and item.name and item.count > 0 then
            total = total + (getPrice(item.name) * item.count)
        end
    end

    total = math.floor(total * (Config.EvidenceStorage.PayoutMultiplier or 1.0))

    return total, inv.items
end

local function clear(stash, items)
    for _, item in pairs(items) do
        if item and item.slot and item.count > 0 then
            exports.ox_inventory:RemoveItem(stash, item.name, item.count, item.metadata, item.slot)
        end
    end
end

local function format(num)
    return tostring(num):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

local function pay(total)
    local cops = getCops()
    if #cops == 0 or total <= 0 then return false end

    local split = math.floor(total / #cops)
    if split <= 0 then return false end

    local fSplit = format(split)
    local fTotal = format(total)

    for i = 1, #cops do
        local src = cops[i]
        local player = getPlayer(src)

        if player and player.Functions then
            player.Functions.AddMoney('bank', split, 'evidence')

            TriggerClientEvent('jp-evidence:client:notify', src, {
                title = 'Evidence',
                description = ('£%s received\nTotal: £%s'):format(fSplit, fTotal),
                type = 'success',
                position = 'top',
                icon = 'money-bill'
            })
        end
    end

    print(('[jp-evidence] paid %s cops £%s'):format(#cops, fSplit))
    return true
end

local function process(zone)
    local data = storages[zone]
    if not data or data.busy then return end

    data.busy = true

    local total, items = getValue(data.stash)

    if total > 0 then
        if pay(total) then
            clear(data.stash, items)
        end
    end

    data.busy = false
end

CreateThread(function()
    for zone in pairs(Config.EvidenceStorage.Zones) do
        local stash = ('pdbonus_%s'):format(zone)

        storages[zone] = {
            stash = stash,
            busy = false
        }

        print('[jp-evidence] ready: ' .. stash)

        CreateThread(function()
            while true do
                Wait(Config.EvidenceStorage.AutoBonusPayoutTimer)
                process(zone)
            end
        end)
    end
end)

exports.ox_inventory:registerHook('swapItems', function(payload)
    local src = payload.source
    local from = payload.fromInventory
    local id = type(from) == 'table' and from.id or from

    if type(id) == 'string' and id:find('pdbonus_') then
        if not canWithdraw(src) then
            TriggerClientEvent('jp-evidence:client:notify', src, {
                title = 'Evidence',
                description = 'Rank too low to withdraw',
                type = 'error',
                position = 'top',
                icon = 'ban'
            })
            return false
        end
    end

    return true
end, {
    inventoryFilter = { '^pdbonus_' }
})

RegisterCommand('processevidence', function(src, args)
    if src ~= 0 then return end

    local zone = args[1]
    if not zone then
        print('processevidence [zone]')
        return
    end

    process(zone)
end, true)