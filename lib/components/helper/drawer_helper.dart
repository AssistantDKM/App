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
      adaptiveBottomModalSheet(
        context,
        hasRoundedCorners: true,
        builder: (BuildContext innerC) => const AssistantAppsModalBottomSheet(
          appType: AssistantAppType.dkm,
        ),
      );
    },
  ));
  widgets.add(const EmptySpace3x());
  widgets.add(const EmptySpace3x());

  return widgets;
}

Widget _drawerItem(
  BuildContext context, {
  required Widget image,
  required String title,
  String? navigateToNamed,
  Function(BuildContext)? onTap,
}) {
  ListTile tile = ListTile(
    key: Key('$image-${title.toString()}'),
    leading: image,
    title: Text(title),
    dense: true,
    onTap: () async {
      if (onTap != null) {
        onTap(context);
        return;
      }

      if (navigateToNamed != null) {
        await getNavigation().navigateAwayFromHomeAsync(
          context,
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
    ));
  }
  return widgets;
}
