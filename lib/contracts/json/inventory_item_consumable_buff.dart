// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class InventoryItemConsumableBuff {
  final int type;
  final int level;
  final int success;

  InventoryItemConsumableBuff({
    required this.type,
    required this.level,
    required this.success,
  });

  factory InventoryItemConsumableBuff.fromJson(String str) =>
      InventoryItemConsumableBuff.fromMap(json.decode(str));

  factory InventoryItemConsumableBuff.fromMap(Map<String, dynamic> json) =>
      InventoryItemConsumableBuff(
        type: readIntSafe(json, 'Type'),
        level: readIntSafe(json, 'Level'),
        success: readIntSafe(json, 'Success'),
      );
}
