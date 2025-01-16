local function openClownMenu()
    exports.ox_lib:registerContext({
        id = 'clown_menu',
        title = '🎃 Hallowenowe Menu 🎃',
        options = {
            {
                title = '🤡 Clown Revenge 🤡',
                description = 'Select a player ID to respawn a clown',
                onSelect = function()
                    local input = exports.ox_lib:inputDialog('Enter Player ID', {
                        {
                            type = 'number',
                            label = 'ID Player',
                            default = 1,
                            min = 1,
                            required = true
                        }
                    })
                    if input then
                        local targetPlayerId = tonumber(input[1])
                        TriggerServerEvent('pe_halloween:spawnClownForPlayer', targetPlayerId)
                    end
                end
            },
            {
                title = '🔥 Infernal Car 🔥',
                description = 'Select a player ID to respawn the infernal car',
                onSelect = function()
                    local input = exports.ox_lib:inputDialog('Enter Player ID', {
                        {
                            type = 'number',
                            label = 'ID Player',
                            default = 1,
                            min = 1,
                            required = true
                        }
                    })
                    if input then
                        local targetPlayerId = tonumber(input[1])
                        TriggerServerEvent('pe_halloween:spawnHellCarForPlayer', targetPlayerId)
                    end
                end
            },
            {
                title = '👻 Attack Undead Zombies 👻',
                description = 'Select player ID to respawn zombies',
                onSelect = function()
                    local input = exports.ox_lib:inputDialog('Enter Player ID', {
                        {
                            type = 'number',
                            label = 'ID Player',
                            default = 1,
                            min = 1,
                            required = true
                        }
                    })
                    if input then
                        local targetPlayerId = tonumber(input[1])
                        TriggerServerEvent('pe_halloween:spawnZombieForPlayer', targetPlayerId)
                    end
                end
            }
        }
    })

    -- Wyświetlanie menu
    exports.ox_lib:showContext('clown_menu')
end

-- Komenda otwierająca menu
RegisterCommand("Hallowen", function()
    print("Otwieranie menu Halloween")
    openClownMenu()
end, false)
