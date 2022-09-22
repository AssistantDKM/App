import 'package:redux/redux.dart';

import '../../../contracts/redux/setting_state.dart';
import 'actions.dart';

final settingReducer = combineReducers<SettingState>([
  TypedReducer<SettingState, ChangeLanguageAction>(_editLanguage),
  TypedReducer<SettingState, SetFontFamily>(_setFontFamily),
  // TypedReducer<SettingState, ToggleIntroComplete>(_toggleIntroComplete),
  TypedReducer<SettingState, SetIsPatron>(_setIsPatron),
]);

SettingState _editLanguage(SettingState state, ChangeLanguageAction action) {
  return state.copyWith(selectedLanguage: action.languageCode);
}

SettingState _setFontFamily(SettingState state, SetFontFamily action) =>
    state.copyWith(
      fontFamily: action.fontFamily,
    );

// SettingState _toggleIntroComplete(SettingState state, _) =>
//     state.copyWith(introComplete: !state.introComplete);
SettingState _setIsPatron(SettingState state, SetIsPatron action) =>
    state.copyWith(isPatron: action.newIsPatron);
