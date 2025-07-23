inInventory = false;

RegisterCommand(Config.Command, function()
	if not Config.canUseInventory() then
		return Config.NotifyFunction(Lang.Notify['cant_use_inventory'][1],
			Lang.Notify['cant_use_inventory'][2])
	end
	
	local isNearVehicle, vehicle, entity = Config.getOwnedVehicle();
	local ped = PlayerPedId();
	local category = 'none';
	if isNearVehicle then
		if IsPedInVehicle(ped, entity, true) then
			category = 'glovebox';
		else
			category = 'trunk';
		end
	end
	local nearPlayers = {};
	nearPlayers = Config.getNearestPlayers();
	TriggerServerEvent("axr_inventory:tryOpenInventory", category, { vehicle = vehicle, entity = entity }, nearPlayers);
end)

RegisterNetEvent('axr_inventory:checkPlayer', function(playerData)
	TriggerServerEvent("axr_inventory:tryOpenInventory", 'otherPlayer', { playerData = playerData });
end)

RegisterKeyMapping(Config.Command, 'Open Inventory', 'keyboard', Config.Keybind);

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	for i = 1, 5 do
		RegisterCommand('fastslots' .. i, function()
			if inventoryBlocked then
				return Config.NotifyFunction(Lang.Notify['inventory_blocked'][1],
					Lang.Notify['inventory_blocked'][2])
			end;
			if Config.canUseFastSlots() then
				TriggerServerEvent('axr_inventory:useFastSlot', i)
			end
		end)
		RegisterKeyMapping('fastslots' .. i, 'Uses the item in your fastSlot ' .. i, 'keyboard', i)
	end
end)


local weapons = nil;
local currentWeapon;
local inAnim = false;

RegisterNetEvent('axr_inventory:removeWeaponFromDrop',function (weapon)
	if weapons and weapon then
		if weapons[weapon] then
			local ped = PlayerPedId();
			RemoveWeaponFromPed(ped, GetHashKey(weapon))
			RemoveAllPedWeapons(ped, true);
			weapons[weapon] = nil;
			currentWeapon = nil;
		end
	end
end)
RegisterNetEvent('axr_inventory:removeCurrentWeapon',function ()
	if weapons and currentWeapon then
		if weapons[currentWeapon] then
			local ped = PlayerPedId();
			RemoveWeaponFromPed(ped, GetHashKey(currentWeapon))
			RemoveAllPedWeapons(ped, true);
			weapons[currentWeapon] = nil;
			currentWeapon = nil;
		end
	end
end)
RegisterNetEvent('axr_inventory:useWeapon', function(weapon)
	if not weapons then return 0 end;
	if not weapons[weapon] then
		weapons[weapon] = {};
	end
	if inAnim then return 0 end;
	if not Config.canUseWeapon then return 0 end;
	local ped = PlayerPedId();
	if not currentWeapon or (currentWeapon == 'WEAPON_UNARMED') then
		inAnim = true;
		TriggerEvent('axr_inventory:playAnimation', 'reaction@intimidation@1h', 'intro', 1500);
		Citizen.Wait(1600);
		ClearPedTasks(ped);
		SetPedAmmo(ped, GetHashKey(weapon), 0)
		GiveWeaponToPed(ped, GetHashKey(weapon), weapons[weapon].ammo or 0, false, true);
		if weapons[weapon].components then
			for k, atash in pairs(weapons[weapon].components) do
				GiveWeaponComponentToPed(ped, GetHashKey(weapon), atash)
			end
		end
		currentWeapon = weapon;
		inAnim = false;
		refreshAmmo();
	elseif currentWeapon and currentWeapon ~= 'WEAPON_UNARMED' and currentWeapon ~= weapon then
		inAnim = true;
		TriggerEvent('axr_inventory:playAnimation', 'reaction@intimidation@1h', 'outro', 1500);
		Citizen.Wait(1600);
		ClearPedTasks(ped);
		local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
		weapons[currentWeapon].ammo = currentAmmo;
		RemoveWeaponFromPed(ped, GetHashKey(currentWeapon))
		TriggerEvent('axr_inventory:playAnimation', 'reaction@intimidation@1h', 'intro', 1500);
		Citizen.Wait(1600);
		ClearPedTasks(ped);
		SetPedAmmo(ped, GetHashKey(weapon), 0)
		GiveWeaponToPed(ped, GetHashKey(weapon), weapons[weapon].ammo or 0, false, true);
		if weapons[weapon].components then
			for k, atash in pairs(weapons[weapon].components) do
				GiveWeaponComponentToPed(ped, GetHashKey(weapon), atash)
			end
		end
		inAnim = false;
		currentWeapon = weapon;
	elseif currentWeapon == weapon then
		inAnim = true;
		TriggerEvent('axr_inventory:playAnimation', 'reaction@intimidation@1h', 'outro', 1500);
		Citizen.Wait(1600);
		ClearPedTasks(ped);
		local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
		weapons[weapon].ammo = currentAmmo;
		RemoveWeaponFromPed(ped, GetHashKey(weapon))
		RemoveAllPedWeapons(ped, true);
		inAnim = false;
		currentWeapon = nil;
	end
end)

