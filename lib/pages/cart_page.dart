import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/tilePresenters/cart_tile_presenter.dart';
import '../constants/analytics_event.dart';
import '../contracts/pageItem/cart_item_page_item.dart';
import '../contracts/redux/app_state.dart';
import '../contracts/redux/cart_item_state.dart';
import '../helper/generic_repository_helper.dart';
import '../helper/search_helper.dart';
import '../redux/cart/cart_viewmodel.dart';

class CartPage extends StatelessWidget {
  final String analyticsEvent = AnalyticsEvent.cart;

  const CartPage({Key? key}) : super(key: key);

  Future<ResultWithValue<List<CartItemPageItem>>> cartItemsFuture(
    context,
    CartViewModel viewModel,
  ) async {
    List<CartItemPageItem> reqItems = List.empty(growable: true);
    for (CartItem cartItem in viewModel.items) {
      var details = await getGenericRepoFromAppId(cartItem.appId).getItem(
        context,
        cartItem.appId,
      );
      if (details.isSuccess) {
        reqItems.add(CartItemPageItem(
          item: details.value,
          quantity: cartItem.quantity,
        ));
      }
    }
    return ResultWithValue(true, reqItems, '');
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CartViewModel>(
      converter: (store) => CartViewModel.fromStore(store),
      builder: (_, viewModel) {
        String title = getTranslations().fromKey(LocaleKey.cart);
        var tilePresenter = cartTilePresenter(
          isPatron: viewModel.isPatron,
          onDelete: (appId) => viewModel.removeFromCart(appId),
        );

        return getBaseWidget().appScaffold(
          context,
          appBar: getBaseWidget().appBarForSubPage(
            context,
            title: Text(title),
            showHomeAction: true,
          ),
          body: ContentHorizontalSpacing(
            child: SearchableList<CartItemPageItem>(
              () => cartItemsFuture(context, viewModel),
              listItemDisplayer: tilePresenter,
              listItemSearch: searchCartItemPageItem,
              addFabPadding: true,
              minListForSearch: 10,
              key: Key(viewModel.items.length.toString()),
            ),
          ),
        );
      },
    );
  }
}
