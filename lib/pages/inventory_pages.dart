import 'package:assistant_dinkum_app/services/json/inventory_repository.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/pageElements/inventory_page_content.dart';
import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/tilePresenters/inventory_tile_presenter.dart';
import '../contracts/json/inventory_item.dart';
import '../contracts/pageItem/inventory_page_item.dart';
import '../contracts/redux/app_state.dart';
import '../helper/generic_repository_helper.dart';
import '../integration/dependency_injection.dart';
import '../redux/misc/inventory_item_viewmodel.dart';

class InventoryListPage extends StatelessWidget {
  final String analyticsEvent;
  final List<LocaleKey> appJsons;
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
    return StoreConnector<AppState, InventoryItemViewModel>(
      converter: (store) => InventoryItemViewModel.fromStore(store),
      builder: (_, viewModel) {
        return ItemsListPage<InventoryItem>(
          analyticsEvent: analyticsEvent,
          title: title,
          getItemsFunc: () => getCombinedItems(context, appJsons),
          listItemDisplayer: inventoryTilePresenter(viewModel.isPatron),
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
    return StoreConnector<AppState, InventoryItemViewModel>(
      converter: (store) => InventoryItemViewModel.fromStore(store),
      builder: (_, viewModel) => ItemDetailsPage<InventoryPageItem>(
        title: title,
        isInDetailPane: isInDetailPane,
        getItemFunc: () => getPageItem(
          context,
          appId,
        ),
        getName: (loadedItem) => loadedItem.item.name,
        contractToWidgetList: commonInventoryContents(
          context,
          viewModel,
          updateDetailView,
          (BuildContext newCtx, String reqItemId, String reqItemTitle) =>
              getNavigation().navigateAwayFromHomeAsync(
            newCtx,
            navigateTo: (BuildContext localNewCtx) => InventoryDetailsPage(
              reqItemId,
              title: reqItemTitle,
              isInDetailPane: isInDetailPane,
              updateDetailView: updateDetailView,
            ),
          ),
        ),
      ),
    );
  }
}

Future<ResultWithValue<List<InventoryItem>>> getCombinedItems(
    BuildContext funcCtx, List<LocaleKey> appJsons) async {
  List<InventoryItem> result = List.empty(growable: true);

  for (LocaleKey appJson in appJsons) {
    ResultWithValue<List<InventoryItem>> genericRepoResult =
        await getInventoryRepo(appJson).getItems(funcCtx);
    if (genericRepoResult.isSuccess) {
      result.addAll(genericRepoResult.value);
    }
  }

  result.sort(((a, b) => a.name.compareTo(b.name)));

  return ResultWithValue(result.isNotEmpty, result, '');
}

Future<ResultWithValue<InventoryPageItem>> getPageItem(
  BuildContext funcCtx,
  String appId,
) async {
  InventoryPageItem result = InventoryPageItem(
    item: InventoryItem.fromJson('{}'),
    usages: List.empty(),
  );

  InventoryRepository service = getGenericRepoFromAppId(appId);
  var itemFuture = service.getItem(funcCtx, appId);
  var usagesFuture = service.getUsagesOfItem(funcCtx, appId);

  ResultWithValue<InventoryItem> itemResult = await itemFuture;
  if (itemResult.isSuccess) {
    result.item = itemResult.value;
  }

  ResultWithValue<List<InventoryItem>> usagesResult = await usagesFuture;
  if (itemResult.isSuccess) {
    result.usages = usagesResult.value;
  }

  return ResultWithValue(itemResult.isSuccess, result, '');
}
