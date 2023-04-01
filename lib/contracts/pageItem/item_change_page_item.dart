import '../json/enum/item_change_type.dart';
import '../json/inventory_item.dart';
import '../json/item_change.dart';
import '../json/item_change_output.dart';

class ItemChangePageItem extends ItemChange {
  final InventoryItem toolDetails;
  final InventoryItem inputDetails;
  final InventoryItem? outputDetails;
  final List<InventoryItem> outputTableDetails;

  ItemChangePageItem({
    required ItemChangeType type,
    required String toolAppId,
    required String inputAppId,
    required int amountNeeded,
    required int secondsToComplete,
    required int daysToComplete,
    required int cycles,
    required String outputAppId,
    required List<InventoryItemChangeOutput> outputTable,
    required this.toolDetails,
    required this.inputDetails,
    required this.outputDetails,
    required this.outputTableDetails,
  }) : super(
          type: type,
          toolAppId: toolAppId,
          inputAppId: inputAppId,
          amountNeeded: amountNeeded,
          secondsToComplete: secondsToComplete,
          daysToComplete: daysToComplete,
          cycles: cycles,
          outputAppId: outputAppId,
          outputTable: outputTable,
        );
}
