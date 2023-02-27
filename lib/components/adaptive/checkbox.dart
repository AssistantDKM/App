import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final Color? activeColor;

  const CustomCheckbox({
    Key? key,
    required this.value,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: LocalImage(
        imagePath: value ? AppImage.checkboxTicked : AppImage.checkboxUnTicked,
        width: 32,
        height: 32,
      ),
    );
  }
}
