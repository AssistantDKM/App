import 'package:assistant_dinkum_app/helper/navigate_helper.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../contracts/json/enum/item_change_type.dart';
import '../../contracts/pageItem/item_change_page_item.dart';
import 'item_base_tile_presenter.dart';

const itemsThatNeedAnItemFromLoadedItems = [
  ItemChangeType.chargingStation,
  ItemChangeType.compostBin,
  ItemChangeType.campFire,
  ItemChangeType.bbq,
  ItemChangeType.stoneGrinder,
  ItemChangeType.tableSaw,
  ItemChangeType.gachaMachine,
  ItemChangeType.furnace,
  ItemChangeType.crudeFurnace,
  ItemChangeType.keg,
  ItemChangeType.spinningWheel,
  ItemChangeType.cheeseMaker,
  ItemChangeType.mill,
// ItemChangeType.batStatue,
  ItemChangeType.billyCanFire,
  ItemChangeType.blastFurnace,
  ItemChangeType.improvedTableSaw,
];

Widget itemChangeTilePresenter({
  required BuildContext ctx,
  required String currentAppId,
  required ItemChangePageItem details,
  required bool isInDetailPane,
  void Function(Widget newDetailView)? updateDetailView,
  required bool isPatron,
}) {
  ListTile unknownTile = itemBasePlainTilePresenter(
    leading: const LocalImage(imagePath: AppImage.unknown),
    title: getTranslations().fromKey(LocaleKey.unknown),
    subtitle: getTranslations().fromKey(LocaleKey.unknown),
  );

  if (itemsThatNeedAnItemFromLoadedItems.contains(details.type)) {
    if (details.outputDetails != null) {
      return FlatCard(
        child: itemBasePlainTilePresenter(
          leading: LocalImage(imagePath: details.toolDetails.icon),
          title: details.toolDetails.name,
          subtitle: getTranslations()
              .fromKey(LocaleKey.seconds)
              .replaceAll('{0}', details.secondsToComplete.toString()),
          trailing: (currentAppId != details.outputDetails!.appId)
              ? LocalImage(imagePath: details.outputDetails!.icon)
              : null,
          onTap: (currentAppId != details.outputDetails!.appId)
              ? () => navigateToInventoryOrUpdateView(
                    context: ctx,
                    item: details.outputDetails!,
                    isInDetailPane: isInDetailPane,
                    updateDetailView: updateDetailView,
                    isPatron: isPatron,
                  )
              : null,
        ),
      );
    } else if (details.outputTableDetails.isNotEmpty) {
      return FlatCard(
        child: itemBasePlainTilePresenter(
          leading: LocalImage(imagePath: details.toolDetails.icon),
          title: details.toolDetails.name,
          subtitle: getTranslations()
              .fromKey(LocaleKey.seconds)
              .replaceAll('{0}', details.secondsToComplete.toString()),
          trailing: Text(details.outputTableDetails.length.toString()),
        ),
      );
    }
  }

  return unknownTile;
}
