import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class AppJsonPrefix {
  static const String bug = 'bug';
  static const String clothing = 'clothing';
  static const String critter = 'critter';
  static const String fish = 'fish';
  static const String furniture = 'furniture';
  static const String item = 'item';
  static const String cooking = 'cooking';
}

Map<String, LocaleKey> appJsonFromAppIdMap = {
  AppJsonPrefix.bug: LocaleKey.bugsJson,
  AppJsonPrefix.clothing: LocaleKey.clothingJson,
  AppJsonPrefix.critter: LocaleKey.critterJson,
  AppJsonPrefix.fish: LocaleKey.fishJson,
  AppJsonPrefix.furniture: LocaleKey.furnitureJson,
  AppJsonPrefix.item: LocaleKey.itemsJson,
  AppJsonPrefix.cooking: LocaleKey.cookingJson,
};
