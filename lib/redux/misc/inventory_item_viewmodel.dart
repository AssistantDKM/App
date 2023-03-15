import 'package:redux/redux.dart';

import '../../contracts/redux/app_state.dart';
import '../museum/selector.dart';
import '../setting/selector.dart';

class InventoryItemViewModel {
  final bool isPatron;
  final List<String> donations;

  InventoryItemViewModel({
    required this.isPatron,
    required this.donations,
  });

  static InventoryItemViewModel fromStore(Store<AppState> store) =>
      InventoryItemViewModel(
        isPatron: getIsPatron(store.state),
        donations: getDonations(store.state),
      );
}
