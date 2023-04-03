import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/inventory_item.dart';
import '../../helper/navigate_helper.dart';
import 'item_base_tile_presenter.dart';

Widget favouriteTilePresenter(
  BuildContext context, {
  required InventoryItem item,
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
        () => navigateToInventory(
              context: context,
              item: item,
              isPatron: isPatron,
            ),
    index: index,
  );
}
