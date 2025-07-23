const inventoryUI = new Vue({
  el: ".inventory",
  data: {
    active: false,
    refreshed: false,
    debug: false,
    targetId: 0,
    clothes: null,
    clothesTitle: "",
    playerMoney: 23450,
    playerWeight: 3.0,
    playerMaxWeight: 5.0,
    playerName: "",
    playerId: 0,
    playerItems: {},
    otherInventory: "none",
    otherWeight: 5.0,
    otherMaxWeight: 50.0,
    extraData: {},
    nearPlayers: null,
    otherPlayer: {},
    tryCheckPlayer: false,
    otherTypes: {
      trunk: true,
      glovebox: true,
      chest: true,
    },
    otherItems: null,
    notify: {
      show: false,
      message: "",
    },
    itemDesc: {
      show: false,
    },
    prompt: {
      show: false,
    },
  },
  mounted() {
    window.addEventListener("keydown", this.onKey);
    window.addEventListener("message", this.onMessage);
    window.addEventListener("mousedown", (event) => {
      const itemElement = event.target.closest(".item");
      if (itemElement) {
        if (event.which == 3) {
          if (!this.itemDesc.show) {
            const category = $(itemElement).data("inventory");
            const slot = $(itemElement).data("slot");
            inventoryUI.buildDescItem(category, slot, itemElement);
          } else {
            inventoryUI.destroyDescItem();
          }
        }
      }
    });
    window.addEventListener("contextmenu", (event) => {
      const itemElement = event.target.closest(".item");
      if (itemElement) {
        event.preventDefault();
      }
    });
  },
  methods: {
    onKey() {
      var theKey = event.code;
      if (theKey == "Escape" && this.notify.show == false) this.destroy();
    },

    async post(url, data = {}, resource = GetParentResourceName()) {
      const response = await fetch(`https://${resource}/${url}`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data),
      });

      return await response.json();
    },

    onMessage() {
      var data = event.data;
      if (data.action == "openInventoryUI") {
        this.build(
          data.playerData,
          data.playerItems,
          data.otherItems,
          data.category,
          data.extraData,
          data.nearPlayers
        );
      }
      if (data.action == "updateInventoryData") {
        switch (data.key) {
          case "playerItems":
            this.playerItems = data.data;
            break;
          case "destroyMenu":
            this.destroy();
            break;
        }
      }
    },

    addDraggable(element) {
      element.draggable({
        helper: "clone",
        containment: "window",
        scroll: false,
      });
      element.draggable({ disable: false });
    },

    isBackpack(item) {
      return InventoryConfig.backpacks[item] || false;
    },

    notifyError(message) {
      this.notify.message = message;
      this.notify.show = true;
      $(".inventory>div").css({
        filter: "blur(6px)",
        "pointer-events": "none",
      });
      $(".inventory>.notify").css({
        filter: "blur(0px)",
        "pointer-events": "auto",
      });
      $(".inventory>.notify").fadeIn();
      setTimeout(() => {
        this.notify.show = false;
        $(".inventory>.notify").fadeOut(100);
        setTimeout(() => {
          this.notify.message = "";
          $(".inventory>div").css({
            filter: "blur(0px)",
            "pointer-events": "auto",
          });
        }, 200);
      }, 3000);
    },

    async createClothes() {
      var clotherTbl = {};
      for (let i = 0; i <= this.clothes.column1.length; i++) {
        if (this.clothes.column1[i]) {
          if (this.clothes.column1[i].droppable) {
            const clothId = this.clothes.column1[i].clothId;
            console.log("create clothId -->", clothId);
            const clothElement = $(
              `.inventory>.playerCharacter>.options>.option[data-clothId="${clothId}"]`
            );
            clothElement.droppable({
              accept: ".item>img",
              drop: async function (event, ui) {
                const from = ui.draggable.parent().data("inventory");
                const to = $(this).data("inventory");
                const fromSlot = ui.draggable.parent().data("slot");
                const item = inventoryUI.playerItems[from][fromSlot - 1].item;
                if (!inventoryUI.playerItems.jewellery[clothId]) {
                  console.log('next')
                  const isJewellery = await inventoryUI.post(
                    "inventory:events",
                    {
                      eventname: "isItemJewellery",
                      item: item,
                      jewelleryType: clothId,
                      callback: true,
                    }
                  );
                  if (!isJewellery)
                    return inventoryUI.notifyError(
                      InventoryConfig.lang.notify.item_is_not_jewellery
                    );
                  if (inventoryUI.playerItems[from] && to == "jewellery") {
                    console.log("cloth ID", clothId);
                    if (inventoryUI.playerItems.jewellery == null) {
                      inventoryUI.playerItems.jewellery = {};
                    }
                    if (
                      inventoryUI.playerItems.jewellery &&
                      !inventoryUI.playerItems.jewellery[clothId]
                    ) {
                      let tempItem = Object.assign(
                        {},
                        inventoryUI.playerItems[from][fromSlot - 1]
                      );
                      inventoryUI.playerItems.jewellery[clothId] = tempItem;
                      inventoryUI.playerItems.jewellery[clothId].amount = 1;
                      if (
                        inventoryUI.playerItems[from][fromSlot - 1].amount > 1
                      ) {
                        inventoryUI.playerItems[from][fromSlot - 1].amount--;
                      } else {
                        inventoryUI.playerItems[from][fromSlot - 1] = null;
                      }
                      inventoryUI.post("inventory:events", {
                        eventname: "dressJewellery",
                        item: inventoryUI.playerItems.jewellery[clothId].item,
                        jewelleryType: clothId,
                      });
                      inventoryUI.refreshData();
                      const clothImg = $(
                        `.inventory>.playerCharacter>.options>.option[data-clothId="${clothId}"]>img`
                      );
                      inventoryUI.addDraggable(clothImg);
                    }
                  }
                } else {
                  inventoryUI.notifyError('Porti deja un accesoriu de acest tip')
                }
              },
            });
          }
        }
      }
      for (let i = 0; i <= this.clothes.column2.length; i++) {
        if (this.clothes.column2[i]) {
          if (this.clothes.column2[i].droppable) {
            const clothId = this.clothes.column2[i].clothId;
            const clothElement2 = $(
              `.inventory>.playerCharacter>.options>.option[data-clothId="${clothId}"]`
            );
            clothElement2.droppable({
              accept: ".item>img",
              drop: async function (event, ui) {
                const from = ui.draggable.parent().data("inventory");
                const to = $(this).data("inventory");
                const fromSlot = ui.draggable.parent().data("slot");
                const item = inventoryUI.playerItems[from][fromSlot - 1].item;
                if (!inventoryUI.playerItems.jewellery[clothId]) {
                  console.log('next')
                  const isJewellery = await inventoryUI.post(
                    "inventory:events",
                    {
                      eventname: "isItemJewellery",
                      item: item,
                      jewelleryType: clothId,
                      callback: true,
                    }
                  );
                  if (!isJewellery)
                    return inventoryUI.notifyError(
                      InventoryConfig.lang.notify.item_is_not_jewellery
                    );
                  if (inventoryUI.playerItems[from] && to == "jewellery") {
                    if (inventoryUI.playerItems.jewellery == null) {
                      inventoryUI.playerItems.jewellery = {};
                    }
                    if (
                      inventoryUI.playerItems.jewellery &&
                      !inventoryUI.playerItems.jewellery[clothId]
                    ) {
                      let tempItem = Object.assign(
                        {},
                        inventoryUI.playerItems[from][fromSlot - 1]
                      );
                      inventoryUI.playerItems.jewellery[clothId] = tempItem;
                      inventoryUI.playerItems.jewellery[clothId].amount = 1;
                      if (
                        inventoryUI.playerItems[from][fromSlot - 1].amount > 1
                      ) {
                        inventoryUI.playerItems[from][fromSlot - 1].amount--;
                      } else {
                        inventoryUI.playerItems[from][fromSlot - 1] = null;
                      }
                      inventoryUI.post("inventory:events", {
                        eventname: "dressJewellery",
                        item: inventoryUI.playerItems.jewellery[clothId].item,
                        jewelleryType: clothId,
                      });
                      inventoryUI.refreshData();
                      const clothImg = $(
                        `.inventory>.playerCharacter>.options>.option[data-clothId="${clothId}"]>img`
                      );
                      inventoryUI.addDraggable(clothImg);
                    }
                  }
                } else {
                  inventoryUI.notifyError('Porti deja un accesoriu de acest tip')
                }
              },
            });
          }
        }
      }
    },

    // backpack equipt
    createBackpackBox() {
      const backpackElement = $(
        `.inventory>.playerCharacter>.options>.option[data-command="backpack"]`
      );
      backpackElement.droppable({
        accept: ".item>img",
        drop: async function (event, ui) {
          const from = ui.draggable.parent().data("inventory");
          const to = $(this).data("inventory");
          const fromSlot = ui.draggable.parent().data("slot");
          if (
            inventoryUI.playerItems[from] &&
            to == "clothes" &&
            inventoryUI.playerItems.clothes == null
          ) {
            const item = inventoryUI.playerItems[from][fromSlot - 1].item;
            if (item && inventoryUI.isBackpack(item)) {
              let tempItem = Object.assign(
                {},
                inventoryUI.playerItems[from][fromSlot - 1]
              );
              inventoryUI.playerItems.clothes = tempItem;
              inventoryUI.playerItems.clothes.amount = 1;
              inventoryUI.playerItems[from][fromSlot - 1].amount--;

              if (inventoryUI.playerItems[from][fromSlot - 1].amount == 0) {
                inventoryUI.playerItems[from][fromSlot - 1] = null;
              }
              inventoryUI.playerMaxWeight += InventoryConfig.backpacks[item];
              inventoryUI.refreshData();
              const backpackImg = $(
                `.inventory>.playerCharacter>.options>.option[data-command="backpack"]>img`
              );
              inventoryUI.post("inventory:events", {
                eventname: "dressBackpack",
                backpack: item,
              });
              inventoryUI.addDraggable(backpackImg);
            } else
              inventoryUI.notifyError(
                InventoryConfig.lang.notify.no_backpack_item
              );
          }
        },
      });
    },

    destroy() {
      if (this.active) {
        this.active = false;
        inventoryUI.post("inventory:events", {
          eventname: "nuiFocus",
          toogle: false,
        });
        inventoryUI.post("inventory:events", {
          eventname: "destroyHandler",
          extraData: this.extraData,
          category: this.otherInventory,
        });
        this.extraData = {};
        this.nearPlayers = null;
        this.otherItems = null;
        this.playerData = null;
        this.playerItems = {};
        this.playerMoney = 0;
        this.playerMaxWeight = 10;
        this.playerWeight = 0;
        this.otherInventory = "none";
        this.destroyDescItem();
        this.destroyPrompt();
      }
    },

    build(
      playerData,
      playerItems,
      otherItems,
      category,
      extraData,
      nearPlayers
    ) {
      this.clothes = InventoryConfig.clothes;
      this.clothesTitle = InventoryConfig.clothesTitle;
      this.playerMoney = playerData.cash;
      this.playerMaxWeight = playerData.max_weight;
      this.playerWeight = playerData.weight;
      this.playerName = playerData.name;
      this.playerId = playerData.user_id;
      this.playerItems = playerItems;
      this.otherInventory = category;
      this.extraData = extraData;
      this.nearPlayers = nearPlayers;
      if (extraData.playerData) {
        this.otherPlayer = extraData.playerData.inventory;
        this.otherMaxWeight = extraData.playerData.playerMaxWeight;
        this.otherWeight = extraData.playerData.playerWeight;
        this.nearPlayers = null;
      } else {
        this.otherItems = otherItems;
      }
      if (extraData.otherMaxWeight) {
        this.otherMaxWeight = extraData.otherMaxWeight;
      }

      this.active = true;
      inventoryUI.post("inventory:events", {
        eventname: "nuiFocus",
        toogle: true,
      });
      this.createClothes();
      setTimeout(() => {
        this.createBackpackBox();
        if (this.otherInventory != "none" && this.otherItems)
          this.otherWeight = this.calculateOtherWeight();
        $(".item").droppable({
          accept: ".item>img",
          drop: async function (event, ui) {
            const from = ui.draggable.parent().data("inventory");
            const to = $(this).data("inventory");

            const fromSlot = ui.draggable.parent().data("slot");
            const toSlot = $(this).data("slot");

            if (to == from && toSlot == fromSlot) return 0;

            // other player
            if (inventoryUI.otherInventory == "otherPlayer") {
              // other player pocket

              if (to == "other-pocket" || from == "other-pocket") {
                if (to == from) {
                  // from other pocket to other pocket
                  const newTo = "pocket";
                  const newFrom = "pocket";
                  const item =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                  if (!item) return console.log("error no item");
                  if (inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is item on toSlot
                    const tblCopy = inventoryUI.otherPlayer[newTo][toSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = tblCopy;
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].slot =
                      fromSlot;
                    inventoryUI.refreshData();
                    return 0;
                  }
                  if (!inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is not item on toSlot
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                    inventoryUI.refreshData();
                    setTimeout(() => {
                      const newImg = $(
                        `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                      );
                      inventoryUI.addDraggable(newImg);
                    }, 100);
                    return 0;
                  }
                }

                if (from == "other-pocket" && to == "other-backpack") {
                  const newTo = "backpack";
                  const newFrom = "pocket";
                  const item =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                  if (!item) return console.log("error no item");

                  if (inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is item on toSlot
                    const tblCopy = inventoryUI.otherPlayer[newTo][toSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = tblCopy;
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].slot =
                      fromSlot;
                    inventoryUI.refreshData();
                    return 0;
                  }
                  if (!inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is not item on toSlot
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                    inventoryUI.refreshData();
                    setTimeout(() => {
                      const newImg = $(
                        `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                      );
                      inventoryUI.addDraggable(newImg);
                    }, 100);
                    return 0;
                  }
                }
                if (from == "other-pocket" && to == "other-fastSlots") {
                  const newTo = "backpack";
                  const newFrom = "fastSlots";
                  const item =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                  if (!item) return console.log("error no item");

                  if (inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is item on toSlot
                    const tblCopy = inventoryUI.otherPlayer[newTo][toSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = tblCopy;
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].slot =
                      fromSlot;
                    inventoryUI.refreshData();
                    return 0;
                  }
                  if (!inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is not item on toSlot
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                    inventoryUI.refreshData();
                    setTimeout(() => {
                      const newImg = $(
                        `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                      );
                      inventoryUI.addDraggable(newImg);
                    }, 100);
                    return 0;
                  }
                }
                if (to == "other-pocket" && from == "other-backpack") {
                  const newTo = "pocket";
                  const newFrom = "backpack";
                  const item =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                  if (!item) return console.log("error no item");

                  if (inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is item on toSlot
                    const tblCopy = inventoryUI.otherPlayer[newTo][toSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = tblCopy;
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].slot =
                      fromSlot;
                    inventoryUI.refreshData();
                    return 0;
                  }
                  if (!inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is not item on toSlot
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                    inventoryUI.refreshData();
                    setTimeout(() => {
                      const newImg = $(
                        `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                      );
                      inventoryUI.addDraggable(newImg);
                    }, 100);
                    return 0;
                  }
                }
                if (to == "other-pocket" && from == "other-fastSlots") {
                  const newTo = "pocket";
                  const newFrom = "fastSlots";
                  const item =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                  if (!item) return console.log("error no item");

                  if (inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is item on toSlot
                    const tblCopy = inventoryUI.otherPlayer[newTo][toSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = tblCopy;
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].slot =
                      fromSlot;
                    inventoryUI.refreshData();
                    return 0;
                  }
                  if (!inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is not item on toSlot
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                    inventoryUI.refreshData();
                    setTimeout(() => {
                      const newImg = $(
                        `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                      );
                      inventoryUI.addDraggable(newImg);
                    }, 100);
                    return 0;
                  }
                }
              }

              if (to == "other-backpack" || from == "other-backpack") {
                if (to == from) {
                  // from other backpack to other backpack
                  const newTo = "backpack";
                  const newFrom = "backpack";
                  const item =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                  if (!item) return console.log("error no item");

                  if (inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is item on toSlot
                    const tblCopy = inventoryUI.otherPlayer[newTo][toSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = tblCopy;
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].slot =
                      fromSlot;
                    inventoryUI.refreshData();
                    return 0;
                  }
                  if (!inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is not item on toSlot
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                    inventoryUI.refreshData();
                    setTimeout(() => {
                      const newImg = $(
                        `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                      );
                      inventoryUI.addDraggable(newImg);
                    }, 100);
                    return 0;
                  }
                }
                if (to == 'other-fastSlots' && from == 'other-backpack') {
                  // from other backpack to other backpack
                  const newTo = "fastSlots";
                  const newFrom = "backpack";
                  const item =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                  if (!item) return console.log("error no item");

                  if (inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is item on toSlot
                    const tblCopy = inventoryUI.otherPlayer[newTo][toSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = tblCopy;
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].slot =
                      fromSlot;
                    inventoryUI.refreshData();
                    return 0;
                  }
                  if (!inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is not item on toSlot
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                    inventoryUI.refreshData();
                    setTimeout(() => {
                      const newImg = $(
                        `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                      );
                      inventoryUI.addDraggable(newImg);
                    }, 100);
                    return 0;
                  }
                }
                if (from == 'other-fastSlots' && to == 'other-backpack') {
                  // from other backpack to other backpack
                  const newTo = "backpack";
                  const newFrom = "fastSlots";
                  const item =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                  if (!item) return console.log("error no item");

                  if (inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is item on toSlot
                    const tblCopy = inventoryUI.otherPlayer[newTo][toSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = tblCopy;
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].slot =
                      fromSlot;
                    inventoryUI.refreshData();
                    return 0;
                  }
                  if (!inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is not item on toSlot
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                    inventoryUI.refreshData();
                    setTimeout(() => {
                      const newImg = $(
                        `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                      );
                      inventoryUI.addDraggable(newImg);
                    }, 100);
                    return 0;
                  }
                }
              }

              if (to == "other-fastSlots" || from == "other-fastSlots") {
                if (to == from) {
                  // from other fastSlots to other fastSlots
                  const newTo = "fastSlots";
                  const newFrom = "fastSlots";
                  const item =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                  if (!item) return console.log("error no item");

                  if (inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is item on toSlot
                    const tblCopy = inventoryUI.otherPlayer[newTo][toSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = tblCopy;
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].slot =
                      fromSlot;
                    inventoryUI.refreshData();
                    return 0;
                  }
                  if (!inventoryUI.otherPlayer[newTo][toSlot - 1]) {
                    // is not item on toSlot
                    inventoryUI.otherPlayer[newTo][toSlot - 1] =
                      inventoryUI.otherPlayer[newFrom][fromSlot - 1];
                    inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                    inventoryUI.refreshData();
                    setTimeout(() => {
                      const newImg = $(
                        `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                      );
                      inventoryUI.addDraggable(newImg);
                    }, 100);
                    return 0;
                  }
                }
              }
              // from player inventory to other player pocket
              if (
                to == "other-pocket" &&
                (from == "pocket" || from == "backpack" || from == "fastSlots")
              ) {
                const newTo = "pocket";
                const item = inventoryUI.playerItems[from][fromSlot - 1].item;
                if (!item) return console.log("error no item");
                var amountnew =
                  inventoryUI.playerItems[from][fromSlot - 1].amount;
                if (inventoryUI.playerItems[from][fromSlot - 1].amount > 1) {
                  // check item amount for prompt
                  const amount2 = await inventoryUI.buildPrompt(
                    inventoryUI.formatNotifyMessage(
                      InventoryConfig.lang.prompt.move_item,
                      [inventoryUI.playerItems[from][fromSlot - 1].name]
                    )
                  );
                  amountnew = parseInt(amount2);
                  if (amountnew && typeof amountnew == "number") {
                    if (amountnew > 0) {
                      amountnew = Math.abs(Math.floor(amountnew));
                    } else return 0;
                  } else return 0;
                }
                var itemsWeight =
                  amountnew *
                  inventoryUI.playerItems[from][fromSlot - 1].weight;
                if (
                  inventoryUI.playerItems[from][fromSlot - 1].amount < amountnew
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_minimum_items
                  );
                if (
                  inventoryUI.otherWeight + itemsWeight >
                  inventoryUI.otherMaxWeight
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_inventory_space
                  );

                var itemD = inventoryUI.getItemPosition(
                  inventoryUI.playerItems[from][fromSlot - 1].item,
                  "other-player"
                );
                if (itemD != null) {
                  // check if item is already in player inventory

                  var newTo2 = itemD[1],
                    newSlot = itemD[0];
                  var itemAmount =
                    inventoryUI.playerItems[from][fromSlot - 1].amount *
                    inventoryUI.playerItems[from][fromSlot - 1].weight;
                  // if (inventoryUI.playerWeight + itemAmount > inventoryUI.playerMaxWeight) return inventoryUI.notifyError(InventoryConfig.lang.notify.no_inventory_space);
                  inventoryUI.otherPlayer[newTo2][newSlot].amount += amountnew;
                  inventoryUI.playerItems[from][fromSlot - 1].amount -=
                    amountnew;
                  if (inventoryUI.playerItems[from][fromSlot - 1].amount < 1) {
                    inventoryUI.playerItems[from][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: newSlot,
                    from: from,
                    to: to,
                    type: "giveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                } else {
                  let tempItem = Object.assign(
                    {},
                    inventoryUI.playerItems[from][fromSlot - 1]
                  );
                  inventoryUI.otherPlayer[newTo][toSlot - 1] = tempItem;
                  inventoryUI.otherPlayer[newTo][toSlot - 1].amount = amountnew;
                  inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                  inventoryUI.playerItems[from][fromSlot - 1].amount -=
                    amountnew;
                  if (inventoryUI.playerItems[from][fromSlot - 1].amount < 1) {
                    inventoryUI.playerItems[from][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: toSlot,
                    from: from,
                    to: to,
                    type: "giveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                }
              }

              // from player inventory to other player pocket
              if (
                to == "other-backpack" &&
                (from == "pocket" || from == "backpack" || from == "fastSlots")
              ) {
                const newTo = "backpack";
                const item = inventoryUI.playerItems[from][fromSlot - 1].item;
                if (!item) return console.log("error no item");
                var amountnew =
                  inventoryUI.playerItems[from][fromSlot - 1].amount;
                if (inventoryUI.playerItems[from][fromSlot - 1].amount > 1) {
                  // check item amount for prompt
                  const amount2 = await inventoryUI.buildPrompt(
                    inventoryUI.formatNotifyMessage(
                      InventoryConfig.lang.prompt.move_item,
                      [inventoryUI.playerItems[from][fromSlot - 1].name]
                    )
                  );
                  amountnew = parseInt(amount2);
                  if (amountnew && typeof amountnew == "number") {
                    if (amountnew > 0) {
                      amountnew = Math.abs(Math.floor(amountnew));
                    } else return 0;
                  } else return 0;
                }
                var itemsWeight =
                  amountnew *
                  inventoryUI.playerItems[from][fromSlot - 1].weight;
                if (
                  inventoryUI.playerItems[from][fromSlot - 1].amount < amountnew
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_minimum_items
                  );
                if (
                  inventoryUI.otherWeight + itemsWeight >
                  inventoryUI.otherMaxWeight
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_inventory_space
                  );

                var itemD = inventoryUI.getItemPosition(
                  inventoryUI.playerItems[from][fromSlot - 1].item,
                  "other-player"
                );
                if (itemD != null) {
                  // check if item is already in player inventory

                  var newTo2 = itemD[1],
                    newSlot = itemD[0];
                  var itemAmount =
                    inventoryUI.playerItems[from][fromSlot - 1].amount *
                    inventoryUI.playerItems[from][fromSlot - 1].weight;
                  if (
                    inventoryUI.otherWeight + itemAmount >
                    inventoryUI.otherMaxWeight
                  )
                    return inventoryUI.notifyError(
                      InventoryConfig.lang.notify.no_inventory_space
                    );
                  inventoryUI.otherPlayer[newTo2][newSlot].amount += amountnew;
                  inventoryUI.playerItems[from][fromSlot - 1].amount -=
                    amountnew;
                  if (inventoryUI.playerItems[from][fromSlot - 1].amount < 1) {
                    inventoryUI.playerItems[from][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: newSlot,
                    from: from,
                    to: to,
                    type: "giveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                } else {
                  let tempItem = Object.assign(
                    {},
                    inventoryUI.playerItems[from][fromSlot - 1]
                  );
                  inventoryUI.otherPlayer[newTo][toSlot - 1] = tempItem;
                  inventoryUI.otherPlayer[newTo][toSlot - 1].amount = amountnew;
                  inventoryUI.otherPlayer[newTo][toSlot - 1].slot = toSlot;
                  inventoryUI.playerItems[from][fromSlot - 1].amount -=
                    amountnew;
                  if (inventoryUI.playerItems[from][fromSlot - 1].amount < 1) {
                    inventoryUI.playerItems[from][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: toSlot,
                    from: from,
                    to: to,
                    type: "giveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                }
              }


              // from other player pocket to player
              if (
                from == "other-pocket" &&
                (to == "pocket" || to == "backpack" || to == "fastSlots")
              ) {
                const newFrom = "pocket";
                const item =
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                if (!item) return console.log("error no item");
                var amountnew =
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount;
                if (inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount > 1) {
                  // check item amount for prompt
                  const amount2 = await inventoryUI.buildPrompt(
                    inventoryUI.formatNotifyMessage(
                      InventoryConfig.lang.prompt.move_item,
                      [inventoryUI.otherPlayer[newFrom][fromSlot - 1].name]
                    )
                  );
                  amountnew = parseInt(amount2);
                  if (amountnew && typeof amountnew == "number") {
                    if (amountnew > 0) {
                      amountnew = Math.abs(Math.floor(amountnew));
                    } else return 0;
                  } else return 0;
                }
                var itemsWeight =
                  amountnew *
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].weight;
                if (
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount <
                  amountnew
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_minimum_items
                  );
                if (
                  inventoryUI.playerWeight + itemsWeight >
                  inventoryUI.playerMaxWeight
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_inventory_space
                  );

                var itemD = inventoryUI.getItemPosition(
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].item,
                  "player"
                );
                if (itemD != null) {
                  // check if item is already in player inventory

                  var newTo2 = itemD[1],
                    newSlot = itemD[0];
                  var itemAmount =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount *
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].weight;
                  // if (inventoryUI.playerWeight + itemAmount > inventoryUI.playerMaxWeight) return inventoryUI.notifyError(InventoryConfig.lang.notify.no_inventory_space);
                  inventoryUI.playerItems[newTo2][newSlot].amount += amountnew;
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount -=
                    amountnew;
                  if (
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount < 1
                  ) {
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: newSlot,
                    from: from,
                    to: to,
                    type: "reciveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                } else {
                  let tempItem = Object.assign(
                    {},
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1]
                  );
                  inventoryUI.playerItems[to][toSlot - 1] = tempItem;
                  inventoryUI.playerItems[to][toSlot - 1].amount = amountnew;
                  inventoryUI.playerItems[to][toSlot - 1].slot = toSlot;
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount -=
                    amountnew;
                  if (
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount < 1
                  ) {
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: toSlot,
                    from: from,
                    to: to,
                    type: "reciveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                }
              }

              // from other player backpack to player
              if (
                from == "other-backpack" &&
                (to == "pocket" || to == "backpack" || to == "fastSlots")
              ) {
                const newFrom = "backpack";
                const item =
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                if (!item) return console.log("error no item");
                var amountnew =
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount;
                if (inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount > 1) {
                  // check item amount for prompt
                  const amount2 = await inventoryUI.buildPrompt(
                    inventoryUI.formatNotifyMessage(
                      InventoryConfig.lang.prompt.move_item,
                      [inventoryUI.otherPlayer[newFrom][fromSlot - 1].name]
                    )
                  );
                  amountnew = parseInt(amount2);
                  if (amountnew && typeof amountnew == "number") {
                    if (amountnew > 0) {
                      amountnew = Math.abs(Math.floor(amountnew));
                    } else return 0;
                  } else return 0;
                }
                var itemsWeight =
                  amountnew *
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].weight;
                if (
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount <
                  amountnew
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_minimum_items
                  );
                if (
                  inventoryUI.playerWeight + itemsWeight >
                  inventoryUI.playerMaxWeight
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_inventory_space
                  );

                var itemD = inventoryUI.getItemPosition(
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].item,
                  "player"
                );
                if (itemD != null) {
                  // check if item is already in player inventory

                  var newTo2 = itemD[1],
                    newSlot = itemD[0];
                  var itemAmount =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount *
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].weight;
                  // if (inventoryUI.playerWeight + itemAmount > inventoryUI.playerMaxWeight) return inventoryUI.notifyError(InventoryConfig.lang.notify.no_inventory_space);
                  inventoryUI.playerItems[newTo2][newSlot].amount += amountnew;
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount -=
                    amountnew;
                  if (
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount < 1
                  ) {
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: newSlot,
                    from: from,
                    to: to,
                    type: "reciveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                } else {
                  let tempItem = Object.assign(
                    {},
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1]
                  );
                  inventoryUI.playerItems[to][toSlot - 1] = tempItem;
                  inventoryUI.playerItems[to][toSlot - 1].amount = amountnew;
                  inventoryUI.playerItems[to][toSlot - 1].slot = toSlot;
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount -=
                    amountnew;
                  if (
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount < 1
                  ) {
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: toSlot,
                    from: from,
                    to: to,
                    type: "reciveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                }
              }

              // from other player fastslots to player
              if (
                from == "other-fastSlots" &&
                (to == "pocket" || to == "backpack" || to == "fastSlots")
              ) {
                const newFrom = "fastSlots";
                const item =
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                if (!item) return console.log("error no item");
                var amountnew =
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount;
                if (inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount > 1) {
                  // check item amount for prompt
                  const amount2 = await inventoryUI.buildPrompt(
                    inventoryUI.formatNotifyMessage(
                      InventoryConfig.lang.prompt.move_item,
                      [inventoryUI.otherPlayer[newFrom][fromSlot - 1].name]
                    )
                  );
                  amountnew = parseInt(amount2);
                  if (amountnew && typeof amountnew == "number") {
                    if (amountnew > 0) {
                      amountnew = Math.abs(Math.floor(amountnew));
                    } else return 0;
                  } else return 0;
                }
                var itemsWeight =
                  amountnew *
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].weight;
                if (
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount <
                  amountnew
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_minimum_items
                  );
                if (
                  inventoryUI.playerWeight + itemsWeight >
                  inventoryUI.playerMaxWeight
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_inventory_space
                  );

                var itemD = inventoryUI.getItemPosition(
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].item,
                  "player"
                );
                if (itemD != null) {
                  // check if item is already in player inventory

                  var newTo2 = itemD[1],
                    newSlot = itemD[0];
                  var itemAmount =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount *
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].weight;
                  // if (inventoryUI.playerWeight + itemAmount > inventoryUI.playerMaxWeight) return inventoryUI.notifyError(InventoryConfig.lang.notify.no_inventory_space);
                  inventoryUI.playerItems[newTo2][newSlot].amount += amountnew;
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount -=
                    amountnew;
                  if (
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount < 1
                  ) {
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: newSlot,
                    from: from,
                    to: to,
                    type: "reciveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                } else {
                  let tempItem = Object.assign(
                    {},
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1]
                  );
                  inventoryUI.playerItems[to][toSlot - 1] = tempItem;
                  inventoryUI.playerItems[to][toSlot - 1].amount = amountnew;
                  inventoryUI.playerItems[to][toSlot - 1].slot = toSlot;
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount -=
                    amountnew;
                  if (
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount < 1
                  ) {
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: toSlot,
                    from: from,
                    to: to,
                    type: "reciveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                }
              }
              // from other player fastslot to player
              if (
                from == "other-fastSlots" &&
                (to == "pocket" || to == "backpack" || to == "fastSlots")
              ) {
                const newFrom = "fastSlots";
                const item =
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].item;
                if (!item) return console.log("error no item");
                var amountnew =
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount;
                if (inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount > 1) {
                  // check item amount for prompt
                  const amount2 = await inventoryUI.buildPrompt(
                    inventoryUI.formatNotifyMessage(
                      InventoryConfig.lang.prompt.move_item,
                      [inventoryUI.otherPlayer[newFrom][fromSlot - 1].name]
                    )
                  );
                  amountnew = parseInt(amount2);
                  if (amountnew && typeof amountnew == "number") {
                    if (amountnew > 0) {
                      amountnew = Math.abs(Math.floor(amountnew));
                    } else return 0;
                  } else return 0;
                }
                var itemsWeight =
                  amountnew *
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].weight;
                if (
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount <
                  amountnew
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_minimum_items
                  );
                if (
                  inventoryUI.playerWeight + itemsWeight >
                  inventoryUI.playerMaxWeight
                )
                  return inventoryUI.notifyError(
                    InventoryConfig.lang.notify.no_inventory_space
                  );

                var itemD = inventoryUI.getItemPosition(
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].item,
                  "player"
                );
                if (itemD != null) {
                  // check if item is already in player inventory

                  var newTo2 = itemD[1],
                    newSlot = itemD[0];
                  var itemAmount =
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount *
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].weight;
                  // if (inventoryUI.playerWeight + itemAmount > inventoryUI.playerMaxWeight) return inventoryUI.notifyError(InventoryConfig.lang.notify.no_inventory_space);
                  inventoryUI.playerItems[newTo2][newSlot].amount += amountnew;
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount -=
                    amountnew;
                  if (
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount < 1
                  ) {
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: newSlot,
                    from: from,
                    to: to,
                    type: "reciveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                } else {
                  let tempItem = Object.assign(
                    {},
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1]
                  );
                  inventoryUI.playerItems[to][toSlot - 1] = tempItem;
                  inventoryUI.playerItems[to][toSlot - 1].amount = amountnew;
                  inventoryUI.playerItems[to][toSlot - 1].slot = toSlot;
                  inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount -=
                    amountnew;
                  if (
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1].amount < 1
                  ) {
                    inventoryUI.otherPlayer[newFrom][fromSlot - 1] = null;
                  }
                  inventoryUI.post("inventory:events", {
                    eventname: "discordLog",
                    category: 'otherPlayer',
                    fromFile: "js",
                    item: item,
                    amount: amountnew,
                    fromSlot: fromSlot,
                    toSlot: toSlot,
                    from: from,
                    to: to,
                    type: "reciveItem",
                  });
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);
                  return 0;
                }
              }
            }

            // player inventory(fastSlots,pocket and backpack)

            if (
              inventoryUI.playerItems[from] &&
              inventoryUI.playerItems[to] &&
              from != "clothes"
            ) {
              if (
                (from == "backpack" || to == "backpack") &&
                inventoryUI.playerItems.clothes == null
              )
                return 0;

              if (
                inventoryUI.playerItems[from][fromSlot - 1] &&
                inventoryUI.playerItems[to][toSlot - 1]
              ) {
                const item = inventoryUI.playerItems[from][fromSlot - 1].item;
                if (!item) return console.log("error no item");

                const tblCopy = inventoryUI.playerItems[to][toSlot - 1];
                inventoryUI.playerItems[to][toSlot - 1] =
                  inventoryUI.playerItems[from][fromSlot - 1];
                inventoryUI.playerItems[from][fromSlot - 1] = tblCopy;
                inventoryUI.playerItems[to][toSlot - 1].slot = toSlot;
                inventoryUI.playerItems[from][fromSlot - 1].slot = fromSlot;
                inventoryUI.refreshData();
                return 0;
              }
              if (
                inventoryUI.playerItems[from][fromSlot - 1] &&
                !inventoryUI.playerItems[to][toSlot - 1] &&
                from != "clothes"
              ) {
                const item = inventoryUI.playerItems[from][fromSlot - 1].item;
                if (!item) return console.log("error no item");

                inventoryUI.playerItems[to][toSlot - 1] =
                  inventoryUI.playerItems[from][fromSlot - 1];
                inventoryUI.playerItems[to][toSlot - 1].slot = toSlot;
                inventoryUI.playerItems[from][fromSlot - 1] = null;
                inventoryUI.refreshData();
                setTimeout(() => {
                  const newImg = $(
                    `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                  );
                  inventoryUI.addDraggable(newImg);
                }, 100);
                return 0;
              }
            }


            if (from == "jewellery") {
              // const clothID = $(this).data("clothId");
              if (inventoryUI.playerItems[to][toSlot - 1])
                return console.log("need to be free slot");
              var itemD = inventoryUI.getItemPosition(
                inventoryUI.playerItems.jewellery[fromSlot].item,
                "player"
              );

              if (itemD != null) {
                // check if item is already in player inventory

                var newTo = itemD[1],
                  newSlot = itemD[0];
                inventoryUI.post("inventory:events", {
                  eventname: "undressJewellery",
                  item: inventoryUI.playerItems.jewellery[fromSlot].item,
                  jewelleryType: fromSlot,
                });
                inventoryUI.playerItems[newTo][newSlot].amount++;
                inventoryUI.playerItems.jewellery[fromSlot] = null;
                inventoryUI.refreshData();
                inventoryUI.destroyDescItem();
                setTimeout(() => {
                  const newImg = $(
                    `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                  );
                  inventoryUI.addDraggable(newImg);
                  inventoryUI.createClothes();
                }, 100);
                return 0;
              } else {
                inventoryUI.post("inventory:events", {
                  eventname: "undressJewellery",
                  item: inventoryUI.playerItems.jewellery[fromSlot].item,
                  jewelleryType: fromSlot,
                });
                inventoryUI.playerItems[to][toSlot - 1] =
                  inventoryUI.playerItems.jewellery[fromSlot];
                inventoryUI.playerItems[to][toSlot - 1].slot = toSlot;
                inventoryUI.playerItems.jewellery[fromSlot] = null;
                inventoryUI.refreshData();
                inventoryUI.destroyDescItem();
                setTimeout(() => {
                  const newImg = $(
                    `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                  );
                  inventoryUI.addDraggable(newImg);
                  inventoryUI.createClothes();
                }, 100);
                return 0;
              }
            }

            // backpack unequipt

            if (from == "clothes") {
              if (to != "pocket")
                return inventoryUI.notifyError(
                  InventoryConfig.lang.notify.unequip_backpack_error
                );
              if (inventoryUI.playerItems[to][toSlot - 1])
                return console.log("need to be free slot");
              if (!inventoryUI.isBackpackFree())
                return inventoryUI.notifyError(
                  InventoryConfig.lang.notify.free_the_backpack
                );
              var itemD = inventoryUI.getItemPosition(
                inventoryUI.playerItems.clothes.item,
                "player"
              );

              if (itemD != null) {
                // check if item is already in player inventory

                var newTo = itemD[1],
                  newSlot = itemD[0];
                inventoryUI.playerItems[newTo][newSlot].amount +=
                  inventoryUI.playerItems.clothes.amount;
                inventoryUI.playerMaxWeight -=
                  InventoryConfig.backpacks[
                  inventoryUI.playerItems.clothes.item
                  ];
                inventoryUI.post("inventory:events", {
                  eventname: "undressBackpack",
                  backpack: inventoryUI.playerItems.clothes.item,
                });
                inventoryUI.playerItems.clothes = null;
                inventoryUI.refreshData();
                inventoryUI.destroyDescItem();
                setTimeout(() => {
                  const newImg = $(
                    `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                  );
                  inventoryUI.addDraggable(newImg);
                  inventoryUI.createBackpackBox();
                }, 100);
                return 0;
              } else {
                inventoryUI.playerItems[to][toSlot - 1] =
                  inventoryUI.playerItems[from];
                inventoryUI.playerItems[to][toSlot - 1].slot = toSlot;
                inventoryUI.playerMaxWeight -=
                  InventoryConfig.backpacks[
                  inventoryUI.playerItems.clothes.item
                  ];
                inventoryUI.post("inventory:events", {
                  eventname: "undressBackpack",
                  backpack: inventoryUI.playerItems.clothes.item,
                });
                inventoryUI.playerItems.clothes = null;
                inventoryUI.refreshData();
                inventoryUI.destroyDescItem();
                setTimeout(() => {
                  const newImg = $(
                    `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                  );
                  inventoryUI.addDraggable(newImg);
                  inventoryUI.createBackpackBox();
                }, 100);
                return 0;
              }
              return 0;
            }

            // other inventory
            if (
              inventoryUI.otherInventory == to ||
              inventoryUI.otherInventory == from
            ) {
              // from other inventory --> to other inventory
              if (to == from) {
                if (
                  inventoryUI.otherItems[fromSlot - 1] &&
                  !inventoryUI.otherItems[toSlot - 1]
                ) {
                  const item = inventoryUI.otherItems[fromSlot - 1].item;
                  if (!item) return console.log("error no item");

                  inventoryUI.otherItems[toSlot - 1] =
                    inventoryUI.otherItems[fromSlot - 1];
                  inventoryUI.otherItems[toSlot - 1].slot = toSlot;
                  inventoryUI.otherItems[fromSlot - 1] = null;
                  inventoryUI.refreshData();
                  setTimeout(() => {
                    const newImg = $(
                      `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                    );
                    inventoryUI.addDraggable(newImg);
                  }, 100);

                  return 0;
                } else if (
                  inventoryUI.otherItems[fromSlot - 1] &&
                  inventoryUI.otherItems[toSlot - 1]
                ) {
                  const item = inventoryUI.otherItems[fromSlot - 1].item;
                  if (!item) return console.log("error no item");

                  const tblCopy = inventoryUI.otherItems[toSlot - 1];
                  inventoryUI.otherItems[toSlot - 1] =
                    inventoryUI.otherItems[fromSlot - 1];
                  inventoryUI.otherItems[fromSlot - 1] = tblCopy;
                  inventoryUI.otherItems[toSlot - 1].slot = toSlot;
                  inventoryUI.otherItems[fromSlot - 1].slot = fromSlot;
                  inventoryUI.refreshData();
                  return 0;
                }
              }
              // from other inventory to player inventory
              else if (inventoryUI.playerItems[to]) {
                if (
                  (from == "backpack" || to == "backpack") &&
                  inventoryUI.playerItems.clothes == null
                )
                  return 0;
                const item = inventoryUI.otherItems[fromSlot - 1].item;
                if (!item) return console.log("error no item");
                // check if toSlot is not free
                if (inventoryUI.playerItems[to][toSlot - 1]) {
                  if (inventoryUI.playerItems[to][toSlot - 1].item == item) {
                    // check same item
                    var am = inventoryUI.otherItems[fromSlot - 1].amount;
                    if (am > 1) {
                      const amount2 = await inventoryUI.buildPrompt(
                        inventoryUI.formatNotifyMessage(
                          InventoryConfig.lang.prompt.move_item,
                          [inventoryUI.otherItems[fromSlot - 1].name]
                        )
                      );
                      am = parseInt(amount2);
                      if (am && typeof am == "number") {
                        if (am > 0) {
                          am = Math.abs(Math.floor(am));
                        } else return 0;
                      } else return 0;
                    }
                    var itemAmount =
                      am * inventoryUI.otherItems[fromSlot - 1].weight;
                    if (inventoryUI.otherItems[fromSlot - 1].amount < am)
                      return inventoryUI.notifyError(
                        InventoryConfig.lang.notify.no_minimum_items
                      );
                    if (
                      inventoryUI.playerWeight + itemAmount >
                      inventoryUI.playerMaxWeight
                    )
                      return inventoryUI.notifyError(
                        InventoryConfig.lang.notify.no_inventory_space
                      );

                    inventoryUI.playerItems[to][toSlot - 1].amount += am;
                    inventoryUI.otherItems[fromSlot - 1].amount -= am;
                    inventoryUI.post("inventory:events", {
                      eventname: "discordLog",
                      category: category,
                      fromFile: "js",
                      item: item,
                      amount: am,
                      fromSlot: fromSlot,
                      toSlot: toSlot,
                      from: from,
                      to: to,
                      type: "reciveItem",
                    });
                    if (inventoryUI.otherItems[fromSlot - 1].amount == 0) {
                      inventoryUI.otherItems[fromSlot - 1] = null;
                    }
                    inventoryUI.refreshData();
                    return 0;
                  }
                  var amountnew = inventoryUI.otherItems[fromSlot - 1].amount;
                  if (inventoryUI.otherItems[fromSlot - 1].amount > 1) {
                    // check item amount for prompt
                    const amount2 = await inventoryUI.buildPrompt(
                      inventoryUI.formatNotifyMessage(
                        InventoryConfig.lang.prompt.move_item,
                        [inventoryUI.otherItems[fromSlot - 1].name]
                      )
                    );
                    amountnew = parseInt(amount2);
                    if (amountnew && typeof amountnew == "number") {
                      if (amountnew > 0) {
                        amountnew = Math.abs(Math.floor(amountnew));
                      } else {
                        amountnew = inventoryUI.otherItems[fromSlot - 1].amount;
                      }
                    } else return 0;
                  }

                  var itemsWeight =
                    amountnew * inventoryUI.otherItems[fromSlot - 1].weight;
                  if (inventoryUI.otherItems[fromSlot - 1].amount < amountnew)
                    return inventoryUI.notifyError(
                      InventoryConfig.lang.notify.no_minimum_items
                    );
                  if (
                    inventoryUI.playerWeight + itemsWeight >
                    inventoryUI.playerMaxWeight
                  )
                    return inventoryUI.notifyError(
                      InventoryConfig.lang.notify.no_inventory_space
                    );

                  // all
                  var itemD = inventoryUI.getItemPosition(
                    inventoryUI.otherItems[fromSlot - 1].item,
                    "player"
                  );
                  if (itemD != null) {
                    // check if item is already in player inventory

                    var newTo = itemD[1],
                      newSlot = itemD[0];
                    inventoryUI.playerItems[newTo][newSlot].amount += amountnew;
                    inventoryUI.otherItems[fromSlot - 1].amount -= amountnew;
                    inventoryUI.post("inventory:events", {
                      eventname: "discordLog",
                      category: category,
                      fromFile: "js",
                      item: item,
                      amount: amountnew,
                      fromSlot: fromSlot,
                      toSlot: toSlot,
                      from: from,
                      to: to,
                      type: "reciveItem",
                    });
                    if (inventoryUI.otherItems[fromSlot - 1].amount == 0) {
                      inventoryUI.otherItems[fromSlot - 1] = null;
                    }
                    inventoryUI.refreshData();
                  } else {
                    return inventoryUI.notifyError(
                      InventoryConfig.lang.notify.slot_not_free
                    );
                  }

                  return 0;
                }
                // check if toSlot is free
                if (!inventoryUI.playerItems[to][toSlot - 1]) {
                  // move more than one item
                  if (inventoryUI.otherItems[fromSlot - 1].amount > 1) {
                    const amount2 = await inventoryUI.buildPrompt(
                      inventoryUI.formatNotifyMessage(
                        InventoryConfig.lang.prompt.move_item,
                        [inventoryUI.otherItems[fromSlot - 1].name]
                      )
                    );
                    var amountnew = parseInt(amount2);
                    if (amountnew && typeof amountnew == "number") {
                      if (amountnew > 0) {
                        amountnew = Math.abs(Math.floor(amountnew));
                      } else return 0;
                    } else return 0;
                    var itemsWeight =
                      amountnew * inventoryUI.otherItems[fromSlot - 1].weight;
                    if (inventoryUI.otherItems[fromSlot - 1].amount < amountnew)
                      return inventoryUI.notifyError(
                        InventoryConfig.lang.notify.no_minimum_items
                      );
                    if (
                      inventoryUI.playerWeight + itemsWeight >
                      inventoryUI.playerMaxWeight
                    )
                      return inventoryUI.notifyError(
                        InventoryConfig.lang.notify.no_inventory_space
                      );
                    var itemD = inventoryUI.getItemPosition(
                      inventoryUI.otherItems[fromSlot - 1].item,
                      "player"
                    );
                    if (itemD != null) {
                      // check if item is already in player inventory

                      var newTo = itemD[1],
                        newSlot = itemD[0];
                      // is already item
                      inventoryUI.otherItems[fromSlot - 1].amount -= amountnew;

                      if (inventoryUI.otherItems[fromSlot - 1].amount == 0) {
                        inventoryUI.otherItems[fromSlot - 1] = null;
                      }
                      inventoryUI.playerItems[newTo][newSlot].amount +=
                        amountnew;
                      inventoryUI.post("inventory:events", {
                        eventname: "discordLog",
                        category: category,
                        fromFile: "js",
                        item: item,
                        amount: amountnew,
                        fromSlot: fromSlot,
                        toSlot: toSlot,
                        from: from,
                        to: to,
                        type: "reciveItem",
                      });
                      inventoryUI.refreshData();
                    } else {
                      // no same item
                      let tempItem = Object.assign(
                        {},
                        inventoryUI.otherItems[fromSlot - 1]
                      );

                      inventoryUI.playerItems[to][toSlot - 1] = tempItem;
                      inventoryUI.otherItems[fromSlot - 1].amount -= amountnew;
                      if (inventoryUI.otherItems[fromSlot - 1].amount == 0) {
                        inventoryUI.otherItems[fromSlot - 1] = null;
                      }
                      inventoryUI.playerItems[to][toSlot - 1].amount =
                        amountnew;
                      inventoryUI.post("inventory:events", {
                        eventname: "discordLog",
                        category: category,
                        fromFile: "js",
                        item: item,
                        amount: amountnew,
                        fromSlot: fromSlot,
                        toSlot: toSlot,
                        from: from,
                        to: to,
                        type: "reciveItem",
                      });
                      inventoryUI.refreshData();
                      setTimeout(() => {
                        const newImg = $(
                          `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                        );
                        inventoryUI.addDraggable(newImg);
                      }, 100);
                    }
                    return 0;
                  } else {
                    // move just one item
                    var itemD = inventoryUI.getItemPosition(
                      inventoryUI.otherItems[fromSlot - 1].item,
                      "player"
                    );
                    if (itemD != null) {
                      // check if item is already in player inventory

                      var newTo = itemD[1],
                        newSlot = itemD[0];
                      var itemAmount =
                        inventoryUI.otherItems[fromSlot - 1].amount *
                        inventoryUI.otherItems[fromSlot - 1].weight;
                      if (
                        inventoryUI.playerWeight + itemAmount >
                        inventoryUI.playerMaxWeight
                      )
                        return inventoryUI.notifyError(
                          InventoryConfig.lang.notify.no_inventory_space
                        );
                      inventoryUI.playerItems[newTo][newSlot].amount +=
                        inventoryUI.otherItems[fromSlot - 1].amount;
                      inventoryUI.otherItems[fromSlot - 1] = null;
                      inventoryUI.post("inventory:events", {
                        eventname: "discordLog",
                        category: category,
                        fromFile: "js",
                        item: item,
                        amount: 1,
                        fromSlot: fromSlot,
                        toSlot: toSlot,
                        from: from,
                        to: to,
                        type: "reciveItem",
                      });
                      inventoryUI.refreshData();
                      setTimeout(() => {
                        const newImg = $(
                          `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                        );
                        inventoryUI.addDraggable(newImg);
                      }, 100);
                      return 0;
                    } else {
                      var itemAmount =
                        inventoryUI.otherItems[fromSlot - 1].amount *
                        inventoryUI.otherItems[fromSlot - 1].weight;
                      if (
                        inventoryUI.playerWeight + itemAmount >
                        inventoryUI.playerMaxWeight
                      )
                        return inventoryUI.notifyError(
                          InventoryConfig.lang.notify.no_inventory_space
                        );
                      inventoryUI.playerItems[to][toSlot - 1] =
                        inventoryUI.otherItems[fromSlot - 1];
                      inventoryUI.playerItems[to][toSlot - 1].slot = toSlot;
                      inventoryUI.otherItems[fromSlot - 1] = null;
                      inventoryUI.post("inventory:events", {
                        eventname: "discordLog",
                        category: category,
                        fromFile: "js",
                        item: item,
                        amount: 1,
                        fromSlot: fromSlot,
                        toSlot: toSlot,
                        from: from,
                        to: to,
                        type: "reciveItem",
                      });
                      inventoryUI.refreshData();
                      setTimeout(() => {
                        const newImg = $(
                          `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                        );
                        inventoryUI.addDraggable(newImg);
                      }, 100);
                      return 0;
                    }
                  }
                }

                return 0;
              }

              // from player inventory to other inventory
              if (inventoryUI.playerItems[from]) {
                console.log("move from me");
                const item = inventoryUI.playerItems[from][fromSlot - 1].item;
                if (!item) return console.log("error no item");
                // check if toSlot is not free
                if (inventoryUI.otherItems[toSlot - 1]) {
                  console.log("to slot is not free");
                  if (inventoryUI.otherItems[toSlot - 1].item == item) {
                    // check same item
                    var am = inventoryUI.playerItems[from][fromSlot - 1].amount;
                    if (am > 1) {
                      const amount2 = await inventoryUI.buildPrompt(
                        inventoryUI.formatNotifyMessage(
                          InventoryConfig.lang.prompt.move_item,
                          [inventoryUI.playerItems[from][fromSlot - 1].name]
                        )
                      );
                      am = parseInt(amount2);
                      if (am && typeof am == "number") {
                        if (am > 0) {
                          am = Math.abs(Math.floor(am));
                        } else return 0;
                      } else return 0;
                    }
                    var itemsWeight =
                      am * inventoryUI.playerItems[from][fromSlot - 1].weight;
                    if (inventoryUI.playerItems[from][fromSlot - 1].amount < am)
                      return inventoryUI.notifyError(
                        InventoryConfig.lang.notify.no_minimum_items
                      );
                    if (
                      inventoryUI.otherWeight + itemsWeight >
                      inventoryUI.otherMaxWeight
                    )
                      return inventoryUI.notifyError(
                        InventoryConfig.lang.notify.no_inventory_space
                      );

                    inventoryUI.otherItems[toSlot - 1].amount += am;
                    inventoryUI.playerItems[from][fromSlot - 1].amount -= am;
                    if (
                      inventoryUI.playerItems[from][fromSlot - 1].amount == 0
                    ) {
                      inventoryUI.playerItems[from][fromSlot - 1] = null;
                    }
                    inventoryUI.post("inventory:events", {
                      eventname: "discordLog",
                      category: category,
                      fromFile: "js",
                      item: item,
                      amount: am,
                      fromSlot: fromSlot,
                      toSlot: toSlot,
                      from: from,
                      to: to,
                      type: "giveItem",
                    });
                    inventoryUI.refreshData();
                    return 0;
                  }

                  var amountnew =
                    inventoryUI.playerItems[from][fromSlot - 1].amount;
                  if (inventoryUI.playerItems[from][fromSlot - 1].amount > 1) {
                    // check item amount for prompt
                    const amount2 = await inventoryUI.buildPrompt(
                      inventoryUI.formatNotifyMessage(
                        InventoryConfig.lang.prompt.move_item,
                        [inventoryUI.playerItems[from][fromSlot - 1].name]
                      )
                    );
                    amountnew = parseInt(amount2);
                    if (amountnew && typeof amountnew == "number") {
                      if (amountnew > 0) {
                        amountnew = Math.abs(Math.floor(amountnew));
                      } else return 0;
                    } else return 0;
                  }

                  var itemsWeight =
                    amountnew *
                    inventoryUI.playerItems[from][fromSlot - 1].weight;
                  if (
                    inventoryUI.playerItems[from][fromSlot - 1].amount <
                    amountnew
                  )
                    return inventoryUI.notifyError(
                      InventoryConfig.lang.notify.no_minimum_items
                    );
                  console.log(
                    "inventoryUI.otherWeight + itemsWeight",
                    inventoryUI.otherWeight + itemsWeight
                  );
                  console.log("maxwww", inventoryUI.otherMaxWeight);
                  if (
                    inventoryUI.otherWeight + itemsWeight >
                    inventoryUI.otherMaxWeight
                  )
                    return inventoryUI.notifyError(
                      InventoryConfig.lang.notify.no_inventory_space
                    );

                  // all
                  var itemD = inventoryUI.getItemPosition(
                    inventoryUI.playerItems[from][fromSlot - 1].item,
                    "other"
                  );
                  if (itemD != null) {
                    // check if item is already in player inventory

                    var newTo = itemD[1],
                      newSlot = itemD[0];

                    inventoryUI.otherItems[newSlot].amount += amountnew;
                    inventoryUI.playerItems[from][fromSlot - 1].amount -=
                      amountnew;
                    if (
                      inventoryUI.playerItems[from][fromSlot - 1].amount == 0
                    ) {
                      inventoryUI.playerItems[from][fromSlot - 1] = null;
                    }
                    inventoryUI.post("inventory:events", {
                      eventname: "discordLog",
                      category: category,
                      fromFile: "js",
                      item: item,
                      amount: amountnew,
                      fromSlot: fromSlot,
                      toSlot: toSlot,
                      from: from,
                      to: to,
                      type: "giveItem",
                    });
                    inventoryUI.refreshData();
                  } else {
                    return inventoryUI.notifyError(
                      InventoryConfig.lang.notify.slot_not_free
                    );
                  }
                  return 0;
                }
                // check if toSlot is free
                if (!inventoryUI.otherItems[toSlot - 1]) {
                  // move more than one item
                  if (inventoryUI.playerItems[from][fromSlot - 1].amount > 1) {
                    const amount2 = await inventoryUI.buildPrompt(
                      inventoryUI.formatNotifyMessage(
                        InventoryConfig.lang.prompt.move_item,
                        [inventoryUI.playerItems[from][fromSlot - 1].name]
                      )
                    );
                    var amountnew = parseInt(amount2);
                    if (amountnew && typeof amountnew == "number") {
                      if (amountnew > 0) {
                        amountnew = Math.abs(Math.floor(amountnew));
                      } else return 0;
                    } else return 0;

                    var itemsWeight =
                      amountnew *
                      inventoryUI.playerItems[from][fromSlot - 1].weight;
                    if (
                      inventoryUI.playerItems[from][fromSlot - 1].amount <
                      amountnew
                    ) {
                      return inventoryUI.notifyError(
                        InventoryConfig.lang.notify.no_minimum_items
                      );
                    }
                    console.log(
                      "inventoryUI.otherWeight + itemsWeight",
                      inventoryUI.otherWeight + itemsWeight
                    );
                    console.log(
                      "inventoryUI.otherMaxWeight-->",
                      inventoryUI.otherMaxWeight
                    );
                    if (
                      inventoryUI.otherWeight + itemsWeight >
                      inventoryUI.otherMaxWeight
                    )
                      return inventoryUI.notifyError(
                        InventoryConfig.lang.notify.no_inventory_space
                      );
                    var itemD = inventoryUI.getItemPosition(
                      inventoryUI.playerItems[from][fromSlot - 1].item,
                      "other"
                    );
                    if (itemD != null) {
                      // check if item is already in player inventory

                      var newTo = itemD[1],
                        newSlot = itemD[0];
                      // is already item
                      inventoryUI.playerItems[from][fromSlot - 1].amount -=
                        amountnew;
                      if (
                        inventoryUI.playerItems[from][fromSlot - 1].amount == 0
                      ) {
                        inventoryUI.playerItems[from][fromSlot - 1] = null;
                      }
                      inventoryUI.otherItems[newSlot].amount += amountnew;
                      inventoryUI.post("inventory:events", {
                        eventname: "discordLog",
                        category: category,
                        fromFile: "js",
                        item: item,
                        amount: amountnew,
                        fromSlot: fromSlot,
                        toSlot: toSlot,
                        from: from,
                        to: to,
                        type: "giveItem",
                      });
                      inventoryUI.refreshData();
                    } else {
                      // no same item
                      let tempItem = Object.assign(
                        {},
                        inventoryUI.playerItems[from][fromSlot - 1]
                      );

                      inventoryUI.otherItems[toSlot - 1] = tempItem;
                      inventoryUI.playerItems[from][fromSlot - 1].amount -=
                        amountnew;
                      if (
                        inventoryUI.playerItems[from][fromSlot - 1].amount == 0
                      ) {
                        inventoryUI.playerItems[from][fromSlot - 1] = null;
                      }
                      inventoryUI.otherItems[toSlot - 1].amount = amountnew;
                      inventoryUI.post("inventory:events", {
                        eventname: "discordLog",
                        category: category,
                        fromFile: "js",
                        item: item,
                        amount: amountnew,
                        fromSlot: fromSlot,
                        toSlot: toSlot,
                        from: from,
                        to: to,
                        type: "giveItem",
                      });
                      inventoryUI.refreshData();
                      setTimeout(() => {
                        const newImg = $(
                          `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                        );
                        inventoryUI.addDraggable(newImg);
                      }, 100);
                    }
                    return 0;
                  } else {
                    // move just one item
                    var itemD = inventoryUI.getItemPosition(
                      inventoryUI.playerItems[from][fromSlot - 1].item,
                      "other"
                    );
                    if (itemD != null) {
                      // check if item is already in player inventory

                      var newTo = itemD[1],
                        newSlot = itemD[0];
                      var itemsWeight =
                        am * inventoryUI.playerItems[from][fromSlot - 1].weight;
                      if (
                        inventoryUI.otherWeight + itemsWeight >
                        inventoryUI.otherMaxWeight
                      )
                        return inventoryUI.notifyError(
                          InventoryConfig.lang.notify.no_inventory_space
                        );
                      inventoryUI.otherItems[newSlot].amount +=
                        inventoryUI.playerItems[from][fromSlot - 1].amount;
                      inventoryUI.playerItems[from][fromSlot - 1] = null;
                      inventoryUI.post("inventory:events", {
                        eventname: "discordLog",
                        category: category,
                        fromFile: "js",
                        item: item,
                        amount: 1,
                        fromSlot: fromSlot,
                        toSlot: toSlot,
                        from: from,
                        to: to,
                        type: "giveItem",
                      });
                      inventoryUI.refreshData();
                      setTimeout(() => {
                        const newImg = $(
                          `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                        );
                        inventoryUI.addDraggable(newImg);
                      }, 100);
                      return 0;
                    } else {
                      var itemsWeight =
                        am * inventoryUI.playerItems[from][fromSlot - 1].weight;
                      if (
                        inventoryUI.otherWeight + itemsWeight >
                        inventoryUI.otherMaxWeight
                      )
                        return inventoryUI.notifyError(
                          InventoryConfig.lang.notify.no_inventory_space
                        );
                      inventoryUI.otherItems[toSlot - 1] =
                        inventoryUI.playerItems[from][fromSlot - 1];
                      inventoryUI.otherItems[toSlot - 1].slot = toSlot;
                      inventoryUI.playerItems[from][fromSlot - 1] = null;
                      inventoryUI.post("inventory:events", {
                        eventname: "discordLog",
                        category: category,
                        fromFile: "js",
                        item: item,
                        amount: 1,
                        fromSlot: fromSlot,
                        toSlot: toSlot,
                        from: from,
                        to: to,
                        type: "giveItem",
                      });
                      inventoryUI.refreshData();
                      setTimeout(() => {
                        const newImg = $(
                          `.item[data-inventory="${to}"][data-slot="${toSlot}"]>img`
                        );
                        inventoryUI.addDraggable(newImg);
                      }, 100);
                      return 0;
                    }
                  }
                }

                return 0;
              }
            }
          },
        });

        $(".item>img").draggable({
          helper: "clone",
          containment: "window",
          scroll: false,
        });
      }, 100);
    },

    buildDescItem(category, slot, itemElement) {
      if (
        !(
          category == "pocket" ||
          category == "backpack" ||
          category == "fastSlots"
        )
      )
        return 0;
      if (category == "backpack" && !this.playerItems.clothes) return 0;
      if (category && slot) {
        var itemData;
        if (category == this.otherInventory) {
          itemData = inventoryUI.otherItems[slot - 1];
        } else {
          itemData = inventoryUI.playerItems[category][slot - 1];
        }
        if (itemData) {
          this.itemDesc = {
            show: true,
            item: itemData.item,
            name: itemData.name,
            amount: itemData.amount,
            weight: itemData.weight,
            description: itemData.description,
            element: itemElement,
            slot: slot,
            category: category,
          };
          const elementPoz = $(itemElement).offset();
          $(itemElement).find("img").css({ "pointer-events": "none" });
          $(".inventory>div").css({ "pointer-events": "none" });
          $(".inventory>.itemDesc").css({ "pointer-events": "auto" });
          $(itemElement).css({ "pointer-events": "auto" });
          if (category == "pocket" || category == "backpack") {
            if (slot % 7 == 0) {
              if (slot < 22) {
                $(".inventory>.itemDesc").css(
                  "top",
                  elementPoz.top + 100 + "px"
                );
                $(".inventory>.itemDesc").css(
                  "left",
                  elementPoz.left - 100 + "px"
                );
              } else {
                $(".inventory>.itemDesc").css(
                  "top",
                  elementPoz.top - 250 + "px"
                );
                $(".inventory>.itemDesc").css(
                  "left",
                  elementPoz.left - 250 + "px"
                );
              }
            } else {
              if (slot < 22) {
                $(".inventory>.itemDesc").css(
                  "top",
                  elementPoz.top + 100 + "px"
                );
                $(".inventory>.itemDesc").css(
                  "left",
                  elementPoz.left - 150 + "px"
                );
              } else {
                $(".inventory>.itemDesc").css(
                  "top",
                  elementPoz.top - 250 + "px"
                );
                $(".inventory>.itemDesc").css(
                  "left",
                  elementPoz.left - 250 + "px"
                );
              }
            }
          } else if (category == "fastSlots") {
            $(".inventory>.itemDesc").css("left", elementPoz.left + 140 + "px");
            if (slot < 5) {
              $(".inventory>.itemDesc").css("top", elementPoz.top + 10 + "px");
            } else {
              $(".inventory>.itemDesc").css("top", elementPoz.top - 150 + "px");
            }
          }

          $(".inventory>.itemDesc").fadeIn();
        }
      }
    },

    destroyDescItem() {
      if (this.itemDesc.show) {
        $(this.itemDesc.element).find("img").css({ "pointer-events": "auto" });
        this.itemDesc = {
          show: false,
        };
        $(".inventory>div").css({
          filter: "blur(0px)",
          "pointer-events": "auto",
        });
        $(".inventory>.itemDesc").fadeOut();
      }
    },

    async useItem() {
      if (
        !(
          this.itemDesc.category == "pocket" ||
          this.itemDesc.category == "backpack" ||
          this.itemDesc.category == "fastSlots"
        )
      )
        return 0;
      if (this.itemDesc.show) {
        const used = await inventoryUI.post("inventory:events", {
          eventname: "useItem",
          item: this.itemDesc.item,
          slot: this.itemDesc.slot,
          category: this.itemDesc.category,
          userID: this.playerId,
          callback: true,
        });
        if (used) {
          this.destroy();
        }
      }
    },

    async giveItem() {
      if (
        !(
          this.itemDesc.category == "pocket" ||
          this.itemDesc.category == "backpack" ||
          this.itemDesc.category == "fastSlots"
        )
      )
        return 0;
      if (this.itemDesc.show) {
        const amount2 = await this.buildPrompt(
          InventoryConfig.lang.prompt.give_item
        );
        var amount = parseInt(amount2);
        if (amount && typeof amount == "number") {
          if (amount > 0) {
            amount = Math.abs(Math.floor(amount));
          } else return 0;
        } else return 0;
        if (!(typeof amount == "number")) return 0;
        if (amount < 1) return 0;
        const given = await inventoryUI.post("inventory:events", {
          eventname: "giveItem",
          amount: amount,
          item: this.itemDesc.item,
          slot: this.itemDesc.slot,
          category: this.itemDesc.category,
          userID: this.playerId,
          callback: true,
        });
        if (given) {
          this.destroy();
        }
      }
    },

    async destroyItem() {
      if (
        !(
          this.itemDesc.category == "pocket" ||
          this.itemDesc.category == "backpack" ||
          this.itemDesc.category == "fastSlots"
        )
      )
        return 0;
      if (this.itemDesc.show) {
        if (!this.playerItems[this.itemDesc.category][this.itemDesc.slot - 1])
          return 0;
        const amount2 = await this.buildPrompt(
          InventoryConfig.lang.prompt.trash_item
        );
        var amount = parseInt(amount2);
        if (amount && typeof amount == "number") {
          if (amount > 0) {
            amount = Math.abs(Math.floor(amount));
          } else return 0;
        } else return 0;
        if (!(typeof amount == "number")) return 0;
        if (amount < 1) return 0;
        const destroyed = await inventoryUI.post("inventory:events", {
          eventname: "destroyItem",
          item: this.itemDesc.item,
          amount: amount,
          slot: this.itemDesc.slot,
          category: this.itemDesc.category,
          userID: this.playerId,
          callback: true,
        });
        if (destroyed) {
          this.playerItems[this.itemDesc.category][
            this.itemDesc.slot - 1
          ].amount -= amount;
          if (
            this.playerItems[this.itemDesc.category][this.itemDesc.slot - 1]
              .amount < 1
          ) {
            this.playerItems[this.itemDesc.category][this.itemDesc.slot - 1] =
              null;
          }
          this.destroy();
        }
        this.refreshData();
      }
    },

    toogleClothes(command) {
      if (command) {
        inventoryUI.post("inventory:events", {
          eventname: "toogleClothes",
          command: command,
        });
      }
    },
    // prompt
    buildPrompt(message) {
      if (!this.prompt.show) {
        $(".inventory>.prompt").html("");
        const promptTemplate = `
          <p>${message}</p>
          <input class="inputPrompt" type="number">
          <div class="options">
            <div class="submit">SUMBIT</div>
            <div class="cancel">CANCEL</div>
          </div>`;
        $(".inventory>.prompt").append(promptTemplate);
        $(".inventory>div").css({
          filter: "blur(4px)",
          "pointer-events": "none",
        });
        $(".inventory>.prompt").css({
          filter: "blur(0px)",
          "pointer-events": "auto",
        });
        $(".inputPrompt").val("");

        this.prompt.show = true;
        return new Promise((resolve, reject) => {
          $(".inventory>.prompt>.options>.cancel").mousedown(async function (
            data
          ) {
            resolve(null);
            inventoryUI.destroyPrompt();
          });

          $(".inventory>.prompt>.options>.submit").mousedown(async function (
            data
          ) {
            var value = $(".inputPrompt").val();
            resolve(value);
            inventoryUI.destroyPrompt();
          });
        });
      }
    },

    destroyPrompt() {
      if (this.prompt.show) {
        this.prompt.show = false;
        $(".inventory>div").css({
          filter: "blur(0px)",
          "pointer-events": "auto",
        });
        $(".inventory>.prompt").fadeOut();
      }
    },

    async checkPlayer(playerData) {
      if (this.tryCheckPlayer) return 0;
      if (playerData) {
        this.tryCheckPlayer = true;
        const check = await inventoryUI.post("inventory:events", {
          eventname: "tryCheckPlayer",
          targetId: playerData.user_id,
          userID: this.playerId,
          callback: true,
        });
        if (check) {
          const playerDataa = {
            user_id: check.user_id,
          };
          setTimeout(() => {
            inventoryUI.post("inventory:events", {
              eventname: "checkPlayer",
              playerData: playerDataa,
              userID: this.playerId,
              callback: true,
            });
          }, 200);

          // this.nearPlayers = null;
          // this.otherInventory = 'otherPlayer',
          // this.otherPlayer = check;
        }
        this.tryCheckPlayer = false;
      }
    },

    calculateOtherWeight() {
      var weight = 0.0;
      if (!this.otherItems) return weight;
      for (let i = 0; i <= this.otherItems.length; i++) {
        if (this.otherItems[i]) {
          weight += this.otherItems[i].weight * this.otherItems[i].amount;
        }
      }
      return Number(weight.toFixed(2));
    },

    isBackpackFree() {
      if (this.playerItems.backpack) {
        for (let i = 0; i < this.playerItems.backpack.length; i++) {
          if (this.playerItems.backpack[i] != null) {
            if (this.playerItems.backpack[i] != false) {
              return false;
            }
          }
        }
      }
      return true;
    },

    calculatePlayerWeight() {
      var weight = 0;
      if (this.playerItems.clothes != null) {
        if (this.playerItems.backpack) {
          for (let i = 0; i <= this.playerItems.backpack.length; i++) {
            if (this.playerItems.backpack[i]) {
              weight +=
                this.playerItems.backpack[i].weight *
                this.playerItems.backpack[i].amount;
            }
          }
        }
      }

      if (this.playerItems.pocket) {
        for (let i = 0; i <= this.playerItems.pocket.length; i++) {
          if (this.playerItems.pocket[i]) {
            weight +=
              this.playerItems.pocket[i].weight *
              this.playerItems.pocket[i].amount;
          }
        }
      }
      if (this.playerItems.fastSlots) {
        for (let i = 0; i <= this.playerItems.fastSlots.length; i++) {
          if (this.playerItems.fastSlots[i]) {
            weight +=
              this.playerItems.fastSlots[i].weight *
              this.playerItems.fastSlots[i].amount;
          }
        }
      }
      return Number(weight.toFixed(2) || 0);
    },

    getItemPosition(item, category) {
      if (item && category) {
        if (category == "player") {
          for (let i = 0; i <= inventoryUI.playerItems.fastSlots.length; i++) {
            if (inventoryUI.playerItems.fastSlots[i]) {
              if (inventoryUI.playerItems.fastSlots[i].item == item) {
                return [i, "fastSlots"];
              }
            }
          }
          for (let i = 0; i <= inventoryUI.playerItems.pocket.length; i++) {
            if (inventoryUI.playerItems.pocket[i]) {
              if (inventoryUI.playerItems.pocket[i].item == item) {
                return [i, "pocket"];
              }
            }
          }
          if (this.playerItems.clothes != null) {
            for (let i = 0; i <= inventoryUI.playerItems.backpack.length; i++) {
              if (inventoryUI.playerItems.backpack[i]) {
                if (inventoryUI.playerItems.backpack[i].item == item) {
                  return [i, "backpack"];
                }
              }
            }
          }
        }

        if (category == "other-player") {
          for (let i = 0; i <= inventoryUI.otherPlayer.fastSlots.length; i++) {
            if (inventoryUI.otherPlayer.fastSlots[i]) {
              if (inventoryUI.otherPlayer.fastSlots[i].item == item) {
                return [i, "fastSlots"];
              }
            }
          }
          for (let i = 0; i <= inventoryUI.otherPlayer.pocket.length; i++) {
            if (inventoryUI.otherPlayer.pocket[i]) {
              if (inventoryUI.otherPlayer.pocket[i].item == item) {
                return [i, "pocket"];
              }
            }
          }
          if (this.otherPlayer.clothes != null) {
            for (let i = 0; i <= inventoryUI.otherPlayer.backpack.length; i++) {
              if (inventoryUI.otherPlayer.backpack[i]) {
                if (inventoryUI.otherPlayer.backpack[i].item == item) {
                  return [i, "backpack"];
                }
              }
            }
          }
        }

        if (category == "other") {
          for (let i = 0; i <= inventoryUI.otherItems.length; i++) {
            if (inventoryUI.otherItems[i]) {
              if (inventoryUI.otherItems[i].item == item) {
                return [i, this.otherInventory];
              }
            }
          }
        }
      }
    },

    formatNotifyMessage(message, data) {
      let formattedMessage = message;
      data.forEach(function (item) {
        formattedMessage = formattedMessage.replace("%s", item);
      });
      return formattedMessage;
    },

    async refreshData() {
      inventoryUI.refreshed = true;
      inventoryUI.refreshed = false;
      inventoryUI.playerWeight = inventoryUI.calculatePlayerWeight();
      if (this.otherItems)
        inventoryUI.otherWeight = inventoryUI.calculateOtherWeight();
      const saved = await inventoryUI.post("inventory:events", {
        eventname: "refreshInventory",
        playerItems: this.playerItems,
        otherItems: this.otherItems,
        category: this.otherInventory,
        userID: this.playerId,
        extraData: this.extraData,
        otherPlayer: this.otherPlayer,
        callback: true,
      });
      if (!saved) {
        this.destroy();
      }
    },
  },
});
