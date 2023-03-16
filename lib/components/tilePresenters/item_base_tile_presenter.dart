import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/interface/item_base_presenter.dart';
import '../../contracts/json/inventory_item.dart';
import 'unknown_tile_presenter.dart';

Widget itemBaseTilePresenter({
  required ItemBasePresenter item,
  required int index,
  required bool isPatron,
  Widget? trailing,
  void Function()? onTap,
}) {
  Widget? imgChild = Container();
  if (item.icon.isNotEmpty) {
    imgChild = genericTileImage(item.icon);
  }

  if (item is InventoryItem && isPatron == false && item.hidden) {
    return obscureTextTilePresenter(
      text: item.name,
      onTap: onTap,
    );
  }

  return itemBasePlainTilePresenter(
    leading: imgChild,
    title: item.name,
    trailing: trailing,
    onTap: onTap,
  );
}

ListTile itemBasePlainTilePresenter({
  Widget? leading,
  required String title,
  String? subtitle,
  Widget? trailing,
  void Function()? onTap,
}) {
  return ListTile(
    leading: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 60),
      child: leading,
    ),
    title: Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: subtitle != null
        ? Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        : null,
    trailing: trailing,
    onTap: onTap,
  );
}

Widget commonTilePresenter(
  BuildContext ctx,
  ItemBasePresenter item,
  int index, {
  void Function()? onTap,
}) {
  return itemBaseTilePresenter(
    item: item,
    index: index,
    isPatron: false,
    onTap: onTap,
  );
}
