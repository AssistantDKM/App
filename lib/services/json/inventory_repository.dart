import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/inventory_item.dart';
import 'base_game_item_repository.dart';

class InventoryRepository extends BaseGameItemRepository<InventoryItem> {
  InventoryRepository(LocaleKey appJson)
      : super(
          appJson: appJson,
          repoName: 'InventoryRepository',
          fromMap: InventoryItem.fromMap,
          compare: (a, b) => a.name.compareTo(b.name),
          findItemById: (r, appId) => r.appId == appId,
        );

  static bool getUsagesOfItemFilter(InventoryItem iItem, String appId) {
    // ignore: unnecessary_null_comparison
    if (iItem.craftable == null) return false;
    // ignore: unnecessary_null_comparison
    if (iItem.craftable.requiredItems == null) return false;
    if (iItem.craftable.requiredItems.isEmpty) return false;
    if (iItem.craftable.requiredItems
            .any((reqItem) => reqItem.appId == appId) //
        ) return true;
    return false;
  }

  Future<ResultWithValue<List<InventoryItem>>> getUsagesOfItem(
    BuildContext context,
    String itemId,
  ) {
    return protectedGetUsagesOfItem(
      context,
      itemId,
      filter: (InventoryItem iItem) => getUsagesOfItemFilter(iItem, itemId),
    );
  }
}
