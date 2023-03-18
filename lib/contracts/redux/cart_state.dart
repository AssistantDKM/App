import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../required_item.dart';

class CartState {
  final List<RequiredItem> items;

  const CartState({
    required this.items,
  });

  factory CartState.initial() {
    return CartState(items: List.empty(growable: true));
  }

  CartState copyWith({
    List<RequiredItem>? newItems,
  }) {
    return CartState(items: newItems ?? items);
  }

  factory CartState.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_null_comparison
    if (json == null) return CartState.initial();
    try {
      return CartState(
        items: readListSafe<RequiredItem>(
          json,
          'items',
          (p) => RequiredItem.fromJson(p),
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
