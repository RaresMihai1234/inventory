local function getPlayerInventory(user_id)
    if not user_id then return 0 end;
    return usersInventory[user_id];
end

local function getUserWeight(user_id)
    if not user_id then return 0 end;
    if usersInventory[user_id] then
        local weight = 0;
        if usersInventory[user_id].fastSlots then
            for k, v in pairs(usersInventory[user_id].fastSlots) do
                if v then
                    weight = weight + v.amount * v.weight;
                end
            end
        end
        if usersInventory[user_id].backpack then
            for k, v in pairs(usersInventory[user_id].backpack) do
                if v then
                    weight = weight + v.amount * v.weight;
                end
            end
        end
        if usersInventory[user_id].pocket then
            for k, v in pairs(usersInventory[user_id].pocket) do
                if v then
                    weight = weight + v.amount * v.weight;
                end
            end
        end
        local weightRound = tonumber(string.format("%.2f", weight));
        return weightRound;
    end
    return 0;
end

local function getUserMaxWeight(user_id)
    if not user_id then return 0 end;
    local max_weight = Config.defaultPlayerMaxWeight;
    if usersInventory[user_id] then
        if usersInventory[user_id].clothes and usersInventory[user_id].clothes.item then
            max_weight = max_weight + (Config.backpacks[usersInventory[user_id].clothes.item] or 0) +
                (Config.getExtraWeightSpace(user_id) or 0);
        end
    end
    return max_weight;
end

local function canCarryItem(user_id, item, amount)
    if not user_id then return 0 end;
    if usersInventory[user_id] then
        local itemWeight = exports.axr_inventory:getItemWeight(item);
        itemWeight = itemWeight or 0;
        itemWeight = itemWeight * amount;
        local maxWeight = getUserMaxWeight(user_id);
        local nowWeight = getUserWeight(user_id);
        if maxWeight >= nowWeight + itemWeight then
            return true;
        end
    end
    return false;
end

local function getVehicleItems(user_id, category, vehicle)
    if user_id then
        if category == 'trunk' then
            local vehData = Config.getTrunkItems(user_id, vehicle);
            return vehData
        elseif category == 'glovebox' then
            local vehData = Config.getGloveboxItems(user_id, vehicle);
            return vehData
        end
    end
end

local function getItemSlot(user_id, item)
    if user_id and usersInventory[user_id] then
        if usersInventory[user_id].pocket then
            for k, v in pairs(usersInventory[user_id].pocket) do
                if v and v.item == item then
                    return k, 'pocket';
                end
            end
        end
        if usersInventory[user_id].backpack then
            for k, v in pairs(usersInventory[user_id].backpack) do
                if v and v.item == item then
                    return k, 'backpack';
                end
            end
        end
        if usersInventory[user_id].fastSlots then
            for k, v in pairs(usersInventory[user_id].fastSlots) do
                if v and v.item == item then
                    return k, 'fastSlots';
                end
            end
        end
    end
end

local function getNextFreeSlot(user_id)
    if user_id and usersInventory[user_id] then
        if not usersInventory[user_id].pocket then return { 1, 'pocket' } end;
        for i = 1, 7 do
            if not usersInventory[user_id].pocket[i] then
                return i, 'pocket';
            end
        end

        if usersInventory[user_id].clothes then
            if not usersInventory[user_id].backpack then return { 1, 'backpack' } end;
            for i = 1, 42 do
                if not usersInventory[user_id].backpack[i] then
                    return i, 'backpack';
                end
            end
        end
    end
end

