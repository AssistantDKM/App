import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/app_image.dart';
import '../../constants/app_colour.dart';

Widget chipFromString(String label) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Chip(
        label: genericItemDescription(label),
        backgroundColor: AppColour.defaultTagColour,
      ),
    );

List<Widget> loadSections(String sectionName, List<String> items) => [
      emptySpace2x(),
      genericItemGroup(sectionName),
      flatCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: items.map((item) => chipFromString(item)).toList(),
          ),
        ),
      ),
    ];

Widget pageDefaultPadding(Widget inner) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: inner,
    );

Widget dinkumPrice(BuildContext priceCtx, int price) {
  Locale locale = Localizations.localeOf(priceCtx);
  NumberFormat format = NumberFormat.currency(
    locale: locale.toString(),
    decimalDigits: 0,
    symbol: '',
  );
  return Chip(
    label: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        localImage(AppImage.coin, width: 32, height: 32),
        emptySpace(0.25),
        Text(format.format(price)),
        emptySpace(0.5),
      ],
    ),
    backgroundColor: AppColour.moneyTagColour,
  );
}
