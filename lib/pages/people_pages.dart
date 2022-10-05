import 'package:assistant_dinkum_app/constants/app_image.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/pageElements/item_page_components.dart';
import '../components/tilePreseneters/deed_requirements_tile_presenter.dart';
import '../components/tilePreseneters/people_tile_presenter.dart';
import '../components/tilePreseneters/required_item_tile_presenter.dart';
import '../constants/app_misc.dart';
import '../contracts/json/inventory_item_craftable_required.dart';
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
                maxWidth: (deviceWidth / 2),
                maxHeight: (deviceHeight / 2),
              ),
              child: localImage(imagePath),
            ),
          ),
          genericItemName(loadedItem.name),
        ];

        if (loadedItem.spendBeforeMoveIn > 0 &&
            loadedItem.relationshipBeforeMove > 0 &&
            loadedItem.relationshipBeforeMove < 200) {
          descripWidgets.addAll([
            emptySpace2x(),
            genericItemGroup('Requirements for deed'),
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

        if (loadedItem.favouriteFood.isNotEmpty) {
          descripWidgets.addAll([
            emptySpace2x(),
            genericItemGroup('Favourite Food'),
            flatCard(
              child: requiredItemTilePresenter(
                context,
                InventoryItemCraftableRequired(
                  appId: loadedItem.favouriteFood,
                  quantity: 0,
                ),
              ),
            ),
          ]);
        }

        // if (loadedItem.dislikes.isNotEmpty) {
        //   descripWidgets.addAll(loadSections(
        //     'Dislikes',
        //     loadedItem.dislikes.where((element) => element.isNotEmpty).toList(),
        //   ));
        // }

        return descripWidgets;
      },
    );
  }
}
