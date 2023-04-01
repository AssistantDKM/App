import '../../enum_base.dart';

enum UsageKey {
  hasUsedToCreate,
  requiresLicence,
  hasItemChange,
  hasFromItemChange,
  changesItems,
  isInGameUpdate,
}

final usageKeyTypeValues = EnumValues({
  'HasUsedToCreate': UsageKey.hasUsedToCreate,
  'RequiresLicence': UsageKey.requiresLicence,
  'HasItemChange': UsageKey.hasItemChange,
  'HasFromItemChange': UsageKey.hasFromItemChange,
  'ChangesItems': UsageKey.changesItems,
  'IsInGameUpdate': UsageKey.isInGameUpdate,
});
