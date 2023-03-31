import 'package:assistant_dinkum_app/contracts/data/game_update.dart';
import 'package:assistant_dinkum_app/contracts/json/licence_item.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/pageElements/inventory_page_content.dart';
import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/tilePresenters/inventory_tile_presenter.dart';
import '../constants/app_json.dart';
import '../contracts/json/inventory_item.dart';
import '../contracts/json/inventory_item_change.dart';
import '../contracts/pageItem/inventory_item_change_page_item.dart';
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
    itemChangeDetails: List.empty(),
    requiredLicence: null,
    fromUpdate: null,
  );

  InventoryRepository? service = getGenericRepoFromAppId(appId);
  if (service == null) {
    return ResultWithValue(false, result, 'getGenericRepoFromAppId');
  }

  var itemFuture = service.getItem(funcCtx, appId);
  var usagesFuture = service.getUsagesOfItem(funcCtx, appId);
  var licencesFuture = getLicenceRepo().getItems(funcCtx);
  var gameUpdateFuture = getDataRepo().getGameUpdateThatItemWasAddedIn(
    funcCtx,
    appId,
  );

  ResultWithValue<InventoryItem> itemResult = await itemFuture;
  if (itemResult.isSuccess) {
    result.item = itemResult.value;

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
  }

  ResultWithValue<List<InventoryItem>> usagesResult = await usagesFuture;
  if (itemResult.isSuccess) {
    result.usages = usagesResult.value;
  }

  ResultWithValue<GameUpdate> gameUpdateResult = await gameUpdateFuture;
  if (gameUpdateResult.isSuccess) {
    result.fromUpdate = gameUpdateResult.value;
  }

  try {
    // ignore: use_build_context_synchronously
    var itemChangeDetails = await getItemChangePageData(
      funcCtx,
      result.item.itemChanges,
    );
    if (itemChangeDetails.isSuccess) {
      result.itemChangeDetails = itemChangeDetails.value;
    }
  } catch (ex) {
    getLog().d(ex.toString());
  }

  return ResultWithValue(itemResult.isSuccess, result, '');
}

Future<ResultWithValue<List<InventoryItemChangePageItem>>>
    getItemChangePageData(
  BuildContext funcCtx,
  List<InventoryItemChange>? itemChanges,
) async {
  if (itemChanges == null) {
    return ResultWithValue<List<InventoryItemChangePageItem>>(
      false,
      List.empty(),
      '',
    );
  }

  List<InventoryItemChangePageItem> itemChangePageDatas =
      List.empty(growable: true);
  for (var itemChange in itemChanges) {
    var itemDetailsFuture = getItemFromGenericRepoUsingAppId(
      funcCtx,
      itemChange.item.appId,
    );
    var outputDetailsFuture = getItemFromGenericRepoUsingAppId(
      funcCtx,
      itemChange.output.appId,
    );

    List<Future<ResultWithValue<InventoryItem>>> outputTableFutures =
        List.empty(growable: true);
    for (var outputTableRow in itemChange.outputTable) {
      outputTableFutures.add(getItemFromGenericRepoUsingAppId(
        funcCtx,
        outputTableRow.appId,
      ));
    }

    var itemDetailsResult = await itemDetailsFuture;
    var outputDetailsResult = await outputDetailsFuture;
    var outputTableResults = await Future.wait(outputTableFutures);

    itemChangePageDatas.add(InventoryItemChangePageItem(
      itemDetails: itemDetailsResult.value,
      outputDetails: outputDetailsResult.isSuccess //
          ? outputDetailsResult.value
          : null,
      outputTableDetails: outputTableResults.map((outT) => outT.value).toList(),
    ));
  }

  return ResultWithValue<List<InventoryItemChangePageItem>>(
    itemChangePageDatas.isNotEmpty,
    itemChangePageDatas,
    '',
  );
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
