import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../contracts/json/inventory_item.dart';
import '../contracts/required_item.dart';
import '../contracts/required_item_details.dart';
import '../services/json/inventory_repository.dart';
import 'generic_repository_helper.dart';

Future<List<RequiredItemDetails>> getAllRequiredItemsForMultiple(
    context, List<RequiredItem> requiredItems) async {
  List<RequiredItemDetails> rawMaterials = List.empty(growable: true);
  for (RequiredItem requiredItem in requiredItems) {
    List<RequiredItemDetails> tempItems =
        await getRequiredItems(context, requiredItem);
    for (int tempItemIndex = 0;
        tempItemIndex < tempItems.length;
        tempItemIndex++) {
      RequiredItemDetails tempItem = tempItems[tempItemIndex];
      // if (tempItem.id != requiredItem.id) {
      //   tempItem.quantity = tempItem.quantity * requiredItem.quantity;
      // }
      rawMaterials.add(tempItem);
    }
  }

  Map<String, RequiredItemDetails> rawMaterialMap = {};
  for (int rawMaterialIndex = 0;
      rawMaterialIndex < rawMaterials.length;
      rawMaterialIndex++) {
    RequiredItemDetails rawMaterialDetails = rawMaterials[rawMaterialIndex];
    if (rawMaterialMap.containsKey(rawMaterialDetails.appId)) {
      rawMaterialMap.update(
        rawMaterialDetails.appId,
        (orig) => RequiredItemDetails(
          appId: rawMaterialDetails.appId,
          icon: rawMaterialDetails.icon,
          name: rawMaterialDetails.name,
          quantity: orig.quantity + rawMaterialDetails.quantity,
        ),
      );
    } else {
      rawMaterialMap.putIfAbsent(
        rawMaterialDetails.appId,
        () => RequiredItemDetails(
          appId: rawMaterialDetails.appId,
          icon: rawMaterialDetails.icon,
          name: rawMaterialDetails.name,
          quantity: rawMaterialDetails.quantity,
        ),
      );
    }
  }

  List<RequiredItemDetails> results = rawMaterialMap.values.toList();
  results.sort((a, b) => a.quantity < b.quantity ? 1 : 0);

  return results;
}

Future<List<RequiredItemDetails>> getRequiredItems(
  BuildContext reqCtx,
  RequiredItem requiredItem,
) async {
  RequiredItemDetails requiredItemDetails;
  List<RequiredItem> tempRawMaterials = List.empty(growable: true);

  InventoryRepository? genRepo = getGenericRepoFromAppId(requiredItem.appId);
  if (genRepo == null) return List.empty();

  ResultWithValue<InventoryItem> genericResult =
      await genRepo.getItem(reqCtx, requiredItem.appId);

  if (genericResult.hasFailed) {
    getLog().e("genericItemResult hasFailed: ${genericResult.errorMessage}");
    return List.empty(growable: true);
  }

  tempRawMaterials = genericResult.value.craftable.requiredItems
      .map((craftReq) => RequiredItem(
            appId: craftReq.appId,
            quantity: craftReq.quantity,
          ))
      .toList();
  requiredItemDetails =
      toRequiredItemDetails(requiredItem, genericResult.value);

  List<RequiredItemDetails> rawMaterialsResult = List.empty(growable: true);

  if (tempRawMaterials.isEmpty) {
    rawMaterialsResult.add(requiredItemDetails);
    return rawMaterialsResult;
  }

  for (int requiredIndex = 0;
      requiredIndex < tempRawMaterials.length;
      requiredIndex++) {
    RequiredItem rawMaterial = tempRawMaterials[requiredIndex];
    rawMaterial.quantity *= requiredItem.quantity;

    if (rawMaterial.appId == requiredItem.appId) {
      // Handle infinite loop
      continue;
      //return List.empty(growable: true);
    }
    List<RequiredItemDetails> requiredItems =
        // ignore: use_build_context_synchronously
        await getRequiredItems(reqCtx, rawMaterial);
    rawMaterialsResult.addAll(requiredItems);
  }
  return rawMaterialsResult;
}

RequiredItemDetails toRequiredItemDetails(
        RequiredItem requiredItem, InventoryItem invItem) =>
    RequiredItemDetails(
      appId: requiredItem.appId,
      icon: invItem.icon,
      name: invItem.name,
      quantity: requiredItem.quantity,
    );
