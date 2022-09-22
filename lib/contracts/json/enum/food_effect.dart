import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class FoodEffect {
  final String type;
  final int value;

  FoodEffect({
    required this.type,
    required this.value,
  });

  factory FoodEffect.fromJson(String str) =>
      FoodEffect.fromMap(json.decode(str));

  factory FoodEffect.fromMap(Map<String, dynamic> json) => FoodEffect(
        type: readStringSafe(json, 'type'),
        value: readIntSafe(json, 'value'),
      );
}
