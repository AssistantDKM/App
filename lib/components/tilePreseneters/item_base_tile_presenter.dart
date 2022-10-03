import 'package:assistant_dinkum_app/constants/app_image.dart';
import 'package:assistant_dinkum_app/contracts/json/inventory_item.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/interface/item_base_presenter.dart';
import '../../helper/image_helper.dart';

Widget itemBaseTilePresenter(
  BuildContext context,
  ItemBasePresenter item,
  int index,
) {
  Widget? imgChild = Container();
  if (item.icon.isNotEmpty) {
    imgChild = genericTileImage('inventory/${item.icon}');
  } else {
    if ((item as dynamic).imageUrl != null) {
      imgChild = localImage(networkImageToLocal((item as dynamic).imageUrl));
    }
  }
  if (item is InventoryItem && item.hidden) {
    return ListTile(
      leading: genericTileImage(AppImage.unknown),
      title: Text(item.name.characters.map((e) => '-').join('')),
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
  );
}
