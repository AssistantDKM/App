import '../../contracts/json/inventory_item.dart';
import 'base_game_item_repository.dart';

class InventoryRepository extends BaseGameItemRepository<InventoryItem> {
  InventoryRepository(appJson)
      : super(
          appJson: appJson,
          repoName: 'InventoryRepository',
          fromMap: InventoryItem.fromMap,
          compare: (a, b) => a.name.compareTo(b.name),
          findItemById: (r, appId) => r.appId == appId,
        );
}
