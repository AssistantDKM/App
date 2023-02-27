import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/interface/item_base_presenter.dart';
import '../../pages/inventory_pages.dart';
import 'item_base_tile_presenter.dart';

Widget Function(
  BuildContext,
  ItemBasePresenter,
  int, {
  void Function()? onTap,
}) inventoryTilePresenter(bool isPatron) {
  return (
    BuildContext context,
    ItemBasePresenter item,
    int index, {
    void Function()? onTap,
  }) {
    return itemBaseTilePresenter(
      context: context,
      item: item,
      index: index,
      isPatron: isPatron,
      onTap: onTap,
    );
  };
}

Widget Function(
  BuildContext,
  ItemBasePresenter,
) inventoryUsageTilePresenter(
  bool isPatron, {
  required bool isInDetailPane,
  updateDetailView,
}) {
  return (
    BuildContext context,
    ItemBasePresenter item,
  ) {
    return itemBaseTilePresenter(
      context: context,
      item: item,
      index: 0,
      isPatron: isPatron,
      onTap: (isInDetailPane && updateDetailView != null)
          ? () => updateDetailView(
                InventoryDetailsPage(
                  item.appId,
                  title: item.name,
                  isInDetailPane: isInDetailPane,
                  updateDetailView: updateDetailView,
                ),
              )
          : () => getNavigation().navigateAwayFromHomeAsync(
                context,
                navigateTo: (ctx) => InventoryDetailsPage(
                  item.appId,
                  title: item.name,
                ),
              ),
    );
  };
}
