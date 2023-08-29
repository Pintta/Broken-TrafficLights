local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-NaturalTrafficLights:s:setLight', function(coords)
    TriggerClientEvent('qb-NaturalTrafficLights:c:setLight', -1, coords)
end)
