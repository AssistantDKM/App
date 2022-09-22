import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class LicenceLevel {
  final int licenceLevel;
  final int skillLevel;
  final int cost;
  final String description;
  final List<String> unlockedRecipes;

  LicenceLevel({
    required this.licenceLevel,
    required this.skillLevel,
    required this.cost,
    required this.description,
    required this.unlockedRecipes,
  });

  factory LicenceLevel.fromJson(String str) =>
      LicenceLevel.fromMap(json.decode(str));

  factory LicenceLevel.fromMap(Map<String, dynamic> json) => LicenceLevel(
        licenceLevel: readIntSafe(json, 'licence_level'),
        skillLevel: readIntSafe(json, 'skill_level'),
        cost: readIntSafe(json, 'cost'),
        description: readStringSafe(json, 'description'),
        unlockedRecipes: readListSafe(
          json,
          'unlocked_recipes',
          (x) => x.toString(),
        ),
      );
}
