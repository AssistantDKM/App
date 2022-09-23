import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

class CustomMenu {
  Widget icon;
  Widget drawerIcon;
  LocaleKey title;
  String? navigateToNamed;
  String? navigateToExternal;
  bool isLocked;
  bool isNew;
  bool hideInCustom;
  bool hideInDrawer;
  void Function(BuildContext)? onTap;
  void Function(BuildContext)? onLongPress;
  CustomMenu({
    required this.icon,
    required this.drawerIcon,
    required this.title,
    this.navigateToNamed,
    this.navigateToExternal,
    this.isLocked = false,
    this.isNew = false,
    this.hideInCustom = false,
    this.hideInDrawer = false,
    this.onTap,
    this.onLongPress,
  });
}

void customMenuClickHandler(BuildContext context, CustomMenu menuItem) async {
  if (menuItem.onTap != null) {
    menuItem.onTap!(context);
    return;
  }

  if (menuItem.navigateToExternal != null) {
    launchExternalURL(menuItem.navigateToExternal!);
    return;
  }

  if (menuItem.navigateToNamed != null) {
    await getNavigation()
        .navigateAsync(context, navigateToNamed: menuItem.navigateToNamed);
  }
}
