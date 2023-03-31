import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/data/game_update.dart';
import '../../helper/navigate_helper.dart';

Widget gameUpdateTilePresenter(
  BuildContext tileCtx,
  GameUpdate updateNewItems, {
  void Function()? onTap,
}) {
  Widget backgroundImgSource = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 1),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Image.asset(
        '${getPath().imageAssetPathPrefix}/${updateNewItems.icon}',
        fit: BoxFit.fitWidth,
      ),
    ),
  );

  Widget content = Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      backgroundImgSource,
      ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        child: Container(
          color: const Color.fromRGBO(0, 0, 0, 0.45),
          width: double.infinity,
          child: Column(children: [
            GenericItemName(updateNewItems.title),
          ]),
        ),
      ),
    ],
  );

  return InkWell(
    onTap: onTap ?? () => navigateToGameUpdate(tileCtx, updateNewItems),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: content,
    ),
  );
}

Widget gameUpdateItemDetailTilePresenter(
  BuildContext tileCtx,
  GameUpdate updateItem, {
  void Function()? onTap,
}) {
  return ListTile(
    leading: ClipRRect(
      borderRadius: UIConstants.generalBorderRadius,
      child: LocalImage(
        imagePath: updateItem.icon.replaceAll('.png', '-icon.png'),
        boxfit: BoxFit.fill,
      ),
    ),
    title: Text(updateItem.title),
    subtitle: Text(simpleDate(updateItem.releaseDate)),
    onTap: onTap ?? () => navigateToGameUpdate(tileCtx, updateItem),
  );
}

  /*
  genericListTileWithSubtitle(
      context,
      leadingImage: updateItem.icon,
      name: updateItem.title,
      subtitle: Text(simpleDate(updateItem.releaseDate)),
      trailing: Text(updateItem.emoji),
      onTap: () => getNavigation().navigateAwayFromHomeAsync(
        context,
        navigateTo: (_) => MajorUpdatesDetailPage(updateNewItems: updateItem),
      ),
    ),
   */
