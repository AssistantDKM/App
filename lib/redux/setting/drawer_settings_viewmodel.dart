import 'package:redux/redux.dart';

import '../../contracts/redux/app_state.dart';
import 'selector.dart';

class DrawerSettingsViewModel {
  final bool isPatron;

  DrawerSettingsViewModel({
    required this.isPatron,
  });

  static DrawerSettingsViewModel fromStore(Store<AppState> store) =>
      DrawerSettingsViewModel(
        isPatron: getIsPatron(store.state),
      );
}
