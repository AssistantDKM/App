import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/adaptive/homepage_appbar.dart';
import '../components/drawer.dart';
import '../constants/analytics_event.dart';
import '../constants/app_image.dart';
import '../constants/app_routes.dart';
import '../contracts/redux/app_state.dart';
import '../helper/text_helper.dart';
import '../redux/misc/homepage_viewmodel.dart';

class HomePage extends StatelessWidget {
  final Color drawerIconColour = getTheme().getDarkModeSecondaryColour();

  HomePage({Key? key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.homePage);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomePageViewModel>(
      converter: (store) => HomePageViewModel.fromStore(store),
      builder: (_, viewModel) {
        List<StaggeredGridTileItem> itemBuilders = [
          largeSquareTile(
            context,
            AppImage.animalsLogo,
            getTranslations().fromKey(LocaleKey.menuAnimals),
            Routes.animals,
          ),
          smallSquareTile(
            context,
            AppImage.bugsLogo,
            getTranslations().fromKey(LocaleKey.menuBugs),
            Routes.bugs,
          ),
          smallSquareTile(
            context,
            AppImage.crittersLogo,
            getTranslations().fromKey(LocaleKey.menuCritters),
            Routes.critters,
          ),
          largeSquareTile(
            context,
            AppImage.itemsLogo,
            getTranslations().fromKey(LocaleKey.menuCrafting),
            Routes.crafting,
          ),
          smallLandscapeRectTile(
            context,
            AppImage.fishLogo,
            getTranslations().fromKey(LocaleKey.menuFish),
            Routes.fish,
          ),
          largeSquareTile(
            context,
            AppImage.foodLogo,
            getTranslations().fromKey(LocaleKey.menuFood),
            Routes.cooking,
          ),
          smallLandscapeRectTile(
            context,
            AppImage.peopleLogo,
            getTranslations().fromKey(LocaleKey.menuPeople),
            Routes.people,
          ),
          smallLandscapeRectTile(
            context,
            AppImage.licencesLogo,
            getTranslations().fromKey(LocaleKey.menuLicences),
            Routes.licence,
          ),
          smallLandscapeRectTile(
            context,
            AppImage.milestonesLogo,
            getTranslations().fromKey(LocaleKey.menuMilestones),
            Routes.milestone,
          ),
        ];

        Widget Function(BuildContext) pageBuilder;
        pageBuilder = (scaffoldContext) {
          return SingleChildScrollView(
            child: ResponsiveStaggeredGrid(items: itemBuilders),
          );
        };

        if (viewModel.hasAcceptedIntro == false) {
          pageBuilder = (BuildContext scaffoldContext) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                    title: const Text('Please read and accept notice below'),
                    tileColor: Colors.red[900],
                    // onTap: () => getNavigation().navigateAwayFromHomeAsync(
                    //   homeCardCtx,
                    //   navigateToNamed: navigateToNamed,
                    // ),
                  ),
                  const EmptySpace2x(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GenericItemDescription(getLegalNoticeText()),
                  ),
                  const EmptySpace2x(),
                  Center(
                    child: PositiveButton(
                      title: getTranslations().fromKey(LocaleKey.noticeAccept),
                      onTap: () => viewModel.setHasAcceptedIntro(),
                    ),
                  ),
                ],
              ),
            );
          };
        }

        return getBaseWidget().appScaffold(
          context,
          appBar: HomePageAppBar('Home'),
          drawer: const AppDrawer(),
          builder: pageBuilder,
          // bottomNavigationBar: const BottomNavbar(currentRoute: Routes.home),
        );
      },
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
              child: LocalImage(imagePath: imagePath),
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

StaggeredGridTileItem smallLandscapeRectTile(BuildContext homeCardCtx,
        String imagePath, String text, String navigateToNamed) =>
    StaggeredGridTileItem(
        2, 1, baseHomeCard(homeCardCtx, imagePath, text, navigateToNamed));

StaggeredGridTileItem smallSquareTile(BuildContext homeCardCtx,
        String imagePath, String text, String navigateToNamed) =>
    StaggeredGridTileItem(
        1, 1, baseHomeCard(homeCardCtx, imagePath, text, navigateToNamed));
