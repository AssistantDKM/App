import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../pages/inventory_pages.dart';
import '../../contracts/required_item_details.dart';

const double itemPadding = 16.0;

Widget requiredItemTreeDetailsRowPresenter(
  BuildContext context,
  RequiredItemDetails itemDetails,
  int cost,
) {
  Row rowWidget = Row(
    children: [
      SizedBox(
        height: 50,
        width: 50,
        child: genericTileImage(itemDetails.icon),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(itemDetails.name, maxLines: 2),
            Container(height: 4),
            if (itemDetails.quantity > 0) ...[
              Text(
                "${getTranslations().fromKey(LocaleKey.quantity)}: ${itemDetails.quantity.toString()}",
                style: _subtitleTextStyle(context),
              ),
            ],
          ],
        ),
      ),
    ],
  );

  Future Function() onTapFunc;
  onTapFunc = () async => await getNavigation().navigateAsync(
        context,
        navigateTo: (context) => InventoryDetailsPage(
          itemDetails.appId,
          title: itemDetails.name,
        ),
      );

  return GestureDetector(
    onTap: onTapFunc,
    child: rowWidget,
  );
}

TextStyle? _subtitleTextStyle(BuildContext ctx) {
  final TextStyle? style = getThemeBodyMedium(ctx);
  final Color? colour = getThemeBodySmall(ctx)?.color;
  if (colour == null) return style;
  return style?.copyWith(color: colour);
}
