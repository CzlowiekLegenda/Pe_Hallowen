local isClownLaughPlaying = false  
local isAmbientPlaying = false     

RegisterNetEvent("pe_halloween:spawnClown")
AddEventHandler("pe_halloween:spawnClown", function(playerCoords)

    local clownModel = GetHashKey("s_m_y_clown_01")
    

    local weapons = {
        "WEAPON_KNIFE",
        "WEAPON_MACHETE",
        "WEAPON_HATCHET",
        "WEAPON_BATTLEAXE",
        "WEAPON_CROWBAR"
    }


    RequestModel(clownModel)
    while not HasModelLoaded(clownModel) do
        Citizen.Wait(100)
    end


    local angle = math.random() * 2 * math.pi
    local distance = math.random(30, 40)
    local xOffset = math.cos(angle) * distance
    local yOffset = math.sin(angle) * distance
    local spawnCoords = vector3(playerCoords.x + xOffset, playerCoords.y + yOffset, playerCoords.z)


    local clownPed = CreatePed(4, clownModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, true)
    

    StopPedSpeaking(clownPed, true)
    DisablePedPainAudio(clownPed, true)


    local randomWeapon = weapons[math.random(#weapons)]
    GiveWeaponToPed(clownPed, GetHashKey(randomWeapon), 1, false, true) -- 

    if not isClownLaughPlaying then
        isClownLaughPlaying = true
        SendNUIMessage({ action = "playClownLaugh" })
        Citizen.Wait(5000)
        isClownLaughPlaying = false
    end

    if not isAmbientPlaying then
        isAmbientPlaying = true
        SendNUIMessage({ action = "playClownAmbient" })
    end

    local startLookTime = GetGameTimer()
    local waitTime = math.random(5000, 10000)
    Citizen.CreateThread(function()
        while GetGameTimer() - startLookTime < waitTime do
            Citizen.Wait(500)
            local playerCoords = GetEntityCoords(PlayerPedId())
            TaskLookAtCoord(clownPed, playerCoords.x, playerCoords.y, playerCoords.z, 500, 0, 2)
        end
        TaskCombatPed(clownPed, PlayerPedId(), 0, 16)
    end)

    Citizen.CreateThread(function()
        while DoesEntityExist(clownPed) do
            Citizen.Wait(1000)
            if IsEntityDead(clownPed) or IsEntityDead(PlayerPedId()) then
                SendNUIMessage({ action = "stopClownAmbient" })
                isAmbientPlaying = false
                break
            end
        end
    end)

    Citizen.CreateThread(function()
        while DoesEntityExist(clownPed) do
            Citizen.Wait(1000)
            if IsEntityDead(PlayerPedId()) then
                DeleteEntity(clownPed)
                SendNUIMessage({ action = "stopClownAmbient" })
                isAmbientPlaying = false
                break
            end
        end
    end)
end)





local isHoldingG = false

-- Nasłuchiwanie na naciśnięcie klawisza G
CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, 47) then -- Klawisz G (kod 47)
            if not isHoldingG then
                isHoldingG = true
                StartSnowballCrafting()
            end
        else
            isHoldingG = false
        end
    end
end)

function StartSnowballCrafting()
    -- Animacja lepienia śnieżki
    PlaySnowballAnimation()

    -- Wywołanie serwera do dodania broni i jej wyposażenia
    TriggerServerEvent('equipAndDrawSnowballWeapon')
end

function PlaySnowballAnimation()
    local ped = PlayerPedId()
    RequestAnimDict("anim@mp_snowball")
    while not HasAnimDictLoaded("anim@mp_snowball") do
        Wait(100)
    end
    TaskPlayAnim(ped, "anim@mp_snowball", "pickup_snowball", 8.0, -8.0, 2000, 1, 0, false, false, false)

    -- Odczekaj na zakończenie animacji
    Wait(2000)
end

