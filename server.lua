--[[
_____/\\\\\\\\\____________________________________/\\\\\\\\\___________________
 ___/\\\\\\\\\\\\\________________________________/\\\///////\\\_________________
  __/\\\/////////\\\______________________________\/\\\_____\/\\\_________________
   _\/\\\_______\/\\\__/\\\____/\\\_____/\\\\\\\\__\/\\\\\\\\\\\/________/\\\\\____
    _\/\\\\\\\\\\\\\\\_\///\\\/\\\/____/\\\/////\\\_\/\\\//////\\\______/\\\///\\\__
     _\/\\\/////////\\\___\///\\\/_____/\\\\\\\\\\\__\/\\\____\//\\\____/\\\__\//\\\_
      _\/\\\_______\/\\\____/\\\/\\\___\//\\///////___\/\\\_____\//\\\__\//\\\__/\\\__
       _\/\\\_______\/\\\__/\\\/\///\\\__\//\\\\\\\\\\_\/\\\______\//\\\__\///\\\\\/___
        _\///________\///__\///____\///____\//////////__\///________\///_____\/////_____ ]]
--
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "axr_inventory")
local resName = GetCurrentResourceName()

-- callbacks

function registerCallback(cbName, cb)
    RegisterServerEvent(resName .. ":s_callback:" .. cbName, function(...)
        local player = source
        if cb and player then
            local result = table.pack(cb(player, ...))
            TriggerClientEvent(resName .. ":c_callback:" .. cbName, player, table.unpack(result))
        end
    end)
end

-- functions
usersInventory = {}
usersWeapons = {}
chests = {}
lockedVehicles = {}
local function sendDiscordLogs(title, message, logtype)
    if not Config.discordLogs then
        return print(
            "^1ERROR^0 Please set the Config.discordLogs in order to recive personal logs")
    end;
    if not Config.discord then
        return print(
            "^1ERROR^0 Please set the Config.discord in order to recive personal logs")
    end;
    local webhook = nil;
    if Config.discordLogs and Config.discordLogs[logtype] then
        webhook = Config.discordLogs[logtype];
    end
    if not webhook then
        return print("^1ERROR^0 There is no webhook such as " ..
            logtype .. " configure in config/config.lua for Config.discordLogs")
    end;
    local information = {
        {
            ["color"] = '16711680',
            ["author"] = {
                ["icon_url"] = Config.discord.logo,
                ["name"] = "[axr_inventory] Logs | " .. Config.discord.serverName,
            },
            ["title"] = title,
            ["description"] = message,
            ["footer"] = {
                ["text"] = os.date('%d/%m/%Y [%X]'),
            }
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST',
        json.encode({ username = "AxR Logs BOT", embeds = information }),
        { ['Content-Type'] = 'application/json' })
end

registerCallback('axr_inventory:getPlayerPing', function(source)
    return GetPlayerPing(source);
end)

registerCallback('axr_inventory:isItemJewellery', function(source, item, jewelleryType, mType)
    local user_id = vRP.getUserId({ source });
    if user_id and usersInventory[user_id] then
        return Config.isItemJewellery(item, jewelleryType, mType);
    end
end)

RegisterServerEvent('axr_inventory:dressJewellery', function(item, jewelleryType)
    local src = source;
    local user_id = vRP.getUserId({ src });
    if user_id and usersInventory[user_id] then
        return Config.dressJewellery(user_id, item, jewelleryType);
    end
end)

RegisterServerEvent('axr_inventory:undressJewellery', function(item, jewelleryType)
    local src = source;
    local user_id = vRP.getUserId({ src });
    if user_id and usersInventory[user_id] then
        return Config.undressJewellery(user_id, item, jewelleryType);
    end
end)

registerCallback('axr_inventory:sendDiscordLogs', function(player, data)
    if not Config.useJSLogs then return 0 end;
    local user_id = vRP.getUserId { player };
    if user_id then
        if data and data.fromFile == 'js' then
            local logtype, title;
            local message = " **UserId:** " ..
                user_id .. "**\nPlayerName:** " ..
                GetPlayerName(player) ..
                '\n**Item:** ' ..
                data.item ..
                "\n**Amount:** " ..
                data.amount ..
                '\n**From:** ' ..
                data.from ..
                '\n**To:** '
                .. data.to ..
                '\n**FromSlot: **'
                .. data.fromSlot ..
                '\n**To Slot**'
                .. data.toSlot;
            if (data.type == 'giveItem') then
                if (data.category == 'trunk') then
                    logtype = 'putItemInTrunk';
                    title = 'Put Item In Trunk';
                elseif (data.category == 'glovebox') then
                    logtype = 'putItemInGlovebox';
                    title = 'Put Item In Glovebox';
                elseif (data.category == 'chest') then
                    logtype = 'putItemInChest';
                    title = 'Put Item In Chest';
                elseif (data.category == 'otherPlayer') then
                    logtype = 'putItemInPlayerInventory';
                    title = 'Put Item In Player Inventory';
                end
            elseif (data.type == 'reciveItem') then
                if (data.category == 'trunk') then
                    title = 'Get Item From Trunk';
                    logtype = 'getItemFromTrunk';
                elseif (data.category == 'glovebox') then
                    title = 'Get Item From Glovebox';
                    logtype = 'getItemFromGlovebox';
                elseif (data.category == 'chest') then
                    title = 'Get Item From Chest';
                    logtype = 'getItemFromChest';
                elseif (data.category == 'otherPlayer') then
                    title = 'Get Item From Player Inventory';
                    logtype = 'getItemFromPlayerInventory';
                end
            end
            Config.moveItemHandler(user_id, data.item, data.amount, title);
            sendDiscordLogs(title, message, logtype);
            return true;
        end
    end
    return false;
end)

function formatItems(user_id)
    if user_id and usersInventory[user_id] then
        if usersInventory[user_id].fastSlots then
            for i = 1, 5 do
                if usersInventory[user_id].fastSlots[i] then
                    local item = usersInventory[user_id].fastSlots[i].item;
                    if Items[item] then
                        usersInventory[user_id].fastSlots[i].name = Items[item].name;
                        usersInventory[user_id].fastSlots[i].description = Items[item].description;
                        usersInventory[user_id].fastSlots[i].weight = Items[item].weight;
                        usersInventory[user_id].fastSlots[i].type = Items[item].type;
                    elseif Weapons[item] then
                        usersInventory[user_id].fastSlots[i].weight = Weapons[item].name;
                        usersInventory[user_id].fastSlots[i].description = Weapons[item].description;
                        usersInventory[user_id].fastSlots[i].weight = Weapons[item].weight;
                        usersInventory[user_id].fastSlots[i].type = Weapons[item].type;
                    else
                        usersInventory[user_id].fastSlots[i] = false;
                    end
                end
            end
        end

        if usersInventory[user_id].pocket then
            for i = 1, 7 do
                if usersInventory[user_id].pocket[i] then
                    local item = usersInventory[user_id].pocket[i].item;
                    if Items[item] then
                        usersInventory[user_id].pocket[i].name = Items[item].name;
                        usersInventory[user_id].pocket[i].description = Items[item].description;
                        usersInventory[user_id].pocket[i].weight = Items[item].weight;
                        usersInventory[user_id].pocket[i].type = Items[item].type;
                    elseif Weapons[item] then
                        usersInventory[user_id].pocket[i].weight = Weapons[item].name;
                        usersInventory[user_id].pocket[i].description = Weapons[item].description;
                        usersInventory[user_id].pocket[i].weight = Weapons[item].weight;
                        usersInventory[user_id].pocket[i].type = Weapons[item].type;
                    else
                        usersInventory[user_id].pocket[i] = false;
                    end
                end
            end
        end


        if usersInventory[user_id].backpack and usersInventory[user_id].clothes then
            for i = 1, 42 do
                if usersInventory[user_id].backpack[i] then
                    local item = usersInventory[user_id].backpack[i].item;
                    if Items[item] then
                        usersInventory[user_id].backpack[i].name = Items[item].name;
                        usersInventory[user_id].backpack[i].description = Items[item].description;
                        usersInventory[user_id].backpack[i].weight = Items[item].weight;
                        usersInventory[user_id].backpack[i].type = Items[item].type;
                    elseif Weapons[item] then
                        usersInventory[user_id].backpack[i].weight = Weapons[item].name;
                        usersInventory[user_id].backpack[i].description = Weapons[item].description;
                        usersInventory[user_id].backpack[i].weight = Weapons[item].weight;
                        usersInventory[user_id].backpack[i].type = Weapons[item].type;
                    else
                        usersInventory[user_id].backpack[i] = false;
                    end
                end
            end
        end
    end
end

local function formatInventory(user_id)
    if user_id and usersInventory[user_id] then
        for k, v in pairs(usersInventory[user_id].pocket) do
            usersInventory[user_id].pocket[k] = v
        end
        for i = 1, 7 do
            if not usersInventory[user_id].pocket[i] then
                usersInventory[user_id].pocket[i] = false;
            end
        end

        for k, v in pairs(usersInventory[user_id].backpack) do
            usersInventory[user_id].backpack[k] = v
        end

        for i = 1, 42 do
            if not usersInventory[user_id].backpack[i] then
                usersInventory[user_id].backpack[i] = false;
            end
        end

        for k, v in pairs(usersInventory[user_id].fastSlots) do
            usersInventory[user_id].fastSlots[k] = v
        end

        for i = 1, 5 do
            if not usersInventory[user_id].fastSlots[i] then
                usersInventory[user_id].fastSlots[i] = false;
            end
        end
        formatItems(user_id);
    end
end
-- local components <const> = {'supressor','grip'}
local function createItems()
    if Weapons then
        for weapon, v in pairs(Weapons) do
            -- weapon ammo
            local ammoCode = 'ammo-' .. weapon;
            local ammoItem = {
                name = Lang.Words['ammo'] .. ' ' .. v.name,
                weight = Config.ammoWeight or 0.01,
                type = 'weapons',
                description = Lang.Words['ammo_desc']:format(v.name),
                onUse = false,
            }
            Items[ammoCode] = ammoItem;
            -- weapon components
            if WeaponsComponents[weapon] then
                for component, hash in pairs(WeaponsComponents[weapon]) do
                    local itemCode = component .. '-' .. weapon;
                    local componentItem = {
                        name = (Lang.Words[component] or component) .. ' ' .. v.name,
                        weight = Config.componentsWeight or 0.01,
                        type = 'weapons',
                        description = Lang.Words['components_desc']:format(Lang.Words[component] or component),
                        onUse = function(user_id, source, item, itemData)
                            TriggerEvent('axr_inventory:useWeaponComponent', user_id, source, item, weapon)
                        end,
                    }
                    Items[itemCode] = componentItem;
                end
            end
        end
    end
end

-- init

AddEventHandler("vRP:playerSpawn", function(user_id, src, first_spawn)
    if first_spawn then
        if not usersInventory[user_id] then
            createItems();
            Citizen.Wait(1000)
            local dbData = exports[Config.Sql]:executeSync('SELECT inventory,weapons FROM vrp_users WHERE id = @user_id',
                { user_id = user_id })
            if dbData and #dbData > 0 then
                usersInventory[user_id] = json.decode(dbData[1].inventory)
                if dbData[1].weapons then
                    TriggerClientEvent('axr_inventory:setWeaponsData', src, json.decode(dbData[1].weapons))
                else
                    TriggerClientEvent('axr_inventory:setWeaponsData', src, {})
                end
                usersWeapons[user_id] = json.decode(dbData[1].weapons) or {};
            else
                usersInventory[user_id] = {}
            end

            if not usersInventory[user_id].fastSlots then
                usersInventory[user_id].fastSlots = {};
            end
            if not usersInventory[user_id].pocket then
                usersInventory[user_id].pocket = {};
            end
            if not usersInventory[user_id].backpack then
                usersInventory[user_id].backpack = {};
            end
            if not usersInventory[user_id].clothes then
                usersInventory[user_id].clothes = nil;
            end
            if not usersInventory[user_id].jewellery then
                usersInventory[user_id].jewellery = {
                    watch = false,
                    bracelet = false,
                    earings = false,
                    necklace = false
                }
            end
            for k, v in pairs(usersInventory[user_id].jewellery) do
                if v then
                    Config.dressJewellery(user_id, v.item, k)
                end
            end
            usersInventory[user_id].blocked = false;
            formatInventory(user_id);
        end
    end
end)

AddEventHandler("vRP:playerLeave", function(user_id)
    if usersInventory[user_id] then
        exports[Config.Sql]:execute('UPDATE vrp_users SET inventory = @newInv WHERE id = @user_id',
            { newInv = json.encode(usersInventory[user_id]), user_id = user_id })
        usersInventory[user_id] = nil;
        if usersWeapons[user_id] then
            exports[Config.Sql]:execute('UPDATE vrp_users SET weapons = @newWeapons WHERE id = @user_id',
                { user_id = user_id, newWeapons = json.encode(usersWeapons[user_id]) })
            usersWeapons[user_id] = nil;
        end

        for k, v in pairs(lockedVehicles) do
            if v and (v.player == user_id) then
                lockedVehicles[k] = nil;
            end
        end
    end
end)


AddEventHandler("onResourceStart", function(rs)
    if rs == "axr_inventory" then
        Citizen.CreateThread(function()
            Citizen.Wait(1000)
            createItems();
            Citizen.Wait(1000)
            for user_id, src in pairs(vRP.getUsers({})) do
                if user_id then
                    if not usersInventory[user_id] then
                        Citizen.Wait(100)
                        local dbData = exports[Config.Sql]:executeSync(
                            'SELECT inventory,weapons FROM vrp_users WHERE id = @user_id',
                            { user_id = user_id })
                        Citizen.Wait(100)
                        if dbData and #dbData > 0 then
                            usersInventory[user_id] = json.decode(dbData[1].inventory)
                            usersWeapons[user_id] = json.decode(dbData[1].weapons) or {};
                            if dbData[1].weapons then
                                TriggerClientEvent('axr_inventory:setWeaponsData', src, usersWeapons[user_id])
                            else
                                TriggerClientEvent('axr_inventory:setWeaponsData', src, {})
                            end
                        else
                            usersInventory[user_id] = {}
                        end

                        if not usersInventory[user_id].fastSlots then
                            usersInventory[user_id].fastSlots = {};
                        end
                        if not usersInventory[user_id].pocket then
                            usersInventory[user_id].pocket = {};
                        end
                        if not usersInventory[user_id].backpack then
                            usersInventory[user_id].backpack = {};
                        end
                        if not usersInventory[user_id].clothes then
                            usersInventory[user_id].clothes = nil;
                        end
                        if not usersInventory[user_id].jewellery then
                            usersInventory[user_id].jewellery = {
                                watch = false,
                                bracelet = false,
                                earings = false,
                                necklace = false
                            }
                        end
                        formatInventory(user_id);
                        usersInventory[user_id].blocked = false;
                    end
                end
            end
            local chestsData = exports[Config.Sql]:executeSync('SELECT id,type,items FROM axr_inventory')
            chests = {};
            if chestsData and #chestsData > 0 then
                for k, v in pairs(chestsData) do
                    chests[v.id] = {
                        type = v.type,
                        items = json.decode(v.items) or {},
                    }
                end
            end
        end)
    end
end)

AddEventHandler('onResourceStop', function(rs)
    if (rs == 'axr_inventory') then
        for user_id, newInventory in pairs(usersInventory) do
            if newInventory then
                exports[Config.Sql]:execute('UPDATE vrp_users SET inventory = @newInventory WHERE id = @user_id',
                    { user_id = user_id, newInventory = json.encode(newInventory) })
                if usersWeapons[user_id] then
                    exports[Config.Sql]:execute('UPDATE vrp_users SET weapons = @newWeapons WHERE id = @user_id',
                        { user_id = user_id, newWeapons = json.encode(usersWeapons[user_id]) })
                    usersWeapons[user_id] = nil;
                end
            end
        end
        -- if chests then
        --     for chestId, chestData in pairs(chests) do
        --         if chestData then
        --             exports[Config.Sql]:execute('UPDATE axr_inventory SET items = @newItems WHERE id = @chestId',
        --                 { chestId = chestId, newItems = (json.encode(chestData.items) or json.encode({})) })
        --         end
        --     end
        -- end
    end
end)

-- functions

local function isItemWeapon(item)
    return Weapons[item] ~= nil or false;
end

RegisterServerEvent('axr_inventory:tryOpenInventory', function(category, extraData, players)
    local src = source;
    local user_id = vRP.getUserId { src };
    if not user_id or not usersInventory[user_id] then return 0 end;
    if usersInventory[user_id].blocked then
        return Config.NotifyFunction(Lang.Notify['inventory_blocked'][1],
            Lang.Notify['inventory_blocked'][2], src)
    end
    local playerData = {
        user_id = user_id,
        name = Config.getPlayerRoleplayName(user_id, src),
        max_weight = exports.axr_inventory:getUserMaxWeight(user_id) or Config.defaultPlayerMaxWeight,
        weight = exports.axr_inventory:getUserWeight(user_id),
        cash = Config.getPlayerCashMoney(user_id, src) or 0,
    }
    local otherItems;
    if category == 'trunk' or category == 'glovebox' then
        if exports.axr_inventory:isVehicleLocked(extraData.vehicle, user_id) then
            return Config.NotifyFunction(Lang.Notify['locked_vehicle'][1], Lang.Notify['locked_vehicle'][2], src)
        end
        otherItems = exports.axr_inventory:getVehicleItems(user_id, category, extraData.vehicle) or {};
        if category == 'trunk' then
            extraData.otherMaxWeight = Config.defaultTrunkMaxWeight;
            if Config.vehiclesTrunkWeight[extraData.vehicle] then
                extraData.otherMaxWeight = Config.vehiclesTrunkWeight[extraData.vehicle];
            end
        else
            extraData.otherMaxWeight = Config.defaultGloveboxMaxWeight;
            if Config.vehiclesGloveboxWeight[extraData.vehicle] then
                extraData.otherMaxWeight = Config.vehiclesGloveboxWeight;
            end
        end
        lockedVehicles[#lockedVehicles + 1] = {
            vehicle = extraData.vehicle,
            vehOwner = user_id,
            player = user_id
        };
    end
    local nearPlayers = nil;
    if players then
        for src, dist in pairs(players) do
            if dist then
                if not nearPlayers then
                    nearPlayers = {}
                end
                local user = vRP.getUserId { src };
                nearPlayers[#nearPlayers + 1] = {
                    name = GetPlayerName(src),
                    user_id = user,
                };
            end
        end
    end
    if extraData.playerData then
        extraData.playerData.inventory       = usersInventory[extraData.playerData.user_id];
        extraData.playerData.playerMaxWeight = exports.axr_inventory:getUserMaxWeight(extraData.playerData.user_id);
        extraData.playerData.playerWeight    = exports.axr_inventory:getUserWeight(extraData.playerData.user_id);
        usersInventory[user_id].blocked      = true;
    end

    TriggerClientEvent('axr_inventory:openInventory', src, playerData, usersInventory[user_id], otherItems, category,
        extraData, nearPlayers);
    if Config.debug then
        print('Player with UserId ' .. user_id .. ' open the inventory, category: ' .. category)
    end
end)

RegisterServerEvent('axr_inventory:useFastSlot', function(slot)
    local src = source;
    local user_id = vRP.getUserId { src };
    if not user_id or not usersInventory[user_id] then return 0 end;
    if usersInventory[user_id].fastSlots then
        if usersInventory[user_id].fastSlots[slot] and usersInventory[user_id].fastSlots[slot].item then
            if not isItemWeapon(usersInventory[user_id].fastSlots[slot].item) then
                local configItem = Items[usersInventory[user_id].fastSlots[slot].item];
                if configItem and ((configItem.onUse and type(configItem.onUse) == 'function') or (type(configItem.onUse) == 'table' or configItem.onUse.__cfx_functionReference)) then
                    configItem.onUse(user_id, src, usersInventory[user_id].fastSlots[slot].item, configItem);
                end
            else
                local configItem = Weapons[usersInventory[user_id].fastSlots[slot].item];
                if configItem then
                    TriggerClientEvent('axr_inventory:useWeapon', src, configItem.hash);
                end
            end
        end
    end
end)

RegisterServerEvent('axr_inventory:saveWeapons', function(weaponTable)
    local src = source;
    local user_id = vRP.getUserId { src };
    if not user_id or not usersInventory[user_id] then return 0 end;
    if not weaponTable then return 0 end;
    usersWeapons[user_id] = weaponTable;
end)

RegisterServerEvent('axr_inventory:useWeaponComponent', function(user_id, src, item, weapon)
    if user_id and src then
        if Items[item] and Weapons[weapon] and WeaponsComponents[weapon] then
            local componentHash = string.gsub(item, '-' .. weapon, "");
            local componentType = componentHash;
            componentHash       = WeaponsComponents[weapon][componentHash];
            TriggerClientEvent('axr_inventory:setWeaponComponent', src, weapon, componentHash, componentType);
        end
    end
end)

RegisterCommand('llkk', function()
    print(json.encode(lockedVehicles));
end)

RegisterServerEvent('axr_inventory:destroyHandler', function(extraData)
    local src = source;
    local user_id = vRP.getUserId { src };
    if not user_id or not usersInventory[user_id] then return 0 end;
    if extraData.playerData and extraData.playerData.user_id then
        if usersInventory[extraData.playerData.user_id] then
            local target_src = vRP.getUserSource { extraData.playerData.user_id };
            if target_src then
                usersInventory[user_id].blocked = false;
                usersInventory[extraData.playerData.user_id].blocked = false;
            end
        end
    end
    if extraData.vehicle then
        for k, v in pairs(lockedVehicles) do
            if v and (v.vehicle == extraData.vehicle) and (v.player == user_id) then
                lockedVehicles[k] = nil;
            end
        end
    end
    if extraData.chestId then
        usersInventory[user_id].blocked = false;
        chests[extraData.chestId].locked = nil;
    end
end)

-- callbacks

registerCallback('axr_inventory:blockUserInventory', function(src)
    local user_id = vRP.getUserId { src };
    if user_id then
        usersInventory[user_id].blocked = true;
        return true
    end
    return false;
end)

registerCallback('axr_inventory:unblockUserInventory', function(src)
    local user_id = vRP.getUserId { src };
    if user_id then
        usersInventory[user_id].blocked = false;
        return true
    end
    return false;
end)

registerCallback('axr_inventory:unequipComponents', function(player, weapon)
    local src = player;
    local user_id = vRP.getUserId { src };
    if not user_id or not usersInventory[user_id] then return 0 end;
    if usersWeapons[user_id] and usersWeapons[user_id][weapon] then
        if usersWeapons[user_id][weapon].components then
            for componentType, _ in pairs(usersWeapons[user_id][weapon].components) do
                local itemCode = componentType .. '-' .. weapon;
                exports.axr_inventory:givePlayerItem(user_id, itemCode, 1, false, 'Unequip component');
                usersWeapons[user_id][weapon].components[componentType] = nil;
                local message = " **UserId:** " ..
                    user_id .. "**\nPlayerName:** " ..
                    GetPlayerName(player)
                sendDiscordLogs('Unequipt Components', message, 'unequipComponents');
            end
            return true;
        end
    end
end)

registerCallback('axr_inventory:receiveNeededAmmo', function(player, weapon, ammoToReceive)
    local src = player;
    local user_id = vRP.getUserId { src };
    if not user_id or not usersInventory[user_id] then return 0 end;
    if usersWeapons[user_id] and usersWeapons[user_id][weapon] then
        if exports.axr_inventory:hasPlayerItem(user_id, weapon) then
            local ammoCode = 'ammo-' .. weapon;
            exports.axr_inventory:givePlayerItem(user_id, ammoCode, ammoToReceive);
            return true;
        end
    end
end)

registerCallback('axr_inventory:saveInventory',
    function(player, playerItems, otherItems, category, userID, extraData, otherPlayer)
        local user_id = vRP.getUserId { player };
        if user_id and userID == user_id then
            if GetPlayerPing(player) ~= -1 and GetPlayerPing(player) <= 500 then
                if playerItems then
                    usersInventory[user_id] = playerItems;
                end
                if otherItems then
                    if category == 'trunk' then
                        if extraData and extraData.targetId then
                            exports[Config.Sql]:execute(
                                'UPDATE vrp_user_vehicles SET trunk = @newTrunk WHERE vehicle = @vehicle AND user_id = @user_id',
                                {
                                    vehicle = extraData.vehicle,
                                    newTrunk = json.encode(otherItems),
                                    user_id = extraData
                                        .targetId
                                })
                        else
                            exports[Config.Sql]:execute(
                                'UPDATE vrp_user_vehicles SET trunk = @newTrunk WHERE vehicle = @vehicle AND user_id = @user_id',
                                { vehicle = extraData.vehicle, newTrunk = json.encode(otherItems), user_id = user_id })
                        end
                    elseif category == 'glovebox' then
                        if extraData and extraData.targetId then
                            exports[Config.Sql]:execute(
                                'UPDATE vrp_user_vehicles SET glovebox = @newGlovebox WHERE vehicle = @vehicle AND user_id = @user_id',
                                {
                                    vehicle = extraData.vehicle,
                                    newGlovebox = json.encode(otherItems),
                                    user_id = extraData
                                        .targetId
                                })
                        else
                            exports[Config.Sql]:execute(
                                'UPDATE vrp_user_vehicles SET glovebox = @newGlovebox WHERE vehicle = @vehicle AND user_id = @user_id',
                                { vehicle = extraData.vehicle, newGlovebox = json.encode(otherItems), user_id = user_id })
                        end
                    elseif category == 'chest' then
                        if extraData.chestId then
                            exports[Config.Sql]:execute('UPDATE axr_inventory SET items = @newItems WHERE id = @chestId',
                                { chestId = extraData.chestId, newItems = (json.encode(otherItems) or json.encode({})) })
                            chests[extraData.chestId].items = otherItems;
                        end
                    end
                end
                if extraData.playerData and extraData.playerData.user_id then
                    if usersInventory[extraData.playerData.user_id] then
                        usersInventory[extraData.playerData.user_id] = otherPlayer;
                    end
                end
                return true;
            else
                print('eroare de salvare man3')
            end
        end
    end)


registerCallback('axr_inventory:destroyItem', function(player, item, amount, category, slot, userID)
    local user_id = vRP.getUserId { player };
    if user_id and userID == user_id then
        if usersInventory[userID] and usersInventory[userID][category] and usersInventory[userID][category][slot] then
            if usersInventory[userID][category][slot].item == item then
                if usersInventory[userID][category][slot].amount >= amount then
                    exports.axr_inventory:removePlayerItem(user_id, item, amount, true, 'Trash Item');
                    if Weapons[item] then
                        TriggerClientEvent('axr_inventory:removeWeaponFromDrop', player, item)
                    end
                    TriggerClientEvent('axr_inventory:playAnimation', player, "pickup_object", "pickup_low", 1500);
                    local message = " **UserId:** " ..
                        user_id .. "**\nPlayerName:** " ..
                        GetPlayerName(player) .. "\n**Item:** " .. item .. '\n**Amount:** ' .. amount
                    sendDiscordLogs('Destroy Item', message, 'dropItem');
                    Config.destroyItemHandler(user_id, item, amount);
                    return true;
                end
            end
        end
    end
end)

registerCallback('axr_inventory:useItem', function(player, item, category, slot, userID)
    local user_id = vRP.getUserId { player };
    if user_id and userID == user_id then
        if usersInventory[userID] and usersInventory[userID][category] and usersInventory[userID][category][slot] then
            if usersInventory[userID][category][slot].item == item then
                if not isItemWeapon(item) then
                    local configItem = Items[item];
                    if configItem and ((configItem.onUse and type(configItem.onUse) == 'function') or (type(configItem.onUse) == 'table' and configItem.onUse.__cfx_functionReference)) then
                        configItem.onUse(user_id, player, item, configItem);
                        local message = " **UserId:** " ..
                            user_id .. "**\nPlayerName:** " ..
                            GetPlayerName(player) .. "\n**Item:** " .. item .. '\n**Amount:** ' .. 1
                        sendDiscordLogs('Use Item', message, 'useItem');
                        Config.useItemHandler(user_id, item);
                        return true;
                    end
                else
                    local configItem = Weapons[item];
                    if configItem then
                        TriggerClientEvent('axr_inventory:useWeapon', player, configItem.hash);
                        local message = " **UserId:** " ..
                            user_id .. "**\nPlayerName:** " ..
                            GetPlayerName(player) .. "\n**WEAPON:** " .. item .. '\n**Amount:** ' .. 1
                        sendDiscordLogs('Use Item (WEAPON)', message, 'useItem');
                        return true;
                    end
                end
            end
        end
    end
end)

registerCallback('axr_inventory:giveItem', function(player, item, amount, category, slot, userID)
    local user_id = vRP.getUserId { player };
    if user_id and userID == user_id then
        if usersInventory[userID] and usersInventory[userID][category] and usersInventory[userID][category][slot] then
            if usersInventory[userID][category][slot].item == item then
                local itemAmount = exports.axr_inventory:getPlayerItemAmount(user_id, item);
                if itemAmount >= amount then
                    local target_id = Config.getNearestPlayerForGiveItem(user_id, player);
                    if target_id and usersInventory[target_id] then
                        local target_source = vRP.getUserSource { target_id }
                        if exports.axr_inventory:givePlayerItem(target_id, item, amount, true, 'Give Player Item') then
                            TriggerClientEvent('axr_inventory:updateNUIData', target_source, 'playerItems',
                                usersInventory[target_id]);
                            if exports.axr_inventory:removePlayerItem(user_id, item, amount, true, 'Give Player Item') then
                                if Weapons[item] then
                                    TriggerClientEvent('axr_inventory:removeWeapon', player, item);
                                end
                                TriggerClientEvent('axr_inventory:playAnimation', player, "mp_common", "givetake2_a",
                                    1500);
                                TriggerClientEvent('axr_inventory:playAnimation', target_source, "mp_common",
                                    "givetake2_a", 1500);
                                local message = " **UserId:** " ..
                                    user_id .. "**\nPlayerName:** " ..
                                    GetPlayerName(player) ..
                                    "\n**TargetId:** " ..
                                    target_id ..
                                    "\n**TargetName:** " ..
                                    GetPlayerName(target_source) .. "\n**Item:** " .. item .. '\n**Amount:** ' .. amount
                                sendDiscordLogs('Give Item to Player', message, 'giveItemToPlayer');
                                return true;
                            end
                        else
                            Config.NotifyFunction(Lang.Notify['no_player_inventory_space'][1],
                                Lang.Notify['no_player_inventory_space'][2], player);
                            -- return true;
                        end
                    end
                end
            end
        end
    end
end)

registerCallback('axr_inventory:requestReloadWeapon', function(player, weapon, toReload)
    local user_id = vRP.getUserId { player };
    if user_id then
        local weaponCfg = Weapons[weapon];
        local ammoItem = weaponCfg.ammo;
        local ammoAmount = exports.axr_inventory:getPlayerItemAmount(user_id, ammoItem);
        if (ammoAmount == 0) then return false, 0 end;
        if (ammoAmount > toReload) then
            exports.axr_inventory:removePlayerItem(user_id, ammoItem, toReload, false, 'Weapon Reload');
            return true, toReload;
        end
        if (ammoAmount < toReload) then
            exports.axr_inventory:removePlayerItem(user_id, ammoItem, ammoAmount, false, 'Weapon Reload');
            return true, ammoAmount;
        end
    end
end)

registerCallback('axr_inventory:requestWeaponComponent', function(player, componentItem)
    local user_id = vRP.getUserId { player };
    if user_id then
        return exports.axr_inventory:removePlayerItem(user_id, componentItem, 1, true, 'Equip Weapon Component');
    end
end)

registerCallback('axr_inventory:tryCheckPlayer', function(player, userID, targetId)
    local user_id = vRP.getUserId { player };
    if user_id and userID == user_id then
        if targetId and usersInventory[targetId] then
            local targetSource = vRP.getUserSource { targetId };
            if targetSource then
                if usersInventory[targetId].blocked then
                    return
                end
                usersInventory[targetId].blocked = true;
                local targetResponse = Config.request(targetId, targetSource,
                    Lang.Words['check_player']:format(GetPlayerName(player), user_id));
                if targetResponse then
                    Config.NotifyFunction(
                        Lang.Notify['check_player_accepted'][1]:format(GetPlayerName(user_id), user_id),
                        Lang.Notify['check_player_accepted'][2], targetSource);
                    return { user_id = targetId };
                else
                    usersInventory[targetId].blocked = false;
                    Config.NotifyFunction(
                        Lang.Notify['check_player_denied'][1]:format(GetPlayerName(targetSource), targetId),
                        Lang.Notify['check_player_denied'][2], player);
                end
            end
        end
    end
end)

-- commands
RegisterCommand(Config.giveItemCommand, function(source, args)
    local src = source;
    local user_id = vRP.getUserId { src };
    if user_id then
        if Config.adminPermission(user_id) then
            local target_id = args[1];
            if target_id then
                target_id = tonumber(target_id);
                if type(target_id) == 'number' then
                    local target_src = vRP.getUserSource { target_id };
                    if target_src then
                        local item = args[2];
                        if item then
                            local amount = args[3];
                            if amount then
                                amount = tonumber(amount);
                                if type(amount) == 'number' then
                                    amount = math.abs(math.ceil(amount));
                                    if exports.axr_inventory:givePlayerItem(target_id, item, amount, true, 'Market 24/7') then
                                        local message = " **UserId:** " ..
                                            user_id .. "**\nPlayerName:** " ..
                                            GetPlayerName(src) ..
                                            "\n**TargetId:** " ..
                                            target_id ..
                                            "\n**TargetName:** " ..
                                            GetPlayerName(target_src) ..
                                            "\n**Item:**" .. item .. "\n**Item Amount:**" .. amount
                                        sendDiscordLogs('Give Item', message, 'giveItem');
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            Config.NotifyFunction(Lang.Notify['no_command_permission'][1], Lang.Notify['no_command_permission'][2], src)
        end
    end
end)

RegisterCommand(Config.clearInventoryCommand, function(source, args)
    local src = source;
    if src ~= 0 then
        print('is src')
        local user_id = vRP.getUserId { src };
        if user_id then
            if Config.adminPermission then
                local target_id = args[1];
                if target_id then
                    target_id = tonumber(target_id);
                    if type(target_id) == 'number' then
                        local target_src = vRP.getUserSource { target_id };
                        if target_src then
                            usersInventory[target_id] = {
                                pocket = {},
                                backpack = {},
                                fastSlots = {},
                                clothes = nil,
                                jewellery = {
                                    watch    = false,
                                    earings  = false,
                                    bracelet = false,
                                    necklace = false
                                }
                            };
                            usersWeapons[target_id] = nil
                            exports[Config.Sql]:execute('UPDATE vrp_users SET weapons = @newWeapons WHERE id = @user_id',
                                { user_id = target_id, newWeapons = json.encode({}) })
                            exports[Config.Sql]:execute(
                                'UPDATE vrp_users SET inventory = @newInventory WHERE id = @user_id',
                                { user_id = target_id, newInventory = json.encode({}) })
                            TriggerClientEvent('axr_inventory:setWeaponsData', target_src, {})
                            Config.NotifyFunction(Lang.Notify['inventory_cleared'][1]:format(target_id, 'Online'),
                                Lang.Notify['inventory_cleared'][2], src);
                            local message = " **UserId:** " ..
                                user_id .. "**\nPlayerName:** " ..
                                GetPlayerName(src) ..
                                "\n**TargetId:** " ..
                                target_id ..
                                "\n**TargetName:** " ..
                                GetPlayerName(target_src)
                            sendDiscordLogs('Clear Player Inventory', message, 'clearInventory');
                        else
                            exports[Config.Sql]:execute('UPDATE vrp_users SET weapons = @newWeapons WHERE id = @user_id',
                                { user_id = target_id, newWeapons = json.encode({}) })
                            exports[Config.Sql]:execute(
                                'UPDATE vrp_users SET inventory = @newInventory WHERE id = @user_id',
                                { user_id = target_id, newInventory = json.encode({}) })
                            Config.NotifyFunction(Lang.Notify['inventory_cleared'][1]:format(target_id, 'Offline'),
                                Lang.Notify['inventory_cleared'][2], src);
                            local message = " **UserId:** " ..
                                user_id .. "**\nPlayerName:** " ..
                                GetPlayerName(src) ..
                                "\n**TargetId:** " ..
                                target_id ..
                                "\n**TargetName:** " ..
                                GetPlayerName(target_src)
                            sendDiscordLogs('Clear Player Inventory', message, 'clearInventory');
                        end
                    end
                end
            else
                Config.NotifyFunction(Lang.Notify['no_command_permission'][1], Lang.Notify['no_command_permission'][2],
                    src)
            end
        end
    else
        local target_id = args[1];
        if target_id then
            target_id = tonumber(target_id);
            if type(target_id) == 'number' then
                local target_src = vRP.getUserSource { target_id };
                if target_src then
                    usersInventory[target_id] = {
                        pocket = {},
                        backpack = {},
                        fastSlots = {},
                        clothes = nil,
                        jewellery = {
                            watch    = false,
                            earings  = false,
                            bracelet = false,
                            necklace = false
                        }
                    };
                    print('SUCCESFULLY CLEARED INVENTORY FOR USER ID ' .. target_id);
                    usersWeapons[target_id] = nil
                    exports[Config.Sql]:execute('UPDATE vrp_users SET weapons = @newWeapons WHERE id = @user_id',
                        { user_id = target_id, newWeapons = json.encode({}) })
                    exports[Config.Sql]:execute(
                        'UPDATE vrp_users SET inventory = @newInventory WHERE id = @user_id',
                        { user_id = target_id, newInventory = json.encode({}) })
                    TriggerClientEvent('axr_inventory:setWeaponsData', target_src, {})
                else
                    exports[Config.Sql]:execute('UPDATE vrp_users SET weapons = @newWeapons WHERE id = @user_id',
                        { user_id = target_id, newWeapons = json.encode({}) })
                    exports[Config.Sql]:execute(
                        'UPDATE vrp_users SET inventory = @newInventory WHERE id = @user_id',
                        { user_id = target_id, newInventory = json.encode({}) })
                end
            end
        end
    end
end)


RegisterCommand("checkinv", function()
    for k, v in pairs(usersInventory) do
        print();
        print('=====----USERID: ' .. k .. '----=====')
        print('=====--POCKET--=====')
        print(json.encode(usersInventory[k].pocket))
        print('=====--BACKPACK--=====')
        print(json.encode(usersInventory[k].backpack))
        print('=====--FASTSLOTS--=====')
        print(json.encode(usersInventory[k].fastSlots))
        print();
        print('======-JEWELLERY-=============')
        print(json.encode(usersInventory[k].jewellery))
    end
end)


RegisterCommand('ch', function()
    print(json.encode(chests))
end)

RegisterCommand('wps', function()
    print(json.encode(usersWeapons))
end)
