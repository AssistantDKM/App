import 'favourite_state.dart';
import 'museum_state.dart';
import 'setting_state.dart';

class AppState {
  final SettingState settingState;
  final FavouriteState favouriteState;
  final MuseumState museumState;

  const AppState({
    required this.settingState,
    required this.favouriteState,
    required this.museumState,
  });

  factory AppState.fromJson(Map<String, dynamic> json) {
    SettingState settingState = SettingState.fromJson(json['settingState']);
    FavouriteState favouriteState =
        FavouriteState.fromJson(json['favouriteState']);
    MuseumState museumState = MuseumState.fromJson(json['museumState']);

    return AppState(
      settingState: settingState,
      favouriteState: favouriteState,
      museumState: museumState,
    );
  }

  factory AppState.initial() {
    return AppState(
      settingState: SettingState.initial(),
      favouriteState: FavouriteState.initial(),
      museumState: MuseumState.initial(),
    );
  }

  AppState copyWith({
    SettingState? settingState,
    FavouriteState? favouriteState,
    MuseumState? museumState,
  }) {
    return AppState(
      settingState: settingState ?? this.settingState,
      favouriteState: favouriteState ?? this.favouriteState,
      museumState: museumState ?? this.museumState,
    );
  }

  Map<String, dynamic> toJson() => {
        'settingState': settingState.toJson(),
        'favouriteState': favouriteState.toJson(),
        'museumState': favouriteState.toJson(),
      };
}
