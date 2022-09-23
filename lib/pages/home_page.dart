import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/adaptive/homepage_appbar.dart';
import '../components/drawer.dart';
import '../constants/analytics_event.dart';
import '../constants/app_image.dart';
import '../constants/app_routes.dart';

class HomePage extends StatelessWidget {
  final Color drawerIconColour = getTheme().getDarkModeSecondaryColour();

  HomePage({Key? key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.homePage);
  }

  @override
  Widget build(BuildContext context) {
    List<StaggeredGridTileItem> itemBuilders = [
      largeSquareTile(
        context,
        AppImage.animalsLogo,
        'Animals',
        Routes.animals,
      ),
      smallSquareTile(
        context,
        AppImage.bugsLogo,
        'Bugs',
        Routes.bugs,
      ),
      smallSquareTile(
        context,
        AppImage.crittersLogo,
        'Critters',
        Routes.critters,
      ),
      largeSquareTile(
        context,
        AppImage.itemsLogo,
        'Items',
        Routes.crafting,
      ),
      smallLanscapeRectTile(
        context,
        AppImage.fishLogo,
        'Fish',
        Routes.fish,
      ),
      largeSquareTile(
        context,
        AppImage.foodLogo,
        'Food',
        Routes.food,
      ),
      smallLanscapeRectTile(
        context,
        AppImage.peopleLogo,
        'People',
        Routes.people,
      ),
      smallLanscapeRectTile(
        context,
        AppImage.licencesLogo,
        'Licences',
        Routes.licence,
      ),
      smallLanscapeRectTile(
        context,
        AppImage.milestonesLogo,
        'Milestones',
        Routes.milestone,
      ),
    ];
    return getBaseWidget().appScaffold(
      context,
      appBar: homePageAppBar('Home'),
      drawer: const AppDrawer(),
      builder: (scaffoldContext) => animateWidgetIn(
        child: SingleChildScrollView(
          child: responsiveStaggeredGrid(items: itemBuilders),
        ),
      ),
      // bottomNavigationBar: const BottomNavbar(currentRoute: Routes.home),
    );
  }
}

Widget baseHomeCard(
  BuildContext homeCardCtx,
  String imagePath,
  String text,
  String navigateToNamed,
) {
  return Card(
    child: InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: localImage(imagePath),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
      onTap: () => getNavigation().navigateAwayFromHomeAsync(
        homeCardCtx,
        navigateToNamed: navigateToNamed,
      ),
    ),
  );
}

StaggeredGridTileItem largeSquareTile(BuildContext homeCardCtx,
        String imagePath, String text, String navigateToNamed) =>
    StaggeredGridTileItem(
        2, 2, baseHomeCard(homeCardCtx, imagePath, text, navigateToNamed));

StaggeredGridTileItem smallLanscapeRectTile(BuildContext homeCardCtx,
        String imagePath, String text, String navigateToNamed) =>
    StaggeredGridTileItem(
        2, 1, baseHomeCard(homeCardCtx, imagePath, text, navigateToNamed));

StaggeredGridTileItem smallSquareTile(BuildContext homeCardCtx,
        String imagePath, String text, String navigateToNamed) =>
    StaggeredGridTileItem(
        1, 1, baseHomeCard(homeCardCtx, imagePath, text, navigateToNamed));
