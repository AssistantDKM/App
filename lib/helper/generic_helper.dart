import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

const int maxNumberOfRowsForRecipeCategory = 3;

Widget genericItemImage(BuildContext context, String imagePath,
        {bool disableZoom = false,
        double height = 100,
        String name = 'Zoom',
        bool hdAvailable = false,
        Function()? onTap}) =>
    Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          child: LocalImage(imagePath: imagePath, height: height),
        ),
      ),
    );

Widget gridIconTilePresenter(BuildContext innerContext, String imageprefix,
        String imageAddress, Function(String icon) onTap) =>
    genericItemImage(
      innerContext,
      '$imageprefix$imageAddress',
      disableZoom: true,
      onTap: () => onTap(imageAddress),
    );

String padString(String input, int numChars) {
  String padding = '';
  for (var paddingIndex = 0;
      paddingIndex < numChars - input.length;
      paddingIndex++) {
    padding += '0';
  }
  return padding + input;
}
