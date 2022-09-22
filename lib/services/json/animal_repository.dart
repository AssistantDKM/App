import '../../contracts/json/animal_item.dart';
import 'base_game_item_repository.dart';

class AnimalRepository extends BaseGameItemRepository<AnimalItem> {
  AnimalRepository(appJson)
      : super(
          appJson: appJson,
          repoName: 'AnimalRepository',
          fromMap: AnimalItem.fromMap,
          compare: (a, b) => a.name.compareTo(b.name),
          findItemById: (r, itemIdInt) => r.id == int.parse(itemIdInt),
        );
}
