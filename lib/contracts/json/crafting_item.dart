// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../interface/item_list_page_type.dart';
import 'required_item.dart';
import 'enum/item_category.dart';
import 'item_licence_requirement.dart';

class CraftingItem extends ItemListPageType {
  final int id;
  final String description;
  final ItemCategory category;
  final List<RequiredItem> materials;
  final int totalProduced;
  final ItemLicenceRequirement? licenceRequirement;
  final int sellPrice;
  final String imageUrl;

  CraftingItem({
    required this.id,
    required name,
    required this.description,
    required this.category,
    required this.materials,
    required this.totalProduced,
    required this.licenceRequirement,
    required this.sellPrice,
    required this.imageUrl,
  }) : super(id.toString(), name);

  factory CraftingItem.fromJson(String str) =>
      CraftingItem.fromMap(json.decode(str));

  factory CraftingItem.fromMap(Map<String, dynamic> json) => CraftingItem(
        id: readIntSafe(json, 'id'),
        name: readStringSafe(json, 'name'),
        description: readStringSafe(json, 'description'),
        category: itemCategoryValues.map[readStringSafe(json, 'category')]!,
        totalProduced: readIntSafe(json, 'total_produced'),
        materials: readListSafe(
          json,
          'materials',
          (x) => RequiredItem.fromMap(x),
        ),
        licenceRequirement: json["licence"] == null
            ? null
            : ItemLicenceRequirement.fromMap(json['licence']),
        sellPrice: readIntSafe(json, 'sell_price'),
        imageUrl: readStringSafe(json, 'image_url'),
      );
}
