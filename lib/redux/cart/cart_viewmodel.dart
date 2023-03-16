import 'package:redux/redux.dart';

import '../../contracts/redux/app_state.dart';
import '../../contracts/redux/cart_item_state.dart';
import '../setting/selector.dart';
import 'actions.dart';
import 'selector.dart';

class CartViewModel {
  List<CartItem> items;
  final bool isPatron;
  Function(String appId, int quantity) addToCart;
  Function(String appId) removeFromCart;

  CartViewModel({
    required this.items,
    required this.addToCart,
    required this.removeFromCart,
    required this.isPatron,
  });

  static CartViewModel fromStore(Store<AppState> store) => CartViewModel(
        items: getCartItems(store.state),
        isPatron: getIsPatron(store.state),
        addToCart: (String appId, int quantity) => store.dispatch(
          AddToCartAction(
            appId: appId,
            quantity: quantity,
          ),
        ),
        removeFromCart: (String appId) => store.dispatch(
          RemoveFromCartAction(appId),
        ),
      );
}
