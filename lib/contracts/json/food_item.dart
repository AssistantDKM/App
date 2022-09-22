// To parse this JSON data, do
//
//     final consumableItem = consumableItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../interface/item_list_page_type.dart';
import 'enum/food_category.dart';
import 'enum/food_effect.dart';
import 'required_item.dart';

class FoodItem extends ItemListPageType {
  final int id;
  final String description;
  final FoodCategory category;
  final List<FoodEffect> effects;
  final List<RequiredItem> materials;
  final int sellPrice;
  final String imageUrl;

  FoodItem({
    required this.id,
    required name,
    required this.description,
    required this.category,
    required this.effects,
    required this.materials,
    required this.sellPrice,
    required this.imageUrl,
  }) : super(id.toString(), name);

  factory FoodItem.fromJson(String str) => FoodItem.fromMap(json.decode(str));

  factory FoodItem.fromMap(Map<String, dynamic> json) => FoodItem(
        id: readIntSafe(json, 'id'),
        name: readStringSafe(json, 'name'),
        description: readStringSafe(json, 'description'),
        category: foodCategoryValues.map[readStringSafe(json, 'category')] ??
            FoodCategory.unknown,
        effects: readListSafe(
          json,
          'effects',
          (x) => FoodEffect.fromMap(x),
        ),
        materials: readListSafe(
          json,
          'materials',
          (x) => RequiredItem.fromMap(x),
        ),
        sellPrice: readIntSafe(json, 'sell_price'),
        imageUrl: readStringSafe(json, 'image_url'),
      );
}
