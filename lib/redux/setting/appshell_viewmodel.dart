import 'package:redux/redux.dart';

import '../../../contracts/redux/app_state.dart';
import 'actions.dart';
import 'selector.dart';

class AppShellViewModel {
  final String selectedLanguage;
  final bool isPatron;

  final Function(String fontFamily) setSelectedLanguage;
  final Function(bool) setIsPatron;

  AppShellViewModel({
    required this.selectedLanguage,
    required this.isPatron,
    //
    required this.setSelectedLanguage,
    required this.setIsPatron,
  });

  static AppShellViewModel fromStore(Store<AppState> store) =>
      AppShellViewModel(
        selectedLanguage: getSelectedLanguage(store.state),
        isPatron: getIsPatron(store.state),
        //
        setSelectedLanguage: (String selectedLang) =>
            store.dispatch(ChangeLanguageAction(selectedLang)),
        setIsPatron: (bool isPatron) => store.dispatch(SetIsPatron(isPatron)),
      );
}
