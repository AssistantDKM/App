// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class InventoryItemCraftableRequired {
  final String appId;
  final int quantity;

  InventoryItemCraftableRequired({
    required this.appId,
    required this.quantity,
  });

  factory InventoryItemCraftableRequired.fromJson(String str) =>
      InventoryItemCraftableRequired.fromMap(json.decode(str));

  factory InventoryItemCraftableRequired.fromMap(Map<String, dynamic> json) =>
      InventoryItemCraftableRequired(
        appId: readStringSafe(json, 'AppId'),
        quantity: readIntSafe(json, 'Quantity'),
      );
}
