// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class InventoryItemChangeOutput {
  final int id;
  final String appId;
  final double? percentageChance;

  InventoryItemChangeOutput({
    required this.id,
    required this.appId,
    required this.percentageChance,
  });

  factory InventoryItemChangeOutput.fromJson(String str) =>
      InventoryItemChangeOutput.fromMap(json.decode(str));

  factory InventoryItemChangeOutput.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return InventoryItemChangeOutput(
        id: 0,
        appId: '',
        percentageChance: null,
      );
    }
    return InventoryItemChangeOutput(
      id: readIntSafe(json, 'Id'),
      appId: readStringSafe(json, 'AppId'),
      percentageChance: readDoubleSafe(json, 'PercentageChance'),
    );
  }
}
