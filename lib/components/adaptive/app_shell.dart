import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants/app_image.dart';
import '../../constants/app_routes.dart';
import '../../contracts/redux/app_state.dart';
import '../../env/app_version_num.dart';
import '../../redux/setting/appshell_viewmodel.dart';
import '../../theme/themes.dart';

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
    List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
      newLocaleDelegate,
      GlobalMaterialLocalizations.delegate, //provides localised strings
      GlobalWidgetsLocalizations.delegate, //provides RTL support
    ];
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
            localizationsDelegates: localizationsDelegates,
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
    required List<LocalizationsDelegate<dynamic>> localizationsDelegates,
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

    Widget matApp = FeedbackWrapper(
      options: FeedbackOptions(
        buildNumber: appsBuildNum.toString(),
        buildVersion: appsBuildName,
        buildCommit: appsCommit,
        currentLang: viewModel.selectedLanguage,
        isPatron: viewModel.isPatron,
      ),
      child: MaterialApp(
        key: key,
        title: 'Assistant for Dinkum',
        theme: theme,
        darkTheme: darkTheme,
        initialRoute: initialRoute,
        routes: routes,
        scrollBehavior: scrollBehavior,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        debugShowCheckedModeBanner: false,
      ),
    );

    if (isDesktop) {
      return MaterialApp(
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Scaffold(
            appBar: WindowTitleBar(
              title: 'Assistant for Dinkum',
              iconPath: AppImage.windowIcon,
            ),
            body: matApp,
          ),
        ),
      );
    }

    return MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: matApp),
    );

    // return MaterialApp(
    //   key: key,
    //   title: 'Assistant for Dinkum',
    //   theme: theme,
    //   darkTheme: darkTheme,
    //   home: Center(child: Text('hi')),
    //   scrollBehavior: scrollBehavior,
    //   localizationsDelegates: localizationsDelegates,
    //   supportedLocales: supportedLocales,
    // );
  }
}
