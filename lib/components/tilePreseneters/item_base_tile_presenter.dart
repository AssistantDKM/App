import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/interface/item_base_presenter.dart';
import '../../helper/image_helper.dart';

Widget itemBaseTilePresenter(
  BuildContext context,
  ItemBasePresenter item,
  int index,
) {
  String localImage = networkImageToLocal(item.imageUrl);
  return ListTile(
    leading: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 60),
      child: genericTileImage(localImage),
    ),
    title: Text(
      item.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
