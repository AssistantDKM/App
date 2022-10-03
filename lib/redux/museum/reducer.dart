import 'package:redux/redux.dart';

import '../../contracts/redux/museum_state.dart';
import 'actions.dart';

final museumReducer = combineReducers<MuseumState>([
  TypedReducer<MuseumState, AddToMuseumAction>(_addToMuseum),
  TypedReducer<MuseumState, RemoveFromMuseumAction>(_removeFromMuseum),
]);

MuseumState _addToMuseum(MuseumState state, AddToMuseumAction action) {
  List<String> newList = state.donations;
  newList.add(action.appId);
  return state.copyWith(donations: newList);
}

MuseumState _removeFromMuseum(
    MuseumState state, RemoveFromMuseumAction action) {
  List<String> items = state.donations;
  List<String> newList = List.empty(growable: true);
  for (String fav in items) {
    if (fav == action.appId) continue;
    newList.add(fav);
  }
  return state.copyWith(donations: newList);
}
