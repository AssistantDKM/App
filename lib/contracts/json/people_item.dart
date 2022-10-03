// To parse this JSON data, do
//
//     final peopleItem = peopleItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../interface/item_base_presenter.dart';

class PeopleItem extends ItemBasePresenter {
  final int id;
  final String imageUrl;
  final String occupation;
  final String favouriteFood;
  final List<String> dislikes;
  final String building;

  PeopleItem({
    required this.id,
    required name,
    required this.occupation,
    required this.favouriteFood,
    required this.dislikes,
    required this.building,
    required this.imageUrl,
  }) : super(id.toString(), name, '');

  factory PeopleItem.fromJson(String str) =>
      PeopleItem.fromMap(json.decode(str));

  factory PeopleItem.fromMap(Map<String, dynamic> json) => PeopleItem(
        id: readIntSafe(json, 'id'),
        name: readStringSafe(json, 'name'),
        occupation: readStringSafe(json, 'occupation'),
        favouriteFood: readStringSafe(json, 'favourite_food'),
        dislikes: readListSafe(
          json,
          'dislikes',
          (x) => x.toString(),
        ),
        building: readStringSafe(json, 'building'),
        imageUrl: readStringSafe(json, 'image_url'),
      );
}
