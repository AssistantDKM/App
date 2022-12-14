import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:get_it/get_it.dart';

import '../env/environment_settings.dart';
import '../services/base/basewidget_service.dart';
import '../services/base/dialog_service.dart';
import '../services/base/language_service.dart';
import '../services/base/loadingwidget_service.dart';
import '../services/base/path_service.dart';
import '../services/base/theme_service.dart';
import '../services/json/inventory_repository.dart';
import '../services/json/licence_repository.dart';
import '../services/json/milestone_repository.dart';
import '../services/json/people_repository.dart';

final getIt = GetIt.instance;

void initDependencyInjection(EnvironmentSettings env) {
  getIt.registerSingleton<EnvironmentSettings>(env);

  // AssistantApps
  initAssistantAppsDependencyInjection(
    env.toAssistantApps(),
    // analytics: AnalyticsService(),
    theme: ThemeService(),
    // notification: NotificationService(),
    path: PathService(),
    baseWidget: BaseWidgetService(),
    dialog: DialogService(),
    loading: LoadingWidgetService(),
    language: LanguageService(),
    // snackbar: SnackbarService(),
  );

  getIt.registerSingleton(PeopleRepository());
  getIt.registerSingleton(LicenceRepository());
  getIt.registerSingleton(MilestoneRepository());

  getIt.registerFactoryParam<InventoryRepository, String, String>(
    (String key, String unused) => InventoryRepository(key),
  );
}

EnvironmentSettings getEnv() => getIt<EnvironmentSettings>();

PeopleRepository getPeopleRepo() => getIt<PeopleRepository>();
LicenceRepository getLicenceRepo() => getIt<LicenceRepository>();
MilestoneRepository getMilestoneRepo() => getIt<MilestoneRepository>();

InventoryRepository getInventoryRepo(String key) =>
    getIt<InventoryRepository>(param1: key, param2: 'di');
