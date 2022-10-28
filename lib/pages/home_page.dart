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
            'Crafting',
            Routes.crafting,
          ),
          smallLandscapeRectTile(
            context,
            AppImage.fishLogo,
            'Fish',
            Routes.fish,
          ),
          largeSquareTile(
            context,
            AppImage.foodLogo,
            'Food',
            Routes.cooking,
          ),
          smallLandscapeRectTile(
            context,
            AppImage.peopleLogo,
            'People',
            Routes.people,
          ),
          // smallLandscapeRectTile(
          //   context,
          //   AppImage.licencesLogo,
          //   'Licences',
          //   Routes.licence,
          // ),
          // smallLandscapeRectTile(
          //   context,
          //   AppImage.milestonesLogo,
          //   'Milestones',
          //   Routes.milestone,
          // ),
        ];

        Widget Function(BuildContext) pageBuilder;
        pageBuilder = (scaffoldContext) {
          return SingleChildScrollView(
            child: responsiveStaggeredGrid(items: itemBuilders),
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
                  emptySpace2x(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: genericItemDescription(getLegalNoticeText()),
                  ),
                  emptySpace2x(),
                  flatCard(
                    child: externalLinkPresenter(
                      scaffoldContext,
                      'Licence & Milestone data from dinkumapi.com',
                      'https://github.com/liamsnowdon/dinkum-api-data',
                    ),
                  ),
                  emptySpace2x(),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            getTheme().getSecondaryColour(scaffoldContext)),
                      ),
                      child: Text(
                        getTranslations().fromKey(LocaleKey.noticeAccept),
                      ),
                      onPressed: () => viewModel.setHasAcceptedIntro(),
                    ),
                  ),
                ],
              ),
            );
          };
        }

        return getBaseWidget().appScaffold(
          context,
          appBar: homePageAppBar('Home'),
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

StaggeredGridTileItem smallLandscapeRectTile(BuildContext homeCardCtx,
        String imagePath, String text, String navigateToNamed) =>
    StaggeredGridTileItem(
        2, 1, baseHomeCard(homeCardCtx, imagePath, text, navigateToNamed));

StaggeredGridTileItem smallSquareTile(BuildContext homeCardCtx,
        String imagePath, String text, String navigateToNamed) =>
    StaggeredGridTileItem(
        1, 1, baseHomeCard(homeCardCtx, imagePath, text, navigateToNamed));
