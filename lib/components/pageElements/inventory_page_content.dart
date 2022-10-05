import 'package:assistant_dinkum_app/contracts/json/inventory_item_consumable_buff.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../constants/app_json.dart';
import '../../contracts/json/inventory_item.dart';
import '../../contracts/json/inventory_item_craftable_required.dart';
import '../../contracts/json/inventory_item_creature.dart';
import '../../helper/patreon_helper.dart';
import '../../helper/position_helper.dart';
import '../../pages/inventory_pages.dart';
import '../../redux/misc/inventory_item_viewmodel.dart';
import '../chip/effect_chip_presenter.dart';
import '../tilePreseneters/required_item_tile_presenter.dart';
import 'inventory_item_favourites_icon.dart';
import 'inventory_item_museum_tile.dart';
import 'item_page_components.dart';

List<Widget> Function(InventoryItem loadedItem, bool isInDetailPane)
    commonInventoryContents(
  BuildContext contentsContext,
  InventoryItemViewModel viewmodel,
  void Function(Widget newDetailView)? updateDetailView,
) {
  return (InventoryItem loadedItem, bool isInDetailPane) {
    bool isMuseumPlaceable = loadedItem.appId.contains(AppJsonPrefix.bug) ||
        loadedItem.appId.contains(AppJsonPrefix.fish) ||
        loadedItem.appId.contains(AppJsonPrefix.critter);

    List<Widget> stackWidgets = [
      InventoryItemFavouritesIcon(appId: loadedItem.appId),
    ];

    Widget imageStack = Stack(
      children: [
        Center(child: localImage(loadedItem.icon)),
        ...widgetsToPositioneds(stackWidgets),
      ],
    );

    List<Widget> descripWidgets = [
      imageStack,
      genericItemName(loadedItem.name),
      pageDefaultPadding(genericItemDescription(loadedItem.description)),
      dinkumPrice(contentsContext, loadedItem.sellPrice),
    ];

    if (isMuseumPlaceable) {
      descripWidgets.add(emptySpace3x());
      descripWidgets.add(flatCard(
        child: InventoryItemMuseumTile(appId: loadedItem.appId),
      ));
    }

    var localConsumable = loadedItem.consumable;
    if (localConsumable.buffs.isNotEmpty) {
      descripWidgets.add(emptySpace2x());
      descripWidgets.add(genericItemGroup('Effects'));

      List<InventoryItemConsumableBuff> localBuffs = localConsumable.buffs
          .where((buff) => buff.level > 0 || buff.seconds > 0)
          .toList();
      descripWidgets.add(flatCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: localBuffs
                .map((item) => effectChipPresenter(contentsContext, item))
                .toList(),
          ),
        ),
      ));
    }

    var localRequireds = loadedItem.craftable.requiredItems;
    if (localRequireds.isNotEmpty) {
      localRequireds.sort((a, b) => b.quantity.compareTo(a.quantity));
      descripWidgets.add(emptySpace2x());
      descripWidgets.add(genericItemGroup('Required Items')); // TODO localize
      for (InventoryItemCraftableRequired required in localRequireds) {
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
          getTranslations().fromKey(LocaleKey.habitat),
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
          getTranslations().fromKey(LocaleKey.seasons),
          seasons
              .where((item) => item.isNotEmpty)
              .map((item) => (item.toLowerCase() == 'all')
                  ? getTranslations().fromKey(LocaleKey.all)
                  : getTranslations().fromString('season$item'))
              .toList(),
        ));
      }

      if (localCreature.timeOfDay.isNotEmpty) {
        List<String> times = List.empty(growable: true);
        times.addAll(localCreature.timeOfDay);
        descripWidgets.addAll(loadSections(
          getTranslations().fromKey(LocaleKey.times),
          times
              .where((item) => item.isNotEmpty)
              .map((item) => (item.toLowerCase() == 'all')
                  ? getTranslations().fromKey(LocaleKey.all)
                  : getTranslations().fromString('time$item'))
              .toList(),
        ));
      }
    }

    if (loadedItem.hidden == true && viewmodel.isPatron == false) {
      return [
        Center(child: localImage(AppImage.unknown)),
        genericItemName(obscureText(loadedItem.name)),
        pageDefaultPadding(genericItemDescription(
          obscureText(loadedItem.description),
        )),
      ];
    }

    return descripWidgets;
  };
}
