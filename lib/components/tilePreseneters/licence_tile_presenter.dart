import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../contracts/json/licence_item.dart';
import '../../contracts/json/licence_level_item.dart';
import '../../helper/image_helper.dart';

Widget licenceTilePresenter(BuildContext context, LicenceItem item, int index) {
  String localImage = networkImageToLocal(item.imageUrl);
  return genericListTile(
    context,
    leadingImage: localImage,
    name: item.name,
  );
}

Widget licenceLevelTilePresenter(
  BuildContext context,
  LicenceLevel item,
  bool disableLeading,
  int index,
) {
  return ListTile(
    leading: disableLeading
        ? null
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.skillLevel > 0) ...[
                const Text('Level'),
                Text(item.skillLevel.toString()),
              ],
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
    trailing: item.unlockedRecipes.isNotEmpty //
        ? const Icon(Icons.info_outline)
        : null,
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
