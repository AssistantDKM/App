import 'package:assistant_dinkum_app/constants/app_padding.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/scaffoldTemplates/generic_page_scaffold.dart';
import '../../components/tilePresenters/required_item_tile_presenter.dart';
import '../../contracts/required_item.dart';
import '../../contracts/required_item_details.dart';
import '../../helper/items_helper.dart';

class GenericPageAllRequiredRawMaterials extends StatefulWidget {
  final String name;
  final List<RequiredItem> requiredItems;
  const GenericPageAllRequiredRawMaterials({
    Key? key,
    required this.name,
    required this.requiredItems,
  }) : super(key: key);

  @override
  createState() => _GenericPageAllRequiredRawMaterialsWidget();
}

class _GenericPageAllRequiredRawMaterialsWidget
    extends State<GenericPageAllRequiredRawMaterials> {
  int currentSelection = 0;

  _GenericPageAllRequiredRawMaterialsWidget() {
    // getAnalytics().trackEvent(AnalyticsEvent.genericAllRequiredRawMaterialsPage);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [
      SegmentedControlWithIconOption(
        icon: Icons.list,
        text: getTranslations().fromKey(LocaleKey.flatList),
      ),
      SegmentedControlWithIconOption(
        icon: Icons.call_split,
        text: getTranslations().fromKey(LocaleKey.tree),
      )
    ];
    Container segmentedWidget = Container(
      margin: const EdgeInsets.all(8),
      child: AdaptiveSegmentedControl(
        controlItems: options,
        currentSelection: currentSelection,
        onSegmentChosen: (index) {
          setState(() {
            currentSelection = index;
          });
        },
      ),
    );

    return basicGenericPageScaffold(
      context,
      title: widget.name,
      body: getBody(context, currentSelection, segmentedWidget),
      // fab: getFloatingActionButton(context, controller, item.genericItem),
    );
  }

  List<Widget> getFlatListBody(
    BuildContext context,
    AsyncSnapshot<List<RequiredItemDetails>> snapshot,
  ) {
    Widget? errorWidget = asyncSnapshotHandler(context, snapshot);
    if (errorWidget != null) return [errorWidget];

    List<Widget> widgets = List.empty(growable: true);

    if (snapshot.data!.isNotEmpty) {
      for (RequiredItemDetails item in snapshot.data!) {
        widgets.add(requiredItemDetailsBodyTilePresenter(
          context,
          details: item,
        ));
      }
    } else {
      widgets.add(
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: Text(
            getTranslations().fromKey(LocaleKey.noItems),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );
    }

    widgets.add(const EmptySpace8x());

    return widgets;
  }

  // List<Widget> getTreeBody(
  //   BuildContext context,
  //   AsyncSnapshot<List<RequiredItemTreeDetails>> snapshot,
  // ) {
  //   Widget? errorWidget = asyncSnapshotHandler(context, snapshot);
  //   if (errorWidget != null) return [errorWidget];

  //   List<Widget> widgets = List.empty(growable: true);

  //   if (snapshot.data!.isNotEmpty) {
  //     widgets.add(Expanded(
  //       child: ListView(
  //         shrinkWrap: true,
  //         children: [
  //           getTree(context, snapshot.data!, CurrencyType.NONE),
  //         ],
  //       ),
  //     ));
  //   } else {
  //     widgets.add(
  //       Container(
  //         margin: const EdgeInsets.only(top: 30),
  //         child: Text(
  //           getTranslations().fromKey(LocaleKey.noItems),
  //           textAlign: TextAlign.center,
  //           overflow: TextOverflow.ellipsis,
  //           style: const TextStyle(fontSize: 20),
  //         ),
  //       ),
  //     );
  //   }

  //   return widgets;
  // }

  Widget getBody(
    BuildContext context,
    int currentSelection,
    Widget segmentedWidget,
  ) {
    List<Widget> widgets = List.empty(growable: true);
    if (widget.name.isNotEmpty) {
      widgets.add(const EmptySpace1x());
      widgets.add(GenericItemName(widget.name));
      widgets.add(GenericItemText(
        getTranslations().fromKey(LocaleKey.allRawMaterialsRequired),
      ));
    }

    widgets.add(Padding(
      padding: AppPadding.buttonPadding,
      child: segmentedWidget,
    ));

    List<RequiredItem> requiredItems = widget.requiredItems;

    // if (currentSelection == 0) {
    return FutureBuilder<List<RequiredItemDetails>>(
      future: getAllRequiredItemsForMultiple(context, requiredItems),
      builder: (BuildContext builderContext,
          AsyncSnapshot<List<RequiredItemDetails>> snapshot) {
        List<Widget> listSpecificWidgets = [
          ...widgets,
          ...getFlatListBody(builderContext, snapshot)
        ];
        return listWithScrollbar(
          itemCount: listSpecificWidgets.length,
          itemBuilder: (builderContext, index) => listSpecificWidgets[index],
          scrollController: ScrollController(),
        );
      },
    );
    // } else {
    //   return FutureBuilder<List<RequiredItemTreeDetails>>(
    //     future: getAllRequiredItemsForTree(context, requiredItems),
    //     builder: (BuildContext builderContext,
    //         AsyncSnapshot<List<RequiredItemTreeDetails>> snapshot) {
    //       var treeSpecificWidgets = [
    //         ...widgets,
    //         ...getTreeBody(builderContext, snapshot)
    //       ];
    //       return Column(
    //         children: treeSpecificWidgets,
    //         mainAxisSize: MainAxisSize.max,
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //       );
    //     },
    //   );
    // }
  }
}