RegisterNetEvent('axr_inventory:setWeaponsData', function(weaponData)
	weapons = weaponData or {};
end)

RegisterNetEvent('axr_inventory:setWeaponComponent', function(weapon, component, componentType)
	if weapon and component and weapons then
		if currentWeapon and currentWeapon == weapon and weapons[weapon] then
			triggerCallback('axr_inventory:requestWeaponComponent', function(given)
				if given then
					if not weapons[weapon].components then
						weapons[weapon].components = {}
					end
					weapons[weapon].components[componentType] = component;
					GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(weapon), GetHashKey(component))
				end
			end, componentType .. '-' .. weapon)
		else
			Config.NotifyFunction(Lang.Notify['no_weapon_in_hand'][1], Lang.Notify['no_weapon_in_hand'][2]);
		end
	end
end)

if not Config.autoReloadAmmo then
	RegisterCommand('reload', function()
		if not weapons then return 0 end;
		if currentWeapon and currentWeapon ~= 'WEAPON_UNARMED' then
			local ped = PlayerPedId();
			local magazineSize = GetMaxAmmoInClip(ped, GetHashKey(currentWeapon));
			local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon));
			local toReload = magazineSize;
			if not weapons[currentWeapon].ammo then
				weapons[currentWeapon].ammo = {};
			end
			if currentAmmo > 0 then
				toReload = magazineSize - currentAmmo;
			end
			triggerCallback('axr_inventory:requestReloadWeapon', function(reload, ammoAdded)
				if reload then
					ammoAdded = ammoAdded + currentAmmo;
					SetPedAmmo(ped, currentWeapon, ammoAdded);
					weapons[currentWeapon].ammo = ammoAdded;
					Citizen.Wait(100);
					MakePedReload(ped);
				end
			end, currentWeapon, toReload)
		end
	end)

	RegisterKeyMapping('reload', 'Reload your weapon', 'keyboard', 'R')
else
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			if weapons then
				if currentWeapon and currentWeapon ~= 'WEAPON_UNARMED' then
					Citizen.Wait(1)
					local ped = PlayerPedId();
					local magazineSize = GetMaxAmmoInClip(ped, GetHashKey(currentWeapon));
					local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon));
					local toReload = magazineSize;
					if not weapons[currentWeapon].ammo then
						weapons[currentWeapon].ammo = {};
					end
					if currentAmmo > 0 then
						toReload = magazineSize - currentAmmo;
					else
						Citizen.Wait(100)
						triggerCallback('axr_inventory:requestReloadWeapon', function(reload, ammoAdded)
							if reload then
								Citizen.Wait(1)
								ammoAdded = ammoAdded + currentAmmo;
								SetPedAmmo(ped, currentWeapon, ammoAdded);
								weapons[currentWeapon].ammo = ammoAdded;
								Citizen.Wait(1);
								MakePedReload(ped);
							end
						end, currentWeapon, toReload)
					end
				end
			end
		end
	end)
end

function refreshAmmo()
	Citizen.CreateThread(function()
		while currentWeapon and currentWeapon ~= 'WEAPON_UNARMED' do
			Citizen.Wait(1000);
			if inventoryBlocked == false then
				TriggerServerEvent('axr_inventory:saveWeapons', weapons)
			end
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10);
		local ped = PlayerPedId();
		if weapons and currentWeapon and currentWeapon ~= 'WEAPON_UNARMED' and not inventoryBlocked then
			local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon));
			weapons[currentWeapon].ammo = currentAmmo;
			if currentAmmo < 1 then
				GiveWeaponToPed(ped, GetHashKey(currentWeapon), 0, false, true)
			end
			if not Config.weaponAcces(currentWeapon) then
				currentWeapon = nil;
				RemoveAllPedWeapons(ped, true);
			end
		end
	end
end)


