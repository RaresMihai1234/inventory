Config                          = {}
Config.Command                  = 'inventory'
Config.giveItemCommand          = 'giveitem'
Config.clearInventoryCommand    = 'clearinventory'
Config.Keybind                  = 'I'
Config.Sql                      = 'oxmysql'
Config.usersTable               = 'vrp_users'
Config.vehiclesTable            = 'vrp_user_vehicles'
Config.defaultPlayerMaxWeight   = 30.0
Config.defaultTrunkMaxWeight    = 30.0
Config.defaultGloveboxMaxWeight = 5.0
Config.canUseInventory = true
Config.defaultChestMaxWeight    = 50.0
Config.ammoWeight               = 0.01
Config.componentsWeight         = 0.01
Config.unequipComponentsCommand = 'strangeatasamente'
Config.unequipComponentsTime    = 10 -- time in seconds
Config.autoReloadAmmo           = false;
Config.debug = true;
Config.backpacks                = {
    ['rucsac'] = 10,
    ['rucsac2'] = 20,
    ['rucsac3'] = 30
}

Config.backpacksClothes         = {
    ['rucsac'] = { id = 40, color = 0 },
    ['rucsac2'] = { id = 41, color = 0 },
    ['rucsac3'] = { id = 45, color = 0 },
}

Config.allowedChestType         = {
    ['house-chest'] = true,
    ['police-chest'] = true,
    ['mafia-chest'] = true,
}

