import 'package:flutter/material.dart';

import '../pages/animal_pages.dart';
import '../pages/food_pages.dart';
import '../pages/home_page.dart';
import '../pages/licences_pages.dart';
import '../pages/people_pages.dart';
import '../pages/settings_page.dart';
import 'analytics_event.dart';
import 'app_json.dart';

class Routes {
  static const String home = '/home';
  static const String about = '/about';
  static const String settings = '/settings';

  // Details pages
  static const String animals = '/animals';
  static const String bugs = '/bugs';
  static const String critters = '/critters';
  static const String fish = '/fish';

  static const String food = '/food';
  static const String consumable = '/consumable';
  static const String cooking = '/cooking';

  static const String crafting = '/crafting';
  static const String people = '/people';
  static const String licence = '/licence';

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

    Routes.food: (context) => FoodListPage(
          analyticsEvent: AnalyticsEvent.food,
          appJsons: const [AppJson.consumables, AppJson.cooking],
          title: 'Food',
        ),
    Routes.consumable: (context) => FoodListPage(
          analyticsEvent: AnalyticsEvent.consumable,
          appJsons: const [AppJson.consumables],
          title: 'Consumable',
        ),
    Routes.cooking: (context) => FoodListPage(
          analyticsEvent: AnalyticsEvent.cooking,
          appJsons: const [AppJson.cooking],
          title: 'Cooking',
        ),

    Routes.crafting: (context) => FoodListPage(
          analyticsEvent: AnalyticsEvent.crafting,
          appJsons: const [AppJson.crafting],
          title: 'Crafting',
        ),

    Routes.people: (context) => PeopleListPage(
          analyticsEvent: AnalyticsEvent.people,
          title: 'People',
        ),
    Routes.licence: (context) => LicencesListPage(
          analyticsEvent: AnalyticsEvent.licence,
          title: 'Licence',
        ),
  };
  return routes;
}
