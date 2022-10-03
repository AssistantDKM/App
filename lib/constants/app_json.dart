class AppJson {
  static const String bugs = 'bugs';
  static const String items = 'items';
  static const String cooking = 'cooking';
  static const String clothing = 'clothing';
  static const String critters = 'critter';
  static const String fish = 'fish';
  static const String furniture = 'furniture';

  static const String licences = 'licences';
  static const String milestones = 'milestones';
  static const String people = 'people';
}

/* FROM C# proj
enum AppIdPrefix
{
    Bug,
    Clothing,
    Critter,
    Fish,
    Furniture,
    Item,
    Cooking,
}
*/

class AppJsonPrefix {
  static const String bug = 'bug';
  static const String clothing = 'clothing';
  static const String critter = 'critter';
  static const String fish = 'fish';
  static const String furniture = 'furniture';
  static const String item = 'item';
  static const String cooking = 'cooking';
}

Map<String, String> appJsonFromAppIdMap = {
  AppJsonPrefix.bug: AppJson.bugs,
  AppJsonPrefix.clothing: AppJson.clothing,
  AppJsonPrefix.critter: AppJson.critters,
  AppJsonPrefix.fish: AppJson.fish,
  AppJsonPrefix.furniture: AppJson.furniture,
  AppJsonPrefix.item: AppJson.items,
  AppJsonPrefix.cooking: AppJson.cooking,
};
