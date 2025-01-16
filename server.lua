

RegisterNetEvent("pe_halloween:spawnClownForPlayer")
AddEventHandler("pe_halloween:spawnClownForPlayer", function(targetPlayerId)
    local src = source
    if GetPlayerName(targetPlayerId) then
        local playerCoords = GetEntityCoords(GetPlayerPed(targetPlayerId))
        TriggerClientEvent("pe_halloween:spawnClown", targetPlayerId, playerCoords)
        TriggerClientEvent("ox_lib:notify", src, {type = "success", description = "Clown was sent to a player with the ID: " .. targetPlayerId})
    else
        TriggerClientEvent("ox_lib:notify", src, {type = "error", description = "No player found with the specified ID."})
    end
end)

RegisterNetEvent("pe_halloween:spawnHellCarForPlayer")
AddEventHandler("pe_halloween:spawnHellCarForPlayer", function(targetPlayerId)
    local src = source
    if GetPlayerName(targetPlayerId) then
        local playerCoords = GetEntityCoords(GetPlayerPed(targetPlayerId))
        TriggerClientEvent("pe_halloween:spawnHellCar", targetPlayerId, playerCoords)
        TriggerClientEvent("ox_lib:notify", src, {type = "success", description = "The infernal car was sent to a player with ID: " .. targetPlayerId})
    else
        TriggerClientEvent("ox_lib:notify", src, {type = "error", description = "No player found with the specified ID."})
    end
end)

RegisterServerEvent('pe_halloween:spawnZombieForPlayer')
AddEventHandler('pe_halloween:spawnZombieForPlayer', function(targetPlayerId)
    local src = source
    if GetPlayerName(targetPlayerId) then
        local playerCoords = GetEntityCoords(GetPlayerPed(targetPlayerId))
        TriggerClientEvent('pe_halloween:spawnZombie', targetPlayerId, playerCoords)
        TriggerClientEvent("ox_lib:notify", src, {type = "success", description = "Zombies were sent to a player with the ID: " .. targetPlayerId})
    else
        TriggerClientEvent("ox_lib:notify", src, {type = "error", description = "No player found with the specified ID."})
    end
end)
