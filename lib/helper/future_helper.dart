import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../contracts/json/inventory_item.dart';
import '../contracts/json/item_change.dart';
import '../contracts/pageItem/item_change_page_item.dart';
import '../integration/dependency_injection.dart';

Future<ResultWithValue<List<InventoryItem>>> getCombinedItems(
  BuildContext funcCtx,
  List<LocaleKey> appJsons,
) async {
  List<InventoryItem> result = List.empty(growable: true);

  for (LocaleKey appJson in appJsons) {
    ResultWithValue<List<InventoryItem>> genericRepoResult =
        await getInventoryRepo(appJson).getItems(funcCtx);
    if (genericRepoResult.isSuccess) {
      result.addAll(genericRepoResult.value);
    }
  }

  result.sort(((a, b) => a.name.compareTo(b.name)));

  return ResultWithValue(result.isNotEmpty, result, '');
}

ResultWithValue<List<ItemChangePageItem>> getItemChangesPageData(
  List<ItemChange>? itemChanges,
  List<InventoryItem> allItems,
) {
  if (itemChanges == null) {
    return ResultWithValue<List<ItemChangePageItem>>(
      false,
      List.empty(),
      '',
    );
  }

  List<ItemChangePageItem> itemChangePageDatas = List.empty(growable: true);
  for (ItemChange itemChange in itemChanges) {
    var changeItem = getItemChangePageData(itemChange, allItems);
    if (changeItem != null) {
      itemChangePageDatas.add(changeItem);
    }
  }

  return ResultWithValue<List<ItemChangePageItem>>(
    itemChangePageDatas.isNotEmpty,
    itemChangePageDatas,
    '',
  );
}

ItemChangePageItem? getItemChangePageData(
  ItemChange itemChange,
  List<InventoryItem> allItems,
) {
  InventoryItem? toolDetails =
      allItems.firstWhereOrNull((item) => item.appId == itemChange.toolAppId);
  InventoryItem? inputDetails =
      allItems.firstWhereOrNull((item) => item.appId == itemChange.inputAppId);
  InventoryItem? outputDetails =
      allItems.firstWhereOrNull((item) => item.appId == itemChange.outputAppId);
  List<InventoryItem> outputTableResults = allItems
      .where((item) =>
          itemChange.outputTable.any((outT) => outT.appId == item.appId))
      .toList();

  if (toolDetails == null ||
      inputDetails == null ||
      outputDetails == null ||
      outputTableResults.isNotEmpty) {
    return null;
  }

  return ItemChangePageItem(
    type: itemChange.type,
    toolAppId: toolDetails.appId,
    toolDetails: toolDetails,
    inputAppId: inputDetails.appId,
    inputDetails: inputDetails,
    amountNeeded: itemChange.amountNeeded,
    secondsToComplete: itemChange.secondsToComplete,
    daysToComplete: itemChange.daysToComplete,
    cycles: itemChange.cycles,
    outputAppId: outputDetails.appId,
    outputDetails: outputDetails,
    outputTable: itemChange.outputTable,
    outputTableDetails: outputTableResults,
  );
}
