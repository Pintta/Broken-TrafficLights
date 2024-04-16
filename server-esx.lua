RegisterNetEvent('Broken-TrafficLights:s:setLight', function(coords)
    TriggerClientEvent('Broken-TrafficLights:c:setLight', -1, coords)
end)
