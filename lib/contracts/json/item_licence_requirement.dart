import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class ItemLicenceRequirement {
  final String name;
  final int level;
  final String imageUrl;

  ItemLicenceRequirement({
    required this.name,
    required this.level,
    required this.imageUrl,
  });

  factory ItemLicenceRequirement.fromJson(String str) =>
      ItemLicenceRequirement.fromMap(json.decode(str));

  factory ItemLicenceRequirement.fromMap(Map<String, dynamic> json) =>
      ItemLicenceRequirement(
        name: readStringSafe(json, 'name'),
        level: readIntSafe(json, 'level'),
        imageUrl: readStringSafe(json, 'image_url'),
      );
}
