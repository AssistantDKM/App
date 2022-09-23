import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'env.dart';
import 'env/assistant_apps_settings.dart';
import 'env/environment_settings.dart';

Future main() async {
  EnvironmentSettings env = EnvironmentSettings(
    isProduction: false,

    // AssistantApps
    assistantAppsApiUrl: assistantAppsApiUrl,
    assistantAppsAppGuid: assistantAppsAppGuid,
    currentWhatIsNewGuid: currentWhatIsNewGuid,

    wiredashProjectId: wiredashProjectId,
    wiredashSecret: wiredashSecret,

    // from env.dart
    patreonOAuthClientId: patreonOAuthClientId,
  );

  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DinkumApp(env));

  if (isWindows) {
    doWhenWindowReady(() {
      const initialSize = Size(500, 800);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}
