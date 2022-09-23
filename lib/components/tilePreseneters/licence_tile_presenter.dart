import 'package:assistant_dinkum_app/constants/app_image.dart';
import 'package:assistant_dinkum_app/contracts/json/licence_item.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/licence_level_item.dart';

Widget licenceTilePresenter(BuildContext context, LicenceItem item, int index) {
  String localImage =
      item.imageUrl.replaceAll('https://api.dinkumapi.com/', '');
  return genericListTile(
    context,
    leadingImage: 'assets/$localImage',
    name: item.name,
  );
}

Widget licenceLevelTilePresenter(
    BuildContext context, LicenceLevel item, int index) {
  return ListTile(
    leading: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(item.skillLevel.toString()),
        const Text('XP'),
      ],
    ),
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(item.cost.toString()),
        localImage(AppImage.permitPoint, width: 24, height: 24),
      ],
    ),
    subtitle: Text(item.description, maxLines: 1),
    trailing: const Icon(Icons.info_outline),
  );

  /**
   * Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(item.unlockedRecipes.length.toString()),
        const Text('Recipes unlocked'),
      ],
    ),
  )
  
   */
}
