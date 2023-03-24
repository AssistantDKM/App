import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../../contracts/data/game_update.dart';

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
}
