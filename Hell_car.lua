RegisterNetEvent("pe_halloween:spawnHellCar")
AddEventHandler("pe_halloween:spawnHellCar", function(playerCoords)
    print("Odebrano event pe_halloween:spawnHellCar na kliencie.")
    
    local carModel = GetHashKey("speedo2")
    local driverModel = GetHashKey("s_m_y_clown_01")

    RequestModel(carModel)
    RequestModel(driverModel)
    
    local startTime = GetGameTimer()
    while not HasModelLoaded(carModel) or not HasModelLoaded(driverModel) do
        Citizen.Wait(200)
        if GetGameTimer() - startTime > 5000 then
            print("Nie udało się załadować modelu samochodu lub kierowcy.")
            return
        end
    end
    print("Model samochodu i model kierowcy załadowany pomyślnie.")

    local angle = math.random() * 2 * math.pi
    local distance = math.random(30, 40)
    local xOffset = math.cos(angle) * distance
    local yOffset = math.sin(angle) * distance
    local spawnCoords = vector3(playerCoords.x + xOffset, playerCoords.y + yOffset, playerCoords.z)

    local hellCar = CreateVehicle(carModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, false)
    if not DoesEntityExist(hellCar) then
        print("Nie udało się zrespić piekielnego samochodu.")
        return
    end
    print("Piekielny samochód zrespiony pomyślnie.")

    SetEntityAsMissionEntity(hellCar, true, true)
    SetVehicleEngineOn(hellCar, true, true, false)
    SetVehicleLights(hellCar, 2)
    SetVehicleBrakeLights(hellCar, true)

    local driverPed = CreatePedInsideVehicle(hellCar, 4, driverModel, -1, true, true)
    SetDriverAbility(driverPed, 1.0)
    SetDriverAggressiveness(driverPed, 1.0)


    local playerPed = PlayerPedId()
    TaskVehicleMissionPedTarget(driverPed, hellCar, playerPed, 6, 100.0, 786468, 0.0, 0.0, true) 


    Citizen.CreateThread(function()
        while DoesEntityExist(hellCar) and not IsEntityDead(playerPed) do
            local playerCoords = GetEntityCoords(playerPed)
            local carCoords = GetEntityCoords(hellCar)
            local distance = #(playerCoords - carCoords)


            if distance < 15 then
                StartVehicleHorn(hellCar, 1000, "NORMAL", false)
                StartEntityFire(hellCar)
            else
                StopEntityFire(hellCar)
            end

            Citizen.Wait(250)

            if IsEntityDead(playerPed) or IsEntityDead(hellCar) then
                DeleteEntity(hellCar)
                DeleteEntity(driverPed)
                print("Piekielny samochód przestał ścigać.")
                break
            end
        end
    end)
end)
