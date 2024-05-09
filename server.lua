if switcher.qbcore then
    local QBCore = exports['qb-core']:GetCoreObject()
    
    QBCore.Functions.CreateCallback('qb-NaturalTrafficLights:s:setLight', function(coords)
        TriggerClientEvent('qb-NaturalTrafficLights:c:setLight', -1, coords)
    end)
else
    return
end

if switcher.esx then
    RegisterNetEvent('Broken-TrafficLights:s:setLight', function(coords)
        TriggerClientEvent('Broken-TrafficLights:c:setLight', -1, coords)
    end)
else
    return
end
