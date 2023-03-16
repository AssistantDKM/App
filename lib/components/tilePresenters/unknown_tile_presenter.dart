import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../helper/patreon_helper.dart';

Widget obscureTextTilePresenter({
  required String text,
  required void Function()? onTap,
}) {
  return ListTile(
    leading: genericTileImage(AppImage.locked),
    title: Text(obscureText(text)),
    onTap: onTap,
  );
}
