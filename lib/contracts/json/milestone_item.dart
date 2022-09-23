// To parse this JSON data, do
//
//     final milestoneItem = milestoneItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../interface/item_list_page_type.dart';
import 'milestone_level.dart';

class MilestoneItem extends ItemListPageType {
  final int id;
  final String description;
  final List<MilestoneLevel> levels;
  final String imageUrl;

  MilestoneItem({
    required this.id,
    required name,
    required this.description,
    required this.levels,
    required this.imageUrl,
  }) : super(id.toString(), name);

  factory MilestoneItem.fromJson(String str) =>
      MilestoneItem.fromMap(json.decode(str));

  factory MilestoneItem.fromMap(Map<String, dynamic> json) => MilestoneItem(
        id: readIntSafe(json, 'id'),
        name: readStringSafe(json, 'name'),
        description: readStringSafe(json, 'description'),
        levels: readListSafe(
          json,
          'levels',
          (x) => MilestoneLevel.fromMap(x),
        ),
        imageUrl: readStringSafe(json, 'image_url'),
      );
}
