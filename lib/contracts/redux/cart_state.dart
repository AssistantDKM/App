import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import 'cart_item_state.dart';

class CartState {
  final List<CartItem> items;

  const CartState({
    required this.items,
  });

  factory CartState.initial() {
    return CartState(items: List.empty(growable: true));
  }

  CartState copyWith({
    List<CartItem>? newItems,
  }) {
    return CartState(items: newItems ?? items);
  }

  factory CartState.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_null_comparison
    if (json == null) return CartState.initial();
    try {
      return CartState(
        items: readListSafe<CartItem>(
          json,
          'items',
          (p) => CartItem.fromJson(p),
        ).toList(),
      );
    } catch (exception) {
      return CartState.initial();
    }
  }

  Map<String, dynamic> toJson() => {
        'items': items,
      };
}
