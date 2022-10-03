import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/cupertino.dart';

import '../../contracts/json/inventory_item.dart';
import '../../contracts/json/inventory_item_craftable_required.dart';
import '../../contracts/json/inventory_item_creature.dart';
import '../tilePreseneters/required_item_tile_presenter.dart';
import 'item_page_components.dart';

List<Widget> commonInventoryContents(
  BuildContext contentsContext,
  InventoryItem loadedItem,
) {
  List<Widget> descripWidgets = [
    Center(child: localImage('inventory/${loadedItem.icon}')),
    genericItemName(loadedItem.name),
    pageDefaultPadding(genericItemDescription(loadedItem.description)),
    dinkumPrice(contentsContext, loadedItem.sellPrice),
  ];

  var localRequireds = loadedItem.craftable.requiredItems;
  if (localRequireds.isNotEmpty) {
    localRequireds.sort((a, b) => b.quantity.compareTo(a.quantity));
    descripWidgets.add(emptySpace2x());
    descripWidgets.add(genericItemGroup('Required Items')); // TODO localize
    for (InventoryItemCraftableRequired required in localRequireds) {
      // descripWidgets.add(Padding(
      //   padding: const EdgeInsets.only(bottom: 4),
      //   child: flatCard(
      //     child: requiredItemTilePresenter(contentsContext, required, 0),
      //   ),
      // ));
      descripWidgets.add(flatCard(
        child: requiredItemTilePresenter(contentsContext, required, 0),
      ));
    }
  }

  InventoryItemCreature? localCreature = loadedItem.creatureDetails;
  if (localCreature != null) {
    List<String> locations = List.empty(growable: true);
    if (localCreature.landLocation.isNotEmpty) {
      locations.addAll(localCreature.landLocation);
    }
    if (localCreature.waterLocation.isNotEmpty) {
      locations.addAll(localCreature.waterLocation);
    }

    if (locations.isNotEmpty) {
      descripWidgets.addAll(loadSections(
        'Habitats', // TODO localize
        locations
            .where((item) => item.isNotEmpty)
            .map((item) => getTranslations().fromString('habitat$item'))
            .toList(),
      ));
    }

    if (localCreature.seasonFound.isNotEmpty) {
      List<String> seasons = List.empty(growable: true);
      seasons.addAll(localCreature.seasonFound);
      descripWidgets.addAll(loadSections(
        'Seasons', // TODO localize
        seasons
            .where((item) => item.isNotEmpty)
            .map((item) => getTranslations().fromString('season$item'))
            .toList(),
      ));
    }

    if (localCreature.timeOfDay.isNotEmpty) {
      List<String> times = List.empty(growable: true);
      times.addAll(localCreature.timeOfDay);
      descripWidgets.addAll(loadSections(
        'Times', // TODO localize
        times
            .where((item) => item.isNotEmpty)
            .map((item) => getTranslations().fromString('time$item'))
            .toList(),
      ));
    }
  }

  return descripWidgets;
}
