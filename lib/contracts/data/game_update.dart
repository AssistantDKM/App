// To parse this JSON data, do
//
//     final gameUpdate = gameUpdateFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class GameUpdate {
  final String guid;
  final String title;
  final String icon;
  final DateTime releaseDate;
  final String postUrl;
  final List<String> appIds;

  GameUpdate({
    required this.guid,
    required this.title,
    required this.icon,
    required this.releaseDate,
    required this.postUrl,
    required this.appIds,
  });

  factory GameUpdate.initial() => GameUpdate(
        guid: 'guid',
        title: 'title',
        icon: '',
        releaseDate: DateTime(2023),
        postUrl: '',
        appIds: [],
      );

  factory GameUpdate.fromJson(String str) =>
      GameUpdate.fromMap(json.decode(str));

  factory GameUpdate.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return GameUpdate.initial();
    }

    return GameUpdate(
      guid: readStringSafe(json, 'guid'),
      title: readStringSafe(json, 'title'),
      icon: readStringSafe(json, 'icon'),
      releaseDate: readDateSafe(json, 'releaseDate'),
      postUrl: readStringSafe(json, 'postUrl'),
      appIds: readListSafe(json, 'itemIds', (x) => x.toString()),
    );
  }
}
