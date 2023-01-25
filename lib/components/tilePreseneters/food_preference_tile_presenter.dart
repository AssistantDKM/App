import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/inventory_item.dart';
import '../../helper/generic_repository_helper.dart';
import '../../pages/inventory_pages.dart';

Widget foodPreferenceTilePresenter(
  BuildContext context, {
  required String appId,
  required String subtitle,
  required String trailing,
  void Function()? onTap,
}) {
  return CachedFutureBuilder(
    future: getGenericRepoFromAppId(appId).getItem(context, appId),
    whileLoading: () => getLoading().smallLoadingTile(context),
    whenDoneLoading: (ResultWithValue<InventoryItem> result) {
      return requiredItemBodyTilePresenter(
        context,
        result,
        subtitle,
        trailing,
        onTap,
      );
    },
  );
}

Widget requiredItemBodyTilePresenter(
  BuildContext context,
  ResultWithValue<InventoryItem> invResult,
  String subtitleText,
  String trailingImgPath,
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
    context,
    leadingImage: item.icon,
    name: item.name,
    subtitle: Text(subtitleText),
    trailing: localImage(
      trailingImgPath,
      width: 32,
      height: 32,
      padding: const EdgeInsets.only(right: 8),
    ),
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
