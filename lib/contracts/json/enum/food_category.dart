import '../../enum_base.dart';

enum FoodCategory {
  unknown,
  raw,
  cooked,
  bottled,
}

final foodCategoryValues = EnumValues({
  "Bottled": FoodCategory.bottled,
  "Cooked": FoodCategory.cooked,
  "Raw": FoodCategory.raw,
});
