import 'package:assistant_dinkum_app/constants/app_json.dart';

import '../../contracts/json/furniture_item.dart';
import 'base_game_item_repository.dart';

class FurnitureRepository extends BaseGameItemRepository<FurnitureItem> {
  FurnitureRepository()
      : super(
          appJson: AppJson.furniture,
          repoName: 'FurnitureRepository',
          fromMap: FurnitureItem.fromMap,
          compare: (a, b) => a.name.compareTo(b.name),
          findItemById: (r, itemIdInt) => r.id == int.parse(itemIdInt),
        );
}
