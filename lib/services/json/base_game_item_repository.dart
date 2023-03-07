import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

class BaseGameItemRepository<T> extends BaseJsonService {
  LocaleKey appJson;
  String repoName;
  T Function(Map<String, dynamic> jsonMap) fromMap;
  int Function(T, T) compare;
  bool Function(T, String) findItemById;

  BaseGameItemRepository({
    required this.appJson,
    required this.repoName,
    required this.fromMap,
    required this.compare,
    required this.findItemById,
  });

  Future<ResultWithValue<List<T>>> getItems(BuildContext context) async {
    try {
      List responseJson = await getListfromJson(
        context,
        getTranslations().fromKey(appJson),
      );
      List<T> dataItems = responseJson
          .map((m) => fromMap(m)) //
          .toList();
      dataItems.sort(compare);
      return ResultWithValue<List<T>>(true, dataItems, '');
    } catch (exception) {
      getLog().e('$repoName getItems Exception: $exception');
      return ResultWithValue<List<T>>(
        false,
        List.empty(),
        exception.toString(),
      );
    }
  }

  Future<ResultWithValue<T>> getItem(
    BuildContext context,
    String itemId,
  ) async {
    ResultWithValue<List<T>> allItemsResult = await getItems(context);

    if (allItemsResult.hasFailed) {
      return ResultWithValue(
          false, fromMap(<String, dynamic>{}), allItemsResult.errorMessage);
    }
    try {
      List<T> validItems = allItemsResult.value
          .where(
            (r) => findItemById(r, itemId),
          )
          .toList();
      if (validItems.isEmpty) {
        throw Exception('item not found');
      }
      return ResultWithValue<T>(true, validItems[0], '');
    } catch (exception) {
      getLog().e('$repoName getItem Exception: $exception');
      return ResultWithValue<T>(
          false, fromMap(<String, dynamic>{}), exception.toString());
    }
  }

  Future<ResultWithValue<List<T>>> protectedGetUsagesOfItem(
    BuildContext context,
    String itemId, {
    required bool Function(T) filter,
  }) async {
    ResultWithValue<List<T>> allItemsResult = await getItems(context);
    if (allItemsResult.isSuccess == false) return allItemsResult;

    try {
      List<T> allItems = allItemsResult.value
          .where((item) => filter(item)) //
          .toList();
      allItems.sort(compare);
      return ResultWithValue<List<T>>(true, allItems, '');
    } catch (exception) {
      getLog().e('$repoName getItems Exception: $exception');
      return ResultWithValue<List<T>>(
        false,
        List.empty(),
        exception.toString(),
      );
    }
  }
}
