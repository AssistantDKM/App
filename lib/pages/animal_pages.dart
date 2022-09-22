import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/tilePreseneters/animal_tile_presenter.dart';
import '../constants/app_colour.dart';
import '../constants/app_image.dart';
import '../contracts/json/animal_item.dart';
import '../contracts/json/enum/habitat.dart';
import '../contracts/json/enum/season.dart';
import '../contracts/json/enum/time.dart';
import '../integration/dependency_injection.dart';

class AnimalsListPage extends StatelessWidget {
  final String analyticsEvent;
  final List<String> appJsons;
  final String title;

  AnimalsListPage({
    Key? key,
    required this.analyticsEvent,
    required this.appJsons,
    required this.title,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsEvent);
  }

  @override
  Widget build(BuildContext context) {
    return ItemsListPage<AnimalItem>(
      analyticsEvent: analyticsEvent,
      title: title,
      getItemsFunc: () => getCombinedAnimalItems(context, appJsons),
      listItemDisplayer: animalTilePresenter,
      listItemSearch: (bugItem, search) => true,
      detailPageFunc: (
        String id,
        bool isInDetailPane,
        void Function(Widget)? updateDetailView,
      ) {
        List<String> comboId = id.split('-');
        return AnimalDetailsPage(
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

class AnimalDetailsPage extends StatelessWidget {
  final String itemId;
  final String title;
  final String appJson;
  final bool isInDetailPane;
  final void Function(Widget newDetailView)? updateDetailView;

  const AnimalDetailsPage(
    this.itemId, {
    Key? key,
    required this.title,
    required this.appJson,
    this.isInDetailPane = false,
    this.updateDetailView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemDetailsPage<AnimalItem>(
      title: title,
      getItemFunc: () => getGenericRepo(appJson).getAnimalItem(context, itemId),
      getName: (loadedItem) => loadedItem.name,
      contractToWidgetList: (loadedItem) {
        List<Widget> descripWidgets = [
          Center(child: networkImage(loadedItem.imageUrl)),
          genericItemName(loadedItem.name),
          genericItemDescription(loadedItem.description),
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

        if (loadedItem.habitats.isNotEmpty) {
          descripWidgets.addAll(loadSections(
            'Habitats',
            loadedItem.habitats
                .map((habitat) => habitatValues.reverse[habitat] ?? '')
                .where((element) => element.isNotEmpty)
                .toList(),
          ));
        }

        if (loadedItem.availability.seasons.isNotEmpty) {
          descripWidgets.addAll(loadSections(
            'Seasons',
            loadedItem.availability.seasons
                .map((season) => seasonValues.reverse[season] ?? '')
                .where((element) => element.isNotEmpty)
                .toList(),
          ));
        }

        if (loadedItem.availability.times.isNotEmpty) {
          descripWidgets.addAll(loadSections(
            'Times',
            loadedItem.availability.times
                .map((time) => timeValues.reverse[time] ?? '')
                .where((element) => element.isNotEmpty)
                .toList(),
          ));
        }

        return descripWidgets;
      },
    );
  }

  Widget chipFromString(String label) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Chip(
          label: genericItemDescription(label),
          backgroundColor: AppColour.defaultTagColour,
        ),
      );

  List<Widget> loadSections(String sectionName, List<String> items) => [
        emptySpace2x(),
        genericItemGroup(sectionName),
        flatCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: items.map((item) => chipFromString(item)).toList(),
            ),
          ),
        ),
      ];
}

Future<ResultWithValue<List<AnimalItem>>> getCombinedAnimalItems(
    BuildContext funcCtx, List<String> appJsons) async {
  List<AnimalItem> result = List.empty(growable: true);

  for (String appJson in appJsons) {
    ResultWithValue<List<AnimalItem>> genericRepoResult =
        await getGenericRepo(appJson).getAnimalItems(funcCtx);
    if (genericRepoResult.isSuccess) {
      result.addAll(genericRepoResult.value.map((animal) {
        animal.itemId = '$appJson-${animal.id}';
        return animal;
      }));
    }
  }

  result.sort(((a, b) => a.name.compareTo(b.name)));

  return ResultWithValue(result.isNotEmpty, result, '');
}
