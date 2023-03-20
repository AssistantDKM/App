import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/scaffoldTemplates/generic_page_scaffold.dart';
import '../../components/tilePresenters/game_update_tile_presenter.dart';
import '../../contracts/data/game_update.dart';
import '../../integration/dependency_injection.dart';

class GameUpdatesPage extends StatelessWidget {
  const GameUpdatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return basicGenericPageScaffold(
      context,
      title: getTranslations().fromKey(LocaleKey.newItemsAdded),
      body: FutureBuilder<ResultWithValue<List<GameUpdate>>>(
        future: getDataRepo().getGameUpdates(context),
        builder: getBodyFromFuture,
      ),
    );
  }

  Widget getBodyFromFuture(
    BuildContext bodyCtx,
    AsyncSnapshot<ResultWithValue<List<GameUpdate>>> snapshot,
  ) {
    List<Widget> listItems = List.empty(growable: true);

    Widget? errorWidget = asyncSnapshotHandler(
      bodyCtx,
      snapshot,
      loader: () => getLoading().fullPageLoading(bodyCtx),
      isValidFunction: (ResultWithValue<List<GameUpdate>>? expResult) {
        if (expResult?.hasFailed ?? true) return false;
        if (expResult?.value == null) return false;
        return true;
      },
    );
    if (errorWidget != null) return errorWidget;

    for (GameUpdate update in snapshot.data!.value) {
      listItems.add(gameUpdateTilePresenter(bodyCtx, update));
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
