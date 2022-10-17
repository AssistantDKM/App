import 'package:redux/redux.dart';

import '../../../contracts/redux/app_state.dart';
import 'actions.dart';
import 'selector.dart';

class SettingViewModel {
  final String selectedLanguage;
  final String fontFamily;
  final bool isPatron;
  final bool hasAcceptedIntro;

  final Function(String fontFamily) setSelectedLanguage;
  final Function(String fontFamily) setFontFamily;
  final Function(bool) setIsPatron;

  SettingViewModel({
    required this.selectedLanguage,
    required this.fontFamily,
    required this.isPatron,
    required this.hasAcceptedIntro,
    //
    required this.setSelectedLanguage,
    required this.setFontFamily,
    required this.setIsPatron,
  });

  static SettingViewModel fromStore(Store<AppState> store) => SettingViewModel(
        selectedLanguage: getSelectedLanguage(store.state),
        fontFamily: getFontFamily(store.state),
        isPatron: getIsPatron(store.state),
        hasAcceptedIntro: getHasAcceptedIntro(store.state),
        //
        setSelectedLanguage: (String selectedLang) =>
            store.dispatch(ChangeLanguageAction(selectedLang)),
        setFontFamily: (String fontFamily) =>
            store.dispatch(SetFontFamily(fontFamily)),
        setIsPatron: (bool isPatron) => store.dispatch(SetIsPatron(isPatron)),
      );
}
