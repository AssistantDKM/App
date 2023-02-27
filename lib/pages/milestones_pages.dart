import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/pageElements/item_page_components.dart';
import '../components/tilePresenters/item_base_tile_presenter.dart';
import '../components/tilePresenters/milestone_tile_presenter.dart';
import '../constants/app_misc.dart';
import '../contracts/json/milestone_item.dart';
import '../contracts/json/milestone_level.dart';
import '../helper/image_helper.dart';
import '../integration/dependency_injection.dart';

class MilestonesListPage extends StatelessWidget {
  final String analyticsEvent;
  final String title;

  MilestonesListPage({
    Key? key,
    required this.analyticsEvent,
    required this.title,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsEvent);
  }

  @override
  Widget build(BuildContext context) {
    return ItemsListPage<MilestoneItem>(
      analyticsEvent: analyticsEvent,
      title: title,
      getItemsFunc: () => getMilestoneRepo().getItems(context),
      listItemDisplayer: commonTilePresenter,
      detailPageFunc: (
        String id,
        bool isInDetailPane,
        void Function(Widget)? updateDetailView,
      ) {
        List<String> comboId = id.split(itemPageSplitMarker);
        return MilestoneDetailsPage(
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

class MilestoneDetailsPage extends StatelessWidget {
  final String itemId;
  final String title;
  final String appJson;
  final bool isInDetailPane;
  final void Function(Widget newDetailView)? updateDetailView;

  const MilestoneDetailsPage(
    this.itemId, {
    Key? key,
    required this.title,
    required this.appJson,
    this.isInDetailPane = false,
    this.updateDetailView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemDetailsPage<MilestoneItem>(
      title: title,
      isInDetailPane: isInDetailPane,
      getItemFunc: () => getMilestoneRepo().getItem(context, itemId),
      getName: (loadedItem) => loadedItem.name,
      contractToWidgetList: (loadedItem, isInDetailPane) {
        List<Widget> descripWidgets = [
          Center(
              child: LocalImage(
                  imagePath: networkImageToLocal(loadedItem.imageUrl))),
          GenericItemName(loadedItem.name),
          pageDefaultPadding(GenericItemDescription(loadedItem.description)),
        ];

        if (loadedItem.levels.isNotEmpty) {
          descripWidgets.add(const EmptySpace2x());
          descripWidgets.add(const GenericItemGroup('Levels'));
          for (MilestoneLevel level in loadedItem.levels) {
            descripWidgets.add(const EmptySpace1x());
            descripWidgets.add(
              FlatCard(
                child: milestoneLevelTilePresenter(
                  context,
                  level,
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
