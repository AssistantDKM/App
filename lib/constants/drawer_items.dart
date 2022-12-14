import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

import '../contracts/custom_menu.dart';
import '../redux/setting/drawer_settings_viewmodel.dart';
import 'app_routes.dart';

const double imageSize = 52;

List<CustomMenu> getMenuOptionsSection1(
    BuildContext context, DrawerSettingsViewModel vm, Color drawerIconColour) {
  //
  Widget localGetFromIcon(IconData icon) =>
      getCorrectlySizedImageFromIcon(context, icon,
          colour: drawerIconColour, maxSize: imageSize);
  Widget localGetDrawerFromIcon(IconData icon) =>
      getCorrectlySizedImageFromIcon(context, icon, colour: drawerIconColour);

  return [
    CustomMenu(
      icon: localGetFromIcon(Icons.campaign),
      drawerIcon: localGetDrawerFromIcon(Icons.campaign),
      title: LocaleKey.whatIsNew,
      navigateToNamed: Routes.whatIsNew,
    ),
    // CustomMenu(
    //   icon: getListTileImage(AppImage.language, size: imageSize),
    //   drawerIcon: getListTileImage(AppImage.language),
    //   title: LocaleKey.language,
    //   navigateToNamed: Routes.language,
    //   hideInCustom: true,
    // ),
    // CustomMenu(
    //   icon: getListTileImage(AppImage.contributors, size: imageSize),
    //   drawerIcon: getListTileImage(AppImage.contributors),
    //   title: LocaleKey.contributors,
    //   navigateToNamed: Routes.contributors,
    // ),
    CustomMenu(
      icon: DonationImage.patreon(size: imageSize),
      drawerIcon: DonationImage.patreon(),
      title: LocaleKey.patrons,
      navigateToNamed: Routes.patronListPage,
    ),
    // isApple
    //     ?
    if (!isWindows) ...[
      CustomMenu(
        icon: localGetFromIcon(Icons.share),
        drawerIcon: localGetDrawerFromIcon(Icons.share),
        title: LocaleKey.share,
        hideInCustom: true,
        onTap: (BuildContext navContext) => shareText(LocaleKey.shareContent),
      ),
    ],
    // : CustomMenu(
    //     icon: getListTileImage(AppImage.donation, size: imageSize),
    //     drawerIcon: getListTileImage(AppImage.donation),
    //     title: LocaleKey.donation,
    //     hideInCustom: true,
    //     navigateToNamed: Routes.donation,
    //   )
  ];
}

List<CustomMenu> getMenuOptionsSection2(
    BuildContext context, DrawerSettingsViewModel vm, Color drawerIconColour) {
  //
  Widget localGetFromIcon(IconData icon) =>
      getCorrectlySizedImageFromIcon(context, icon,
          colour: drawerIconColour, maxSize: imageSize);
  Widget localGetDrawerFromIcon(IconData icon) =>
      getCorrectlySizedImageFromIcon(context, icon, colour: drawerIconColour);

  return [
    CustomMenu(
      icon: localGetFromIcon(Icons.star),
      drawerIcon: localGetDrawerFromIcon(Icons.star),
      title: LocaleKey.favourites,
      navigateToNamed: Routes.favourites,
    ),
    // CustomMenu(
    //   icon: localGetFromIcon(Icons.shopping_basket_rounded),
    //   drawerIcon: localGetDrawerFromIcon(Icons.shopping_basket_rounded),
    //   title: LocaleKey.cart,
    //   navigateToNamed: Routes.cart,
    // ),
    CustomMenu(
      icon: localGetFromIcon(Icons.new_releases_sharp),
      drawerIcon: localGetDrawerFromIcon(Icons.new_releases_sharp),
      title: LocaleKey.news,
      navigateToNamed: Routes.newsPage,
    ),
  ];
}

List<CustomMenu> getMenuOptionsSection3(
    BuildContext context, DrawerSettingsViewModel vm, Color drawerIconColour) {
  //
  Widget localGetFromIcon(IconData icon) =>
      getCorrectlySizedImageFromIcon(context, icon,
          colour: drawerIconColour, maxSize: imageSize);
  Widget localGetDrawerFromIcon(IconData icon) =>
      getCorrectlySizedImageFromIcon(context, icon, colour: drawerIconColour);

  return [
    // CustomMenu(
    //   icon: localGetFromIcon(Icons.sync),
    //   drawerIcon: localGetDrawerFromIcon(Icons.sync),
    //   title: LocaleKey.synchronize,
    //   navigateToNamed: Routes.syncPage,
    // ),
    CustomMenu(
      icon: localGetFromIcon(Icons.feedback),
      drawerIcon: localGetDrawerFromIcon(Icons.feedback),
      title: LocaleKey.feedback,
      onTap: (tapCtx) {
        Wiredash.of(tapCtx).show(inheritMaterialTheme: true);
      },
    ),
    CustomMenu(
      icon: localGetFromIcon(Icons.help),
      drawerIcon: localGetDrawerFromIcon(Icons.help),
      title: LocaleKey.about,
      hideInCustom: true,
      navigateToNamed: Routes.about,
    ),
    // CustomMenu(
    //   icon: getListTileImage(AppImage.twitter, size: imageSize),
    //   drawerIcon: getListTileImage(AppImage.twitter),
    //   title: LocaleKey.social,
    //   navigateToNamed: Routes.socialLinks,
    // ),
  ];
}

// List<CustomMenu> getMenuOptions(
//     BuildContext context, DrawerSettingsViewModel vm) {
//   Color drawerIconColour = getTheme().getDarkModeSecondaryColour();
//   return [
//     ...getMenuOptionsSection1(context, vm, drawerIconColour),
//     ...getMenuOptionsSection2(context, vm, drawerIconColour),
//     ...getMenuOptionsSection3(context, vm, drawerIconColour),
//   ];
// }
