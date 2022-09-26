import 'package:flutter/material.dart';

import 'app.dart';
import 'env.dart';
import 'env/assistant_apps_settings.dart';
import 'env/environment_settings.dart';

Future main() async {
  EnvironmentSettings env = EnvironmentSettings(
    isProduction: true,

    // AssistantApps
    assistantAppsApiUrl: 'https://api.assistantapps.com',
    assistantAppsAppGuid: assistantAppsAppGuid,
    currentWhatIsNewGuid: currentWhatIsNewGuid,

    wiredashProjectId: wiredashProjectId,
    wiredashSecret: wiredashSecret,

    // from env.dart
    patreonOAuthClientId: patreonOAuthClientId,
  );

  WidgetsFlutterBinding.ensureInitialized();
  runApp(DinkumApp(env));
}
