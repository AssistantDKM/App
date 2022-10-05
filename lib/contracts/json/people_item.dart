// To parse this JSON data, do
//
//     final peopleItem = peopleItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../interface/item_base_presenter.dart';

class PeopleItem extends ItemBasePresenter {
  final String deed;
  final int spendBeforeMoveIn;
  final int relationshipBeforeMove;
  final String shirtAppId;
  final String pantsAppId;
  final String shoesAppId;
  final String color;
  final String favouriteFood;
  final String hatedFood;
  final bool hatesAnimalProducts;
  final bool hatesMeat;
  final bool hatesFruits;
  final bool hatesVegetables;

  PeopleItem({
    required appId,
    required icon,
    required name,
    required this.deed,
    required this.spendBeforeMoveIn,
    required this.relationshipBeforeMove,
    required this.shirtAppId,
    required this.pantsAppId,
    required this.shoesAppId,
    required this.color,
    required this.favouriteFood,
    required this.hatedFood,
    required this.hatesAnimalProducts,
    required this.hatesMeat,
    required this.hatesFruits,
    required this.hatesVegetables,
  }) : super(appId, name, icon);

  factory PeopleItem.fromJson(String str) =>
      PeopleItem.fromMap(json.decode(str));

  factory PeopleItem.fromMap(Map<String, dynamic> json) => PeopleItem(
        appId: readStringSafe(json, 'AppId'),
        icon: readStringSafe(json, 'Icon'),
        name: readStringSafe(json, 'Name'),
        deed: readStringSafe(json, 'Deed'),
        spendBeforeMoveIn: readIntSafe(json, 'SpendBeforeMoveIn'),
        relationshipBeforeMove: readIntSafe(json, 'RelationshipBeforeMove'),
        shirtAppId: readStringSafe(json, 'ShirtAppId'),
        pantsAppId: readStringSafe(json, 'PantsAppId'),
        shoesAppId: readStringSafe(json, 'ShoesAppId'),
        color: readStringSafe(json, 'Color'),
        favouriteFood: readStringSafe(json, 'FavouriteFood'),
        hatedFood: readStringSafe(json, 'HatedFood'),
        hatesAnimalProducts: readBoolSafe(json, 'HatesAnimalProducts'),
        hatesMeat: readBoolSafe(json, 'HatesMeat'),
        hatesFruits: readBoolSafe(json, 'HatesFruits'),
        hatesVegetables: readBoolSafe(json, 'HatesVegetables'),
      );
}
