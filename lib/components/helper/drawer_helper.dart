import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';
import '../../constants/drawer_items.dart';
import '../../contracts/custom_menu.dart';
import '../../redux/setting/drawer_settings_viewmodel.dart';

List<Widget> getDrawerItems(BuildContext context, DrawerSettingsViewModel vm) {
  List<Widget> widgets = List.empty(growable: true);
  Color drawerIconColour = getTheme().getDarkModeSecondaryColour();

  widgets.add(const EmptySpace(0.5));
  widgets.addAll(_mapToDrawerItem(
    context,
    getMenuOptionsSection1(context, vm, drawerIconColour),
  ));
  widgets.add(getBaseWidget().customDivider());
  widgets.addAll(_mapToDrawerItem(
    context,
    getMenuOptionsSection2(context, vm, drawerIconColour),
  ));
  widgets.add(getBaseWidget().customDivider());
  widgets.addAll(_mapToDrawerItem(
    context,
    getMenuOptionsSection3(context, vm, drawerIconColour),
  ));
  widgets.add(getBaseWidget().customDivider());

  widgets.add(
    FutureBuilder<ResultWithValue<VersionDetail>>(
      future: getUpdate().getPackageInfo(),
      builder: (BuildContext context,
          AsyncSnapshot<ResultWithValue<VersionDetail>> snapshot) {
        Widget? errorWidget = asyncSnapshotHandler(context, snapshot,
            loader: () => getLoading().loadingIndicator());
        if (errorWidget != null) return Container();

        ResultWithValue<VersionDetail>? packageInfoResult = snapshot.data;
        String appVersionString =
            'Version: ${packageInfoResult?.value.version}';

        return ListTile(
          key: const Key('versionNumber'),
          leading: const CorrectlySizedImageFromIcon(icon: Icons.code),
          title: Text(appVersionString),
          onTap: () {},
          dense: true,
        );
      },
    ),
  );
  widgets.add(_drawerItem(
    context,
    image: const ListTileImage(partialPath: AppImage.assistantApps),
    title: getTranslations().fromKey(LocaleKey.assistantApps),
    onTap: (_) {
      adaptiveListBottomModalSheet(
        context,
        hasRoundedCorners: true,
        builder: (BuildContext innerC, ScrollController controller) =>
            AssistantAppsModalBottomSheet(
          appType: AssistantAppType.dkm,
          controller: controller,
        ),
      );
    },
  ));
  widgets.add(const EmptySpace3x());
  widgets.add(const EmptySpace3x());

  return widgets;
}

Widget _drawerItem(
  BuildContext drawerItemCtx, {
  required Widget image,
  required String title,
  String? navigateToNamed,
  Function(BuildContext)? onTap,
  Function(BuildContext)? onLongPress,
}) {
  ListTile tile = ListTile(
    key: Key('$image-${title.toString()}'),
    leading: image,
    title: Text(title),
    dense: true,
    onLongPress: () {
      if (onLongPress != null) onLongPress(drawerItemCtx);
    },
    onTap: () async {
      if (onTap != null) {
        onTap(drawerItemCtx);
        return;
      }

      if (navigateToNamed != null) {
        await getNavigation().navigateAwayFromHomeAsync(
          drawerItemCtx,
          navigateToNamed: navigateToNamed,
        );
      }
    },
  );
  return tile;
}

List<Widget> _mapToDrawerItem(BuildContext context, List<CustomMenu> menus) {
  List<Widget> widgets = List.empty(growable: true);
  for (CustomMenu menu in menus) {
    widgets.add(_drawerItem(
      context,
      title: getTranslations().fromKey(menu.title),
      image: menu.drawerIcon,
      navigateToNamed: menu.navigateToNamed,
      onTap: menu.onTap,
      onLongPress: menu.onLongPress,
    ));
  }
  return widgets;
}
