import 'package:assistant_dinkum_app/constants/app_routes.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/adaptive/homepage_appbar.dart';
import '../components/drawer.dart';
import '../constants/analytics_event.dart';
import '../constants/app_image.dart';

class HomePage extends StatelessWidget {
  final Color drawerIconColour = getTheme().getDarkModeSecondaryColour();

  HomePage({Key? key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.homePage);
  }

  @override
  Widget build(BuildContext context) {
    List<StaggeredGridTile> itemBuilders = [
      largeSquareTile(
        baseHomeCard(
          context,
          AppImage.animalsLogo,
          'Animals',
          Routes.animals,
        ),
      ),
      smallSquareTile(
        baseHomeCard(
          context,
          AppImage.bugsLogo,
          'Bugs',
          Routes.bugs,
        ),
      ),
      smallSquareTile(
        baseHomeCard(
          context,
          AppImage.crittersLogo,
          'Critters',
          Routes.critters,
        ),
      ),
      largeSquareTile(
        baseHomeCard(
          context,
          AppImage.itemsLogo,
          'Items',
          Routes.crafting,
        ),
      ),
      smallLanscapeRectTile(
        baseHomeCard(
          context,
          AppImage.fishLogo,
          'Fish',
          Routes.fish,
        ),
      ),
      largeSquareTile(
        baseHomeCard(
          context,
          AppImage.foodLogo,
          'Food',
          Routes.food,
        ),
      ),
      smallLanscapeRectTile(
        baseHomeCard(
          context,
          AppImage.peopleLogo,
          'People',
          Routes.people,
        ),
      ),
      smallLanscapeRectTile(
        baseHomeCard(
          context,
          AppImage.licencesLogo,
          'Licences',
          Routes.licence,
        ),
      ),
      smallLanscapeRectTile(
        baseHomeCard(
          context,
          AppImage.milestonesLogo,
          'Milestones',
          Routes.bugs,
        ),
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

StaggeredGridTile largeSquareTile(Widget innerChild) {
  return StaggeredGridTile.count(
    crossAxisCellCount: 2,
    mainAxisCellCount: 2,
    child: innerChild,
  );
}

StaggeredGridTile smallLanscapeRectTile(Widget innerChild) {
  return StaggeredGridTile.count(
    crossAxisCellCount: 2,
    mainAxisCellCount: 1,
    child: innerChild,
  );
}

StaggeredGridTile smallSquareTile(Widget innerChild) {
  return StaggeredGridTile.count(
    crossAxisCellCount: 1,
    mainAxisCellCount: 1,
    child: innerChild,
  );
}
