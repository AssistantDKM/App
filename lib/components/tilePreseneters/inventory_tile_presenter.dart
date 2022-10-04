import 'package:flutter/material.dart';

import '../../contracts/interface/item_base_presenter.dart';
import 'item_base_tile_presenter.dart';

Widget Function(
  BuildContext,
  ItemBasePresenter,
  int,
) inventoryTilePresenter(bool isPatron) {
  return (
    BuildContext context,
    ItemBasePresenter item,
    int index,
  ) {
    return itemBaseTilePresenter(
      context: context,
      item: item,
      index: index,
      isPatron: isPatron,
    );
  };
}
