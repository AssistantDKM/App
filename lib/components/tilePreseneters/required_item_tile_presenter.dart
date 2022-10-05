import 'package:assistant_dinkum_app/components/common/cached_future_builder.dart';
import 'package:assistant_dinkum_app/pages/inventory_pages.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/inventory_item.dart';
import '../../contracts/json/inventory_item_craftable_required.dart';
import '../../helper/generic_repository_helper.dart';

Widget requiredItemTilePresenter(
  BuildContext context,
  InventoryItemCraftableRequired item, {
  void Function()? onTap,
}) {
  return CachedFutureBuilder(
    future: getGenericRepoFromAppId(item.appId).getItem(
      context,
      item.appId,
    ),
    whileLoading: getLoading().smallLoadingTile(context),
    whenDoneLoading: (ResultWithValue<InventoryItem> result) =>
        requiredItemBodyTilePresenter(context, result, item.quantity, onTap),
  );
}

Widget requiredItemBodyTilePresenter(
  BuildContext context,
  ResultWithValue<InventoryItem> invResult,
  int quantity,
  void Function()? onTap,
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
    leadingImage: item.icon,
    name: item.name,
    quantity: quantity,
    onTap: onTap ??
        () => getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateTo: (ctx) => InventoryDetailsPage(
                item.appId,
                title: item.name,
              ),
            ),
  );
}
