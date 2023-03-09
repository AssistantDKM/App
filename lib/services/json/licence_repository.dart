import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../contracts/json/licence_item.dart';
import 'base_game_item_repository.dart';

class LicenceRepository extends BaseGameItemRepository<LicenceItem> {
  LicenceRepository()
      : super(
          appJson: LocaleKey.licenceJson,
          repoName: 'LicenceRepository',
          fromMap: LicenceItem.fromMap,
          compare: (a, b) => a.name.compareTo(b.name),
          findItemById: (r, appId) => r.appId == appId,
        );
}
