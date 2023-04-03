import 'package:assistant_dinkum_app/integration/dependency_injection.dart';
import 'package:flutter/material.dart';

import '../../contracts/json/enum/usage_key.dart';

class LookupRepository {
  Map<String, List<UsageKey>> _internalLookup = <String, List<UsageKey>>{};

  void loadLookups(BuildContext ctx) {
    getDataRepo().loadLookupJson(ctx).then((value) => _internalLookup = value);
  }

  List<UsageKey> getItemUsages(String appId) {
    if (_internalLookup.containsKey(appId) == false) return List.empty();
    List<UsageKey>? usageKeys = _internalLookup[appId];
    return usageKeys ?? List.empty();
  }

  bool itemHasUsage(String appId, UsageKey usageKey) {
    List<UsageKey> usageKeys = getItemUsages(appId);
    return usageKeys.contains(usageKey);
  }

  bool itemHasAnyUsage(String appId, List<UsageKey> usageKeys) =>
      usageKeys.any((usageKey) => itemHasUsage(appId, usageKey));
}
