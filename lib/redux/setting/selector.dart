import '../../../contracts/redux/app_state.dart';

String getSelectedLanguage(AppState state) =>
    state.settingState.selectedLanguage;

String getFontFamily(AppState state) => state.settingState.fontFamily;

bool getIsPatron(AppState state) => state.settingState.isPatron;
