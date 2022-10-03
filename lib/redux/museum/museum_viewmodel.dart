import 'package:redux/redux.dart';

import '../../contracts/redux/app_state.dart';
import 'actions.dart';
import 'selector.dart';

class MuseumViewModel {
  List<String> donation;

  Function(String appId) addToMuseum;
  Function(String appId) removeFromMuseum;

  MuseumViewModel({
    required this.donation,
    required this.addToMuseum,
    required this.removeFromMuseum,
  });

  static MuseumViewModel fromStore(Store<AppState> store) => MuseumViewModel(
        donation: getDonations(store.state),
        addToMuseum: (String appId) => store.dispatch(AddToMuseumAction(appId)),
        removeFromMuseum: (String appId) =>
            store.dispatch(RemoveFromMuseumAction(appId)),
      );
}
