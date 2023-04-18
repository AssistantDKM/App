import '../interface/item_base_presenter.dart';
import '../json/inventory_item.dart';

class CartItemPageItem extends ItemBasePresenter {
  InventoryItem item;
  int quantity;

  CartItemPageItem({
    required this.item,
    required this.quantity,
  }) : super(item.appId, item.name, item.icon);
}
