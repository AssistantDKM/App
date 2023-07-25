import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../contracts/json/enum/item_change_type.dart';
import '../../contracts/json/inventory_item.dart';
import '../../contracts/json/item_change_output.dart';
import '../../contracts/pageItem/item_change_page_item.dart';
import '../../helper/navigate_helper.dart';
import '../pageElements/item_page_components.dart';
import 'item_base_tile_presenter.dart';

const double itemChangeHeight = 48;
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
  ItemChangeType.modeller,
];

Widget itemChangeUsingTilePresenter({
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
          subtitle: getSubtitleStr(details),
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
      List<Widget> percWidgets = List.empty(growable: true);
      for (var outputIndex = 0;
          outputIndex < details.outputTableDetails.length;
          outputIndex++) {
        percWidgets.add(
          renderOutputTableTile(
            ctx,
            inputDetails: details.toolDetails,
            outputTableDetail: details.outputTableDetails[outputIndex],
            outputTable: details.outputTable[outputIndex],
            amountNeeded: details.amountNeeded,
            isInDetailPane: isInDetailPane,
            isPatron: isInDetailPane,
            isGatcha: isPatron,
            updateDetailView: updateDetailView,
          ),
        );

        // var currItem = details.outputTableDetails[outputIndex];
        // var currTblItem = details.outputTable[outputIndex];
        // if (currItem.appId != currentAppId) continue;

        // percWidgets.add(
        //   FlatCard(
        //     child: itemBasePlainTilePresenter(
        //       leading: LocalImage(imagePath: details.toolDetails.icon),
        //       title: details.toolDetails.name,
        //       subtitle: getTranslations()
        //            .fromKey(LocaleKey.percentage)
        //            .replaceAll('{0}', currTblItem.percentageChance.toString()),
        //       trailing: LocalImage(imagePath: currItem.icon),
        //       onTap: () => navigateToInventoryOrUpdateView(
        //         context: ctx,
        //         item: currItem,
        //         isInDetailPane: isInDetailPane,
        //         updateDetailView: updateDetailView,
        //         isPatron: isPatron,
        //       ),
        //     ),
        //   ),
        // );
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: percWidgets,
      );
    }
  }

  return unknownTile;
}

Widget itemChangeFromTilePresenter({
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
          leading: LocalImage(imagePath: details.inputDetails.icon),
          title: details.inputDetails.name,
          subtitle: getSubtitleStr(details),
          trailing: LocalImage(imagePath: details.toolDetails.icon),
          onTap: (currentAppId != details.inputDetails.appId)
              ? () => navigateToInventoryOrUpdateView(
                    context: ctx,
                    item: details.inputDetails,
                    isInDetailPane: isInDetailPane,
                    updateDetailView: updateDetailView,
                    isPatron: isPatron,
                  )
              : null,
        ),
      );
    } else if (details.outputTableDetails.isNotEmpty) {
      String trailingStr = details.outputTableDetails.length.toString();
      InventoryItemChangeOutput? tableItem = details.outputTable
          .firstWhereOrNull((tblItem) => tblItem.appId == currentAppId);
      if (tableItem != null) {
        trailingStr = getTranslations()
            .fromKey(LocaleKey.percentage)
            .replaceAll('{0}', tableItem.percentageChance.toString());
      }

      return FlatCard(
        child: itemBasePlainTilePresenter(
          leading: LocalImage(imagePath: details.toolDetails.icon),
          title: details.toolDetails.name,
          subtitle: getTranslations()
              .fromKey(LocaleKey.seconds)
              .replaceAll('{0}', details.secondsToComplete.toString()),
          trailing: Text(trailingStr),
          onTap: () => navigateToInventoryOrUpdateView(
            context: ctx,
            item: details.toolDetails,
            isInDetailPane: isInDetailPane,
            updateDetailView: updateDetailView,
            isPatron: isPatron,
          ),
        ),
      );
    }
  }

  return unknownTile;
}

