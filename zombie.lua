RegisterNetEvent("pe_halloween:spawnZombie")
AddEventHandler("pe_halloween:spawnZombie", function(playerCoords, zombieCount)
    local zombieModel = GetHashKey("u_m_y_zombie_01")
    RequestModel(zombieModel)

    local startTime = GetGameTimer()
    while not HasModelLoaded(zombieModel) do
        Citizen.Wait(200)
        if GetGameTimer() - startTime > 5000 then
            return
        end
    end

    for i = 1, (zombieCount or 1) do
        local angle = math.random() * 2 * math.pi
        local distance = math.random(5, 10)
        local xOffset = math.cos(angle) * distance
        local yOffset = math.sin(angle) * distance
        local spawnCoords = vector3(playerCoords.x + xOffset, playerCoords.y + yOffset, playerCoords.z)

        local zombie = CreatePed(4, zombieModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, false)
        if not DoesEntityExist(zombie) then
            return
        end

        SetEntityAsMissionEntity(zombie, true, true)
        SetPedCanRagdoll(zombie, false)
        SetPedCombatAttributes(zombie, 46, true)
        StopPedSpeaking(zombie, true)
        DisablePedPainAudio(zombie, true)

        TaskCombatPed(zombie, PlayerPedId(), 0, 16)

        SendNUIMessage({
            action = "playZombieSound"
        })

        Citizen.CreateThread(function()
            local zombieLifeTime = 15000
            local spawnTime = GetGameTimer()

            while DoesEntityExist(zombie) and (GetGameTimer() - spawnTime < zombieLifeTime) do
                local playerPos = GetEntityCoords(PlayerPedId())
                local distanceToPlayer = #(playerPos - GetEntityCoords(zombie))

                if distanceToPlayer > 20.0 then
                    DeleteEntity(zombie)
                    print("Zombie zostało usunięte.")
                    break
                end
                Citizen.Wait(500)
            end

            if DoesEntityExist(zombie) then
                DeleteEntity(zombie)
                print("Zombie zniknęło po upływie czasu.")
            end

            SendNUIMessage({
                action = "stopZombieSound"
            })
        end)
    end
end)
