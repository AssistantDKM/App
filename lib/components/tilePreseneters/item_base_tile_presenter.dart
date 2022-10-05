import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../contracts/interface/item_base_presenter.dart';
import '../../contracts/json/inventory_item.dart';
import '../../helper/image_helper.dart';
import '../../helper/patreon_helper.dart';

Widget itemBaseTilePresenter({
  required BuildContext context,
  required ItemBasePresenter item,
  required int index,
  required bool isPatron,
}) {
  Widget? imgChild = Container();
  if (item.icon.isNotEmpty) {
    imgChild = genericTileImage(item.icon);
  } else {
    if ((item as dynamic).imageUrl != null) {
      imgChild = localImage(networkImageToLocal((item as dynamic).imageUrl));
    }
  }
  if (item is InventoryItem && isPatron == false && item.hidden) {
    return ListTile(
      leading: genericTileImage(AppImage.unknown),
      title: Text(obscureText(item.name)),
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

Widget commonTilePresenter(
  BuildContext context,
  ItemBasePresenter item,
  int index,
) {
  return itemBaseTilePresenter(
    context: context,
    item: item,
    index: index,
    isPatron: false,
  );
}
