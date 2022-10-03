import 'package:redux/redux.dart';

import '../../contracts/redux/app_state.dart';
import '../favourite/actions.dart';
import '../favourite/selector.dart';

class InventoryItemViewModel {
  List<String> favourites;

  Function(String appId) addFavourite;
  Function(String appId) removeFavourite;

  InventoryItemViewModel({
    required this.favourites,
    required this.addFavourite,
    required this.removeFavourite,
  });

  static InventoryItemViewModel fromStore(Store<AppState> store) =>
      InventoryItemViewModel(
        favourites: getFavourites(store.state),
        addFavourite: (String appId) =>
            store.dispatch(AddFavouriteAction(appId)),
        removeFavourite: (String appId) =>
            store.dispatch(RemoveFavouriteAction(appId)),
      );
}
