shared_script '@vrp_basic_menu/ai_module_fg-obfuscated.lua'
shared_script '@vrp_basic_menu/shared_fg-obfuscated.lua'
--[[
_____/\\\\\\\\\____________________________________/\\\\\\\\\___________________        
 ___/\\\\\\\\\\\\\________________________________/\\\///////\\\_________________       
  __/\\\/////////\\\______________________________\/\\\_____\/\\\_________________      
   _\/\\\_______\/\\\__/\\\____/\\\_____/\\\\\\\\__\/\\\\\\\\\\\/________/\\\\\____     
    _\/\\\\\\\\\\\\\\\_\///\\\/\\\/____/\\\/////\\\_\/\\\//////\\\______/\\\///\\\__    
     _\/\\\/////////\\\___\///\\\/_____/\\\\\\\\\\\__\/\\\____\//\\\____/\\\__\//\\\_   
      _\/\\\_______\/\\\____/\\\/\\\___\//\\///////___\/\\\_____\//\\\__\//\\\__/\\\__  
       _\/\\\_______\/\\\__/\\\/\///\\\__\//\\\\\\\\\\_\/\\\______\//\\\__\///\\\\\/___ 
        _\///________\///__\///____\///____\//////////__\///________\///_____\/////_____ ]]--



fx_version 'bodacious'
game 'gta5'
title 'Advanced Inventory System with Slots'
author 'AleX (AxeRo)'
lua54 'yes'

ui_page "nui/ui.html"

client_scripts{ 
  "@vrp/lib/Tunnel.lua",
  "@vrp/lib/Proxy.lua",
  'client/nui.lua',
  'client/client.lua'
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server/server.lua",
  "server/functions.lua",
  "server/add_on.lua"
}

escrow_ignore {
  'config/lang.lua',
  'config/config.lua',
  'config/items.lua',
  'config/functions.lua',
  'config/weapons.lua',
}

shared_scripts {
  'config/config.lua',
  'config/*.lua',
}

files {
  'nui/ui.html',
  'nui/css/*.css',
  'nui/js/*.js',
  'nui/assets/*.png',
  'nui/assets/items/*.png',
  'nui/assets/clothes/*.png',
  'nui/fonts/*.*'
}
