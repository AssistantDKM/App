import '../base/persistToStorage.dart';

class ChangeLanguageAction extends PersistToStorage {
  final String languageCode;
  ChangeLanguageAction(this.languageCode);
}

class SetFontFamily extends PersistToStorage {
  final String fontFamily;
  SetFontFamily(this.fontFamily);
}

class ToggleIntroComplete extends PersistToStorage {}

class SetIsPatron extends PersistToStorage {
  final bool newIsPatron;
  SetIsPatron(this.newIsPatron);
}
