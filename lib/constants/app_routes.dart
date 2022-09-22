import 'package:assistant_dinkum_app/constants/analytics_event.dart';
import 'package:assistant_dinkum_app/constants/app_json.dart';
import 'package:flutter/material.dart';

import '../pages/animal_pages.dart';
import '../pages/home_page.dart';
import '../pages/settings_page.dart';

class Routes {
  static const String home = '/home';
  static const String about = '/about';
  static const String settings = '/settings';

  // Details pages
  static const String animals = '/animals';
  static const String bugs = '/bugs';
  static const String critters = '/critters';
  static const String fish = '/fish';

  static const String itemIdParam = 'itemId';
  static const String bugDetails = '/bug/:$itemIdParam';
}

Map<String, Widget Function(BuildContext)> initNamedRoutes() {
  Map<String, WidgetBuilder> routes = {
    Routes.home: (context) => HomePage(),
    Routes.settings: (context) => SettingsPage(),
    // Routes.about: (context) => const AboutPage(),

    // Details pages
    Routes.animals: (context) => AnimalsListPage(
          analyticsEvent: AnalyticsEvent.animalsPage,
          appJsons: const [AppJson.bugs, AppJson.critters, AppJson.fish],
          title: 'Animals',
        ),
    Routes.bugs: (context) => AnimalsListPage(
          analyticsEvent: AnalyticsEvent.bugsPage,
          appJsons: const [AppJson.bugs],
          title: 'Bugs',
        ),
    Routes.critters: (context) => AnimalsListPage(
          analyticsEvent: AnalyticsEvent.crittersPage,
          appJsons: const [AppJson.critters],
          title: 'Critters',
        ),
    Routes.fish: (context) => AnimalsListPage(
          analyticsEvent: AnalyticsEvent.fishPage,
          appJsons: const [AppJson.fish],
          title: 'Fish',
        ),
  };
  return routes;
}
