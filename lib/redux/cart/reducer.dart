import 'package:redux/redux.dart';

import '../../contracts/redux/cart_item_state.dart';
import '../../contracts/redux/cart_state.dart';
import 'actions.dart';

final cartReducer = combineReducers<CartState>([
  TypedReducer<CartState, AddToCartAction>(_addToCart),
  TypedReducer<CartState, RemoveFromCartAction>(_removeFromCart),
]);

CartState _addToCart(CartState state, AddToCartAction action) {
  List<CartItem> newList = state.items;
  newList.add(CartItem(
    appId: action.appId,
    quantity: action.quantity,
  ));
  return state.copyWith(newItems: newList);
}

CartState _removeFromCart(CartState state, RemoveFromCartAction action) {
  List<CartItem> items = state.items;
  List<CartItem> newList = List.empty(growable: true);
  for (CartItem fav in items) {
    print(fav.appId);
    print(action.appId);
    print('---');
    if (fav.appId == action.appId) continue;
    newList.add(fav);
  }
  return state.copyWith(newItems: newList);
}
