vRP = Proxy.getInterface("vRP")
local resName = GetCurrentResourceName()
local function callback(cbName, cb, ...)
	TriggerServerEvent(resName .. ":s_callback:" .. cbName, ...)
	return RegisterNetEvent(resName .. ":c_callback:" .. cbName, function(...)
		cb(...)
	end)
end

function triggerCallback(cbName, cb, ...)
	local ev = false
	local f = function(...)
		if ev ~= false then
			RemoveEventHandler(ev)
		end
		cb(...)
	end
	ev = callback(cbName, f, ...)
	return ev
end

local NuiEvents <const> = {
	['closeForceInventory'] = function()
		SendNUIMessage({
			action = 'destroyMenu',
		})
	end,
	['openInventory'] = function(playerData, playerItems, otherItems, category, extraData, nearPlayers)
		inInventory = true;
		SendNUIMessage({
			action = 'openInventoryUI',
			playerData = playerData,
			playerItems = playerItems,
			otherItems = otherItems,
			category = category,
			extraData = extraData,
			nearPlayers = nearPlayers,
		})
		if category == 'trunk' then
			TriggerEvent('axr_inventory:playAnimation', "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
				"machinic_loop_mechandplayer", -1);
			if extraData.entity then
				SetVehicleDoorOpen(extraData.entity, 4, 0, false);
			end
		end
		if category == 'otherPlayer' then
			TriggerEvent('axr_inventory:playAnimation', "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
				"machinic_loop_mechandplayer", -1);
		end
		Citizen.CreateThread(function()
			while inInventory do
				Citizen.Wait(1000)
				triggerCallback('axr_inventory:getPlayerPing', function(ping)
					if (ping == -1 or ping >= 500) then
						inInventory = false;
						SendNUIMessage({
							action = 'destroyMenu',
						})
					elseif not (NetworkIsPlayerActive(PlayerId()) and IsPlayerOnline()) then
						inInventory = false;
						SendNUIMessage({
							action = 'destroyMenu',
						})
					end
				end)
			end
		end)
	end,
	['refreshInventory'] = function(data)
		if inInventory then
			local response = promise.new();
			triggerCallback('axr_inventory:saveInventory', function(saved)
				response:resolve(saved);
			end, data.playerItems, data.otherItems, data.category, data.userID, data.extraData, data.otherPlayer)
			Citizen.Await(response);
			return response.value;
		end
	end,
	['destroyItem'] = function(data)
		if inInventory then
			local response = promise.new();
			triggerCallback('axr_inventory:destroyItem', function(saved)
				response:resolve(saved);
			end, data.item, data.amount, data.category, data.slot, data.userID)
			Citizen.Await(response);
			return response.value;
		end
	end,
	['useItem'] = function(data)
		if inInventory then
			local response = promise.new();
			triggerCallback('axr_inventory:useItem', function(saved)
				response:resolve(saved);
			end, data.item, data.category, data.slot, data.userID)
			Citizen.Await(response);
			return response.value;
		end
	end,
	['giveItem'] = function(data)
		if inInventory then
			local response = promise.new();
			triggerCallback('axr_inventory:giveItem', function(saved)
				response:resolve(saved);
			end, data.item, data.amount, data.category, data.slot, data.userID)
			Citizen.Await(response);
			return response.value;
		end
	end,
	['isItemJewellery'] = function(data)
		local response = promise.new();
		local model = GetEntityModel(PlayerPedId())
		local mType = 'male';
		if (model == 'mp_f_freemode_01') then
			mType = 'female';
		end
		triggerCallback('axr_inventory:isItemJewellery', function(is)
			response:resolve(is);
		end, data.item, data.jewelleryType, mType)
		Citizen.Await(response);
		return response.value;
	end,
	['dressJewellery'] = function(data)
		if data and data.jewelleryType then
			TriggerServerEvent('axr_inventory:dressJewellery', data.item, data.jewelleryType)
		end
	end,
	['undressJewellery'] = function(data)
		if data and data.jewelleryType then
			TriggerServerEvent('axr_inventory:undressJewellery', data.item, data.jewelleryType)
		end
	end,
	['tryCheckPlayer'] = function(data)
		if inInventory then
			local response = promise.new();
			triggerCallback('axr_inventory:tryCheckPlayer', function(check)
				response:resolve(check);
			end, data.userID, data.targetId)
			Citizen.Await(response);
			return response.value;
		end
	end,
	['checkPlayer'] = function(data)
		TriggerEvent('axr_inventory:checkPlayer', data.playerData);
	end,
	['toogleClothes'] = function(data)
		if data.command then
			ExecuteCommand(data.command);
		end
	end,
	['updateNUIData'] = function(key, data)
		SendNUIMessage({
			action = 'updateInventoryData',
			key = key,
			data = data,
		})
	end,
	['nuiFocus'] = function(data)
		SetNuiFocus(data.toogle, data.toogle)
		if data.toogle == false then
			inInventory = false;
		end
	end,
	['destroyHandler'] = function(data)
		if data and data.extraData then
			TriggerServerEvent('axr_inventory:destroyHandler', data.extraData);
			if data.extraData.entity and data.category == 'trunk' then
				ClearPedTasksImmediately(PlayerPedId());
				SetVehicleDoorShut(data.extraData.entity, 4);
			end
			if data.category == 'otherPlayer' then
				ClearPedTasksImmediately(PlayerPedId());
			end
		end
	end,
	['discordLog'] = function(data)
		if data then
			triggerCallback('axr_inventory:sendDiscordLogs', function(sended)
				return true;
			end, data)
		end
	end,
	['dressBackpack'] = function(data)
		if data and data.backpack then
			if Config.backpacksClothes[data.backpack] then
				Config.setBackpackCloth(Config.backpacksClothes[data.backpack].id,
					Config.backpacksClothes[data.backpack].color, true);
			end
		end
	end,
	['undressBackpack'] = function(data)
		if data and data.backpack then
			if Config.backpacksClothes[data.backpack] then
				Config.setBackpackCloth(Config.backpacksClothes[data.backpack].id,
					Config.backpacksClothes[data.backpack].color, false);
			end
		end
	end,
}

RegisterNUICallback("inventory:events", function(data, cb)
	if not NuiEvents[data.eventname] then
		if data.eventname then
			return print("CALLBACK ERROR: System doesn't recognise Eventname " .. data.eventname .. "")
		else
			return print("CALLBACK ERROR: Eventname wasn't find in system")
		end
	end
	if not data.callback then
		NuiEvents[data.eventname](data);
		cb('ok');
	else
		local response <const> = NuiEvents[data.eventname](data);
		cb(response);
	end
end)

RegisterNetEvent("axr_inventory:openInventory",
	function(playerData, playerItems, otherItems, category, extraData, nearPlayers)
		if not playerData then return 0 end;
		NuiEvents['openInventory'](playerData, playerItems, otherItems, category, extraData, nearPlayers);
	end)

RegisterNetEvent('axr_inventory:updateNUIData', function(key, data)
	NuiEvents['updateNUIData'](key, data);
end)


RegisterNetEvent('axr_inventory:closeForceInventory', function()
	NuiEvents['closeForceInventory']()
end)
