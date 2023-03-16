import 'package:assistant_dinkum_app/contracts/interface/item_base_presenter.dart';

import '../json/inventory_item.dart';
import '../json/licence_item.dart';

class LicenceItemPageItem extends ItemBasePresenter {
  LicenceItem item;
  List<InventoryItem> learnedFromLicencePerLevel;

  LicenceItemPageItem({
    required this.item,
    required this.learnedFromLicencePerLevel,
  }) : super(item.appId, item.name, item.icon);
}