local function givePlayerItem(user_id, item, amount, showNotify, from)
    if user_id then
        local src = vRP.getUserSource { user_id };
        if src then
            local itemData = Items[item] or Weapons[item];

            if not itemData then
                return print(
                    'No item created in axr_inventory/config/items.lua or axr_inventory/config/weapons.lua')
            end;
            local weight = getUserWeight(user_id) or 0;
            local max_weight = getUserMaxWeight(user_id);
            if (weight + (itemData.weight * amount) < max_weight) then
                local slot, category;
                slot, category = getItemSlot(user_id, item);
                if slot then
                    usersInventory[user_id][category][slot].amount = usersInventory[user_id][category][slot].amount +
                        amount;
                    if showNotify then
                        Config.NotifyFunction(Lang.Notify['item_recived'][1]:format(itemData.name, amount),
                            Lang.Notify['item_recived'][1], src)
                    end
                    TriggerClientEvent('axr_inventory:updateNUIData', src, 'playerItems', usersInventory[user_id]);
                    return true;
                end
                if not slot then
                    slot, category = getNextFreeSlot(user_id);
                    if slot and category then
                        usersInventory[user_id][category][slot] = {
                            item        = item,
                            amount      = amount,
                            name        = itemData.name,
                            weight      = itemData.weight,
                            description = itemData.description,
                            slot        = slot,
                        }
                        TriggerClientEvent('axr_inventory:updateNUIData', src, 'playerItems', usersInventory[user_id]);
                        if showNotify then
                            Config.NotifyFunction(Lang.Notify['item_recived'][1]:format(item, amount),
                                Lang.Notify['item_recived'][1], src)
                        end
                        return true;
                    end
                end
            else
                Config.NotifyFunction(Lang.Notify['no_inventory_space'][1], Lang.Notify['no_inventory_space'][2], src);
            end
        end
    end
end

local function removePlayerItem(user_id, item, amount, showNotify, from)
    if user_id then
        local src = vRP.getUserSource { user_id };
        if src then
            local itemData = Items[item] or Weapons[item];
            if not itemData then
                return print(
                    'No item created in axr_inventory/config/items.lua or axr_inventory/config/weapons.lua')
            end;
            local slot, category = getItemSlot(user_id, item);
            if slot and category then
                if usersInventory[user_id][category][slot] then
                    usersInventory[user_id][category][slot].amount = usersInventory[user_id][category][slot].amount -
                        amount;
                    if usersInventory[user_id][category][slot].amount < 1 then
                        usersInventory[user_id][category][slot] = nil;
                    end
                    if Weapons[item] then
                        TriggerClientEvent('axr_inventory:removeWeapon', src, item);
                    end
                    TriggerClientEvent('axr_inventory:updateNUIData', src, 'playerItems', usersInventory[user_id]);
                    if showNotify then
                        Config.NotifyFunction(Lang.Notify['item_removed'][1]:format(item, amount),
                            Lang.Notify['item_removed'][2], src)
                    end
                    return true;
                end
            end
        end
    end
end

local function getPlayerItemAmount(user_id, item)
    if user_id then
        local src = vRP.getUserSource { user_id };
        if src then
            local itemData = Items[item] or Weapons[item];
            if not itemData then
                print('No item' .. item ..
                    ' created in axr_inventory/config/items.lua or axr_inventory/config/weapons.lua')
                return 0;
            end;
            local slot, category = getItemSlot(user_id, item);
            if slot and category then
                return usersInventory[user_id][category][slot].amount or 0;
            end
        end
    end
    return 0;
end

local function hasPlayerItem(user_id, item)
    if user_id then
        local src = vRP.getUserSource { user_id };
        if src then
            local itemData = Items[item] or Weapons[item];
            if not itemData then
                return print(
                    'No item created in axr_inventory/config/items.lua or axr_inventory/config/weapons.lua')
            end;
            local slot, category = getItemSlot(user_id, item);
            if slot and category then
                return true;
            end
        end
    end
    return false;
end

local function allowedChestType(type)
    return Config.allowedChestType[type];
end

local function isChest(chestId)
    for k, v in pairs(Config.staticChests) do
        if v.chestId == chestId then
            return true;
        end
    end
end

local function getChestTablePoz(chestId)
    for k, v in pairs(Config.staticChests) do
        if v.chestId == chestId then
            return k;
        end
    end
end

