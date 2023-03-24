import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/pageItem/cart_item_page_item.dart';
import '../../pages/inventory_pages.dart';
import 'item_base_tile_presenter.dart';
import 'unknown_tile_presenter.dart';

Widget Function(
  BuildContext,
  CartItemPageItem, {
  void Function()? onTap,
}) cartTilePresenter({
  required bool isPatron,
  required void Function(String appId, int origQuantity) onEdit,
  required void Function(String appId) onDelete,
}) {
  return (
    BuildContext context,
    CartItemPageItem cart, {
    void Function()? onTap,
  }) {
    var item = cart.item;
    Widget? imgChild = Container();
    if (item.icon.isNotEmpty) {
      imgChild = genericTileImage(item.icon);
    }

    if (isPatron == false && item.hidden) {
      return obscureTextTilePresenter(
        text: item.name,
        onTap: onTap,
      );
    }

    return itemBasePlainTilePresenter(
      leading: imgChild,
      title: item.name,
      subtitle:
          '${getTranslations().fromKey(LocaleKey.quantity)}: ${cart.quantity}',
      trailing: popupMenu(
        context,
        onEdit: () => onEdit(item.appId, cart.quantity),
        onDelete: () => onDelete(item.appId),
      ),
      onTap: onTap ??
          () => getNavigation().navigateAwayFromHomeAsync(
                context,
                navigateTo: (ctx) => InventoryDetailsPage(
                  item.appId,
                  title: item.name,
                ),
              ),
    );
  };
}
