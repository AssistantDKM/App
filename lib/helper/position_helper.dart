import 'package:flutter/material.dart';

List<Positioned> widgetsToPositioneds(List<Widget> widgets) {
  return widgets
      .asMap()
      .entries
      .map((entry) {
        int idx = entry.key;
        if (idx == 0) {
          return Positioned(top: 0, left: 0, child: entry.value);
        }
        if (idx == 1) {
          return Positioned(top: 0, right: 0, child: entry.value);
        }
        if (idx == 2) {
          return Positioned(bottom: 0, left: 0, child: entry.value);
        }
        if (idx == 3) {
          return Positioned(bottom: 0, right: 0, child: entry.value);
        }

        return null;
      })
      .where((element) => element != null)
      .map((e) => e!)
      .toList();
}
