// To parse this JSON data, do
//
//     final milestoneItem = milestoneItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class MilestoneLevel {
  final int count;
  final int permitPoints;

  MilestoneLevel({
    required this.count,
    required this.permitPoints,
  });

  factory MilestoneLevel.fromJson(String str) =>
      MilestoneLevel.fromMap(json.decode(str));

  factory MilestoneLevel.fromMap(Map<String, dynamic> json) => MilestoneLevel(
        count: readIntSafe(json, 'count'),
        permitPoints: readIntSafe(json, 'permit_points'),
      );
}
