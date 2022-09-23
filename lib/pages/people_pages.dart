import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/pageElements/item_page_components.dart';
import '../components/tilePreseneters/people_tile_presenter.dart';
import '../constants/app_misc.dart';
import '../contracts/json/people_item.dart';
import '../integration/dependency_injection.dart';

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
    return ItemsListPage<PeopleItem>(
      analyticsEvent: analyticsEvent,
      title: title,
      getItemsFunc: () => getPeopleRepo().getItems(context),
      listItemDisplayer: peopleTilePresenter,
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
    return ItemDetailsPage<PeopleItem>(
      title: title,
      isInDetailPane: isInDetailPane,
      getItemFunc: () => getPeopleRepo().getItem(context, itemId),
      getName: (loadedItem) => loadedItem.name,
      contractToWidgetList: (loadedItem) {
        List<Widget> descripWidgets = [
          Center(child: networkImage(loadedItem.imageUrl)),
          genericItemName(loadedItem.name),
          pageDefaultPadding(genericItemDescription(loadedItem.occupation)),
          pageDefaultPadding(genericItemDescription(loadedItem.building)),
        ];

        descripWidgets.addAll(loadSections(
          'Favourite Food',
          [loadedItem.favouriteFood],
        ));

        if (loadedItem.dislikes.isNotEmpty) {
          descripWidgets.addAll(loadSections(
            'Dislikes',
            loadedItem.dislikes.where((element) => element.isNotEmpty).toList(),
          ));
        }

        return descripWidgets;
      },
    );
  }
}
