import '../../contracts/redux/app_state.dart';

List<String> getFavourites(AppState state) =>
    state.favouriteState.favouriteItems;
