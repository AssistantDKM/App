import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_json.dart';
import '../../contracts/json/inventory_item.dart';
import '../../contracts/json/inventory_item_craftable_required.dart';
import '../../contracts/json/inventory_item_creature.dart';
import '../../helper/position_helper.dart';
import '../../pages/inventory_pages.dart';
import '../tilePreseneters/required_item_tile_presenter.dart';
import 'inventory_item_favourites_icon.dart';
import 'inventory_item_museum_icon.dart';
import 'item_page_components.dart';

List<Widget> Function(InventoryItem loadedItem, bool isInDetailPane)
    commonInventoryContents(
  BuildContext contentsContext,
  void Function(Widget newDetailView)? updateDetailView,
) {
  return (InventoryItem loadedItem, bool isInDetailPane) {
    bool isMuseumPlaceable = loadedItem.appId.contains(AppJsonPrefix.bug) ||
        loadedItem.appId.contains(AppJsonPrefix.fish) ||
        loadedItem.appId.contains(AppJsonPrefix.critter);

    List<Widget> stackWidgets = [
      InventoryItemFavouritesIcon(appId: loadedItem.appId),
    ];

    if (isMuseumPlaceable) {
      stackWidgets.add(InventoryItemMuseumIcon(appId: loadedItem.appId));
    }

    Widget imageStack = Stack(
      children: [
        Center(child: localImage('inventory/${loadedItem.icon}')),
        ...widgetsToPositioneds(stackWidgets),
      ],
    );

    List<Widget> descripWidgets = [
      imageStack,
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
          child: requiredItemTilePresenter(
            contentsContext,
            required,
            onTap: (isInDetailPane && updateDetailView != null)
                ? () => updateDetailView(
                      InventoryDetailsPage(
                        required.appId,
                        title: required.appId.toString(),
                        isInDetailPane: isInDetailPane,
                        updateDetailView: updateDetailView,
                      ),
                    )
                : null,
          ),
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
  };
}
