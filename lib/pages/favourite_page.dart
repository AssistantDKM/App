import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/tilePreseneters/favourite_tile_presenter.dart';
import '../constants/analytics_event.dart';
import '../contracts/json/inventory_item.dart';
import '../contracts/redux/app_state.dart';
import '../helper/generic_repository_helper.dart';
import '../redux/favourite/favourite_viewmodel.dart';

class FavouritesPage extends StatelessWidget {
  FavouritesPage({Key? key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.favouritesPage);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(context,
        appBar: getBaseWidget().appBarForSubPage(
          context,
          title: Text(getTranslations().fromKey(LocaleKey.favourites)),
          showHomeAction: true,
        ),
        body: StoreConnector<AppState, FavouriteViewModel>(
          converter: (store) => FavouriteViewModel.fromStore(store),
          builder: (_, viewModel) => getBody(context, viewModel),
          // builder: (_, viewModel) => getRealBody(context, viewModel),
        ));
  }

  Widget getBody(BuildContext context, FavouriteViewModel viewModel) =>
      FutureBuilder<List<InventoryItem>>(
        future: favouritesFuture(context, viewModel),
        builder: (BuildContext context,
                AsyncSnapshot<List<InventoryItem>> snapshot) =>
            getRealBody(context, viewModel, snapshot),
      );

  Future<List<InventoryItem>> favouritesFuture(
      context, FavouriteViewModel viewModel) async {
    List<InventoryItem> reqItems = List.empty(growable: true);
    for (String favItem in viewModel.favourites) {
      var details = await getGenericRepoFromAppId(favItem).getItem(
        context,
        favItem,
      );
      if (details.isSuccess) reqItems.add(details.value);
    }
    return reqItems;
  }

  Widget getRealBody(
    BuildContext context,
    FavouriteViewModel viewModel,
    AsyncSnapshot<List<InventoryItem>> snapshot,
  ) {
    Widget? errorWidget = asyncSnapshotHandler(context, snapshot);
    if (errorWidget != null) return errorWidget;

    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return Center(
        child: Text(
          getTranslations().fromKey(LocaleKey.noItems),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 20),
        ),
      );
    }

    return SearchableList<InventoryItem>(
      getSearchListFutureFromList(
        snapshot.data!,
        compare: (a, b) => a.name.compareTo(b.name),
      ),
      listItemDisplayer: (
        BuildContext itemCtx,
        InventoryItem reqItem, {
        void Function()? onTap,
      }) {
        return favouriteTilePresenter(
          itemCtx,
          reqItem,
          onTap: onTap,
          onDelete: () => viewModel.removeFavourite(reqItem.appId),
        );
      },
      listItemSearch: (item, search) =>
          item.name.toLowerCase().contains(search.toLowerCase()),
      key: Key('numFavourites${snapshot.data!.length}'),
    );
  }
}
