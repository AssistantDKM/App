// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import 'enum/consumable_buff_type.dart';

class InventoryItemConsumableBuff {
  final ConsumableBuffType type;
  final int level;
  final int seconds;

  InventoryItemConsumableBuff({
    required this.type,
    required this.level,
    required this.seconds,
  });

  factory InventoryItemConsumableBuff.fromJson(String str) =>
      InventoryItemConsumableBuff.fromMap(json.decode(str));

  factory InventoryItemConsumableBuff.fromMap(Map<String, dynamic> json) =>
      InventoryItemConsumableBuff(
        type: consumableBuffTypeValues
                .map[readIntSafe(json, 'Type').toString()] ??
            ConsumableBuffType.unknown,
        level: readIntSafe(json, 'Level'),
        seconds: readIntSafe(json, 'Seconds'),
      );
}
