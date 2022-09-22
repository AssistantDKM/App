import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class RequiredItem {
  final String name;
  final int amount;
  final String imageUrl;

  RequiredItem({
    required this.name,
    required this.amount,
    required this.imageUrl,
  });

  factory RequiredItem.fromJson(String str) =>
      RequiredItem.fromMap(json.decode(str));

  factory RequiredItem.fromMap(Map<String, dynamic> json) => RequiredItem(
        name: readStringSafe(json, 'name'),
        amount: readIntSafe(json, 'amount'),
        imageUrl: readStringSafe(json, 'image_url'),
      );
}
