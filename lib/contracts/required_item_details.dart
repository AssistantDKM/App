import 'json/inventory_item.dart';
import 'required_item.dart';

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

  @override
  String toString() {
    return "${quantity}x $name";
  }
}
