import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/pageElements/item_page_components.dart';
import '../../components/scaffoldTemplates/generic_page_scaffold.dart';

class AllPossibleOutputsFromFuturePage<T> extends StatelessWidget {
  final Future<List<T>> Function() requiredItemsFuture;
  final String title;
  final String? subtitle;
  final bool hideAppBar;
  final Widget Function(BuildContext context, T p) presenter;

  const AllPossibleOutputsFromFuturePage(
    this.requiredItemsFuture,
    this.title,
    this.presenter, {
    Key? key,
    this.subtitle,
    this.hideAppBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body = getBody(context);
    if (hideAppBar) {
      return Column(
        children: [
          const EmptySpace2x(),
          GenericItemName(title),
          const EmptySpace1x(),
          if (subtitle != null && subtitle!.isNotEmpty) ...[
            pageDefaultPadding(GenericItemDescription(subtitle!)),
            const EmptySpace1x(),
          ],
          getBaseWidget().customDivider(),
          const EmptySpace1x(),
          Expanded(child: body),
        ],
      );
    }

    return basicGenericPageScaffold(
      context,
      title: title,
      body: body,
    );
  }

  Widget getBody(BuildContext context) {
    return CachedFutureBuilder<List<T>>(
      future: requiredItemsFuture(),
      whileLoading: () => getLoading().fullPageLoading(context),
      whenDoneLoading: (data) {
        if (data.isEmpty) {
          return Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              getTranslations().fromKey(LocaleKey.noItems),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20),
            ),
          );
        }

        return listWithScrollbar(
          itemCount: data.length,
          itemBuilder: (context, index) => presenter(context, data[index]),
          scrollController: ScrollController(),
          padding: const EdgeInsets.only(top: 8, bottom: 64),
        );
      },
    );
  }
}
