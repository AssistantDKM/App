import 'package:redux/redux.dart';

import '../../contracts/redux/favourite_state.dart';
import 'actions.dart';

final favouriteReducer = combineReducers<FavouriteState>([
  TypedReducer<FavouriteState, AddFavouriteAction>(_addFavourite),
  TypedReducer<FavouriteState, RemoveFavouriteAction>(_removeFavourite),
]);

FavouriteState _addFavourite(FavouriteState state, AddFavouriteAction action) {
  List<String> newList = state.favouriteItems;
  newList.add(action.appId);
  return state.copyWith(favouriteItems: newList);
}

FavouriteState _removeFavourite(
    FavouriteState state, RemoveFavouriteAction action) {
  List<String> items = state.favouriteItems;
  List<String> newList = List.empty(growable: true);
  for (String fav in items) {
    if (fav == action.appId) continue;
    newList.add(fav);
  }
  return state.copyWith(favouriteItems: newList);
}
