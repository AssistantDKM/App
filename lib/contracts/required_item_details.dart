import 'json/inventory_item.dart';
import 'required_item.dart';
import 'required_item_tree_details.dart';

class RequiredItemDetails extends RequiredItem {
  String icon;
  String name;
  bool isHidden;

  RequiredItemDetails({
    required String appId,
    required this.icon,
    required this.name,
    required this.isHidden,
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
      isHidden: invItem.hidden,
      quantity: quantity,
    );
  }

  factory RequiredItemDetails.toRequiredItemDetails(
      RequiredItemTreeDetails reqTree) {
    return RequiredItemDetails(
      appId: reqTree.appId,
      icon: reqTree.icon,
      name: reqTree.name,
      isHidden: false,
      quantity: reqTree.quantity,
    );
  }

  factory RequiredItemDetails.initial() => RequiredItemDetails(
        appId: '',
        icon: '',
        name: '',
        isHidden: true,
        quantity: 0,
      );

  @override
  String toString() {
    return "${quantity}x $name";
  }
}
