import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/pageElements/item_list_page.dart';
import '../components/tilePreseneters/favourite_tile_presenter.dart';
import '../constants/analytics_event.dart';
import '../contracts/json/inventory_item.dart';
import '../contracts/redux/app_state.dart';
import '../helper/generic_repository_helper.dart';
import '../redux/favourite/favourite_viewmodel.dart';
import 'inventory_pages.dart';

class FavouritesPage extends StatelessWidget {
  FavouritesPage({Key? key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.favouritesPage);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FavouriteViewModel>(
      converter: (store) => FavouriteViewModel.fromStore(store),
      builder: (_, viewModel) => getRealBody(context, viewModel),
    );
  }

  Future<ResultWithValue<List<InventoryItem>>> favouritesFuture(
    context,
    FavouriteViewModel viewModel,
  ) async {
    List<InventoryItem> reqItems = List.empty(growable: true);
    for (String favItem in viewModel.favourites) {
      var details = await getGenericRepoFromAppId(favItem).getItem(
        context,
        favItem,
      );
      if (details.isSuccess) reqItems.add(details.value);
    }
    return ResultWithValue(true, reqItems, '');
  }

  Widget getRealBody(
    BuildContext context,
    FavouriteViewModel viewModel,
  ) {
    String title = getTranslations().fromKey(LocaleKey.favourites);

    return ItemsListPage<InventoryItem>(
      analyticsEvent: AnalyticsEvent.favouritesPage,
      title: title,
      getItemsFunc: () => favouritesFuture(context, viewModel),
      listItemDisplayer: (
        BuildContext itemCtx,
        InventoryItem reqItem,
        int num, {
        void Function()? onTap,
      }) {
        return favouriteTilePresenter(
          itemCtx,
          reqItem,
          viewModel.isPatron,
          onTap: onTap,
          onDelete: () => viewModel.removeFavourite(reqItem.appId),
        );
      },
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
