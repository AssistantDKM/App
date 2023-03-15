import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../constants/app_json.dart';
import '../../constants/app_misc.dart';
import '../../contracts/json/inventory_item.dart';
import '../../contracts/json/inventory_item_consumable.dart';
import '../../contracts/json/inventory_item_consumable_buff.dart';
import '../../contracts/json/inventory_item_craftable_required.dart';
import '../../contracts/json/inventory_item_creature.dart';
import '../../contracts/pageItem/inventory_page_item.dart';
import '../../helper/generic_repository_helper.dart';
import '../../helper/patreon_helper.dart';
import '../../helper/position_helper.dart';
import '../../pages/inventory_pages.dart';
import '../../pages/licences_pages.dart';
import '../../pages/misc/all_possible_outputs_future_page.dart';
import '../../redux/misc/inventory_item_viewmodel.dart';
import '../chip/effect_chip_presenter.dart';
import '../tilePresenters/inventory_tile_presenter.dart';
import '../tilePresenters/licence_tile_presenter.dart';
import '../tilePresenters/required_item_tile_presenter.dart';
import 'inventory_item_favourites_icon.dart';
import 'inventory_item_museum_tile.dart';
import 'item_page_components.dart';

List<Widget> Function(
  InventoryPageItem loadedPageItem,
  bool isInDetailPane,
) commonInventoryContents(
  BuildContext contentsContext,
  InventoryItemViewModel viewmodel,
  void Function(Widget newDetailView)? updateDetailView,
) {
  return (InventoryPageItem loadedPageItem, bool isInDetailPane) {
    InventoryItem loadedItem = loadedPageItem.item;

    bool isMuseumPlaceable = loadedItem.appId.contains(AppJsonPrefix.bug) ||
        loadedItem.appId.contains(AppJsonPrefix.fish) ||
        loadedItem.appId.contains(AppJsonPrefix.critter);

    List<Widget> stackWidgets = [
      InventoryItemFavouritesIcon(appId: loadedItem.appId),
    ];

    Widget imageStack = Stack(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: minHeightOfDetailPageHeaderImage,
          ),
          child: Center(
            child: LocalImage(imagePath: loadedItem.icon),
          ),
        ),
        ...widgetsToPositioneds(stackWidgets),
      ],
    );

    List<Widget> descripWidgets = [
      imageStack,
      GenericItemName(loadedItem.name),
      pageDefaultPadding(GenericItemDescription(loadedItem.description)),
    ];

    if (loadedItem.sellPrice > 0) {
      descripWidgets.add(dinkumPrice(contentsContext, loadedItem.sellPrice));
    }

    if (isMuseumPlaceable) {
      descripWidgets.add(const EmptySpace3x());
      descripWidgets.add(FlatCard(
        child: InventoryItemMuseumTile(
          appId: loadedItem.appId,
          donations: viewmodel.donations,
        ),
      ));
    }

    InventoryItemConsumable localConsumable = loadedItem.consumable;
    if (localConsumable.buffs.isNotEmpty) {
      descripWidgets.add(const EmptySpace2x());
      descripWidgets.add(GenericItemGroup(
        getTranslations().fromKey(LocaleKey.effects),
      ));

      List<InventoryItemConsumableBuff> localBuffs = localConsumable.buffs
          .where((buff) => buff.level > 0 || buff.seconds > 0)
          .toList();
      descripWidgets.add(FlatCard(
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
      descripWidgets.add(const EmptySpace2x());
      descripWidgets.add(GenericItemGroup(
        getTranslations().fromKey(LocaleKey.requiredItems),
      ));
      for (InventoryItemCraftableRequired required in localRequireds) {
        descripWidgets.add(FlatCard(
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
              .map((item) => (item.toLowerCase() == 'all')
                  ? getTranslations().fromKey(LocaleKey.all)
                  : getTranslations().fromString('habitat$item'))
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

    if (loadedPageItem.usages.isNotEmpty) {
      descripWidgets.add(const EmptySpace2x());
      descripWidgets.add(GenericItemGroup(
        getTranslations().fromKey(LocaleKey.usedToCreate),
      ));

      var usagesPresenter = inventoryUsageTilePresenter(
        viewmodel.isPatron,
        isInDetailPane: isInDetailPane,
        updateDetailView: updateDetailView,
      );

      allItemsPageNavigate(BuildContext navigateCtx) =>
          AllPossibleOutputsFromFuturePage<InventoryItem>(
            () => getGenericRepoFromAppId(loadedItem.appId)
                .getUsagesOfItem(navigateCtx, loadedItem.appId)
                .then(
                  (result) => result.isSuccess //
                      ? result.value
                      : List.empty(),
                ),
            loadedItem.name,
            usagesPresenter,
            subtitle: getTranslations().fromKey(LocaleKey.usedToCreate),
            hideAppBar: isInDetailPane,
            onBackButton: (isInDetailPane && updateDetailView != null)
                ? () => updateDetailView(
                      InventoryDetailsPage(
                        loadedItem.appId,
                        title: loadedItem.appId.toString(),
                        isInDetailPane: isInDetailPane,
                        updateDetailView: updateDetailView,
                      ),
                    )
                : null,
          );

      descripWidgets.addAll(
        genericItemWithOverflowButton(
          contentsContext,
          loadedPageItem.usages,
          usagesPresenter,
          viewMoreOnPress: (isInDetailPane && updateDetailView != null)
              ? () => updateDetailView(allItemsPageNavigate(contentsContext))
              : () => getNavigation().navigateAsync(
                    contentsContext,
                    navigateTo: allItemsPageNavigate,
                  ),
        ),
      );
    }

    if (loadedPageItem.requiredLicence != null) {
      descripWidgets.add(const EmptySpace2x());
      descripWidgets.add(const GenericItemGroup(
        'Required Licence',
      ));
      var localPresenter = licenceTilePresenter(isPatron: viewmodel.isPatron);
      descripWidgets.add(FlatCard(
        child: localPresenter(
          contentsContext,
          loadedPageItem.requiredLicence!,
          0,
          onTap: () => getNavigation().navigateAwayFromHomeAsync(
            contentsContext,
            navigateTo: (BuildContext navigateCtx) => LicenceDetailsPage(
              loadedPageItem.requiredLicence!.appId,
              title: loadedPageItem.requiredLicence!.name,
            ),
          ),
        ),
      ));
    }

    if (loadedItem.hidden == true && viewmodel.isPatron == false) {
      return [
        const Center(child: LocalImage(imagePath: AppImage.locked)),
        GenericItemName(obscureText(loadedItem.name)),
        pageDefaultPadding(GenericItemDescription(
          obscureText(loadedItem.description),
        )),
      ];
    }

    return descripWidgets;
  };
}
