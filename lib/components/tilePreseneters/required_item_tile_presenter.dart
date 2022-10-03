import 'package:assistant_dinkum_app/components/common/cached_future_builder.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/inventory_item.dart';
import '../../contracts/json/inventory_item_craftable_required.dart';
import '../../helper/generic_repository_helper.dart';

Widget requiredItemTilePresenter(
    BuildContext context, InventoryItemCraftableRequired item, int index) {
  return CachedFutureBuilder(
    future: getGenericRepoFromAppId(item.appId).getItem(
      context,
      item.appId,
    ),
    whileLoading: getLoading().smallLoadingTile(context),
    whenDoneLoading: (ResultWithValue<InventoryItem> result) =>
        requiredItemBodyTilePresenter(context, result, item.quantity),
  );
}

Widget requiredItemBodyTilePresenter(
  BuildContext context,
  ResultWithValue<InventoryItem> invResult,
  int quantity,
) {
  if (invResult.hasFailed) {
    return ListTile(
      leading: const Icon(Icons.question_mark),
      title: Text(getTranslations().fromKey(LocaleKey.unknown)),
      subtitle: const Text('???'),
    );
  }

  InventoryItem item = invResult.value;
  return genericListTile(
    context,
    leadingImage: 'inventory/${item.icon}',
    name: item.name,
    quantity: quantity,
  );
}
