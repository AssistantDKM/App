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
  static const String home = '/';
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
    Routes.home: (BuildContext pageContext) => HomePage(),
    Routes.settings: (_) => SettingsPage(),
    Routes.about: (_) => AboutPage(
          key: const Key('AboutPage'),
          appType: AssistantAppType.dkm,
          aboutPageWidgetsFunc: (BuildContext ctx) {
            return [
              const EmptySpace(0.5),
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
    Routes.patronListPage: (_) => PatronListPage(AnalyticsEvent.patronListPage),
    Routes.whatIsNew: (_) => WhatIsNewPage(
          AnalyticsEvent.whatIsNewDetailPage,
          selectedLanguage: 'en',
        ),
    Routes.favourites: (_) => FavouritesPage(),
    Routes.newsPage: (_) => SteamNewsPage(
          AnalyticsEvent.steamNewsPage,
          AssistantAppType.dkm,
          backupFunc: (_) => Future(() =>
              ResultWithValue<List<SteamNewsItemViewModel>>(
                  false, List.empty(), '')),
        ),

    // Details pages
    Routes.animals: (_) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.animalsPage,
          appJsons: const [
            LocaleKey.bugsJson,
            LocaleKey.critterJson,
            LocaleKey.fishJson,
          ],
          title: 'Animals',
        ),
    Routes.bugs: (_) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.bugsPage,
          appJsons: const [LocaleKey.bugsJson],
          title: 'Bugs',
        ),
    Routes.critters: (_) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.crittersPage,
          appJsons: const [LocaleKey.critterJson],
          title: 'Critters',
        ),
    Routes.fish: (_) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.fishPage,
          appJsons: const [LocaleKey.fishJson],
          title: 'Fish',
        ),

    Routes.crafting: (_) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.inventory,
          appJsons: const [LocaleKey.itemsJson],
          title: 'Items',
        ),
    Routes.cooking: (_) => InventoryListPage(
          analyticsEvent: AnalyticsEvent.cooking,
          appJsons: const [LocaleKey.cookingJson],
          title: 'Cooking',
        ),

    Routes.people: (_) => PeopleListPage(
          analyticsEvent: AnalyticsEvent.people,
          title: 'People',
        ),
    Routes.licence: (_) => LicencesListPage(
          analyticsEvent: AnalyticsEvent.licence,
          title: 'Licence',
        ),
    Routes.milestone: (_) => MilestonesListPage(
          analyticsEvent: AnalyticsEvent.milestone,
          title: 'Milestone',
        ),
  };
  return routes;
}
