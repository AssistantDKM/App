import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../contracts/json/licence_item.dart';
import '../../helper/text_helper.dart';
import '../pageElements/item_page_components.dart';
import 'item_base_tile_presenter.dart';

Widget licenceLevelTilePresenter(
  BuildContext context, {
  required LicenceItem loadedItem,
  required int index,
}) {
  int currentLevel = index;
  int firstCalc = (currentLevel + 1) * loadedItem.levelCost;
  int multiplier = currentLevel * loadedItem.levelCostMuliplier;
  int levelCost = firstCalc * (multiplier == 0 ? 1 : multiplier);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(levelCost.toString()),
            const LocalImage(
              imagePath: AppImage.permitPoint,
              width: 24,
              height: 24,
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            pageDefaultPadding(
              Text(
                loadedItem.descriptions[index],
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ],
    ),
  );
}

Widget Function(
  BuildContext,
  LicenceItem,
  int, {
  void Function()? onTap,
}) licenceTilePresenter({
  required bool isPatron,
}) {
  //addSpaceBeforeCapital
  return (
    BuildContext localCtx,
    LicenceItem licence,
    int index, {
    void Function()? onTap,
  }) =>
      itemBasePlainTilePresenter(
        leading: genericTileImage(licence.icon),
        title: addSpaceBeforeCapital(licence.name),
        onTap: onTap,
      );
}
