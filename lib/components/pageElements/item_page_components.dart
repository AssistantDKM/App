import 'dart:math';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../constants/app_colour.dart';
import '../../constants/app_misc.dart';
import '../../constants/app_routes.dart';
import '../../contracts/required_item.dart';
import '../../helper/currency_helper.dart';
import '../../redux/misc/inventory_item_viewmodel.dart';
import '../tilePresenters/required_item_tile_presenter.dart';

List<Widget> commonDetailPageHeaderWidgets(
  BuildContext detailPageCtx, {
  required String icon,
  required String name,
  double minHeight = 128,
  double maxImageSize = 200,
  String? description,
}) {
  double deviceWidth = MediaQuery.of(detailPageCtx).size.width;
  double deviceHeight = MediaQuery.of(detailPageCtx).size.height;

  Widget imageStack = ConstrainedBox(
    constraints: BoxConstraints(
      minHeight: minHeight,
      maxWidth: min((deviceWidth / 2), maxImageSize),
      maxHeight: min((deviceHeight / 2), maxImageSize),
    ),
    child: Center(
      child: LocalImage(imagePath: icon),
    ),
  );

  List<Widget> descripWidgets = [
    imageStack,
    GenericItemName(name),
    const EmptySpace1x(),
  ];

  if (description != null) {
    descripWidgets.add(
      pageDefaultPadding(GenericItemDescription(description)),
    );
  }

  return descripWidgets;
}

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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: inner,
    );

Widget dinkumPrice(BuildContext priceCtx, int price) {
  return getBaseWidget().appChip(
    label: dinkumPriceInner(priceCtx, amount: price),
    backgroundColor: AppColour.moneyTagColour,
  );
}

Widget dinkumPriceInner(
  BuildContext priceCtx, {
  required int amount,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
}) {
  Locale locale = Localizations.localeOf(priceCtx);
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: mainAxisAlignment,
    children: [
      const LocalImage(imagePath: AppImage.coin, width: 32, height: 32),
      const EmptySpace(0.25),
      Text(formatCurrency(locale, amount)),
      const EmptySpace(0.5),
    ],
  );
}

List<Widget> genericItemWithOverflowButton<T>(
  BuildContext context,
  List<T> itemArray,
  Widget Function(BuildContext context, T item) presenter, {
  void Function()? viewMoreOnPress,
}) {
  int numRecords = itemArray.length > maxNumberOfRowsForRecipeCategory
      ? maxNumberOfRowsForRecipeCategory
      : itemArray.length;
  List<Widget> widgets = List.empty(growable: true);
  for (var itemIndex = 0; itemIndex < numRecords; itemIndex++) {
    widgets.add(FlatCard(
      child: presenter(context, itemArray[itemIndex]),
    ));
  }
  if (itemArray.length > maxNumberOfRowsForRecipeCategory &&
      viewMoreOnPress != null) {
    widgets.add(viewMoreButton(
      context,
      (itemArray.length - numRecords),
      viewMoreOnPress,
    ));
  }
  return widgets;
}

Widget viewMoreButton(BuildContext context, int numLeftOver, viewMoreOnPress) {
  String viewMore = getTranslations().fromKey(LocaleKey.viewXMore);
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: PositiveButton(
      title: viewMore.replaceAll("{0}", numLeftOver.toString()),
      onTap: () {
        if (viewMoreOnPress == null) return;
        viewMoreOnPress();
      },
    ),
  );
}

List<Widget> getCartItems(
  BuildContext context,
  InventoryItemViewModel vm,
  List<RequiredItem> cartItems,
  bool isPatron,
) {
  List<Widget> cartWidgets = List.empty(growable: true);

  if (cartItems.isNotEmpty) {
    cartWidgets.add(const EmptySpace1x());
    cartWidgets.add(
      GenericItemGroup(getTranslations().fromKey(LocaleKey.cart)),
    );
    cartWidgets.addAll(
      genericItemWithOverflowButton(
        context,
        cartItems,
        (BuildContext cartCtx, RequiredItem cartItem) {
          return requiredItemTilePresenter(
            cartCtx,
            appId: cartItem.appId,
            quantity: cartItem.quantity,
            isPatron: isPatron,
            onTap: () => getNavigation().navigateAsync(
              context,
              navigateToNamed: Routes.cart,
            ),
          );
        },
      ),
    );
  }
  return cartWidgets;
}