local function openChest(user_id, chestId, type, maxWeight)
    local src = vRP.getUserSource { user_id };
    if user_id and src and usersInventory[user_id] and chestId then
        if usersInventory[user_id].blocked then
            return Config.NotifyFunction(Lang.Notify['inventory_blocked'][1],
                Lang.Notify['inventory_blocked'][2], src)
        end
        if chests[chestId] and chests[chestId].locked then
            return Config.NotifyFunction(
                Lang.Notify['chest_locked'][1], Lang.Notify['chest_locked'], src)
        end
        if Config.staticChests and isChest(chestId) then
            local chestPoz = getChestTablePoz(chestId);
            if not Config.hasChestPermission(user_id, Config.staticChests[chestPoz]) then
                return Config.NotifyFunction(Lang.Notify['no_chest_permission'][1], Lang.Notify['no_chest_permission']
                    [2], src);
            end
        end
        if not chests[chestId] then
            if not allowedChestType(type) then return print('chest not allowed') end;
            chests[chestId] = {
                type = type,
                items = {},
            };
            exports[Config.Sql]:execute('INSERT INTO axr_inventory (id,type,items) VALUES (@id,@type,@items)', {
                id = chestId,
                type = type,
                items = json.encode({}),
            })
        end
        local playerData = {
            user_id = user_id,
            name = Config.getPlayerRoleplayName(user_id, src),
            max_weight = exports.axr_inventory:getUserMaxWeight(user_id) or Config.defaultPlayerMaxWeight,
            weight = exports.axr_inventory:getUserWeight(user_id),
            cash = Config.getPlayerCashMoney(user_id, src),
        }

        chests[chestId].locked = user_id;
        usersInventory[user_id].blocked = true;
        TriggerClientEvent('axr_inventory:openInventory', src, playerData, usersInventory[user_id], chests[chestId]
            .items, 'chest', { chestId = chestId, otherMaxWeight = maxWeight or Config.defaultChestMaxWeight }, nil);
        return true;
    end
end

RegisterServerEvent('axr_inventory:openChest', function(chestId, type, maxWeight)
    local src = source;
    local user_id = vRP.getUserId { src };
    if not user_id then return 0 end;
    openChest(user_id, chestId, type, maxWeight);
end)

local function createItem(item, name, description, weight, itemType, onUse)
    if not item then return 0 end;

    if not Items[item] then
        Items[item] = {
            name = name or 'No item name',
            weight = weight or 0.01,
            description = description or 'No item description',
            type = itemType or 'all',
            onUse = onUse,
        }
        return true
    else
        print('Item ' .. item .. ' already exist in axr_inventory/config/items.lua or has created in another script')
    end
    return false
end

local function getItemWeight(item)
    if not item then return 0.0 end;
    if Items[item] then
        return Items[item].weight or 0.0;
    elseif Weapons[item] then
        return Weapons[item].weight or 0.0;
    end
end

local function getItemType(item)
    if not item then return nil end;
    if Items[item] then
        return Items[item].type or 'all';
    elseif Weapons[item] then
        return Weapons[item].weight or 'all';
    end
end


local function getItemName(item)
    if not item then return nil end;
    if Items[item] then
        return Items[item].name or 'No Name';
    elseif Weapons[item] then
        return Weapons[item].name or 'No Name';
    end
end

local function hasBackpackEquipt(user_id)
    if not user_id then return 0 end;
    if usersInventory[user_id] then
        if usersInventory[user_id].clothes and usersInventory[user_id].clothes.item then
            for backpackItem, __ in pairs(Config.backpacks) do
                if backpackItem == usersInventory[user_id].clothes.item then
                    return true;
                end
            end
        end
    end

    return false;
end

local function getBackpackEquiptItem(user_id)
    if not user_id then return 0 end;
    if usersInventory[user_id] then
        if usersInventory[user_id].clothes and usersInventory[user_id].clothes.item then
            for backpackItem, __ in pairs(Config.backpacks) do
                if backpackItem == usersInventory[user_id].clothes.item then
                    return backpackItem;
                end
            end
        end
    end
end

local function isVehicleLocked(vehicle, owner_id)
    for k, v in pairs(lockedVehicles) do
        if v and (v.vehicle == vehicle) and (v.vehOwner == owner_id) then
            return true;
        end
    end
    return false;
end

exports('isVehicleLocked', isVehicleLocked);

