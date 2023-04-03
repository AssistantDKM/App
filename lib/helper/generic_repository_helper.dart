import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../constants/app_json.dart';
import '../contracts/json/inventory_item.dart';
import '../integration/dependency_injection.dart';
import '../services/json/inventory_repository.dart';

InventoryRepository? getGenericRepoFromAppId(String appId) {
  List<String> comboId = appId.split('_');

  if (appJsonFromAppIdMap.containsKey(comboId.first)) {
    return getInventoryRepo(appJsonFromAppIdMap[comboId.first]!);
  }

  getLog().e('Could not get repository for ${comboId.first}');
  return null;
}

Future<ResultWithValue<InventoryItem>> getItemFromGenericRepoUsingAppId<T>(
  BuildContext itemCtx,
  String appId,
) {
  InventoryRepository? genRepo = getGenericRepoFromAppId(appId);
  if (genRepo == null) {
    return Future.value(
      ResultWithValue<InventoryItem>(false, InventoryItem.fromJson('{}'), ''),
    );
  }

  return genRepo.getItem(itemCtx, appId);
}

Future<List<InventoryItem>> getAllGameItems(
  BuildContext itemCtx,
) async {
  List<Future<ResultWithValue<List<InventoryItem>>>> repoFutures =
      List.empty(growable: true);
  for (var jsonKey in appJsonFromAppIdMap.values) {
    var repo = getInventoryRepo(jsonKey);
    repoFutures.add(repo.getItems(itemCtx));
  }

  List<ResultWithValue<List<InventoryItem>>> repoResult =
      await Future.wait(repoFutures);

  return repoResult
      .where((allItemsResult) => allItemsResult.isSuccess)
      .expand((allItemsResult) => allItemsResult.value)
      .toList();
}
