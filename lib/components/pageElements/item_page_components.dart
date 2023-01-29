import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../constants/app_colour.dart';
import '../../helper/currency_helper.dart';

Widget chipFromString(String label) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: getBaseWidget().appChip(
        label: GenericItemDescription(label),
        backgroundColor: AppColour.defaultTagColour,
      ),
    );

List<Widget> loadSections(String sectionName, List<String> items) => [
      const EmptySpace2x(),
      GenericItemGroup(sectionName),
      FlatCard(
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
  return getBaseWidget().appChip(
    label: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const LocalImage(imagePath: AppImage.coin, width: 32, height: 32),
        const EmptySpace(0.25),
        Text(formatCurrency(locale, price)),
        const EmptySpace(0.5),
      ],
    ),
    backgroundColor: AppColour.moneyTagColour,
  );
}
