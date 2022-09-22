import '../../contracts/json/food_item.dart';
import 'base_game_item_repository.dart';

class FoodRepository extends BaseGameItemRepository<FoodItem> {
  FoodRepository(appJson)
      : super(
          appJson: appJson,
          repoName: 'FoodRepository',
          fromMap: FoodItem.fromMap,
          compare: (a, b) => a.name.compareTo(b.name),
          findItemById: (r, itemIdInt) => r.id == int.parse(itemIdInt),
        );
}
