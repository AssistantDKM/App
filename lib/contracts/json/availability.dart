import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import 'enum/season.dart';
import 'enum/time.dart';

class Availability {
  final List<Time> times;
  final List<Season> seasons;

  Availability({
    required this.times,
    required this.seasons,
  });

  factory Availability.fromJson(String str) =>
      Availability.fromMap(json.decode(str));

  factory Availability.fromMap(Map<String, dynamic> json) => Availability(
        times: readListSafe(
          json,
          'time',
          (x) => timeValues.map[x.toString()]!,
        ),
        seasons: readListSafe(
          json,
          'seasons',
          (x) => seasonValues.map[x.toString()]!,
        ),
      );
}
