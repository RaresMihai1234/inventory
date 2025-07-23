const InventoryConfig = {
  clothesTitle:
    "Alege imbracamintea de pe tine sau foloseste backpack-ul pentru mai multe sloturi si kilograme in plus",
  clothes: {
    column1: [
      // dont edit backpack.command
      { img: "cap.png", command: "hat", clothId: "hat" },
      { img: "shirt.png", command: "shirt", clothId: "shirt" },
      { img: "gloves.png", command: "gloves", clothId: "gloves" },
      { img: "watch.png", droppable: true, clothId: "watch" },
      { img: "pants.png", command: "pants", clothId: "pants" },
      { img: "shoes.png", command: "shoes", clothId: "shoes" },
    ],
    column2: [
      { img: "mask.png", command: "mask", clothId: "mask" },
      { img: "glasses.png", command: "glasses", clothId: "glasses" },
      { img: "backpack.png", command: "backpack", clothId: "backpack" },
      { img: "tshirt.png", command: "tshirt", clothId: "tshirt" },
      { img: "necklace.png", droppable: true, clothId: "necklace" },
      { img: "earings.png", command: "earings", clothId: "earings" },
    ],
  },
  backpacks: {
    ["rucsac"]: 10,
    ["rucsac2"]: 20,
    ["rucsac3"]: 30,
  },
  blocked_items: {
    ["WEAPON_PISTOL50"]: true,
    ["water"]: true,
  },
  lang: {
    texts: {
      check_player: "Check Player",
    },
    prompt: {
      move_item: "Scrie cate buc de %s doresti sa muti",
      give_item:
        "Scrie cate buc de item doresti sa oferi jucatorului de langa tine",
      trash_item: "Scrie cate buc de item doresti sa arunci pe jos",
    },
    notify: {
      no_backpack_item:
        "Itemul trebuie sa fie un tip de rucsac pentru a-l echipa",
      unequip_backpack_error:
        "Ghiozdanul se poate dezechipa doar fiind pus in buzunar (pocket)",
      free_the_backpack: "Goleste mai intai ghiozdanul",
      no_minimum_items: "Nu ai destule iteme pentru a le muta",
      no_inventory_space: "Nu ai destul loc in inventar",
      slot_not_free: "Asigura-te ca slotul este liber",
      item_is_not_jewellery: 'Itemul folosit nu este o bijuterie respectiva'
    },
  },
};
