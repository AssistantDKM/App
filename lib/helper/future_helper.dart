import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../contracts/json/inventory_item.dart';
import '../integration/dependency_injection.dart';

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
