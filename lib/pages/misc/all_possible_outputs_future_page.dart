import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/scaffoldTemplates/generic_page_scaffold.dart';

class AllPossibleOutputsFromFuturePage<T> extends StatelessWidget {
  final Future<List<T>> Function() requiredItemsFuture;
  final String title;
  final Widget Function(BuildContext context, T p) presenter;

  const AllPossibleOutputsFromFuturePage(
    this.requiredItemsFuture,
    this.title,
    this.presenter, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return basicGenericPageScaffold(
      context,
      title: title,
      body: getBody(context),
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
          padding: const EdgeInsets.only(bottom: 64),
        );
      },
    );
  }
}
