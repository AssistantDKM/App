import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/animal_item.dart';

Widget animalTilePresenter(BuildContext context, AnimalItem bug, int index) {
  String localImage = bug.imageUrl.replaceAll('https://api.dinkumapi.com/', '');
  return genericListTile(
    context,
    leadingImage: 'assets/$localImage',
    name: bug.name,
  );
}
