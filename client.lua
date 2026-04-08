if not Config or not Config.EvidenceStorage or not Config.EvidenceStorage.Enabled then
    return
end

RegisterNetEvent('jp-evidence:client:notify', function(data)
    if not data then return end

    lib.notify({
        title = data.title or 'Evidence',
        description = data.description or '',
        type = data.type or 'inform',
        position = data.position or 'top',
        icon = data.icon or 'info'
    })
end)