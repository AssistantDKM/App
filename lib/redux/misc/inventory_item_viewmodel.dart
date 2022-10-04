import 'package:redux/redux.dart';

import '../../contracts/redux/app_state.dart';
import '../setting/selector.dart';

class InventoryItemViewModel {
  final bool isPatron;

  InventoryItemViewModel({
    required this.isPatron,
  });

  static InventoryItemViewModel fromStore(Store<AppState> store) =>
      InventoryItemViewModel(
        isPatron: getIsPatron(store.state),
      );
}
