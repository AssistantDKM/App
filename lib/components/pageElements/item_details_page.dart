import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/interface/item_base_presenter.dart';
import '../common/cached_future_builder.dart';
import '../scaffoldTemplates/generic_page_scaffold.dart';

class ItemDetailsPage<T extends ItemBasePresenter> extends StatelessWidget {
  final String title;
  final Future<ResultWithValue<T>> Function() getItemFunc;
  final bool isInDetailPane;
  final String Function(T loadedItem) getName;
  final List<Widget> Function(T loadedItem, bool isInDetailPane)
      contractToWidgetList;
  final void Function(Widget newDetailView)? updateDetailView;

  ItemDetailsPage({
    Key? key,
    required this.title,
    required this.getItemFunc,
    required this.getName,
    required this.contractToWidgetList,
    this.isInDetailPane = false,
    this.updateDetailView,
  }) : super(key: key) {
    // getAnalytics().trackEvent('${AnalyticsEvent.itemDetailPage}: $itemId');
  }

  @override
  Widget build(BuildContext context) {
    String loading = getTranslations().fromKey(LocaleKey.loading);
    Widget loadingWidget = getLoading().fullPageLoading(
      context,
      loadingText: loading,
    );
    return CachedFutureBuilder<ResultWithValue<T>>(
      future: getItemFunc(),
      whileLoading: isInDetailPane
          ? loadingWidget
          : genericPageScaffold(
              context,
              loading,
              null,
              body: (_, __) => loadingWidget,
              showShortcutLinks: true,
            ),
      whenDoneLoading: (ResultWithValue<T> snapshot) {
        Widget bodyWidget = getBody(context, snapshot);
        if (isInDetailPane) return bodyWidget;
        return getBaseWidget().appScaffold(
          context,
          appBar: getBaseWidget().appBarForSubPage(
            context,
            title: Text(title),
            showHomeAction: true,
          ),
          body: bodyWidget,
        );
      },
    );
  }

  Widget getBody(
    BuildContext context,
    ResultWithValue<T> snapshot,
  ) {
    isValidFunc(ResultWithValue<T>? gameItemResult) {
      if (gameItemResult == null) return false;
      if (gameItemResult.hasFailed) return false;
      // ignore: unnecessary_null_comparison
      if (gameItemResult.value == null) return false;
      return true;
    }

    if (isValidFunc(snapshot) == false) {
      return getLoading().customErrorWidget(context);
    }

    List<Widget> widgets = [emptySpace1x()];
    widgets.addAll(contractToWidgetList(snapshot.value, isInDetailPane));
    widgets.add(emptySpace10x());

    return listWithScrollbar(
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets[index],
    );
  }
}
