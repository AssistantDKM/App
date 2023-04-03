import 'package:assistant_dinkum_app/contracts/json/inventory_item.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/pageElements/item_page_components.dart';
import '../components/tilePresenters/inventory_tile_presenter.dart';
import '../components/tilePresenters/licence_tile_presenter.dart';
import '../constants/analytics_event.dart';
import '../constants/app_misc.dart';
import '../contracts/json/licence_item.dart';
import '../contracts/pageItem/licence_item_page_item.dart';
import '../contracts/redux/app_state.dart';
import '../helper/future_helper.dart';
import '../helper/navigate_helper.dart';
import '../helper/text_helper.dart';
import '../integration/dependency_injection.dart';
import '../redux/misc/inventory_item_viewmodel.dart';

class LicencesListPage extends StatelessWidget {
  final String analyticsEvent = AnalyticsEvent.licence;

  const LicencesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InventoryItemViewModel>(
      converter: (store) => InventoryItemViewModel.fromStore(store),
      builder: (_, viewModel) {
        String title = getTranslations().fromKey(LocaleKey.menuLicences);
        var localPresenter = licenceTilePresenter(
          isPatron: viewModel.isPatron,
        );
        return ItemsListPage<LicenceItem>(
          analyticsEvent: analyticsEvent,
          title: title,
          getItemsFunc: () => getLicenceRepo().getItems(context),
          listItemDisplayer: localPresenter,
          detailPageFunc: (
            String id,
            bool isInDetailPane,
            void Function(Widget)? updateDetailView,
          ) {
            List<String> comboId = id.split(itemPageSplitMarker);
            return LicenceDetailsPage(
              comboId.last,
              title: title,
              isInDetailPane: isInDetailPane,
              updateDetailView: updateDetailView,
            );
          },
        );
      },
    );
  }
}

class LicenceDetailsPage extends StatelessWidget {
  final String appId;
  final String title;
  final bool isInDetailPane;
  final void Function(Widget newDetailView)? updateDetailView;

  const LicenceDetailsPage(
    this.appId, {
    Key? key,
    required this.title,
    this.isInDetailPane = false,
    this.updateDetailView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getLog().d(appId);

    return StoreConnector<AppState, InventoryItemViewModel>(
      converter: (store) => InventoryItemViewModel.fromStore(store),
      builder: (storeCtx, viewModel) {
        return ItemDetailsPage<LicenceItemPageItem>(
          title: title,
          isInDetailPane: isInDetailPane,
          getItemFunc: () => getPageItem(storeCtx, appId),
          getName: (loadedItem) => loadedItem.name,
          contractToWidgetList: (loadedItem, isInDetailPane) {
            List<Widget> descripWidgets = commonDetailPageHeaderWidgets(
              storeCtx,
              icon: loadedItem.item.icon,
              name: addSpaceBeforeCapital(loadedItem.item.name),
              minHeight: 96,
              maxImageSize: 128,
            );

            if (loadedItem.item.maxLevel > 0) {
              descripWidgets.add(const EmptySpace2x());
              descripWidgets.add(const GenericItemGroup('Levels'));

              for (int levelIndex = 0;
                  levelIndex < loadedItem.item.maxLevel;
                  levelIndex++) {
                //
                descripWidgets.add(
                  FlatCard(
                    child: licenceLevelTilePresenter(
                      storeCtx,
                      loadedItem: loadedItem.item,
                      index: levelIndex,
                    ),
                  ),
                );

                List<InventoryItem> itemsThatGetUnlocked =
                    loadedItem.learnedFromLicencePerLevel.where((invItem) {
                  if (invItem.craftable.licenceLevelLearnt ==
                      (levelIndex + 1)) {
                    return true;
                  }
                  return false;
                }).toList();

                if (itemsThatGetUnlocked.isNotEmpty) {
                  descripWidgets.add(const EmptySpace1x());
                  for (int itemIndex = 0;
                      itemIndex < itemsThatGetUnlocked.length;
                      itemIndex++) {
                    InventoryItem invItem = itemsThatGetUnlocked[itemIndex];
                    var invPresenter = inventoryTilePresenter(
                      isPatron: viewModel.isPatron,
                      displayMuseumStatus: false,
                    );
                    descripWidgets.add(invPresenter(
                      storeCtx,
                      invItem,
                      0,
                      onTap: () => navigateToInventory(
                        context: storeCtx,
                        item: invItem,
                        isPatron: viewModel.isPatron,
                      ),
                    ));
                  }
                }
                descripWidgets.add(const EmptySpace2x());
              }
            }

            return descripWidgets;
          },
        );
      },
    );
  }
}

Future<ResultWithValue<LicenceItemPageItem>> getPageItem(
  BuildContext funcCtx,
  String appId,
) async {
  LicenceItemPageItem result = LicenceItemPageItem(
    item: LicenceItem.fromJson('{}'),
    learnedFromLicencePerLevel: List.empty(),
  );

  Future<ResultWithValue<List<InventoryItem>>> allItemsFuture =
      getCombinedItems(funcCtx, const [LocaleKey.itemsJson]);

  ResultWithValue<LicenceItem> itemResult =
      await getLicenceRepo().getItem(funcCtx, appId);
  if (itemResult.isSuccess) {
    result.item = itemResult.value;
  }

  ResultWithValue<List<InventoryItem>> allItems = await allItemsFuture;
  if (allItems.isSuccess) {
    result.learnedFromLicencePerLevel =
        allItems.value.where((InventoryItem iItem) {
      // ignore: unnecessary_null_comparison
      if (iItem.craftable == null) return false;
      // ignore: unnecessary_null_comparison
      if (iItem.craftable.learnThroughLicence == false) return false;
      if (iItem.craftable.licenceAppId != itemResult.value.appId) return false;

      return true;
    }).toList();
  }

  return ResultWithValue(itemResult.isSuccess, result, '');
}
