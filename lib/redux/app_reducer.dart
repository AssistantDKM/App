import '../contracts/redux/app_state.dart';
import 'cart/reducer.dart';
import 'favourite/reducer.dart';
import 'museum/reducer.dart';
import 'setting/reducer.dart';

AppState appReducer(AppState state, dynamic action) => AppState(
      settingState: settingReducer(state.settingState, action),
      favouriteState: favouriteReducer(state.favouriteState, action),
      museumState: museumReducer(state.museumState, action),
      cartState: cartReducer(state.cartState, action),
    );
