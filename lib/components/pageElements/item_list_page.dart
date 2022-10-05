import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/interface/item_base_presenter.dart';

class ItemsListPage<T extends ItemBasePresenter> extends StatelessWidget {
  final String title;
  final Future<ResultWithValue<List<T>>> Function() getItemsFunc;
  final Widget Function(BuildContext, T, int, {void Function()? onTap})
      listItemDisplayer;
  final bool Function(T, String)? listItemSearch;
  final Widget Function(
    String id,
    bool isInDetailPane,
    void Function(Widget)? updateDetailView,
  ) detailPageFunc;
  final int minListForSearch;

  ItemsListPage({
    Key? key,
    this.listItemSearch,
    required String analyticsEvent,
    required this.title,
    required this.getItemsFunc,
    required this.listItemDisplayer,
    required this.detailPageFunc,
    this.minListForSearch = 10,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsEvent);
  }

  @override
  Widget build(BuildContext context) {
    bool Function(T, String) listItemSearchLocal = listItemSearch ??
        (item, search) =>
            item.name.toLowerCase().contains(search.toLowerCase());
    //
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        title: Text(title),
        showHomeAction: true,
      ),
      body: ResponsiveListDetailView<T>(
        () => getItemsFunc(),
        listItemDisplayer,
        listItemSearchLocal,
        listItemMobileOnTap: (BuildContext context, T invItem) {
          getNavigation().navigateAwayFromHomeAsync(
            context,
            navigateTo: (newCtx) => detailPageFunc(invItem.appId, false, null),
          );
        },
        listItemDesktopOnTap: (
          BuildContext context,
          T animalItem,
          void Function(Widget) updateDetailView,
        ) {
          return detailPageFunc(animalItem.appId, true, updateDetailView);
        },
        addFabPadding: true,
        minListForSearch: minListForSearch,
        // key: Key(getTranslations().currentLanguage),
      ),
      // bottomNavigationBar: const BottomNavbar(currentRoute: Routes.allItems),
    );
  }
}
