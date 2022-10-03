import 'package:redux/redux.dart';

import '../../contracts/redux/app_state.dart';
import 'actions.dart';
import 'selector.dart';

class FavouriteViewModel {
  List<String> favourites;

  Function(String appId) addFavourite;
  Function(String appId) removeFavourite;

  FavouriteViewModel({
    required this.favourites,
    required this.addFavourite,
    required this.removeFavourite,
  });

  static FavouriteViewModel fromStore(Store<AppState> store) =>
      FavouriteViewModel(
        favourites: getFavourites(store.state),
        addFavourite: (String appId) =>
            store.dispatch(AddFavouriteAction(appId)),
        removeFavourite: (String appId) =>
            store.dispatch(RemoveFavouriteAction(appId)),
      );
}
