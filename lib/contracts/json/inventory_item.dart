// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../interface/item_base_presenter.dart';
import 'inventory_item_consumable.dart';
import 'inventory_item_craftable.dart';
import 'enum/equipable_type.dart';
import 'inventory_item_creature.dart';

class InventoryItem extends ItemBasePresenter {
  final int id;
  final bool hidden;
  final String description;
  final int sellPrice;
  final EquipableType equipable;
  final InventoryItemCraftable craftable;
  final InventoryItemConsumable consumable;
  final int requiredLicenceLevel;
  final InventoryItemCreature? creatureDetails;

  InventoryItem({
    required this.id,
    required this.hidden,
    required String appId,
    required String name,
    required String icon,
    required this.description,
    required this.sellPrice,
    required this.equipable,
    required this.craftable,
    required this.consumable,
    required this.requiredLicenceLevel,
    required this.creatureDetails,
  }) : super(appId, name, icon);

  factory InventoryItem.fromJson(String str) =>
      InventoryItem.fromMap(json.decode(str));

  factory InventoryItem.fromMap(Map<String, dynamic> json) => InventoryItem(
        id: readIntSafe(json, 'Id'),
        icon: readStringSafe(json, 'Icon'),
        appId: readStringSafe(json, 'AppId'),
        hidden: readBoolSafe(json, 'Hidden'),
        name: readStringSafe(json, 'Name'),
        description: readStringSafe(json, 'Description'),
        sellPrice: readIntSafe(json, 'SellPrice'),
        equipable: equipableTypeValues
                .map[readIntSafe(json, 'Equipable').toString()] ??
            EquipableType.notEquipable,
        craftable: InventoryItemCraftable.fromMap(json['Craftable']),
        consumable: InventoryItemConsumable.fromMap(json['Consumable']),
        requiredLicenceLevel: readIntSafe(json, 'RequiredLicenceLevel'),
        creatureDetails: InventoryItemCreature.fromMap(json['CreatureDetails']),
      );
}
