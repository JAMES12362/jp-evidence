if not Config or not Config.EvidenceStorage or not Config.EvidenceStorage.Enabled then return end

local zones = {}
local showingText = false

CreateThread(function()
    for name, zone in pairs(Config.EvidenceStorage.Zones or {}) do
        if zone.coords then
            zones[#zones + 1] = {
                name = name,
                coords = zone.coords,
                stash = zone.stash or ('pdbonus_%s'):format(name),
                drawDistance = zone.drawDistance or 10.0,
                interactDistance = zone.interactDistance or 1.5,
                markerType = zone.markerType or 2,
                markerSize = zone.markerSize or vec3(0.35, 0.35, 0.35),
                markerColor = zone.markerColor or { r = 50, g = 150, b = 255, a = 180 }
            }
        end
    end
end)

RegisterNetEvent('jp-evidence:client:notify', function(data)
    data = data or {}

    lib.notify({
        title = data.title or Config.EvidenceStorage.EvidenceLabel or 'Evidence',
        description = data.description or '',
        type = data.type or 'inform',
        position = data.position or 'top',
        icon = data.icon or 'info'
    })
end)

local function hideText()
    if showingText then
        showingText = false
        lib.hideTextUI()
    end
end

CreateThread(function()
    while true do
        local wait = 1000
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)
        local closest

        for i = 1, #zones do
            local zone = zones[i]
            local distance = #(playerCoords - zone.coords)

            if distance <= zone.drawDistance then
                wait = 0
                closest = zone

                DrawMarker(
                    zone.markerType,
                    zone.coords.x,
                    zone.coords.y,
                    zone.coords.z - 0.95,
                    0.0, 0.0, 0.0,
                    0.0, 0.0, 0.0,
                    zone.markerSize.x,
                    zone.markerSize.y,
                    zone.markerSize.z,
                    zone.markerColor.r,
                    zone.markerColor.g,
                    zone.markerColor.b,
                    zone.markerColor.a,
                    false,
                    true,
                    2,
                    false,
                    nil,
                    nil,
                    false
                )

                if distance <= zone.interactDistance then
                    if not showingText then
                        showingText = true
                        lib.showTextUI('[E] Open Evidence')
                    end

                    if IsControlJustReleased(0, 38) then
                        exports.ox_inventory:openInventory('stash', zone.stash)
                    end

                    break
                end
            end
        end

        if not closest then
            hideText()
        elseif closest then
            local distance = #(playerCoords - closest.coords)

            if distance > closest.interactDistance then
                hideText()
            end
        end

        Wait(wait)
    end
end)
