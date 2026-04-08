

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'jp-evidence'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'ox_lib',
    'ox_inventory',
    'qbx_core'
}