// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import 'inventory_item_craftable_required.dart';

class InventoryItemCraftable {
  final List<InventoryItemCraftableRequired> requiredItems;
  final int recipeGiveThisAmount;
  // final int workPlaceConditionsEnum;
  // final String workPlaceConditions;
  // final int categoryEnum;
  // final String category;
  // final int subCategoryEnum;
  // final String subCategory;
  // final int tierLevel;
  // final int skillEnum;
  // final String skill;
  // final int levelSkillLearnt;
  final bool learnThroughLicence;
  final String licenceAppId;
  final int licenceLevelLearnt;
  // final int crafterLevelLearnt;

  InventoryItemCraftable({
    required this.requiredItems,
    required this.recipeGiveThisAmount,
    // required this.workPlaceConditionsEnum,
    // required this.workPlaceConditions,
    // required this.categoryEnum,
    // required this.category,
    // required this.subCategoryEnum,
    // required this.subCategory,
    // required this.tierLevel,
    // required this.skillEnum,
    // required this.skill,
    // required this.levelSkillLearnt,
    required this.learnThroughLicence,
    required this.licenceAppId,
    required this.licenceLevelLearnt,
    // required this.crafterLevelLearnt,
  });

  factory InventoryItemCraftable.fromJson(String str) =>
      InventoryItemCraftable.fromMap(json.decode(str));

  factory InventoryItemCraftable.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return InventoryItemCraftable(
        recipeGiveThisAmount: 0,
        requiredItems: [],
        learnThroughLicence: false,
        licenceAppId: '',
        licenceLevelLearnt: 0,
      );
    }
    return InventoryItemCraftable(
      requiredItems: readListSafe(
        json,
        'RequiredItems',
        (x) => InventoryItemCraftableRequired.fromMap(x),
      ),
      recipeGiveThisAmount: readIntSafe(json, 'RecipeGiveThisAmount'),
      // workPlaceConditionsEnum: readIntSafe(json, 'WorkPlaceConditionsEnum'),
      // workPlaceConditions: readIntSafe(json, 'WorkPlaceConditions'),
      // categoryEnum: readIntSafe(json, 'CategoryEnum'),
      // category: readIntSafe(json, 'Category'),
      // subCategoryEnum: readIntSafe(json, 'SubCategoryEnum'),
      // subCategory: readIntSafe(json, 'SubCategory'),
      // tierLevel: readIntSafe(json, 'TierLevel'),
      // skillEnum: readIntSafe(json, 'SkillEnum'),
      // skill: readIntSafe(json, 'Skill'),
      // levelSkillLearnt: readIntSafe(json, 'LevelSkillLearnt'),
      learnThroughLicence: readBoolSafe(json, 'LearnThroughLicence'),
      licenceAppId: readStringSafe(json, 'LicenceAppId'),
      licenceLevelLearnt: readIntSafe(json, 'LicenceLevelLearnt'),
      // licenceLevelLearnt: readIntSafe(json, 'LicenceLevelLearnt'),
      // crafterLevelLearnt: readIntSafe(json, 'CrafterLevelLearnt'),
    );
  }
}
