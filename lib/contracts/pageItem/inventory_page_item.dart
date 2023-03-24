import 'package:assistant_dinkum_app/contracts/interface/item_base_presenter.dart';

import '../data/game_update.dart';
import '../json/inventory_item.dart';
import '../json/licence_item.dart';

class InventoryPageItem extends ItemBasePresenter {
  InventoryItem item;
  List<InventoryItem> usages;
  LicenceItem? requiredLicence;
  GameUpdate? fromUpdate;

  InventoryPageItem({
    required this.item,
    required this.usages,
    required this.requiredLicence,
    required this.fromUpdate,
  }) : super(item.appId, item.name, item.icon);
}
