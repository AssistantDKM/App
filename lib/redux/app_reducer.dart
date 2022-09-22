import '../contracts/redux/app_state.dart';
import 'setting/reducer.dart';

AppState appReducer(AppState state, dynamic action) => AppState(
      settingState: settingReducer(state.settingState, action),
    );
