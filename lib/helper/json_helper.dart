import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

List<String> readStringListSafe(Map<dynamic, dynamic>? json, String prop) {
  if (json == null) return List.empty(growable: true);
  try {
    if (json[prop] == null) return List.empty(growable: true);
    return readListSafe(json, prop, (x) => x.toString());
  } catch (ex) {
    return List.empty(growable: true);
  }
}
