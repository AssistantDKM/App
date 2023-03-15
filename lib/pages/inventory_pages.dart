import 'package:assistant_dinkum_app/contracts/json/licence_item.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:collection/collection.dart';

import '../components/pageElements/inventory_page_content.dart';
import '../components/pageElements/item_details_page.dart';
import '../components/pageElements/item_list_page.dart';
import '../components/tilePresenters/inventory_tile_presenter.dart';
import '../contracts/json/inventory_item.dart';
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
    requiredLicence: null,
  );

  InventoryRepository service = getGenericRepoFromAppId(appId);
  var itemFuture = service.getItem(funcCtx, appId);
  var usagesFuture = service.getUsagesOfItem(funcCtx, appId);
  var licencesFuture = getLicenceRepo().getItems(funcCtx);

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

  return ResultWithValue(itemResult.isSuccess, result, '');
}
