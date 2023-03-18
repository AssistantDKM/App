// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);
// https://app.quicktype.io/

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class RequiredItem {
  String appId;
  int quantity;

  RequiredItem({
    required this.appId,
    this.quantity = 0,
  });

  @override
  String toString() {
    return "$appId x$quantity";
  }

  factory RequiredItem.fromRawJson(String str) =>
      RequiredItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequiredItem.fromJson(Map<String, dynamic>? json) => RequiredItem(
        appId: readStringSafe(json, 'AppId'),
        quantity: readIntSafe(json, 'Quantity'),
      );

  Map<String, dynamic> toJson() => {
        "AppId": appId,
        "Quantity": quantity,
      };
}
