import 'package:assistant_dinkum_app/contracts/interface/item_base_presenter.dart';

import '../data/game_update.dart';
import '../json/inventory_item.dart';
import '../json/licence_item.dart';
import 'inventory_item_change_page_item.dart';

class InventoryPageItem extends ItemBasePresenter {
  InventoryItem item;
  List<InventoryItem> usages;
  List<InventoryItemChangePageItem>? itemChangeDetails;
  LicenceItem? requiredLicence;
  GameUpdate? fromUpdate;

  InventoryPageItem({
    required this.item,
    required this.usages,
    required this.itemChangeDetails,
    required this.requiredLicence,
    required this.fromUpdate,
  }) : super(item.appId, item.name, item.icon);
}
