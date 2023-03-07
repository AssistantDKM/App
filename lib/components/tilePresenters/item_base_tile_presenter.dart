import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../contracts/interface/item_base_presenter.dart';
import '../../contracts/json/inventory_item.dart';
import '../../helper/patreon_helper.dart';

Widget itemBaseTilePresenter({
  required BuildContext context,
  required ItemBasePresenter item,
  required int index,
  required bool isPatron,
  void Function()? onTap,
}) {
  Widget? imgChild = Container();
  if (item.icon.isNotEmpty) {
    imgChild = genericTileImage(item.icon);
  }

  if (item is InventoryItem && isPatron == false && item.hidden) {
    return ListTile(
      leading: genericTileImage(AppImage.locked),
      title: Text(obscureText(item.name)),
      onTap: onTap,
    );
  }

  return ListTile(
    leading: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 60),
      child: imgChild,
    ),
    title: Text(
      item.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    onTap: onTap,
  );
}

Widget commonTilePresenter(
  BuildContext context,
  ItemBasePresenter item,
  int index, {
  void Function()? onTap,
}) {
  return itemBaseTilePresenter(
    context: context,
    item: item,
    index: index,
    isPatron: false,
    onTap: onTap,
  );
}
