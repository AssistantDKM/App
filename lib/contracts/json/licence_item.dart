// To parse this JSON data, do
//
//     final licenceItem = licenceItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../interface/item_base_presenter.dart';

class LicenceItem extends ItemBasePresenter {
  final int id;
  final List<String> descriptions;
  final int maxLevel;
  final int levelCost;
  final int levelCostMuliplier;
  final int unlockedBySkill;
  final int sortingNumber;
  final String licenceColour;

  LicenceItem({
    required this.id,
    required String appId,
    required String name,
    required String icon,
    required this.descriptions,
    required this.maxLevel,
    required this.levelCost,
    required this.levelCostMuliplier,
    required this.unlockedBySkill,
    required this.sortingNumber,
    required this.licenceColour,
  }) : super(appId, name, icon);

  factory LicenceItem.fromJson(String str) =>
      LicenceItem.fromMap(json.decode(str));

  factory LicenceItem.fromMap(Map<String, dynamic> json) => LicenceItem(
        id: readIntSafe(json, 'Id'),
        appId: readStringSafe(json, 'AppId'),
        name: readStringSafe(json, 'Name'),
        descriptions: readListSafe(
          json,
          'Descriptions',
          (x) => x.toString(),
        ),
        icon: readStringSafe(json, 'Icon'),
        maxLevel: readIntSafe(json, 'MaxLevel'),
        levelCost: readIntSafe(json, 'LevelCost'),
        levelCostMuliplier: readIntSafe(json, 'LevelCostMuliplier'),
        unlockedBySkill: readIntSafe(json, 'UnlockedBySkill'),
        sortingNumber: readIntSafe(json, 'SortingNumber'),
        licenceColour: readStringSafe(json, 'LicenceColour'),
      );
}
