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

  factory GameUpdate.fromJson(String str) =>
      GameUpdate.fromMap(json.decode(str));

  factory GameUpdate.fromMap(Map<String, dynamic>? json) => GameUpdate(
        guid: readStringSafe(json, 'Guid'),
        title: readStringSafe(json, 'Title'),
        icon: readStringSafe(json, 'Icon'),
        releaseDate: readDateSafe(json, 'ReleaseDate'),
        postUrl: readStringSafe(json, 'PostUrl'),
        appIds: readListSafe(json, 'AppIds', (x) => x.toString()),
      );
}
