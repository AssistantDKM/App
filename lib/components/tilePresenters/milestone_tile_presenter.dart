import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';

Widget milestoneLevelTilePresenter(
  BuildContext context, {
  required String prefix,
  required String suffix,
  required int requiredAmount,
  required int rewardPerLevel,
}) {
  Widget topSection = Text(
    getTranslations()
        .fromKey(LocaleKey.requirement)
        .replaceAll('{0}', '$prefix$requiredAmount$suffix'),
  );

  if (suffix == 'm') {
    topSection = Text(
      getTranslations().fromKey(LocaleKey.requirementInKm).replaceAll(
          '{0}', '${(requiredAmount / 1000).toStringAsFixed(0)} km'),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        topSection,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(rewardPerLevel.toString()),
            const LocalImage(
              imagePath: AppImage.permitPoint,
              width: 24,
              height: 24,
            ),
          ],
        )
      ],
    ),
  );
}
