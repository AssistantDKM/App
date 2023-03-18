import 'package:redux/redux.dart';

import '../../contracts/redux/cart_state.dart';
import '../../contracts/required_item.dart';
import 'actions.dart';

final cartReducer = combineReducers<CartState>([
  TypedReducer<CartState, AddToCartAction>(_addToCart),
  TypedReducer<CartState, EditToCartAction>(_editCartItem),
  TypedReducer<CartState, RemoveFromCartAction>(_removeFromCart),
]);

CartState _addToCart(CartState state, AddToCartAction action) {
  bool addedNewItem = false;
  List<RequiredItem> newItems = List.empty(growable: true);
  for (int craftingIndex = 0;
      craftingIndex < state.items.length;
      craftingIndex++) {
    RequiredItem temp = state.items[craftingIndex];
    if (state.items[craftingIndex].appId == action.appId) {
      addedNewItem = true;
      temp.quantity = temp.quantity + action.quantity;
    }
    newItems.add(temp);
  }
  if (!addedNewItem) {
    newItems.add(
      RequiredItem(
        appId: action.appId,
        quantity: action.quantity,
      ),
    );
  }
  return state.copyWith(
    newItems: newItems
        .where((newItem) => newItem.appId.isNotEmpty) //
        .toList(),
  );
}

CartState _editCartItem(CartState state, EditToCartAction action) {
  List<RequiredItem> newItems = List.empty(growable: true);
  for (var craftingIndex = 0;
      craftingIndex < state.items.length;
      craftingIndex++) {
    var temp = state.items[craftingIndex];
    if (state.items[craftingIndex].appId == action.appId) {
      temp.quantity = action.quantity;
    }
    newItems.add(temp);
  }
  return state.copyWith(
    newItems: newItems
        .where((newItem) => newItem.appId.isNotEmpty) //
        .toList(),
  );
}

CartState _removeFromCart(CartState state, RemoveFromCartAction action) {
  List<RequiredItem> items = state.items;
  List<RequiredItem> newList = List.empty(growable: true);
  for (RequiredItem fav in items) {
    if (fav.appId == action.appId) continue;
    newList.add(fav);
  }
  return state.copyWith(
    newItems: newList
        .where((newItem) => newItem.appId.isNotEmpty) //
        .toList(),
  );
}