local function openPlayerTrunk(user_id, target_id, vehicle)
    if user_id and vehicle then
        if usersInventory[user_id] then
            local src = vRP.getUserSource { user_id }
            if usersInventory[user_id].blocked then
                return Config.NotifyFunction(Lang.Notify['inventory_blocked'][1],
                    Lang.Notify['inventory_blocked'][2], src)
            end
            if Config.hasUserVehicle(target_id) then
                if isVehicleLocked(vehicle, target_id) then
                    return Config.NotifyFunction(Lang.Notify['locked_vehicle'][1], Lang.Notify['locked_vehicle'][2], src)
                end
                local playerData = {
                    user_id = user_id,
                    name = Config.getPlayerRoleplayName(user_id, src),
                    max_weight = exports.axr_inventory:getUserMaxWeight(user_id) or Config.defaultPlayerMaxWeight,
                    weight = exports.axr_inventory:getUserWeight(user_id),
                    cash = Config.getPlayerCashMoney(user_id, src),
                }
                local otherItems = exports.axr_inventory:getVehicleItems(target_id, 'trunk', vehicle) or {};
                local entity = Config.getTargetVehicleEntity(target_id, vehicle);
                local extraData = {
                    otherMaxWeight = Config.vehiclesTrunkWeight[vehicle] or Config.defaultTrunkMaxWeight,
                    targetId = target_id,
                    vehicle = vehicle,
                    entity = entity
                }
                TriggerClientEvent('axr_inventory:openInventory', src, playerData, usersInventory[user_id], otherItems,
                    'trunk', extraData,
                    nil);
                lockedVehicles[#lockedVehicles + 1] = {
                    vehicle = vehicle,
                    vehOwner = target_id,
                    player = user_id
                };
                return true;
            end
        end
    end
end

local function openPlayerGlovebox(user_id, target_id, vehicle)
    if user_id and vehicle then
        if usersInventory[user_id] then
            local src = vRP.getUserSource { user_id }
            if usersInventory[user_id].blocked then
                return Config.NotifyFunction(Lang.Notify['inventory_blocked'][1],
                    Lang.Notify['inventory_blocked'][2], src)
            end
            if Config.hasUserVehicle(target_id) then
                if isVehicleLocked(vehicle, target_id) then
                    return Config.NotifyFunction(Lang.Notify['locked_vehicle'][1], Lang.Notify['locked_vehicle'][2], src)
                end
                local playerData = {
                    user_id = user_id,
                    name = Config.getPlayerRoleplayName(user_id, src),
                    max_weight = exports.axr_inventory:getUserMaxWeight(user_id) or Config.defaultPlayerMaxWeight,
                    weight = exports.axr_inventory:getUserWeight(user_id),
                    cash = Config.getPlayerCashMoney(user_id, src),
                }
                local otherItems = exports.axr_inventory:getVehicleItems(target_id, 'glovebox', vehicle) or {};
                local extraData = {
                    otherMaxWeight = Config.vehiclesGloveboxWeight[vehicle] or Config.defaultGloveboxMaxWeight,
                    targetId = target_id,
                    vehicle = vehicle,
                    entity = nil,
                }
                TriggerClientEvent('axr_inventory:openInventory', src, playerData, usersInventory[user_id], otherItems,
                    'glovebox', extraData, nil);
                lockedVehicles[#lockedVehicles + 1] = {
                    vehicle = vehicle,
                    vehOwner = target_id,
                    player = user_id
                };
                return true;
            end
        end
    end
end

exports("getPlayerInventory", getPlayerInventory);
exports('getUserWeight', getUserWeight);
exports('getUserMaxWeight', getUserMaxWeight);
exports('getVehicleItems', getVehicleItems);
exports('givePlayerItem', givePlayerItem);
exports('removePlayerItem', removePlayerItem);
exports('getPlayerItemAmount', getPlayerItemAmount);
exports('hasPlayerItem', hasPlayerItem);
exports('openChest', openChest);
exports('createItem', createItem);
exports('getItemWeight', getItemWeight);
exports('getItemType', getItemType);
exports('getItemName', getItemName);
exports('hasBackpackEquipt', hasBackpackEquipt);
exports('getBackpackEquiptItem', getBackpackEquiptItem);
exports('openPlayerTrunk', openPlayerTrunk);
exports('openPlayerGlovebox', openPlayerGlovebox);
exports('canCarryItem', canCarryItem);
-- exports.axr_inventory:createItem('body_armor','Armura Antiglont','Armura Antiglont pentru schimburi de focuri',2.5,'all',function (user_id, source, item, itemData)
--     print('plm de armura',user_id,source,item,itemData)
-- end)
