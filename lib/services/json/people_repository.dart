import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../contracts/json/people_item.dart';
import 'base_game_item_repository.dart';

class PeopleRepository extends BaseGameItemRepository<PeopleItem> {
  PeopleRepository()
      : super(
          appJson: LocaleKey.peopleJson,
          repoName: 'PeopleRepository',
          fromMap: PeopleItem.fromMap,
          compare: (a, b) => a.name.compareTo(b.name),
          findItemById: (r, appId) => r.appId == appId,
        );
}
