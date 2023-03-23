import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

String getLegalNoticeText() => getTranslations()
    .fromKey(LocaleKey.legalNotice)
    .replaceAll('{0}', 'James Bendon')
    .replaceAll('{1}', 'Dinkum');

String addSpaceBeforeCapital(String orig) {
  List<String> result = List.empty(growable: true);
  List<String> strArr = orig.split('');

  for (int strArrIndex = 0; strArrIndex < strArr.length; strArrIndex++) {
    String strItem = strArr[strArrIndex];
    if (strArrIndex != 0 && strItem.contains(RegExp(r'[A-Z]'))) {
      String prevStrItem = strArr[strArrIndex - 1];
      if (prevStrItem != ' ') {
        result.add(' ');
      }
    }
    result.add(strItem);
  }
  return result.join('');
}
