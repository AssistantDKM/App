// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import 'enum/consumable_type.dart';
import 'inventory_item_consumable_buff.dart';

class InventoryItemConsumable {
  final ConsumableType type;
  final List<InventoryItemConsumableBuff> buffs;

  InventoryItemConsumable({
    required this.type,
    required this.buffs,
  });

  factory InventoryItemConsumable.fromJson(String str) =>
      InventoryItemConsumable.fromMap(json.decode(str));

  factory InventoryItemConsumable.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return InventoryItemConsumable(
        type: ConsumableType.unknown,
        buffs: [],
      );
    }
    return InventoryItemConsumable(
      type: consumableTypeValues.map[readIntSafe(json, 'Type').toString()] ??
          ConsumableType.unknown,
      buffs: readListSafe(
        json,
        'Buffs',
        (x) => InventoryItemConsumableBuff.fromMap(x),
      ),
    );
  }
}
