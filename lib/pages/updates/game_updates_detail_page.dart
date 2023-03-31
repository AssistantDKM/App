import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../components/scaffoldTemplates/generic_page_scaffold.dart';
import '../../components/tilePresenters/inventory_tile_presenter.dart';
import '../../contracts/data/game_update.dart';
import '../../contracts/json/inventory_item.dart';
import '../../contracts/redux/app_state.dart';
import '../../contracts/required_item.dart';
import '../../helper/generic_repository_helper.dart';
import '../../helper/navigate_helper.dart';
import '../../redux/misc/inventory_item_viewmodel.dart';
import '../../services/json/inventory_repository.dart';

class GameUpdatesDetailsPage extends StatelessWidget {
  final GameUpdate gameUpdate;
  const GameUpdatesDetailsPage({
    Key? key,
    required this.gameUpdate,
  }) : super(key: key);

  Future<List<InventoryItem>> getAllDetails(
    BuildContext reqItemCtx,
    List<String> appIds,
  ) async {
    List<RequiredItem> requiredItems =
        appIds.map((appId) => RequiredItem(appId: appId, quantity: 1)).toList();
    List<InventoryItem> result = List.empty(growable: true);

    for (var requiredItem in requiredItems) {
      InventoryRepository? genRepo =
          getGenericRepoFromAppId(requiredItem.appId);
      if (genRepo == null) continue;

      ResultWithValue<InventoryItem> genericResult =
          await genRepo.getItem(reqItemCtx, requiredItem.appId);

      if (genericResult.hasFailed) {
        getLog()
            .e("genericItemResult hasFailed: ${genericResult.errorMessage}");
        continue;
      }

      result.add(genericResult.value);
    }

    result.sort((InventoryItem a, InventoryItem b) => a.name.compareTo(b.name));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return basicGenericPageScaffold(
      context,
      title: gameUpdate.title,
      body: StoreConnector<AppState, InventoryItemViewModel>(
        converter: (store) => InventoryItemViewModel.fromStore(store),
        builder: (_, viewModel) {
          return CachedFutureBuilder<List<InventoryItem>>(
            future: getAllDetails(context, gameUpdate.appIds),
            whileLoading: () => getLoading().fullPageLoading(context),
            whenDoneLoading: (List<InventoryItem> snapshot) =>
                getBodyFromFuture(context, snapshot, viewModel, gameUpdate),
          );
        },
      ),
    );
  }

  Widget getBodyFromFuture(
    BuildContext bodyCtx,
    List<InventoryItem> details,
    InventoryItemViewModel viewModel,
    GameUpdate localMajorItem,
  ) {
    List<Widget> listItems = List.empty(growable: true);

    listItems.add(const EmptySpace2x());
    listItems.add(Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: LocalImage(imagePath: localMajorItem.icon, width: 200),
      ),
    ));

    listItems.add(const EmptySpace1x());
    listItems.add(Center(
      child: GenericItemName(simpleDate(localMajorItem.releaseDate)),
    ));
    if (details.isNotEmpty) {
      listItems.add(const EmptySpace1x());
      listItems.add(Center(
        child: Text(
            '${getTranslations().fromKey(LocaleKey.newItemsAdded)}: ${details.length}'),
      ));
      listItems.add(const EmptySpace1x());
    }
    if (localMajorItem.postUrl.isNotEmpty) {
      listItems.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: PositiveButton(
          title: getTranslations().fromKey(LocaleKey.viewPostOnline),
          onTap: () => launchExternalURL(localMajorItem.postUrl),
        ),
      ));
    }
    listItems.add(getBaseWidget().customDivider());
    listItems.add(const EmptySpace1x());

    if (details.isNotEmpty) {
      var presenter = inventoryTilePresenter(
        isPatron: viewModel.isPatron,
        displayMuseumStatus: false,
        donations: [],
      );
      for (int detailIndex = 0; detailIndex < details.length; detailIndex++) {
        InventoryItem gItem = details[detailIndex];
        listItems.add(presenter(
          bodyCtx,
          gItem,
          detailIndex,
          onTap: () => navigateToInventory(
            context: bodyCtx,
            item: gItem,
            isPatron: viewModel.isPatron,
          ),
        ));
      }
    } else {
      listItems.add(Center(
        child: GenericItemGroup(
          getTranslations().fromKey(LocaleKey.noItemsRecorded),
        ),
      ));
    }

    return listWithScrollbar(
      shrinkWrap: true,
      itemCount: listItems.length,
      itemBuilder: (BuildContext context, int index) => listItems[index],
      padding: const EdgeInsets.only(bottom: 64),
      scrollController: ScrollController(),
    );
  }
}
