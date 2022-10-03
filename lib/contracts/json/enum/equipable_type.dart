import '../../enum_base.dart';

enum EquipableType {
  notEquipable,
  hat,
  face,
  shirt,
  dress,
  pants,
  shoes,
  idol,
  flooring,
  wallpaper,
}

final equipableTypeValues = EnumValues({
  '': EquipableType.notEquipable,
  '0': EquipableType.notEquipable,
  '1': EquipableType.hat,
  '2': EquipableType.face,
  '3': EquipableType.shirt,
  '4': EquipableType.dress,
  '5': EquipableType.pants,
  '6': EquipableType.shoes,
  '7': EquipableType.idol,
  '8': EquipableType.flooring,
  '9': EquipableType.wallpaper,
});
