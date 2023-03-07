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
  Widget topSection =
      Text('Requirement: ${prefix}${requiredAmount}${suffix}'); //TODO translate

  if (suffix == 'm') {
    topSection = Text(
        'Requirement: ${(requiredAmount / 1000).toStringAsFixed(0)} km'); //TODO translate
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
