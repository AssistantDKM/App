// ignore_for_file: constant_identifier_names

import '../../enum_base.dart';

enum Habitat {
  // Bugs
  everywhere,
  pine_forests,
  plains,
  tropics,
  desert,
  bushlands,

  // Critters
  southern_ocean,
  northern_ocean,
  rivers,

  // Fish
  billabongs,
  mangroves,
}

final habitatValues = EnumValues({
  // Bugs
  "Everywhere": Habitat.everywhere,
  "Bushlands": Habitat.bushlands,
  "Desert": Habitat.desert,
  "Pine Forests": Habitat.pine_forests,
  "Plains": Habitat.plains,
  "Tropics": Habitat.tropics,

  // Critters
  "Southern Ocean": Habitat.southern_ocean,
  "Northern Ocean": Habitat.northern_ocean,
  "Rivers": Habitat.rivers,

  // Fish
  "Billabongs": Habitat.billabongs,
  "Mangroves": Habitat.mangroves,
});
