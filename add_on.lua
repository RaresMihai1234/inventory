Citizen.CreateThread(function ()
    Citizen.Wait(2500);
    exports.axr_inventory:onInventoryLoad();
end)

exports('onInventoryLoad',function ()
    if Items then
        TriggerEvent('vrp:setupItems',Items);
    end
    TriggerEvent('vrp:createItems');
    print('^2[AXR] axr_inventory load successfully^0');
end)