local inRange, notified = false, false;
Citizen.CreateThread(function()
	local ticks = 1000;
	while Config.staticChests do
		Citizen.Wait(ticks)
		ticks = 1000;
		inRange = false;
		local ped = PlayerPedId()
		for chestId, chestData in pairs(Config.staticChests) do
			local dist = #(chestData.coords - GetEntityCoords(ped))
			if dist < chestData.accessDist then
				inRange = true;
				ticks = 1;
				local r, g, b = table.unpack(chestData.markerColor);
				Config.drawMarker(chestData.marker, chestData.coords, r, g, b)
				if not notified then
					Config.showTextUI(Lang.Words.open_chest:format(chestData.name));
					notified = true;
				end
				if IsControlJustPressed(0, chestData.accessKey) then
					Config.HideStaticNotify();
					TriggerServerEvent('axr_inventory:openChest', chestData.chestId, chestData.type,
						chestData.chestWeight or Config.defaultChestMaxWeight);
				end
			end
		end
		if not inRange then
			if notified then
				notified = false;
				Config.HideStaticNotify();
			end
		end
	end
end)

local function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(10)
	end
end

RegisterCommand(Config.unequipComponentsCommand, function()
	triggerCallback('axr_inventory:getInventoryState', function(blocked)
		if blocked then
			return Config.NotifyFunction(Lang.Notify['inventory_blocked'][1],
				Lang.Notify['inventory_blocked'][2])
		end
		if weapons and currentWeapon and weapons[currentWeapon] and weapons[currentWeapon].components then
			triggerCallback('axr_inventory:blockUserInventory', function(done)
				if done then
					LoadAnim("mp_arresting")
					TaskPlayAnim(PlayerPedId(), "mp_arresting", "a_uncuff", 3.0, 3.0, -1, 50, 0, false, false, false)
					Config.progressBar(Lang.Words.unequip_components, Config.unequipComponentsTime * 1000);
					ClearPedTasksImmediately(PlayerPedId())
					triggerCallback('axr_inventory:unequipComponents', function(newComponents)
						if newComponents then
							local magazineSize = GetMaxAmmoInClip(PlayerPedId(), GetHashKey(currentWeapon));
							Citizen.Wait(100);
							local magazineSize2 = GetMaxAmmoInClip(PlayerPedId(), GetHashKey(currentWeapon));
							Citizen.Wait(100);
							RemoveAllPedWeapons(PlayerPedId(), true);
							weapons[currentWeapon].components = nil;
							Config.NotifyFunction(
								Lang.Notify['unequip_components'][1]:format(Weapons[currentWeapon].name),
								Lang.Notify['unequip_components'][2])
							if magazineSize > magazineSize2 and weapons[currentWeapon].ammo > magazineSize2 then
								local ammoToReceive = weapons[currentWeapon].ammo - magazineSize2;
								triggerCallback('axr_inventory:receiveNeededAmmo', function(received)
									if received then
										weapons[currentWeapon].ammo = magazineSize2;
									end
									RemoveAllPedWeapons(PlayerPedId(), true);
									currentWeapon = nil;
									Citizen.Wait(1000);
									triggerCallback('axr_inventory:unblockUserInventory', function(done)
										if not done then
											print('err')
										end
									end)
								end, currentWeapon, ammoToReceive);
							else
								triggerCallback('axr_inventory:unblockUserInventory', function(done)
									if not done then
										print('err')
									end
									RemoveAllPedWeapons(PlayerPedId(), true);
									currentWeapon = nil;
									Citizen.Wait(1000);
								end)
							end
						else
							triggerCallback('axr_inventory:unblockUserInventory', function(done)
								if not done then
									print('err')
								end
								Citizen.Wait(1000);
							end)
						end
					end, currentWeapon)
				end
			end)
		end
	end)
end)


RegisterNetEvent('axr_inventory:playAnimation', function(anim, idle, time)
	LoadAnim(anim)
	TaskPlayAnim(PlayerPedId(), anim, idle, 3.0, 3.0, -1, 50, 0, 0, 0, 0)
	if time > 0 then
		Citizen.Wait(time)
		StopAnimTask(PlayerPedId(), anim, idle, 1.0)
	end
end)

RegisterCommand('axr_inventory:removeWeapon', function(weapon)
	if weapon and weapons and weapons[weapon] then
		weapons[weapon] = nil;
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey(weapon));
	end
end)



Citizen.CreateThread(function()
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped, true)
	SetPedConfigFlag(ped, 48, 1)
	SetPedCanSwitchWeapon(ped, 0)
	SetWeaponsNoAutoreload(1)
	SetWeaponsNoAutoswap(1)
	while true do
		Citizen.Wait(1)
		DisableControlAction(0, 37, true) -- TAB
		DisableControlAction(0, 45, true) -- R
		DisableControlAction(0, 140, true) -- Melee attack
		RemoveAllPickupsOfType(14)   -- delete weapon drops
		if inInventory then
			DisableAllControlActions(0)
		end
		-- DisablePlayerFiring(PlayerPedId(), true)
	end
end)

RegisterCommand('ws', function()
	print(weapons)
end)