Config.staticChests             = {
    {
        coords = vector3(77.511177062988, 3706.1704101562, 40.313079833984), -- coords x,y,z
        name = 'Seif Sinaloa',                                               -- chestName
        faction = 'Cartel de Sinaloa',                                       -- faction access
        group = nil,                                                         -- group access
        permission = nil,                                                    -- permission access
        chestId = 'sinaloa-chest:1',                                         -- chestId
        type = 'mafia-chest',                                                -- chestType to acces the chest(neet to match Config.allowedChestType data)
        accessDist = 1.0,                                                    -- access distance in meters
        accessKey = 38,                                                      -- key code from https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        marker = 6,                                                          -- marker code from https://docs.fivem.net/docs/game-references/markers/
        markerColor = { 255, 255, 255 },                                     -- {r,g,b} color
        chestWeight = 200,
    },
    {
        coords = vector3(-1887.548828125, 2069.6442871094, 145.57383728027), -- coords x,y,z
        name = 'Seif Sindicat',                                              -- chestName
        faction = 'Sindicat',                                                -- faction access
        group = nil,                                                         -- group access
        permission = nil,                                                    -- permission access
        chestId = 'sindicat-chest:1',                                        -- chestId
        type = 'mafia-chest',                                                -- chestType to acces the chest(neet to match Config.allowedChestType data)
        accessDist = 1.0,                                                    -- access distance in meters
        accessKey = 38,                                                      -- key code from https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        marker = 6,                                                          -- marker code from https://docs.fivem.net/docs/game-references/markers/
        markerColor = { 255, 255, 255 },                                     -- {r,g,b} color
        chestWeight = 350,
    },
    {
        coords = vector3(-2609.4484863281, 1707.3063964844, 142.37255859375), -- coords x,y,z
        name = 'Seif Russian Bratva',                                         -- chestName
        faction = 'Russian Bratva',                                           -- faction access
        group = nil,                                                          -- group access
        permission = nil,                                                     -- permission access
        chestId = 'russianbratva-chest:1',                                    -- chestId
        type = 'mafia-chest',                                                 -- chestType to acces the chest(neet to match Config.allowedChestType data)
        accessDist = 1.0,                                                     -- access distance in meters
        accessKey = 38,                                                       -- key code from https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        marker = 6,                                                           -- marker code from https://docs.fivem.net/docs/game-references/markers/
        markerColor = { 255, 255, 255 },                                      -- {r,g,b} color
        chestWeight = 500,
    },
    {
        coords = vector3(790.07061767578, 3404.7707519531, 57.884166717529), -- coords x,y,z
        name = 'Seif Mafia Yakuza',                                          -- chestName
        faction = 'Mafia Yakuza',                                            -- faction access
        group = nil,                                                         -- group access
        permission = nil,                                                    -- permission access
        chestId = 'mafiayakuza-chest:1',                                     -- chestId
        type = 'mafia-chest',                                                -- chestType to acces the chest(neet to match Config.allowedChestType data)
        accessDist = 1.0,                                                    -- access distance in meters
        accessKey = 38,                                                      -- key code from https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        marker = 6,                                                          -- marker code from https://docs.fivem.net/docs/game-references/markers/
        markerColor = { 255, 255, 255 },                                     -- {r,g,b} color
        chestWeight = 500,
    },
    {
        coords = vector3(-3348.8876953125, 570.61767578125, 17.175205230713), -- coords x,y,z
        name = 'Seif Mafia Cocalari',                                          -- chestName
        faction = 'Cocalari',                                                  -- faction access
        group = nil,                                                         -- group access
        permission = nil,                                                    -- permission access
        chestId = 'mafiacocalari-chest:1',                                     -- chestId
        type = 'mafia-chest',                                                -- chestType to acces the chest(neet to match Config.allowedChestType data)
        accessDist = 1.0,                                                    -- access distance in meters
        accessKey = 38,                                                      -- key code from https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        marker = 6,                                                          -- marker code from https://docs.fivem.net/docs/game-references/markers/
        markerColor = { 255, 255, 255 },                                     -- {r,g,b} color
        chestWeight = 500,
    },
    {
        coords = vector3(1378.4621582031, 4701.1967773438, 134.84019470215), -- coords x,y,z
        name = 'Seif Toretto',                                               -- chestName
        faction = 'Toretto',                                                 -- faction access
        group = nil,                                                         -- group access
        permission = nil,                                                    -- permission access
        chestId = 'toretto-chest:1',                                         -- chestId
        type = 'mafia-chest',                                                -- chestType to acces the chest(neet to match Config.allowedChestType data)
        accessDist = 1.0,                                                    -- access distance in meters
        accessKey = 38,                                                      -- key code from https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        marker = 6,                                                          -- marker code from https://docs.fivem.net/docs/game-references/markers/
        markerColor = { 255, 255, 255 },                                     -- {r,g,b} color
        chestWeight = 500,
    },
    {
        coords = vector3(1391.4898681641, 1158.8814697266, 114.33354949951), -- coords x,y,z
        name = 'Seif Castellanos',                                         -- chestName
        faction = 'Castellanos Cartel',                                    -- faction access
        group = nil,                                                       -- group access
        permission = nil,                                                  -- permission access
        chestId = 'castellanos-chest:1',                                   -- chestId
        type = 'mafia-chest',                                              -- chestType to acces the chest(neet to match Config.allowedChestType data)
        accessDist = 1.0,                                                  -- access distance in meters
        accessKey = 38,                                                    -- key code from https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        marker = 6,                                                        -- marker code from https://docs.fivem.net/docs/game-references/markers/
        markerColor = { 255, 255, 255 },                                   -- {r,g,b} color
        chestWeight = 500,
    },
    -- {
    --     coords = vector3(-3348.8876953125, 570.61767578125, 17.175205230713), -- coords x,y,z
    --     name = 'Seif Ballas',                                               -- chestName
    --     faction = 'Ballas',                                                 -- faction access
    --     group = nil,                                                        -- group access
    --     permission = nil,                                                   -- permission access
    --     chestId = 'ballas-chest:1',                                         -- chestId
    --     type = 'mafia-chest',                                               -- chestType to acces the chest(neet to match Config.allowedChestType data)
    --     accessDist = 1.0,                                                   -- access distance in meters
    --     accessKey = 38,                                                     -- key code from https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
    --     marker = 6,                                                         -- marker code from https://docs.fivem.net/docs/game-references/markers/
    --     markerColor = { 255, 255, 255 },                                    -- {r,g,b} color
    --     chestWeight = 500,
    -- },
    {
        coords = vector3(3417.9113769531, 4950.9765625, 36.001106262207), -- coords x,y,z
        name = 'Seif Sicario',                                          -- chestName
        faction = 'Sicario',                                            -- faction access
        group = nil,                                                    -- group access
        permission = nil,                                               -- permission access
        chestId = 'sicario-chest:1',                                    -- chestId
        type = 'mafia-chest',                                           -- chestType to acces the chest(neet to match Config.allowedChestType data)
        accessDist = 1.0,                                               -- access distance in meters
        accessKey = 38,                                                 -- key code from https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        marker = 6,                                                     -- marker code from https://docs.fivem.net/docs/game-references/markers/
        markerColor = { 255, 255, 255 },                                -- {r,g,b} color
        chestWeight = 500,
    },
}

