// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import '../json/inventory_item.dart';

class InventoryItemChangePageItem {
  final InventoryItem itemDetails;
  final InventoryItem? outputDetails;
  final List<InventoryItem> outputTableDetails;

  InventoryItemChangePageItem({
    required this.itemDetails,
    required this.outputDetails,
    required this.outputTableDetails,
  });

  factory InventoryItemChangePageItem.initial() => InventoryItemChangePageItem(
        itemDetails: InventoryItem.fromJson('{}'),
        outputDetails: InventoryItem.fromJson('{}'),
        outputTableDetails: List.empty(),
      );
}
