import 'package:assistant_dinkum_app/constants/app_image.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/people_item.dart';
import 'item_base_tile_presenter.dart';

Widget Function(BuildContext, PeopleItem, int) peopleTilePresenter(
    bool isPatron) {
  return (
    BuildContext context,
    PeopleItem item,
    int index,
  ) {
    if (item.icon.isEmpty) {
      item.icon = AppImage.unknown;
    }
    return itemBaseTilePresenter(
      context: context,
      item: item,
      index: index,
      isPatron: isPatron,
    );
  };
}
