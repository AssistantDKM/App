import 'setting_state.dart';

class AppState {
  final SettingState settingState;

  const AppState({
    required this.settingState,
  });

  factory AppState.fromJson(Map<String, dynamic> json) {
    SettingState settingState = //
        SettingState.fromJson(json['settingState']);

    return AppState(
      settingState: settingState,
    );
  }

  factory AppState.initial() {
    return AppState(
      settingState: SettingState.initial(),
    );
  }

  AppState copyWith({
    SettingState? settingState,
  }) {
    return AppState(
      settingState: settingState ?? this.settingState,
    );
  }

  Map<String, dynamic> toJson() => {
        'settingState': settingState.toJson(),
      };
}
