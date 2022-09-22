import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/food_item.dart';

Widget foodTilePresenter(BuildContext context, FoodItem food, int index) {
  String localImage =
      food.imageUrl.replaceAll('https://api.dinkumapi.com/', '');
  return genericListTile(
    context,
    leadingImage: 'assets/$localImage',
    name: food.name,
  );
}
