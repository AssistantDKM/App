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
