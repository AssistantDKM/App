import 'package:redux/redux.dart';

import '../../contracts/redux/app_state.dart';
import '../setting/selector.dart';

class RawMaterialsViewModel {
  final bool isPatron;

  RawMaterialsViewModel({
    required this.isPatron,
  });

  static RawMaterialsViewModel fromStore(Store<AppState> store) =>
      RawMaterialsViewModel(
        isPatron: getIsPatron(store.state),
      );
}
