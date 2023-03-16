import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/interface/item_base_presenter.dart';
import '../../pages/inventory_pages.dart';
import 'item_base_tile_presenter.dart';

Widget favouriteTilePresenter(
  BuildContext context, {
  required ItemBasePresenter item,
  required bool isPatron,
  required int index,
  void Function()? onTap,
  required void Function() onDelete,
}) {
  return itemBaseTilePresenter(
    item: item,
    isPatron: isPatron,
    trailing: popupMenu(context, onDelete: onDelete),
    onTap: onTap ??
        () => getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateTo: (ctx) => InventoryDetailsPage(
                item.appId,
                title: item.name,
              ),
            ),
    index: index,
  );
}
