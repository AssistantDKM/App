import 'package:flutter/material.dart';

const double horizontalSpace = 4;

List<Positioned> widgetsToPositioneds(List<Widget> widgets) {
  return widgets
      .asMap()
      .entries
      .map((entry) {
        int idx = entry.key;
        var value = entry.value;
        if (idx == 0) {
          return Positioned(top: 0, left: horizontalSpace, child: value);
        }
        if (idx == 1) {
          return Positioned(top: 0, right: horizontalSpace, child: value);
        }
        if (idx == 2) {
          return Positioned(bottom: 0, left: horizontalSpace, child: value);
        }
        if (idx == 3) {
          return Positioned(bottom: 0, right: horizontalSpace, child: value);
        }

        return null;
      })
      .where((element) => element != null)
      .map((e) => e!)
      .toList();
}
