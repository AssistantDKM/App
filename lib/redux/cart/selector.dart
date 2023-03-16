import '../../contracts/redux/app_state.dart';
import '../../contracts/redux/cart_item_state.dart';

List<CartItem> getCartItems(AppState state) => state.cartState.items;
