import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class CartItem {
  String appId;
  int quantity;

  CartItem({
    required this.appId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic>? json) => CartItem(
        appId: readStringSafe(json, 'appId'),
        quantity: readIntSafe(json, 'quantity'),
      );

  Map<String, dynamic> toJson() => {
        'appId': appId,
        'quantity': quantity,
      };
}
