import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:settings_ui/settings_ui.dart';

import '../components/drawer.dart';
import '../constants/analytics_event.dart';
import '../contracts/redux/app_state.dart';
import '../redux/setting/settingViewModel.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.settingsPage);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        title: const Text('Settings'),
        showHomeAction: true,
      ),
      drawer: const AppDrawer(),
      builder: (scaffoldContext) => animateWidgetIn(
        child: StoreConnector<AppState, SettingViewModel>(
          converter: (store) => SettingViewModel.fromStore(store),
          builder: (_, viewModel) => getBody(context, viewModel),
        ),
      ),
      // bottomNavigationBar: const BottomNavbar(currentRoute: Routes.home),
    );
  }

  Widget getBody(BuildContext bodyCtx, SettingViewModel viewModel) {
    // Common
    List<AbstractSettingsTile> commonTiles = List.empty(growable: true);

    LocalizationMap currentLocale = getTranslations()
        .getCurrentLocalizationMap(bodyCtx, viewModel.selectedLanguage);
    commonTiles.add(
      SettingsTile.navigation(
        leading: const Icon(Icons.language),
        title: const Text('Language'),
        value: Text(getTranslations().fromKey(currentLocale.name)),
        trailing: SizedBox(
          width: 50,
          height: 50,
          child: Image.asset(
            'icons/flags/png/${currentLocale.countryCode}.png',
            package: 'country_icons',
          ),
        ),
        onPressed: (context) async {
          String? temp = await getTranslations().langaugeSelectionPage(context);
          // if null, no language selected
          if (temp != null) {
            viewModel.setSelectedLanguage(temp);
          }
        },
      ),
    );

    commonTiles.add(
      SettingsTile.switchTile(
        onToggle: (value) {},
        initialValue: true,
        leading: Icon(Icons.format_paint),
        title: Text('Enable custom theme'),
      ),
    );

    return SettingsList(sections: [
      SettingsSection(
        title: const Text('Common'),
        tiles: commonTiles,
      ),
    ]);
  }
}
