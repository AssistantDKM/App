import 'dart:math';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/tilePreseneters/deed_requirements_tile_presenter.dart';
import '../components/tilePreseneters/food_preference_tile_presenter.dart';
import '../components/tilePreseneters/people_tile_presenter.dart';
import '../constants/app_image.dart';
import '../constants/app_misc.dart';
import '../contracts/json/people_item.dart';
import '../contracts/redux/app_state.dart';
import '../integration/dependency_injection.dart';
import '../redux/misc/inventory_item_viewmodel.dart';

class PeopleListPage extends StatelessWidget {
  final String analyticsEvent;
  final String title;

  PeopleListPage({
    Key? key,
    required this.analyticsEvent,
    required this.title,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsEvent);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InventoryItemViewModel>(
      converter: (store) => InventoryItemViewModel.fromStore(store),
      builder: (_, viewModel) {
        return ItemsListPage<PeopleItem>(
          analyticsEvent: analyticsEvent,
          title: title,
          getItemsFunc: () => getPeopleRepo().getItems(context),
          listItemDisplayer: peopleTilePresenter(viewModel.isPatron),
          detailPageFunc: (
            String id,
            bool isInDetailPane,
            void Function(Widget)? updateDetailView,
          ) {
            List<String> comboId = id.split(itemPageSplitMarker);
            return PeopleDetailsPage(
              comboId.last,
              title: title,
              appJson: comboId.first,
              isInDetailPane: isInDetailPane,
              updateDetailView: updateDetailView,
            );
          },
        );
      },
    );
  }
}

class PeopleDetailsPage extends StatelessWidget {
  final String itemId;
  final String title;
  final String appJson;
  final bool isInDetailPane;
  final void Function(Widget newDetailView)? updateDetailView;

  const PeopleDetailsPage(
    this.itemId, {
    Key? key,
    required this.title,
    required this.appJson,
    this.isInDetailPane = false,
    this.updateDetailView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double maxImageSize = 200;

    return ItemDetailsPage<PeopleItem>(
      title: title,
      isInDetailPane: isInDetailPane,
      getItemFunc: () => getPeopleRepo().getItem(context, itemId),
      getName: (loadedItem) => loadedItem.name,
      contractToWidgetList: (loadedItem, isInDetailPane) {
        String imagePath = loadedItem.icon.isEmpty //
            ? AppImage.unknown
            : loadedItem.icon;
        List<Widget> descripWidgets = [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: min((deviceWidth / 2), maxImageSize),
                maxHeight: min((deviceHeight / 2), maxImageSize),
              ),
              child: localImage(imagePath),
            ),
          ),
          genericItemName(loadedItem.name),
        ];

        bool hasReqSpend = loadedItem.spendBeforeMoveIn > 0;
        bool hasReqRel = loadedItem.relationshipBeforeMove > 0;
        bool hasReqValidRel = loadedItem.relationshipBeforeMove < 200;
        if (hasReqSpend && hasReqRel && hasReqValidRel) {
          descripWidgets.addAll([
            emptySpace2x(),
            genericItemGroup(
              getTranslations().fromKey(LocaleKey.requiredForDeed),
            ),
            flatCard(
              child: deedRequirementsTilePresenter(
                context,
                loadedItem.deed,
                loadedItem.spendBeforeMoveIn,
                loadedItem.relationshipBeforeMove,
              ),
            ),
          ]);
        }

        if (loadedItem.favouriteFood.isNotEmpty ||
            loadedItem.hatedFood.isNotEmpty) {
          descripWidgets.addAll([
            emptySpace2x(),
            genericItemGroup(
              getTranslations().fromKey(LocaleKey.foodPreferences),
            ),
          ]);

          if (loadedItem.favouriteFood.isNotEmpty) {
            descripWidgets.addAll([
              flatCard(
                child: foodPreferenceTilePresenter(
                  context,
                  appId: loadedItem.favouriteFood,
                  subtitle: getTranslations().fromKey(LocaleKey.favourite),
                  trailing: AppImage.relationshipPlus,
                ),
              ),
            ]);
          }
          if (loadedItem.hatedFood.isNotEmpty) {
            descripWidgets.addAll([
              flatCard(
                child: foodPreferenceTilePresenter(
                  context,
                  appId: loadedItem.hatedFood,
                  subtitle: getTranslations().fromKey(LocaleKey.hated),
                  trailing: AppImage.relationshipMinus,
                ),
              ),
            ]);
          }

          double tableSize = 64;
          descripWidgets.addAll([
            flatCard(
              child: Column(
                children: [
                  customDivider(),
                  emptySpace1x(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          localImage(AppImage.animalProduct, width: tableSize),
                          emptySpace1x(),
                          localImage(
                            loadedItem.hatesAnimalProducts
                                ? AppImage.preferenceDislikes
                                : AppImage.preferenceNothing,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          localImage(AppImage.vegetable, width: tableSize),
                          emptySpace1x(),
                          localImage(
                            loadedItem.hatesVegetables
                                ? AppImage.preferenceDislikes
                                : AppImage.preferenceNothing,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          localImage(AppImage.fruit, width: tableSize),
                          emptySpace1x(),
                          localImage(
                            loadedItem.hatesFruits
                                ? AppImage.preferenceDislikes
                                : AppImage.preferenceNothing,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          localImage(AppImage.meat, width: tableSize),
                          emptySpace1x(),
                          localImage(
                            loadedItem.hatesMeat
                                ? AppImage.preferenceDislikes
                                : AppImage.preferenceNothing,
                          ),
                        ],
                      ),
                    ],
                  ),
                  emptySpace3x(),
                ],
              ),
            ),
          ]);
        }

        return descripWidgets;
      },
    );
  }
}
