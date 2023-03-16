import 'package:redux/redux.dart';

import '../../contracts/redux/app_state.dart';
import '../cart/actions.dart';
import '../museum/selector.dart';
import '../setting/selector.dart';

class InventoryItemViewModel {
  final bool isPatron;
  final List<String> donations;
  Function(String appId, int quantity) addToCart;

  InventoryItemViewModel({
    required this.isPatron,
    required this.donations,
    //
    required this.addToCart,
  });

  static InventoryItemViewModel fromStore(Store<AppState> store) =>
      InventoryItemViewModel(
        isPatron: getIsPatron(store.state),
        donations: getDonations(store.state),
        //
        addToCart: (String appId, int quantity) => store.dispatch(
          AddToCartAction(
            appId: appId,
            quantity: quantity,
          ),
        ),
      );
}
