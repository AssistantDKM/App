import 'package:flutter/material.dart';

import '../../contracts/interface/item_base_presenter.dart';
import '../../contracts/json/inventory_item.dart';
import '../../helper/navigate_helper.dart';
import '../pageElements/inventory_item_museum_tile.dart';
import 'item_base_tile_presenter.dart';

Widget Function(
  BuildContext,
  ItemBasePresenter,
  int, {
  void Function()? onTap,
}) inventoryTilePresenter({
  required bool isPatron,
  required bool displayMuseumStatus,
  List<String>? donations,
}) {
  return (
    BuildContext context,
    ItemBasePresenter item,
    int index, {
    void Function()? onTap,
  }) {
    Widget? trailing;
    if (displayMuseumStatus == true && donations != null) {
      trailing = SizedBox(
        height: 20,
        width: 20,
        child: InventoryItemMuseumCheckBox(
          appId: item.appId,
          donations: donations,
        ),
      );
    }
    return itemBaseTilePresenter(
      item: item,
      index: index,
      isPatron: isPatron,
      trailing: trailing,
      onTap: onTap,
    );
  };
}

Widget Function(
  BuildContext,
  InventoryItem,
) inventoryUsageTilePresenter(
  bool isPatron, {
  required bool isInDetailPane,
  updateDetailView,
}) {
  return (
    BuildContext context,
    InventoryItem item,
  ) {
    return itemBaseTilePresenter(
      item: item,
      index: 0,
      isPatron: isPatron,
      onTap: () => navigateToInventoryOrUpdateView(
        context: context,
        item: item,
        isPatron: isPatron,
        isInDetailPane: isInDetailPane,
        updateDetailView: updateDetailView,
      ),
    );
  };
}
