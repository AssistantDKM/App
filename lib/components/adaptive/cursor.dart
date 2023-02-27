import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';

class CustomCursor extends StatefulWidget {
  final Widget matApp;
  const CustomCursor({Key? key, required this.matApp}) : super(key: key);

  @override
  createState() => _CustomCursorWidget();
}

class _CustomCursorWidget extends State<CustomCursor> {
  Offset position = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onHover: (event) {
        setState(() {
          position = event.position;
        });
      },
      child: Stack(
        children: [
          widget.matApp,
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1),
            left: position.dx,
            top: position.dy - 32,
            child: const IgnorePointer(
              child: LocalImage(
                imagePath: AppImage.customCursor,
                width: 48,
                height: 48,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
