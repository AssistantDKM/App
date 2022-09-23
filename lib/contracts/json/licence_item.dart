// To parse this JSON data, do
//
//     final licenceItem = licenceItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import './licence_level_item.dart';
import '../interface/item_base_presenter.dart';

class LicenceItem extends ItemBasePresenter {
  final int id;
  final String description;
  final List<LicenceLevel> levels;

  LicenceItem({
    required this.id,
    required name,
    required this.description,
    required this.levels,
    required imageUrl,
  }) : super(id.toString(), name, imageUrl);

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
