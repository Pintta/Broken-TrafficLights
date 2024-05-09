if Config.qbcore then
    local QBCore = exports['qb-core']:GetCoreObject()
    local RealReacting = math.random(3500, 5000)
    local CheckingTime = math.random(1000, 2500)
    
    RegisterNetEvent('qb-NaturalTrafficLights:c:setLight', function(coords)
        local Liikennevalot = {
            [0] = 0x3e2b73a4,
            [1] = 0x336e5e2a,
            [2] = 0xd8eba922,
            [3] = 0xd4729f50,
            [4] = 0x272244b2,
            [5] = 0x33986eae,
            [6] = 0x2323cdc5
        }
        for _, Liikennevalo in pairs(Liikennevalot) do
            trafficLight = GetClosestObjectOfType(coords, 1.0, Liikennevalo, false, false, false)
            if trafficLight ~= 0 then
                SetEntityTrafficlightOverride(trafficLight, 0)
                Wait(RealReacting)
                SetEntityTrafficlightOverride(trafficLight, -1)
                break
            end
        end
    end)
    
    local function translateVector3(pos, angle, distance)
        local angleRad = angle * 2.0 * math.pi / 360.0
        return vector3(pos.x - distance * math.sin(angleRad), pos.y + distance * math.cos(angleRad), pos.z)
    end
    
    CreateThread(function()
        local lastTrafficLight = 0
        while true do
            Wait(CheckingTime)
            local player = GetPlayerPed(-1)
            if IsPedInAnyVehicle(player) and IsVehicleStopped(GetVehiclePedIsIn(player)) then
                local playerPosition = GetEntityCoords(player)
                local playerHeading = GetEntityHeading(player)
                local trafficLight = 0
                for searchDistance = 60.0, 20.0, -10.0 do
                    local HaeSijainti = translateVector3(playerPosition, playerHeading, searchDistance)
                    local Liikennevalot = {
                        [0] = 0x3e2b73a4,
                        [1] = 0x336e5e2a,
                        [2] = 0xd8eba922,
                        [3] = 0xd4729f50,
                        [4] = 0x272244b2,
                        [5] = 0x33986eae,
                        [6] = 0x2323cdc5
                    }
                    for _, Liikennevalo in pairs(Liikennevalot) do
                        trafficLight = GetClosestObjectOfType(HaeSijainti, 10.0, Liikennevalo, false, false, false)
                        if trafficLight ~= 0 then
                            local lightHeading = GetEntityHeading(trafficLight)
                            local headingDiff = math.abs(playerHeading - lightHeading)
                            if ((headingDiff < 20.0) or (headingDiff > (360.0 - 20.0))) then
                                break
                            else
                                trafficLight = 0
                            end
                        end
                    end
                    if trafficLight ~= 0 then
                        break
                    end
                end
                if (trafficLight ~= 0) and (trafficLight ~= lastTrafficLight) then
                    QBCore.Functions.TriggerCallback('qb-NaturalTrafficLights:s:setLight', GetEntityCoords(trafficLight, false), function(result)
                    end)
                    lastTrafficLight = trafficLight
                    Wait(RealReacting)
                end
            end
        end
    end)
end
