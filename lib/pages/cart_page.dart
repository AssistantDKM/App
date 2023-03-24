import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/tilePresenters/cart_tile_presenter.dart';
import '../constants/analytics_event.dart';
import '../constants/app_padding.dart';
import '../contracts/pageItem/cart_item_page_item.dart';
import '../contracts/redux/app_state.dart';
import '../contracts/required_item.dart';
import '../helper/generic_repository_helper.dart';
import '../redux/cart/cart_viewmodel.dart';
import 'misc/generic_page_all_required_raw_materials.dart';

class CartPage extends StatelessWidget {
  final String analyticsEvent = AnalyticsEvent.cart;

  const CartPage({Key? key}) : super(key: key);

  Future<List<CartItemPageItem>> cartItemsFuture(
    BuildContext futureCtx,
    CartViewModel viewModel,
  ) async {
    List<CartItemPageItem> reqItems = List.empty(growable: true);
    for (RequiredItem cartItem in viewModel.items) {
      var repo = getGenericRepoFromAppId(cartItem.appId);
      if (repo == null) continue;
      var details = await repo.getItem(
        futureCtx,
        cartItem.appId,
      );
      if (details.isSuccess) {
        reqItems.add(CartItemPageItem(
          item: details.value,
          quantity: cartItem.quantity,
        ));
      }
    }
    return reqItems;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CartViewModel>(
      converter: (store) => CartViewModel.fromStore(store),
      builder: (_, viewModel) {
        String title = getTranslations().fromKey(LocaleKey.cart);

        return getBaseWidget().appScaffold(
          context,
          appBar: getBaseWidget().appBarForSubPage(
            context,
            title: Text(title),
            showHomeAction: true,
          ),
          body: ContentHorizontalSpacing(
            child: FutureBuilder<List<CartItemPageItem>>(
              key: Key('${viewModel.items.length}'),
              future: cartItemsFuture(context, viewModel),
              builder: (BuildContext context, snapshot) =>
                  getBody(context, viewModel, snapshot),
            ),
          ),
        );
      },
    );
  }

  Widget getBody(
    BuildContext bodyCtx,
    CartViewModel viewModel,
    AsyncSnapshot<List<CartItemPageItem>> snapshot,
  ) {
    Widget? errorWidget = asyncSnapshotHandler(bodyCtx, snapshot);
    if (errorWidget != null) return errorWidget;

    var requiredItems = snapshot.data!;
    List<Widget> widgets = List.empty(growable: true);

    var tilePresenter = cartTilePresenter(
      isPatron: viewModel.isPatron,
      onEdit: (String appId, int origQuantity) {
        TextEditingController controller =
            TextEditingController(text: origQuantity.toString());
        getDialog().showQuantityDialog(
          bodyCtx,
          controller,
          onSuccess: (BuildContext ctx, String quantity) {
            int? intQuantity = int.tryParse(quantity);
            if (intQuantity == null) return;
            viewModel.editCartItem(appId, intQuantity);
          },
        );
      },
      onDelete: (appId) => viewModel.removeFromCart(appId),
    );

    for (CartItemPageItem cartDetail in requiredItems) {
      widgets.add(tilePresenter(bodyCtx, cartDetail));
    }

    widgets.add(const EmptySpace1x());

    if (requiredItems.isNotEmpty) {
      widgets.add(Padding(
        padding: AppPadding.buttonPadding,
        child: PositiveButton(
          title: getTranslations().fromKey(LocaleKey.viewAllRequiredItems),
          onTap: () async => await getNavigation().navigateAsync(
            bodyCtx,
            navigateTo: (context) => GenericPageAllRequiredRawMaterials(
              name: getTranslations().fromKey(LocaleKey.cart),
              requiredItems: requiredItems
                  .map((req) => RequiredItem(
                        appId: req.appId,
                        quantity: req.quantity,
                      ))
                  .toList(),
            ),
          ),
        ),
      ));
    }

    return listWithScrollbar(
      itemCount: widgets.length,
      itemBuilder: (_, index) => widgets[index],
      scrollController: ScrollController(),
    );
  }
}
