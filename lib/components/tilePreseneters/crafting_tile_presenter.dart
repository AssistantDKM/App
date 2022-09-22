import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/crafting_item.dart';

Widget craftingTilePresenter(
    BuildContext context, CraftingItem craft, int index) {
  String localImage =
      craft.imageUrl.replaceAll('https://api.dinkumapi.com/', '');
  return genericListTile(
    context,
    leadingImage: 'assets/$localImage',
    name: craft.name,
  );
}
