import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

String getLegalNoticeText() => getTranslations()
    .fromKey(LocaleKey.legalNotice)
    .replaceAll('{0}', 'James Bendon')
    .replaceAll('{1}', 'Dinkum');
