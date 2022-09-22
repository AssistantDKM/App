import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/required_item.dart';

Widget requiredItemTilePresenter(
    BuildContext context, RequiredItem reqItem, int index) {
  String localImage =
      reqItem.imageUrl.replaceAll('https://api.dinkumapi.com/', 'assets/');
  return genericListTile(
    context,
    leadingImage: localImage,
    name: reqItem.name,
    quantity: reqItem.amount,
  );
}
