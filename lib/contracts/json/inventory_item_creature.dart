// To parse this JSON data, do
//
//     final craftingItem = craftingItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../helper/json_helper.dart';
import 'enum/creature_type.dart';

class InventoryItemCreature {
  final CreatureType type;
  final List<String> landLocation;
  final List<String> waterLocation;
  final List<String> seasonFound;
  final List<String> timeOfDay;
  final String rarity;

  InventoryItemCreature({
    required this.type,
    required this.landLocation,
    required this.waterLocation,
    required this.seasonFound,
    required this.timeOfDay,
    required this.rarity,
  });

  factory InventoryItemCreature.fromJson(String str) =>
      InventoryItemCreature.fromMap(json.decode(str));

  factory InventoryItemCreature.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return InventoryItemCreature(
        type: CreatureType.none,
        landLocation: [],
        waterLocation: [],
        seasonFound: [],
        timeOfDay: [],
        rarity: '',
      );
    }
    return InventoryItemCreature(
      type: creatureTypeValues.map[readIntSafe(json, 'Type').toString()] ??
          CreatureType.none,
      landLocation: readStringListSafe(json, 'LandLocation'),
      waterLocation: readStringListSafe(json, 'WaterLocation'),
      seasonFound: readStringListSafe(json, 'SeasonFound'),
      timeOfDay: readStringListSafe(json, 'TimeOfDay'),
      rarity: readStringSafe(json, 'Rarity'),
    );
  }
}
