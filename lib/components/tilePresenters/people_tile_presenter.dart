import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/people_item.dart';
import 'item_base_tile_presenter.dart';

Widget Function(
  BuildContext,
  PeopleItem,
  int, {
  void Function()? onTap,
}) peopleTilePresenter(bool isPatron) {
  return (
    BuildContext context,
    PeopleItem item,
    int index, {
    void Function()? onTap,
  }) {
    if (item.icon.isEmpty) {
      item.icon = getPath().unknownImagePath;
    }
    return itemBaseTilePresenter(
      item: item,
      index: index,
      isPatron: isPatron,
      onTap: onTap,
    );
  };
}
