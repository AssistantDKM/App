import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/inventory_item.dart';
import '../../contracts/required_item_details.dart';
import '../../helper/generic_repository_helper.dart';
import '../../helper/navigate_helper.dart';

Widget requiredItemTilePresenter(
  BuildContext context, {
  required String appId,
  required int quantity,
  required bool isPatron,
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
        isPatron: isPatron,
        onTap: onTap,
      );
    },
  );
}

Widget requiredItemBodyTilePresenter(
  BuildContext context, {
  required ResultWithValue<InventoryItem> invResult,
  required int quantity,
  required bool isPatron,
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
    isPatron: isPatron,
    onTap: onTap,
  );
}

Widget requiredItemDetailsBodyTilePresenter(
  BuildContext context, {
  required RequiredItemDetails details,
  required bool isPatron,
  void Function()? onTap,
}) {
  return genericListTile(
    context,
    leadingImage: details.icon,
    name: details.name,
    quantity: details.quantity,
    onTap: onTap ??
        () => navigateToInventoryWithProps(
              context: context,
              appId: details.appId,
              name: details.name,
              obscure: (details.isHidden && isPatron == false),
            ),
  );
}