Widget itemChangeForToolTilePresenter({
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
      return renderOutputTile(
        ctx,
        inputDetails: details.inputDetails,
        outputTableDetail: details.outputDetails!,
        amountNeeded: details.amountNeeded,
        isInDetailPane: isInDetailPane,
        isPatron: isPatron,
        isGatcha: details.type == ItemChangeType.gachaMachine,
        updateDetailView: updateDetailView,
      );
    } else if (details.outputTableDetails.isNotEmpty) {
      List<Widget> percWidgets = List.empty(growable: true);
      for (var outputIndex = 0;
          outputIndex < details.outputTableDetails.length;
          outputIndex++) {
        percWidgets.add(
          renderOutputTableTile(
            ctx,
            inputDetails: details.inputDetails,
            outputTableDetail: details.outputTableDetails[outputIndex],
            outputTable: details.outputTable[outputIndex],
            amountNeeded: details.amountNeeded,
            isInDetailPane: isInDetailPane,
            isPatron: isPatron,
            isGatcha: details.type == ItemChangeType.gachaMachine,
            updateDetailView: updateDetailView,
          ),
        );
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: percWidgets,
      );
    }
  }

  return unknownTile;
}

Widget renderOutputTableTile(
  BuildContext ctx, {
  required InventoryItem inputDetails,
  required InventoryItem outputTableDetail,
  required InventoryItemChangeOutput outputTable,
  required int amountNeeded,
  required bool isInDetailPane,
  required bool isPatron,
  required bool isGatcha,
  required void Function(Widget)? updateDetailView,
  Widget? chevronWidget,
}) {
  return renderOutputTile(
    ctx,
    inputDetails: inputDetails,
    outputTableDetail: outputTableDetail,
    extraOutpuElem: Text(
      getTranslations()
          .fromKey(LocaleKey.percentage)
          .replaceAll('{0}', outputTable.percentageChance.toString()),
    ),
    amountNeeded: amountNeeded,
    isInDetailPane: isInDetailPane,
    isPatron: isPatron,
    isGatcha: isGatcha,
    updateDetailView: updateDetailView,
    chevronWidget: chevronWidget,
  );
}

Widget renderOutputTile(
  BuildContext ctx, {
  required InventoryItem inputDetails,
  required InventoryItem outputTableDetail,
  required int amountNeeded,
  Widget? extraOutpuElem,
  required bool isInDetailPane,
  required bool isPatron,
  required bool isGatcha,
  required void Function(Widget)? updateDetailView,
  Widget? chevronWidget,
}) {
  leftOnTap() => navigateToInventoryOrUpdateView(
        context: ctx,
        item: inputDetails,
        isInDetailPane: isInDetailPane,
        updateDetailView: updateDetailView,
        isPatron: isPatron,
      );
  rightOnTap() => navigateToInventoryOrUpdateView(
        context: ctx,
        item: outputTableDetail,
        isInDetailPane: isInDetailPane,
        updateDetailView: updateDetailView,
        isPatron: isPatron,
      );

  List<Widget> leftWidgets = List.empty(growable: true);
  if (inputDetails.id == 299) {
    leftWidgets = [
      const EmptySpace1x(),
      ConstrainedBox(
        constraints: const BoxConstraints(minHeight: itemChangeHeight),
        child: dinkumPriceInner(
          ctx,
          amount: amountNeeded,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      ),
      const EmptySpace1x(),
    ];
  } else {
    leftWidgets = [
      const EmptySpace1x(),
      LocalImage(
        imagePath: inputDetails.icon,
        height: itemChangeHeight,
      ),
      const EmptySpace1x(),
      Flexible(
        fit: FlexFit.tight,
        child: Text(
          inputDetails.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    ];
  }

  return FlatCard(
    child: Row(
      children: [
        Flexible(
          flex: isGatcha ? 2 : 3,
          fit: FlexFit.tight,
          child: InkWell(
            onTap: leftOnTap,
            child: Row(children: leftWidgets),
          ),
        ),
        chevronWidget ?? const Icon(Icons.chevron_right_rounded),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: InkWell(
            onTap: rightOnTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const EmptySpace1x(),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    outputTableDetail.name,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                LocalImage(
                  imagePath: outputTableDetail.icon,
                  height: itemChangeHeight,
                ),
                if (extraOutpuElem != null) ...[
                  extraOutpuElem,
                ],
                const EmptySpace1x(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

String getSubtitleStr(ItemChangePageItem details) {
  String subtitleStr = getTranslations()
      .fromKey(LocaleKey.seconds)
      .replaceAll('{0}', details.secondsToComplete.toString());
  if (details.daysToComplete >= 1) {
    subtitleStr = getTranslations()
        .fromKey(LocaleKey.days)
        .replaceAll('{0}', details.daysToComplete.toString());
  }
  return subtitleStr;
}
