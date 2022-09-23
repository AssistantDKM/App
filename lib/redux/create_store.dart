import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:redux/redux.dart';

import '../constants/app_local_storage_key.dart';
import '../contracts/redux/app_state.dart';
import 'app_reducer.dart';
import 'middleware/local_storage_middleware.dart';

Future<Store<AppState>> createStore() async {
  List<void Function(Store<AppState>, dynamic, void Function(dynamic))>
      middlewares = [LocalStorageMiddleware()];
  Map<String, dynamic> stateMap = <String, dynamic>{};
  ResultWithValue<Map<String, dynamic>> stateMapResult =
      await getStorageRepo().loadFromStorage(LocalStorageKey.appState);
  if (stateMapResult.isSuccess) {
    stateMap = stateMapResult.value;
  } else {
    getLog().e('createStore');
  }

  AppState initialState = AppState.initial();
  try {
    initialState = AppState.fromJson(stateMap);
  } catch (exception) {
    getLog().e('Failed to load initial state');
    initialState = AppState.initial();
  }

  return Store(
    appReducer,
    initialState: initialState,
    middleware: middlewares,
  );
}
