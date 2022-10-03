import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/pageElements/inventory_page_content.dart';
import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/tilePreseneters/item_base_tile_presenter.dart';
import '../contracts/json/inventory_item.dart';
import '../contracts/redux/app_state.dart';
import '../helper/generic_repository_helper.dart';
import '../integration/dependency_injection.dart';
import '../redux/setting/setting_viewmodel.dart';

class InventoryListPage extends StatelessWidget {
  final String analyticsEvent;
  final List<String> appJsons;
  final String title;

  InventoryListPage({
    Key? key,
    required this.analyticsEvent,
    required this.appJsons,
    required this.title,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsEvent);
  }

  @override
  Widget build(BuildContext context) {
    return ItemsListPage<InventoryItem>(
      analyticsEvent: analyticsEvent,
      title: title,
      getItemsFunc: () => getCombinedItems(context, appJsons),
      listItemDisplayer: itemBaseTilePresenter,
      detailPageFunc: (
        String appId,
        bool isInDetailPane,
        void Function(Widget)? updateDetailView,
      ) {
        return InventoryDetailsPage(
          appId,
          title: title,
          isInDetailPane: isInDetailPane,
          updateDetailView: updateDetailView,
        );
      },
    );
  }
}

class InventoryDetailsPage extends StatelessWidget {
  final String appId;
  final String title;
  final bool isInDetailPane;
  final void Function(Widget newDetailView)? updateDetailView;

  const InventoryDetailsPage(
    this.appId, {
    Key? key,
    required this.title,
    this.isInDetailPane = false,
    this.updateDetailView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getLog().d(appId);
    return StoreConnector<AppState, SettingViewModel>(
      converter: (store) => SettingViewModel.fromStore(store),
      builder: (redxContext, viewModel) => ItemDetailsPage<InventoryItem>(
        title: title,
        isInDetailPane: isInDetailPane,
        getItemFunc: () => getGenericRepoFromAppId(appId).getItem(
          context,
          appId,
        ),
        getName: (loadedItem) => loadedItem.name,
        contractToWidgetList: (loadedItem) => commonInventoryContents(
          redxContext,
          loadedItem,
        ),
      ),
    );
  }
}

Future<ResultWithValue<List<InventoryItem>>> getCombinedItems(
    BuildContext funcCtx, List<String> appJsons) async {
  List<InventoryItem> result = List.empty(growable: true);

  for (String appJson in appJsons) {
    ResultWithValue<List<InventoryItem>> genericRepoResult =
        await getInventoryRepo(appJson).getItems(funcCtx);
    if (genericRepoResult.isSuccess) {
      result.addAll(genericRepoResult.value);
    }
  }

  result.sort(((a, b) => a.name.compareTo(b.name)));

  return ResultWithValue(result.isNotEmpty, result, '');
}
