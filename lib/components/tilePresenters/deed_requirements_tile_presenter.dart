import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../contracts/json/inventory_item.dart';
import '../../helper/currency_helper.dart';
import '../../helper/generic_repository_helper.dart';
import '../../pages/inventory_pages.dart';

Widget deedRequirementsTilePresenter(
  BuildContext context,
  String deedId,
  int spendBeforeMoveIn,
  int relationshipBeforeMove, {
  void Function()? onTap,
}) {
  return CachedFutureBuilder(
    future: getGenericRepoFromAppId(deedId).getItem(
      context,
      deedId,
    ),
    whileLoading: () => getLoading().smallLoadingTile(context),
    whenDoneLoading: (ResultWithValue<InventoryItem> result) =>
        deedRequirementsBodyTilePresenter(
      context,
      result,
      spendBeforeMoveIn,
      relationshipBeforeMove,
      onTap,
    ),
  );
}

Widget deedRequirementsBodyTilePresenter(
  BuildContext deedCtx,
  ResultWithValue<InventoryItem> invResult,
  int spendBeforeMoveIn,
  int relationshipBeforeMove,
  void Function()? onTap,
) {
  if (invResult.hasFailed) {
    return ListTile(
      leading: const Icon(Icons.question_mark),
      title: Text(getTranslations().fromKey(LocaleKey.unknown)),
      subtitle: const Text('???'),
    );
  }

  Locale locale = Localizations.localeOf(deedCtx);

  return ListTile(
    leading: LocalImage(imagePath: invResult.value.icon),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const LocalImage(imagePath: AppImage.coin, width: 32, height: 32),
        const EmptySpace(0.25),
        Text(formatCurrency(locale, spendBeforeMoveIn)),
      ],
    ),
    subtitle: Wrap(
      children: [
        const SizedBox(width: 5, height: 1),
        ...List.generate(
          5,
          (index) => getHeartImage(
            relationshipBeforeMove - (index * 20),
          ),
        )
      ],
    ),
    onTap: onTap ??
        () => getNavigation().navigateAwayFromHomeAsync(
              deedCtx,
              navigateTo: (ctx) => InventoryDetailsPage(
                invResult.value.appId,
                title: invResult.value.name,
              ),
            ),
  );
}

Widget getHeartImage(int relationshipBeforeMove) {
  double heartImgSize = 18;
  int relationshipHeartPart = (relationshipBeforeMove / 5).round();
  String heartImg = AppImage.relationshipHeart0;
  switch (relationshipHeartPart) {
    case 0:
      heartImg = AppImage.relationshipHeart0;
      break;
    case 1:
      heartImg = AppImage.relationshipHeart1;
      break;
    case 2:
      heartImg = AppImage.relationshipHeart2;
      break;
    case 3:
      heartImg = AppImage.relationshipHeart3;
      break;
  }
  if (relationshipHeartPart >= 4) {
    heartImg = AppImage.relationshipHeart4;
  }
  return LocalImage(
      imagePath: heartImg, height: heartImgSize, width: heartImgSize);
}