Config.vehiclesTrunkWeight      = {
    ["giulia"] = 50,
    ["1310s"] = 50,
    ["4c"] = 50,
    ["pounder"] = 500,
    ["tz3"] = 50,
    ["stelvio"] = 50,
    ["8c"] = 50,
    ["alfmito"] = 50,
    ["gt37"] = 50,
    ["agta"] = 50,
    ["ardv"] = 50,
    ["gtv6"] = 50,
    ["ast"] = 50,
    ["db11"] = 50,
    ["rs7"] = 50,
    ["r820"] = 50,
    ["a8audi"] = 50,
    ["audirs6tk"] = 50,
    ["a6avant"] = 50,
    ["rs318"] = 50,
    ["rs52018"] = 50,
    ["audiq8"] = 50,
    ["a8fsi"] = 50,
    ["audquattros"] = 50,
    ["b5s4"] = 50,
    ["c5rs6"] = 50,
    ["ttrs"] = 50,
    ["as7"] = 50,
    ["bbentayga"] = 50,
    ["ben17"] = 50,
    ["contgt13"] = 50,
    ["850"] = 50,
    ["440i"] = 50,
    ["530d"] = 50,
    ["m2"] = 50,
    ["m5e60"] = 50,
    ["bmwe90"] = 50,
    ["m3f80"] = 50,
    ["m6f13"] = 50,
    ["bmws"] = 50,
    ["m3e30"] = 50,
    ["745le"] = 50,
    ["s1000rr"] = 50,
    ["e34"] = 50,
    ["m3e36"] = 50,
    ["17m760i"] = 50,
    ["m516"] = 50,
    ["f82"] = 50,
    ["m4c"] = 50,
    ["48is"] = 50,
    ["bmwe39"] = 50,
    ["m5e26"] = 50,
    ["e46"] = 50,
    ["bugatti"] = 50,
    ["chiron17"] = 50,
    ["dinghy"] = 55,
    ["seashark3"] = 55,
    ["jetmax"] = 20,
    ["speeder"] = 55,
    ["squalo"] = 55,
    ["toro2"] = 55,
    ["tropic"] = 55,
    ["tug"] = 3000,
    ["frogger"] = 70,
    ["maverick"] = 70,
    ["volatus"] = 70,
    ["supervolito"] = 70,
    ["trailers2"] = 600,
    ["trflat"] = 300,
    ["trailers3"] = 310,
    ["tvtrailer"] = 300,
    ["trailers"] = 200,
    ["cuban800"] = 100,
    ["dodo"] = 120,
    ["luxor2"] = 250,
    ["mammatus"] = 100,
    ["nimbus"] = 600,
    ["velum2"] = 150,
    ["vestra"] = 130,
    ["sobol"] = 150,
    ["e15082"] = 150,
    ["speedo"] = 130,
    ["mule"] = 100,
    ["steed2"] = 100,
    ["nspeedo"] = 100,
    ["GC_23SPRINTSLMD"] = 500,
    ["youga3"] = 150,
    ["rumpo3"] = 150
}

Config.vehiclesGloveboxWeight   = {
    ["sultanrs"] = 8
}

