import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart'
    hide ExternalUrls;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:settings_ui/settings_ui.dart';

import '../components/drawer.dart';
import '../constants/analytics_event.dart';
import '../constants/app_image.dart';
import '../constants/external_urls.dart';
import '../contracts/redux/app_state.dart';
import '../env.dart';
import '../env/app_version_num.dart';
import '../helper/text_helper.dart';
import '../redux/setting/setting_viewmodel.dart';

class SettingsPage extends StatelessWidget {
  final void Function(Locale locale) onLocaleChange;

  SettingsPage(this.onLocaleChange, {Key? key}) : super(key: key) {
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
        title: Text(getTranslations().fromKey(LocaleKey.appLanguage)),
        value: Text(getTranslations().fromKey(currentLocale.name)),
        trailing: SizedBox(
          width: 50,
          height: 50,
          child: getCountryFlag(currentLocale.countryCode),
        ),
        onPressed: (context) async {
          String? temp = await getTranslations().langaugeSelectionPage(context);
          // if null, no language selected
          if (temp != null) {
            var newLocale = getTranslations().getLocaleFromKey(temp);
            onLocaleChange(newLocale);

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
          child: const LocalImage(
            imagePath: AppImage.patreon,
            width: 24,
            height: 24,
          ),
        ),
        title: GestureDetector(
          onLongPress: patreonAccessCodePopupFunc,
          child: Text(patreonTitle),
        ),
        initialValue: viewModel.isPatron,
        trailing: GestureDetector(
          onLongPress: patreonAccessCodePopupFunc,
          child: getBaseWidget().adaptiveCheckbox(
            value: viewModel.isPatron,
            onChanged: (_) => patreonModalFunc(),
          ),
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
        onPressed: (pressCtx) async {
          getNavigation().navigateAwayFromHomeAsync(
            pressCtx,
            navigateTo: (navCtx) => const LogsViewPage(),
          );
        },
      ),
    );

    otherTiles.add(
      SettingsTile.navigation(
        leading: const Icon(Icons.description),
        title: Text(getTranslations().fromKey(LocaleKey.privacyPolicy)),
        onPressed: (_) => launchExternalURL(DinkExternalUrls.privacyPolicy),
      ),
    );

    otherTiles.add(
      SettingsTile.navigation(
        leading: const Icon(Icons.description),
        title: Text(getTranslations().fromKey(LocaleKey.termsAndConditions)),
        onPressed: (_) =>
            launchExternalURL(DinkExternalUrls.termsAndConditions),
      ),
    );

    otherTiles.add(
      SettingsTile.navigation(
        leading: const Icon(Icons.description),
        title: Text(getTranslations().fromKey(LocaleKey.legal)),
        onPressed: (context) => showAboutDialog(
          context: context,
          applicationLegalese: getLegalNoticeText(),
          applicationVersion: appsBuildName,
        ),
      ),
    );

    otherTiles.add(
      SettingsTile.navigation(
        leading: const Icon(Icons.bug_report),
        title: const Text('Version info'),
        onPressed: (BuildContext tapCtx) => adaptiveListBottomModalSheet(
          tapCtx,
          hasRoundedCorners: true,
          builder: (_, ScrollController controller) =>
              VersionDebugBottomSheet(controller: controller),
        ),
      ),
    );

    return otherTiles;
  }
}
