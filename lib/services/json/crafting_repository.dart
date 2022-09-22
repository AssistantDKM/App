import '../../contracts/json/crafting_item.dart';
import 'base_game_item_repository.dart';

class CraftingRepository extends BaseGameItemRepository<CraftingItem> {
  CraftingRepository(appJson)
      : super(
          appJson: appJson,
          repoName: 'CraftingRepository',
          fromMap: CraftingItem.fromMap,
          compare: (a, b) => a.name.compareTo(b.name),
          findItemById: (r, itemIdInt) => r.id == int.parse(itemIdInt),
        );
}
