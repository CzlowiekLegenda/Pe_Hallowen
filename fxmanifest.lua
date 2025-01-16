fx_version 'cerulean'
game 'gta5'

author 'CzlowiekLegenda'
description 'A script to disrupt players in the game'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    'clown_menu.lua',
    'client.lua',
    'Hell_car.lua',
    'zombie.lua'
}

server_script 'server.lua'

dependencies {
    'ox_lib'
}

files {
    'sounds/clown_ambient.ogg',
    'sounds/zombie.ogg',
    'html/index.html'
}
