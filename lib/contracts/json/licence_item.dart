// To parse this JSON data, do
//
//     final licenceItem = licenceItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistant_dinkum_app/contracts/json/licence_level_item.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../interface/item_list_page_type.dart';

class LicenceItem extends ItemListPageType {
  final int id;
  final String name;
  final String description;
  final List<LicenceLevel> levels;
  final String imageUrl;

  LicenceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.levels,
    required this.imageUrl,
  }) : super(id.toString(), name);

  factory LicenceItem.fromJson(String str) =>
      LicenceItem.fromMap(json.decode(str));

  factory LicenceItem.fromMap(Map<String, dynamic> json) => LicenceItem(
        id: readIntSafe(json, 'id'),
        name: readStringSafe(json, 'name'),
        description: readStringSafe(json, 'description'),
        levels: readListSafe(
          json,
          'levels',
          (x) => LicenceLevel.fromMap(x),
        ),
        imageUrl: readStringSafe(json, 'image_url'),
      );
}
