import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../components/scaffoldTemplates/generic_page_scaffold.dart';
import '../../components/tilePresenters/required_item_tile_presenter.dart';
import '../../constants/app_padding.dart';
import '../../contracts/redux/app_state.dart';
import '../../contracts/required_item.dart';
import '../../contracts/required_item_details.dart';
import '../../contracts/required_item_tree_details.dart';
import '../../helper/items_helper.dart';
import '../../redux/misc/raw_materials_viewmodel.dart';
import 'generic_page_all_required_raw_materials_tree_components.dart';

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

    return StoreConnector<AppState, RawMaterialsViewModel>(
      converter: (store) => RawMaterialsViewModel.fromStore(store),
      builder: (storeCtx, viewModel) => basicGenericPageScaffold(
        context,
        title: widget.name,
        body: getBody(
          context,
          currentSelection,
          segmentedWidget,
          viewModel.isPatron,
        ),
        // fab: getFloatingActionButton(context, controller, item.genericItem),
      ),
    );
  }

  Widget getBody(
    BuildContext context,
    int currentSelection,
    Widget segmentedWidget,
    bool isPatron,
  ) {
    List<Widget> widgets = List.empty(growable: true);
    if (widget.name.isNotEmpty) {
      widgets.add(const EmptySpace2x());
    }

    widgets.add(Padding(
      padding: AppPadding.buttonPadding,
      child: segmentedWidget,
    ));

    List<RequiredItem> requiredItems = widget.requiredItems;

    if (currentSelection == 0) {
      return FutureBuilder<List<RequiredItemDetails>>(
        future: getAllRequiredItemsForMultiple(context, requiredItems),
        builder: (BuildContext builderContext,
            AsyncSnapshot<List<RequiredItemDetails>> snapshot) {
          List<Widget> listSpecificWidgets = [
            ...widgets,
            ...getFlatListBody(builderContext, snapshot, isPatron)
          ];
          return ContentHorizontalSpacing(
            child: listWithScrollbar(
              itemCount: listSpecificWidgets.length,
              itemBuilder: (builderContext, index) =>
                  listSpecificWidgets[index],
              scrollController: ScrollController(),
            ),
          );
        },
      );
    } else {
      return FutureBuilder<List<RequiredItemTreeDetails>>(
        future: getAllRequiredItemsForTree(context, requiredItems),
        builder: (BuildContext builderContext,
            AsyncSnapshot<List<RequiredItemTreeDetails>> snapshot) {
          var treeSpecificWidgets = [
            ...widgets,
            ...getTreeBody(builderContext, snapshot, isPatron)
          ];
          return ContentHorizontalSpacing(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: treeSpecificWidgets,
            ),
          );
        },
      );
    }
  }

  List<Widget> getFlatListBody(
    BuildContext context,
    AsyncSnapshot<List<RequiredItemDetails>> snapshot,
    bool isPatron,
  ) {
    Widget? errorWidget = asyncSnapshotHandler(context, snapshot);
    if (errorWidget != null) return [errorWidget];

    List<Widget> widgets = List.empty(growable: true);

    if (snapshot.data!.isNotEmpty) {
      for (RequiredItemDetails item in snapshot.data!) {
        widgets.add(requiredItemDetailsBodyTilePresenter(
          context,
          details: item,
          isPatron: isPatron,
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

  List<Widget> getTreeBody(
    BuildContext context,
    AsyncSnapshot<List<RequiredItemTreeDetails>> snapshot,
    bool isPatron,
  ) {
    Widget? errorWidget = asyncSnapshotHandler(context, snapshot);
    if (errorWidget != null) return [errorWidget];

    List<Widget> widgets = List.empty(growable: true);

    if (snapshot.data!.isNotEmpty) {
      widgets.add(Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            getTree(context, snapshot.data!, isPatron),
          ],
        ),
      ));
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

    return widgets;
  }
}
