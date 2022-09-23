import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constants/app_routes.dart';
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
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.dark,
      light: getDynamicTheme(Brightness.light),
      dark: getDynamicTheme(Brightness.dark),
      builder: (ThemeData theme, ThemeData darkTheme) {
        return _androidApp(
          context,
          const Key('app-shell'),
          theme,
          darkTheme,
          Routes.home,
          routes,
          getLanguage().supportedLocales(),
        );
      },
    );
  }

  Widget _androidApp(
    BuildContext context,
    Key key,
    ThemeData theme,
    ThemeData darkTheme,
    String initialRoute,
    Map<String, Widget Function(BuildContext)> routes,
    List<Locale> supportedLocales,
  ) {
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

    MaterialApp matApp = MaterialApp(
      key: key,
      title: 'Assistant for Dinkum',
      theme: theme,
      darkTheme: darkTheme,
      initialRoute: initialRoute,
      routes: routes,
      scrollBehavior: scrollBehavior,
      supportedLocales: supportedLocales,
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
