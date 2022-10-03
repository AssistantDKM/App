import '../../enum_base.dart';

enum ConsumableType {
  unknown,
  meat,
  fruit,
  animalProduct,
  vegetable,
}

final consumableTypeValues = EnumValues({
  "0": ConsumableType.unknown,
  "1": ConsumableType.meat,
  "2": ConsumableType.fruit,
  "3": ConsumableType.animalProduct,
  "4": ConsumableType.vegetable,
});
