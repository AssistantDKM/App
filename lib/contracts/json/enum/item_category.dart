import '../../enum_base.dart';

enum ItemCategory {
  tools,
  landscaping,
  lighting,
  farming,
  home,
  miscellaneous,
}

final itemCategoryValues = EnumValues({
  "Farming": ItemCategory.farming,
  "Home": ItemCategory.home,
  "Landscaping": ItemCategory.landscaping,
  "Lighting": ItemCategory.lighting,
  "Miscellaneous": ItemCategory.miscellaneous,
  "Tools": ItemCategory.tools,
});
