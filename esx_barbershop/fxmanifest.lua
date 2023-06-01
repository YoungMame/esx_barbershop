fx_version 'adamant'

game 'gta5'

-- RageUI V2

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    "client/cl_main.lua",
    "client/clientcar.lua"
}


shared_script {
    "config.lua",
    '@es_extended/imports.lua',
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/server.lua",


}

