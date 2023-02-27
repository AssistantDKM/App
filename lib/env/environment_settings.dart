import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import 'app_version_num.dart';

class EnvironmentSettings {
  bool isProduction;
  String assistantAppsApiUrl;
  String assistantAppsAppGuid;
  String currentWhatIsNewGuid;
  String patreonOAuthClientId;

  EnvironmentSettings({
    required this.isProduction,
    required this.assistantAppsApiUrl,
    required this.assistantAppsAppGuid,
    required this.currentWhatIsNewGuid,
    required this.patreonOAuthClientId,
  });

  AssistantAppsEnvironmentSettings toAssistantApps() =>
      AssistantAppsEnvironmentSettings(
        assistantAppsApiUrl: assistantAppsApiUrl,
        assistantAppsAppGuid: assistantAppsAppGuid,
        currentWhatIsNewGuid: currentWhatIsNewGuid,
        isProduction: isProduction,
        patreonOAuthClientId: patreonOAuthClientId,

        // Required for Android (because of how I set it up) and Windows
        appVersionBuildNumberOverride: appsBuildNum,
        appVersionBuildNameOverride: appsBuildName,
      );
}
