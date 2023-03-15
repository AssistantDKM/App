import 'package:redux/redux.dart';

import '../../contracts/redux/app_state.dart';
import 'actions.dart';

class MuseumViewModel {
  Function(String appId) addToMuseum;
  Function(String appId) removeFromMuseum;

  MuseumViewModel({
    required this.addToMuseum,
    required this.removeFromMuseum,
  });

  static MuseumViewModel fromStore(Store<AppState> store) => MuseumViewModel(
        addToMuseum: (String appId) => store.dispatch(AddToMuseumAction(appId)),
        removeFromMuseum: (String appId) =>
            store.dispatch(RemoveFromMuseumAction(appId)),
      );
}
