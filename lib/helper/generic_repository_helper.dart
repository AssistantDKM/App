import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../constants/app_json.dart';
import '../integration/dependency_injection.dart';
import '../services/json/inventory_repository.dart';

InventoryRepository getGenericRepoFromAppId(String appId) {
  List<String> comboId = appId.split('_');

  if (appJsonFromAppIdMap.containsKey(comboId.first)) {
    return getInventoryRepo(appJsonFromAppIdMap[comboId.first]!);
  }

  getLog().e('Could not get repository for ${comboId.first}');
  return getInventoryRepo(appId);
}
