import 'json/inventory_item.dart';
import 'required_item.dart';
import 'required_item_tree_details.dart';

class RequiredItemDetails extends RequiredItem {
  String icon;
  String name;

  RequiredItemDetails({
    required String appId,
    required this.icon,
    required this.name,
    int quantity = 0,
  }) : super(appId: appId, quantity: quantity);

  factory RequiredItemDetails.fromInventoryItem(
    InventoryItem invItem,
    int quantity,
  ) {
    return RequiredItemDetails(
      appId: invItem.appId,
      icon: invItem.icon,
      name: invItem.name,
      quantity: quantity,
    );
  }

  factory RequiredItemDetails.toRequiredItemDetails(
      RequiredItemTreeDetails reqTree) {
    return RequiredItemDetails(
      appId: reqTree.appId,
      icon: reqTree.icon,
      name: reqTree.name,
      quantity: reqTree.quantity,
    );
  }

  factory RequiredItemDetails.initial() => RequiredItemDetails(
        appId: '',
        icon: '',
        name: '',
        quantity: 0,
      );

  @override
  String toString() {
    return "${quantity}x $name";
  }
}
