import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/inventory_item.dart';
import '../../helper/generic_repository_helper.dart';
import '../../helper/navigate_helper.dart';

Widget foodPreferenceTilePresenter(
  BuildContext context, {
  required String appId,
  required String subtitle,
  required String trailing,
  required bool isPatron,
  void Function()? onTap,
}) {
  return CachedFutureBuilder(
    future: getItemFromGenericRepoUsingAppId(context, appId),
    whileLoading: () => getLoading().smallLoadingTile(context),
    whenDoneLoading: (ResultWithValue<InventoryItem> result) {
      return foodPreferenceBodyTilePresenter(
        context,
        result,
        subtitle,
        trailing,
        isPatron,
        onTap,
      );
    },
  );
}

Widget foodPreferenceBodyTilePresenter(
  BuildContext foodCtx,
  ResultWithValue<InventoryItem> invResult,
  String subtitleText,
  String trailingImgPath,
  bool isPatron,
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
  return genericListTileWithSubtitle(
    foodCtx,
    leadingImage: item.icon,
    name: item.name,
    subtitle: Text(subtitleText),
    trailing: LocalImage(
      imagePath: trailingImgPath,
      width: 32,
      height: 32,
      padding: const EdgeInsets.only(right: 8),
    ),
    onTap: onTap ??
        () => navigateToInventory(
              context: foodCtx,
              item: item,
              isPatron: isPatron,
            ),
  );
}
