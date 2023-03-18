import '../../contracts/redux/app_state.dart';
import '../../contracts/required_item.dart';

List<RequiredItem> getCartItems(AppState state) => state.cartState.items;
