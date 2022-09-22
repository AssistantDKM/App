import 'package:flutter/material.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../contracts/json/animal_item.dart';

class AnimalRepository extends BaseJsonService {
  String appJson;

  AnimalRepository(this.appJson);

  Future<ResultWithValue<List<AnimalItem>>> getAnimalItems(
    BuildContext context,
  ) async {
    try {
      List responseJson = await getListfromJson(
        context,
        appJson,
      );
      List<AnimalItem> dataItems = responseJson
          .map((m) => AnimalItem.fromMap(m)) //
          .toList();
      dataItems.sort(((a, b) => a.name.compareTo(b.name)));
      return ResultWithValue<List<AnimalItem>>(true, dataItems, '');
    } catch (exception) {
      getLog().e('AnimalRepository getAnimalItems Exception: $exception');
      return ResultWithValue<List<AnimalItem>>(
        false,
        List.empty(),
        exception.toString(),
      );
    }
  }

  Future<ResultWithValue<AnimalItem>> getAnimalItem(
    BuildContext context,
    String itemId,
  ) async {
    ResultWithValue<List<AnimalItem>> allItemsResult =
        await getAnimalItems(context);

    if (allItemsResult.hasFailed) {
      return ResultWithValue(
          false, AnimalItem.fromJson('{}'), allItemsResult.errorMessage);
    }
    try {
      int itemIdInt = int.parse(itemId);
      List<AnimalItem> validItems = allItemsResult.value
          .where(
            (r) => r.id == itemIdInt,
          )
          .toList();
      if (validItems.isEmpty) {
        throw Exception('Animal not found');
      }
      return ResultWithValue<AnimalItem>(true, validItems[0], '');
    } catch (exception) {
      getLog().e('AnimalRepository getAnimalItem Exception: $exception');
      return ResultWithValue<AnimalItem>(
          false, AnimalItem.fromJson('{}'), exception.toString());
    }
  }
}
