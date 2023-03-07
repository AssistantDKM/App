import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../contracts/json/milestone_item.dart';
import 'base_game_item_repository.dart';

class MilestoneRepository extends BaseGameItemRepository<MilestoneItem> {
  MilestoneRepository()
      : super(
          appJson: LocaleKey.milestoneJson,
          repoName: 'MilestoneRepository',
          fromMap: MilestoneItem.fromMap,
          compare: (a, b) => a.name.compareTo(b.name),
          findItemById: (r, itemIdInt) => r.id == int.parse(itemIdInt),
        );
}
