import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class InventoryItemChangeOutput {
  final String appId;
  final double? percentageChance;

  InventoryItemChangeOutput({
    required this.appId,
    required this.percentageChance,
  });

  factory InventoryItemChangeOutput.fromJson(String str) =>
      InventoryItemChangeOutput.fromMap(json.decode(str));

  factory InventoryItemChangeOutput.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return InventoryItemChangeOutput(
        appId: '',
        percentageChance: null,
      );
    }
    return InventoryItemChangeOutput(
      appId: readStringSafe(json, 'AppId'),
      percentageChance: readDoubleSafe(json, 'PercentageChance'),
    );
  }
}
