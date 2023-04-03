import 'package:assistant_dinkum_app/contracts/json/enum/usage_key.dart';
import 'package:assistant_dinkum_app/contracts/json/item_change.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/pageElements/inventory_page_content.dart';
import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/tilePresenters/inventory_tile_presenter.dart';
import '../constants/app_json.dart';
import '../contracts/data/game_update.dart';
import '../contracts/json/inventory_item.dart';
import '../contracts/json/licence_item.dart';
import '../contracts/pageItem/inventory_page_item.dart';
import '../contracts/redux/app_state.dart';
import '../helper/future_helper.dart';
import '../helper/generic_repository_helper.dart';
import '../integration/dependency_injection.dart';
import '../redux/misc/inventory_item_viewmodel.dart';
import '../services/json/inventory_repository.dart';

class InventoryListPage extends StatelessWidget {
  final String analyticsEvent;
  final List<LocaleKey> appJsons;
  final bool displayMuseumStatus;
  final String title;

  InventoryListPage({
    Key? key,
    required this.analyticsEvent,
    required this.appJsons,
    required this.displayMuseumStatus,
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
          listItemDisplayer: inventoryTilePresenter(
            isPatron: viewModel.isPatron,
            displayMuseumStatus: displayMuseumStatus,
            donations: viewModel.donations,
          ),
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
      builder: (storeCtx, viewModel) => ItemDetailsPage<InventoryPageItem>(
        key: Key('item-details-$appId-cart[]-${viewModel.cartItems.length}'),
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
        ),
        floatingActionButton: getFloatingActionButton(
          fabCtx: storeCtx,
          appId: appId,
          viewModel: viewModel,
        ),
      ),
    );
  }
}

Future<ResultWithValue<InventoryPageItem>> getPageItem(
  BuildContext funcCtx,
  String appId,
) async {
  InventoryPageItem result = InventoryPageItem(
    item: InventoryItem.fromJson('{}'),
    usages: List.empty(),
    itemChangesUsing: List.empty(),
    itemChangesFrom: List.empty(),
    itemChangesForTool: List.empty(),
    requiredLicence: null,
    fromUpdate: null,
  );

  // print(getLookupRepo().getItemUsages(appId));

  emptyListFuture<T>() =>
      Future.value(ResultWithValue<List<T>>(false, List.empty(), ''));

  var itemsFuture = getAllGameItems(funcCtx);

  var itemChangesUsingFuture =
      getLookupRepo().itemHasUsage(appId, UsageKey.hasItemChange)
          ? getDataRepo().getItemChangesUsing(funcCtx, appId)
          : emptyListFuture<ItemChange>();
  var itemChangesFromFuture =
      getLookupRepo().itemHasUsage(appId, UsageKey.hasFromItemChange)
          ? getDataRepo().getItemChangesOutputting(funcCtx, appId)
          : emptyListFuture<ItemChange>();
  var itemChangesForToolFuture =
      getLookupRepo().itemHasUsage(appId, UsageKey.changesItems)
          ? getDataRepo().getItemChangesForTool(funcCtx, appId)
          : emptyListFuture<ItemChange>();

  var licencesFuture =
      getLookupRepo().itemHasUsage(appId, UsageKey.requiresLicence)
          ? getLicenceRepo().getItems(funcCtx)
          : emptyListFuture<LicenceItem>();

  var gameUpdateFuture =
      getLookupRepo().itemHasUsage(appId, UsageKey.requiresLicence)
          ? getDataRepo().getGameUpdateThatItemWasAddedIn(funcCtx, appId)
          : Future.value(
              ResultWithValue<GameUpdate>(false, GameUpdate.initial(), ''));

  bool hasUsedToCreate =
      getLookupRepo().itemHasUsage(appId, UsageKey.hasUsedToCreate);

  List<InventoryItem> allItems = await itemsFuture;
  List<InventoryItem> usages = List.empty(growable: true);

  for (InventoryItem item in allItems) {
    if (item.appId == appId) {
      result.item = item;
    }

    bool createsCurrentItem =
        InventoryRepository.getUsagesOfItemFilter(item, appId);
    if (hasUsedToCreate && createsCurrentItem) {
      usages.add(item);
    }
  }
  result.usages = usages;

  if (result.item.craftable.licenceAppId.isNotEmpty) {
    ResultWithValue<List<LicenceItem>> licencesResult = await licencesFuture;
    if (licencesResult.isSuccess) {
      var requiredLicence = licencesResult.value.firstWhereOrNull(
        (licence) => licence.appId == result.item.craftable.licenceAppId,
      );
      if (requiredLicence != null) {
        result.requiredLicence = requiredLicence;
      }
    }
  }

  ResultWithValue<GameUpdate> gameUpdateResult = await gameUpdateFuture;
  if (gameUpdateResult.isSuccess) {
    result.fromUpdate = gameUpdateResult.value;
  }

  var itemChangesUsingResult = await itemChangesUsingFuture;
  if (itemChangesUsingResult.isSuccess) {
    var itemChangeResult = getItemChangesPageData(
      itemChangesUsingResult.value,
      allItems,
    );
    result.itemChangesUsing = itemChangeResult.isSuccess //
        ? itemChangeResult.value
        : List.empty();
  }

  var itemChangesFromResult = await itemChangesFromFuture;
  if (itemChangesFromResult.isSuccess) {
    var itemChangeResult = getItemChangesPageData(
      itemChangesFromResult.value,
      allItems,
    );
    result.itemChangesFrom = itemChangeResult.isSuccess //
        ? itemChangeResult.value
        : List.empty();
  }

  var itemChangesForToolResult = await itemChangesForToolFuture;
  if (itemChangesForToolResult.isSuccess) {
    var itemChangeResult = getItemChangesPageData(
      itemChangesForToolResult.value,
      allItems,
    );
    result.itemChangesForTool = itemChangeResult.isSuccess //
        ? itemChangeResult.value
        : List.empty();
  }

  return ResultWithValue(true, result, '');
}

Widget? getFloatingActionButton({
  required BuildContext fabCtx,
  required String appId,
  required InventoryItemViewModel viewModel,
}) {
  if (appId.contains('${AppJsonPrefix.item}_') == false) {
    return null;
  }

  return FloatingActionButton(
    child: const Icon(Icons.shopping_basket),
    onPressed: () => getDialog().showQuantityDialog(
      fabCtx,
      TextEditingController(),
      onSuccess: (BuildContext ctx, String quantity) {
        int? intQuantity = int.tryParse(quantity);
        if (intQuantity == null) return;
        viewModel.addToCart(appId, intQuantity);
      },
    ),
  );
}
