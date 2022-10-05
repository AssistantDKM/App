import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../contracts/interface/item_base_presenter.dart';
import '../../contracts/json/inventory_item.dart';
import '../../pages/inventory_pages.dart';

Widget favouriteTilePresenter(
  BuildContext context,
  ItemBasePresenter item, {
  void Function()? onTap,
  required void Function() onDelete,
}) {
  if (item is InventoryItem && item.hidden) {
    return ListTile(
      leading: genericTileImage(AppImage.unknown),
      title: Text(item.name.characters.map((e) => '-').join('')),
    );
  }

  return ListTile(
    leading: genericTileImage(item.icon),
    title: Text(
      item.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: popupMenu(context, onDelete: onDelete),
    onTap: onTap ??
        () => getNavigation().navigateAwayFromHomeAsync(
              context,
              navigateTo: (ctx) => InventoryDetailsPage(
                item.appId,
                title: item.name,
              ),
            ),
  );
}