Config.discord                  = {
    serverName = 'Cypher Fivem Server',
    logo =
    'https://cdn.discordapp.com/attachments/1174812571119931443/1294034920821493835/WHITE_BRAND_LABEL_LOGO.png?ex=67098b6f&is=670839ef&hm=33da72ce1fbedbdc1c19336520963cb830c9350dd632f0a2af4be174169e688b&'
}
Config.useJSLogs                = true -- if you want to use js logs or not
Config.discordLogs              = {
    giveItem =
    'https://discord.com/api/webhooks/1288437706149597187/ictNXJSWmqZYtQkank9k4r4LqvGVy59fvoDkpOdTv7FwMCEQbiWQOgqICF0KKJcA7cH3',
    clearInventory =
    'https://discord.com/api/webhooks/1294456590963048478/0SrCGa-61c4u_yVuRba-6vxsD_7bUD6Z_1jc_RL4dKXcbJ3688UFOPkFebhW6bdPAxvL',
    dropItem =
    'https://discord.com/api/webhooks/1288437757693399051/2W__07aMnakpDtcsMg9Mhy0L9flopVxMekMletfGf7qO46Lxvotbh45rToPrauy0MeSg',
    giveItemToPlayer =
    'https://discord.com/api/webhooks/1288437706149597187/ictNXJSWmqZYtQkank9k4r4LqvGVy59fvoDkpOdTv7FwMCEQbiWQOgqICF0KKJcA7cH3',
    useItem =
    'https://discord.com/api/webhooks/1288437643935354932/Gkfb8eTCltTxHPQPn2bMlvTtN3jcXWNqNg9I4jq7ywZ8NpB6gcgDjYKxnZ6IHzfQ2xNo',
    unequipComponents =
    'https://discord.com/api/webhooks/1315278251869999185/4uDzLX8pyqIr5se2SW3D0Pz5066qMe5BgVfdhwqT42XuoWzJFeKmdM-smXmzV4H-tn38',

    -- js logs bellow
    putItemInTrunk =
    'https://discord.com/api/webhooks/1315278251869999185/4uDzLX8pyqIr5se2SW3D0Pz5066qMe5BgVfdhwqT42XuoWzJFeKmdM-smXmzV4H-tn38',
    getItemFromTrunk =
    'https://discord.com/api/webhooks/1315278251869999185/4uDzLX8pyqIr5se2SW3D0Pz5066qMe5BgVfdhwqT42XuoWzJFeKmdM-smXmzV4H-tn38',
    putItemInGlovebox =
    'https://discord.com/api/webhooks/1315278251869999185/4uDzLX8pyqIr5se2SW3D0Pz5066qMe5BgVfdhwqT42XuoWzJFeKmdM-smXmzV4H-tn38',
    getItemFromGlovebox =
    'https://discord.com/api/webhooks/1315278251869999185/4uDzLX8pyqIr5se2SW3D0Pz5066qMe5BgVfdhwqT42XuoWzJFeKmdM-smXmzV4H-tn38',
    putItemInChest =
    'https://discord.com/api/webhooks/1315278251869999185/4uDzLX8pyqIr5se2SW3D0Pz5066qMe5BgVfdhwqT42XuoWzJFeKmdM-smXmzV4H-tn38',
    getItemFromChest =
    'https://discord.com/api/webhooks/1315278251869999185/4uDzLX8pyqIr5se2SW3D0Pz5066qMe5BgVfdhwqT42XuoWzJFeKmdM-smXmzV4H-tn38',
    getItemFromPlayerInventory =
    'https://discord.com/api/webhooks/1315278251869999185/4uDzLX8pyqIr5se2SW3D0Pz5066qMe5BgVfdhwqT42XuoWzJFeKmdM-smXmzV4H-tn38',
    putItemInPlayerInventory =
    'https://discord.com/api/webhooks/1315278251869999185/4uDzLX8pyqIr5se2SW3D0Pz5066qMe5BgVfdhwqT42XuoWzJFeKmdM-smXmzV4H-tn38'
}
