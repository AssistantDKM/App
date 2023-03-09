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
    required String appId,
    required String name,
    required String icon,
    required this.description,
    required this.levels,
  }) : super(appId, name, icon);

  factory LicenceItem.fromJson(String str) =>
      LicenceItem.fromMap(json.decode(str));

  factory LicenceItem.fromMap(Map<String, dynamic> json) => LicenceItem(
        id: readIntSafe(json, 'Id'),
        icon: readStringSafe(json, 'Icon'),
        appId: readStringSafe(json, 'AppId'),
        name: readStringSafe(json, 'Name'),
        description: readStringSafe(json, 'Description'),
        levels: readListSafe(
          json,
          'Levels',
          (x) => LicenceLevel.fromMap(x),
        ),
      );
}
