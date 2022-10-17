import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../constants/app_fonts.dart';

class SettingState {
  final String selectedLanguage;
  final String fontFamily;
  final bool isPatron;
  final bool hasAcceptedIntro;

  const SettingState({
    required this.selectedLanguage,
    required this.fontFamily,
    required this.isPatron,
    required this.hasAcceptedIntro,
  });

  factory SettingState.initial() {
    return const SettingState(
      selectedLanguage: 'en',
      fontFamily: defaultFontFamily,
      isPatron: false,
      hasAcceptedIntro: false,
    );
  }

  SettingState copyWith({
    String? selectedLanguage,
    String? fontFamily,
    bool? isPatron,
    bool? hasAcceptedIntro,
  }) {
    return SettingState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      fontFamily: fontFamily ?? this.fontFamily,
      isPatron: isPatron ?? this.isPatron,
      hasAcceptedIntro: hasAcceptedIntro ?? this.hasAcceptedIntro,
    );
  }

  factory SettingState.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_null_comparison
    if (json == null) return SettingState.initial();
    try {
      return SettingState(
        selectedLanguage: readStringSafe(json, 'selectedLanguage'),
        fontFamily: readStringSafe(json, 'fontFamily'),
        isPatron: readBoolSafe(json, 'isPatron'),
        hasAcceptedIntro: readBoolSafe(json, 'hasAcceptedIntro'),
      );
    } catch (exception) {
      return SettingState.initial();
    }
  }

  Map<String, dynamic> toJson() => {
        'selectedLanguage': selectedLanguage,
        'fontFamily': fontFamily,
        'isPatron': isPatron,
        'hasAcceptedIntro': hasAcceptedIntro,
      };
}
