import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wiredash/wiredash.dart';

import '../../constants/app_routes.dart';
import '../../contracts/redux/app_state.dart';
import '../../env/app_version_num.dart';
import '../../integration/dependency_injection.dart';
import '../../redux/setting/appshell_viewmodel.dart';
import '../../redux/setting/drawer_settings_viewmodel.dart';
import '../../redux/setting/setting_viewmodel.dart';
import '../../theme/themes.dart';
import '../windows_title_bar.dart';

class AppShell extends StatelessWidget {
  final TranslationsDelegate newLocaleDelegate;
  final void Function(Locale locale) onLocaleChange;
  const AppShell({
    required Key key,
    required this.onLocaleChange,
    required this.newLocaleDelegate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getLog().i("main rebuild");
    Map<String, Widget Function(BuildContext)> routes = initNamedRoutes();
    return StoreConnector<AppState, AppShellViewModel>(
      converter: (store) => AppShellViewModel.fromStore(store),
      builder: (storeCtx, viewModel) => AdaptiveTheme(
        initial: AdaptiveThemeMode.dark,
        light: getDynamicTheme(Brightness.light),
        dark: getDynamicTheme(Brightness.dark),
        builder: (ThemeData theme, ThemeData darkTheme) {
          return _androidApp(
            context,
            key: const Key('app-shell'),
            theme: theme,
            darkTheme: darkTheme,
            initialRoute: Routes.home,
            viewModel: viewModel,
            routes: routes,
            supportedLocales: getLanguage().supportedLocales(),
          );
        },
      ),
    );
  }

  Widget _androidApp(
    BuildContext context, {
    required Key key,
    required ThemeData theme,
    required ThemeData darkTheme,
    required String initialRoute,
    required AppShellViewModel viewModel,
    required Map<String, Widget Function(BuildContext)> routes,
    required List<Locale> supportedLocales,
  }) {
    ScrollBehavior? scrollBehavior;
    if (isWindows) {
      scrollBehavior = const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      );
    }

    Wiredash matApp = Wiredash(
      projectId: getEnv().wiredashProjectId,
      secret: getEnv().wiredashSecret,
      options: WiredashOptionsData(
        locale: getTranslations().getLocaleFromKey(viewModel.selectedLanguage),
      ),
      feedbackOptions: WiredashFeedbackOptions(
        email: EmailPrompt.hidden,
        collectMetaData: (metaData) => metaData
          // information about your app build
          ..buildNumber = appsBuildNum.toString()
          ..buildVersion = appsBuildName
          ..buildCommit = appsCommit

          // custom metadata
          ..custom['isPatron'] = viewModel.isPatron,
      ),
      child: MaterialApp(
        key: key,
        title: 'Assistant for Dinkum',
        theme: theme,
        darkTheme: darkTheme,
        initialRoute: initialRoute,
        routes: routes,
        scrollBehavior: scrollBehavior,
        supportedLocales: supportedLocales,
      ),
    );

    if (!isWindows) return matApp;

    return MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: WindowsTitleBar('Assistant for Dinkum'),
        body: matApp,
      ),
    );
  }
}
