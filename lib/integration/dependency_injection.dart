import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:get_it/get_it.dart';

import '../env/environment_settings.dart';
import '../services/base/basewidget_service.dart';
import '../services/base/language_service.dart';
import '../services/base/loadingwidget_service.dart';
import '../services/base/path_service.dart';
import '../services/base/theme_service.dart';
import '../services/json/animal_repository.dart';
import '../services/json/crafting_repository.dart';
import '../services/json/food_repository.dart';

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
    // dialog: DialogService(),
    loading: LoadingWidgetService(),
    language: LanguageService(),
    // snackbar: SnackbarService(),
  );

  // getIt.registerSingleton(BugRepository());

  getIt.registerFactoryParam<AnimalRepository, String, String>(
    (String key, String unused) => AnimalRepository(key),
  );

  getIt.registerFactoryParam<FoodRepository, String, String>(
    (String key, String unused) => FoodRepository(key),
  );

  getIt.registerFactoryParam<CraftingRepository, String, String>(
    (String key, String unused) => CraftingRepository(key),
  );
}

EnvironmentSettings getEnv() => getIt<EnvironmentSettings>();

AnimalRepository getGenericRepo(String key) =>
    getIt<AnimalRepository>(param1: key, param2: 'di');

FoodRepository getFoodRepo(String key) =>
    getIt<FoodRepository>(param1: key, param2: 'di');

CraftingRepository getCraftingRepo(String key) =>
    getIt<CraftingRepository>(param1: key, param2: 'di');
