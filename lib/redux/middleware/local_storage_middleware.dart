import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:redux/redux.dart';

import '../../constants/app_local_storage_key.dart';
import '../../contracts/redux/app_state.dart';
import '../base/persist_to_storage.dart';

class LocalStorageMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    if (action is PersistToStorage) {
      getLog().i('saving to SharedPref');
      saveStateToPrefs(store.state);
    }
  }

  void saveStateToPrefs(AppState state) async {
    String stateString = json.encode(state.toJson());
    getStorageRepo().saveToStorage(LocalStorageKey.appState, stateString);
  }
}
