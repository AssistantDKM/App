import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart'
    hide ExternalUrls;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:settings_ui/settings_ui.dart';

import '../components/adaptive/checkbox.dart';
import '../components/drawer.dart';
import '../constants/analytics_event.dart';
import '../constants/app_image.dart';
import '../constants/external_urls.dart';
import '../contracts/redux/app_state.dart';
import '../env.dart';
import '../env/app_version_num.dart';
import '../redux/setting/setting_viewmodel.dart';

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
    return SettingsList(sections: [
      SettingsSection(
        title: Text(getTranslations().fromKey(LocaleKey.general)),
        tiles: getCommonTiles(bodyCtx, viewModel),
      ),
      SettingsSection(
        title: Text(getTranslations().fromKey(LocaleKey.other)),
        tiles: getOtherTiles(bodyCtx, viewModel),
      ),
    ]);
  }

  List<AbstractSettingsTile> getCommonTiles(
    BuildContext bodyCtx,
    SettingViewModel viewModel,
  ) //
  {
    List<AbstractSettingsTile> commonTiles = List.empty(growable: true);

    LocalizationMap currentLocale = getTranslations()
        .getCurrentLocalizationMap(bodyCtx, viewModel.selectedLanguage);
    commonTiles.add(
      SettingsTile.navigation(
        leading: const Icon(Icons.language),
        title: const Text('Language'),
        enabled: false,
        value: Text(getTranslations().fromKey(currentLocale.name)),
        trailing: Opacity(
          opacity: 0.5,
          child: SizedBox(
            width: 50,
            height: 50,
            child: getCountryFlag(currentLocale.countryCode),
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

    String patreonTitle = getTranslations().fromKey(LocaleKey.patreonAccess);
    Future<void> Function() patreonAccessCodePopupFunc;
    patreonAccessCodePopupFunc = () async {
      String code = await getDialog().asyncInputDialog(
        bodyCtx,
        patreonTitle,
      );
      String newName = (code.isEmpty) ? '' : code;
      bool codeIsCorrect = Patreon.codes.any(
        (code) => code == newName.toUpperCase(),
      );
      if (codeIsCorrect) {
        viewModel.setIsPatron(true);
      }
    };
    Future<void> Function() patreonModalFunc;
    patreonModalFunc = () async {
      if (viewModel.isPatron) {
        viewModel.setIsPatron(false);
        return;
      }
      adaptiveBottomModalSheet(
        bodyCtx,
        hasRoundedCorners: true,
        builder: (BuildContext innerC) => PatreonLoginModalBottomSheet(
          AnalyticsEvent.patreonOAuthLogin,
          (Result loginResult) {
            if (loginResult.isSuccess) {
              viewModel.setIsPatron(true);
            } else {
              getLog()
                  .d('patreonOAuthLogin message ${loginResult.errorMessage}');
            }
          },
        ),
      );
    };
    commonTiles.add(
      SettingsTile.switchTile(
        leading: GestureDetector(
          onLongPress: patreonAccessCodePopupFunc,
          child: localImage(AppImage.patreon, width: 24, height: 24),
        ),
        title: GestureDetector(
          onLongPress: patreonAccessCodePopupFunc,
          child: Text(patreonTitle),
        ),
        initialValue: viewModel.isPatron,
        trailing: CustomCheckbox(
          value: viewModel.isPatron,
          onLongPress: patreonAccessCodePopupFunc,
          onTap: patreonModalFunc,
        ),
        onToggle: (value) => patreonModalFunc(),
      ),
    );

    return commonTiles;
  }

  List<AbstractSettingsTile> getOtherTiles(
    BuildContext bodyCtx,
    SettingViewModel viewModel,
  ) //
  {
    List<AbstractSettingsTile> otherTiles = List.empty(growable: true);

    otherTiles.add(
      SettingsTile.navigation(
        leading: const Icon(Icons.code),
        title: const Text('Logs'),
        onPressed: (context) async {
          adaptiveBottomModalSheet(
            context,
            hasRoundedCorners: true,
            builder: (BuildContext innerContext) =>
                const LogsModalBottomSheet(title: 'Logs'),
          );
        },
      ),
    );

    otherTiles.add(
      SettingsTile.navigation(
        leading: const Icon(Icons.description),
        title: Text(getTranslations().fromKey(LocaleKey.privacyPolicy)),
        onPressed: (context) =>
            launchExternalURL(DinkExternalUrls.privacyPolicy),
      ),
    );

    otherTiles.add(
      SettingsTile.navigation(
        leading: const Icon(Icons.description),
        title: Text(getTranslations().fromKey(LocaleKey.termsAndConditions)),
        onPressed: (context) =>
            launchExternalURL(DinkExternalUrls.termsAndConditions),
      ),
    );

    otherTiles.add(
      SettingsTile.navigation(
        leading: const Icon(Icons.description),
        title: Text(getTranslations().fromKey(LocaleKey.legal)),
        onPressed: (context) => showAboutDialog(
          context: context,
          applicationLegalese: getTranslations().fromKey(LocaleKey.legalNotice),
          applicationVersion: appsBuildName,
        ),
      ),
    );

    return otherTiles;
  }
}
