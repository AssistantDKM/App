// To parse this JSON data, do
//
//     final furnitureItem = furnitureItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../interface/item_list_page_type.dart';

class FurnitureItem extends ItemListPageType {
  final int id;
  final String description;
  final int sellPrice;
  final String furnitureItemSet;

  FurnitureItem({
    required this.id,
    required name,
    required this.description,
    required this.sellPrice,
    required this.furnitureItemSet,
  }) : super(id.toString(), name);

  factory FurnitureItem.fromJson(String str) =>
      FurnitureItem.fromMap(json.decode(str));

  factory FurnitureItem.fromMap(Map<String, dynamic> json) => FurnitureItem(
        id: readIntSafe(json, 'id'),
        name: readStringSafe(json, 'name'),
        description: readStringSafe(json, 'description'),
        sellPrice: readIntSafe(json, 'sell_price'),
        furnitureItemSet: readStringSafe(json, 'set'),
      );
}
