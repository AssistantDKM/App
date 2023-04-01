// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import 'enum/item_change_type.dart';
import 'item_change_output.dart';

class ItemChange {
  final ItemChangeType type;
  final String toolAppId;
  final String inputAppId;
  final int amountNeeded;
  final int secondsToComplete;
  final int daysToComplete;
  final int cycles;
  final String outputAppId;
  final List<InventoryItemChangeOutput> outputTable;

  ItemChange({
    required this.type,
    required this.toolAppId,
    required this.inputAppId,
    required this.amountNeeded,
    required this.secondsToComplete,
    required this.daysToComplete,
    required this.cycles,
    required this.outputAppId,
    required this.outputTable,
  });

  factory ItemChange.fromJson(String str) =>
      ItemChange.fromMap(json.decode(str));

  factory ItemChange.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return ItemChange(
        type: ItemChangeType.unknown,
        toolAppId: '',
        inputAppId: '',
        amountNeeded: 0,
        secondsToComplete: 0,
        daysToComplete: 0,
        cycles: 0,
        outputAppId: '',
        outputTable: List.empty(),
      );
    }

    return ItemChange(
      type: itemChangeTypeValues.map[readStringSafe(json, 'Type').toString()] ??
          ItemChangeType.unknown,
      toolAppId: readStringSafe(json, 'ToolAppId'),
      inputAppId: readStringSafe(json, 'InputAppId'),
      amountNeeded: readIntSafe(json, 'AmountNeeded'),
      secondsToComplete: readIntSafe(json, 'SecondsToComplete'),
      daysToComplete: readIntSafe(json, 'DaysToComplete'),
      cycles: readIntSafe(json, 'Cycles'),
      outputAppId: readStringSafe(json, 'OutputAppId'),
      outputTable: readListSafe(
        json,
        'OutputTable',
        (x) => InventoryItemChangeOutput.fromMap(x),
      ),
    );
  }
}
