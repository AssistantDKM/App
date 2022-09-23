import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/crafting_item.dart';
import '../../helper/image_helper.dart';

Widget craftingTilePresenter(
    BuildContext context, CraftingItem item, int index) {
  String localImage = networkImageToLocal(item.imageUrl);
  return genericListTile(
    context,
    leadingImage: localImage,
    name: item.name,
  );
}
