import '../../enum_base.dart';

enum CreatureType {
  none,
  bug,
  fish,
  critter,
  relic,
}

final creatureTypeValues = EnumValues({
  '': CreatureType.none,
  '0': CreatureType.none,
  '1': CreatureType.bug,
  '2': CreatureType.fish,
  '3': CreatureType.critter,
  '4': CreatureType.relic,
});
