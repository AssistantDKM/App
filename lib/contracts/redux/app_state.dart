import 'cart_state.dart';
import 'favourite_state.dart';
import 'museum_state.dart';
import 'setting_state.dart';

class AppState {
  final SettingState settingState;
  final FavouriteState favouriteState;
  final MuseumState museumState;
  final CartState cartState;

  const AppState({
    required this.settingState,
    required this.favouriteState,
    required this.museumState,
    required this.cartState,
  });

  factory AppState.fromJson(Map<String, dynamic> json) {
    SettingState settingState = SettingState.fromJson(json['settingState']);
    FavouriteState favouriteState =
        FavouriteState.fromJson(json['favouriteState']);
    MuseumState museumState = MuseumState.fromJson(json['museumState']);
    CartState cartState = CartState.fromJson(json['cartState']);

    return AppState(
      settingState: settingState,
      favouriteState: favouriteState,
      museumState: museumState,
      cartState: cartState,
    );
  }

  factory AppState.initial() {
    return AppState(
      settingState: SettingState.initial(),
      favouriteState: FavouriteState.initial(),
      museumState: MuseumState.initial(),
      cartState: CartState.initial(),
    );
  }

  AppState copyWith({
    SettingState? settingState,
    FavouriteState? favouriteState,
    MuseumState? museumState,
    CartState? cartState,
  }) {
    return AppState(
      settingState: settingState ?? this.settingState,
      favouriteState: favouriteState ?? this.favouriteState,
      museumState: museumState ?? this.museumState,
      cartState: cartState ?? this.cartState,
    );
  }

  Map<String, dynamic> toJson() => {
        'settingState': settingState.toJson(),
        'favouriteState': favouriteState.toJson(),
        'museumState': museumState.toJson(),
        'cartState': cartState.toJson(),
      };
}
