import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/pageElements/item_page_components.dart';
import '../components/tilePreseneters/crafting_tile_presenter.dart';
import '../constants/app_colour.dart';
import '../constants/app_image.dart';
import '../constants/app_misc.dart';
import '../contracts/json/crafting_item.dart';
import '../integration/dependency_injection.dart';

class CraftingListPage extends StatelessWidget {
  final String analyticsEvent;
  final List<String> appJsons;
  final String title;

  CraftingListPage({
    Key? key,
    required this.analyticsEvent,
    required this.appJsons,
    required this.title,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsEvent);
  }

  @override
  Widget build(BuildContext context) {
    return ItemsListPage<CraftingItem>(
      analyticsEvent: analyticsEvent,
      title: title,
      getItemsFunc: () => getCombinedCraftingItems(context, appJsons),
      listItemDisplayer: craftingTilePresenter,
      detailPageFunc: (
        String id,
        bool isInDetailPane,
        void Function(Widget)? updateDetailView,
      ) {
        List<String> comboId = id.split(itemPageSplitMarker);
        return FoodDetailsPage(
          comboId.last,
          title: title,
          appJson: comboId.first,
          isInDetailPane: isInDetailPane,
          updateDetailView: updateDetailView,
        );
      },
    );
  }
}

class FoodDetailsPage extends StatelessWidget {
  final String itemId;
  final String title;
  final String appJson;
  final bool isInDetailPane;
  final void Function(Widget newDetailView)? updateDetailView;

  const FoodDetailsPage(
    this.itemId, {
    Key? key,
    required this.title,
    required this.appJson,
    this.isInDetailPane = false,
    this.updateDetailView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemDetailsPage<CraftingItem>(
      title: title,
      isInDetailPane: isInDetailPane,
      getItemFunc: () => getCraftingRepo(appJson).getItem(context, itemId),
      getName: (loadedItem) => loadedItem.name,
      contractToWidgetList: (loadedItem) {
        List<Widget> descripWidgets = [
          Center(child: networkImage(loadedItem.imageUrl)),
          genericItemName(loadedItem.name),
          pageDefaultPadding(genericItemDescription(loadedItem.description)),
          Chip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                emptySpace1x(),
                Text(loadedItem.sellPrice.toString()),
                localImage(AppImage.coin, width: 32, height: 32),
              ],
            ),
            backgroundColor: AppColour.moneyTagColour,
          ),
        ];

//effects

        // if (loadedItem.habitats.isNotEmpty) {
        //   descripWidgets.addAll(loadSections(
        //     'Habitats',
        //     loadedItem.habitats
        //         .map((habitat) => habitatValues.reverse[habitat] ?? '')
        //         .where((element) => element.isNotEmpty)
        //         .toList(),
        //   ));
        // }

        return descripWidgets;
      },
    );
  }
}

Future<ResultWithValue<List<CraftingItem>>> getCombinedCraftingItems(
    BuildContext funcCtx, List<String> appJsons) async {
  List<CraftingItem> result = List.empty(growable: true);

  for (String appJson in appJsons) {
    ResultWithValue<List<CraftingItem>> genericRepoResult =
        await getCraftingRepo(appJson).getItems(funcCtx);
    if (genericRepoResult.isSuccess) {
      result.addAll(genericRepoResult.value.map((food) {
        food.itemId = '$appJson$itemPageSplitMarker${food.id}';
        return food;
      }));
    }
  }

  result.sort(((a, b) => a.name.compareTo(b.name)));

  return ResultWithValue(result.isNotEmpty, result, '');
}
