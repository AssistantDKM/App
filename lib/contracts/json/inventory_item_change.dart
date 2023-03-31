// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import 'enum/item_change_type.dart';
import 'inventory_item_change_output.dart';

class InventoryItemChange {
  final ItemChangeType type;
  final InventoryItemChangeOutput item;
  final int amountNeeded;
  final int secondsToComplete;
  final int daysToComplete;
  final int cycles;
  final InventoryItemChangeOutput output;
  final List<InventoryItemChangeOutput> outputTable;

  InventoryItemChange({
    required this.type,
    required this.item,
    required this.amountNeeded,
    required this.secondsToComplete,
    required this.daysToComplete,
    required this.cycles,
    required this.output,
    required this.outputTable,
  });

  factory InventoryItemChange.fromJson(String str) =>
      InventoryItemChange.fromMap(json.decode(str));

  factory InventoryItemChange.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return InventoryItemChange(
        type: ItemChangeType.unknown,
        item: InventoryItemChangeOutput(
          id: 0,
          appId: '',
          percentageChance: null,
        ),
        amountNeeded: 0,
        secondsToComplete: 0,
        daysToComplete: 0,
        cycles: 0,
        output: InventoryItemChangeOutput(
          id: 0,
          appId: '',
          percentageChance: null,
        ),
        outputTable: List.empty(),
      );
    }

    return InventoryItemChange(
      type: itemChangeTypeValues.map[readStringSafe(json, 'Type').toString()] ??
          ItemChangeType.unknown,
      item: InventoryItemChangeOutput.fromMap(json['Item']),
      amountNeeded: readIntSafe(json, 'AmountNeeded'),
      secondsToComplete: readIntSafe(json, 'SecondsToComplete'),
      daysToComplete: readIntSafe(json, 'DaysToComplete'),
      cycles: readIntSafe(json, 'Cycles'),
      output: InventoryItemChangeOutput.fromMap(json['Output']),
      outputTable: readListSafe(
        json,
        'OutputTable',
        (x) => InventoryItemChangeOutput.fromMap(x),
      ),
    );
  }
}
