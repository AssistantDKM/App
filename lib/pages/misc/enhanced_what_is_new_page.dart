import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants/analytics_event.dart';
import '../../contracts/redux/app_state.dart';
import '../../redux/setting/what_is_new_settings_viewmodel.dart';

class EnhancedWhatIsNewPage extends StatelessWidget {
  const EnhancedWhatIsNewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WhatIsNewSettingsViewModel>(
      converter: (store) => WhatIsNewSettingsViewModel.fromStore(store),
      builder: (storeContext, viewModel) => getBody(storeContext, viewModel),
    );
  }

  Widget getBody(BuildContext context, WhatIsNewSettingsViewModel viewModel) {
    List<PlatformType> overriddenPlatList = getPlatforms()
        .map((plat) => (plat == PlatformType.windows)
                ? PlatformType.githubWindowsInstaller //
                : plat //
            )
        .toList();
    if (isLinux) {
      overriddenPlatList.add(PlatformType.githubWindowsInstaller);
    }

    return WhatIsNewPage(
      AnalyticsEvent.whatIsNewDetailPage,
      selectedLanguage: viewModel.selectedLanguage,
      overriddenPlatforms: overriddenPlatList,
    );
  }
}
