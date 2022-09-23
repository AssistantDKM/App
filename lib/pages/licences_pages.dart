import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/pageElements/item_page_components.dart';
import '../components/tilePreseneters/item_base_tile_presenter.dart';
import '../components/tilePreseneters/licence_tile_presenter.dart';
import '../constants/app_misc.dart';
import '../contracts/json/licence_item.dart';
import '../contracts/json/licence_level_item.dart';
import '../helper/image_helper.dart';
import '../integration/dependency_injection.dart';

class LicencesListPage extends StatelessWidget {
  final String analyticsEvent;
  final String title;

  LicencesListPage({
    Key? key,
    required this.analyticsEvent,
    required this.title,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsEvent);
  }

  @override
  Widget build(BuildContext context) {
    return ItemsListPage<LicenceItem>(
      analyticsEvent: analyticsEvent,
      title: title,
      getItemsFunc: () => getLicenceRepo().getItems(context),
      listItemDisplayer: itemBaseTilePresenter,
      detailPageFunc: (
        String id,
        bool isInDetailPane,
        void Function(Widget)? updateDetailView,
      ) {
        List<String> comboId = id.split(itemPageSplitMarker);
        return LicenceDetailsPage(
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

class LicenceDetailsPage extends StatelessWidget {
  final String itemId;
  final String title;
  final String appJson;
  final bool isInDetailPane;
  final void Function(Widget newDetailView)? updateDetailView;

  const LicenceDetailsPage(
    this.itemId, {
    Key? key,
    required this.title,
    required this.appJson,
    this.isInDetailPane = false,
    this.updateDetailView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemDetailsPage<LicenceItem>(
      title: title,
      isInDetailPane: isInDetailPane,
      getItemFunc: () => getLicenceRepo().getItem(context, itemId),
      getName: (loadedItem) => loadedItem.name,
      contractToWidgetList: (loadedItem) {
        List<Widget> descripWidgets = [
          Center(child: localImage(networkImageToLocal(loadedItem.imageUrl))),
          genericItemName(loadedItem.name),
          pageDefaultPadding(genericItemDescription(loadedItem.description)),
        ];

        if (loadedItem.levels.isNotEmpty) {
          descripWidgets.add(emptySpace2x());
          descripWidgets.add(genericItemGroup('Levels'));

          bool enableLeading =
              loadedItem.levels.any((lvl) => lvl.skillLevel > 0);
          for (LicenceLevel level in loadedItem.levels) {
            descripWidgets.add(emptySpace1x());
            descripWidgets.add(
              flatCard(
                child: licenceLevelTilePresenter(
                  context,
                  level,
                  !enableLeading,
                  0,
                ),
              ),
            );
          }
        }

        return descripWidgets;
      },
    );
  }
}
