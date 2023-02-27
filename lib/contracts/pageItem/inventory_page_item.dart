import 'package:assistant_dinkum_app/contracts/interface/item_base_presenter.dart';

import '../json/inventory_item.dart';

class InventoryPageItem extends ItemBasePresenter {
  InventoryItem item;
  List<InventoryItem> usages;

  InventoryPageItem({
    required this.item,
    required this.usages,
  }) : super(item.appId, item.name, item.icon);
}
