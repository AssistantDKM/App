import '../../constants/app_json.dart';
import '../../contracts/json/licence_item.dart';
import 'base_game_item_repository.dart';

class LicenceRepository extends BaseGameItemRepository<LicenceItem> {
  LicenceRepository()
      : super(
          appJson: AppJson.licences,
          repoName: 'LicenceRepository',
          fromMap: LicenceItem.fromMap,
          compare: (a, b) => a.name.compareTo(b.name),
          findItemById: (r, itemIdInt) => r.id == int.parse(itemIdInt),
        );
}
