import '../json/enum/item_change_type.dart';
import '../json/inventory_item.dart';
import '../json/inventory_item_change.dart';
import '../json/inventory_item_change_output.dart';

class InventoryItemChangePageItem extends InventoryItemChange {
  final InventoryItem itemDetails;
  final InventoryItem? outputDetails;
  final List<InventoryItem> outputTableDetails;

  InventoryItemChangePageItem({
    required ItemChangeType type,
    required InventoryItemChangeOutput item,
    required int amountNeeded,
    required int secondsToComplete,
    required int daysToComplete,
    required int cycles,
    required InventoryItemChangeOutput output,
    required List<InventoryItemChangeOutput> outputTable,
    required this.itemDetails,
    required this.outputDetails,
    required this.outputTableDetails,
  }) : super(
          type: type,
          item: item,
          amountNeeded: amountNeeded,
          secondsToComplete: secondsToComplete,
          daysToComplete: daysToComplete,
          cycles: cycles,
          output: output,
          outputTable: outputTable,
        );
}
