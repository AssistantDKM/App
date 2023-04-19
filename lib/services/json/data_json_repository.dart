import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../../contracts/data/game_update.dart';
import '../../contracts/json/enum/usage_key.dart';
import '../../contracts/json/item_change.dart';

class DataJsonRepository extends BaseJsonService {
  //
  Future<ResultWithValue<List<GameUpdate>>> getGameUpdates(
    BuildContext context,
  ) async {
    try {
      dynamic responseJson =
          await getJsonFromAssets(context, "data/updates.json");
      List list = json.decode(responseJson);
      List<GameUpdate> trans = list //
          .map((e) => GameUpdate.fromMap(e))
          .toList();
      return ResultWithValue<List<GameUpdate>>(true, trans, '');
    } catch (exception) {
      getLog().e(
          "DataJsonRepository getGameUpdates Exception: ${exception.toString()}");
      return ResultWithValue<List<GameUpdate>>(
        false,
        List.empty(),
        exception.toString(),
      );
    }
  }

  Future<ResultWithValue<GameUpdate>> getLatestGameUpdate(
    BuildContext context,
  ) async {
    ResultWithValue<List<GameUpdate>> allItemsResult =
        await getGameUpdates(context);
    if (allItemsResult.hasFailed) {
      return ResultWithValue<GameUpdate>(
        false,
        GameUpdate.initial(),
        allItemsResult.errorMessage,
      );
    }

    try {
      if (allItemsResult.value.isEmpty) {
        return ResultWithValue<GameUpdate>(
          false,
          GameUpdate.initial(),
          'No update found',
        );
      }

      GameUpdate item = allItemsResult.value.first;

      return ResultWithValue<GameUpdate>(true, item, '');
    } catch (exception) {
      getLog().e(
          "DataJsonRepository getLatestMajorUpdate Exception: ${exception.toString()}");
      return ResultWithValue<GameUpdate>(
        false,
        GameUpdate.initial(),
        exception.toString(),
      );
    }
  }

  Future<ResultWithValue<GameUpdate>> getGameUpdateThatItemWasAddedIn(
    BuildContext context,
    String itemId,
  ) async {
    ResultWithValue<List<GameUpdate>> allItemsResult =
        await getGameUpdates(context);
    if (allItemsResult.hasFailed) {
      return ResultWithValue<GameUpdate>(
        false,
        GameUpdate.initial(),
        allItemsResult.errorMessage,
      );
    }

    try {
      List<GameUpdate> items = allItemsResult.value
          .where((all) => all.appIds.contains(itemId))
          .toList();

      if (items.isEmpty) {
        return ResultWithValue<GameUpdate>(
          false,
          GameUpdate.initial(),
          'No update found',
        );
      }

      return ResultWithValue<GameUpdate>(true, items.first, '');
    } catch (exception) {
      getLog().e(
          "DataJsonRepository getMajorUpdatesForItem Exception: ${exception.toString()}");
      return ResultWithValue<GameUpdate>(
        false,
        GameUpdate.initial(),
        exception.toString(),
      );
    }
  }

  Future<Map<String, List<UsageKey>>> loadLookupJson(
    BuildContext context,
  ) async {
    dynamic responseJson =
        await getJsonFromAssets(context, "data/usageLookup.json");
    Map<String, dynamic> data = json.decode(responseJson);

    Map<String, List<UsageKey>> result = <String, List<UsageKey>>{};
    for (var dataKey in data.keys) {
      result.putIfAbsent(dataKey, () {
        List<UsageKey> enumKeys = List.empty(growable: true);
        for (var listItem in data[dataKey]) {
          UsageKey? enumKey = usageKeyTypeValues.map[listItem];
          if (enumKey == null) continue;
          enumKeys.add(enumKey);
        }
        return enumKeys;
      });
    }
    return result;
  }

  Future<ResultWithValue<List<ItemChange>>> getItemChanges(
    BuildContext context,
  ) async {
    try {
      dynamic responseJson =
          await getJsonFromAssets(context, "data/itemChanges.json");
      List list = json.decode(responseJson);
      List<ItemChange> trans = list //
          .map((e) => ItemChange.fromMap(e))
          .toList();
      return ResultWithValue<List<ItemChange>>(true, trans, '');
    } catch (exception) {
      getLog().e(
          "DataJsonRepository getItemChanges Exception: ${exception.toString()}");
      return ResultWithValue<List<ItemChange>>(
        false,
        List.empty(),
        exception.toString(),
      );
    }
  }

  Future<ResultWithValue<List<ItemChange>>> getItemChangesUsing(
    BuildContext context,
    String appId,
  ) async {
    ResultWithValue<List<ItemChange>> allItemsResult =
        await getItemChanges(context);
    if (allItemsResult.hasFailed) {
      return ResultWithValue<List<ItemChange>>(
        false,
        List.empty(),
        allItemsResult.errorMessage,
      );
    }

    List<ItemChange> items = allItemsResult.value.where((all) {
      if (all.inputAppId == appId) return true;
      // if (all.outputTable.any((tblItem) => tblItem.appId == appId)) return true;
      return false;
    }).toList();

    return ResultWithValue<List<ItemChange>>(items.isNotEmpty, items, '');
  }

  Future<ResultWithValue<List<ItemChange>>> getItemChangesOutputting(
    BuildContext context,
    String appId,
  ) async {
    ResultWithValue<List<ItemChange>> allItemsResult =
        await getItemChanges(context);
    if (allItemsResult.hasFailed) {
      return ResultWithValue<List<ItemChange>>(
        false,
        List.empty(),
        allItemsResult.errorMessage,
      );
    }

    List<ItemChange> items = allItemsResult.value.where((all) {
      if (all.outputAppId == appId) return true;
      if (all.outputTable.any((tblItem) => tblItem.appId == appId)) return true;
      return false;
    }).toList();

    return ResultWithValue<List<ItemChange>>(items.isNotEmpty, items, '');
  }

  Future<ResultWithValue<List<ItemChange>>> getItemChangesForTool(
    BuildContext context,
    String appId,
  ) async {
    ResultWithValue<List<ItemChange>> allItemsResult =
        await getItemChanges(context);
    if (allItemsResult.hasFailed) {
      return ResultWithValue<List<ItemChange>>(
        false,
        List.empty(),
        allItemsResult.errorMessage,
      );
    }

    List<ItemChange> items =
        allItemsResult.value.where((all) => all.toolAppId == appId).toList();

    return ResultWithValue<List<ItemChange>>(items.isNotEmpty, items, '');
  }
}
