import 'package:assistantapps_flutter_common/contracts/results/result_with_value.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/inventory_item.dart';
import 'base_game_item_repository.dart';

class InventoryRepository extends BaseGameItemRepository<InventoryItem> {
  InventoryRepository(appJson)
      : super(
          appJson: appJson,
          repoName: 'InventoryRepository',
          fromMap: InventoryItem.fromMap,
          compare: (a, b) => a.name.compareTo(b.name),
          findItemById: (r, appId) => r.appId == appId,
        );

  Future<ResultWithValue<List<InventoryItem>>> getUsagesOfItem(
    BuildContext context,
    String itemId,
  ) {
    return protectedGetUsagesOfItem(context, itemId,
        filter: (InventoryItem iItem) {
      // ignore: unnecessary_null_comparison
      if (iItem.craftable == null) return false;
      // ignore: unnecessary_null_comparison
      if (iItem.craftable.requiredItems == null) return false;
      if (iItem.craftable.requiredItems.isEmpty) return false;
      if (iItem.craftable.requiredItems
              .any((reqItem) => reqItem.appId == itemId) //
          ) return true;
      return false;
    });
  }
}
