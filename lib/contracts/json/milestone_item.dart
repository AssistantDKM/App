// To parse this JSON data, do
//
//     final milestoneItem = milestoneItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../interface/item_base_presenter.dart';

class MilestoneItem extends ItemBasePresenter {
  final int id;
  final String description;
  final String prefix;
  final String suffix;
  final List<int> requirementsPerLevel;
  final int rewardPerLevel;
  final int points;
  final bool isVisibleOnList;

  MilestoneItem({
    required this.id,
    required String appId,
    required String name,
    required String icon,
    required this.description,
    required this.prefix,
    required this.suffix,
    required this.requirementsPerLevel,
    required this.rewardPerLevel,
    required this.points,
    required this.isVisibleOnList,
  }) : super(appId, name, icon);

  factory MilestoneItem.fromJson(String str) =>
      MilestoneItem.fromMap(json.decode(str));

  factory MilestoneItem.fromMap(Map<String, dynamic> json) => MilestoneItem(
        id: readIntSafe(json, 'Id'),
        icon: readStringSafe(json, 'Icon'),
        appId: readStringSafe(json, 'AppId'),
        name: readStringSafe(json, 'Name'),
        description: readStringSafe(json, 'Description'),
        prefix: readStringSafe(json, 'Prefix'),
        suffix: readStringSafe(json, 'Suffix'),
        requirementsPerLevel: readListSafe(
          json,
          'RequirementPerLevel',
          (x) => x,
        ),
        rewardPerLevel: readIntSafe(json, 'RewardPerLevel'),
        points: readIntSafe(json, 'Points'),
        isVisibleOnList: readBoolSafe(json, 'IsVisibleOnList'),
      );
}
