import 'package:assistant_dinkum_app/contracts/required_item_details.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/inventory_item.dart';
import '../../helper/generic_repository_helper.dart';
import '../../pages/inventory_pages.dart';

Widget requiredItemTilePresenter(
  BuildContext context, {
  required String appId,
  required int quantity,
  void Function()? onTap,
}) {
  return CachedFutureBuilder(
    future: getItemFromGenericRepoUsingAppId(
      context,
      appId,
    ),
    whileLoading: () => getLoading().smallLoadingTile(context),
    whenDoneLoading: (ResultWithValue<InventoryItem> result) {
      return requiredItemBodyTilePresenter(
        context,
        invResult: result,
        quantity: quantity,
        onTap: onTap,
      );
    },
  );
}

Widget requiredItemBodyTilePresenter(
  BuildContext context, {
  required ResultWithValue<InventoryItem> invResult,
  required int quantity,
  required void Function()? onTap,
}) {
  if (invResult.hasFailed) {
    return ListTile(
      leading: const Icon(Icons.question_mark),
      title: Text(getTranslations().fromKey(LocaleKey.unknown)),
      subtitle: const Text('???'),
    );
  }

  return requiredItemDetailsBodyTilePresenter(
    context,
    details: RequiredItemDetails.fromInventoryItem(invResult.value, quantity),
    onTap: onTap,
  );
}

Widget requiredItemDetailsBodyTilePresenter(
  BuildContext context, {
  required RequiredItemDetails details,
  void Function()? onTap,
}) {
  return genericListTile(
    context,
    leadingImage: details.icon,
    name: details.name,
    quantity: details.quantity,
    onTap: onTap ??
        () => getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateTo: (ctx) => InventoryDetailsPage(
                details.appId,
                title: details.name,
              ),
            ),
  );
}
