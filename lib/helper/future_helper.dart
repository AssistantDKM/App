import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../contracts/json/inventory_item.dart';
import '../contracts/json/inventory_item_change.dart';
import '../contracts/pageItem/inventory_item_change_page_item.dart';
import '../integration/dependency_injection.dart';
import 'generic_repository_helper.dart';

Future<ResultWithValue<List<InventoryItem>>> getCombinedItems(
    BuildContext funcCtx, List<LocaleKey> appJsons) async {
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

Future<ResultWithValue<List<InventoryItemChangePageItem>>>
    getItemChangePageData(
  BuildContext funcCtx,
  List<InventoryItemChange>? itemChanges,
) async {
  if (itemChanges == null) {
    return ResultWithValue<List<InventoryItemChangePageItem>>(
      false,
      List.empty(),
      '',
    );
  }

  List<InventoryItemChangePageItem> itemChangePageDatas =
      List.empty(growable: true);
  for (var itemChange in itemChanges) {
    var itemDetailsFuture = getItemFromGenericRepoUsingAppId(
      funcCtx,
      itemChange.item.appId,
    );
    var outputDetailsFuture = getItemFromGenericRepoUsingAppId(
      funcCtx,
      itemChange.output.appId,
    );

    List<Future<ResultWithValue<InventoryItem>>> outputTableFutures =
        List.empty(growable: true);
    for (var outputTableRow in itemChange.outputTable) {
      outputTableFutures.add(getItemFromGenericRepoUsingAppId(
        funcCtx,
        outputTableRow.appId,
      ));
    }

    var itemDetailsResult = await itemDetailsFuture;
    var outputDetailsResult = await outputDetailsFuture;
    var outputTableResults = await Future.wait(outputTableFutures);

    itemChangePageDatas.add(InventoryItemChangePageItem(
      type: itemChange.type,
      item: itemChange.item,
      amountNeeded: itemChange.amountNeeded,
      secondsToComplete: itemChange.secondsToComplete,
      daysToComplete: itemChange.daysToComplete,
      cycles: itemChange.cycles,
      output: itemChange.output,
      outputTable: itemChange.outputTable,
      itemDetails: itemDetailsResult.value,
      outputDetails: outputDetailsResult.isSuccess //
          ? outputDetailsResult.value
          : null,
      outputTableDetails: outputTableResults.map((outT) => outT.value).toList(),
    ));
  }

  return ResultWithValue<List<InventoryItemChangePageItem>>(
    itemChangePageDatas.isNotEmpty,
    itemChangePageDatas,
    '',
  );
}
