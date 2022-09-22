// To parse this JSON data, do
//
//     final bugItem = bugItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../interface/item_list_page_type.dart';
import 'availability.dart';
import 'enum/habitat.dart';

class AnimalItem extends ItemListPageType {
  final int id;
  final String name;
  final String description;
  final List<Habitat> habitats;
  final Availability availability;
  final int sellPrice;
  final String imageUrl;

  AnimalItem({
    required this.id,
    required this.name,
    required this.description,
    required this.habitats,
    required this.availability,
    required this.sellPrice,
    required this.imageUrl,
  }) : super(id.toString());

  factory AnimalItem.fromJson(String str) =>
      AnimalItem.fromMap(json.decode(str));

  factory AnimalItem.fromMap(Map<String, dynamic> json) => AnimalItem(
        id: readIntSafe(json, 'id'),
        name: readStringSafe(json, 'name'),
        description: readStringSafe(json, 'description'),
        habitats: readListSafe(
          json,
          'habitats',
          (x) => habitatValues.map[x.toString()]!,
        ),
        availability: Availability.fromMap(json['availability']),
        sellPrice: readIntSafe(json, 'sell_price'),
        imageUrl: readStringSafe(json, 'image_url'),
      );
}
