import 'package:assistant_dinkum_app/helper/patreon_helper.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../contracts/data/game_update.dart';
import '../contracts/json/inventory_item.dart';
import '../contracts/json/licence_item.dart';
import '../pages/inventory_pages.dart';
import '../pages/licences_pages.dart';
import '../pages/updates/game_updates_detail_page.dart';

void navigateToLicence(
  BuildContext navCtx,
  LicenceItem requiredLicence,
) =>
    getNavigation().navigateAwayFromHomeAsync(
      navCtx,
      navigateTo: (BuildContext navigateCtx) => LicenceDetailsPage(
        requiredLicence.appId,
        title: requiredLicence.name,
      ),
    );

void navigateToInventoryWithProps({
  required BuildContext context,
  required String appId,
  required String name,
  required bool obscure,
}) {
  String localName = name;
  if (obscure) {
    localName = obscureText(name);
  }
  getNavigation().navigateAwayFromHomeAsync(
    context,
    navigateTo: (ctx) => InventoryDetailsPage(appId, title: localName),
  );
}

void navigateToInventory({
  required BuildContext context,
  required InventoryItem item,
  required bool isPatron,
}) {
  navigateToInventoryWithProps(
    context: context,
    appId: item.appId,
    name: item.name,
    obscure: (item.hidden && isPatron != true),
  );
}

void navigateToInventoryOrUpdateView({
  required BuildContext context,
  required InventoryItem item,
  required bool isPatron,
  bool isInDetailPane = false,
  void Function(Widget)? updateDetailView,
}) {
  if (updateDetailView == null) {
    navigateToInventory(
      context: context,
      item: item,
      isPatron: isPatron,
    );
  }

  updateDetailView!(
    InventoryDetailsPage(
      item.appId,
      title: item.name,
      isInDetailPane: isInDetailPane,
      updateDetailView: updateDetailView,
    ),
  );
  return;
}

void navigateToGameUpdate(BuildContext context, GameUpdate gameUpdate) {
  getNavigation().navigateAwayFromHomeAsync(
    context,
    navigateTo: (_) => GameUpdatesDetailsPage(gameUpdate: gameUpdate),
  );
}


/*
navigateToInventory(
              context: foodCtx,
              item: item,
              isPatron: false, // TODO Patron prop
            ),
*/