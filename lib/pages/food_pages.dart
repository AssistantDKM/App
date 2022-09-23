import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/chip/effect_chip_presenter.dart';
import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/pageElements/item_page_components.dart';
import '../components/tilePreseneters/item_base_tile_presenter.dart';
import '../components/tilePreseneters/required_item_tile_presenter.dart';
import '../constants/app_colour.dart';
import '../constants/app_image.dart';
import '../constants/app_misc.dart';
import '../contracts/json/food_item.dart';
import '../contracts/json/required_item.dart';
import '../helper/image_helper.dart';
import '../integration/dependency_injection.dart';

class FoodListPage extends StatelessWidget {
  final String analyticsEvent;
  final List<String> appJsons;
  final String title;

  FoodListPage({
    Key? key,
    required this.analyticsEvent,
    required this.appJsons,
    required this.title,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsEvent);
  }

  @override
  Widget build(BuildContext context) {
    return ItemsListPage<FoodItem>(
      analyticsEvent: analyticsEvent,
      title: title,
      getItemsFunc: () => getCombinedFoodItems(context, appJsons),
      listItemDisplayer: itemBaseTilePresenter,
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
    return ItemDetailsPage<FoodItem>(
      title: title,
      isInDetailPane: isInDetailPane,
      getItemFunc: () => getFoodRepo(appJson).getItem(context, itemId),
      getName: (loadedItem) => loadedItem.name,
      contractToWidgetList: (loadedItem) {
        List<Widget> descripWidgets = [
          Center(child: localImage(networkImageToLocal(loadedItem.imageUrl))),
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

        if (loadedItem.effects.isNotEmpty) {
          descripWidgets.add(emptySpace2x());
          descripWidgets.add(genericItemGroup('Effects'));
          descripWidgets.add(flatCard(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: loadedItem.effects
                    .map((item) => effectChipPresenter(context, item))
                    .toList(),
              ),
            ),
          ));
        }

        if (loadedItem.materials.isNotEmpty) {
          descripWidgets.add(emptySpace2x());
          descripWidgets.add(genericItemGroup('Required Items'));
          for (RequiredItem material in loadedItem.materials) {
            descripWidgets.add(
              flatCard(child: requiredItemTilePresenter(context, material, 0)),
            );
          }
        }

        return descripWidgets;
      },
    );
  }
}

Future<ResultWithValue<List<FoodItem>>> getCombinedFoodItems(
    BuildContext funcCtx, List<String> appJsons) async {
  List<FoodItem> result = List.empty(growable: true);

  for (String appJson in appJsons) {
    ResultWithValue<List<FoodItem>> genericRepoResult =
        await getFoodRepo(appJson).getItems(funcCtx);
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
