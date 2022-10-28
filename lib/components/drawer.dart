import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../constants/app_image.dart';
import '../contracts/redux/app_state.dart';
import '../redux/setting/drawer_settings_viewmodel.dart';
import 'helper/drawer_helper.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  //
  Widget drawerWrapper(BuildContext drawerCtx, List<Widget> widgets) {
    String path = AppImage.drawerHeader;
    return Drawer(
      child: ListView(
        children: [
          emptySpace1x(),
          SizedBox(
            height: 100.0,
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(path),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: null,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
            ),
          ),
          ...widgets,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DrawerSettingsViewModel>(
      converter: (store) => DrawerSettingsViewModel.fromStore(store),
      builder: (storeCtx, viewModel) => drawerWrapper(
        context,
        getDrawerItems(context, viewModel),
      ),
    );
  }
}
