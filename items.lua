Items = {
    ['water'] = {
        name = 'Apa Plata 0.5l',
        weight = 0.5,
        description = 'Apa plata necarbogazoasa 0.5l',
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.drinkWater(user_id, source, item, -10);
        end,
    },

    ['apa'] = {
        name = 'Apa Plata 0.5l',
        weight = 0.5,
        description = 'Apa plata necarbogazoasa 0.5l',
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.drinkWater(user_id, source, item, -10);
        end,
    },

    ['trusa_auto'] = {
        name = 'Trusa Auto',
        weight = 0.25,
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.Trusa(user_id, source, item);
        end,
    },
    ['binoclu'] = {
        name = 'Binoclu',
        weight = 0.1,
        description = 'Folosit sa vezi la departare',
        type = 'pocket',
        onUse = function(user_id, source, item, itemData)
            if user_id ~= nil then
                TriggerClientEvent('force-binoculars:client:toggleBinoculars', source)

             
            end
        end,
    },
 
    ['body_armor'] = {
        name = 'Armura',
        weight = 3.0,
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.UseArmor(user_id, source, item);
        end,
    },
    ['kebab'] = {
        name = 'Kebab',
        weight = 0.4,
        description = 'Fast Food',
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.eatFood(user_id, source, item, -10);
        end,
    },
    ['kitairride'] = {
        name = 'KIT Airride',
        weight = 1.0,
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.AirRideKit(user_id, source, item);
        end,
    },
    ['snickers'] = {
        name = 'Snickers',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -60);
        end,
    },
    
    ['adrenalina'] = {
        name = 'Adrenalina',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.useAdrenalina(user_id, source, item, -80);
        end,
    },

    ['coke'] = {
        name = 'Cocaina',
        weight = 0.02,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['mars'] = {
        name = 'Mars',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -80);
        end,
    },
    
    ['twix'] = {
        name = 'Twix',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -80);
        end,
    },
    
    ['mm'] = {
        name = 'M&M',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -80);
        end,
    },
    
    ['milka'] = {
        name = 'Milka',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -45);
        end,
    },
    
    ['poiana'] = {
        name = 'Poiana',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -80);
        end,
    },
    
    ['kitkat'] = {
        name = 'KitKat',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -60);
        end,
    },
    
    ['rom'] = {
        name = 'Rom',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -60);
        end,
    },
    
    ['lion'] = {
        name = 'Lion',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -65);
        end,
    },
    
    ['bounty'] = {
        name = 'Bounty',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -80);
        end,
    },
    
    ['tacos'] = {
        name = 'Tacos',
        weight = 0.1,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -30);
        end,
    },
    
    ['shaorma'] = {
        name = 'Shaorma',
        weight = 0.1,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -30);
        end,
    },
    
    ['sandwich'] = {
        name = 'Sandwich',
        weight = 0.1,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -30);
        end,
    },
    
    -- Fruits
    
    ['mar'] = {
        name = 'Mar',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -80);
        end,
    },
    
    ['para'] = {
        name = 'Para',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -80);
        end,
    },
    
    ['banana'] = {
        name = 'Banana',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -80);
        end,
    },
    
    ['kiwi'] = {
        name = 'Kiwi',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -80);
        end,
    },
    
    ['piersica'] = {
        name = 'Piersica',
        weight = 0.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -80);
        end,
    },
    
    -- Chips
    
    ['lays'] = {
        name = 'Chipsuri Lays',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -30);
        end,
    },
    
    ['chio'] = {
        name = 'Chipsuri Chio',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -30);
        end,
    },
    
    ['pringles'] = {
        name = 'Cipsuri Pringles',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -40);
        end,
    },
    
    ['star'] = {
        name = 'Chipsuri Star',
        weight = 0.15,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -15);
        end,
    },
    
    ['vodka'] = {
        name = 'Vodka',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -60);
        end,
    },
    
    ['whiskey'] = {
        name = 'Whiskey',
        weight = 0.7,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -60);
        end,
    },
    
    ['tequila'] = {
        name = 'Tequila',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -60);
        end,
    },
    
    ['bere'] = {
        name = 'Bere',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -60);
        end,
    },
    
    ['beer'] = {
        name = 'Bere',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -60);
        end,
    },

    ['vinalb'] = {
        name = 'Vin Alb',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -60);
        end,
    },
    
    ['vinrosu'] = {
        name = 'Vin Rosu',
        weight = 1.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -60);
        end,
    },
    
    ['vinrose'] = {
        name = 'Vin Rose',
        weight = 1.5,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -60);
        end,
    },
    
    -- BAUTURI (Drinks)
    
    ['milk'] = {
        name = 'Lapte',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -50);
        end,
    },
    
    ['coffee'] = {
        name = 'Cafea',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -40);
        end,
    },
    
    ['tea'] = {
        name = 'Ceai',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -40);
        end,
    },
    
    ['icetea'] = {
        name = 'Ice-Tea',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -40);
        end,
    },
    
    ['orangejuice'] = {
        name = 'Suc de Portocale',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -60);
        end,
    },
    
    ['cola'] = {
        name = 'Coca Cola',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -40);
        end,
    },
    
    ['fanta'] = {
        name = 'Fanta',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -40);
        end,
    },
    
    ['sprite'] = {
        name = 'Sprite',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -40);
        end,
    },
    ['spikestrips'] = {
        name = 'Spikes',
        weight = 0.1,
        description = 'Folosite pentru a sparge cauciucurile masinilor',
        type = 'pocket',
        onUse = function(user_id, source, item, itemData)
            if user_id ~= nil then
                TriggerClientEvent('zerolag:spikestrips', source)
                exports.axr_inventory:removePlayerItem(user_id, 'spikestrips', 1, true, 'folositrope')

             
            end
        end,
    },
    ['schweppes'] = {
        name = 'Schweppes',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -40);
        end,
    },
    
    ['redgull'] = {
        name = 'RedBull',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -40);
        end,
    },
    
    ['lemonlimonad'] = {
        name = 'Limonada',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.drinkWater(user_id, source, item, -40);
        end,
    },
    
    ['gogoasag'] = {
        name = 'Gogoasa Glazurata',
        weight = 0.2,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -30);
        end,
    },
    
    ['gogoasas'] = {
        name = 'Gogoasa Simpla',
        weight = 0.2,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -30);
        end,
    },
    
    ['gogoasan'] = {
        name = 'Gogoasa cu Nuttela',
        weight = 0.25,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -30);
        end,
    },
    
    ['gogoasac'] = {
        name = 'Gogoasa cu Capsuni',
        weight = 0.2,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -30);
        end,
    },
    
    ['gogoasaz'] = {
        name = 'Gogoasa cu Zmeura',
        weight = 0.3,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -30);
        end,
    },
    
    ['gogoasab'] = {
        name = 'Gogoasa cu Banana',
        weight = 0.1,
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.eatFood(user_id, source, item, -30);
        end,
    },
    ['medkit'] = {
        name = 'Trusa medicala',
        weight = 1.0,
        type = 'all',
        onUse = ' ',
    },

    ['buletin'] = {
        name = 'Buletin',
        weight = 0.01,
        description = 'Act de identitate national',
        type = 'act',
        onUse = function(user_id, source, item, itemData)
            print("show buletin")
            -- edit with your function
        end,
    },
    ['rucsac'] = {
        name = 'Rucsac Mic',
        weight = 0.45,
        description = 'Rucsac Mic',
        type = 'all',
        onUse = 'false',
    },
    ['rucsac2'] = {
        name = 'Rucsac Mediu',
        weight = 1.0,
        description = 'Rucsac Mediu',
        type = 'all',
        onUse = 'false',
    },
    ['rucsac3'] = {
        name = 'Rucsac Mare',
        weight = 1.5,
        description = 'Rucsac Mare',
        type = 'all',
        onUse = 'false',
    },
    ['seeds'] = {
        name = 'Seminte',
        weight = 0.2,
        description = 'Niste seminte misterioase',
        type = 'all',
        onUse = 'false',
    },
    ['credit'] = {
        name = 'Card-uri de Credit furate',
        weight = 0.2,
        description = 'Card-uri de Credit furate care pot fi transformate in Buletine Ilegale la Falsificator',
        type = 'all',
        onUse = 'false',
    },
    ['bank_money'] = {
        name = 'Bani de Banca',
        weight = 0,
        description = '$',
        type = 'all',
        onUse = 'false',
    },
    ['trash'] = {
        name = 'Gunoi',
        weight = 0,
        description = 'Pute a hoit!',
        type = 'all',
        onUse = 'false',
    },
    ['fake_id'] = {
        name = 'Buletin Falsificat',
        weight = 0,
        description = 'Scrie un nume pe el Hmmm...',
        type = 'all',
        onUse = 'false',
    },
    ['cigarette'] = {
        name = 'Tigara cu Ciuperci',
        weight = 0.1,
        description = 'Tigari cu ciuperci pentru viata usoara.',
        type = 'all',
        onUse = 'false',
    },
    ['pctcntb'] = {
        name = 'Pachet tigari de contrabanda',
        weight = 0.05,
        description = 'Pachet ce contine tigari de contrabanda',
        type = 'all',
        onUse = 'false',
    },

    ['bandajmic'] = {
        name = 'bandaj mic',
        weight = 0.2,
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.bandajmic(user_id, source, item);
        end,
    },

    ['atxcoin'] = {
        name = 'Atx Coin',
        weight = 0.1,
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.atxcoin(user_id, source, item);
        end,
    },

    ['bandajmediu'] = {
        name = 'bandajm ediu',
        weight = 0.4,
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.bandajmediu(user_id, source, item);
        end,
    },

    ['bandajmare'] = {
        name = 'bandaj mare',
        weight = 0.4,
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.bandajmare(user_id, source, item);
        end,
    },


    ['AK47'] = {
        name = 'AK47',
        weight = 0.4,
        description = 'Un masterpeice de Rusia.',
        type = 'all',
        onUse = 'false',
    },
    ['DB'] = {
        name = 'Deagle',
        weight = 0.4,
        description = 'Deagle',
        type = 'all',
        onUse = 'false',
    },
    ['M4A1'] = {
        name = 'M4A1',
        weight = 0.4,
        description = 'Un masterpiece de America.',
        type = 'all',
        onUse = 'false',
    },
    ['rinichi'] = {
        name = 'Rinichi',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['stick'] = {
        name = 'Stick',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['id_card_f'] = {
        name = 'Id Card Fals',
        weight = 0.10,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['inima'] = {
        name = 'Inima',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['key_lspd'] = {
        name = 'Cheie Sectie',
        weight = 0.4,
        description = 'O cheie pentru sectia de politie',
        type = 'all',
        onUse = 'false',
    },
    ['ficat'] = {
        name = 'Ficat',
        weight = 1.0,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['ciuperca'] = {
        name = 'Ciuperci',
        weight = 1.0,
        description = 'Ciuperca pentru vanzare..',
        type = 'all',
        onUse = 'false',
    },
    ['tabloufrt'] = {
        name = 'Tablou',
        weight = 0,
        description = 'Deseu',
        type = 'all',
        onUse = 'false',
    },
    ['radarpd'] = {
        name = 'Radar Politie',
        weight = 0,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['fertilizer'] = {
        name = 'Fertilizator',
        weight = 0.05,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['dust'] = {
        name = 'Praf',
        weight = 0.05,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['secure_card'] = {
        name = 'Card de Securitate',
        weight = 1.0,
        description = 'Acest card se foloseste pentru jafuri',
        type = 'all',
        onUse = 'false',
    },
    ['asigurare'] = {
        name = 'Asigurare',
        weight = 0,
        description = 'Asigurare Auto',
        type = 'all',
        onUse = 'false',
    },
    ['undita'] = {
        name = 'Undita',
        weight = 0.01,
        description = 'Foloseste-o numai pe malul apei',
        type = 'all',
        onUse = 'false',
    },
    ['momeala'] = {
        name = 'Momeala',
        weight = 0.01,
        description = 'Ar trebui sa prinda ceva',
        type = 'all',
        onUse = 'false',
    },
    ['foarfece'] = {
        name = 'Foarfece',
        weight = 0.01,
        description = 'Foarfeca pentru jobul de ciupercar',
        type = 'all',
        onUse = 'false',
    },
    ['iphone'] = {
        name = 'iPhone',
        weight = 0.01,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['trusa_turbina'] = {
        name = 'Trusa Turbina',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['canistra_turbina'] = {
        name = 'Lichid Turbina',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
       -- PT MUZEU //
       ['pendul_antic'] = {
        name = 'Pendul Antic',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['ceas_antic'] = {
        name = 'Ceas Antic',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['radio_antic'] = {
        name = 'Radio Antic',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['compas_antic'] = {
        name = 'Compas Antic',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['lupa_antica'] = {
        name = 'Lupa Antică',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['brosa_din_rubin'] = {
        name = 'Brosă din Rubin',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['pana_de_aur'] = {
        name = 'Pana de Aur',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['colier_de_perle'] = {
        name = 'Colier de Perle',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['cufar_antic'] = {
        name = 'Cufăr Antic',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['cutie_cu_bijuterii'] = {
        name = 'Cutie cu Bijuterii',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['potasiu'] = {
        name = 'Potasiu',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['acidsulfuric'] = {
        name = 'Acid Sulfuric',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['sticla'] = {
        name = 'Sticlă',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },

    -- PT ARME - rare //
    ['teava_mk2'] = {
        name = 'Teava MK2',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['clever_mk2'] = {
        name = 'Clever MK2',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['incarcator_pistol_mk2'] = {
        name = 'Încărcător Pistol MK2',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['teava_tec'] = {
        name = 'Teava TEC',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['comp_tec'] = {
        name = 'Comp TEC',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['frame_tec'] = {
        name = 'Frame TEC',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['piese_microsmg'] = {
        name = 'Piese MicrosMG',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['accesorii_microsmg'] = {
        name = 'Accesorii MicrosMG',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['incarcator_microsmg'] = {
        name = 'Încărcător MicrosMG',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['teava_combatpistol'] = {
        name = 'Teava CombatPistol',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['incarcator_combatpistol'] = {
        name = 'Încărcător CombatPistol',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['frame_combatpistol'] = {
        name = 'Frame CombatPistol',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['kit_ar1'] = {
        name = 'Kit AR1',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['frame_ar1'] = {
        name = 'Frame AR1',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['frame_ar'] = {
        name = 'Frame AR',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['frame_ar2'] = {
        name = 'Frame AR2',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['accesorii_ar2'] = {
        name = 'Accesorii AR2',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['kit_ar2'] = {
        name = 'Kit AR2',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['suport_mg1'] = {
        name = 'Suport MG1',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['accesorii_mg1'] = {
        name = 'Accesorii MG1',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['frame_mg1'] = {
        name = 'Frame MG1',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['suport_mg2'] = {
        name = 'Suport MG2',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['accesorii_mg2'] = {
        name = 'Accesorii MG2',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['frame_mg2'] = {
        name = 'Frame MG2',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['teava_gusen'] = {
        name = 'Teava Gusen',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['comp_gusen'] = {
        name = 'Comp Gusen',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['frame_gusen'] = {
        name = 'Frame Gusen',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['teava_db'] = {
        name = 'Teava DB',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['comp_db'] = {
        name = 'Comp DB',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['frame_db'] = {
        name = 'Frame DB',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },



    ['cascutaradio'] = {
        name = 'Cascuta Radio',
        weight = 0.1,
        description = '',
        type = 'pocket',
        onUse = function(user_id, source, item, itemData)
            -- local user_id = vRP.getUserId({player})
            if user_id ~= nil then
                TriggerClientEvent('scully_radio:openRadio', source, 'default')
            end
            -- edit with your function
        end,
    },
    ['jewelry'] = {
        name = 'Bijuterie',
        weight = 0.01,
        description = 'Vindele pentru un banut frumos',
        type = 'all',
        onUse = 'false',
    },
    ['permisconducere'] = {
        name = 'Permis De Conducere',
        weight = 0.01,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['atestatuber'] = {
        name = 'Atestat Uber',
        weight = 0.01,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['permisportarma'] = {
        name = 'Permis De Port Arma',
        weight = 0.01,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['metal_detector'] = {
        name = 'Detector de Metale',
        weight = 0.10,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['fakeid'] = {
        name = 'Fake Id',
        weight = 0.10,
        description = 'Buletinul Fals',
        type = 'all',
        onUse = 'false',
    },
    ['proximity_mine'] = {
        name = 'Bomba',
        weight = 0.10,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['argint_stantat'] = {
        name = 'Argint',
        weight = 0.10,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['bani_murdari'] = {
        name = 'Bani Murdari',
        weight = 0.10,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['aur_stantat'] = {
        name = 'Aur Stanat',
        weight = 0.10,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['Pachet_de_coca'] = {
        name = 'Pachet de cocaina',
        weight = 0.10,
        description = 'Pachet de cocaina',
        type = 'all',
        onUse = 'false',
    },
    ['lab_card'] = {
        name = 'Card Coca',
        weight = 0.01,
        description = 'Card pentru a accesa laboratorul de cocaina',
        type = 'all',
        onUse = 'false',
    },
    ['zaruri'] = {
        name = 'Zaruri',
        weight = 0.05,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['stiuca'] = {
        name = 'Stiuca',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['caras'] = {
        name = 'Caras',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['guvid'] = {
        name = 'Guvid',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['somn'] = {
        name = 'Somn',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['platica'] = {
        name = 'Platica',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['crap'] = {
        name = 'Crap',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['salau'] = {
        name = 'Salau',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['biban'] = {
        name = 'Biban',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['somon'] = {
        name = 'Somon',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['Anghila_Electrica'] = {
        name = 'Peste Anghila Electrica',
        weight = 0.80,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['Payara'] = {
        name = 'Peste Payara',
        weight = 0.80,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['Paku'] = {
        name = 'Peste Paku',
        weight = 0.80,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['Aravana'] = {
        name = 'Peste Aravana',
        weight = 0.80,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['Pui_de_aligator'] = {
        name = 'Pui de aligator',
        weight = 0.80,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['Pui_de_Caiman'] = {
        name = 'Pui de Caiman',
        weight = 0.80,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['Arapaima'] = {
        name = 'Peste Arapaima',
        weight = 0.80,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['cocaina10g'] = {
        name = '10g Cocaina',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['cocaina1g'] = {
        name = '1g Cocaina',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -1);
        end,
    },
    ['drill'] = {
        name = 'Bormasina',
        weight = 0.1,
        description = 'Folosita sa spargi atm-uri',
        type = 'pocket',
        onUse = function(user_id, source, item, itemData)
            if user_id ~= nil then
                local atmcoords = {
                    {x = 174.12326049805, y = 6637.8901367188, z = 31.573083877563},
                    {x = -95.526062011719, y = 6457.0703125, z = 31.460357666016},
                    {x = -97.186416625977, y = 6455.451171875, z = 31.465986251831},
                    {x = -386.78561401367, y = 6046.0063476562, z = 31.501564025879}
                }
    
                local playerCoords = GetEntityCoords(GetPlayerPed(source))
                local maxDistance = 5.0
                local nearATM = false
    
                for _, coord in pairs(atmcoords) do
                    if #(playerCoords - vector3(coord.x, coord.y, coord.z)) <= maxDistance then
                        nearATM = true
                        break
                    end
                end
    
                if not nearATM then
                    vRPclient.notify(source, {"Trebuie sa fii langa un ATM pentru a folosi bormasina!"})
                    return
                end
    
                local cop = vRP.getOnlineUsersByFaction({'Politie'})
    
                vRPclient.getNearestVehicle(source, {5}, function(veh)
                    if vRP.isUserInFaction({user_id, 'Politie'}) then
                        vRPclient.notify(source, {"Nu poti folosi bormasina ca si politist"})
                    else
                        if #cop >= 5 then
                            if veh then
                                exports.axr_inventory:removePlayerItem(user_id, 'drill', 1, true, 'folositrope')
                                TriggerClientEvent('zero:gat', source)
                            else
                                vRPclient.notify(source, {"Trebuie sa ai o masina langa tine si ATM pentru a putea incepe jaful."})
                            end
                        else
                            vRPclient.notify(source, {"Nu sunt destui politisti in oras"})
                        end
                    end
                end)
            end
        end,
    },
    
    ['blowtorch'] = {
        name = 'Torta cu flacara',
        weight = 0.2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['folieplastic'] = {
        name = 'Folie de Plastic',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['hydrochloric_acid'] = {
        name = 'Acid Clorhidric',
        weight = 0.02,
        description = '',
        type = 'all',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['gasoline'] = {
        name = 'Canistra cu benzina',
        weight = 0.05,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['coca_paste'] = {
        name = 'Pasta de Cocaina',
        weight = 0.03,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['coca_blend'] = {
        name = 'Amestec de Cocaina',
        weight = 0.02,
        description = '',
        type = 'all',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['frunzacoca'] = {
        name = 'Frunza de Cocaina',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['acidsulfuric'] = {
        name = 'Acid Sulfuric',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['acidclorhidric'] = {
        name = 'Acid Clorhidric',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['efedrina'] = {
        name = 'Efedrina',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['metamfetamina1g'] = {
        name = '1g Metamfetamina',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['metamfetamina10g'] = {
        name = '10g Metamfetamina',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['galeata_lemn'] = {
        name = 'Galeata Lemn',
        weight = 0.5,
        description = 'Galeata de lemn',
        type = 'all',
        onUse = 'false',
    },
    ['galeata_lapte'] = {
        name = 'Galeata Lapte',
        weight = 2,
        description = 'Galeata de lapte',
        type = 'all',
        onUse = 'false',
    },
    ['sticla_goala'] = {
        name = 'Sticla Goala',
        weight = 0.05,
        description = 'Galeata de lapte',
        type = 'all',
        onUse = 'false',
    },
    ['sticla_lapte'] = {
        name = 'Sticla cu Lapte',
        weight = 0.75,
        description = 'Sticla cu lapte',
        type = 'all',
        onUse = 'false',
    },
    ['secera'] = {
        name = 'Secera',
        weight = 0.8,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['balot-fan'] = {
        name = 'Balot de fan',
        weight = 1.25,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['powdered_milk'] = {
        name = 'Lapte Praf',
        weight = 1.0,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['unpacked_coke'] = {
        name = 'Coca Depachetata',
        weight = 1.0,
        description = '',
        type = 'all',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['cutted_coke'] = {
        name = 'Cocaina Taiata',
        weight = 1.0,
        description = '',
        type = 'all',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['packed_coke'] = {
        name = 'Cocaina Impachetata',
        weight = 1.5,
        description = '',
        type = 'all',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['GADGET_PARACHUTE'] = {
        name = 'Parasuta',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['sulfur'] = {
        name = 'Sulfur',
        weight = 0.20,
        description = 'Sulfur',
        type = 'all',
        onUse = 'false',
    },
    ['surub'] = {
        name = 'Surub',
        weight = 0.15,
        description = 'Surub',
        type = 'all',
        onUse = 'false',
    },
    ['steel'] = {
        name = 'Steel',
        weight = 0.5,
        description = 'Steel',
        type = 'all',
        onUse = 'false',
    },
    ['pickaxe'] = {
        name = 'Pickaxe',
        weight = 0.05,
        description = 'Item Job',
        type = 'all',
        onUse = 'false',
    },
    ['iron'] = {
        name = 'Lingou de Fier',
        weight = 0.4,
        description = 'Un lingou de fier pur!',
        type = 'all',
        onUse = 'false',
    },
    ['setdecusut'] = {
        name = 'Set De Cusut',
        weight = 0.05,
        description = 'Set De Cusut',
        type = 'all',
        onUse = 'false',
    },
    ['lana'] = {
        name = 'Lana',
        weight = 0.03,
        description = 'Lana',
        type = 'all',
        onUse = 'false',
    },
    ['teava'] = {
        name = 'Teava',
        weight = 1,
        description = 'Teava!',
        type = 'all',
        onUse = 'false',
    },
    ['gold'] = {
        name = 'Lingou de Aur',
        weight = 0.4,
        description = 'Un lingou de aur pur!',
        type = 'all',
        onUse = 'false',
    },
    ['monedasindicat'] = {
        name = 'Moneda de Sindicat',
        weight = 1,
        description = 'Poate niste domni respectabili au nevoie de ele',
        type = 'all',
        onUse = 'false',
    },
    ['dirty_money'] = {
        name = 'Bani Murdari',
        weight = 0,
        description = 'Poate niste domni respectabili au nevoie de ei',
        type = 'all',
        onUse = 'false',
    },
    ['gold_bar'] = {
        name = 'Lingou de Aur',
        weight = 0.3,
        description = 'Un lingou de aur pur de 24K!',
        type = 'all',
        onUse = 'false',
    },
    ['dia_box'] = {
        name = 'Diamant',
        weight = 0.2,
        description = 'Diamant de 24K!',
        type = 'all',
        onUse = 'false',
    },
    ['recompensaheist'] = {
        name = 'Obiect misterios',
        weight = 0.2,
        description = 'Cum ai facut rost de mine?',
        type = 'all',
        onUse = 'false',
    },
    ['recompensaheist2'] = {
        name = 'Obiect misterios',
        weight = 0.2,
        description = 'Cum ai facut rost de mine?',
        type = 'all',
        onUse = 'false',
    },
    ['recompensaheist3'] = {
        name = 'Obiect misterios',
        weight = 0.2,
        description = 'Cum ai facut rost de mine?',
        type = 'all',
        onUse = 'false',
    },
    ['iarbaheist'] = {
        name = 'Iarba',
        weight = 0.02,
        description = 'Cum ai facut rost de mine?',
        type = 'all',
        onUse = 'false',
    },
    ['cocainaheist'] = {
        name = 'Cocaina',
        weight = 0.02,
        description = 'Cum ai facut rost de mine?',
        type = 'all',
        onUse = 'false',
    },
    ['conserva'] = {
        name = 'Conserva',
        weight = 0,
        description = 'Pentru jobul de miner',
        type = 'all',
        onUse = 'false',
    },
    ['plastic'] = {
        name = 'Plastic',
        weight = 0,
        description = 'Pentru jobul de miner',
        type = 'all',
        onUse = 'false',
    },
    ['shoe'] = {
        name = 'Cizma',
        weight = 0,
        description = 'O fi cizma lui Jack Sparrow?',
        type = 'all',
        onUse = 'false',
    },
    ['cashbag'] = {
        name = 'Punga cu bani uzi',
        weight = 0,
        description = 'Ce idiot',
        type = 'all',
        onUse = 'false',
    },
    ['oilcan'] = {
        name = 'Canistra de ulei',
        weight = 0,
        description = 'Deseu',
        type = 'all',
        onUse = 'false',
    },
    ['tank'] = {
        name = 'Minereu',
        weight = 0,
        description = 'Pentru jobul de miner',
        type = 'all',
        onUse = 'false',
    },
    ['picamer'] = {
        name = 'Picamer',
        weight = 0,
        description = 'Picamer pentru constructor',
        type = 'all',
        onUse = 'false',
    },
    ['ciocan'] = {
        name = 'Ciocan',
        weight = 0,
        description = 'Ciocan pentru santierist',
        type = 'all',
        onUse = 'false',
    },
    ['lighter'] = {
        name = 'Bricheta',
        weight = 0.5,
        description = 'O bricheta tip vintage',
        type = 'all',
        onUse = 'false',
    },
    ['lockpick_tools'] = {
        name = 'Unelte Incuietori',
        weight = 0.2,
        description = 'Unelte pentru a sparge incuietorile usilor.',
        type = 'all',
        onUse = 'false',
    },
    ['trusa'] = {
        name = 'Trusa',
        weight = 0.4,
        description = 'Obiecte preferate pentru minerit',
        type = 'all',
        onUse = 'false',
    },
    ['pet'] = {
        name = 'Sticla Goala',
        weight = 0.1,
        description = 'Bun pentru depozitare bauturi!',
        type = 'all',
        onUse = 'false',
    },
    ['petrol'] = {
        name = 'Petrol',
        weight = 0.9,
        description = 'Petrol',
        type = 'all',
        onUse = 'false',
    },
    ['Combustibil'] = {
        name = 'Combustibil',
        weight = 0.1,
        description = 'Combustibil',
        type = 'all',
        onUse = 'false',
    },
    ['canistragoala'] = {
        name = 'Canistra Goala',
        weight = 0.9,
        description = 'Canistra Goala',
        type = 'all',
        onUse = 'false',
    },
    ['deer_meat'] = {
        name = 'Carne alterata ~ CAPRIOARA',
        weight = 0.05,
        description = 'Carne alterata ~ CAPRIOARA',
        type = 'all',
        onUse = 'false',
    },
    ['deer_meat2'] = {
        name = 'Carne de calitate ~ CAPRIOARA',
        weight = 0.10,
        description = 'Carne de calitate ~ CAPRIOARA',
        type = 'all',
        onUse = 'false',
    },
    ['pig_meat'] = {
        name = 'Carne alterata ~ PORC',
        weight = 0.05,
        description = 'Carne alterata ~ PORC',
        type = 'all',
        onUse = 'false',
    },
    ['pig_meat2'] = {
        name = 'Carne de calitate ~ PORC',
        weight = 0.10,
        description = 'Carne de calitate ~ PORC',
        type = 'all',
        onUse = 'false',
    },
    ['chicken_meat'] = {
        name = 'Carne alterata ~ GAINA',
        weight = 0.05,
        description = 'Carne alterata ~ GAINA',
        type = 'all',
        onUse = 'false',
    },
    ['chicken_meat2'] = {
        name = 'Carne de calitate ~ GAINA',
        weight = 0.10,
        description = 'Carne de calitate ~ GAINA',
        type = 'all',
        onUse = 'false',
    },
    ['photosm'] = {
        name = 'Poza Mixta',
        weight = 0.1,
        description = 'Poza cu cu peisaj urban si natural combinat!',
        type = 'all',
        onUse = 'false',
    },
    ['cardspalatorie'] = {
        name = 'Carc acces spalatorie',
        weight = 0.02,
        description = 'Card spalatorie!',
        type = 'all',
        onUse = 'false',
    },
    ['samanta'] = {
        name = 'Samanta de rosie',
        weight = 0.1,
        description = 'Gustul bun de rosie vine de la o samanta buna!',
        type = 'all',
        onUse = 'false',
    },
    ['revista'] = {
        name = 'Revista Natura',
        weight = 0.1,
        description = 'O revista incantatoare care ajuta oameni sa se relaxeze citindo!',
        type = 'all',
        onUse = 'false',
    },
    ['ziar'] = {
        name = 'Ziar',
        weight = 0.1,
        description = 'Un ziar care aduce multe stiri societatii!',
        type = 'all',
        onUse = 'false',
    },
    ['fier'] = {
        name = 'Fier',
        weight = 0,
        description = 'Minereu de fier',
        type = 'all',
        onUse = 'false',
    },
    ['cupru'] = {
        name = 'Cupru',
        weight = 0,
        description = 'Cupru',
        type = 'all',
        onUse = 'false',
    },
    ['sulf'] = {
        name = 'Sulf',
        weight = 0,
        description = 'Sulf',
        type = 'all',
        onUse = 'false',
    },
    ['prafdepusca'] = {
        name = 'Praf de Pusca',
        weight = 0,
        description = 'Praf de Pusca',
        type = 'all',
        onUse = 'false',
    },
    ['amethyst'] = {
        name = 'Amethyst',
        weight = 0.6,
        description = 'Piatra pretioasa',
        type = 'all',
        onUse = 'false',
    },
    ['safir'] = {
        name = 'Safir',
        weight = 0.6,
        description = 'Piatra foarte pretioasa',
        type = 'all',
        onUse = 'false',
    },
    ['uranium'] = {
        name = 'Uranium',
        weight = 0.6,
        description = 'Radioactivitatea ei creaza haos',
        type = 'all',
        onUse = 'false',
    },
    ['aur'] = {
        name = 'Aur',
        weight = 0.6,
        description = 'Metal Pretios foarte valoros',
        type = 'all',
        onUse = 'false',
    },
    ['diamant'] = {
        name = 'Diamant',
        weight = 0.6,
        description = 'Diamant foarte pretios si foarte valoros, INDESTRUCTIBIL',
        type = 'all',
        onUse = 'false',
    },
    ['id_doc'] = {
        name = 'Buletin',
        weight = 0,
        description = 'Un buletin cu numele si informatiile tale pe el! Nu il pierde',
        type = 'all',
        onUse = 'false',
    },
    ['gunpermit_doc'] = {
        name = 'Permis Port-Arma',
        weight = 0,
        description = 'Un permis ce te lasa sa ai asupra ta arme de foc',
        type = 'all',
        onUse = 'false',
    },
    ['hash_token_rocketcasino'] = {
        name = 'Moneda Cazino',
        weight = 0,
        description = 'Moneda cu care poti juca la cazino',
        type = 'all',
        onUse = 'false',
    },
    ['asigurare_masina'] = {
        name = 'Asigurare de Masina',
        weight = 0,
        description = 'O Asigurare de masina pe care o puteti oferi la altii sau pastra pentru masina voastra',
        type = 'all',
        onUse = 'false',
    },
    ['permisportarmaruleta'] = {
        name = 'Permis Port Arma De La Ruleta',
        weight = 0,
        description = 'Cu acest permis nu ti vei pierde armele.',
        type = 'all',
        onUse = 'false',
    },
    ['dosardmv'] = {
        name = 'Dosar DMV',
        weight = 0,
        description = 'Cu acest item te duci la un politist pentru a da de permis, el te va verifica daca ai dosar sau nu.',
        type = 'all',
        onUse = 'false',
    },
    ['thermal_charge'] = {
        name = 'Thermal',
        weight = 0.8,
        description = 'Substanta puternica din seminte de Turbina Corymbosa',
        type = 'all',
        onUse = 'false',
    },
    ['laptop_h'] = {
        name = 'Laptop',
        weight = 0.8,
        description = 'Substanta puternica din seminte de Turbina Corymbosa',
        type = 'all',
        onUse = 'false',
    },
    ['lockpick'] = {
        name = 'Lockpick',
        weight = 0.8,
        description = 'Substanta puternica din seminte de Turbina Corymbosa',
        type = 'all',
        onUse = 'false',
    },
    ['id_card'] = {
        name = 'Id Card',
        weight = 0.8,
        description = 'Substanta puternica din seminte de Turbina Corymbosa',
        type = 'all',
        onUse = 'false',
    },
    ['bijuterii'] = {
        name = 'Bijuterii pretioase',
        weight = 0.2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['combomeal'] = {
        name = 'Combo Meal',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['bigmac'] = {
        name = 'Big Mac',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['mcpollo'] = {
        name = 'Mc pollo',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['mcroyaldeluxe'] = {
        name = 'Royal Deluxe',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['cbo'] = {
        name = 'CBO',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['cuartodelibra'] = {
        name = 'Cuarto de Libra',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['grandmcextreme'] = {
        name = 'Grand McExtreme Bacon Burger',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['bigchickensupreme'] = {
        name = 'Big Chicken Supreme',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['bigcrispybbq'] = {
        name = 'Big Crispy BBQ',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['bigdoublecheese'] = {
        name = 'Big Double Cheese',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['ammo-pistol'] = {
        name = 'Gloante Pistol',
        weight = 0.01,
        description = 'Gloante Pistol',
        type = 'all',
        onUse = 'false',
    },
    ['ammo-rifle'] = {
        name = 'Gloante de Calibru mare',
        weight = 0.01,
        description = 'Gloante de Calibru mare',
        type = 'all',
        onUse = 'false',
    },
    ['hamburgesa'] = {
        name = 'Hamburger',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['stack_cocaina'] = {
        name = 'PCP Neprocesat',
        weight = 4,
        description = 'Praf alb de PCP neprocesat',
        type = 'all',
        onUse = 'false',
    },
    ['hamburgesadepollo'] = {
        name = 'Hamburger pollo',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['mcfish'] = {
        name = 'Mc Fish',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['happymeal'] = {
        name = 'Happy Meal',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['nestea'] = {
        name = 'Nestea',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['agua'] = {
        name = 'Apa Plata 0.5l',
        weight = 0.5,
        description = 'Apa plata necarbogazoasa 0.5l',
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.drinkWater(user_id, source, item, -10);
        end,
    },
    ['monsterenergy'] = {
        name = 'Monster Energy',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['aquarius'] = {
        name = 'Apa',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['cerveza'] = {
        name = 'Cerveza',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['nuggets'] = {
        name = 'Nuggets',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['patatasfritas'] = {
        name = 'Cartofi',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['topfries'] = {
        name = 'Top Fries',
        weight = 0.8,
        description = 'Mc Donalds',
        type = 'all',
        onUse = 'false',
    },
    ['Componente_arme'] = {
        name = 'Componente',
        weight = 0.8,
        description = 'Pentru Craftarea armelor',
        type = 'all',
        onUse = 'false',
    },
    ['scanner'] = {
        name = 'Scanner',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['oil'] = {
        name = 'Ulei Motor',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['tires'] = {
        name = 'Cauciucuri',
        weight = 2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['brake_pads'] = {
        name = 'Placute frana',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['transmission_oil'] = {
        name = 'Ulei transmisie',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['shock_absorber'] = {
        name = 'Suspensie',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['clutch'] = {
        name = 'Ambreiaj',
        weight = 2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['air_filter'] = {
        name = 'Filtru aer',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['fuel_filter'] = {
        name = 'Filtru de combustibil',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['spark_plugs'] = {
        name = 'Buji',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['serpentine_belt'] = {
        name = 'Curea distributie',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['susp'] = {
        name = 'Suspensie joasa',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['susp1'] = {
        name = 'Suspensie camber',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['susp2'] = {
        name = 'Suspensie sport',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['susp3'] = {
        name = 'Suspensie comfort',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['susp4'] = {
        name = 'Suspensie inalta',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['garett'] = {
        name = 'Garett GTW Turbo',
        weight = 3,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['twingarett'] = {
        name = 'Garett GTW Bi-Turbo',
        weight = 3,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['nitrous'] = {
        name = 'Nitro',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['AWD'] = {
        name = 'AWD',
        weight = 2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['RWD'] = {
        name = 'RWD',
        weight = 2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['FWD'] = {
        name = 'FWD',
        weight = 2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['semislick'] = {
        name = 'Cauciuc Semi Slick',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['slick'] = {
        name = 'Cauciu Slick',
        weight = 2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['race_brakes'] = {
        name = 'Frane Brembo',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['piston'] = {
        name = 'Piston',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['rod'] = {
        name = 'Biela',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['gear'] = {
        name = 'Rotita',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['brake_discs'] = {
        name = 'Frana disc',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['brake_caliper'] = {
        name = 'Placuta frana',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['springs'] = {
        name = 'Suspensie',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['aluminum'] = {
        name = 'Aluminu',
        weight = 1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['v8engine'] = {
        name = 'V8',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['s63b44'] = {
        name = 'BMW V8',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['2jzengine'] = {
        name = '2Jz',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['logan14'] = {
        name = 'Motor Logan 1.4',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['hv8'] = {
        name = 'Koenigsegg Hot V8',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['motorcustom'] = {
        name = 'Motor Custom',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['nisgtr35'] = {
        name = 'GTR',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['talam52v10'] = {
        name = 'Huracan',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['918spyeng'] = {
        name = 'Ferrari',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['aston59v12'] = {
        name = 'Lamborghini V12 T',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['apollosv8'] = {
        name = 'V8 Muscle',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['toolbox'] = {
        name = 'Trusa de scule',
        weight = 0.6,
        description = 'Te ajuta',
        type = 'all',
        onUse = 'false',
    },
    ['mechanic_tools'] = {
        name = 'Trusa de Mecanic',
        weight = 0.8,
        description = 'Necesar',
        type = 'all',
        onUse = 'false',
    },
    ['turbo_lvl_1'] = {
        name = 'GARET TURBO',
        weight = 0.6,
        description = 'Turbina',
        type = 'all',
        onUse = 'false',
    },
    ['nos'] = {
        name = 'NOS',
        weight = 0.8,
        description = 'Nitro',
        type = 'all',
        onUse = 'false',
    },
    ['stock_transmission'] = {
        name = 'Transmisie Stock',
        weight = 0.5,
        description = 'Este o transmisie Stock',
        type = 'all',
        onUse = 'false',
    },
    ['race_transmission'] = {
        name = 'RWD',
        weight = 0.5,
        description = 'Right Wheel Drive',
        type = 'all',
        onUse = 'false',
    },
    ['race_transmission_4wd'] = {
        name = 'AWD',
        weight = 4,
        description = 'All Wheel Drive',
        type = 'all',
        onUse = 'false',
    },
    ['race_transmission_fwd'] = {
        name = 'FWD',
        weight = 0.6,
        description = 'Front Wheel Drive',
        type = 'all',
        onUse = 'false',
    },
    ['stock_suspension'] = {
        name = 'Suspensie Stock',
        weight = 0.8,
        description = 'Este Stock',
        type = 'all',
        onUse = 'false',
    },
    ['race_suspension'] = {
        name = 'Suspensie Race',
        weight = 0.5,
        description = 'Se lasa jos',
        type = 'all',
        onUse = 'false',
    },
    ['costumscafandru'] = {
        name = 'Costum Scafandru',
        weight = 5.0,
        description = 'Costum Scafandru',
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.useScuba(user_id, source, item);
        end,
    },
    ['boombox'] = {
        name = 'Boombox',
        weight = 0.2,
        description = 'Boombox',
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.useBoombox(user_id, source, item);
        end,
    },
    ['costumscafandruheist'] = {
        name = 'Costum Scafandru',
        weight = 5.0,
        description = 'Costum Scafandru',
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.useScubaHeist(user_id, source, item);
        end,
    },
    ['canistraplina'] = {
        name = 'Canistra Plina',
        weight = 1.0,
        description = 'Canistra Plina',
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.useCanistra(user_id, source, item);
        end,
    },
    ['ceas'] = {
        name = 'Ceas',
        weight = 1.0,
        description = 'Ceas',
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.useCeas(user_id, source, item);
        end,
    },
    ['zaruribarbut'] = {
        name = 'Zaruri barbut',
        weight = 1.0,
        description = 'Zaruri barbut',
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.zaruribarbut(user_id, source, item);
        end,
    },
    ['monedaaur'] = {
        name = 'Moneda Aur',
        weight = 0.2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['brataraaur'] = {
        name = 'Bratara Aur',
        weight = 0.2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['perle'] = {
        name = 'Perle',
        weight = 0.2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['monedarara'] = {
        name = 'Moneda Rara',
        weight = 0.4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['monedaargint'] = {
        name = 'Moneda Argint',
        weight = 0.2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['ceasvechi'] = {
        name = 'Ceas vechi',
        weight = 0.2,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['stock_oil'] = {
        name = 'Ulei Stock',
        weight = 0.5,
        description = 'Este Stock',
        type = 'all',
        onUse = 'false',
    },
    ['shell_oil'] = {
        name = 'Ulei Premium',
        weight = 4,
        description = 'Este Premium',
        type = 'all',
        onUse = 'false',
    },
    ['stock_engine'] = {
        name = 'Motor Stock',
        weight = 0.5,
        description = 'Este Stock',
        type = 'all',
        onUse = 'false',
    },
    ['customtunning'] = {
        name = 'M264',
        weight = 4,
        description = 'Face kilometri multi!!',
        type = 'all',
        onUse = 'false',
    },
    ['audiwx'] = {
        name = 'Custom T',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['sl65amgv12'] = {
        name = 'Mercede V8',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['s55b30'] = {
        name = 'BMW M3 / M4',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['m840trsenna'] = {
        name = 'Mclaren',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['ea888'] = {
        name = 'Volvo',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['ea825'] = {
        name = 'Demon V8',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['bnr34ffeng'] = {
        name = 'Nissan Skyline',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['aqls7raceswap'] = {
        name = 'Chevrolet V8',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['4age'] = {
        name = 'Subaru',
        weight = 0.1,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['faina'] = {
        name = 'Vinde Faina',
        weight = 4,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['stock_tires'] = {
        name = 'Cauciucuri Stock',
        weight = 0.5,
        description = 'Sunt Stock',
        type = 'all',
        onUse = 'false',
    },
    ['michelin_tires'] = {
        name = 'Cauciucuri Michelin',
        weight = 0.5,
        description = 'Cauciucuri Michelin pentru Formula 1',
        type = 'all',
        onUse = 'false',
    },
    ['stock_brakes'] = {
        name = 'Frane Stock',
        weight = 4,
        description = 'Sunt Stock',
        type = 'all',
        onUse = 'false',
    },
    ['fisaspalatorie'] = {
        name = 'Fisa spalatorie',
        weight = 0.05,
        description = 'Fisa spalatorie',
        type = 'all',
        onUse = 'false',
    },
    ['stock_sparkplugs'] = {
        name = 'Bujii Stock',
        weight = 4,
        description = 'Sunt Stock',
        type = 'all',
        onUse = 'false',
    },
    ['ngk_sparkplugs'] = {
        name = 'Bujii Sparkplugs',
        weight = 4,
        description = 'Sparkplug-uri',
        type = 'all',
        onUse = 'false',
    },
    ['pliculete'] = {
        name = 'Pliculete',
        weight = 0,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['maconha'] = {
        name = 'Maconha',
        weight = 0,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    -- DROGURI
    ['cristalheroina'] = {
        name = 'Cristal Heroina',
        weight = 0.7,
        description = 'Cristale ilegale',
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['drug_cansativa'] = {
        name = 'Cannabis Sativa',
        weight = 0.5,
        description = 'Esenta de canabis folosita pentru crearea drogurilor puternice',
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['drug_cocaalka'] = {
        name = 'Cocaina Alkaloid',
        weight = 0.7,
        description = 'Un lichid albastru extras din planta coca',
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['drug_unprocpcp'] = {
        name = 'PCP Neprocesat',
        weight = 0.6,
        description = 'Praf alb de PCP neprocesat',
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['drug_lyseracid'] = {
        name = 'Acid Lysergic',
        weight = 0.8,
        description = 'Substanta puternica din seminte de Turbina Corymbosa',
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['cristalcocaina'] = {
        name = 'Cristal Cocaina',
        weight = 0.5,
        description = 'Cristale ilegale',
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },

    
    ['iarba'] = {
        name = 'iarba',
        weight = 0.5,
        description = 'Iarba',
        type = 'pocket',
        onUse = 'false',
    },
    ['stack_iarba'] = {
        name = 'Cannabis Sativa',
        weight = 4,
        description = 'Esenta de canabis folosita pentru crearea drogurilor puternice',
        type = 'pocket',
        onUse = 'false',
    },
    ['stack_metanfetamina'] = {
        name = 'Acid Lysergic',
        weight = 4,
        description = 'Substanta puternica din seminte de Turbina Corymbosa',
        type = 'pocket',
        onUse = 'false',
    },
    ['cocaina'] = {
        name = 'Cocaina Neprelucrata',
        weight = 0.5,
        description = '',
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['metanfetamina'] = {
        name = 'Metanfetamina Neprelucrata',
        weight = 0.5,
        description = '',
        type = 'pocket',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['coletf'] = {
        name = 'Colete Fragile',
        weight = 0.15,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['coletmic'] = {
        name = 'Colete Mici',
        weight = 0.15,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['coletmadi'] = {
        name = 'Colete Medii',
        weight = 0.15,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['coletmari'] = {
        name = 'Colete Mari',
        weight = 0.15,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['lemn'] = {
        name = 'Lemn',
        weight = 0.50,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['contractfirma'] = {
        name = 'contractfirma',
        weight = 0.50,
        description = 'Contract eliberat de primarie pentru achizitia unei firme de miner.',
        type = 'pocket',
        onUse = 'false',
    },


    -- MINER
    ['dream-copper'] = {
        name = 'Cupru',
        weight = 0.3,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['dream-iron'] = {
        name = 'Fier',
        weight = 0.3,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['dream-molibden'] = {
        name = 'Molibden',
        weight = 0.6,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['dream-zinc'] = {
        name = 'Zinc',
        weight = 0.4,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['dream-lead'] = {
        name = 'Plumb',
        weight = 0.3,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['dream-silver'] = {
        name = 'Argint',
        weight = 0.35,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['dream-tin'] = {
        name = 'Staniol',
        weight = 0.2,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['dream-diamonds'] = {
        name = 'Diamante',
        weight = 0.1,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    -- FPT JOBS ILEGALE
    ['marijuana10g'] = {
        name = '🌿 Marijuana 10g',
        weight = 0.10,
        description = 'Niste seminte de marijuana.',
        type = 'pocket',
        onUse = 'false',
    },
    ['marijuana1g'] = {
        name = '🌿 Marijuana 1g',
        weight = 0.01,
        description = 'Niste seminte de marijuana.',
        type = 'pocket',
        onUse = 'false',
    },
    ['marijuana'] = {
        name = '🌿 Marijuana',
        weight = 0.10,
        description = 'Niste seminte de marijuana.',
        type = 'pocket',
        onUse = 'false',
    },
    ['pulse'] = {
        name = '☁️ Pulse',
        weight = 0.30,
        description = 'Drog de mare risc.',
        type = 'pocket',
        onUse = 'false',
    },
    ['specialgold'] = {
        name = '☁️ Special Gold',
        weight = 0.20,
        description = 'Drog de mare risc.',
        type = 'pocket',
        onUse = 'false',
    },
    ['tutun'] = {
        name = '🍁 Tutun',
        weight = 0.01,
        description = 'Tigare legala.',
        type = 'pocket',
        onUse = 'false',
    },
    ['trabuc'] = {
        name = '🚬 Trabuc',
        weight = 0.05,
        description = 'Tigare legala.',
        type = 'pocket',
        onUse = 'false',
    },
    ['cutietrabucuri'] = {
        name = '🧧 Cutie Trabucuri',
        weight = 0.20,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['filtru'] = {
        name = '🧻 Filtru',
        weight = 0.20,
        description = 'Foite pentru tigari.',
        type = 'pocket',
        onUse = 'false',
    },
    ['foita'] = {
        name = 'Foita',
        weight = 0.20,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    -- ['deer_bait'] = {
    --     name = 'Momeala Caprioare',
    --     weight = 0.10,
    --     description = 'Momeala de proasta calitate pentru caprioare',
    --     type = 'pocket',
    --     onUse = 'false',
    -- },
    -- ['deer_bait2'] = {
    --     name = 'Momeala Caprioare 2',
    --     weight = 0.10,
    --     description = 'Momeala proaspata pentru caprioare',
    --     type = 'pocket',
    --     onUse = 'false',
    -- },
    -- ['pig_bait'] = {
    --     name = 'Momeala Porci',
    --     weight = 0.10,
    --     description = 'Momeala de proasta calitate pentru porci',
    --     type = 'pocket',
    --     onUse = 'false',
    -- },
    -- ['pig_bait2'] = {
    --     name = 'Momeala Porci 2',
    --     weight = 0.10,
    --     description = 'Momeala proaspata pentru porci',
    --     type = 'pocket',
    --     onUse = 'false',
    -- },
    ['deer_meat'] = {
        name = 'Carne alterata CAPRIOARA',
        weight = 1.00,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['deer_meat2'] = {
        name = 'Carne de calitate CAPRIOARA',
        weight = 1.00,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['pig_meat'] = {
        name = 'Carne alterata PORC',
        weight = 1.00,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['pig_meat2'] = {
        name = 'Carne de calitate  PORC',
        weight = 1.00,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['chicken_meat'] = {
        name = 'Carne alterata GAINA',
        weight = 1.00,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['chicken_meat2'] = {
        name = 'Carne de calitate GAINA',
        weight = 1.00,
        description = '',
        type = 'pocket',
        onUse = 'false',
    },
    ['plantatutun'] = {
        name = '🍁 Planta Tutun',
        weight = 0.01,
        description = 'Tutun pentru tigari.',
        type = 'pocket',
        onUse = 'false',
    },
    ["otravasobolani"] = {
        name = "🐀 Otrava pentru Sobolani",
        weight = 0.20,
        description = "Otrava pentru soricei.",
        type = 'pocket',
        onUse = 'false',
    },
    ["acetona"] = {
        name = "💧 Acetona",
        weight = 0.05,
        description = "Acetona pentru uz personal.",
        type = 'pocket',
        onUse = 'false',
    },
    ["ingrasamantchimic"] = {
        name = "Ingrasamant Chimic",
        weight = 0.15,
        description = "Ingrasamant.",
        type = 'pocket',
        onUse = 'false',
    },
    ['kq_meth_low'] = {
        name = '1g Metamfetamina',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['kq_meth_high'] = {
        name = '10g Metamfetamina',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['kq_meth_lab_kit'] = {
        name = 'Kit Metamfetamina',
        weight = 0.5,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ['kq_meth_pills'] = {
        name = 'Pastile',
        weight = 0.05,
        description = '',
        type = 'all',
        onUse = 'false',
    },
    ["kq_acetone"] = {
        name = "💧 Acetona",
        weight = 0.05,
        description = "Acetona pentru uz personal.",
        type = 'pocket',
        onUse = 'false',
    },
    ["kq_ammonia"] = {
        name = "💧 Amoniac",
        weight = 0.03,
        description = "Amoniac.",
        type = 'pocket',
        onUse = 'false',
    },
    ["kq_ethanol"] = {
        name = "💧 Etanol",
        weight = 0.02,
        description = "Etanol",
        type = 'pocket',
        onUse = 'false',
    },
    ["zerolag_parachute"] = {
        name = "Parasuta",
        weight = 0.50,
        description = "O parasuta ce se poate echipa pentru a sarii de la inaltime.",
        type = 'pocket',
        onUse = function(user_id, source, item, itemData)
            -- local user_id = vRP.getUserId({player})
            if user_id ~= nil then
                TriggerClientEvent('parasutaEvent', source)
            end
            -- edit with your function
        end,
    },

    ["kq_lithium"] = {
        name = "💧 Litiu",
        weight = 0.03,
        description = "Litiu",
        type = 'pocket',
        onUse = 'false',
    },
    ["bani"] = {
        name = "Bani Cash",
        weight = 0,
        description = "$.",
        type = "pocket",
        onUse = 'false',
    },
    ["licentpescar"] = {
        name = "Licenta Pescar",
        weight = 0.01,
        description = "",
        type = 'pocket',
        onUse = 'false',
    },
    ["licenttirist"] = {
        name = "Licenta Tirist",
        weight = 0.01,
        description = "",
        type = 'pocket',
        onUse = 'false',
    },
    ["licentminer"] = {
        name = "Licenta Miner",
        weight = 0.01,
        description = "",
        type = 'pocket',
        onUse = 'false',
    },
    -- Scafandru miner
    ["minereuaur"] = {
        name = "Minereu de Aur",
        weight = 0.10,
        description = "Minereu.",
        type = 'pocket',
        onUse = 'false',
    },
    ["minereuargint"] = {
        name = "Minereu de Argint",
        weight = 0.15,
        description = "Minereu.",
        type = 'pocket',
        onUse = 'false',
    },
    ["minereufier"] = {
        name = "Minereu de Fier",
        weight = 0.30,
        description = "Minereu.",
        type = 'pocket',
        onUse = 'false',
    },
    ["minereusulf"] = {
        name = "Minereu de Sulf",
        weight = 0.15,
        description = "Minereu.",
        type = 'pocket',
        onUse = 'false',
    },
    ["piatra"] = {
        name = "Piatra",
        weight = 0.50,
        description = "Minereu.",
        type = 'pocket',
        onUse = 'false',
    },
    ["artefactunu"] = {
        name = "Artefact pretios",
        weight = 0.15,
        description = "Artefact.",
        type = 'pocket',
        onUse = 'false',
    },
    ["artefactdoi"] = {
        name = "Artefact spart",
        weight = 0.20,
        description = "Artefact.",
        type = 'pocket',
        onUse = 'false',
    },
    ["artefacttrei"] = {
        name = "Artefact",
        weight = 0.25,
        description = "Artefact.",
        type = 'pocket',
        onUse = 'false',
    },
    ["artefactpatru"] = {
        name = "Artefact",
        weight = 0.30,
        description = nil,
        type = 'pocket',
        onUse = 'false',
    },
    ["tarnacoape"] = {
        name = "Tarnacop",
        weight = 1,
        description = "Tarnacop.",
        type = 'pocket',
        onUse = 'false',
    },

    -- addon
    ['cocainaneprocesata'] = {
        name = 'Cocaina Procesata',
        weight = 0.5,
        description = 'Cocaina Procesata',
        type = 'all',
        onUse = function(user_id, source, item)
            Config.useDrugs(user_id, source, item, -80);
        end,
    },
    ['rope'] = {
        name = 'Sfoara',
        weight = 0.1,
        description = 'Folosita sa o legi de masina',
        type = 'pocket',
        onUse = function(user_id, source, item, itemData)
            -- local user_id = vRP.getUserId({player})
            if user_id ~= nil then
              local cop = vRP.getOnlineUsersByFaction({'Politie'})
              vRPclient.getNearestVehicle(source, {5}, function(veh)
                if vRP.isUserInFaction({user_id,'Politie'}) then
                  vRPclient.notify(source,{"Nu poti folosi sfoara ca si politist"})
                else
                if #cop >= 4 then
                if (veh) then
              TriggerClientEvent("lucian_jafatm:userope", source)
                else
                  vRPclient.notify(source,{"Nu exista nicio masina pentru a lega sfoara"})
                end
              else
                vRPclient.notify(source,{"Nu sunt destui politisti in oras"})
              end
              end
              end)
            end
            -- edit with your function
        end,
    },
    ['fragmentatx'] = {
        name = "Fragment Astrix Coins",
        weight = 0.1,
        description = "Acest item poate fi schimbat la Mayor pentru Astrix Coins 100 frgamente = 1 ATX",
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            Config.fragmentatx(user_id, source, item);
        end,
    },
    ['tichetvipb'] = {
        name = 'Tichet VIP BRONZE 7 ZILE',
        weight = 0.1,
        description = 'Acest item se poate schimba la Mayor pentru VIP BRONZE 7 ZILE',
        type = 'all',
        onUse = 'false',
    },
    ['tichetvips'] = {
        name = 'Tichet VIP Silver 7 ZILE',
        weight = 0.1,
        description = 'Acest item se poate schimba la Mayor pentru VIP Silver 7 ZILE',
        type = 'all',
        onUse = 'false',
    },
    ['tichetviptrx'] = {
        name = 'Tichet VIP TRX 7 ZILE',
        weight = 0.1,
        description = 'Acest item se poate schimba la Mayor pentru TRX BRONZE 7 ZILE',
        type = 'all',
        onUse = 'false',
    },
    ['tichetvipg'] = {
        name = 'Tichet VIP GOLD 3 ZILE',
        weight = 0.1,
        description = 'Acest item se poate schimba la Mayor pentru VIP GOLD 3 ZILE',
        type = 'all',
        onUse = 'false',
    },
    ['tichetvipd'] = {
        name = 'Tichet VIP Diamond 1 ZILE',
        weight = 0.1,
        description = 'Acest item se poate schimba la Mayor pentru VIP DIAMOND 1 ZILE',
        type = 'all',
        onUse = 'false',
    },
    ['tichetvipe'] = {
        name = 'Tichet VIP Emerald 1 ZILE',
        weight = 0.1,
        description = 'Acest item se poate schimba la Mayor pentru VIP Emerald 1 ZILE',
        type = 'all',
        onUse = 'false',
    },
    ['trusa_lockpick'] = {
        name = 'Trusa Lockpick',
        weight = 1.2,
        description = 'Trusa Lockpick',
        type = 'all',
        onUse = function(user_id, source, item, itemData)
            TriggerClientEvent('astrix_housing:tryRobHouse', source);
        end
    },

    -- new miner job
    ['diamondore'] = {
        name = 'Diamond Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['emeraldore'] = {
        name = 'Emerald Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['rubyore'] = {
        name = 'Ruby Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['sapphireore'] = {
        name = 'Sapphire Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['platinumore'] = {
        name = 'Platinum Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['goldore'] = {
        name = 'Gold Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['silverore'] = {
        name = 'Silver Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['copperore'] = {
        name = 'Cooper Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['amethystore'] = {
        name = 'Amethyst Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['topazore'] = {
        name = 'Topaz Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['ironore'] = {
        name = 'Iron Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['opalore'] = {
        name = 'Opal Ore',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
    ['stones'] = {
        name = 'Piatra',
        weight = 0.1,
        description = 'Ore',
        type = 'all',
        onUse = 'false',
    },
}
