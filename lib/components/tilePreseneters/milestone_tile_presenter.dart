import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../contracts/json/milestone_level.dart';

Widget milestoneLevelTilePresenter(
  BuildContext context,
  MilestoneLevel item,
  int index,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Level: ${item.count}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.permitPoints.toString()),
            localImage(AppImage.permitPoint, width: 24, height: 24),
          ],
        )
      ],
    ),
  );
}
