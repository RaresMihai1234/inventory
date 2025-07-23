exports.axr_inventory:getPlayerInventory(user_id); --> return user inventory
exports.axr_inventory:getUserMaxWeight(user_id); -->  return user max weight
exports.axr_inventory:getUserWeight(user_id); --> return user weight 
exports.axr_inventory:getVehicleItems(user_id, category, vehicle_code); --> return vehicle items
exports.axr_inventory:getPlayerItemAmount(user_id, item_code); --> return user item amount 
exports.axr_inventory:hasPlayerItem(user_id,item_code); --> return true/false if user has the item
exports.axr_inventory:removePlayerItem(user_id, item_code, amount, notify, from); --> remove user item
exports.axr_inventory:givePlayerItem(user_id, item_code, amount, notify, from); --> give user item
exports.axr_inventory:openChest(user_id,chestId,type); --> return true if chest is opened by player