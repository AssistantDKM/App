import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/pageElements/item_page_components.dart';
import '../pages/favourite_page.dart';
import '../pages/inventory_pages.dart';
import '../pages/home_page.dart';
import '../pages/licences_pages.dart';
import '../pages/milestones_pages.dart';
import '../pages/people_pages.dart';
import '../pages/settings_page.dart';
import 'analytics_event.dart';
import 'app_json.dart';

class Routes {
  static const String home = '/home';
  static const String about = '/about';
  static const String settings = '/settings';
  static const String whatIsNew = '/whatIsNew';
  static const String patronListPage = '/patronListPage';
  static const String favourites = '/favourites';
  static const String cart = '/cart';
  static const String newsPage = '/newsPage';
  static const String syncPage = '/syncPage';
  static const String feedback = '/feedback';
  static const String socialLinks = '/socialLinks';

  // Details pages
  static const String animals = '/animals';
  static const String bugs = '/bugs';
  static const String critters = '/critters';
  static const String fish = '/fish';

  static const String cooking = '/cooking';
  static const String crafting = '/crafting';

  static const String people = '/people';
  static const String licence = '/licence';
  static const String milestone = '/milestone';
}

Map<String, Widget Function(BuildContext)> initNamedRoutes() {
  Map<String, WidgetBuilder> routes = {
    Routes.home: (context) => HomePage(),
    Routes.settings: (context) => SettingsPage(),
    Routes.about: (context) => AboutPage(
          key: const Key('AboutPage'),
          appType: AssistantAppType.DKM,
          aboutPageWidgetsFunc: (BuildContext ctx) {
            return [
              emptySpace(0.5),
              pageDefaultPadding(Text(
                getTranslations().fromKey(LocaleKey.aboutContent),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 50,
                style: const TextStyle(fontSize: 16),
              )),
            ];
          },
        ),
    Routes.patronListPage: (context) =>
        PatronListPage(AnalyticsEvent.patronListPage),
    Routes.whatIsNew: (context) => WhatIsNewPage(
          AnalyticsEvent.whatIsNewDetailPage,
          selectedLanguage: 'en',
        ),
    Routes.favourites: (context) => FavouritesPage(),
    Routes.newsPage: (context) => SteamNewsPage(
          AnalyticsEvent.steamNewsPage,
          AssistantAppType.DKM,
          backupFunc: (_) => Future(() =>
              ResultWithValue<List<SteamNewsItemViewModel>>(
                  false, List.empty(), '')),
        ),

    // Details pages
    Routes.animals: (context) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.animalsPage,
          appJsons: const [AppJson.bugs, AppJson.critters, AppJson.fish],
          title: 'Animals',
        ),
    Routes.bugs: (context) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.bugsPage,
          appJsons: const [AppJson.bugs],
          title: 'Bugs',
        ),
    Routes.critters: (context) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.crittersPage,
          appJsons: const [AppJson.critters],
          title: 'Critters',
        ),
    Routes.fish: (context) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.fishPage,
          appJsons: const [AppJson.fish],
          title: 'Fish',
        ),

    Routes.crafting: (context) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.inventory,
          appJsons: const [AppJson.items],
          title: 'Items',
        ),
    Routes.cooking: (context) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.cooking,
          appJsons: const [AppJson.cooking],
          title: 'Cooking',
        ),

    Routes.people: (context) => PeopleListPage(
          analyticsEvent: AnalyticsEvent.people,
          title: 'People',
        ),
    Routes.licence: (context) => LicencesListPage(
          analyticsEvent: AnalyticsEvent.licence,
          title: 'Licence',
        ),
    Routes.milestone: (context) => MilestonesListPage(
          analyticsEvent: AnalyticsEvent.milestone,
          title: 'Milestone',
        ),
  };
  return routes;
}
