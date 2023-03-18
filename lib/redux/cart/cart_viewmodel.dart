import 'package:redux/redux.dart';

import '../../contracts/redux/app_state.dart';
import '../../contracts/required_item.dart';
import '../setting/selector.dart';
import 'actions.dart';
import 'selector.dart';

class CartViewModel {
  List<RequiredItem> items;
  final bool isPatron;
  //
  Function(String appId, int quantity) addToCart;
  Function(String appId, int newQuantity) editCartItem;
  Function(String appId) removeFromCart;

  CartViewModel({
    required this.items,
    required this.isPatron,
    //
    required this.addToCart,
    required this.editCartItem,
    required this.removeFromCart,
  });

  static CartViewModel fromStore(Store<AppState> store) => CartViewModel(
        items: getCartItems(store.state),
        isPatron: getIsPatron(store.state),
        //
        addToCart: (String appId, int quantity) => store.dispatch(
          AddToCartAction(
            appId: appId,
            quantity: quantity,
          ),
        ),
        editCartItem: (String appId, int quantity) => store.dispatch(
          EditToCartAction(
            appId: appId,
            quantity: quantity,
          ),
        ),
        removeFromCart: (String appId) => store.dispatch(
          RemoveFromCartAction(appId),
        ),
      );
}
